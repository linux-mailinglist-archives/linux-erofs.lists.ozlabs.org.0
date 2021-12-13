Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD28472AED
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Dec 2021 12:10:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JCJh448T7z2yPP
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Dec 2021 22:10:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JCJgz6F9Hz2yLd
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Dec 2021 22:10:05 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0V-WlIDw_1639393794; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V-WlIDw_1639393794) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 13 Dec 2021 19:09:56 +0800
Date: Mon, 13 Dec 2021 19:09:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <huyue2@yulong.com>
Subject: Re: [RFC PATCH v5 1/2] erofs-utils: fuse: support tail-packing
 inline compressed data
Message-ID: <YbcqArpVrEXjLzW/@B-P7TQMD6M-0146.local>
References: <1fc2694139fa8b217208992c72ec8ef383e3ff9e.1639377756.git.huyue2@yulong.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1fc2694139fa8b217208992c72ec8ef383e3ff9e.1639377756.git.huyue2@yulong.com>
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
Cc: geshifei@coolpad.com, zhangwen@coolpad.com, linux-erofs@lists.ozlabs.org,
 shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Mon, Dec 13, 2021 at 02:50:54PM +0800, Yue Hu wrote:
> Add tail-packing inline compressed data support for erofsfuse.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

This version almost looks fine to me, no need to update. I will polish
it this week.

