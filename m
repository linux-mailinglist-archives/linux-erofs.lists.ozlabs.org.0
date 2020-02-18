Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0827F162780
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2020 14:56:49 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MMph182QzDqdS
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 00:56:44 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=jb2+luyx; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48MMpF4S7zzDqdS
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 00:56:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=QWm+MsHkSRgQJK1eFxqCcWrvQ90y26mjyjBOZ11Iwkk=; b=jb2+luyxr+xSioYyaBNa3dAEcG
 HSkNE/u4FRJRlH9iJvfMy5PCbL6cVJNDiZN1T+0cd1NFPBhswNdJGqv4MI+l2rK+i+tYpDmuT8Bqa
 v4kTQEGSXMc95ruYcJyKvonnTr8/VCdmBG1QzESKMSk9lJUywki+bnjFt/A2gjwlx0PFneQN6p+Z8
 w8PFnDecZukQL71k/MfBJQ4M0XvKWkJLm4emA2PDAS90/6wmUKCMv8DC2uYB8tZIweEjrWjDvK1i9
 ARqcVs4oiBQgZVdD9JO7vnPU+QZg8rs4gj+Y0mapS7yUw3ZxNuiOhm4hApWihKBeAmYq71FGdgE8W
 1g9mrcqA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j43MI-0000Q8-5H; Tue, 18 Feb 2020 13:56:18 +0000
Date: Tue, 18 Feb 2020 05:56:18 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v6 03/19] mm: Use readahead_control to pass arguments
Message-ID: <20200218135618.GO7778@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-4-willy@infradead.org>
 <20200218050300.GI10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218050300.GI10776@dread.disaster.area>
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

On Tue, Feb 18, 2020 at 04:03:00PM +1100, Dave Chinner wrote:
> On Mon, Feb 17, 2020 at 10:45:44AM -0800, Matthew Wilcox wrote:
> > +static void read_pages(struct readahead_control *rac, struct list_head *pages,
> > +		gfp_t gfp)
> >  {
> > +	const struct address_space_operations *aops = rac->mapping->a_ops;
> >  	struct blk_plug plug;
> >  	unsigned page_idx;
> 
> Splitting out the aops rather than the mapping here just looks
> weird, especially as you need the mapping later in the function.
> Using aops doesn't even reduce the code side....

It does in subsequent patches ... I agree it looks a little weird here,
but I think in the final form, it makes sense:

static void read_pages(struct readahead_control *rac, struct list_head *pages)
{
        const struct address_space_operations *aops = rac->mapping->a_ops;
        struct page *page;
        struct blk_plug plug;

        blk_start_plug(&plug);

        if (aops->readahead) {
                aops->readahead(rac);
                readahead_for_each(rac, page) {
                        unlock_page(page);
                        put_page(page);
                }
        } else if (aops->readpages) {
                aops->readpages(rac->file, rac->mapping, pages,
                                readahead_count(rac));
                /* Clean up the remaining pages */
                put_pages_list(pages);
        } else {
                readahead_for_each(rac, page) {
                        aops->readpage(rac->file, page);
                        put_page(page);
                }
        }

        blk_finish_plug(&plug);
}

It'll look even better once ->readpages goes away.

> > @@ -155,9 +158,13 @@ void __do_page_cache_readahead(struct address_space *mapping,
> >  	unsigned long end_index;	/* The last page we want to read */
> >  	LIST_HEAD(page_pool);
> >  	int page_idx;
> > -	unsigned int nr_pages = 0;
> >  	loff_t isize = i_size_read(inode);
> >  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
> > +	struct readahead_control rac = {
> > +		.mapping = mapping,
> > +		.file = filp,
> > +		._nr_pages = 0,
> > +	};
> 
> No need to initialise _nr_pages to zero, leaving it out will do the
> same thing.

Yes, it does, but I wanted to make it explicit here.

> > +			if (readahead_count(&rac))
> > +				read_pages(&rac, &page_pool, gfp_mask);
> > +			rac._nr_pages = 0;
> 
> Hmmm. Wondering ig it make sense to move the gfp_mask to the readahead
> control structure - if we have to pass the gfp_mask down all the
> way along side the rac, then I think it makes sense to do that...

So we end up removing it later on in this series, but I do wonder if
it would make sense anyway.  By the end of the series, we still have
this in iomap:

                if (ctx->rac) /* same as readahead_gfp_mask */
                        gfp |= __GFP_NORETRY | __GFP_NOWARN;

and we could get rid of that by passing gfp flags down in the rac.  On the
other hand, I don't know why it doesn't just use readahead_gfp_mask()
here anyway ... Christoph?
