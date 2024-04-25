Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FD78B199B
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 05:40:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1714016401;
	bh=wIhG2on98pfe8bofhlOX/NmELBwk78MljHX0l+Mx/hc=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ioLr0L0YkAdQ7GLkaBETHgw5ZAsvGGRi4jOQXDhawhbdOxklXbrENLukXStowZH5x
	 KYtJFs1qbXpEEudspojQ1StL0Bxrrj//G0aqBhf6pTpghAzastT6kh9R5eZrToQPzo
	 wUYF9wLNkbEvI6sVtnmRTeipWk+3EU6ocmixIJYvbSvmiUf9L3mx6171G51AnMwg1X
	 RAB20zgbQIk0FSgSvT4trVFKLPnte9r1zh+f3vim6TRytwnHQZuT+Zs/+w6PB9Cy0N
	 C8V4NNstb5VdMwuamcfU4ZHnow5FraxMk8Jq5ws9s7UcVsQ8UR/4yclHbmJZdqeWjf
	 YN4eACtnfbwLA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VQ1nr6sCyz3dJ5
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 13:40:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=bYlfQBat;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VQ1nl48r6z3cy8
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Apr 2024 13:39:53 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2ab88634cfaso476227a91.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 20:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714016391; x=1714621191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wIhG2on98pfe8bofhlOX/NmELBwk78MljHX0l+Mx/hc=;
        b=A/B7sq/UlRmZxR50kez12odcAl264DzSX/g90bXtE255F8UH+z56nemy3eXGMewNyC
         wirN7mxLTvr+018hrFkTk2a1TzOcvA0jAfyYkAYaOao2YHF2FT5EQqQ4mPla74Tzgsf9
         YnLAWw7O+guMlOM7CEHbD1Fc+q3LDfI8xtIXmkZubF36hU9xGKFSJCU/Xj43cWO5uvbu
         lIyGAPFLbyNdwG7le3+CmTqVzH0lm1h5HUjhuth/4uJ6GnR2jvfGoR4DaCpPKV9OEhAI
         It33UPwDVf2ncnbyoreHmDkw8k73xb8XVFpp58WXZNHkITgD7Cf5nbdFlmNoNJsVyAJe
         R3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCV/xMwD05KGFHBW7isT7CR9lSX8UqaGHiHMcY2khhcC+fI6RlSZbvIOfDTVPyABnvNbxoehjKunyxJztBToCkU4yxfpJU+DCif88vrv
X-Gm-Message-State: AOJu0YySwqXByGjdnFEg6+tgFMeT0aC1lJIDrYPfokmhb/1akzJmjIVr
	IkqYhUbyGqa0RKhzdVVTGhfABQRTnivwuztf7uF1T+VzozgJWqQ5aGUJ6RUQDUQ=
X-Google-Smtp-Source: AGHT+IEfZDVSTn6CBqe5ZAHgMgoe0qLLYIBYiW7PO1i7p+W13X5lG7GbuYGFsQwdW53QX9r33Uk0OA==
X-Received: by 2002:a17:90b:1e47:b0:2af:44e6:2bc with SMTP id pi7-20020a17090b1e4700b002af44e602bcmr3771680pjb.8.1714016391029;
        Wed, 24 Apr 2024 20:39:51 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id fu4-20020a17090ad18400b002acfe00c742sm8459264pjb.21.2024.04.24.20.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 20:39:50 -0700 (PDT)
