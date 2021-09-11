Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4CE40797F
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Sep 2021 18:13:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H6Hpq6vHfz2yNK
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Sep 2021 02:13:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TDq+cc2e;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TDq+cc2e; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H6Hpn2zhkz2yJf
 for <linux-erofs@lists.ozlabs.org>; Sun, 12 Sep 2021 02:13:21 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E305F6113A;
 Sat, 11 Sep 2021 16:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631376799;
 bh=rthStXvaO9cXC6NKXq61WQFWnxPWjPcNPnSpevSxBQ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TDq+cc2e/xVIVMf8Accc4A5t4QXDSL1680udyedSdFftxbDF+9gSqS/Mpxz/hL1f0
 XYDrGCTQtnQAYfMsE5NSWUCOEQ8KZhipjFjihTrQ/OX7WK6cwTO1z9bABirt8zhveF
 0qQAqL9H+DxqEX9k8opk6dCE0bQ7zOdsFZJ4gItnC24CszZ07vJylnWghxDwYE9fnf
 2nVL2Ef5TplKKv1ULvnoaMCeWCfHWKfhP1AZWPwVx+iwRYO55rJTGF2/heCHzamFGD
 WrY/v6LIy3nBFXYhE2VV4vZzHydhNWbOIAZZ5ggbOeonZUNxBWt+pYH+mA/Ny0KC6L
 2ak3FzGe9rvNg==
Date: Sun, 12 Sep 2021 00:13:06 +0800
From: Gao Xiang <xiang@kernel.org>
To: Guo Xuenan <guoxuenan@huawei.com>
Subject: Re: [PATCH v1 3/5] dump.erofs: add -S options for collecting
 statistics of the whole filesystem
Message-ID: <20210911161305.GC3160@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Guo Xuenan <guoxuenan@huawei.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org, mpiglet@outlook.com,
 Huang Jianan <huangjianan@oppo.com>
References: <20210911134635.1253426-1-guoxuenan@huawei.com>
 <20210911134635.1253426-3-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210911134635.1253426-3-guoxuenan@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org, mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

(+Cc Jianan.)

On Sat, Sep 11, 2021 at 09:46:33PM +0800, Guo Xuenan wrote:
> From: mpiglet <mpiglet@outlook.com>
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> Signed-off-by: mpiglet <mpiglet@outlook.com>
> ---
>  dump/main.c | 474 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 474 insertions(+)
> 
> diff --git a/dump/main.c b/dump/main.c
> index 25ac89f..b0acc0b 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -19,10 +19,78 @@
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
> +	".so",
> +	".png",
> +	".jpg",
> +	".xml",
> +	".html",
> +	".odex",
> +	".vdex",
> +	".apk",
> +	".ttf",
> +	".jar",
> +	".json",
> +	".ogg",
> +	".oat",
> +	".art",
> +	".rc",
> +	".otf",
> +	".txt",
> +	"others",
> +};
> +enum {
> +	SOFILETYPE = 0,
> +	PNGFILETYPE,
> +	JPEGFILETYPE,
> +	XMLFILETYPE,
> +	HTMLFILETYPE,
> +	ODEXFILETYPE,
> +	VDEXFILETYPE,
> +	APKFILETYPE,
> +	TTFFILETYPE,
> +	JARFILETYPE,
> +	JSONFILETYPE,
> +	OGGFILETYPE,
> +	OATFILETYPE,
> +	ARTFILETYPE,
> +	RCFILETYPE,
> +	OTFFILETYPE,
> +	TXTFILETYPE,
> +	OTHERFILETYPE,
> +};

Why we need enums here? Can these be resolved with some array index?

