Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A766A29C
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 09:05:20 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nry51PjCzDqXC
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 17:05:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nrxR4G45zDqWW
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 17:04:43 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 727B4A3321B0BE167475;
 Tue, 16 Jul 2019 15:04:40 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Jul
 2019 15:04:34 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: [PATCH v2 09/17] erofs-utils: introduce lz4/lz4hc compression
 algorithm
Date: Tue, 16 Jul 2019 15:04:11 +0800
Message-ID: <20190716070419.30203-10-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190716070419.30203-1-gaoxiang25@huawei.com>
References: <20190716070419.30203-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch adds lz4/lz4hc compression algorithms to
erofs-utils compression framework in order to enable
the fixed-output size compression.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 configure.ac           | 65 ++++++++++++++++++++++++++++++++++++++++++
 lib/Makefile.am        |  7 +++++
 lib/compressor.c       |  6 ++++
 lib/compressor.h       |  6 ++++
 lib/compressor_lz4.c   | 48 +++++++++++++++++++++++++++++++
 lib/compressor_lz4hc.c | 61 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 193 insertions(+)
 create mode 100644 lib/compressor_lz4.c
 create mode 100644 lib/compressor_lz4hc.c

diff --git a/configure.ac b/configure.ac
index 49f1a7d..6cc0c60 100644
--- a/configure.ac
+++ b/configure.ac
@@ -50,7 +50,22 @@ AC_DEFUN([EROFS_UTILS_PARSE_DIRECTORY],
  fi
 ])
 
+AC_ARG_ENABLE(lz4,
+   [AS_HELP_STRING([--disable-lz4], [disable LZ4 compression support @<:@default=enabled@:>@])],
+   [enable_lz4="$enableval"], [enable_lz4="yes"])
+
 # Checks for libraries.
