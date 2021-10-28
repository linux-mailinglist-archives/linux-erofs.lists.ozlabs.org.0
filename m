Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E04043DF3D
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 12:50:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hg2QC25VPz2ynN
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 21:50:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com;
 envelope-from=guoxuenan@huawei.com; receiver=<UNKNOWN>)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hg2Q746PRz2xY6
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 Oct 2021 21:50:07 +1100 (AEDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hg2MC1zdZzZcVZ;
 Thu, 28 Oct 2021 18:47:35 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 28 Oct 2021 18:49:32 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 18:49:31 +0800
From: Guo Xuenan <guoxuenan@huawei.com>
To: <xiang@kernel.org>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v2 3/5] erofs-utils: dump: add option to print specified file
 infomation.
Date: Thu, 28 Oct 2021 18:57:46 +0800
Message-ID: <20211028105748.3586231-3-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211028105748.3586231-1-guoxuenan@huawei.com>
References: <20211028105748.3586231-1-guoxuenan@huawei.com>
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
Cc: daeho43@gmail.com, mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Wang Qi <mpiglet@outlook.com>

add option --nid to print information of specific nid, including
file name/file links/file size/data layout/compression ratio etc..

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
Signed-off-by: Wang Qi <mpiglet@outlook.com>
---
 dump/main.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 135 insertions(+), 3 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index eacf02e..d1aa017 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -17,8 +17,10 @@
 
 struct erofsdump_cfg {
 	unsigned int totalshow;
+	bool show_inode;
 	bool show_superblock;
 	bool show_statistics;
+	erofs_nid_t nid;
 };
 static struct erofsdump_cfg dumpcfg;
 
@@ -64,7 +66,8 @@ struct erofs_statistics {
 static struct erofs_statistics stats;
 
 static struct option long_options[] = {
-	{"help", no_argument, 0, 1},
+	{"help", no_argument, NULL, 1},
+	{"nid", required_argument, NULL, 2},
 	{0, 0, 0, 0},
 };
 
@@ -82,14 +85,18 @@ static struct erofsdump_feature feature_lists[] = {
 };
 
 static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid);
+static inline int erofs_checkdirent(struct erofs_dirent *de,
+		struct erofs_dirent *last_de,
+		u32 maxsize, const char *dname);
 
 static void usage(void)
 {
 	fputs("usage: [options] IMAGE\n\n"
 	      "Dump erofs layout from IMAGE, and [options] are:\n"
-	      " -S      show statistic information of the image\n"
 	      " -V      print the version number of dump.erofs and exit.\n"
 	      " -s      show information about superblock\n"
+	      " -S      show statistic information of the image\n"
+	      " --nid=# show the target inode info of nid #\n"
 	      " --help  display this help and exit.\n",
 	      stderr);
 }
