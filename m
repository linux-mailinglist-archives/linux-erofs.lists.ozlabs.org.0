Return-Path: <linux-erofs+bounces-233-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040E1A9BCBB
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Apr 2025 04:19:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZkGkR48wZz2yQJ;
	Fri, 25 Apr 2025 12:19:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745547567;
	cv=none; b=l2r7Syh3Odar6VtV3cQaKKbAbUCX48fZVcYVzHvm2maMlOfRLXLkLx8OD6nxAdQM3WJtet0tarw8w/Em+0j4wCf0xB1IXjAxt8EB3AKcTbyscKcc/FgVhSFeGcT8R3sCxmFJVs9BsmNmH25Q8pFYyNbpkDiXvnZ5xpvwvrSvf5r4bQePOwxi1rGEs82X/RvsGG36pgXdHUsBZpm9QeorquCRwGSduOqBz875eoSvBa5F4PKxcgz6fDWTrjoGZCT2kvavSd6dMN8TzLCx+wL6zXhS5tQOd/9N34z9mP4bkMSS2IRAqPf2qRLG0OGyh2ZQY7c8gNxKF1uMre1Q0Kbe/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745547567; c=relaxed/relaxed;
	bh=nOlpOq7hrvJWxEePynaJz58a5eZhLR8qTWp66NWvJvY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jRRK+IFTHoTEiIBstxpXasjk6S3LBDLQBDX/yhdFhHdL5lCTzX1jYOBioHmaB7r2VsnI/UJaXL03lqzYC8pWd0AmzGBKUBtQzq7+WAG5pbyHEQsfesWkFRmd2VIa/3nEWXK3lamyAT46Rxh6N5njK5faIJN4G1elTM83UiQylxMLeMs1hbtc1dOtcjWGXlEa/KgLcICls9CVqlg4GzaW+wXSOziNo/QfyiGoqsUaNbqPbANI29sZVtOohK/vhZxkv2dXtPJB3ap2YEpcXKXcpkhgP3SdWQdvOERG9iPu6fCiugqW2VG2/uGcPm4zEByzhqA/NxpyPksbtZr8y6K1Lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Id82FmGS; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Id82FmGS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZkGkQ6s2jz2y8t
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Apr 2025 12:19:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4D7005C565C;
	Fri, 25 Apr 2025 02:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AD0C4CEE3;
	Fri, 25 Apr 2025 02:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745547564;
	bh=D3m7qL1UU5oxx2HKR2qPUQh0EXxSExFwEK7uyQNho90=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Id82FmGSTee/K0fqbKXLy0lTRJBK78+6/TS/74IOF/FJ88foBG79MFK7M2dSH7MGW
	 ZQ6YQRXK/9KDgmp2xo+33T8gL8YfisDLdFSFSXr+SI0Y2RcYzXc6zECGg4Ye4MRHfl
	 ZiCHyPSqarP3TTgz+sH53Hr+vjo8zTbz+OPE6NAVRaiOIACPXg/CY0cKwdPbhloSEO
	 +3rKdr+iU+2388BClBmv6nbjsrLY8tG9g+uJz+lPDKAGva9YD0pvePQluEI2tygsqL
	 nlFOBhlaHRer4oQ6epw0Kca+xDE41pbmer+dSI+ZisiQLRsRuPFgnuv05DzXKzCxmv
	 0mLNcJB+JkhLQ==
Message-ID: <b6e395c8-207b-4b52-bd52-42e54bb9b902@kernel.org>
Date: Fri, 25 Apr 2025 10:19:20 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, dhavale@google.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, huyue2@coolpad.com,
 jefflexu@linux.alibaba.com
References: <20250424030653.3308358-1-lihongbo22@huawei.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250424030653.3308358-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 4/24/25 11:06, Hongbo Li wrote:
> I have a solid background in file systems and since much of my
> recent work has focused on EROFS, I am familiar with it. Now I
> have the time and am willing to help review EROFS patches.
> 
> I hope my participation can be helpful to the EROFS patch review
> process.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Cool, glad to hear the good news!

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa1e04e87d1d..f286c96ea7db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8719,6 +8719,7 @@ M:	Chao Yu <chao@kernel.org>
>  R:	Yue Hu <zbestahu@gmail.com>
>  R:	Jeffle Xu <jefflexu@linux.alibaba.com>
>  R:	Sandeep Dhavale <dhavale@google.com>
> +R:	Hongbo Li <lihongbo22@huawei.com>
>  L:	linux-erofs@lists.ozlabs.org
>  S:	Maintained
>  W:	https://erofs.docs.kernel.org