+# Use customized LZ4 library path when specified.
+AC_ARG_WITH(lz4-incdir,
+   [AS_HELP_STRING([--with-lz4-incdir=DIR], [LZ4 include directory])], [
+   EROFS_UTILS_PARSE_DIRECTORY(["$withval"],[withval])])
+
+AC_ARG_WITH(lz4-libdir,
+   [AS_HELP_STRING([--with-lz4-libdir=DIR], [LZ4 lib directory])], [
+   EROFS_UTILS_PARSE_DIRECTORY(["$withval"],[withval])])
+
+AC_ARG_VAR([LZ4_CFLAGS], [C compiler flags for lz4])
+AC_ARG_VAR([LZ4_LIBS], [linker flags for lz4])
 
 # Checks for header files.
 AC_CHECK_HEADERS(m4_flatten([
@@ -102,7 +117,57 @@ AC_CHECK_DECL(lseek64,[AC_DEFINE(HAVE_LSEEK64_PROTOTYPE, 1,
 # Checks for library functions.
 AC_CHECK_FUNCS([gettimeofday memset realpath strdup strerror strrchr strtoull])
 
+# Configure lz4
+test -z $LZ4_LIBS && LZ4_LIBS='-llz4'
+
+if test "x$enable_lz4" = "xyes"; then
+  test -z "${with_lz4_incdir}" || LZ4_CFLAGS="-I$with_lz4_incdir $LZ4_CFLAGS"
+  test -z "${with_lz4_libdir}" || LZ4_LIBS="-L$with_lz4_libdir $LZ4_LIBS"
+
+  saved_CPPFLAGS=${CPPFLAGS}
+  CPPFLAGS="${LZ4_CFLAGS} ${CFLAGS}"
+
+  AC_CHECK_HEADERS([lz4.h],[have_lz4h="yes"], [])
+
+  if test "x${have_lz4h}" = "xyes" ; then
+    saved_LDFLAGS=${LDFLAGS}
+    LDFLAGS="-L$with_lz4_libdir ${LDFLAGS}"
+    AC_CHECK_LIB(lz4, LZ4_compress_destSize, [
+      have_lz4="yes"
+      have_lz4hc="yes"
+      AC_CHECK_LIB(lz4, LZ4_compress_HC_destSize, [], [
+        AC_CHECK_DECL(LZ4_compress_HC_destSize, [lz4_force_static="yes"],
+          [have_lz4hc="no"], [[
+#define LZ4_HC_STATIC_LINKING_ONLY (1)
+#include <lz4hc.h>
+        ]])
+      ])
+    ], [AC_MSG_ERROR([Cannot find proper lz4 version (>= 1.8.0)])])
+    LDFLAGS=${saved_LDFLAGS}
+
+    if test "x${have_lz4}" = "xyes"; then
+      AC_DEFINE([LZ4_ENABLED], [1], [Define to 1 if lz4 is enabled.])
+
+      if test "x${have_lz4hc}" = "xyes"; then
+        AC_DEFINE([LZ4HC_ENABLED], [1], [Define to 1 if lz4hc is enabled.])
+      fi
+
+      if test "x${lz4_force_static}" = "xyes"; then
+        LDFLAGS="-all-static ${LDFLAGS}"
+      else
+	test -z "${with_lz4_libdir}" || LZ4_LIBS="-R ${with_lz4_libdir} $LZ4_LIBS"
+      fi
+      LIBS="$LZ4_LIBS $LIBS"
+    fi
+  fi
+  CFLAGS=${saved_CPPFLAGS}
+fi
+
+AM_CONDITIONAL([ENABLE_LZ4], [test "x${have_lz4}" = "xyes"])
+AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
+
 AC_CONFIG_FILES([Makefile
 		 lib/Makefile
 		 mkfs/Makefile])
 AC_OUTPUT
+
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 64da708..17dc9e1 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -4,4 +4,11 @@
 noinst_LTLIBRARIES = liberofs.la
 liberofs_la_SOURCES = config.c io.c cache.c inode.c compressor.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
+if ENABLE_LZ4
+liberofs_la_CFLAGS += ${LZ4_CFLAGS}
+liberofs_la_SOURCES += compressor_lz4.c
+if ENABLE_LZ4HC
+liberofs_la_SOURCES += compressor_lz4hc.c
+endif
+endif
 
diff --git a/lib/compressor.c b/lib/compressor.c
index cc97cfb..a6138c6 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -39,6 +39,12 @@ int erofs_compressor_init(struct erofs_compress *c,
 			  char *alg_name)
 {
 	static struct erofs_compressor *compressors[] = {
+#if LZ4_ENABLED
+#if LZ4HC_ENABLED
+		&erofs_compressor_lz4hc,
+#endif
+		&erofs_compressor_lz4,
+#endif
 	};
 
 	int ret, i;
diff --git a/lib/compressor.h b/lib/compressor.h
index 8ad9d11..6429b2a 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -35,8 +35,14 @@ struct erofs_compress {
 	unsigned int destsize_alignsize;
 	unsigned int destsize_redzone_begin;
 	unsigned int destsize_redzone_end;
+
+	void *private_data;
 };
 
+/* list of compression algorithms */
+extern struct erofs_compressor erofs_compressor_lz4;
+extern struct erofs_compressor erofs_compressor_lz4hc;
+
 int erofs_compress_destsize(struct erofs_compress *c, int compression_level,
 			    void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize);
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
new file mode 100644
index 0000000..eacd21c
--- /dev/null
+++ b/lib/compressor_lz4.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/compressor-lz4.c
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#include <lz4.h>
+#include "erofs/internal.h"
+#include "compressor.h"
+
+static int lz4_compress_destsize(struct erofs_compress *c,
+				 int compression_level,
+				 void *src, unsigned int *srcsize,
+				 void *dst, unsigned int dstsize)
+{
+	int srcSize = (int)*srcsize;
+	int rc = LZ4_compress_destSize(src, dst, &srcSize, (int)dstsize);
+
+	if (!rc)
+		return -EFAULT;
+	*srcsize = srcSize;
+	return 0;
+}
+
+static int compressor_lz4_exit(struct erofs_compress *c)
+{
+	return 0;
+}
+
+static int compressor_lz4_init(struct erofs_compress *c,
+				 char *alg_name)
+{
+	if (alg_name && strcmp(alg_name, "lz4"))
+		return -EINVAL;
+	c->alg = &erofs_compressor_lz4;
+	return 0;
+}
+
+struct erofs_compressor erofs_compressor_lz4 = {
+	.default_level = 0,
+	.best_level = 0,
+	.init = compressor_lz4_init,
+	.exit = compressor_lz4_exit,
+	.compress_destsize = lz4_compress_destsize,
+};
+
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
new file mode 100644
index 0000000..ec9347e
--- /dev/null
+++ b/lib/compressor_lz4hc.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/compressor-lz4hc.c
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#define LZ4_HC_STATIC_LINKING_ONLY (1)
+#include <lz4hc.h>
+#include "erofs/internal.h"
+#include "compressor.h"
+
+static int lz4hc_compress_destsize(struct erofs_compress *c,
+				   int compression_level,
+				   void *src,
+				   unsigned int *srcsize,
+				   void *dst,
+				   unsigned int dstsize)
+{
+	int srcSize = (int)*srcsize;
+	int rc = LZ4_compress_HC_destSize(c->private_data, src, dst,
+					  &srcSize, (int)dstsize,
+					  compression_level);
+	if (!rc)
+		return -EFAULT;
+	*srcsize = srcSize;
+	return 0;
+}
+
+static int compressor_lz4hc_exit(struct erofs_compress *c)
+{
+	if (!c->private_data)
+		return -EINVAL;
+
+	LZ4_freeStreamHC(c->private_data);
+	return 0;
+}
+
+static int compressor_lz4hc_init(struct erofs_compress *c,
+				 char *alg_name)
+{
+	if (alg_name && strcmp(alg_name, "lz4hc"))
+		return -EINVAL;
+
+	c->alg = &erofs_compressor_lz4hc;
+
+	c->private_data = LZ4_createStreamHC();
+	if (!c->private_data)
+		return -ENOMEM;
+	return 0;
+}
+
+struct erofs_compressor erofs_compressor_lz4hc = {
+	.default_level = LZ4HC_CLEVEL_DEFAULT,
+	.best_level = LZ4HC_CLEVEL_MAX,
+	.init = compressor_lz4hc_init,
+	.exit = compressor_lz4hc_exit,
+	.compress_destsize = lz4hc_compress_destsize,
+};
+
-- 
2.17.1