@@ -103,7 +110,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 {
 	int opt;
 
-	while ((opt = getopt_long(argc, argv, "SVs",
+	while ((opt = getopt_long(argc, argv, "SV:s",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 's':
@@ -117,6 +124,11 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 		case 'V':
 			erofsdump_print_version();
 			exit(0);
+		case 2:
+			dumpcfg.show_inode = true;
+			dumpcfg.nid = (erofs_nid_t)atoll(optarg);
+			++dumpcfg.totalshow;
+			break;
 		case 1:
 			usage();
 			exit(0);
@@ -331,6 +343,123 @@ static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid)
 	return 0;
 }
 
+static int erofs_get_pathname(erofs_nid_t nid, erofs_nid_t parent_nid,
+		erofs_nid_t target, char *path, unsigned int pos)
+{
+	int err;
+	erofs_off_t offset;
+	char buf[EROFS_BLKSIZ];
+	struct erofs_inode inode = { .nid = nid };
+
+	path[pos++] = '/';
+	if (target == sbi.root_nid)
+		return 0;
+
+	err = erofs_read_inode_from_disk(&inode);
+	if (err) {
+		erofs_err("read inode %lu failed", nid);
+		return err;
+	}
+
+	offset = 0;
+	while (offset < inode.i_size) {
+		erofs_off_t maxsize = min_t(erofs_off_t,
+					inode.i_size - offset, EROFS_BLKSIZ);
+		struct erofs_dirent *de = (void *)buf;
+		struct erofs_dirent *end;
+		unsigned int nameoff;
+
+		err = erofs_pread(&inode, buf, maxsize, offset);
+		if (err)
+			return err;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		end = (void *)buf + nameoff;
+		while (de < end) {
+			const char *dname;
+			int len;
+
+			nameoff = le16_to_cpu(de->nameoff);
+			dname = (char *)buf + nameoff;
+			len = erofs_checkdirent(de, end, maxsize, dname);
+			if (len < 0)
+				return len;
+
+			if (de->nid == target) {
+				memcpy(path + pos, dname, len);
+				return 0;
+			}
+
+			if (de->file_type == EROFS_FT_DIR &&
+					de->nid != parent_nid &&
+					de->nid != nid) {
+				memcpy(path + pos, dname, len);
+				err = erofs_get_pathname(de->nid, nid,
+						target, path, pos + len);
+				if (!err)
+					return 0;
+				memset(path + pos, 0, len);
+			}
+			++de;
+		}
+		offset += maxsize;
+	}
+	return -1;
+}
+
+static void erofsdump_show_fileinfo(void)
+{
+	int err;
+	erofs_off_t size;
+	u16 access_mode;
+	time_t t;
+	erofs_nid_t nid = dumpcfg.nid;
+	struct erofs_inode inode = { .nid = nid };
+	char path[PATH_MAX + 1] = {0};
+	char access_mode_str[] = "rwxrwxrwx";
+	char timebuf[128] = {0};
+
+	err = erofs_read_inode_from_disk(&inode);
+	if (err) {
+		erofs_err("failed to find inode %lu from disk", nid);
+		return;
+	}
+
+	err = erofs_get_occupied_size(&inode, &size);
+	if (err) {
+		erofs_err("get file size failed\n");
+		return;
+	}
+
+	err = erofs_get_pathname(sbi.root_nid, sbi.root_nid, nid, path, 0);
+	if (err < 0) {
+		fprintf(stderr, "File: Path not found.\n");
+		return;
+	}
+
+	fprintf(stdout, "File : %s\n", path);
+	fprintf(stdout, "Inode: %lu  ", inode.nid);
+	fprintf(stdout, "Links: %u  ", inode.i_nlink);
+	fprintf(stdout, "Layout: %d\n", inode.datalayout);
+	fprintf(stdout, "Inode size: %d   ", inode.inode_isize);
+	fprintf(stdout, "Extent size: %u   ", inode.extent_isize);
+	fprintf(stdout,	"Xattr size: %u\n", inode.xattr_isize);
+	fprintf(stdout, "File size: %lu  ", inode.i_size);
+	fprintf(stdout,	"On-disk size: %lu  ", size);
+	fprintf(stdout, "Compression ratio: %.2f%%\n",
+			(double)(100 * size) / (double)(inode.i_size));
+	t = inode.i_ctime;
+	strftime(timebuf, sizeof(timebuf),
+			"%Y-%m-%d %H:%M:%S", localtime(&t));
+	access_mode = inode.i_mode & 0777;
+	for (int i = 8; i >= 0; i--)
+		if (((access_mode >> i) & 1) == 0)
+			access_mode_str[8 - i] = '-';
+	fprintf(stdout, "Uid: %u   Gid: %u  ", inode.i_uid, inode.i_gid);
+	fprintf(stdout, "Access: %04o/%s\n", access_mode, access_mode_str);
+	fprintf(stdout, "Timestamp: %s\n", timebuf);
+}
+
 static void erofsdump_print_chart_row(char *col1, unsigned int col2,
 		double col3, char *col4)
 {
@@ -512,6 +641,9 @@ int main(int argc, char **argv)
 	if (dumpcfg.show_statistics)
 		erofsdump_print_statistic();
 
+	if (dumpcfg.show_inode)
+		erofsdump_show_fileinfo();
+
 exit:
 	erofs_exit_configure();
 	return err;
-- 
2.31.1

