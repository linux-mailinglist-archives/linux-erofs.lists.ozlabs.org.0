Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A55EE162A17
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2020 17:10:22 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MQmq7376zDqbc
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 03:10:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=ipLlBOxg; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48MQmb332dzDqY0
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 03:10:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=5KDaFTW+pz8VfJMmd/150jcSlwmVWcMm/3HMnI/xfvg=; b=ipLlBOxgYKVfRZo7Sgo48aXcMn
 g+YvOK1M9fWayNYCWbwGsZLPH92YapUqcU3V5/r6tbkb9ft/cqAo3wSGowvvZcx4rWcc7/FZqrjgU
 C3Fut73k2NJ3qoka036sCPRkrwE5zKTESvinIrwcv+q0cgEnEAW9BFRIcBy7P/qW64o6xFymjBnd6
 8c5ms/UIfeyFwZwXVtAUiNakXaQvESAYSksXwpI8XKuUP0K9NptGJs83qh5VWlLhzAz7zqZR5fA4t
 Wop5PUNx/CWSP8yDQssgxeF8hMUqj5MF3HuUkauFwvDvTC8SaXnbvBgLZnpTizJzcd+E709oxa5QK
 FdKMzcpg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j45Rk-0001Tm-Vv; Tue, 18 Feb 2020 16:10:04 +0000
Date: Tue, 18 Feb 2020 08:10:04 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v6 08/19] mm: Add readahead address space operation
Message-ID: <20200218161004.GR7778@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-14-willy@infradead.org>
 <20200218062147.GN10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218062147.GN10776@dread.disaster.area>
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

On Tue, Feb 18, 2020 at 05:21:47PM +1100, Dave Chinner wrote:
> On Mon, Feb 17, 2020 at 10:45:54AM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > This replaces ->readpages with a saner interface:
> >  - Return void instead of an ignored error code.
> >  - Pages are already in the page cache when ->readahead is called.
> 
> Might read better as:
> 
>  - Page cache is already populates with locked pages when
>    ->readahead is called.

Will do.

> >  - Implementation looks up the pages in the page cache instead of
> >    having them passed in a linked list.
> 
> Add:
> 
>  - cleanup of unused readahead handled by ->readahead caller, not
>    the method implementation.

The readpages caller does that cleanup too, so it's not an advantage
to the readahead interface.

        if (mapping->a_ops->readpages) {
                ret = mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
                /* Clean up the remaining pages */
                put_pages_list(pages);
                goto out;
        }

> >  ``readpages``
> >  	called by the VM to read pages associated with the address_space
> >  	object.  This is essentially just a vector version of readpage.
> >  	Instead of just one page, several pages are requested.
> >  	readpages is only used for read-ahead, so read errors are
> >  	ignored.  If anything goes wrong, feel free to give up.
> > +	This interface is deprecated; implement readahead instead.
> 
> What is the removal schedule for the deprecated interface? 

I mentioned that in the cover letter; once Dave Howells has the fscache
branch merged, I'll do the remaining filesystems.  Should be within the
next couple of merge windows.

> > +/* The byte offset into the file of this readahead block */
> > +static inline loff_t readahead_offset(struct readahead_control *rac)
> > +{
> > +	return (loff_t)rac->_start * PAGE_SIZE;
> > +}
> 
> Urk. Didn't an early page use "offset" for the page index? That
> was was "mm: Remove 'page_offset' from readahead loop" did, right?
> 
> That's just going to cause confusion to have different units for
> readahead "offsets"....

We are ... not consistent anywhere in the VM/VFS with our naming.
Unfortunately.

$ grep -n offset mm/filemap.c 
391: * @start:	offset in bytes where the range starts
...
815:	pgoff_t offset = old->index;
...
2020:	unsigned long offset;      /* offset into pagecache page */
...
2257:	*ppos = ((loff_t)index << PAGE_SHIFT) + offset;

That last one's my favourite.  Not to mention the fine distinction you
and I discussed recently between offset_in_page() and page_offset().

Best of all, even our types encode the ambiguity of an 'offset'.  We have
pgoff_t and loff_t (replacing the earlier off_t).

So, new rule.  'pos' is the number of bytes into a file.  'index' is the
number of PAGE_SIZE pages into a file.  We don't use the word 'offset'
at all.  'length' as a byte count and 'count' as a page count seem like
fine names to me.

> > -	if (aops->readpages) {
> > +	if (aops->readahead) {
> > +		aops->readahead(rac);
> > +		readahead_for_each(rac, page) {
> > +			unlock_page(page);
> > +			put_page(page);
> > +		}
> 
> This needs a comment to explain the unwinding that needs to be done
> here. I'm not going to remember in a year's time that this is just
> for the pages that weren't submitted by ->readahead....

ACK.
