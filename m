Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E71468EA9C
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Feb 2023 10:09:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PBZ270m8vz3cfH
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Feb 2023 20:09:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=HdDnyFzC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=HdDnyFzC;
	dkim-atps=neutral
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PBZ226423z3cMT
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 Feb 2023 20:09:29 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id k13so18600958plg.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 08 Feb 2023 01:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTV4gmWFsvat4BGmFQV2nTb2oNRlilhLC12DwTs3rMo=;
        b=HdDnyFzCdX/POmTgcWzRB6xYWvOQdJ7jQbuOwHOWb7iA0vXra2vQRXnkpWR7z2t74Y
         3Zlaha7FPUZQzGF1xBnNBLJH1uc8TPYD7QB48uBMKXo7NL+XQXEsG2K6wrfyIQzfAR7t
         07bgf+DxynKVD3VkeejffIxjmSs2YZmKFtrA0fm41Og9e5f5X/jypxaFAkw2D9v1+Llc
         0zJZGPhm87mHWA1VKyDzXW5rb+AaJU22sOiIMWDURxxiIH4krbnrAthQ2qayGgreXpeq
         k6LaIsrlE8trPEJueZFjVCGGwq4j5uSDym0u/3tnpH5GG6rlIWLUzq4vA2Uza31GgN1H
         YDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DTV4gmWFsvat4BGmFQV2nTb2oNRlilhLC12DwTs3rMo=;
        b=KO7CQQGWRZw59mJIXh9Cb2sspQ3ZJXIy0X8+4tNbEUKyqyHl8kwQg0Ho4/Zjvb2onW
         ddDm72DGJB1geRR3z74w8E5YWcP2RHZLIf8yfgXqkLNhV/VCZqZON+jdo+jMEiixcM/T
         hVbr6ZgzQZzbaMUSHd58fIGatO/xbuyINuPzu+dYIk9XyA6pnWy/ZpNz6eL+hK+KWCaz
         RRsNTe5VF1WZKgvtDa/FgbDMFxh70PGs9lDaMXFg1C8a19TykcwHfHha8vVg6xEOmC+X
         JP00/SE5mFq8/8c3HLjyJHgYMMstUgL5fs8vWV1m41K5AiXskE/OSzsOABptiZO5zlpz
         kWFg==
X-Gm-Message-State: AO0yUKW+drCF8hUyHwogQ4D1Se32PAXu68JajupGpToTQlrj1JaY3auG
	FuOlISkXwai0ouedfXab6DeyCQ==
X-Google-Smtp-Source: AK7set8RFe9izhTNSosc9mYm1ynqnJp/Mo8ezAjZeZZbVqMO/Af9xc/RBSZ8Z919OcuG6LH2H9UxHg==
X-Received: by 2002:a17:90b:4f86:b0:22c:4dd3:5c4b with SMTP id qe6-20020a17090b4f8600b0022c4dd35c4bmr8040480pjb.19.1675847367230;
        Wed, 08 Feb 2023 01:09:27 -0800 (PST)
Received: from [10.3.144.50] ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id ne22-20020a17090b375600b00230a3b016fcsm1037996pjb.10.2023.02.08.01.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 01:09:26 -0800 (PST)
Message-ID: <968342d4-3c5a-524e-432e-5c96b3aba827@bytedance.com>
Date: Wed, 8 Feb 2023 17:09:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [External] [PATCH] erofs: relinquish volume with mutex held
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <cover.1675840368.git.jefflexu@linux.alibaba.com>
 <20230208073206.111814-1-jefflexu@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20230208073206.111814-1-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2023/2/8 15:32, Jingbo Xu 写道:
> Relinquish fscache volume with mutex held.  Otherwise if a new domain is
> registered when the old domain with the same name gets removed from the
> list but not relinquished yet, fscache may complain the collision.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/erofs/fscache.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 8da6e05e9d23..35b2d8b5773e 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -328,8 +328,8 @@ static void erofs_fscache_domain_put(struct erofs_domain *domain)
>   			kern_unmount(erofs_pseudo_mnt);
>   			erofs_pseudo_mnt = NULL;
>   		}
> -		mutex_unlock(&erofs_domain_list_lock);
>   		fscache_relinquish_volume(domain->volume, NULL, false);
> +		mutex_unlock(&erofs_domain_list_lock);
>   		kfree(domain->domain_id);
>   		kfree(domain);
>   		return;
