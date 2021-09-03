Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 908184000AA
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 15:41:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H1Jpk3JyDz2yPh
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 23:41:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=bEigjao8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030;
 helo=mail-pj1-x1030.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=bEigjao8; dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H1JpX6Nlfz2xYQ
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Sep 2021 23:40:52 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id
 gp20-20020a17090adf1400b00196b761920aso3914650pjb.3
 for <linux-erofs@lists.ozlabs.org>; Fri, 03 Sep 2021 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Oap1t090IzC5O0EeBlc+U2zCPu4gksu8lpwpP1k6qPs=;
 b=bEigjao8LDfKe8pvUqd/2IUcNMX2iGCw5iSI5nCrsig0TsB+d1LiJfNcdDThv6nzWC
 bV9dwAAlITxfqCYlco/nvUoHHwIz4qi28zknbg58v/XiVJpYjGZpSEu10haN4qlMxMY5
 NEnai9nqNzrvulMfekG2Gt7RGzICxeZVIY5vj5a7TKwb36btuu0c4mh9twasU/BI02Zz
 oR+o9L+uKBB8ouwD8g+sgY/cv+MJb30Bwf0cp/m2csHg8R0km9PQPLdjuj9hVgOndjAK
 ww7iLQdKVq/SGn/9kmkSJwLeMycB14+sMOYYU6Axo0HS69QZxPcb4NG34LWmq+E8WX8Q
 YxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Oap1t090IzC5O0EeBlc+U2zCPu4gksu8lpwpP1k6qPs=;
 b=q58BWbXQY+sghxCh/efoXzVB8D6iiPIR0brBrtjqEsX1AGeFR5NPSzaudrN+0KTKbl
 276FcMSyBxplo9VOahjsGlyvtvS+ccgcerzHcPAdgS2uEzju5rIIg6N51vbdIac4AFmU
 eBl+G/mPNF2isxf09/ITs0X88RGwZQWdV9/zFMMv2UkHMyXlT64L94jmF/TIRvBfqoUg
 UlgXOAj+glaOVJKFzJgVU8hakseFEu2/dY9xMITyt6xlI0oaj1LRUU/WV2rik195z0Q5
 m/p6xBqKvYOzVlZwAYn6TuWYzoCQIqYRpRQwF4RAuTOZy9iAFHCxRZVwLoW4/Zuyvt7X
 iLDQ==
X-Gm-Message-State: AOAM5307k3sy2W1/S7/EjnhcaKomP60vhotGVr0hLLl8YB7F0A1lTWGC
 f5QBtjjxq9tO94WG8gTt7VS39rOWBLNMcRoG
X-Google-Smtp-Source: ABdhPJy/lGi3VkxXwoq2vT0wI18rhQuiYrQN5J28bb4Vby+DuL/QiAHTHlEOiFf3Zy5KUj01y7pbNQ==
X-Received: by 2002:a17:90b:4a51:: with SMTP id
 lb17mr882723pjb.245.1630676449764; 
 Fri, 03 Sep 2021 06:40:49 -0700 (PDT)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id o1sm5590948pjk.1.2021.09.03.06.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 06:40:49 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V2 1/6] erofs-utils: clean up file headers & footers
Date: Fri,  3 Sep 2021 21:40:30 +0800
Message-Id: <20210903134035.12507-2-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210903134035.12507-1-jnhuang95@gmail.com>
References: <20210831165116.16575-1-jnhuang95@gmail.com>
 <20210903134035.12507-1-jnhuang95@gmail.com>
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

From: Huang Jianan <huangjianan@oppo.com>

