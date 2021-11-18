Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23A6455475
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Nov 2021 06:54:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hvprz2DjZz2ynQ
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Nov 2021 16:54:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=XYutp2DJ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035;
 helo=mail-pj1-x1035.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=XYutp2DJ; dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hvprq2bMPz2xXx
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Nov 2021 16:54:01 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id
 n15-20020a17090a160f00b001a75089daa3so7288092pja.1
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Nov 2021 21:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BJmqTr/59lWWyEGphtWhkV6FMrrSy0AsXYnE8qCzhL0=;
 b=XYutp2DJ+FxQGf76OVQ86JGHSHBQPe+dVJDQEaHucaTWPx9AYD7nA66HThQAC0Y0Uc
 MhEYgT4yBsAgodfmR2niCymxxO7YJ7iDBSQyB5e9RvZh6vTHw8edvvVc0x5rQEp55d2I
 iex60ECWTep2+V+6VP0fAGPd1NmJAi519o1vntmCQmICH6A0LlMKwCG79Q3K+aPTE+ii
 kbHckuurEYyoI92+9tPrqZDzrQHuyakbxa/ws8KXNBy5AXcC7V1qzs8QHHT+pqMJmUpl
 WcIM/34aPqDcHnyetEGfZmVtAoo7EYuK0KVRMWho4tl1cKNgXsmA8obJ7PxRmaiOjth6
 4law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BJmqTr/59lWWyEGphtWhkV6FMrrSy0AsXYnE8qCzhL0=;
 b=lTEV/sZDANmbXaZmebKYanqpAOZIb5e6vc2aVSpI5vlBbiOWcPMzPfLGZfR6AeGX0d
 +S5zwZRjnAjPw5VCVS4ofHWXKWQ6OAAOzXnzYeVxMWQWkJTlU1J063KW42KGCajHL3NF
 pC7cGorlcbIQEKAE9WFOBDSjrTnaonvoDC3JwprBWu8QImK/3J/S4L3nz07TXKsji0kg
 JhvzfT2lv2ojYLAyvTF8WgLCf5FkZaort/uVkI4n0Tn/IfnsLiO57sN89GUtH7cyQZg8
 pgz6ztbpYd4GtNq6nBqUC83SA48cdoSI1mZJYO9DGLzfjjeinvyCOoA/bBQvnlYb/esf
 1Slw==
X-Gm-Message-State: AOAM533EULOE9ZRLNMGIQEfNjW24cHIK2bToEZlK0B+6GPwfoiit0Wq2
 sQkIBVli5gnQweId//d/fu+g+++zAEFWPw==
X-Google-Smtp-Source: ABdhPJwd47WHC5YtDUN7GuoibGtuBkFsBcbVoBfqKjSGMjlNBwRHPGLYgmL09gFYwKNHYKnV4dU11Q==
X-Received: by 2002:a17:90a:b88d:: with SMTP id
 o13mr7113211pjr.39.1637214836290; 
 Wed, 17 Nov 2021 21:53:56 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id b130sm1544119pfb.9.2021.11.17.21.53.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 17 Nov 2021 21:53:56 -0800 (PST)
Date: Thu, 18 Nov 2021 13:51:33 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v4 6/6] erofs-utils: get compression algorithms directly
 on mapping
