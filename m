Return-Path: <linux-erofs+bounces-1078-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C068B948EA
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 08:29:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW96n5Vr0z3cYP;
	Tue, 23 Sep 2025 16:29:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758608945;
	cv=none; b=UAiJ2xwMXwGALIrQ6Af6QFEe8DOtSuZqvfIJQOLCweszL4N/nB9s+OZsgd9shwDJEKF9Vsgs57XagRFRz0AHrI40NYvjS84WViqYmPl3rr9w3SgOPFJHv0KquMYxqvn9EI6kLKIHq63PZlnzyZPywR9kBljTkpbB2yz8yzlFQzb9rGK2458AwlfdWlC6fcpuaPKq75x67eVC0hSF+9I5lons4s4qyJAmtTeIHQcfSBR7dXAyZNt+G12k9Ola6YPmgZmELOlov9PrzjWXv7UzkEKDtfaUHajToyjMXOF47ZlFZSlx7FiRqxsqdu9TWG3qqsKBWrWI7EqJpSqMUKw1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758608945; c=relaxed/relaxed;
	bh=R7qgMZbbQuFx5yetY11ZSTle8sHE/fUOIr1yaNTUmUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KxzT0WGBx77TBhEttevpPyXGIxLpcXzANVgpQIt6x2ZJH0PWeUmj9svKBeXl6MV3NW4rlt7qYNYO8D3iCZlhFR6KU9ShlJrvajbluLvDiXp5Ikbd3oHe9U9QmmmmG6L9fiLmEEeZX4v9y/+7Cqvpj6NAxprFsW09z5ySV0XzGq7Azk3grNDbo/JVZY83ibBzvAD00J/Ty3XlCg1E0pZtLee3g0XoWkdAbMcQVkXFdormq5ZNwDAxNkVZFIB2puBqDQd5LQgV0++9vUObwMU20eRFzIniJRA5OlODHKYGk//Xzr2RhXwCha9vu7TE69YWOhMYqj371TjUmNuD0VuL2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BvHWoWR+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BvHWoWR+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cW96k2xBLz2ysc
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 16:29:00 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758608936; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=R7qgMZbbQuFx5yetY11ZSTle8sHE/fUOIr1yaNTUmUs=;
	b=BvHWoWR+uI6tWBTxUJZTb0+csHY2gFbaMtf06PlGctqU8U5nI9GSU1X/j9zpooq022yUeVIEJDSfpTASqQKbAilqNdzQ7BPkD7TIS5D+DEf6xXiySQ3+q+Fkv60prquY8z+xBM+5N7K7NnBotAfzzq6DU8sKGJUzEncRPmpvr58=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wodx0M9_1758608929 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 14:28:55 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/4] erofs-utils: lib: unexport "erofs/compress.h"
Date: Tue, 23 Sep 2025 14:28:45 +0800
Message-ID: <20250923062848.1712858-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

It shouldn't be used by external users directly.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c                                     |  3 +--
 fsck/main.c                                     |  2 +-
 lib/Makefile.am                                 |  2 +-
 lib/compress.c                                  |  2 +-
 lib/fragments.c                                 |  2 +-
 lib/inode.c                                     |  2 +-
 .../erofs/compress.h => lib/liberofs_compress.h | 17 ++++-------------
 mkfs/main.c                                     | 12 ++++++------
 8 files changed, 16 insertions(+), 26 deletions(-)
 rename include/erofs/compress.h => lib/liberofs_compress.h (80%)

diff --git a/dump/main.c b/dump/main.c
index b818a4a..58d489c 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -13,12 +13,11 @@
 #include "erofs/print.h"
 #include "erofs/inode.h"
 #include "erofs/dir.h"
-#include "erofs/compress.h"
 #include "erofs/fragments.h"
+#include "../lib/liberofs_compress.h"
 #include "../lib/liberofs_private.h"
 #include "../lib/liberofs_uuid.h"
 
