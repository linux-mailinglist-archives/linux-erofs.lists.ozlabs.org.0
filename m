Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F83A305E8
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 02:51:28 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45FQqx6PmSzDqT7
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 10:51:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1559263885;
	bh=oOufX2D/RKwc8WFQm7oaUVUaa9RAx0/Tq6CY90yTmVY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=CMfNYiCzx+hsVtWvrxEfhYS5EDzxW2LYstuQpVntFQEtGiIBLTyUZ1550d8b13kWc
	 S+thXBT+gMiB+oxBLEovi88kOUFSyInNonMb9l7Iu/4dEF2+S1OmBKEvL0iu7iPoml
	 3miUk4dxYSHZBMp8XZRC/N/+3mI7uoWzFp6oZ3Ve6PVgpwWErzgHMBz5jOJys2fjAb
	 gfVkT5qOGRlZKL7V6vGNHBzCoGVoHuQv95phn48W7uTiqN5BsBaZXm+s/pU+26LzaW
	 hODnOGhyYTT2g+th+w82r7bXkszO83oYMZu8FSKAQpJP6kFSMuPwpInE+ohyVK3OLK
	 4aFI+V7GmmZ3g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.31; helo=sonic315-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="TTMBVFmq"; 
 dkim-atps=neutral
Received: from sonic315-55.consmr.mail.gq1.yahoo.com
 (sonic315-55.consmr.mail.gq1.yahoo.com [98.137.65.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FQqn70QyzDqSw
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 May 2019 10:51:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1559263874; bh=tLTFrJcCquG8Uoj5YWqPnxRfFIVId5aKlTmRLxs8iI0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=TTMBVFmqfXUyFzAeByXapjIo9GpipppoBVweGoPKWvsQ2lcliHBycVqQeDt1W6GyyAbZzPdFUxMipIZfsOcC9sAjFdBUMyAui9uaICJPNuBwaknDVknhs+W6FzcN0Q+TesRVilSv4d89XtvWuBIH3utRs7A+UH/1j395oMuqdRqXsmvOghRl2Hr7CIlRAO57rPNbqgTUu4FA0uvTx/9c56gLfMQVzUC0M0wRi+tSXiuV7ZjPdqjrGgvUjXm05udTtQgKXzbQTWDTdE+TBiFzPZb8AkfBBVD99XJGQ5HhMnRk1XStXxq/VYqTtKHePQsVdi1t/eorYO3l7Ar3Zq7Uyw==
X-YMail-OSG: 9zZG1xMVM1mjkJR5y8ulGYqF2tMH3WggjfhYy60XJKQ9eftgw4rG94Io7R6XBmW
 VlI4yFASX3N7HEVj.F2qR_eVc1Te7zvvSwcC6.3mnEnayVD3qnG1d7foaJKUGRwwQmcDOPQYOQwj
 bS4ea3LAkxStE2_AVx7dPUut6eZEuGuZ3_Ub9gWoBwWhDHio5FKT0yziOFYzDqqn2LhIyToD.3yT
 NZKs1.Kv1THRRZapRLp1zuNDvCazXBIS08YYs42qdRrTC6ebCj3S7yLAmm1_ABPx4H2_y2RmiLGh
 JNfqEsfszsWG.LQijFaL0nr92BtKJwnDvxTdLuOvW85GXbKjW1TbatZgI4yfBir_vRcx.FiqrXMR
 nT_CULzj3W3by.wfhEJTdy2KBbuCxvaKu8CL2MC8.FW3g6bMQH6GsWrmGtpW3zdV8siEWkMMGYql
 6OprYaDRs_CzkqBMCLPiYRUJEQcjNWoKE0_1nOpygVoXZ3WY3Q1BHfYuln.h5GyZmddkE.hlKtPp
 gZ3VNwjeRzlTBios2Vsw0GOh3Nx4VTcE_E4quu4vc3pFQxXsLmw.x50vl2HzWP0axlP.qcZ2rOT1
 wiZvSZKU0Gs1Yi8NgmNF9KoHu2q_ACfTe5Gw_yoZNEFr9NDHFyuJFmx3yFSFakcfhxGXRtdhrK9Y
 1mw2z4eaKKjtDjiHeLNe9zEeXFMfgqngsNIu0q2gvCapxjjGR9eeJjvipX9zZNnAVzp5Yf7ZnVsm
 64OGVPVtgnmLQBj.9VS3NbAG85cwSv3iq3JtYxQ9VftaQDmZFO7FSDarwyswW3glI2u33vt6flqI
 .sG8lEi0N0fvN6vtQnZe4mPqKNvDbL4ieE3tcpJlSTW7bQWgWdyU3snD1VEWCnf9f89W8hc7aIjr
 l59x2EXAqEWpj0htURiNbzfqlNBbxiYLis3LR8GwjfXbv3OoGEadG_V5vWS_WuaoUdmgd42sHiJg
 P3SjaGspmyhdwbdYiV3S1F3YIjnpytYk4cC.QOA5mPZrKhfiZIrGYeu2MuG.F_AJC9S7mcRM_8Rp
 96s7fWpqI.tpPD6OoBbna.XgtAfTYi0KyKOvLEiJJwOH8VrKM9g6wt0YMkX27iOpXckkYVo1HVgE
 oBPh0dqCmu_eGzP1c76JAfgKM4gGL5JiLBkfPbAgpDkaRTkARyoKTXRvNjytVGYFTjoKiaD_3NKu
 t5sarBYiQQcmm2O6g1W0Xk_dICwZ8MmR6I2_vdZ5DgEkqXgHf2Df9IgCPn23HyLLPRVE-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 00:51:14 +0000
Received: from 125.120.86.223 (EHLO localhost.localdomain) ([125.120.86.223])
 by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID a9e989b6e54ef4fb7ecb5a20a6091749; 
 Fri, 31 May 2019 00:51:14 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 03/13] erofs-utils: introduce miscellaneous files
Date: Fri, 31 May 2019 08:50:37 +0800
Message-Id: <20190531005047.22093-4-hsiangkao@aol.com>
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
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Li Guifu <bluce.liguifu@huawei.com>

This patch introduces a global configuration scheme, some
functions which can print messages in different level,
build scripts and .gitignore file.

Signed-off-by: Li Guifu <bluce.liguifu@huawei.com>
Signed-off-by: Miao Xie <miaoxie@huawei.com>
Signed-off-by: Fang Wei <fangwei1@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 .gitignore             |  25 ++++++++++
 Makefile.am            |   6 +++
 VERSION                |   2 +
 autogen.sh             |   9 ++++
 configure.ac           | 107 +++++++++++++++++++++++++++++++++++++++++
 include/erofs/config.h |  31 ++++++++++++
 include/erofs/print.h  |  67 ++++++++++++++++++++++++++
 lib/Makefile.am        |   7 +++
 lib/config.c           |  36 ++++++++++++++
 9 files changed, 290 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 Makefile.am
 create mode 100644 VERSION
 create mode 100755 autogen.sh
 create mode 100644 configure.ac
 create mode 100644 include/erofs/config.h
 create mode 100644 include/erofs/print.h
 create mode 100644 lib/Makefile.am
 create mode 100644 lib/config.c

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..3a39a1e
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,25 @@
+.*
+*~
+*.diff
+*.o
+*.la
+*.a
+*.patch
+*.rej
+
+#
+# Generated files
+#
+aclocal.m4
+autom4te.cache
+config.*
+Makefile
+Makefile.in
+config/
+m4/
+configure
+configure.scan
+libtool
+stamp-h
+stamp-h1
+
diff --git a/Makefile.am b/Makefile.am
new file mode 100644
index 0000000..ee5fd92
--- /dev/null
+++ b/Makefile.am
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile.am
+
+ACLOCAL_AMFLAGS = -I m4
+
+SUBDIRS=lib
diff --git a/VERSION b/VERSION
new file mode 100644
index 0000000..a27f297
--- /dev/null
+++ b/VERSION
@@ -0,0 +1,2 @@
+0.1
+2019-04-20
diff --git a/autogen.sh b/autogen.sh
new file mode 100755
index 0000000..fdda7e1
--- /dev/null
+++ b/autogen.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+
+aclocal && \
+autoheader && \
+autoconf && \
+libtoolize && \
+automake -a -c
+
diff --git a/configure.ac b/configure.ac
new file mode 100644
index 0000000..9c6d8bb
--- /dev/null
+++ b/configure.ac
@@ -0,0 +1,107 @@
+#                                               -*- Autoconf -*-
+# Process this file with autoconf to produce a configure script.
+
+AC_PREREQ([2.69])
+
+m4_define([erofs_utils_version], m4_esyscmd([sed -n '1p' VERSION | tr -d '\n']))
+m4_define([erofs_utils_date], m4_esyscmd([sed -n '2p' VERSION | tr -d '\n']))
+
+AC_INIT([erofs-utils], [erofs_utils_version], [linux-erofs@lists.ozlabs.org])
+AC_CONFIG_SRCDIR([config.h.in])
+AC_CONFIG_HEADERS([config.h])
+AC_CONFIG_MACRO_DIR([m4])
+AC_CONFIG_AUX_DIR(config)
+AM_INIT_AUTOMAKE([foreign -Wall -Werror])
+
+# Checks for programs.
+AM_PROG_AR
+AC_PROG_CC
+AC_PROG_INSTALL
+
+LT_INIT
+
+dnl EROFS_UTILS_PARSE_DIRECTORY
+dnl Input:  $1 = a string to a relative or absolute directory
+dnl Output: $2 = the variable to set with the absolute directory
+AC_DEFUN([EROFS_UTILS_PARSE_DIRECTORY],
+[
+ dnl Check if argument is a directory
+ if test -d $1 ; then
+    dnl Get the absolute path of the directory
+    dnl in case of relative directory.
+    dnl If realpath is not a valid command,
+    dnl an error is produced and we keep the given path.
+    local_tmp=`realpath $1 2>/dev/null`
+    if test "$local_tmp" != "" ; then
+       if test -d "$local_tmp" ; then
+           $2="$local_tmp"
+       else
+           $2=$1
+       fi
+    else
+       $2=$1
+    fi
+    dnl Check for space in the directory
+    if test `echo $1|cut -d' ' -f1` != $1 ; then
+        AC_MSG_ERROR($1 directory shall not contain any space.)
+    fi
+ else
+    AC_MSG_ERROR($1 shall be a valid directory)
+ fi
+])
+
+# Checks for libraries.
+
+# Checks for header files.
+AC_CHECK_HEADERS(m4_flatten([
+	dirent.h
+	fcntl.h
+	inttypes.h
+	linux/types.h
+	limits.h
+	stddef.h
+	stdint.h
+	stdlib.h
+	string.h
+	sys/stat.h
+	sys/time.h
+	unistd.h
+]))
+
+# Checks for typedefs, structures, and compiler characteristics.
+AC_C_INLINE
+AC_TYPE_INT64_T
+AC_TYPE_SIZE_T
+AC_TYPE_SSIZE_T
+AC_CHECK_MEMBERS([struct stat.st_rdev])
+AC_TYPE_UINT64_T
+
+#
+# Check to see if llseek() is declared in unistd.h.  On some libc's
+# it is, and on others it isn't..... Thank you glibc developers....
+#
+AC_CHECK_DECL(llseek,
+  [AC_DEFINE(HAVE_LLSEEK_PROTOTYPE, 1,
+    [Define to 1 if llseek declared in unistd.h])],,
+  [#include <unistd.h>])
+
+#
+# Check to see if lseek64() is declared in unistd.h.  Glibc's header files
+# are so convoluted that I can't tell whether it will always be defined,
+# and if it isn't defined while lseek64 is defined in the library,
+# disaster will strike.
+#
+# Warning!  Use of --enable-gcc-wall may throw off this test.
+#
+AC_CHECK_DECL(lseek64,[AC_DEFINE(HAVE_LSEEK64_PROTOTYPE, 1,
+  [Define to 1 if lseek64 declared in unistd.h])],,
+  [#define _LARGEFILE_SOURCE
+   #define _LARGEFILE64_SOURCE
+   #include <unistd.h>])
+
+# Checks for library functions.
+AC_CHECK_FUNCS([gettimeofday memset realpath strdup strerror strrchr strtoull])
+
+AC_CONFIG_FILES([Makefile
+		 lib/Makefile])
+AC_OUTPUT
diff --git a/include/erofs/config.h b/include/erofs/config.h
new file mode 100644
index 0000000..e31732b
--- /dev/null
+++ b/include/erofs/config.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs_utils/include/erofs/config.h
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Li Guifu <bluce.liguifu@huawei.com>
+ */
+#ifndef __EROFS_CONFIG_H
+#define __EROFS_CONFIG_H
+
+#include "defs.h"
+
+struct erofs_configure {
+	const char *c_version;
+	int c_dbg_lvl;
+	bool c_dry_run;
+
+	/* related arguments for mkfs.erofs */
+	char *c_img_path;
+	char *c_src_path;
+};
+
+extern struct erofs_configure cfg;
+
+void erofs_init_configure(void);
+void erofs_show_config(void);
+void erofs_exit_configure(void);
+
+#endif
+
diff --git a/include/erofs/print.h b/include/erofs/print.h
new file mode 100644
index 0000000..bc0b8d4
--- /dev/null
+++ b/include/erofs/print.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs_utils/include/erofs/print.h
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Li Guifu <bluce.liguifu@huawei.com>
+ */
+#ifndef __EROFS_PRINT_H
+#define __EROFS_PRINT_H
+
+#include "config.h"
+#include <stdio.h>
+
+#define FUNC_LINE_FMT "%s() Line[%d] "
+
+#ifndef pr_fmt
+#define pr_fmt(fmt) "EROFS: " FUNC_LINE_FMT fmt "\n"
+#endif
+
+#define erofs_dbg(fmt, ...) do {				\
+	if (cfg.c_dbg_lvl >= 7) {				\
+		fprintf(stdout,					\
+			pr_fmt(fmt),				\
+			__func__,				\
+			__LINE__,				\
+			##__VA_ARGS__);				\
+	}							\
+} while (0)
+
+#define erofs_info(fmt, ...) do {				\
+	if (cfg.c_dbg_lvl >= 3) {				\
+		fprintf(stdout,					\
+			pr_fmt(fmt),				\
+			__func__,				\
+			__LINE__,				\
+			##__VA_ARGS__);				\
+		fflush(stdout);					\
+	}							\
+} while (0)
+
+#define erofs_warn(fmt, ...) do {				\
+	if (cfg.c_dbg_lvl >= 2) {				\
+		fprintf(stdout,					\
+			pr_fmt(fmt),				\
+			__func__,				\
+			__LINE__,				\
+			##__VA_ARGS__);				\
+		fflush(stdout);					\
+	}							\
+} while (0)
+
+#define erofs_err(fmt, ...) do {				\
+	if (cfg.c_dbg_lvl >= 0) {				\
+		fprintf(stderr,					\
+			"Err: " pr_fmt(fmt),			\
+			__func__,				\
+			__LINE__,				\
+			##__VA_ARGS__);				\
+	}							\
+} while (0)
+
+#define erofs_dump(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
+
+
+#endif
+
diff --git a/lib/Makefile.am b/lib/Makefile.am
new file mode 100644
index 0000000..6f1da26
--- /dev/null
+++ b/lib/Makefile.am
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile.am
+
+noinst_LTLIBRARIES = liberofs.la
+liberofs_la_SOURCES = config.c
+liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
+
diff --git a/lib/config.c b/lib/config.c
new file mode 100644
index 0000000..6ff8e4d
--- /dev/null
+++ b/lib/config.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs_utils/lib/config.c
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Li Guifu <bluce.liguifu@huawei.com>
+ */
+#include <string.h>
+#include "erofs/print.h"
+
+struct erofs_configure cfg;
+
+void erofs_init_configure(void)
+{
+	memset(&cfg, 0, sizeof(cfg));
+
+	cfg.c_dbg_lvl  = 0;
+	cfg.c_version  = PACKAGE_VERSION;
+	cfg.c_dry_run  = false;
+}
+
+void erofs_show_config(void)
+{
+	const struct erofs_configure *c = &cfg;
+
+	erofs_dump("\tc_version:           [%8s]\n", c->c_version);
+	erofs_dump("\tc_dbg_lvl:           [%8d]\n", c->c_dbg_lvl);
+	erofs_dump("\tc_dry_run:           [%8d]\n", c->c_dry_run);
+}
+
+void erofs_exit_configure(void)
+{
+
+}
+
-- 
2.17.1