Message-ID: <20211118135133.00002c4e.zbestahu@gmail.com>
In-Reply-To: <20211116094939.32246-7-hsiangkao@linux.alibaba.com>
References: <20211116094939.32246-1-hsiangkao@linux.alibaba.com>
 <20211116094939.32246-7-hsiangkao@linux.alibaba.com>
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
Cc: Yan Song <imeoer@linux.alibaba.com>, Peng Tao <tao.peng@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Changwei Ge <chge@linux.alibaba.com>, Liu Jiang <gerry@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 16 Nov 2021 17:49:39 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Keep in sync with the latest kernel
> commit 8f89926290c4 ("erofs: get compression algorithms directly on mapping")
> 
> And it also fixes fsck MicroLZMA support, btw.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fsck/main.c                |  8 ++------
>  include/erofs/decompress.h |  5 -----
>  include/erofs/internal.h   | 12 +++++++++---
>  lib/data.c                 | 10 ++--------
>  lib/zmap.c                 | 19 ++++++++++---------
>  5 files changed, 23 insertions(+), 31 deletions(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index 7bee5605b9df..aefa881f740a 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -287,7 +287,7 @@ static int verify_compressed_inode(struct erofs_inode *inode)
>  	int ret = 0;
>  	u64 pchunk_len = 0;
>  	erofs_off_t end = inode->i_size;
> -	unsigned int algorithmformat, raw_size = 0, buffer_size = 0;
> +	unsigned int raw_size = 0, buffer_size = 0;
>  	char *raw = NULL, *buffer = NULL;
>  
>  	while (end > 0) {
> @@ -310,10 +310,6 @@ static int verify_compressed_inode(struct erofs_inode *inode)
>  		if (!fsckcfg.check_decomp || !(map.m_flags & EROFS_MAP_MAPPED))
>  			continue;
>  
> -		algorithmformat = map.m_flags & EROFS_MAP_ZIPPED ?
> -						Z_EROFS_COMPRESSION_LZ4 :
> -						Z_EROFS_COMPRESSION_SHIFTED;
> -
>  		if (map.m_plen > raw_size) {
>  			raw_size = map.m_plen;
>  			raw = realloc(raw, raw_size);
> @@ -350,7 +346,7 @@ static int verify_compressed_inode(struct erofs_inode *inode)
>  					.decodedskip = 0,
>  					.inputsize = map.m_plen,
>  					.decodedlength = map.m_llen,
> -					.alg = algorithmformat,
> +					.alg = map.m_algorithmformat,
>  					.partial_decoding = 0
>  					 });
>  
> diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
> index 0ba2b08daa73..3d0d9633865d 100644
> --- a/include/erofs/decompress.h
> +++ b/include/erofs/decompress.h
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
>  	char *in, *out;
>  
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 93e05bbc8271..666d1f2df466 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -252,7 +252,7 @@ static inline const char *erofs_strerror(int err)
>  enum {
>  	BH_Meta,
>  	BH_Mapped,
> -	BH_Zipped,
> +	BH_Encoded,
>  	BH_FullMapped,
>  };
>  
> @@ -260,8 +260,8 @@ enum {
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
> @@ -272,6 +272,7 @@ struct erofs_map_blocks {
>  	u64 m_plen, m_llen;
>  
>  	unsigned short m_deviceid;
> +	char m_algorithmformat;
>  	unsigned int m_flags;
>  	erofs_blk_t index;
>  };
> @@ -282,6 +283,11 @@ struct erofs_map_blocks {
>   */
>  #define EROFS_GET_BLOCKS_FIEMAP	0x0002
>  
> +enum {
> +	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
> +	Z_EROFS_COMPRESSION_RUNTIME_MAX
> +};
> +
>  struct erofs_map_dev {
>  	erofs_off_t m_pa;
>  	unsigned int m_deviceid;
> diff --git a/lib/data.c b/lib/data.c
> index 136c0d97ab45..27710f941615 100644
> --- a/lib/data.c
> +++ b/lib/data.c
> @@ -226,12 +226,11 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
>  	};
>  	struct erofs_map_dev mdev;
>  	bool partial;
> -	unsigned int algorithmformat, bufsize;
> +	unsigned int bufsize = 0;
>  	char *raw = NULL;
>  	int ret = 0;
>  
>  	end = offset + size;
> -	bufsize = 0;
>  	while (end > offset) {
>  		map.m_la = end - 1;
>  
> @@ -288,18 +287,13 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
>  		if (ret < 0)
>  			break;
>  
> -		if (map.m_flags & EROFS_MAP_ZIPPED)
> -			algorithmformat = inode->z_algorithmtype[0];
> -		else
> -			algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
> -
>  		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
>  					.in = raw,
>  					.out = buffer + end - offset,
>  					.decodedskip = skip,
>  					.inputsize = map.m_plen,
>  					.decodedlength = length,
> -					.alg = algorithmformat,
> +					.alg = map.m_algorithmformat,
>  					.partial_decoding = partial
>  					 });
>  		if (ret < 0)
> diff --git a/lib/zmap.c b/lib/zmap.c
> index 9dd0c7633a45..3715c47e3647 100644
> --- a/lib/zmap.c
> +++ b/lib/zmap.c
> @@ -72,7 +72,7 @@ struct z_erofs_maprecorder {
>  
>  	unsigned long lcn;
>  	/* compression extent information gathered */
> -	u8  type;
> +	u8  type, headtype;
>  	u16 clusterofs;
>  	u16 delta[2];
>  	erofs_blk_t pblk, compressedlcs;
> @@ -390,9 +390,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>  		}
>  		return z_erofs_extent_lookback(m, m->delta[0]);
>  	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -		map->m_flags &= ~EROFS_MAP_ZIPPED;
> -		/* fallthrough */
>  	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +		m->headtype = m->type;
>  		map->m_la = (lcn << lclusterbits) | m->clusterofs;
>  		break;
>  	default:
> @@ -415,7 +414,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  
>  	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
>  		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
> -	if (!(map->m_flags & EROFS_MAP_ZIPPED) ||
> +	if (m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
>  	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
>  		map->m_plen = 1 << lclusterbits;
>  		return 0;
> @@ -548,15 +547,13 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
>  	if (err)
>  		goto out;
>  
> -	map->m_flags = EROFS_MAP_ZIPPED;	/* by default, compressed */
> +	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
>  	end = (m.lcn + 1ULL) << lclusterbits;
>  	switch (m.type) {
>  	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -		if (endoff >= m.clusterofs)
> -			map->m_flags &= ~EROFS_MAP_ZIPPED;
> -		/* fallthrough */
>  	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
>  		if (endoff >= m.clusterofs) {
> +			m.headtype = m.type;
>  			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
>  			break;
>  		}
> @@ -586,12 +583,16 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
>  
>  	map->m_llen = end - map->m_la;
>  	map->m_pa = blknr_to_addr(m.pblk);
> -	map->m_flags |= EROFS_MAP_MAPPED;
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

Reviewed-by: Yue Hu <huyue2@yulong.com>

Thanks.
