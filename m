Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B5E40AEBB
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Sep 2021 15:16:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H83lV1jFkz2yJ6
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Sep 2021 23:16:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H83lH4sj4z2xXR
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Sep 2021 23:16:23 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UoNbqcm_1631625365; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UoNbqcm_1631625365) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 14 Sep 2021 21:16:06 +0800
Date: Tue, 14 Sep 2021 21:16:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Guo Xuenan <guoxuenan@huawei.com>
Subject: Re: [PATCH v2 3/5] dump.erofs: add -S options for collecting
 statistics of the whole filesystem
Message-ID: <YUCglI2Yql6FTYRg@B-P7TQMD6M-0146.local>
References: <20210914074424.1875409-1-guoxuenan@huawei.com>
 <20210914074424.1875409-3-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210914074424.1875409-3-guoxuenan@huawei.com>
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
Cc: linux-erofs@lists.ozlabs.org, mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Sep 14, 2021 at 03:44:22PM +0800, Guo Xuenan wrote:
> From: Wang Qi <mpiglet@outlook.com>
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> Signed-off-by: Wang Qi <mpiglet@outlook.com>
> ---
>  dump/main.c | 364 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 361 insertions(+), 3 deletions(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index 33521bf..0778354 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -21,10 +21,63 @@
>  
>  struct dumpcfg {
>  	bool print_superblock;
> +	bool print_statistic;
>  	bool print_version;
>  };
>  static struct dumpcfg dumpcfg;
>  
> +static const char chart_format[] = "%-16s	%-11d %8.2f%% |%-50s|\n";
> +static const char header_format[] = "%-16s %11s %16s |%-50s|\n";
> +static char *file_types[] = {
> +	".so", ".png", ".jpg", ".xml", ".html", ".odex",
> +	".vdex", ".apk", ".ttf", ".jar", ".json", ".ogg",
> +	".oat", ".art", ".rc", ".otf", ".txt", "others",
> +};
> +#define OTHERFILETYPE	ARRAY_SIZE(file_types)
> +/* (1 << FILE_MAX_SIZE_BITS)KB */
> +#define	FILE_MAX_SIZE_BITS	16
> +
> +static const char * const file_category_types[] = {
> +	[EROFS_FT_UNKNOWN] = "unknown type",
> +	[EROFS_FT_REG_FILE] = "regular file",
> +	[EROFS_FT_DIR] = "directory",
> +	[EROFS_FT_CHRDEV] = "char dev",
> +	[EROFS_FT_BLKDEV] = "block dev",
> +	[EROFS_FT_FIFO] = "FIFO file",
> +	[EROFS_FT_SOCK] = "SOCK file",
> +	[EROFS_FT_SYMLINK] = "symlink file",
> +};
> +
> +struct statistics {
> +	unsigned long blocks;
> +	unsigned long files;

what's the difference (blocks vs sbi.blocks) and
(files vs sbi.inos)?

If we consider fsck.erofs feature later, how about renaming
files to inos?

> +	unsigned long files_total_size;
> +	unsigned long files_total_origin_size;
> +	double compress_rate;
> +	unsigned long compressed_files;
> +	unsigned long uncompressed_files;
> +
> +	unsigned long regular_files;
> +	unsigned long dir_files;
> +	unsigned long chardev_files;
> +	unsigned long blkdev_files;
> +	unsigned long fifo_files;
> +	unsigned long sock_files;
> +	unsigned long symlink_files;

can we use an array indexed by EROFS_FT_UNKNOWN..EROFS_FT_SYMLINK as
well for these?

> +
> +	/* statistics the number of files based on inode_info->flags */
> +	unsigned long file_category_stat[EROFS_FT_MAX];
> +	/* statistics the number of files based on file name extensions */
> +	unsigned int file_type_stat[OTHERFILETYPE];
> +	/* statistics the number of files based on file orignial size */
> +	unsigned int file_original_size[FILE_MAX_SIZE_BITS + 1];
> +	/* statistics the number of files based on the compressed
> +	 * size of file
> +	 */
> +	unsigned int file_comp_size[FILE_MAX_SIZE_BITS + 1];
> +};
> +static struct statistics stats;
> +
>  static struct option long_options[] = {
>  	{"help", no_argument, 0, 1},
>  	{0, 0, 0, 0},
> @@ -57,24 +110,29 @@ static void usage(void)
>  		"Dump erofs layout from erofs-image, and [options] are:\n"
>  		"--help  display this help and exit.\n"
>  		"-s          print information about superblock\n"
> +		"-S      print statistic information of the erofs-image\n"
>  		"-V      print the version number of dump.erofs and exit.\n",
> -		stderr);
> +		stdout);

