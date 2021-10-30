Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A303C4406DA
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Oct 2021 04:01:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hh2bP3xLJz305L
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Oct 2021 13:01:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uZnYlBli;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uZnYlBli; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hh2bG5FWlz2yph
 for <linux-erofs@lists.ozlabs.org>; Sat, 30 Oct 2021 13:01:30 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6401C610E5;
 Sat, 30 Oct 2021 02:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635559287;
 bh=ExVuC2ZaY7Do2FA9UtpmcQD32fubZ8kspvXT2mzenEc=;
 h=From:To:Cc:Subject:Date:From;
 b=uZnYlBliPsd9rGkU5TsebJHsAAzrJ2K5ejKekc1tdqCJ9VoE6LLZyt8FWbpBa50WY
 77Ega3H0omcljQnZjx+YrI8K8C4L8NZkdSqeW3aTCdRTMWi40Jdfwj3I9VFjxOqhxn
 h2n/YCqoTSPW4bvsNgC5Y9kkt1pzQ1ILPtBqDAxYOkh3/X3LnY849Uu8HqrdNj7P8K
 hoVVSe+Zv/YH4AV3ALvnzmO57QGTmOxfz6hbxG5elskjZRARpuRFiJTghsQnkjEC1I
 +Mjset6KNCWKS4WN9ciFCgwoU+VGO3yVM1WARyaCY+ObiqIsE6x0fE2c7C4vSYMtNH
 zq2YE8DlSyXfA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs-utils: add liblzma dependency
Date: Sat, 30 Oct 2021 10:01:16 +0800
Message-Id: <20211030020118.13898-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Lasse Collin <lasse.collin@tukaani.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

liblzma [1] has a fixed-sized output LZMA compression implementation
now since v5.3.2alpha. Let's add such dependency in the build system.

[1] https://git.tukaani.org/?p=xz.git

Cc: Lasse Collin <lasse.collin@tukaani.org>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 README           |  3 +++
 configure.ac     | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 fuse/Makefile.am |  3 ++-
 lib/Makefile.am  |  1 +
 mkfs/Makefile.am |  3 ++-
 5 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 3f8301006ccc..333dcb49cc42 100644
--- a/README
+++ b/README
@@ -8,6 +8,7 @@ Dependencies & build
 --------------------
 
  lz4 1.8.0+ for lz4 enabled [2], lz4 1.9.3+ highly recommended [4][5].
+ XZ Utils 5.3.2alpha [6] or later versions for MicroLZMA enabled.
 
  libfuse 2.6+ for erofsfuse enabled as a plus.
 
@@ -221,3 +222,5 @@ Comments
     https://github.com/lz4/lz4/issues/783
 
     which is also resolved in lz4-1.9.3.
+
+[6] https://tukaani.org/xz/xz-5.3.2alpha.tar.xz
diff --git a/configure.ac b/configure.ac
index b2c32259c5bd..b50c00c5d6c1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -69,6 +69,10 @@ AC_ARG_ENABLE(lz4,
    [AS_HELP_STRING([--disable-lz4], [disable LZ4 compression support @<:@default=enabled@:>@])],
    [enable_lz4="$enableval"], [enable_lz4="yes"])
 
