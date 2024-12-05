Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E14679E4C8C
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Dec 2024 04:09:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y3fVq4qZpz2yN8
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Dec 2024 14:09:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733368146;
	cv=none; b=Rk+x4rOk12rc9h6jgcBaQvf5YPuNb45BpjANFHAu+m6pp7W5Q6lY7wSW3r3dFF+sQp9/5o7LAmEr1JJTUHy8ehEnMR+1Jz9TzAx+7s/9HZ1Ud5ZlSfcGxwVlrtQycK/CYWNLAFgxr51EuYE9HPpPJpAi4UeLEULMsZik/siQjrOIEfKMcHP+bOfWrU6wKKQZgWqDmUFRgt+E4+LNI5Mq7Bl0OTOTQGhHx4Q9kQUv/wjLDUxQ61EwIfeNwaJtLMFTeFzcOiUJ/f8tU7Ue/6+0RG7VVp3ksiaJql2ldqPArXyXjnqpS+a6lwmyjyU/OL6c7QKLls0wrMbacY3xbzUMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733368146; c=relaxed/relaxed;
	bh=6kpqnhj8Hbll+qFTPtoWQD6Qv8WTwSGRX7gpKzzxyy8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cQVCHAIucqeZ21/FyJu6F+mFAH4Ft9ZrvgZXgrMwKg+S+YG1LvydKv1nw5Hd2i5HufvXvTNyTKXnAtZrl50sSGcisFZb7BIvVEVixGhLQ1igBqOi2r9gbEDibwMCc5PXDYMCuU5GBRbM4UvCNeR3GImwGL8cJi71ThggGFAKARc41RKImT4xuNl19t3uH3ndNs/2p7x9ixi5Mlkcol5ao18WTs9gMqLvr8DiHRGO8U1r3f6YUutRskuPrLru6Hj8miBegJ+pbDPuf4KDwHzxIJciOxxcvtU2YND03JcGhOF5yM1EQHHc9/zVq3A1JtdZrNg9ylxDG7YAROm7bOtxPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HsPhHJL5; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HsPhHJL5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y3fVk1Kn3z2y8p
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Dec 2024 14:08:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733368134; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6kpqnhj8Hbll+qFTPtoWQD6Qv8WTwSGRX7gpKzzxyy8=;
	b=HsPhHJL5Q1unISQur72PRHVQbHfKJ/y9H9Tzf5Ss7po/EL0BhHfCmm58bXRGiJDkqZer1Io+POWR1Dt9P/mEc2DOAdn4ImlUg1D9iaYpRiKQ3Si4uBM4orgtFMioqCEF8RmJmAx4oBH/Hc2r2kU/5nWN25Z9Imc3wJHYYQXqRjY=
Received: from localhost.localdomain(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKrYqkO_1733368127 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Dec 2024 11:08:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: use pkg-config for lz4 configuration
Date: Thu,  5 Dec 2024 11:08:46 +0800
Message-Id: <20241205030846.70656-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

Also obsolete those `LZ4_HC_STATIC_LINKING_ONLY` versions since it's
too complicated to be maintained.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac           | 71 +++++++++++++++---------------------------
 lib/Makefile.am        |  2 +-
 lib/compressor_lz4hc.c |  1 -
 3 files changed, 26 insertions(+), 48 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9c1657b..45a7d33 100644
--- a/configure.ac
+++ b/configure.ac
@@ -123,8 +123,8 @@ AC_ARG_ENABLE([fuzzing],
     [enable_fuzzing="no"])
 
 AC_ARG_ENABLE(lz4,
-   [AS_HELP_STRING([--disable-lz4], [disable LZ4 compression support @<:@default=enabled@:>@])],
-   [enable_lz4="$enableval"], [enable_lz4="yes"])
+   [AS_HELP_STRING([--disable-lz4], [disable LZ4 compression support @<:@default=auto@:>@])],
+   [enable_lz4="$enableval"])
 
 AC_ARG_ENABLE(lzma,
    [AS_HELP_STRING([--disable-lzma], [disable LZMA compression support @<:@default=auto@:>@])],
@@ -172,17 +172,6 @@ AC_ARG_WITH(selinux,
     esac], [with_selinux=no])
 
 # Checks for libraries.
