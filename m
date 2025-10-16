Return-Path: <linux-erofs+bounces-1186-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D46BE14F5
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Oct 2025 04:48:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnC7d2nD9z3bpS;
	Thu, 16 Oct 2025 13:48:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760582909;
	cv=none; b=GC26brO9xevZY3CDY4mtKudvkgvdhhMNZlHO5tbE+uDn2WDVk++s5s7NNNqRTl4a2l2RQiRnfdIgs2Ew2wYMgjXOunH6V1jBvhjrJAM8nccYwwYtWgQTT1YJ8AAWGLHuwTvigb9tKAvjCHnDk724dlfCv7jgng44CLivdhcJUOikAumr/n3NZOnrzMu8Kvm+skKfQ3q1j4Yplzwgg10xmTzoeDN6+y50f/af+tnpMBFRONU43JuOzGJrAeAX2j5wdnnQk54ZS7XkxDoXJW7PJXH6UVh6vA+1SZS0WlCOkDD6jn/8TLF0irUwuOusYiK0SaNM8WK7cDzpxR9bg5iSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760582909; c=relaxed/relaxed;
	bh=vHL6UmcX/02wCUi0vAZYVsBXoPBL7/UKDA5TKmv9HW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekMzZrgQ6lQENkwrgLHBKtm04k+1q0BVrsGBok7FvV7wd+kaYwKruRWzNvDCroVYEKCDkn0N3jeEykbc0WdqIE93tPGSZ05ejU6vcFyxiiOx0WQhlKlIOzlQKeSaMWlETxAA3tWnZuzs6d0gWi8/JMZ5g7g8bxXHwhKjkMM6UmDb5Y0ixqPezPJbTVhsFST6XI8iHc3qNj0HTMv/mGleQBHvenM7dQew1VyGtwkLKxz0/pTIcaagXen8jAlJ2uOyPgQN5W+sUR2oe9KoIjwwST7J6rs+8CDt9c1otN/CT8B4jxKGIPqx9c+VGCQVWSC8wNqstTobxzVeh3W/ilJpNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kWgGS61E; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kWgGS61E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnC7b2LNhz2yQH
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Oct 2025 13:48:26 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760582903; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vHL6UmcX/02wCUi0vAZYVsBXoPBL7/UKDA5TKmv9HW0=;
	b=kWgGS61Ew4lGXk0wk/Ofpi265PzuP/Dd+UT0jCQ/gD9uFNOg/aVMD+axK07qd4zeNSof3V6SXQZz+n+5vM0lwT3LNm8Iu4CuEZawwOIHVWnacahzsi802y+Jt4GACRdxMQJP1W/PrXI869wrdqBRvu9JLrkqgwshRhc8a6D+R60=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqIZVjD_1760582901 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Oct 2025 10:48:21 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/7] erofs-utils: lib: unexport "erofs/fragments.h"
Date: Thu, 16 Oct 2025 10:48:11 +0800
Message-ID: <20251016024815.2750927-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251016024815.2750927-1-hsiangkao@linux.alibaba.com>
References: <20251016024815.2750927-1-hsiangkao@linux.alibaba.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Disallow external users to use those internal APIs.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c                                   |  1 -
 fsck/main.c                                   |  1 -
 fuse/main.c                                   |  1 -
 include/erofs/internal.h                      | 14 +++++++++
 lib/Makefile.am                               |  2 +-
 lib/compress.c                                |  2 +-
 lib/data.c                                    |  2 +-
 lib/fragments.c                               |  2 +-
 lib/importer.c                                |  2 +-
 lib/inode.c                                   |  4 +--
 .../fragments.h => lib/liberofs_fragments.h   | 30 +++----------------
 lib/xattr.c                                   |  2 +-
 mkfs/main.c                                   |  1 -
 13 files changed, 26 insertions(+), 38 deletions(-)
 rename include/erofs/fragments.h => lib/liberofs_fragments.h (50%)

diff --git a/dump/main.c b/dump/main.c
index 4ad3f7b..57ec3b7 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -13,7 +13,6 @@
 #include "erofs/print.h"
 #include "erofs/inode.h"
 #include "erofs/dir.h"
