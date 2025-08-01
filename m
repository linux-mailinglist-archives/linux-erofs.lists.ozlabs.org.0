Return-Path: <linux-erofs+bounces-738-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958C1B17D92
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Aug 2025 09:31:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btd1B0wlnz2ymc;
	Fri,  1 Aug 2025 17:31:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754033486;
	cv=none; b=iGTbcezjMN3Wm4wYtg2GZ1EblIU7zhod6gcolXIqBz8PvsI7/55bTtsJG4ZsObr0OBYiYiGF44EuZ7b6Ej8zEiUDtHnReG99hMOPgMNNGidzVnCTh7B4ensdtl6Yk/x9cLUCTYVyOhx7zsq/PNkioQ4fooJSMiqZftLaJPzdhP3z8JRX6XWVZqoVvoEax2drmKXnXVm8D38xksM0YpYPccpE7wPHkiwmsA6tdGpX5Bq7kOy4HKCvCGuszhEtU+nIZ6nO+UFSGuUdQqwJ/CjOYEEV6P2OyOuhvJRuYrObQntYhynVxS5RuiWH9jXTknpJNmK6TEkNhNCehgW+2HnZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754033486; c=relaxed/relaxed;
	bh=c1AcSDLg831LP5VzsiUd1E1bUgGvBp0PZnUVZ6kzXEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGOirXVovwLW+IZzWKR/kuTnm2nVlLPbCKbSiYbzIkFcP0f15ZByximrQL6V6BNT7jGMv9/rZezdtwk6/CxaF+Qxcz+Oeyu0Ik/iD0Yvm7LoLeWfd6EB+5w2xfOetliP+FNFcnO6qhFHEURpqDsMuMAbkPCsBECBaX12xl1BRHT3KVODjVMuntVvGoGbnsO3yGdqiVPilv5qNrVLJ5Si6BZ5TsKyoXSd6gyHJp6aruBgGlSxuawf/7iQuqY9ppFqlhSuTkTvvk9wsp8uao8JBRMxnPR/wUs2zzTDSTAgRHsT/H8ReZLlnHJqXkrqrow+SKPMVWrtYcksXqFtM3cWrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btd165Z0gz2yfL
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Aug 2025 17:31:20 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4btcw604Jgz2Cg1f;
	Fri,  1 Aug 2025 15:27:01 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id E862E18005F;
	Fri,  1 Aug 2025 15:31:15 +0800 (CST)
Received: from localhost.localdomain (10.175.124.27) by
 kwepemp500007.china.huawei.com (7.202.195.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Aug 2025 15:31:15 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <jingrui@huawei.com>,
	<lihongbo22@huawei.com>, zhaoyifan <zhaoyifan28@huawei.com>
Subject: [PATCH v2 2/4] erofs-utils: introduce build support for libcurl, openssl and libxml2 library
Date: Fri, 1 Aug 2025 15:30:44 +0800
Message-ID: <20250801073046.1900016-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <97aa3cdb-076b-4af2-a110-79250b74fc7a@linux.alibaba.com>
References: <97aa3cdb-076b-4af2-a110-79250b74fc7a@linux.alibaba.com>
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: zhaoyifan <zhaoyifan28@huawei.com>

This patch adds additional dependencies on libcurl, openssl and libxml2 library
for the upcoming S3 data source support, with libcurl to interact with S3 API,
openssl to generate S3 auth signature and libxml2 to parse response body.

The newly introduced dependencies are optional, controlled by the `--enable-s3`
configure option.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
change since v1:
- rebase on the latest `experimental` branch
- rename: lib/s3.c => lib/remotes/s3.c
- configure.ac: introduce `subdir-objects` option as s3.c in a subdir
- move include/erofs/s3.h in the following patch

 configure.ac     | 43 ++++++++++++++++++++++++++++++++++++++++++-
 lib/Makefile.am  |  4 ++++
 lib/remotes/s3.c |  6 ++++++
 mkfs/Makefile.am |  3 ++-
 4 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 lib/remotes/s3.c

diff --git a/configure.ac b/configure.ac
index 2d42b1f..82ff98e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -24,7 +24,7 @@ esac
 # OS-specific treatment
 AM_CONDITIONAL([OS_LINUX], [test "$build_linux" = "yes"])
 
-AM_INIT_AUTOMAKE([foreign -Wall])
+AM_INIT_AUTOMAKE([foreign subdir-objects -Wall])
 
 # Checks for programs.
 AM_PROG_AR
@@ -165,6 +165,10 @@ AC_ARG_WITH(xxhash,
    [AS_HELP_STRING([--with-xxhash],
       [Enable and build with libxxhash support @<:@default=auto@:>@])])
 
+AC_ARG_ENABLE(s3,
+   [AS_HELP_STRING([--enable-s3], [enable s3 image generation support @<:@default=no@:>@])],
+   [enable_s3="$enableval"], [enable_s3="no"])
+
 AC_ARG_ENABLE(fuse,
    [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
    [enable_fuse="$enableval"], [enable_fuse="no"])
@@ -578,6 +582,32 @@ AS_IF([test "x$with_xxhash" != "xno"], [
   ])
 ])
 