- Remove filename in the file since it's generally not useful.
- Get rid of all unnecessary trailing newline.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 AUTHORS                    | 1 -
 ChangeLog                  | 1 -
 Makefile.am                | 2 --
 README                     | 1 -
 autogen.sh                 | 1 -
 configure.ac               | 1 -
 fuse/Makefile.am           | 2 --
 fuse/dir.c                 | 3 ---
 fuse/main.c                | 3 ---
 include/erofs/block_list.h | 2 --
 include/erofs/cache.h      | 3 ---
 include/erofs/compress.h   | 3 ---
 include/erofs/config.h     | 3 ---
 include/erofs/decompress.h | 2 --
 include/erofs/defs.h       | 2 --
 include/erofs/err.h        | 3 ---
 include/erofs/exclude.h    | 3 ---
 include/erofs/hashtable.h  | 2 --
 include/erofs/inode.h      | 2 --
 include/erofs/internal.h   | 2 --
 include/erofs/io.h         | 3 ---
 include/erofs/list.h       | 2 --
 include/erofs/print.h      | 4 ----
 include/erofs/trace.h      | 3 ---
 include/erofs/xattr.h      | 2 --
 include/erofs_fs.h         | 2 --
 lib/Makefile.am            | 2 --
 lib/block_list.c           | 2 --
 lib/cache.c                | 3 ---
 lib/compress.c             | 3 ---
 lib/compressor.c           | 3 ---
 lib/compressor.h           | 3 ---
 lib/compressor_lz4.c       | 3 ---
 lib/compressor_lz4hc.c     | 3 ---
 lib/config.c               | 3 ---
 lib/data.c                 | 3 ---
 lib/decompress.c           | 2 --
 lib/exclude.c              | 3 ---
 lib/inode.c                | 3 ---
 lib/io.c                   | 2 --
 lib/namei.c                | 3 ---
 lib/super.c                | 3 ---
 lib/xattr.c                | 3 ---
 lib/zmap.c                 | 2 --
 man/Makefile.am            | 1 -
 man/mkfs.erofs.1           | 1 -
 mkfs/Makefile.am           | 2 --
 mkfs/main.c                | 2 --
 48 files changed, 113 deletions(-)

diff --git a/AUTHORS b/AUTHORS
index 3487d44..dacbdda 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -6,4 +6,3 @@ R: Gao Xiang <xiang@kernel.org>
 R: Chao Yu <yuchao0@huawei.com>
 S: Maintained
 L: linux-erofs@lists.ozlabs.org
-
diff --git a/ChangeLog b/ChangeLog
index 6637bc3..4c0c941 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -58,4 +58,3 @@ erofs-utils (1.0-1) unstable; urgency=low
    - (mkfs.erofs) Posix ACL support;
 
  -- Gao Xiang <xiang@kernel.org>  Thu, 24 Oct 2019 00:00:00 +0800
-
diff --git a/Makefile.am b/Makefile.am
index b804aa9..20f0f7d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Makefile.am
 
 ACLOCAL_AMFLAGS = -I m4
 
@@ -7,4 +6,3 @@ SUBDIRS = man lib mkfs
 if ENABLE_FUSE
 SUBDIRS += fuse
 endif
-
diff --git a/README b/README
index af9cdf1..7b641f7 100644
--- a/README
+++ b/README
@@ -230,4 +230,3 @@ Comments
     https://github.com/lz4/lz4/issues/783
 
     which is also resolved in lz4-1.9.3.
-
diff --git a/autogen.sh b/autogen.sh
index 6816b11..fd81db4 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -7,4 +7,3 @@ autoconf && \
 case `uname` in Darwin*) glibtoolize --copy ;; \
   *) libtoolize --copy ;; esac && \
 automake -a -c
-
diff --git a/configure.ac b/configure.ac
index 3510609..a749db0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -297,4 +297,3 @@ AC_CONFIG_FILES([Makefile
 		 mkfs/Makefile
 		 fuse/Makefile])
 AC_OUTPUT
-
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index e7757bc..6893a97 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Makefile.am
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
@@ -7,4 +6,3 @@ erofsfuse_SOURCES = dir.c main.c
 erofsfuse_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS} ${libselinux_CFLAGS}
 erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS} ${libselinux_LIBS}
-
diff --git a/fuse/dir.c b/fuse/dir.c
index e16fda1..bc8735b 100644
--- a/fuse/dir.c
+++ b/fuse/dir.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/fuse/dir.c
- *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
 #include <fuse.h>
