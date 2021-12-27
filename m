Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5882D47FABE
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 08:26:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JMq3T27B5z2yp9
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 18:26:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=myLiTVDA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436;
 helo=mail-pf1-x436.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=myLiTVDA; dkim-atps=neutral
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JMq3L0LrSz2yP3
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Dec 2021 18:26:20 +1100 (AEDT)
Received: by mail-pf1-x436.google.com with SMTP id c2so13026830pfc.1
 for <linux-erofs@lists.ozlabs.org>; Sun, 26 Dec 2021 23:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=He34Scs0tQk+7pfdt5xEcQPNHIESpcBZBXRXZghBQ2k=;
 b=myLiTVDAtT+DslZlTdpn7lOcfecbAofIjIrvmZcYS7MBsqR6YPBNd9XT0uI+lLh8tF
 C9FUgDn5MsPOJpSZJlaunfNPZue+aopJse5vGd620bo4pdUnoktSsXbKdvgWCzdERLje
 3CZpgKwAhv9QJuY8zOeNPu02/C7CrZKoQkNRJyAjLPYFirOGw/CB0F4Hs3fk+C/65nR/
 khqBcpLJXvs6yQTfa9xHA+oJQ31HTU5snfOtXc1bvXW+HfIw991VRq1IJklYo58h6RCC
 IcshwgQ6+aVhldYKSbIawrtIdbhUfTc16+ykzKtyr4uT8spaRpLnHg3VlK3LdeF0aObD
 X1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=He34Scs0tQk+7pfdt5xEcQPNHIESpcBZBXRXZghBQ2k=;
 b=qoQvyH+ekp2K8ujcMlQZyJS9Xe3rg1Hb+5vXS6UWqUXx53EWUSdb1VxfEXlecHoRus
 n501KhM58h2PapIDeiuQPBIkv/Aq1wwgYLTNBmbRLJ3ldWQFK2Bv6MRuKLLYQJ7hXLgr
 2fAVYx7RpBQoZ066Ly6bvMUtWJgiKQ/MRuA2zBvEe3EAIm1s1vwAScLQZkn28LOwVVrR
 BWmOSPlvPgdS9jA3pu+qXGlk3SiJabqLlHIzZe8zYG0vLXQQ5Cot85yuWbhYRGFTg5jG
 +TkShUtGwL/H6M6G67EYQmyaqUSYq3pFTbt7UrovngFViujVhjftUQ0rCKzvAi+Vs2Yg
 /2Hg==
X-Gm-Message-State: AOAM530jEqpVfndWC/tr+KDzmfxD79UJhYbaDXxPhPckNOEGgrPpEFrA
 bvvs0i0MJUc2+zwRaxSyCw8=
X-Google-Smtp-Source: ABdhPJx1+2KDv7UaVWyrFlFnbhxL1oLrf8vDNCiiy/OydR2Ui9vQtuEpCK1YKnIun/gWkMWY42tcOA==
X-Received: by 2002:a63:3d0e:: with SMTP id k14mr4808997pga.484.1640589975515; 
 Sun, 26 Dec 2021 23:26:15 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id h8sm3153698pfi.205.2021.12.26.23.26.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 26 Dec 2021 23:26:15 -0800 (PST)
Date: Mon, 27 Dec 2021 15:23:26 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v3 5/5] erofs: add on-disk compressed tail-packing
 inline support
Message-ID: <20211227152326.0000486b.zbestahu@gmail.com>
In-Reply-To: <20211225070626.74080-6-hsiangkao@linux.alibaba.com>
References: <20211225070626.74080-1-hsiangkao@linux.alibaba.com>
 <20211225070626.74080-6-hsiangkao@linux.alibaba.com>
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
Cc: geshifei@coolpad.com, LKML <linux-kernel@vger.kernel.org>,
 zhangwen@coolpad.com, Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
 shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On Sat, 25 Dec 2021 15:06:26 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> From: Yue Hu <huyue2@yulong.com>
