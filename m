Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 363E9468FC6
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Dec 2021 04:43:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J6q5M0gyYz2yV5
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Dec 2021 14:43:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Zp2sRyeM;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c;
 helo=mail-pl1-x62c.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=Zp2sRyeM; dkim-atps=neutral
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J6q5B5G4Xz2xsk
 for <linux-erofs@lists.ozlabs.org>; Mon,  6 Dec 2021 14:42:52 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id m24so6176447pls.10
 for <linux-erofs@lists.ozlabs.org>; Sun, 05 Dec 2021 19:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7Cphd9xo8Bz4oY6daS3vIRqki2hpgNt+Vtbk1uDGZ28=;
 b=Zp2sRyeMswksCWC5ePXJoli+kXC6UaS0xFmBMa9ceNjVYMXLvFW96bbXBbrIK3Nb2r
 shyahwI92oB8lV6yC/XF29M2o+kmZoqScsO7uncOFjuVxKWHNi4uvtDENe/wOop4Mu54
 lmXUEVPuC0k+v+srdZ6nL6EtEtyOp73hoztAMuho60DzNM3nEAT5wA3fQ7j+aZqBZjkC
 jyjSOSdsQiWLaxDjIb0R4qXA/4Oo8yoWqnZuYHSEW5aJRmAQ2RrpLqq2+LBCHKB5GxEq
 aQ5vim2jAySQNAgFN0IUISRDHFIIzhwncnbcFjgsQt28FHG9sk1eNpjRRTWRcroLTnVe
 eWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7Cphd9xo8Bz4oY6daS3vIRqki2hpgNt+Vtbk1uDGZ28=;
 b=fKD30HpicTHScHoR0uG3Y+l/Rr/9j82iIm62TMBN0UdcDCW3ytzxrMkn2MZAs4yMCw
 WF7W7mqZSzwEUoksspTOMnkrflDa8NBM5DnDRodec6hoqO6aFkuJBnu7LnlFWxy5c5RZ
 MshVEt9b+xoK1AsMtwyiKQWv22lFp9QIhS3LHzbn0/QqvJm2NIsRJu66AXGbCKj81gcr
 rW7yq/1CAtjBvjdI1HXSmPkxtdXK6nlDibtsNtzYSMGYcPHvHybtyJQVY9Dzw4UmTHFr
 GjyN4U2YbIUWX9RakcI51Iz9f7pkwYe2dEHrw9H/NrpfnJvcB2QUe+tWigNBvK548Qpo
 coQw==
X-Gm-Message-State: AOAM533rrikU4vETSKH54B20iAOmQZKi1H8vDy319COEIEg62JYqSU7v
 wIZLeDl8qQGrULiozTHvi18=
X-Google-Smtp-Source: ABdhPJz7BsY339C6K8QTrccq2TI9yGg/OgWeoqxLCxxdoZWENTjtrfY0HW7jhYpKbQX7oeDt64JNxw==
X-Received: by 2002:a17:902:768b:b0:144:e570:c7d2 with SMTP id
 m11-20020a170902768b00b00144e570c7d2mr41191146pll.86.1638762169152; 
 Sun, 05 Dec 2021 19:42:49 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id l2sm10261013pfc.42.2021.12.05.19.42.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 05 Dec 2021 19:42:49 -0800 (PST)
Date: Mon, 6 Dec 2021 11:40:10 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH v3 2/2] erofs-utils: fuse: support tail-packing
 inline compressed data
Message-ID: <20211206114010.00006f6e.zbestahu@gmail.com>
In-Reply-To: <Ya1bqEn/2IetbXOT@B-P7TQMD6M-0146.local>
References: <cover.1637140430.git.huyue2@yulong.com>
 <fcb5afd747456997284bbd411a68e4a19b41966f.1637140430.git.huyue2@yulong.com>
 <Ya1bqEn/2IetbXOT@B-P7TQMD6M-0146.local>
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
Cc: linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@yulong.com>,
 geshifei@yulong.com, zhangwen@yulong.com, shaojunjun@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On Mon, 6 Dec 2021 08:39:04 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Wed, Nov 17, 2021 at 05:22:01PM +0800, Yue Hu via Linux-erofs wrote:
> > Add tail-packing inline compressed data support for erofsfuse.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>  
> 
> Sorry about long delay, I'm very busy in container use cases now.
> I've checked your patch, some inlined comments below.
> 
> > ---
> > v3:
> > - remove z_idata_addr, add z_idata_headlcn instead of m_taillcn.
> > - add bug_on for legacy if enable inline and disable big pcluster.
> > - extract z_erofs_do_map_blocks() instead of added
> >   z_erofs_map_tail_data_blocks() with similar logic.
> > 
> > v2:
> > - add tail-packing information to inode and get it on first read.
> > - update tail-packing checking logic.
> > 
> >  include/erofs/internal.h |   2 +
> >  lib/decompress.c         |   3 -
> >  lib/zmap.c               | 136 +++++++++++++++++++++++++++++++++------
> >  3 files changed, 120 insertions(+), 21 deletions(-)
> > 
> > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > index 54e5939..5d1a44c 100644
> > --- a/include/erofs/internal.h
> > +++ b/include/erofs/internal.h
> > @@ -172,6 +172,8 @@ struct erofs_inode {
> >  			uint8_t  z_algorithmtype[2];
> >  			uint8_t  z_logical_clusterbits;
> >  			uint8_t  z_physical_clusterblks;
> > +			uint16_t z_idata_size;
> > +			uint32_t z_idata_headlcn;
> >  		};
> >  	};
> >  #ifdef WITH_ANDROID
> > diff --git a/lib/decompress.c b/lib/decompress.c
> > index 6f4ecc2..806ac91 100644
> > --- a/lib/decompress.c
> > +++ b/lib/decompress.c
> > @@ -71,9 +71,6 @@ out:
> >  int z_erofs_decompress(struct z_erofs_decompress_req *rq)
> >  {
> >  	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
> > -		if (rq->inputsize != EROFS_BLKSIZ)
> > -			return -EFSCORRUPTED;
> > -  
> 
> 		if (rq->inputsize > EROFS_BLKSIZ)
> 			return -EFSCORRUPTED;
> 
> >  		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
> >  		DBG_BUGON(rq->decodedlength < rq->decodedskip);
> >  
> > diff --git a/lib/zmap.c b/lib/zmap.c
> > index 458030b..42783e5 100644
> > --- a/lib/zmap.c
> > +++ b/lib/zmap.c
> > @@ -10,6 +10,9 @@
> >  #include "erofs/io.h"
> >  #include "erofs/print.h"
> >  
> > +static int z_erofs_do_map_blocks(struct erofs_inode *vi,
> > +				 struct erofs_map_blocks *map);
> > +
> >  int z_erofs_fill_inode(struct erofs_inode *vi)
> >  {
> >  	if (!erofs_sb_has_big_pcluster() &&
> > @@ -18,12 +21,69 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
> >  		vi->z_algorithmtype[0] = 0;
> >  		vi->z_algorithmtype[1] = 0;
> >  		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
> > +		vi->z_idata_size = 0;
> >  
> >  		vi->flags |= EROFS_I_Z_INITED;
> > +		DBG_BUGON(erofs_sb_has_tail_packing());
> >  	}
> >  	return 0;
> >  }
> >  
> > +static erofs_off_t compacted_inline_data_addr(struct erofs_inode *vi,
> > +					      unsigned int totalidx)
> > +{
> > +	const erofs_off_t ebase = round_up(iloc(vi->nid) + vi->inode_isize +
> > +				  vi->xattr_isize, 8) +
> > +				  sizeof(struct z_erofs_map_header);
> > +	unsigned int compacted_4b_initial, compacted_4b_end;
> > +	unsigned int compacted_2b;
> > +	erofs_off_t addr;
> > +
> > +	compacted_4b_initial = (32 - ebase % 32) / 4;
> > +	if (compacted_4b_initial == 32 / 4)
> > +		compacted_4b_initial = 0;
> > +
> > +	if (compacted_4b_initial > totalidx) {
> > +		compacted_4b_initial = 0;
> > +		compacted_2b = 0;
> > +	} else if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) {
> > +		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
> > +	} else
> > +		compacted_2b = 0;
> > +
> > +	compacted_4b_end = totalidx - compacted_4b_initial - compacted_2b;
> > +
> > +	addr = ebase + compacted_4b_initial * 4 + compacted_2b * 2;
> > +	if (compacted_4b_end > 1)
> > +		addr += (compacted_4b_end/2) * 8;
> > +	if (compacted_4b_end % 2)
> > +		addr += 8;
> > +
> > +	return addr;
> > +}
> > +
> > +static erofs_off_t legacy_inline_data_addr(struct erofs_inode *vi,
> > +					   unsigned int totalidx)
> > +{
> > +	return Z_EROFS_VLE_LEGACY_INDEX_ALIGN(iloc(vi->nid) + vi->inode_isize +
> > +					      vi->xattr_isize) +
> > +		totalidx * sizeof(struct z_erofs_vle_decompressed_index);
> > +}
> > +
> > +static erofs_off_t z_erofs_inline_data_addr(struct erofs_inode *vi)
> > +{
> > +	const unsigned int datamode = vi->datalayout;
> > +	const unsigned int totalidx = DIV_ROUND_UP(vi->i_size, EROFS_BLKSIZ);
> > +
> > +	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
> > +		return compacted_inline_data_addr(vi, totalidx);
> > +
> > +	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
> > +		return legacy_inline_data_addr(vi, totalidx);
> > +
> > +	return -EINVAL;
> > +}  
> 
> no need these three new functions if introducing
> EROFS_GET_BLOCKS_FINDTAIL, see below..

