Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D0C3AFB5B
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Jun 2021 05:20:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8BVt1RBSz3060
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Jun 2021 13:20:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8BVm0JW8z2yXs
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Jun 2021 13:20:46 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04420; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0UdGyXoE_1624332039; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UdGyXoE_1624332039) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 22 Jun 2021 11:20:41 +0800
Date: Tue, 22 Jun 2021 11:20:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] AOSP: erofs-utils: add block list support
Message-ID: <YNFXBps3VtETCb17@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210622030232.1176-1-zbestahu@gmail.com>
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
Cc: huyue2@yulong.com, xiang@kernel.org, Guo Weichao <guoweichao@oppo.com>,
 linux-erofs@lists.ozlabs.org, zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

Thanks for your contribution!

On Tue, Jun 22, 2021 at 11:02:32AM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Android update engine will treat EROFS filesystem image as one single
> file. Let's add block list support to optimize OTA size.
> 
> Change-Id: I21d6177dff0ee65d3c57023b102e991d40873f0d

Change-Id is not strictly necessary here.

I'm not quite familiar with Android block list format (Guifu knows better
than me), may be Jianan and Guifu could review it first. I'll seek time
on this off work.

Hi Jianan,
I heard that you guys have some internal implementation as well, could
you also help review this patch?

Hi Guifu,
Could you also take a look at this against the previous huawei in-house
Android block list implementation and review this as well?

Thanks,
Gao Xiang

> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  include/erofs/block_list.h | 19 ++++++++++
>  include/erofs/config.h     |  1 +
>  lib/block_list.c           | 86 ++++++++++++++++++++++++++++++++++++++++++++++
>  lib/compress.c             |  8 +++++
>  lib/inode.c                | 21 ++++++++++-
>  mkfs/main.c                | 17 +++++++++
>  6 files changed, 151 insertions(+), 1 deletion(-)
>  create mode 100644 include/erofs/block_list.h
>  create mode 100644 lib/block_list.c
> 
> diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
> new file mode 100644
> index 0000000..cbf1050
> --- /dev/null
> +++ b/include/erofs/block_list.h
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * erofs-utils/include/erofs/block_list.h
> + *
> + * Copyright (C), 2021, Coolpad Group Limited.
> + * Created by Yue Hu <huyue2@yulong.com>
> + */
> +#ifndef __EROFS_BLOCK_LIST_H
> +#define __EROFS_BLOCK_LIST_H
> +
> +#include "internal.h"
> +
> +int block_list_fopen(void);
> +void block_list_fclose(void);
> +void write_block_list(const char *path, erofs_blk_t blk_start,
> +                      erofs_blk_t nblocks, bool has_tail);
> +void write_block_list_tail_end(const char *path, erofs_blk_t nblocks,
> +                               bool inline_data, erofs_blk_t blkaddr);
> +#endif
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index d140a73..67e7a0f 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -65,6 +65,7 @@ struct erofs_configure {
>  	char *mount_point;
>  	char *target_out_path;
>  	char *fs_config_file;
> +	char *block_list_file;
>  #endif
>  };
>  
> diff --git a/lib/block_list.c b/lib/block_list.c
> new file mode 100644
> index 0000000..6ebe0f9
> --- /dev/null
> +++ b/lib/block_list.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * erofs-utils/lib/block_list.c
> + *
> + * Copyright (C), 2021, Coolpad Group Limited.
> + * Created by Yue Hu <huyue2@yulong.com>
> + */
> +#ifdef WITH_ANDROID
> +#include <stdio.h>
> +
> +#include "erofs/block_list.h"
> +
> +#define pr_fmt(fmt) "EROFS block_list: " FUNC_LINE_FMT fmt "\n"
> +#include "erofs/print.h"
> +
> +static FILE *block_list_fp = NULL;
> +
> +int block_list_fopen(void)
> +{
> +	if (block_list_fp)
> +		return 0;
> +
> +	block_list_fp = fopen(cfg.block_list_file, "w");
> +
> +	if (block_list_fp == NULL)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +void block_list_fclose(void)
> +{
> +	if (block_list_fp) {
> +		fclose(block_list_fp);
> +		block_list_fp = NULL;
> +	}
> +}
> +
> +void write_block_list(const char *path, erofs_blk_t blk_start,
> +		      erofs_blk_t nblocks, bool has_tail)
> +{
> +	const char *fspath = erofs_fspath(path);
> +
> +	if (!block_list_fp || !cfg.mount_point)
> +		return;
> +
> +	/* only tail-end data */
> +	if (!nblocks)
> +		return;
> +
> +	fprintf(block_list_fp, "/%s", cfg.mount_point);
> +
> +	if (fspath[0] != '/')
> +		fprintf(block_list_fp, "/");
> +
> +	if (nblocks == 1) {
> +		fprintf(block_list_fp, "%s %u", fspath, blk_start);
> +	} else {
> +		fprintf(block_list_fp, "%s %u-%u", fspath, blk_start,
> +			blk_start + nblocks - 1);
> +	}
> +
> +	if (!has_tail)
> +		fprintf(block_list_fp, "\n");
> +}
> +
> +void write_block_list_tail_end(const char *path, erofs_blk_t nblocks,
> +			       bool inline_data, erofs_blk_t blkaddr)
> +{
> +	if (!block_list_fp || !cfg.mount_point)
> +		return;
> +
> +	if (!nblocks && !inline_data) {
> +		erofs_dbg("%s : only tail-end non-inline data", path);
> +		write_block_list(path, blkaddr, 1, false);
> +		return;
> +	}
> +
> +	if (nblocks) {
> +		if (!inline_data)
> +			fprintf(block_list_fp, " %u", blkaddr);
> +
> +		fprintf(block_list_fp, "\n");
> +	}
> +}
> +#endif
> diff --git a/lib/compress.c b/lib/compress.c
> index 2093bfd..5dec0c3 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -19,6 +19,10 @@
>  #include "erofs/compress.h"
>  #include "compressor.h"
>  
> +#ifdef WITH_ANDROID
> +#include "erofs/block_list.h"
> +#endif
> +
>  static struct erofs_compress compresshandle;
>  static int compressionlevel;
>  
> @@ -553,6 +557,10 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
>  		   inode->i_srcpath, (unsigned long long)inode->i_size,
>  		   compressed_blocks);
>  
> +#ifdef WITH_ANDROID
> +	write_block_list(inode->i_srcpath, blkaddr, compressed_blocks, false);
> +#endif
> +
>  	/*
>  	 * TODO: need to move erofs_bdrop to erofs_write_tail_end
>  	 *       when both mkfs & kernel support compression inline.
> diff --git a/lib/inode.c b/lib/inode.c
> index 787e5b4..6be23cb 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -22,6 +22,10 @@
>  #include "erofs/xattr.h"
>  #include "erofs/exclude.h"
>  
> +#ifdef WITH_ANDROID
> +#include "erofs/block_list.h"
> +#endif
> +
>  #define S_SHIFT                 12
>  static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
>  	[S_IFREG >> S_SHIFT]  = EROFS_FT_REG_FILE,
> @@ -369,6 +373,12 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
>  			return -EIO;
>  		}
>  	}
> +
> +#ifdef WITH_ANDROID
> +	if (nblocks)
> +		write_block_list(inode->i_srcpath, inode->u.i_blkaddr,
> +				 nblocks, inode->idata_size ? true : false);
> +#endif
>  	return 0;
>  }
>  
> @@ -626,6 +636,7 @@ static struct erofs_bhops erofs_write_inline_bhops = {
>  int erofs_write_tail_end(struct erofs_inode *inode)
>  {
>  	struct erofs_buffer_head *bh, *ibh;
> +	erofs_off_t pos;
>  
>  	bh = inode->bh_data;
>  
> @@ -640,7 +651,6 @@ int erofs_write_tail_end(struct erofs_inode *inode)
>  		ibh->op = &erofs_write_inline_bhops;
>  	} else {
>  		int ret;
> -		erofs_off_t pos;
>  
>  		erofs_mapbh(bh->block);
>  		pos = erofs_btell(bh, true) - EROFS_BLKSIZ;
> @@ -658,6 +668,15 @@ int erofs_write_tail_end(struct erofs_inode *inode)
>  		free(inode->idata);
>  		inode->idata = NULL;
>  	}
> +
> +#ifdef WITH_ANDROID
> +	if (!S_ISDIR(inode->i_mode) && !S_ISLNK(inode->i_mode))
> +		write_block_list_tail_end(inode->i_srcpath,
> +					  inode->i_size / EROFS_BLKSIZ,
> +					  inode->bh_inline ? true: false,
> +					  erofs_blknr(pos));
> +#endif
> +
>  out:
>  	/* now bh_data can drop directly */
>  	if (bh) {
> diff --git a/mkfs/main.c b/mkfs/main.c
> index e476189..d5a5e07 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -27,6 +27,10 @@
>  #include <uuid.h>
>  #endif
>  
> +#ifdef WITH_ANDROID
> +#include "erofs/block_list.h"
> +#endif
> +
>  #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
>  
>  static struct option long_options[] = {
> @@ -47,6 +51,7 @@ static struct option long_options[] = {
>  	{"mount-point", required_argument, NULL, 10},
>  	{"product-out", required_argument, NULL, 11},
>  	{"fs-config-file", required_argument, NULL, 12},
> +	{"block-list-file", required_argument, NULL, 13},
>  #endif
>  	{0, 0, 0, 0},
>  };
> @@ -95,6 +100,7 @@ static void usage(void)
>  	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
>  	      " --product-out=X       X=product_out directory\n"
>  	      " --fs-config-file=X    X=fs_config file\n"
> +	      " --block-list-file=X    X=block_list file\n"
>  #endif
>  	      "\nAvailable compressors are: ", stderr);
>  	print_available_compressors(stderr, ", ");
> @@ -293,6 +299,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  		case 12:
>  			cfg.fs_config_file = optarg;
>  			break;
> +		case 13:
> +			cfg.block_list_file = optarg;
> +			break;
>  #endif
>  		case 'C':
>  			i = strtoull(optarg, &endptr, 0);
> @@ -541,6 +550,11 @@ int main(int argc, char **argv)
>  		erofs_err("failed to load fs config %s", cfg.fs_config_file);
>  		return 1;
>  	}
> +
> +	if (cfg.block_list_file && block_list_fopen() < 0) {
> +		erofs_err("failed to open %s", cfg.block_list_file);
> +		return 1;
> +	}
>  #endif
>  
>  	erofs_show_config();
> @@ -607,6 +621,9 @@ int main(int argc, char **argv)
>  		err = erofs_mkfs_superblock_csum_set();
>  exit:
>  	z_erofs_compress_exit();
> +#ifdef WITH_ANDROID
> +	block_list_fclose();
> +#endif
>  	dev_close();
>  	erofs_cleanup_exclude_rules();
>  	erofs_exit_configure();
> -- 
> 1.9.1
