Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC11305EF
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 02:51:59 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45FQrX6Mm3zDqTF
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 10:51:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1559263916;
	bh=/PQ9PDnir7fFoi8YaoJCIwl4XmVAjLm1NRIQ7pMz+oQ=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=VZuIfOlOg0iqP0enUGnE426CzFAeIq6WQwMgxnNT3c+gl0q5Rzy2KNG/mDkLMA6q5
	 le7gNzZTbzBq4X3Pxn8Rp8BoJeMmxnS97qPg27RmdZbyHgXmfx10coIEEyfaSNSRAY
	 zLg9+nyoywCUkPg6j4fi6R6FR5SvUdQwV4qb5cs/Z08331oGVIzkzTFs3TuInYHA2m
	 RrUS7EtabK9uX46zT9o690FgtvJ4in8j25nY62b/ByrzZmt2ZgJ7fI9cbnOZxPCDEN
	 38XatGxqxEFOYCl/b8qdnHsN+JtoM6xo7NGZMNdxSPVNjI8RGXt+K/DnbuaJkJMr1d
	 p95mLJek4DUTg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.69.148; helo=sonic310-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="rNw6z+DE"; 
 dkim-atps=neutral
Received: from sonic310-22.consmr.mail.gq1.yahoo.com
 (sonic310-22.consmr.mail.gq1.yahoo.com [98.137.69.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FQr16r9kzDqW5
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 May 2019 10:51:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1559263888; bh=sJ/I5seLhNDrkrjiZY/wDGhtoZtVeUhKjEpzrXmvsGg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=rNw6z+DEX4vY/c56P78UhCOjy3/vYWtiFf2i2geTJHq8Yp1evE8FGIYgl1iJ1km52uzCBVtkK+S7bdh3vZJyGc/mD9Y6gRThm5fP8lssJNPq42ZCbtUAvrZYCbGOH0NJRoIdXl8n2CLElATWbzqC4FmlszXUDujUaduqAFwTccMT2bReJzN2P+6h70ropHpjeqU56q3AWsFW2pll/yGnItm1GmQHP2u0cFYyOfsrQGCV+uEk8BPLzjgUY0hAH6Z9WQe7/V8UkQpIJ0PoVstNxykP1GMjGHaI70vI60U5V8bUeontvFhihd01OilVQqVWUKwJoaA9t4BdRntWSX6W/A==
X-YMail-OSG: hEmFTMcVM1nmWf9n_YL0LOCcyNVPzDnbEUZOIH37o4RVfBtYbXf.0JFtTbakZCR
 B1oHk5DfL4D.qWNwY97Y6vRkMT63ISs5KwiOtpUpnfL_ouFMjqadbXSpDHpeTNDkRsmvnt9sFCkV
 03n0zfmCEKfoYUmR9dZVYfCf.nq9jmOX7_Tfr20dCL1Bl7u_0bx3T12sdy4C9jT9gani8_u5W7AW
 2J._eHFxPX..CeDG4mkPFwFabzsT7im7OYwGKET2jO6cJ6LHxGYEqSKABipmoVYYRd13y6xnbs9K
 .FnXUiJCK_1TuDHH3CVVdXPJgUEKlpe2wtm_gANlLyd54NF1TS6KfiHGSDFAsGpdKEFLEsIuRLNH
 OySElZ3tjyWC_mXurgSS2ZOeKPxkN0rmGZQzVwlDq2Lqcn0kC2DmQa5wCLHBkzjzdez.v645x4WN
 m37QURYPcBc7zkY1z.xXl.Evr6sCbkktlhi7wfRHA6TH0r4nGNC8AYl41qsLPWj0QFxcdHDXtSaL
 CqYIo9s_j_7FAN7xJ5QbYDt5plcioeRPjuatTDpzdA.zFOmxYwYKT5uL7HR3elZVCEWmfo2FQYjW
 8yzkuPIbjtURCaooUi3KmRGxLhJIApt1aZJYV.a5q0EInDz87TLw8FaaA2sgbOXNe7l5Rv4yST8E
 dhO_FnDp.iITJ1xWQ7Qi6HuqVaEjZGugYCF20pwxkQdcPdBWBQLfJ13mjXbPSkdnggNNuC1cZ4q4
 6C5R6cG7Ncyc6motm.St5asLm3qee2yaTTN_6hL7V6l0ceqnCpSSM43paLgzKKU_kWkwwmylvhXk
 0HPGwEzHcIGJC6OO9RVgnJG7xYP5loS9oHre23RD2iSAzUttOOGjBXC9ic4YlvUkFBYNoUkxNVf2
 pHMBikabn2wErvfd1If.RJb4CjGfekwHF34RB2ztB0Tu0wnKv.T4Mr4sTLHlizf2y8O4Rjf6rOF3
 4TVawTD_uBo.Do8q0v_dDFTOVWiMaIYJZp.j45g6M9HOUmdK8dOAuacPVrJ_rkfYc7YpM8ZUOoiR
 v.PtSjDL9cIEPa2LrJhLvFkrbzp2mO_edulNPekIBsuadyYJG1R2syCeByRyl4b1ur8sUwpVDUhV
 p5WdLLiEbpC__IOBqSkmEvZeCUEFXzUsmpdPCpgCrBFWljjukcImgYU_xlm9ktp6w4cfEIIX6buv
 phVdQ2_uAt3LeYcXxtdibFZsg2wERcveqlXlWiXTcFfrAFk7uOk3weGHxfKTry0bCFEk-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 00:51:28 +0000
Received: from 125.120.86.223 (EHLO localhost.localdomain) ([125.120.86.223])
 by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID a9e989b6e54ef4fb7ecb5a20a6091749; 
 Fri, 31 May 2019 00:51:27 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 07/13] erofs-utils: introduce mkfs support
Date: Fri, 31 May 2019 08:50:41 +0800
Message-Id: <20190531005047.22093-8-hsiangkao@aol.com>
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
index 0000000..1ed15d2
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
+static void usage(char *execpath)
+{
+	fprintf(stderr, "%s %s\n", basename(execpath), cfg.c_version);
+	fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
+	fprintf(stderr, "Generate erofs image from DIRECTORY to FILE, and [options] are:\n");
+	fprintf(stderr, " -d#      set output message level to # (maximum 9)\n");
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
+	int opt, i;
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
+	err = mkfs_parse_options_cfg(argc, argv);
+	if (err) {
+		if (err == -EINVAL)
+			usage(argv[0]);
+		return 1;
+	}
+
+	err = dev_open(cfg.c_img_path);
+	if (err) {
+		usage(argv[0]);
+		return 1;
+	}
+
+	erofs_err("%s %s\n", basename(argv[0]), cfg.c_version);
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