> +
> +#define	FILE_SIZE_BITS	30
> +struct statistics {
> +	unsigned long blocks;
> +	unsigned long files;
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
> +
> +	unsigned int file_type_stat[OTHERFILETYPE + 1];
> +	unsigned int file_org_size[FILE_SIZE_BITS];

What do "FILE_SIZE_BITS" and "file_org_size" mean?

> +	unsigned int file_comp_size[FILE_SIZE_BITS];
> +};
> +static struct statistics stats;
> +
>  static struct option long_options[] = {
>  	{"help", no_argument, 0, 1},
>  	{0, 0, 0, 0},
> @@ -33,6 +101,7 @@ static void usage(void)
>  	fputs("usage: [options] erofs-image \n\n"
>  		"Dump erofs layout from erofs-image, and [options] are:\n"
>  		"-s          print information about superblock\n"
> +		"-S      print statistic information of the erofs-image\n"
>  		"-v/-V      print dump.erofs version info\n"
>  		"-h/--help  display this help and exit\n", stderr);
>  }
> @@ -51,6 +120,9 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
>  		case 's':
>  			dumpcfg.print_superblock = true;
>  			break;
> +		case 'S':
> +			dumpcfg.print_statistic = true;
> +			break;
>  		case 'v':
>  		case 'V':
>  			dumpfs_print_version();
> @@ -78,6 +150,116 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
>  	return 0;
>  }
>  
> +static int z_erofs_get_last_cluster_size_from_disk(struct erofs_map_blocks *map,
> +		erofs_off_t last_cluster_size,
> +		erofs_off_t *last_cluster_compressed_size)

Hmmm... do we really need the exact compressed bytes?
or just compressed blocks is enough?

"compressed blocks" can be gotten in erofs inode.

Btw, although I think it's useful for fsck (check if an erofs is correct).

> +{
> +	int ret;
> +	int decomp_len;
> +	int compressed_len = 0;
> +	char *decompress;
> +	char raw[Z_EROFS_PCLUSTER_MAX_SIZE] = {0};
> +
> +	ret = dev_read(raw, map->m_pa, map->m_plen);
> +	if (ret < 0)
> +		return -EIO;
> +
> +	if (erofs_sb_has_lz4_0padding()) {
> +		compressed_len = map->m_plen;
> +	} else {
> +		// lz4 maximum compression ratio is 255
> +		decompress = (char *)malloc(map->m_plen * 255);
> +		if (!decompress) {
> +			erofs_err("allocate memory for decompress space failed");
> +			return -1;
> +		}
> +		decomp_len = LZ4_decompress_safe_partial(raw, decompress,
> +				map->m_plen, last_cluster_size,
> +				map->m_plen * 10);
> +		if (decomp_len < 0) {
> +			erofs_err("decompress last cluster to get decompressed size failed");
> +			free(decompress);
> +			return -1;
> +		}
> +		compressed_len = LZ4_compress_destSize(decompress, raw,
> +				&decomp_len, Z_EROFS_PCLUSTER_MAX_SIZE);
> +		if (compressed_len < 0) {
> +			erofs_err("compress to get last extent size failed\n");
> +			free(decompress);
> +			return -1;
> +		}
> +		free(decompress);
> +		// dut to the use of lz4hc (can use different compress level),
> +		// our normal lz4 compress result may be bigger
> +		compressed_len = compressed_len < map->m_plen ?
> +			compressed_len : map->m_plen;
> +	}
> +
> +	*last_cluster_compressed_size = compressed_len;
> +	return 0;
> +}
> +
> +static int z_erofs_get_compressed_size(struct erofs_inode *inode,
> +		erofs_off_t *size)
> +{
> +	int err;
> +	erofs_blk_t compressedlcs;
> +	erofs_off_t last_cluster_size;
> +	erofs_off_t last_cluster_compressed_size;
> +	struct erofs_map_blocks map = {
> +		.index = UINT_MAX,
> +		.m_la = inode->i_size - 1,
> +	};
> +
> +	err = z_erofs_map_blocks_iter(inode, &map);

(add Jianan here.)

Can we port the latest erofs kernel fiemap code to erofs-utils, and add
some functionality to get the file distribution as well when the fs isn't
mounted?


> +	if (err) {
> +		erofs_err("read nid %ld's last block failed\n", inode->nid);
> +		return err;
> +	}
> +	compressedlcs = map.m_plen >> inode->z_logical_clusterbits;
> +	*size = (inode->u.i_blocks - compressedlcs) * EROFS_BLKSIZ;
> +	last_cluster_size = inode->i_size - map.m_la;
> +
> +	if (!(map.m_flags & EROFS_MAP_ZIPPED)) {
> +		*size += last_cluster_size;
> +	} else {
> +		err = z_erofs_get_last_cluster_size_from_disk(&map,
> +				last_cluster_size,
> +				&last_cluster_compressed_size);
> +		if (err) {
> +			erofs_err("get nid %ld's last extent size failed",
> +					inode->nid);
> +			return err;
> +		}
> +		*size += last_cluster_compressed_size;
> +	}
> +	return 0;
> +}
> +
> +static int get_file_compressed_size(struct erofs_inode *inode,
> +		erofs_off_t *size)

