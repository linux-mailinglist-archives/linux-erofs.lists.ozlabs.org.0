Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C813440C2C6
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Sep 2021 11:29:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H8ZfV5Q9Jz2yPd
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Sep 2021 19:29:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com;
 envelope-from=guoxuenan@huawei.com; receiver=<UNKNOWN>)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H8ZfQ5Lmlz2yJt
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Sep 2021 19:29:02 +1000 (AEST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H8Zd907mDz1DH1v;
 Wed, 15 Sep 2021 17:27:57 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 17:28:48 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 15 Sep
 2021 17:28:47 +0800
From: Guo Xuenan <guoxuenan@huawei.com>
To: <xiang@kernel.org>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v3 4/5] dump.erofs: add -i options to dump file information of
 specific inode number
Date: Wed, 15 Sep 2021 17:35:36 +0800
Message-ID: <20210915093537.2579575-4-guoxuenan@huawei.com>
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
 dump/main.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 158 insertions(+), 1 deletion(-)

diff --git a/dump/main.c b/dump/main.c
index be18ddd..e2ceee3 100644
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
 
@@ -89,6 +91,7 @@ static void usage(void)
 	fputs("usage: [options] IMAGE\n\n"
 		"Dump erofs layout from IMAGE, and [options] are:\n"
 		"-s      print information about superblock\n"
+		"-i #    print target # inode info\n"
 		"-S      print statistic information of the erofs-image\n"
 		"-V      print the version number of dump.erofs and exit.\n"
 		"--help  display this help and exit.\n",
@@ -102,10 +105,16 @@ static void dumpfs_print_version(void)
 static int dumpfs_parse_options_cfg(int argc, char **argv)
 {
 	int opt;
+	u64 i;
 
-	while ((opt = getopt_long(argc, argv, "sSV",
+	while ((opt = getopt_long(argc, argv, "i:sSV",
 					long_options, NULL)) != -1) {
 		switch (opt) {
+		case 'i':
+			i = atoll(optarg);
+			dumpcfg.print_inode = true;
+			dumpcfg.ino = i;
+			break;
 		case 's':
 			dumpcfg.print_superblock = true;
 			break;
@@ -158,6 +167,151 @@ static int get_file_compressed_size(struct erofs_inode *inode,
 	}
 	return 0;
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
+	u16 access_mode;
+	time_t t;
+	erofs_nid_t nid = dumpcfg.ino;
+	struct erofs_inode inode = {.nid = nid};
+	char path[PATH_MAX + 1] = {0};
+	char access_mode_str[] = "rwxrwxrwx";
+
+	err = erofs_read_inode_from_disk(&inode);
+	if (err) {
+		erofs_err("read inode %lu from disk failed", nid);
+		return;
+	}
+
+	err = get_file_compressed_size(&inode, &size);
+	if (err) {
+		erofs_err("get file size failed\n");
+		return;
+	}
+
+	fprintf(stdout, "Inode %lu info:\n", dumpcfg.ino);
+	err = get_path_by_nid(sbi.root_nid, sbi.root_nid, nid, path, 0);
+
+	fprintf(stdout, "File path:            %s\n",
+			!err ? path : "path not found");
+	fprintf(stdout, "File nid:             %lu\n", inode.nid);
+	fprintf(stdout, "File inode core size: %d\n", inode.inode_isize);
+	fprintf(stdout, "File original size:   %lu\n", inode.i_size);
+	fprintf(stdout,	"File on-disk size:    %lu\n", size);
+	fprintf(stdout, "File compress rate:   %.2f%%\n",
+			(double)(100 * size) / (double)(inode.i_size));
+	fprintf(stdout, "File extent size:     %u\n", inode.extent_isize);
+	fprintf(stdout,	"File xattr size:      %u\n", inode.xattr_isize);
+	fprintf(stdout, "File type:            ");
+	switch (inode.i_mode & S_IFMT) {
+	case S_IFBLK:  fprintf(stdout, "block device\n");     break;
+	case S_IFCHR:  fprintf(stdout, "character device\n"); break;
+	case S_IFDIR:  fprintf(stdout, "directory\n");        break;
+	case S_IFIFO:  fprintf(stdout, "FIFO/pipe\n");        break;
+	case S_IFLNK:  fprintf(stdout, "symlink\n");          break;
+	case S_IFREG:  fprintf(stdout, "regular file\n");     break;
+	case S_IFSOCK: fprintf(stdout, "socket\n");           break;
+	default:       fprintf(stdout, "unknown?\n");         break;
+	}
+
+	access_mode = inode.i_mode & 0777;
+	t = inode.i_ctime;
+	for (int i = 8; i >= 0; i--)
+		if (((access_mode >> i) & 1) == 0)
+			access_mode_str[8 - i] = '-';
+	fprintf(stdout, "File access:          %04o/%s\n",
+			access_mode, access_mode_str);
+	fprintf(stdout, "File uid:             %u\n", inode.i_uid);
+	fprintf(stdout, "File gid:             %u\n", inode.i_gid);
+	fprintf(stdout, "File datalayout:      %d\n", inode.datalayout);
+	fprintf(stdout,	"File nlink:           %u\n", inode.i_nlink);
+	fprintf(stdout, "File create time:     %s", ctime(&t));
+	fprintf(stdout, "File access time:     %s", ctime(&t));
+	fprintf(stdout, "File modify time:     %s", ctime(&t));
+}
 
 static int get_file_type(const char *filename)
 {
@@ -496,6 +650,9 @@ int main(int argc, char **argv)
 	if (dumpcfg.print_statistic)
 		dumpfs_print_statistic();
 
+	if (dumpcfg.print_inode)
+		dumpfs_print_inode();
+
 exit:
 	erofs_exit_configure();
 	return err;
-- 
2.25.4

