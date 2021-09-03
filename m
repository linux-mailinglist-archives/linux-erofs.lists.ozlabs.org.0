Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8E63FF907
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 05:09:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H12pR2NBkz2yJV
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 13:09:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H12pK6vtgz2xXS
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Sep 2021 13:09:45 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0Un3LdMD_1630638578; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Un3LdMD_1630638578) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 03 Sep 2021 11:09:39 +0800
Date: Fri, 3 Sep 2021 11:09:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH 1/5] erofs-utils: remove filename in the file
Message-ID: <YTGR8kjFRUjSd/Ih@B-P7TQMD6M-0146.local>
References: <20210831165116.16575-1-jnhuang95@gmail.com>
 <20210831165116.16575-2-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210831165116.16575-2-jnhuang95@gmail.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Sep 01, 2021 at 12:51:12AM +0800, Huang Jianan wrote:
> From: Huang Jianan <huangjianan@oppo.com>
> 
> It's generally not useful to have the filename in the file.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

If we decide to clean up this stuff, could we remove trailing newline
like the commit below?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/erofs?id=c5fcb51111b85323cafe3f02784f7f0bf6a7cf07

Thanks,
Gao Xiang

> ---
>  Makefile.am                | 1 -
>  fuse/Makefile.am           | 1 -
>  fuse/dir.c                 | 2 --
>  fuse/main.c                | 2 --
>  include/erofs/block_list.h | 2 --
>  include/erofs/cache.h      | 2 --
>  include/erofs/compress.h   | 2 --
>  include/erofs/config.h     | 2 --
>  include/erofs/decompress.h | 2 --
>  include/erofs/defs.h       | 2 --
>  include/erofs/err.h        | 2 --
>  include/erofs/exclude.h    | 2 --
>  include/erofs/hashtable.h  | 2 --
>  include/erofs/inode.h      | 2 --
>  include/erofs/internal.h   | 2 --
>  include/erofs/io.h         | 2 --
>  include/erofs/list.h       | 2 --
>  include/erofs/print.h      | 2 --
>  include/erofs/trace.h      | 2 --
>  include/erofs/xattr.h      | 2 --
>  include/erofs_fs.h         | 1 -
>  lib/Makefile.am            | 1 -
>  lib/block_list.c           | 2 --
>  lib/cache.c                | 2 --
>  lib/compress.c             | 2 --
>  lib/compressor.c           | 2 --
>  lib/compressor.h           | 2 --
>  lib/compressor_lz4.c       | 2 --
>  lib/compressor_lz4hc.c     | 2 --
>  lib/config.c               | 2 --
>  lib/data.c                 | 2 --
>  lib/decompress.c           | 2 --
>  lib/exclude.c              | 2 --
>  lib/inode.c                | 2 --
>  lib/io.c                   | 2 --
>  lib/namei.c                | 2 --
>  lib/super.c                | 2 --
>  lib/xattr.c                | 2 --
>  lib/zmap.c                 | 2 --
>  man/Makefile.am            | 1 -
>  mkfs/Makefile.am           | 1 -
>  mkfs/main.c                | 2 --
>  42 files changed, 78 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index b804aa9..9a49efc 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0+
> -# Makefile.am
>  
>  ACLOCAL_AMFLAGS = -I m4
>  
> diff --git a/fuse/Makefile.am b/fuse/Makefile.am
> index e7757bc..962b467 100644
> --- a/fuse/Makefile.am
> +++ b/fuse/Makefile.am
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0+
> -# Makefile.am
>  
>  AUTOMAKE_OPTIONS = foreign
>  bin_PROGRAMS     = erofsfuse
> diff --git a/fuse/dir.c b/fuse/dir.c
> index e16fda1..9d95ec6 100644
> --- a/fuse/dir.c
> +++ b/fuse/dir.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/fuse/dir.c
> - *
>   * Created by Li Guifu <blucerlee@gmail.com>
>   */
>  #include <fuse.h>
> diff --git a/fuse/main.c b/fuse/main.c
> index 5552480..34a9b7a 100644
> --- a/fuse/main.c
> +++ b/fuse/main.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/fuse/main.c
> - *
>   * Created by Li Guifu <blucerlee@gmail.com>
>   */
>  #include <stdlib.h>
> diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
> index 7756d8a..5127b23 100644
> --- a/include/erofs/block_list.h
> +++ b/include/erofs/block_list.h
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/include/erofs/block_list.h
> - *
>   * Copyright (C), 2021, Coolpad Group Limited.
>   * Created by Yue Hu <huyue2@yulong.com>
>   */
> diff --git a/include/erofs/cache.h b/include/erofs/cache.h
> index 611ca5b..a249d30 100644
> --- a/include/erofs/cache.h
> +++ b/include/erofs/cache.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * erofs-utils/include/erofs/cache.h
> - *
>   * Copyright (C) 2018 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Miao Xie <miaoxie@huawei.com>
> diff --git a/include/erofs/compress.h b/include/erofs/compress.h
> index d234e8b..47fd489 100644
> --- a/include/erofs/compress.h
> +++ b/include/erofs/compress.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * erofs-utils/include/erofs/compress.h
> - *
>   * Copyright (C) 2019 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Gao Xiang <gaoxiang25@huawei.com>
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 8124f3b..896049b 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * erofs-utils/include/erofs/config.h
> - *
>   * Copyright (C) 2018-2019 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Li Guifu <bluce.liguifu@huawei.com>
> diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
> index beaac35..0ba2b08 100644
> --- a/include/erofs/decompress.h
> +++ b/include/erofs/decompress.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * erofs-utils/include/erofs/decompress.h
> - *
>   * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
>   * Created by Huang Jianan <huangjianan@oppo.com>
>   */
> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
> index 5410685..6e0a777 100644
> --- a/include/erofs/defs.h
> +++ b/include/erofs/defs.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * erofs-utils/include/erofs/defs.h
> - *
>   * Copyright (C) 2018 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Li Guifu <bluce.liguifu@huawei.com>
> diff --git a/include/erofs/err.h b/include/erofs/err.h
> index da3b681..2ff77a4 100644
> --- a/include/erofs/err.h
> +++ b/include/erofs/err.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * erofs-utils/include/erofs/err.h
> - *
>   * Copyright (C) 2018 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Li Guifu <bluce.liguifu@huawei.com>
> diff --git a/include/erofs/exclude.h b/include/erofs/exclude.h
> index 88c55d7..98217e4 100644
> --- a/include/erofs/exclude.h
> +++ b/include/erofs/exclude.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * erofs-utils/include/erofs/exclude.h
> - *
>   * Created by Li Guifu <bluce.lee@aliyun.com>
>   */
>  #ifndef __EROFS_EXCLUDE_H
> diff --git a/include/erofs/hashtable.h b/include/erofs/hashtable.h
> index 7e47189..a71cb00 100644
> --- a/include/erofs/hashtable.h
> +++ b/include/erofs/hashtable.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * erofs-utils/include/erofs/hashtable.h
> - *
>   * Original code taken from 'linux/include/linux/hash{,table}.h'
>   */
>  #ifndef __EROFS_HASHTABLE_H
> diff --git a/include/erofs/inode.h b/include/erofs/inode.h
> index 5a7f5f1..a736762 100644
> --- a/include/erofs/inode.h
> +++ b/include/erofs/inode.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * erofs-utils/include/erofs/inode.h
> - *
>   * Copyright (C) 2018-2019 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Li Guifu <bluce.liguifu@huawei.com>
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 5583861..7dc5ff0 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * erofs-utils/include/erofs/internal.h
> - *
>   * Copyright (C) 2019 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Gao Xiang <gaoxiang25@huawei.com>
> diff --git a/include/erofs/io.h b/include/erofs/io.h
> index 5574245..20b25d0 100644
> --- a/include/erofs/io.h
> +++ b/include/erofs/io.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * erofs-utils/include/erofs/io.h
> - *
>   * Copyright (C) 2018-2019 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Li Guifu <bluce.liguifu@huawei.com>
> diff --git a/include/erofs/list.h b/include/erofs/list.h
> index 3572726..d2bc704 100644
> --- a/include/erofs/list.h
> +++ b/include/erofs/list.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * erofs-utils/include/erofs/list.h
> - *
>   * Copyright (C) 2018 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Li Guifu <bluce.liguifu@huawei.com>
> diff --git a/include/erofs/print.h b/include/erofs/print.h
> index 6b79074..9c08a50 100644
> --- a/include/erofs/print.h
> +++ b/include/erofs/print.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * erofs-utils/include/erofs/print.h
> - *
>   * Copyright (C) 2018-2019 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Li Guifu <bluce.liguifu@huawei.com>
> diff --git a/include/erofs/trace.h b/include/erofs/trace.h
> index 5a12da7..5412ded 100644
> --- a/include/erofs/trace.h
> +++ b/include/erofs/trace.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * erofs-utils/include/erofs/trace.h
> - *
>   * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
>   */
>  #ifndef __EROFS_TRACE_H
> diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
> index 197fe25..5086b54 100644
> --- a/include/erofs/xattr.h
> +++ b/include/erofs/xattr.h
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/include/erofs/xattr.h
> - *
>   * Originally contributed by an anonymous person,
>   * heavily changed by Li Guifu <blucerlee@gmail.com>
>   *                and Gao Xiang <xiang@kernel.org>
> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> index 18fc182..f9cdd71 100644
> --- a/include/erofs_fs.h
> +++ b/include/erofs_fs.h
> @@ -1,6 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
>  /*
> - * erofs-utils/include/erofs_fs.h
>   * EROFS (Enhanced ROM File System) on-disk format definition
>   *
>   * Copyright (C) 2017-2018 HUAWEI, Inc.
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index b12e2c1..87e6411 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0+
> -# Makefile.am
>  
>  noinst_LTLIBRARIES = liberofs.la
>  noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
> diff --git a/lib/block_list.c b/lib/block_list.c
> index 3be0992..73c1bde 100644
> --- a/lib/block_list.c
> +++ b/lib/block_list.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/lib/block_list.c
> - *
>   * Copyright (C), 2021, Coolpad Group Limited.
>   * Created by Yue Hu <huyue2@yulong.com>
>   */
> diff --git a/lib/cache.c b/lib/cache.c
> index 340dcdd..0a1c0cf 100644
> --- a/lib/cache.c
> +++ b/lib/cache.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/lib/cache.c
> - *
>   * Copyright (C) 2018-2019 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Miao Xie <miaoxie@huawei.com>
> diff --git a/lib/compress.c b/lib/compress.c
> index a8ebbc1..2b12d67 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/lib/compress.c
> - *
>   * Copyright (C) 2018-2019 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Miao Xie <miaoxie@huawei.com>
> diff --git a/lib/compressor.c b/lib/compressor.c
> index 8836e0c..846a836 100644
> --- a/lib/compressor.c
> +++ b/lib/compressor.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/lib/compressor.c
> - *
>   * Copyright (C) 2018-2019 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Gao Xiang <gaoxiang25@huawei.com>
> diff --git a/lib/compressor.h b/lib/compressor.h
> index b2471c4..132bd65 100644
> --- a/lib/compressor.h
> +++ b/lib/compressor.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * erofs-utils/lib/compressor.h
> - *
>   * Copyright (C) 2018-2019 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Gao Xiang <gaoxiang25@huawei.com>
> diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
> index 292d0f2..ce8c472 100644
> --- a/lib/compressor_lz4.c
> +++ b/lib/compressor_lz4.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/lib/compressor-lz4.c
> - *
>   * Copyright (C) 2018-2019 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Gao Xiang <gaoxiang25@huawei.com>
> diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
> index 14c3a71..e345f70 100644
> --- a/lib/compressor_lz4hc.c
> +++ b/lib/compressor_lz4hc.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/lib/compressor-lz4hc.c
> - *
>   * Copyright (C) 2018-2019 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Gao Xiang <gaoxiang25@huawei.com>
> diff --git a/lib/config.c b/lib/config.c
> index 99fcf49..aa328c4 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/lib/config.c
> - *
>   * Copyright (C) 2018-2019 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Li Guifu <bluce.liguifu@huawei.com>
> diff --git a/lib/data.c b/lib/data.c
> index 42b4904..32d4c00 100644
> --- a/lib/data.c
> +++ b/lib/data.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/lib/data.c
> - *
>   * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
>   * Compression support by Huang Jianan <huangjianan@oppo.com>
>   */
> diff --git a/lib/decompress.c b/lib/decompress.c
> index 490c4bc..2ee1439 100644
> --- a/lib/decompress.c
> +++ b/lib/decompress.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/lib/decompress.c
> - *
>   * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
>   * Created by Huang Jianan <huangjianan@oppo.com>
>   */
> diff --git a/lib/exclude.c b/lib/exclude.c
> index 73b3720..e9e8b9b 100644
> --- a/lib/exclude.c
> +++ b/lib/exclude.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/lib/exclude.c
> - *
>   * Created by Li Guifu <bluce.lee@aliyun.com>
>   */
>  #include <string.h>
> diff --git a/lib/inode.c b/lib/inode.c
> index 6871d2b..62047d3 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/lib/inode.c
> - *
>   * Copyright (C) 2018-2019 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Li Guifu <bluce.liguifu@huawei.com>
> diff --git a/lib/io.c b/lib/io.c
> index 6067041..b053137 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/lib/io.c
> - *
>   * Copyright (C) 2018 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Li Guifu <bluce.liguifu@huawei.com>
> diff --git a/lib/namei.c b/lib/namei.c
> index b572d17..f4094a1 100644
> --- a/lib/namei.c
> +++ b/lib/namei.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/lib/namei.c
> - *
>   * Created by Li Guifu <blucerlee@gmail.com>
>   */
>  #include <sys/types.h>
> diff --git a/lib/super.c b/lib/super.c
> index 11405ec..c4a67f3 100644
> --- a/lib/super.c
> +++ b/lib/super.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/lib/super.c
> - *
>   * Created by Li Guifu <blucerlee@gmail.com>
>   */
>  #include <string.h>
> diff --git a/lib/xattr.c b/lib/xattr.c
> index aff3d67..39d4a96 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/lib/xattr.c
> - *
>   * Originally contributed by an anonymous person,
>   * heavily changed by Li Guifu <blucerlee@gmail.com>
>   *                and Gao Xiang <hsiangkao@aol.com>
> diff --git a/lib/zmap.c b/lib/zmap.c
> index 1084faa..fdc84af 100644
> --- a/lib/zmap.c
> +++ b/lib/zmap.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * erofs-utils/lib/zmap.c
> - *
>   * (a large amount of code was adapted from Linux kernel. )
>   *
>   * Copyright (C) 2018-2019 HUAWEI, Inc.
> diff --git a/man/Makefile.am b/man/Makefile.am
> index 0df947b..d62d6e2 100644
> --- a/man/Makefile.am
> +++ b/man/Makefile.am
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0+
> -# Makefile.am
>  
>  dist_man_MANS = mkfs.erofs.1
>  
> diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
> index 8b8e051..bcef7e1 100644
> --- a/mkfs/Makefile.am
> +++ b/mkfs/Makefile.am
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0+
> -# Makefile.am
>  
>  AUTOMAKE_OPTIONS = foreign
>  bin_PROGRAMS     = mkfs.erofs
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 89f2310..debb754 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * mkfs/main.c
> - *
>   * Copyright (C) 2018-2019 HUAWEI, Inc.
>   *             http://www.huawei.com/
>   * Created by Li Guifu <bluce.liguifu@huawei.com>
> -- 
> 2.25.1
