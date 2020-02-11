Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6A0158F38
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2020 13:54:29 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48H2m23CDlzDqM1
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2020 23:54:26 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=eWC7poTU; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48H2ls2Zm9zDqM1
 for <linux-erofs@lists.ozlabs.org>; Tue, 11 Feb 2020 23:54:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+uQN30cS5Bj87iEEBzdOLx8lg9+i0ExEu8VOZjq8Ndo=; b=eWC7poTUmbgHCYbKut5tUcDZwL
 w3YYTT854/6orjDXWt0o8myOrLaqYxmNildHwtqHwB9P6sAmRSzUVkC2ndTa5MBo6vPhEIM38iBQg
 3QFH9rbgbTMx5jUAauOSubj91u3I4QqJCftUeJ3u2BRZFY7uw1LRQwqgp3/dZBByXH8F5OzZAb0t+
 miBihdnvmVJGXqnRBr1rG3atRoSZFunPwyyK3rI6Tg1RqDm7wVtET7WbIVm0KlJr9sAYInPEKF3Lu
 GTYeC4TiyWPK4e73vfdDf6T1j5MFZMYQQejC42VttS5bt+wx+jfOtOIGuI60RBaTCQF1YD4hRLaX6
 1eYOefYA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j1V3O-0006U6-1C; Tue, 11 Feb 2020 12:54:14 +0000
Date: Tue, 11 Feb 2020 04:54:13 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v5 04/13] mm: Add readahead address space operation
Message-ID: <20200211125413.GU8731@bombadil.infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-5-willy@infradead.org>
 <20200211045230.GD10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211045230.GD10776@dread.disaster.area>
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

On Tue, Feb 11, 2020 at 03:52:30PM +1100, Dave Chinner wrote:
> > +struct readahead_control {
> > +	struct file *file;
> > +	struct address_space *mapping;
> > +/* private: use the readahead_* accessors instead */
> > +	pgoff_t start;
> > +	unsigned int nr_pages;
> > +	unsigned int batch_count;
> > +};
> > +
> > +static inline struct page *readahead_page(struct readahead_control *rac)
> > +{
> > +	struct page *page;
> > +
> > +	if (!rac->nr_pages)
> > +		return NULL;
> > +
> > +	page = xa_load(&rac->mapping->i_pages, rac->start);
> > +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> > +	rac->batch_count = hpage_nr_pages(page);
> > +	rac->start += rac->batch_count;
> 
> There's no mention of large page support in the patch description
> and I don't recall this sort of large page batching in previous
> iterations.
> 
> This seems like new functionality to me, not directly related to
> the initial ->readahead API change? What have I missed?

I had a crisis of confidence when I was working on this -- the loop
originally looked like this:

#define readahead_for_each(rac, page)                                   \
        for (; (page = readahead_page(rac)); rac->nr_pages--)

and then I started thinking about what I'd need to do to support large
pages, and that turned into

#define readahead_for_each(rac, page)                                   \
        for (; (page = readahead_page(rac));				\
		rac->nr_pages -= hpage_nr_pages(page))

but I realised that was potentially a use-after-free because 'page' has
certainly had put_page() called on it by then.  I had a brief period
where I looked at moving put_page() away from being the filesystem's
responsibility and into the iterator, but that would introduce more
changes into the patchset, as well as causing problems for filesystems
that want to break out of the loop.

By this point, I was also looking at the readahead_for_each_batch()
iterator that btrfs uses, and so we have the batch count anyway, and we
might as well use it to store the number of subpages of the large page.
And so it became easier to just put the whole ball of wax into the initial
patch set, rather than introduce the iterator now and then fix it up in
the patch set that I'm basing on this.

So yes, there's a certain amount of excess functionality in this patch
set ... I can remove it for the next release.
