Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7138363D11A
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 09:51:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NMXxj1xHgz3bVK
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 19:51:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=MwUmlvq3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=MwUmlvq3;
	dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NMXxd1YTpz2xfS
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Nov 2022 19:51:31 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so1257601pjs.4
        for <linux-erofs@lists.ozlabs.org>; Wed, 30 Nov 2022 00:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmkJmlGPtdkNVnisZ7NmSyEYhonbavhWMMtpsVqAU+Y=;
        b=MwUmlvq3Q6uCYlb8Ha9UD5G/xSqb7bWLxdR2vKkJc2TfLPBTLrbjtzE7BFbvIoo1Xy
         ym6AS0z+tUqtcycKFdgjwdrZN1WXxXr14PNfYzykgRVtQxWDTULf+vAg5ece6ygcKkQm
         +qmB6DaiVMw2WUkOrAHokmTUPGmBqn08AYdcpToEnTY43vqG1suTmpfkplCw4L9YOe+j
         m0t6+bIyXnM5T/SOeSuJcAbqfJUshRGgMK9Es5FF+zKtUmCjqwKssrSIphjS60FxVKAH
         jZet+FkVIyuZTGbr46KP2oB9JXcJLGn9aTPkv7DEo0Q3jbClNuWAAfvhq0iGFTCGck72
         ODmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmkJmlGPtdkNVnisZ7NmSyEYhonbavhWMMtpsVqAU+Y=;
        b=PtU+QG56fUaVc8Qcy5SD3n1iLcwH8+D4pEcZLKz4FrBQEfGi1MRRVcNY0rGLRUde3b
         EvbF6w2TA09CI3DQvwTKs40XIbEhc5j9iKPuL8OZNwqqpXWSLx8DR9pQdo7vUTICzRRa
         1gsFpl0IuII0v8wjbVCb9syThd/rFR1I5oO9GaLlZVb7EIEl+Tx/Met03EQl8LY53UCl
         EVqS2vwtW2R3RxPhu9IrC3JPCLen00UgIv2toLNDI+8ESDFdcvUXdfwM9ZeSdzJKFdo9
         MqBsRY5oaYcoTSievgit6PQU/Bz0QZUCo71D4r8ZxfRKzrWvdMX8h//4bh+D6+c4PYg2
         YYDg==
X-Gm-Message-State: ANoB5plwHIzYEuWdfm6qqjS9E9cEijCRAi2mSN7/QgT1TtO0+Bj/JmQf
	w3eZjg8Vp8vyNQdx85REBiQ=
X-Google-Smtp-Source: AA0mqf5/6wGVdzZSPhqOgFmrb0UzYuEUvTLMEL4TaaE0gD3+NZobTEY+uLMIOTOuWdgB0njaDNA/TA==
X-Received: by 2002:a17:902:cecb:b0:17f:628d:2a8 with SMTP id d11-20020a170902cecb00b0017f628d02a8mr52600434plg.34.1669798285287;
        Wed, 30 Nov 2022 00:51:25 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id jf3-20020a170903268300b00186ac4b21cfsm808537plb.230.2022.11.30.00.51.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Nov 2022 00:51:25 -0800 (PST)
Date: Wed, 30 Nov 2022 16:55:34 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v3] erofs-utils: mkfs: support fragment deduplication
Message-ID: <20221130165534.00004006.zbestahu@gmail.com>
In-Reply-To: <Y4cTKeWowrg9FySM@B-P7TQMD6M-0146.local>
References: <20221129100053.10665-1-zbestahu@gmail.com>
	<Y4cTKeWowrg9FySM@B-P7TQMD6M-0146.local>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zbestahu@163.com, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

Thanks for your comments.

On Wed, 30 Nov 2022 16:24:09 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Tue, Nov 29, 2022 at 06:00:53PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > Previously, there's no fragment deduplication when this feature is
> > introduced. Let's support it now.
> > 
> > With this patch, for Linux 5.10.1 + 5.10.87 source code:
> >   
> 
> Please add EROFS -T0 to retest 32 byte inode results.
> 
> Also add Squashfs + LZ4HC results as a comparison.

