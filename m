Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B663D05CD
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jul 2021 01:47:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GTwP60FFJz304h
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jul 2021 09:47:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iV1XnoTg;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iV1XnoTg; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GTwP31HTvz2yP4
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jul 2021 09:47:19 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA8AB61106;
 Tue, 20 Jul 2021 23:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626824835;
 bh=oN69miVSRyaML6+IUHqvCBLtsgOcDIuQKYun/dc9vbI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iV1XnoTgpBubZrPubTyOqte+EiVGYBIHQCQvbGYr0Bswkz9mneNYCegjzWH2A3q0n
 6IvDPLJV8tBGZCWNbh3bztuydaPhHCGySqEDH/ae4l3Sod6h+4UCPxzuaxsiNB8hjm
 5v6bp3/y4uEEx2l+0orKxa8XqeCqFVDibr2L+Wh7p9TG5OYhC5IucSAO+vj6sYJ+Bm
 9H/9DP76Gq7bFNJYKh/FsfYUnn4pim18uWc2+ISbCjfkI4sPH22jwKz/n+ofaqmnlU
 MSQ8+65PoKWCx5fvIxU5C/RMF2kLUUiIqSdxP+fuVHZx2b6Oq29ae6/aIpNfUPiS6V
 uUkqm4takzirg==
Date: Wed, 21 Jul 2021 07:46:28 +0800
From: Gao Xiang <xiang@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v4] iomap: support tail packing inline read
Message-ID: <20210720234620.GA15940@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Matthew Wilcox <willy@infradead.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
References: <20210720133554.44058-1-hsiangkao@linux.alibaba.com>
 <20210720204224.GK23236@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210720204224.GK23236@magnolia>
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
Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Darrick,

