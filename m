Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57265465241
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Dec 2021 17:00:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J43hN1qM8z308b
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Dec 2021 03:00:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=UpGEH8eC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036;
 helo=mail-pj1-x1036.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=UpGEH8eC; dkim-atps=neutral
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J43hH2j8cz2yfk
 for <linux-erofs@lists.ozlabs.org>; Thu,  2 Dec 2021 03:00:15 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id
 cq22-20020a17090af99600b001a9550a17a5so96571pjb.2
 for <linux-erofs@lists.ozlabs.org>; Wed, 01 Dec 2021 08:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nnVQeuLQYaYBWAeiRgi7PqByMFOkgSSN+pE87/vE2wI=;
 b=UpGEH8eC3k+qvUBpQi5xHoRmcNPamIuj4Q7K19ilmYUXEcMFlnIGeOeDAcpI40brUA
 BD01r7bq5ODttr9q8O1Dz0lorwN2vbUSE2AmTXbNn/CXOtzdSYpaXHxuOExPmMsCMDsh
 YR5KYLRZry9pAlkduG5eYYW0hImgWQzB5q76OHuaKhP5kfmFqou0lRIvBq4b10vbzmVt
 uP4WGKUaqZ3GEMo5SM6NuVxM7QvBKAafTKJ7BmYC2+dbKcplWDdHolExYWdiulcpA2iW
 M6vv59f/gam5hKMGL/nf+mzIJJ7IxXmJMxGallhic8RNtbEXZiK3iX5AHmSSMplT5yGH
 2yiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nnVQeuLQYaYBWAeiRgi7PqByMFOkgSSN+pE87/vE2wI=;
 b=rybIQqWih83tnCkPtL5UvnpHfX1ZTAJ/yqahCSQVVjTukVLJ1Nkchnq9jpLqv4OF6I
 rd4RSTwMLmYDNIaDcQ4hlqvlUmz4nutG7jRbzfMVVnezv1gD/PtCL6ypgQ9n0vPgQH3e
 HdoiIpk0YEzaoSJGhGdAm1u2I/DiAxhjy8Lpm6pf5Oh78voa4y1y4j1CczZ8DTn0n8Xz
 HT3oKizRZ/21xQxoZNRfXBkVC6OF7GxGFM5m2DkzLTIjA/MJLbMO7znIFQrWR1rQ0AAy
 hop9CEiyiFms8zdoIhqFwS4QR0FxqHeYtbV2p7qo6q7OvUuP2t8pfguhhfWOhlIoPZf0
 Bxnw==
X-Gm-Message-State: AOAM530kmcxe8mtDaTDy88o8HBTvTbyB0NzgUZgQgI1kwFapV6k4Uj9Y
 6hpRdyyi/I14imJJudMrIP0pQgv7Rek=
X-Google-Smtp-Source: ABdhPJzywE04jBsAU/IjfVKo/eIGJd1bIumDALPVwFEgsD9k6rM1159UoZ6yrYtNoF20N5S6h8naug==
X-Received: by 2002:a17:903:124e:b0:143:a388:865e with SMTP id
 u14-20020a170903124e00b00143a388865emr8520974plh.42.1638374412476; 
 Wed, 01 Dec 2021 08:00:12 -0800 (PST)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id d7sm280454pfj.91.2021.12.01.08.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Dec 2021 08:00:08 -0800 (PST)
