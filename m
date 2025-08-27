Return-Path: <linux-erofs+bounces-917-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B86CB37A35
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Aug 2025 08:14:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cBZ3n6V7zz30T8;
	Wed, 27 Aug 2025 16:13:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756275237;
	cv=none; b=jJ4ZukWdy9nQQ+1LfQg0JJY1nC79f69kHJGlvrXKNT60I9Z538DmScvCvPeYDneoMifa+PJcESEILo8CG4n/2B9dY9tY22kiyOmJqOgWSsyCqjJuH67bW9U8CcCTTVWGe7GpPTftL/KOOFNRuM7muOCloaumVdLeO3Nqs/rlXLj2E0ITGJ1nvD4gHrSr+fdKZtyIyB6GD6c3IA902VPNgwwQyKORwokIzlid3HPKgPU8oqsVqIFaGCDvcM4vu68wiPAPzRkC80ltd8H1Dt1/qabLrw9GjMG278Eb49BxlLRJu9bGAMl+6b3YF3O+rLBSEltGH5cHroTWcLq2EjvE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756275237; c=relaxed/relaxed;
	bh=NNtBnM1u667mdYrai0Gwo/QfDoTbrmLRHpVdeB+wPEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIS/i4HWWzDRNaQT5VBllV7uQfYaGmflMLIUDTB9TKduVrtz1NqcaiXFJxheH7T/1tuD3mS5SOkWGPr0O96GQby/vi6ncC6dwGaZC6vVVEiAnXRvIq4U7o1lbOk4d4QJOJITtRLhuCaOLCQCS1EOe7EquKW0YxR6TtmclSo1//YJFo7ZvKlkVY5zog+trZWZ9WGwivNaOQvdAdw3pqC9iSAS4l99/MJnbanux0du1u0WzoC6pmXYAInzZ9SBXdPdW1QqogbQcgWMyK0p1gbSpoQhy2u8d47Lb7v62XepmzdnTxMVoG2vQwyLeIMkivYtxcdOQ1yBQun0DB7F1yuABw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ShblO1aS; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ShblO1aS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cBZ3n0JJjz2yDH
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 Aug 2025 16:13:56 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756275233; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NNtBnM1u667mdYrai0Gwo/QfDoTbrmLRHpVdeB+wPEY=;
	b=ShblO1aSkuUlP2wnKIHihDUGTi3coQgK+IibJ77kmxH1NHZSfjb8sglnoQqyXr/B1qzmnuHGDBPkfl9zGC/BroieFlgtapP/ry3Q/luUrmRNbRSxu2vVKjZYWnEZmzyVDqlA7VadvVLs+WGlTARh1uku4WwwEaIA6iNFAnrU2Y0=
Received: from 30.221.131.253(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmhqsUT_1756275229 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Aug 2025 14:13:49 +0800
Message-ID: <bee2ac5b-7543-4dfc-8f94-69fe2bc632b8@linux.alibaba.com>
Date: Wed, 27 Aug 2025 14:13:48 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: rename `fallthrough` to
 `erofs_fallthrough`
To: Noboru Asai <asai@sijam.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org
References: <20250827060902.207447-1-asai@sijam.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250827060902.207447-1-asai@sijam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Noboru,

On 2025/8/27 14:09, Noboru Asai wrote:
> In order to fix compile errors with libxxhash,
> since `fallthrough` is used in xxhash.h.
> 
> Signed-off-by: Noboru Asai <asai@sijam.com>
> ---
>   include/erofs/defs.h | 4 ++--
>   lib/namei.c          | 2 +-
>   lib/rebuild.c        | 2 +-
>   lib/zmap.c           | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
> index 0f3e754..b705149 100644
> --- a/include/erofs/defs.h
> +++ b/include/erofs/defs.h
> @@ -370,9 +370,9 @@ unsigned long __roundup_pow_of_two(unsigned long n)
>   #define __erofs_unlikely(x)    __builtin_expect(!!(x), 0)
>   
>   #if __has_attribute(__fallthrough__)
> -# define fallthrough	__attribute__((__fallthrough__))
> +# define erofs_fallthrough	__attribute__((__fallthrough__))
>   #else
> -# define fallthrough	do {} while (0)  /* fallthrough */
> +# define erofs_fallthrough	do {} while (0)  /* fallthrough */

Thanks for the patch!

How about using __erofs_fallthrough; for internal macros?

Thanks,
Gao Xiang


