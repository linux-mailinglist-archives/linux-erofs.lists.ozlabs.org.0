Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573AC9374C9
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jul 2024 10:13:32 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MK1iOIEH;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WQMrB09Wvz3cXG
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jul 2024 18:13:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MK1iOIEH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WQMr24XzNz3c4W
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jul 2024 18:13:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721376796; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WUAQ6Wh6dYXFdtkbtXGrEMeXdR1lUnBn9C2RHEfhJ+s=;
	b=MK1iOIEHOVcO6JDtzcItwDqYPiONb49/tl+Bo4rlnx6T84VR+IIgydQYDG2rONROXBxyNMonm9z0tgSYjQNvJpPhBEJnxnitLJaIOFjSHYrFkIVC/O4er+ejspTmbnzmbK7p35MQUJkQ4km3UfBDOK276SSLolJQ7QC3E0ks/QY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WArCsN7_1721376793;
Received: from 30.97.48.203(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WArCsN7_1721376793)
          by smtp.aliyun-inc.com;
          Fri, 19 Jul 2024 16:13:14 +0800
Message-ID: <b95acec7-8cc3-42e8-9e64-b8a919268cfe@linux.alibaba.com>
Date: Fri, 19 Jul 2024 16:13:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] erofs-utils: lib: add bitops header
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240718054025.427439-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240718054025.427439-1-hongzhen@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/18 13:40, Hongzhen Luo wrote:
> Add bitops header for subsequent bloom filter implementation.
> This is borrowed from a part of the previous patch. See:
> https://lore.kernel.org/all/20230802091750.74181-3-jefflexu@linux.alibaba.com/.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
>   include/erofs/bitops.h | 42 ++++++++++++++++++++++++++++++++++++++++++
>   lib/Makefile.am        |  1 +
>   2 files changed, 43 insertions(+)
>   create mode 100644 include/erofs/bitops.h
> 
> diff --git a/include/erofs/bitops.h b/include/erofs/bitops.h
> new file mode 100644
> index 0000000..ef60d6e
> --- /dev/null
> +++ b/include/erofs/bitops.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +#ifndef __EROFS_BITOPS_H
> +#define __EROFS_BITOPS_H
> +
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
> +#include "defs.h"
> +
> +struct bitmap {
> +	unsigned long size;	/* size of bitmap in bits */
> +	unsigned long *map;
> +};

What is the meaning of this structure, please just fold it into
the original structure.

> +
> +static inline void set_bit(int nr, volatile unsigned long *addr)

Since it's not atomic, please use __set_bit instead.

> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +
> +	*p  |= mask;
> +}
> +
> +static inline void clear_bit(int nr, volatile unsigned long *addr)

please use __clear_bit instead.

> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +
> +	*p &= ~mask;
> +}
> +
> +static inline int test_bit(int nr, const volatile unsigned long *addr)

please call it __test_bit instead, or use READ_ONCE to wrap it up.

Thanks,
Gao Xiang
