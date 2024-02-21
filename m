Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D788485D01F
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Feb 2024 06:52:07 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QtoNIVut;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tflln5Pgcz3cFf
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Feb 2024 16:52:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QtoNIVut;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tfllf57yYz3bqh
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Feb 2024 16:51:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708494711; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7E+siCnMik/l+oHEf3rZ0JLaW8QljyyfGjK+kOyDzhg=;
	b=QtoNIVutelw68GanHiu6KAZjzWrIffls5gEIy6uZH8V+gr4yfurOkM+J12MtBukooqT+Po06iuDsqKMl+w3GnS7WM2NOHouKTMGntKETHBPGCvfXgsVZE9KJayyfbwQzsRDWThEkyxHTNWSmciMUth/5FyTtTMJa8AI5Avo3DoI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W0ywcNe_1708494706;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W0ywcNe_1708494706)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 13:51:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs-utils: support liblzma auto-detection
Date: Wed, 21 Feb 2024 13:51:44 +0800
Message-Id: <20240221055144.4054806-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240220171700.3693176-2-hsiangkao@linux.alibaba.com>
References: <20240220171700.3693176-2-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The new XZ Utils 5.4 is now available in most Linux distributions.

Let's enable liblzma auto-detection as well as get rid of MicroLZMA
EXPERIMENTAL warning.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - fix build errors:
   https://github.com/erofs/erofsnightly/actions/runs/7982759356
   https://github.com/erofs/erofsnightly/actions/runs/7982793191
 configure.ac             | 53 +++++++++++++++++-----------------------
 lib/compressor_liblzma.c |  3 +--
 2 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/configure.ac b/configure.ac
index cd14beb..6530ee4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -119,8 +119,8 @@ AC_ARG_ENABLE(lz4,
    [enable_lz4="$enableval"], [enable_lz4="yes"])
 
 AC_ARG_ENABLE(lzma,
-   [AS_HELP_STRING([--enable-lzma], [enable LZMA compression support @<:@default=no@:>@])],
-   [enable_lzma="$enableval"], [enable_lzma="no"])
+   [AS_HELP_STRING([--disable-lzma], [disable LZMA compression support @<:@default=auto@:>@])],
+   [enable_lzma="$enableval"])
 
 AC_ARG_WITH(zlib,
    [AS_HELP_STRING([--without-zlib],
@@ -161,14 +161,6 @@ AC_ARG_WITH(lz4-libdir,
 AC_ARG_VAR([LZ4_CFLAGS], [C compiler flags for lz4])
 AC_ARG_VAR([LZ4_LIBS], [linker flags for lz4])
 
-AC_ARG_WITH(liblzma-incdir,
-   [AS_HELP_STRING([--with-liblzma-incdir=DIR], [liblzma include directory])], [
-   EROFS_UTILS_PARSE_DIRECTORY(["$withval"],[withval])])
-
-AC_ARG_WITH(liblzma-libdir,
-   [AS_HELP_STRING([--with-liblzma-libdir=DIR], [liblzma lib directory])], [
-   EROFS_UTILS_PARSE_DIRECTORY(["$withval"],[withval])])
-
 # Checks for header files.
 AC_CHECK_HEADERS(m4_flatten([
 	dirent.h
@@ -400,30 +392,31 @@ if test "x$enable_lz4" = "xyes"; then
   CPPFLAGS=${saved_CPPFLAGS}
 fi
 
-if test "x$enable_lzma" = "xyes"; then
+# Configure liblzma
+have_liblzma="no"
+AS_IF([test "x$enable_lzma" != "xno"], [
   saved_CPPFLAGS=${CPPFLAGS}
-  test -z "${with_liblzma_incdir}" ||
-    CPPFLAGS="-I$with_liblzma_incdir $CPPFLAGS"
-  AC_CHECK_HEADERS([lzma.h],[have_lzmah="yes"], [])
-
-  if test "x${have_lzmah}" = "xyes" ; then
+  PKG_CHECK_MODULES([liblzma], [liblzma], [
+    # Paranoia: don't trust the result reported by pkgconfig before trying out
     saved_LIBS="$LIBS"
-    saved_LDFLAGS="$LDFLAGS"
-
-    test -z "${with_liblzma_libdir}" ||
-      LDFLAGS="-L$with_liblzma_libdir ${LDFLAGS}"
-    AC_CHECK_LIB(lzma, lzma_microlzma_encoder, [],
-      [AC_MSG_ERROR([Cannot find proper liblzma])])
-
-    AC_CHECK_DECL(lzma_microlzma_encoder, [have_liblzma="yes"],
-      [AC_MSG_ERROR([Cannot find proper liblzma])], [[
+    saved_CPPFLAGS=${CPPFLAGS}
+    CPPFLAGS="${liblzma_CFLAGS} ${CPPFLAGS}"
+    LIBS="${liblzma_LIBS} $LIBS"
+    AC_CHECK_HEADERS([lzma.h],[
+      AC_CHECK_LIB(lzma, lzma_microlzma_encoder, [
+        AC_CHECK_DECL(lzma_microlzma_encoder, [have_liblzma="yes"],
+          [], [[
 #include <lzma.h>
-    ]])
-    LDFLAGS="${saved_LDFLAGS}"
+        ]])
+      ])
+    ])
     LIBS="${saved_LIBS}"
-  fi
-  CPPFLAGS="${saved_CPPFLAGS}"
-fi
+    CPPFLAGS="${saved_CPPFLAGS}"
+  ])
+  AS_IF([test "x$enable_lzma" = "xyes" -a "x$have_liblzma" != "xyes"], [
+    AC_MSG_ERROR([Cannot find proper liblzma])
+  ])
+])
 
 # Configure zlib
 have_zlib="no"
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index 7183b0b..712f44f 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -103,8 +103,7 @@ static int erofs_compressor_liblzma_init(struct erofs_compress *c)
 	ctx->opt.dict_size = c->dict_size;
 
 	c->private_data = ctx;
-	erofs_warn("EXPERIMENTAL MicroLZMA feature in use. Use at your own risk!");
-	erofs_warn("Note that it may take more time since the compressor is still single-threaded for now.");
+	erofs_warn("It may take a longer time since MicroLZMA is still single-threaded for now.");
 	return 0;
 }
 
-- 
2.39.3

