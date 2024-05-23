Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7048CCDFF
	for <lists+linux-erofs@lfdr.de>; Thu, 23 May 2024 10:11:57 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iuIKjX5h;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VlLN13Dm2z79QS
	for <lists+linux-erofs@lfdr.de>; Thu, 23 May 2024 18:06:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iuIKjX5h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VlLML01f2z799L
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 May 2024 18:05:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716451528; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jdcK8SjzH/UlsmMBuOk0eiR/pi8S0wZRTF8hadYQX/s=;
	b=iuIKjX5hgq6rUCnF2fuP4v9CQaOD6hPdW9rkWHexrEOJjhr+KzsOBeCkAd42y3dd/gGvg3ocCKO3FQDaP0K7BhpaZRxS4YhVW5N/DU/CFJXM9mhasHADAf4LHfbDsZAjT7qJc5W0o+3plW3Zf1AdPTBUSWA8f9gKpZpQlezBx00=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W727hSr_1716451526;
Received: from 30.97.48.194(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W727hSr_1716451526)
          by smtp.aliyun-inc.com;
          Thu, 23 May 2024 16:05:27 +0800
Message-ID: <cd255c91-ba26-49de-9df6-21306acaad64@linux.alibaba.com>
Date: Thu, 23 May 2024 16:05:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: support building static library
To: ComixHe <heyuming@deepin.org>
References: <43DE50371629F5AE+20240523073104.54391-1-heyuming@deepin.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <43DE50371629F5AE+20240523073104.54391-1-heyuming@deepin.org>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Comix!

On 2024/5/23 15:31, ComixHe wrote:
> In some cases, developer may need to integrate erofs-utils into their
> proejct as a static library to reduce package dependencies and
> have more finer control over the feature used by the project.

Thanks for sharing this.

> 
> For exapmle, squashfuse provides a static library `libsquashfuse.a` and
> exposes some useful functions, Appimage uses this static library to build
> image. It could ensure that the executable image can be executed directly
> on most linux platforms and the user doesn't need to install squashfuse
> in order to execute the image.
> 
> Signed-off-by: ComixHe <heyuming@deepin.org>
> ---
>   configure.ac     | 28 ++++++++++++++++++++++++++++
>   dump/Makefile.am | 10 ++++++++++
>   fsck/Makefile.am | 10 ++++++++++
>   fuse/Makefile.am | 10 ++++++++++
>   mkfs/Makefile.am | 10 ++++++++++
>   5 files changed, 68 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 1989bca..16ddb7c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -147,6 +147,30 @@ AC_ARG_ENABLE(fuse,
>      [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
>      [enable_fuse="$enableval"], [enable_fuse="no"])
>   
> +AC_ARG_ENABLE([static-fuse],
> +    [AS_HELP_STRING([--enable-static-fuse],
> +                    [build erofsfuse as a static library @<:@default=no@:>@])],
> +    [enable_static_fuse="$enableval"],
> +    [enable_static_fuse="no"])
> +
> +AC_ARG_ENABLE([static-dump],
> +    [AS_HELP_STRING([--enable-static-dump],
> +                    [build dump.erofs as a static library @<:@default=no@:>@])],
> +    [enable_static_dump="$enableval"],
> +    [enable_static_dump="no"])
> +
> +AC_ARG_ENABLE([static-mkfs],
> +    [AS_HELP_STRING([--enable-static-mkfs],
> +                    [build mkfs.erofs as a static library @<:@default=no@:>@])],
> +    [enable_static_mkfs="$enableval"],
> +    [enable_static_mkfs="no"])
> +
> +AC_ARG_ENABLE([static-fsck],
> +    [AS_HELP_STRING([--enable-static-fsck],
> +                    [build fsck.erofs as a static library @<:@default=no@:>@])],
> +    [enable_static_fsck="$enableval"],
> +    [enable_static_fsck="no"])

But how could we support static libraries from binaries?

I guess you need static liberofs instead?

Thanks,
Gao Xiang
