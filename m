Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F8F5A0B21
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Aug 2022 10:14:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MCwjB2wS2z3bf5
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Aug 2022 18:14:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=kjs1LOTg;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=kjs1LOTg;
	dkim-atps=neutral
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MCwj25SClz2xst
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Aug 2022 18:13:57 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id bh13so17238256pgb.4
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 Aug 2022 01:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=BU6EIqDF8mBWOtI+h8qI93lpIBZQHKAUMPUypUw8tAA=;
        b=kjs1LOTgH/qFmowIGJd9K+84P6WUTBRrPcVQttetVC+diTDpo0OwXwDuzMjkVqALLc
         Ls6uOyUg6i/+nrhv9a5uUIoXTpBnImspDEzHLTEdEvIk6H9qBJpk1D2UPFOJn5NV9kaf
         xfqh0XIXebkkifgND0Q6msGjyw1YY3Wcp1V82DivDqhIF6s3PYmr/gYSqtmAb7B3jQvT
         cAKcHvb066dJJqDOEkjVkR1qL1H0wqpIQYbqs2Alrs1pIfCQiqx76cb3cjMkemFZHB9F
         RMAih4ia6wb741pVQQf5U8dTbalR+U1+BkkpsgbPGZgm8AmZyFv2IAJQRNJjkqhARWaS
         myhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=BU6EIqDF8mBWOtI+h8qI93lpIBZQHKAUMPUypUw8tAA=;
        b=tEbwJcpz1bg9HRDNNpH7Jtb46wT122St20nqT5k/Vb6ssmtK8Sno5GVyFEZEYIkbD5
         tYLgaLWn7/yEfKJ9HECJBveEZ0Gi9lUWgF8BJwq74v8G4p7svSTgeBLAVZFuJyN5wO6s
         x2GBsqDIjAzVXEM0tEjdQAHZfHMv0iGFoRgxjtzlF3L0O5SQb7F7/UBRpOFSuuFE6Pks
         dvoAmJm/XWX92SRHJmtCQ0NlELlUA/dP1OiXD0mrpt9SbKXFD6gjen5sNRe7f3HYVl07
         gPfI8Yqo+0tgYPLy2o/cHgRjQUOx7eQzV+hLmAqUcWlR0QglvOBARF1/Fhgjr44yXc9D
         O1oQ==
X-Gm-Message-State: ACgBeo2sEPZZ4q5nAujTlD7bWxq9w/P3DJHUNTVwhZpUumrO2jukEqIL
	exa9R64kCETvhyOfEOrUXZXIwqAUvTQ=
X-Google-Smtp-Source: AA6agR5kdU5aFntPuhUM+cn9kO5y3OGT06DHkL4NxMHnte4JgEcXVngAXuUjK8gGfUkCkcFhXXCjLQ==
X-Received: by 2002:a63:8f57:0:b0:42a:3d37:3e74 with SMTP id r23-20020a638f57000000b0042a3d373e74mr2301676pgn.420.1661415232131;
        Thu, 25 Aug 2022 01:13:52 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id nv15-20020a17090b1b4f00b001f559e00473sm2849640pjb.43.2022.08.25.01.13.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Aug 2022 01:13:51 -0700 (PDT)
Date: Thu, 25 Aug 2022 16:16:00 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH v4 3/3] erofs-utils: introduce compressed fragments
 support
Message-ID: <20220825161600.00003dfc.zbestahu@gmail.com>
In-Reply-To: <YwXol8hr1G1eB0z/@B-P7TQMD6M-0146.local>
References: <cover.1661087840.git.huyue2@coolpad.com>
	<2691b09ec876ac825821bc9a3ac165997df2acf5.1661087840.git.huyue2@coolpad.com>
	<YwXol8hr1G1eB0z/@B-P7TQMD6M-0146.local>
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

Hi Xiang,

