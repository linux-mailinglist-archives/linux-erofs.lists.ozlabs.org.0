Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 88388192C97
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2020 16:32:43 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48nXDn0NkgzDqdx
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2020 02:32:41 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=nwr8fvcC; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48nXDc3r83zDqYJ
 for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2020 02:32:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=L8UzQwxATOZdjWZ+3tNM04b2mH/5tj4IRSDfIFAnCq4=; b=nwr8fvcCAKrcOHuwe8r/p16lMc
 bZh3DEdAU9aGBWN3F5ynv1Ne93Ij03ZhftdP2p/j/SwKFdDbTLj5/ZaltpVeKwhDVOtZpmt6dBgOM
 Y5kNAkTDyJM9LmxIOgZivD4BtHVK41PC4z2UtEwA8qUzMYjVHQwzjfESuvsJdyTL91AdLqA/lHmDm
 b4ONx8n6tUgKbzMesC9PHNx/tJe345Szba01BQVbNkeQ4aBKyS9/rqkTgJMFlzt5JsbGeTzjBPG19
 tW79XBGQHh8i08Okr8byBxVFG1QH7u5q9rAcay5PaTaRDoWupoIchhUNkRzhk4f/AQVLTP2rNvR7K
 5pnTChzQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jH816-0004oZ-U3; Wed, 25 Mar 2020 15:32:28 +0000
Date: Wed, 25 Mar 2020 08:32:28 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v10 24/25] fuse: Convert from readpages to readahead
Message-ID: <20200325153228.GB22483@bombadil.infradead.org>
References: <20200323202259.13363-1-willy@infradead.org>
 <20200323202259.13363-25-willy@infradead.org>
 <CAJfpegu7EFcWrg3bP+-2BX_kb52RrzBCo_U3QKYzUkZfe4EjDA@mail.gmail.com>
 <20200325120254.GA22483@bombadil.infradead.org>
 <CAJfpegshssCJiA8PBcq2XvBj3mR8dufHb0zWRFvvKKv82VQYsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegshssCJiA8PBcq2XvBj3mR8dufHb0zWRFvvKKv82VQYsw@mail.gmail.com>
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

On Wed, Mar 25, 2020 at 03:43:02PM +0100, Miklos Szeredi wrote:
> >
> > -       while ((page = readahead_page(rac))) {
> > -               if (fuse_readpages_fill(&data, page) != 0)
> > +               nr_pages = min(readahead_count(rac), fc->max_pages);
> 
> Missing fc->max_read clamp.

Yeah, I realised that.  I ended up doing ...

+       unsigned int i, max_pages, nr_pages = 0;
...
+       max_pages = min(fc->max_pages, fc->max_read / PAGE_SIZE);

> > +               ia = fuse_io_alloc(NULL, nr_pages);
> > +               if (!ia)
> >                         return;
> > +               ap = &ia->ap;
> > +               __readahead_batch(rac, ap->pages, nr_pages);
> 
> nr_pages = __readahead_batch(...)?

That's the other bug ... this was designed for btrfs which has a fixed-size
buffer.  But you want to dynamically allocate fuse_io_args(), so we need to
figure out the number of pages beforehand, which is a little awkward.  I've
settled on this for the moment:

        for (;;) {
               struct fuse_io_args *ia;
                struct fuse_args_pages *ap;

                nr_pages = readahead_count(rac) - nr_pages;
                if (nr_pages > max_pages)
                        nr_pages = max_pages;
                if (nr_pages == 0)
                        break;
                ia = fuse_io_alloc(NULL, nr_pages);
                if (!ia)
                        return;
                ap = &ia->ap;
                __readahead_batch(rac, ap->pages, nr_pages);
                for (i = 0; i < nr_pages; i++) {
                        fuse_wait_on_page_writeback(inode,
                                                    readahead_index(rac) + i);
                        ap->descs[i].length = PAGE_SIZE;
                }
                ap->num_pages = nr_pages;
                fuse_send_readpages(ia, rac->file);
        }

but I'm not entirely happy with that either.  Pondering better options.

> This will give consecutive pages, right?

readpages() was already being called with consecutive pages.  Several
filesystems had code to cope with the pages being non-consecutive, but
that wasn't how the core code worked; if there was a discontiguity it
would send off the pages that were consecutive and start a new batch.

__readahead_batch() can't return fewer than nr_pages, so you don't need
to check for that.
