Return-Path: <linux-erofs+bounces-777-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA25EB1C7B5
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Aug 2025 16:36:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bxtCM5xKGz2ygJ;
	Thu,  7 Aug 2025 00:36:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754490991;
	cv=none; b=G6n1yRjdJfejLkm+p6bGDJ3eyNWfq+cjw2khI/TZ6Q9WliSn6RnZW+hT6JV+vprOI5vqSWjyKvUdicMYnPBJHYJS/B0su50f7eYx7fB8ZxqNHnpjdyuZsX2qMhtlah630rwj64/N+v6NYebuEMCjfYuEvUIwflb0Xi8XIB/6E13Vr4HogIf8mk21NQ7+mFggfYbMS1oTSDqB1SbBBu4CkUTTC8X4ZNtwDG3vtkfuBwpxqjtwh3EDK/DmrQieMnkIVwVgVQp7ijzutDYz0+u7XvZXJ7jR8Bna16oSlK6DZc06tUQ1weYnmCKfk+rQJluH0uKnyNHyq/CRAIJTG/J80A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754490991; c=relaxed/relaxed;
	bh=hF4flzkd9Z3lOqjQElAOdV+JqLADVB09I+GeqoFX9Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdTuibH+j8cqouXAIIzIihoWiH76TYkSGsDzfUtOwRTeylGAGqTYJAkeFnqwVMsOv6VDk7EQcz//4PsMVO6u7hSGt7mXo2roCY+CfZix4N8adSCbzYziU0EZnrBmxkZm5+lwsnyylK1ki3sTDxJP+WwycW6KTzK0LfL+luLhHGw5n852h1FxAg6a+W3G1vDAIRNv5ZKCWBVjD1j/kyvRbS7f/2MWpabO09368FBNzArfU5tnzIv2QyTsilFlfdW+kxzN6XE7nZZ4Wfjtb1MTRteBx/SXhLusLDek0eZW7WH46ueLcRXPBpITAryKtHEfoEEefgSC065VL2G4m5dEaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=krpgDmkG; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=krpgDmkG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxtCK2915z3bnB
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Aug 2025 00:36:27 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754490984; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hF4flzkd9Z3lOqjQElAOdV+JqLADVB09I+GeqoFX9Eo=;
	b=krpgDmkGEcU7qXCIdsi2y06bcLEQZuxoC10BT6gD1wLKGU8cCLvy0b37VbdLBZgpr4KsQB+i3Cj6r4ux63yGiTiLs8X1UPBtKgSYcNxJ4PfDBz1Lvd60b8t7jI3FrVB6+uodCKC9caLjMICeV7n/SjHpCWtFzI6OewttiEpRoHE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WlBLAvG_1754490979 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Aug 2025 22:36:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <zhaoyifan28@huawei.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v5 2/4] erofs-utils: introduce extra build dependencies for S3 support
Date: Wed,  6 Aug 2025 22:36:12 +0800
Message-ID: <20250806143615.1661283-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250806143615.1661283-1-hsiangkao@linux.alibaba.com>
References: <20250806143615.1661283-1-hsiangkao@linux.alibaba.com>
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

From: Yifan Zhao <zhaoyifan28@huawei.com>

This patch adds additional dependencies on libcurl, openssl and libxml2
library for the upcoming S3 data source support, with libcurl to
interact with S3 API, openssl to generate S3 auth signature and libxml2
to parse response body.

erofs-utils: introduce extra build dependencies for S3 support

This patch adds additional dependencies on libcurl, openssl, and libxml2
for the upcoming S3 data source support:
 - libcurl is used to interact with the S3 API;
 - openssl is used to generate S3 authentication signatures;
 - libxml2 is used to parse response bodies;

These dependencies are optional and controlled using the
`--with-{libcurl,openssl,libxml2}` configure options.

Additionally, a new `--enable-s3` option is introduced to enable S3
support.  It will report an error if any of the three required libraries
doesn't work properly.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac     | 129 ++++++++++++++++++++++++++++++++++++++++++++++-
 lib/Makefile.am  |   1 +
 mkfs/Makefile.am |   3 +-
 3 files changed, 131 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index da6ae48..7769ac9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -24,7 +24,7 @@ esac
 # OS-specific treatment
 AM_CONDITIONAL([OS_LINUX], [test "$build_linux" = "yes"])
 
