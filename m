Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DF8923DFB
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 14:35:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1719923710;
	bh=t2VzYQ+j8+6iQewLkeQCbIq09NlR4ehs8d7s9IHNlCc=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Q/gOMe7aYGv0a8IqMDMdCDdzLYiNXyUVfZGYKRjDS4CqlC9T5l6AObAH8460SjnA0
	 Bi7DWggqRG4+XZPUOYrBuXQRGOPQ+oGBgGfPb08g/YYivKIh7Ky/ubsCV0ZqHZCbb2
	 1DDVmn/eM595B7WuDpRtYjvxo/F2x9+107aCrP84+NNHiKLdjvOQ6W7OQZMgPkTdbN
	 dhfhe8FMfd9wrgIU2XTJqAxalkYGJs5K6H73lP3n9sRpfZJ8V2u5/f7FGAaMiebkT/
	 pfJMtkGJmZvsv8uOJNjhoq4CGI/7Fuq8gao9bDLIaa6pz4Dc7ieVAhs+y1fSsY8mpS
	 shNmBN/12Yr5g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WD2Ry5Xk3z3fqs
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 22:35:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=JEItlZnn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WD2Rt67l1z3fS1
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Jul 2024 22:35:06 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1f480624d0fso24245045ad.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 02 Jul 2024 05:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719923704; x=1720528504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t2VzYQ+j8+6iQewLkeQCbIq09NlR4ehs8d7s9IHNlCc=;
        b=Iab/NzmEG7lqHyQCEOdhk5fKMMNEWafpEqNdaTsoHziK+bDquu5sDzaUwcN9A2ULfm
         KIGkg3LEPQUMTidPbhs/DUzXXkrcdaMixaztKOyqgdtYNCveDJeO2vLRftkrI46Ws4F1
         3ZY7iK+YCpyixgIVZbYT9KhRLIR4sWE8OUC+REqZ/7rEgFeC29n2qUMCmZGRGfSibOmw
         +8W+mIuo4St4UXna0LagKC5U9dQg/dVxezolKRhFeZxqNYFeP+HYdG/TR2zaKwvfNhuM
         vMozN1kUQpXezcz7rlnhyIiWDLUhZSPfBcfEyeDpu4PQy9cqAOS0G8OikMKOW9sbfycI
         LtzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX48hufr8u0AB8J+s9uWuqFE+eA9x2/q3kyQ7jDK9K7+qN6RLvjj2GNeYYeJUr3ijxRhBVP17RIpY42jFlyU4MYIHVg3y+lZ+KTH2IR
X-Gm-Message-State: AOJu0Yx/xQ+UEmjcwy1iqHVTywtGe3C91GI5wGJWwZMCpvfIcBMeMw0H
	7ZhdpUi0AaH0/0eOeTL8inKZk4aFKvROLPHaWH5DOoxVDJpiaCapnWjlH/wza1I=
X-Google-Smtp-Source: AGHT+IHQnoogWURs/kZMnk2ajJRFjETen6Zlw109v1iQySDinr13mF+vbirF+SJ/r8hNYxe5uKUJlA==
X-Received: by 2002:a17:902:e80f:b0:1f9:ddb9:3ee5 with SMTP id d9443c01a7336-1fadbc85f8dmr67450555ad.26.1719923703933;
        Tue, 02 Jul 2024 05:35:03 -0700 (PDT)
Received: from [10.3.154.188] ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d9685sm83027985ad.111.2024.07.02.05.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 05:35:02 -0700 (PDT)
Message-ID: <616a1162-233e-46a9-98e8-cfac36426a2b@bytedance.com>
Date: Tue, 2 Jul 2024 20:34:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v3 8/9] cachefiles: cyclic allocation of msg_id
 to avoid reuse
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
 <20240628062930.2467993-9-libaokun@huaweicloud.com>