+AC_ARG_ENABLE(lzma,
+   [AS_HELP_STRING([--enable-lzma], [enable LZMA compression support @<:@default=no@:>@])],
+   [enable_lzma="$enableval"], [enable_lzma="no"])
+
 AC_ARG_ENABLE(fuse,
    [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
    [enable_fuse="$enableval"], [enable_fuse="no"])
@@ -99,6 +103,14 @@ AC_ARG_WITH(lz4-libdir,
 AC_ARG_VAR([LZ4_CFLAGS], [C compiler flags for lz4])
 AC_ARG_VAR([LZ4_LIBS], [linker flags for lz4])
 
+AC_ARG_WITH(liblzma-incdir,
+   [AS_HELP_STRING([--with-liblzma-incdir=DIR], [liblzma include directory])], [
+   EROFS_UTILS_PARSE_DIRECTORY(["$withval"],[withval])])
+
+AC_ARG_WITH(liblzma-libdir,
+   [AS_HELP_STRING([--with-liblzma-libdir=DIR], [liblzma lib directory])], [
+   EROFS_UTILS_PARSE_DIRECTORY(["$withval"],[withval])])
+
 # Checks for header files.
 AC_CHECK_HEADERS(m4_flatten([
 	dirent.h
@@ -263,10 +275,36 @@ if test "x$enable_lz4" = "xyes"; then
   CPPFLAGS=${saved_CPPFLAGS}
 fi
 
+if test "x$enable_lzma" = "xyes"; then
+  saved_CPPFLAGS=${CPPFLAGS}
+  test -z "${with_liblzma_incdir}" ||
+    CPPFLAGS="-I$with_liblzma_incdir $CPPFLAGS"
+  AC_CHECK_HEADERS([lzma.h],[have_lzmah="yes"], [])
+
+  if test "x${have_lzmah}" = "xyes" ; then
+    saved_LIBS="$LIBS"
+    saved_LDFLAGS="$LDFLAGS"
+
+    test -z "${with_liblzma_libdir}" ||
+      LDFLAGS="-L$with_liblzma_libdir ${LDFLAGS}"
+    AC_CHECK_LIB(lzma, lzma_microlzma_encoder, [],
+      [AC_MSG_ERROR([Cannot find proper liblzma])])
+
+    AC_CHECK_DECL(lzma_microlzma_encoder, [have_liblzma="yes"],
+      [AC_MSG_ERROR([Cannot find proper liblzma])], [[
+#include <lzma.h>
+    ]])
+    LDFLAGS="${saved_LDFLAGS}"
+    LIBS="${saved_LIBS}"
+  fi
+  CPPFLAGS="${saved_CPPFLAGS}"
+fi
+
 # Set up needed symbols, conditionals and compiler/linker flags
 AM_CONDITIONAL([ENABLE_LZ4], [test "x${have_lz4}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
 AM_CONDITIONAL([ENABLE_FUSE], [test "x${have_fuse}" = "xyes"])
+AM_CONDITIONAL([ENABLE_LIBLZMA], [test "x${have_liblzma}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
   AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
@@ -293,6 +331,17 @@ if test "x${have_lz4}" = "xyes"; then
 fi
 AC_SUBST([liblz4_LIBS])
 
+if test "x${have_liblzma}" = "xyes"; then
+  AC_DEFINE([HAVE_LIBLZMA], [1], [Define to 1 if liblzma is enabled.])
+  liblzma_LIBS="-llzma"
+  test -z "${with_liblzma_libdir}" ||
+    liblzma_LIBS="-L${with_liblzma_libdir} $liblzma_LIBS"
+  test -z "${with_liblzma_incdir}" ||
+    liblzma_CFLAGS="-I${with_liblzma_incdir}"
+  AC_SUBST([liblzma_LIBS])
+  AC_SUBST([liblzma_CFLAGS])
+fi
+
 AC_CONFIG_FILES([Makefile
 		 man/Makefile
 		 lib/Makefile
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 6893a97ccaf1..7b007f3fec11 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -5,4 +5,5 @@ bin_PROGRAMS     = erofsfuse
 erofsfuse_SOURCES = dir.c main.c
 erofsfuse_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS} ${libselinux_CFLAGS}
-erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS} ${libselinux_LIBS}
+erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS} \
+	${libselinux_LIBS} ${liblzma_LIBS}
diff --git a/lib/Makefile.am b/lib/Makefile.am
index b64d90b3e144..370de844146f 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -31,3 +31,4 @@ if ENABLE_LZ4HC
 liberofs_la_SOURCES += compressor_lz4hc.c
 endif
 endif
+liberofs_la_CFLAGS += ${liblzma_CFLAGS}
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index e488f86cff90..2a4bc1d58769 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -5,4 +5,5 @@ bin_PROGRAMS     = mkfs.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS} ${libselinux_CFLAGS}
 mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
-mkfs_erofs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} ${liblz4_LIBS}
+mkfs_erofs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
+	${liblz4_LIBS} ${liblzma_LIBS}
-- 
2.20.1

