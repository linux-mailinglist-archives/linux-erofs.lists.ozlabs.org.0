Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 722866A29A
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 09:05:13 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nrxm3kvGzDqTk
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 17:05:00 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nrxR16NRzDqTh
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 17:04:42 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 6DFD7CBACC5B03A1D0E9;
 Tue, 16 Jul 2019 15:04:40 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Jul
 2019 15:04:32 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: [PATCH v2 07/17] erofs-utils: introduce mkfs support
Date: Tue, 16 Jul 2019 15:04:09 +0800
Message-ID: <20190716070419.30203-8-gaoxiang25@huawei.com>
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

This patch adds mkfs support to erofs-utils, and
it's able to build uncompressed images at the moment.

Signed-off-by: Li Guifu <bluce.liguifu@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 Makefile.am      |   2 +-
 configure.ac     |   3 +-
 mkfs/Makefile.am |   9 +++
 mkfs/main.c      | 179 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 191 insertions(+), 2 deletions(-)
 create mode 100644 mkfs/Makefile.am
 create mode 100644 mkfs/main.c

diff --git a/Makefile.am b/Makefile.am
index ee5fd92..d94ab73 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -3,4 +3,4 @@
 
 ACLOCAL_AMFLAGS = -I m4
 
-SUBDIRS=lib
+SUBDIRS=lib mkfs
diff --git a/configure.ac b/configure.ac
index 9c6d8bb..49f1a7d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -103,5 +103,6 @@ AC_CHECK_DECL(lseek64,[AC_DEFINE(HAVE_LSEEK64_PROTOTYPE, 1,
 AC_CHECK_FUNCS([gettimeofday memset realpath strdup strerror strrchr strtoull])
 
 AC_CONFIG_FILES([Makefile
-		 lib/Makefile])
+		 lib/Makefile
+		 mkfs/Makefile])
 AC_OUTPUT
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
new file mode 100644
index 0000000..257f864
--- /dev/null
+++ b/mkfs/Makefile.am
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile.am
+
+AUTOMAKE_OPTIONS = foreign
+bin_PROGRAMS     = mkfs.erofs
+mkfs_erofs_SOURCES = main.c
+mkfs_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
+mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la
+
diff --git a/mkfs/main.c b/mkfs/main.c
new file mode 100644
index 0000000..ec1712f
--- /dev/null
+++ b/mkfs/main.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * mkfs/main.c
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Li Guifu <bluce.liguifu@huawei.com>
+ */
+#define _GNU_SOURCE
+#include <time.h>
+#include <sys/time.h>
+#include <stdlib.h>
+#include <limits.h>
+#include <libgen.h>
+#include "erofs/config.h"
+#include "erofs/print.h"
+#include "erofs/cache.h"
+#include "erofs/inode.h"
+#include "erofs/io.h"
+
+#define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
+
+static void usage(void)
+{
+	fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
+	fprintf(stderr, "Generate erofs image from DIRECTORY to FILE, and [options] are:\n");
+	fprintf(stderr, " -d#       set output message level to # (maximum 9)\n");
+}
+
+u64 parse_num_from_str(const char *str)
+{
+	u64 num      = 0;
+	char *endptr = NULL;
+
+	num = strtoull(str, &endptr, 10);
+	BUG_ON(num == ULLONG_MAX);
+	return num;
+}
+
+static int mkfs_parse_options_cfg(int argc, char *argv[])
+{
+	int opt;
+
+	while ((opt = getopt(argc, argv, "d:z:")) != -1) {
+		switch (opt) {
+		case 'd':
+			cfg.c_dbg_lvl = parse_num_from_str(optarg);
+			break;
+
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
+	if (optind > argc) {
+		erofs_err("Source directory is missing");
+		return -EINVAL;
+	}
+
+	cfg.c_src_path = realpath(argv[optind++], NULL);
+	if (!cfg.c_src_path) {
+		erofs_err("Failed to parse source directory: %s",
+			  erofs_strerror(-errno));
+		return -ENOENT;
+	}
+
+	if (optind < argc) {
+		erofs_err("Unexpected argument: %s\n", argv[optind]);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
+				  erofs_nid_t root_nid)
+{
+	struct erofs_super_block sb = {
+		.magic     = cpu_to_le32(EROFS_SUPER_MAGIC_V1),
+		.blkszbits = LOG_BLOCK_SIZE,
+		.inos   = 0,
+		.blocks = 0,
+		.meta_blkaddr  = sbi.meta_blkaddr,
+		.xattr_blkaddr = 0,
+	};
+	const unsigned int sb_blksize =
+		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
+	char *buf;
+	struct timeval t;
+
+	if (!gettimeofday(&t, NULL)) {
+		sb.build_time      = cpu_to_le64(t.tv_sec);
+		sb.build_time_nsec = cpu_to_le32(t.tv_usec);
+	}
+
+	sb.blocks       = cpu_to_le32(erofs_mapbh(NULL, true));
+	sb.root_nid     = cpu_to_le16(root_nid);
+
+	buf = calloc(sb_blksize, 1);
+	if (!buf) {
+		erofs_err("Failed to allocate memory for sb: %s",
+			  erofs_strerror(-errno));
+		return -ENOMEM;
+	}
+	memcpy(buf + EROFS_SUPER_OFFSET, &sb, sizeof(sb));
+
+	bh->fsprivate = buf;
+	bh->op = &erofs_buf_write_bhops;
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int err = 0;
+	struct erofs_buffer_head *sb_bh;
+	struct erofs_inode *root_inode;
+	erofs_nid_t root_nid;
+
+	erofs_init_configure();
+	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
+
+	err = mkfs_parse_options_cfg(argc, argv);
+	if (err) {
+		if (err == -EINVAL)
+			usage();
+		return 1;
+	}
+
+	err = dev_open(cfg.c_img_path);
+	if (err) {
+		usage();
+		return 1;
+	}
+
+	erofs_show_config();
+
+	sb_bh = erofs_buffer_init();
+	err = erofs_bh_balloon(sb_bh, EROFS_SUPER_END);
+	if (err < 0) {
+		erofs_err("Failed to balloon erofs_super_block: %s",
+			  erofs_strerror(err));
+		goto exit;
+	}
+
+	erofs_inode_manager_init();
+
+	root_inode = erofs_mkfs_build_tree_from_path(NULL, cfg.c_src_path);
+	if (IS_ERR(root_inode)) {
+		err = PTR_ERR(root_inode);
+		goto exit;
+	}
+
+	root_nid = erofs_lookupnid(root_inode);
+	erofs_iput(root_inode);
+
+	err = erofs_mkfs_update_super_block(sb_bh, root_nid);
+	if (err)
+		goto exit;
+
+	/* flush all remaining buffers */
+	if (!erofs_bflush(NULL))
+		err = -EIO;
+exit:
+	dev_close();
+	erofs_exit_configure();
+
+	if (err) {
+		erofs_err("\tCould not format the device : %s\n",
+			  erofs_strerror(err));
+		return 1;
+	}
+	return err;
+}
-- 
2.17.1