> ---
> v5:
> - use nextpackoff instead and move into map_recorder suggested by Xiang.
> - calculate next pack offset from the aligning view of pos.
> 
> v4:
> - introduce EROFS_GET_BLOCKS_FINDTAIL suggested by Xiang.
> - remove 3 functions about calculation to inline data address
>   and calculate it directly when reload index.
> - add m_nxtioff/z_idataoff to help get/record the inline data address.
> - add on-disk feature related.
> 
> v3:
> - remove z_idata_addr, add z_idata_headlcn instead of m_taillcn.
> - add bug_on for legacy if enable inline and disable big pcluster.
> - extract z_erofs_do_map_blocks() instead of added
>   z_erofs_map_tail_data_blocks() with similar logic.
> 
> v2:
> - add tail-packing information to inode and get it on first read.
> - update tail-packing checking logic.
> 
>  include/erofs/internal.h |   6 +++
>  include/erofs_fs.h       |  10 +++-
>  lib/decompress.c         |   2 +-
>  lib/namei.c              |   2 +-
>  lib/zmap.c               | 106 +++++++++++++++++++++++++++++++--------
>  5 files changed, 100 insertions(+), 26 deletions(-)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 8b154ed..6f33bb8 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -110,6 +110,7 @@ EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
>  EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
>  EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
>  EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
> +EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
>  EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
>  
>  #define EROFS_I_EA_INITED	(1 << 0)
> @@ -171,6 +172,9 @@ struct erofs_inode {
>  			uint8_t  z_algorithmtype[2];
>  			uint8_t  z_logical_clusterbits;
>  			uint8_t  z_physical_clusterblks;
> +			uint16_t z_idata_size;
> +			uint32_t z_idata_headlcn;
> +			uint64_t z_idataoff;

we could use `uint32_t z_idataoff' instead?

>  		};
>  	};
>  #ifdef WITH_ANDROID
> @@ -259,6 +263,8 @@ struct erofs_map_blocks {
>  	erofs_blk_t index;
>  };
>  
> +#define EROFS_GET_BLOCKS_FINDTAIL	0x0001
> +
>  /* super.c */
>  int erofs_read_superblock(void);
>  
> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> index 66a68e3..0e87e85 100644
> --- a/include/erofs_fs.h
> +++ b/include/erofs_fs.h
> @@ -22,11 +22,13 @@
>  #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
>  #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
>  #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
> +#define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
>  #define EROFS_ALL_FEATURE_INCOMPAT		\
>  	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
>  	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
>  	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
> -	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE)
> +	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
> +	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING)
>  
>  #define EROFS_SB_EXTSLOT_SIZE	16
>  
> @@ -266,13 +268,17 @@ struct z_erofs_lz4_cfgs {
>   *                                  (4B) + 2B + (4B) if compacted 2B is on.
>   * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
>   * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
> + * bit 3 : tailpacking inline data
>   */
>  #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
>  #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
>  #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
> +#define Z_EROFS_ADVISE_INLINE_DATA		0x0008
>  
>  struct z_erofs_map_header {
> -	__le32	h_reserved1;
> +	__le16	h_reserved1;
> +	/* record the size of tailpacking data */
> +	__le16  h_idata_size;
>  	__le16	h_advise;
>  	/*
>  	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
> diff --git a/lib/decompress.c b/lib/decompress.c
> index 2ee1439..9b90d18 100644
> --- a/lib/decompress.c
> +++ b/lib/decompress.c
> @@ -67,7 +67,7 @@ out:
>  int z_erofs_decompress(struct z_erofs_decompress_req *rq)
>  {
>  	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
> -		if (rq->inputsize != EROFS_BLKSIZ)
> +		if (rq->inputsize > EROFS_BLKSIZ)
>  			return -EFSCORRUPTED;
>  
>  		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
> diff --git a/lib/namei.c b/lib/namei.c
> index b4bdabf..481b33e 100644
> --- a/lib/namei.c
> +++ b/lib/namei.c
> @@ -137,7 +137,7 @@ static int erofs_read_inode_from_disk(struct erofs_inode *vi)
>  		vi->u.chunkbits = LOG_BLOCK_SIZE +
>  			(vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
>  	} else if (erofs_inode_is_data_compressed(vi->datalayout))
> -		z_erofs_fill_inode(vi);
> +		return z_erofs_fill_inode(vi);
>  	return 0;
>  bogusimode:
>  	erofs_err("bogus i_mode (%o) @ nid %llu", vi->i_mode, vi->nid | 0ULL);
> diff --git a/lib/zmap.c b/lib/zmap.c
> index 458030b..be9905c 100644
> --- a/lib/zmap.c
> +++ b/lib/zmap.c
> @@ -10,6 +10,10 @@
>  #include "erofs/io.h"
>  #include "erofs/print.h"
>  
> +static int z_erofs_do_map_blocks(struct erofs_inode *vi,
> +				 struct erofs_map_blocks *map,
> +				 int flags);
> +
>  int z_erofs_fill_inode(struct erofs_inode *vi)
>  {
>  	if (!erofs_sb_has_big_pcluster() &&
> @@ -18,8 +22,13 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
>  		vi->z_algorithmtype[0] = 0;
>  		vi->z_algorithmtype[1] = 0;
>  		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
> +		vi->z_idata_size = 0;
>  
>  		vi->flags |= EROFS_I_Z_INITED;
> +		if (erofs_sb_has_ztailpacking()) {
> +			erofs_err("unsupported, plz enable big pcluster for legacy compression inline");
> +			return -EOPNOTSUPP;
> +		}

We could make erofs_sb_has_ztailpacking() not go
z_erofs_fill_inode() instead.


>  	}
>  	return 0;
>  }
> @@ -44,6 +53,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
>  
>  	h = (struct z_erofs_map_header *)buf;
>  	vi->z_advise = le16_to_cpu(h->h_advise);
> +	vi->z_idata_size = le16_to_cpu(h->h_idata_size);
>  	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
>  	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
>  
> @@ -61,6 +71,16 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
>  			  vi->nid * 1ULL);
>  		return -EFSCORRUPTED;
>  	}
> +
> +	if (vi->z_idata_size) {
> +		struct erofs_map_blocks map = { .index = UINT_MAX };
> +
> +		ret = z_erofs_do_map_blocks(vi, &map,
> +					    EROFS_GET_BLOCKS_FINDTAIL);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	vi->flags |= EROFS_I_Z_INITED;
>  	return 0;
>  }
> @@ -76,6 +96,7 @@ struct z_erofs_maprecorder {
>  	u16 clusterofs;
>  	u16 delta[2];
>  	erofs_blk_t pblk, compressedlcs;
> +	erofs_off_t nextpackoff;
>  };
>  
>  static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
> @@ -113,6 +134,7 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
>  	if (err)
>  		return err;
> +	m->nextpackoff = pos + sizeof(struct z_erofs_vle_decompressed_index);
>  
>  	m->lcn = lcn;
>  	di = m->kaddr + erofs_blkoff(pos);
> @@ -161,12 +183,12 @@ static unsigned int decode_compactedbits(unsigned int lobits,
>  
>  static int unpack_compacted_index(struct z_erofs_maprecorder *m,
>  				  unsigned int amortizedshift,
> -				  unsigned int eofs)
> +				  erofs_off_t pos)
>  {
>  	struct erofs_inode *const vi = m->inode;
>  	const unsigned int lclusterbits = vi->z_logical_clusterbits;
>  	const unsigned int lomask = (1 << lclusterbits) - 1;
> -	unsigned int vcnt, base, lo, encodebits, nblk;
> +	unsigned int vcnt, base, lo, encodebits, nblk, eofs;
>  	int i;
>  	u8 *in, type;
>  	bool big_pcluster;
> @@ -178,8 +200,12 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
>  	else
>  		return -EOPNOTSUPP;
>  
> +	m->nextpackoff = rounddown(pos, vcnt << amortizedshift) +
> +			 (vcnt << amortizedshift);
> +
>  	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
>  	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
> +	eofs = erofs_blkoff(pos);
>  	base = round_down(eofs, vcnt << amortizedshift);
>  	in = m->kaddr + base;
>  
> @@ -285,7 +311,9 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  	if (compacted_4b_initial == 32 / 4)
>  		compacted_4b_initial = 0;
>  
> -	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> +	if (compacted_4b_initial > totalidx)
> +		compacted_4b_initial = compacted_2b = 0;

We could backport upstream patch for this ;)

> +	else if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
>  		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
>  	else
>  		compacted_2b = 0;

Thanks,
Gao Xiang
