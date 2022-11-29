Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 133F363B9A6
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Nov 2022 07:02:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NLsFP0qPjz3cLr
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Nov 2022 17:02:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=j9LcpASE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=j9LcpASE;
	dkim-atps=neutral
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NLsFJ0sK9z2xVr
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Nov 2022 17:02:42 +1100 (AEDT)
Received: by mail-pg1-x52d.google.com with SMTP id 82so4595189pgc.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 28 Nov 2022 22:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVtzVdKQv0g30oBa2Hz1NU30m+9ocKEMSrHBOpASCUE=;
        b=j9LcpASEEyHQAPpIMEFvOUJvC+/+L7+Egwuy6+yuaS9x/mxTiuACj6WfmV5YClhJ1V
         dRhQuSyt02Pflr4KKi3oZ+m6nr/97LiTNFOKmp6bzL0QpevsVX6jAug3bB6mMGqsxMRF
         8Nt35dJoPmOpaCMT7uW1OaOE/1HwHUuSbgJO5yhZa7DCb/4FXOvAaZA3Lwuv2LK4w+yw
         9GbEJbuE4OiV4z2d9u8rd7pMNvAwo+JFWC7LEIfOBDQHQyA0/MAPYI8UtzOq4JcCPzwT
         x4u/rhiwlZODchxIDyyJyQulZriKyzf/EqOzx+vEtH72WO3jtVKTlo487yEDqrSHQBOR
         bSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVtzVdKQv0g30oBa2Hz1NU30m+9ocKEMSrHBOpASCUE=;
        b=ChzYtl6kRF7S/Wugfjx3W74PTVGL2owAoxOTOZkIIszGZm0rs5572l+Wc4DeH7MdoF
         Gtfffyer3kLDOK2Speif6NKA/3hkgouUj8+uL+5vno5wGs5nT/rgWwni2HW7F6Uli3ZY
         oOkOPC2jb/xzIaCiPEt6zlDAAZ8yFYJ774CZKOPxonZodkEeeGFOYtGEpPpaQHKEuSQX
         6gUinohAJttjvwT9/i83ov96cuBZqUY8HpXaL5lhcf3gvToMp5R/yMdNa5E2T5/Sle31
         iurkBTvcHbTPfKX+bHaZ2ldd5c1QnxvOFugcI3OlFmyawwlRgL9yIRuSs6NwMY+/N5lZ
         +dxQ==
X-Gm-Message-State: ANoB5pmEY4P5KaE8GQBr4wFhu4g2uGAzuZ4c5g790G4Jzq8/OBV/trO/
	F51i9z5Px13YNIA/y/i6f8A=
X-Google-Smtp-Source: AA0mqf4l6ME8PYNcrt8deR/IeLaZMF5UfzXRh4SYlgZ+XwFaBygdcPLCmFpItIqHInhJ1FsXZUVOvg==
X-Received: by 2002:a63:1054:0:b0:42b:9219:d14e with SMTP id 20-20020a631054000000b0042b9219d14emr31169155pgq.176.1669701756450;
        Mon, 28 Nov 2022 22:02:36 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id pm9-20020a17090b3c4900b00210c84b8ae5sm481443pjb.35.2022.11.28.22.02.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Nov 2022 22:02:36 -0800 (PST)
Date: Tue, 29 Nov 2022 14:06:44 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC][PATCH v2] erofs-utils: mkfs: support fragment
 deduplication
Message-ID: <20221129140644.00003cb2.zbestahu@gmail.com>
In-Reply-To: <Y4Vjyc148XUp4CX6@B-P7TQMD6M-0146.local>
References: <20221123131916.20782-1-zbestahu@gmail.com>
	<Y4Vjyc148XUp4CX6@B-P7TQMD6M-0146.local>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 29 Nov 2022 09:43:37 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Wed, Nov 23, 2022 at 09:19:16PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > Previously, there's no fragment deduplication when this feature is