Will do it in v4.

> 
> > [before]
> >  32k pcluster + lz4hc,12 + fragment		454M
> >  64k pcluster + lz4hc,12 + fragment		439M
> > 128k pcluster + lz4hc,12 + fragment		431M
> >  32k pcluster + lz4hc,12 + fragment + dedupe	376M
> >  64k pcluster + lz4hc,12 + fragment + dedupe	384M
> > 128k pcluster + lz4hc,12 + fragment + dedupe	399M
> > 
> > [after]
> >  32k pcluster + lz4hc,12 + fragment		316M
> >  64k pcluster + lz4hc,12 + fragment		300M
> > 128k pcluster + lz4hc,12 + fragment		292M
> >  32k pcluster + lz4hc,12 + fragment + dedupe	291M
> >  64k pcluster + lz4hc,12 + fragment + dedupe	286M
> > 128k pcluster + lz4hc,12 + fragment + dedupe	283M
> > 
> > Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---
> > v3: 
> > - modify acrroding to Xiang's comments in v2
> > - simplify the logic in vle_compress_one
> > - fix the crash for 1MB pcluster
> > 
> > v2: mainly improve the logic in compression
> > 
> >  include/erofs/fragments.h |   3 +-
> >  lib/compress.c            | 115 ++++++++++++++++++++----
> >  lib/fragments.c           | 180 +++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 277 insertions(+), 21 deletions(-)
> > 
> > diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
> > index 5444384..6c51fc9 100644
> > --- a/include/erofs/fragments.h
> > +++ b/include/erofs/fragments.h
> > @@ -15,8 +15,9 @@ extern "C"
> >  extern const char *frags_packedname;
> >  #define EROFS_PACKED_INODE	frags_packedname
> >  
> > +int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *crc);
> >  int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
> > -			   unsigned int len);
> > +			   unsigned int len, u32 crc);  
> 
> 						^ tofcrc
> 
> tail of file crc

Nice.

