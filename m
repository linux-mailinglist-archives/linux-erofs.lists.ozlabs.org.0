Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 443C244D3FB
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Nov 2021 10:22:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hqbps1LC3z2yPW
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Nov 2021 20:22:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=apF7+/Dz;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e;
 helo=mail-pl1-x62e.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=apF7+/Dz; dkim-atps=neutral
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hqbpj3Tlxz2xYD
 for <linux-erofs@lists.ozlabs.org>; Thu, 11 Nov 2021 20:22:35 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id p18so5233149plf.13
 for <linux-erofs@lists.ozlabs.org>; Thu, 11 Nov 2021 01:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QPphVD/MwZRPiazJNxT7XRnDmFIumKcOFaU+WVUpphg=;
 b=apF7+/Dzw6X2EATiVD0cbXDWJqGRClzd4su3oLavp7N/WDXeJnh53AN2n8XjIcBYC1
 qIBVUX+4MiGBNTA3eI7VnYF7/CBjPcsVTtqRGbFlnFNZ5/6qVYcncMrDHbMAV4AxPefk
 W2W3ZNlbd9rJSeBVjokdkE6jvqkHXxGqoM8xLVN2v4jMCjPmWqyc9PKWFdxyjRxTXnI9
 LJc6jrCHpJ7m8Nb5TWKQNYWqs7mQkMsBVcYPL282YaJUIPmb+0VgoxO5p9J/xpZKFXMM
 29/wlmLR8H9qm+VlOsRHG7hEGN1Jd1lwWFJjC0uQzDX87CgWPHEViqPoYGcRNAk/0e27
 AVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QPphVD/MwZRPiazJNxT7XRnDmFIumKcOFaU+WVUpphg=;
 b=aoOozpvh3x5dwnd85s9nlA8DtLqDHIIZJRx9ep8p7yWvlPHlL+dm0wC2wj8L9Q89r7
 LpUUAVYo7Z+lgt/Sd9nsHJpY7wsNhcHg/pm5u4JfafYXK3vhFMnb1PREP88rFbiA6jSD
 V2kMaHUbpLZiSowJpSb8XizlXJqqCOKVJ7hTdKsEk75cJk4mHj1eXUa6S5GSxHtmp0lm
 lCAOHfgzX8S67Jyy7IX7eo7bJcRWJUNNJ//ICVoog6Y0pNVJXqReTnl9rv0R21QQR8aB
 vi2lilAcchBoXU9ST/jOTZmsMLkFDgVshUYl2UpjcUZxNcxBmbcH44RMdIBzj4KB5hGs
 Lr4Q==
X-Gm-Message-State: AOAM531+tXiH3/ROIRz5ut3KSOZDiK5WNmECWWNGhR9RGqtKRm2RlI2f
 t6Zh0U573NRgIZLUuv1zy5Q=
X-Google-Smtp-Source: ABdhPJzt9NFvogprG8abHtPybHA6rRKsucZz8c/fV/g31UibU3iIPLvIGDRZkOTU6ZFvYfW93lWuDA==
X-Received: by 2002:a17:90b:4b04:: with SMTP id
 lx4mr6753406pjb.11.1636622553101; 
 Thu, 11 Nov 2021 01:22:33 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id nn4sm1843512pjb.38.2021.11.11.01.22.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 11 Nov 2021 01:22:32 -0800 (PST)
Date: Thu, 11 Nov 2021 17:20:42 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: mkfs: add block list support for chunked
 files
Message-ID: <20211111172042.00000ac6.zbestahu@gmail.com>
In-Reply-To: <YYy1Yr1cudpnqqfh@B-P7TQMD6M-0146.local>
References: <20211111053031.4002774-1-dvander@google.com>
 <YYy1Yr1cudpnqqfh@B-P7TQMD6M-0146.local>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On Thu, 11 Nov 2021 14:17:06 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi David,
> 
> On Thu, Nov 11, 2021 at 05:30:31AM +0000, David Anderson via Linux-erofs wrote:
> > When using the --block-list-file option, add block mapping lines for
> > chunked files. The extent printing code has been slightly refactored to
> > accommodate multiple extent ranges.
> > 
> > Signed-off-by: David Anderson <dvander@google.com>  
> 
> Thanks for the patch. Currently. I don't have Android environment at hand.
> 
> Hi Yue and Jianan,
> Could you help check this patch in your environments as well and add
> "Tested-by:" tags on this? Many thanks!

This patch has no impact for block mapping without --chunksize in build.

Tested-by: Yue Hu <huyue2@yulong.com>

Thanks.

> 
> Thanks,
> Gao Xiang
> 
> > ---
> >  include/erofs/block_list.h |  7 +++++++
> >  lib/blobchunk.c            | 27 ++++++++++++++++++++++++-
> >  lib/block_list.c           | 41 +++++++++++++++++++++++++++++---------
> >  3 files changed, 65 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
> > index dcc0e50..40df228 100644
> > --- a/include/erofs/block_list.h
> > +++ b/include/erofs/block_list.h
> > @@ -15,11 +15,18 @@ void erofs_droid_blocklist_write(struct erofs_inode *inode,
> >  				 erofs_blk_t blk_start, erofs_blk_t nblocks);
> >  void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
> >  					  erofs_blk_t blkaddr);
> > +void erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
> > +					erofs_blk_t blk_start, erofs_blk_t nblocks,
> > +					bool first_extent, bool last_extent);
> >  #else
> >  static inline void erofs_droid_blocklist_write(struct erofs_inode *inode,
> >  				 erofs_blk_t blk_start, erofs_blk_t nblocks) {}
> >  static inline void
> >  erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
> >  					  erofs_blk_t blkaddr) {}
> > +static inline void
> > +erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
> > +				   erofs_blk_t blk_start, erofs_blk_t nblocks,
> > +				   bool first_extent, bool last_extent) {}
> >  #endif
> >  #endif
> > diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> > index 661c5d0..a2e62be 100644
> > --- a/lib/blobchunk.c
> > +++ b/lib/blobchunk.c
> > @@ -7,6 +7,7 @@
> >  #define _GNU_SOURCE
> >  #include "erofs/hashmap.h"
> >  #include "erofs/blobchunk.h"
> > +#include "erofs/block_list.h"
> >  #include "erofs/cache.h"
> >  #include "erofs/io.h"
> >  #include <unistd.h>
> > @@ -101,7 +102,10 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
> >  				   erofs_off_t off)
> >  {
> >  	struct erofs_inode_chunk_index idx = {0};
> > -	unsigned int dst, src, unit;
> > +	erofs_blk_t extent_start = EROFS_NULL_ADDR;
> > +	erofs_blk_t extent_end = EROFS_NULL_ADDR;
> > +	unsigned int dst, src, unit, num_extents;
> > +	bool first_extent = true;
> >  
> >  	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
> >  		unit = sizeof(struct erofs_inode_chunk_index);
> > @@ -115,6 +119,20 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
> >  		chunk = *(void **)(inode->chunkindexes + src);
> >  
> >  		idx.blkaddr = chunk->blkaddr + remapped_base;
> > +		if (extent_start != EROFS_NULL_ADDR &&
> > +		    idx.blkaddr == extent_end + 1) {
> > +			extent_end = idx.blkaddr;
> > +		} else {
> > +			if (extent_start != EROFS_NULL_ADDR) {
> > +				erofs_droid_blocklist_write_extent(inode,
> > +					extent_start,
> > +					(extent_end - extent_start) + 1,
> > +					first_extent, false);
> > +				first_extent = false;
> > +			}
> > +			extent_start = idx.blkaddr;
> > +			extent_end = idx.blkaddr;
> > +		}
> >  		if (unit == EROFS_BLOCK_MAP_ENTRY_SIZE)
> >  			memcpy(inode->chunkindexes + dst, &idx.blkaddr, unit);
> >  		else
> > @@ -122,6 +140,13 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
> >  	}
> >  	off = roundup(off, unit);
> >  
> > +	if (extent_start == EROFS_NULL_ADDR)
> > +		num_extents = 0;
> > +	else
> > +		num_extents = (extent_end - extent_start) + 1;
> > +	erofs_droid_blocklist_write_extent(inode, extent_start, num_extents,
> > +		first_extent, true);
> > +
> >  	return dev_write(inode->chunkindexes, off, inode->extent_isize);
> >  }
> >  
> > diff --git a/lib/block_list.c b/lib/block_list.c
> > index 096dc9b..87609a9 100644
> > --- a/lib/block_list.c
> > +++ b/lib/block_list.c
> > @@ -32,25 +32,48 @@ void erofs_droid_blocklist_fclose(void)
> >  }
> >  
> >  static void blocklist_write(const char *path, erofs_blk_t blk_start,
> > -			    erofs_blk_t nblocks, bool has_tail)
> > +			    erofs_blk_t nblocks, bool first_extent,
> > +			    bool last_extent)
> >  {
> >  	const char *fspath = erofs_fspath(path);
> >  
> > -	fprintf(block_list_fp, "/%s", cfg.mount_point);
> > +	if (first_extent) {
> > +		fprintf(block_list_fp, "/%s", cfg.mount_point);
> >  
> > -	if (fspath[0] != '/')
> > -		fprintf(block_list_fp, "/");
> > +		if (fspath[0] != '/')
> > +			fprintf(block_list_fp, "/");
> > +
> > +		fprintf(block_list_fp, "%s", fspath);
> > +	}
> >  
> >  	if (nblocks == 1)
> > -		fprintf(block_list_fp, "%s %u", fspath, blk_start);
> > +		fprintf(block_list_fp, " %u", blk_start);
> >  	else
> > -		fprintf(block_list_fp, "%s %u-%u", fspath, blk_start,
> > +		fprintf(block_list_fp, " %u-%u", blk_start,
> >  			blk_start + nblocks - 1);
> >  
> > -	if (!has_tail)
> > +	if (last_extent)
> >  		fprintf(block_list_fp, "\n");
> >  }
> >  
> > +void erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
> > +					erofs_blk_t blk_start,
> > +					erofs_blk_t nblocks, bool first_extent,
> > +					bool last_extent)
> > +{
> > +	if (!block_list_fp || !cfg.mount_point)
> > +		return;
> > +
> > +	if (!nblocks) {
> > +		if (last_extent)
> > +			fprintf(block_list_fp, "\n");
> > +		return;
> > +	}
> > +
> > +	blocklist_write(inode->i_srcpath, blk_start, nblocks, first_extent,
> > +			last_extent);
> > +}
> > +
> >  void erofs_droid_blocklist_write(struct erofs_inode *inode,
> >  				 erofs_blk_t blk_start, erofs_blk_t nblocks)
> >  {
> > @@ -58,7 +81,7 @@ void erofs_droid_blocklist_write(struct erofs_inode *inode,
> >  		return;
> >  
> >  	blocklist_write(inode->i_srcpath, blk_start, nblocks,
> > -			!!inode->idata_size);
> > +			true, !inode->idata_size);
> >  }
> >  
> >  void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
> > @@ -80,6 +103,6 @@ void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
> >  		return;
> >  	}
> >  	if (blkaddr != NULL_ADDR)
> > -		blocklist_write(inode->i_srcpath, blkaddr, 1, false);
> > +		blocklist_write(inode->i_srcpath, blkaddr, 1, true, true);
> >  }
> >  #endif
> > -- 
> > 2.34.0.rc0.344.g81b53c2807-goog  

