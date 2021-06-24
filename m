Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1A03B270F
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Jun 2021 07:58:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G9TvF1Q6pz2yhF
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Jun 2021 15:58:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=GDjZz68j;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034;
 helo=mail-pj1-x1034.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=GDjZz68j; dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G9Tv61dkqz2yhF
 for <linux-erofs@lists.ozlabs.org>; Thu, 24 Jun 2021 15:57:53 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id k5so2835944pjj.1
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Jun 2021 22:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nvVuJPVsrbkFI2EuyCDqSsio50hcGxYZ9riRZafcUtY=;
 b=GDjZz68jUG0D+l+KQ2/TZZ7WtHXMn6hHWdVL4UhPdmry6hznJWLv9P8qgvJeMr1tuC
 3vuKcugMs2bwSZfh7fwdq3+1Fv0gKrqYnWHhblOALv2hIq5AO+VHyQxtB1tPuBt6XlnJ
 edzYhZwlX2NVRug1TatUm/qCG6tMh64AxqN2ATlOY7IpVhdfcfRGNMBvwtjugYMcLTA+
 9fjvmXHi9njEz85bW2nYmGbP2x7+Q/BZp5gZYFZ6ATckSyNMSx4osS4TQg5J7itaNKYa
 YLcNaLBdXD71cc9mIw5rP7AlNWb4CPNOoyMQMfYAWPxTX/Hnb85Wjpf6i/92g5WwuajZ
 Dekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nvVuJPVsrbkFI2EuyCDqSsio50hcGxYZ9riRZafcUtY=;
 b=hg5wbmv8Cgy5EmYhAxtnkhLBk3Atx/zN/FYV75dr0hkKNyYvy9H4+hiX+D9Ksc7pW2
 5NTkIGZCBlqPj+kX1DDxb06E2jKm34TtsHmJvL7vv1Ef3KlInWAVn7XpfcdV9cZFvSR4
 feR8H8IYWcB4/na/XxF1GFOpAvVlaCS7kcBhIeZWjoNcrXkv+WAH/fW7pRKgZBxP85oe
 q75fOUP4iMRwvFhEmBadDd+hGHytdd+bw2VZ/022NxRKu0Bh3p7mMPbbnKw2JnV0pobf
 Ea0R80H2PUAcvswdD/fnv5lIA7PLOdTO3tv1Ny+v4NtNCdRhrbH4FoSljuZfi2o24aTb
 RdbQ==
X-Gm-Message-State: AOAM530zKqz1akCN4eyGxdB3DoXSGArS5DlINo3alAAvrN7PYjHagsxE
 6lVeT/1x3tSpXr3TwYlLFZU=
X-Google-Smtp-Source: ABdhPJyd5MZlfuVEzly4Qfl7g4f57Spe6nwHHTNRpNCg3zemhfPzT1/fDmiG8pEZq4xhR+dxZCyHuA==
X-Received: by 2002:a17:902:9b8a:b029:110:56f0:b275 with SMTP id
 y10-20020a1709029b8ab029011056f0b275mr2933031plp.30.1624514267450; 
 Wed, 23 Jun 2021 22:57:47 -0700 (PDT)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id q8sm1550332pfc.51.2021.06.23.22.57.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jun 2021 22:57:47 -0700 (PDT)
Date: Thu, 24 Jun 2021 13:57:51 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] AOSP: erofs-utils: add block list support
Message-ID: <20210624135751.00004f35.zbestahu@gmail.com>
In-Reply-To: <YNQaMausKty/Mv14@B-P7TQMD6M-0146.local>
References: <20210622030232.1176-1-zbestahu@gmail.com>
 <1624469489-40907-1-git-send-email-hsiangkao@linux.alibaba.com>
 <3f562b66-b433-956e-fa4a-b4586aa4fc61@aliyun.com>
 <YNQaMausKty/Mv14@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: yh@oppo.com, Yue Hu <huyue2@yulong.com>, zhangwen@yulong.com,
 Weichao Guo <guoweichao@oppo.com>, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 24 Jun 2021 13:37:53 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Thu, Jun 24, 2021 at 01:23:25AM -0400, Li Guifu wrote:
> > Gao Xiang
> > 	There are three condition need to be fixed.
> > 	The whole inline file should not be printed anything even *\n*  
> 
> Yes.
> 
> > 	The last inline block should add *\n* to trigger a new line  
> 
> doesn't it?
> 
> > 	The last block and not inline should be print independently  
> 
> Could you give some output example of this?
> 
> btw, do you also have some idea or help fix/improve this patch?

Gao Xiang,

I'm improving the patch based on v2 and some suggestions from Guifu.
Of course, i will test it firstly then send it out.

Thanks.

> I'd like to merge it asap if it gets into shape but I don't have
> aosp environment at hand.
> 
> > 	
> > 
> > On 6/23/21 1:31 PM, Gao Xiang wrote:  
> > > From: Yue Hu <huyue2@yulong.com>
> > > 
> > > Android update engine will treat EROFS filesystem image as one single
> > > file. Let's add block list support to optimize OTA size.
> > > 
> > > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > > Signed-off-by: Gao Xiang <xiang@kernel.org>
> > > ---
> > > some cleanups.
> > > 
> > > Hi all,
> > > please kindly check it again if it works since I dont have such
> > > environment. If it doesn't work, please help fix it..
> > > 
> > > Thanks,
> > > Gao Xiang
> > > 
> > >   include/erofs/block_list.h | 27 +++++++++++++++
> > >   include/erofs/config.h     |  1 +
> > >   lib/block_list.c           | 86 ++++++++++++++++++++++++++++++++++++++++++++++
> > >   lib/compress.c             |  2 ++
> > >   lib/inode.c                |  6 ++++
> > >   mkfs/main.c                | 14 ++++++++
> > >   6 files changed, 136 insertions(+)
> > >   create mode 100644 include/erofs/block_list.h
> > >   create mode 100644 lib/block_list.c
> > > 
> > > diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
> > > new file mode 100644
> > > index 000000000000..7756d8a5784c
> > > --- /dev/null
> > > +++ b/include/erofs/block_list.h
> > > @@ -0,0 +1,27 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * erofs-utils/include/erofs/block_list.h
> > > + *
> > > + * Copyright (C), 2021, Coolpad Group Limited.
> > > + * Created by Yue Hu <huyue2@yulong.com>
> > > + */
> > > +#ifndef __EROFS_BLOCK_LIST_H
> > > +#define __EROFS_BLOCK_LIST_H
> > > +
> > > +#include "internal.h"
> > > +
> > > +#ifdef WITH_ANDROID
> > > +int erofs_droid_blocklist_fopen(void);
> > > +void erofs_droid_blocklist_fclose(void);
> > > +void erofs_droid_blocklist_write(struct erofs_inode *inode,
> > > +				 erofs_blk_t blk_start, erofs_blk_t nblocks);
> > > +void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
> > > +					  erofs_blk_t blkaddr);
> > > +#else
> > > +static inline void erofs_droid_blocklist_write(struct erofs_inode *inode,
> > > +				 erofs_blk_t blk_start, erofs_blk_t nblocks) {}
> > > +static inline
> > > +void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
> > > +					  erofs_blk_t blkaddr) {}
> > > +#endif
> > > +#endif
> > > diff --git a/include/erofs/config.h b/include/erofs/config.h
> > > index d140a735bd49..67e7a0fed24c 100644
> > > --- a/include/erofs/config.h
> > > +++ b/include/erofs/config.h
> > > @@ -65,6 +65,7 @@ struct erofs_configure {
> > >   	char *mount_point;
> > >   	char *target_out_path;
> > >   	char *fs_config_file;
> > > +	char *block_list_file;
> > >   #endif
> > >   };
> > > diff --git a/lib/block_list.c b/lib/block_list.c
> > > new file mode 100644
> > > index 000000000000..ffe780e91900
> > > --- /dev/null
> > > +++ b/lib/block_list.c
> > > @@ -0,0 +1,86 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * erofs-utils/lib/block_list.c
> > > + *
> > > + * Copyright (C), 2021, Coolpad Group Limited.
> > > + * Created by Yue Hu <huyue2@yulong.com>
> > > + */
> > > +#ifdef WITH_ANDROID
> > > +#include <stdio.h>
> > > +#include <sys/stat.h>
> > > +#include "erofs/block_list.h"
> > > +
> > > +#define pr_fmt(fmt) "EROFS block_list: " FUNC_LINE_FMT fmt "\n"
> > > +#include "erofs/print.h"
> > > +
> > > +static FILE *block_list_fp = NULL;
> > > +
> > > +int erofs_droid_blocklist_fopen(void)
> > > +{
> > > +	if (block_list_fp)
> > > +		return 0;
> > > +
> > > +	block_list_fp = fopen(cfg.block_list_file, "w");
> > > +
> > > +	if (!block_list_fp)
> > > +		return -1;
> > > +	return 0;
> > > +}
> > > +
> > > +void erofs_droid_blocklist_fclose(void)
> > > +{
> > > +	if (!block_list_fp)
> > > +		return;
> > > +
> > > +	fclose(block_list_fp);
> > > +	block_list_fp = NULL;
> > > +}
> > > +
> > > +static void blocklist_write(const char *path, erofs_blk_t blk_start,
> > > +			    erofs_blk_t nblocks, bool has_tail)
> > > +{
> > > +	const char *fspath = erofs_fspath(path);
> > > +
> > > +	fprintf(block_list_fp, "/%s", cfg.mount_point);
> > > +
> > > +	if (fspath[0] != '/')
> > > +		fprintf(block_list_fp, "/");
> > > +
> > > +	if (nblocks == 1)
> > > +		fprintf(block_list_fp, "%s %u", fspath, blk_start);
> > > +	else if (nblocks > 1)
> > > +		fprintf(block_list_fp, "%s %u-%u", fspath, blk_start,
> > > +			blk_start + nblocks - 1);
> > > +	else
> > > +		fprintf(block_list_fp, "%s", fspath);
> > > +
> > > +	if (!has_tail)
> > > +		fprintf(block_list_fp, "\n");
> > > +}
> > > +
> > > +void erofs_droid_blocklist_write(struct erofs_inode *inode,
> > > +				 erofs_blk_t blk_start, erofs_blk_t nblocks)
> > > +{
> > > +	if (!block_list_fp || !cfg.mount_point)
> > > +		return;
> > > +
> > > +	blocklist_write(inode->i_srcpath, blk_start, nblocks,
> > > +			!!inode->idata_size);
> > > +}
> > > +
> > > +void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
> > > +					  erofs_blk_t blkaddr)
> > > +{
> > > +	if (!block_list_fp || !cfg.mount_point)
> > > +		return;
> > > +
> > > +	/* XXX: a bit hacky.. may need a better approach */
> > > +	if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
> > > +		return;
> > > +
> > > +	if (blkaddr != NULL_ADDR)
> > > +		fprintf(block_list_fp, " %u\n", blkaddr);
> > > +	else
> > > +		fprintf(block_list_fp, "\n");
> > > +}  
> > void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
> > 					  erofs_blk_t blkaddr)
> > {
> > 	if (!block_list_fp || !cfg.mount_point)
> > 		return;
> > 
> > 	/* XXX: a bit hacky.. may need a better approach */
> > 	if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
> > 		return;
> > 
> > 	if (erofs_blknr(inode->i_size)) { // its block list has been output before
> > 		if (blkaddr == NULL_ADDR)
> > 			fprintf(block_list_fp, "\n");
> > 		else
> > 			fprintf(block_list_fp, " %u\n", blkaddr);
> > 		return;
> > 	}
> > 	if (blkaddr != NULL_ADDR)
> > 		blocklist_write(inode->i_srcpath, blkaddr, 1, false);  
> 
> That still sounds a bit hacky. But if no better idea, we could leave it
> as-is... honestly, I don't quite like this.
> 
> Thanks,
> Gao Xiang
> 
> > }
> > 
> >   
> > > +#endif
> > > diff --git a/lib/compress.c b/lib/compress.c
> > > index 2093bfd68b71..af0c72037281 100644
> > > --- a/lib/compress.c
> > > +++ b/lib/compress.c
> > > @@ -18,6 +18,7 @@
> > >   #include "erofs/cache.h"
> > >   #include "erofs/compress.h"
> > >   #include "compressor.h"
> > > +#include "erofs/block_list.h"
> > >   static struct erofs_compress compresshandle;
> > >   static int compressionlevel;
> > > @@ -571,6 +572,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
> > >   		DBG_BUGON(ret);
> > >   	}
> > >   	inode->compressmeta = compressmeta;
> > > +	erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
> > >   	return 0;
> > >   err_bdrop:
> > > diff --git a/lib/inode.c b/lib/inode.c
> > > index 787e5b4485a2..4134f8a0e91b 100644
> > > --- a/lib/inode.c
> > > +++ b/lib/inode.c
> > > @@ -21,6 +21,7 @@
> > >   #include "erofs/compress.h"
> > >   #include "erofs/xattr.h"
> > >   #include "erofs/exclude.h"
> > > +#include "erofs/block_list.h"
> > >   #define S_SHIFT                 12
> > >   static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
> > > @@ -369,6 +370,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
> > >   			return -EIO;
> > >   		}
> > >   	}
> > > +	erofs_droid_blocklist_write(inode, inode->u.i_blkaddr, nblocks);
> > >   	return 0;
> > >   }
> > > @@ -638,6 +640,8 @@ int erofs_write_tail_end(struct erofs_inode *inode)
> > >   		ibh->fsprivate = erofs_igrab(inode);
> > >   		ibh->op = &erofs_write_inline_bhops;
> > > +
> > > +		erofs_droid_blocklist_write_tail_end(inode, NULL_ADDR);
> > >   	} else {
> > >   		int ret;
> > >   		erofs_off_t pos;
> > > @@ -657,6 +661,8 @@ int erofs_write_tail_end(struct erofs_inode *inode)
> > >   		inode->idata_size = 0;
> > >   		free(inode->idata);
> > >   		inode->idata = NULL;
> > > +
> > > +		erofs_droid_blocklist_write_tail_end(inode, erofs_blknr(pos));
> > >   	}
> > >   out:
> > >   	/* now bh_data can drop directly */
> > > diff --git a/mkfs/main.c b/mkfs/main.c
> > > index e476189f0731..28539da5ea5f 100644
> > > --- a/mkfs/main.c
> > > +++ b/mkfs/main.c
> > > @@ -22,6 +22,7 @@
> > >   #include "erofs/compress.h"
> > >   #include "erofs/xattr.h"
> > >   #include "erofs/exclude.h"
> > > +#include "erofs/block_list.h"
> > >   #ifdef HAVE_LIBUUID
> > >   #include <uuid.h>
> > > @@ -47,6 +48,7 @@ static struct option long_options[] = {
> > >   	{"mount-point", required_argument, NULL, 10},
> > >   	{"product-out", required_argument, NULL, 11},
> > >   	{"fs-config-file", required_argument, NULL, 12},
> > > +	{"block-list-file", required_argument, NULL, 13},
> > >   #endif
> > >   	{0, 0, 0, 0},
> > >   };
> > > @@ -95,6 +97,7 @@ static void usage(void)
> > >   	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
> > >   	      " --product-out=X       X=product_out directory\n"
> > >   	      " --fs-config-file=X    X=fs_config file\n"
> > > +	      " --block-list-file=X    X=block_list file\n"
> > >   #endif
> > >   	      "\nAvailable compressors are: ", stderr);
> > >   	print_available_compressors(stderr, ", ");
> > > @@ -293,6 +296,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
> > >   		case 12:
> > >   			cfg.fs_config_file = optarg;
> > >   			break;
> > > +		case 13:
> > > +			cfg.block_list_file = optarg;
> > > +			break;
> > >   #endif
> > >   		case 'C':
> > >   			i = strtoull(optarg, &endptr, 0);
> > > @@ -541,6 +547,11 @@ int main(int argc, char **argv)
> > >   		erofs_err("failed to load fs config %s", cfg.fs_config_file);
> > >   		return 1;
> > >   	}
> > > +
> > > +	if (cfg.block_list_file && erofs_droid_blocklist_fopen() < 0) {
> > > +		erofs_err("failed to open %s", cfg.block_list_file);
> > > +		return 1;
> > > +	}
> > >   #endif
> > >   	erofs_show_config();
> > > @@ -607,6 +618,9 @@ int main(int argc, char **argv)
> > >   		err = erofs_mkfs_superblock_csum_set();
> > >   exit:
> > >   	z_erofs_compress_exit();
> > > +#ifdef WITH_ANDROID
> > > +	erofs_droid_blocklist_fclose();
> > > +#endif
> > >   	dev_close();
> > >   	erofs_cleanup_exclude_rules();
> > >   	erofs_exit_configure();
> > >   

