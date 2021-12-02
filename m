Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F4F46670F
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Dec 2021 16:46:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J4gKv27RSz2ywd
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Dec 2021 02:46:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1638459987;
	bh=8C8/iOf/QGZFrlbVfrNfVJwUS5L3GTL8Kpe5efrAg30=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=bEulRvjtPNCCnv0ClzeG/wYFcCCN/yuU2ZMoZXchWaVJVEdwEuMX4VCWlmO6zrSBc
	 nLPFyIqLKJGrmoTtt0ObjUr8+HgiWJPbkSK4OQXKsiF91HkWQRyBS8o/GhVNzgmZBS
	 to4hte4InFPbzxypzOpPf0zmY1nkOAD7+leZ5ZVJV+SnlB+5eX6/Rsh1+b3pXzpvRJ
	 jEAMVvYCNMoK4f00KKWeU4GHy68tomgwyC8g1Y/jjrOZ8Q7hAvKmG2hSu0KFq3YXVW
	 snHRpqrE6Ayd6zXptiU+YioNZpC7C3EdJYuUehfibP0PKN9RtQoGUIluGT2Xm57XyX
	 W3FzLadENpnBg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.5;
 helo=out30-5.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=dIg43bpB; dkim-atps=neutral
X-Greylist: delayed 307 seconds by postgrey-1.36 at boromir;
 Fri, 03 Dec 2021 02:46:20 AEDT
Received: from out30-5.freemail.mail.aliyun.com
 (out30-5.freemail.mail.aliyun.com [115.124.30.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J4gKm30Mvz2ync
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Dec 2021 02:46:19 +1100 (AEDT)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07357798|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00652471-0.00123404-0.992241;
 FP=13146506834483517361|2|2|3|0|-1|-1|-1; HT=e01e04423;
 MF=bluce.lee@aliyun.com; NM=1; PH=DS; RN=3; RT=3; SR=0;
 TI=SMTPD_---0UzBdB-T_1638459653; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UzBdB-T_1638459653) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 02 Dec 2021 23:40:54 +0800
Message-ID: <3e6371af-dc95-59f6-7c1b-30b4ad5fc527@aliyun.com>
Date: Thu, 2 Dec 2021 23:41:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] erofs-utils: add Apache 2.0 license
To: Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org,
 hsiangkao@linux.alibaba.com
References: <Yaeq51nipFpzhD7r@B-P7TQMD6M-0146.local>
 <20211202022521.4291-1-huangjianan@oppo.com>
In-Reply-To: <20211202022521.4291-1-huangjianan@oppo.com>
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
From: Li Guifu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li Guifu <bluce.lee@aliyun.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> Let's release liberofs under GPL-2.0+ OR Apache-2.0 license for
> better integration.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

Acked-by: Li Guifu <bluce.lee@aliyun.com>

Thanks,
Li Guifu