-
 struct erofsdump_cfg {
 	unsigned int totalshow;
 	bool show_inode;
diff --git a/fsck/main.c b/fsck/main.c
index 505c631..a1cb0cd 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -11,11 +11,11 @@
 #include <sys/stat.h>
 #include <sys/xattr.h>
 #include "erofs/print.h"
-#include "erofs/compress.h"
 #include "erofs/decompress.h"
 #include "erofs/dir.h"
 #include "erofs/xattr.h"
 #include "../lib/compressor.h"
+#include "../lib/liberofs_compress.h"
 #include "erofs/fragments.h"
 
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 72aa0e8..7487433 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -4,7 +4,6 @@ noinst_LTLIBRARIES = liberofs.la
 noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/blobchunk.h \
       $(top_srcdir)/include/erofs/block_list.h \
-      $(top_srcdir)/include/erofs/compress.h \
       $(top_srcdir)/include/erofs/config.h \
       $(top_srcdir)/include/erofs/decompress.h \
       $(top_srcdir)/include/erofs/defs.h \
@@ -29,6 +28,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/importer.h \
       $(top_srcdir)/lib/liberofs_base64.h \
       $(top_srcdir)/lib/liberofs_cache.h \
+      $(top_srcdir)/lib/liberofs_compress.h \
       $(top_srcdir)/lib/liberofs_private.h \
       $(top_srcdir)/lib/liberofs_xxhash.h \
       $(top_srcdir)/lib/liberofs_gzran.h \
diff --git a/lib/compress.c b/lib/compress.c
index dd537ec..8266c56 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -15,7 +15,6 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include "erofs/print.h"
-#include "erofs/compress.h"
 #include "erofs/dedupe.h"
 #include "compressor.h"
 #include "erofs/block_list.h"
@@ -25,6 +24,7 @@
 #include "erofs/workqueue.h"
 #endif
 #include "liberofs_cache.h"
+#include "liberofs_compress.h"
 #include "liberofs_metabox.h"
 
 #define Z_EROFS_DESTBUF_SZ	(Z_EROFS_PCLUSTER_MAX_SIZE + EROFS_MAX_BLOCK_SIZE * 2)
diff --git a/lib/fragments.c b/lib/fragments.c
index 5e93f48..6a30785 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -14,13 +14,13 @@
 #include <sys/mman.h>
 #include "erofs/err.h"
 #include "erofs/inode.h"
-#include "erofs/compress.h"
 #include "erofs/print.h"
 #include "erofs/internal.h"
 #include "erofs/fragments.h"
 #include "erofs/bitops.h"
 #include "erofs/lock.h"
 #include "erofs/importer.h"
+#include "liberofs_compress.h"
 #include "liberofs_private.h"
 #ifdef HAVE_SYS_SENDFILE_H
 #include <sys/sendfile.h>
diff --git a/lib/inode.c b/lib/inode.c
index 0811c97..fef7128 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -19,7 +19,6 @@
 #include "erofs/lock.h"
 #include "erofs/diskbuf.h"
 #include "erofs/inode.h"
-#include "erofs/compress.h"
 #include "erofs/xattr.h"
 #include "erofs/exclude.h"
 #include "erofs/block_list.h"
@@ -28,6 +27,7 @@
 #include "erofs/fragments.h"
 #include "erofs/importer.h"
 #include "liberofs_cache.h"
+#include "liberofs_compress.h"
 #include "liberofs_private.h"
 #include "liberofs_metabox.h"
 
diff --git a/include/erofs/compress.h b/lib/liberofs_compress.h
similarity index 80%
rename from include/erofs/compress.h
rename to lib/liberofs_compress.h
index 00e7715..907c6d4 100644
--- a/include/erofs/compress.h
+++ b/lib/liberofs_compress.h
@@ -2,17 +2,12 @@
 /*
  * Copyright (C) 2019 HUAWEI, Inc.
  *             http://www.huawei.com/
- * Created by Gao Xiang <xiang@kernel.org>
+ * Copyright (C) 2025 Alibaba Cloud
  */
-#ifndef __EROFS_COMPRESS_H
-#define __EROFS_COMPRESS_H
+#ifndef __EROFS_LIB_LIBEROFS_COMPRESS_H
+#define __EROFS_LIB_LIBEROFS_COMPRESS_H
 
-#ifdef __cplusplus
-extern "C"
-{
-#endif
-
-#include "internal.h"
+#include "erofs/internal.h"
 
 #define EROFS_CONFIG_COMPR_MAX_SZ	(4000 * 1024)
 #define Z_EROFS_COMPR_QUEUE_SZ		(EROFS_CONFIG_COMPR_MAX_SZ * 2)
@@ -29,8 +24,4 @@ int z_erofs_compress_exit(struct erofs_sb_info *sbi);
 const char *z_erofs_list_supported_algorithms(int i, unsigned int *mask);
 const struct erofs_algorithm *z_erofs_list_available_compressors(int *i);
 
-#ifdef __cplusplus
-}
-#endif
-
 #endif
diff --git a/mkfs/main.c b/mkfs/main.c
index 50e2bdb..9703d8c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -19,7 +19,6 @@
 #include "erofs/diskbuf.h"
 #include "erofs/inode.h"
 #include "erofs/tar.h"
-#include "erofs/compress.h"
 #include "erofs/dedupe.h"
 #include "erofs/xattr.h"
 #include "erofs/exclude.h"
@@ -28,13 +27,14 @@
 #include "erofs/blobchunk.h"
 #include "erofs/fragments.h"
 #include "erofs/rebuild.h"
-#include "../lib/liberofs_private.h"
-#include "../lib/liberofs_uuid.h"
+#include "../lib/compressor.h"
+#include "../lib/liberofs_compress.h"
+#include "../lib/liberofs_gzran.h"
 #include "../lib/liberofs_metabox.h"
-#include "../lib/liberofs_s3.h"
 #include "../lib/liberofs_oci.h"
-#include "../lib/liberofs_gzran.h"
-#include "../lib/compressor.h"
+#include "../lib/liberofs_private.h"
+#include "../lib/liberofs_s3.h"
+#include "../lib/liberofs_uuid.h"
 
 static struct option long_options[] = {
 	{"version", no_argument, 0, 'V'},
-- 
2.43.5