+AS_IF([test "x$enable_s3" != "xno"], [
+  # Paranoia: don't trust the result reported by pkgconfig before trying out
+  saved_LIBS="$LIBS"
+  saved_CPPFLAGS=${CPPFLAGS}
+  PKG_CHECK_MODULES([libcurl], [libcurl])
+  PKG_CHECK_MODULES([openssl], [openssl])
+  PKG_CHECK_MODULES([libxml2],  [libxml-2.0])
+  CPPFLAGS="${libcurl_CFLAGS} ${openssl_CFLAGS} ${libxml2_CFLAGS} ${CPPFLAGS}"
+  LIBS="${libcurl_LIBS} ${openssl_LIBS} ${libxml2_LIBS} $LIBS"
+  s3_deps_ok="yes"
+  AC_CHECK_LIB(curl, curl_multi_perform, [], [
+    AC_MSG_ERROR([libcurl doesn't work properly])
+    s3_deps_ok="no"
+  ])
+  AC_CHECK_LIB(ssl, EVP_sha1, [], [
+    AC_MSG_ERROR([openssl doesn't work properly])
+    s3_deps_ok="no"
+  ])
+  AC_CHECK_LIB(xml2, xmlReadMemory, [], [
+    AC_MSG_ERROR([libxml-2.0 doesn't work properly])
+    s3_deps_ok="no"
+  ])
+  AS_IF([test "x$s3_deps_ok" = "xyes"], [have_s3="yes"], [have_s3="no"])
+  LIBS="${saved_LIBS}"
+  CPPFLAGS="${saved_CPPFLAGS}"], [have_s3="no"])
+
 # Enable 64-bit off_t
 CFLAGS+=" -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
 
@@ -601,6 +631,7 @@ AM_CONDITIONAL([ENABLE_LIBDEFLATE], [test "x${have_libdeflate}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBZSTD], [test "x${have_libzstd}" = "xyes"])
 AM_CONDITIONAL([ENABLE_QPL], [test "x${have_qpl}" = "xyes"])
 AM_CONDITIONAL([ENABLE_XXHASH], [test "x${have_xxhash}" = "xyes"])
+AM_CONDITIONAL([ENABLE_S3], [test "x${have_s3}" = "xyes"])
 AM_CONDITIONAL([ENABLE_STATIC_FUSE], [test "x${enable_static_fuse}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
@@ -652,6 +683,16 @@ if test "x$have_xxhash" = "xyes"; then
   AC_DEFINE([HAVE_XXHASH], 1, [Define to 1 if xxhash is found])
 fi
 
+if test "x$have_s3" = "xyes"; then
+  AC_DEFINE([HAVE_S3], 1, [Define to 1 if s3 is enabled])
+  AC_SUBST([libcurl_LIBS])
+  AC_SUBST([libcurl_CFLAGS])
+  AC_SUBST([openssl_LIBS])
+  AC_SUBST([openssl_CFLAGS])
+  AC_SUBST([libxml2_LIBS])
+  AC_SUBST([libxml2_CFLAGS])
+fi
+
 # Dump maximum block size
 AS_IF([test "x$erofs_cv_max_block_size" = "x"],
       [$erofs_cv_max_block_size = 4096], [])
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 0db81df..2d04149 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -66,6 +66,10 @@ liberofs_la_CFLAGS += ${libxxhash_CFLAGS}
 else
 liberofs_la_SOURCES += xxhash.c
 endif
+if ENABLE_S3
+liberofs_la_CFLAGS += ${libcurl_CFLAGS} ${openssl_CFLAGS} ${libxml2_CFLAGS}
+liberofs_la_SOURCES += remotes/s3.c
+endif
 if ENABLE_EROFS_MT
 liberofs_la_LDFLAGS = -lpthread
 liberofs_la_SOURCES += workqueue.c
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
new file mode 100644
index 0000000..ed2b023
--- /dev/null
+++ b/lib/remotes/s3.c
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2025 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Yifan Zhao <zhaoyifan28@huawei.com>
+ */
\ No newline at end of file
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


