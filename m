Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3FF8FE0A5
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 10:11:10 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gaZZh2O/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VvxqH2JPVz3d9t
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 18:11:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gaZZh2O/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vvxq60Lvxz3cyd
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jun 2024 18:10:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717661453; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9zY6F6dImF/etY0wWv/u+Vy6VO20JzjAaThufS5Hi5w=;
	b=gaZZh2O/gq0wvSJ++LIVcsdNgCwBZq0KajbVI8JV886nwYBZfb7xQ1oCX89I8oYACDsR4cg6SQyVIy1Rp6/vQej3xGVRe8h+hq7pR3xKvoMHn8GKQasYVjZ+Nt5UAlUZEYKNbJtgUfgI6NhzYQHg9V2gtDJ4bFrozNkkMbrnxf8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W7xWQ90_1717661450;
Received: from 30.97.48.170(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7xWQ90_1717661450)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 16:10:52 +0800
Message-ID: <6e382603-7bb6-4b49-87e5-59d6f7c4dc5d@linux.alibaba.com>
Date: Thu, 6 Jun 2024 16:10:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: support external crypto for decompression
To: tao.zeng@amlogic.com, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
References: <20240606-erofs-decompression-v1-1-ec5f31396e04@amlogic.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240606-erofs-decompression-v1-1-ec5f31396e04@amlogic.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On 2024/6/6 15:53, Tao Zeng via B4 Relay wrote:
> From: Tao Zeng <tao.zeng@amlogic.com>
> 
> Some SoCs have hardware decompressors which using private algorithms,
> which can be used for accelerating decompression for EROFS, but
> current EROFS decompressor architecture do not support external
> decompressors, this change adds a crypto layer interface for decompression
> and can be used to hook SoC vendor's decompressor by crypto name. Soc
> vendors can develop their own code which can be added to crypto layer.

There are several fundamental points with this stuff.

First, I think using crypto APIs to support hardware accelerators
_may_ be fine (I also plan to use crypto APIs for Intel IAA
accelerator), as long as you contribute your SoC accelerator
implementation upstream.

Using crypto APIs for out-of-tree external drivers as workaround
doesn't work on my side (or I guess the whole Linux project).

> 
> Signed-off-by: Tao Zeng <tao.zeng@amlogic.com>
> ---
>   fs/erofs/Kconfig                |  19 +++
>   fs/erofs/Makefile               |   1 +
>   fs/erofs/compress.h             |  28 ++++
>   fs/erofs/decompressor.c         |   7 +
>   fs/erofs/decompressor_cryptor.c | 306 ++++++++++++++++++++++++++++++++++++++++
>   fs/erofs/erofs_fs.h             |  14 ++
>   fs/erofs/internal.h             |   4 +
>   fs/erofs/super.c                |   8 +-
>   8 files changed, 386 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 7dcdce660cac..72e29041244b 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -127,6 +127,25 @@ config EROFS_FS_ZIP_ZSTD
>   
>   	  If unsure, say N.
>   
> +config EROFS_FS_ZIP_CRYPTO
> +	bool "EROFS external crypto decompress support"

	bool "EROFS crypto decompressor support"

> +	depends on EROFS_FS_ZIP
> +	help
> +	  Saying Y here to support external crypto for decompressing EROFS
> +	  file systems. Some SoCs have hardware decompressor with private
> +	  algorithm, which can be used for accelarating decompression of

	Sorry upstream Linux doesn't support private out-of-tree algorithms.

> +	  EROFS. This config enables external cryptos.

	help
	  Saying Y here to use specific crypto decompressors to decompress
	  EROFS file systems instead of software implementation, which can
	  be used for offloading asynchronous requests to accelerators.

	  If unsure, say N.

> +
> +	  If unsure, say N.
> +
> +config EROFS_CRYPTO_MAX_DISTANCE_PAGES
> +	int "EROFS max distance pages for crypto usage"
> +	default 32
> +	help
> +	  This config defines max distance pages for external crypto. Crypto
> +	  layer will use this value to grow up PCP buffers.
> +	  The default value is 128KB(32 pages).

No, I don't think it's of any use for accelerators.

