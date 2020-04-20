Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0ED1B07CE
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2020 13:43:22 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 495Pw74s7mzDqjN
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2020 21:43:19 +1000 (AEST)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=g7JEJ58U; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 495Pvs6GPyzDqDm
 for <linux-erofs@lists.ozlabs.org>; Mon, 20 Apr 2020 21:43:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=y3v9H7gulitO+Y85OVNVzldz0TRWO8cQsHtyyEuI5ig=; b=g7JEJ58UfwyeWV04dJy7haqXcR
 FkY7TCFjfydjy7CUKLk2sKTRTGMeWlNvIH6QaFdDcJ6LNamrUKqVtRcrYX13W0QaBjHoZgQRwTrWr
 pFMw6Zh2CU0LWD4TLAEVKbFuQrrB+5ujPnG45zzsqeSt+qZFmCfJvo+ZWZer92aHWA9AX6zXTHxmR
 SZTQ0uswpYDxkQli+e+cy4XXvjLfdwzNe85/eZjU4D+5T9gllu2ggGK4e+wrNS8ioWTjEeUaLiDp9
 BBpgydRU02eR0+H8csye5k3wOpZi5BcrTH2LP3QdS1jLAlgaTQNjvb0utJkJEpp5gVZ/qj8/l1oQZ
 Kc/2zb2Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jQUpI-0006Jo-4N; Mon, 20 Apr 2020 11:43:00 +0000
Date: Mon, 20 Apr 2020 04:43:00 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v11 24/25] fuse: Convert from readpages to readahead
Message-ID: <20200420114300.GB5820@bombadil.infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-25-willy@infradead.org>
 <CAJfpegsZF=TFQ67vABkE5ghiZoTZF+=_u8tM5U_P6jZeAmv23A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsZF=TFQ67vABkE5ghiZoTZF+=_u8tM5U_P6jZeAmv23A@mail.gmail.com>
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
Cc: linux-xfs <linux-xfs@vger.kernel.org>,
 William Kucharski <william.kucharski@oracle.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Apr 20, 2020 at 01:14:17PM +0200, Miklos Szeredi wrote:
> > +       for (;;) {
> > +               struct fuse_io_args *ia;
> > +               struct fuse_args_pages *ap;
> > +
> > +               nr_pages = readahead_count(rac) - nr_pages;
> 
> Hmm.  I see what's going on here, but it's confusing.   Why is
> __readahead_batch() decrementing the readahead count at the start,
> rather than at the end?
> 
> At the very least it needs a comment about why nr_pages is calculated this way.

Because usually that's what we want.  See, for example, fs/mpage.c:

        while ((page = readahead_page(rac))) {
                prefetchw(&page->flags);
                args.page = page;
                args.nr_pages = readahead_count(rac);
                args.bio = do_mpage_readpage(&args);
                put_page(page);
        }

fuse is different because it's trying to allocate for the next batch,
not for the batch we're currently on.

I'm a little annoyed because I posted almost this exact loop here:

https://lore.kernel.org/linux-fsdevel/CAJfpegtrhGamoSqD-3Svfj3-iTdAbfD8TP44H_o+HE+g+CAnCA@mail.gmail.com/

and you said "I think that's fine", modified only by your concern
for it not being obvious that nr_pages couldn't be decremented by
__readahead_batch(), so I modified the loop slightly to assign to
nr_pages.  The part you're now complaining about is unchanged.

> > +               if (nr_pages > max_pages)
> > +                       nr_pages = max_pages;
> > +               if (nr_pages == 0)
> > +                       break;
> > +               ia = fuse_io_alloc(NULL, nr_pages);
> > +               if (!ia)
> > +                       return;
> > +               ap = &ia->ap;
> > +               nr_pages = __readahead_batch(rac, ap->pages, nr_pages);
> > +               for (i = 0; i < nr_pages; i++) {
> > +                       fuse_wait_on_page_writeback(inode,
> > +                                                   readahead_index(rac) + i);
> 
> What's wrong with ap->pages[i]->index?  Are we trying to wean off using ->index?

It saves reading from a cacheline?  I wouldn't be surprised if the
compiler hoisted the read from rac->_index to outside the loop and just
iterated from rac->_index to rac->_index + nr_pages.
