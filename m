Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1A93B25FA
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Jun 2021 06:03:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G9RMM10cBz3069
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Jun 2021 14:03:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1624507423;
	bh=KOdHs2rd4ZW1WrPf8UBpMPMF2vUIj1lUQwj8VIzMuZA=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=gazsVh2cGGMFI4qAWOMDNc5DAxEU1cizmJ3vzKJ87MDdnlnKl4bwyet4I+d2mtIHc
	 cHLvALx8vL4UskquLDWFvWwH2et4szTrnhxJH4dDy8VNgn0z9w5rLZlw6v2njCTY9q
	 Aca7Qv8pZBW/6GiAOpWZo+PJtoQWrSwx4hHgKa72IsFOk5h3wRhJA2bOeMGG2RWO4J
	 tw7fVGzq+S4P3kUxM4EdXn1WXfsJCPqvbWSI80HhUvdlMIijIA735eB9qtg96JTTHx
	 MOZ7hIhPdL/npF+OufKCtbuLE7zk3z2Ebd0jCPVTiulKwywohtGsHhI8P3EAFWWlGR
	 OcdfRAU5sTqJQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.29;
 helo=out30-29.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=WyzzUE1G; dkim-atps=neutral
X-Greylist: delayed 304 seconds by postgrey-1.36 at boromir;
 Thu, 24 Jun 2021 14:03:38 AEST
Received: from out30-29.freemail.mail.aliyun.com
 (out30-29.freemail.mail.aliyun.com [115.124.30.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G9RMG0G6hz302c
 for <linux-erofs@lists.ozlabs.org>; Thu, 24 Jun 2021 14:03:37 +1000 (AEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07357798|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.00119164-5.0753e-05-0.998758;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04395; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=6; RT=6; SR=0; TI=SMTPD_---0UdTs8R._1624507095; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UdTs8R._1624507095) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Jun 2021 11:58:17 +0800
Subject: Re: [PATCH] AOSP: erofs-utils: add block list support
To: Yue Hu <zbestahu@gmail.com>, linux-erofs@lists.ozlabs.org, xiang@kernel.org
References: <20210622030232.1176-1-zbestahu@gmail.com>
Message-ID: <258e86ca-c9f4-0df1-8af9-6fd445bd4982@aliyun.com>
Date: Wed, 23 Jun 2021 23:58:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210622030232.1176-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
From: Li Guifu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li Guifu <bluce.lee@aliyun.com>
Cc: huyue2@yulong.com, zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hu Yue

   Thanks to your contribution.
   Base test shows it could record block map list correctly.
   Some codes need be refactored for further ahead.

On 6/21/21 11:02 PM, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Android update engine will treat EROFS filesystem image as one single
> file. Let's add block list support to optimize OTA size.
> 
> Change-Id: I21d6177dff0ee65d3c57023b102e991d40873f0d
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>   include/erofs/block_list.h | 19 ++++++++++
>   include/erofs/config.h     |  1 +
>   lib/block_list.c           | 86 ++++++++++++++++++++++++++++++++++++++++++++++
>   lib/compress.c             |  8 +++++
>   lib/inode.c                | 21 ++++++++++-
>   mkfs/main.c                | 17 +++++++++
>   6 files changed, 151 insertions(+), 1 deletion(-)
>   create mode 100644 include/erofs/block_list.h
>   create mode 100644 lib/block_list.c

step1:
     block_list.c/h are new file, please add them to lib/Makefile.am or 
it will not be built.
     You would also add a Android.mk/bp for android target build

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
>   	char *mount_point;
>   	char *target_out_path;
>   	char *fs_config_file;
> +	char *block_list_file;
>   #endif
>   };
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
step2:
	The return code would be replace with errno please.
	So further error message could be showed up.
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
step3:
	if (!block_list_fp || !cfg.mount_point)
	These codes are double checked at write_block_list() function.
	Could you do a further optimize ?

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
step4:
	write_block_list_tail_end() has much if-condition nesting,
	It could return early at the begin of it.
	

> +#endif
> diff --git a/lib/compress.c b/lib/compress.c
> index 2093bfd..5dec0c3 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -19,6 +19,10 @@
>   #include "erofs/compress.h"
>   #include "compressor.h"
>   
> +#ifdef WITH_ANDROID
> +#include "erofs/block_list.h"
> +#endif
> +
>   static struct erofs_compress compresshandle;
>   static int compressionlevel;
>   
> @@ -553,6 +557,10 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
>   		   inode->i_srcpath, (unsigned long long)inode->i_size,
>   		   compressed_blocks);
>   
> +#ifdef WITH_ANDROID
> +	write_block_list(inode->i_srcpath, blkaddr, compressed_blocks, false);
> +#endif
> +
>   	/*
>   	 * TODO: need to move erofs_bdrop to erofs_write_tail_end
>   	 *       when both mkfs & kernel support compression inline.
> diff --git a/lib/inode.c b/lib/inode.c
> index 787e5b4..6be23cb 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -22,6 +22,10 @@
>   #include "erofs/xattr.h"
>   #include "erofs/exclude.h"
>   
> +#ifdef WITH_ANDROID
> +#include "erofs/block_list.h"
> +#endif
> +
>   #define S_SHIFT                 12
>   static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
>   	[S_IFREG >> S_SHIFT]  = EROFS_FT_REG_FILE,
> @@ -369,6 +373,12 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
>   			return -EIO;
>   		}
>   	}
> +
> +#ifdef WITH_ANDROID
> +	if (nblocks)
> +		write_block_list(inode->i_srcpath, inode->u.i_blkaddr,
> +				 nblocks, inode->idata_size ? true : false);
> +#endif
>   	return 0;
>   }
>   
> @@ -626,6 +636,7 @@ static struct erofs_bhops erofs_write_inline_bhops = {
>   int erofs_write_tail_end(struct erofs_inode *inode)
>   {
>   	struct erofs_buffer_head *bh, *ibh;
> +	erofs_off_t pos;
>   
>   	bh = inode->bh_data;
>   
> @@ -640,7 +651,6 @@ int erofs_write_tail_end(struct erofs_inode *inode)
>   		ibh->op = &erofs_write_inline_bhops;
>   	} else {
>   		int ret;
> -		erofs_off_t pos;
>   
>   		erofs_mapbh(bh->block);
>   		pos = erofs_btell(bh, true) - EROFS_BLKSIZ;
> @@ -658,6 +668,15 @@ int erofs_write_tail_end(struct erofs_inode *inode)
>   		free(inode->idata);
>   		inode->idata = NULL;
>   	}
> +
> +#ifdef WITH_ANDROID
> +	if (!S_ISDIR(inode->i_mode) && !S_ISLNK(inode->i_mode))
> +		write_block_list_tail_end(inode->i_srcpath,
> +					  inode->i_size / EROFS_BLKSIZ,
> +					  inode->bh_inline ? true: false,
> +					  erofs_blknr(pos));
step5:
	inode->i_size / EROFS_BLKSIZ,
	It could be replace with erofs_blknr() just like pos.
	The *pos* here would cause build errorly with message,
	"./include/erofs/internal.h:55:41: error: ‘pos’ may be used 
uninitialized in this function [-Werror=maybe-uninitialized]"
> +#endif
> +
>   out:
>   	/* now bh_data can drop directly */
>   	if (bh) {
> diff --git a/mkfs/main.c b/mkfs/main.c
> index e476189..d5a5e07 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -27,6 +27,10 @@
>   #include <uuid.h>
>   #endif
>   
> +#ifdef WITH_ANDROID
> +#include "erofs/block_list.h"
> +#endif
> +
>   #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
>   
>   static struct option long_options[] = {
> @@ -47,6 +51,7 @@ static struct option long_options[] = {
>   	{"mount-point", required_argument, NULL, 10},
>   	{"product-out", required_argument, NULL, 11},
>   	{"fs-config-file", required_argument, NULL, 12},
> +	{"block-list-file", required_argument, NULL, 13},
>   #endif
>   	{0, 0, 0, 0},
>   };
> @@ -95,6 +100,7 @@ static void usage(void)
>   	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
>   	      " --product-out=X       X=product_out directory\n"
>   	      " --fs-config-file=X    X=fs_config file\n"
> +	      " --block-list-file=X    X=block_list file\n"
>   #endif
>   	      "\nAvailable compressors are: ", stderr);
>   	print_available_compressors(stderr, ", ");
> @@ -293,6 +299,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>   		case 12:
>   			cfg.fs_config_file = optarg;
>   			break;
> +		case 13:
> +			cfg.block_list_file = optarg;
> +			break;
>   #endif
>   		case 'C':
>   			i = strtoull(optarg, &endptr, 0);
> @@ -541,6 +550,11 @@ int main(int argc, char **argv)
>   		erofs_err("failed to load fs config %s", cfg.fs_config_file);
>   		return 1;
>   	}
> +
> +	if (cfg.block_list_file && block_list_fopen() < 0) {
> +		erofs_err("failed to open %s", cfg.block_list_file);
> +		return 1;
> +	}
>   #endif
>   
>   	erofs_show_config();
> @@ -607,6 +621,9 @@ int main(int argc, char **argv)
>   		err = erofs_mkfs_superblock_csum_set();
>   exit:
>   	z_erofs_compress_exit();
> +#ifdef WITH_ANDROID
> +	block_list_fclose();
> +#endif
>   	dev_close();
>   	erofs_cleanup_exclude_rules();
>   	erofs_exit_configure();
> 
