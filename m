Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E42472024
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Dec 2021 05:58:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JC8RY6MPWz2ynM
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Dec 2021 15:58:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=KQ5iSSG8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531;
 helo=mail-pg1-x531.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=KQ5iSSG8; dkim-atps=neutral
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JC8RT6t0Kz2x9d
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Dec 2021 15:58:43 +1100 (AEDT)
Received: by mail-pg1-x531.google.com with SMTP id f125so13585098pgc.0
 for <linux-erofs@lists.ozlabs.org>; Sun, 12 Dec 2021 20:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rTvA8jP0lctDxemlR2ZyoBRQZMHCL5ZgvhLO0z0u6SQ=;
 b=KQ5iSSG8JpXAKyLvR0E+PKNmPmJa1+svNJInuumuEEM7GTvOExgESNqc8wKjNLV1e/
 OHvk3LIrRksWuS5XeHPdbvCUfQ0IZ3BNmON3priKKRQrFvO//2xpLfemxJZSYBLrrbCR
 QaClkn3/wp7i8EN0TlCYtUkvzXdIqBEMVr7JAWl/5T3YRip78v3oUURtnv8YM7u4ObEl
 kNNUFiGC7qx4bhz2n2iVy/rVkfcRpaKBta3jyUwKumIMHfesubAtPbF8EACW5h3sOEBI
 +oaJck2orV7VHBbqrSeVt8WGosMczh9MaNsTVbVAMN0nfqljAgXaEE7110SicD5YfDxK
 88CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rTvA8jP0lctDxemlR2ZyoBRQZMHCL5ZgvhLO0z0u6SQ=;
 b=PTRZOxIW3GYVFvgmgQa7fPLA/3xdgXCuLaIlB4+lDyOnqtEnVjNSeanJNbRZ2RxHqT
 UjBYPVIb77oxeG8c51mr3I1tfNZvS2hRY8FBEu2mq7Tv9ZJNISOcbMwpO6+KqIJKoCGV
 BTNh5xwfKFH0TtXoAKQLiVlWundbN/jHSM3CoW+5EKtjPuXhQdoUCtKLYaCZV+NY8v90
 LsySnElouNThhaG/KMYB0MqzQ2m0fQCpOrZ5JSrpFKVTx25zD4NgpI3xAFNZpJWE/ZjF
 4JUnG89ouG3ng7vfmPAv/NE7M2XwEhupR0y5JYyl9YLiq27k0HKWEr2N+4QWKSheqQIF
 RqMQ==
X-Gm-Message-State: AOAM533+GK0bGtZLC2r3SLubUIdmFhFPYwHZBPOyuZMduUXk0OFANYiN
 hInlgPmOptinhxR3aZsAEC8=
X-Google-Smtp-Source: ABdhPJwKKDECs2sS5dUG8SPo25zRrsmbblSHZB1uM8J5+DMT1VEDhob4qvhjMsFxoEJhbzH7oDuV2w==
X-Received: by 2002:a63:495a:: with SMTP id y26mr50751156pgk.264.1639371518811; 
 Sun, 12 Dec 2021 20:58:38 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id d10sm10639207pfl.139.2021.12.12.20.58.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 12 Dec 2021 20:58:38 -0800 (PST)
Date: Mon, 13 Dec 2021 12:56:29 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH v4 1/2] erofs-utils: fuse: support tail-packing
 inline compressed data
Message-ID: <20211213125629.00003595.zbestahu@gmail.com>
In-Reply-To: <YbaklwDl6P7CsrK4@B-P7TQMD6M-0146.local>
References: <cover.1639303144.git.huyue2@yulong.com>
 <4333936bf0811f2ecb1ad89d72911d7f1f638c90.1639303144.git.huyue2@yulong.com>
 <YbaklwDl6P7CsrK4@B-P7TQMD6M-0146.local>
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
Cc: geshifei@coolpad.com, zhangwen@coolpad.com, Yue Hu <huyue2@yulong.com>,
 linux-erofs@lists.ozlabs.org, shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On Mon, 13 Dec 2021 09:40:39 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Sun, Dec 12, 2021 at 06:31:28PM +0800, Yue Hu wrote:
