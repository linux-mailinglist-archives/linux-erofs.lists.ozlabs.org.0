Return-Path: <linux-erofs+bounces-760-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A96B1A5F7
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Aug 2025 17:29:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwgT16Scvz3bwd;
	Tue,  5 Aug 2025 01:29:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754321349;
	cv=none; b=FAFNbW3N6i+k1CyqtD7bM+miSIF5L6Z48KSZqUKr0vN4ERqslwvXjZkcu2nWF/srHfAoBipr8z3DngELXfVETGLEsSy0RCIc2yU4FvLkFMrzmypeHKe3VFnhAD7Ecs7qN2Cju2FK0D4Brb5l0XjKXzMWZQYqnUdHh7c4JTDtIjK6rpuM99ET52ir+8QJHvY84zoisfyCPgD+JQuAE1suoooFE3J50xg00Cq5/Z0MLf2E8ftCL59KC9uMiVEb5wgAqJNdVmV0WzJ7BVTf6b8/G3SccHhxHunvPoKAcu95of4MICyQ/q53QfBlv/+PamMHxUwex6AzXwHrcw123vY3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754321349; c=relaxed/relaxed;
	bh=oPQAvA/wxp0ARYk6fsGmyOoBL2aiA9g+MvgAvefyoUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCmgM+GX90kw7ZgmFCqQGOvyWj30kfYACIuB2nO72n2Zfh1Ifb5RokLkyr/wCCpeto4hZft5kPVytudFZeAUKSIpQp727GdFMYBC7UgHeDtMkFyip33dVpJIHSH1CNMJRfJC1hvjVoss9mkcg9Oc3XJgTso27NIKoCd7NEphltTSIqKr8XwFfOpAvi0pReUHOYjzxR48B5UbMdN9DOCDzZJd06umxw7Hqp0Txryk16bAdR+RPBlfYKStWbI5+JqFNrpyLpmJyHHasqGQpUQpeiQ70Vs26TEtUMZkj21tPlDA7znGoac/P1o19UGFdk2JVrPAiQ9Zz2X2oC6p/VSYSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwgSy5sH9z30Yb
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Aug 2025 01:29:05 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bwgPg2pK2z1R8ry;
	Mon,  4 Aug 2025 23:26:15 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id 61AA91800B2;
	Mon,  4 Aug 2025 23:29:01 +0800 (CST)
Received: from localhost.localdomain (10.175.124.27) by
 kwepemp500007.china.huawei.com (7.202.195.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Aug 2025 23:29:00 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <jingrui@huawei.com>,
	<lihongbo22@huawei.com>, zhaoyifan <zhaoyifan28@huawei.com>
Subject: [PATCH v3 2/4] erofs-utils: introduce extra build dependencies for S3 support
Date: Mon, 4 Aug 2025 23:28:23 +0800
Message-ID: <20250804152825.428197-2-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250804152825.428197-1-zhaoyifan28@huawei.com>
References: <20250804152825.428197-1-zhaoyifan28@huawei.com>
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
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: zhaoyifan <zhaoyifan28@huawei.com>

This patch adds additional dependencies on libcurl, openssl and libxml2
library for the upcoming S3 data source support, with libcurl to
interact with S3 API, openssl to generate S3 auth signature and libxml2
to parse response body.

The newly introduced dependencies are optional, controlled by the
`--with-{libcurl,openssl,libxml2}` configure option. A new option
`--enable-s3` is also introduced to control whether S3 support is
enabled, and will report an error if any of the three dependencies
above is not satisfied.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
changes since v2:
- introduce `--with-{libcurl,openssl,libxml2}`
- `--enable-s3` would fail if any dependency is missing
- rename: HAVE_S3 -> S3_ENABLED

 configure.ac     | 129 ++++++++++++++++++++++++++++++++++++++++++++++-
 lib/Makefile.am  |  12 +++++
 lib/remotes/s3.c |   6 +++
 mkfs/Makefile.am |   3 +-
 4 files changed, 148 insertions(+), 2 deletions(-)
 create mode 100644 lib/remotes/s3.c

diff --git a/configure.ac b/configure.ac
index 2d42b1f..b735f92 100644
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
@@ -578,6 +594,91 @@ AS_IF([test "x$with_xxhash" != "xno"], [
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
 
@@ -601,6 +702,10 @@ AM_CONDITIONAL([ENABLE_LIBDEFLATE], [test "x${have_libdeflate}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBZSTD], [test "x${have_libzstd}" = "xyes"])
 AM_CONDITIONAL([ENABLE_QPL], [test "x${have_qpl}" = "xyes"])
 AM_CONDITIONAL([ENABLE_XXHASH], [test "x${have_xxhash}" = "xyes"])
+AM_CONDITIONAL([ENABLE_LIBCURL], [test "x${have_libcurl}" = "xyes"])
+AM_CONDITIONAL([ENABLE_OPENSSL], [test "x${have_openssl}" = "xyes"])
+AM_CONDITIONAL([ENABLE_LIBXML2], [test "x${have_libxml2}" = "xyes"])
+AM_CONDITIONAL([ENABLE_S3], [test "x${have_s3}" = "xyes"])
 AM_CONDITIONAL([ENABLE_STATIC_FUSE], [test "x${enable_static_fuse}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
@@ -652,6 +757,28 @@ if test "x$have_xxhash" = "xyes"; then
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
+  AC_DEFINE([S3_ENABLED], 1, [Define to 1 if s3 is enabled])
+fi
+
 # Dump maximum block size
 AS_IF([test "x$erofs_cv_max_block_size" = "x"],
       [$erofs_cv_max_block_size = 4096], [])
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 0db81df..72b03ba 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -66,6 +66,18 @@ liberofs_la_CFLAGS += ${libxxhash_CFLAGS}
 else
 liberofs_la_SOURCES += xxhash.c
 endif
+if ENABLE_LIBCURL
+liberofs_la_CFLAGS += ${libcurl_CFLAGS}
+endif
+if ENABLE_OPENSSL
+liberofs_la_CFLAGS += ${openssl_CFLAGS}
+endif
+if ENABLE_LIBXML2
+liberofs_la_CFLAGS += ${libxml2_CFLAGS}
+endif
+if ENABLE_S3
+liberofs_la_SOURCES += remotes/s3.c
+endif
 if ENABLE_EROFS_MT
 liberofs_la_LDFLAGS = -lpthread
 liberofs_la_SOURCES += workqueue.c
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
new file mode 100644
index 0000000..35e3fd5
--- /dev/null
+++ b/lib/remotes/s3.c
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2025 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Yifan Zhao <zhaoyifan28@huawei.com>
+ */
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
2.46.0