> ---
>   include/erofs/blobchunk.h      | 2 +-
>   include/erofs/block_list.h     | 2 +-
>   include/erofs/cache.h          | 2 +-
>   include/erofs/compress.h       | 2 +-
>   include/erofs/compress_hints.h | 2 +-
>   include/erofs/config.h         | 2 +-
>   include/erofs/decompress.h     | 2 +-
>   include/erofs/defs.h           | 2 +-
>   include/erofs/err.h            | 2 +-
>   include/erofs/exclude.h        | 2 +-
>   include/erofs/inode.h          | 2 +-
>   include/erofs/internal.h       | 2 +-
>   include/erofs/io.h             | 2 +-
>   include/erofs/list.h           | 2 +-
>   include/erofs/print.h          | 2 +-
>   include/erofs/trace.h          | 2 +-
>   include/erofs/xattr.h          | 2 +-
>   lib/Makefile.am                | 2 +-
>   lib/blobchunk.c                | 2 +-
>   lib/block_list.c               | 2 +-
>   lib/cache.c                    | 2 +-
>   lib/compress.c                 | 2 +-
>   lib/compress_hints.c           | 2 +-
>   lib/compressor.c               | 2 +-
>   lib/compressor.h               | 2 +-
>   lib/compressor_liblzma.c       | 2 +-
>   lib/compressor_lz4.c           | 2 +-
>   lib/compressor_lz4hc.c         | 2 +-
>   lib/config.c                   | 2 +-
>   lib/data.c                     | 2 +-
>   lib/decompress.c               | 2 +-
>   lib/exclude.c                  | 2 +-
>   lib/inode.c                    | 2 +-
>   lib/io.c                       | 2 +-
>   lib/namei.c                    | 2 +-
>   lib/super.c                    | 2 +-
>   lib/xattr.c                    | 2 +-
>   lib/zmap.c                     | 2 +-
>   38 files changed, 38 insertions(+), 38 deletions(-)
> 
> diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
> index 4e1ae79..49cb7bf 100644
> --- a/include/erofs/blobchunk.h
> +++ b/include/erofs/blobchunk.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * erofs-utils/lib/blobchunk.h
>    *
> diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
> index ca8053e..78fab44 100644
> --- a/include/erofs/block_list.h
> +++ b/include/erofs/block_list.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * Copyright (C), 2021, Coolpad Group Limited.
>    * Created by Yue Hu <huyue2@yulong.com>
> diff --git a/include/erofs/cache.h b/include/erofs/cache.h
> index 7957ee5..de12399 100644
> --- a/include/erofs/cache.h
> +++ b/include/erofs/cache.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * Copyright (C) 2018 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/compress.h b/include/erofs/compress.h
> index fdbf5ff..21eac57 100644
> --- a/include/erofs/compress.h
> +++ b/include/erofs/compress.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * Copyright (C) 2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/compress_hints.h b/include/erofs/compress_hints.h
> index 43f80e1..659c5b6 100644
> --- a/include/erofs/compress_hints.h
> +++ b/include/erofs/compress_hints.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
>    * Created by Huang Jianan <huangjianan@oppo.com>
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index cb064b6..e41c079 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
> index e649c80..82bf7b8 100644
> --- a/include/erofs/decompress.h
> +++ b/include/erofs/decompress.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
>    * Created by Huang Jianan <huangjianan@oppo.com>
> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
> index 4db237f..e745bc0 100644
> --- a/include/erofs/defs.h
> +++ b/include/erofs/defs.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * Copyright (C) 2018 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/err.h b/include/erofs/err.h
> index 18f152a..08b0bdb 100644
> --- a/include/erofs/err.h
> +++ b/include/erofs/err.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * Copyright (C) 2018 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/exclude.h b/include/erofs/exclude.h
> index 599f018..3f17032 100644
> --- a/include/erofs/exclude.h
> +++ b/include/erofs/exclude.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * Created by Li Guifu <bluce.lee@aliyun.com>
>    */
> diff --git a/include/erofs/inode.h b/include/erofs/inode.h
> index e23d65f..79b39b0 100644
> --- a/include/erofs/inode.h
> +++ b/include/erofs/inode.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index a68de32..e6beb8c 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * Copyright (C) 2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/io.h b/include/erofs/io.h
> index 6f51e06..0f58c70 100644
> --- a/include/erofs/io.h
> +++ b/include/erofs/io.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/list.h b/include/erofs/list.h
> index fd5358d..2a0e961 100644
> --- a/include/erofs/list.h
> +++ b/include/erofs/list.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * Copyright (C) 2018 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/print.h b/include/erofs/print.h
> index 2213d1d..f188a6b 100644
> --- a/include/erofs/print.h
> +++ b/include/erofs/print.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/trace.h b/include/erofs/trace.h
> index 893e16c..398e331 100644
> --- a/include/erofs/trace.h
> +++ b/include/erofs/trace.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
>    */
> diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
> index 8e68812..226e984 100644
> --- a/include/erofs/xattr.h
> +++ b/include/erofs/xattr.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * Originally contributed by an anonymous person,
>    * heavily changed by Li Guifu <blucerlee@gmail.com>
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index 67ba798..c745e49 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   
>   noinst_LTLIBRARIES = liberofs.la
>   noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index b605b0b..5e9a88a 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * erofs-utils/lib/blobchunk.c
>    *
> diff --git a/lib/block_list.c b/lib/block_list.c
> index 87609a9..896fb01 100644
> --- a/lib/block_list.c
> +++ b/lib/block_list.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * Copyright (C), 2021, Coolpad Group Limited.
>    * Created by Yue Hu <huyue2@yulong.com>
> diff --git a/lib/cache.c b/lib/cache.c
> index 83d591f..f820c0b 100644
> --- a/lib/cache.c
> +++ b/lib/cache.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/compress.c b/lib/compress.c
> index 98be7a2..6f16e0c 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/compress_hints.c b/lib/compress_hints.c
> index 81a8ac9..25adf35 100644
> --- a/lib/compress_hints.c
> +++ b/lib/compress_hints.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
>    * Created by Huang Jianan <huangjianan@oppo.com>
> diff --git a/lib/compressor.c b/lib/compressor.c
> index 6362825..a4d696e 100644
> --- a/lib/compressor.c
> +++ b/lib/compressor.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/compressor.h b/lib/compressor.h
> index 1ea2724..fd28dfe 100644
> --- a/lib/compressor.h
> +++ b/lib/compressor.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
> index 578ba06..42f3ac6 100644
> --- a/lib/compressor_liblzma.c
> +++ b/lib/compressor_liblzma.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * erofs-utils/lib/compressor_liblzma.c
>    *
> diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
> index fc8c23c..0936d03 100644
> --- a/lib/compressor_lz4.c
> +++ b/lib/compressor_lz4.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
> index 3f68b00..8f2d25c 100644
> --- a/lib/compressor_lz4hc.c
> +++ b/lib/compressor_lz4hc.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/config.c b/lib/config.c
> index f1c8edf..d3298da 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/data.c b/lib/data.c
> index 27710f9..e57707e 100644
> --- a/lib/data.c
> +++ b/lib/data.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
>    * Compression support by Huang Jianan <huangjianan@oppo.com>
> diff --git a/lib/decompress.c b/lib/decompress.c
> index f313e41..359dae7 100644
> --- a/lib/decompress.c
> +++ b/lib/decompress.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
>    * Created by Huang Jianan <huangjianan@oppo.com>
> diff --git a/lib/exclude.c b/lib/exclude.c
> index 2f980a3..e3c4ed5 100644
> --- a/lib/exclude.c
> +++ b/lib/exclude.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * Created by Li Guifu <bluce.lee@aliyun.com>
>    */
> diff --git a/lib/inode.c b/lib/inode.c
> index 461c797..b6d3092 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/io.c b/lib/io.c
> index a0d366a..5bc3432 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * Copyright (C) 2018 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/namei.c b/lib/namei.c
> index 7377e74..4124170 100644
> --- a/lib/namei.c
> +++ b/lib/namei.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * Created by Li Guifu <blucerlee@gmail.com>
>    */
> diff --git a/lib/super.c b/lib/super.c
> index 3ccc551..69522bd 100644
> --- a/lib/super.c
> +++ b/lib/super.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * Created by Li Guifu <blucerlee@gmail.com>
>    */
> diff --git a/lib/xattr.c b/lib/xattr.c
> index 00fb963..02f93f2 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * Originally contributed by an anonymous person,
>    * heavily changed by Li Guifu <blucerlee@gmail.com>
> diff --git a/lib/zmap.c b/lib/zmap.c
> index 3715c47..09d5d35 100644
> --- a/lib/zmap.c
> +++ b/lib/zmap.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>   /*
>    * (a large amount of code was adapted from Linux kernel. )
>    *
> 
