Return-Path: <linux-erofs+bounces-889-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D516B327E7
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Aug 2025 11:14:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c8BFh4k89z3dDJ;
	Sat, 23 Aug 2025 19:14:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755940456;
	cv=none; b=KLo7lqmNaMxs7egNZWg02hNrAF0wJ1XnrmMp36am4pEsacvBG/uDuxtmZSXYzLQIs8/3LVUOQM+mfIKyy+Ybw0q4Vdm805UKDfaCARr3S6BpceVVZ0OjndwW/LtX1owM9mL/hQniZ/N0KlOkcj87s9Eoa4xRPrZJJ2jx0EmynFzSjsd1VE1v2UEqtwSwGG1+jL9ouiNM5XOsHxz6q/z+jQQXYAEmOc22E0MGml9AHS3VCYtMR823anzPRDouCYL82DTfWHWd2chnPkl4zDYBFE6qrgwgypsoepI3Wf61YDPabNmwUb5mrsaYWU1B/ExAiAhoAXs3hjFAtyy02vcp+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755940456; c=relaxed/relaxed;
	bh=jcHExl5YB9j9892D+WCCf80J/1I4+TfGjV16131nytg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYWmiDlSh5cL+/csYoOGdldIWzFdPGwsYJrJF+f+l53wIvSfxgib1byD/1w3AntvDpU9Cz4HdY06IlQ3oMhpyicJB08Zlc/UOfzvvxqJ96u1aMm7EPHmCHm3R+L/xL7RmrhatSpPzLtwd4EPJEB6uRSvWXdR2XqAyK9UQcIiLrvqprcOZQl7GKuBekKMO6C137KPNoi0WIvxwd/bMn7PNtW9si+XLRX377JYx6hzNuvRzx5Sqd2u0undTeS5K6cAGlROmeyiCskxu2K2jSrC5KrvwU26u4zHeYuTPj0ysggMh381VgaZzP8J3wcHX4/X1AdcAs4hBWE78u/l///ixQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vJKfHLzX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vJKfHLzX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c8BFf4wQtz3d9t
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Aug 2025 19:14:13 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755940449; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jcHExl5YB9j9892D+WCCf80J/1I4+TfGjV16131nytg=;
	b=vJKfHLzXjD4ClraHMA70lZuRwP5eXQEwTIiJk59GaM2wEozm/Wqd6hg1ZhXYr9uhCdJukDkFphdl7H/rYrAflOb4r890lkaeDa5e15Qg9OngJRbfSXM19FItShyzHmn03j3/nXW7/KYtxpB7ewiq+Zot/wBGoOt3nwUI/RI+yYw=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmLopdJ_1755940446 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 23 Aug 2025 17:14:07 +0800
Message-ID: <d1426b16-f5df-4587-813b-a244b4debc84@linux.alibaba.com>
Date: Sat, 23 Aug 2025 17:14:06 +0800
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
Subject: Re: [PATCH v3] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
To: Friendy Su <friendy.su@sony.com>, linux-erofs@lists.ozlabs.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>, Daniel Palmer <daniel.palmer@sony.com>
References: <20250823083453.249576-1-friendy.su@sony.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250823083453.249576-1-friendy.su@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/23 16:34, Friendy Su wrote:
> Set proper 'dsunit' to let file body align on huge page on blobdev,
> 
> where 'dsunit' * 'blocksize' = huge page size (2M).
> 
> When do mmap() a file mounted with dax=always, aligning on huge page
> makes kernel map huge page(2M) per page fault exception, compared with
> mapping normal page(4K) per page fault.
> 
> This greatly improves mmap() performance by reducing times of page
> fault being triggered.
> 
> Considering deduplication, 'chunksize' should not be smaller than
> 'dsunit', then after dedupliation, still align on dsunit.
> 
> Signed-off-by: Friendy Su <friendy.su@sony.com>
> Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
> ---
>   lib/blobchunk.c  | 18 ++++++++++++++++++
>   man/mkfs.erofs.1 | 15 +++++++++++++++
>   mkfs/main.c      | 12 ++++++++++++
>   3 files changed, 45 insertions(+)
> 
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index bbc69cf..69c70e9 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -309,6 +309,24 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
>   	minextblks = BLK_ROUND_UP(sbi, inode->i_size);
>   	interval_start = 0;
>   
> +	/*
> +	 * dsunit <= chunksize, deduplication will not cause unalignment,
> +	 * we can do align with confidence
> +	 */
> +	if (sbi->bmgr->dsunit > 1 &&
> +	    sbi->bmgr->dsunit <= 1u << (chunkbits - sbi->blkszbits)) {

Sigh, I meant (sbi->bmgr->dsunit >= 1u << (chunkbits - sbi->blkszbits))

Let's ignore sbi->bmgr->dsunit < 1u << (chunkbits - sbi->blkszbits).

Thanks,
Gao Xiang