In-Reply-To: <20240628062930.2467993-9-libaokun@huaweicloud.com>
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2024/6/28 14:29, libaokun@huaweicloud.com 写道:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Reusing the msg_id after a maliciously completed reopen request may cause
> a read request to remain unprocessed and result in a hung, as shown below:
> 
>         t1       |      t2       |      t3
> -------------------------------------------------
> cachefiles_ondemand_select_req
>   cachefiles_ondemand_object_is_close(A)
>   cachefiles_ondemand_set_object_reopening(A)
>   queue_work(fscache_object_wq, &info->work)
>                  ondemand_object_worker
>                   cachefiles_ondemand_init_object(A)
>                    cachefiles_ondemand_send_req(OPEN)
>                      // get msg_id 6
>                      wait_for_completion(&req_A->done)
> cachefiles_ondemand_daemon_read
>   // read msg_id 6 req_A
>   cachefiles_ondemand_get_fd
>   copy_to_user
>                                  // Malicious completion msg_id 6
>                                  copen 6,-1
>                                  cachefiles_ondemand_copen
>                                   complete(&req_A->done)
>                                   // will not set the object to close
>                                   // because ondemand_id && fd is valid.
> 
>                  // ondemand_object_worker() is done
>                  // but the object is still reopening.
> 
>                                  // new open req_B
>                                  cachefiles_ondemand_init_object(B)
>                                   cachefiles_ondemand_send_req(OPEN)
>                                   // reuse msg_id 6
> process_open_req
>   copen 6,A.size
>   // The expected failed copen was executed successfully
> 
> Expect copen to fail, and when it does, it closes fd, which sets the
> object to close, and then close triggers reopen again. However, due to
> msg_id reuse resulting in a successful copen, the anonymous fd is not
> closed until the daemon exits. Therefore read requests waiting for reopen
> to complete may trigger hung task.
> 
> To avoid this issue, allocate the msg_id cyclically to avoid reusing the
> msg_id for a very short duration of time.
> 
> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/internal.h |  1 +
>   fs/cachefiles/ondemand.c | 20 ++++++++++++++++----
>   2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index a1a1d25e9514..7b99bd98de75 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -129,6 +129,7 @@ struct cachefiles_cache {
>   	unsigned long			req_id_next;
>   	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
>   	u32				ondemand_id_next;
> +	u32				msg_id_next;
>   };
>   
>   static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 1d5b970206d0..470c96658385 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -528,20 +528,32 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>   		smp_mb();
>   
>   		if (opcode == CACHEFILES_OP_CLOSE &&
> -			!cachefiles_ondemand_object_is_open(object)) {
> +		    !cachefiles_ondemand_object_is_open(object)) {
>   			WARN_ON_ONCE(object->ondemand->ondemand_id == 0);
>   			xas_unlock(&xas);
>   			ret = -EIO;
>   			goto out;
>   		}
>   
> -		xas.xa_index = 0;
> +		/*
> +		 * Cyclically find a free xas to avoid msg_id reuse that would
> +		 * cause the daemon to successfully copen a stale msg_id.
> +		 */
> +		xas.xa_index = cache->msg_id_next;
>   		xas_find_marked(&xas, UINT_MAX, XA_FREE_MARK);
> +		if (xas.xa_node == XAS_RESTART) {
> +			xas.xa_index = 0;
> +			xas_find_marked(&xas, cache->msg_id_next - 1, XA_FREE_MARK);
> +		}
>   		if (xas.xa_node == XAS_RESTART)
>   			xas_set_err(&xas, -EBUSY);
> +
>   		xas_store(&xas, req);
> -		xas_clear_mark(&xas, XA_FREE_MARK);
> -		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
> +		if (xas_valid(&xas)) {
> +			cache->msg_id_next = xas.xa_index + 1;
> +			xas_clear_mark(&xas, XA_FREE_MARK);
> +			xas_set_mark(&xas, CACHEFILES_REQ_NEW);
> +		}
>   		xas_unlock(&xas);
>   	} while (xas_nomem(&xas, GFP_KERNEL));
>   
