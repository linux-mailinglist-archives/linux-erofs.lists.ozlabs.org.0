Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244928B1A12
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 06:57:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1714021024;
	bh=BKeDMR/VAwY6KFTp7q+D4M4FMjxN7DS4mVLtRqQA6Ps=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=TduBb3tZf3fU68PNGZmzcDUBCVcYs+F8X41aBJ+p5yuhoU60bb+uGB77jn8d2aeIZ
	 II+B81WeUpj/22+sYEJlkTO36Ei/5KRs3et/hA18Rd/fGv4fbTaJ3EXH/lnAIddTSq
	 yB4mfPZYfOgGp6WRFtuY5JsN7LrC2GX1DvV5r2QUpfEyNfhKaMQqsPfIOW4C9K5YNC
	 XhwaGrOMFGzo6FZAFQVeK5ldEjU+yKB6NetNyiZwEvraOHbiSKDqmp4NIfMmdNrn0l
	 xbFbj/20ImOL8Kpz1b2GQuLQU27qvGGahW45Ar19q3FkPVeYJsfxtNoKkYODH+/yjV
	 islxRJt2RCwRQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VQ3Vm4zRBz3dGn
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 14:57:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CwQZ2yvT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VQ3Vd4jvTz3ckg
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Apr 2024 14:56:56 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so569179b3a.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 21:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714021014; x=1714625814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BKeDMR/VAwY6KFTp7q+D4M4FMjxN7DS4mVLtRqQA6Ps=;
        b=rWBhUE6SUZQfbF8G/OEyY0eCCK9kxrtw/QpVTHvJmjwM+xRjaSO46ckQSvfUKIlvCy
         EWPxUqrkF37iMDZxM6L8wMu85GysUtQrdhUTMTtPHzjGaVt3VorDzBuFx8UBDzqE3thz
         VOrlGvvexqFp5g50ywPZPMPL75A/mGV8mDq89zZI1sOsK3n/YtJ1t2gam1eguz5uVw0q
         FyyMLFa2+aQmw1kzYqS4b3EATFjlUTtCefxLFZDS5VfqSlk3MFV781y6mQCJCR0ka79U
         czV2Tw7HOjCdM9g6SYFUz6LZKpFpOGhID+BX31f73E5RisHOHNMuyOyHYp7tzkAsYnfr
         YBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6jiu/w9FZT1ezSW/hkO8zlMCcpXQBybcM2TqZUqfD+TF1x3steqlU1LdZEpteR8v2IC+nW+PxbD9iWBTAzX1NLb9mMw91EO8imdNe
X-Gm-Message-State: AOJu0Yxi4X4cUEWV2OuOYXeRM4swbKdyhAExjZj9E9Fiv+G+N+4FAn+v
	DR0FLa8pOQYDCvrYPVeGvhCs2EKiWt57OB8aDnqXwL7NgEe6pwKVSzFVEWQdqb0=
X-Google-Smtp-Source: AGHT+IFhv2H4/vzmguAbVa1ZZdUzUVWqiOvj6TC3VDCEFSUjKANEKZ1zNzViwGoIP2V0IpdAALwTxQ==
X-Received: by 2002:a05:6a20:840a:b0:1a7:7818:720e with SMTP id c10-20020a056a20840a00b001a77818720emr5781273pzd.21.1714021013910;
        Wed, 24 Apr 2024 21:56:53 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id r6-20020a17090a5c8600b002ade3490b4asm6319376pji.22.2024.04.24.21.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 21:56:53 -0700 (PDT)
Message-ID: <32f04cea-1c41-4c16-98fb-86be6ecefc87@bytedance.com>
Date: Thu, 25 Apr 2024 12:56:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] cachefiles: Set object to close if ondemand_id < 0
 in copen
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-11-libaokun@huaweicloud.com>
In-Reply-To: <20240424033916.2748488-11-libaokun@huaweicloud.com>
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
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> If copen is maliciously called in the user mode, it may delete the request
> corresponding to the random id. And the request may have not been read yet.
> 
> Note that when the object is set to reopen, the open request will be done
> with the still reopen state in above case. As a result, the request
> corresponding to this object is always skipped in select_req function, so
> the read request is never completed and blocks other process.
> 
> Fix this issue by simply set object to close if its id < 0 in copen.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/ondemand.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 7c2d43104120..673e7ad52041 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -182,6 +182,7 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>   	xas_store(&xas, NULL);
>   	xa_unlock(&cache->reqs);
>   
> +	info = req->object->ondemand;
>   	/* fail OPEN request if copen format is invalid */
>   	ret = kstrtol(psize, 0, &size);
>   	if (ret) {
> @@ -201,7 +202,6 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>   		goto out;
>   	}
>   
> -	info = req->object->ondemand;
>   	spin_lock(&info->lock);
>   	/* The anonymous fd was closed before copen ? */
>   	if (info->ondemand_id == CACHEFILES_ONDEMAND_ID_CLOSED) {
> @@ -222,6 +222,11 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>   	wake_up_all(&cache->daemon_pollwq);
>   
>   out:
> +	spin_lock(&info->lock);
> +	/* Need to set object close to avoid reopen status continuing */
> +	if (info->ondemand_id == CACHEFILES_ONDEMAND_ID_CLOSED)
> +		cachefiles_ondemand_set_object_close(req->object);
> +	spin_unlock(&info->lock);
>   	complete(&req->done);
>   	return ret;
>   }
