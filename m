Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C3F71A10E
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Jun 2023 16:54:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QX8Kx4c5bz3dt9
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 00:54:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QX8Ks28FXz3cdK
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Jun 2023 00:54:22 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vk6QxIe_1685631242;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vk6QxIe_1685631242)
          by smtp.aliyun-inc.com;
          Thu, 01 Jun 2023 22:54:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: support detecting maximum block size
Date: Thu,  1 Jun 2023 22:53:59 +0800
Message-Id: <20230601145359.103536-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <036ee477-af3c-14dd-8311-b9117f056542@linux.alibaba.com>
References: <036ee477-af3c-14dd-8311-b9117f056542@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Previously PAGE_SIZE was actually unset for most cases so that it was
always hard-coded 4096.

In order to set EROFS_MAX_BLOCK_SIZE correctly, let's detect the real
page size when configuring and get rid of PAGE_SIZE.

Cc: Kelvin Zhang <zhangkelvin@google.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
change since v1:
 - get rid of PAGE_SIZE (Kelvin);

 configure.ac             | 38 ++++++++++++++++++++++++++++++++++++++
 include/erofs/internal.h | 10 ++--------
 lib/namei.c              |  2 +-
 mkfs/main.c              |  4 ++--
 4 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4dbe86f..2ade490 100644
--- a/configure.ac
+++ b/configure.ac
@@ -59,6 +59,8 @@ AC_DEFUN([EROFS_UTILS_PARSE_DIRECTORY],
  fi
 ])
 
+AC_ARG_VAR([MAX_BLOCK_SIZE], [The maximum block size which erofs-utils supports])
+
 AC_ARG_ENABLE([debug],
     [AS_HELP_STRING([--enable-debug],
                     [enable debugging mode @<:@default=no@:>@])],
@@ -202,6 +204,35 @@ AC_CHECK_FUNCS(m4_flatten([
 	tmpfile64
 	utimensat]))
 
+# Detect maximum block size if necessary
+AS_IF([test "x$MAX_BLOCK_SIZE" = "x"], [
+  AC_CACHE_CHECK([sysconf (_SC_PAGESIZE)], [erofs_cv_max_block_size],
+               AC_RUN_IFELSE([AC_LANG_PROGRAM(
+[[
+#include <unistd.h>
+#include <stdio.h>
+]],
+[[
+    int result;
+    FILE *f;
+
+    result = sysconf(_SC_PAGESIZE);
+    if (result < 0)
+	return 1;
+
+    f = fopen("conftest.out", "w");
+    if (!f)
+	return 1;
+
+    fprintf(f, "%d", result);
+    fclose(f);
+    return 0;
+]])],
+                             [erofs_cv_max_block_size=`cat conftest.out`],
+                             [],
+                             []))
+], [erofs_cv_max_block_size=$MAX_BLOCK_SIZE])
+
 # Configure debug mode
 AS_IF([test "x$enable_debug" != "xno"], [], [
   dnl Turn off all assert checking.
@@ -367,6 +398,13 @@ if test "x${have_liblzma}" = "xyes"; then
   AC_SUBST([liblzma_CFLAGS])
 fi
 
+# Dump maximum block size
+AS_IF([test "x$erofs_cv_max_block_size" = "x"],
+      [$erofs_cv_max_block_size = 4096], [])
+
+AC_DEFINE_UNQUOTED([EROFS_MAX_BLOCK_SIZE], [$erofs_cv_max_block_size],
+		   [The maximum block size which erofs-utils supports])
+
 AC_CONFIG_FILES([Makefile
 		 man/Makefile
 		 lib/Makefile
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index b3d04be..370cfac 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -27,16 +27,10 @@ typedef unsigned short umode_t;
 #define PATH_MAX        4096    /* # chars in a path name including nul */
 #endif
 
-#ifndef PAGE_SHIFT
-#define PAGE_SHIFT		(12)
+#ifndef EROFS_MAX_BLOCK_SIZE
+#define EROFS_MAX_BLOCK_SIZE	4096
 #endif
 
-#ifndef PAGE_SIZE
-#define PAGE_SIZE		(1U << PAGE_SHIFT)
-#endif
-
-#define EROFS_MAX_BLOCK_SIZE	PAGE_SIZE
-
 #define EROFS_ISLOTBITS		5
 #define EROFS_SLOTSIZE		(1U << EROFS_ISLOTBITS)
 
diff --git a/lib/namei.c b/lib/namei.c
index 3d0cf93..3751741 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -137,7 +137,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->u.chunkbits = sbi.blkszbits +
 			(vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	} else if (erofs_inode_is_data_compressed(vi->datalayout)) {
-		if (erofs_blksiz() != PAGE_SIZE)
+		if (erofs_blksiz() != EROFS_MAX_BLOCK_SIZE)
 			return -EOPNOTSUPP;
 		return z_erofs_fill_inode(vi);
 	}
diff --git a/mkfs/main.c b/mkfs/main.c
index 3ec4903..a6a2d0e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -532,7 +532,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		cfg.c_dbg_lvl = EROFS_ERR;
 		cfg.c_showprogress = false;
 	}
-	if (cfg.c_compr_alg[0] && erofs_blksiz() != PAGE_SIZE) {
+	if (cfg.c_compr_alg[0] && erofs_blksiz() != EROFS_MAX_BLOCK_SIZE) {
 		erofs_err("compression is unsupported for now with block size %u",
 			  erofs_blksiz());
 		return -EINVAL;
@@ -670,7 +670,7 @@ static void erofs_mkfs_default_options(void)
 {
 	cfg.c_showprogress = true;
 	cfg.c_legacy_compress = false;
-	sbi.blkszbits = ilog2(PAGE_SIZE);
+	sbi.blkszbits = ilog2(EROFS_MAX_BLOCK_SIZE);
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
 	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
 			     EROFS_FEATURE_COMPAT_MTIME;
-- 
2.24.4

