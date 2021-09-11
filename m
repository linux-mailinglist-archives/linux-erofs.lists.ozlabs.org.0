Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B8C407863
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Sep 2021 15:39:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H6DPm2l42z2yMP
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Sep 2021 23:39:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com;
 envelope-from=guoxuenan@huawei.com; receiver=<UNKNOWN>)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H6DPd5vW5z2xv8
 for <linux-erofs@lists.ozlabs.org>; Sat, 11 Sep 2021 23:39:49 +1000 (AEST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H6DJV0ZSFz8yGj;
 Sat, 11 Sep 2021 21:35:22 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 11 Sep 2021 21:39:45 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 11 Sep
 2021 21:39:44 +0800
From: Guo Xuenan <guoxuenan@huawei.com>
To: <xiang@kernel.org>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v1 4/5] dump.erofs: add -i options to dump file information of
 specific inode number
Date: Sat, 11 Sep 2021 21:46:34 +0800
Message-ID: <20210911134635.1253426-4-guoxuenan@huawei.com>
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

From: mpiglet <mpiglet@outlook.com>

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
Signed-off-by: mpiglet <mpiglet@outlook.com>
---
 dump/main.c | 202 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 200 insertions(+), 2 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index b0acc0b..2389cef 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -19,8 +19,10 @@
 
 struct dumpcfg {
 	bool print_superblock;
+	bool print_inode;
 	bool print_statistic;
 	bool print_version;
+	u64 ino;
 };
 static struct dumpcfg dumpcfg;
 
@@ -100,8 +102,9 @@ static void usage(void)
 {
 	fputs("usage: [options] erofs-image \n\n"
 		"Dump erofs layout from erofs-image, and [options] are:\n"
-		"-s          print information about superblock\n"
-		"-S      print statistic information of the erofs-image\n"
+		"-s         print information about superblock\n"
+		"-S         print statistic information of the erofs-image\n"
+		"-i #       print target # inode info\n"
 		"-v/-V      print dump.erofs version info\n"
 		"-h/--help  display this help and exit\n", stderr);
 }
