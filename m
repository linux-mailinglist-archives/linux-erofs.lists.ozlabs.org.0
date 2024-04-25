Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1897E8B19A0
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 05:42:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1714016561;
	bh=TFC/YaLZv7yQ0eyRd7w4YHDkBUmQZEf/nvPZ7CB9pC8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=X7ppjw+4P8CNpFLz/+KM8WLQQgN3JKfGYpWb1BlhmBrlYWGNFrWMRHev9QbkU6z1F
	 PVtxS0rwb3nrPcSTu75UoWVDZ0IrF450Yrj1fvSHouR+3ihzPq2Y8/+BXFyZ2cbrKB
	 8X9J3hStk5NM3A6sgUEfKQ/EuAjaDiKehEcdYpS4i0eM/qzq4B/BkwThGATUEpQZmh
	 QLByTMk96vHb5AQFNk7svxY1M/3T4AEkepMYmsfSTIDdRKSA3eM+ZDHzD4ybGrkWRH
	 Q5c6nSAbLTPfCs0NQM3yE46tZ4sWopTkUgAXFs2eLV3CAdpzLQFuNfJLJ1yHCQmAqK
	 HRLxZ1OLwDyug==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VQ1rx4zb5z3dHw
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 13:42:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SJpLsgRF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VQ1rr3NwRz3cCb
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Apr 2024 13:42:36 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso553722b3a.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 20:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714016554; x=1714621354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TFC/YaLZv7yQ0eyRd7w4YHDkBUmQZEf/nvPZ7CB9pC8=;
        b=vIEuHSpWF3enhMBwqy4XwIHmarxqueCNJEL9t/sWfl+iME4WPhdfZCmWtuF1CSuURp
         u+g9rz4AlQmT2Mn/txz8YXC++ThtoyFmVeXKvUuXgOUZjm8x+AZL/bXqtajobZe96fUv
         Bw5ciswsbd3qHPianQOnnc6IARm24XdDLyehRS0ymoAmvGk7dsMOxRqABhzbOV+OkU4H
         BFOBU0/iDOOBy3JBI4STJX/wACPUKO46SOGL0zj0ZWXn9ONTlt0gsPWtYMRjqYGJfWH0
         xbyp8zIbk+ZgLZJrJjlm4c01UqHfuOz7k8WQSLTNCB2xiqAhsAs3zGrJU06jDN9stjKB
         7ZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3WXsuFoaB1+yK6uluzbDMF4vg+rE0uGKFvxrNENvBZVv5x/OcPSZJgNc/w8qEdIveuEYv2ITSwb/xiuX2YgCT2B6I2oc5i/UqAcn9
X-Gm-Message-State: AOJu0YxtsbyAUVGo1iCYLhzjZbblIf/S6RdWaAjlEQToK7BM6iMpyxuX
	J16nD6InomoW5jOk2umdSnTzKYDz8Yo8rzNimpVzwnCrZXQqYsdOO6aGDQ4aLDE=
X-Google-Smtp-Source: AGHT+IGDHeAbOWt5xjIMSRHX9LP133pX+NDtWq9rTdN4bteCp1aM+6ZXUcBnQZVGw2+uRdMca/c7UA==
X-Received: by 2002:a05:6a00:148d:b0:6ea:9252:435 with SMTP id v13-20020a056a00148d00b006ea92520435mr6295917pfu.30.1714016553835;
        Wed, 24 Apr 2024 20:42:33 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id i28-20020a63585c000000b005d5445349edsm11743801pgm.19.2024.04.24.20.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 20:42:33 -0700 (PDT)
