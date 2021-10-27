Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B62D543C90C
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 13:58:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfRz84rCYz2yMg
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 22:58:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com;
 envelope-from=guoxuenan@huawei.com; receiver=<UNKNOWN>)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfRz608Rcz2xvL
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 22:58:09 +1100 (AEDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HfRw92BFDzZcV4;
 Wed, 27 Oct 2021 19:55:37 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 27 Oct 2021 19:57:33 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 27 Oct
 2021 19:57:32 +0800
From: Guo Xuenan <guoxuenan@huawei.com>
To: <xiang@kernel.org>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH 3/3] erofs-utils: dump: add -e option to dump the inode extent
 info
Date: Wed, 27 Oct 2021 20:03:51 +0800
Message-ID: <20211027120351.2885966-3-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027120351.2885966-1-guoxuenan@huawei.com>
References: <20211027120351.2885966-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
Cc: daeho43@gmail.com, mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Wang Qi <mpiglet@outlook.com>

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
Signed-off-by: Wang Qi <mpiglet@outlook.com>
---
 dump/main.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/dump/main.c b/dump/main.c
index 8a31345..e4018a7 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -18,9 +18,11 @@
 struct erofsdump_cfg {
 	unsigned int totalshow;
 	bool show_inode;
+	bool show_inode_phy;
 	bool show_superblock;
 	bool show_statistics;
 	u64 ino;
+	u64 ino_phy;
 };
 static struct erofsdump_cfg dumpcfg;
 
@@ -94,6 +96,7 @@ static void usage(void)
 	      "Dump erofs layout from IMAGE, and [options] are:\n"
 	      " -S      show statistic information of the image\n"
 	      " -V      print the version number of dump.erofs and exit.\n"
+	      " -e #    show the inode extent info of nid #\n"
 	      " -i #    show the target inode info of nid #\n"
 	      " -s      show information about superblock\n"
 	      " --help  display this help and exit.\n",
@@ -110,9 +113,14 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 	int opt;
 	u64 i;
 
-	while ((opt = getopt_long(argc, argv, "SVi:s",
+	while ((opt = getopt_long(argc, argv, "SVi:e:s",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
+		case 'e':
+			dumpcfg.show_inode_phy = true;
+			dumpcfg.ino_phy = atoll(optarg);
+			++dumpcfg.totalshow;
+			break;
 		case 'i':
 			i = atoll(optarg);
 			dumpcfg.show_inode = true;
@@ -408,6 +416,79 @@ static int erofs_get_pathname(erofs_nid_t nid, erofs_nid_t parent_nid,
 	return -1;
 }
 
+static void erofsdump_show_inode_phy(void)
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
+	unsigned int extent_count;
+	struct erofs_map_blocks map = {
+		.index = UINT_MAX,
+		.m_la = 0,
+	};
+
+	fprintf(stdout, "Inode: %lu\n", nid);
+	err = erofs_get_pathname(sbi.root_nid, sbi.root_nid, nid, path, 0);
+	if (err) {
+		erofs_err("Path not found\n");
+		return;
+	}
+	fprintf(stdout, "File path: %s\n", path);
+	fprintf(stdout, "File size: %lu\n", inode.i_size);
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
+		fprintf(stdout, "Plain blknr: %u - %u\n", start, end);
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
+		fprintf(stdout,
+				"Compressed blknr: %u - %u\n", start, end);
+		extent_count = 0;
+		map.m_la = 0;
+		fprintf(stdout, "Ext:  logical_offset/length:  physical_offset/length\n");
+		while (map.m_la < inode.i_size) {
+			err = z_erofs_map_blocks_iter(&inode, &map,
+					EROFS_GET_BLOCKS_FIEMAP);
+			fprintf(stdout, "%u: ", extent_count++);
+			fprintf(stdout, "%6lu..%-6lu / %-lu: ",
+					map.m_la, map.m_la + map.m_llen, map.m_llen);
+			fprintf(stdout, "%lu..%lu / %-lu\n",
+					map.m_pa, map.m_pa + map.m_plen, map.m_plen);
+			map.m_la += map.m_llen;
+		}
+		break;
+	}
+}
+
 static void dumpfs_print_inode(void)
 {
 	int err;
@@ -645,6 +726,9 @@ int main(int argc, char **argv)
 	if (dumpcfg.show_inode)
 		dumpfs_print_inode();
 
+	if (dumpcfg.show_inode_phy)
+		erofsdump_show_inode_phy();
+
 exit:
 	erofs_exit_configure();
 	return err;
-- 
2.31.1

