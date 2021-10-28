Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FD343DFCA
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 13:13:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hg2wc1ngbz2ynN
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 22:13:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hg2wX3KV1z2yMq
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 Oct 2021 22:12:55 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0Uu.znPx_1635419555; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uu.znPx_1635419555) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 28 Oct 2021 19:12:37 +0800
Date: Thu, 28 Oct 2021 19:12:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Guo Xuenan <guoxuenan@huawei.com>
Subject: Re: [PATCH v2 2/5] erofs-utils: dump: add feature for collecting
 filesystem statistics.
Message-ID: <YXqFoxI73WAZF874@B-P7TQMD6M-0146.local>
References: <20211028105748.3586231-1-guoxuenan@huawei.com>
 <20211028105748.3586231-2-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211028105748.3586231-2-guoxuenan@huawei.com>
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
Cc: daeho43@gmail.com, linux-erofs@lists.ozlabs.org, mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Oct 28, 2021 at 06:57:45PM +0800, Guo Xuenan wrote:
> From: Wang Qi <mpiglet@outlook.com>
> 
> Add -S option, for printing statistics of the overall disk, including
> file type(by file extension)/size statistics and distribution, number
> of compressed and uncompressed files, whole compression ratio of image.
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> Signed-off-by: Wang Qi <mpiglet@outlook.com>
> ---
>  dump/Makefile.am         |   2 +-
>  dump/main.c              | 358 ++++++++++++++++++++++++++++++++++++++-
>  include/erofs/internal.h |   1 +
>  lib/namei.c              |   2 +-
>  4 files changed, 360 insertions(+), 3 deletions(-)
> 
> diff --git a/dump/Makefile.am b/dump/Makefile.am
> index f0246d7..4759901 100644
> --- a/dump/Makefile.am
> +++ b/dump/Makefile.am
> @@ -6,4 +6,4 @@ bin_PROGRAMS     = dump.erofs
>  AM_CPPFLAGS = ${libuuid_CFLAGS}
>  dump_erofs_SOURCES = main.c
>  dump_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
> -dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} ${libuuid_LIBS}
> +dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} ${libuuid_LIBS} ${liblz4_LIBS}
> diff --git a/dump/main.c b/dump/main.c
> index 5b7ac5c..eacf02e 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -18,9 +18,51 @@
>  struct erofsdump_cfg {
>  	unsigned int totalshow;
>  	bool show_superblock;
> +	bool show_statistics;
>  };
>  static struct erofsdump_cfg dumpcfg;
>  
> +static const char chart_format[] = "%-16s	%-11d %8.2f%% |%-50s|\n";
> +static const char header_format[] = "%-16s %11s %16s |%-50s|\n";
> +static char *file_types[] = {
> +	".txt", ".so", ".xml", ".apk",
> +	".odex", ".vdex", ".oat", ".rc",
> +	".otf", ".txt", "others",
> +};

After re-thinking about it, I guess how about showing the top X extensions
and others. (X can be configurable), it makes more sense than fixed
extension as above.

But anyway, I'm fine to leave it as-is for now. we could improve it
later.

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
> +struct erofs_statistics {
> +	unsigned long files;
> +	unsigned long compressed_files;
> +	unsigned long uncompressed_files;
> +	unsigned long files_total_size;
> +	unsigned long files_total_origin_size;
> +	double compress_rate;
> +
> +	/* [statistics] # of files based on inode_info->flags */
> +	unsigned long file_category_stat[EROFS_FT_MAX];
> +	/* [statistics] # of files based on file name extensions */
> +	unsigned int file_type_stat[OTHERFILETYPE];
> +	/* [statistics] # of files based on the original size of files */
> +	unsigned int file_original_size[FILE_MAX_SIZE_BITS + 1];
> +	/* [statistics] # of files based on the compressed size of files */
> +	unsigned int file_comp_size[FILE_MAX_SIZE_BITS + 1];
> +};
> +static struct erofs_statistics stats;
> +
>  static struct option long_options[] = {
>  	{"help", no_argument, 0, 1},
>  	{0, 0, 0, 0},
> @@ -39,10 +81,13 @@ static struct erofsdump_feature feature_lists[] = {
>  	{ false, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
>  };
>  
> +static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid);
> +
>  static void usage(void)
>  {
>  	fputs("usage: [options] IMAGE\n\n"
>  	      "Dump erofs layout from IMAGE, and [options] are:\n"
> +	      " -S      show statistic information of the image\n"
>  	      " -V      print the version number of dump.erofs and exit.\n"
>  	      " -s      show information about superblock\n"
>  	      " --help  display this help and exit.\n",
> @@ -58,13 +103,17 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
>  {
>  	int opt;
>  
> -	while ((opt = getopt_long(argc, argv, "Vs",
> +	while ((opt = getopt_long(argc, argv, "SVs",
>  				  long_options, NULL)) != -1) {
>  		switch (opt) {
>  		case 's':
>  			dumpcfg.show_superblock = true;
>  			++dumpcfg.totalshow;
>  			break;
> +		case 'S':
> +			dumpcfg.show_statistics = true;
> +			++dumpcfg.totalshow;
> +			break;
>  		case 'V':
>  			erofsdump_print_version();
>  			exit(0);
> @@ -90,6 +139,310 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
>  	return 0;
>  }
>  
> +static int erofs_get_occupied_size(struct erofs_inode *inode,
> +		erofs_off_t *size)
> +{
> +	*size = 0;
> +	switch (inode->datalayout) {
> +	case EROFS_INODE_FLAT_INLINE:
> +	case EROFS_INODE_FLAT_PLAIN:
> +	case EROFS_INODE_CHUNK_BASED:
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
> +static int erofs_getfile_extension(const char *filename)
> +{
> +	char *postfix = strrchr(filename, '.');
> +	int type = 0;
> +
> +	if (postfix == NULL)

	if (!postfix)

> +		return OTHERFILETYPE - 1;
> +	for (type = 0; type < OTHERFILETYPE - 1; ++type) {
> +		if (strcmp(postfix, file_types[type]) == 0)
> +			break;
> +		type++;

redundant "type++" here.

Thanks,
Gao Xiang

