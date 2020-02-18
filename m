Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507AF163657
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2020 23:46:22 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MbYl2wQ6zDqdZ
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 09:46:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mail105.syd.optusnet.com.au (client-ip=211.29.132.249;
 helo=mail105.syd.optusnet.com.au; envelope-from=david@fromorbit.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=fromorbit.com
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au
 [211.29.132.249])
 by lists.ozlabs.org (Postfix) with ESMTP id 48MbYf3QxczDqZk
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 09:46:14 +1100 (AEDT)
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au
 [49.179.138.28])
 by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 2C6AA3A311C;
 Wed, 19 Feb 2020 09:46:11 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1j4Bd4-0003kz-H7; Wed, 19 Feb 2020 09:46:10 +1100
Date: Wed, 19 Feb 2020 09:46:10 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6 03/19] mm: Use readahead_control to pass arguments
Message-ID: <20200218224610.GT10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-4-willy@infradead.org>
 <20200218050300.GI10776@dread.disaster.area>
 <20200218135618.GO7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218135618.GO7778@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
 a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
 a=7-415B0cAAAA:8 a=-669WvyOGAhHUzcTJR8A:9 a=CjuIK1q_8ugA:10
 a=biEYGPWJfzWAr4FL6Ov7:22
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Feb 18, 2020 at 05:56:18AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 18, 2020 at 04:03:00PM +1100, Dave Chinner wrote:
> > On Mon, Feb 17, 2020 at 10:45:44AM -0800, Matthew Wilcox wrote:
> > > +static void read_pages(struct readahead_control *rac, struct list_head *pages,
> > > +		gfp_t gfp)
> > >  {
> > > +	const struct address_space_operations *aops = rac->mapping->a_ops;
> > >  	struct blk_plug plug;
> > >  	unsigned page_idx;
> > 
> > Splitting out the aops rather than the mapping here just looks
> > weird, especially as you need the mapping later in the function.
> > Using aops doesn't even reduce the code side....
> 
> It does in subsequent patches ... I agree it looks a little weird here,
> but I think in the final form, it makes sense:

Ok. Perhaps just an additional commit comment to say "read_pages() is
changed to be aops centric as @rac abstracts away all other
implementation details by the end of the patchset."

> > > +			if (readahead_count(&rac))
> > > +				read_pages(&rac, &page_pool, gfp_mask);
> > > +			rac._nr_pages = 0;
> > 
> > Hmmm. Wondering ig it make sense to move the gfp_mask to the readahead
> > control structure - if we have to pass the gfp_mask down all the
> > way along side the rac, then I think it makes sense to do that...
> 
> So we end up removing it later on in this series, but I do wonder if
> it would make sense anyway.  By the end of the series, we still have
> this in iomap:
> 
>                 if (ctx->rac) /* same as readahead_gfp_mask */
>                         gfp |= __GFP_NORETRY | __GFP_NOWARN;
> 
> and we could get rid of that by passing gfp flags down in the rac.  On the
> other hand, I don't know why it doesn't just use readahead_gfp_mask()
> here anyway ... Christoph?

mapping->gfp_mask is awful. Is it a mask, or is it a valid set of
allocation flags? Or both?  Some callers to mapping_gfp_constraint()
uses it as a mask, some callers to mapping_gfp_constraint() use it
as base flags that context specific flags get masked out of,
readahead_gfp_mask() callers use it as the entire set of gfp flags
for allocation.

That whole API sucks - undocumented as to what it's suposed to do
and how it's supposed to be used. Hence it's difficult to use
correctly or understand whether it's being used correctly. And
reading callers only leads to more confusion and crazy code like in
do_mpage_readpage() where readahead returns a mask that are used as
base flags and normal reads return a masked set of base flags...

The iomap code is obviously correct when it comes to gfp flag
manipulation. We start with GFP_KERNEL context, then constrain it
via the mask held in mapping->gfp_mask, then if it's readahead we
allow the allocation to silently fail.

Simple to read and understand code, versus having weird code that
requires the reader to decipher an undocumented and inconsistent API
to understand how the gfp flags have been calculated and are valid.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
