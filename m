Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656B240787E
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Sep 2021 15:59:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H6Dqy1yj5z2yLZ
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Sep 2021 23:59:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com;
 envelope-from=guoxuenan@huawei.com; receiver=<UNKNOWN>)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H6Dqq3G5Pz2yHb
 for <linux-erofs@lists.ozlabs.org>; Sat, 11 Sep 2021 23:59:00 +1000 (AEST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H6DNr6Lhqz8sw0;
 Sat, 11 Sep 2021 21:39:08 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 11 Sep 2021 21:39:41 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 11 Sep
 2021 21:39:41 +0800
From: Guo Xuenan <guoxuenan@huawei.com>
To: <xiang@kernel.org>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v1 2/5] dump.erofs: add "-s" option to dump superblock
 information
Date: Sat, 11 Sep 2021 21:46:32 +0800
Message-ID: <20210911134635.1253426-2-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210911134635.1253426-1-guoxuenan@huawei.com>
References: <20210911134635.1253426-1-guoxuenan@huawei.com>
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

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
Signed-off-by: mpiglet <mpiglet@outlook.com>
---
 dump/main.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/dump/main.c b/dump/main.c
index 8fbc24a..25ac89f 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -17,6 +17,12 @@
 #include "erofs/print.h"
 #include "erofs/io.h"
 
+struct dumpcfg {
+	bool print_superblock;
+	bool print_version;
+};
+static struct dumpcfg dumpcfg;
+
 static struct option long_options[] = {
 	{"help", no_argument, 0, 1},
 	{0, 0, 0, 0},
@@ -26,6 +32,7 @@ static void usage(void)
 {
 	fputs("usage: [options] erofs-image \n\n"
 		"Dump erofs layout from erofs-image, and [options] are:\n"
+		"-s          print information about superblock\n"
 		"-v/-V      print dump.erofs version info\n"
 		"-h/--help  display this help and exit\n", stderr);
 }
@@ -41,6 +48,9 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
 	while ((opt = getopt_long(argc, argv, "sSvVi:I:h",
 					long_options, NULL)) != -1) {
 		switch (opt) {
+		case 's':
+			dumpcfg.print_superblock = true;
+			break;
 		case 'v':
 		case 'V':
 			dumpfs_print_version();
@@ -68,6 +78,39 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
 	return 0;
 }
 
+static void dumpfs_print_superblock(void)
+{
+	time_t time = sbi.build_time;
+
+	fprintf(stderr, "Filesystem magic number:	0x%04X\n", EROFS_SUPER_MAGIC_V1);
+	fprintf(stderr, "Filesystem blocks: 		%lu\n", sbi.blocks);
+	fprintf(stderr, "Filesystem meta block:		%u\n", sbi.meta_blkaddr);
+	fprintf(stderr, "Filesystem xattr block:	%u\n", sbi.xattr_blkaddr);
+	fprintf(stderr, "Filesystem root nid:		%ld\n", sbi.root_nid);
+	fprintf(stderr, "Filesystem valid inos:		%lu\n", sbi.inos);
+	fprintf(stderr, "Filesystem created:		%s", ctime(&time));
+	fprintf(stderr, "Filesystem uuid:		");
+	for (int i = 0; i < 16; i++)
+		fprintf(stderr, "%02x", sbi.uuid[i]);
+	fprintf(stderr, "\n");
+
+	if (erofs_sb_has_lz4_0padding())
+		fprintf(stderr, "Filesystem support lz4 0padding\n");
+	else
+		fprintf(stderr, "Filesystem not support lz4 0padding\n");
+
+	if (erofs_sb_has_big_pcluster())
+		fprintf(stderr, "Filesystem support big pcluster\n");
+	else
+		fprintf(stderr, "Filesystem not support big pcluster\n");
+
+	if (erofs_sb_has_sb_chksum())
+		fprintf(stderr, "Filesystem has super block checksum feature\n");
+	else
+		fprintf(stderr, "Filesystem has no superblock checksum feature\n");
+
+}
+
 int main(int argc, char **argv)
 {
 	int err = 0;
@@ -80,5 +123,20 @@ int main(int argc, char **argv)
 		return -1;
 	}
 
+	err = dev_open_ro(cfg.c_img_path);
+	if (err) {
+		erofs_err("open image file failed");
+		return -1;
+	}
+
+	err = erofs_read_superblock();
+	if (err) {
+		erofs_err("read superblock failed");
+		return -1;
+	}
+
+	if (dumpcfg.print_superblock)
+		dumpfs_print_superblock();
+
 	return 0;
 }
-- 
2.25.4

