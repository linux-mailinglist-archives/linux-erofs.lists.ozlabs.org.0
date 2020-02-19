Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0DD1638F2
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 02:04:43 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MfdN72gnzDqcq
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 12:04:40 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTP id 48MfdJ4sF9zDq6k
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 12:04:34 +1100 (AEDT)
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au
 [49.179.138.28])
 by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 832B83A331C;
 Wed, 19 Feb 2020 12:04:32 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1j4Dmx-0004dF-Ul; Wed, 19 Feb 2020 12:04:31 +1100
Date: Wed, 19 Feb 2020 12:04:31 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6 08/19] mm: Add readahead address space operation
Message-ID: <20200219010431.GW10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-14-willy@infradead.org>
 <20200218062147.GN10776@dread.disaster.area>
 <20200218161004.GR7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218161004.GR7778@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
 a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=J8tHrh_ofsGOLyDWh6kA:9
 a=ffwTswad_GV-5CZc:21 a=o0rOaByW-dbbsVyy:21 a=CjuIK1q_8ugA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
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

On Tue, Feb 18, 2020 at 08:10:04AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 18, 2020 at 05:21:47PM +1100, Dave Chinner wrote:
> > On Mon, Feb 17, 2020 at 10:45:54AM -0800, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > This replaces ->readpages with a saner interface:
> > >  - Return void instead of an ignored error code.
> > >  - Pages are already in the page cache when ->readahead is called.
> > 
> > Might read better as:
> > 
> >  - Page cache is already populates with locked pages when
> >    ->readahead is called.
> 
> Will do.
> 
> > >  - Implementation looks up the pages in the page cache instead of
> > >    having them passed in a linked list.
> > 
> > Add:
> > 
> >  - cleanup of unused readahead handled by ->readahead caller, not
> >    the method implementation.
> 
> The readpages caller does that cleanup too, so it's not an advantage
> to the readahead interface.

Right. I kinda of read the list as "the reasons the new API is sane"
not as "how readahead is different to readpages"....

> > >  ``readpages``
> > >  	called by the VM to read pages associated with the address_space
> > >  	object.  This is essentially just a vector version of readpage.
> > >  	Instead of just one page, several pages are requested.
> > >  	readpages is only used for read-ahead, so read errors are
> > >  	ignored.  If anything goes wrong, feel free to give up.
> > > +	This interface is deprecated; implement readahead instead.
> > 
> > What is the removal schedule for the deprecated interface? 
> 
> I mentioned that in the cover letter; once Dave Howells has the fscache
> branch merged, I'll do the remaining filesystems.  Should be within the
> next couple of merge windows.

Sure, but I like to see actual release tags with the deprecation
notice so that it's obvious to the reader as to whether this is
something new and/or when they can expect it to go away.

> > > +/* The byte offset into the file of this readahead block */
> > > +static inline loff_t readahead_offset(struct readahead_control *rac)
> > > +{
> > > +	return (loff_t)rac->_start * PAGE_SIZE;
> > > +}
> > 
> > Urk. Didn't an early page use "offset" for the page index? That
> > was was "mm: Remove 'page_offset' from readahead loop" did, right?
> > 
> > That's just going to cause confusion to have different units for
> > readahead "offsets"....
> 
> We are ... not consistent anywhere in the VM/VFS with our naming.
> Unfortunately.
> 
> $ grep -n offset mm/filemap.c 
> 391: * @start:	offset in bytes where the range starts
> ...
> 815:	pgoff_t offset = old->index;
> ...
> 2020:	unsigned long offset;      /* offset into pagecache page */
> ...
> 2257:	*ppos = ((loff_t)index << PAGE_SHIFT) + offset;
> 
> That last one's my favourite.  Not to mention the fine distinction you
> and I discussed recently between offset_in_page() and page_offset().
> 
> Best of all, even our types encode the ambiguity of an 'offset'.  We have
> pgoff_t and loff_t (replacing the earlier off_t).
> 
> So, new rule.  'pos' is the number of bytes into a file.  'index' is the
> number of PAGE_SIZE pages into a file.  We don't use the word 'offset'
> at all.  'length' as a byte count and 'count' as a page count seem like
> fine names to me.

That sounds very reasonable to me. Another patchset in the making? :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