no need to modify this....

>  }
> +
>  static void dumpfs_print_version(void)
>  {
> -	fprintf(stderr, "dump.erofs %s\n", cfg.c_version);
> +	fprintf(stdout, "dump.erofs %s\n", cfg.c_version);

no need to modify this....

>  }
>  
>  static int dumpfs_parse_options_cfg(int argc, char **argv)
>  {
>  	int opt;
>  
> -	while ((opt = getopt_long(argc, argv, "sV",
> +	while ((opt = getopt_long(argc, argv, "sSV",
>  					long_options, NULL)) != -1) {
>  		switch (opt) {
>  		case 's':
>  			dumpcfg.print_superblock = true;
>  			break;
> +		case 'S':
> +			dumpcfg.print_statistic = true;
> +			break;
>  		case 'V':
>  			dumpfs_print_version();
>  			exit(0);
> @@ -100,6 +158,303 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
>  	return 0;
>  }
>  
> +static int get_file_compressed_size(struct erofs_inode *inode,
> +		erofs_off_t *size)
> +{
> +	*size = 0;
> +	switch (inode->datalayout) {
> +	case EROFS_INODE_FLAT_INLINE:
> +	case EROFS_INODE_FLAT_PLAIN:
> +		stats.uncompressed_files++;
> +		*size = inode->i_size;
> +		break;
> +	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
> +	case EROFS_INODE_FLAT_COMPRESSION:
> +		stats.compressed_files++;
> +		*size = inode->u.i_blocks * EROFS_BLKSIZ;
> +		break;
> +	default:
> +		erofs_err("unknown datalayout");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +static int get_file_type(const char *filename)
> +{
> +	char *postfix = strrchr(filename, '.');
> +	int type = 0;
> +
> +	if (postfix == NULL)
> +		return OTHERFILETYPE - 1;
> +	while (type < OTHERFILETYPE - 1) {
> +		if (strcmp(postfix, file_types[type]) == 0)
> +			break;
> +		type++;
> +	}
> +	return type;
> +}
> +
> +static void update_file_size_statatics(erofs_off_t occupied_size,
> +		erofs_off_t original_size)
> +{
> +	int occupied_size_mark;
> +	int original_size_mark;
> +
> +	original_size_mark = 0;
> +	occupied_size_mark = 0;
> +	occupied_size >>= 10;
> +	original_size >>= 10;
> +
> +	while (occupied_size || original_size) {
> +		if (occupied_size) {
> +			occupied_size >>= 1;
> +			occupied_size_mark++;
> +		}
> +		if (original_size) {
> +			original_size >>= 1;
> +			original_size_mark++;
> +		}
> +	}
> +
> +	if (original_size_mark >= FILE_MAX_SIZE_BITS)
> +		stats.file_original_size[FILE_MAX_SIZE_BITS]++;
> +	else
> +		stats.file_original_size[original_size_mark]++;
> +
> +	if (occupied_size_mark >= FILE_MAX_SIZE_BITS)
> +		stats.file_comp_size[FILE_MAX_SIZE_BITS]++;
> +	else
> +		stats.file_comp_size[occupied_size_mark]++;
> +}
> +
> +static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid)
> +{
> +	struct erofs_inode vi = { .nid = nid};
> +	int err;
> +	char buf[EROFS_BLKSIZ];
> +	char filename[PATH_MAX + 1];
> +	erofs_off_t offset;
> +
> +	err = erofs_read_inode_from_disk(&vi);
> +	if (err)
> +		return err;
> +
> +	offset = 0;
> +	while (offset < vi.i_size) {
> +		erofs_off_t maxsize = min_t(erofs_off_t,
> +			vi.i_size - offset, EROFS_BLKSIZ);
> +		struct erofs_dirent *de = (void *)buf;
> +		struct erofs_dirent *end;
> +		unsigned int nameoff;
> +
> +		err = erofs_pread(&vi, buf, maxsize, offset);
> +		if (err)
> +			return err;
> +
> +		nameoff = le16_to_cpu(de->nameoff);
> +
> +		if (nameoff < sizeof(struct erofs_dirent) ||
> +		    nameoff >= PAGE_SIZE) {
> +			erofs_err("invalid de[0].nameoff %u @ nid %llu",
> +				  nameoff, nid | 0ULL);
> +			return -EFSCORRUPTED;
> +		}
> +		end = (void *)buf + nameoff;
> +		while (de < end) {
> +			const char *dname;
> +			unsigned int dname_len;
> +			struct erofs_inode inode = { .nid = de->nid };
> +			erofs_off_t occupied_size = 0;
> +
> +			nameoff = le16_to_cpu(de->nameoff);
> +			dname = (char *)buf + nameoff;
> +
> +			if (de + 1 >= end)
> +				dname_len = strnlen(dname, maxsize - nameoff);
> +			else
> +				dname_len =
> +					le16_to_cpu(de[1].nameoff) - nameoff;
> +
> +			/* a corrupted entry is found */
> +			if (nameoff + dname_len > maxsize ||
> +				dname_len > EROFS_NAME_LEN) {
> +				erofs_err("bogus dirent @ nid %llu",
> +						le64_to_cpu(de->nid) | 0ULL);
> +				DBG_BUGON(1);
> +				return -EFSCORRUPTED;
> +			}
> +			if (de->nid != nid && de->nid != parent_nid)
> +				stats.files++;
> +
> +			memset(filename, 0, PATH_MAX + 1);
> +			memcpy(filename, dname, dname_len);
> +			if (de->file_type >= EROFS_FT_MAX) {
> +				erofs_err("invalid file type %llu", de->nid);
> +				continue;
> +			}
> +			if (de->file_type != EROFS_FT_DIR)
> +				stats.file_category_stat[de->file_type]++;
> +			switch (de->file_type) {
> +			case EROFS_FT_REG_FILE:
> +				err = erofs_read_inode_from_disk(&inode);
> +				if (err) {
> +					erofs_err("read file inode from disk failed!");
> +					return err;
> +				}
> +				stats.files_total_origin_size += inode.i_size;
> +				stats.file_type_stat[get_file_type(filename)]++;
> +
> +				err = get_file_compressed_size(&inode,
> +						&occupied_size);
> +				if (err) {
> +					erofs_err("get file size failed\n");
> +					return err;
> +				}
> +				stats.files_total_size += occupied_size;
> +				update_file_size_statatics(occupied_size, inode.i_size);
> +				break;
> +
> +			case EROFS_FT_DIR:
> +				if (de->nid != nid && de->nid != parent_nid) {
> +					stats.uncompressed_files++;
> +					err = erofs_read_dir(de->nid, nid);
> +					if (err) {
> +						fprintf(stdout,
> +								"parse dir nid %llu error occurred\n",
> +								de->nid);
> +						return err;
> +					}
> +					stats.file_category_stat[EROFS_FT_DIR]++;
> +				}
> +				break;
> +			case EROFS_FT_UNKNOWN:
> +			case EROFS_FT_CHRDEV:
> +			case EROFS_FT_BLKDEV:
> +			case EROFS_FT_FIFO:
> +			case EROFS_FT_SOCK:
> +			case EROFS_FT_SYMLINK:
> +				stats.uncompressed_files++;

I'd like to check if the file is/isn't compressed just by inode
datalayout rather than specific file type....

I mean we could check if the file type is correct or not (...much like a
fsck functionality....) but if we just want to get # of (un)compressed
files, we could just check datalayout instead....

Thanks,
Gao Xiang

> +				break;
> +			default:
> +				erofs_err("%d file type not exists", de->file_type);
> +			}
> +			++de;
> +		}
> +		offset += maxsize;
> +	}
> +	return 0;
> +}
> +
> +static void dumpfs_print_statistic_of_filetype(void)
> +{
> +	fprintf(stdout, "Filesystem total file count:		%lu\n",
> +			stats.files);
> +	for (int i = 0; i < EROFS_FT_MAX; i++)
> +		fprintf(stdout, "Filesystem %s count:		%lu\n",
> +			file_category_types[i], stats.file_category_stat[i]);
> +}
> +
> +static void dumpfs_print_chart_row(char *col1, unsigned int col2,
> +		double col3, char *col4)
> +{
> +	char row[500] = {0};
> +
> +	sprintf(row, chart_format, col1, col2, col3, col4);
> +	fprintf(stdout, row);
> +}
> +
> +static void dumpfs_print_chart_of_file(unsigned int *file_counts,
> +		unsigned int len)
> +{
> +	char col1[30];
> +	unsigned int col2;
> +	double col3;
> +	char col4[400];
> +	unsigned int lowerbound = 0;
> +	unsigned int upperbound = 1;
> +
> +	fprintf(stdout, header_format, ">=(KB) .. <(KB) ", "count",
> +			"ratio", "distribution");
> +	for (int i = 0; i < len; i++) {
> +		memset(col1, 0, sizeof(col1));
> +		memset(col4, 0, sizeof(col4));
> +		if (i == len - 1)
> +			sprintf(col1, "%6d ..", lowerbound);
> +		else if (i <= 6)
> +			sprintf(col1, "%6d .. %-6d", lowerbound, upperbound);
> +		else
> +
> +			sprintf(col1, "%6d .. %-6d", lowerbound, upperbound);
> +		col2 = file_counts[i];
> +		col3 = (double)(100 * col2) / (double)stats.file_category_stat[EROFS_FT_REG_FILE];
> +		memset(col4, '#', col3 / 2);
> +		dumpfs_print_chart_row(col1, col2, col3, col4);
> +		lowerbound = upperbound;
> +		upperbound <<= 1;
> +	}
> +}
> +
> +static void dumpfs_print_chart_of_file_type(char **file_types, unsigned int len)
> +{
> +	char col1[30];
> +	unsigned int col2;
> +	double col3;
> +	char col4[401];
> +
> +	fprintf(stdout, header_format, "type", "count", "ratio",
> +			"distribution");
> +	for (int i = 0; i < len; i++) {
> +		memset(col1, 0, sizeof(col1));
> +		memset(col4, 0, sizeof(col4));
> +		sprintf(col1, "%-17s", file_types[i]);
> +		col2 = stats.file_type_stat[i];
> +		col3 = (double)(100 * col2) / (double)stats.file_category_stat[EROFS_FT_REG_FILE];
> +		memset(col4, '#', col3 / 2);
> +		dumpfs_print_chart_row(col1, col2, col3, col4);
> +	}
> +}
> +
> +static void dumpfs_print_statistic_of_compression(void)
> +{
> +	stats.compress_rate = (double)(100 * stats.files_total_size) /
> +		(double)(stats.files_total_origin_size);
> +	fprintf(stdout, "Filesystem compressed files:            %lu\n",
> +			stats.compressed_files);
> +	fprintf(stdout, "Filesystem uncompressed files:          %lu\n",
> +			stats.uncompressed_files);
> +	fprintf(stdout, "Filesystem total original file size:    %lu Bytes\n",
> +			stats.files_total_origin_size);
> +	fprintf(stdout, "Filesystem total file size:             %lu Bytes\n",
> +			stats.files_total_size);
> +	fprintf(stdout, "Filesystem compress rate:               %.2f%%\n",
> +			stats.compress_rate);
> +}
> +
> +static void dumpfs_print_statistic(void)
> +{
> +	int err;
> +
> +	stats.blocks = sbi.blocks;
> +	err = erofs_read_dir(sbi.root_nid, sbi.root_nid);
> +	if (err) {
> +		erofs_err("read dir failed");
> +		return;
> +	}
> +
> +	dumpfs_print_statistic_of_filetype();
> +	dumpfs_print_statistic_of_compression();
> +
> +	fprintf(stdout, "\nOriginal file size distribution:\n");
> +	dumpfs_print_chart_of_file(stats.file_original_size,
> +			ARRAY_SIZE(stats.file_original_size));
> +	fprintf(stdout, "\nOn-Disk file size distribution:\n");
> +	dumpfs_print_chart_of_file(stats.file_comp_size,
> +			ARRAY_SIZE(stats.file_comp_size));
> +	fprintf(stdout, "\nFile type distribution:\n");
> +	dumpfs_print_chart_of_file_type(file_types, OTHERFILETYPE);
> +}
> +
>  static void dumpfs_print_superblock(void)
>  {
>  	time_t time = sbi.build_time;
> @@ -156,6 +511,9 @@ int main(int argc, char **argv)
>  
>  	if (dumpcfg.print_superblock)
>  		dumpfs_print_superblock();
> +
> +	if (dumpcfg.print_statistic)
> +		dumpfs_print_statistic();
>  out:
>  	if (cfg.c_img_path)
>  		free(cfg.c_img_path);
> -- 
> 2.25.4
