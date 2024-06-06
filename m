Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B5E8FDDB7
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 06:19:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VvrgX1Tx8z3cV9
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 14:19:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=deepin.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=deepin.org (client-ip=13.245.218.24; helo=smtpbg153.qq.com; envelope-from=heyuming@deepin.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 693 seconds by postgrey-1.37 at boromir; Thu, 06 Jun 2024 14:18:59 AEST
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VvrgR4k75z3cF1
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jun 2024 14:18:52 +1000 (AEST)
X-QQ-mid: bizesmtp82t1717647514tr9g0zyv
X-QQ-Originating-IP: lFpPnIL0gCQP0pAVQb+BnQUTVqt8xwNX5Pk4N6aVUZ8=
Received: from ComixHe.tail207ab.ts.net ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Jun 2024 12:18:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10965905757059532299
From: ComixHe <heyuming@deepin.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] build: support building static library liberofsfuse
Date: Thu,  6 Jun 2024 12:18:26 +0800
Message-ID: <64B0656069715534+20240606041826.46688-1-heyuming@deepin.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <43DE50371629F5AE+20240523073104.54391-1-heyuming@deepin.org>
References: <43DE50371629F5AE+20240523073104.54391-1-heyuming@deepin.org>
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
Cc: ComixHe <heyuming@deepin.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: ComixHe <heyuming@deepin.org>
---
 configure.ac     | 10 ++++++++++
 fuse/Makefile.am | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/configure.ac b/configure.ac
index 1989bca..3efbb70 100644
--- a/configure.ac
+++ b/configure.ac
@@ -147,6 +147,12 @@ AC_ARG_ENABLE(fuse,
    [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
    [enable_fuse="$enableval"], [enable_fuse="no"])
 
+AC_ARG_ENABLE([static-fuse],
+    [AS_HELP_STRING([--enable-static-fuse],
+                    [build erofsfuse as a static library @<:@default=no@:>@])],
+    [enable_static_fuse="$enableval"],
+    [enable_static_fuse="no"])
+
 AC_ARG_WITH(uuid,
    [AS_HELP_STRING([--without-uuid],
       [Ignore presence of libuuid and disable uuid support @<:@default=enabled@:>@])])
@@ -525,6 +531,10 @@ AM_CONDITIONAL([ENABLE_FUSE], [test "x${have_fuse}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBLZMA], [test "x${have_liblzma}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBDEFLATE], [test "x${have_libdeflate}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBZSTD], [test "x${have_libzstd}" = "xyes"])
+AM_CONDITIONAL([ENABLE_STATIC_FUSE], [test "x${enable_static_fuse}" = "xyes"])
+AM_CONDITIONAL([ENABLE_STATIC_MKFS], [test "x${enable_static_mkfs}" = "xyes"])
+AM_CONDITIONAL([ENABLE_STATIC_DUMP], [test "x${enable_static_dump}" = "xyes"])
+AM_CONDITIONAL([ENABLE_STATIC_FSCK], [test "x${enable_static_fsck}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
   AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
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
-- 
2.45.2

