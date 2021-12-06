Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A9377468E5B
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Dec 2021 01:39:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J6l1f4RL7z2yPD
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Dec 2021 11:39:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J6l1X3bxVz2xKK
 for <linux-erofs@lists.ozlabs.org>; Mon,  6 Dec 2021 11:39:24 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R381e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UzTYkud_1638751144; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UzTYkud_1638751144) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 06 Dec 2021 08:39:06 +0800
Date: Mon, 6 Dec 2021 08:39:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <huyue2@yulong.com>
Subject: Re: [RFC PATCH v3 2/2] erofs-utils: fuse: support tail-packing
 inline compressed data
Message-ID: <Ya1bqEn/2IetbXOT@B-P7TQMD6M-0146.local>
References: <cover.1637140430.git.huyue2@yulong.com>
 <fcb5afd747456997284bbd411a68e4a19b41966f.1637140430.git.huyue2@yulong.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fcb5afd747456997284bbd411a68e4a19b41966f.1637140430.git.huyue2@yulong.com>
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
Cc: geshifei@yulong.com, zhangwen@yulong.com, linux-erofs@lists.ozlabs.org,
 shaojunjun@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Wed, Nov 17, 2021 at 05:22:01PM +0800, Yue Hu via Linux-erofs wrote:
> Add tail-packing inline compressed data support for erofsfuse.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Sorry about long delay, I'm very busy in container use cases now.
I've checked your patch, some inlined comments below.

> ---
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
>  include/erofs/internal.h |   2 +
>  lib/decompress.c         |   3 -
>  lib/zmap.c               | 136 +++++++++++++++++++++++++++++++++------
>  3 files changed, 120 insertions(+), 21 deletions(-)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 54e5939..5d1a44c 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -172,6 +172,8 @@ struct erofs_inode {
>  			uint8_t  z_algorithmtype[2];
>  			uint8_t  z_logical_clusterbits;
>  			uint8_t  z_physical_clusterblks;
> +			uint16_t z_idata_size;
> +			uint32_t z_idata_headlcn;
>  		};
>  	};
>  #ifdef WITH_ANDROID
> diff --git a/lib/decompress.c b/lib/decompress.c
> index 6f4ecc2..806ac91 100644
> --- a/lib/decompress.c
> +++ b/lib/decompress.c
> @@ -71,9 +71,6 @@ out:
>  int z_erofs_decompress(struct z_erofs_decompress_req *rq)
>  {
>  	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
> -		if (rq->inputsize != EROFS_BLKSIZ)
> -			return -EFSCORRUPTED;
> -

		if (rq->inputsize > EROFS_BLKSIZ)
			return -EFSCORRUPTED;

>  		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
>  		DBG_BUGON(rq->decodedlength < rq->decodedskip);
>  
> diff --git a/lib/zmap.c b/lib/zmap.c
> index 458030b..42783e5 100644
> --- a/lib/zmap.c
> +++ b/lib/zmap.c
> @@ -10,6 +10,9 @@
>  #include "erofs/io.h"
>  #include "erofs/print.h"
>  
> +static int z_erofs_do_map_blocks(struct erofs_inode *vi,
> +				 struct erofs_map_blocks *map);
> +
>  int z_erofs_fill_inode(struct erofs_inode *vi)
>  {
>  	if (!erofs_sb_has_big_pcluster() &&
> @@ -18,12 +21,69 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
>  		vi->z_algorithmtype[0] = 0;
>  		vi->z_algorithmtype[1] = 0;
>  		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
> +		vi->z_idata_size = 0;
>  
>  		vi->flags |= EROFS_I_Z_INITED;
> +		DBG_BUGON(erofs_sb_has_tail_packing());
>  	}
>  	return 0;
>  }
>  
> +static erofs_off_t compacted_inline_data_addr(struct erofs_inode *vi,
> +					      unsigned int totalidx)
> +{
> +	const erofs_off_t ebase = round_up(iloc(vi->nid) + vi->inode_isize +
> +				  vi->xattr_isize, 8) +
> +				  sizeof(struct z_erofs_map_header);
> +	unsigned int compacted_4b_initial, compacted_4b_end;
> +	unsigned int compacted_2b;
> +	erofs_off_t addr;
> +
> +	compacted_4b_initial = (32 - ebase % 32) / 4;
> +	if (compacted_4b_initial == 32 / 4)
> +		compacted_4b_initial = 0;
> +
> +	if (compacted_4b_initial > totalidx) {
> +		compacted_4b_initial = 0;
> +		compacted_2b = 0;
> +	} else if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) {
> +		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
> +	} else
> +		compacted_2b = 0;
> +
> +	compacted_4b_end = totalidx - compacted_4b_initial - compacted_2b;
> +
> +	addr = ebase + compacted_4b_initial * 4 + compacted_2b * 2;
> +	if (compacted_4b_end > 1)
> +		addr += (compacted_4b_end/2) * 8;
> +	if (compacted_4b_end % 2)
> +		addr += 8;
> +
> +	return addr;
> +}
> +
> +static erofs_off_t legacy_inline_data_addr(struct erofs_inode *vi,
> +					   unsigned int totalidx)
> +{
> +	return Z_EROFS_VLE_LEGACY_INDEX_ALIGN(iloc(vi->nid) + vi->inode_isize +
> +					      vi->xattr_isize) +
> +		totalidx * sizeof(struct z_erofs_vle_decompressed_index);
> +}
> +
> +static erofs_off_t z_erofs_inline_data_addr(struct erofs_inode *vi)
> +{
> +	const unsigned int datamode = vi->datalayout;
> +	const unsigned int totalidx = DIV_ROUND_UP(vi->i_size, EROFS_BLKSIZ);
> +
> +	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
> +		return compacted_inline_data_addr(vi, totalidx);
> +
> +	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
> +		return legacy_inline_data_addr(vi, totalidx);
> +
> +	return -EINVAL;
> +}

