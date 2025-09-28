Return-Path: <linux-erofs+bounces-1124-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B3BBA6906
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Sep 2025 08:32:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cZDym5QcXz3cQx;
	Sun, 28 Sep 2025 16:32:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759041168;
	cv=none; b=fy9juTIfgDnLoZlLui9dZ/KL61thsJo7TITQvt9A+rt4AMfUBHtQtscJsjhqfmUfw2foUqtOwp3gZyf2VKpn/8yw901asw4ZFFsnwgXhxP3iFkCW+taqwCPzQZDrPuGTT/2EJ4SBwCXhJ0Df3Nrxk52WFRVxUsyJfPj0j3MLGIJOGMKWjbpMpfVfXdQ4kC7Z0uWn0hQh3NDrAqJZ+gbLYLcM/IRrzaiFz5YgCjdgNw6ZDvmZzyjwN376eXy6iI9/fZ9/6F41PxVGqn4VaTM46aPghuS/bf38FSGIHg0pgC94mO5gYaLbaka7Xcy/xpGTvD+canu5DL3KJAucMaHrbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759041168; c=relaxed/relaxed;
	bh=VHYIiuPCNUa+Jej9CBb4YqnIk01t8t39i5SVrb0m1yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GntCdCsoDY1gqsllddr0P8eX+sJnJaLg3W/Sq6Cz5/snjVnSXllR8Ew2BoWl++PWu/u8BLYNXoWLcBpMDoFpLtiZIsp5itFqAaxa0GsYg26WzUjvyJHyg/EiGDNT+1mcxsX/3qaPgODD0JkRhQHgjtFof3RssjaqHdrPhLbXmoBfagQE5o66ffREPayxgVhx2kHt/P46TlNmK5ix+WkyZGDEWa5oznGqtSTumz7JXBTM6Awok8lMm+CEFImdUO4EN+8MiFygSmMjMOMEx2ZVRszt0PvyHdZppV9brEFn1NLtJDENFkNrkI12xXEAkA1kHK4VUKkpUUrgrLofU6/Lyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tD0wnHJz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tD0wnHJz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cZDyk0bb4z2yrW
	for <linux-erofs@lists.ozlabs.org>; Sun, 28 Sep 2025 16:32:44 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759041159; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VHYIiuPCNUa+Jej9CBb4YqnIk01t8t39i5SVrb0m1yA=;
	b=tD0wnHJz3h4HhL7gjI56mZbTzSpk6mVGJjN3cfLSoEdpeRnfah1buP+Me3ANvPI35m4RfaSyRg9SPdNF7Pb8vmDWhuKUhD7lBmD2oAcwhtOn4KcNhQWx4xqnB1Xo9eNWsPnAhdiX9UoMJa3t/7jzuV0tHJX9yEFDGepUeah+ziU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Woy6mLF_1759041158 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 28 Sep 2025 14:32:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/3] erofs-utils: lib: unexport "erofs/rebuild.h"
Date: Sun, 28 Sep 2025 14:32:31 +0800
Message-ID: <20250928063232.2613721-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928063232.2613721-1-hsiangkao@linux.alibaba.com>
References: <20250928063232.2613721-1-hsiangkao@linux.alibaba.com>
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

Disallow external users to use those unstable APIs for now.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/Makefile.am                                   |  2 +-
 lib/inode.c                                       |  3 +--
 include/erofs/rebuild.h => lib/liberofs_rebuild.h | 15 ++++-----------
 lib/rebuild.c                                     |  2 +-
 lib/remotes/s3.c                                  |  2 +-
 lib/tar.c                                         |  2 +-
 mkfs/main.c                                       |  2 +-
 7 files changed, 10 insertions(+), 18 deletions(-)
 rename include/erofs/rebuild.h => lib/liberofs_rebuild.h (73%)

diff --git a/lib/Makefile.am b/lib/Makefile.am
index 7487433..4c73012 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -24,12 +24,12 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/xattr.h \
       $(top_srcdir)/include/erofs/compress_hints.h \
       $(top_srcdir)/include/erofs/fragments.h \
-      $(top_srcdir)/include/erofs/rebuild.h \
       $(top_srcdir)/include/erofs/importer.h \
       $(top_srcdir)/lib/liberofs_base64.h \
       $(top_srcdir)/lib/liberofs_cache.h \
       $(top_srcdir)/lib/liberofs_compress.h \
       $(top_srcdir)/lib/liberofs_private.h \
