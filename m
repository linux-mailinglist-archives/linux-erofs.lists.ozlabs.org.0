Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79996370DF
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Nov 2022 04:16:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NHjnL6PHwz3cWl
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Nov 2022 14:16:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=RzU80y3g;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=RzU80y3g;
	dkim-atps=neutral
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NHjn94ss3z3cG9
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Nov 2022 14:15:55 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id g10so301249plo.11
        for <linux-erofs@lists.ozlabs.org>; Wed, 23 Nov 2022 19:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izPaIXoR0mqHQXoajgsFosHgFE5ZKAyed6010tsk+Pc=;
        b=RzU80y3geJBXdEaXuBq8W2BdY3k9Uz0lr/jHzpEnw1jfg6WiDAtPnD44xbW2LpECM7
         Ope8SdjBN0noYrjxlJa7zdT9GfrWO8UtZNLJD4nmudx9bZw1S4CvlH+P4wglPmFErk6R
         qVXi7jJxLTjENAF75IBjHAUsAAxfnLggLXwvDyQl1HALFGcHVARmL5lTPsSE+cFtHkui
         yOk6UG1sOAAwfDQEME6fez4fjVKXh9V0n0kNOedLaAqk0o6SCfh/NCXUtuQguwhycJy6
         0D8XNOFzh4RSGIV7wApydA8GfB32uemkAFzxmT/+BatEJ5BGd/1YglIbTl4+H16nSk7V
         vKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izPaIXoR0mqHQXoajgsFosHgFE5ZKAyed6010tsk+Pc=;
        b=TCEJRjB1kRjFT+mg8oYw2lX0rg7Dz7zlY9zrJkBii15fBix67WC60gxosgENvM3Yi5
         UeJY5wD4MuwLUKe5qdA6b8bYDUuFtTAI9s/vKx8RY6BovQfy2Dtmqvi4DYua4i4oLpUM
         qvWw7AgI5x0Ep90FSt2Xt2N0dQGG4I7aawZ55/iJKwPoEsyqf1HXGDcM/qrksNOKhERE
         Ve6SDCAGLj0WllEjLG1KKP8YBYQyqp9ckG7rUMtgxqSGoIBHjn3xAInrbr/B47ZaUL2q
         fkIzZ3srN8YAlzBQhKqg7uyWdJKBstEPpR9dVE+zywRo6VA2MOFxPJQ+QkV7nhBrPgLz
         30jQ==
X-Gm-Message-State: ANoB5pnjMds21/l1QxYJX0dViPUKmBELw+lIWZ2B5JMcBPLHtvgyWi2t
	44Wjwk+lYku4n+qgZ5lmEVMxwBBx2UE=
X-Google-Smtp-Source: AA0mqf5F/bIrfYB/cBGmXDv3NcqoEr/GV3HfKZqj1d9lTYxPx3t8O9+AJbCbYvjNnZp6PhMvw7CvwA==
X-Received: by 2002:a17:902:e5c5:b0:185:4625:2a1f with SMTP id u5-20020a170902e5c500b0018546252a1fmr11888148plf.24.1669259752334;
        Wed, 23 Nov 2022 19:15:52 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id b12-20020aa78ecc000000b0056b2e70c2f5sm12143770pfr.25.2022.11.23.19.15.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Nov 2022 19:15:52 -0800 (PST)
Date: Thu, 24 Nov 2022 11:19:54 +0800
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: Re: [RFC][PATCH v2] erofs-utils: mkfs: support fragment
 deduplication
Message-ID: <20221124111954.00004c15.zbestahu@gmail.com>
In-Reply-To: <20221123131916.20782-1-zbestahu@gmail.com>
References: <20221123131916.20782-1-zbestahu@gmail.com>
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
Cc: shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 23 Nov 2022 21:19:16 +0800
Yue Hu <zbestahu@gmail.com> wrote:

> From: Yue Hu <huyue2@coolpad.com>
> 
> Previously, there's no fragment deduplication when this feature is
> introduced. Let's support it now.
> 
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Some preliminary numbers with fragments + dedupe:

dataset: Linux 5.10.1 + Linux 5.10.87 source code
algorithm: lz4hc,12

 16K, 306M(erofs), 366M(squashfs)
 32K, 291M(erofs), 332M(squashfs)
 64K, 286M(erofs), 304M(squashfs)
128K, 283M(erofs), 283M(squashfs)

btw: squashfs uses level 12 of lz4hc default.

