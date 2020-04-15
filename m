Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBFE1A9213
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2020 06:56:29 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49296y3NHNzDr2F
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2020 14:56:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux-foundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=o7nTdRDW; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49296r2XDmzDr1P
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2020 14:56:19 +1000 (AEST)
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net
 [73.231.172.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3BD0920784;
 Wed, 15 Apr 2020 04:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586926577;
 bh=7/cyAEWqRIoOXcFZNvYgjU7w3cE8iC6Fh8sNAEooM88=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=o7nTdRDWnBos1+imCHuZl8B8uuGul0yLnN9eMfYMaDqOlB+cl/NgjLOckV0vY0hpP
 Ucm/O1A9vtop3dW0jo3wEyrWUTI/eFT4pIPVlWkKKNR0Qa5IVvC7y0T9VVsiPyVZ+6
 YcmvoJe/CEGPjhSZX5DnQnSB/tg3reced0fueZDI=
Date: Tue, 14 Apr 2020 21:56:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v11 05/25] mm: Add new readahead_control API
Message-Id: <20200414215616.f665d12f8549f52606784d1e@linux-foundation.org>
In-Reply-To: <20200415021808.GA5820@bombadil.infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-6-willy@infradead.org>
 <20200414181705.bfc4c0087092051a9475141e@linux-foundation.org>
 <20200415021808.GA5820@bombadil.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
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
Cc: linux-xfs@vger.kernel.org, William Kucharski <william.kucharski@oracle.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 14 Apr 2020 19:18:08 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Apr 14, 2020 at 06:17:05PM -0700, Andrew Morton wrote:
> > On Tue, 14 Apr 2020 08:02:13 -0700 Matthew Wilcox <willy@infradead.org> wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > Filesystems which implement the upcoming ->readahead method will get
> > > their pages by calling readahead_page() or readahead_page_batch().
> > > These functions support large pages, even though none of the filesystems
> > > to be converted do yet.
> > > 
> > > +static inline struct page *readahead_page(struct readahead_control *rac)
> > > +static inline unsigned int __readahead_batch(struct readahead_control *rac,
> > > +		struct page **array, unsigned int array_sz)
> > 
> > These are large functions.  Was it correct to inline them?
> 
> Hmm.  They don't seem that big to me.

They're really big!

> readahead_page, stripped of its sanity checks:

Well, the sanity checks still count for cache footprint.

otoh, I think a function which is expected to be called from a single
site per filesystem is OK to be inlined, because there's not likely to
be much icache benefit unless different filesystem types are
simultaneously being used heavily, which sounds unlikely.  Although
there's still a bit of overall code size bloat.

> +       rac->_index += rac->_batch_count;
> +       if (!rac->_nr_pages) {
> +               rac->_batch_count = 0;
> +               return NULL;
> +       }
> +       page = xa_load(&rac->mapping->i_pages, rac->_index);
> +       rac->_batch_count = hpage_nr_pages(page);
> 
> __readahead_batch is much bigger, but it's only used by btrfs and fuse,
> and it seemed unfair to make everybody pay the cost for a function only
> used by two filesystems.

Do we expect more filesystems to use these in the future?

These function are really big!

> > The batching API only appears to be used by fuse?  If so, do we really
> > need it?  Does it provide some functional need, or is it a performance
> > thing?  If the latter, how significant is it?
> 
> I must confess to not knowing the performance impact.  If the code uses
> xa_load() repeatedly, it costs O(log n) each time as we walk down the tree
> (mitigated to a large extent by cache, of course).  Using xas_for_each()
> keeps us at the bottom of the tree and each iteration is O(1).
> I'm interested to see if filesystem maintainers start to use the batch
> function or if they're happier sticking with the individual lookups.
> 
> The batch API was originally written for use with btrfs, but it was a
> significant simplification to convert fuse to use it.

hm, OK.  It's not clear that its inclusion is justified?

> > The code adds quite a few (inlined!) VM_BUG_ONs.  Can we plan to remove
> > them at some stage?  Such as, before Linus shouts at us :)
> 
> I'd be happy to remove them.  Various reviewers said things like "are you
> sure this can't happen?"

Yeah, these things tend to live for ever.  Please add a todo to remove
them after the code has matured?

