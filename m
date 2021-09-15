Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936E240C2C5
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Sep 2021 11:29:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H8ZfS2zzvz2yWr
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Sep 2021 19:29:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com;
 envelope-from=guoxuenan@huawei.com; receiver=<UNKNOWN>)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H8ZfH1KYCz2yHt
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Sep 2021 19:28:52 +1000 (AEST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H8ZXx2p1Pz8yZ1;
 Wed, 15 Sep 2021 17:24:17 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 17:28:43 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 15 Sep
 2021 17:28:43 +0800
From: Guo Xuenan <guoxuenan@huawei.com>
To: <xiang@kernel.org>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v3 2/5] dump.erofs: add "-s" option to dump superblock
 information
Date: Wed, 15 Sep 2021 17:35:34 +0800
Message-ID: <20210915093537.2579575-2-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210915093537.2579575-1-guoxuenan@huawei.com>
References: <20210915093537.2579575-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
 dump/main.c      | 77 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/dump/Makefile.am b/dump/Makefile.am
index 3d8a32c..0bb7b4e 100644
--- a/dump/Makefile.am
+++ b/dump/Makefile.am
@@ -3,6 +3,7 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = dump.erofs
+AM_CPPFLAGS = ${libuuid_CFLAGS}
 dump_erofs_SOURCES = main.c
 dump_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
-dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la
\ No newline at end of file
+dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libuuid_LIBS}
\ No newline at end of file
diff --git a/dump/main.c b/dump/main.c
index af8db4b..7ece596 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -13,15 +13,38 @@
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
 
+struct feature {
+	bool compat;
+	__le32 flag;
+	const char *name;
+};
+
+static struct feature feature_lists[] = {
+	{ true, EROFS_FEATURE_COMPAT_SB_CHKSUM, "sb_csum" },
+	{ false, EROFS_FEATURE_INCOMPAT_LZ4_0PADDING, "0padding" },
+	{ false, EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER, "bigpcluster" },
+};
+
 static void usage(void)
 {
 	fputs("usage: [options] IMAGE\n\n"
 		"Dump erofs layout from IMAGE, and [options] are:\n"
+		"-s      print information about superblock\n"
 		"-V      print the version number of dump.erofs and exit.\n"
 		"--help  display this help and exit.\n",
 		stderr);
@@ -35,9 +58,12 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
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
@@ -63,6 +89,40 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
 	return 0;
 }
 
+static void dumpfs_print_superblock(void)
+{
+	time_t time = sbi.build_time;
+	char uuid_str[37] = "not available";
+	int i = 0;
+
+	fprintf(stdout, "Filesystem magic number:                      0x%04X\n",
+			EROFS_SUPER_MAGIC_V1);
+	fprintf(stdout, "Filesystem blocks:                            %lu\n",
+			sbi.blocks);
+	fprintf(stdout, "Filesystem inode metadata start block:        %u\n",
+			sbi.meta_blkaddr);
+	fprintf(stdout, "Filesystem shared xattr metadata start block: %u\n",
+			sbi.xattr_blkaddr);
+	fprintf(stdout, "Filesystem root nid:                          %ld\n",
+			sbi.root_nid);
+	fprintf(stdout, "Filesystem inode count:                       %lu\n",
+			sbi.inos);
+	fprintf(stdout, "Filesystem created:                           %s",
+			ctime(&time));
+	fprintf(stdout, "Filesystem features:                          ");
+	for (; i < ARRAY_SIZE(feature_lists); i++) {
+		__le32 feature = feature_lists[i].compat ?
+			sbi.feature_compat : sbi.feature_incompat;
+		if (feature & feature_lists[i].flag)
+			fprintf(stdout, "%s ", feature_lists[i].name);
+	}
+#ifdef HAVE_LIBUUID
+	uuid_unparse_lower(sbi.uuid, uuid_str);
+#endif
+	fprintf(stdout, "\nFilesystem UUID:                              %s\n",
+			uuid_str);
+}
+
 int main(int argc, char **argv)
 {
 	int err = 0;
@@ -75,6 +135,21 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
+	err = dev_open_ro(cfg.c_img_path);
+	if (err) {
+		erofs_err("open image file failed");
+		goto exit;
+	}
+
+	err = erofs_read_superblock();
+	if (err) {
+		erofs_err("read superblock failed");
+		goto exit;
+	}
+
+	if (dumpcfg.print_superblock)
+		dumpfs_print_superblock();
+
 exit:
 	erofs_exit_configure();
 	return err;
-- 
2.25.4

