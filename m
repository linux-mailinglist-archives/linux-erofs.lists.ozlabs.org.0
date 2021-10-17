Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20036430A4B
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Oct 2021 17:43:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HXPRc55HMz2ynX
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Oct 2021 02:43:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IumawfjG;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IumawfjG; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HXPRY0Fzbz2yKQ
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Oct 2021 02:43:20 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 231A660F9E;
 Sun, 17 Oct 2021 15:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634485398;
 bh=7rtVxTf07dmNllT8+b9Wc8k/EraK1VLR7qga4vJgb+4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IumawfjGFQvmYJtYQi5xoKSPg6/hO3CbBANAd0ig7u1r4b732ITusRACK3UH2hLw/
 du3nMIQ/X2DHgVpBchW9pripRmmsj/dtyEsVtUxec7BK/2JB/itXDpk5rKFJHoMyuz
 tXen++ellTcynMc+bv6rM1bviMBzMdARawOe7eYu8iEh3S38P00qs00Rb+hc6oH/Tf
 hc0LEyuMp6sm9ee6wdvEVVfSz9KUhAmfTxF9lwSJnkt0TNVL3/wXcT5ha1mWT+Vfw0
 SuPLtwsJKlJXN69ZfCXav5b7ySPsDrUk8nJgf6cSr0amcfvq2bQnAKaqtpzyxZeyFm
 IqO4nLP023EfQ==
Date: Sun, 17 Oct 2021 23:42:55 +0800
From: Gao Xiang <xiang@kernel.org>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2 3/3] erofs: introduce readmore decompression strategy
Message-ID: <20211017154253.GB4054@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Chao Yu <chao@kernel.org>, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Yue Hu <zbestahu@gmail.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20211008200839.24541-1-xiang@kernel.org>
 <20211008200839.24541-4-xiang@kernel.org>
 <8e39e5d1-285d-52b6-8fea-8bb9ff10bf5a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e39e5d1-285d-52b6-8fea-8bb9ff10bf5a@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Sun, Oct 17, 2021 at 11:34:22PM +0800, Chao Yu wrote:
> On 2021/10/9 4:08, Gao Xiang wrote:
> > From: Gao Xiang <hsiangkao@linux.alibaba.com>
> > 
> > Previously, the readahead window was strictly followed by EROFS
> > decompression strategy in order to minimize extra memory footprint.
> > However, it could become inefficient if just reading the partial
> > requested data for much big LZ4 pclusters and the upcoming LZMA
> > implementation.
> > 
> > Let's try to request the leading data in a pcluster without
> > triggering memory reclaiming instead for the LZ4 approach first
> > to boost up 100% randread of large big pclusters, and it has no real
> > impact on low memory scenarios.
> > 
> > It also introduces a way to expand read lengths in order to decompress
> > the whole pcluster, which is useful for LZMA since the algorithm
> > itself is relatively slow and causes CPU bound, but LZ4 is not.
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >   fs/erofs/internal.h | 13 ++++++
> >   fs/erofs/zdata.c    | 99 ++++++++++++++++++++++++++++++++++++---------
> >   2 files changed, 93 insertions(+), 19 deletions(-)
> > 
> > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > index 48bfc6eb2b02..7f96265ccbdb 100644
> > --- a/fs/erofs/internal.h
> > +++ b/fs/erofs/internal.h
> > @@ -307,6 +307,19 @@ static inline unsigned int erofs_inode_datalayout(unsigned int value)
> >   			      EROFS_I_DATALAYOUT_BITS);
> >   }
> > +/*
> > + * Different from grab_cache_page_nowait(), reclaiming is never triggered
> > + * when allocating new pages.
> > + */
> > +static inline
> > +struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
> > +					  pgoff_t index)
> > +{
> > +	return pagecache_get_page(mapping, index,
> > +			FGP_LOCK|FGP_CREAT|FGP_NOFS|FGP_NOWAIT,
> > +			readahead_gfp_mask(mapping) & ~__GFP_RECLAIM);
> > +}
> > +
> >   extern const struct super_operations erofs_sops;
> >   extern const struct address_space_operations erofs_raw_access_aops;
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index 5c34ef66677f..febb018e10a7 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -1377,6 +1377,72 @@ static void z_erofs_runqueue(struct super_block *sb,
> >   	z_erofs_decompress_queue(&io[JQ_SUBMIT], pagepool);
> >   }
> > +/*
> > + * Since partial uptodate is still unimplemented for now, we have to use
> > + * approximate readmore strategies as a start.
> > + */
> > +static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
> > +				      struct readahead_control *rac,
> > +				      erofs_off_t end,
> > +				      struct list_head *pagepool,
> > +				      bool backmost)
> > +{
> > +	struct inode *inode = f->inode;
> > +	struct erofs_map_blocks *map = &f->map;
> > +	erofs_off_t cur;
> > +	int err;
> > +
> > +	if (backmost) {
> > +		map->m_la = end;
> > +		/* TODO: pass in EROFS_GET_BLOCKS_READMORE for LZMA later */
> > +		err = z_erofs_map_blocks_iter(inode, map, 0);
> > +		if (err)
> > +			return;
> > +
> > +		/* expend ra for the trailing edge if readahead */
> > +		if (rac) {
> > +			loff_t newstart = readahead_pos(rac);
> > +
> > +			cur = round_up(map->m_la + map->m_llen, PAGE_SIZE);
> > +			readahead_expand(rac, newstart, cur - newstart);
> > +			return;
> > +		}
> > +		end = round_up(end, PAGE_SIZE);
> > +	} else {
> > +		end = round_up(map->m_la, PAGE_SIZE);
> > +
> > +		if (!map->m_llen)
> > +			return;
> > +	}
> > +
> > +	cur = map->m_la + map->m_llen - 1;
> > +	while (cur >= end) {
> > +		pgoff_t index = cur >> PAGE_SHIFT;
> > +		struct page *page;
> > +
> > +		page = erofs_grab_cache_page_nowait(inode->i_mapping, index);
> > +		if (!page)
> > +			goto skip;
> > +
> > +		if (PageUptodate(page)) {
> > +			unlock_page(page);
> > +			put_page(page);
> > +			goto skip;
> > +		}
> > +
> > +		err = z_erofs_do_read_page(f, page, pagepool);
> > +		if (err)
> > +			erofs_err(inode->i_sb,
> > +				  "readmore error at page %lu @ nid %llu",
> > +				  index, EROFS_I(inode)->nid);
> > +		put_page(page);
> > +skip:
> > +		if (cur < PAGE_SIZE)
> > +			break;
> > +		cur = (index << PAGE_SHIFT) - 1;
> 
> Looks a little bit weird to readahead backward, any special reason here?

Due to the do_read_page implementation, since I'd like to avoid
to get the exact full extent length (FIEMAP-likewise) inside
do_read_page but only request the needed range, so it should be
all in a backward way. Also the submission chain can be then in
a forward way.

If the question was asked why we should read backward, as I said in the
commit message, big pclusters matter since we could read in more leading
data at once.

Thanks,
Gao Xiang

> 
> Thanks,