> > introduced. Let's support it now.
> > 
> > Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---
> > v2: mainly improve the logic in compression
> > 
> >  include/erofs/fragments.h |   3 +-
> >  lib/compress.c            | 122 +++++++++++++++++++++----
> >  lib/fragments.c           | 188 +++++++++++++++++++++++++++++++++++++-
> >  lib/inode.c               |  12 ++-
> >  4 files changed, 302 insertions(+), 23 deletions(-)
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
> >  struct erofs_inode *erofs_mkfs_build_fragments(void);
> >  int erofs_fragments_init(void);
> >  void erofs_fragments_exit(void);
> > diff --git a/lib/compress.c b/lib/compress.c
> > index 17b3213..7a133fd 100644
> > --- a/lib/compress.c
> > +++ b/lib/compress.c
> > @@ -33,6 +33,10 @@ struct z_erofs_vle_compress_ctx {
> >  	unsigned int head, tail;
> >  	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
> >  	u16 clusterofs;
> > +
> > +	u32 crc;
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
> > @@ -319,30 +323,83 @@ static void tryrecompress_trailing(void *in, unsigned int *insize,
> >  	*compressedsize = ret;
> >  }
> >  
> > -static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx,
> > -			    bool final)
> > +static void z_erofs_fragments_dedupe_reduce(struct z_erofs_vle_compress_ctx *ctx,
> > +					    unsigned int *len)
> > +{
> > +	struct erofs_inode *inode = ctx->inode;
> > +	const unsigned int remaining = ctx->remaining + *len;
> > +
> > +	if (!inode->fragment_size || !ctx->e.compressedblks)
> > +		return;
> > +
> > +	/* try to close the gap if it gets larger (should be rare) */
> > +	if (inode->fragment_size < remaining) {
> > +		z_erofs_write_indexes(ctx);
> > +		ctx->e.compressedblks =
> > +			BLK_ROUND_UP(remaining - inode->fragment_size);
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
> > +static void z_erofs_fragments_dedupe_end(struct z_erofs_vle_compress_ctx *ctx)
> > +{
> > +	struct erofs_inode *inode = ctx->inode;
> > +
> > +	if (inode->fragment_size && ctx->e.compressedblks) {
> > +		inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
> > +		z_erofs_write_indexes(ctx);
> > +
> > +		ctx->e.length = inode->fragment_size;
> > +		ctx->e.compressedblks = 0;
> > +		ctx->e.raw = true;
> > +		ctx->e.partial = false;
> > +		ctx->e.blkaddr = ctx->blkaddr;
> > +	}
> > +	z_erofs_write_indexes(ctx);
> > +	z_erofs_write_indexes_final(ctx);
> > +}
> > +
> > +static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx, bool fixing)
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
> > +		unsigned int pclustersize = !fixing ? ctx->pclustersize :
> > +					ctx->e.compressedblks * EROFS_BLKSIZ;  
> 
> I have to think more about this.

i will set "ctx->pcluster" when recompressing directly.

> 
> >  		bool may_inline = (cfg.c_ztailpacking && final);
> >  		bool may_packing = (cfg.c_fragments && final &&
> >  				   !erofs_is_packed_inode(inode));
> >  
> > -		if (z_erofs_compress_dedupe(inode, ctx, &len) && !final)
> > +		if (z_erofs_compress_dedupe(ctx, &len) && !final)
> >  			break;
> >  
> >  		if (len <= pclustersize) {
> >  			if (!final || !len)
> >  				break;
> >  			if (may_packing) {
> > +				if (inode->fragment_size && !fixing) {
> > +					ctx->remaining = inode->fragment_size;
> > +					ctx->e.length = 0;
> > +					ctx->e.compressedblks = BLK_ROUND_UP(len);
> > +					return -EAGAIN;
> > +				}
> >  				ctx->e.length = len;
> >  				goto frag_packing;
> >  			}
> > @@ -385,11 +442,11 @@ nocompression:
> >  			ctx->e.compressedblks = 1;
> >  			ctx->e.raw = true;
> >  		} else if (may_packing && len == ctx->e.length &&
> > -			   ret < pclustersize) {
> > +			   ret < pclustersize && !inode->fragment_size) {
> >  frag_packing:
> >  			ret = z_erofs_pack_fragments(inode,
> >  						     ctx->queue + ctx->head,
> > -						     len);
> > +						     len, ctx->crc);
> >  			if (ret < 0)
> >  				return ret;
> >  			ctx->e.compressedblks = 0; /* indicate a fragment */
> > @@ -425,6 +482,20 @@ frag_packing:
> >  			DBG_BUGON(ctx->e.compressedblks * EROFS_BLKSIZ >=
> >  				  ctx->e.length);
> >  
> > +			/*
> > +			 * Try to recompress a litte more if there's space left
> > +			 * for fragment deduplication.
> > +			 */
> > +			if (may_packing && len == ctx->e.length && tailused) {
> > +				DBG_BUGON(!inode->fragment_size);
> > +				if (fixing)
> > +					goto frag_packing;
> > +
> > +				ctx->remaining = inode->fragment_size;
> > +				ctx->e.length = 0;
> > +				return -EAGAIN;
> > +			}
> > +
> >  			/* zero out garbage trailing data for non-0padding */
> >  			if (!erofs_sb_has_lz4_0padding())
> >  				memset(dst + ret, 0,
> > @@ -454,6 +525,9 @@ frag_packing:
> >  		ctx->head += ctx->e.length;
> >  		len -= ctx->e.length;
> >  
> > +		if (fixing)
> > +			z_erofs_fragments_dedupe_reduce(ctx, &len);
> > +
> >  		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
> >  			const unsigned int qh_aligned =
> >  				round_down(ctx->head, EROFS_BLKSIZ);
> > @@ -736,7 +810,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
> >  {
> >  	struct erofs_buffer_head *bh;
> >  	static struct z_erofs_vle_compress_ctx ctx;
> > -	erofs_off_t remaining;
> >  	erofs_blk_t blkaddr, compressed_blocks;
> >  	unsigned int legacymetasize;
> >  	int ret;
> > @@ -775,6 +848,16 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
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
> > @@ -782,22 +865,26 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
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
> > +	ret = 0;
> > +	while (ctx.remaining) {
> > +		const u64 readcount = min_t(u64, ctx.remaining,
> >  					    sizeof(ctx.queue) - ctx.tail);
> > +		bool fixing = !!ret;
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
> > -		if (ret)
> > +		ret = vle_compress_one(&ctx, fixing);
> > +		if (ret && ret != -EAGAIN)
> >  			goto err_free_idata;
> >  	}
> >  	DBG_BUGON(ctx.head != ctx.tail);
> > @@ -807,8 +894,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
> >  	DBG_BUGON(compressed_blocks < !!inode->idata_size);
> >  	compressed_blocks -= !!inode->idata_size;
> >  
> > -	z_erofs_write_indexes(&ctx);
> > -	z_erofs_write_indexes_final(&ctx);
> > +	z_erofs_fragments_dedupe_end(&ctx);
> >  	legacymetasize = ctx.metacur - compressmeta;
> >  	/* estimate if data compression saves space or not */
> >  	if (!inode->fragment_size &&
> > diff --git a/lib/fragments.c b/lib/fragments.c
> > index b8c37d5..550c888 100644
> > --- a/lib/fragments.c
> > +++ b/lib/fragments.c
> > @@ -10,14 +10,191 @@
> >  #include "erofs/inode.h"
> >  #include "erofs/compress.h"
> >  #include "erofs/print.h"
> > +#include "erofs/internal.h"
> >  #include "erofs/fragments.h"
> >  
> > +struct fragment_dedupe_item {
> > +	struct list_head	list;
> > +	unsigned int		length, nr_dup;
> > +	erofs_off_t		pos;
> > +	u8			data[];
> > +};
> > +
> > +#define FRAGMENT_HASHTABLE_SIZE		65536
> > +#define FRAGMENT_HASH(crc)		(crc & (FRAGMENT_HASHTABLE_SIZE - 1))
> > +
> > +static struct list_head di_hashtable[FRAGMENT_HASHTABLE_SIZE];  
> 
> what does "di_hashtable" mean?

What about "dedupe_fragments" or "dupli_fragments"?

> 
> > +static unsigned int keylen;	/* the data length to crc for deduplication */  
> 
> keylen?  too generic name.

Let me think again.

> 
> > +
> >  static FILE *packedfile;
> >  const char *frags_packedname = "packed_file";
> >  
> > +static struct fragment_dedupe_item *find_duplicate(struct list_head *head,  
> 
> why not fold in this?

Will fix it in v3.

> 
> > +						   u8 *data, unsigned int len)
> > +{
> > +	struct fragment_dedupe_item *di, *candidate = NULL;
> > +
> > +	list_for_each_entry(di, head, list) {
> > +		unsigned int e1, e2, i = 0;
> > +
> > +		DBG_BUGON(di->length < keylen + 1);
> > +		DBG_BUGON(len < keylen + 1);
> > +
> > +		e1 = di->length - keylen - 1;
> > +		e2 = len - keylen - 1;
> > +
> > +		if (memcmp(di->data + e1 + 1, data + e2 + 1, keylen))
> > +			continue;
> > +
> > +		while (i <= min(e1, e2) && di->data[e1 - i] == data[e2 - i])
> > +			i++;
> > +
> > +		if (i && (!candidate || i + keylen > candidate->nr_dup)) {
> > +			di->nr_dup = i + keylen;
> > +			candidate = di;
> > +
> > +			/* full match */
> > +			if (i == min(e1, e2) + 1)
> > +				break;
> > +		}
> > +	}
> > +	return candidate;
> > +}
> > +
> > +static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
> > +					 u32 crc)
> > +{
> > +	struct fragment_dedupe_item *di;
> > +	struct list_head *head;
> > +	u8 *data;
> > +	unsigned int length;
> > +	int ret;
> > +
> > +	head = &di_hashtable[FRAGMENT_HASH(crc)];
> > +	if (list_empty(head))
> > +		return 0;
> > +
> > +	if (inode->i_size < EROFS_CONFIG_COMPR_MAX_SZ)
> > +		length = inode->i_size;
> > +	else
> > +		length = EROFS_CONFIG_COMPR_MAX_SZ;
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
> > +	di = find_duplicate(head, data, length);
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
> > +	u8 key[keylen];
> > +	u32 crc;
> > +	int ret;
> > +
> > +	if (inode->i_size <= keylen)
> > +		return 0;
> > +
> > +	ret = lseek(fd, inode->i_size - keylen, SEEK_SET);
> > +	if (ret == -1)
> > +		return -errno;
> > +
> > +	ret = read(fd, key, keylen);
> > +	if (ret != keylen)
> > +		return -errno;
> > +
> > +	crc = erofs_crc32c(~0, key, keylen);
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
> > +	struct fragment_dedupe_item *di;  
> 
> 	erofs_fragment_dedupe_item?

Okay.

> 
> > +
> > +	if (len <= keylen)
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
> > +	list_add_tail(&di->list, &di_hashtable[FRAGMENT_HASH(crc)]);
> > +	return 0;
> > +}
> > +
> > +static inline void z_erofs_fragments_dedupe_init(unsigned int clen)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < FRAGMENT_HASHTABLE_SIZE; ++i)
> > +		init_list_head(&di_hashtable[i]);
> > +
> > +	keylen = clen;
> > +}
> > +
> > +static void z_erofs_fragments_dedupe_exit(void)
> > +{
> > +	struct fragment_dedupe_item *di, *n;
> > +	struct list_head *head;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < FRAGMENT_HASHTABLE_SIZE; ++i) {
> > +		head = &di_hashtable[i];
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
> > @@ -35,6 +212,11 @@ int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
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
> > @@ -50,6 +232,8 @@ void erofs_fragments_exit(void)
> >  {
> >  	if (packedfile)
> >  		fclose(packedfile);
> > +
> > +	z_erofs_fragments_dedupe_exit();
> >  }
> >  
> >  int erofs_fragments_init(void)
> > @@ -61,5 +245,7 @@ int erofs_fragments_init(void)
> >  #endif
> >  	if (!packedfile)
> >  		return -ENOMEM;
> > +
> > +	z_erofs_fragments_dedupe_init(16);
> >  	return 0;
> >  }
> > diff --git a/lib/inode.c b/lib/inode.c
> > index 9de4dec..cb2e057 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -406,7 +406,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
> >  	return 0;
> >  }
> >  
> > -int erofs_write_file(struct erofs_inode *inode)
> > +static int erofs_write_file(struct erofs_inode *inode)  
> 
> Can we move this into a seperated patch?

Sure.

> 
> >  {
> >  	int ret, fd;
> >  
> > @@ -1196,7 +1196,10 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
> >  	struct erofs_inode *inode;
> >  	int ret;
> >  
> > -	lseek(fd, 0, SEEK_SET);
> > +	ret = lseek(fd, 0, SEEK_SET);
> > +	if (ret == -1)
> > +		return ERR_PTR(-errno);  
> 
> Same here.

Sure.

> 
> > +
> >  	ret = fstat64(fd, &st);
> >  	if (ret)
> >  		return ERR_PTR(-errno);
> > @@ -1223,7 +1226,10 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
> >  
> >  	ret = erofs_write_compressed_file(inode, fd);
> >  	if (ret == -ENOSPC) {
> > -		lseek(fd, 0, SEEK_SET);
> > +		ret = lseek(fd, 0, SEEK_SET);
> > +		if (ret == -1)
> > +			return ERR_PTR(-errno);
> > +  
> 
> Same here.

Sure.

> 
> Thanks,
> Gao Xiang
> 
> 
> >  		ret = write_uncompressed_file_from_fd(inode, fd);
> >  	}
> >  
> > -- 
> > 2.17.1  

