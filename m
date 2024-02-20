Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD0A85C243
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 18:17:30 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P8YuOQmo;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TfR1034HPz3cDg
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Feb 2024 04:17:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P8YuOQmo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TfR0r1Sc5z3brm
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Feb 2024 04:17:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708449429; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zttsjv5i+qmayLOhfjU8SpN8ITzH3IOA9lmZxe5WOOg=;
	b=P8YuOQmowK5FhiGuZLVaHTTvDdU7rR4/68pc5rNkC0kQrE1TYCvGoNl0HPCpcuWv2+MgHTsJQcStURuoWPsP3sPYIJ0IU3hPhplsgUC5bufTTn+gXHwJOqug4utSuVtZcVi5ZxoD/+66+zwOkFydw/E0RVmpRPiU7/Q0JplJfCc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W0xCsNI_1708449421;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W0xCsNI_1708449421)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 01:17:07 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: support zlib auto-detection
Date: Wed, 21 Feb 2024 01:16:59 +0800
Message-Id: <20240220171700.3693176-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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

Fix explicit `--with-zlib` so that it errors out when zlib
is unavailable.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/configure.ac b/configure.ac
index bf6e99f..cd14beb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -124,7 +124,7 @@ AC_ARG_ENABLE(lzma,
 
 AC_ARG_WITH(zlib,
    [AS_HELP_STRING([--without-zlib],
-      [Ignore presence of zlib inflate support @<:@default=enabled@:>@])])
+      [Ignore presence of zlib inflate support @<:@default=auto@:>@])])
 
 AC_ARG_WITH(libdeflate,
    [AS_HELP_STRING([--with-libdeflate],
@@ -426,18 +426,29 @@ if test "x$enable_lzma" = "xyes"; then
 fi
 
 # Configure zlib
+have_zlib="no"
 AS_IF([test "x$with_zlib" != "xno"], [
-  PKG_CHECK_MODULES([zlib], [zlib])
-  # Paranoia: don't trust the result reported by pkgconfig before trying out
-  saved_LIBS="$LIBS"
-  saved_CPPFLAGS=${CPPFLAGS}
-  CPPFLAGS="${zlib_CFLAGS} ${CPPFLAGS}"
-  LIBS="${zlib_LIBS} $LIBS"
-  AC_CHECK_LIB(z, inflate, [
-    have_zlib="yes" ], [
-    AC_MSG_ERROR([zlib doesn't work properly])])
-  LIBS="${saved_LIBS}"
-  CPPFLAGS="${saved_CPPFLAGS}"], [have_zlib="no"])
+  PKG_CHECK_MODULES([zlib], [zlib], [
+    # Paranoia: don't trust the result reported by pkgconfig before trying out
+    saved_LIBS="$LIBS"
+    saved_CPPFLAGS=${CPPFLAGS}
+    CPPFLAGS="${zlib_CFLAGS} ${CPPFLAGS}"
+    LIBS="${zlib_LIBS} $LIBS"
+    AC_CHECK_HEADERS([zlib.h],[
+      AC_CHECK_LIB(z, inflate, [], [
+        AC_MSG_ERROR([zlib doesn't work properly])])
+      AC_CHECK_DECL(inflate, [have_zlib="yes"],
+        [AC_MSG_ERROR([zlib doesn't work properly])], [[
+#include <zlib.h>
+      ]])
+    ])
+    LIBS="${saved_LIBS}"
+    CPPFLAGS="${saved_CPPFLAGS}"], [
+    AS_IF([test "x$with_zlib" = "xyes"], [
+      AC_MSG_ERROR([Cannot find proper zlib])
+    ])
+  ])
+])
 
 # Configure libdeflate
 AS_IF([test "x$with_libdeflate" != "xno"], [
-- 
2.39.3

