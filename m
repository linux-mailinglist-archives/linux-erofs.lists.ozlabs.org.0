Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id B45C08CD594
	for <lists+linux-erofs@lfdr.de>; Thu, 23 May 2024 16:21:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BN+OLsQW;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VlVZB2fH9z3vY2
	for <lists+linux-erofs@lfdr.de>; Fri, 24 May 2024 00:15:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BN+OLsQW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VlVZ52llyz3gBn
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 May 2024 00:15:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716473718; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MVhR9qJH/G4vYt3c0pqKjwIpl5/b/3BVmyfe685riEA=;
	b=BN+OLsQWKZ+ESkEt4O0CGpRrZ5yHIiPdTcBv3Uq9/yeDT3x71bmZBQkVf60CCO7W0XXdWaYrid/qmWbqLanxoWuFMTSjvRP6iXU2QiSfV97Pp6S3R3VN9W//Pr0mq+aUSHTB2THGxXI+BVvjwBN4Zo8Aq0UmxQjTJ1Dk3CbfV10=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W73Bx-a_1716473712;
Received: from 30.39.171.189(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W73Bx-a_1716473712)
          by smtp.aliyun-inc.com;
          Thu, 23 May 2024 22:15:14 +0800
Message-ID: <943db365-f5e7-4fdc-9f00-d2cd00f527d7@linux.alibaba.com>
Date: Thu, 23 May 2024 22:15:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] cachefiles: fix slab-use-after-free in
 cachefiles_ondemand_get_fd()
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
References: <20240522114308.2402121-1-libaokun@huaweicloud.com>
 <20240522114308.2402121-4-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240522114308.2402121-4-libaokun@huaweicloud.com>
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 5/22/24 7:42 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> We got the following issue in a fuzz test of randomly issuing the restore
> command:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in cachefiles_ondemand_daemon_read+0x609/0xab0
> Write of size 4 at addr ffff888109164a80 by task ondemand-04-dae/4962
> 
> CPU: 11 PID: 4962 Comm: ondemand-04-dae Not tainted 6.8.0-rc7-dirty #542
> Call Trace:
>  kasan_report+0x94/0xc0
>  cachefiles_ondemand_daemon_read+0x609/0xab0
>  vfs_read+0x169/0xb50
>  ksys_read+0xf5/0x1e0
> 
> Allocated by task 626:
>  __kmalloc+0x1df/0x4b0
>  cachefiles_ondemand_send_req+0x24d/0x690
>  cachefiles_create_tmpfile+0x249/0xb30
>  cachefiles_create_file+0x6f/0x140
>  cachefiles_look_up_object+0x29c/0xa60
>  cachefiles_lookup_cookie+0x37d/0xca0
>  fscache_cookie_state_machine+0x43c/0x1230
>  [...]
> 
> Freed by task 626:
>  kfree+0xf1/0x2c0
>  cachefiles_ondemand_send_req+0x568/0x690
>  cachefiles_create_tmpfile+0x249/0xb30
>  cachefiles_create_file+0x6f/0x140
>  cachefiles_look_up_object+0x29c/0xa60
>  cachefiles_lookup_cookie+0x37d/0xca0
>  fscache_cookie_state_machine+0x43c/0x1230
>  [...]
> ==================================================================
> 
> Following is the process that triggers the issue:
> 
>      mount  |   daemon_thread1    |    daemon_thread2
> ------------------------------------------------------------
>  cachefiles_ondemand_init_object
>   cachefiles_ondemand_send_req
>    REQ_A = kzalloc(sizeof(*req) + data_len)
>    wait_for_completion(&REQ_A->done)
> 
>             cachefiles_daemon_read
>              cachefiles_ondemand_daemon_read
>               REQ_A = cachefiles_ondemand_select_req
>               cachefiles_ondemand_get_fd
>               copy_to_user(_buffer, msg, n)
>             process_open_req(REQ_A)
>                                   ------ restore ------
>                                   cachefiles_ondemand_restore
>                                   xas_for_each(&xas, req, ULONG_MAX)
>                                    xas_set_mark(&xas, CACHEFILES_REQ_NEW);
> 
>                                   cachefiles_daemon_read
>                                    cachefiles_ondemand_daemon_read
>                                     REQ_A = cachefiles_ondemand_select_req
> 
>              write(devfd, ("copen %u,%llu", msg->msg_id, size));
>              cachefiles_ondemand_copen
>               xa_erase(&cache->reqs, id)
>               complete(&REQ_A->done)
>    kfree(REQ_A)
>                                     cachefiles_ondemand_get_fd(REQ_A)
>                                      fd = get_unused_fd_flags
>                                      file = anon_inode_getfile
>                                      fd_install(fd, file)
>                                      load = (void *)REQ_A->msg.data;
>                                      load->fd = fd;
>                                      // load UAF !!!
> 
> This issue is caused by issuing a restore command when the daemon is still
> alive, which results in a request being processed multiple times thus
> triggering a UAF. So to avoid this problem, add an additional reference
> count to cachefiles_req, which is held while waiting and reading, and then
> released when the waiting and reading is over.
> 
> Note that since there is only one reference count for waiting, we need to
> avoid the same request being completed multiple times, so we can only
> complete the request if it is successfully removed from the xarray.
> 
> Fixes: e73fa11a356c ("cachefiles: add restore command to recover inflight ondemand read requests")
> Suggested-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/cachefiles/internal.h |  1 +
>  fs/cachefiles/ondemand.c | 23 +++++++++++++++++++----
>  2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index d33169f0018b..7745b8abc3aa 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -138,6 +138,7 @@ static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
>  struct cachefiles_req {
>  	struct cachefiles_object *object;
>  	struct completion done;
> +	refcount_t ref;
>  	int error;
>  	struct cachefiles_msg msg;
>  };
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 4ba42f1fa3b4..c011fb24d238 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -4,6 +4,12 @@
>  #include <linux/uio.h>
>  #include "internal.h"
>  
> +static inline void cachefiles_req_put(struct cachefiles_req *req)
> +{
> +	if (refcount_dec_and_test(&req->ref))
> +		kfree(req);
> +}
> +
>  static int cachefiles_ondemand_fd_release(struct inode *inode,
>  					  struct file *file)
>  {
> @@ -330,6 +336,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  
>  	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
>  	cache->req_id_next = xas.xa_index + 1;
> +	refcount_inc(&req->ref);
>  	xa_unlock(&cache->reqs);
>  
>  	id = xas.xa_index;
> @@ -356,15 +363,22 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  		complete(&req->done);
>  	}
>  
> +	cachefiles_req_put(req);
>  	return n;
>  
>  err_put_fd:
>  	if (msg->opcode == CACHEFILES_OP_OPEN)
>  		close_fd(((struct cachefiles_open *)msg->data)->fd);
>  error:
> -	xa_erase(&cache->reqs, id);
> -	req->error = ret;
> -	complete(&req->done);
> +	xas_reset(&xas);
> +	xas_lock(&xas);
> +	if (xas_load(&xas) == req) {
> +		req->error = ret;
> +		complete(&req->done);
> +		xas_store(&xas, NULL);
> +	}
> +	xas_unlock(&xas);
> +	cachefiles_req_put(req);
>  	return ret;
>  }
>  
> @@ -395,6 +409,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>  		goto out;
>  	}
>  
> +	refcount_set(&req->ref, 1);
>  	req->object = object;
>  	init_completion(&req->done);
>  	req->msg.opcode = opcode;
> @@ -456,7 +471,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>  	wake_up_all(&cache->daemon_pollwq);
>  	wait_for_completion(&req->done);
>  	ret = req->error;
> -	kfree(req);
> +	cachefiles_req_put(req);
>  	return ret;
>  out:
>  	/* Reset the object to close state in error handling path.

-- 
Thanks,
Jingbo
