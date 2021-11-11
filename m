Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF3B44D1E1
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Nov 2021 07:17:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HqWjC1Frjz2yPT
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Nov 2021 17:17:35 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HqWj66jS1z2xDw
 for <linux-erofs@lists.ozlabs.org>; Thu, 11 Nov 2021 17:17:27 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0Uw-mj4D_1636611427; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uw-mj4D_1636611427) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 11 Nov 2021 14:17:08 +0800
Date: Thu, 11 Nov 2021 14:17:06 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: David Anderson <dvander@google.com>,
 Huang Jianan <huangjianan@oppo.com>, Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: add block list support for chunked
 files
Message-ID: <YYy1Yr1cudpnqqfh@B-P7TQMD6M-0146.local>
References: <20211111053031.4002774-1-dvander@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211111053031.4002774-1-dvander@google.com>
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

Hi David,

On Thu, Nov 11, 2021 at 05:30:31AM +0000, David Anderson via Linux-erofs wrote:
> When using the --block-list-file option, add block mapping lines for
> chunked files. The extent printing code has been slightly refactored to
> accommodate multiple extent ranges.
> 
> Signed-off-by: David Anderson <dvander@google.com>

Thanks for the patch. Currently. I don't have Android environment at hand.

Hi Yue and Jianan,
Could you help check this patch in your environments as well and add
"Tested-by:" tags on this? Many thanks!

Thanks,
Gao Xiang

> ---
>  include/erofs/block_list.h |  7 +++++++
>  lib/blobchunk.c            | 27 ++++++++++++++++++++++++-
>  lib/block_list.c           | 41 +++++++++++++++++++++++++++++---------
>  3 files changed, 65 insertions(+), 10 deletions(-)
> 
> diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
> index dcc0e50..40df228 100644
> --- a/include/erofs/block_list.h
> +++ b/include/erofs/block_list.h
> @@ -15,11 +15,18 @@ void erofs_droid_blocklist_write(struct erofs_inode *inode,
>  				 erofs_blk_t blk_start, erofs_blk_t nblocks);
>  void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
>  					  erofs_blk_t blkaddr);
> +void erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
> +					erofs_blk_t blk_start, erofs_blk_t nblocks,
> +					bool first_extent, bool last_extent);
>  #else
>  static inline void erofs_droid_blocklist_write(struct erofs_inode *inode,
>  				 erofs_blk_t blk_start, erofs_blk_t nblocks) {}
>  static inline void
>  erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
>  					  erofs_blk_t blkaddr) {}
> +static inline void
> +erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
> +				   erofs_blk_t blk_start, erofs_blk_t nblocks,
> +				   bool first_extent, bool last_extent) {}
>  #endif
>  #endif
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index 661c5d0..a2e62be 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -7,6 +7,7 @@
>  #define _GNU_SOURCE
>  #include "erofs/hashmap.h"
>  #include "erofs/blobchunk.h"
> +#include "erofs/block_list.h"
>  #include "erofs/cache.h"
>  #include "erofs/io.h"
>  #include <unistd.h>
> @@ -101,7 +102,10 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
>  				   erofs_off_t off)
>  {
>  	struct erofs_inode_chunk_index idx = {0};
> -	unsigned int dst, src, unit;
> +	erofs_blk_t extent_start = EROFS_NULL_ADDR;
> +	erofs_blk_t extent_end = EROFS_NULL_ADDR;
> +	unsigned int dst, src, unit, num_extents;
> +	bool first_extent = true;
>  
>  	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
>  		unit = sizeof(struct erofs_inode_chunk_index);
> @@ -115,6 +119,20 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
>  		chunk = *(void **)(inode->chunkindexes + src);
>  
>  		idx.blkaddr = chunk->blkaddr + remapped_base;
> +		if (extent_start != EROFS_NULL_ADDR &&
> +		    idx.blkaddr == extent_end + 1) {
> +			extent_end = idx.blkaddr;
> +		} else {
> +			if (extent_start != EROFS_NULL_ADDR) {
> +				erofs_droid_blocklist_write_extent(inode,
> +					extent_start,
> +					(extent_end - extent_start) + 1,
> +					first_extent, false);
> +				first_extent = false;
> +			}
> +			extent_start = idx.blkaddr;
> +			extent_end = idx.blkaddr;
> +		}
>  		if (unit == EROFS_BLOCK_MAP_ENTRY_SIZE)
>  			memcpy(inode->chunkindexes + dst, &idx.blkaddr, unit);
>  		else
> @@ -122,6 +140,13 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
>  	}
>  	off = roundup(off, unit);
>  
> +	if (extent_start == EROFS_NULL_ADDR)
> +		num_extents = 0;
> +	else
> +		num_extents = (extent_end - extent_start) + 1;
> +	erofs_droid_blocklist_write_extent(inode, extent_start, num_extents,
> +		first_extent, true);
> +
>  	return dev_write(inode->chunkindexes, off, inode->extent_isize);
>  }
>  
> diff --git a/lib/block_list.c b/lib/block_list.c
> index 096dc9b..87609a9 100644
> --- a/lib/block_list.c
> +++ b/lib/block_list.c
> @@ -32,25 +32,48 @@ void erofs_droid_blocklist_fclose(void)
>  }
>  
>  static void blocklist_write(const char *path, erofs_blk_t blk_start,
> -			    erofs_blk_t nblocks, bool has_tail)
> +			    erofs_blk_t nblocks, bool first_extent,
> +			    bool last_extent)
>  {
>  	const char *fspath = erofs_fspath(path);
>  
> -	fprintf(block_list_fp, "/%s", cfg.mount_point);
> +	if (first_extent) {
> +		fprintf(block_list_fp, "/%s", cfg.mount_point);
>  
> -	if (fspath[0] != '/')
> -		fprintf(block_list_fp, "/");
> +		if (fspath[0] != '/')
> +			fprintf(block_list_fp, "/");
> +
> +		fprintf(block_list_fp, "%s", fspath);
> +	}
>  
>  	if (nblocks == 1)
> -		fprintf(block_list_fp, "%s %u", fspath, blk_start);
> +		fprintf(block_list_fp, " %u", blk_start);
>  	else
> -		fprintf(block_list_fp, "%s %u-%u", fspath, blk_start,
> +		fprintf(block_list_fp, " %u-%u", blk_start,
>  			blk_start + nblocks - 1);
>  
> -	if (!has_tail)
> +	if (last_extent)
>  		fprintf(block_list_fp, "\n");
>  }
>  
> +void erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
> +					erofs_blk_t blk_start,
> +					erofs_blk_t nblocks, bool first_extent,
> +					bool last_extent)
> +{
> +	if (!block_list_fp || !cfg.mount_point)
> +		return;
> +
> +	if (!nblocks) {
> +		if (last_extent)
> +			fprintf(block_list_fp, "\n");
> +		return;
> +	}
> +
> +	blocklist_write(inode->i_srcpath, blk_start, nblocks, first_extent,
> +			last_extent);
> +}
> +
>  void erofs_droid_blocklist_write(struct erofs_inode *inode,
>  				 erofs_blk_t blk_start, erofs_blk_t nblocks)
>  {
> @@ -58,7 +81,7 @@ void erofs_droid_blocklist_write(struct erofs_inode *inode,
>  		return;
>  
>  	blocklist_write(inode->i_srcpath, blk_start, nblocks,
> -			!!inode->idata_size);
> +			true, !inode->idata_size);
>  }
>  
>  void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
> @@ -80,6 +103,6 @@ void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
>  		return;
>  	}
>  	if (blkaddr != NULL_ADDR)
> -		blocklist_write(inode->i_srcpath, blkaddr, 1, false);
> +		blocklist_write(inode->i_srcpath, blkaddr, 1, true, true);
>  }
>  #endif
> -- 
> 2.34.0.rc0.344.g81b53c2807-goog
