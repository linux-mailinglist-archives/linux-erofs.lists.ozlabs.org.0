Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAEF42757F
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Oct 2021 03:52:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HR7NP3LpNz308J
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Oct 2021 12:52:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=m8+6I0Ak;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b;
 helo=mail-pg1-x52b.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=m8+6I0Ak; dkim-atps=neutral
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HR7NK6FNhz3000
 for <linux-erofs@lists.ozlabs.org>; Sat,  9 Oct 2021 12:52:15 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id 133so4769825pgb.1
 for <linux-erofs@lists.ozlabs.org>; Fri, 08 Oct 2021 18:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J3/G+Htr0JzoQ9SW3wtIiw5W7YL3z8+P6XbDg6D7GbI=;
 b=m8+6I0AkdQ6x6UksboO6N1QINdiEk6XajNGDuHqhLFaZdEmTVA0YYxFThZhwfdClSJ
 zJY2AaBb/H3PPjv3mNLqkXbIdGwBaW6trRH75Ge2Wx1DqWcrk0RvH6w/jGjRxqCdGFAd
 2bKOHS457JB7ytkR8gupGVj4Z9f0wYGhw6rat3oBFHGMpbSefj43BH2oDa4DySHZ0sit
 kBGHh5LHiuTV8wymPKl6IcqIoHyy234J9UrW4jmk8MH6jCmSkgKHEIPiuf0adu8x9Hs0
 7kQ6QjEq0z2BgoUQqsfN5n4UBYVb3o5mLQLJzRZIflU7cYC45buPGT0wab1ft76NWcpb
 o24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J3/G+Htr0JzoQ9SW3wtIiw5W7YL3z8+P6XbDg6D7GbI=;
 b=IVy69pCZ6KuHwGRpPBmRYTlbW2wMSBLuHC/bPu801slFtiqzXuMi4xpVEABwiTgD94
 PKwkPgzi+JwynOnf+LOXRZ642M+AJc+6PzgEl4BADgPu6JJ72C1B+uHr68zHcqBXr022
 dJ5VWWLqaCQ6y/S0XJO41hX79Ui1E4SJWnYXitgVBfTmMGskcWMzTvdhgt7UA5lYjFN+
 vCalA3uKNaED8UVaUORp8EBxbJhPpzvTeeGGRNj7xWP63caCDlwMRYElH0JdlRnoLImu
 Kl7xUK0NLreSVYvY8psCL9A/O5nxZSw66u7w+5LASjp5EA9fmmxqw14a6oHlvSJcxF58
 ii7g==
X-Gm-Message-State: AOAM533InejqK9UILKEo+HGrADS79/0AEF13Cg47urN/yySv4LUs+zxY
 mlhkyMcruRplgaqSX7hRzQY=
X-Google-Smtp-Source: ABdhPJxVc5UpfDMkvsxcKWseNE5uyehdjqaPjnS14YlXBlap57ULvnJRqqdLE8o1kNq1b41gX+BzkA==
X-Received: by 2002:a62:7e4e:0:b0:44c:51f5:5895 with SMTP id
 z75-20020a627e4e000000b0044c51f55895mr13234300pfc.73.1633744331133; 
 Fri, 08 Oct 2021 18:52:11 -0700 (PDT)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id i18sm486958pfq.198.2021.10.08.18.52.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Oct 2021 18:52:10 -0700 (PDT)
Date: Sat, 9 Oct 2021 09:52:04 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH v2 1/3] erofs: get compression algorithms directly on
 mapping
Message-ID: <20211009095204.00000974.zbestahu@gmail.com>
In-Reply-To: <20211008200839.24541-2-xiang@kernel.org>
References: <20211008200839.24541-1-xiang@kernel.org>
 <20211008200839.24541-2-xiang@kernel.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, shaojunjun@yulong.com,
 huyue2@yulong.com, Gao Xiang <hsiangkao@linux.alibaba.com>,
 zhangwen@yulong.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat,  9 Oct 2021 04:08:37 +0800
Gao Xiang <xiang@kernel.org> wrote:

> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Currently, z_erofs_map_blocks_iter() returns whether extents are
> compressed or not, and the decompression frontend gets the specific
> algorithms then.
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
> Let's look up compression algorithms in z_erofs_map_blocks_iter()
> directly instead.
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

Looks good to me.

Reviewed-by: Yue Hu <huyue2@yulong.com>

>  
>  TRACE_EVENT(erofs_lookup,
>  