-# Use customized LZ4 library path when specified.
-AC_ARG_WITH(lz4-incdir,
-   [AS_HELP_STRING([--with-lz4-incdir=DIR], [LZ4 include directory])], [
-   EROFS_UTILS_PARSE_DIRECTORY(["$withval"],[withval])])
-
-AC_ARG_WITH(lz4-libdir,
-   [AS_HELP_STRING([--with-lz4-libdir=DIR], [LZ4 lib directory])], [
-   EROFS_UTILS_PARSE_DIRECTORY(["$withval"],[withval])])
-
-AC_ARG_VAR([LZ4_CFLAGS], [C compiler flags for lz4])
-AC_ARG_VAR([LZ4_LIBS], [linker flags for lz4])
 
 # Checks for header files.
 AC_CHECK_HEADERS(m4_flatten([
@@ -396,36 +385,35 @@ AS_IF([test "x$enable_fuse" != "xno"], [
   CPPFLAGS="${saved_CPPFLAGS}"], [have_fuse="no"])
 
 # Configure lz4
-test -z $LZ4_LIBS && LZ4_LIBS='-llz4'
-
-if test "x$enable_lz4" = "xyes"; then
-  test -z "${with_lz4_incdir}" || LZ4_CFLAGS="-I$with_lz4_incdir $LZ4_CFLAGS"
-
+AS_IF([test "x$enable_lz4" != "xno"], [
   saved_CPPFLAGS=${CPPFLAGS}
-  CPPFLAGS="${LZ4_CFLAGS} ${CPPFLAGS}"
-
-  AC_CHECK_HEADERS([lz4.h],[have_lz4h="yes"], [])
-
-  if test "x${have_lz4h}" = "xyes" ; then
+  PKG_CHECK_MODULES([liblz4], [liblz4], [
+    # Paranoia: don't trust the result reported by pkgconfig before trying out
     saved_LIBS="$LIBS"
-    saved_LDFLAGS=${LDFLAGS}
-    test -z "${with_lz4_libdir}" || LDFLAGS="-L$with_lz4_libdir ${LDFLAGS}"
-    AC_CHECK_LIB(lz4, LZ4_compress_destSize, [
-      have_lz4="yes"
-      have_lz4hc="yes"
-      AC_CHECK_LIB(lz4, LZ4_compress_HC_destSize, [], [
-        AC_CHECK_DECL(LZ4_compress_HC_destSize, [lz4_force_static="yes"],
-          [have_lz4hc="no"], [[
-#define LZ4_HC_STATIC_LINKING_ONLY (1)
+    saved_CPPFLAGS=${CPPFLAGS}
+    CPPFLAGS="${liblz4_CFLAGS} ${CPPFLAGS}"
+    LIBS="${liblz4_LIBS} $LIBS"
+    AC_CHECK_HEADERS([lz4.h],[
+      AC_CHECK_LIB(lz4, LZ4_compress_destSize, [
+        AC_CHECK_DECL(LZ4_compress_destSize, [have_lz4="yes"],
+          [], [[
+#include <lz4.h>
+        ]])
+      ])
+      AC_CHECK_LIB(lz4, LZ4_compress_HC_destSize, [
+        AC_CHECK_DECL(LZ4_compress_HC_destSize, [have_lz4hc="yes"],
+          [], [[
 #include <lz4hc.h>
         ]])
       ])
-    ], [AC_MSG_ERROR([Cannot find proper lz4 version (>= 1.8.0)])])
-    LDFLAGS=${saved_LDFLAGS}
+    ])
     LIBS="${saved_LIBS}"
-  fi
-  CPPFLAGS=${saved_CPPFLAGS}
-fi
+    CPPFLAGS="${saved_CPPFLAGS}"
+  ], [[]])
+  AS_IF([test "x$enable_lz4" = "xyes" -a "x$have_lz4" != "xyes"], [
+    AC_MSG_ERROR([Cannot find a proper liblz4 version])
+  ])
+])
 
 # Configure liblzma
 have_liblzma="no"
@@ -581,16 +569,7 @@ if test "x${have_lz4}" = "xyes"; then
   if test "x${have_lz4hc}" = "xyes"; then
     AC_DEFINE([LZ4HC_ENABLED], [1], [Define to 1 if lz4hc is enabled.])
   fi
-
-  if test "x${lz4_force_static}" = "xyes"; then
-    LZ4_LIBS="-Wl,-Bstatic -Wl,-whole-archive -Xlinker ${LZ4_LIBS} -Wl,-no-whole-archive -Wl,-Bdynamic"
-    test -z "${with_lz4_libdir}" || LZ4_LIBS="-L${with_lz4_libdir} $LZ4_LIBS"
-  else
-    test -z "${with_lz4_libdir}" || LZ4_LIBS="-L${with_lz4_libdir} -R${with_lz4_libdir} $LZ4_LIBS"
-  fi
-  liblz4_LIBS="${LZ4_LIBS}"
 fi
-AC_SUBST([liblz4_LIBS])
 
 if test "x${have_liblzma}" = "xyes"; then
   AC_DEFINE([HAVE_LIBLZMA], [1], [Define to 1 if liblzma is enabled.])
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 758363e..9c0604d 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -38,7 +38,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 if ENABLE_LZ4
-liberofs_la_CFLAGS += ${LZ4_CFLAGS}
+liberofs_la_CFLAGS += ${liblz4_CFLAGS}
 liberofs_la_SOURCES += compressor_lz4.c
 if ENABLE_LZ4HC
 liberofs_la_SOURCES += compressor_lz4hc.c
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index 1e1ccc7..9955c0d 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -4,7 +4,6 @@
  *             http://www.huawei.com/
  * Created by Gao Xiang <xiang@kernel.org>
  */
-#define LZ4_HC_STATIC_LINKING_ONLY (1)
 #include <lz4hc.h>
 #include "erofs/internal.h"
 #include "erofs/print.h"
-- 
2.39.3 (Apple Git-146)

