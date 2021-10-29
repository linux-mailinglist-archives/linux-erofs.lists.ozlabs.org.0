Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1288943F962
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 11:06:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hgc460RsBz2yxm
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 20:06:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com;
 envelope-from=guoxuenan@huawei.com; receiver=<UNKNOWN>)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hgc4151tQz2xg6
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Oct 2021 20:06:25 +1100 (AEDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hgc145nblzZcYq;
 Fri, 29 Oct 2021 17:03:52 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 29 Oct 2021 17:05:49 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 17:05:48 +0800
From: Guo Xuenan <guoxuenan@huawei.com>
To: <xiang@kernel.org>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v3 2/5] erofs-utils: dump: add feature for collecting
 filesystem statistics.
Date: Fri, 29 Oct 2021 17:12:41 +0800
Message-ID: <20211029091244.1162119-2-guoxuenan@huawei.com>
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

From: Wang Qi <mpiglet@outlook.com>

Add -S option, for printing statistics of the overall disk, including
file type(by file extension)/size statistics and distribution, number
of compressed and uncompressed files, whole compression ratio of image.

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
Signed-off-by: Wang Qi <mpiglet@outlook.com>
---
 dump/Makefile.am         |   2 +-
 dump/main.c              | 357 ++++++++++++++++++++++++++++++++++++++-
 include/erofs/internal.h |   1 +
 lib/namei.c              |   2 +-
 4 files changed, 359 insertions(+), 3 deletions(-)

diff --git a/dump/Makefile.am b/dump/Makefile.am
index f0246d7..4759901 100644
--- a/dump/Makefile.am
+++ b/dump/Makefile.am
@@ -6,4 +6,4 @@ bin_PROGRAMS     = dump.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS}
 dump_erofs_SOURCES = main.c
 dump_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
-dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} ${libuuid_LIBS}
+dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} ${libuuid_LIBS} ${liblz4_LIBS}
diff --git a/dump/main.c b/dump/main.c
index 5b7ac5c..c5e82d1 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -18,9 +18,51 @@
 struct erofsdump_cfg {
 	unsigned int totalshow;
 	bool show_superblock;
+	bool show_statistics;
 };
 static struct erofsdump_cfg dumpcfg;
 
