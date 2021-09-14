Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BF56E40AE87
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Sep 2021 15:04:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H83TY1Bq3z2yJ7
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Sep 2021 23:04:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H83TQ2XhDz2xvG
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Sep 2021 23:04:25 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UoNp2mw_1631624656; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UoNp2mw_1631624656) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 14 Sep 2021 21:04:18 +0800
Date: Tue, 14 Sep 2021 21:04:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Guo Xuenan <guoxuenan@huawei.com>
Subject: Re: [PATCH v2 2/5] dump.erofs: add "-s" option to dump superblock
 information
Message-ID: <YUCd0F3rGIQdS++Z@B-P7TQMD6M-0146.local>
References: <20210914074424.1875409-1-guoxuenan@huawei.com>
 <20210914074424.1875409-2-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210914074424.1875409-2-guoxuenan@huawei.com>
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

Some nits...

On Tue, Sep 14, 2021 at 03:44:21PM +0800, Guo Xuenan wrote:
> From: Wang Qi <mpiglet@outlook.com>
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> Signed-off-by: Wang Qi <mpiglet@outlook.com>
> ---
>  dump/Makefile.am |  3 +-
>  dump/main.c      | 94 +++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 88 insertions(+), 9 deletions(-)
> 
> diff --git a/dump/Makefile.am b/dump/Makefile.am
> index 8e18c0f..1ba58da 100644
> --- a/dump/Makefile.am
> +++ b/dump/Makefile.am
> @@ -3,7 +3,8 @@
>  
>  AUTOMAKE_OPTIONS = foreign
>  bin_PROGRAMS     = dump.erofs
> +AM_CPPFLAGS = ${libuuid_CFLAGS}
>  dump_erofs_SOURCES = main.c
>  dump_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
> -dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${liblz4_LIBS}
> +dump_erofs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/liberofs.la ${liblz4_LIBS}

+dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libuuid_LIBS}

>  
> diff --git a/dump/main.c b/dump/main.c
> index 8f299ca..33521bf 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -6,25 +6,57 @@
>   *            Guo Xuenan <guoxuenan@huawei.com>
>   */
>  
> +#define _GNU_SOURCE
>  #include <stdlib.h>
>  #include <getopt.h>
>  #include <sys/sysmacros.h>
>  #include <time.h>
>  #include <lz4.h>
> -

Should we get rid of this blank line in the patch 1 instead?

>  #include "erofs/print.h"
>  #include "erofs/io.h"
>  
> +#ifdef HAVE_LIBUUID
> +#include <uuid.h>
> +#endif
> +
> +struct dumpcfg {
> +	bool print_superblock;
> +	bool print_version;
> +};
> +static struct dumpcfg dumpcfg;
> +
>  static struct option long_options[] = {
>  	{"help", no_argument, 0, 1},
>  	{0, 0, 0, 0},
>  };
>  
> +#define EROFS_FEATURE_COMPAT	0
> +#define EROFS_FEATURE_INCOMPAT	1

How about getting rid of these?

> +
> +struct feature {
> +	int compat;

	bool compat;

> +	unsigned int mask;
> +	const char *name;
> +};
> +
> +static struct feature feature_lists[] = {
> +	{	EROFS_FEATURE_COMPAT, EROFS_FEATURE_COMPAT_SB_CHKSUM,
> +		"superblock-checksum"	},

sb_csum is enough... (refer to "metadata_csum" shown in dumpe2fs)

> +
> +	{	EROFS_FEATURE_INCOMPAT, EROFS_FEATURE_INCOMPAT_LZ4_0PADDING,
> +		"lz4-0padding"	},

How about showing "0padding" instead? Since I'll use this in the LZMA
patchset as well... (so not lz4-specific...)

> +	{	EROFS_FEATURE_INCOMPAT, EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER,
> +		"big-pcluster"	},

bigpcluster

> +
> +	{	0, 0, 0	},
> +};
> +
>  static void usage(void)
>  {
>  	fputs("usage: [options] erofs-image\n\n"
>  		"Dump erofs layout from erofs-image, and [options] are:\n"
>  		"--help  display this help and exit.\n"
> +		"-s          print information about superblock\n"
>  		"-V      print the version number of dump.erofs and exit.\n",
>  		stderr);
>  }
> @@ -37,9 +69,12 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
>  {
>  	int opt;
>  
> -	while ((opt = getopt_long(argc, argv, "V",
> +	while ((opt = getopt_long(argc, argv, "sV",
>  					long_options, NULL)) != -1) {
>  		switch (opt) {
> +		case 's':
> +			dumpcfg.print_superblock = true;
> +			break;
>  		case 'V':
>  			dumpfs_print_version();
>  			exit(0);
> @@ -65,21 +100,64 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
>  	return 0;
>  }
>  
> +static void dumpfs_print_superblock(void)
> +{
> +	time_t time = sbi.build_time;
> +	unsigned int features[] = {sbi.feature_compat, sbi.feature_incompat};
> +	char uuid_str[37] = "not available";
> +	int i = 0;
> +	int j = 0;
> +
> +	fprintf(stdout, "Filesystem magic number:			0x%04X\n", EROFS_SUPER_MAGIC_V1);
> +	fprintf(stdout, "Filesystem blocks:				%lu\n", sbi.blocks);
> +	fprintf(stdout, "Filesystem inode metadata start block:		%u\n", sbi.meta_blkaddr);
> +	fprintf(stdout, "Filesystem shared xattr metadata start block:	%u\n", sbi.xattr_blkaddr);
> +	fprintf(stdout, "Filesystem root nid:				%ld\n", sbi.root_nid);
> +	fprintf(stdout, "Filesystem valid inode count:			%lu\n", sbi.inos);

"Filesystem inode count" is enough since such "valid" expression makes
people think about what does the invalid inode mean.

Thanks,
Gao Xiang

> +	fprintf(stdout, "Filesystem created:				%s", ctime(&time));
> +	fprintf(stdout, "Filesystem features:				");
> +	for (; i < ARRAY_SIZE(features); i++) {
> +		for (; j < ARRAY_SIZE(feature_lists); j++) {
> +			if (i == feature_lists[j].compat
> +				&& (features[i] & feature_lists[j].mask))
> +				fprintf(stdout, "%s ", feature_lists[j].name);
> +		}
> +	}
> +	fprintf(stdout, "\n");
> +#ifdef HAVE_LIBUUID
> +	uuid_unparse_lower(sbi.uuid, uuid_str);
> +#endif
> +	fprintf(stdout, "Filesystem UUID:				%s\n", uuid_str);
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	int err = 0;
>  
>  	erofs_init_configure();
>  	err = dumpfs_parse_options_cfg(argc, argv);
> -
> -	if (cfg.c_img_path)
> -		free(cfg.c_img_path);
> -
>  	if (err) {
>  		if (err == -EINVAL)
>  			usage();
> -		return -1;
> +		goto out;
>  	}
>  
> -	return 0;
> +	err = dev_open_ro(cfg.c_img_path);
> +	if (err) {
> +		erofs_err("open image file failed");
> +		goto out;
> +	}
> +
> +	err = erofs_read_superblock();
> +	if (err) {
> +		erofs_err("read superblock failed");
> +		goto out;
> +	}
> +
> +	if (dumpcfg.print_superblock)
> +		dumpfs_print_superblock();
> +out:
> +	if (cfg.c_img_path)
> +		free(cfg.c_img_path);
> +	return err;
>  }
> -- 
> 2.25.4