From: Huang Jianan <jnhuang95@gmail.com>
X-Google-Original-From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH] erofs-utils: add Apache 2.0 license
Date: Wed,  1 Dec 2021 23:59:52 +0800
Message-Id: <20211201155952.2053-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add Apache 2.0 to license for liberofs.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 include/erofs/blobchunk.h      | 2 +-
 include/erofs/block_list.h     | 2 +-
 include/erofs/cache.h          | 2 +-
 include/erofs/compress.h       | 2 +-
 include/erofs/compress_hints.h | 2 +-
 include/erofs/config.h         | 2 +-
 include/erofs/decompress.h     | 2 +-
 include/erofs/defs.h           | 2 +-
 include/erofs/err.h            | 2 +-
 include/erofs/exclude.h        | 2 +-
 include/erofs/flex-array.h     | 2 +-
 include/erofs/hashmap.h        | 2 +-
 include/erofs/hashtable.h      | 2 +-
 include/erofs/inode.h          | 2 +-
 include/erofs/internal.h       | 2 +-
 include/erofs/io.h             | 2 +-
 include/erofs/list.h           | 2 +-
 include/erofs/print.h          | 2 +-
 include/erofs/trace.h          | 2 +-
 include/erofs/xattr.h          | 2 +-
 lib/Makefile.am                | 2 +-
 lib/blobchunk.c                | 2 +-
 lib/block_list.c               | 2 +-
 lib/cache.c                    | 2 +-
 lib/compress.c                 | 2 +-
 lib/compress_hints.c           | 2 +-
 lib/compressor.c               | 2 +-
 lib/compressor.h               | 2 +-
 lib/compressor_liblzma.c       | 2 +-
 lib/compressor_lz4.c           | 2 +-
 lib/compressor_lz4hc.c         | 2 +-
 lib/config.c                   | 2 +-
 lib/data.c                     | 2 +-
 lib/decompress.c               | 2 +-
 lib/exclude.c                  | 2 +-
 lib/hashmap.c                  | 2 +-
 lib/inode.c                    | 2 +-
 lib/io.c                       | 2 +-
 lib/namei.c                    | 2 +-
 lib/super.c                    | 2 +-
 lib/xattr.c                    | 2 +-
 lib/zmap.c                     | 2 +-
 42 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index 4e1ae79..49cb7bf 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * erofs-utils/lib/blobchunk.h
  *
diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
index ca8053e..78fab44 100644
--- a/include/erofs/block_list.h
+++ b/include/erofs/block_list.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C), 2021, Coolpad Group Limited.
  * Created by Yue Hu <huyue2@yulong.com>
diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 7957ee5..de12399 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index fdbf5ff..21eac57 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/compress_hints.h b/include/erofs/compress_hints.h
index 43f80e1..659c5b6 100644
--- a/include/erofs/compress_hints.h
+++ b/include/erofs/compress_hints.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
  * Created by Huang Jianan <huangjianan@oppo.com>
diff --git a/include/erofs/config.h b/include/erofs/config.h
index cb064b6..e41c079 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
index e649c80..82bf7b8 100644
--- a/include/erofs/decompress.h
+++ b/include/erofs/decompress.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
  * Created by Huang Jianan <huangjianan@oppo.com>
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 4db237f..e745bc0 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/err.h b/include/erofs/err.h
index 18f152a..08b0bdb 100644
--- a/include/erofs/err.h
+++ b/include/erofs/err.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/exclude.h b/include/erofs/exclude.h
index 599f018..3f17032 100644
--- a/include/erofs/exclude.h
+++ b/include/erofs/exclude.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Created by Li Guifu <bluce.lee@aliyun.com>
  */
diff --git a/include/erofs/flex-array.h b/include/erofs/flex-array.h
index 9b1642f..bf762ce 100644
--- a/include/erofs/flex-array.h
+++ b/include/erofs/flex-array.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
 #ifndef __EROFS_FLEX_ARRAY_H
 #define __EROFS_FLEX_ARRAY_H
 
diff --git a/include/erofs/hashmap.h b/include/erofs/hashmap.h
index 3d38578..29d3479 100644
--- a/include/erofs/hashmap.h
+++ b/include/erofs/hashmap.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
 #ifndef __EROFS_HASHMAP_H
 #define __EROFS_HASHMAP_H
 
