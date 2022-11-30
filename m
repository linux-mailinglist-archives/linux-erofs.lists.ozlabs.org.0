Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6896263D0A2
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 09:29:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NMXSQ1jNNz3bVK
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Nov 2022 19:29:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.5; helo=out199-5.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
X-Greylist: delayed 306 seconds by postgrey-1.36 at boromir; Wed, 30 Nov 2022 19:29:35 AEDT
Received: from out199-5.us.a.mail.aliyun.com (out199-5.us.a.mail.aliyun.com [47.90.199.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NMXSH4wTfz2y84
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Nov 2022 19:29:34 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VW2JFLX_1669796658;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VW2JFLX_1669796658)
          by smtp.aliyun-inc.com;
          Wed, 30 Nov 2022 16:24:20 +0800
Date: Wed, 30 Nov 2022 16:24:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH v3] erofs-utils: mkfs: support fragment deduplication
Message-ID: <Y4cTKeWowrg9FySM@B-P7TQMD6M-0146.local>
References: <20221129100053.10665-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221129100053.10665-1-zbestahu@gmail.com>
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

On Tue, Nov 29, 2022 at 06:00:53PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Previously, there's no fragment deduplication when this feature is
> introduced. Let's support it now.
> 
> With this patch, for Linux 5.10.1 + 5.10.87 source code:
> 

Please add EROFS -T0 to retest 32 byte inode results.

Also add Squashfs + LZ4HC results as a comparison.

> [before]
>  32k pcluster + lz4hc,12 + fragment		454M
>  64k pcluster + lz4hc,12 + fragment		439M
> 128k pcluster + lz4hc,12 + fragment		431M
>  32k pcluster + lz4hc,12 + fragment + dedupe	376M
>  64k pcluster + lz4hc,12 + fragment + dedupe	384M
> 128k pcluster + lz4hc,12 + fragment + dedupe	399M
> 
> [after]
>  32k pcluster + lz4hc,12 + fragment		316M
>  64k pcluster + lz4hc,12 + fragment		300M
> 128k pcluster + lz4hc,12 + fragment		292M
>  32k pcluster + lz4hc,12 + fragment + dedupe	291M
>  64k pcluster + lz4hc,12 + fragment + dedupe	286M
> 128k pcluster + lz4hc,12 + fragment + dedupe	283M
> 
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
> v3: 
> - modify acrroding to Xiang's comments in v2
> - simplify the logic in vle_compress_one
> - fix the crash for 1MB pcluster
> 
> v2: mainly improve the logic in compression
> 
>  include/erofs/fragments.h |   3 +-
>  lib/compress.c            | 115 ++++++++++++++++++++----
>  lib/fragments.c           | 180 +++++++++++++++++++++++++++++++++++++-
>  3 files changed, 277 insertions(+), 21 deletions(-)
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

						^ tofcrc

tail of file crc