On Wed, 24 Aug 2022 17:00:07 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Sun, Aug 21, 2022 at 09:57:25PM +0800, zbestahu@gmail.com wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > This approach can merge tail pclusters or the whole files into a special
> > inode in order to achieve greater compression ratio. And an option of
> > pcluster size is provided for different compression requirments.
> > 
> > Meanwhile, we change to write the uncompressed data from 'clusterofs'
> > when compressing files since it can benefit from in-place I/O. For now,
> > this change goes with the fragments.
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---
> >  include/erofs/compress.h  |   3 +-
> >  include/erofs/config.h    |   3 +-
> >  include/erofs/fragments.h |  25 +++++++++
> >  include/erofs/inode.h     |   1 +
> >  include/erofs/internal.h  |   1 +
> >  include/erofs_fs.h        |   1 +
> >  lib/Makefile.am           |   4 +-
> >  lib/compress.c            | 108 ++++++++++++++++++++++++++++----------
> >  lib/fragments.c           |  58 ++++++++++++++++++++
> >  lib/inode.c               |  59 ++++++++++++++++-----
> >  mkfs/main.c               |  64 +++++++++++++++++++---
> >  11 files changed, 277 insertions(+), 50 deletions(-)
> >  create mode 100644 include/erofs/fragments.h
> >  create mode 100644 lib/fragments.c
> > 
> > diff --git a/include/erofs/compress.h b/include/erofs/compress.h
> > index 24f6204..d17aadb 100644
> > --- a/include/erofs/compress.h
> > +++ b/include/erofs/compress.h
> > @@ -18,7 +18,8 @@ extern "C"
> >  #define EROFS_CONFIG_COMPR_MIN_SZ           (32   * 1024)
> >  
> >  void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
> > -int erofs_write_compressed_file(struct erofs_inode *inode);
> > +int erofs_write_compressed_file_from_fd(struct erofs_inode *inode, int fd,
> > +					bool is_src);
> >  
> >  int z_erofs_compress_init(struct erofs_buffer_head *bh);
> >  int z_erofs_compress_exit(void);
> > diff --git a/include/erofs/config.h b/include/erofs/config.h
> > index 539d813..764b0f7 100644
> > --- a/include/erofs/config.h
> > +++ b/include/erofs/config.h
> > @@ -44,6 +44,7 @@ struct erofs_configure {
> >  	char c_chunkbits;
> >  	bool c_noinline_data;
> >  	bool c_ztailpacking;
> > +	bool c_fragments;
> >  	bool c_ignore_mtime;
> >  	bool c_showprogress;
> >  
> > @@ -62,7 +63,7 @@ struct erofs_configure {
> >  	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
> >  	int c_inline_xattr_tolerance;
> >  
> > -	u32 c_pclusterblks_max, c_pclusterblks_def;
> > +	u32 c_pclusterblks_max, c_pclusterblks_def, c_pclusterblks_packed;
> >  	u32 c_max_decompressed_extent_bytes;
> >  	u32 c_dict_size;
> >  	u64 c_unix_timestamp;
> > diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
> > new file mode 100644
> > index 0000000..913aa99
> > --- /dev/null
> > +++ b/include/erofs/fragments.h
> > @@ -0,0 +1,25 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> > +/*
> > + * Copyright (C), 2022, Coolpad Group Limited.
> > + */
> > +#ifndef __EROFS_FRAGMENTS_H
> > +#define __EROFS_FRAGMENTS_H
> > +
> > +#ifdef __cplusplus
> > +extern "C"
> > +{
> > +#endif
> > +
> > +#include "erofs/internal.h"
> > +
> > +int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
> > +			   unsigned int len);
> > +struct erofs_inode *erofs_mkfs_build_fragments(void);
> > +int erofs_fragments_init(void);
> > +void erofs_fragments_exit(void);
> > +
> > +#ifdef __cplusplus
> > +}
> > +#endif
> > +
> > +#endif
> > diff --git a/include/erofs/inode.h b/include/erofs/inode.h
> > index 79b8d89..bf20cd3 100644
> > --- a/include/erofs/inode.h
> > +++ b/include/erofs/inode.h
> > @@ -22,6 +22,7 @@ unsigned int erofs_iput(struct erofs_inode *inode);
> >  erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
> >  struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
> >  						    const char *path);
> > +struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name);
> >  
> >  #ifdef __cplusplus
> >  }
> > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > index 58590ed..2e834e5 100644
> > --- a/include/erofs/internal.h
> > +++ b/include/erofs/internal.h
> > @@ -212,6 +212,7 @@ struct erofs_inode {
> >  	uint64_t capabilities;
> >  #endif
> >  	erofs_off_t fragmentoff;
> > +	unsigned int fragment_size;
> >  };
> >  
> >  static inline bool is_inode_layout_compression(struct erofs_inode *inode)
> > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > index 2422e1c..997ac0c 100644
> > --- a/include/erofs_fs.h
> > +++ b/include/erofs_fs.h
> > @@ -267,6 +267,7 @@ struct erofs_inode_chunk_index {
> >  
> >  /* maximum supported size of a physical compression cluster */
> >  #define Z_EROFS_PCLUSTER_MAX_SIZE	(1024 * 1024)
> > +#define Z_EROFS_PCLUSTER_MAX_BLKS	(Z_EROFS_PCLUSTER_MAX_SIZE / EROFS_BLKSIZ)
> >  
> >  /* available compression algorithm types (for h_algorithmtype) */
> >  enum {
> > diff --git a/lib/Makefile.am b/lib/Makefile.am
> > index 3fad357..95f1d55 100644
> > --- a/lib/Makefile.am
> > +++ b/lib/Makefile.am
> > @@ -22,12 +22,14 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
> >        $(top_srcdir)/include/erofs/trace.h \
> >        $(top_srcdir)/include/erofs/xattr.h \
> >        $(top_srcdir)/include/erofs/compress_hints.h \
> > +      $(top_srcdir)/include/erofs/fragments.h \
> >        $(top_srcdir)/lib/liberofs_private.h
> >  
> >  noinst_HEADERS += compressor.h
> >  liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
> >  		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
> > -		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c
> > +		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
> > +		      fragments.c
> >  liberofs_la_CFLAGS = -Wall -I$(top_srcdir)/include
> >  if ENABLE_LZ4
> >  liberofs_la_CFLAGS += ${LZ4_CFLAGS}
> > diff --git a/lib/compress.c b/lib/compress.c
> > index fd02053..fde14f6 100644
> > --- a/lib/compress.c
> > +++ b/lib/compress.c
> > @@ -18,6 +18,7 @@
> >  #include "compressor.h"
> >  #include "erofs/block_list.h"
> >  #include "erofs/compress_hints.h"
> > +#include "erofs/fragments.h"
> >  
> >  static struct erofs_compress compresshandle;
> >  static unsigned int algorithmtype[2];
> > @@ -74,9 +75,9 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
> >  	if (!d1) {
> >  		/*
> >  		 * A lcluster cannot have three parts with the middle one which
> > -		 * is well-compressed for !ztailpacking cases.
> > +		 * is well-compressed for !ztailpacking and !fragments cases.
> >  		 */
> > -		DBG_BUGON(!raw && !cfg.c_ztailpacking);
> > +		DBG_BUGON(!raw && !cfg.c_ztailpacking && !cfg.c_fragments);  
> 
> This should be per-inode?

Thanks for reviewing the patch, let me check this and below.

Thanks.

> 
> >  		type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
> >  			Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
> >  		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
> > @@ -143,7 +144,7 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
> >  				     unsigned int *len, char *dst)
> >  {
> >  	int ret;
> > -	unsigned int count;
> > +	unsigned int count, offset, rcopied, rzeroed;
> >  
> >  	/* reset clusterofs to 0 if permitted */
> >  	if (!erofs_sb_has_lz4_0padding() && ctx->clusterofs &&
> > @@ -153,11 +154,21 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
> >  		ctx->clusterofs = 0;
> >  	}
> >  
> > -	/* write uncompressed data */
> > +	/*
> > +	 * write uncompressed data from clusterofs which can benefit from
> > +	 * in-place I/O, loop shift right when to exceed EROFS_BLKSIZ.
> > +	 */
> >  	count = min(EROFS_BLKSIZ, *len);
> >  
> > -	memcpy(dst, ctx->queue + ctx->head, count);
> > -	memset(dst + count, 0, EROFS_BLKSIZ - count);
> > +	offset = cfg.c_fragments ? ctx->clusterofs : 0;  
> 
> interlaced_offset;
> 
> > +	rcopied = min(EROFS_BLKSIZ - offset, count);
> > +	rzeroed = EROFS_BLKSIZ - offset - rcopied;
> > +
> > +	memcpy(dst + offset, ctx->queue + ctx->head, rcopied);
> > +	memcpy(dst, ctx->queue + ctx->head + rcopied, count - rcopied);
> > +
> > +	memset(dst + offset + rcopied, 0, rzeroed);
> > +	memset(dst + count - rcopied, 0, EROFS_BLKSIZ - count - rzeroed);
> >  
> >  	erofs_dbg("Writing %u uncompressed data to block %u",
> >  		  count, ctx->blkaddr);
> > @@ -167,8 +178,11 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
> >  	return count;
> >  }
> >  
> > -static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode)
> > +static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode,
> > +						 bool is_src)  
> 
> is_src should be in erofs_inode as, for example, bool is_packed_inode,
> or other likewise rather than passing another argument here.
> 
> >  {
> > +	if (cfg.c_fragments && !is_src)
> > +		return cfg.c_pclusterblks_packed;
> >  #ifndef NDEBUG
> >  	if (cfg.c_random_pclusterblks)
> >  		return 1 + rand() % cfg.c_pclusterblks_max;
> > @@ -224,7 +238,7 @@ static void tryrecompress_trailing(void *in, unsigned int *insize,
> >  
> >  static int vle_compress_one(struct erofs_inode *inode,
> >  			    struct z_erofs_vle_compress_ctx *ctx,
> > -			    bool final)
> > +			    bool final, bool is_src)
> >  {
> >  	struct erofs_compress *const h = &compresshandle;
> >  	unsigned int len = ctx->tail - ctx->head;
> > @@ -234,14 +248,19 @@ static int vle_compress_one(struct erofs_inode *inode,
> >  	char *const dst = dstbuf + EROFS_BLKSIZ;
> >  
> >  	while (len) {
> > -		unsigned int pclustersize =
> > -			z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
> > +		unsigned int pclustersize = EROFS_BLKSIZ *
> > +				z_erofs_get_max_pclusterblks(inode, is_src);
> >  		bool may_inline = (cfg.c_ztailpacking && final);
> > +		bool may_packing = (cfg.c_fragments && final && is_src);
> >  		bool raw;
> >  
> >  		if (len <= pclustersize) {
> >  			if (!final)
> >  				break;
> > +			if (may_packing) {
> > +				count = len;
> > +				goto frag_packing;
> > +			}
> >  			if (!may_inline && len <= EROFS_BLKSIZ)
> >  				goto nocompression;
> >  		}
> > @@ -294,6 +313,19 @@ nocompression:
> >  				return ret;
> >  			ctx->compressedblks = 1;
> >  			raw = false;
> > +		} else if (may_packing && len == count && ret < pclustersize) {
> > +frag_packing:
> > +			ret = z_erofs_pack_fragments(inode,
> > +						     ctx->queue + ctx->head,
> > +						     len);
> > +			if (ret < 0)
> > +				return ret;
> > +			if (inode->i_size == inode->fragment_size) {
> > +				ctx->head += len;
> > +				return 0;
> > +			}
> > +			ctx->compressedblks = 0;
> > +			raw = false;
> >  		} else {
> >  			unsigned int tailused, padding;
> >  
> > @@ -546,13 +578,20 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
> >  {
> >  	struct z_erofs_map_header h = {
> >  		.h_advise = cpu_to_le16(inode->z_advise),
> > -		.h_idata_size = cpu_to_le16(inode->idata_size),
> >  		.h_algorithmtype = inode->z_algorithmtype[1] << 4 |
> >  				   inode->z_algorithmtype[0],
> >  		/* lclustersize */
> >  		.h_clusterbits = inode->z_logical_clusterbits - 12,
> >  	};
> >  
> > +	if (cfg.c_fragments)
> > +		h.h_fragmentoff = cpu_to_le32(inode->fragmentoff);
> > +	else
> > +		h.h_idata_size = cpu_to_le16(inode->idata_size);
> > +
> > +	if (inode->fragment_size && inode->i_size == inode->fragment_size)
> > +		h.h_clusterbits |=  1 << Z_EROFS_FRAGMENT_INODE_BIT;
> > +
> >  	memset(compressmeta, 0, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
> >  	/* write out map header */
> >  	memcpy(compressmeta, &h, sizeof(struct z_erofs_map_header));
> > @@ -605,30 +644,25 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
> >  	inode->eof_tailraw = NULL;
> >  }
> >  
> > -int erofs_write_compressed_file(struct erofs_inode *inode)
> > +int erofs_write_compressed_file_from_fd(struct erofs_inode *inode, int fd,
> > +					bool is_src)  
> 
> same here.
> 
> >  {
> >  	struct erofs_buffer_head *bh;
> >  	static struct z_erofs_vle_compress_ctx ctx;
> >  	erofs_off_t remaining;
> >  	erofs_blk_t blkaddr, compressed_blocks;
> >  	unsigned int legacymetasize;
> > -	int ret, fd;
> > +	int ret;
> >  	u8 *compressmeta = malloc(vle_compressmeta_capacity(inode->i_size));
> >  
> >  	if (!compressmeta)
> >  		return -ENOMEM;
> >  
> > -	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
> > -	if (fd < 0) {
> > -		ret = -errno;
> > -		goto err_free_meta;
> > -	}
> > -
> >  	/* allocate main data buffer */
> >  	bh = erofs_balloc(DATA, 0, 0, 0);
> >  	if (IS_ERR(bh)) {
> >  		ret = PTR_ERR(bh);
> > -		goto err_close;
> > +		goto err_free_meta;
> >  	}
> >  
> >  	/* initialize per-file compression setting */
> > @@ -649,6 +683,9 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
> >  	inode->z_algorithmtype[1] = algorithmtype[1];
> >  	inode->z_logical_clusterbits = LOG_BLOCK_SIZE;
> >  
> > +	inode->idata_size = 0;
> > +	inode->fragment_size = 0;
> > +
> >  	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
> >  	ctx.blkaddr = blkaddr;
> >  	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
> > @@ -668,7 +705,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
> >  		remaining -= readcount;
> >  		ctx.tail += readcount;
> >  
> > -		ret = vle_compress_one(inode, &ctx, !remaining);
> > +		ret = vle_compress_one(inode, &ctx, !remaining, is_src);
> >  		if (ret)
> >  			goto err_free_idata;
> >  	}
> > @@ -682,19 +719,20 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
> >  	vle_write_indexes_final(&ctx);
> >  	legacymetasize = ctx.metacur - compressmeta;
> >  	/* estimate if data compression saves space or not */
> > -	if (compressed_blocks * EROFS_BLKSIZ + inode->idata_size +
> > +	if (!inode->fragment_size &&
> > +	    compressed_blocks * EROFS_BLKSIZ + inode->idata_size +
> >  	    legacymetasize >= inode->i_size) {
> >  		ret = -ENOSPC;
> >  		goto err_free_idata;
> >  	}
> >  	z_erofs_write_mapheader(inode, compressmeta);
> >  
> > -	close(fd);
> >  	if (compressed_blocks) {
> >  		ret = erofs_bh_balloon(bh, blknr_to_addr(compressed_blocks));
> >  		DBG_BUGON(ret != EROFS_BLKSIZ);
> >  	} else {
> > -		DBG_BUGON(!inode->idata_size);
> > +		if (!cfg.c_fragments)
> > +			DBG_BUGON(!inode->idata_size);
> >  	}
> >  
> >  	erofs_info("compressed %s (%llu bytes) into %u blocks",
> > @@ -717,7 +755,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
> >  		DBG_BUGON(ret);
> >  	}
> >  	inode->compressmeta = compressmeta;
> > -	erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
> > +	if (is_src)
> > +		erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
> >  	return 0;
> >  
> >  err_free_idata:
> > @@ -727,8 +766,6 @@ err_free_idata:
> >  	}
> >  err_bdrop:
> >  	erofs_bdrop(bh, true);	/* revoke buffer */
> > -err_close:
> > -	close(fd);
> >  err_free_meta:
> >  	free(compressmeta);
> >  	return ret;
> > @@ -834,14 +871,27 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
> >  	 * to be loaded in order to get those compressed block counts.
> >  	 */
> >  	if (cfg.c_pclusterblks_max > 1) {
> > -		if (cfg.c_pclusterblks_max >
> > -		    Z_EROFS_PCLUSTER_MAX_SIZE / EROFS_BLKSIZ) {
> > +		if (cfg.c_pclusterblks_max > Z_EROFS_PCLUSTER_MAX_BLKS) {
> >  			erofs_err("unsupported clusterblks %u (too large)",
> >  				  cfg.c_pclusterblks_max);
> >  			return -EINVAL;
> >  		}
> > +		if (cfg.c_pclusterblks_packed > Z_EROFS_PCLUSTER_MAX_BLKS) {  
> 
> 			c_pclusterblks_packed should be smaller than c_pclusterblks_max
> 
> > +			erofs_err("unsupported clusterblks %u (too large for fragments)",
> > +				  cfg.c_pclusterblks_packed);
> > +			return -EINVAL;
> > +		}
> > +		if (cfg.c_pclusterblks_packed == 1) {
> > +			erofs_err("physical cluster size of fragments should > 4096 bytes");
> > +			return -EINVAL;
> > +		}  
> 
> How can this happen? why judging this here?
> 
> >  		erofs_sb_set_big_pcluster();
> >  	}
> > +	if (!erofs_sb_has_big_pcluster() && cfg.c_pclusterblks_packed > 1) {
> > +		erofs_err("invalid clusterblks %u (for fragments)",
> > +			  cfg.c_pclusterblks_packed);
> > +		return -EINVAL;
> > +	}  
> 
> The only condition I think would be
> 
> 	if (c_pclusterblks_packed > cfg.c_pclusterblks_max) {
> 		erofs_err("invalid physical cluster size for the packed file");
> 	}
> 
> 
> 
> >  
> >  	if (ret != Z_EROFS_COMPRESSION_LZ4)
> >  		erofs_sb_set_compr_cfgs();
> > diff --git a/lib/fragments.c b/lib/fragments.c
> > new file mode 100644
> > index 0000000..73c0d1b
> > --- /dev/null
> > +++ b/lib/fragments.c
> > @@ -0,0 +1,58 @@
> > +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> > +/*
> > + * Copyright (C), 2022, Coolpad Group Limited.
> > + * Created by Yue Hu <huyue2@coolpad.com>
> > + */
> > +#define _GNU_SOURCE
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include "erofs/err.h"
> > +#include "erofs/inode.h"
> > +#include "erofs/compress.h"
> > +#include "erofs/print.h"
> > +#include "erofs/fragments.h"
> > +
> > +static FILE *packedfile;
> > +
> > +int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
> > +			   unsigned int len)
> > +{
> > +	inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
> > +	inode->fragmentoff = ftell(packedfile);
> > +	inode->fragment_size = len;
> > +
> > +	if (write(fileno(packedfile), data, len) < 0)
> > +		return -EIO;
> > +
> > +	erofs_sb_set_fragments();
> > +
> > +	erofs_dbg("Recording %u fragment data at %lu", inode->fragment_size,
> > +		  inode->fragmentoff);
> > +	return len;
> > +}
> > +
> > +struct erofs_inode *erofs_mkfs_build_fragments(void)
> > +{
> > +	fseek(packedfile, 0, SEEK_SET);
> > +
> > +	return erofs_mkfs_build_special_from_fd(fileno(packedfile),
> > +						"packed_file");
> > +}
> > +
> > +void erofs_fragments_exit(void)
> > +{
> > +	if (packedfile)
> > +		fclose(packedfile);
> > +}
> > +
> > +int erofs_fragments_init(void)
> > +{
> > +#ifdef HAVE_TMPFILE64
> > +	packedfile = tmpfile64();
> > +#else
> > +	packedfile = tmpfile();
> > +#endif
> > +	if (!packedfile)
> > +		return -ENOMEM;
> > +	return 0;
> > +}
> > diff --git a/lib/inode.c b/lib/inode.c
> > index 4da28b3..e6f3dfa 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -424,7 +424,11 @@ int erofs_write_file(struct erofs_inode *inode)
> >  	}
> >  
> >  	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
> > -		ret = erofs_write_compressed_file(inode);
> > +		fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
> > +		if (fd < 0)
> > +			return -errno;
> > +		ret = erofs_write_compressed_file_from_fd(inode, fd, true);
> > +		close(fd);
> >  
> >  		if (!ret || ret != -ENOSPC)
> >  			return ret;
> > @@ -935,6 +939,24 @@ static struct erofs_inode *erofs_new_inode(void)
> >  	return inode;
> >  }
> >  
> > +static struct erofs_inode *erofs_generate_inode(struct stat64 *st,
> > +						const char *path)  
> 
> let's avoid such helper, since it doesn't simplify a lot.
> 
> Thanks,
> Gao Xiang
> 
> > +{
> > +	struct erofs_inode *inode;
> > +	int ret;
> > +
> > +	inode = erofs_new_inode();
> > +	if (IS_ERR(inode))
> > +		return inode;
> > +
> > +	ret = erofs_fill_inode(inode, st, path);
> > +	if (ret) {
> > +		free(inode);
> > +		return ERR_PTR(ret);
> > +	}
> > +	return inode;
> > +}
> > +
> >  /* get the inode from the (source) path */
> >  static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
> >  {
> > @@ -962,17 +984,7 @@ static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
> >  	}
> >  
> >  	/* cannot find in the inode cache */
> > -	inode = erofs_new_inode();
> > -	if (IS_ERR(inode))
> > -		return inode;
> > -
> > -	ret = erofs_fill_inode(inode, &st, path);
> > -	if (ret) {
> > -		free(inode);
> > -		return ERR_PTR(ret);
> > -	}
> > -
> > -	return inode;
> > +	return erofs_generate_inode(&st, path);
> >  }
> >  
> >  static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
> > @@ -1180,3 +1192,26 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
> >  
> >  	return erofs_mkfs_build_tree(inode);
> >  }
> > +
> > +struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
> > +{
> > +        struct stat64 st;
> > +        struct erofs_inode *inode;
> > +        int ret;
> > +
> > +        ret = fstat64(fd, &st);
> > +        if (ret)
> > +                return ERR_PTR(-errno);
> > +
> > +        inode = erofs_generate_inode(&st, name);
> > +        if (IS_ERR(inode))
> > +                return inode;
> > +
> > +	/* only for compressed file now */
> > +        ret = erofs_write_compressed_file_from_fd(inode, fd, false);
> > +        if (ret)
> > +                return ERR_PTR(ret);
> > +
> > +        erofs_prepare_inode_buffer(inode);
> > +        return inode;
> > +}
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index b969b35..cfc2c4a 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -23,6 +23,7 @@
> >  #include "erofs/block_list.h"
> >  #include "erofs/compress_hints.h"
> >  #include "erofs/blobchunk.h"
> > +#include "erofs/fragments.h"
> >  #include "../lib/liberofs_private.h"
> >  
> >  #ifdef HAVE_LIBUUID
> > @@ -133,9 +134,9 @@ static int parse_extended_opts(const char *opts)
> >  		const char *p = strchr(token, ',');
> >  
> >  		next = NULL;
> > -		if (p)
> > +		if (p) {
> >  			next = p + 1;
> > -		else {
> > +		} else {
> >  			p = token + strlen(token);
> >  			next = p;
> >  		}
> > @@ -202,7 +203,34 @@ static int parse_extended_opts(const char *opts)
> >  				return -EINVAL;
> >  			cfg.c_ztailpacking = true;
> >  		}
> > +
> > +		if (MATCH_EXTENTED_OPT("fragments", token, keylen)) {
> > +			char *endptr;
> > +			u64 i;
> > +
> > +			if (vallen || cfg.c_ztailpacking)
> > +				return -EINVAL;
> > +			cfg.c_fragments = true;
> > +
> > +			i = strtoull(next, &endptr, 0);
> > +			if (i == 0 || (*endptr != ',' && *endptr != '\0')) {
> > +				cfg.c_pclusterblks_packed = 1;
> > +				continue;
> > +			}
> > +			if (i % EROFS_BLKSIZ) {
> > +				erofs_err("invalid physical clustersize %llu",
> > +					  i);
> > +				return -EINVAL;
> > +			}
> > +			cfg.c_pclusterblks_packed = i / EROFS_BLKSIZ;
> > +
> > +			if (*endptr == ',')
> > +				next = strchr(next, ',')  + 1;
> > +			else
> > +				goto out;
> > +		}
> >  	}
> > +out:
> >  	return 0;
> >  }
> >  
> > @@ -458,7 +486,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
> >  
> >  int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
> >  				  erofs_nid_t root_nid,
> > -				  erofs_blk_t *blocks)
> > +				  erofs_blk_t *blocks,
> > +				  erofs_nid_t packed_nid)
> >  {
> >  	struct erofs_super_block sb = {
> >  		.magic     = cpu_to_le32(EROFS_SUPER_MAGIC_V1),
> > @@ -482,6 +511,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
> >  	*blocks         = erofs_mapbh(NULL);
> >  	sb.blocks       = cpu_to_le32(*blocks);
> >  	sb.root_nid     = cpu_to_le16(root_nid);
> > +	sb.packed_nid    = cpu_to_le64(packed_nid);
> >  	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
> >  
> >  	if (erofs_sb_has_compr_cfgs())
> > @@ -599,8 +629,8 @@ int main(int argc, char **argv)
> >  {
> >  	int err = 0;
> >  	struct erofs_buffer_head *sb_bh;
> > -	struct erofs_inode *root_inode;
> > -	erofs_nid_t root_nid;
> > +	struct erofs_inode *root_inode, *packed_inode;
> > +	erofs_nid_t root_nid, packed_nid;
> >  	struct stat64 st;
> >  	erofs_blk_t nblocks;
> >  	struct timeval t;
> > @@ -670,6 +700,14 @@ int main(int argc, char **argv)
> >  		erofs_warn("EXPERIMENTAL chunked file feature in use. Use at your own risk!");
> >  	if (cfg.c_ztailpacking)
> >  		erofs_warn("EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
> > +	if (cfg.c_fragments) {
> > +		err = erofs_fragments_init();
> > +		if (err) {
> > +			erofs_err("failed to initialize fragments");
> > +			return 1;
> > +		}
> > +		erofs_warn("EXPERIMENTAL compressed fragments feature in use. Use at your own risk!");
> > +	}
> >  	erofs_set_fs_root(cfg.c_src_path);
> >  #ifndef NDEBUG
> >  	if (cfg.c_random_pclusterblks)
> > @@ -739,7 +777,19 @@ int main(int argc, char **argv)
> >  			goto exit;
> >  	}
> >  
> > -	err = erofs_mkfs_update_super_block(sb_bh, root_nid, &nblocks);
> > +	packed_nid = 0;
> > +	if (cfg.c_fragments) {
> > +		packed_inode = erofs_mkfs_build_fragments();
> > +		if (IS_ERR(packed_inode)) {
> > +			err = PTR_ERR(packed_inode);
> > +			goto exit;
> > +		}
> > +		packed_nid = erofs_lookupnid(packed_inode);
> > +		erofs_iput(packed_inode);
> > +	}
> > +
> > +	err = erofs_mkfs_update_super_block(sb_bh, root_nid, &nblocks,
> > +					    packed_nid);
> >  	if (err)
> >  		goto exit;
> >  
> > @@ -761,6 +811,8 @@ exit:
> >  	erofs_cleanup_exclude_rules();
> >  	if (cfg.c_chunkbits)
> >  		erofs_blob_exit();
> > +	if (cfg.c_fragments)
> > +		erofs_fragments_exit();
> >  	erofs_exit_configure();
> >  
> >  	if (err) {
> > -- 
> > 2.17.1  