@@ -100,4 +98,3 @@ int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 	}
 	return 0;
 }
-
diff --git a/fuse/main.c b/fuse/main.c
index 5552480..fca4d7f 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/fuse/main.c
- *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
 #include <stdlib.h>
@@ -249,4 +247,3 @@ err:
 	erofs_exit_configure();
 	return ret ? EXIT_FAILURE : EXIT_SUCCESS;
 }
-
diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
index 7756d8a..5127b23 100644
--- a/include/erofs/block_list.h
+++ b/include/erofs/block_list.h
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/include/erofs/block_list.h
- *
  * Copyright (C), 2021, Coolpad Group Limited.
  * Created by Yue Hu <huyue2@yulong.com>
  */
diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 611ca5b..e324d92 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-utils/include/erofs/cache.h
- *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Miao Xie <miaoxie@huawei.com>
@@ -102,4 +100,3 @@ bool erofs_bflush(struct erofs_buffer_block *bb);
 void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
 
 #endif
-
diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index d234e8b..4434aaa 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-utils/include/erofs/compress.h
- *
  * Copyright (C) 2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
@@ -24,4 +22,3 @@ int z_erofs_compress_exit(void);
 const char *z_erofs_list_available_compressors(unsigned int i);
 
 #endif
-
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 8124f3b..95fc23e 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-utils/include/erofs/config.h
- *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Li Guifu <bluce.liguifu@huawei.com>
@@ -89,4 +87,3 @@ static inline int erofs_selabel_open(const char *file_contexts)
 #endif
 
 #endif
-
diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
index beaac35..0ba2b08 100644
--- a/include/erofs/decompress.h
+++ b/include/erofs/decompress.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-utils/include/erofs/decompress.h
- *
  * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
  * Created by Huang Jianan <huangjianan@oppo.com>
  */
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 5410685..6e0a777 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-utils/include/erofs/defs.h
- *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Li Guifu <bluce.liguifu@huawei.com>
diff --git a/include/erofs/err.h b/include/erofs/err.h
index da3b681..a33bdd1 100644
--- a/include/erofs/err.h
+++ b/include/erofs/err.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-utils/include/erofs/err.h
- *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Li Guifu <bluce.liguifu@huawei.com>
@@ -31,4 +29,3 @@ static inline long PTR_ERR(const void *ptr)
 }
 
 #endif
-
diff --git a/include/erofs/exclude.h b/include/erofs/exclude.h
index 88c55d7..6930f2b 100644
--- a/include/erofs/exclude.h
+++ b/include/erofs/exclude.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-utils/include/erofs/exclude.h
- *
  * Created by Li Guifu <bluce.lee@aliyun.com>
  */
 #ifndef __EROFS_EXCLUDE_H
@@ -24,4 +22,3 @@ int erofs_parse_exclude_path(const char *args, bool is_regex);
 struct erofs_exclude_rule *erofs_is_exclude_path(const char *dir,
 						 const char *name);
 #endif
-
diff --git a/include/erofs/hashtable.h b/include/erofs/hashtable.h
index 7e47189..a71cb00 100644
--- a/include/erofs/hashtable.h
+++ b/include/erofs/hashtable.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * erofs-utils/include/erofs/hashtable.h
- *
  * Original code taken from 'linux/include/linux/hash{,table}.h'
  */
 #ifndef __EROFS_HASHTABLE_H
diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 5a7f5f1..a736762 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-utils/include/erofs/inode.h
- *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Li Guifu <bluce.liguifu@huawei.com>
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 5583861..7dc5ff0 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-utils/include/erofs/internal.h
- *
  * Copyright (C) 2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 5574245..0763baf 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-utils/include/erofs/io.h
- *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Li Guifu <bluce.liguifu@huawei.com>
@@ -41,4 +39,3 @@ static inline int blk_read(void *buf, erofs_blk_t start,
 }
 
 #endif
-
diff --git a/include/erofs/list.h b/include/erofs/list.h
index 3572726..d2bc704 100644
--- a/include/erofs/list.h
+++ b/include/erofs/list.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-utils/include/erofs/list.h
- *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Li Guifu <bluce.liguifu@huawei.com>
diff --git a/include/erofs/print.h b/include/erofs/print.h
index 6b79074..57b6607 100644
--- a/include/erofs/print.h
+++ b/include/erofs/print.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-utils/include/erofs/print.h
- *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Li Guifu <bluce.liguifu@huawei.com>
@@ -71,6 +69,4 @@ enum {
 
 #define erofs_dump(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
 
-
 #endif
-
diff --git a/include/erofs/trace.h b/include/erofs/trace.h
index 5a12da7..d70d236 100644
--- a/include/erofs/trace.h
+++ b/include/erofs/trace.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-utils/include/erofs/trace.h
- *
  * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
  */
 #ifndef __EROFS_TRACE_H
@@ -11,4 +9,3 @@
 #define trace_erofs_map_blocks_flatmode_exit(inode, map, flags, ret) ((void)0)
 
 #endif
-
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 197fe25..5086b54 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/include/erofs/xattr.h
- *
  * Originally contributed by an anonymous person,
  * heavily changed by Li Guifu <blucerlee@gmail.com>
  *                and Gao Xiang <xiang@kernel.org>
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 18fc182..48934bb 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -1,6 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
 /*
- * erofs-utils/include/erofs_fs.h
  * EROFS (Enhanced ROM File System) on-disk format definition
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
@@ -360,4 +359,3 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 }
 
 #endif
-
diff --git a/lib/Makefile.am b/lib/Makefile.am
index b12e2c1..b5127c4 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Makefile.am
 
 noinst_LTLIBRARIES = liberofs.la
 noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
@@ -30,4 +29,3 @@ if ENABLE_LZ4HC
 liberofs_la_SOURCES += compressor_lz4hc.c
 endif
 endif
-
diff --git a/lib/block_list.c b/lib/block_list.c
index 3be0992..73c1bde 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/lib/block_list.c
- *
  * Copyright (C), 2021, Coolpad Group Limited.
  * Created by Yue Hu <huyue2@yulong.com>
  */
diff --git a/lib/cache.c b/lib/cache.c
index 340dcdd..8016e38 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/lib/cache.c
- *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Miao Xie <miaoxie@huawei.com>
@@ -442,4 +440,3 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 	if (rollback)
 		tail_blkaddr = blkaddr;
 }
-
diff --git a/lib/compress.c b/lib/compress.c
index a8ebbc1..5ac9427 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/lib/compress.c
- *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Miao Xie <miaoxie@huawei.com>
@@ -680,4 +678,3 @@ int z_erofs_compress_exit(void)
 {
 	return erofs_compressor_exit(&compresshandle);
 }
-
diff --git a/lib/compressor.c b/lib/compressor.c
index 8836e0c..c14fc05 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/lib/compressor.c
- *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
@@ -91,4 +89,3 @@ int erofs_compressor_exit(struct erofs_compress *c)
 		return c->alg->exit(c);
 	return 0;
 }
-
diff --git a/lib/compressor.h b/lib/compressor.h
index b2471c4..151c43d 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * erofs-utils/lib/compressor.h
- *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
@@ -53,4 +51,3 @@ int erofs_compressor_init(struct erofs_compress *c, char *alg_name);
 int erofs_compressor_exit(struct erofs_compress *c);
 
 #endif
-
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index 292d0f2..f71252e 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/lib/compressor-lz4.c
- *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
@@ -48,4 +46,3 @@ struct erofs_compressor erofs_compressor_lz4 = {
 	.exit = compressor_lz4_exit,
 	.compress_destsize = lz4_compress_destsize,
 };
-
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index 14c3a71..0c912fb 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/lib/compressor-lz4hc.c
- *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
@@ -61,4 +59,3 @@ struct erofs_compressor erofs_compressor_lz4hc = {
 	.exit = compressor_lz4hc_exit,
 	.compress_destsize = lz4hc_compress_destsize,
 };
-
diff --git a/lib/config.c b/lib/config.c
index 99fcf49..4757dbb 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/lib/config.c
- *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Li Guifu <bluce.liguifu@huawei.com>
@@ -85,4 +83,3 @@ int erofs_selabel_open(const char *file_contexts)
 	return 0;
 }
 #endif
-
diff --git a/lib/data.c b/lib/data.c
index 42b4904..1a1005a 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/lib/data.c
- *
  * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
  * Compression support by Huang Jianan <huangjianan@oppo.com>
  */
@@ -217,4 +215,3 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 	}
 	return -EINVAL;
 }
-
diff --git a/lib/decompress.c b/lib/decompress.c
index 490c4bc..2ee1439 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/lib/decompress.c
- *
  * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
  * Created by Huang Jianan <huangjianan@oppo.com>
  */
diff --git a/lib/exclude.c b/lib/exclude.c
index 73b3720..2f980a3 100644
--- a/lib/exclude.c
+++ b/lib/exclude.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/lib/exclude.c
- *
  * Created by Li Guifu <bluce.lee@aliyun.com>
  */
 #include <string.h>
@@ -129,4 +127,3 @@ struct erofs_exclude_rule *erofs_is_exclude_path(const char *dir,
 	}
 	return NULL;
 }
-
diff --git a/lib/inode.c b/lib/inode.c
index 6871d2b..97ee2c9 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/lib/inode.c
- *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Li Guifu <bluce.liguifu@huawei.com>
@@ -1100,4 +1098,3 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
 
 	return erofs_mkfs_build_tree(inode);
 }
-
diff --git a/lib/io.c b/lib/io.c
index 6067041..b053137 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/lib/io.c
- *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Li Guifu <bluce.liguifu@huawei.com>
diff --git a/lib/namei.c b/lib/namei.c
index b572d17..755a5ad 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/lib/namei.c
- *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
 #include <sys/types.h>
@@ -262,4 +260,3 @@ int erofs_ilookup(const char *path, struct erofs_inode *vi)
 	vi->nid = nd.nid;
 	return erofs_read_inode_from_disk(vi);
 }
-
diff --git a/lib/super.c b/lib/super.c
index 11405ec..0fa69ab 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/lib/super.c
- *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
 #include <string.h>
@@ -71,4 +69,3 @@ int erofs_read_superblock(void)
 	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
 	return 0;
 }
-
diff --git a/lib/xattr.c b/lib/xattr.c
index aff3d67..ffc5f7a 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/lib/xattr.c
- *
  * Originally contributed by an anonymous person,
  * heavily changed by Li Guifu <blucerlee@gmail.com>
  *                and Gao Xiang <hsiangkao@aol.com>
@@ -687,4 +685,3 @@ char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
 	DBG_BUGON(p > size);
 	return buf;
 }
-
diff --git a/lib/zmap.c b/lib/zmap.c
index 1084faa..fdc84af 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * erofs-utils/lib/zmap.c
- *
  * (a large amount of code was adapted from Linux kernel. )
  *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
diff --git a/man/Makefile.am b/man/Makefile.am
index 0df947b..d62d6e2 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Makefile.am
 
 dist_man_MANS = mkfs.erofs.1
 
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index d164fa5..bc0a10b 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -99,4 +99,3 @@ This manual page was written by Gao Xiang <xiang@kernel.org>.
 git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git.
 .SH SEE ALSO
 .BR mkfs (8).
-
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index 8b8e051..e488f86 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Makefile.am
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = mkfs.erofs
@@ -7,4 +6,3 @@ AM_CPPFLAGS = ${libuuid_CFLAGS} ${libselinux_CFLAGS}
 mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 mkfs_erofs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} ${liblz4_LIBS}
-
diff --git a/mkfs/main.c b/mkfs/main.c
index 89f2310..debb754 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * mkfs/main.c
- *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Li Guifu <bluce.liguifu@huawei.com>
-- 
2.25.1