> > Add tail-packing inline compressed data support for erofsfuse.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> > v4:
> > - introduce EROFS_GET_BLOCKS_FINDTAIL suggested by Xiang.
> > - remove 3 functions about calculation to inline data address
> >   and calculate it directly when reload index.
> > - add m_nxtioff/z_idataoff to help get/record the inline data address.
> > - add on-disk feature related.
> > 
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
> >  include/erofs/internal.h |  8 ++++
> >  include/erofs_fs.h       | 10 +++-
> >  lib/decompress.c         |  2 +-
> >  lib/namei.c              |  2 +-
> >  lib/zmap.c               | 99 ++++++++++++++++++++++++++++++++--------
> >  5 files changed, 98 insertions(+), 23 deletions(-)
> > 
> > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > index 8b154ed..1c92a27 100644
> > --- a/include/erofs/internal.h
> > +++ b/include/erofs/internal.h
> > @@ -110,6 +110,7 @@ EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
> >  EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
> >  EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
> >  EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
> > +EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
> >  EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
> >  
> >  #define EROFS_I_EA_INITED	(1 << 0)
> > @@ -171,6 +172,9 @@ struct erofs_inode {
> >  			uint8_t  z_algorithmtype[2];
> >  			uint8_t  z_logical_clusterbits;
> >  			uint8_t  z_physical_clusterblks;
> > +			uint16_t z_idata_size;
> > +			uint32_t z_idata_headlcn;
> > +			uint64_t z_idataoff;
> >  		};
> >  	};
> >  #ifdef WITH_ANDROID
> > @@ -257,8 +261,12 @@ struct erofs_map_blocks {
> >  
> >  	unsigned int m_flags;
> >  	erofs_blk_t index;
> > +
> > +	u16 m_nxtioff;  
> 
> better rename as nextpackoff and move into map_recorder.

agree.

> 
> >  };
> >  
> > +#define EROFS_GET_BLOCKS_FINDTAIL	0x0001
> > +
> >  /* super.c */
> >  int erofs_read_superblock(void);
> >  
> > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > index 66a68e3..0e87e85 100644
> > --- a/include/erofs_fs.h
> > +++ b/include/erofs_fs.h
> > @@ -22,11 +22,13 @@
> >  #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
> >  #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
> >  #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
> > +#define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
> >  #define EROFS_ALL_FEATURE_INCOMPAT		\
> >  	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
> >  	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
> >  	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
> > -	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE)
> > +	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
> > +	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING)
> >  
> >  #define EROFS_SB_EXTSLOT_SIZE	16
> >  
> > @@ -266,13 +268,17 @@ struct z_erofs_lz4_cfgs {
> >   *                                  (4B) + 2B + (4B) if compacted 2B is on.
> >   * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
> >   * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
> > + * bit 3 : tailpacking inline data
> >   */
> >  #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
> >  #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
> >  #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
> > +#define Z_EROFS_ADVISE_INLINE_DATA		0x0008
> >  
> >  struct z_erofs_map_header {
> > -	__le32	h_reserved1;
> > +	__le16	h_reserved1;
> > +	/* record the size of tailpacking data */
> > +	__le16  h_idata_size;
> >  	__le16	h_advise;
> >  	/*
> >  	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
> > diff --git a/lib/decompress.c b/lib/decompress.c
> > index 2ee1439..9b90d18 100644
> > --- a/lib/decompress.c
> > +++ b/lib/decompress.c
> > @@ -67,7 +67,7 @@ out:
> >  int z_erofs_decompress(struct z_erofs_decompress_req *rq)
> >  {
> >  	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
> > -		if (rq->inputsize != EROFS_BLKSIZ)
> > +		if (rq->inputsize > EROFS_BLKSIZ)
> >  			return -EFSCORRUPTED;
> >  
> >  		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
> > diff --git a/lib/namei.c b/lib/namei.c
> > index b4bdabf..481b33e 100644
> > --- a/lib/namei.c
> > +++ b/lib/namei.c
> > @@ -137,7 +137,7 @@ static int erofs_read_inode_from_disk(struct erofs_inode *vi)
> >  		vi->u.chunkbits = LOG_BLOCK_SIZE +
> >  			(vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
> >  	} else if (erofs_inode_is_data_compressed(vi->datalayout))
> > -		z_erofs_fill_inode(vi);
> > +		return z_erofs_fill_inode(vi);
> >  	return 0;
> >  bogusimode:
> >  	erofs_err("bogus i_mode (%o) @ nid %llu", vi->i_mode, vi->nid | 0ULL);
> > diff --git a/lib/zmap.c b/lib/zmap.c
> > index 458030b..aa51b61 100644
> > --- a/lib/zmap.c
> > +++ b/lib/zmap.c
> > @@ -10,6 +10,10 @@
> >  #include "erofs/io.h"
> >  #include "erofs/print.h"
> >  
> > +static int z_erofs_do_map_blocks(struct erofs_inode *vi,
> > +				 struct erofs_map_blocks *map,
> > +				 int flags);
> > +
> >  int z_erofs_fill_inode(struct erofs_inode *vi)
> >  {
> >  	if (!erofs_sb_has_big_pcluster() &&
> > @@ -18,8 +22,13 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
> >  		vi->z_algorithmtype[0] = 0;
> >  		vi->z_algorithmtype[1] = 0;
> >  		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
> > +		vi->z_idata_size = 0;
> >  
> >  		vi->flags |= EROFS_I_Z_INITED;
> > +		if (erofs_sb_has_ztailpacking()) {
> > +			erofs_err("unsupported, plz enable big pcluster for legacy compression inline");
> > +			return -EOPNOTSUPP;
> > +		}
> >  	}
> >  	return 0;
> >  }
> > @@ -44,6 +53,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
> >  
> >  	h = (struct z_erofs_map_header *)buf;
> >  	vi->z_advise = le16_to_cpu(h->h_advise);
> > +	vi->z_idata_size = le16_to_cpu(h->h_idata_size);
> >  	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
> >  	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
> >  
> > @@ -61,6 +71,16 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
> >  			  vi->nid * 1ULL);
> >  		return -EFSCORRUPTED;
> >  	}
> > +
> > +	if (vi->z_idata_size) {
> > +		struct erofs_map_blocks map = { .index = UINT_MAX };
> > +
> > +		ret = z_erofs_do_map_blocks(vi, &map,
> > +					    EROFS_GET_BLOCKS_FINDTAIL);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	vi->flags |= EROFS_I_Z_INITED;
> >  	return 0;
> >  }
> > @@ -113,6 +133,8 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> >  	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
> >  	if (err)
> >  		return err;
> > +	m->map->m_nxtioff = erofs_blkoff(pos) +
> > +			    sizeof(struct z_erofs_vle_decompressed_index);  
> 
> m->nextpackoff = pos + sizeof(struct z_erofs_vle_decompressed_index);

rt.

> 
> >  
> >  	m->lcn = lcn;
> >  	di = m->kaddr + erofs_blkoff(pos);
> > @@ -285,7 +307,9 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> >  	if (compacted_4b_initial == 32 / 4)
> >  		compacted_4b_initial = 0;
> >  
> > -	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> > +	if (compacted_4b_initial > totalidx)
> > +		compacted_4b_initial = compacted_2b = 0;
> > +	else if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> >  		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
> >  	else
> >  		compacted_2b = 0;
> > @@ -310,6 +334,9 @@ out:
> >  	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
> >  	if (err)
> >  		return err;
> > +	m->map->m_nxtioff = erofs_blkoff(pos) +
> > +			((1 << amortizedshift == 2) ? 2 : ((lcn % 2) ? 4 : 8));  
> 
> I'd like to skip the whole current pack for compact indexes.
> 
> How about this:
> 
>   static int unpack_compacted_index(struct z_erofs_maprecorder *m,
>                                   unsigned int amortizedshift,
> -                                 unsigned int eofs, bool lookahead)
>  -                                unsigned int eofs)
> ++                                unsigned int pos, bool lookahead)
>   {
>         struct erofs_inode *const vi = m->inode;
>         const unsigned int lclusterbits = vi->z_logical_clusterbits;
>         const unsigned int lomask = (1 << lclusterbits) - 1;
> --      unsigned int vcnt, base, lo, encodebits, nblk;
> ++      unsigned int vcnt, base, lo, encodebits, nblk, eofs;
>         int i;
>         u8 *in, type;
>         bool big_pcluster;
> @@@ -203,8 -200,8 +225,10 @@@
>         else
>                 return -EOPNOTSUPP;
> 
> ++      m->nextpackoff = round_up(pos, vcnt << amortizedshift);

looks more simple, let me check.

>         big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
>         encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
> ++      eofs = erofs_blkoff(pos);
>         base = round_down(eofs, vcnt << amortizedshift);
>         in = m->kaddr + base;
> 
> @@@ -340,8 -334,10 +366,7 @@@ out
>         err = z_erofs_reload_indexes(m, erofs_blknr(pos));
>         if (err)
>                 return err;
> -       return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos),
> -                                     lookahead);
>  -      m->map->m_nxtioff = erofs_blkoff(pos) +
>  -                      ((1 << amortizedshift == 2) ? 2 : ((lcn % 2) ? 4 : 8));
>  -
>  -      return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos));
> ++      return unpack_compacted_index(m, amortizedshift, pos, lookahead);
>   }
> 
> Thanks,
> Gao Xiang
> 

Thanks.
