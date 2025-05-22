Return-Path: <linux-erofs+bounces-360-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E40AC0830
	for <lists+linux-erofs@lfdr.de>; Thu, 22 May 2025 11:06:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b32V31LXbz3c3w;
	Thu, 22 May 2025 19:06:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747904811;
	cv=none; b=TVqLVLB6G8NJMPDz8qOOT2HqYFR3CcZBoRYKmvPVDqkm2UqA/1Xes2ZAIttMl9u7PTsdzZeUmC6Q84TQ6QGyl2kV19cwb7NkBMwtIl+b+iDEqlzkvv5x87TaFh4Vih1n14qZLUaJ5rWrabulhkZ/MGa1a77NNx2WHhgGhOBgTv5bFGiO1OQW4vvT+biLx4U5fKzKE24lVQyvz3HEvQZyNhpSIXQK3B6NGuRrbhnrXdvbRYUv4EibyGfF+1fn89fH5siu35lI3TP4CAZpp0uKQZsbw5b7Tjwpl6JyWST6ELZFoCN6GnEEB11zsu1rS0SGcCM/W+xZwn50A8rvshA15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747904811; c=relaxed/relaxed;
	bh=N8CSzgH6h+Lund+UV8UvMsQfx9po2OnLfKYLiT27LHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJ/7bXjKkbZuV84Tv1wix5+Ppyk1rGxmKdWHHGzoVKwdkq6iW6B//eOIPVvBWr2rXQf5lnQMVkb4T6H5XnRpBGMMAm9y8auZnHNGU9bEVbYNljl5ZB1+/OyQabYPUEj5+zz89/AvwPC3VxpPaqGGMxUfibDxh+ChL1zCvXczK2GkPnGMqNX5mZcluopUeaZ6ULIh3XPmETqKS+qGGiF+lVV8r6m4kX5DmOO2KO2RK3TjshaVx0kybf182PjuxqqeSyWfLik4S/UwKBXI2l1Uzq3Gvw5wpmD/mi1N8P2zlvk+ann0X58gm9XtNSB6fMK1aa+0DPT3MUNDFDsXPlq+Rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=m4fu4He2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=m4fu4He2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b32V12qDFz2ySc
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 May 2025 19:06:47 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747904803; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=N8CSzgH6h+Lund+UV8UvMsQfx9po2OnLfKYLiT27LHY=;
	b=m4fu4He2tCP+UzgM/ex+P/aG6HImZMgJYc9volrg6Z//9HvNx2Mn02qwRXUBcQxY7Lg6U9cn2cQnsyG0LH4O10pZ9qDzDoKP5muq/R3JUOQiMMgvzM/0XUor6lsZo9idZqNOSDUerBDbdMSEZ6RFvhmzQPVA+e81U/stCpxbiJI=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WbVLUK3_1747904796 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 May 2025 17:06:41 +0800
Message-ID: <7fa71441-a5b0-40aa-aee8-8f251ea96f75@linux.alibaba.com>
Date: Thu, 22 May 2025 17:06:35 +0800
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
Subject: Re: [PATCH v8] erofs: support deflate decompress by using Intel QAT
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250522084700.21354-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250522084700.21354-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/22 16:47, Bo Liu wrote:

...

> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> index b134146d735b..4d024f043ea1 100644
> --- a/Documentation/ABI/testing/sysfs-fs-erofs
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -27,3 +27,12 @@ Description:	Writing to this will drop compression-related caches,
>   		- 1 : invalidate cached compressed folios
>   		- 2 : drop in-memory pclusters
>   		- 3 : drop in-memory pclusters and cached compressed folios
> +
> +What:		/sys/fs/erofs/accel
> +Date:		May 2025
> +Contact:	"Bo Liu" <liubo03@inspur.com>
> +Description:	Used to set or show hardware accelerators in effect
> +		and multiple accelerators are separated by '\n'.
> +		Supported accelerator(s): qat_deflate.
> +		Disable all accelerators with an empty string (echo > accel).
> +

redundent new line.

...

> diff --git a/fs/erofs/decompressor_crypto.c b/fs/erofs/decompressor_crypto.c
> new file mode 100644
> index 000000000000..f4891d335792
> --- /dev/null
> +++ b/fs/erofs/decompressor_crypto.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/scatterlist.h>
> +#include <crypto/acompress.h>
> +
> +#include "compress.h"
> +
> +static int __z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
> +				struct crypto_acomp *tfm)

Please check your tab setting (should be 8 spaces) and
rework it on my v4.

> +{

...

> +
> +int z_erofs_crypto_show_engines(char *buf, int size, char sep)
> +{
> +	struct z_erofs_crypto_engine *e;
> +	int alg, len = 0;
> +
> +	for (alg = 0; alg < Z_EROFS_COMPRESSION_MAX; ++alg) {
> +		for (e = z_erofs_crypto[alg]; e->crypto_name; ++e) {
> +			if (!e->tfm)
> +				continue;
> +			len += scnprintf(buf + len, size - len, "%s%c",
> +					 e->crypto_name, sep);
> +		}
> +	}
> +	return len;
> +}
> +

redundent new line.

Thanks,
Gao Xiang

> diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
> index c6908a487054..e4c9df9d7978 100644
> --- a/fs/erofs/decompressor_deflate.c
> +++ b/fs/erofs/decompressor_deflate.c

