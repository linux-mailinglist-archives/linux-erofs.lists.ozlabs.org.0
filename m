Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D314140C2C3
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Sep 2021 11:29:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H8ZfM5dk8z2yL7
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Sep 2021 19:28:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com;
 envelope-from=guoxuenan@huawei.com; receiver=<UNKNOWN>)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H8ZfH0WgTz2xtj
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Sep 2021 19:28:52 +1000 (AEST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H8ZdP4FbFz8t9G;
 Wed, 15 Sep 2021 17:28:09 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 17:28:46 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 15 Sep
 2021 17:28:45 +0800
From: Guo Xuenan <guoxuenan@huawei.com>
To: <xiang@kernel.org>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v3 3/5] dump.erofs: add -S options for collecting statistics
 of the whole filesystem
Date: Wed, 15 Sep 2021 17:35:35 +0800
Message-ID: <20210915093537.2579575-3-guoxuenan@huawei.com>
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
 dump/Makefile.am |   2 +-
 dump/main.c      | 348 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 348 insertions(+), 2 deletions(-)

diff --git a/dump/Makefile.am b/dump/Makefile.am
index 0bb7b4e..d7b2873 100644
--- a/dump/Makefile.am
+++ b/dump/Makefile.am
@@ -6,4 +6,4 @@ bin_PROGRAMS     = dump.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS}
 dump_erofs_SOURCES = main.c
 dump_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
-dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libuuid_LIBS}
\ No newline at end of file
+dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libuuid_LIBS} ${liblz4_LIBS}
\ No newline at end of file
diff --git a/dump/main.c b/dump/main.c
index 7ece596..be18ddd 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -19,10 +19,54 @@
 
 struct dumpcfg {
 	bool print_superblock;
+	bool print_statistic;
 	bool print_version;
 };
 static struct dumpcfg dumpcfg;
 
