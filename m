Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59328407881
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Sep 2021 15:59:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H6Dr31Wbwz2yPt
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Sep 2021 23:59:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com;
 envelope-from=guoxuenan@huawei.com; receiver=<UNKNOWN>)
X-Greylist: delayed 1154 seconds by postgrey-1.36 at boromir;
 Sat, 11 Sep 2021 23:59:03 AEST
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H6Dqq2KYkz2y8R
 for <linux-erofs@lists.ozlabs.org>; Sat, 11 Sep 2021 23:59:01 +1000 (AEST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H6DNm64DDz8spB;
 Sat, 11 Sep 2021 21:39:04 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 11 Sep 2021 21:39:37 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 11 Sep
 2021 21:39:37 +0800
From: Guo Xuenan <guoxuenan@huawei.com>
To: <xiang@kernel.org>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v1 1/5] erofs-utils: introduce dump.erofs for utils
Date: Sat, 11 Sep 2021 21:46:31 +0800
Message-ID: <20210911134635.1253426-1-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600004.china.huawei.com (7.193.23.242)
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
Cc: mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: mpiglet <mpiglet@outlook.com>

Add dump-tool for erofs to facilitate users directly
analyzing the erofs image file.

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
Signed-off-by: mpiglet <mpiglet@outlook.com>
---
 Makefile.am        |  2 +-
 configure.ac       |  2 ++
 dump/Makefile.am   | 10 ++++++
 dump/main.c        | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 include/erofs/io.h |  3 ++
 lib/namei.c        |  4 +--
 6 files changed, 102 insertions(+), 3 deletions(-)
 create mode 100644 dump/Makefile.am
 create mode 100644 dump/main.c

diff --git a/Makefile.am b/Makefile.am
index b804aa9..fedf7b5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -3,7 +3,7 @@
 
 ACLOCAL_AMFLAGS = -I m4
 
-SUBDIRS = man lib mkfs
+SUBDIRS = man lib mkfs dump
 if ENABLE_FUSE
 SUBDIRS += fuse
 endif
diff --git a/configure.ac b/configure.ac
index f626064..f4fe548 100644
--- a/configure.ac
+++ b/configure.ac
@@ -280,6 +280,8 @@ AC_CONFIG_FILES([Makefile
 		 man/Makefile
 		 lib/Makefile
 		 mkfs/Makefile
+		 dump/Makefile
 		 fuse/Makefile])
+
 AC_OUTPUT
 
diff --git a/dump/Makefile.am b/dump/Makefile.am
new file mode 100644
index 0000000..e664799
--- /dev/null
+++ b/dump/Makefile.am
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile.am
+
+AUTOMAKE_OPTIONS = foreign
+bin_PROGRAMS     = dump.erofs
+AM_CPPFLAGS = ${libuuid_CFLAGS} ${libselinux_CFLAGS}
+dump_erofs_SOURCES = main.c
+dump_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
+dump_erofs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} ${liblz4_LIBS}
+
diff --git a/dump/main.c b/dump/main.c
new file mode 100644
index 0000000..8fbc24a
--- /dev/null
+++ b/dump/main.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dump/main.c
+ *
+ * Copyright (C) 2021-2022 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Wang Qi <mpiglet@outlook.com>
+ *            Guo Xuenan <guoxuenan@huawei.com>
+ */
+
+#include <stdlib.h>
+#include <getopt.h>
+#include <sys/sysmacros.h>
+#include <time.h>
+#include <lz4.h>
+
+#include "erofs/print.h"
+#include "erofs/io.h"
+
+static struct option long_options[] = {
+	{"help", no_argument, 0, 1},
+	{0, 0, 0, 0},
+};
+
+static void usage(void)
+{
+	fputs("usage: [options] erofs-image \n\n"
+		"Dump erofs layout from erofs-image, and [options] are:\n"
+		"-v/-V      print dump.erofs version info\n"
+		"-h/--help  display this help and exit\n", stderr);
+}
+static void dumpfs_print_version(void)
+{
+	fprintf(stderr, "dump.erofs %s\n", cfg.c_version);
+}
+
+static int dumpfs_parse_options_cfg(int argc, char **argv)
+{
+	int opt;
+
+	while ((opt = getopt_long(argc, argv, "sSvVi:I:h",
+					long_options, NULL)) != -1) {
+		switch (opt) {
+		case 'v':
+		case 'V':
+			dumpfs_print_version();
+			exit(0);
+		case 'h':
+		case 1:
+		    usage();
+		    exit(0);
+		default: /* '?' */
+			return -EINVAL;
+		}
+	}
+
+	if (optind >= argc)
+		return -EINVAL;
+
+	cfg.c_img_path = strdup(argv[optind++]);
+	if (!cfg.c_img_path)
+		return -ENOMEM;
+
+	if (optind < argc) {
+		erofs_err("unexpected argument: %s\n", argv[optind]);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int err = 0;
+
+	erofs_init_configure();
+	err = dumpfs_parse_options_cfg(argc, argv);
+	if (err) {
+		if (err == -EINVAL)
+			usage();
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/include/erofs/io.h b/include/erofs/io.h
index 5574245..00e5de8 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -10,6 +10,7 @@
 #define __EROFS_IO_H
 
 #include <unistd.h>
+#include <sys/types.h>
 #include "internal.h"
 
 #ifndef O_BINARY
@@ -25,6 +26,8 @@ int dev_fillzero(u64 offset, size_t len, bool padding);
 int dev_fsync(void);
 int dev_resize(erofs_blk_t nblocks);
 u64 dev_length(void);
+dev_t erofs_new_decode_dev(u32 dev);
+int erofs_read_inode_from_disk(struct erofs_inode *vi);
 
 static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
 			    u32 nblocks)
diff --git a/lib/namei.c b/lib/namei.c
index 4e06ba4..21631f1 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -15,7 +15,7 @@
 #include "erofs/print.h"
 #include "erofs/io.h"
 
-static dev_t erofs_new_decode_dev(u32 dev)
+dev_t erofs_new_decode_dev(u32 dev)
 {
 	const unsigned int major = (dev & 0xfff00) >> 8;
 	const unsigned int minor = (dev & 0xff) | ((dev >> 12) & 0xfff00);
@@ -23,7 +23,7 @@ static dev_t erofs_new_decode_dev(u32 dev)
 	return makedev(major, minor);
 }
 
-static int erofs_read_inode_from_disk(struct erofs_inode *vi)
+int erofs_read_inode_from_disk(struct erofs_inode *vi)
 {
 	int ret, ifmt;
 	char buf[sizeof(struct erofs_inode_extended)];
-- 
2.25.4

