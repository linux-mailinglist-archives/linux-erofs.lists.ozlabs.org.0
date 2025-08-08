Return-Path: <linux-erofs+bounces-794-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E7CB1E0DF
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Aug 2025 05:15:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4byq0W74kzz30Vl;
	Fri,  8 Aug 2025 13:15:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754622923;
	cv=none; b=F4FFQHAsYb8P38i7zBYETJ4Z9X+KzD6gKyY6V3AVbVlLNXBmwZbVQD5Gv4mYR6pblrcTBIEbC6KWFg1yrDzfWSoRjE5cKVUxpvVd60BBDjYobEbCw8Wo1btSsJW5m+ycM5Krkc63cI8u9WKQykjDgYM4SUS+e2FddxFpy23oC7xtw8ZuBSUxc5jaH63YLQMSGPz3uEK4fHXSC6XViQe5UMKR3pJj4OPWC7FHbipI6fHPzOk4gr7QF/njS9LJEciyzt6Jrq7GlcuLcx8EFIU27askFz26tem9XxTRDawxXecFnbrgeA6UoQURIk876ky55AwgO3K/0VXwXncAUcna3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754622923; c=relaxed/relaxed;
	bh=hF4flzkd9Z3lOqjQElAOdV+JqLADVB09I+GeqoFX9Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IraM+uXjV+xDzHCENJxp8CC4eG0jjwN0/Gz9kM48mOCKrwfogcrlpXU0TJT/m2rcwh2JFQr+7V/mE7yTzPmQxYX5LwJ8zX6BGxcWDEHQAj9w/3qMasLbjd5+sIwYf6HK3BIz+ayVtYyZzo+0+LHIiNlkVPPQJWVxFqEhAP/CfzIzg/M6IhNfZroQ0dGYHYIxQ8Mh114YfOoSObKHa43OqkLWYPq4c8qtO5s7Q1tt7+4R7H/anlcWi2mP/ZWtqhED1cw1jHyaC5lsUe7HYDvPYu8LwQR9owBY8TpeFLyXGhEeH4NIQdJ2ByR+CCKQqWVkZ8zPHz3+KeVrEpusVGkyxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aPqLLwse; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aPqLLwse;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4byq0T3Pdcz3bmC
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Aug 2025 13:15:20 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754622916; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hF4flzkd9Z3lOqjQElAOdV+JqLADVB09I+GeqoFX9Eo=;
	b=aPqLLwsep0I6QTwhjFetDaWJCFytGmnIVs6lwp2kKUGTOAcFEM8HqZQhXDM/Jdb+qNHTtZk77yTAwPXSk35N6YnVB/AW/5ENTFNSCjKyoYs7c9TR+t8dq1ZTuzrOhjkDcLOpIpyanxiLsmqvUTiL7czTwrsE9mUG1NGrqdsuPO4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WlFkAVi_1754622914 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Aug 2025 11:15:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <zhaoyifan28@huawei.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v7 2/4] erofs-utils: introduce extra build dependencies for S3 support
Date: Fri,  8 Aug 2025 11:15:06 +0800
Message-ID: <20250808031508.346771-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250808031508.346771-1-hsiangkao@linux.alibaba.com>
References: <20250808031508.346771-1-hsiangkao@linux.alibaba.com>
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


