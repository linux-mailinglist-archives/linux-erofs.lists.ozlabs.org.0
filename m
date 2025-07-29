Return-Path: <linux-erofs+bounces-719-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 523B3B14D00
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Jul 2025 13:25:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4brtM834dWz2yrT;
	Tue, 29 Jul 2025 21:25:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.32
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753788356;
	cv=none; b=QmwAN5S5CStp5B9vmjAhF907X8HmhwUmDnHAQ4xQlN6MgNTcJAUNwhPcovOUgaLssU+kDakNqjQ7e9fuzel8V6RcG8XPzLJ99suDH5fkLwiNDoN6z3VmbDH9epKHoB+eUUDa3V1VO3WTRifde4uHHmX6IZH51gUWfcn2xySzx9q0ugid+a1+CVt+MWZieCqo+EMqeU3EwBYM+Zo5WF+Pw4R3j8VVngCeMLqeE+jZlDI62gTUq3aYviylYktbS7r7wYxbwDFtwXflCREjyAw02jFB3ticjFiDx7XiYrfwwAz61ZEogXPIKPKA7Nx8baXZluFenTpCqcwTbcsmNXlkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753788356; c=relaxed/relaxed;
	bh=Q8ydTx720YJP1YOrTKKnfqTrzW0/P+WI+qzqdB5NFE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdoDrV2gj2w6CvAxNCiJPWZwZHt+DKoHWf+BvU5oIirxaZOjSaW/9nGzp8bRlLHxyG3tJwb7KTvz/4c2B2pw3diXN2Tx8+3Hi855zLtj2xNFG7MJduO5e4GVijywB17tYeY+E73DpXbGT8GwjWXZW44Zipb00R81I0rxbo0TYAe5FBFH4b0/ed1f1wtkVC+IDCCQ5UvZXXHOKy2rCT+wx8dvbq2MZ3VLz4t3PqPTymb/cCo1+aXSEOe3l9KPM9qDwn4xuzz+xh01WjzHkWMPuG7fUbb3bK4kMJRm8PBegC3E+GfQiNc9mw9Empc/jDLmp0EyVdxKESkriDocO5CHsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.32; helo=szxga06-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=szxga06-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4brtM73pDxz2y82
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Jul 2025 21:25:55 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4brsyv0zFKz27j4q
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Jul 2025 19:08:23 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id BFB141A0188
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Jul 2025 19:07:21 +0800 (CST)
Received: from localhost.localdomain (10.175.124.27) by
 kwepemp500007.china.huawei.com (7.202.195.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Jul 2025 19:07:20 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhurui10@huawei.com>,
	<songgongzheng@huawei.com>, <lihongbo22@huawei.com>, <qinbinjuan@huawei.com>,
	<caihaomin@huawei.com>, <caihe@huawei.com>, zhaoyifan
	<zhaoyifan28@huawei.com>
Subject: [RFC 2/4] erofs-utils: introduce build support for libcurl, openssl and libxml2 library
Date: Tue, 29 Jul 2025 19:06:08 +0800
Message-ID: <20250729110610.3438246-3-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250729110610.3438246-1-zhaoyifan28@huawei.com>
References: <20250729110610.3438246-1-zhaoyifan28@huawei.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: zhaoyifan <zhaoyifan28@huawei.com>

This patch adds additional dependencies on libcurl, openssl and libxml2 library
for the upcoming S3 data source support, with libcurl to interact with S3 API,
openssl to generate S3 auth signature and libxml2 to parse response body.

The newly introduced dependencies are optional, controlled by the `--enable-s3`
configure option.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 configure.ac       | 41 +++++++++++++++++++++++++++++++++++++++++
 include/erofs/s3.h | 10 ++++++++++
 lib/Makefile.am    |  5 +++++
 lib/s3.c           |  7 +++++++
 mkfs/Makefile.am   |  3 ++-
 5 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 include/erofs/s3.h
 create mode 100644 lib/s3.c

diff --git a/configure.ac b/configure.ac
index 2d42b1f..925fad8 100644
--- a/configure.ac
+++ b/configure.ac
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
diff --git a/include/erofs/s3.h b/include/erofs/s3.h
new file mode 100644
index 0000000..e29bde2
--- /dev/null
+++ b/include/erofs/s3.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2025 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Yifan Zhao <zhaoyifan28@huawei.com>
+ */
+#ifndef __EROFS_S3_H
+#define __EROFS_S3_H
+
+#endif
\ No newline at end of file
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 0db81df..b53ec76 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -22,6 +22,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/print.h \
       $(top_srcdir)/include/erofs/bitops.h \
       $(top_srcdir)/include/erofs/tar.h \
+      $(top_srcdir)/include/erofs/s3.h \
       $(top_srcdir)/include/erofs/trace.h \
       $(top_srcdir)/include/erofs/xattr.h \
       $(top_srcdir)/include/erofs/compress_hints.h \
@@ -66,6 +67,10 @@ liberofs_la_CFLAGS += ${libxxhash_CFLAGS}
 else
 liberofs_la_SOURCES += xxhash.c
 endif
+if ENABLE_S3
+liberofs_la_CFLAGS += ${libcurl_CFLAGS} ${openssl_CFLAGS} ${libxml2_CFLAGS}
+liberofs_la_SOURCES += s3.c
+endif
 if ENABLE_EROFS_MT
 liberofs_la_LDFLAGS = -lpthread
 liberofs_la_SOURCES += workqueue.c
diff --git a/lib/s3.c b/lib/s3.c
new file mode 100644
index 0000000..bbd35a4
--- /dev/null
+++ b/lib/s3.c
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2025 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Yifan Zhao <zhaoyifan28@huawei.com>
+ */
+#include "erofs/s3.h"
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


