Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4F58CCD76
	for <lists+linux-erofs@lfdr.de>; Thu, 23 May 2024 09:56:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VlL2p0Vzhz3gKr
	for <lists+linux-erofs@lfdr.de>; Thu, 23 May 2024 17:51:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=deepin.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=deepin.org (client-ip=52.205.10.60; helo=smtp-usa1.onexmail.com; envelope-from=heyuming@deepin.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 332 seconds by postgrey-1.37 at boromir; Thu, 23 May 2024 17:51:05 AEST
Received: from smtp-usa1.onexmail.com (smtp-usa1.onexmail.com [52.205.10.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VlL2d1SsSz3gJT
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 May 2024 17:51:04 +1000 (AEST)
X-QQ-mid: bizesmtp80t1716450286tukel6s4
X-QQ-Originating-IP: AP4r7M3/99vEcNrzsovCIy6IVweSIS+0QLhVBMTYyPM=
Received: from ComixHe.tail207ab.ts.net ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 May 2024 15:44:44 +0800 (CST)
X-QQ-SSF: 01400000000000104000000A0000000
X-QQ-FEAT: bRp6PL0F45OgpcHWR3NKkacdTgCip9vXSO4XH7UDO/436p8C2fRB2Ixl/BOna
	/JQCf2EnSzh1In93dnE0A3af7VBrMoTQrk5Oe4hP104xeXM6Xm+Yo5gcW7namKmU7Sny8vm
	Sx3DmJbq2iUlLewc6BxG5m0dEhVLvsoSZUKO8YBgEDtDdO735NFK2gaNrTT5WnHEPNwhIFJ
	v2Ku5JrhRVoRvo6OyLLkJhUwMmbnMDAaYwPvLNrzUTE72Jls+hK6k6Lsq1LpShaBXB4g7wH
	y45XY/36lauuo24XadTiQYLGoqSANQWYTAJEPoQGj88Qp1UlrF8oZu1UGRnvTrmeTH34ja9
	v6g9ClmSz5jaRngi3lP0Frv3o6BbFT0PvwzjNRRoKv1aa7d1fxvx53S7lkU4w==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7198586172468979690
From: ComixHe <heyuming@deepin.org>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH] build: support building static library
Date: Thu, 23 May 2024 15:31:04 +0800
Message-ID: <43DE50371629F5AE+20240523073104.54391-1-heyuming@deepin.org>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:deepin.org:qybglogicsvrsz:qybglogicsvrsz3a-1
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
Cc: ComixHe <heyuming@deepin.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In some cases, developer may need to integrate erofs-utils into their
proejct as a static library to reduce package dependencies and
have more finer control over the feature used by the project.

For exapmle, squashfuse provides a static library `libsquashfuse.a` and
exposes some useful functions, Appimage uses this static library to build
image. It could ensure that the executable image can be executed directly
on most linux platforms and the user doesn't need to install squashfuse
in order to execute the image.

Signed-off-by: ComixHe <heyuming@deepin.org>
---
 configure.ac     | 28 ++++++++++++++++++++++++++++
 dump/Makefile.am | 10 ++++++++++
 fsck/Makefile.am | 10 ++++++++++
 fuse/Makefile.am | 10 ++++++++++
 mkfs/Makefile.am | 10 ++++++++++
 5 files changed, 68 insertions(+)

diff --git a/configure.ac b/configure.ac
index 1989bca..16ddb7c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -147,6 +147,30 @@ AC_ARG_ENABLE(fuse,
    [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
    [enable_fuse="$enableval"], [enable_fuse="no"])
 
+AC_ARG_ENABLE([static-fuse],
+    [AS_HELP_STRING([--enable-static-fuse],
+                    [build erofsfuse as a static library @<:@default=no@:>@])],
+    [enable_static_fuse="$enableval"],
+    [enable_static_fuse="no"])
+
+AC_ARG_ENABLE([static-dump],
+    [AS_HELP_STRING([--enable-static-dump],
+                    [build dump.erofs as a static library @<:@default=no@:>@])],
+    [enable_static_dump="$enableval"],
+    [enable_static_dump="no"])
+
+AC_ARG_ENABLE([static-mkfs],
+    [AS_HELP_STRING([--enable-static-mkfs],
+                    [build mkfs.erofs as a static library @<:@default=no@:>@])],
+    [enable_static_mkfs="$enableval"],
+    [enable_static_mkfs="no"])
+
+AC_ARG_ENABLE([static-fsck],
+    [AS_HELP_STRING([--enable-static-fsck],
+                    [build fsck.erofs as a static library @<:@default=no@:>@])],
+    [enable_static_fsck="$enableval"],
+    [enable_static_fsck="no"])
+
 AC_ARG_WITH(uuid,
    [AS_HELP_STRING([--without-uuid],
       [Ignore presence of libuuid and disable uuid support @<:@default=enabled@:>@])])
@@ -525,6 +549,10 @@ AM_CONDITIONAL([ENABLE_FUSE], [test "x${have_fuse}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBLZMA], [test "x${have_liblzma}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBDEFLATE], [test "x${have_libdeflate}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBZSTD], [test "x${have_libzstd}" = "xyes"])
+AM_CONDITIONAL([ENABLE_STATIC_FUSE], [test "x${enable_static_fuse}" = "xyes"])
+AM_CONDITIONAL([ENABLE_STATIC_MKFS], [test "x${enable_static_mkfs}" = "xyes"])
+AM_CONDITIONAL([ENABLE_STATIC_DUMP], [test "x${enable_static_dump}" = "xyes"])
+AM_CONDITIONAL([ENABLE_STATIC_FSCK], [test "x${enable_static_fsck}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
   AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
diff --git a/dump/Makefile.am b/dump/Makefile.am
index 09c483e..da0df51 100644
--- a/dump/Makefile.am
+++ b/dump/Makefile.am
@@ -9,3 +9,13 @@ dump_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
 	${libzstd_LIBS}
+
+if ENABLE_STATIC_DUMP
+lib_LTLIBRARIES     = libdumperofs.la
+libdumperofs_la_SOURCES = main.c
+libdumperofs_la_CFLAGS = -Wall -I$(top_srcdir)/include
+libdumperofs_la_CFLAGS += -Dmain=dumperofs_main -static
+libdumperofs_la_LIBADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
+	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
+	${libzstd_LIBS}
+endif
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 70eacc0..0916320 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -10,6 +10,16 @@ fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
 	${libzstd_LIBS}
 
+if ENABLE_STATIC_FSCK
+lib_LTLIBRARIES    = libfsckerofs.la
+libfsckerofs_la_SOURCES = main.c
+libfsckerofs_la_CFLAGS = -Wall -I$(top_srcdir)/include
+libfsckerofs_la_CFLAGS += -Dmain=fsckerofs_main -static
+libfsckerofs_la_LIBADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
+	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
+	${libzstd_LIBS}
+endif
+
 if ENABLE_FUZZING
 noinst_PROGRAMS   = fuzz_erofsfsck
 fuzz_erofsfsck_SOURCES = main.c
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 7eae5f6..120d3e1 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -8,3 +8,13 @@ erofsfuse_CFLAGS = -Wall -I$(top_srcdir)/include
 erofsfuse_CFLAGS += ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
 erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
 	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS}
+
+
+if ENABLE_STATIC_FUSE
+lib_LTLIBRARIES = liberofsfuse.la
+liberofsfuse_la_SOURCES = main.c
+liberofsfuse_la_CFLAGS  = -Wall -I$(top_srcdir)/include
+liberofsfuse_la_CFLAGS += -Dmain=erofsfuse_main -static ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
+liberofsfuse_la_LIBADD  = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
+	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS}
+endif
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index af97e39..6edcdda 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -8,3 +8,13 @@ mkfs_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} \
 	${libdeflate_LIBS} ${libzstd_LIBS}
+
+if ENABLE_STATIC_MKFS
+lib_LTLIBRARIES     = libmkerofs.la
+libmkerofs_la_SOURCES = main.c
+libmkerofs_la_CFLAGS = -Wall -I$(top_srcdir)/include
+libmkerofs_la_CFLAGS += -Dmain=mkerofs_main -static
+libmkerofs_la_LIBADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
+	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} \
+	${libdeflate_LIBS} ${libzstd_LIBS}
+endif
-- 
2.45.1

