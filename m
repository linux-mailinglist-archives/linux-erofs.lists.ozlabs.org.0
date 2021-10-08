Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2460E4262AC
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Oct 2021 05:01:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HQXy30Bjxz2ygF
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Oct 2021 14:00:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=VOn/Q9jM;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532;
 helo=mail-pg1-x532.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=VOn/Q9jM; dkim-atps=neutral
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HQXxj6r27z308M
 for <linux-erofs@lists.ozlabs.org>; Fri,  8 Oct 2021 14:00:40 +1100 (AEDT)
Received: by mail-pg1-x532.google.com with SMTP id s11so1728267pgr.11
 for <linux-erofs@lists.ozlabs.org>; Thu, 07 Oct 2021 20:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dj0s5gHpb3ZbMoqbjqKgxJDgSpnR8KBBUz69TXB+ylM=;
 b=VOn/Q9jMxilGMYrm/f9y0YpvbgJdWgwjXqPiQCM0YjuT9He1HSKicLiXT5iCniVz4G
 J98lcSjyumXBlcgRSD8wWG+KsAtDsbCWB/hFrA8imeDQoSkq4c1dg7HdTRuhREwgD8Ne
 5Ix79QHgTCrz4bPlhaInrT/HWqJvsHH5MANvOj1u/FunOETOoOANCT58TzSJAhqb6bbM
 91+7TbxINeaDFCLoZw4FgIQhh7bITU2Ho/YpeobdUykFrhhPc4mSr4B7Q12o7IuOSBNW
 0VEXVn8LPKeABVR7RVmsaBMyGPpYdGnsWmzIvfnshW5k0/Wc79BGozjsz8LzXUQsPaah
 5pHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dj0s5gHpb3ZbMoqbjqKgxJDgSpnR8KBBUz69TXB+ylM=;
 b=r21FnedlOHjxJYbwNRWSUqZWIQPC4I35RWl611tDxUadfNpoDyxp+SlE0XRa2QJBb8
 +ok5O51lq3Q/LExSQAw8k85vFGINpAV1c7yKj2q7yB+y9Ld3PSrLsW//jmntXGP3SZ1W
 AyIBWszhPG4rFjS8A3WqnahFPyiUPKiA03I95msqL8XEns7/FaeOm2sn80kLF5udPQKi
 i9zyjBve4NgkBKHsKkGz5IGvRVrT2Z9EmMbkCxa2Erz7ShTz7ArG+kafXRTP+JNUg5xt
 l3d9F9tChVSjwQ/mwk8+VEfG8c9Q+QO2pVr6PETXh3TbyWXOJ15Gk0il6kbl3QUADtsl
 xKEg==
X-Gm-Message-State: AOAM532ktD6e/MzIJpfgaYEzpl6kC3WJGHwe/hJ3MYMlfDPRgapRJV/J
 FQ9RAtYtj3cwPKmtlSaAdO0=
X-Google-Smtp-Source: ABdhPJxvoZvwTNLYNZte1Y49PFZs5zGtriRYHpyVw38Pq0Tienu7yLSLI6dOlk+O2T6J3BYh11pxQA==
X-Received: by 2002:a63:7b48:: with SMTP id k8mr477530pgn.208.1633662036058;
 Thu, 07 Oct 2021 20:00:36 -0700 (PDT)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id g4sm653874pgs.42.2021.10.07.20.00.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Oct 2021 20:00:35 -0700 (PDT)
Date: Fri, 8 Oct 2021 11:00:29 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH 1/3] erofs: get compression algorithms directly on mapping
Message-ID: <20211008110029.0000181f.zbestahu@gmail.com>
In-Reply-To: <20211007170605.7062-2-xiang@kernel.org>
References: <20211007170605.7062-1-xiang@kernel.org>
 <20211007170605.7062-2-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri,  8 Oct 2021 01:06:03 +0800
Gao Xiang <xiang@kernel.org> wrote:

> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Currently, z_erofs_map_blocks returns whether extents are compressed

Mapping function is z_erofs_map_blocks_iter()?

> or not, and the decompression frontend gets the specific algorithms
> then.
> 
> It works but not quite well in many aspests, for example:
>  - The decompression frontend has to deal with whether extents are
>    compressed or not again and lookup the algorithms if compressed.
>    It's duplicated and too detailed about the on-disk mapping.
> 
>  - A new secondary compression head will be introduced later so that
>    each file can have 2 compression algorithms at most for different
>    type of data. It could increase the complexity of the decompression
>    frontend if still handled in this way;
> 
>  - A new readmore decompression strategy will be introduced to get
>    better performance for much bigger pcluster and lzma, which needs
>    the specific algorithm in advance as well.
> 
> Let's look up compression algorithms directly in z_erofs_map_blocks()

Same mapping function name mistake?

> instead.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/compress.h          |  5 -----
>  fs/erofs/internal.h          | 12 +++++++++---
>  fs/erofs/zdata.c             | 12 ++++++------
>  fs/erofs/zmap.c              | 19 ++++++++++---------
>  include/trace/events/erofs.h |  2 +-
>  5 files changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
> index 3701c72bacb2..ad62d1b4d371 100644
> --- a/fs/erofs/compress.h
> +++ b/fs/erofs/compress.h
> @@ -8,11 +8,6 @@
>  
>  #include "internal.h"
>  
> -enum {
> -	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
> -	Z_EROFS_COMPRESSION_RUNTIME_MAX
> -};
> -
>  struct z_erofs_decompress_req {
>  	struct super_block *sb;
>  	struct page **in, **out;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 9524e155b38f..48bfc6eb2b02 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -338,7 +338,7 @@ extern const struct address_space_operations z_erofs_aops;
>   * of the corresponding uncompressed data in the file.
>   */
>  enum {
> -	BH_Zipped = BH_PrivateStart,
> +	BH_Encoded = BH_PrivateStart,
>  	BH_FullMapped,
>  };
>  
> @@ -346,8 +346,8 @@ enum {
>  #define EROFS_MAP_MAPPED	(1 << BH_Mapped)
>  /* Located in metadata (could be copied from bd_inode) */
>  #define EROFS_MAP_META		(1 << BH_Meta)
> -/* The extent has been compressed */
> -#define EROFS_MAP_ZIPPED	(1 << BH_Zipped)
> +/* The extent is encoded */
> +#define EROFS_MAP_ENCODED	(1 << BH_Encoded)
>  /* The length of extent is full */
>  #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
>  
> @@ -355,6 +355,7 @@ struct erofs_map_blocks {
>  	erofs_off_t m_pa, m_la;
>  	u64 m_plen, m_llen;
>  
> +	char m_algorithmformat;
>  	unsigned int m_flags;
>  
>  	struct page *mpage;
> @@ -368,6 +369,11 @@ struct erofs_map_blocks {
>   */
>  #define EROFS_GET_BLOCKS_FIEMAP	0x0002
>  
> +enum {
> +	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
> +	Z_EROFS_COMPRESSION_RUNTIME_MAX
> +};
> +
>  /* zmap.c */
>  extern const struct iomap_ops z_erofs_iomap_report_ops;
>  
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 11c7a1aaebad..5c34ef66677f 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -476,6 +476,11 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
>  	struct erofs_workgroup *grp;
>  	int err;
>  
> +	if (!(map->m_flags & EROFS_MAP_ENCODED)) {
> +		DBG_BUGON(1);
> +		return -EFSCORRUPTED;
> +	}
> +
>  	/* no available pcluster, let's allocate one */
>  	pcl = z_erofs_alloc_pcluster(map->m_plen >> PAGE_SHIFT);
>  	if (IS_ERR(pcl))
> @@ -483,16 +488,11 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
>  
>  	atomic_set(&pcl->obj.refcount, 1);
>  	pcl->obj.index = map->m_pa >> PAGE_SHIFT;
> -
> +	pcl->algorithmformat = map->m_algorithmformat;
>  	pcl->length = (map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) |
>  		(map->m_flags & EROFS_MAP_FULL_MAPPED ?
>  			Z_EROFS_PCLUSTER_FULL_LENGTH : 0);
>  
> -	if (map->m_flags & EROFS_MAP_ZIPPED)
> -		pcl->algorithmformat = Z_EROFS_COMPRESSION_LZ4;
> -	else
> -		pcl->algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
> -
>  	/* new pclusters should be claimed as type 1, primary and followed */
>  	pcl->next = clt->owned_head;
>  	clt->mode = COLLECT_PRIMARY_FOLLOWED;
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 7a6df35fdc91..9d9c26343dab 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -111,7 +111,7 @@ struct z_erofs_maprecorder {
>  
>  	unsigned long lcn;
>  	/* compression extent information gathered */
> -	u8  type;
> +	u8  type, headtype;
>  	u16 clusterofs;
>  	u16 delta[2];
>  	erofs_blk_t pblk, compressedlcs;
> @@ -446,9 +446,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>  		}
>  		return z_erofs_extent_lookback(m, m->delta[0]);
>  	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -		map->m_flags &= ~EROFS_MAP_ZIPPED;
> -		fallthrough;
>  	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +		m->headtype = m->type;
>  		map->m_la = (lcn << lclusterbits) | m->clusterofs;
>  		break;
>  	default:
> @@ -472,7 +471,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  
>  	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
>  		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
> -	if (!(map->m_flags & EROFS_MAP_ZIPPED) ||
> +	if (m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
>  	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
>  		map->m_plen = 1 << lclusterbits;
>  		return 0;
> @@ -609,16 +608,13 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  	if (err)
>  		goto unmap_out;
>  
> -	map->m_flags = EROFS_MAP_ZIPPED;	/* by default, compressed */
>  	end = (m.lcn + 1ULL) << lclusterbits;
>  
>  	switch (m.type) {
>  	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -		if (endoff >= m.clusterofs)
> -			map->m_flags &= ~EROFS_MAP_ZIPPED;
> -		fallthrough;
>  	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
>  		if (endoff >= m.clusterofs) {
> +			m.headtype = m.type;
>  			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
>  			break;
>  		}
> @@ -650,12 +646,17 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  
>  	map->m_llen = end - map->m_la;
>  	map->m_pa = blknr_to_addr(m.pblk);
> -	map->m_flags |= EROFS_MAP_MAPPED;
> +	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;

Seems the new flag EROFS_MAP_ENCODED may be a little redundant?

It is used only for checking whether the file system is corrupted or not when
entering z_erofs_register_collection(). 

And before collection begins, we will check whether the EROFS_MAP_MAPPED is set
or not. We will do the collection only if EROFS_MAP_MAPPED is set. That's to say,
the above checking to EROFS_MAP_ENCODED should be not possible?

Thanks.

>  
>  	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
>  	if (err)
>  		goto out;
>  
> +	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN)
> +		map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
> +	else
> +		map->m_algorithmformat = vi->z_algorithmtype[0];
> +
>  	if (flags & EROFS_GET_BLOCKS_FIEMAP) {
>  		err = z_erofs_get_extent_decompressedlen(&m);
>  		if (!err)
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index db4f2cec8360..16ae7b666810 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -24,7 +24,7 @@ struct erofs_map_blocks;
>  #define show_mflags(flags) __print_flags(flags, "",	\
>  	{ EROFS_MAP_MAPPED,	"M" },			\
>  	{ EROFS_MAP_META,	"I" },			\
> -	{ EROFS_MAP_ZIPPED,	"Z" })
> +	{ EROFS_MAP_ENCODED,	"E" })
>  
>  TRACE_EVENT(erofs_lookup,
>  