+      $(top_srcdir)/lib/liberofs_rebuild.h \
       $(top_srcdir)/lib/liberofs_xxhash.h \
       $(top_srcdir)/lib/liberofs_gzran.h \
       $(top_srcdir)/lib/liberofs_metabox.h \
diff --git a/lib/inode.c b/lib/inode.c
index 0b5e77a..810ffc2 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -30,6 +30,7 @@
 #include "liberofs_compress.h"
 #include "liberofs_private.h"
 #include "liberofs_metabox.h"
+#include "liberofs_rebuild.h"
 
 static inline bool erofs_is_special_identifier(const char *path)
 {
@@ -1684,8 +1685,6 @@ err_closedir:
 	return ret;
 }
 
-int erofs_rebuild_load_basedir(struct erofs_inode *dir);
-
 bool erofs_dentry_is_wht(struct erofs_sb_info *sbi, struct erofs_dentry *d)
 {
 	if (!d->validnid)
diff --git a/include/erofs/rebuild.h b/lib/liberofs_rebuild.h
similarity index 73%
rename from include/erofs/rebuild.h
rename to lib/liberofs_rebuild.h
index 59b2f6f..1eb79cf 100644
--- a/include/erofs/rebuild.h
+++ b/lib/liberofs_rebuild.h
@@ -1,13 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
-#ifndef __EROFS_REBUILD_H
-#define __EROFS_REBUILD_H
+#ifndef __EROFS_LIB_LIBEROFS_REBUILD_H
+#define __EROFS_LIB_LIBEROFS_REBUILD_H
 
-#ifdef __cplusplus
-extern "C"
-{
-#endif
-
-#include "internal.h"
+#include "erofs/internal.h"
 
 enum erofs_rebuild_datamode {
 	EROFS_REBUILD_DATA_BLOB_INDEX,
@@ -21,8 +16,6 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
 			    enum erofs_rebuild_datamode mode);
 
-#ifdef __cplusplus
-}
-#endif
+int erofs_rebuild_load_basedir(struct erofs_inode *dir);
 
 #endif
diff --git a/lib/rebuild.c b/lib/rebuild.c
index e3c7eb8..83e30fd 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -10,11 +10,11 @@
 #endif
 #include "erofs/print.h"
 #include "erofs/inode.h"
-#include "erofs/rebuild.h"
 #include "erofs/dir.h"
 #include "erofs/xattr.h"
 #include "erofs/blobchunk.h"
 #include "erofs/internal.h"
+#include "liberofs_rebuild.h"
 #include "liberofs_uuid.h"
 
 #ifdef HAVE_LINUX_AUFS_TYPE_H
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 0296ef4..2e7763e 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -16,8 +16,8 @@
 #include "erofs/inode.h"
 #include "erofs/blobchunk.h"
 #include "erofs/diskbuf.h"
-#include "erofs/rebuild.h"
 #include "erofs/importer.h"
+#include "liberofs_rebuild.h"
 #include "liberofs_s3.h"
 
 #define S3EROFS_PATH_MAX		1024
diff --git a/lib/tar.c b/lib/tar.c
index 100efb3..139d1c5 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -10,7 +10,6 @@
 #include "erofs/tar.h"
 #include "erofs/xattr.h"
 #include "erofs/blobchunk.h"
-#include "erofs/rebuild.h"
 #include "erofs/importer.h"
 #if defined(HAVE_ZLIB)
 #include <zlib.h>
@@ -18,6 +17,7 @@
 #include "liberofs_base64.h"
 #include "liberofs_cache.h"
 #include "liberofs_gzran.h"
+#include "liberofs_rebuild.h"
 
 /* This file is a tape/volume header.  Ignore it on extraction.  */
 #define GNUTYPE_VOLHDR 'V'
diff --git a/mkfs/main.c b/mkfs/main.c
index fb69a5f..7a538bd 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -26,12 +26,12 @@
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
 #include "erofs/fragments.h"
-#include "erofs/rebuild.h"
 #include "../lib/compressor.h"
 #include "../lib/liberofs_gzran.h"
 #include "../lib/liberofs_metabox.h"
 #include "../lib/liberofs_oci.h"
 #include "../lib/liberofs_private.h"
+#include "../lib/liberofs_rebuild.h"
 #include "../lib/liberofs_s3.h"
 #include "../lib/liberofs_uuid.h"
 
-- 
2.43.5


