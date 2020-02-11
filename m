Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D82159A40
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2020 21:08:55 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48HDPJ1KGfzDqLD
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2020 07:08:52 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTP id 48HDNt6knQzDqLM
 for <linux-erofs@lists.ozlabs.org>; Wed, 12 Feb 2020 07:08:30 +1100 (AEDT)
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au
 [49.179.138.28])
 by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 2D0293A3899;
 Wed, 12 Feb 2020 07:08:28 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1j1bpa-0002l0-DL; Wed, 12 Feb 2020 07:08:26 +1100
Date: Wed, 12 Feb 2020 07:08:26 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5 04/13] mm: Add readahead address space operation
Message-ID: <20200211200826.GK10776@dread.disaster.area>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-5-willy@infradead.org>
 <20200211045230.GD10776@dread.disaster.area>
 <20200211125413.GU8731@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211125413.GU8731@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
 a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
 a=7-415B0cAAAA:8 a=EnYlyWvjhy6VBD_eMqkA:9 a=CdacwtsPoHkD4rhW:21
 a=vlsg44Ume0T2P6Xz:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
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
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Feb 11, 2020 at 04:54:13AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 11, 2020 at 03:52:30PM +1100, Dave Chinner wrote:
> > > +struct readahead_control {
> > > +	struct file *file;
> > > +	struct address_space *mapping;
> > > +/* private: use the readahead_* accessors instead */
> > > +	pgoff_t start;
> > > +	unsigned int nr_pages;
> > > +	unsigned int batch_count;
> > > +};
> > > +
> > > +static inline struct page *readahead_page(struct readahead_control *rac)
> > > +{
> > > +	struct page *page;
> > > +
> > > +	if (!rac->nr_pages)
> > > +		return NULL;
> > > +
> > > +	page = xa_load(&rac->mapping->i_pages, rac->start);
> > > +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> > > +	rac->batch_count = hpage_nr_pages(page);
> > > +	rac->start += rac->batch_count;
> > 
> > There's no mention of large page support in the patch description
> > and I don't recall this sort of large page batching in previous
> > iterations.
> > 
> > This seems like new functionality to me, not directly related to
> > the initial ->readahead API change? What have I missed?
> 
> I had a crisis of confidence when I was working on this -- the loop
> originally looked like this:
> 
> #define readahead_for_each(rac, page)                                   \
>         for (; (page = readahead_page(rac)); rac->nr_pages--)
> 
> and then I started thinking about what I'd need to do to support large
> pages, and that turned into
> 
> #define readahead_for_each(rac, page)                                   \
>         for (; (page = readahead_page(rac));				\
> 		rac->nr_pages -= hpage_nr_pages(page))
> 
> but I realised that was potentially a use-after-free because 'page' has
> certainly had put_page() called on it by then.  I had a brief period
> where I looked at moving put_page() away from being the filesystem's
> responsibility and into the iterator, but that would introduce more
> changes into the patchset, as well as causing problems for filesystems
> that want to break out of the loop.
> 
> By this point, I was also looking at the readahead_for_each_batch()
> iterator that btrfs uses, and so we have the batch count anyway, and we
> might as well use it to store the number of subpages of the large page.
> And so it became easier to just put the whole ball of wax into the initial
> patch set, rather than introduce the iterator now and then fix it up in
> the patch set that I'm basing on this.
> 
> So yes, there's a certain amount of excess functionality in this patch
> set ... I can remove it for the next release.

I'd say "Just document it" as that was the main reason I noticed it.
Or perhaps add the batching function as a stand-alone patch so it's
clear that the batch interface solves two problems at once - large
pages and the btrfs page batching implementation...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