-AM_INIT_AUTOMAKE([foreign -Wall])
+AM_INIT_AUTOMAKE([foreign subdir-objects -Wall])
 
 # Checks for programs.
 AM_PROG_AR
@@ -165,6 +165,22 @@ AC_ARG_WITH(xxhash,
    [AS_HELP_STRING([--with-xxhash],
       [Enable and build with libxxhash support @<:@default=auto@:>@])])
 
+AC_ARG_WITH(libcurl,
+   [AS_HELP_STRING([--with-libcurl],
+      [Enable and build with libcurl support @<:@default=auto@:>@])])
+
+AC_ARG_WITH(openssl,
+   [AS_HELP_STRING([--with-openssl],
+      [Enable and build with openssl support @<:@default=auto@:>@])])
+
+AC_ARG_WITH(libxml2,
+   [AS_HELP_STRING([--with-libxml2],
+      [Enable and build with libxml2 support @<:@default=auto@:>@])])
+
+AC_ARG_ENABLE(s3,
+   [AS_HELP_STRING([--enable-s3], [enable s3 image generation support @<:@default=no@:>@])],
+   [enable_s3="$enableval"], [enable_s3="no"])
+
 AC_ARG_ENABLE(fuse,
    [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
    [enable_fuse="$enableval"], [enable_fuse="no"])
@@ -583,6 +599,91 @@ AS_IF([test "x$with_xxhash" != "xno"], [
   ])
 ])
 
