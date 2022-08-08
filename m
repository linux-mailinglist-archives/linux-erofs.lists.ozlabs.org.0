Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88FE58C329
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Aug 2022 08:13:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M1QqK189Kz2ywr
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Aug 2022 16:13:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M1QqF6YW9z2xHg
	for <linux-erofs@lists.ozlabs.org>; Mon,  8 Aug 2022 16:12:56 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VLe4lZ4_1659939169;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VLe4lZ4_1659939169)
          by smtp.aliyun-inc.com;
          Mon, 08 Aug 2022 14:12:51 +0800
Date: Mon, 8 Aug 2022 14:12:49 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs-utils: use the BLK_ROUND_UP directly
Message-ID: <YvCpYe6prSe83jCC@B-P7TQMD6M-0146.local>
References: <20220808032049.31120-1-huyue2@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220808032049.31120-1-huyue2@coolpad.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Aug 08, 2022 at 11:20:49AM +0800, Yue Hu wrote:
> Just simplify the code.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

LGTM,

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fsck/main.c    | 6 ++----
>  lib/compress.c | 4 ++--
>  lib/data.c     | 2 +-
>  lib/zmap.c     | 2 +-
>  4 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index 8ed3fc5..410e756 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -483,10 +483,8 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
>  	}
>  
>  	if (fsckcfg.print_comp_ratio) {
> -		fsckcfg.logical_blocks +=
> -			DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
> -		fsckcfg.physical_blocks +=
> -			DIV_ROUND_UP(pchunk_len, EROFS_BLKSIZ);
> +		fsckcfg.logical_blocks += BLK_ROUND_UP(inode->i_size);
> +		fsckcfg.physical_blocks += BLK_ROUND_UP(pchunk_len);
>  	}
>  out:
>  	if (raw)
> diff --git a/lib/compress.c b/lib/compress.c
> index ee3b856..4bd0958 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -303,7 +303,7 @@ nocompression:
>  
>  			tailused = ret & (EROFS_BLKSIZ - 1);
>  			padding = 0;
> -			ctx->compressedblks = DIV_ROUND_UP(ret, EROFS_BLKSIZ);
> +			ctx->compressedblks = BLK_ROUND_UP(ret);
>  			DBG_BUGON(ctx->compressedblks * EROFS_BLKSIZ >= count);
>  
>  			/* zero out garbage trailing data for non-0padding */
> @@ -584,7 +584,7 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
>  		u8 *out;
>  
>  		eofs = inode->extent_isize -
> -			(4 << (DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ) & 1));
> +			(4 << (BLK_ROUND_UP(inode->i_size) & 1));
>  		base = round_down(eofs, 8);
>  		pos = 16 /* encodebits */ * ((eofs - base) / 4);
>  		out = inode->compressmeta + base;
> diff --git a/lib/data.c b/lib/data.c
> index 6bc554d..ad7b2cb 100644
> --- a/lib/data.c
> +++ b/lib/data.c
> @@ -22,7 +22,7 @@ static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
>  
>  	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
>  
> -	nblocks = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
> +	nblocks = BLK_ROUND_UP(inode->i_size);
>  	lastblk = nblocks - tailendpacking;
>  
>  	/* there is no hole in flatmode */
> diff --git a/lib/zmap.c b/lib/zmap.c
> index 95745c5..abe0d31 100644
> --- a/lib/zmap.c
> +++ b/lib/zmap.c
> @@ -325,7 +325,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  	const erofs_off_t ebase = round_up(iloc(vi->nid) + vi->inode_isize +
>  					   vi->xattr_isize, 8) +
>  		sizeof(struct z_erofs_map_header);
> -	const unsigned int totalidx = DIV_ROUND_UP(vi->i_size, EROFS_BLKSIZ);
> +	const unsigned int totalidx = BLK_ROUND_UP(vi->i_size);
>  	unsigned int compacted_4b_initial, compacted_2b;
>  	unsigned int amortizedshift;
>  	erofs_off_t pos;
> -- 
> 2.17.1