Message-ID: <0affdece-7816-4011-a55a-59a1af4d35dd@bytedance.com>
Date: Thu, 25 Apr 2024 11:39:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] cachefiles: fix slab-use-after-free in
 cachefiles_ondemand_get_fd()
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-4-libaokun@huaweicloud.com>
In-Reply-To: <20240424033916.2748488-4-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
From: Jia Zhu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jia Zhu <zhujia.zj@bytedance.com>
Cc: jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2024/4/24 11:39, libaokun@huaweicloud.com 写道:
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
>   kasan_report+0x94/0xc0
>   cachefiles_ondemand_daemon_read+0x609/0xab0
>   vfs_read+0x169/0xb50
>   ksys_read+0xf5/0x1e0
> 
> Allocated by task 626:
>   __kmalloc+0x1df/0x4b0
>   cachefiles_ondemand_send_req+0x24d/0x690
>   cachefiles_create_tmpfile+0x249/0xb30
>   cachefiles_create_file+0x6f/0x140
>   cachefiles_look_up_object+0x29c/0xa60
>   cachefiles_lookup_cookie+0x37d/0xca0
>   fscache_cookie_state_machine+0x43c/0x1230
>   [...]
> 
> Freed by task 626:
>   kfree+0xf1/0x2c0
>   cachefiles_ondemand_send_req+0x568/0x690
>   cachefiles_create_tmpfile+0x249/0xb30
>   cachefiles_create_file+0x6f/0x140
>   cachefiles_look_up_object+0x29c/0xa60
>   cachefiles_lookup_cookie+0x37d/0xca0
>   fscache_cookie_state_machine+0x43c/0x1230
>   [...]
> ==================================================================
> 
> Following is the process that triggers the issue:
> 
>       mount  |   daemon_thread1    |    daemon_thread2
> ------------------------------------------------------------
>   cachefiles_ondemand_init_object
>    cachefiles_ondemand_send_req
>     REQ_A = kzalloc(sizeof(*req) + data_len)
>     wait_for_completion(&REQ_A->done)
> 
>              cachefiles_daemon_read
>               cachefiles_ondemand_daemon_read
>                REQ_A = cachefiles_ondemand_select_req
>                cachefiles_ondemand_get_fd
>                copy_to_user(_buffer, msg, n)
>              process_open_req(REQ_A)
>                                    ------ restore ------
>                                    cachefiles_ondemand_restore
>                                    xas_for_each(&xas, req, ULONG_MAX)
>                                     xas_set_mark(&xas, CACHEFILES_REQ_NEW);
> 
>                                    cachefiles_daemon_read
>                                     cachefiles_ondemand_daemon_read
>                                      REQ_A = cachefiles_ondemand_select_req
> 
>               write(devfd, ("copen %u,%llu", msg->msg_id, size));
>               cachefiles_ondemand_copen
>                xa_erase(&cache->reqs, id)
>                complete(&REQ_A->done)
>     kfree(REQ_A)
>                                      cachefiles_ondemand_get_fd(REQ_A)
>                                       fd = get_unused_fd_flags
>                                       file = anon_inode_getfile
>                                       fd_install(fd, file)
>                                       load = (void *)REQ_A->msg.data;
>                                       load->fd = fd;
>                                       // load UAF !!!
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

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/internal.h |  1 +
>   fs/cachefiles/ondemand.c | 44 ++++++++++++++++++++++------------------
>   2 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index d33169f0018b..7745b8abc3aa 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -138,6 +138,7 @@ static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
>   struct cachefiles_req {
>   	struct cachefiles_object *object;
>   	struct completion done;
> +	refcount_t ref;
>   	int error;
>   	struct cachefiles_msg msg;
>   };
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index fd49728d8bae..56d12fe4bf73 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -4,6 +4,12 @@
>   #include <linux/uio.h>
>   #include "internal.h"
>   
> +static inline void cachefiles_req_put(struct cachefiles_req *req)
> +{
> +	if (refcount_dec_and_test(&req->ref))
> +		kfree(req);
> +}
> +
>   static int cachefiles_ondemand_fd_release(struct inode *inode,
>   					  struct file *file)
>   {
> @@ -299,7 +305,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>   {
>   	struct cachefiles_req *req;
>   	struct cachefiles_msg *msg;
> -	unsigned long id = 0;
>   	size_t n;
>   	int ret = 0;
>   	XA_STATE(xas, &cache->reqs, cache->req_id_next);
> @@ -330,41 +335,39 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>   
>   	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
>   	cache->req_id_next = xas.xa_index + 1;
> +	refcount_inc(&req->ref);
>   	xa_unlock(&cache->reqs);
>   
> -	id = xas.xa_index;
> -
>   	if (msg->opcode == CACHEFILES_OP_OPEN) {
>   		ret = cachefiles_ondemand_get_fd(req);
>   		if (ret) {
>   			cachefiles_ondemand_set_object_close(req->object);
> -			goto error;
> +			goto out;
>   		}
>   	}
>   
> -	msg->msg_id = id;
> +	msg->msg_id = xas.xa_index;
>   	msg->object_id = req->object->ondemand->ondemand_id;
>   
>   	if (copy_to_user(_buffer, msg, n) != 0) {
>   		ret = -EFAULT;
>   		if (msg->opcode == CACHEFILES_OP_OPEN)
>   			close_fd(((struct cachefiles_open *)msg->data)->fd);
> -		goto error;
>   	}
> -
> -	/* CLOSE request has no reply */
> -	if (msg->opcode == CACHEFILES_OP_CLOSE) {
> -		xa_erase(&cache->reqs, id);
> -		complete(&req->done);
> +out:
> +	/* Remove error request and CLOSE request has no reply */
> +	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
> +		xas_reset(&xas);
> +		xas_lock(&xas);
> +		if (xas_load(&xas) == req) {
> +			req->error = ret;
> +			complete(&req->done);
> +			xas_store(&xas, NULL);
> +		}
> +		xas_unlock(&xas);
>   	}
> -
> -	return n;
> -
> -error:
> -	xa_erase(&cache->reqs, id);
> -	req->error = ret;
> -	complete(&req->done);
> -	return ret;
> +	cachefiles_req_put(req);
> +	return ret ? ret : n;
>   }
>   
>   typedef int (*init_req_fn)(struct cachefiles_req *req, void *private);
> @@ -394,6 +397,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>   		goto out;
>   	}
>   
> +	refcount_set(&req->ref, 1);
>   	req->object = object;
>   	init_completion(&req->done);
>   	req->msg.opcode = opcode;
> @@ -455,7 +459,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>   	wake_up_all(&cache->daemon_pollwq);
>   	wait_for_completion(&req->done);
>   	ret = req->error;
> -	kfree(req);
> +	cachefiles_req_put(req);
>   	return ret;
>   out:
>   	/* Reset the object to close state in error handling path.
