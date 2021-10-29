Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A62FE43F960
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 11:06:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hgc3j4ZsTz3bYW
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 20:06:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com;
 envelope-from=guoxuenan@huawei.com; receiver=<UNKNOWN>)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hgc3W6QtRz2yHW
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Oct 2021 20:05:58 +1100 (AEDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Hgc176HsTz1DHwy;
 Fri, 29 Oct 2021 17:03:55 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 29 Oct 2021 17:05:50 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 17:05:49 +0800
From: Guo Xuenan <guoxuenan@huawei.com>
To: <xiang@kernel.org>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v3 4/5] erofs-utils: dump: add support for showing file
 extents.
Date: Fri, 29 Oct 2021 17:12:43 +0800
Message-ID: <20211029091244.1162119-4-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211029091244.1162119-1-guoxuenan@huawei.com>
References: <20211029091244.1162119-1-guoxuenan@huawei.com>
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
Cc: mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add option -e to show file extents info, this option needs
specify nid as well. (eg. dump.erofs --nid # -e erofs.img)

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
Signed-off-by: Wang Qi <mpiglet@outlook.com>
---
 dump/main.c              | 50 +++++++++++++++++++++++++++++++++++++---
 include/erofs/internal.h |  2 ++
 lib/data.c               |  4 ++--
 3 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 78e952e..4acb742 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -18,6 +18,7 @@
 struct erofsdump_cfg {
 	unsigned int totalshow;
 	bool show_inode;
+	bool show_extent;
 	bool show_superblock;
 	bool show_statistics;
 	erofs_nid_t nid;
@@ -94,6 +95,7 @@ static void usage(void)
 	fputs("usage: [options] IMAGE\n\n"
 	      "Dump erofs layout from IMAGE, and [options] are:\n"
 	      " -V      print the version number of dump.erofs and exit.\n"
+	      " -e      show extent info (require --nid set)\n"
 	      " -s      show information about superblock\n"
 	      " -S      show statistic information of the image\n"
 	      " --nid=# show the target inode info of nid #\n"
@@ -110,9 +112,13 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 {
 	int opt;
 
-	while ((opt = getopt_long(argc, argv, "SV:s",
+	while ((opt = getopt_long(argc, argv, "SVes",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
+		case 'e':
+			dumpcfg.show_extent = true;
+			++dumpcfg.totalshow;
+			break;
 		case 's':
 			dumpcfg.show_superblock = true;
 			++dumpcfg.totalshow;
@@ -407,7 +413,15 @@ static int erofs_get_pathname(erofs_nid_t nid, erofs_nid_t parent_nid,
 	return -1;
 }
 
-static void erofsdump_show_fileinfo(void)
+static int erofsdump_map_blocks(struct erofs_inode *inode,
+		struct erofs_map_blocks *map, int flags)
+{
+	if (erofs_inode_is_data_compressed(inode->datalayout))
+		return z_erofs_map_blocks_iter(inode, map, flags);
+	return erofs_map_blocks(inode, map, flags);
+}
+
+static void erofsdump_show_fileinfo(bool show_extent)
 {
 	int err;
 	erofs_off_t size;
@@ -419,6 +433,11 @@ static void erofsdump_show_fileinfo(void)
 	char path[PATH_MAX + 1] = {0};
 	char access_mode_str[] = "rwxrwxrwx";
 	char timebuf[128] = {0};
+	unsigned int extent_count = 0;
+	struct erofs_map_blocks map = {
+		.index = UINT_MAX,
+		.m_la = 0,
+	};
 
 	err = erofs_read_inode_from_disk(&inode);
 	if (err) {
@@ -460,6 +479,26 @@ static void erofsdump_show_fileinfo(void)
 	fprintf(stdout, "Uid: %u   Gid: %u  ", inode.i_uid, inode.i_gid);
 	fprintf(stdout, "Access: %04o/%s\n", access_mode, access_mode_str);
 	fprintf(stdout, "Timestamp: %s.%09d\n", timebuf, time_nsec);
+
+	if (!dumpcfg.show_extent)
+		return;
+
+	fprintf(stdout, "\nExt:  logical_offset/length:  physical_offset/length\n");
+	while (map.m_la < inode.i_size) {
+		err = erofsdump_map_blocks(&inode, &map,
+				EROFS_GET_BLOCKS_FIEMAP);
+		if (err) {
+			erofs_err("get file blocks range failed");
+			return;
+		}
+		fprintf(stdout, "%u: ", extent_count++);
+		fprintf(stdout, "%6lu..%-6lu / %-lu: ",
+				map.m_la, map.m_la + map.m_llen, map.m_llen);
+		fprintf(stdout, "%lu..%lu / %-lu\n",
+				map.m_pa, map.m_pa + map.m_plen, map.m_plen);
+		map.m_la += map.m_llen;
+	}
+	fprintf(stdout, "%s:%d extents found\n", cfg.c_img_path, extent_count);
 }
 
 static void erofsdump_print_chart_row(char *col1, unsigned int col2,
@@ -643,8 +682,13 @@ int main(int argc, char **argv)
 	if (dumpcfg.show_statistics)
 		erofsdump_print_statistic();
 
+	if (dumpcfg.show_extent && !dumpcfg.show_inode) {
+		usage();
+		goto exit;
+	}
+
 	if (dumpcfg.show_inode)
-		erofsdump_show_fileinfo();
+		erofsdump_show_fileinfo(dumpcfg.show_extent);
 
 exit:
 	erofs_exit_configure();
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 139656c..8282f03 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -275,6 +275,8 @@ int erofs_ilookup(const char *path, struct erofs_inode *vi);
 /* data.c */
 int erofs_pread(struct erofs_inode *inode, char *buf,
 		erofs_off_t count, erofs_off_t offset);
+int erofs_map_blocks(struct erofs_inode *inode,
+		struct erofs_map_blocks *map, int flags);
 /* zmap.c */
 int z_erofs_fill_inode(struct erofs_inode *vi);
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
diff --git a/lib/data.c b/lib/data.c
index 30e7312..9048707 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -61,8 +61,8 @@ err_out:
 	return err;
 }
 
-static int erofs_map_blocks(struct erofs_inode *inode,
-			    struct erofs_map_blocks *map, int flags)
+int erofs_map_blocks(struct erofs_inode *inode,
+		struct erofs_map_blocks *map, int flags)
 {
 	struct erofs_inode *vi = inode;
 	struct erofs_inode_chunk_index *idx;
-- 
2.31.1