-#include "erofs/fragments.h"
 #include "../lib/liberofs_compress.h"
 #include "../lib/liberofs_private.h"
 #include "../lib/liberofs_uuid.h"
diff --git a/fsck/main.c b/fsck/main.c
index a1cb0cd..8aba964 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -16,7 +16,6 @@
 #include "erofs/xattr.h"
 #include "../lib/compressor.h"
 #include "../lib/liberofs_compress.h"
-#include "erofs/fragments.h"
 
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
 
diff --git a/fuse/main.c b/fuse/main.c
index c129a0c..82aca8c 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -12,7 +12,6 @@
 #include "erofs/print.h"
 #include "erofs/dir.h"
 #include "erofs/inode.h"
-#include "erofs/fragments.h"
 
 #include <float.h>
 #include <fuse.h>
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 4de6563..6106501 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -535,6 +535,20 @@ static inline int erofs_blk_read(struct erofs_sb_info *sbi, int device_id,
 /* vmdk.c */
 int erofs_dump_vmdk_desc(FILE *f, struct erofs_sb_info *sbi);
 
+extern const char *erofs_frags_packedname;
+#define EROFS_PACKED_INODE	erofs_frags_packedname
+
+static inline bool erofs_is_packed_inode(struct erofs_inode *inode)
+{
+	return inode->i_srcpath == EROFS_PACKED_INODE;
+}
+
+int erofs_packedfile_init(struct erofs_sb_info *sbi, bool fragments_mkfs);
+void erofs_packedfile_exit(struct erofs_sb_info *sbi);
+
+int erofs_packedfile_read(struct erofs_sb_info *sbi,
+			  void *buf, erofs_off_t len, erofs_off_t pos);
+
 /* XXX: will find a better way later */
 erofs_blk_t erofs_total_metablocks(struct erofs_bufmgr *bmgr);
 
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 9991119..286932d 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -22,11 +22,11 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/trace.h \
       $(top_srcdir)/include/erofs/xattr.h \
       $(top_srcdir)/include/erofs/compress_hints.h \
-      $(top_srcdir)/include/erofs/fragments.h \
       $(top_srcdir)/include/erofs/importer.h \
       $(top_srcdir)/lib/liberofs_base64.h \
       $(top_srcdir)/lib/liberofs_cache.h \
       $(top_srcdir)/lib/liberofs_compress.h \
+      $(top_srcdir)/lib/liberofs_fragments.h \
       $(top_srcdir)/lib/liberofs_private.h \
       $(top_srcdir)/lib/liberofs_rebuild.h \
       $(top_srcdir)/lib/liberofs_xxhash.h \
diff --git a/lib/compress.c b/lib/compress.c
index 7f34b66..20f511e 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -19,12 +19,12 @@
 #include "compressor.h"
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
-#include "erofs/fragments.h"
 #ifdef EROFS_MT_ENABLED
 #include "erofs/workqueue.h"
 #endif
 #include "liberofs_cache.h"
 #include "liberofs_compress.h"
+#include "liberofs_fragments.h"
 #include "liberofs_metabox.h"
 
 #define Z_EROFS_DESTBUF_SZ	(Z_EROFS_PCLUSTER_MAX_SIZE + EROFS_MAX_BLOCK_SIZE * 2)
diff --git a/lib/data.c b/lib/data.c
index 6791fda..1e51134 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -8,7 +8,7 @@
 #include "erofs/internal.h"
 #include "erofs/trace.h"
 #include "erofs/decompress.h"
-#include "erofs/fragments.h"
+#include "liberofs_fragments.h"
 
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 {
diff --git a/lib/fragments.c b/lib/fragments.c
index 6a30785..244608f 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -16,11 +16,11 @@
 #include "erofs/inode.h"
 #include "erofs/print.h"
 #include "erofs/internal.h"
-#include "erofs/fragments.h"
 #include "erofs/bitops.h"
 #include "erofs/lock.h"
 #include "erofs/importer.h"
 #include "liberofs_compress.h"
+#include "liberofs_fragments.h"
 #include "liberofs_private.h"
 #ifdef HAVE_SYS_SENDFILE_H
 #include <sys/sendfile.h>
diff --git a/lib/importer.c b/lib/importer.c
index fed7bab..ad4bed8 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2025 Alibaba Cloud
  */
-#include "erofs/fragments.h"
 #include "erofs/importer.h"
 #include "erofs/config.h"
 #include "erofs/dedupe.h"
@@ -12,6 +11,7 @@
 #include "erofs/xattr.h"
 #include "liberofs_cache.h"
 #include "liberofs_compress.h"
+#include "liberofs_fragments.h"
 #include "liberofs_metabox.h"
 
 static EROFS_DEFINE_MUTEX(erofs_importer_global_mutex);
diff --git a/lib/inode.c b/lib/inode.c
index d16468d..14a65af 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -24,12 +24,12 @@
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
-#include "erofs/fragments.h"
 #include "erofs/importer.h"
 #include "liberofs_cache.h"
 #include "liberofs_compress.h"
-#include "liberofs_private.h"
+#include "liberofs_fragments.h"
 #include "liberofs_metabox.h"
+#include "liberofs_private.h"
 #include "liberofs_rebuild.h"
 
 static inline bool erofs_is_special_identifier(const char *path)
diff --git a/include/erofs/fragments.h b/lib/liberofs_fragments.h
similarity index 50%
rename from include/erofs/fragments.h
rename to lib/liberofs_fragments.h
index 00e1e46..ca71e52 100644
--- a/include/erofs/fragments.h
+++ b/lib/liberofs_fragments.h
@@ -1,25 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 /*
- * Copyright (C), 2022, Coolpad Group Limited.
+ * Copyright (C) 2022, Coolpad Group Limited.
+ * Copyright (C) 2025 Alibaba Cloud
  */
-#ifndef __EROFS_FRAGMENTS_H
-#define __EROFS_FRAGMENTS_H
-
-#ifdef __cplusplus
-extern "C"
-{
-#endif
+#ifndef __EROFS_LIB_LIBEROFS_FRAGMENTS_H
+#define __EROFS_LIB_LIBEROFS_FRAGMENTS_H
 
 #include "erofs/internal.h"
 
-extern const char *erofs_frags_packedname;
-#define EROFS_PACKED_INODE	erofs_frags_packedname
-
-static inline bool erofs_is_packed_inode(struct erofs_inode *inode)
-{
-	return inode->i_srcpath == EROFS_PACKED_INODE;
-}
-
 struct erofs_importer;
 
 u32 z_erofs_fragments_tofh(struct erofs_inode *inode, int fd, erofs_off_t fpos);
@@ -32,14 +20,4 @@ int erofs_fragment_commit(struct erofs_inode *inode, u32 tofh);
 int erofs_flush_packed_inode(struct erofs_importer *im);
 int erofs_packedfile(struct erofs_sb_info *sbi);
 
-int erofs_packedfile_init(struct erofs_sb_info *sbi, bool fragments_mkfs);
-void erofs_packedfile_exit(struct erofs_sb_info *sbi);
-
-int erofs_packedfile_read(struct erofs_sb_info *sbi,
-			  void *buf, erofs_off_t len, erofs_off_t pos);
-
-#ifdef __cplusplus
-}
-#endif
-
 #endif
diff --git a/lib/xattr.c b/lib/xattr.c
index e02e8cb..fc22c81 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -15,9 +15,9 @@
 #include "erofs/print.h"
 #include "erofs/list.h"
 #include "erofs/xattr.h"
-#include "erofs/fragments.h"
 #include "erofs/importer.h"
 #include "liberofs_cache.h"
+#include "liberofs_fragments.h"
 #include "liberofs_metabox.h"
 #include "liberofs_xxhash.h"
 #include "liberofs_private.h"
diff --git a/mkfs/main.c b/mkfs/main.c
index 5657b1d..11e3032 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -25,7 +25,6 @@
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
-#include "erofs/fragments.h"
 #include "../lib/compressor.h"
 #include "../lib/liberofs_gzran.h"
 #include "../lib/liberofs_metabox.h"
-- 
2.43.5


