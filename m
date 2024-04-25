Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140228B1A3D
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 07:15:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1714022153;
	bh=bNdUFtYR2xbr86vH1UwuLkPY/+I0PhhpA884pNqNeBA=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=WBnh0GCwxhDaOu/SzMdQ10F9CFH+aM33V6I9ev2r2ogefaEyZAONX9vOz2lQVYMG1
	 acThT3V3KHPVYD6pfDmvNkM0c2+IsJ2KHIOzUjhmbD55sYjNTmGLf4VYxN3l5JXnVB
	 IWAHJeCR9p3D+S0SLHnUy8zdOGfVMj5IIM65KRMOBRHWT1dKlTP8iYQElK2Zl5ouNG
	 mSoo9WYhon51NIjCnPenerkhfoJoSarbhesn8BnyVB1JiTzShw9vDmDGK1B/TWNVNa
	 wag0zlaCuZzd6NZqXoYp1tB7vSUKfbF7oDtW7MtEnJrwBBWc/AYvwElVxCKejoP4Gy
	 cf4WOJ43O563w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VQ3wT4wh9z3dH8
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 15:15:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=SM/qxM/w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VQ3wN46wkz3cmg
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Apr 2024 15:15:45 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1eab16dcfd8so2897705ad.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 22:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714022143; x=1714626943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bNdUFtYR2xbr86vH1UwuLkPY/+I0PhhpA884pNqNeBA=;
        b=MQdYTv5I3ImJ0s1RXufj1sDFqc1jy5qYejnDsPQQI7hoorOmzvPj2eSLke8kkSoINI
         xTyFOKDv8gCuu3RyCXp1IyFTDdv89IlB2bXEUpI6Fe/l+QVAXEHK7hNk0NbCHf5k+BX+
         VTX94t0L1eQ9YvPNeHZDf8zsXHgwrqU8GFXxwXNU/kxlzKEq0RE5Mjaael3BY5hjSMag
         BWbkkvs7ve/8kiNAKm3rNt6mymLvhvsEF+p8/zae4hYAbbKZyQq+VJ1TvohWaDnFwtB4
         FiCoN5Rmocst63px4CVFLCaxtrP3yWs41JehEIwc1g48ppm/cKKWYIAsJIiI8iW9qBKH
         t8+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWE7DTrxzONrvij4TUApMg3O/qQ5IB3DxCIPtW7hsXFyQgfbPva2LJR0mNnzHFFoYWiVCm/2WXLPkYRxXWrB7oD25I7WI1dpJNM2/oH
X-Gm-Message-State: AOJu0Yx1KMDBjsAi8/Z6k0C3LoVtw2bz/B/Ue+cMkIk/rOHDV7His9eC
	yrJIuvUH+SKEx1HIOf1B6YKRFYG2LfifJj/l7rcahkERvHMQ/lUFb3xIO+jiIXw=
X-Google-Smtp-Source: AGHT+IEQITLDZGcYmA+FjKYuiztsfCh0wLhqQI6Xcb/IceR3ZPd+qhouMoKXS2ZMMGdGKHN5UKg2Ig==
X-Received: by 2002:a17:903:41d0:b0:1e4:6243:8543 with SMTP id u16-20020a17090341d000b001e462438543mr5733230ple.5.1714022143006;
        Wed, 24 Apr 2024 22:15:43 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ce9000b001e78d217fd9sm12826398plg.16.2024.04.24.22.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 22:15:42 -0700 (PDT)
Message-ID: <e1c97315-de7a-4222-9fd4-788e566b2eaa@bytedance.com>
Date: Thu, 25 Apr 2024 13:15:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] cachefiles: make on-demand read killable
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-13-libaokun@huaweicloud.com>
In-Reply-To: <20240424033916.2748488-13-libaokun@huaweicloud.com>
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
> Replacing wait_for_completion() with wait_for_completion_killable() in
> cachefiles_ondemand_send_req() allows us to kill processes that might
> trigger a hunk_task if the daemon is abnormal.
> 
> But now only CACHEFILES_OP_READ is killable, because OP_CLOSE and OP_OPEN
> is initiated from kworker context and the signal is prohibited in these
> kworker.
> 
> Note that when the req in xas changes, i.e. xas_load(&xas) != req, it
> means that a process will complete the current request soon, so wait
> again for the request to be completed.
> 
> Suggested-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/ondemand.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 673e7ad52041..b766430f4abf 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -525,8 +525,25 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>   		goto out;
>   
>   	wake_up_all(&cache->daemon_pollwq);
> -	wait_for_completion(&req->done);
> -	ret = req->error;
> +wait:
> +	ret = wait_for_completion_killable(&req->done);
> +	if (!ret) {
> +		ret = req->error;
> +	} else {
> +		xas_reset(&xas);
> +		xas_lock(&xas);
> +		if (xas_load(&xas) == req) {
> +			xas_store(&xas, NULL);
> +			ret = -EINTR;
> +		}
> +		xas_unlock(&xas);
> +
> +		/* Someone will complete it soon. */
> +		if (ret != -EINTR) {
> +			cpu_relax();
> +			goto wait;
> +		}
> +	}
>   	cachefiles_req_put(req);
>   	return ret;
>   out:
