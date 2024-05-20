Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id AC9BD8C997D
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 09:46:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mYbxEBwi;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjTsb2cZmz3cXn
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 17:36:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mYbxEBwi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjTsT1HZVz30Vm
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 17:36:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716190598; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=y4VyW6RT9bxLxNrdTlih7hQvvkEMAoIZw9HLmgrPep4=;
	b=mYbxEBwi7edwCeygig7g13pUKAtxVT/hPBb3oNzbMTFg7hR8DtsonA1cOjgYSn0I5u25EaatngECKoPiev/0ysHWswAdlKLVS51L8MlsgkG1Y9tgmeGd3WRZDKq/ixqFHIWBmr2RgNF8bESmd+F7JaFgsCocqLZ9Yj7POAVSYEY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6nxons_1716190595;
Received: from 30.221.148.185(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W6nxons_1716190595)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 15:36:36 +0800
Message-ID: <a4cb6b6b-0105-4ba5-b43d-662ef96fbec6@linux.alibaba.com>
Date: Mon, 20 May 2024 15:36:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] cachefiles: fix slab-use-after-free in
 cachefiles_ondemand_daemon_read()
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-5-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240515084601.3240503-5-libaokun@huaweicloud.com>
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



On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> We got the following issue in a fuzz test of randomly issuing the restore
> command:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in cachefiles_ondemand_daemon_read+0xb41/0xb60
> Read of size 8 at addr ffff888122e84088 by task ondemand-04-dae/963
> 
> CPU: 13 PID: 963 Comm: ondemand-04-dae Not tainted 6.8.0-dirty #564
> Call Trace:
>  kasan_report+0x93/0xc0
>  cachefiles_ondemand_daemon_read+0xb41/0xb60
>  vfs_read+0x169/0xb50
>  ksys_read+0xf5/0x1e0
> 
> Allocated by task 116:
>  kmem_cache_alloc+0x140/0x3a0
>  cachefiles_lookup_cookie+0x140/0xcd0
>  fscache_cookie_state_machine+0x43c/0x1230
>  [...]
> 
> Freed by task 792:
>  kmem_cache_free+0xfe/0x390
>  cachefiles_put_object+0x241/0x480
>  fscache_cookie_state_machine+0x5c8/0x1230
>  [...]
> ==================================================================
> 
> Following is the process that triggers the issue:
> 
>      mount  |   daemon_thread1    |    daemon_thread2
> ------------------------------------------------------------
> cachefiles_withdraw_cookie
>  cachefiles_ondemand_clean_object(object)
>   cachefiles_ondemand_send_req
>    REQ_A = kzalloc(sizeof(*req) + data_len)
>    wait_for_completion(&REQ_A->done)
> 
>             cachefiles_daemon_read
>              cachefiles_ondemand_daemon_read
>               REQ_A = cachefiles_ondemand_select_req
>               msg->object_id = req->object->ondemand->ondemand_id
>                                   ------ restore ------
>                                   cachefiles_ondemand_restore
>                                   xas_for_each(&xas, req, ULONG_MAX)
>                                    xas_set_mark(&xas, CACHEFILES_REQ_NEW)
> 
>                                   cachefiles_daemon_read
>                                    cachefiles_ondemand_daemon_read
>                                     REQ_A = cachefiles_ondemand_select_req
>               copy_to_user(_buffer, msg, n)
>                xa_erase(&cache->reqs, id)
>                complete(&REQ_A->done)
>               ------ close(fd) ------
>               cachefiles_ondemand_fd_release
>                cachefiles_put_object
>  cachefiles_put_object
>   kmem_cache_free(cachefiles_object_jar, object)
>                                     REQ_A->object->ondemand->ondemand_id
>                                      // object UAF !!!
> 
> When we see the request within xa_lock, req->object must not have been
> freed yet, so grab the reference count of object before xa_unlock to
> avoid the above issue.
> 
> Fixes: 0a7e54c1959c ("cachefiles: resend an open request if the read request's object is closed")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/cachefiles/ondemand.c          | 2 ++
>  include/trace/events/cachefiles.h | 6 +++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 56d12fe4bf73..bb94ef6a6f61 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -336,6 +336,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
>  	cache->req_id_next = xas.xa_index + 1;
>  	refcount_inc(&req->ref);
> +	cachefiles_grab_object(req->object, cachefiles_obj_get_read_req);
>  	xa_unlock(&cache->reqs);
>  
>  	if (msg->opcode == CACHEFILES_OP_OPEN) {
> @@ -355,6 +356,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  			close_fd(((struct cachefiles_open *)msg->data)->fd);
>  	}
>  out:
> +	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
>  	/* Remove error request and CLOSE request has no reply */
>  	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
>  		xas_reset(&xas);
> diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
> index cf4b98b9a9ed..119a823fb5a0 100644
> --- a/include/trace/events/cachefiles.h
> +++ b/include/trace/events/cachefiles.h
> @@ -33,6 +33,8 @@ enum cachefiles_obj_ref_trace {
>  	cachefiles_obj_see_withdrawal,
>  	cachefiles_obj_get_ondemand_fd,
>  	cachefiles_obj_put_ondemand_fd,
> +	cachefiles_obj_get_read_req,
> +	cachefiles_obj_put_read_req,

How about cachefiles_obj_[get|put]_ondemand_read, so that it could be
easily identified as ondemand mode at the first glance?

>  };
>  
>  enum fscache_why_object_killed {
> @@ -127,7 +129,9 @@ enum cachefiles_error_trace {
>  	EM(cachefiles_obj_see_lookup_cookie,	"SEE lookup_cookie")	\
>  	EM(cachefiles_obj_see_lookup_failed,	"SEE lookup_failed")	\
>  	EM(cachefiles_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\
> -	E_(cachefiles_obj_see_withdrawal,	"SEE withdrawal")
> +	EM(cachefiles_obj_see_withdrawal,	"SEE withdrawal")	\
> +	EM(cachefiles_obj_get_read_req,		"GET read_req")		\
> +	E_(cachefiles_obj_put_read_req,		"PUT read_req")

Ditto.


Otherwise, LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo
