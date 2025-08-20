Return-Path: <linux-erofs+bounces-842-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1246EB2D3A3
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Aug 2025 07:38:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6Fc46pzDz2xQ0;
	Wed, 20 Aug 2025 15:38:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755668308;
	cv=none; b=ZEhb0AvRyFFRxqjhKHAzom3kJ8yKIGF/Ag3kLfK30gWX9Dt8s3eIO3pU7qI0903mTSSXIzHS9LNHBs6zpu1yyEEuDsCe679KD/ktREYIdKC83VUxS3pj23l4Di8I8cHcgEpO72ikBru2fedsKkjunhY7XOaaZgaGDhPLad+0V4FZ4ABOmStHKIPTAB3Wl8kYoOCefX/+WqOT4vo+Ta9HUYiKP6xyC+E6V5Hd7W47MS/lbsad0Cz7EqjCINGLPhqPTxAD9KVh2V6rfHSDK3EtFjXXdgQcc4y4/RTNqNeb4tGaoTf+o7/oHDCWEl4zaKrU4epCGUaqTyNJFthmwJNKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755668308; c=relaxed/relaxed;
	bh=+Me1Vffv5Q97rsZHRZoWXNiZ7NeFUQrswKugaxqMfcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5fU4+9mGtAJK3cEOC5qFcGOLfL7B1kLaNsowtf0MuyyEYZDtd7plI/w9qzFHDdBiWO3/hteT2Mnd+KbJDSs3XGJGBjq60mbfH5qcy6ub//EztUnVDR3k2asD+JThNmAngOquG8bPgjuHElDvGm1EMo9y+Qlold6bLYz16LkHfR8WT7Sx+tB943siW9H3Zr6HK9hCgkp1camTSMrancFkOyvGH+fCR6PBqMOdhdceDVXglKlq986FH3qv0j4UpR8Xq8wsOt/i4/hwHoNnH4qekSzfklFrNG6TAkvoxajRdlzBEM6zJle5ifMSCxllKGoaTd/cPdyYLE68CKvqj9wRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VA2dVVTX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VA2dVVTX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6Fc25Z1Kz2yZ6
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Aug 2025 15:38:26 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755668300; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+Me1Vffv5Q97rsZHRZoWXNiZ7NeFUQrswKugaxqMfcE=;
	b=VA2dVVTXs+OBi+dtTbQ14RRumxvg+d/FT4v0kzJL0HgOgl7xSQ2GSDwcDlJv+uo/Co2Snx81MWu13sKgQc+2XhLXWkGmQPFWnq0QDQK04ClOq5WIcO0jwiUShd+rJ9NkJSDm1Ov/HE4aBJUaknKvzwMCDAeudcGCSEYY0Rb3fLY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmAOfS9_1755668298 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 13:38:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/3] erofs-utils: lib: unexport `erofs/cache.h`
Date: Wed, 20 Aug 2025 13:38:06 +0800
Message-ID: <20250820053806.1441397-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250820053806.1441397-1-hsiangkao@linux.alibaba.com>
References: <20250820053806.1441397-1-hsiangkao@linux.alibaba.com>
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
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

It shouldn't be used by external users.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h                      |  3 +++
 lib/Makefile.am                               |  2 +-
 lib/blobchunk.c                               |  2 +-
 lib/cache.c                                   |  2 +-
 lib/compress.c                                |  2 +-
 lib/importer.c                                |  2 +-
 lib/inode.c                                   |  2 +-
 include/erofs/cache.h => lib/liberofs_cache.h | 12 +++++-------
 lib/metabox.c                                 |  2 +-
 lib/super.c                                   |  2 +-
 lib/tar.c                                     |  2 +-
 lib/xattr.c                                   |  2 +-
 mkfs/main.c                                   |  1 -
 13 files changed, 18 insertions(+), 18 deletions(-)
 rename include/erofs/cache.h => lib/liberofs_cache.h (92%)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index a609fbd..ea58584 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -537,6 +537,9 @@ static inline int erofs_blk_read(struct erofs_sb_info *sbi, int device_id,
 /* vmdk.c */
 int erofs_dump_vmdk_desc(FILE *f, struct erofs_sb_info *sbi);
 
+/* XXX: will find a better way later */
+erofs_blk_t erofs_total_metablocks(struct erofs_bufmgr *bmgr);
+
 #ifdef EUCLEAN
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 #else
diff --git a/lib/Makefile.am b/lib/Makefile.am
index f485440..955495d 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -4,7 +4,6 @@ noinst_LTLIBRARIES = liberofs.la
 noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/blobchunk.h \
       $(top_srcdir)/include/erofs/block_list.h \
-      $(top_srcdir)/include/erofs/cache.h \
       $(top_srcdir)/include/erofs/compress.h \
       $(top_srcdir)/include/erofs/config.h \
       $(top_srcdir)/include/erofs/decompress.h \
@@ -28,6 +27,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/fragments.h \
       $(top_srcdir)/include/erofs/rebuild.h \
       $(top_srcdir)/include/erofs/importer.h \
+      $(top_srcdir)/lib/liberofs_cache.h \
       $(top_srcdir)/lib/liberofs_private.h \
       $(top_srcdir)/lib/liberofs_xxhash.h \
       $(top_srcdir)/lib/liberofs_metabox.h \
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 157b9a9..af6ddd7 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -8,7 +8,7 @@
 #include "erofs/hashmap.h"
 #include "erofs/blobchunk.h"
 #include "erofs/block_list.h"
-#include "erofs/cache.h"
+#include "liberofs_cache.h"
 #include "liberofs_private.h"
 #include "sha256.h"
 #include <unistd.h>
diff --git a/lib/cache.c b/lib/cache.c
index cd11737..24449f2 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -6,9 +6,9 @@
  * with heavy changes by Gao Xiang <xiang@kernel.org>
  */
 #include <stdlib.h>
-#include <erofs/cache.h>
 #include <erofs/bitops.h>
 #include "erofs/print.h"
+#include "liberofs_cache.h"
 
 static int erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
 {
diff --git a/lib/compress.c b/lib/compress.c
index 0049199..622a205 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -15,7 +15,6 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include "erofs/print.h"
-#include "erofs/cache.h"
 #include "erofs/compress.h"
 #include "erofs/dedupe.h"
 #include "compressor.h"
@@ -25,6 +24,7 @@
 #ifdef EROFS_MT_ENABLED
 #include "erofs/workqueue.h"
 #endif
+#include "liberofs_cache.h"
 #include "liberofs_metabox.h"
 
 #define Z_EROFS_DESTBUF_SZ	(Z_EROFS_PCLUSTER_MAX_SIZE + EROFS_MAX_BLOCK_SIZE * 2)
diff --git a/lib/importer.c b/lib/importer.c
index 95f006d..9c57c07 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -4,12 +4,12 @@
  */
 #include "erofs/fragments.h"
 #include "erofs/importer.h"
-#include "erofs/cache.h"
 #include "erofs/config.h"
 #include "erofs/dedupe.h"
 #include "erofs/inode.h"
 #include "erofs/print.h"
 #include "erofs/lock.h"
+#include "liberofs_cache.h"
 #include "liberofs_metabox.h"
 
 static EROFS_DEFINE_MUTEX(erofs_importer_global_mutex);
diff --git a/lib/inode.c b/lib/inode.c
index 302492c..7ee6b3d 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -19,7 +19,6 @@
 #include "erofs/lock.h"
 #include "erofs/diskbuf.h"
 #include "erofs/inode.h"
-#include "erofs/cache.h"
 #include "erofs/compress.h"
 #include "erofs/xattr.h"
 #include "erofs/exclude.h"
@@ -28,6 +27,7 @@
 #include "erofs/blobchunk.h"
 #include "erofs/fragments.h"
 #include "erofs/importer.h"
+#include "liberofs_cache.h"
 #include "liberofs_private.h"
 #include "liberofs_metabox.h"
 
diff --git a/include/erofs/cache.h b/lib/liberofs_cache.h
similarity index 92%
rename from include/erofs/cache.h
rename to lib/liberofs_cache.h
index c248b73..215b320 100644
--- a/include/erofs/cache.h
+++ b/lib/liberofs_cache.h
@@ -1,12 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
- *             http://www.huawei.com/
- * Created by Miao Xie <miaoxie@huawei.com>
- * with heavy changes by Gao Xiang <xiang@kernel.org>
+ *             http://www.huawei.com
+ * Copyright (C) 2025 Alibaba Cloud
  */
-#ifndef __EROFS_CACHE_H
-#define __EROFS_CACHE_H
+#ifndef __EROFS_LIB_LIBEROFS_CACHE_H
+#define __EROFS_LIB_LIBEROFS_CACHE_H
 
 #ifdef __cplusplus
 extern "C"
@@ -14,7 +13,7 @@ extern "C"
 #endif
 
 #include <stdlib.h>
-#include "internal.h"
+#include "erofs/internal.h"
 
 struct erofs_buffer_head;
 struct erofs_buffer_block;
@@ -139,7 +138,6 @@ int erofs_bflush(struct erofs_bufmgr *bmgr,
 		 struct erofs_buffer_block *bb);
 
 void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
-erofs_blk_t erofs_total_metablocks(struct erofs_bufmgr *bmgr);
 void erofs_buffer_exit(struct erofs_bufmgr *bmgr);
 
 #ifdef __cplusplus
diff --git a/lib/metabox.c b/lib/metabox.c
index c9db9ac..fdc46eb 100644
--- a/lib/metabox.c
+++ b/lib/metabox.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 #include <stdlib.h>
-#include "erofs/cache.h"
 #include "erofs/inode.h"
 #include "erofs/importer.h"
+#include "liberofs_cache.h"
 #include "liberofs_private.h"
 #include "liberofs_metabox.h"
 
diff --git a/lib/super.c b/lib/super.c
index 97d955f..a9ec3aa 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -6,7 +6,7 @@
 #include <stdlib.h>
 #include "erofs/print.h"
 #include "erofs/xattr.h"
-#include "erofs/cache.h"
+#include "liberofs_cache.h"
 
 static bool check_layout_compatibility(struct erofs_sb_info *sbi,
 				       struct erofs_super_block *dsb)
diff --git a/lib/tar.c b/lib/tar.c
index 95129b3..fe801e2 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -4,7 +4,6 @@
 #include <string.h>
 #include <sys/stat.h>
 #include "erofs/print.h"
-#include "erofs/cache.h"
 #include "erofs/diskbuf.h"
 #include "erofs/inode.h"
 #include "erofs/list.h"
@@ -16,6 +15,7 @@
 #if defined(HAVE_ZLIB)
 #include <zlib.h>
 #endif
+#include "liberofs_cache.h"
 
 /* This file is a tape/volume header.  Ignore it on extraction.  */
 #define GNUTYPE_VOLHDR 'V'
diff --git a/lib/xattr.c b/lib/xattr.c
index 1f6a83f..114e2bb 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -15,8 +15,8 @@
 #include "erofs/print.h"
 #include "erofs/hashtable.h"
 #include "erofs/xattr.h"
-#include "erofs/cache.h"
 #include "erofs/fragments.h"
+#include "liberofs_cache.h"
 #include "liberofs_xxhash.h"
 #include "liberofs_private.h"
 
diff --git a/mkfs/main.c b/mkfs/main.c
index d2950b7..e0ba55d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -15,7 +15,6 @@
 #include <getopt.h>
 #include "erofs/config.h"
 #include "erofs/print.h"
-#include "erofs/cache.h"
 #include "erofs/importer.h"
 #include "erofs/diskbuf.h"
 #include "erofs/inode.h"
-- 
2.43.5


