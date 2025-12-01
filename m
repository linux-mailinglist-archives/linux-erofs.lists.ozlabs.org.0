Return-Path: <linux-erofs+bounces-1460-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1083EC9599A
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Dec 2025 03:41:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dKSpT0NZTz2ypW;
	Mon, 01 Dec 2025 13:41:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764556897;
	cv=none; b=llwLVd5MYsZwR5XyW6ys8DasdQCsiA3gpd1Kd5nFkFCSDcbdL2QKSzkjP/0VktahbpyQ0Rvw4yeJldnyNL2TPsciX47e7gVti029B2hhZ1syDvmKsadbXQ6rG6Id/OJCBIzeyfHZJ2pnpSCUm8y6wMfJOIRvTZu+8yrKvG6H20G2lCWqABjQaZKXTNidHiE2Hy5MbZCX2pBgdoQTVXSj0mgB+VsTUKAhIopEi7yQudM57IKnuuiXoQA2REyDlG4vWvAtqDwgnUesjTCjXGBny6lL4lKL053jI3ZTHlDeyfOUHD3/lPJ2ngGvkMjMLY7dU86AG07KaJB7H8QI8AhP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764556897; c=relaxed/relaxed;
	bh=IRV0SSnaKOp4bOmHFQSp0jfAZP/w8Kb5KU2roZRI6Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRAl9KIz2hmePFNQQ9vDerGnMOVTIWzWdnX+O3ACjNoJ7G6+5LDtfsi8lKnv3p4tDz8tsloFULHPh+GaNueAYguUe+y0M2pnuVyrEjpDcEKrM3vCMehPjTE/3uUAKvGtcuMQEsnMe/BHuKKrzbhMbzzmyo9AX+i/7YqYkKwos3JTlmfoa/2tTSbfs3OeM2k0D5IWPfjaGeXIQ6qsYTTobEk1iK1sN/t6QlNkEY7nqQEbCZQERtIDo02UGzanK170gwho3dcPdWJwUVOuRD25tWPLHRMiH/z+3ZmoP/ZYRcJrKeTcOKwuNKBFq5PNL4+ZHDNTIx/W3BzS5SMayzpLIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XxbUeOph; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XxbUeOph;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dKSpS0cXNz2yG3
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Dec 2025 13:41:35 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764556891; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IRV0SSnaKOp4bOmHFQSp0jfAZP/w8Kb5KU2roZRI6Y8=;
	b=XxbUeOphAE2rIkjVZVvNcvj2rzgDRuvAbqyCr2x13EaWcepgRCsngRhynaiLG0crMP4T5vDxHGnjn2C/gOZHxUvGcVAVIyj0oZZJwY0U7r6CHHjPLGE+CJRlmL1C1T75gfWIT17kwMH6EcGwXNX38ZLtj1MDu3sWU++5Iojz1rg=
Received: from 30.221.148.135(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Wtl.jsE_1764556890 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 01 Dec 2025 10:41:30 +0800
Message-ID: <ea1d91da-deb3-456c-adeb-09f16502b82c@linux.alibaba.com>
Date: Mon, 1 Dec 2025 10:41:29 +0800
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
Subject: Re: [PATCH] erofs: switch on-disk header `erofs_fs.h` to MIT license
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20251201023816.1045273-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20251201023816.1045273-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 12/1/25 10:38 AM, Gao Xiang wrote:
> Switch to the permissive MIT license to make the EROFS on-disk format
> more interoperable across various use cases.
> 
> It was previously recommended by the Composefs folks, for example:
> https://github.com/composefs/composefs/pull/216#discussion_r1356409501
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/erofs_fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 3d5738f80072..e24268acdd62 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
> +/* SPDX-License-Identifier: MIT */
>  /*
>   * EROFS (Enhanced ROM File System) on-disk format definition
>   *

Acked-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo


