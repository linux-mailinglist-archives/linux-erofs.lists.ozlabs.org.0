Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A4C3D6BDF
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jul 2021 04:19:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GYgVP1L0Wz3081
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jul 2021 12:19:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GYgVG0tmyz304Q
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jul 2021 12:19:47 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0Uh6SH2N_1627352366; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uh6SH2N_1627352366) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 27 Jul 2021 10:19:27 +0800
Date: Tue, 27 Jul 2021 10:19:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v8] iomap: make inline data support more flexible
Message-ID: <YP9tLRwS7opJOSH8@B-P7TQMD6M-0146.local>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Huang Jianan <huangjianan@oppo.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Christoph Hellwig <hch@lst.de>,
 Matthew Wilcox <willy@infradead.org>,
 Andreas Gruenbacher <agruenba@redhat.com>
References: <20210726145734.214295-1-hsiangkao@linux.alibaba.com>
 <20210726221054.GG8572@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210726221054.GG8572@magnolia>
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
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Darrick,

On Mon, Jul 26, 2021 at 03:10:54PM -0700, Darrick J. Wong wrote:
> On Mon, Jul 26, 2021 at 10:57:34PM +0800, Gao Xiang wrote:
> > The existing inline data support only works for cases where the entire
> > file is stored as inline data.  For larger files, EROFS stores the
> > initial blocks separately and then can pack a small tail adjacent to the
> > inode.  Generalise inline data to allow for tail packing.  Tails may not
> > cross a page boundary in memory.
> > 
> > We currently have no filesystems that support tail packing and writing,
> > so that case is currently disabled (see iomap_write_begin_inline).
> > 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Darrick J. Wong <djwong@kernel.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> > v7: https://lore.kernel.org/r/20210723174131.180813-1-hsiangkao@linux.alibaba.com
> > changes since v7:
> >  - This version is based on Andreas's patch, the main difference
> >    is to avoid using "iomap->length" in iomap_read_inline_data().
> >    more details see:
> >     https://lore.kernel.org/r/CAHpGcMJhuSApy4eg9jKe2pYq4d7bY-Lg-Bmo9tOANghQ2Hxo-A@mail.gmail.com
> >    The rest are similar (some renaming and return type changes.)
> > 
> >  - with update according to Christoph's comments:
> >    https://lore.kernel.org/r/20210726121702.GA528@lst.de/
> >    except that "
> >     I think we should fix that now that we have the srcmap concept.
> >     That is or IOMAP_WRITE|IOMAP_ZERO return the inline map as the
> >     soure map, and return the actual block map we plan to write into
> >     as the main iomap. "
> >    Hopefully it could be addressed with a new gfs2-related patch.
> > 
> >  - it passes gfs2 fstests and no strange on my side.
> > 
> > Hopefully I don't miss anything (already many inputs), and everyone
> > is happy with this version.
> > 
> >  fs/iomap/buffered-io.c | 40 ++++++++++++++++++++++++++++------------
> >  fs/iomap/direct-io.c   | 10 ++++++----
> >  include/linux/iomap.h  | 18 ++++++++++++++++++
> >  3 files changed, 52 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 87ccb3438bec..0d9f161ecb7e 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -205,25 +205,30 @@ struct iomap_readpage_ctx {
> >  	struct readahead_control *rac;
> >  };
> >  
> > -static void
> > -iomap_read_inline_data(struct inode *inode, struct page *page,
> > +static int iomap_read_inline_data(struct inode *inode, struct page *page,
> >  		struct iomap *iomap)
> >  {
> > -	size_t size = i_size_read(inode);
> > +	size_t size = i_size_read(inode) - iomap->offset;
> >  	void *addr;
> >  
> >  	if (PageUptodate(page))
> > -		return;
> > +		return 0;
> >  
> > -	BUG_ON(page_has_private(page));
> > -	BUG_ON(page->index);
> > -	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +	/* inline data must start page aligned in the file */
> > +	if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
> > +		return -EIO;
> > +	if (WARN_ON_ONCE(size > PAGE_SIZE -
> > +			 offset_in_page(iomap->inline_data)))
> > +		return -EIO;
> > +	if (WARN_ON_ONCE(page_has_private(page)))
> > +		return -EIO;
> >  
> >  	addr = kmap_atomic(page);
> >  	memcpy(addr, iomap->inline_data, size);
> >  	memset(addr + size, 0, PAGE_SIZE - size);
> >  	kunmap_atomic(addr);
> >  	SetPageUptodate(page);
> > +	return 0;
> 
> As I muttered in the v7 thread, I don't really like how this function
> gets away from using iomap->length for the copy length, unlike the other
> iomap read paths.  I started sketching out how I'd really like the
> function to read and ended up with:
> 
> static int iomap_read_inline_data(struct inode *inode, struct page *page,
> 			struct iomap *iomap)
> {
> 	void *addr;
> 	loff_t isize = i_size_read(inode);
> 	loff_t ret;
> 	unsigned int plen = min(isize - iomap->offset, iomap->length);
> 
> 	/* inline data must start page aligned in the file */
> 	if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
> 		return -EIO;
> 	if (WARN_ON_ONCE(!iomap_inline_data_valid(iomap)))
> 		return -EIO;
> 	if (WARN_ON_ONCE(page_has_private(page)))
> 		return -EIO;
> 
> 	addr = kmap_atomic(page);
> 	memcpy(addr, iomap->inline_data, plen);
> 	if (iomap->offset + plen == isize) {
> 		/* If we reach EOF, we can zero the rest of the page */
> 		memset(addr + plen, 0, PAGE_SIZE - plen);
> 		plen = PAGE_SIZE;
> 	}
> 
> 	if (offset_in_page(iomap->offset) == 0 && plen == PAGE_SIZE) {
> 		SetPageUptodate(page);
> 	} else {
> 		iomap_page_create(inode, page);
> 		iomap_set_range_uptodate(page,
> 				offset_in_page(iomap->offset), plen);

If we finally do like this, I think `plen' here needs to be block-aligned
like my previous patches.

Another point is currently these code has no use cases, so let's do the
minimal thing first. (I could try this when working on subpage-sized
block support.)

> 	}
> 	kunmap_atomic(addr);
> 	return plen;
> }
> 
> But then my brain filled up with all the other potential case I'd have
> to support in order to do this properly, and decided that this patch,
> while retaining some grossness, isn't really any worse that what we have
> now.

Yeah.

> 
> I think I /would/ like to request a V9 with one extra safety check,
> however:
> 
> 	if (WARN_ON_ONCE(size > iomap->length))
> 		return -EIO;
> 
> Add that one sanity check and I think I'm willing to throw this on the
> pile for 5.15.

Okay, will update.

Thanks,
Gao Xiang

> 
> --D
> 
> >  }
> >  
> >  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> > @@ -247,8 +252,10 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> >  	sector_t sector;
> >  
> >  	if (iomap->type == IOMAP_INLINE) {
> > -		WARN_ON_ONCE(pos);
> > -		iomap_read_inline_data(inode, page, iomap);
> > +		int ret = iomap_read_inline_data(inode, page, iomap);
> > +
> > +		if (ret)
> > +			return ret;
> >  		return PAGE_SIZE;
> >  	}
> >  
> > @@ -589,6 +596,15 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
> >  	return 0;
> >  }
> >  
> > +static int iomap_write_begin_inline(struct inode *inode,
> > +		struct page *page, struct iomap *srcmap)
> > +{
> > +	/* needs more work for the tailpacking case, disable for now */
> > +	if (WARN_ON_ONCE(srcmap->offset != 0))
> > +		return -EIO;
> > +	return iomap_read_inline_data(inode, page, srcmap);
> > +}
> > +
> >  static int
> >  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> >  		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
> > @@ -618,7 +634,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> >  	}
> >  
> >  	if (srcmap->type == IOMAP_INLINE)
> > -		iomap_read_inline_data(inode, page, srcmap);
> > +		status = iomap_write_begin_inline(inode, page, srcmap);
> >  	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
> >  		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
> >  	else
> > @@ -671,11 +687,11 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
> >  	void *addr;
> >  
> >  	WARN_ON_ONCE(!PageUptodate(page));
> > -	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +	BUG_ON(!iomap_inline_data_valid(iomap));
> >  
> >  	flush_dcache_page(page);
> >  	addr = kmap_atomic(page);
> > -	memcpy(iomap->inline_data + pos, addr + pos, copied);
> > +	memcpy(iomap_inline_data(iomap, pos), addr + pos, copied);
> >  	kunmap_atomic(addr);
> >  
> >  	mark_inode_dirty(inode);
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index 9398b8c31323..41ccbfc9dc82 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -378,23 +378,25 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
> >  		struct iomap_dio *dio, struct iomap *iomap)
> >  {
> >  	struct iov_iter *iter = dio->submit.iter;
> > +	void *inline_data = iomap_inline_data(iomap, pos);
> >  	size_t copied;
> >  
> > -	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +	if (WARN_ON_ONCE(!iomap_inline_data_valid(iomap)))
> > +		return -EIO;
> >  
> >  	if (dio->flags & IOMAP_DIO_WRITE) {
> >  		loff_t size = inode->i_size;
> >  
> >  		if (pos > size)
> > -			memset(iomap->inline_data + size, 0, pos - size);
> > -		copied = copy_from_iter(iomap->inline_data + pos, length, iter);
> > +			memset(iomap_inline_data(iomap, size), 0, pos - size);
> > +		copied = copy_from_iter(inline_data, length, iter);
> >  		if (copied) {
> >  			if (pos + copied > size)
> >  				i_size_write(inode, pos + copied);
> >  			mark_inode_dirty(inode);
> >  		}
> >  	} else {
> > -		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
> > +		copied = copy_to_iter(inline_data, length, iter);
> >  	}
> >  	dio->size += copied;
> >  	return copied;
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 479c1da3e221..b8ec145b2975 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -97,6 +97,24 @@ iomap_sector(struct iomap *iomap, loff_t pos)
> >  	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
> >  }
> >  
> > +/*
> > + * Returns the inline data pointer for logical offset @pos.
> > + */
> > +static inline void *iomap_inline_data(struct iomap *iomap, loff_t pos)
> > +{
> > +	return iomap->inline_data + pos - iomap->offset;
> > +}
> > +
> > +/*
> > + * Check if the mapping's length is within the valid range for inline data.
> > + * This is used to guard against accessing data beyond the page inline_data
> > + * points at.
> > + */
> > +static inline bool iomap_inline_data_valid(struct iomap *iomap)
> > +{
> > +	return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
> > +}
> > +
> >  /*
> >   * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
> >   * and page_done will be called for each page written to.  This only applies to
> > -- 
> > 2.24.4
> > 