+static const char chart_format[] = "%-16s	%-11d %8.2f%% |%-50s|\n";
+static const char header_format[] = "%-16s %11s %16s |%-50s|\n";
+static char *file_types[] = {
+	".so", ".png", ".jpg", ".xml", ".html", ".odex",
+	".vdex", ".apk", ".ttf", ".jar", ".json", ".ogg",
+	".oat", ".art", ".rc", ".otf", ".txt", "others",
+};
+#define OTHERFILETYPE	ARRAY_SIZE(file_types)
+/* (1 << FILE_MAX_SIZE_BITS)KB */
+#define	FILE_MAX_SIZE_BITS	16
+
+static const char * const file_category_types[] = {
+	[EROFS_FT_UNKNOWN] = "unknown type",
+	[EROFS_FT_REG_FILE] = "regular file",
+	[EROFS_FT_DIR] = "directory",
+	[EROFS_FT_CHRDEV] = "char dev",
+	[EROFS_FT_BLKDEV] = "block dev",
+	[EROFS_FT_FIFO] = "FIFO file",
+	[EROFS_FT_SOCK] = "SOCK file",
+	[EROFS_FT_SYMLINK] = "symlink file",
+};
+
+struct statistics {
+	unsigned long files;
+	unsigned long compressed_files;
+	unsigned long uncompressed_files;
+	unsigned long files_total_size;
+	unsigned long files_total_origin_size;
+	double compress_rate;
+
+	/* statistics the number of files based on inode_info->flags */
+	unsigned long file_category_stat[EROFS_FT_MAX];
+	/* statistics the number of files based on file name extensions */
+	unsigned int file_type_stat[OTHERFILETYPE];
+	/* statistics the number of files based on file orignial size */
+	unsigned int file_original_size[FILE_MAX_SIZE_BITS + 1];
+	/* statistics the number of files based on the compressed
+	 * size of file
+	 */
+	unsigned int file_comp_size[FILE_MAX_SIZE_BITS + 1];
+};
+static struct statistics stats;
+
 static struct option long_options[] = {
 	{"help", no_argument, 0, 1},
 	{0, 0, 0, 0},
@@ -45,6 +89,7 @@ static void usage(void)
 	fputs("usage: [options] IMAGE\n\n"
 		"Dump erofs layout from IMAGE, and [options] are:\n"
 		"-s      print information about superblock\n"
+		"-S      print statistic information of the erofs-image\n"
 		"-V      print the version number of dump.erofs and exit.\n"
 		"--help  display this help and exit.\n",
 		stderr);
@@ -58,12 +103,15 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
 {
 	int opt;
 
-	while ((opt = getopt_long(argc, argv, "sV",
+	while ((opt = getopt_long(argc, argv, "sSV",
 					long_options, NULL)) != -1) {
 		switch (opt) {
 		case 's':
 			dumpcfg.print_superblock = true;
 			break;
+		case 'S':
+			dumpcfg.print_statistic = true;
+			break;
 		case 'V':
 			dumpfs_print_version();
 			exit(0);
@@ -89,6 +137,301 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
 	return 0;
 }
 
+static int get_file_compressed_size(struct erofs_inode *inode,
+		erofs_off_t *size)
+{
+	*size = 0;
+	switch (inode->datalayout) {
+	case EROFS_INODE_FLAT_INLINE:
+	case EROFS_INODE_FLAT_PLAIN:
+		stats.uncompressed_files++;
+		*size = inode->i_size;
+		break;
+	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
+	case EROFS_INODE_FLAT_COMPRESSION:
+		stats.compressed_files++;
+		*size = inode->u.i_blocks * EROFS_BLKSIZ;
+		break;
+	default:
+		erofs_err("unknown datalayout");
+		return -1;
+	}
+	return 0;
+}
+
+static int get_file_type(const char *filename)
+{
+	char *postfix = strrchr(filename, '.');
+	int type = 0;
+
+	if (postfix == NULL)
+		return OTHERFILETYPE - 1;
+	while (type < OTHERFILETYPE - 1) {
+		if (strcmp(postfix, file_types[type]) == 0)
+			break;
+		type++;
+	}
+	return type;
+}
+
+static void update_file_size_statatics(erofs_off_t occupied_size,
+		erofs_off_t original_size)
+{
+	int occupied_size_mark;
+	int original_size_mark;
+
+	original_size_mark = 0;
+	occupied_size_mark = 0;
+	occupied_size >>= 10;
+	original_size >>= 10;
+
+	while (occupied_size || original_size) {
+		if (occupied_size) {
+			occupied_size >>= 1;
+			occupied_size_mark++;
+		}
+		if (original_size) {
+			original_size >>= 1;
+			original_size_mark++;
+		}
+	}
+
+	if (original_size_mark >= FILE_MAX_SIZE_BITS)
+		stats.file_original_size[FILE_MAX_SIZE_BITS]++;
+	else
+		stats.file_original_size[original_size_mark]++;
+
+	if (occupied_size_mark >= FILE_MAX_SIZE_BITS)
+		stats.file_comp_size[FILE_MAX_SIZE_BITS]++;
+	else
+		stats.file_comp_size[occupied_size_mark]++;
+}
+
+static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid)
+{
+	struct erofs_inode vi = { .nid = nid};
+	int err;
+	char buf[EROFS_BLKSIZ];
+	erofs_off_t offset;
+
+	err = erofs_read_inode_from_disk(&vi);
+	if (err)
+		return err;
+
+	offset = 0;
+	while (offset < vi.i_size) {
+		erofs_off_t maxsize = min_t(erofs_off_t,
+			vi.i_size - offset, EROFS_BLKSIZ);
+		struct erofs_dirent *de = (void *)buf;
+		struct erofs_dirent *end;
+		unsigned int nameoff;
+
+		err = erofs_pread(&vi, buf, maxsize, offset);
+		if (err)
+			return err;
+
+		nameoff = le16_to_cpu(de->nameoff);
+
+		if (nameoff < sizeof(struct erofs_dirent) ||
+		    nameoff >= PAGE_SIZE) {
+			erofs_err("invalid de[0].nameoff %u @ nid %llu",
+				  nameoff, nid | 0ULL);
+			return -EFSCORRUPTED;
+		}
+		end = (void *)buf + nameoff;
+		while (de < end) {
+			const char *dname;
+			unsigned int dname_len;
+			struct erofs_inode inode = { .nid = de->nid };
+			erofs_off_t occupied_size = 0;
+			/* skip "." and ".." dentry */
+			if (de->nid == nid || de->nid == parent_nid) {
+				de++;
+				continue;
+			}
+
+			nameoff = le16_to_cpu(de->nameoff);
+			dname = (char *)buf + nameoff;
+
+			if (de + 1 >= end)
+				dname_len = strnlen(dname, maxsize - nameoff);
+			else
+				dname_len = le16_to_cpu(de[1].nameoff) - nameoff;
+
+			/* a corrupted entry is found */
+			if (nameoff + dname_len > maxsize ||
+				dname_len > EROFS_NAME_LEN) {
+				erofs_err("bogus dirent @ nid %llu",
+						le64_to_cpu(de->nid) | 0ULL);
+				DBG_BUGON(1);
+				return -EFSCORRUPTED;
+			}
+
+			if (de->file_type >= EROFS_FT_MAX) {
+				erofs_err("invalid file type %llu", de->nid);
+				de++;
+				continue;
+			}
+			if (de->file_type != EROFS_FT_DIR)
+				stats.file_category_stat[de->file_type]++;
+
+			err = erofs_read_inode_from_disk(&inode);
+			if (err) {
+				erofs_err("read file inode from disk failed!");
+				return err;
+			}
+
+			stats.files++;
+			err = get_file_compressed_size(&inode, &occupied_size);
+			if (err) {
+				erofs_err("get file size failed\n");
+				return err;
+			}
+
+			switch (de->file_type) {
+			case EROFS_FT_REG_FILE:
+				stats.files_total_origin_size += inode.i_size;
+				stats.file_type_stat[get_file_type(dname)]++;
+				stats.files_total_size += occupied_size;
+				update_file_size_statatics(occupied_size, inode.i_size);
+				break;
+			case EROFS_FT_DIR:
+				if (de->nid != nid && de->nid != parent_nid) {
+					err = erofs_read_dir(de->nid, nid);
+					if (err) {
+						fprintf(stdout,
+								"parse dir nid %llu error occurred\n",
+								de->nid);
+						return err;
+					}
+					stats.file_category_stat[EROFS_FT_DIR]++;
+				}
+				break;
+			case EROFS_FT_UNKNOWN:
+			case EROFS_FT_CHRDEV:
+			case EROFS_FT_BLKDEV:
+			case EROFS_FT_FIFO:
+			case EROFS_FT_SOCK:
+			case EROFS_FT_SYMLINK:
+				break;
+			default:
+				erofs_err("%d file type not exists", de->file_type);
+			}
+			++de;
+		}
+		offset += maxsize;
+	}
+	return 0;
+}
+
+static void dumpfs_print_statistic_of_filetype(void)
+{
+	fprintf(stdout, "Filesystem total file count:		%lu\n",
+			stats.files);
+	for (int i = 0; i < EROFS_FT_MAX; i++)
+		fprintf(stdout, "Filesystem %s count:		%lu\n",
+			file_category_types[i], stats.file_category_stat[i]);
+}
+
+static void dumpfs_print_chart_row(char *col1, unsigned int col2,
+		double col3, char *col4)
+{
+	char row[500] = {0};
+
+	sprintf(row, chart_format, col1, col2, col3, col4);
+	fprintf(stdout, row);
+}
+
+static void dumpfs_print_chart_of_file(unsigned int *file_counts,
+		unsigned int len)
+{
+	char col1[30];
+	unsigned int col2;
+	double col3;
+	char col4[400];
+	unsigned int lowerbound = 0;
+	unsigned int upperbound = 1;
+
+	fprintf(stdout, header_format, ">=(KB) .. <(KB) ", "count",
+			"ratio", "distribution");
+	for (int i = 0; i < len; i++) {
+		memset(col1, 0, sizeof(col1));
+		memset(col4, 0, sizeof(col4));
+		if (i == len - 1)
+			sprintf(col1, "%6d ..", lowerbound);
+		else if (i <= 6)
+			sprintf(col1, "%6d .. %-6d", lowerbound, upperbound);
+		else
+
+			sprintf(col1, "%6d .. %-6d", lowerbound, upperbound);
+		col2 = file_counts[i];
+		col3 = (double)(100 * col2) / (double)stats.file_category_stat[EROFS_FT_REG_FILE];
+		memset(col4, '#', col3 / 2);
+		dumpfs_print_chart_row(col1, col2, col3, col4);
+		lowerbound = upperbound;
+		upperbound <<= 1;
+	}
+}
+
+static void dumpfs_print_chart_of_file_type(char **file_types, unsigned int len)
+{
+	char col1[30];
+	unsigned int col2;
+	double col3;
+	char col4[401];
+
+	fprintf(stdout, header_format, "type", "count", "ratio",
+			"distribution");
+	for (int i = 0; i < len; i++) {
+		memset(col1, 0, sizeof(col1));
+		memset(col4, 0, sizeof(col4));
+		sprintf(col1, "%-17s", file_types[i]);
+		col2 = stats.file_type_stat[i];
+		col3 = (double)(100 * col2) / (double)stats.file_category_stat[EROFS_FT_REG_FILE];
+		memset(col4, '#', col3 / 2);
+		dumpfs_print_chart_row(col1, col2, col3, col4);
+	}
+}
+
+static void dumpfs_print_statistic_of_compression(void)
+{
+	stats.compress_rate = (double)(100 * stats.files_total_size) /
+		(double)(stats.files_total_origin_size);
+	fprintf(stdout, "Filesystem compressed files:            %lu\n",
+			stats.compressed_files);
+	fprintf(stdout, "Filesystem uncompressed files:          %lu\n",
+			stats.uncompressed_files);
+	fprintf(stdout, "Filesystem total original file size:    %lu Bytes\n",
+			stats.files_total_origin_size);
+	fprintf(stdout, "Filesystem total file size:             %lu Bytes\n",
+			stats.files_total_size);
+	fprintf(stdout, "Filesystem compress rate:               %.2f%%\n",
+			stats.compress_rate);
+}
+
+static void dumpfs_print_statistic(void)
+{
+	int err;
+
+	err = erofs_read_dir(sbi.root_nid, sbi.root_nid);
+	if (err) {
+		erofs_err("read dir failed");
+		return;
+	}
+
+	dumpfs_print_statistic_of_filetype();
+	dumpfs_print_statistic_of_compression();
+
+	fprintf(stdout, "\nOriginal file size distribution:\n");
+	dumpfs_print_chart_of_file(stats.file_original_size,
+			ARRAY_SIZE(stats.file_original_size));
+	fprintf(stdout, "\nOn-Disk file size distribution:\n");
+	dumpfs_print_chart_of_file(stats.file_comp_size,
+			ARRAY_SIZE(stats.file_comp_size));
+	fprintf(stdout, "\nFile type distribution:\n");
+	dumpfs_print_chart_of_file_type(file_types, OTHERFILETYPE);
+}
+
 static void dumpfs_print_superblock(void)
 {
 	time_t time = sbi.build_time;
@@ -150,6 +493,9 @@ int main(int argc, char **argv)
 	if (dumpcfg.print_superblock)
 		dumpfs_print_superblock();
 
+	if (dumpcfg.print_statistic)
+		dumpfs_print_statistic();
+
 exit:
 	erofs_exit_configure();
 	return err;
-- 
2.25.4

