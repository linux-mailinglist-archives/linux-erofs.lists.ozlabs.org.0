Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A42C764EDA
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 11:11:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690449077;
	bh=cACJ3NT7rSPHksG1CSCDv/QZVUluNTqq4KXvaW886oI=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=DRwA+w8rY11cEorGM7Kr3m8t7o8GqxehLYB3Pp1/yvgSLdlCP32y/JbEhmjwDwd7R
	 zSAc0WNh5MlcUK87plz7nmWMTW2ZXP22z4hDUjcv/6HqSR+2KEii/yJQNE0949Bmr/
	 x3Jj+5YjLDVhjiU2K4nI+8a9CJcFaXA70tEs+qmNkIm7BJ2M4XBECUvna/gmkA2AQ1
	 oTY0QLfoR9UgLRJ6gbRZm+X9xcqsLY8p2FvEk2I2u+okXHb9a2scfg8yDFc0wKw/Jg
	 RAXsWo/RSIv0zQFlLaVP4rFNG+JUACAaVMBKgwGSzwgizfbV9zrLwaDwi3mCGSwGEZ
	 3FQwqKfGtPBjw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RBQ452dPKz3cFt
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 19:11:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lKnOasFR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RBQ422mYxz2xpj
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 19:11:14 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686f74a8992so86824b3a.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 02:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690449072; x=1691053872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cACJ3NT7rSPHksG1CSCDv/QZVUluNTqq4KXvaW886oI=;
        b=OwL4DfD3oTw8qGyXCBovuUh5KtsDzXk3hlZIXtBbYsSVkYL+/U4/PZmxulSQhtIbTk
         tSWQJkpfZnJnjpW/gvOxFaXHqj/nP0AhOgattQ+zVsPwQBShQuYROEC2RncTXiaTSJ8y
         bJ/AuBFPMncHWqu86pXrcHjJ1v3bdEFd+Yt8aCvHzO+fJYOPYhBaYGA21EpvDaaBiGKQ
         DiMa5WCynZU/W4H/qxkHe+OlWPIrnSI5xmhSIoYZYS/2/B0Pt5C/EyO9a7fDESXM8jdJ
         FW7mpPkCVlZG8156Mt7Znld/dyIU/BUXIsWt/SGnSovYE/ENguTBcPND+OdPlz+rkACK
         L3ZQ==
X-Gm-Message-State: ABy/qLbs6gnmDqqqgu3WHjcVH6R6xRLZw4vERuAEsJudJOYUGdGcaMBX
	tQPcwtAvaHY4i3kOlCjHOdArig==
X-Google-Smtp-Source: APBJJlFfFWIsc+pfSeu4dzuDSzimKXTbXaekoL0gFKsbHel8kB/qljY4u0PtyM2mUW/wDh3jQGEPVg==
X-Received: by 2002:a05:6a00:2d82:b0:675:8627:a291 with SMTP id fb2-20020a056a002d8200b006758627a291mr4692915pfb.3.1690449072033;
        Thu, 27 Jul 2023 02:11:12 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id h4-20020aa786c4000000b00682a99b01basm1038080pfo.0.2023.07.27.02.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 02:11:11 -0700 (PDT)
Message-ID: <1eb30b9e-c43b-b81e-4d96-5d6fa4f2894a@bytedance.com>
Date: Thu, 27 Jul 2023 17:10:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 22/49] sunrpc: dynamically allocate the sunrpc_cred
 shrinker
Content-Language: en-US
To: akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
 vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
 brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
 cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
 gregkh@linuxfoundation.org, muchun.song@linux.dev
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-23-zhengqi.arch@bytedance.com>
In-Reply-To: <20230727080502.77895-23-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
From: Qi Zheng via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, x86@kernel.org, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-arm-msm@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/27 16:04, Qi Zheng wrote:
> Use new APIs to dynamically allocate the sunrpc_cred shrinker.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   net/sunrpc/auth.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
> index 2f16f9d17966..6b898b1be6f5 100644
> --- a/net/sunrpc/auth.c
> +++ b/net/sunrpc/auth.c
> @@ -861,11 +861,7 @@ rpcauth_uptodatecred(struct rpc_task *task)
>   		test_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags) != 0;
>   }
>   
> -static struct shrinker rpc_cred_shrinker = {
> -	.count_objects = rpcauth_cache_shrink_count,
> -	.scan_objects = rpcauth_cache_shrink_scan,
> -	.seeks = DEFAULT_SEEKS,
> -};
> +static struct shrinker *rpc_cred_shrinker;
>   
>   int __init rpcauth_init_module(void)
>   {
> @@ -874,9 +870,16 @@ int __init rpcauth_init_module(void)
>   	err = rpc_init_authunix();
>   	if (err < 0)
>   		goto out1;
> -	err = register_shrinker(&rpc_cred_shrinker, "sunrpc_cred");
> -	if (err < 0)
> +	rpc_cred_shrinker = shrinker_alloc(0, "sunrpc_cred");
> +	if (!rpc_cred_shrinker)

Here should set err to -ENOMEM, will fix.

>   		goto out2;
> +
> +	rpc_cred_shrinker->count_objects = rpcauth_cache_shrink_count;
> +	rpc_cred_shrinker->scan_objects = rpcauth_cache_shrink_scan;
> +	rpc_cred_shrinker->seeks = DEFAULT_SEEKS;
> +
> +	shrinker_register(rpc_cred_shrinker);
> +
>   	return 0;
>   out2:
>   	rpc_destroy_authunix();
> @@ -887,5 +890,5 @@ int __init rpcauth_init_module(void)
>   void rpcauth_remove_module(void)
>   {
>   	rpc_destroy_authunix();
> -	unregister_shrinker(&rpc_cred_shrinker);
> +	shrinker_free(rpc_cred_shrinker);
>   }
