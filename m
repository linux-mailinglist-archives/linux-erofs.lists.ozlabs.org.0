Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5368F40A7D8
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Sep 2021 09:37:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H7wDg1XVHz2yPF
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Sep 2021 17:37:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com;
 envelope-from=guoxuenan@huawei.com; receiver=<UNKNOWN>)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H7wDZ0Lgtz2xr1
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Sep 2021 17:37:49 +1000 (AEST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H7w7G0hLQz8wXq;
 Tue, 14 Sep 2021 15:33:14 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 15:37:39 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 14 Sep
 2021 15:37:38 +0800
From: Guo Xuenan <guoxuenan@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v2 2/5] dump.erofs: add "-s" option to dump superblock
 information
Date: Tue, 14 Sep 2021 15:44:21 +0800
Message-ID: <20210914074424.1875409-2-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210914074424.1875409-1-guoxuenan@huawei.com>
References: <20210914074424.1875409-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

From: Wang Qi <mpiglet@outlook.com>

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
Signed-off-by: Wang Qi <mpiglet@outlook.com>
---
 dump/Makefile.am |  3 +-
 dump/main.c      | 94 +++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/dump/Makefile.am b/dump/Makefile.am
index 8e18c0f..1ba58da 100644
--- a/dump/Makefile.am
+++ b/dump/Makefile.am
@@ -3,7 +3,8 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = dump.erofs
+AM_CPPFLAGS = ${libuuid_CFLAGS}
 dump_erofs_SOURCES = main.c
 dump_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
-dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${liblz4_LIBS}
+dump_erofs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/liberofs.la ${liblz4_LIBS}
 
diff --git a/dump/main.c b/dump/main.c
index 8f299ca..33521bf 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -6,25 +6,57 @@
  *            Guo Xuenan <guoxuenan@huawei.com>
  */
 
+#define _GNU_SOURCE
 #include <stdlib.h>
 #include <getopt.h>
 #include <sys/sysmacros.h>
 #include <time.h>
 #include <lz4.h>
-
 #include "erofs/print.h"
 #include "erofs/io.h"
 
+#ifdef HAVE_LIBUUID
+#include <uuid.h>
+#endif
+
+struct dumpcfg {
+	bool print_superblock;
+	bool print_version;
+};
+static struct dumpcfg dumpcfg;
+
 static struct option long_options[] = {
 	{"help", no_argument, 0, 1},
 	{0, 0, 0, 0},
 };
 
+#define EROFS_FEATURE_COMPAT	0
+#define EROFS_FEATURE_INCOMPAT	1
+
+struct feature {
+	int compat;
+	unsigned int mask;
+	const char *name;
+};
+
+static struct feature feature_lists[] = {
+	{	EROFS_FEATURE_COMPAT, EROFS_FEATURE_COMPAT_SB_CHKSUM,
+		"superblock-checksum"	},
+
+	{	EROFS_FEATURE_INCOMPAT, EROFS_FEATURE_INCOMPAT_LZ4_0PADDING,
+		"lz4-0padding"	},
+	{	EROFS_FEATURE_INCOMPAT, EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER,
+		"big-pcluster"	},
+
+	{	0, 0, 0	},
+};
+
 static void usage(void)
 {
 	fputs("usage: [options] erofs-image\n\n"
 		"Dump erofs layout from erofs-image, and [options] are:\n"
 		"--help  display this help and exit.\n"
+		"-s          print information about superblock\n"
 		"-V      print the version number of dump.erofs and exit.\n",
 		stderr);
 }
@@ -37,9 +69,12 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
 {
 	int opt;
 
-	while ((opt = getopt_long(argc, argv, "V",
+	while ((opt = getopt_long(argc, argv, "sV",
 					long_options, NULL)) != -1) {
 		switch (opt) {
+		case 's':
+			dumpcfg.print_superblock = true;
+			break;
 		case 'V':
 			dumpfs_print_version();
 			exit(0);
@@ -65,21 +100,64 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
 	return 0;
 }
 
+static void dumpfs_print_superblock(void)
+{
+	time_t time = sbi.build_time;
+	unsigned int features[] = {sbi.feature_compat, sbi.feature_incompat};
+	char uuid_str[37] = "not available";
+	int i = 0;
+	int j = 0;
+
+	fprintf(stdout, "Filesystem magic number:			0x%04X\n", EROFS_SUPER_MAGIC_V1);
+	fprintf(stdout, "Filesystem blocks:				%lu\n", sbi.blocks);
+	fprintf(stdout, "Filesystem inode metadata start block:		%u\n", sbi.meta_blkaddr);
+	fprintf(stdout, "Filesystem shared xattr metadata start block:	%u\n", sbi.xattr_blkaddr);
+	fprintf(stdout, "Filesystem root nid:				%ld\n", sbi.root_nid);
+	fprintf(stdout, "Filesystem valid inode count:			%lu\n", sbi.inos);
+	fprintf(stdout, "Filesystem created:				%s", ctime(&time));
+	fprintf(stdout, "Filesystem features:				");
+	for (; i < ARRAY_SIZE(features); i++) {
+		for (; j < ARRAY_SIZE(feature_lists); j++) {
+			if (i == feature_lists[j].compat
+				&& (features[i] & feature_lists[j].mask))
+				fprintf(stdout, "%s ", feature_lists[j].name);
+		}
+	}
+	fprintf(stdout, "\n");
+#ifdef HAVE_LIBUUID
+	uuid_unparse_lower(sbi.uuid, uuid_str);
+#endif
+	fprintf(stdout, "Filesystem UUID:				%s\n", uuid_str);
+}
+
 int main(int argc, char **argv)
 {
 	int err = 0;
 
 	erofs_init_configure();
 	err = dumpfs_parse_options_cfg(argc, argv);
-
-	if (cfg.c_img_path)
-		free(cfg.c_img_path);
-
 	if (err) {
 		if (err == -EINVAL)
 			usage();
-		return -1;
+		goto out;
 	}
 
-	return 0;
+	err = dev_open_ro(cfg.c_img_path);
+	if (err) {
+		erofs_err("open image file failed");
+		goto out;
+	}
+
+	err = erofs_read_superblock();
+	if (err) {
+		erofs_err("read superblock failed");
+		goto out;
+	}
+
+	if (dumpcfg.print_superblock)
+		dumpfs_print_superblock();
+out:
+	if (cfg.c_img_path)
+		free(cfg.c_img_path);
+	return err;
 }
-- 
2.25.4