>  struct erofs_inode *erofs_mkfs_build_fragments(void);
>  int erofs_fragments_init(void);
>  void erofs_fragments_exit(void);
> diff --git a/lib/compress.c b/lib/compress.c
> index 17b3213..7e01932 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -33,6 +33,10 @@ struct z_erofs_vle_compress_ctx {
>  	unsigned int head, tail;
>  	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
>  	u16 clusterofs;
> +
> +	u32 crc;

	tofcrc;

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
> @@ -319,30 +323,62 @@ static void tryrecompress_trailing(void *in, unsigned int *insize,
>  	*compressedsize = ret;
>  }
>  
> -static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx,
> -			    bool final)
> +static void z_erofs_fragments_dedupe_update(struct z_erofs_vle_compress_ctx *ctx,
> +					    unsigned int *len)
> +{
> +	struct erofs_inode *inode = ctx->inode;
> +	const unsigned int remaining = ctx->remaining + *len;

please rename as "new_fragmentsize" for easy understanding.

> +
> +	DBG_BUGON(!inode->fragment_size);
> +
> +	/* try to close the gap if it gets larger (should be rare) */
> +	if (inode->fragment_size < remaining) {
> +		ctx->pclustersize = roundup(remaining - inode->fragment_size,
> +					    EROFS_BLKSIZ);
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
> +static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx, bool fixup)
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
>  		bool may_inline = (cfg.c_ztailpacking && final);
>  		bool may_packing = (cfg.c_fragments && final &&
>  				   !erofs_is_packed_inode(inode));

		bool may_xxxx = fixup;

>  
> -		if (z_erofs_compress_dedupe(inode, ctx, &len) && !final)
> +		if (z_erofs_compress_dedupe(ctx, &len) && !final)
>  			break;
>  
> -		if (len <= pclustersize) {
> +		if (len <= ctx->pclustersize) {
>  			if (!final || !len)
>  				break;
>  			if (may_packing) {
> +				if (inode->fragment_size && !fixup) {
> +					ctx->remaining = inode->fragment_size;
> +					ctx->pclustersize =
> +						roundup(len, EROFS_BLKSIZ);
> +					ctx->e.length = 0;
> +					return -EAGAIN;
> +				}
>  				ctx->e.length = len;
>  				goto frag_packing;
>  			}
> @@ -353,7 +389,7 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx,
>  		ctx->e.length = min(len,
>  				cfg.c_max_decompressed_extent_bytes);
>  		ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
> -				&ctx->e.length, dst, pclustersize,
> +				&ctx->e.length, dst, ctx->pclustersize,
>  				!(final && len == ctx->e.length));
>  		if (ret <= 0) {
>  			if (ret != -EAGAIN) {
> @@ -385,11 +421,12 @@ nocompression:
>  			ctx->e.compressedblks = 1;
>  			ctx->e.raw = true;
>  		} else if (may_packing && len == ctx->e.length &&
> -			   ret < pclustersize) {
> +			   ret < ctx->pclustersize && (!inode->fragment_size ||
> +			   fixup)) {
>  frag_packing:
>  			ret = z_erofs_pack_fragments(inode,
>  						     ctx->queue + ctx->head,
> -						     len);
> +						     len, ctx->crc);
>  			if (ret < 0)
>  				return ret;
>  			ctx->e.compressedblks = 0; /* indicate a fragment */

			may_xxxx = false;

> @@ -425,6 +462,21 @@ frag_packing:
>  			DBG_BUGON(ctx->e.compressedblks * EROFS_BLKSIZ >=
>  				  ctx->e.length);
>  
> +			/*
> +			 * Try to recompress a litte more if there's space left
> +			 * for fragment deduplication.
> +			 */
> +			if (may_packing && len == ctx->e.length && tailused &&
> +			    ctx->tail < sizeof(ctx->queue)) {
> +				DBG_BUGON(!inode->fragment_size);
> +
> +				ctx->remaining = inode->fragment_size;
> +				ctx->pclustersize =
> +					ctx->e.compressedblks * EROFS_BLKSIZ;
> +				ctx->e.length = 0;
> +				return -EAGAIN;
> +			}
> +
>  			/* zero out garbage trailing data for non-0padding */
>  			if (!erofs_sb_has_lz4_0padding())
>  				memset(dst + ret, 0,
> @@ -454,6 +506,9 @@ frag_packing:
>  		ctx->head += ctx->e.length;
>  		len -= ctx->e.length;
>  
> +		if (fixup && ctx->e.compressedblks)

		if (may_xxxx)

> +			z_erofs_fragments_dedupe_update(ctx, &len);
> +
>  		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
>  			const unsigned int qh_aligned =
>  				round_down(ctx->head, EROFS_BLKSIZ);
> @@ -736,10 +791,9 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
>  {
>  	struct erofs_buffer_head *bh;
>  	static struct z_erofs_vle_compress_ctx ctx;
> -	erofs_off_t remaining;
>  	erofs_blk_t blkaddr, compressed_blocks;
>  	unsigned int legacymetasize;
> -	int ret;
> +	int ret = 0;
>  	u8 *compressmeta = malloc(vle_compressmeta_capacity(inode->i_size));
>  
>  	if (!compressmeta)
> @@ -775,6 +829,16 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
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
> @@ -782,22 +846,25 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
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
> +	while (ctx.remaining) {
> +		const u64 readcount = min_t(u64, ctx.remaining,
>  					    sizeof(ctx.queue) - ctx.tail);
> +		bool fixup = ret < 0;

	drop this one;

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

					     ret == -EAGAIN

> -		if (ret)
> +		ret = vle_compress_one(&ctx, fixup);
> +		if (ret && ret != -EAGAIN)
>  			goto err_free_idata;
>  	}
>  	DBG_BUGON(ctx.head != ctx.tail);
> @@ -807,6 +874,16 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
>  	DBG_BUGON(compressed_blocks < !!inode->idata_size);
>  	compressed_blocks -= !!inode->idata_size;
>  
> +	if (inode->fragment_size && ctx.e.compressedblks) {

why not moving into z_erofs_fragments_dedupe_update()?

Thanks,
Gao Xiang

> +		z_erofs_write_indexes(&ctx);
> +
> +		inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
> +		ctx.e.length = inode->fragment_size;
> +		ctx.e.compressedblks = 0;
> +		ctx.e.raw = true;
> +		ctx.e.partial = false;
> +		ctx.e.blkaddr = ctx.blkaddr;
> +	}
>  	z_erofs_write_indexes(&ctx);
>  	z_erofs_write_indexes_final(&ctx);
>  	legacymetasize = ctx.metacur - compressmeta;
> diff --git a/lib/fragments.c b/lib/fragments.c
> index b8c37d5..48c133f 100644
> --- a/lib/fragments.c
> +++ b/lib/fragments.c
> @@ -10,14 +10,183 @@
>  #include "erofs/inode.h"
>  #include "erofs/compress.h"
>  #include "erofs/print.h"
> +#include "erofs/internal.h"
>  #include "erofs/fragments.h"
>  
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
> +static unsigned int len_to_hash; /* the fragment length for crc32 hash */
> +
>  static FILE *packedfile;
>  const char *frags_packedname = "packed_file";
>  
> +static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
> +					 u32 crc)
> +{
> +	struct erofs_fragment_dedupe_item *cur, *di = NULL;
> +	struct list_head *head;
> +	u8 *data;
> +	unsigned int length;
> +	int ret;
> +
> +	head = &dupli_frags[FRAGMENT_HASH(crc)];
> +	if (list_empty(head))
> +		return 0;
> +
> +	/* XXX: no need to read so much for smaller? */
> +	if (inode->i_size < 2 * EROFS_CONFIG_COMPR_MAX_SZ)
> +		length = inode->i_size;
> +	else
> +		length = 2 * EROFS_CONFIG_COMPR_MAX_SZ;
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
> +	list_for_each_entry(cur, head, list) {
> +		unsigned int e1, e2, i = 0;
> +
> +		DBG_BUGON(cur->length < len_to_hash + 1);
> +		DBG_BUGON(length < len_to_hash + 1);
> +
> +		e1 = cur->length - len_to_hash - 1;
> +		e2 = length - len_to_hash - 1;
> +
> +		if (memcmp(cur->data + e1 + 1, data + e2 + 1, len_to_hash))
> +			continue;
> +
> +		while (i <= min(e1, e2) && cur->data[e1 - i] == data[e2 - i])
> +			i++;
> +
> +		if (i && (!di || i + len_to_hash > di->nr_dup)) {
> +			cur->nr_dup = i + len_to_hash;
> +			di = cur;
> +
> +			/* full match */
> +			if (i == min(e1, e2) + 1)
> +				break;
> +		}
> +	}
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
> +	u8 data_to_hash[len_to_hash];
> +	u32 crc;
> +	int ret;
> +
> +	if (inode->i_size <= len_to_hash)
> +		return 0;
> +
> +	ret = lseek(fd, inode->i_size - len_to_hash, SEEK_SET);
> +	if (ret == -1)
> +		return -errno;
> +
> +	ret = read(fd, data_to_hash, len_to_hash);
> +	if (ret != len_to_hash)
> +		return -errno;
> +
> +	crc = erofs_crc32c(~0, data_to_hash, len_to_hash);
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
> +	struct erofs_fragment_dedupe_item *di;
> +
> +	if (len <= len_to_hash)
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
> +	list_add_tail(&di->list, &dupli_frags[FRAGMENT_HASH(crc)]);
> +	return 0;
> +}
> +
> +static inline void z_erofs_fragments_dedupe_init(unsigned int clen)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < FRAGMENT_HASHTABLE_SIZE; ++i)
> +		init_list_head(&dupli_frags[i]);
> +
> +	len_to_hash = clen;
> +}
> +
> +static void z_erofs_fragments_dedupe_exit(void)
> +{
> +	struct erofs_fragment_dedupe_item *di, *n;
> +	struct list_head *head;
> +	unsigned int i;
> +
> +	for (i = 0; i < FRAGMENT_HASHTABLE_SIZE; ++i) {
> +		head = &dupli_frags[i];
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
> @@ -35,6 +204,11 @@ int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
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
> @@ -50,6 +224,8 @@ void erofs_fragments_exit(void)
>  {
>  	if (packedfile)
>  		fclose(packedfile);
> +
> +	z_erofs_fragments_dedupe_exit();
>  }
>  
>  int erofs_fragments_init(void)
> @@ -61,5 +237,7 @@ int erofs_fragments_init(void)
>  #endif
>  	if (!packedfile)
>  		return -ENOMEM;
> +
> +	z_erofs_fragments_dedupe_init(16);
>  	return 0;
>  }
> -- 
> 2.17.1