> ---
> v2: mainly improve the logic in compression
> 
>  include/erofs/fragments.h |   3 +-
>  lib/compress.c            | 122 +++++++++++++++++++++----
>  lib/fragments.c           | 188 +++++++++++++++++++++++++++++++++++++-
>  lib/inode.c               |  12 ++-
>  4 files changed, 302 insertions(+), 23 deletions(-)
> 
> diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
> index 5444384..6c51fc9 100644
> --- a/include/erofs/fragments.h
> +++ b/include/erofs/fragments.h
> @@ -15,8 +15,9 @@ extern "C"
>  extern const char *frags_packedname;
>  #define EROFS_PACKED_INODE	frags_packedname
>  
> +int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *crc);
>  int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
> -			   unsigned int len);
> +			   unsigned int len, u32 crc);
>  struct erofs_inode *erofs_mkfs_build_fragments(void);
>  int erofs_fragments_init(void);
>  void erofs_fragments_exit(void);
> diff --git a/lib/compress.c b/lib/compress.c
> index 17b3213..7a133fd 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -33,6 +33,10 @@ struct z_erofs_vle_compress_ctx {
>  	unsigned int head, tail;
>  	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
>  	u16 clusterofs;
> +
> +	u32 crc;
> +	unsigned int pclustersize;
> +	erofs_off_t remaining;
>  };
>  
>  #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	\
> @@ -162,10 +166,10 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
>  	ctx->clusterofs = clusterofs + count;
>  }
>  
> -static int z_erofs_compress_dedupe(struct erofs_inode *inode,
> -				   struct z_erofs_vle_compress_ctx *ctx,
> +static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
>  				   unsigned int *len)
>  {
> +	struct erofs_inode *inode = ctx->inode;
>  	int ret = 0;
>  
>  	do {
> @@ -319,30 +323,83 @@ static void tryrecompress_trailing(void *in, unsigned int *insize,
>  	*compressedsize = ret;
>  }
>  
> -static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx,
> -			    bool final)
> +static void z_erofs_fragments_dedupe_reduce(struct z_erofs_vle_compress_ctx *ctx,
> +					    unsigned int *len)
> +{
> +	struct erofs_inode *inode = ctx->inode;
> +	const unsigned int remaining = ctx->remaining + *len;
> +
> +	if (!inode->fragment_size || !ctx->e.compressedblks)
> +		return;
> +
> +	/* try to close the gap if it gets larger (should be rare) */
> +	if (inode->fragment_size < remaining) {
> +		z_erofs_write_indexes(ctx);
> +		ctx->e.compressedblks =
> +			BLK_ROUND_UP(remaining - inode->fragment_size);
> +		return;
> +	}
> +
> +	inode->fragmentoff += inode->fragment_size - remaining;
> +	inode->fragment_size = remaining;
> +
> +	erofs_dbg("Reducing fragment size to %u at %lu",
> +		  inode->fragment_size, inode->fragmentoff);
> +
> +	/* it's ending */
> +	ctx->head += remaining;
> +	ctx->remaining = 0;
> +	*len = 0;
> +}
> +
> +static void z_erofs_fragments_dedupe_end(struct z_erofs_vle_compress_ctx *ctx)
> +{
> +	struct erofs_inode *inode = ctx->inode;
> +
> +	if (inode->fragment_size && ctx->e.compressedblks) {
> +		inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
> +		z_erofs_write_indexes(ctx);
> +
> +		ctx->e.length = inode->fragment_size;
> +		ctx->e.compressedblks = 0;
> +		ctx->e.raw = true;
> +		ctx->e.partial = false;
> +		ctx->e.blkaddr = ctx->blkaddr;
> +	}
> +	z_erofs_write_indexes(ctx);
> +	z_erofs_write_indexes_final(ctx);
> +}
> +
> +static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx, bool fixing)
>  {
>  	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
>  	struct erofs_inode *inode = ctx->inode;
>  	char *const dst = dstbuf + EROFS_BLKSIZ;
>  	struct erofs_compress *const h = &compresshandle;
>  	unsigned int len = ctx->tail - ctx->head;
> +	bool final = !ctx->remaining;
>  	int ret;
>  
>  	while (len) {
> -		unsigned int pclustersize =
> -			z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
> +		unsigned int pclustersize = !fixing ? ctx->pclustersize :
> +					ctx->e.compressedblks * EROFS_BLKSIZ;
>  		bool may_inline = (cfg.c_ztailpacking && final);
>  		bool may_packing = (cfg.c_fragments && final &&
>  				   !erofs_is_packed_inode(inode));
>  
> -		if (z_erofs_compress_dedupe(inode, ctx, &len) && !final)
> +		if (z_erofs_compress_dedupe(ctx, &len) && !final)
>  			break;
>  
>  		if (len <= pclustersize) {
>  			if (!final || !len)
>  				break;
>  			if (may_packing) {
> +				if (inode->fragment_size && !fixing) {
> +					ctx->remaining = inode->fragment_size;
> +					ctx->e.length = 0;
> +					ctx->e.compressedblks = BLK_ROUND_UP(len);
> +					return -EAGAIN;
> +				}
>  				ctx->e.length = len;
>  				goto frag_packing;
>  			}
> @@ -385,11 +442,11 @@ nocompression:
>  			ctx->e.compressedblks = 1;
>  			ctx->e.raw = true;
>  		} else if (may_packing && len == ctx->e.length &&
> -			   ret < pclustersize) {
> +			   ret < pclustersize && !inode->fragment_size) {
>  frag_packing:
>  			ret = z_erofs_pack_fragments(inode,
>  						     ctx->queue + ctx->head,
> -						     len);
> +						     len, ctx->crc);
>  			if (ret < 0)
>  				return ret;
>  			ctx->e.compressedblks = 0; /* indicate a fragment */
> @@ -425,6 +482,20 @@ frag_packing:
>  			DBG_BUGON(ctx->e.compressedblks * EROFS_BLKSIZ >=
>  				  ctx->e.length);
>  
> +			/*
> +			 * Try to recompress a litte more if there's space left
> +			 * for fragment deduplication.
> +			 */
> +			if (may_packing && len == ctx->e.length && tailused) {
> +				DBG_BUGON(!inode->fragment_size);
> +				if (fixing)
> +					goto frag_packing;
> +
> +				ctx->remaining = inode->fragment_size;
> +				ctx->e.length = 0;
> +				return -EAGAIN;
> +			}
> +
>  			/* zero out garbage trailing data for non-0padding */
>  			if (!erofs_sb_has_lz4_0padding())
>  				memset(dst + ret, 0,
> @@ -454,6 +525,9 @@ frag_packing:
>  		ctx->head += ctx->e.length;
>  		len -= ctx->e.length;
>  
> +		if (fixing)
> +			z_erofs_fragments_dedupe_reduce(ctx, &len);
> +
>  		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
>  			const unsigned int qh_aligned =
>  				round_down(ctx->head, EROFS_BLKSIZ);
> @@ -736,7 +810,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
>  {
>  	struct erofs_buffer_head *bh;
>  	static struct z_erofs_vle_compress_ctx ctx;
> -	erofs_off_t remaining;
>  	erofs_blk_t blkaddr, compressed_blocks;
>  	unsigned int legacymetasize;
>  	int ret;
> @@ -775,6 +848,16 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
>  	inode->idata_size = 0;
>  	inode->fragment_size = 0;
>  
> +	/*
> +	 * Dedupe fragments before compression to avoid writing duplicate parts
> +	 * into packed inode.
> +	 */
> +	if (cfg.c_fragments && !erofs_is_packed_inode(inode)) {
> +		ret = z_erofs_fragments_dedupe(inode, fd, &ctx.crc);
> +		if (ret < 0)
> +			goto err_bdrop;
> +	}
> +
>  	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
>  	ctx.inode = inode;
>  	ctx.blkaddr = blkaddr;
> @@ -782,22 +865,26 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
>  	ctx.head = ctx.tail = 0;
>  	ctx.clusterofs = 0;
>  	ctx.e.length = 0;
> -	remaining = inode->i_size;
> +	ctx.e.compressedblks = 0;
> +	ctx.pclustersize = z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
> +	ctx.remaining = inode->i_size - inode->fragment_size;
>  
> -	while (remaining) {
> -		const u64 readcount = min_t(u64, remaining,
> +	ret = 0;
> +	while (ctx.remaining) {
> +		const u64 readcount = min_t(u64, ctx.remaining,
>  					    sizeof(ctx.queue) - ctx.tail);
> +		bool fixing = !!ret;
>  
>  		ret = read(fd, ctx.queue + ctx.tail, readcount);
>  		if (ret != readcount) {
>  			ret = -errno;
>  			goto err_bdrop;
>  		}
> -		remaining -= readcount;
> +		ctx.remaining -= readcount;
>  		ctx.tail += readcount;
>  
> -		ret = vle_compress_one(&ctx, !remaining);
> -		if (ret)
> +		ret = vle_compress_one(&ctx, fixing);
> +		if (ret && ret != -EAGAIN)
>  			goto err_free_idata;
>  	}
>  	DBG_BUGON(ctx.head != ctx.tail);
> @@ -807,8 +894,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
>  	DBG_BUGON(compressed_blocks < !!inode->idata_size);
>  	compressed_blocks -= !!inode->idata_size;
>  
> -	z_erofs_write_indexes(&ctx);
> -	z_erofs_write_indexes_final(&ctx);
> +	z_erofs_fragments_dedupe_end(&ctx);
>  	legacymetasize = ctx.metacur - compressmeta;
>  	/* estimate if data compression saves space or not */
>  	if (!inode->fragment_size &&
> diff --git a/lib/fragments.c b/lib/fragments.c
> index b8c37d5..550c888 100644
> --- a/lib/fragments.c
> +++ b/lib/fragments.c
> @@ -10,14 +10,191 @@
>  #include "erofs/inode.h"
>  #include "erofs/compress.h"
>  #include "erofs/print.h"
> +#include "erofs/internal.h"
>  #include "erofs/fragments.h"
>  
> +struct fragment_dedupe_item {
> +	struct list_head	list;
> +	unsigned int		length, nr_dup;
> +	erofs_off_t		pos;
> +	u8			data[];
> +};
> +
> +#define FRAGMENT_HASHTABLE_SIZE		65536
> +#define FRAGMENT_HASH(crc)		(crc & (FRAGMENT_HASHTABLE_SIZE - 1))
> +
> +static struct list_head di_hashtable[FRAGMENT_HASHTABLE_SIZE];
> +static unsigned int keylen;	/* the data length to crc for deduplication */
> +
>  static FILE *packedfile;
>  const char *frags_packedname = "packed_file";
>  
> +static struct fragment_dedupe_item *find_duplicate(struct list_head *head,
> +						   u8 *data, unsigned int len)
> +{
> +	struct fragment_dedupe_item *di, *candidate = NULL;
> +
> +	list_for_each_entry(di, head, list) {
> +		unsigned int e1, e2, i = 0;
> +
> +		DBG_BUGON(di->length < keylen + 1);
> +		DBG_BUGON(len < keylen + 1);
> +
> +		e1 = di->length - keylen - 1;
> +		e2 = len - keylen - 1;
> +
> +		if (memcmp(di->data + e1 + 1, data + e2 + 1, keylen))
> +			continue;
> +
> +		while (i <= min(e1, e2) && di->data[e1 - i] == data[e2 - i])
> +			i++;
> +
> +		if (i && (!candidate || i + keylen > candidate->nr_dup)) {
> +			di->nr_dup = i + keylen;
> +			candidate = di;
> +
> +			/* full match */
> +			if (i == min(e1, e2) + 1)
> +				break;
> +		}
> +	}
> +	return candidate;
> +}
> +
> +static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
> +					 u32 crc)
> +{
> +	struct fragment_dedupe_item *di;
> +	struct list_head *head;
> +	u8 *data;
> +	unsigned int length;
> +	int ret;
> +
> +	head = &di_hashtable[FRAGMENT_HASH(crc)];
> +	if (list_empty(head))
> +		return 0;
> +
> +	if (inode->i_size < EROFS_CONFIG_COMPR_MAX_SZ)
> +		length = inode->i_size;
> +	else
> +		length = EROFS_CONFIG_COMPR_MAX_SZ;
> +
> +	data = malloc(length);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	ret = lseek(fd, inode->i_size - length, SEEK_SET);
> +	if (ret == -1) {
> +		ret = -errno;
> +		goto out;
> +	}
> +
> +	ret = read(fd, data, length);
> +	if (ret != length) {
> +		ret = -errno;
> +		goto out;
> +	}
> +
> +	di = find_duplicate(head, data, length);
> +	if (!di)
> +		goto out;
> +
> +	DBG_BUGON(di->length < di->nr_dup);
> +
> +	inode->fragment_size = di->nr_dup;
> +	inode->fragmentoff = di->pos + di->length - di->nr_dup;
> +
> +	erofs_dbg("Dedupe %u fragment data at %lu", inode->fragment_size,
> +		  inode->fragmentoff);
> +out:
> +	free(data);
> +	return ret;
> +}
> +
> +
> +int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *crc_ret)
> +{
> +	u8 key[keylen];
> +	u32 crc;
> +	int ret;
> +
> +	if (inode->i_size <= keylen)
> +		return 0;
> +
> +	ret = lseek(fd, inode->i_size - keylen, SEEK_SET);
> +	if (ret == -1)
> +		return -errno;
> +
> +	ret = read(fd, key, keylen);
> +	if (ret != keylen)
> +		return -errno;
> +
> +	crc = erofs_crc32c(~0, key, keylen);
> +	*crc_ret = crc;
> +
> +	ret = z_erofs_fragments_dedupe_find(inode, fd, crc);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = lseek(fd, 0, SEEK_SET);
> +	if (ret == -1)
> +		return -errno;
> +	return 0;
> +}
> +
> +static int z_erofs_fragments_dedupe_insert(void *data, unsigned int len,
> +					   erofs_off_t pos, u32 crc)
> +{
> +	struct fragment_dedupe_item *di;
> +
> +	if (len <= keylen)
> +		return 0;
> +
> +	di = malloc(sizeof(*di) + len);
> +	if (!di)
> +		return -ENOMEM;
> +
> +	memcpy(di->data, data, len);
> +	di->length = len;
> +	di->pos = pos;
> +	di->nr_dup = 0;
> +
> +	list_add_tail(&di->list, &di_hashtable[FRAGMENT_HASH(crc)]);
> +	return 0;
> +}
> +
> +static inline void z_erofs_fragments_dedupe_init(unsigned int clen)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < FRAGMENT_HASHTABLE_SIZE; ++i)
> +		init_list_head(&di_hashtable[i]);
> +
> +	keylen = clen;
> +}
> +
> +static void z_erofs_fragments_dedupe_exit(void)
> +{
> +	struct fragment_dedupe_item *di, *n;
> +	struct list_head *head;
> +	unsigned int i;
> +
> +	for (i = 0; i < FRAGMENT_HASHTABLE_SIZE; ++i) {
> +		head = &di_hashtable[i];
> +
> +		if (list_empty(head))
> +			continue;
> +
> +		list_for_each_entry_safe(di, n, head, list)
> +			free(di);
> +	}
> +}
> +
>  int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
> -			   unsigned int len)
> +			   unsigned int len, u32 crc)
>  {
> +	int ret;
> +
>  	inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
>  	inode->fragmentoff = ftell(packedfile);
>  	inode->fragment_size = len;
> @@ -35,6 +212,11 @@ int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
>  
>  	erofs_dbg("Recording %u fragment data at %lu", inode->fragment_size,
>  		  inode->fragmentoff);
> +
> +	ret = z_erofs_fragments_dedupe_insert(data, len, inode->fragmentoff,
> +					      crc);
> +	if (ret)
> +		return ret;
>  	return len;
>  }
>  
> @@ -50,6 +232,8 @@ void erofs_fragments_exit(void)
>  {
>  	if (packedfile)
>  		fclose(packedfile);
> +
> +	z_erofs_fragments_dedupe_exit();
>  }
>  
>  int erofs_fragments_init(void)
> @@ -61,5 +245,7 @@ int erofs_fragments_init(void)
>  #endif
>  	if (!packedfile)
>  		return -ENOMEM;
> +
> +	z_erofs_fragments_dedupe_init(16);
>  	return 0;
>  }
> diff --git a/lib/inode.c b/lib/inode.c
> index 9de4dec..cb2e057 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -406,7 +406,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
>  	return 0;
>  }
>  
> -int erofs_write_file(struct erofs_inode *inode)
> +static int erofs_write_file(struct erofs_inode *inode)
>  {
>  	int ret, fd;
>  
> @@ -1196,7 +1196,10 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
>  	struct erofs_inode *inode;
>  	int ret;
>  
> -	lseek(fd, 0, SEEK_SET);
> +	ret = lseek(fd, 0, SEEK_SET);
> +	if (ret == -1)
> +		return ERR_PTR(-errno);
> +
>  	ret = fstat64(fd, &st);
>  	if (ret)
>  		return ERR_PTR(-errno);
> @@ -1223,7 +1226,10 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
>  
>  	ret = erofs_write_compressed_file(inode, fd);
>  	if (ret == -ENOSPC) {
> -		lseek(fd, 0, SEEK_SET);
> +		ret = lseek(fd, 0, SEEK_SET);
> +		if (ret == -1)
> +			return ERR_PTR(-errno);
> +
>  		ret = write_uncompressed_file_from_fd(inode, fd);
>  	}
>  

