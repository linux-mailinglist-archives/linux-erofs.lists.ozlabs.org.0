Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1AD305F1
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 02:52:06 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45FQrg3vCxzDqV9
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 10:52:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1559263923;
	bh=uxgYsOAyyXq8FSntXZvh2UYjOfda01xzDQ7JjkAozZg=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=CEBqifp0PNDAZ53t6JzkREtANWEC3F9DO6WnaAs31KE/XSyXv+9IMO4xYZ44K/l4H
	 KukIdqEiUY1rY1I2U/azWofdd2A/CkRzQKFdf32qMMi5hwyMDsEVaMP+BRkioE5nIQ
	 ulYWgOrDuXrF1ZJefghAcRQYOupL3Oondm3vxTv4BESHOP5aJw+wThuC083cG++RFN
	 m3ULf7VSkWFrFIt1OT2HF4O11nGHeHW4X86oUOhT5NmqOTM88subbHiYPSmthHVi6d
	 n7ljsvEdsZBq+HVqmXsAwtXJxz/6WqVC8P6dcgVua2U37l4W1G3yctDoRWlQaU7c4s
	 tNpnhsRxdZC9Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.206; helo=sonic304-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="VzOOnUzR"; 
 dkim-atps=neutral
Received: from sonic304-25.consmr.mail.gq1.yahoo.com
 (sonic304-25.consmr.mail.gq1.yahoo.com [98.137.68.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FQrP2JXfzDqSv
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 May 2019 10:51:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1559263907; bh=Khq1tvZNWf4XGNurMEmhjqJqGlGooaOuN0QexClRyqA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=VzOOnUzRJb/NjS3i0QOr0St1Gj6AC+SdbmSLb0hFtKPtJTOnDIcSupBVMdeBdWq1+S4V6nAjJ3c1K2dzPASx8J+HVArgbCqZ52b+1ruyChbJFrNzY1EJEgeFsm0PVynHAvSKtvW6ljXwSqUcwYOfS+R/DPNmCwy75nlE1+avXA8GCCidTPokD2k5U8zLQPZZ+TLHdXzezZZpQuysVJmx3YrikLc6W606gDwE5t2mq4aIXzX21npCJf+VYXsWKBIiNS8mGs+nrARdgxpmy1G+rIgqnHrZtNbAoUWuuF2IKhEUsdd4VZgY6qnl3cSYNGt3cxVAqXZy9ayEYrW/9bakOw==
X-YMail-OSG: gCxWhx4VM1k3CHS2tiaNOzLSHqYUEWLkriobTE0R1O.vhcDE0.O4atc1tHWwgAo
 B_BvfFecjUXgRrfl_cpI2W205MrPO2K0dmaaNabEp5fTdEKWQm9QPh27Rt26Q9zTDhJF9xRkpSJB
 qg_Mz_OP8BtrrdunYEiWnfh8RG9qe0PjCJ_hOS2mCfu6jalWNUqmmxDroVgIAcKQTKmExKGp9YHx
 m2CAnmanUbLS3wG3hL9QYuhO3m82EyjW5h_Z8pd8t0.MupA_6A3hBXXEUAvOFoYkd2VfK4_gO_Bb
 LERtgQXZa5jUl9XGFLV35_jbt7fjpctOlnw6rmdSu3tUtHt2YhKpwSqY0GU0OXSQv7OURwtbOEeb
 JR1C24uZSSozZm49vQlROel5ZOTh2iPspJoNZGGV3DX4ZkvbyuQnLg9t1XURrM3vkgzswvuXkfNI
 ADLBQsvhPGn.IKTOA.7J9_pfql8F0CljUHhjmXDsCNBb2lV5Ucq.KXytcsOfLJKUISc4Q.RbjxOJ
 r1xF9FyIeI2u4rlBk84EvSwe8wgWn0EomRHIxOm5Pzo1AXYNCXcCKxgxK4gONYwdUKbh2TQMnz9c
 QQqjPxz9Ket.xm0ivvetGK0fnN.4PanPIX0_OskoOMBwG_SpMO1YZRd.JCa.duJZ3LWeHBJQo2uR
 RCv1ZXVpgtGOFVCvyl3DmZDH41ThdDiAg_13FF7zVZmajx63OgBDfs2r0S4lEBlev__TZlXrUpAA
 qZHH9oHhZBF72m3Uk_fs4bp.Q2AJTQxzUzS_9wFK.oz5mPQn.KYvYHua0x.atEJiH8N_11ALj65I
 FbTy_unGAFRaBJ8TiIEbEJK0S_KN2P9CYyYjN8upytFqAy9Tv7e9ZjPz9.bJzBAubx79CqHS2w3M
 qR7AoSpixiOl9JLHV7wDqBociQEF1epjYtpVWCZEZqkM6AOk_cI6VfU_tc.j31VGyr2QfoudwP0g
 .ODtzZLEIKXunPV_YYxFX_HzQtmW91A4trcAfjkjLKRL3pnztofiko0pE78.1NF3guifPW9cAY06
 OXDXmEDwh776PURxx71dE0B05rbQ4V1XF_vevvSUQEFeKSG3IkVcVd_q3FWe02GmLM4SBfINDziE
 ShY_eL_kjrhgsBw2G_o0_xw8CUr4nsDv48VRmxvplJBu5K6iIgM.olzqIFOmuaD3Sl5E5iVyNAp2
 8TJMb3cEfUkKW5LQjvuTsm4WfzuJZ6Z1CaFPiRPYEdQHWGd8t7J2koqV_JOJmGQxSbAD3GOU-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 00:51:47 +0000
Received: from 125.120.86.223 (EHLO localhost.localdomain) ([125.120.86.223])
 by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID a9e989b6e54ef4fb7ecb5a20a6091749; 
 Fri, 31 May 2019 00:51:47 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 09/13] erofs-utils: introduce lz4/lz4hc compression algorithm
Date: Fri, 31 May 2019 08:50:43 +0800
Message-Id: <20190531005047.22093-10-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531005047.22093-1-hsiangkao@aol.com>
References: <20190531005047.22093-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

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
index 8ad9d11..814ef2b 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -35,8 +35,14 @@ struct erofs_compress {
 	unsigned int destsize_alignsize;
 	unsigned int destsize_redzone_begin;
 	unsigned int destsize_redzone_end;
+
+	void *private;
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
index 0000000..3bbb754
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
+	int rc = LZ4_compress_HC_destSize(c->private, src, dst,
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
+	if (!c->private)
+		return -EINVAL;
+
+	LZ4_freeStreamHC(c->private);
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
+	c->private = LZ4_createStreamHC();
+	if (!c->private)
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