+# Configure libcurl
+have_libcurl="no"
+AS_IF([test "x$with_libcurl" != "xno"], [
+  PKG_CHECK_MODULES([libcurl], [libcurl], [
+    # Paranoia: don't trust the result reported by pkgconfig before trying out
+    saved_LIBS="$LIBS"
+    saved_CPPFLAGS=${CPPFLAGS}
+    CPPFLAGS="${libcurl_CFLAGS} ${CPPFLAGS}"
+    LIBS="${libcurl_LIBS} $LIBS"
+    AC_CHECK_HEADERS([curl/curl.h],[
+      AC_CHECK_LIB(curl, curl_easy_perform, [], [
+        AC_MSG_ERROR([libcurl doesn't work properly])])
+      AC_CHECK_DECL(curl_easy_perform, [have_libcurl="yes"],
+        [AC_MSG_ERROR([libcurl doesn't work properly])], [[
+#include <curl/curl.h>
+      ]])
+    ])
+    LIBS="${saved_LIBS}"
+    CPPFLAGS="${saved_CPPFLAGS}"], [
+    AS_IF([test "x$with_libcurl" = "xyes"], [
+      AC_MSG_ERROR([Cannot find proper libcurl])
+    ])
+  ])
+])
+
+# Configure openssl
+have_openssl="no"
+AS_IF([test "x$with_openssl" != "xno"], [
+  PKG_CHECK_MODULES([openssl], [openssl], [
+    # Paranoia: don't trust the result reported by pkgconfig before trying out
+    saved_LIBS="$LIBS"
+    saved_CPPFLAGS=${CPPFLAGS}
+    CPPFLAGS="${openssl_CFLAGS} ${CPPFLAGS}"
+    LIBS="${openssl_LIBS} $LIBS"
+    AC_CHECK_HEADERS([openssl/hmac.h],[
+      AC_CHECK_LIB(ssl, EVP_sha1, [], [
+        AC_MSG_ERROR([openssl doesn't work properly])])
+      AC_CHECK_DECL(EVP_sha1, [have_openssl="yes"],
+        [AC_MSG_ERROR([openssl doesn't work properly])], [[
+#include <openssl/hmac.h>
+      ]])
+    ])
+    LIBS="${saved_LIBS}"
+    CPPFLAGS="${saved_CPPFLAGS}"], [
+    AS_IF([test "x$with_openssl" = "xyes"], [
+      AC_MSG_ERROR([Cannot find proper openssl])
+    ])
+  ])
+])
+
+# Configure libxml2
+have_libxml2="no"
+AS_IF([test "x$with_libxml2" != "xno"], [
+  PKG_CHECK_MODULES([libxml2], [libxml-2.0], [
+    # Paranoia: don't trust the result reported by pkgconfig before trying out
+    saved_LIBS="$LIBS"
+    saved_CPPFLAGS=${CPPFLAGS}
+    CPPFLAGS="${libxml2_CFLAGS} ${CPPFLAGS}"
+    LIBS="${libxml2_LIBS} $LIBS"
+    AC_CHECK_HEADERS([libxml/parser.h],[
+      AC_CHECK_LIB(xml2, xmlReadMemory, [], [
+        AC_MSG_ERROR([libxml2 doesn't work properly])])
+      AC_CHECK_DECL(xmlReadMemory, [have_libxml2="yes"],
+        [AC_MSG_ERROR([libxml2 doesn't work properly])], [[
+#include <libxml/parser.h>
+      ]])
+    ])
+    LIBS="${saved_LIBS}"
+    CPPFLAGS="${saved_CPPFLAGS}"], [
+    AS_IF([test "x$with_libxml2" = "xyes"], [
+      AC_MSG_ERROR([Cannot find proper libxml2])
+    ])
+  ])
+])
+
+AS_IF([test "x$enable_s3" != "xno"], [
+  AS_IF(
+    [test "x$have_libcurl" = "xyes" && \
+     test "x$have_openssl" = "xyes" && \
+     test "x$have_libxml2" = "xyes"],
+    [have_s3="yes"],
+    [have_s3="no"
+     AC_MSG_ERROR([S3 disabled: missing libcurl, openssl, or libxml2])])
+  ], [have_s3="no"])
+
 # Enable 64-bit off_t
 CFLAGS+=" -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
 
@@ -606,6 +707,10 @@ AM_CONDITIONAL([ENABLE_LIBDEFLATE], [test "x${have_libdeflate}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBZSTD], [test "x${have_libzstd}" = "xyes"])
 AM_CONDITIONAL([ENABLE_QPL], [test "x${have_qpl}" = "xyes"])
 AM_CONDITIONAL([ENABLE_XXHASH], [test "x${have_xxhash}" = "xyes"])
+AM_CONDITIONAL([ENABLE_LIBCURL], [test "x${have_libcurl}" = "xyes"])
+AM_CONDITIONAL([ENABLE_OPENSSL], [test "x${have_openssl}" = "xyes"])
+AM_CONDITIONAL([ENABLE_LIBXML2], [test "x${have_libxml2}" = "xyes"])
+AM_CONDITIONAL([ENABLE_S3], [test "x${have_s3}" = "xyes"])
 AM_CONDITIONAL([ENABLE_STATIC_FUSE], [test "x${enable_static_fuse}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
@@ -657,6 +762,28 @@ if test "x$have_xxhash" = "xyes"; then
   AC_DEFINE([HAVE_XXHASH], 1, [Define to 1 if xxhash is found])
 fi
 
+if test "x$have_libcurl" = "xyes"; then
+  AC_DEFINE([HAVE_LIBCURL], 1, [Define to 1 if libcurl is found])
+  AC_SUBST([libcurl_LIBS])
+  AC_SUBST([libcurl_CFLAGS])
+fi
+
+if test "x$have_openssl" = "xyes"; then
+  AC_DEFINE([HAVE_OPENSSL], 1, [Define to 1 if openssl is found])
+  AC_SUBST([openssl_LIBS])
+  AC_SUBST([openssl_CFLAGS])
+fi
+
+if test "x$have_libxml2" = "xyes"; then
+  AC_DEFINE([HAVE_LIBXML2], 1, [Define to 1 if libxml2 is found])
+  AC_SUBST([libxml2_LIBS])
+  AC_SUBST([libxml2_CFLAGS])
+fi
+
+if test "x$have_s3" = "xyes"; then
+  AC_DEFINE([S3EROFS_ENABLED], 1, [Define to 1 if s3 is enabled])
+fi
+
 # Dump maximum block size
 AS_IF([test "x$erofs_cv_max_block_size" = "x"],
       [$erofs_cv_max_block_size = 4096], [])
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 0db81df..6458acf 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -66,6 +66,7 @@ liberofs_la_CFLAGS += ${libxxhash_CFLAGS}
 else
 liberofs_la_SOURCES += xxhash.c
 endif
+liberofs_la_CFLAGS += ${libcurl_CFLAGS} ${openssl_CFLAGS} ${libxml2_CFLAGS}
 if ENABLE_EROFS_MT
 liberofs_la_LDFLAGS = -lpthread
 liberofs_la_SOURCES += workqueue.c
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index 2499242..b84b4c1 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -7,4 +7,5 @@ mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} \
-	${libdeflate_LIBS} ${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS}
+	${libdeflate_LIBS} ${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} \
+	${libcurl_LIBS} ${openssl_LIBS} ${libxml2_LIBS}
-- 
2.43.5


