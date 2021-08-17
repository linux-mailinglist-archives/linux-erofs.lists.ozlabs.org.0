Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4AC3EE17C
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Aug 2021 02:54:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GpXc674c4z2yZ2
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Aug 2021 10:54:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GpXc308PGz2yP0
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 Aug 2021 10:54:23 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04420; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0UjGrjA7_1629161655; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UjGrjA7_1629161655) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 17 Aug 2021 08:54:17 +0800
Date: Tue, 17 Aug 2021 08:54:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 1/2] erofs: add support for the full decompressed lengthy
Message-ID: <YRsItrKiD0Wa3oTr@B-P7TQMD6M-0146.local>
References: <20210813052931.203280-1-hsiangkao@linux.alibaba.com>
 <20210813052931.203280-2-hsiangkao@linux.alibaba.com>
 <f3437906-f983-65f9-8471-35f94b57d889@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3437906-f983-65f9-8471-35f94b57d889@kernel.org>
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
Cc: Lasse Collin <lasse.collin@tukaani.org>, nl6720 <nl6720@gmail.com>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Aug 16, 2021 at 11:38:03PM +0800, Chao Yu wrote:
> On 2021/8/13 13:29, Gao Xiang wrote:
> > Previously, there is no need to get the full decompressed length since
> > EROFS supports partial decompression. However for some other cases
> > such as fiemap, the full decompressed length is necessary for iomap to
> > make it work properly.
> > 
> > This patch adds a way to get the full decompressed length. Note that
> > it takes more metadata overhead and it'd be avoided if possible in the
> > performance sensitive scenario.
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >   fs/erofs/internal.h |  5 +++
> >   fs/erofs/zmap.c     | 93 +++++++++++++++++++++++++++++++++++++++++----
> >   2 files changed, 90 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > index 25b094085ca6..2a05b09e1c06 100644
> > --- a/fs/erofs/internal.h
> > +++ b/fs/erofs/internal.h
> > @@ -356,6 +356,11 @@ struct erofs_map_blocks {
> >   /* Flags used by erofs_map_blocks_flatmode() */
> >   #define EROFS_GET_BLOCKS_RAW    0x0001
> > +/*
> > + * Used to get the exact decompressed length, e.g. fiemap (consider lookback
> > + * approach instead if possible since it's quite metadata expensive.)
> > + */
> > +#define EROFS_GET_BLOCKS_FIEMAP	0x0002
> >   /* zmap.c */
> >   #ifdef CONFIG_EROFS_FS_ZIP
> > diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> > index f68aea4baed7..12256ef12819 100644
> > --- a/fs/erofs/zmap.c
> > +++ b/fs/erofs/zmap.c
> > @@ -212,9 +212,32 @@ static unsigned int decode_compactedbits(unsigned int lobits,
> >   	return lo;
> >   }
> > +static int get_compacted_la_distance(unsigned int lclusterbits,
> > +				     unsigned int encodebits,
> > +				     unsigned int vcnt, u8 *in, int i)
> > +{
> > +	const unsigned int lomask = (1 << lclusterbits) - 1;
> > +	unsigned int lo, d1 = 0;
> > +	u8 type;
> > +
> > +	for (; i < vcnt; ++i) {
> 
> for (di = 0; i < vcnt; ++i, ++d1)

Hi Chao,

Thanks for the review

this could cause lo potential uninitialized warning (actually it's
unpossible). So I resent [PATCH v1.1] as

https://lore.kernel.org/linux-erofs/20210814152727.78451-1-hsiangkao@linux.alibaba.com/

Please kindly help check out...

> 
> > +		lo = decode_compactedbits(lclusterbits, lomask,
> > +					  in, encodebits * i, &type);
> > +
> > +		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
> > +			return d1;
> 
> [1]
> 
> > +		++d1;
> > +	}
> > +
> > +	/* vcnt - 1 (Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) item */
> > +	if (!(lo & Z_EROFS_VLE_DI_D0_CBLKCNT))
> > +		d1 += lo - 1;
> > +	return d1;
> > +}
> > +
> >   static int unpack_compacted_index(struct z_erofs_maprecorder *m,
> >   				  unsigned int amortizedshift,
> > -				  unsigned int eofs)
> > +				  unsigned int eofs, bool lookahead)
> >   {
> >   	struct erofs_inode *const vi = EROFS_I(m->inode);
> >   	const unsigned int lclusterbits = vi->z_logical_clusterbits;
> > @@ -243,6 +266,11 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
> >   	m->type = type;
> >   	if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
> >   		m->clusterofs = 1 << lclusterbits;
> > +
> > +		/* figure out lookahead_distance: delta[1] if needed */
> > +		if (lookahead)
> > +			m->delta[1] = get_compacted_la_distance(lclusterbits,
> > +						encodebits, vcnt, in, i);
> >   		if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT) {
> >   			if (!big_pcluster) {
> >   				DBG_BUGON(1);
> > @@ -313,7 +341,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
> >   }
> >   static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> > -					    unsigned long lcn)
> > +					    unsigned long lcn, bool lookahead)
> >   {
> >   	struct inode *const inode = m->inode;
> >   	struct erofs_inode *const vi = EROFS_I(inode);
> > @@ -364,11 +392,12 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> >   	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
> >   	if (err)
> >   		return err;
> > -	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos));
> > +	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos),
> > +				      lookahead);
> >   }
> >   static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> > -					  unsigned int lcn)
> > +					  unsigned int lcn, bool lookahead)
> >   {
> >   	const unsigned int datamode = EROFS_I(m->inode)->datalayout;
> > @@ -376,7 +405,7 @@ static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> >   		return legacy_load_cluster_from_disk(m, lcn);
> >   	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
> > -		return compacted_load_cluster_from_disk(m, lcn);
> > +		return compacted_load_cluster_from_disk(m, lcn, lookahead);
> >   	return -EINVAL;
> >   }
> > @@ -399,7 +428,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
> >   	/* load extent head logical cluster if needed */
> >   	lcn -= lookback_distance;
> > -	err = z_erofs_load_cluster_from_disk(m, lcn);
> > +	err = z_erofs_load_cluster_from_disk(m, lcn, false);
> >   	if (err)
> >   		return err;
> > @@ -450,7 +479,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
> >   	if (m->compressedlcs)
> >   		goto out;
> > -	err = z_erofs_load_cluster_from_disk(m, lcn);
> > +	err = z_erofs_load_cluster_from_disk(m, lcn, false);
> >   	if (err)
> >   		return err;
> > @@ -498,6 +527,48 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
> >   	return -EFSCORRUPTED;
> >   }
> > +static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
> > +{
> > +	struct inode *inode = m->inode;
> > +	struct erofs_inode *vi = EROFS_I(inode);
> > +	struct erofs_map_blocks *map = m->map;
> > +	unsigned int lclusterbits = vi->z_logical_clusterbits;
> > +	u64 lcn = m->lcn, headlcn = map->m_la >> lclusterbits;
> > +	int err;
> > +
> > +	do {
> > +		/* handle the last EOF pcluster (no next HEAD lcluster) */
> > +		if ((lcn << lclusterbits) >= inode->i_size) {
> > +			map->m_llen = inode->i_size - map->m_la;
> > +			return 0;
> > +		}
> > +
> > +		err = z_erofs_load_cluster_from_disk(m, lcn, true);
> > +		if (err)
> > +			return err;
> > +
> > +		if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
> > +			if (!m->delta[1])
> > +				DBG_BUGON(m->clusterofs != 1 << lclusterbits);
> 
> 			DBG_BUGON(!m->delta[1] &&
> 				m->clusterofs != 1 << lclusterbits);
> 

Ok, will update.

> > +		} else if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
> > +			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD) {
> > +			/* go on until the next HEAD lcluster */
> > +			if (lcn != headlcn)
> > +				break;
> > +			m->delta[1] = 1;
> 
> If I didn't miss anything, return value [1] of get_compacted_la_distance()
> won't be used anyway here? right?

These are two different things, first, return value [1] is used to calculate
length to the next lcluster, e.g.

   NONHEAD NONHEAD HEAD
     ^
     m->lcn
so here in the first loop, delta[1] = 2, and m->type == NONHEAD,
the second loop, m->type == HEAD, lcn != headlcn, so we are done.


Yet here the logic is instead
if m->lcn == m->headlcn, so m->lcn points to this lcluster HEAD, but we
need to find the next lcluster, e.g.

   HEAD NONHEAD NONHEAD NONHEAD HEAD
    ^                             ^
    m->lcn, m->headlcn            we need to get this

so we lcn == headlcn, we need to go on and get the next HEAD lcluster
one.

It will use since m->lcn could be originally equal to headlcn (point to
this HEAD lcluster) 

Thanks,
Gao Xiang

> 
> Thanks,
> 
> > +		} else {
> > +			erofs_err(inode->i_sb, "unknown type %u @ lcn %llu of nid %llu",
> > +				  m->type, lcn, vi->nid);
> > +			DBG_BUGON(1);
> > +			return -EOPNOTSUPP;
> > +		}
> > +		lcn += m->delta[1];
> > +	} while (m->delta[1]);
> > +
> > +	map->m_llen = (lcn << lclusterbits) + m->clusterofs - map->m_la;
> > +	return 0;
> > +}
> > +
> >   int z_erofs_map_blocks_iter(struct inode *inode,
> >   			    struct erofs_map_blocks *map,
> >   			    int flags)
> > @@ -531,7 +602,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
> >   	initial_lcn = ofs >> lclusterbits;
> >   	endoff = ofs & ((1 << lclusterbits) - 1);
> > -	err = z_erofs_load_cluster_from_disk(&m, initial_lcn);
> > +	err = z_erofs_load_cluster_from_disk(&m, initial_lcn, false);
> >   	if (err)
> >   		goto unmap_out;
> > @@ -581,6 +652,12 @@ int z_erofs_map_blocks_iter(struct inode *inode,
> >   	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
> >   	if (err)
> >   		goto out;
> > +
> > +	if (flags & EROFS_GET_BLOCKS_FIEMAP) {
> > +		err = z_erofs_get_extent_decompressedlen(&m);
> > +		if (!err)
> > +			map->m_flags |= EROFS_MAP_FULL_MAPPED;
> > +	}
> >   unmap_out:
> >   	if (m.kaddr)
> >   		kunmap_atomic(m.kaddr);
> > 
