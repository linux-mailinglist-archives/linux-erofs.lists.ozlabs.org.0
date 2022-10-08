Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C385F8482
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Oct 2022 11:06:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mkzms23nCz3blY
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Oct 2022 20:06:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mkzmp2zYkz2y8J
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Oct 2022 20:06:02 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VRbkoWW_1665219956;
Received: from 30.221.130.66(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VRbkoWW_1665219956)
          by smtp.aliyun-inc.com;
          Sat, 08 Oct 2022 17:05:58 +0800
Message-ID: <206e172c-5ba0-1233-f46d-edb828df53ad@linux.alibaba.com>
Date: Sat, 8 Oct 2022 17:05:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 3/5] cachefiles: resend an open request if the read
 request's object is closed
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, dhowells@redhat.com, xiang@kernel.org
References: <20220818135204.49878-1-zhujia.zj@bytedance.com>
 <20220818135204.49878-4-zhujia.zj@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220818135204.49878-4-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 8/18/22 9:52 PM, Jia Zhu wrote:
> When an anonymous fd is closed by user daemon, if there is a new read
> request for this file comes up, the anonymous fd should be re-opened
> to handle that read request rather than fail it directly.
> 
> 1. Introduce reopening state for objects that are closed but have
>    inflight/subsequent read requests.
> 2. No longer flush READ requests but only CLOSE requests when anonymous
>    fd is closed.
> 3. Enqueue the reopen work to workqueue, thus user daemon could get rid
>    of daemon_read context and handle that request smoothly. Otherwise,
>    the user daemon will send a reopen request and wait for itself to
>    process the request.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> Reviewed-by: Xin Yin <yinxin.x@bytedance.com>
> ---
>  fs/cachefiles/internal.h |  3 ++
>  fs/cachefiles/ondemand.c | 79 +++++++++++++++++++++++++++-------------
>  2 files changed, 56 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index cdf4ec781933..66bbd4f1d22a 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -48,9 +48,11 @@ struct cachefiles_volume {
>  enum cachefiles_object_state {
>  	CACHEFILES_ONDEMAND_OBJSTATE_close, /* Anonymous fd closed by daemon or initial state */
>  	CACHEFILES_ONDEMAND_OBJSTATE_open, /* Anonymous fd associated with object is available */
> +	CACHEFILES_ONDEMAND_OBJSTATE_reopening, /* Object that was closed and is being reopened. */
>  };
>  
>  struct cachefiles_ondemand_info {
> +	struct work_struct		work;
>  	int				ondemand_id;
>  	enum cachefiles_object_state	state;
>  	struct cachefiles_object	*object;
> @@ -341,6 +343,7 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
>  
>  CACHEFILES_OBJECT_STATE_FUNCS(open);
>  CACHEFILES_OBJECT_STATE_FUNCS(close);
> +CACHEFILES_OBJECT_STATE_FUNCS(reopening);
>  #else
>  #define CACHEFILES_ONDEMAND_OBJINFO(object)	NULL
>  
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index f51266554e4d..79ffb19380cd 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -18,14 +18,10 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
>  	info->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
>  	cachefiles_ondemand_set_object_close(object);
>  
> -	/*
> -	 * Flush all pending READ requests since their completion depends on
> -	 * anon_fd.
> -	 */
> -	xas_for_each(&xas, req, ULONG_MAX) {
> +	/* Only flush CACHEFILES_REQ_NEW marked req to avoid race with daemon_read */
> +	xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {

Could you please add a more detailed comment here, explaing why flushing
CLOSE requests when anony fd gets closed is needed, and why the original
xas_for_each() would race with daemon_read()? There are some refs at [1]
and [2].

[1]
https://hackmd.io/YNsTQqLcQYOZ4gAlFWrNcA#flush-CLOSE-requests-when-anon-fd-is-closed
[2]
https://hackmd.io/YNsTQqLcQYOZ4gAlFWrNcA#race-between-readingflush-requests

The sequence chart is welcome to be added into the comment to explain
the race, or the code will be difficult to understand since the subtlety
of the race.


>  		if (req->msg.object_id == object_id &&
> -		    req->msg.opcode == CACHEFILES_OP_READ) {
> -			req->error = -EIO;
> +		    req->msg.opcode == CACHEFILES_OP_CLOSE) {
>  			complete(&req->done);
>  			xas_store(&xas, NULL);
>  		}
> @@ -175,6 +171,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  	trace_cachefiles_ondemand_copen(req->object, id, size);
>  
>  	cachefiles_ondemand_set_object_open(req->object);
> +	wake_up_all(&cache->daemon_pollwq);
>  
>  out:
>  	complete(&req->done);
> @@ -234,6 +231,14 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>  	return ret;
>  }
>  
> +static void ondemand_object_worker(struct work_struct *work)
> +{
> +	struct cachefiles_object *object =
> +		((struct cachefiles_ondemand_info *)work)->object;
> +
> +	cachefiles_ondemand_init_object(object);
> +}
> +
>  ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  					char __user *_buffer, size_t buflen)
>  {
> @@ -249,7 +254,27 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	 * requests from being processed repeatedly.
>  	 */
>  	xa_lock(&cache->reqs);
> -	req = xas_find_marked(&xas, UINT_MAX, CACHEFILES_REQ_NEW);
> +	xas_for_each_marked(&xas, req, UINT_MAX, CACHEFILES_REQ_NEW) {
> +		/*
> +		 * Reopen the closed object with associated read request.
> +		 * Skip read requests whose related object are reopening.
> +		 */
> +		if (req->msg.opcode == CACHEFILES_OP_READ) {
> +			ret = cmpxchg(&CACHEFILES_ONDEMAND_OBJINFO(req->object)->state,
> +						  CACHEFILES_ONDEMAND_OBJSTATE_close,
> +						  CACHEFILES_ONDEMAND_OBJSTATE_reopening);
> +			if (ret == CACHEFILES_ONDEMAND_OBJSTATE_close) {
> +				INIT_WORK(&CACHEFILES_ONDEMAND_OBJINFO(req->object)->work,
> +						ondemand_object_worker);

How about initializing @work in cachefiles_ondemand_init_obj_info(), so
that the work_struct of each object only needs to be initialized once?


> +				queue_work(fscache_wq,
> +					&CACHEFILES_ONDEMAND_OBJINFO(req->object)->work);
> +				continue;
> +			} else if (ret == CACHEFILES_ONDEMAND_OBJSTATE_reopening) {
> +				continue;
> +			}
> +		}
> +		break;
> +	}
>  	if (!req) {
>  		xa_unlock(&cache->reqs);
>  		return 0;
> @@ -267,14 +292,18 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	xa_unlock(&cache->reqs);
>  
>  	id = xas.xa_index;
> -	msg->msg_id = id;
>  
>  	if (msg->opcode == CACHEFILES_OP_OPEN) {
>  		ret = cachefiles_ondemand_get_fd(req);
> -		if (ret)
> +		if (ret) {
> +			cachefiles_ondemand_set_object_close(req->object);
>  			goto error;
> +		}
>  	}
>  
> +	msg->msg_id = id;
> +	msg->object_id = CACHEFILES_ONDEMAND_OBJINFO(req->object)->ondemand_id;
> +
>  	if (copy_to_user(_buffer, msg, n) != 0) {
>  		ret = -EFAULT;
>  		goto err_put_fd;
> @@ -307,19 +336,23 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>  					void *private)
>  {
>  	struct cachefiles_cache *cache = object->volume->cache;
> -	struct cachefiles_req *req;
> +	struct cachefiles_req *req = NULL;
>  	XA_STATE(xas, &cache->reqs, 0);
>  	int ret;
>  
>  	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>  		return 0;
>  
> -	if (test_bit(CACHEFILES_DEAD, &cache->flags))
> -		return -EIO;
> +	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
> +		ret = -EIO;
> +		goto out;
> +	}
>  
>  	req = kzalloc(sizeof(*req) + data_len, GFP_KERNEL);
> -	if (!req)
> -		return -ENOMEM;
> +	if (!req) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
>  
>  	req->object = object;
>  	init_completion(&req->done);
> @@ -357,7 +390,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>  		/* coupled with the barrier in cachefiles_flush_reqs() */
>  		smp_mb();
>  
> -		if (opcode != CACHEFILES_OP_OPEN &&
> +		if (opcode == CACHEFILES_OP_CLOSE &&
>  			!cachefiles_ondemand_object_is_open(object)) {
>  			WARN_ON_ONCE(CACHEFILES_ONDEMAND_OBJINFO(object)->ondemand_id == 0);
>  			xas_unlock(&xas);
> @@ -382,8 +415,12 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>  	wake_up_all(&cache->daemon_pollwq);
>  	wait_for_completion(&req->done);
>  	ret = req->error;
> +	kfree(req);
> +	return ret;
>  out:
>  	kfree(req);
> +	if (opcode == CACHEFILES_OP_OPEN)
> +		cachefiles_ondemand_set_object_close(req->object);

Could you please add a comment here explaining why we need to set the
object state back to CLOSE state for OPEN (espectially reopening)
requests when error occured, and why we only set it back to CLOSE state
when error occured before the anony fd gets initialized? (That's because
when the error occures after the anony fd has been initialized, the
object will be reset to CLOSE state through
cachefiles_ondemand_fd_release() triggered by close_fd().) Or the code
is quite difficult to comprehend.


>  	return ret;
>  }
>  
> @@ -435,7 +472,6 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
>  	if (!cachefiles_ondemand_object_is_open(object))
>  		return -ENOENT;
>  
> -	req->msg.object_id = CACHEFILES_ONDEMAND_OBJINFO(object)->ondemand_id;
>  	trace_cachefiles_ondemand_close(object, &req->msg);
>  	return 0;
>  }
> @@ -451,16 +487,7 @@ static int cachefiles_ondemand_init_read_req(struct cachefiles_req *req,
>  	struct cachefiles_object *object = req->object;
>  	struct cachefiles_read *load = (void *)req->msg.data;
>  	struct cachefiles_read_ctx *read_ctx = private;
> -	int object_id = CACHEFILES_ONDEMAND_OBJINFO(object)->ondemand_id;
>  
> -	/* Stop enqueuing requests when daemon has closed anon_fd. */
> -	if (!cachefiles_ondemand_object_is_open(object)) {
> -		WARN_ON_ONCE(object_id == 0);
> -		pr_info_once("READ: anonymous fd closed prematurely.\n");
> -		return -EIO;
> -	}
> -
> -	req->msg.object_id = object_id;
>  	load->off = read_ctx->off;
>  	load->len = read_ctx->len;
>  	trace_cachefiles_ondemand_read(object, &req->msg, load);

-- 
Thanks,
Jingbo