Message-ID: <c359d4d3-5aff-4536-983d-87af3198724d@bytedance.com>
Date: Thu, 25 Apr 2024 11:42:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH 04/12] cachefiles: fix slab-use-after-free in
 cachefiles_ondemand_daemon_read()
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-5-libaokun@huaweicloud.com>
In-Reply-To: <20240424033916.2748488-5-libaokun@huaweicloud.com>
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
> BUG: KASAN: slab-use-after-free in cachefiles_ondemand_daemon_read+0xb41/0xb60
> Read of size 8 at addr ffff888122e84088 by task ondemand-04-dae/963
> 
> CPU: 13 PID: 963 Comm: ondemand-04-dae Not tainted 6.8.0-dirty #564
> Call Trace:
>   kasan_report+0x93/0xc0
>   cachefiles_ondemand_daemon_read+0xb41/0xb60
>   vfs_read+0x169/0xb50
>   ksys_read+0xf5/0x1e0
> 
> Allocated by task 116:
>   kmem_cache_alloc+0x140/0x3a0
>   cachefiles_lookup_cookie+0x140/0xcd0
>   fscache_cookie_state_machine+0x43c/0x1230
>   [...]
> 
> Freed by task 792:
>   kmem_cache_free+0xfe/0x390
>   cachefiles_put_object+0x241/0x480
>   fscache_cookie_state_machine+0x5c8/0x1230
>   [...]
> ==================================================================
> 
> Following is the process that triggers the issue:
> 
>       mount  |   daemon_thread1    |    daemon_thread2
> ------------------------------------------------------------
> cachefiles_withdraw_cookie
>   cachefiles_ondemand_clean_object(object)
>    cachefiles_ondemand_send_req
>     REQ_A = kzalloc(sizeof(*req) + data_len)
>     wait_for_completion(&REQ_A->done)
> 
>              cachefiles_daemon_read
>               cachefiles_ondemand_daemon_read
>                REQ_A = cachefiles_ondemand_select_req
>                msg->object_id = req->object->ondemand->ondemand_id
>                                    ------ restore ------
>                                    cachefiles_ondemand_restore
>                                    xas_for_each(&xas, req, ULONG_MAX)
>                                     xas_set_mark(&xas, CACHEFILES_REQ_NEW)
> 
>                                    cachefiles_daemon_read
>                                     cachefiles_ondemand_daemon_read
>                                      REQ_A = cachefiles_ondemand_select_req
>                copy_to_user(_buffer, msg, n)
>                 xa_erase(&cache->reqs, id)
>                 complete(&REQ_A->done)
>                ------ close(fd) ------
>                cachefiles_ondemand_fd_release
>                 cachefiles_put_object
>   cachefiles_put_object
>    kmem_cache_free(cachefiles_object_jar, object)
>                                      REQ_A->object->ondemand->ondemand_id
>                                       // object UAF !!!
> 
> When we see the request within xa_lock, req->object must not have been
> freed yet, so grab the reference count of object before xa_unlock to
> avoid the above issue.
> 
> Fixes: 0a7e54c1959c ("cachefiles: resend an open request if the read request's object is closed")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/ondemand.c          | 2 ++
>   include/trace/events/cachefiles.h | 6 +++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 56d12fe4bf73..bb94ef6a6f61 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -336,6 +336,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>   	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
>   	cache->req_id_next = xas.xa_index + 1;
>   	refcount_inc(&req->ref);
> +	cachefiles_grab_object(req->object, cachefiles_obj_get_read_req);
>   	xa_unlock(&cache->reqs);
>   
>   	if (msg->opcode == CACHEFILES_OP_OPEN) {
> @@ -355,6 +356,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>   			close_fd(((struct cachefiles_open *)msg->data)->fd);
>   	}
>   out:
> +	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);
>   	/* Remove error request and CLOSE request has no reply */
>   	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
>   		xas_reset(&xas);
> diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
> index cf4b98b9a9ed..119a823fb5a0 100644
> --- a/include/trace/events/cachefiles.h
> +++ b/include/trace/events/cachefiles.h
> @@ -33,6 +33,8 @@ enum cachefiles_obj_ref_trace {
>   	cachefiles_obj_see_withdrawal,
>   	cachefiles_obj_get_ondemand_fd,
>   	cachefiles_obj_put_ondemand_fd,
> +	cachefiles_obj_get_read_req,
> +	cachefiles_obj_put_read_req,
>   };
>   
>   enum fscache_why_object_killed {
> @@ -127,7 +129,9 @@ enum cachefiles_error_trace {
>   	EM(cachefiles_obj_see_lookup_cookie,	"SEE lookup_cookie")	\
>   	EM(cachefiles_obj_see_lookup_failed,	"SEE lookup_failed")	\
>   	EM(cachefiles_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\
> -	E_(cachefiles_obj_see_withdrawal,	"SEE withdrawal")
> +	EM(cachefiles_obj_see_withdrawal,	"SEE withdrawal")	\
> +	EM(cachefiles_obj_get_read_req,		"GET read_req")		\
> +	E_(cachefiles_obj_put_read_req,		"PUT read_req")
>   
>   #define cachefiles_coherency_traces					\
>   	EM(cachefiles_coherency_check_aux,	"BAD aux ")		\
