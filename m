Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4CF63F0E6
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Dec 2022 13:52:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NNGDx1MVQz3bYf
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Dec 2022 23:52:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=coolpad-com.20200927.dkim.feishu.cn header.i=@coolpad-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=myDi97if;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=coolpad.com (client-ip=101.36.218.36; helo=v03.bc.feishu.cn; envelope-from=huyue2@coolpad.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=coolpad-com.20200927.dkim.feishu.cn header.i=@coolpad-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=myDi97if;
	dkim-atps=neutral
Received: from v03.bc.feishu.cn (v03.bc.feishu.cn [101.36.218.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4NNGDn0JPdz3bVs
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Dec 2022 23:52:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=coolpad-com.20200927.dkim.feishu.cn; t=1669898998;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=gWJt4jSfRwmwiXefB7poqUPRAy8F1P/GxCYpVgrpEaw=;
 b=myDi97ifcXwwhwhhPcEjAzcq26RyPJqeLPIItnRoK6j8Z0/lua3CkEA/jI0Seuwg4erQlQ
 /QAVU2oQoAcCF3IQNotws+5rIVKltzL+xkD09PKQuX3ek3ITOo1znckdBEtmRObS3o32/2
 yE4dZSJwzhP20qz/No2W+HwaJajBrYc+EWvLhCnoPq2/3IAg5WMxX67ID1CCcYHCYO7vCw
 RobvQLbN2pa3ywjeos1NPvjwcVqLbrS0EbTvTfvk+KcjqY4WioGhg1luMdNC8pekrcqXaW
 vq+Xm2JdxG3kZSVKWWpNaLFeKDGsLYfUFzm6Pic67UoMCFsV8NMjZXJCiZmXlA==
Message-Id: <20221201205358.00003061.huyue2@coolpad.com>
Content-Transfer-Encoding: 7bit
To: <linux-erofs@lists.ozlabs.org>
From: "Yue Hu" <huyue2@coolpad.com>
Date: Thu, 01 Dec 2022 20:49:46 +0800
Content-Type: multipart/alternative;
 boundary=57346fd42101a9635370fa39b970577ccd92389d852fce3133fd003348b5
In-Reply-To: <20221201111615.9593-1-zbestahu@gmail.com>
Subject: Re: [PATCH v4] erofs-utils: mkfs: support fragment deduplication
Mime-Version: 1.0
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
X-Lms-Return-Path: <lba+26388a2ea+380ab3+lists.ozlabs.org+huyue2@coolpad.com>
References: <20221201111615.9593-1-zbestahu@gmail.com>
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

--57346fd42101a9635370fa39b970577ccd92389d852fce3133fd003348b5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Add a missing change:
- change to generate a ctx for duplicate fragment in compression.

On Thu,  1 Dec 2022 19:16:15 +0800
Yue Hu <zbestahu@gmail.com> wrote:

> From: Yue Hu <huyue2@coolpad.com>
>=20
> Previously, there's no fragment deduplication when this feature is
> introduced. Let's support it now.
>=20
> We intend to dedupe the fragments before compression, so that duplicate
> parts will not be written into packed inode.
>=20
> With this patch, for Linux 5.10.1 + 5.10.87 source code:
>=20
> [before]
>  32k pcluster + T0 + lz4hc,12 + fragment		450M
>  64k pcluster + T0 + lz4hc,12 + fragment		434M
> 128k pcluster + T0 + lz4hc,12 + fragment		426M
>  32k pcluster + T0 + lz4hc,12 + fragment + dedupe	368M
>  64k pcluster + T0 + lz4hc,12 + fragment + dedupe	380M
> 128k pcluster + T0 + lz4hc,12 + fragment + dedupe	395M
>=20
> [after]
>  32k pcluster + T0 + lz4hc,12 + fragment		311M
>  64k pcluster + T0 + lz4hc,12 + fragment		295M
> 128k pcluster + T0 + lz4hc,12 + fragment		287M
>  32k pcluster + T0 + lz4hc,12 + fragment + dedupe	286M
>  64k pcluster + T0 + lz4hc,12 + fragment + dedupe	281M
> 128k pcluster + T0 + lz4hc,12 + fragment + dedupe	278M
>=20
> Tested on SquashFS (which uses level 12 by default for lz4hc):
>=20
>  32k block + lz4hc		332M
>  64k block + lz4hc		304M
> 128k block + lz4hc		283M
> 256k block + lz4hc		273M
> 256k block + lz4hc + noI	278M
>=20
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
> v4:
> - renaming include tofcrc/new_fragmentsize
> - move fixup into ctx
> - use may_fixing to check packing fragment or not
> - move sb/inode flag + 64bits case from erofs_pack_fragments() to new
>   helper erofs_fragments_commit()
> - move recompress ahead of may_inline case when compressing succeeds
> - update commit message/code comments
> - note that decompress will fail when enable ztailpacking at the same
>   time, need some time to debug
>=20
> v3:
> - modify acrroding to Xiang's comments in v2
> - simplify the logic in vle_compress_one
> - fix the crash for 1MB pcluster
>=20
> v2: mainly improve the logic in compression
>=20
>  include/erofs/fragments.h |   4 +-
>  lib/compress.c            | 134 +++++++++++++++++++++-----
>  lib/fragments.c           | 197 ++++++++++++++++++++++++++++++++++++--
>  3 files changed, 305 insertions(+), 30 deletions(-)
>=20
> diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
> index 5444384..e91fb31 100644
> --- a/include/erofs/fragments.h
> +++ b/include/erofs/fragments.h
> @@ -15,8 +15,10 @@ extern "C"
>  extern const char *frags_packedname;
>  #define EROFS_PACKED_INODE	frags_packedname
> =20
> +int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tof=
crc_r);
>  int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
> -			   unsigned int len);
> +			   unsigned int len, u32 tofcrc);
> +void z_erofs_fragments_commit(struct erofs_inode *inode);
>  struct erofs_inode *erofs_mkfs_build_fragments(void);
>  int erofs_fragments_init(void);
>  void erofs_fragments_exit(void);
> diff --git a/lib/compress.c b/lib/compress.c
> index 17b3213..afd6e8e 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -33,6 +33,11 @@ struct z_erofs_vle_compress_ctx {
>  	unsigned int head, tail;
>  	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
>  	u16 clusterofs;
> +
> +	u32 tofcrc;
> +	unsigned int pclustersize;
> +	erofs_off_t remaining;
> +	bool need_fix;
>  };
> =20
>  #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	\
> @@ -162,10 +167,10 @@ static void z_erofs_write_indexes(struct z_erofs_vl=
e_compress_ctx *ctx)
>  	ctx->clusterofs =3D clusterofs + count;
>  }
> =20
> -static int z_erofs_compress_dedupe(struct erofs_inode *inode,
> -				   struct z_erofs_vle_compress_ctx *ctx,
> +static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
>  				   unsigned int *len)
>  {
> +	struct erofs_inode *inode =3D ctx->inode;
>  	int ret =3D 0;
> =20
>  	do {
> @@ -301,10 +306,6 @@ static void tryrecompress_trailing(void *in, unsigne=
d int *insize,
>  	unsigned int count;
>  	int ret =3D *compressedsize;
> =20
> -	/* no need to recompress */
> -	if (!(ret & (EROFS_BLKSIZ - 1)))
> -		return;
> -
>  	count =3D *insize;
>  	ret =3D erofs_compress_destsize(&compresshandle,
>  				      in, &count, (void *)tmp,
> @@ -319,30 +320,69 @@ static void tryrecompress_trailing(void *in, unsign=
ed int *insize,
>  	*compressedsize =3D ret;
>  }
> =20
> -static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx,
> -			    bool final)
> +static void z_erofs_fragments_dedupe_update(struct z_erofs_vle_compress_=
ctx *ctx,
> +					    unsigned int *len)
> +{
> +	struct erofs_inode *inode =3D ctx->inode;
> +	const unsigned int new_fragmentsize =3D ctx->remaining + *len;
> +
> +	DBG_BUGON(!inode->fragment_size);
> +
> +	/* try to fix it again if it gets larger (should be rare) */
> +	if (inode->fragment_size < new_fragmentsize) {
> +		ctx->pclustersize =3D
> +			roundup(new_fragmentsize - inode->fragment_size,
> +				EROFS_BLKSIZ);
> +		return;
> +	}
> +
> +	inode->fragmentoff +=3D inode->fragment_size - new_fragmentsize;
> +	inode->fragment_size =3D new_fragmentsize;
> +
> +	erofs_dbg("Reducing fragment size to %u at %lu",
> +		  inode->fragment_size, inode->fragmentoff);
> +
> +	/* it's ending */
> +	ctx->head +=3D new_fragmentsize;
> +	ctx->remaining =3D 0;
> +	*len =3D 0;
> +}
> +
> +static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
>  {
>  	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
>  	struct erofs_inode *inode =3D ctx->inode;
>  	char *const dst =3D dstbuf + EROFS_BLKSIZ;
>  	struct erofs_compress *const h =3D &compresshandle;
>  	unsigned int len =3D ctx->tail - ctx->head;
> +	bool final =3D !ctx->remaining;
>  	int ret;
> =20
>  	while (len) {
> -		unsigned int pclustersize =3D
> -			z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
>  		bool may_inline =3D (cfg.c_ztailpacking && final);
>  		bool may_packing =3D (cfg.c_fragments && final &&
>  				   !erofs_is_packed_inode(inode));
> +		bool may_fixing =3D ctx->need_fix;
> =20
> -		if (z_erofs_compress_dedupe(inode, ctx, &len) && !final)
> +		if (z_erofs_compress_dedupe(ctx, &len) && !final)
>  			break;
> =20
> -		if (len <=3D pclustersize) {
> +		if (len <=3D ctx->pclustersize) {
> +			if (may_fixing && !len) {
> +				may_packing =3D false;
> +				goto frag_nopacking;
> +			}
>  			if (!final || !len)
>  				break;
>  			if (may_packing) {
> +				if (inode->fragment_size && !may_fixing) {
> +					ctx->remaining =3D inode->fragment_size;
> +					ctx->pclustersize =3D
> +						roundup(len, EROFS_BLKSIZ);
> +					ctx->e.length =3D 0;
> +					ctx->need_fix =3D true;
> +					break;
> +				}
>  				ctx->e.length =3D len;
>  				goto frag_packing;
>  			}
> @@ -353,7 +393,7 @@ static int vle_compress_one(struct z_erofs_vle_compre=
ss_ctx *ctx,
>  		ctx->e.length =3D min(len,
>  				cfg.c_max_decompressed_extent_bytes);
>  		ret =3D erofs_compress_destsize(h, ctx->queue + ctx->head,
> -				&ctx->e.length, dst, pclustersize,
> +				&ctx->e.length, dst, ctx->pclustersize,
>  				!(final && len =3D=3D ctx->e.length));
>  		if (ret <=3D 0) {
>  			if (ret !=3D -EAGAIN) {
> @@ -385,15 +425,17 @@ nocompression:
>  			ctx->e.compressedblks =3D 1;
>  			ctx->e.raw =3D true;
>  		} else if (may_packing && len =3D=3D ctx->e.length &&
> -			   ret < pclustersize) {
> +			   ret < ctx->pclustersize && (!inode->fragment_size ||
> +			   may_fixing)) {
>  frag_packing:
>  			ret =3D z_erofs_pack_fragments(inode,
>  						     ctx->queue + ctx->head,
> -						     len);
> +						     len, ctx->tofcrc);
>  			if (ret < 0)
>  				return ret;
>  			ctx->e.compressedblks =3D 0; /* indicate a fragment */
>  			ctx->e.raw =3D true;
> +			may_fixing =3D false;
>  		/* tailpcluster should be less than 1 block */
>  		} else if (may_inline && len =3D=3D ctx->e.length &&
>  			   ret < EROFS_BLKSIZ) {
> @@ -415,7 +457,27 @@ frag_packing:
>  		} else {
>  			unsigned int tailused, padding;
> =20
> -			if (may_inline && len =3D=3D ctx->e.length)
> +			tailused =3D ret & (EROFS_BLKSIZ - 1);
> +			/*
> +			 * If there's a space left for the last round when
> +			 * deduping fragments, try to read fragment and
> +			 * recompress a litte more to check whether it can be
> +			 * filled up. Fix the fragment if succeeds. Otherwise,
> +			 * just drop it and go to packing.
> +			 */
> +			if (may_packing && len =3D=3D ctx->e.length && tailused &&
> +			    ctx->tail < sizeof(ctx->queue)) {
> +				DBG_BUGON(!inode->fragment_size);
> +
> +				ctx->remaining =3D inode->fragment_size;
> +				ctx->pclustersize =3D
> +					BLK_ROUND_UP(ret) * EROFS_BLKSIZ;
> +				ctx->e.length =3D 0;
> +				ctx->need_fix =3D true;
> +				break;
> +			}
> +
> +			if (may_inline && len =3D=3D ctx->e.length && tailused)
>  				tryrecompress_trailing(ctx->queue + ctx->head,
>  						&ctx->e.length, dst, &ret);
> =20
> @@ -454,6 +516,21 @@ frag_packing:
>  		ctx->head +=3D ctx->e.length;
>  		len -=3D ctx->e.length;
> =20
> +		if (may_fixing)
> +			z_erofs_fragments_dedupe_update(ctx, &len);
> +
> +		/* generate a ctx for duplicate fragment */
> +		if (final && !len && inode->fragment_size && !may_packing) {
> +frag_nopacking:
> +			z_erofs_write_indexes(ctx);
> +
> +			ctx->e.length =3D inode->fragment_size;
> +			ctx->e.compressedblks =3D 0;
> +			ctx->e.raw =3D true;
> +			ctx->e.partial =3D false;
> +			ctx->e.blkaddr =3D ctx->blkaddr;
> +		}
> +
>  		if (!final && ctx->head >=3D EROFS_CONFIG_COMPR_MAX_SZ) {
>  			const unsigned int qh_aligned =3D
>  				round_down(ctx->head, EROFS_BLKSIZ);
> @@ -736,7 +813,6 @@ int erofs_write_compressed_file(struct erofs_inode *i=
node, int fd)
>  {
>  	struct erofs_buffer_head *bh;
>  	static struct z_erofs_vle_compress_ctx ctx;
> -	erofs_off_t remaining;
>  	erofs_blk_t blkaddr, compressed_blocks;
>  	unsigned int legacymetasize;
>  	int ret;
> @@ -775,6 +851,16 @@ int erofs_write_compressed_file(struct erofs_inode *=
inode, int fd)
>  	inode->idata_size =3D 0;
>  	inode->fragment_size =3D 0;
> =20
> +	/*
> +	 * Dedupe fragments before compression to avoid writing duplicate parts
> +	 * into packed inode.
> +	 */
> +	if (cfg.c_fragments && !erofs_is_packed_inode(inode)) {
> +		ret =3D z_erofs_fragments_dedupe(inode, fd, &ctx.tofcrc);
> +		if (ret < 0)
> +			goto err_bdrop;
> +	}
> +
>  	blkaddr =3D erofs_mapbh(bh->block);	/* start_blkaddr */
>  	ctx.inode =3D inode;
>  	ctx.blkaddr =3D blkaddr;
> @@ -782,10 +868,12 @@ int erofs_write_compressed_file(struct erofs_inode =
*inode, int fd)
>  	ctx.head =3D ctx.tail =3D 0;
>  	ctx.clusterofs =3D 0;
>  	ctx.e.length =3D 0;
> -	remaining =3D inode->i_size;
> +	ctx.pclustersize =3D z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ=
;
> +	ctx.remaining =3D inode->i_size - inode->fragment_size;
> +	ctx.need_fix =3D false;
> =20
> -	while (remaining) {
> -		const u64 readcount =3D min_t(u64, remaining,
> +	while (ctx.remaining) {
> +		const u64 readcount =3D min_t(u64, ctx.remaining,
>  					    sizeof(ctx.queue) - ctx.tail);
> =20
>  		ret =3D read(fd, ctx.queue + ctx.tail, readcount);
> @@ -793,10 +881,10 @@ int erofs_write_compressed_file(struct erofs_inode =
*inode, int fd)
>  			ret =3D -errno;
>  			goto err_bdrop;
>  		}
> -		remaining -=3D readcount;
> +		ctx.remaining -=3D readcount;
>  		ctx.tail +=3D readcount;
> =20
> -		ret =3D vle_compress_one(&ctx, !remaining);
> +		ret =3D vle_compress_one(&ctx);
>  		if (ret)
>  			goto err_free_idata;
>  	}
> @@ -807,6 +895,8 @@ int erofs_write_compressed_file(struct erofs_inode *i=
node, int fd)
>  	DBG_BUGON(compressed_blocks < !!inode->idata_size);
>  	compressed_blocks -=3D !!inode->idata_size;
> =20
> +	z_erofs_fragments_commit(inode);
> +
>  	z_erofs_write_indexes(&ctx);
>  	z_erofs_write_indexes_final(&ctx);
>  	legacymetasize =3D ctx.metacur - compressmeta;
> diff --git a/lib/fragments.c b/lib/fragments.c
> index b8c37d5..e50937c 100644
> --- a/lib/fragments.c
> +++ b/lib/fragments.c
> @@ -10,17 +10,181 @@
>  #include "erofs/inode.h"
>  #include "erofs/compress.h"
>  #include "erofs/print.h"
> +#include "erofs/internal.h"
>  #include "erofs/fragments.h"
> =20
> +struct erofs_fragment_dedupe_item {
> +	struct list_head	list;
> +	unsigned int		length, nr_dup;
> +	erofs_off_t		pos;
> +	u8			data[];
> +};
> +
> +#define FRAGMENT_HASHTABLE_SIZE		65536
> +#define FRAGMENT_HASH(crc)		(crc & (FRAGMENT_HASHTABLE_SIZE - 1))
> +
> +static struct list_head dupli_frags[FRAGMENT_HASHTABLE_SIZE];
> +static unsigned int len_to_hash; /* the fragment length for crc32 hash *=
/
> +
>  static FILE *packedfile;
>  const char *frags_packedname =3D "packed_file";
> =20
> -int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
> -			   unsigned int len)
> +static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int =
fd,
> +					 u32 crc)
>  {
> -	inode->z_advise |=3D Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
> -	inode->fragmentoff =3D ftell(packedfile);
> -	inode->fragment_size =3D len;
> +	struct erofs_fragment_dedupe_item *cur, *di =3D NULL;
> +	struct list_head *head;
> +	u8 *data;
> +	unsigned int length;
> +	int ret;
> +
> +	head =3D &dupli_frags[FRAGMENT_HASH(crc)];
> +	if (list_empty(head))
> +		return 0;
> +
> +	/* XXX: no need to read so much for smaller? */
> +	if (inode->i_size < EROFS_CONFIG_COMPR_MAX_SZ)
> +		length =3D inode->i_size;
> +	else
> +		length =3D EROFS_CONFIG_COMPR_MAX_SZ;
> +
> +	data =3D malloc(length);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	ret =3D lseek(fd, inode->i_size - length, SEEK_SET);
> +	if (ret =3D=3D -1) {
> +		ret =3D -errno;
> +		goto out;
> +	}
> +
> +	ret =3D read(fd, data, length);
> +	if (ret !=3D length) {
> +		ret =3D -errno;
> +		goto out;
> +	}
> +
> +	list_for_each_entry(cur, head, list) {
> +		unsigned int e1, e2, i =3D 0;
> +
> +		DBG_BUGON(cur->length < len_to_hash + 1);
> +		DBG_BUGON(length < len_to_hash + 1);
> +
> +		e1 =3D cur->length - len_to_hash - 1;
> +		e2 =3D length - len_to_hash - 1;
> +
> +		if (memcmp(cur->data + e1 + 1, data + e2 + 1, len_to_hash))
> +			continue;
> +
> +		while (i <=3D min(e1, e2) && cur->data[e1 - i] =3D=3D data[e2 - i])
> +			i++;
> +
> +		if (i && (!di || i + len_to_hash > di->nr_dup)) {
> +			cur->nr_dup =3D i + len_to_hash;
> +			di =3D cur;
> +
> +			/* full match */
> +			if (i =3D=3D min(e1, e2) + 1)
> +				break;
> +		}
> +	}
> +	if (!di)
> +		goto out;
> +
> +	DBG_BUGON(di->length < di->nr_dup);
> +
> +	inode->fragment_size =3D di->nr_dup;
> +	inode->fragmentoff =3D di->pos + di->length - di->nr_dup;
> +
> +	erofs_dbg("Dedupe %u fragment data at %lu", inode->fragment_size,
> +		  inode->fragmentoff);
> +out:
> +	free(data);
> +	return ret;
> +}
> +
> +int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tof=
crc_r)
> +{
> +	u8 data_to_hash[len_to_hash];
> +	u32 crc;
> +	int ret;
> +
> +	if (inode->i_size <=3D len_to_hash)
> +		return 0;
> +
> +	ret =3D lseek(fd, inode->i_size - len_to_hash, SEEK_SET);
> +	if (ret =3D=3D -1)
> +		return -errno;
> +
> +	ret =3D read(fd, data_to_hash, len_to_hash);
> +	if (ret !=3D len_to_hash)
> +		return -errno;
> +
> +	crc =3D erofs_crc32c(~0, data_to_hash, len_to_hash);
> +	*tofcrc_r =3D crc;
> +
> +	ret =3D z_erofs_fragments_dedupe_find(inode, fd, crc);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D lseek(fd, 0, SEEK_SET);
> +	if (ret =3D=3D -1)
> +		return -errno;
> +	return 0;
> +}
> +
> +static int z_erofs_fragments_dedupe_insert(void *data, unsigned int len,
> +					   erofs_off_t pos, u32 crc)
> +{
> +	struct erofs_fragment_dedupe_item *di;
> +
> +	if (len <=3D len_to_hash)
> +		return 0;
> +
> +	di =3D malloc(sizeof(*di) + len);
> +	if (!di)
> +		return -ENOMEM;
> +
> +	memcpy(di->data, data, len);
> +	di->length =3D len;
> +	di->pos =3D pos;
> +	di->nr_dup =3D 0;
> +
> +	list_add_tail(&di->list, &dupli_frags[FRAGMENT_HASH(crc)]);
> +	return 0;
> +}
> +
> +static inline void z_erofs_fragments_dedupe_init(unsigned int clen)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < FRAGMENT_HASHTABLE_SIZE; ++i)
> +		init_list_head(&dupli_frags[i]);
> +
> +	len_to_hash =3D clen;
> +}
> +
> +static void z_erofs_fragments_dedupe_exit(void)
> +{
> +	struct erofs_fragment_dedupe_item *di, *n;
> +	struct list_head *head;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < FRAGMENT_HASHTABLE_SIZE; ++i) {
> +		head =3D &dupli_frags[i];
> +
> +		if (list_empty(head))
> +			continue;
> +
> +		list_for_each_entry_safe(di, n, head, list)
> +			free(di);
> +	}
> +}
> +
> +void z_erofs_fragments_commit(struct erofs_inode *inode)
> +{
> +	if (!inode->fragment_size)
> +		return;
>  	/*
>  	 * If the packed inode is larger than 4GiB, the full fragmentoff
>  	 * will be recorded by switching to the noncompact layout anyway.
> @@ -28,13 +192,28 @@ int z_erofs_pack_fragments(struct erofs_inode *inode=
, void *data,
>  	if (inode->fragmentoff >> 32)
>  		inode->datalayout =3D EROFS_INODE_FLAT_COMPRESSION_LEGACY;
> =20
> +	inode->z_advise |=3D Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
> +	erofs_sb_set_fragments();
> +}
> +
> +int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
> +			   unsigned int len, u32 tofcrc)
> +{
> +	int ret;
> +
> +	inode->fragmentoff =3D ftell(packedfile);
> +	inode->fragment_size =3D len;
> +
>  	if (fwrite(data, len, 1, packedfile) !=3D 1)
>  		return -EIO;
> =20
> -	erofs_sb_set_fragments();
> -
>  	erofs_dbg("Recording %u fragment data at %lu", inode->fragment_size,
>  		  inode->fragmentoff);
> +
> +	ret =3D z_erofs_fragments_dedupe_insert(data, len, inode->fragmentoff,
> +					      tofcrc);
> +	if (ret)
> +		return ret;
>  	return len;
>  }
> =20
> @@ -50,6 +229,8 @@ void erofs_fragments_exit(void)
>  {
>  	if (packedfile)
>  		fclose(packedfile);
> +
> +	z_erofs_fragments_dedupe_exit();
>  }
> =20
>  int erofs_fragments_init(void)
> @@ -61,5 +242,7 @@ int erofs_fragments_init(void)
>  #endif
>  	if (!packedfile)
>  		return -ENOMEM;
> +
> +	z_erofs_fragments_dedupe_init(16);
>  	return 0;
>  }
--57346fd42101a9635370fa39b970577ccd92389d852fce3133fd003348b5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<p>Add a missing change:
<br>- change to generate a ctx for duplicate fragment in compression.
<br>
<br>On Thu,  1 Dec 2022 19:16:15 +0800
<br>Yue Hu <zbestahu@gmail.com> wrote:
<br>
<br>> From: Yue Hu <huyue2@coolpad.com>
<br>>=20
<br>> Previously, there's no fragment deduplication when this feature is
<br>> introduced. Let's support it now.
<br>>=20
<br>> We intend to dedupe the fragments before compression, so that duplica=
te
<br>> parts will not be written into packed inode.
<br>>=20
<br>> With this patch, for Linux 5.10.1 + 5.10.87 source code:
<br>>=20
<br>> [before]
<br>>  32k pcluster + T0 + lz4hc,12 + fragment		450M
<br>>  64k pcluster + T0 + lz4hc,12 + fragment		434M
<br>> 128k pcluster + T0 + lz4hc,12 + fragment		426M
<br>>  32k pcluster + T0 + lz4hc,12 + fragment + dedupe	368M
<br>>  64k pcluster + T0 + lz4hc,12 + fragment + dedupe	380M
<br>> 128k pcluster + T0 + lz4hc,12 + fragment + dedupe	395M
<br>>=20
<br>> [after]
<br>>  32k pcluster + T0 + lz4hc,12 + fragment		311M
<br>>  64k pcluster + T0 + lz4hc,12 + fragment		295M
<br>> 128k pcluster + T0 + lz4hc,12 + fragment		287M
<br>>  32k pcluster + T0 + lz4hc,12 + fragment + dedupe	286M
<br>>  64k pcluster + T0 + lz4hc,12 + fragment + dedupe	281M
<br>> 128k pcluster + T0 + lz4hc,12 + fragment + dedupe	278M
<br>>=20
<br>> Tested on SquashFS (which uses level 12 by default for lz4hc):
<br>>=20
<br>>  32k block + lz4hc		332M
<br>>  64k block + lz4hc		304M
<br>> 128k block + lz4hc		283M
<br>> 256k block + lz4hc		273M
<br>> 256k block + lz4hc + noI	278M
<br>>=20
<br>> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
<br>> Signed-off-by: Yue Hu <huyue2@coolpad.com>
<br>> ---
<br>> v4:
<br>> - renaming include tofcrc/new_fragmentsize
<br>> - move fixup into ctx
<br>> - use may_fixing to check packing fragment or not
<br>> - move sb/inode flag + 64bits case from erofs_pack_fragments() to new
<br>>   helper erofs_fragments_commit()
<br>> - move recompress ahead of may_inline case when compressing succeeds
<br>> - update commit message/code comments
<br>> - note that decompress will fail when enable ztailpacking at the same
<br>>   time, need some time to debug
<br>>=20
<br>> v3:
<br>> - modify acrroding to Xiang's comments in v2
<br>> - simplify the logic in vle_compress_one
<br>> - fix the crash for 1MB pcluster
<br>>=20
<br>> v2: mainly improve the logic in compression
<br>>=20
<br>>  include/erofs/fragments.h |   4 +-
<br>>  lib/compress.c            | 134 +++++++++++++++++++++-----
<br>>  lib/fragments.c           | 197 ++++++++++++++++++++++++++++++++++++=
--
<br>>  3 files changed, 305 insertions(+), 30 deletions(-)
<br>>=20
<br>> diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
<br>> index 5444384..e91fb31 100644
<br>> --- a/include/erofs/fragments.h
<br>> +++ b/include/erofs/fragments.h
<br>> @@ -15,8 +15,10 @@ extern "C"
<br>>  extern const char *frags_packedname;
<br>>  #define EROFS_PACKED_INODE	frags_packedname
<br>> =20
<br>> +int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 =
*tofcrc_r);
<br>>  int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
<br>> -			   unsigned int len);
<br>> +			   unsigned int len, u32 tofcrc);
<br>> +void z_erofs_fragments_commit(struct erofs_inode *inode);
<br>>  struct erofs_inode *erofs_mkfs_build_fragments(void);
<br>>  int erofs_fragments_init(void);
<br>>  void erofs_fragments_exit(void);
<br>> diff --git a/lib/compress.c b/lib/compress.c
<br>> index 17b3213..afd6e8e 100644
<br>> --- a/lib/compress.c
<br>> +++ b/lib/compress.c
<br>> @@ -33,6 +33,11 @@ struct z_erofs_vle_compress_ctx {
<br>>  	unsigned int head, tail;
<br>>  	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
<br>>  	u16 clusterofs;
<br>> +
<br>> +	u32 tofcrc;
<br>> +	unsigned int pclustersize;
<br>> +	erofs_off_t remaining;
<br>> +	bool need_fix;
<br>>  };
<br>> =20
<br>>  #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	\
<br>> @@ -162,10 +167,10 @@ static void z_erofs_write_indexes(struct z_erof=
s_vle_compress_ctx *ctx)
<br>>  	ctx->clusterofs =3D clusterofs + count;
<br>>  }
<br>> =20
<br>> -static int z_erofs_compress_dedupe(struct erofs_inode *inode,
<br>> -				   struct z_erofs_vle_compress_ctx *ctx,
<br>> +static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *=
ctx,
<br>>  				   unsigned int *len)
<br>>  {
<br>> +	struct erofs_inode *inode =3D ctx->inode;
<br>>  	int ret =3D 0;
<br>> =20
<br>>  	do {
<br>> @@ -301,10 +306,6 @@ static void tryrecompress_trailing(void *in, uns=
igned int *insize,
<br>>  	unsigned int count;
<br>>  	int ret =3D *compressedsize;
<br>> =20
<br>> -	/* no need to recompress */
<br>> -	if (!(ret & (EROFS_BLKSIZ - 1)))
<br>> -		return;
<br>> -
<br>>  	count =3D *insize;
<br>>  	ret =3D erofs_compress_destsize(&compresshandle,
<br>>  				      in, &count, (void *)tmp,
<br>> @@ -319,30 +320,69 @@ static void tryrecompress_trailing(void *in, un=
signed int *insize,
<br>>  	*compressedsize =3D ret;
<br>>  }
<br>> =20
<br>> -static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx,
<br>> -			    bool final)
<br>> +static void z_erofs_fragments_dedupe_update(struct z_erofs_vle_compr=
ess_ctx *ctx,
<br>> +					    unsigned int *len)
<br>> +{
<br>> +	struct erofs_inode *inode =3D ctx->inode;
<br>> +	const unsigned int new_fragmentsize =3D ctx->remaining + *len;
<br>> +
<br>> +	DBG_BUGON(!inode->fragment_size);
<br>> +
<br>> +	/* try to fix it again if it gets larger (should be rare) */
<br>> +	if (inode->fragment_size < new_fragmentsize) {
<br>> +		ctx->pclustersize =3D
<br>> +			roundup(new_fragmentsize - inode->fragment_size,
<br>> +				EROFS_BLKSIZ);
<br>> +		return;
<br>> +	}
<br>> +
<br>> +	inode->fragmentoff +=3D inode->fragment_size - new_fragmentsize;
<br>> +	inode->fragment_size =3D new_fragmentsize;
<br>> +
<br>> +	erofs_dbg("Reducing fragment size to %u at %lu",
<br>> +		  inode->fragment_size, inode->fragmentoff);
<br>> +
<br>> +	/* it's ending */
<br>> +	ctx->head +=3D new_fragmentsize;
<br>> +	ctx->remaining =3D 0;
<br>> +	*len =3D 0;
<br>> +}
<br>> +
<br>> +static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
<br>>  {
<br>>  	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
<br>>  	struct erofs_inode *inode =3D ctx->inode;
<br>>  	char *const dst =3D dstbuf + EROFS_BLKSIZ;
<br>>  	struct erofs_compress *const h =3D &compresshandle;
<br>>  	unsigned int len =3D ctx->tail - ctx->head;
<br>> +	bool final =3D !ctx->remaining;
<br>>  	int ret;
<br>> =20
<br>>  	while (len) {
<br>> -		unsigned int pclustersize =3D
<br>> -			z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
<br>>  		bool may_inline =3D (cfg.c_ztailpacking && final);
<br>>  		bool may_packing =3D (cfg.c_fragments && final &&
<br>>  				   !erofs_is_packed_inode(inode));
<br>> +		bool may_fixing =3D ctx->need_fix;
<br>> =20
<br>> -		if (z_erofs_compress_dedupe(inode, ctx, &len) && !final)
<br>> +		if (z_erofs_compress_dedupe(ctx, &len) && !final)
<br>>  			break;
<br>> =20
<br>> -		if (len <=3D pclustersize) {
<br>> +		if (len <=3D ctx->pclustersize) {
<br>> +			if (may_fixing && !len) {
<br>> +				may_packing =3D false;
<br>> +				goto frag_nopacking;
<br>> +			}
<br>>  			if (!final || !len)
<br>>  				break;
<br>>  			if (may_packing) {
<br>> +				if (inode->fragment_size && !may_fixing) {
<br>> +					ctx->remaining =3D inode->fragment_size;
<br>> +					ctx->pclustersize =3D
<br>> +						roundup(len, EROFS_BLKSIZ);
<br>> +					ctx->e.length =3D 0;
<br>> +					ctx->need_fix =3D true;
<br>> +					break;
<br>> +				}
<br>>  				ctx->e.length =3D len;
<br>>  				goto frag_packing;
<br>>  			}
<br>> @@ -353,7 +393,7 @@ static int vle_compress_one(struct z_erofs_vle_co=
mpress_ctx *ctx,
<br>>  		ctx->e.length =3D min(len,
<br>>  				cfg.c_max_decompressed_extent_bytes);
<br>>  		ret =3D erofs_compress_destsize(h, ctx->queue + ctx->head,
<br>> -				&ctx->e.length, dst, pclustersize,
<br>> +				&ctx->e.length, dst, ctx->pclustersize,
<br>>  				!(final && len =3D=3D ctx->e.length));
<br>>  		if (ret <=3D 0) {
<br>>  			if (ret !=3D -EAGAIN) {
<br>> @@ -385,15 +425,17 @@ nocompression:
<br>>  			ctx->e.compressedblks =3D 1;
<br>>  			ctx->e.raw =3D true;
<br>>  		} else if (may_packing && len =3D=3D ctx->e.length &&
<br>> -			   ret < pclustersize) {
<br>> +			   ret < ctx->pclustersize && (!inode->fragment_size ||
<br>> +			   may_fixing)) {
<br>>  frag_packing:
<br>>  			ret =3D z_erofs_pack_fragments(inode,
<br>>  						     ctx->queue + ctx->head,
<br>> -						     len);
<br>> +						     len, ctx->tofcrc);
<br>>  			if (ret < 0)
<br>>  				return ret;
<br>>  			ctx->e.compressedblks =3D 0; /* indicate a fragment */
<br>>  			ctx->e.raw =3D true;
<br>> +			may_fixing =3D false;
<br>>  		/* tailpcluster should be less than 1 block */
<br>>  		} else if (may_inline && len =3D=3D ctx->e.length &&
<br>>  			   ret < EROFS_BLKSIZ) {
<br>> @@ -415,7 +457,27 @@ frag_packing:
<br>>  		} else {
<br>>  			unsigned int tailused, padding;
<br>> =20
<br>> -			if (may_inline && len =3D=3D ctx->e.length)
<br>> +			tailused =3D ret & (EROFS_BLKSIZ - 1);
<br>> +			/*
<br>> +			 * If there's a space left for the last round when
<br>> +			 * deduping fragments, try to read fragment and
<br>> +			 * recompress a litte more to check whether it can be
<br>> +			 * filled up. Fix the fragment if succeeds. Otherwise,
<br>> +			 * just drop it and go to packing.
<br>> +			 */
<br>> +			if (may_packing && len =3D=3D ctx->e.length && tailused &&
<br>> +			    ctx->tail < sizeof(ctx->queue)) {
<br>> +				DBG_BUGON(!inode->fragment_size);
<br>> +
<br>> +				ctx->remaining =3D inode->fragment_size;
<br>> +				ctx->pclustersize =3D
<br>> +					BLK_ROUND_UP(ret) * EROFS_BLKSIZ;
<br>> +				ctx->e.length =3D 0;
<br>> +				ctx->need_fix =3D true;
<br>> +				break;
<br>> +			}
<br>> +
<br>> +			if (may_inline && len =3D=3D ctx->e.length && tailused)
<br>>  				tryrecompress_trailing(ctx->queue + ctx->head,
<br>>  						&ctx->e.length, dst, &ret);
<br>> =20
<br>> @@ -454,6 +516,21 @@ frag_packing:
<br>>  		ctx->head +=3D ctx->e.length;
<br>>  		len -=3D ctx->e.length;
<br>> =20
<br>> +		if (may_fixing)
<br>> +			z_erofs_fragments_dedupe_update(ctx, &len);
<br>> +
<br>> +		/* generate a ctx for duplicate fragment */
<br>> +		if (final && !len && inode->fragment_size && !may_packing) {
<br>> +frag_nopacking:
<br>> +			z_erofs_write_indexes(ctx);
<br>> +
<br>> +			ctx->e.length =3D inode->fragment_size;
<br>> +			ctx->e.compressedblks =3D 0;
<br>> +			ctx->e.raw =3D true;
<br>> +			ctx->e.partial =3D false;
<br>> +			ctx->e.blkaddr =3D ctx->blkaddr;
<br>> +		}
<br>> +
<br>>  		if (!final && ctx->head >=3D EROFS_CONFIG_COMPR_MAX_SZ) {
<br>>  			const unsigned int qh_aligned =3D
<br>>  				round_down(ctx->head, EROFS_BLKSIZ);
<br>> @@ -736,7 +813,6 @@ int erofs_write_compressed_file(struct erofs_inod=
e *inode, int fd)
<br>>  {
<br>>  	struct erofs_buffer_head *bh;
<br>>  	static struct z_erofs_vle_compress_ctx ctx;
<br>> -	erofs_off_t remaining;
<br>>  	erofs_blk_t blkaddr, compressed_blocks;
<br>>  	unsigned int legacymetasize;
<br>>  	int ret;
<br>> @@ -775,6 +851,16 @@ int erofs_write_compressed_file(struct erofs_ino=
de *inode, int fd)
<br>>  	inode->idata_size =3D 0;
<br>>  	inode->fragment_size =3D 0;
<br>> =20
<br>> +	/*
<br>> +	 * Dedupe fragments before compression to avoid writing duplicate p=
arts
<br>> +	 * into packed inode.
<br>> +	 */
<br>> +	if (cfg.c_fragments && !erofs_is_packed_inode(inode)) {
<br>> +		ret =3D z_erofs_fragments_dedupe(inode, fd, &ctx.tofcrc);
<br>> +		if (ret < 0)
<br>> +			goto err_bdrop;
<br>> +	}
<br>> +
<br>>  	blkaddr =3D erofs_mapbh(bh->block);	/* start_blkaddr */
<br>>  	ctx.inode =3D inode;
<br>>  	ctx.blkaddr =3D blkaddr;
<br>> @@ -782,10 +868,12 @@ int erofs_write_compressed_file(struct erofs_in=
ode *inode, int fd)
<br>>  	ctx.head =3D ctx.tail =3D 0;
<br>>  	ctx.clusterofs =3D 0;
<br>>  	ctx.e.length =3D 0;
<br>> -	remaining =3D inode->i_size;
<br>> +	ctx.pclustersize =3D z_erofs_get_max_pclusterblks(inode) * EROFS_BL=
KSIZ;
<br>> +	ctx.remaining =3D inode->i_size - inode->fragment_size;
<br>> +	ctx.need_fix =3D false;
<br>> =20
<br>> -	while (remaining) {
<br>> -		const u64 readcount =3D min_t(u64, remaining,
<br>> +	while (ctx.remaining) {
<br>> +		const u64 readcount =3D min_t(u64, ctx.remaining,
<br>>  					    sizeof(ctx.queue) - ctx.tail);
<br>> =20
<br>>  		ret =3D read(fd, ctx.queue + ctx.tail, readcount);
<br>> @@ -793,10 +881,10 @@ int erofs_write_compressed_file(struct erofs_in=
ode *inode, int fd)
<br>>  			ret =3D -errno;
<br>>  			goto err_bdrop;
<br>>  		}
<br>> -		remaining -=3D readcount;
<br>> +		ctx.remaining -=3D readcount;
<br>>  		ctx.tail +=3D readcount;
<br>> =20
<br>> -		ret =3D vle_compress_one(&ctx, !remaining);
<br>> +		ret =3D vle_compress_one(&ctx);
<br>>  		if (ret)
<br>>  			goto err_free_idata;
<br>>  	}
<br>> @@ -807,6 +895,8 @@ int erofs_write_compressed_file(struct erofs_inod=
e *inode, int fd)
<br>>  	DBG_BUGON(compressed_blocks < !!inode->idata_size);
<br>>  	compressed_blocks -=3D !!inode->idata_size;
<br>> =20
<br>> +	z_erofs_fragments_commit(inode);
<br>> +
<br>>  	z_erofs_write_indexes(&ctx);
<br>>  	z_erofs_write_indexes_final(&ctx);
<br>>  	legacymetasize =3D ctx.metacur - compressmeta;
<br>> diff --git a/lib/fragments.c b/lib/fragments.c
<br>> index b8c37d5..e50937c 100644
<br>> --- a/lib/fragments.c
<br>> +++ b/lib/fragments.c
<br>> @@ -10,17 +10,181 @@
<br>>  #include "erofs/inode.h"
<br>>  #include "erofs/compress.h"
<br>>  #include "erofs/print.h"
<br>> +#include "erofs/internal.h"
<br>>  #include "erofs/fragments.h"
<br>> =20
<br>> +struct erofs_fragment_dedupe_item {
<br>> +	struct list_head	list;
<br>> +	unsigned int		length, nr_dup;
<br>> +	erofs_off_t		pos;
<br>> +	u8			data[];
<br>> +};
<br>> +
<br>> +#define FRAGMENT_HASHTABLE_SIZE		65536
<br>> +#define FRAGMENT_HASH(crc)		(crc & (FRAGMENT_HASHTABLE_SIZE - 1))
<br>> +
<br>> +static struct list_head dupli_frags[FRAGMENT_HASHTABLE_SIZE];
<br>> +static unsigned int len_to_hash; /* the fragment length for crc32 ha=
sh */
<br>> +
<br>>  static FILE *packedfile;
<br>>  const char *frags_packedname =3D "packed_file";
<br>> =20
<br>> -int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
<br>> -			   unsigned int len)
<br>> +static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, =
int fd,
<br>> +					 u32 crc)
<br>>  {
<br>> -	inode->z_advise |=3D Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
<br>> -	inode->fragmentoff =3D ftell(packedfile);
<br>> -	inode->fragment_size =3D len;
<br>> +	struct erofs_fragment_dedupe_item *cur, *di =3D NULL;
<br>> +	struct list_head *head;
<br>> +	u8 *data;
<br>> +	unsigned int length;
<br>> +	int ret;
<br>> +
<br>> +	head =3D &dupli_frags[FRAGMENT_HASH(crc)];
<br>> +	if (list_empty(head))
<br>> +		return 0;
<br>> +
<br>> +	/* XXX: no need to read so much for smaller? */
<br>> +	if (inode->i_size < EROFS_CONFIG_COMPR_MAX_SZ)
<br>> +		length =3D inode->i_size;
<br>> +	else
<br>> +		length =3D EROFS_CONFIG_COMPR_MAX_SZ;
<br>> +
<br>> +	data =3D malloc(length);
<br>> +	if (!data)
<br>> +		return -ENOMEM;
<br>> +
<br>> +	ret =3D lseek(fd, inode->i_size - length, SEEK_SET);
<br>> +	if (ret =3D=3D -1) {
<br>> +		ret =3D -errno;
<br>> +		goto out;
<br>> +	}
<br>> +
<br>> +	ret =3D read(fd, data, length);
<br>> +	if (ret !=3D length) {
<br>> +		ret =3D -errno;
<br>> +		goto out;
<br>> +	}
<br>> +
<br>> +	list_for_each_entry(cur, head, list) {
<br>> +		unsigned int e1, e2, i =3D 0;
<br>> +
<br>> +		DBG_BUGON(cur->length < len_to_hash + 1);
<br>> +		DBG_BUGON(length < len_to_hash + 1);
<br>> +
<br>> +		e1 =3D cur->length - len_to_hash - 1;
<br>> +		e2 =3D length - len_to_hash - 1;
<br>> +
<br>> +		if (memcmp(cur->data + e1 + 1, data + e2 + 1, len_to_hash))
<br>> +			continue;
<br>> +
<br>> +		while (i <=3D min(e1, e2) && cur->data[e1 - i] =3D=3D data[e2 - i]=
)
<br>> +			i++;
<br>> +
<br>> +		if (i && (!di || i + len_to_hash > di->nr_dup)) {
<br>> +			cur->nr_dup =3D i + len_to_hash;
<br>> +			di =3D cur;
<br>> +
<br>> +			/* full match */
<br>> +			if (i =3D=3D min(e1, e2) + 1)
<br>> +				break;
<br>> +		}
<br>> +	}
<br>> +	if (!di)
<br>> +		goto out;
<br>> +
<br>> +	DBG_BUGON(di->length < di->nr_dup);
<br>> +
<br>> +	inode->fragment_size =3D di->nr_dup;
<br>> +	inode->fragmentoff =3D di->pos + di->length - di->nr_dup;
<br>> +
<br>> +	erofs_dbg("Dedupe %u fragment data at %lu", inode->fragment_size,
<br>> +		  inode->fragmentoff);
<br>> +out:
<br>> +	free(data);
<br>> +	return ret;
<br>> +}
<br>> +
<br>> +int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 =
*tofcrc_r)
<br>> +{
<br>> +	u8 data_to_hash[len_to_hash];
<br>> +	u32 crc;
<br>> +	int ret;
<br>> +
<br>> +	if (inode->i_size <=3D len_to_hash)
<br>> +		return 0;
<br>> +
<br>> +	ret =3D lseek(fd, inode->i_size - len_to_hash, SEEK_SET);
<br>> +	if (ret =3D=3D -1)
<br>> +		return -errno;
<br>> +
<br>> +	ret =3D read(fd, data_to_hash, len_to_hash);
<br>> +	if (ret !=3D len_to_hash)
<br>> +		return -errno;
<br>> +
<br>> +	crc =3D erofs_crc32c(~0, data_to_hash, len_to_hash);
<br>> +	*tofcrc_r =3D crc;
<br>> +
<br>> +	ret =3D z_erofs_fragments_dedupe_find(inode, fd, crc);
<br>> +	if (ret < 0)
<br>> +		return ret;
<br>> +
<br>> +	ret =3D lseek(fd, 0, SEEK_SET);
<br>> +	if (ret =3D=3D -1)
<br>> +		return -errno;
<br>> +	return 0;
<br>> +}
<br>> +
<br>> +static int z_erofs_fragments_dedupe_insert(void *data, unsigned int =
len,
<br>> +					   erofs_off_t pos, u32 crc)
<br>> +{
<br>> +	struct erofs_fragment_dedupe_item *di;
<br>> +
<br>> +	if (len <=3D len_to_hash)
<br>> +		return 0;
<br>> +
<br>> +	di =3D malloc(sizeof(*di) + len);
<br>> +	if (!di)
<br>> +		return -ENOMEM;
<br>> +
<br>> +	memcpy(di->data, data, len);
<br>> +	di->length =3D len;
<br>> +	di->pos =3D pos;
<br>> +	di->nr_dup =3D 0;
<br>> +
<br>> +	list_add_tail(&di->list, &dupli_frags[FRAGMENT_HASH(crc)]);
<br>> +	return 0;
<br>> +}
<br>> +
<br>> +static inline void z_erofs_fragments_dedupe_init(unsigned int clen)
<br>> +{
<br>> +	unsigned int i;
<br>> +
<br>> +	for (i =3D 0; i < FRAGMENT_HASHTABLE_SIZE; ++i)
<br>> +		init_list_head(&dupli_frags[i]);
<br>> +
<br>> +	len_to_hash =3D clen;
<br>> +}
<br>> +
<br>> +static void z_erofs_fragments_dedupe_exit(void)
<br>> +{
<br>> +	struct erofs_fragment_dedupe_item *di, *n;
<br>> +	struct list_head *head;
<br>> +	unsigned int i;
<br>> +
<br>> +	for (i =3D 0; i < FRAGMENT_HASHTABLE_SIZE; ++i) {
<br>> +		head =3D &dupli_frags[i];
<br>> +
<br>> +		if (list_empty(head))
<br>> +			continue;
<br>> +
<br>> +		list_for_each_entry_safe(di, n, head, list)
<br>> +			free(di);
<br>> +	}
<br>> +}
<br>> +
<br>> +void z_erofs_fragments_commit(struct erofs_inode *inode)
<br>> +{
<br>> +	if (!inode->fragment_size)
<br>> +		return;
<br>>  	/*
<br>>  	 * If the packed inode is larger than 4GiB, the full fragmentoff
<br>>  	 * will be recorded by switching to the noncompact layout anyway.
<br>> @@ -28,13 +192,28 @@ int z_erofs_pack_fragments(struct erofs_inode *i=
node, void *data,
<br>>  	if (inode->fragmentoff >> 32)
<br>>  		inode->datalayout =3D EROFS_INODE_FLAT_COMPRESSION_LEGACY;
<br>> =20
<br>> +	inode->z_advise |=3D Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
<br>> +	erofs_sb_set_fragments();
<br>> +}
<br>> +
<br>> +int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
<br>> +			   unsigned int len, u32 tofcrc)
<br>> +{
<br>> +	int ret;
<br>> +
<br>> +	inode->fragmentoff =3D ftell(packedfile);
<br>> +	inode->fragment_size =3D len;
<br>> +
<br>>  	if (fwrite(data, len, 1, packedfile) !=3D 1)
<br>>  		return -EIO;
<br>> =20
<br>> -	erofs_sb_set_fragments();
<br>> -
<br>>  	erofs_dbg("Recording %u fragment data at %lu", inode->fragment_size=
,
<br>>  		  inode->fragmentoff);
<br>> +
<br>> +	ret =3D z_erofs_fragments_dedupe_insert(data, len, inode->fragmento=
ff,
<br>> +					      tofcrc);
<br>> +	if (ret)
<br>> +		return ret;
<br>>  	return len;
<br>>  }
<br>> =20
<br>> @@ -50,6 +229,8 @@ void erofs_fragments_exit(void)
<br>>  {
<br>>  	if (packedfile)
<br>>  		fclose(packedfile);
<br>> +
<br>> +	z_erofs_fragments_dedupe_exit();
<br>>  }
<br>> =20
<br>>  int erofs_fragments_init(void)
<br>> @@ -61,5 +242,7 @@ int erofs_fragments_init(void)
<br>>  #endif
<br>>  	if (!packedfile)
<br>>  		return -ENOMEM;
<br>> +
<br>> +	z_erofs_fragments_dedupe_init(16);
<br>>  	return 0;
<br>>  }</p><meta data-version=3D"editor_version_1.2.11"/><div data-zone-id=
=3D"0" data-line-index=3D"0" data-line=3D"true" style=3D"white-space: pre-w=
rap; margin-top: 4px; margin-bottom: 4px; line-height: 1.6;">------=E6=9C=
=BA=E5=AF=86=EF=BC=9A=E6=AD=A4=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E6=89=80=
=E5=8C=85=E5=90=AB=E5=86=85=E5=AE=B9=E4=B8=BA=E9=85=B7=E6=B4=BE=E6=9C=BA=E5=
=AF=86=E5=86=85=E5=AE=B9,=E5=B9=B6=E4=B8=94=E5=8F=97=E5=88=B0=E6=B3=95=E5=
=BE=8B=E7=9A=84=E4=BF=9D=E6=8A=A4=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E4=B8=
=8D=E5=B1=9E=E4=BA=8E=E4=BB=A5=E4=B8=8A=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=
=E7=9A=84=E7=9B=AE=E6=A0=87=E6=8E=A5=E6=94=B6=E8=80=85=EF=BC=8C=E6=82=A8=E4=
=B8=8D=E5=BE=97=E7=BB=86=E8=AF=BB=EF=BC=8C=E4=BD=BF=E7=94=A8=EF=BC=8C=E4=BC=
=A0=E6=92=AD=EF=BC=8C=E6=95=A3=E5=B8=83=E6=88=96=E5=A4=8D=E5=88=B6=E8=AF=A5=
=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BB=BB=E4=BD=95=E4=
=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E5=B7=B2=E7=BB=8F=E8=AF=
=AF=E6=94=B6=E6=AD=A4=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=
=E6=82=A8=E7=AB=8B=E5=8D=B3=E9=80=9A=E7=9F=A5=E6=88=91=E4=BB=AC=E5=B9=B6=E5=
=88=A0=E9=99=A4=E5=8E=9F=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E3=80=82 CONFI=
DENTIAL: This e-mail message contains information of Coolpad that is confid=
ential and which is subject to legal privilege.If you are not the intended =
recipient as indicated above,you must not peruse,use, disseminate,distribut=
e or copy any information contained in this message.If you have received th=
is message in error, please notify us and delete the original message immed=
iately.
</div><div data-zone-id=3D"0" data-line-index=3D"1" data-line=3D"true" styl=
e=3D"white-space: pre-wrap; margin-top: 4px; margin-bottom: 4px; line-heigh=
t: 1.6;">------ =E7=94=B3=E6=98=8E=EF=BC=9A=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=
=89=80=E7=8E=B0=E5=86=85=E5=AE=B9=EF=BC=8C=E4=BB=85=E4=BD=9C=E4=B8=BA=E6=88=
=91=E4=BB=AC=E4=B9=8B=E9=97=B4=E5=B0=B1=E5=90=88=E4=BD=9C=E7=9A=84=E4=BA=8B=
=E5=AE=9C=E8=BF=9B=E8=A1=8C=E7=9A=84=E4=BA=A4=E6=B5=81=E3=80=81=E6=B2=9F=E9=
=80=9A=E3=80=81=E6=B4=BD=E8=B0=88=E3=80=81=E5=95=86=E8=AE=AE=EF=BC=8C=E4=B8=
=8D=E4=BD=9C=E4=B8=BA=E5=8D=8F=E8=AE=AE=E6=88=96=E6=89=BF=E8=AF=BA=EF=BC=8C=
=E4=B8=80=E5=88=87=E5=8D=8F=E8=AE=AE=E5=8F=8A=E6=89=BF=E8=AF=BA=E5=BF=85=E9=
=A1=BB=E4=BB=A5=E4=B9=A6=E9=9D=A2=E6=96=87=E6=9C=AC=E7=9B=96=E7=AB=A0=E4=B8=
=BA=E5=87=86=E3=80=82 DECLARATION=EF=BC=9AAll contents of this E-mail ,are =
only regarded as the cooperation we have had between the exchanges, communi=
cation, negotiation and deliberation, not as a agreement or promise. All co=
ntracts and commitments must be  sealed shall prevail.
</div>
--57346fd42101a9635370fa39b970577ccd92389d852fce3133fd003348b5--