@@ -113,6 +116,7 @@ static void dumpfs_print_version(void)
 static int dumpfs_parse_options_cfg(int argc, char **argv)
 {
 	int opt;
+	u64 i;
 
 	while ((opt = getopt_long(argc, argv, "sSvVi:I:h",
 					long_options, NULL)) != -1) {
@@ -127,6 +131,11 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
 		case 'V':
 			dumpfs_print_version();
 			exit(0);
+		case 'i':
+			i = atoll(optarg);
+			dumpcfg.print_inode = true;
+			dumpcfg.ino = i;
+			break;
 		case 'h':
 		case 1:
 		    usage();
@@ -293,6 +302,193 @@ static void dumpfs_print_superblock(void)
 
 }
 
+static int get_path_by_nid(erofs_nid_t nid, erofs_nid_t parent_nid,
+		erofs_nid_t target, char *path, unsigned int pos)
+{
+	int err;
+	struct erofs_inode inode = {.nid = nid};
+	erofs_off_t offset;
+	char buf[EROFS_BLKSIZ];
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
+		if (nameoff < sizeof(struct erofs_dirent) ||
+		    nameoff >= PAGE_SIZE) {
+			erofs_err("invalid de[0].nameoff %u @ nid %llu",
+				  nameoff, nid | 0ULL);
+			return -EFSCORRUPTED;
+		}
+
+		end = (void *)buf + nameoff;
+		while (de < end) {
+			const char *dname;
+			unsigned int dname_len;
+
+			nameoff = le16_to_cpu(de->nameoff);
+			dname = (char *)buf + nameoff;
+			if (de + 1 >= end)
+				dname_len = strnlen(dname, maxsize - nameoff);
+			else
+				dname_len = le16_to_cpu(de[1].nameoff)
+					- nameoff;
+
+			/* a corrupted entry is found */
+			if (nameoff + dname_len > maxsize ||
+			    dname_len > EROFS_NAME_LEN) {
+				erofs_err("bogus dirent @ nid %llu",
+						le64_to_cpu(de->nid) | 0ULL);
+				DBG_BUGON(1);
+				return -EFSCORRUPTED;
+			}
+
+			if (de->nid == target) {
+				memcpy(path + pos, dname, dname_len);
+				return 0;
+			}
+
+			if (de->file_type == EROFS_FT_DIR &&
+					de->nid != parent_nid &&
+					de->nid != nid) {
+				memcpy(path + pos, dname, dname_len);
+				err = get_path_by_nid(de->nid, nid,
+						target, path, pos + dname_len);
+				if (!err)
+					return 0;
+				memset(path + pos, 0, dname_len);
+			}
+			++de;
+		}
+		offset += maxsize;
+	}
+	return -1;
+}
+
+static void dumpfs_print_inode(void)
+{
+	int err;
+	erofs_off_t size;
+	erofs_nid_t nid = dumpcfg.ino;
+	struct erofs_inode inode = {.nid = nid};
+	char path[PATH_MAX + 1] = {0};
+	time_t t = inode.i_ctime;
+
+	err = erofs_read_inode_from_disk(&inode);
+	if (err) {
+		erofs_err("read inode %lu from disk failed", nid);
+		return;
+	}
+
+	fprintf(stderr, "Inode %lu info:\n", dumpcfg.ino);
+	switch (inode.inode_isize) {
+	case 32:
+		fprintf(stderr, "	File inode is compacted layout\n");
+		break;
+	case 64:
+		fprintf(stderr, "	File inode is extended layout\n");
+		break;
+	default:
+		erofs_err("unsupported inode layout\n");
+	}
+	fprintf(stderr, "	File size:		%lu\n",
+			inode.i_size);
+	fprintf(stderr, "	File nid:		%lu\n",
+			inode.nid);
+	fprintf(stderr, "	File extent size:	%u\n",
+			inode.extent_isize);
+	fprintf(stderr, "	File xattr size:	%u\n",
+			inode.xattr_isize);
+	fprintf(stderr, "	File inode size:	%u\n",
+			inode.inode_isize);
+	fprintf(stderr, "	File type:		");
+	switch (inode.i_mode & S_IFMT) {
+	case S_IFREG:
+		fprintf(stderr, "regular\n");
+		break;
+	case S_IFDIR:
+		fprintf(stderr, "directory\n");
+		break;
+	case S_IFLNK:
+		fprintf(stderr, "link\n");
+		break;
+	case S_IFCHR:
+		fprintf(stderr, "character device\n");
+		break;
+	case S_IFBLK:
+		fprintf(stderr, "block device\n");
+		break;
+	case S_IFIFO:
+		fprintf(stderr, "fifo\n");
+		break;
+	case S_IFSOCK:
+		fprintf(stderr, "sock\n");
+		break;
+	default:
+		break;
+	}
+
+	err = get_file_compressed_size(&inode, &size);
+	if (err) {
+		erofs_err("get file size failed\n");
+		return;
+	}
+
+	fprintf(stderr, "	File original size:	%lu\n"
+			"	File on-disk size:	%lu\n",
+			inode.i_size, size);
+	fprintf(stderr, "	File compress rate:	%.2f%%\n",
+			(double)(100 * size) / (double)(inode.i_size));
+
+	fprintf(stderr, "	File datalayout:	");
+	switch (inode.datalayout) {
+	case EROFS_INODE_FLAT_PLAIN:
+		fprintf(stderr, "EROFS_INODE_FLAT_PLAIN\n");
+		break;
+	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
+		fprintf(stderr, "EROFS_INODE_FLAT_COMPRESSION_LEGACY\n");
+		break;
+	case EROFS_INODE_FLAT_INLINE:
+		fprintf(stderr, "EROFS_INODE_FLAT_INLINE\n");
+		break;
+	case EROFS_INODE_FLAT_COMPRESSION:
+		fprintf(stderr, "EROFS_INODE_FLAT_COMPRESSION\n");
+		break;
+	default:
+		break;
+	}
+
+	fprintf(stderr, "	File create time:	%s", ctime(&t));
+	fprintf(stderr, "	File uid:		%u\n", inode.i_uid);
+	fprintf(stderr, "	File gid:		%u\n", inode.i_gid);
+	fprintf(stderr, "	File hard-link count:	%u\n", inode.i_nlink);
+
+	err = get_path_by_nid(sbi.root_nid, sbi.root_nid, nid, path, 0);
+	if (!err)
+		fprintf(stderr, "	File path:		%s\n", path);
+	else
+		fprintf(stderr, "Path not found\n");
+}
+
 static int get_file_type(const char *filename)
 {
 	char *postfix = strrchr(filename, '.');
@@ -611,6 +807,8 @@ int main(int argc, char **argv)
 	if (dumpcfg.print_statistic)
 		dumpfs_print_statistic();
 
+	if (dumpcfg.print_inode)
+		dumpfs_print_inode();
 
 	return 0;
 }
-- 
2.25.4