> +
>   config EROFS_FS_ONDEMAND
>   	bool "EROFS fscache-based on-demand read support"
>   	depends on EROFS_FS
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 097d672e6b14..d2dc5e2d20bd 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -7,4 +7,5 @@ erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
> +erofs-$(CONFIG_EROFS_FS_ZIP_CRYPTO) += decompressor_cryptor.o
>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
> diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
> index 19d53c30c8af..8236775563a5 100644
> --- a/fs/erofs/compress.h
> +++ b/fs/erofs/compress.h
> @@ -98,4 +98,32 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
>   			       struct page **pagepool);
>   int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
>   			    struct page **pgpl);
> +
> +#ifdef CONFIG_EROFS_FS_ZIP_CRYPTO
> +/* for external cryto decompress */
> +int z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
> +			      struct page **pagepool);
> +int z_erofs_load_crypto_config(struct super_block *sb,
> +			       struct erofs_super_block *dsb,
> +			       void *data, int size);
> +#else
> +static inline int z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
> +					    struct page **pagepool)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int z_erofs_load_crypto_config(struct super_block *sb,
> +					     struct erofs_super_block *dsb,
> +					     void *data,
> +					     int size);
> +{
> +	if (crypto) {
> +		erofs_err(sb, "crypto algorithm isn't enabled");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +#endif
> +
>   #endif
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 9d85b6c11c6b..83fde9e974e3 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -406,6 +406,13 @@ const struct z_erofs_decompressor erofs_decompressors[] = {
>   		.name = "zstd"
>   	},
>   #endif
> +#ifdef CONFIG_EROFS_FS_ZIP_CRYPTO
> +	[Z_EROFS_COMPRESSION_CRYPTO] = {
> +		.config = z_erofs_load_crypto_config,
> +		.decompress = z_erofs_crypto_decompress,
> +		.name = "crypto"
> +	},
> +#endif
>   };
>   
>   int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
> diff --git a/fs/erofs/decompressor_cryptor.c b/fs/erofs/decompressor_cryptor.c
> new file mode 100644
> index 000000000000..87df4d285ad1
> --- /dev/null
> +++ b/fs/erofs/decompressor_cryptor.c
> @@ -0,0 +1,306 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
> + */
> +#include <linux/types.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/highmem.h>
> +#include <linux/xz.h>
> +#include <linux/module.h>
> +#include <linux/crypto.h>
> +#include "compress.h"
> +#include "internal.h"
> +
> +static int crypto_max_distance_pages;
> +
> +int z_erofs_load_crypto_config(struct super_block *sb,
> +			       struct erofs_super_block *dsb,
> +			       void *data, int size)
> +{
> +	struct erofs_sb_info *sbi;
> +	struct z_erofs_crypto_cfgs *crypto = (struct z_erofs_crypto_cfgs *)data;
> +	int max_pages;
> +
> +	sbi = EROFS_SB(sb);
> +	if (!sbi)
> +		return -EINVAL;
> +
> +	if (sbi->crypto) {
> +		erofs_err(sb, "already have crypto\n");
> +		return -EINVAL;
> +	}
> +	if (crypto) {
> +		max_pages = BIT(crypto->max_distance) / PAGE_SIZE;
> +		if (max_pages > CONFIG_EROFS_CRYPTO_MAX_DISTANCE_PAGES) {
> +			erofs_err(sb, "bad max distance:%d\n", max_pages);
> +			return -EINVAL;
> +		}
> +
> +		if (max_pages > crypto_max_distance_pages)
> +			crypto_max_distance_pages = max_pages;
> +		sbi->crypto = crypto_alloc_comp(crypto->crypto_name, 0, 0);
> +		if (IS_ERR(sbi->crypto)) {
> +			erofs_err(sb, "failed to alloc cryto %s\n",
> +				  crypto->crypto_name);
> +			return PTR_ERR(sbi->crypto);
> +		}
> +		erofs_info(sb, "max pcluster:%d, distance:%d, %d, crypto:%s\n",
> +			   crypto->max_pclusterblks,
> +			   crypto->max_distance, crypto_max_distance_pages,
> +			   crypto->crypto_name);
> +		return z_erofs_gbuf_growsize(crypto_max_distance_pages);

That is optimized for LZ4,  I don't think it's useful for hardware accelerators.


> +	} else {
> +		return -EINVAL;
> +	}
> +}
> +
> +static void *z_erofs_crypto_handle_inplace_io(struct z_erofs_decompress_req *rq,
> +					      void *inpage,
> +					      unsigned int *inputmargin,
> +					      int *maptype,
> +					      bool support_0padding)
> +{
> +	unsigned int nrpages_in, nrpages_out;

...


Same here.

> +	return src;
> +}
> +
> +static int z_erofs_crypto_decompress_mem(struct z_erofs_decompress_req *rq, u8 *out)
> +{

..
Same here.

> +	return ret;
> +}
> +
> +/*
> + * Fill all gaps with bounce pages if it's a sparse page list. Also check if
> + * all physical pages are consecutive, which can be seen for moderate CR.
> + */
> +static int z_erofs_crypto_prepare_dstpages(struct z_erofs_decompress_req *rq,
> +					   struct page **pagepool)
> +{


..
Same here.


> +	}
> +	return kaddr ? 1 : 0;
> +}
> +

...

> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 6c0c270c42e1..993b7a1b656f 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -297,6 +297,10 @@ enum {
>   	Z_EROFS_COMPRESSION_LZMA	= 1,
>   	Z_EROFS_COMPRESSION_DEFLATE	= 2,
>   	Z_EROFS_COMPRESSION_ZSTD	= 3,
> +#ifdef CONFIG_EROFS_FS_ZIP_CRYPTO
> +	/* for generic crypto framework */
> +	Z_EROFS_COMPRESSION_CRYPTO	= 4,
> +#endif

crypto is NOT a new algorithm, please maintain a mapping
(crypto decompressor <-> algorithm) with existing algrithms.

>   	Z_EROFS_COMPRESSION_MAX
>   };
>   #define Z_EROFS_ALL_COMPR_ALGS		((1 << Z_EROFS_COMPRESSION_MAX) - 1)
> @@ -330,6 +334,16 @@ struct z_erofs_zstd_cfgs {
>   	u8 reserved[4];
>   } __packed;
>   
> +#ifdef CONFIG_EROFS_FS_ZIP_CRYPTO
> +/* 16 bytes */
> +struct z_erofs_crypto_cfgs {
> +	char   crypto_name[8];
> +	__le16 max_distance;
> +	__le16 max_pclusterblks;
> +	u8     reserved[4];
> +} __packed;
> +#endif

Same here, no needed.

Thanks,
Gao Xiang