> 
> Introduces erofs compressed tail-packing inline support.
> 
> This approach adds a new field called `h_idata_size' in the
> per-file compression header to indicate the encoded size of
> each tail-packing pcluster.
> 
> At runtime, it will find the start logical offset of the tail
> pcluster when initializing per-inode zmap and record such
> extent (headlcn, idataoff) information to the in-memory inode.
> Therefore, follow-on requests can directly recognize if one
> pcluster is a tail-packing inline pcluster or not.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/erofs_fs.h |  10 +++-
>  fs/erofs/internal.h |   6 +++
>  fs/erofs/super.c    |   3 ++
>  fs/erofs/sysfs.c    |   2 +
>  fs/erofs/zmap.c     | 116 ++++++++++++++++++++++++++++++++------------
>  5 files changed, 105 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index dda79afb901d..3ea62c6fb00a 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -23,13 +23,15 @@
>  #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
>  #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
>  #define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
> +#define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
>  #define EROFS_ALL_FEATURE_INCOMPAT		\
>  	(EROFS_FEATURE_INCOMPAT_ZERO_PADDING | \
>  	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
>  	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
>  	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
>  	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
> -	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2)
> +	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2 | \
> +	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING)
>  
>  #define EROFS_SB_EXTSLOT_SIZE	16
>  
> @@ -292,13 +294,17 @@ struct z_erofs_lzma_cfgs {
>   *                                  (4B) + 2B + (4B) if compacted 2B is on.
>   * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
>   * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
> + * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
>   */
>  #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
>  #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
>  #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
> +#define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
>  
>  struct z_erofs_map_header {
> -	__le32	h_reserved1;
> +	__le16	h_reserved1;
> +	/* indicates the encoded size of tailpacking data */
> +	__le16  h_idata_size;
>  	__le16	h_advise;
>  	/*
>  	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 8e70435629e5..ebb9ffa08dd2 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -274,6 +274,7 @@ EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
>  EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
>  EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
>  EROFS_FEATURE_FUNCS(compr_head2, incompat, INCOMPAT_COMPR_HEAD2)
> +EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
>  EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
>  
>  /* atomic flag definitions */
> @@ -308,6 +309,9 @@ struct erofs_inode {
>  			unsigned short z_advise;
>  			unsigned char  z_algorithmtype[2];
>  			unsigned char  z_logical_clusterbits;
> +			unsigned long  z_idata_headlcn;
> +			unsigned int  z_idataoff;

need a space?

> +			unsigned short z_idata_size;
>  		};
>  #endif	/* CONFIG_EROFS_FS_ZIP */
>  	};
> @@ -421,6 +425,8 @@ struct erofs_map_blocks {
>  #define EROFS_GET_BLOCKS_FIEMAP	0x0002
>  /* Used to map the whole extent if non-negligible data is requested for LZMA */
>  #define EROFS_GET_BLOCKS_READMORE	0x0004
> +/* Used to map tail extent for tailpacking inline pcluster */
> +#define EROFS_GET_BLOCKS_FINDTAIL	0x0008
>  
>  enum {
>  	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 58f381f80205..0724ad5fd6cf 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -411,6 +411,9 @@ static int erofs_read_superblock(struct super_block *sb)
>  
>  	/* handle multiple devices */
>  	ret = erofs_init_devices(sb, dsb);
> +
> +	if (erofs_sb_has_ztailpacking(sbi))
> +		erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
>  out:
>  	kunmap(page);
>  	put_page(page);
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index 666693432107..dac252bc9228 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -75,6 +75,7 @@ EROFS_ATTR_FEATURE(chunked_file);
>  EROFS_ATTR_FEATURE(device_table);
>  EROFS_ATTR_FEATURE(compr_head2);
>  EROFS_ATTR_FEATURE(sb_chksum);
> +EROFS_ATTR_FEATURE(ztailpacking);
>  
>  static struct attribute *erofs_feat_attrs[] = {
>  	ATTR_LIST(zero_padding),
> @@ -84,6 +85,7 @@ static struct attribute *erofs_feat_attrs[] = {
>  	ATTR_LIST(device_table),
>  	ATTR_LIST(compr_head2),
>  	ATTR_LIST(sb_chksum),
> +	ATTR_LIST(ztailpacking),
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(erofs_feat);
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 660489a7fb64..52b5369f9b42 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -7,12 +7,17 @@
>  #include <asm/unaligned.h>
>  #include <trace/events/erofs.h>
>  
> +static int z_erofs_do_map_blocks(struct inode *inode,
> +				 struct erofs_map_blocks *map,
> +				 int flags);
> +
>  int z_erofs_fill_inode(struct inode *inode)
>  {
>  	struct erofs_inode *const vi = EROFS_I(inode);
>  	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>  
>  	if (!erofs_sb_has_big_pcluster(sbi) &&
> +	    !erofs_sb_has_ztailpacking(sbi) &&
>  	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
>  		vi->z_advise = 0;
>  		vi->z_algorithmtype[0] = 0;
> @@ -51,6 +56,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  		goto out_unlock;
>  
>  	DBG_BUGON(!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
> +		  !erofs_sb_has_ztailpacking(EROFS_SB(sb)) &&
>  		  vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
>  
>  	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
> @@ -65,6 +71,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  
>  	h = kaddr + erofs_blkoff(pos);
>  	vi->z_advise = le16_to_cpu(h->h_advise);
> +	vi->z_idata_size = le16_to_cpu(h->h_idata_size);

duplicated code?

>  	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
>  	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
>  
> @@ -94,13 +101,34 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  		err = -EFSCORRUPTED;
>  		goto unmap_done;
>  	}
> -	/* paired with smp_mb() at the beginning of the function */
> -	smp_mb();
> -	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
>  unmap_done:
>  	kunmap_atomic(kaddr);
>  	unlock_page(page);
>  	put_page(page);
> +	if (err)
> +		goto out_unlock;
> +
> +	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
> +		struct erofs_map_blocks map = { .mpage = NULL };
> +
> +		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
> +		err = z_erofs_do_map_blocks(inode, &map,
> +					    EROFS_GET_BLOCKS_FINDTAIL);
> +		if (map.mpage)
> +			put_page(map.mpage);
> +
> +		if (!map.m_plen ||
> +		    erofs_blkoff(map.m_pa) + map.m_plen > EROFS_BLKSIZ) {
> +			erofs_err(sb, "invalid tail-packing pclustersize %llu",
> +				  map.m_plen);
> +			err = -EFSCORRUPTED;
> +		}
> +		if (err < 0)
> +			goto out_unlock;
> +	}
> +	/* paired with smp_mb() at the beginning of the function */
> +	smp_mb();
> +	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
>  out_unlock:
>  	clear_and_wake_up_bit(EROFS_I_BL_Z_BIT, &vi->flags);
>  	return err;
> @@ -117,6 +145,7 @@ struct z_erofs_maprecorder {
>  	u16 clusterofs;
>  	u16 delta[2];
>  	erofs_blk_t pblk, compressedlcs;
> +	erofs_off_t nextpackoff;
>  };
>  
>  static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
> @@ -169,6 +198,7 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  	if (err)
>  		return err;
>  
> +	m->nextpackoff = pos + sizeof(struct z_erofs_vle_decompressed_index);
>  	m->lcn = lcn;
>  	di = m->kaddr + erofs_blkoff(pos);
>  
> @@ -243,12 +273,12 @@ static int get_compacted_la_distance(unsigned int lclusterbits,
>  
>  static int unpack_compacted_index(struct z_erofs_maprecorder *m,
>  				  unsigned int amortizedshift,
> -				  unsigned int eofs, bool lookahead)
> +				  erofs_off_t pos, bool lookahead)
>  {
>  	struct erofs_inode *const vi = EROFS_I(m->inode);
>  	const unsigned int lclusterbits = vi->z_logical_clusterbits;
>  	const unsigned int lomask = (1 << lclusterbits) - 1;
> -	unsigned int vcnt, base, lo, encodebits, nblk;
> +	unsigned int vcnt, base, lo, encodebits, nblk, eofs;
>  	int i;
>  	u8 *in, type;
>  	bool big_pcluster;
> @@ -260,8 +290,12 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
>  	else
>  		return -EOPNOTSUPP;
>  
> +	/* it doesn't equal to roundup(..) */
> +	m->nextpackoff = rounddown(pos, vcnt << amortizedshift) +
> +			 (vcnt << amortizedshift);
>  	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
>  	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
> +	eofs = erofs_blkoff(pos);
>  	base = round_down(eofs, vcnt << amortizedshift);
>  	in = m->kaddr + base;
>  
> @@ -399,8 +433,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
>  	if (err)
>  		return err;
> -	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos),
> -				      lookahead);
> +	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
>  }
>  
>  static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> @@ -583,11 +616,12 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
>  	return 0;
>  }
>  
> -int z_erofs_map_blocks_iter(struct inode *inode,
> -			    struct erofs_map_blocks *map,
> -			    int flags)
> +static int z_erofs_do_map_blocks(struct inode *inode,
> +				 struct erofs_map_blocks *map,
> +				 int flags)
>  {
>  	struct erofs_inode *const vi = EROFS_I(inode);
> +	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
>  	struct z_erofs_maprecorder m = {
>  		.inode = inode,
>  		.map = map,
> @@ -597,22 +631,8 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  	unsigned long initial_lcn;
>  	unsigned long long ofs, end;
>  
> -	trace_z_erofs_map_blocks_iter_enter(inode, map, flags);
> -
> -	/* when trying to read beyond EOF, leave it unmapped */
> -	if (map->m_la >= inode->i_size) {
> -		map->m_llen = map->m_la + 1 - inode->i_size;
> -		map->m_la = inode->i_size;
> -		map->m_flags = 0;
> -		goto out;
> -	}
> -
> -	err = z_erofs_fill_inode_lazy(inode);
> -	if (err)
> -		goto out;
> -
>  	lclusterbits = vi->z_logical_clusterbits;
> -	ofs = map->m_la;
> +	ofs = flags & EROFS_GET_BLOCKS_FINDTAIL ? inode->i_size - 1 : map->m_la;
>  	initial_lcn = ofs >> lclusterbits;
>  	endoff = ofs & ((1 << lclusterbits) - 1);
>  
> @@ -620,6 +640,9 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  	if (err)
>  		goto unmap_out;
>  
> +	if (ztailpacking && (flags & EROFS_GET_BLOCKS_FINDTAIL))
> +		vi->z_idataoff = m.nextpackoff;
> +
>  	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
>  	end = (m.lcn + 1ULL) << lclusterbits;
>  
> @@ -658,12 +681,20 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  		goto unmap_out;
>  	}
>  
> -	map->m_llen = end - map->m_la;
> -	map->m_pa = blknr_to_addr(m.pblk);
> +	if (flags & EROFS_GET_BLOCKS_FINDTAIL)
> +		vi->z_idata_headlcn = m.lcn;

The name of "z_idata_headlcn" includes "idata" which looks like ztailpacking related?
If it is, add ztailpacking check here? If not, update it such as "z_tailextent_headlcn"?

>  
> -	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
> -	if (err)
> -		goto out;
> +	map->m_llen = end - map->m_la;
> +	if (ztailpacking && m.lcn == vi->z_idata_headlcn) {
> +		map->m_flags |= EROFS_MAP_META;
> +		map->m_pa = vi->z_idataoff;
> +		map->m_plen = vi->z_idata_size;
> +	} else {
> +		map->m_pa = blknr_to_addr(m.pblk);
> +		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
> +		if (err)
> +			goto out;
> +	}
>  
>  	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN)
>  		map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
> @@ -689,6 +720,31 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  		  __func__, map->m_la, map->m_pa,
>  		  map->m_llen, map->m_plen, map->m_flags);
>  
> +	return err;
> +}
> +
> +int z_erofs_map_blocks_iter(struct inode *inode,
> +			    struct erofs_map_blocks *map,
> +			    int flags)
> +{
> +	int err = 0;
> +
> +	trace_z_erofs_map_blocks_iter_enter(inode, map, flags);
> +
> +	/* when trying to read beyond EOF, leave it unmapped */
> +	if (map->m_la >= inode->i_size) {
> +		map->m_llen = map->m_la + 1 - inode->i_size;
> +		map->m_la = inode->i_size;
> +		map->m_flags = 0;
> +		goto out;
> +	}
> +
> +	err = z_erofs_fill_inode_lazy(inode);
> +	if (err)
> +		goto out;
> +
> +	err = z_erofs_do_map_blocks(inode, map, flags);
> +out:
>  	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
>  
>  	/* aggressively BUG_ON iff CONFIG_EROFS_FS_DEBUG is on */