> 
> >  struct erofs_inode *erofs_mkfs_build_fragments(void);
> >  int erofs_fragments_init(void);
> >  void erofs_fragments_exit(void);
> > diff --git a/lib/compress.c b/lib/compress.c
> > index 17b3213..7e01932 100644
> > --- a/lib/compress.c
> > +++ b/lib/compress.c
> > @@ -33,6 +33,10 @@ struct z_erofs_vle_compress_ctx {
> >  	unsigned int head, tail;
> >  	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
> >  	u16 clusterofs;
> > +
> > +	u32 crc;  
> 
> 	tofcrc;
> 
> > +	unsigned int pclustersize;
> > +	erofs_off_t remaining;
> >  };
> >  
> >  #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	\
> > @@ -162,10 +166,10 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
> >  	ctx->clusterofs = clusterofs + count;
> >  }
> >  
> > -static int z_erofs_compress_dedupe(struct erofs_inode *inode,
> > -				   struct z_erofs_vle_compress_ctx *ctx,
> > +static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
> >  				   unsigned int *len)
> >  {
> > +	struct erofs_inode *inode = ctx->inode;
> >  	int ret = 0;
> >  
> >  	do {
> > @@ -319,30 +323,62 @@ static void tryrecompress_trailing(void *in, unsigned int *insize,
> >  	*compressedsize = ret;
> >  }
> >  
> > -static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx,
> > -			    bool final)
> > +static void z_erofs_fragments_dedupe_update(struct z_erofs_vle_compress_ctx *ctx,
> > +					    unsigned int *len)
> > +{
> > +	struct erofs_inode *inode = ctx->inode;
> > +	const unsigned int remaining = ctx->remaining + *len;  
> 
> please rename as "new_fragmentsize" for easy understanding.

Okay.

> 
> > +
> > +	DBG_BUGON(!inode->fragment_size);
> > +
> > +	/* try to close the gap if it gets larger (should be rare) */
> > +	if (inode->fragment_size < remaining) {
> > +		ctx->pclustersize = roundup(remaining - inode->fragment_size,
> > +					    EROFS_BLKSIZ);
> > +		return;
> > +	}
> > +
> > +	inode->fragmentoff += inode->fragment_size - remaining;
> > +	inode->fragment_size = remaining;
> > +
> > +	erofs_dbg("Reducing fragment size to %u at %lu",
> > +		  inode->fragment_size, inode->fragmentoff);
> > +
> > +	/* it's ending */
> > +	ctx->head += remaining;
> > +	ctx->remaining = 0;
> > +	*len = 0;
> > +}
> > +
> > +static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx, bool fixup)
> >  {
> >  	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
> >  	struct erofs_inode *inode = ctx->inode;
> >  	char *const dst = dstbuf + EROFS_BLKSIZ;
> >  	struct erofs_compress *const h = &compresshandle;
> >  	unsigned int len = ctx->tail - ctx->head;
> > +	bool final = !ctx->remaining;
> >  	int ret;
> >  
> >  	while (len) {
> > -		unsigned int pclustersize =
> > -			z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
> >  		bool may_inline = (cfg.c_ztailpacking && final);
> >  		bool may_packing = (cfg.c_fragments && final &&
> >  				   !erofs_is_packed_inode(inode));  
> 
> 		bool may_xxxx = fixup;
> 
> >  
> > -		if (z_erofs_compress_dedupe(inode, ctx, &len) && !final)
> > +		if (z_erofs_compress_dedupe(ctx, &len) && !final)
> >  			break;
> >  
> > -		if (len <= pclustersize) {
> > +		if (len <= ctx->pclustersize) {
> >  			if (!final || !len)
> >  				break;
> >  			if (may_packing) {
> > +				if (inode->fragment_size && !fixup) {
> > +					ctx->remaining = inode->fragment_size;
> > +					ctx->pclustersize =
> > +						roundup(len, EROFS_BLKSIZ);
> > +					ctx->e.length = 0;
> > +					return -EAGAIN;
> > +				}
> >  				ctx->e.length = len;
> >  				goto frag_packing;
> >  			}
> > @@ -353,7 +389,7 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx,
> >  		ctx->e.length = min(len,
> >  				cfg.c_max_decompressed_extent_bytes);
> >  		ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
> > -				&ctx->e.length, dst, pclustersize,
> > +				&ctx->e.length, dst, ctx->pclustersize,
> >  				!(final && len == ctx->e.length));
> >  		if (ret <= 0) {
> >  			if (ret != -EAGAIN) {
> > @@ -385,11 +421,12 @@ nocompression:
> >  			ctx->e.compressedblks = 1;
> >  			ctx->e.raw = true;
> >  		} else if (may_packing && len == ctx->e.length &&
> > -			   ret < pclustersize) {
> > +			   ret < ctx->pclustersize && (!inode->fragment_size ||
> > +			   fixup)) {
> >  frag_packing:
> >  			ret = z_erofs_pack_fragments(inode,
> >  						     ctx->queue + ctx->head,
> > -						     len);
> > +						     len, ctx->crc);
> >  			if (ret < 0)
> >  				return ret;
> >  			ctx->e.compressedblks = 0; /* indicate a fragment */  
> 
> 			may_xxxx = false;
> 
> > @@ -425,6 +462,21 @@ frag_packing:
> >  			DBG_BUGON(ctx->e.compressedblks * EROFS_BLKSIZ >=
> >  				  ctx->e.length);
> >  
> > +			/*
> > +			 * Try to recompress a litte more if there's space left
> > +			 * for fragment deduplication.
> > +			 */
> > +			if (may_packing && len == ctx->e.length && tailused &&
> > +			    ctx->tail < sizeof(ctx->queue)) {
> > +				DBG_BUGON(!inode->fragment_size);
> > +
> > +				ctx->remaining = inode->fragment_size;
> > +				ctx->pclustersize =
> > +					ctx->e.compressedblks * EROFS_BLKSIZ;
> > +				ctx->e.length = 0;
> > +				return -EAGAIN;
> > +			}
> > +
> >  			/* zero out garbage trailing data for non-0padding */
> >  			if (!erofs_sb_has_lz4_0padding())
> >  				memset(dst + ret, 0,
> > @@ -454,6 +506,9 @@ frag_packing:
> >  		ctx->head += ctx->e.length;
> >  		len -= ctx->e.length;
> >  
> > +		if (fixup && ctx->e.compressedblks)  
> 
> 		if (may_xxxx)

Okay.

> 
> > +			z_erofs_fragments_dedupe_update(ctx, &len);
> > +
> >  		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
> >  			const unsigned int qh_aligned =
> >  				round_down(ctx->head, EROFS_BLKSIZ);
> > @@ -736,10 +791,9 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
> >  {
> >  	struct erofs_buffer_head *bh;
> >  	static struct z_erofs_vle_compress_ctx ctx;
> > -	erofs_off_t remaining;
> >  	erofs_blk_t blkaddr, compressed_blocks;
> >  	unsigned int legacymetasize;
> > -	int ret;
> > +	int ret = 0;
> >  	u8 *compressmeta = malloc(vle_compressmeta_capacity(inode->i_size));
> >  
> >  	if (!compressmeta)
> > @@ -775,6 +829,16 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
> >  	inode->idata_size = 0;
> >  	inode->fragment_size = 0;
> >  
> > +	/*
> > +	 * Dedupe fragments before compression to avoid writing duplicate parts
> > +	 * into packed inode.
> > +	 */
> > +	if (cfg.c_fragments && !erofs_is_packed_inode(inode)) {
> > +		ret = z_erofs_fragments_dedupe(inode, fd, &ctx.crc);
> > +		if (ret < 0)
> > +			goto err_bdrop;
> > +	}
> > +
> >  	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
> >  	ctx.inode = inode;
> >  	ctx.blkaddr = blkaddr;
> > @@ -782,22 +846,25 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
> >  	ctx.head = ctx.tail = 0;
> >  	ctx.clusterofs = 0;
> >  	ctx.e.length = 0;
> > -	remaining = inode->i_size;
> > +	ctx.e.compressedblks = 0;
> > +	ctx.pclustersize = z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
> > +	ctx.remaining = inode->i_size - inode->fragment_size;
> >  
> > -	while (remaining) {
> > -		const u64 readcount = min_t(u64, remaining,
> > +	while (ctx.remaining) {
> > +		const u64 readcount = min_t(u64, ctx.remaining,
> >  					    sizeof(ctx.queue) - ctx.tail);
> > +		bool fixup = ret < 0;  
> 
> 	drop this one;
> 
> >  
> >  		ret = read(fd, ctx.queue + ctx.tail, readcount);
> >  		if (ret != readcount) {
> >  			ret = -errno;
> >  			goto err_bdrop;
> >  		}
> > -		remaining -= readcount;
> > +		ctx.remaining -= readcount;
> >  		ctx.tail += readcount;
> >  
> > -		ret = vle_compress_one(&ctx, !remaining);  
> 
> 					     ret == -EAGAIN

Just move 'fixup' in 'ctx'?

> 
> > -		if (ret)
> > +		ret = vle_compress_one(&ctx, fixup);
> > +		if (ret && ret != -EAGAIN)
> >  			goto err_free_idata;
> >  	}
> >  	DBG_BUGON(ctx.head != ctx.tail);
> > @@ -807,6 +874,16 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
> >  	DBG_BUGON(compressed_blocks < !!inode->idata_size);
> >  	compressed_blocks -= !!inode->idata_size;
> >  
> > +	if (inode->fragment_size && ctx.e.compressedblks) {  
> 
> why not moving into z_erofs_fragments_dedupe_update()?

I consider this before, it's a bit awkward for me due to non updating case.

Let me reconsider.

> 
> Thanks,
> Gao Xiang
> 
> > +		z_erofs_write_indexes(&ctx);
> > +
> > +		inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
> > +		ctx.e.length = inode->fragment_size;
> > +		ctx.e.compressedblks = 0;
> > +		ctx.e.raw = true;
> > +		ctx.e.partial = false;
> > +		ctx.e.blkaddr = ctx.blkaddr;
> > +	}
> >  	z_erofs_write_indexes(&ctx);
> >  	z_erofs_write_indexes_final(&ctx);
> >  	legacymetasize = ctx.metacur - compressmeta;
> > diff --git a/lib/fragments.c b/lib/fragments.c
> > index b8c37d5..48c133f 100644
> > --- a/lib/fragments.c
> > +++ b/lib/fragments.c
> > @@ -10,14 +10,183 @@
> >  #include "erofs/inode.h"
> >  #include "erofs/compress.h"
> >  #include "erofs/print.h"
> > +#include "erofs/internal.h"
> >  #include "erofs/fragments.h"
> >  
> > +struct erofs_fragment_dedupe_item {
> > +	struct list_head	list;
> > +	unsigned int		length, nr_dup;
> > +	erofs_off_t		pos;
> > +	u8			data[];
> > +};
> > +
> > +#define FRAGMENT_HASHTABLE_SIZE		65536
> > +#define FRAGMENT_HASH(crc)		(crc & (FRAGMENT_HASHTABLE_SIZE - 1))
> > +
> > +static struct list_head dupli_frags[FRAGMENT_HASHTABLE_SIZE];
> > +static unsigned int len_to_hash; /* the fragment length for crc32 hash */
> > +
> >  static FILE *packedfile;
> >  const char *frags_packedname = "packed_file";
> >  
> > +static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
> > +					 u32 crc)
> > +{
> > +	struct erofs_fragment_dedupe_item *cur, *di = NULL;
> > +	struct list_head *head;
> > +	u8 *data;
> > +	unsigned int length;
> > +	int ret;
> > +
> > +	head = &dupli_frags[FRAGMENT_HASH(crc)];
> > +	if (list_empty(head))
> > +		return 0;
> > +
> > +	/* XXX: no need to read so much for smaller? */
> > +	if (inode->i_size < 2 * EROFS_CONFIG_COMPR_MAX_SZ)
> > +		length = inode->i_size;
> > +	else
> > +		length = 2 * EROFS_CONFIG_COMPR_MAX_SZ;
> > +
> > +	data = malloc(length);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	ret = lseek(fd, inode->i_size - length, SEEK_SET);
> > +	if (ret == -1) {
> > +		ret = -errno;
> > +		goto out;
> > +	}
> > +
> > +	ret = read(fd, data, length);
> > +	if (ret != length) {
> > +		ret = -errno;
> > +		goto out;
> > +	}
> > +
> > +	list_for_each_entry(cur, head, list) {
> > +		unsigned int e1, e2, i = 0;
> > +
> > +		DBG_BUGON(cur->length < len_to_hash + 1);
> > +		DBG_BUGON(length < len_to_hash + 1);
> > +
> > +		e1 = cur->length - len_to_hash - 1;
> > +		e2 = length - len_to_hash - 1;
> > +
> > +		if (memcmp(cur->data + e1 + 1, data + e2 + 1, len_to_hash))
> > +			continue;
> > +
> > +		while (i <= min(e1, e2) && cur->data[e1 - i] == data[e2 - i])
> > +			i++;
> > +
> > +		if (i && (!di || i + len_to_hash > di->nr_dup)) {
> > +			cur->nr_dup = i + len_to_hash;
> > +			di = cur;
> > +
> > +			/* full match */
> > +			if (i == min(e1, e2) + 1)
> > +				break;
> > +		}
> > +	}
> > +	if (!di)
> > +		goto out;
> > +
> > +	DBG_BUGON(di->length < di->nr_dup);
> > +
> > +	inode->fragment_size = di->nr_dup;
> > +	inode->fragmentoff = di->pos + di->length - di->nr_dup;
> > +
> > +	erofs_dbg("Dedupe %u fragment data at %lu", inode->fragment_size,
> > +		  inode->fragmentoff);
> > +out:
> > +	free(data);
> > +	return ret;
> > +}
> > +
> > +
> > +int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *crc_ret)
> > +{
> > +	u8 data_to_hash[len_to_hash];
> > +	u32 crc;
> > +	int ret;
> > +
> > +	if (inode->i_size <= len_to_hash)
> > +		return 0;
> > +
> > +	ret = lseek(fd, inode->i_size - len_to_hash, SEEK_SET);
> > +	if (ret == -1)
> > +		return -errno;
> > +
> > +	ret = read(fd, data_to_hash, len_to_hash);
> > +	if (ret != len_to_hash)
> > +		return -errno;
> > +
> > +	crc = erofs_crc32c(~0, data_to_hash, len_to_hash);
> > +	*crc_ret = crc;
> > +
> > +	ret = z_erofs_fragments_dedupe_find(inode, fd, crc);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = lseek(fd, 0, SEEK_SET);
> > +	if (ret == -1)
> > +		return -errno;
> > +	return 0;
> > +}
> > +
> > +static int z_erofs_fragments_dedupe_insert(void *data, unsigned int len,
> > +					   erofs_off_t pos, u32 crc)
> > +{
> > +	struct erofs_fragment_dedupe_item *di;
> > +
> > +	if (len <= len_to_hash)
> > +		return 0;
> > +
> > +	di = malloc(sizeof(*di) + len);
> > +	if (!di)
> > +		return -ENOMEM;
> > +
> > +	memcpy(di->data, data, len);
> > +	di->length = len;
> > +	di->pos = pos;
> > +	di->nr_dup = 0;
> > +
> > +	list_add_tail(&di->list, &dupli_frags[FRAGMENT_HASH(crc)]);
> > +	return 0;
> > +}
> > +
> > +static inline void z_erofs_fragments_dedupe_init(unsigned int clen)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < FRAGMENT_HASHTABLE_SIZE; ++i)
> > +		init_list_head(&dupli_frags[i]);
> > +
> > +	len_to_hash = clen;
> > +}
> > +
> > +static void z_erofs_fragments_dedupe_exit(void)
> > +{
> > +	struct erofs_fragment_dedupe_item *di, *n;
> > +	struct list_head *head;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < FRAGMENT_HASHTABLE_SIZE; ++i) {
> > +		head = &dupli_frags[i];
> > +
> > +		if (list_empty(head))
> > +			continue;
> > +
> > +		list_for_each_entry_safe(di, n, head, list)
> > +			free(di);
> > +	}
> > +}
> > +
> >  int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
> > -			   unsigned int len)
> > +			   unsigned int len, u32 crc)
> >  {
> > +	int ret;
> > +
> >  	inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
> >  	inode->fragmentoff = ftell(packedfile);
> >  	inode->fragment_size = len;
> > @@ -35,6 +204,11 @@ int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
> >  
> >  	erofs_dbg("Recording %u fragment data at %lu", inode->fragment_size,
> >  		  inode->fragmentoff);
> > +
> > +	ret = z_erofs_fragments_dedupe_insert(data, len, inode->fragmentoff,
> > +					      crc);
> > +	if (ret)
> > +		return ret;
> >  	return len;
> >  }
> >  
> > @@ -50,6 +224,8 @@ void erofs_fragments_exit(void)
> >  {
> >  	if (packedfile)
> >  		fclose(packedfile);
> > +
> > +	z_erofs_fragments_dedupe_exit();
> >  }
> >  
> >  int erofs_fragments_init(void)
> > @@ -61,5 +237,7 @@ int erofs_fragments_init(void)
> >  #endif
> >  	if (!packedfile)
> >  		return -ENOMEM;
> > +
> > +	z_erofs_fragments_dedupe_init(16);
> >  	return 0;
> >  }
> > -- 
> > 2.17.1  

