Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7A040A7D7
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Sep 2021 09:37:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H7wDd1BwTz2yNY
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Sep 2021 17:37:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com;
 envelope-from=guoxuenan@huawei.com; receiver=<UNKNOWN>)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H7wDY4tc9z2xlG
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Sep 2021 17:37:49 +1000 (AEST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H7w7l2QKRzQmdp;
 Tue, 14 Sep 2021 15:33:39 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 15:37:44 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 14 Sep
 2021 15:37:43 +0800
From: Guo Xuenan <guoxuenan@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v2 5/5] dump.erofs: add -I options to dump the layout of a
 particular inode on disk
Date: Tue, 14 Sep 2021 15:44:24 +0800
Message-ID: <20210914074424.1875409-5-guoxuenan@huawei.com>
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
 dump/main.c  | 90 +++++++++++++++++++++++++++++++++++++++++++++++-----
 lib/config.c |  3 ++
 2 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 233de50..5f20e84 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -23,8 +23,10 @@ struct dumpcfg {
 	bool print_superblock;
 	bool print_inode;
 	bool print_statistic;
+	bool print_inode_phy;
 	bool print_version;
 	u64 ino;
+	u64 ino_phy;
 };
 static struct dumpcfg dumpcfg;
 
@@ -111,9 +113,10 @@ static void usage(void)
 	fputs("usage: [options] erofs-image\n\n"
 		"Dump erofs layout from erofs-image, and [options] are:\n"
 		"--help  display this help and exit.\n"
+		"-i #    print target # inode info\n"
+		"-I #    print target # inode on-disk info\n"
 		"-s      print information about superblock\n"
 		"-S      print statistic information of the erofs-image\n"
-		"-i #    print target # inode info\n"
 		"-V      print the version number of dump.erofs and exit.\n",
 		stdout);
 }
@@ -128,7 +131,7 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
 	int opt;
 	u64 i;
 
-	while ((opt = getopt_long(argc, argv, "i:sSV",
+	while ((opt = getopt_long(argc, argv, "i:I:sSV",
 					long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'i':
@@ -136,6 +139,11 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
 			dumpcfg.print_inode = true;
 			dumpcfg.ino = i;
 			break;
+		case 'I':
+			i = atoll(optarg);
+			dumpcfg.print_inode_phy = true;
+			dumpcfg.ino_phy = i;
+			break;
 		case 's':
 			dumpcfg.print_superblock = true;
 			break;
@@ -188,6 +196,7 @@ static int get_file_compressed_size(struct erofs_inode *inode,
 	}
 	return 0;
 }
+
 static int get_path_by_nid(erofs_nid_t nid, erofs_nid_t parent_nid,
 		erofs_nid_t target, char *path, unsigned int pos)
 {
@@ -270,6 +279,69 @@ static int get_path_by_nid(erofs_nid_t nid, erofs_nid_t parent_nid,
 	return -1;
 }
 
+static void dumpfs_print_inode_phy(void)
+{
+	int err;
+	erofs_nid_t nid = dumpcfg.ino_phy;
+	struct erofs_inode inode = {.nid = nid};
+	char path[PATH_MAX + 1] = {0};
+
+	err = erofs_read_inode_from_disk(&inode);
+	if (err < 0) {
+		erofs_err("read inode %lu from disk failed", nid);
+		return;
+	}
+
+	const erofs_off_t ibase = iloc(inode.nid);
+	const erofs_off_t pos = Z_EROFS_VLE_LEGACY_INDEX_ALIGN(
+			ibase + inode.inode_isize + inode.xattr_isize);
+	erofs_blk_t blocks = inode.u.i_blocks;
+	erofs_blk_t start = 0;
+	erofs_blk_t end = 0;
+	struct erofs_map_blocks map = {
+		.index = UINT_MAX,
+		.m_la = 0,
+	};
+
+	fprintf(stdout, "Inode %lu on-disk info:\n", nid);
+	err = get_path_by_nid(sbi.root_nid, sbi.root_nid, nid, path, 0);
+	if (!err)
+		fprintf(stderr, "File Path:			%s\n",
+				path);
+	else
+		erofs_err("path not found");
+
+	switch (inode.datalayout) {
+	case EROFS_INODE_FLAT_INLINE:
+	case EROFS_INODE_FLAT_PLAIN:
+		if (inode.u.i_blkaddr == NULL_ADDR)
+			start = end = erofs_blknr(pos);
+		else {
+			start = inode.u.i_blkaddr;
+			end = start + BLK_ROUND_UP(inode.i_size) - 1;
+		}
+		fprintf(stdout, "File size:			%lu\n",
+				inode.i_size);
+		fprintf(stdout,
+				"Plain Block Address:		%u - %u\n",
+				start, end);
+		break;
+
+	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
+	case EROFS_INODE_FLAT_COMPRESSION:
+		err = z_erofs_map_blocks_iter(&inode, &map, 0);
+		if (err)
+			erofs_err("get file blocks range failed");
+
+		start = erofs_blknr(map.m_pa);
+		end = start - 1 + blocks;
+		fprintf(stderr,
+				"Compressed Block Address:	%u - %u\n",
+				start, end);
+		break;
+	}
+}
+
 static void dumpfs_print_inode(void)
 {
 	int err;
@@ -648,19 +720,19 @@ int main(int argc, char **argv)
 	if (err) {
 		if (err == -EINVAL)
 			usage();
-		goto out;
+		goto exit;
 	}
 
 	err = dev_open_ro(cfg.c_img_path);
 	if (err) {
 		erofs_err("open image file failed");
-		goto out;
+		goto exit;
 	}
 
 	err = erofs_read_superblock();
 	if (err) {
 		erofs_err("read superblock failed");
-		goto out;
+		goto exit;
 	}
 
 	if (dumpcfg.print_superblock)
@@ -671,8 +743,10 @@ int main(int argc, char **argv)
 
 	if (dumpcfg.print_inode)
 		dumpfs_print_inode();
-out:
-	if (cfg.c_img_path)
-		free(cfg.c_img_path);
+
+	if (dumpcfg.print_inode_phy)
+		dumpfs_print_inode_phy();
+exit:
+	erofs_exit_configure();
 	return err;
 }
diff --git a/lib/config.c b/lib/config.c
index 99fcf49..405fae6 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -7,6 +7,7 @@
  * Created by Li Guifu <bluce.liguifu@huawei.com>
  */
 #include <string.h>
+#include <stdlib.h>
 #include "erofs/print.h"
 #include "erofs/internal.h"
 
@@ -45,6 +46,8 @@ void erofs_exit_configure(void)
 	if (cfg.sehnd)
 		selabel_close(cfg.sehnd);
 #endif
+	if (cfg.c_img_path)
+		free(cfg.c_img_path);
 }
 
 static unsigned int fullpath_prefix;	/* root directory prefix length */
-- 
2.25.4

