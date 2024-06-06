Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 763368FE00C
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 09:40:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vvx8L4vvfz3d96
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 17:40:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=deepin.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=deepin.org (client-ip=114.132.77.159; helo=bg1.exmail.qq.com; envelope-from=heyuming@deepin.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 12455 seconds by postgrey-1.37 at boromir; Thu, 06 Jun 2024 17:40:44 AEST
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vvx8D4LYHz3d2S
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jun 2024 17:40:43 +1000 (AEST)
X-QQ-mid: bizesmtp90t1717659609trcddds9
X-QQ-Originating-IP: Ujin+uIzRBRE4m2RjKx8ojHcF1Xf/+P35+XFdA1it0g=
Received: from ComixHe.tail207ab.ts.net ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Jun 2024 15:40:08 +0800 (CST)
X-QQ-SSF: 01400000000000104000000A0000000
X-QQ-FEAT: JjNfdqAt6CTqn12bSpL7KRBcJbtd0sI/3bTpRSaDhJ9Z+BspZJPvFB4h7Hax0
	hCutRXbo9Ty3o0tGIbDZ2PJZ0B7ozyrYOju+apJ6bXhp1M3LFuluz0IoxwJX55oV6Q+WABx
	A6qPnREVytRDnEBfDI/gZ02S/xnvqu5mNHafX5oBET+Fs8v+2KpN5UOiqojXw3KHbXsjt+M
	9BdHEu/nZn7ndY+klbptkp9fhdiUGHws3XBRF/Aci83kXLdfN5gpEcApRP7GkPS/sk4325X
	amRHuycaqcYCtKrNSg5lWjWvAEcUtmEgsgcRWomBdnkPR86aspDr5pagnTPz01gqmDtcM/l
	5BpbhzfoaFek+ixj/7ihfB9Lh6Ylts9O8IWmyNIAEGg9C5JF0c=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3160080480387314522
From: ComixHe <heyuming@deepin.org>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH v2] build: support building static library liberofsfuse
Date: Thu,  6 Jun 2024 15:39:48 +0800
Message-ID: <3399126AB01D5AB6+2bad5767fc035a7a2234408b0fffa53b3a07aa51.1717659178.git.heyuming@deepin.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <64B0656069715534+20240606041826.46688-1-heyuming@deepin.org>
References: <64B0656069715534+20240606041826.46688-1-heyuming@deepin.org>
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

add new option '--enable-static-fuse' so that we
could import erofsfuse as a static library directly
into other projects

Signed-off-by: ComixHe <heyuming@deepin.org>
---
 configure.ac     | 7 +++++++
 fuse/Makefile.am | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/configure.ac b/configure.ac
index 1989bca..f756139 100644
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
@@ -525,6 +531,7 @@ AM_CONDITIONAL([ENABLE_FUSE], [test "x${have_fuse}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBLZMA], [test "x${have_liblzma}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBDEFLATE], [test "x${have_libdeflate}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBZSTD], [test "x${have_libzstd}" = "xyes"])
+AM_CONDITIONAL([ENABLE_STATIC_FUSE], [test "x${enable_static_fuse}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
   AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 7eae5f6..c5c5696 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -8,3 +8,12 @@ erofsfuse_CFLAGS = -Wall -I$(top_srcdir)/include
 erofsfuse_CFLAGS += ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
 erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
 	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS}
+
+if ENABLE_STATIC_FUSE
+lib_LIBRARIES = liberofsfuse.a
+liberofsfuse_a_SOURCES = main.c
+liberofsfuse_a_CFLAGS  = -Wall -I$(top_srcdir)/include
+liberofsfuse_a_CFLAGS += -Dmain=erofsfuse_main ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
+liberofsfuse_la_LIBADD  = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
+	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS}
+endif
-- 
2.45.2