erofs_dump_get_file_occupied_blocks?

> +{
> +	int err;
> +
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
> +		err = z_erofs_get_compressed_size(inode, size);
> +		if (err) {
> +			erofs_err("get compressed file size failed\n");
> +			return err;
> +		}
> +	}
> +	return 0;
> +}
> +
>  static void dumpfs_print_superblock(void)
>  {
>  	time_t time = sbi.build_time;
> @@ -111,6 +293,294 @@ static void dumpfs_print_superblock(void)
>  
>  }
>  
> +static int get_file_type(const char *filename)
> +{
> +	char *postfix = strrchr(filename, '.');
> +	int type = SOFILETYPE;
> +
> +	if (postfix == NULL)
> +		return OTHERFILETYPE;
> +	while (type < OTHERFILETYPE) {
> +		if (strcmp(postfix, file_types[type]) == 0)
> +			break;
> +		type++;
> +	}
> +	return type;
> +}
> +
> +// file count、file size、file type

It'd be better to avoid C++ comments...

> +static int read_dir(erofs_nid_t nid, erofs_nid_t parent_nid)
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
> +			int actual_size_mark;
> +			int original_size_mark;
> +			erofs_off_t actual_size = 0;
> +			erofs_off_t original_size;
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
> +
> +			switch (de->file_type) {
> +			case EROFS_FT_UNKNOWN:
> +				break;
> +			case EROFS_FT_REG_FILE:
> +				err = erofs_read_inode_from_disk(&inode);
> +				if (err) {
> +					erofs_err("read file inode from disk failed!");
> +					return err;
> +				}
> +				original_size = inode.i_size;
> +				stats.files_total_origin_size += original_size;
> +				stats.regular_files++;
> +
> +				err = get_file_compressed_size(&inode,
> +						&actual_size);
> +				if (err) {
> +					erofs_err("get file size failed\n");
> +					return err;
> +				}
> +				stats.files_total_size += actual_size;
> +				stats.file_type_stat[get_file_type(filename)]++;
> +
> +				original_size_mark = 0;
> +				actual_size_mark = 0;
> +				actual_size >>= 10;
> +				original_size >>= 10;
> +
> +				while (actual_size || original_size) {
> +					if (actual_size) {
> +						actual_size >>= 1;
> +						actual_size_mark++;
> +					}
> +					if (original_size) {
> +						original_size >>= 1;
> +						original_size_mark++;
> +					}
> +				}
> +
> +				if (original_size_mark >= FILE_SIZE_BITS - 1)
> +					stats.file_org_size[FILE_SIZE_BITS - 1]++;
> +				else
> +					stats.file_org_size[original_size_mark]++;
> +				if (actual_size_mark >= FILE_SIZE_BITS - 1)
> +					stats.file_comp_size[FILE_SIZE_BITS - 1]++;
> +				else
> +					stats.file_comp_size[actual_size_mark]++;
> +				break;
> +
> +			case EROFS_FT_DIR:
> +				if (de->nid != nid && de->nid != parent_nid) {



> +					stats.dir_files++;
> +					stats.uncompressed_files++;
> +					err = read_dir(de->nid, nid);
> +					if (err) {
> +						fprintf(stderr,
> +								"parse dir nid %llu error occurred\n",
> +								de->nid);
> +						return err;
> +					}
> +				}
> +				break;
> +			case EROFS_FT_CHRDEV:
> +				stats.chardev_files++;
> +				stats.uncompressed_files++;

How about using an array instead?

> +				break;
> +			case EROFS_FT_BLKDEV:
> +				stats.blkdev_files++;
> +				stats.uncompressed_files++;
> +				break;
> +			case EROFS_FT_FIFO:
> +				stats.fifo_files++;
> +				stats.uncompressed_files++;
> +				break;
> +			case EROFS_FT_SOCK:
> +				stats.sock_files++;
> +				stats.uncompressed_files++;
> +				break;
> +			case EROFS_FT_SYMLINK:
> +				stats.symlink_files++;
> +				stats.uncompressed_files++;
> +				break;
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
> +	fprintf(stderr, "Filesystem total file count:         %lu\n",
> +			stats.files);
> +	fprintf(stderr, "Filesystem regular file count:       %lu\n",
> +			stats.regular_files);
> +	fprintf(stderr, "Filesystem directory count:          %lu\n",
> +			stats.dir_files);
> +	fprintf(stderr, "Filesystem symlink file count:       %lu\n",
> +			stats.symlink_files);
> +	fprintf(stderr, "Filesystem character device count:   %lu\n",
> +			stats.chardev_files);
> +	fprintf(stderr, "Filesystem block device count:       %lu\n",
> +			stats.blkdev_files);
> +	fprintf(stderr, "Filesystem FIFO file count:          %lu\n",
> +			stats.fifo_files);
> +	fprintf(stderr, "Filesystem SOCK file count:          %lu\n",
> +			stats.sock_files);

Also a loop can be used here.

> +}
> +
> +static void dumpfs_print_chart_row(char *col1, unsigned int col2,
> +		double col3, char *col4)
> +{
> +	char row[500] = {0};
> +
> +	sprintf(row, chart_format, col1, col2, col3, col4);
> +	fprintf(stderr, row);
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
> +	fprintf(stderr, header_format, ">=(KB) .. <(KB) ", "count",
> +			"ratio", "distribution");
> +	for (int i = 0; i < len; i++) {
> +		memset(col1, 0, 30);

		memset(col1, 0, sizeof(col1));

> +		memset(col4, 0, 400);

		memset(col4, 0, sizeof(col4));

Thanks,
Gao Xiang

> +		if (i == len - 1)
> +			strcpy(col1, " others");
> +		else if (i <= 6)
> +			sprintf(col1, "%6d .. %-6d", lowerbound, upperbound);
> +		else
> +
> +			sprintf(col1, "%6d .. %-6d", lowerbound, upperbound);
> +		col2 = file_counts[i];
> +		col3 = (double)(100 * col2) / (double)stats.regular_files;
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
> +	fprintf(stderr, header_format, "type", "count", "ratio",
> +			"distribution");
> +	for (int i = 0; i < len; i++) {
> +		memset(col1, 0, 30);
> +		memset(col4, 0, 401);
> +		sprintf(col1, "%-17s", file_types[i]);
> +		col2 = stats.file_type_stat[i];
> +		col3 = (double)(100 * col2) / (double)stats.regular_files;
> +		memset(col4, '#', col3 / 2);
> +		dumpfs_print_chart_row(col1, col2, col3, col4);
> +	}
> +}
> +
> +static void dumpfs_print_statistic_of_compression(void)
> +{
> +	stats.compress_rate = (double)(100 * stats.files_total_size) /
> +		(double)(stats.files_total_origin_size);
> +	fprintf(stderr, "Filesystem compressed files:         %lu\n",
> +			stats.compressed_files);
> +	fprintf(stderr, "Filesystem uncompressed files:       %lu\n",
> +			stats.uncompressed_files);
> +	fprintf(stderr, "Filesystem total original file size: %lu Bytes\n",
> +			stats.files_total_origin_size);
> +	fprintf(stderr, "Filesystem total file size:          %lu Bytes\n",
> +			stats.files_total_size);
> +	fprintf(stderr, "Filesystem compress rate:            %.2f%%\n",
> +			stats.compress_rate);
> +}
> +
> +static void dumpfs_print_statistic(void)
> +{
> +	int err;
> +
> +	stats.blocks = sbi.blocks;
> +	err = read_dir(sbi.root_nid, sbi.root_nid);
> +	if (err) {
> +		erofs_err("read dir failed");
> +		return;
> +	}
> +
> +	dumpfs_print_statistic_of_filetype();
> +	dumpfs_print_statistic_of_compression();
> +
> +	fprintf(stderr, "\nOriginal file size distribution:\n");
> +	dumpfs_print_chart_of_file(stats.file_org_size, 17);
> +	fprintf(stderr, "\nOn-Disk file size distribution:\n");
> +	dumpfs_print_chart_of_file(stats.file_comp_size, 17);
> +	fprintf(stderr, "\nFile type distribution:\n");
> +	dumpfs_print_chart_of_file_type(file_types, OTHERFILETYPE + 1);
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	int err = 0;
> @@ -138,5 +608,9 @@ int main(int argc, char **argv)
>  	if (dumpcfg.print_superblock)
>  		dumpfs_print_superblock();
>  
> +	if (dumpcfg.print_statistic)
> +		dumpfs_print_statistic();
> +
> +
>  	return 0;
>  }
> -- 
> 2.25.4
> 