diff --git a/include/erofs/hashtable.h b/include/erofs/hashtable.h
index 3c4dfc1..e6ba823 100644
--- a/include/erofs/hashtable.h
+++ b/include/erofs/hashtable.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
 /*
  * Original code taken from 'linux/include/linux/hash{,table}.h'
  */
diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index e23d65f..79b39b0 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index a68de32..e6beb8c 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 6f51e06..0f58c70 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/list.h b/include/erofs/list.h
index fd5358d..2a0e961 100644
--- a/include/erofs/list.h
+++ b/include/erofs/list.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/print.h b/include/erofs/print.h
index 2213d1d..f188a6b 100644
--- a/include/erofs/print.h
+++ b/include/erofs/print.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/include/erofs/trace.h b/include/erofs/trace.h
index 893e16c..398e331 100644
--- a/include/erofs/trace.h
+++ b/include/erofs/trace.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
  */
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 8e68812..226e984 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Originally contributed by an anonymous person,
  * heavily changed by Li Guifu <blucerlee@gmail.com>
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 67ba798..c745e49 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 
 noinst_LTLIBRARIES = liberofs.la
 noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index b605b0b..5e9a88a 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * erofs-utils/lib/blobchunk.c
  *
diff --git a/lib/block_list.c b/lib/block_list.c
index 87609a9..896fb01 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C), 2021, Coolpad Group Limited.
  * Created by Yue Hu <huyue2@yulong.com>
diff --git a/lib/cache.c b/lib/cache.c
index 83d591f..f820c0b 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/compress.c b/lib/compress.c
index 98be7a2..6f16e0c 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/compress_hints.c b/lib/compress_hints.c
index 81a8ac9..25adf35 100644
--- a/lib/compress_hints.c
+++ b/lib/compress_hints.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
  * Created by Huang Jianan <huangjianan@oppo.com>
diff --git a/lib/compressor.c b/lib/compressor.c
index 6362825..a4d696e 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/compressor.h b/lib/compressor.h
index 1ea2724..fd28dfe 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index 578ba06..42f3ac6 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * erofs-utils/lib/compressor_liblzma.c
  *
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index fc8c23c..0936d03 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index 3f68b00..8f2d25c 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/config.c b/lib/config.c
index f1c8edf..d3298da 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/data.c b/lib/data.c
index 27710f9..e57707e 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
  * Compression support by Huang Jianan <huangjianan@oppo.com>
diff --git a/lib/decompress.c b/lib/decompress.c
index f313e41..359dae7 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
  * Created by Huang Jianan <huangjianan@oppo.com>
diff --git a/lib/exclude.c b/lib/exclude.c
index 2f980a3..e3c4ed5 100644
--- a/lib/exclude.c
+++ b/lib/exclude.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Created by Li Guifu <bluce.lee@aliyun.com>
  */
diff --git a/lib/hashmap.c b/lib/hashmap.c
index e11bd8d..6c373af 100644
--- a/lib/hashmap.c
+++ b/lib/hashmap.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0 OR Apache-2.0
 /*
  * Copied from https://github.com/git/git.git
  * Generic implementation of hash-based key value mappings.
diff --git a/lib/inode.c b/lib/inode.c
index 461c797..b6d3092 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/io.c b/lib/io.c
index a0d366a..5bc3432 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
diff --git a/lib/namei.c b/lib/namei.c
index 7377e74..4124170 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Created by Li Guifu <blucerlee@gmail.com>
  */
diff --git a/lib/super.c b/lib/super.c
index 3ccc551..69522bd 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Created by Li Guifu <blucerlee@gmail.com>
  */
diff --git a/lib/xattr.c b/lib/xattr.c
index 00fb963..02f93f2 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * Originally contributed by an anonymous person,
  * heavily changed by Li Guifu <blucerlee@gmail.com>
diff --git a/lib/zmap.c b/lib/zmap.c
index 3715c47..09d5d35 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 /*
  * (a large amount of code was adapted from Linux kernel. )
  *
-- 
2.25.1