Let me optimize the logic.

> 
> > +
> >  static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
> >  {
> >  	int ret;
> > @@ -44,6 +104,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
> >  
> >  	h = (struct z_erofs_map_header *)buf;
> >  	vi->z_advise = le16_to_cpu(h->h_advise);
> > +	vi->z_idata_size = le16_to_cpu(h->h_idata_size);
> >  	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
> >  	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
> >  
> > @@ -61,6 +122,16 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
> >  			  vi->nid * 1ULL);
> >  		return -EFSCORRUPTED;
> >  	}
> > +
> > +	if (vi->z_idata_size) {
> > +		struct erofs_map_blocks map = { .m_la = vi->i_size - 1 };
> > +
> > +		ret = z_erofs_do_map_blocks(vi, &map);
> > +		if (ret)
> > +			return ret;  
> 
> How about introducing another mode called
> EROFS_GET_BLOCKS_FINDTAIL

Aha, nice name. That flag have leaped into my mind :)

> 
> which implys .m_la = vi->i_size - 1 internally, so we won't need to
> handle .m_la here.
> 
> > +		vi->z_idata_headlcn = map.m_la >> vi->z_logical_clusterbits;  
> 
> Also updaing vi->z_idata_headlcn when EROFS_GET_BLOCKS_FINDTAIL.

Right.

> 
> > +	}
> > +
> >  	vi->flags |= EROFS_I_Z_INITED;
> >  	return 0;
> >  }
> > @@ -374,7 +445,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
> >  }
> >  
> >  static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
> > -					    unsigned int initial_lcn)
> > +					    unsigned int initial_lcn,
> > +					    bool idatamap)
> >  {
> >  	struct erofs_inode *const vi = m->inode;
> >  	struct erofs_map_blocks *const map = m->map;
> > @@ -384,6 +456,12 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
> >  
> >  	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
> >  		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
> > +
> > +	if (idatamap) {
> > +		map->m_plen = vi->z_idata_size;
> > +		return 0;
> > +	}
> > +
> >  	if (!(map->m_flags & EROFS_MAP_ZIPPED) ||
> >  	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
> >  		map->m_plen = 1 << lclusterbits;
> > @@ -440,8 +518,8 @@ err_bonus_cblkcnt:
> >  	return -EFSCORRUPTED;
> >  }
> >  
> > -int z_erofs_map_blocks_iter(struct erofs_inode *vi,
> > -			    struct erofs_map_blocks *map)
> > +static int z_erofs_do_map_blocks(struct erofs_inode *vi,
> > +				 struct erofs_map_blocks *map)
> >  {
> >  	struct z_erofs_maprecorder m = {
> >  		.inode = vi,
> > @@ -452,18 +530,7 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
> >  	unsigned int lclusterbits, endoff;
> >  	unsigned long initial_lcn;
> >  	unsigned long long ofs, end;
> > -
> > -	/* when trying to read beyond EOF, leave it unmapped */
> > -	if (map->m_la >= vi->i_size) {
> > -		map->m_llen = map->m_la + 1 - vi->i_size;
> > -		map->m_la = vi->i_size;
> > -		map->m_flags = 0;
> > -		goto out;
> > -	}
> > -
> > -	err = z_erofs_fill_inode_lazy(vi);
> > -	if (err)
> > -		goto out;
> > +	bool idatamap;
> >  
> >  	lclusterbits = vi->z_logical_clusterbits;
> >  	ofs = map->m_la;
> > @@ -510,19 +577,52 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
> >  		goto out;
> >  	}
> >  
> > +	/* check if mapping tail-packing data */
> > +	idatamap = vi->z_idata_size && (ofs == vi->i_size - 1 ||
> > +		   m.lcn == vi->z_idata_headlcn);  
> 
> better namin as `is_idata'...

Okay.

> 
> I think no need to handle ofs == vi->i_size - 1 specially here
> if EROFS_GET_BLOCKS_FINDTAIL is introduced...

Right.

> 
> > +
> > +	/* need to trim tail-packing data if beyond file size */
> >  	map->m_llen = end - map->m_la;
> > -	map->m_pa = blknr_to_addr(m.pblk);
> > +	if (idatamap && end > vi->i_size)
> > +		map->m_llen -= end - vi->i_size;  
> 
> No need as well?

Let me confirm.

> 
> >  
> > -	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
> > +	if (idatamap && (vi->z_advise & Z_EROFS_ADVISE_INLINE_DATA)) {
> > +		map->m_pa = z_erofs_inline_data_addr(vi);  
> 
> How about setting another u32 z_idataoff when EROFS_GET_BLOCKS_FINDTAIL
> so we won't need to introduce another calculate methods instead?

Agree, need to improve it.

> 
> Thanks,
> Gao Xiang