+static const char chart_format[] = "%-16s	%-11d %8.2f%% |%-50s|\n";
+static const char header_format[] = "%-16s %11s %16s |%-50s|\n";
+static char *file_types[] = {
+	".txt", ".so", ".xml", ".apk",
+	".odex", ".vdex", ".oat", ".rc",
+	".otf", ".txt", "others",
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
+struct erofs_statistics {
+	unsigned long files;
+	unsigned long compressed_files;
+	unsigned long uncompressed_files;
+	unsigned long files_total_size;
+	unsigned long files_total_origin_size;
+	double compress_rate;
+
+	/* [statistics] # of files based on inode_info->flags */
+	unsigned long file_category_stat[EROFS_FT_MAX];
+	/* [statistics] # of files based on file name extensions */
+	unsigned int file_type_stat[OTHERFILETYPE];
+	/* [statistics] # of files based on the original size of files */
+	unsigned int file_original_size[FILE_MAX_SIZE_BITS + 1];
+	/* [statistics] # of files based on the compressed size of files */
+	unsigned int file_comp_size[FILE_MAX_SIZE_BITS + 1];
+};
+static struct erofs_statistics stats;
+
 static struct option long_options[] = {
 	{"help", no_argument, 0, 1},
 	{0, 0, 0, 0},
@@ -39,10 +81,13 @@ static struct erofsdump_feature feature_lists[] = {
 	{ false, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
 };
 
+static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid);
+
 static void usage(void)
 {
 	fputs("usage: [options] IMAGE\n\n"
 	      "Dump erofs layout from IMAGE, and [options] are:\n"
+	      " -S      show statistic information of the image\n"
 	      " -V      print the version number of dump.erofs and exit.\n"
 	      " -s      show information about superblock\n"
 	      " --help  display this help and exit.\n",
@@ -58,13 +103,17 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 {
 	int opt;
 
-	while ((opt = getopt_long(argc, argv, "Vs",
+	while ((opt = getopt_long(argc, argv, "SVs",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 's':
 			dumpcfg.show_superblock = true;
 			++dumpcfg.totalshow;
 			break;
+		case 'S':
+			dumpcfg.show_statistics = true;
+			++dumpcfg.totalshow;
+			break;
 		case 'V':
 			erofsdump_print_version();
 			exit(0);
@@ -90,6 +139,309 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 	return 0;
 }
 
+static int erofs_get_occupied_size(struct erofs_inode *inode,
+		erofs_off_t *size)
+{
+	*size = 0;
+	switch (inode->datalayout) {
+	case EROFS_INODE_FLAT_INLINE:
+	case EROFS_INODE_FLAT_PLAIN:
+	case EROFS_INODE_CHUNK_BASED:
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
+static int erofs_getfile_extension(const char *filename)
+{
+	char *postfix = strrchr(filename, '.');
+	int type = 0;
+
+	if (!postfix)
+		return OTHERFILETYPE - 1;
+	for (type = 0; type < OTHERFILETYPE - 1; ++type) {
+		if (strcmp(postfix, file_types[type]) == 0)
+			break;
+	}
+	return type;
+}
+
+static void update_file_size_statatics(erofs_off_t occupied_size,
+		erofs_off_t original_size)
+{
+	int occupied_size_mark, original_size_mark;
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
+static inline int erofs_checkdirent(struct erofs_dirent *de,
+		struct erofs_dirent *last_de,
+		u32 maxsize, const char *dname)
+{
+	int dname_len;
+	unsigned int nameoff = le16_to_cpu(de->nameoff);
+
+	if (nameoff < sizeof(struct erofs_dirent) ||
+			nameoff >= PAGE_SIZE) {
+		erofs_err("invalid de[0].nameoff %u @ nid %llu",
+				nameoff, de->nid | 0ULL);
+		return -EFSCORRUPTED;
+	}
+
+	dname_len = (de + 1 >= last_de) ? strnlen(dname, maxsize - nameoff) :
+				le16_to_cpu(de[1].nameoff) - nameoff;
+	/* a corrupted entry is found */
+	if (nameoff + dname_len > maxsize ||
+			dname_len > EROFS_NAME_LEN) {
+		erofs_err("bogus dirent @ nid %llu",
+				le64_to_cpu(de->nid) | 0ULL);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+	if (de->file_type >= EROFS_FT_MAX) {
+		erofs_err("invalid file type %llu", de->nid);
+		return -EFSCORRUPTED;
+	}
+	return dname_len;
+}
+
+static int erofs_read_dirent(struct erofs_dirent *de,
+		erofs_nid_t nid, erofs_nid_t parent_nid,
+		const char *dname)
+{
+	int err;
+	erofs_off_t occupied_size = 0;
+	struct erofs_inode inode = { .nid = de->nid };
+
+	stats.files++;
+	stats.file_category_stat[de->file_type]++;
+	err = erofs_read_inode_from_disk(&inode);
+	if (err) {
+		erofs_err("read file inode from disk failed!");
+		return err;
+	}
+
+	err = erofs_get_occupied_size(&inode, &occupied_size);
+	if (err) {
+		erofs_err("get file size failed\n");
+		return err;
+	}
+
+	if (de->file_type == EROFS_FT_REG_FILE) {
+		stats.files_total_origin_size += inode.i_size;
+		stats.file_type_stat[erofs_getfile_extension(dname)]++;
+		stats.files_total_size += occupied_size;
+		update_file_size_statatics(occupied_size, inode.i_size);
+	}
+
+	if ((de->file_type == EROFS_FT_DIR)
+			&& de->nid != nid && de->nid != parent_nid) {
+		err = erofs_read_dir(de->nid, nid);
+		if (err) {
+			erofs_err("parse dir nid %llu error occurred\n",
+					de->nid);
+			return err;
+		}
+	}
+	return 0;
+}
+
+
+static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid)
+{
+	int err;
+	erofs_off_t offset;
+	char buf[EROFS_BLKSIZ];
+	struct erofs_inode vi = { .nid = nid };
+
+	err = erofs_read_inode_from_disk(&vi);
+	if (err)
+		return err;
+
+	offset = 0;
+	while (offset < vi.i_size) {
+		erofs_off_t maxsize = min_t(erofs_off_t,
+						vi.i_size - offset, EROFS_BLKSIZ);
+		struct erofs_dirent *de = (void *)buf;
+		struct erofs_dirent *end;
+		unsigned int nameoff;
+
+		err = erofs_pread(&vi, buf, maxsize, offset);
+		if (err)
+			return err;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		end = (void *)buf + nameoff;
+		while (de < end) {
+			const char *dname;
+			int ret;
+
+			/* skip "." and ".." dentry */
+			if (de->nid == nid || de->nid == parent_nid) {
+				de++;
+				continue;
+			}
+
+			dname = (char *)buf + nameoff;
+			ret = erofs_checkdirent(de, end, maxsize, dname);
+			if (ret < 0)
+				return ret;
+			ret = erofs_read_dirent(de, nid, parent_nid, dname);
+			if (ret < 0)
+				return ret;
+			++de;
+		}
+		offset += maxsize;
+	}
+	return 0;
+}
+
+static void erofsdump_print_chart_row(char *col1, unsigned int col2,
+		double col3, char *col4)
+{
+	char row[500] = {0};
+
+	sprintf(row, chart_format, col1, col2, col3, col4);
+	fprintf(stdout, row);
+}
+
+static void erofsdump_filesize_distribution(const char *title,
+		unsigned int *file_counts, unsigned int len)
+{
+	char col1[30];
+	unsigned int col2;
+	double col3;
+	char col4[400];
+	unsigned int lowerbound = 0;
+	unsigned int upperbound = 1;
+
+	fprintf(stdout, "\n%s file size distribution:\n", title);
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
+		if (stats.file_category_stat[EROFS_FT_REG_FILE])
+			col3 = (double)(100 * col2) /
+				stats.file_category_stat[EROFS_FT_REG_FILE];
+		else
+			col3 = 0.0;
+		memset(col4, '#', col3 / 2);
+		erofsdump_print_chart_row(col1, col2, col3, col4);
+		lowerbound = upperbound;
+		upperbound <<= 1;
+	}
+}
+
+static void erofsdump_filetype_distribution(char **file_types, unsigned int len)
+{
+	char col1[30];
+	unsigned int col2;
+	double col3;
+	char col4[401];
+
+	fprintf(stdout, "\nFile type distribution:\n");
+	fprintf(stdout, header_format, "type", "count", "ratio",
+			"distribution");
+	for (int i = 0; i < len; i++) {
+		memset(col1, 0, sizeof(col1));
+		memset(col4, 0, sizeof(col4));
+		sprintf(col1, "%-17s", file_types[i]);
+		col2 = stats.file_type_stat[i];
+		if (stats.file_category_stat[EROFS_FT_REG_FILE])
+			col3 = (double)(100 * col2) /
+				stats.file_category_stat[EROFS_FT_REG_FILE];
+		else
+			col3 = 0.0;
+		memset(col4, '#', col3 / 2);
+		erofsdump_print_chart_row(col1, col2, col3, col4);
+	}
+}
+
+static void erofsdump_file_statistic(void)
+{
+	fprintf(stdout, "Filesystem total file count:		%lu\n",
+			stats.files);
+	for (int i = 0; i < EROFS_FT_MAX; i++)
+		fprintf(stdout, "Filesystem %s count:		%lu\n",
+			file_category_types[i], stats.file_category_stat[i]);
+
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
+static void erofsdump_print_statistic(void)
+{
+	int err;
+
+	err = erofs_read_dir(sbi.root_nid, sbi.root_nid);
+	if (err) {
+		erofs_err("read dir failed");
+		return;
+	}
+
+	erofsdump_file_statistic();
+	erofsdump_filesize_distribution("Original",
+			stats.file_original_size,
+			ARRAY_SIZE(stats.file_original_size));
+	erofsdump_filesize_distribution("On-disk",
+			stats.file_comp_size,
+			ARRAY_SIZE(stats.file_comp_size));
+	erofsdump_filetype_distribution(file_types, OTHERFILETYPE);
+}
+
 static void erofsdump_show_superblock(void)
 {
 	time_t time = sbi.build_time;
@@ -156,6 +508,9 @@ int main(int argc, char **argv)
 	if (dumpcfg.show_superblock)
 		erofsdump_show_superblock();
 
+	if (dumpcfg.show_statistics)
+		erofsdump_print_statistic();
+
 exit:
 	erofs_exit_configure();
 	return err;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index a487871..139656c 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -269,6 +269,7 @@ struct erofs_map_blocks {
 int erofs_read_superblock(void);
 
 /* namei.c */
+int erofs_read_inode_from_disk(struct erofs_inode *vi);
 int erofs_ilookup(const char *path, struct erofs_inode *vi);
 
 /* data.c */
diff --git a/lib/namei.c b/lib/namei.c
index b4bdabf..56f199a 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -22,7 +22,7 @@ static dev_t erofs_new_decode_dev(u32 dev)
 	return makedev(major, minor);
 }
 
-static int erofs_read_inode_from_disk(struct erofs_inode *vi)
+int erofs_read_inode_from_disk(struct erofs_inode *vi)
 {
 	int ret, ifmt;
 	char buf[sizeof(struct erofs_inode_extended)];
-- 
2.31.1

