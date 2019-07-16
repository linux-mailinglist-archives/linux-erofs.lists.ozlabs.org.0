Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A59536A297
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 09:04:58 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nrxg1T3JzDqXM
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 17:04:55 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nrxP399pzDqLP
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 17:04:41 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 6C423819B8CA83E910B5;
 Tue, 16 Jul 2019 15:04:35 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Jul
 2019 15:04:27 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: [PATCH v2 03/17] erofs-utils: introduce miscellaneous files
Date: Tue, 16 Jul 2019 15:04:05 +0800
Message-ID: <20190716070419.30203-4-gaoxiang25@huawei.com>
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