On Tue, Jul 20, 2021 at 01:42:24PM -0700, Darrick J. Wong wrote:
> On Tue, Jul 20, 2021 at 09:35:54PM +0800, Gao Xiang wrote:
> > This tries to add tail packing inline read to iomap, which can support
> > several inline tail blocks. Similar to the previous approach, it cleans
> > post-EOF in one iteration.
> > 
> > The write path remains untouched since EROFS cannot be used for testing.
> > It'd be better to be implemented if upcoming real users care rather than
> > leave untested dead code around.
> > 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Darrick J. Wong <djwong@kernel.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> > v3: https://lore.kernel.org/r/20210719144747.189634-1-hsiangkao@linux.alibaba.com
> > changes since v3:
> >  - update return value type of iomap_read_inline_data to int;
> >  - fix iomap_write_begin_inline() pointed out by Andreas.
> > 
> >  fs/iomap/buffered-io.c | 52 ++++++++++++++++++++++++++----------------
> >  fs/iomap/direct-io.c   | 11 +++++----
> >  2 files changed, 39 insertions(+), 24 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 87ccb3438bec..0edc8bbb35d1 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -205,25 +205,25 @@ struct iomap_readpage_ctx {
> >  	struct readahead_control *rac;
> >  };
> >  
> > -static void
> > +static int
> >  iomap_read_inline_data(struct inode *inode, struct page *page,
> > -		struct iomap *iomap)
> > +		struct iomap *iomap, loff_t pos)
> >  {
> > -	size_t size = i_size_read(inode);
> > +	unsigned int size, poff = offset_in_page(pos);
> >  	void *addr;
> >  
> > -	if (PageUptodate(page))
> > -		return;
> > -
> > -	BUG_ON(page_has_private(page));
> > -	BUG_ON(page->index);
> > -	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +	/* inline source data must be inside a single page */
> > +	BUG_ON(iomap->length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> 
> Can we reduce the strength of these checks to a warning and an -EIO
> return?

Ok, will update it.

> 
> > +	/* handle tail-packing blocks cross the current page into the next */
> > +	size = min_t(unsigned int, iomap->length + pos - iomap->offset,
> > +		     PAGE_SIZE - poff);
> >  
> >  	addr = kmap_atomic(page);
> > -	memcpy(addr, iomap->inline_data, size);
> > -	memset(addr + size, 0, PAGE_SIZE - size);
> > +	memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
> > +	memset(addr + poff + size, 0, PAGE_SIZE - poff - size);
> 
> Hmm, so I guess the point of this is to support reading data from a
> tail-packing block, where each file gets some arbitrary byte range
> within the tp-block, and the range isn't aligned to an fs block?  Hence
> you have to use the inline data code to read the relevant bytes and copy
> them into the pagecache?

Yes, the source data isn't aligned to an fs block.

> 
> Aka this thing from the v3 discussion:
> 
> > The other one is actual file tail blocks, I think it can cross pages due
> > to multiple tail inline blocks.
> >
> >                             |<---------- inline data ------------->|
> >   _________________________________________________________________
> >   | file block | file block | file block | file block | file block |
> >   |<----------------    page   ---------------------->|<---  page
> 
> Except ... is this diagram a little misleading?  Each of these "file
> blocks" isn't i_blocksize bytes in size, right?  Because if they were,
> you could use the standard iomap codepaths?

The disgram above describe logical file extents.

The real physical layout is like this:
  _________________________________________________________
 | ... | inode |     inline data     | other inodes | .... |
               |<- arbitary length ->|
> 
> So the real layout might look a bit more like this?
> 
>                                 |<--- inline data ---->|
>   _________________________________________________________________
>   | file1 |     file2     |file3|  file4  |   file4    |
>   |<-------------   page   -------------->|<---  page ----...
> 
> (Sorry, /me isn't all that familiar with erofs layout...)

Nope, that is what erofs is like, erofs tail packing data inline with
inode itself, so when reading inode, the cache page itself can read
the tail blocks as well. When it read tail blocks again, it can save
I/O due to buffered before. Also this approach can save storage space
since it saves entire tail blocks as well.

> 
> >  	kunmap_atomic(addr);
> > -	SetPageUptodate(page);
> > +	iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
> > +	return PAGE_SIZE - poff;
> >  }
> >  
> >  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> > @@ -246,18 +246,18 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> >  	unsigned poff, plen;
> >  	sector_t sector;
> >  
> > -	if (iomap->type == IOMAP_INLINE) {
> > -		WARN_ON_ONCE(pos);
> > -		iomap_read_inline_data(inode, page, iomap);
> > -		return PAGE_SIZE;
> > -	}
> > -
> > -	/* zero post-eof blocks as the page may be mapped */
> >  	iop = iomap_page_create(inode, page);
> > +	/* needs to skip some leading uptodate blocks */
> >  	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
> >  	if (plen == 0)
> >  		goto done;
> >  
> > +	if (iomap->type == IOMAP_INLINE) {
> > +		plen = iomap_read_inline_data(inode, page, iomap, pos);
> > +		goto done;
> > +	}
> > +
> > +	/* zero post-eof blocks as the page may be mapped */
> >  	if (iomap_block_needs_zeroing(inode, iomap, pos)) {
> >  		zero_user(page, poff, plen);
> >  		iomap_set_range_uptodate(page, poff, plen);
> > @@ -589,6 +589,18 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
> >  	return 0;
> >  }
> >  
> > +static int iomap_write_begin_inline(struct inode *inode, loff_t pos,
> > +		struct page *page, struct iomap *srcmap)
> > +{
> > +	/* needs more work for the tailpacking case, disable for now */
> > +	if (WARN_ON_ONCE(srcmap->offset != 0))
> > +		return -EIO;
> > +	if (PageUptodate(page))
> > +		return 0;
> > +	iomap_read_inline_data(inode, page, srcmap, 0);
> > +	return 0;
> > +}
> > +
> >  static int
> >  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> >  		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
> > @@ -618,7 +630,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> >  	}
> >  
> >  	if (srcmap->type == IOMAP_INLINE)
> > -		iomap_read_inline_data(inode, page, srcmap);
> > +		status = iomap_write_begin_inline(inode, pos, page, srcmap);
> >  	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
> >  		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
> >  	else
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index 9398b8c31323..ee6309967b77 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -379,22 +379,25 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
> >  {
> >  	struct iov_iter *iter = dio->submit.iter;
> >  	size_t copied;
> > +	void *dst = iomap->inline_data + pos - iomap->offset;
> >  
> > -	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +	/* inline data must be inside a single page */
> > +	BUG_ON(length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> 
> Same here, can we convert these to warnings + EIO return?

Sure, I could update it as well.

Thanks,
Gao Xiang

> 
> --D
> 
> >  	if (dio->flags & IOMAP_DIO_WRITE) {
> >  		loff_t size = inode->i_size;
> >  
> >  		if (pos > size)
> > -			memset(iomap->inline_data + size, 0, pos - size);
> > -		copied = copy_from_iter(iomap->inline_data + pos, length, iter);
> > +			memset(iomap->inline_data + size - iomap->offset,
> > +			       0, pos - size);
> > +		copied = copy_from_iter(dst, length, iter);
> >  		if (copied) {
> >  			if (pos + copied > size)
> >  				i_size_write(inode, pos + copied);
> >  			mark_inode_dirty(inode);
> >  		}
> >  	} else {
> > -		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
> > +		copied = copy_to_iter(dst, length, iter);
> >  	}
> >  	dio->size += copied;
> >  	return copied;
> > -- 
> > 2.24.4
> > 