no need these three new functions if introducing
EROFS_GET_BLOCKS_FINDTAIL, see below..

> +
>  static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
>  {
>  	int ret;
> @@ -44,6 +104,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
>  
>  	h = (struct z_erofs_map_header *)buf;
>  	vi->z_advise = le16_to_cpu(h->h_advise);
> +	vi->z_idata_size = le16_to_cpu(h->h_idata_size);
>  	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
>  	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
>  
> @@ -61,6 +122,16 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
>  			  vi->nid * 1ULL);
>  		return -EFSCORRUPTED;
>  	}
> +
> +	if (vi->z_idata_size) {
> +		struct erofs_map_blocks map = { .m_la = vi->i_size - 1 };
> +
> +		ret = z_erofs_do_map_blocks(vi, &map);
> +		if (ret)
> +			return ret;

How about introducing another mode called
EROFS_GET_BLOCKS_FINDTAIL

which implys .m_la = vi->i_size - 1 internally, so we won't need to
handle .m_la here.

> +		vi->z_idata_headlcn = map.m_la >> vi->z_logical_clusterbits;

Also updaing vi->z_idata_headlcn when EROFS_GET_BLOCKS_FINDTAIL.

> +	}
> +
>  	vi->flags |= EROFS_I_Z_INITED;
>  	return 0;
>  }
> @@ -374,7 +445,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>  }
>  
>  static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
> -					    unsigned int initial_lcn)
> +					    unsigned int initial_lcn,
> +					    bool idatamap)
>  {
>  	struct erofs_inode *const vi = m->inode;
>  	struct erofs_map_blocks *const map = m->map;
> @@ -384,6 +456,12 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  
>  	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
>  		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
> +
> +	if (idatamap) {
> +		map->m_plen = vi->z_idata_size;
> +		return 0;
> +	}
> +
>  	if (!(map->m_flags & EROFS_MAP_ZIPPED) ||
>  	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
>  		map->m_plen = 1 << lclusterbits;
> @@ -440,8 +518,8 @@ err_bonus_cblkcnt:
>  	return -EFSCORRUPTED;
>  }
>  
> -int z_erofs_map_blocks_iter(struct erofs_inode *vi,
> -			    struct erofs_map_blocks *map)
> +static int z_erofs_do_map_blocks(struct erofs_inode *vi,
> +				 struct erofs_map_blocks *map)
>  {
>  	struct z_erofs_maprecorder m = {
>  		.inode = vi,
> @@ -452,18 +530,7 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
>  	unsigned int lclusterbits, endoff;
>  	unsigned long initial_lcn;
>  	unsigned long long ofs, end;
> -
> -	/* when trying to read beyond EOF, leave it unmapped */
> -	if (map->m_la >= vi->i_size) {
> -		map->m_llen = map->m_la + 1 - vi->i_size;
> -		map->m_la = vi->i_size;
> -		map->m_flags = 0;
> -		goto out;
> -	}
> -
> -	err = z_erofs_fill_inode_lazy(vi);
> -	if (err)
> -		goto out;
> +	bool idatamap;
>  
>  	lclusterbits = vi->z_logical_clusterbits;
>  	ofs = map->m_la;
> @@ -510,19 +577,52 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
>  		goto out;
>  	}
>  
> +	/* check if mapping tail-packing data */
> +	idatamap = vi->z_idata_size && (ofs == vi->i_size - 1 ||
> +		   m.lcn == vi->z_idata_headlcn);

better namin as `is_idata'...

I think no need to handle ofs == vi->i_size - 1 specially here
if EROFS_GET_BLOCKS_FINDTAIL is introduced...

> +
> +	/* need to trim tail-packing data if beyond file size */
>  	map->m_llen = end - map->m_la;
> -	map->m_pa = blknr_to_addr(m.pblk);
> +	if (idatamap && end > vi->i_size)
> +		map->m_llen -= end - vi->i_size;

No need as well?

>  
> -	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
> +	if (idatamap && (vi->z_advise & Z_EROFS_ADVISE_INLINE_DATA)) {
> +		map->m_pa = z_erofs_inline_data_addr(vi);

How about setting another u32 z_idataoff when EROFS_GET_BLOCKS_FINDTAIL
so we won't need to introduce another calculate methods instead?

Thanks,
Gao Xiang
