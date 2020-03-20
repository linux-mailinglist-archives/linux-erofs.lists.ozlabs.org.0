Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id AC60E18D69B
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2020 19:12:02 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48kX0v3WnrzF0Pt
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2020 05:11:59 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=eyNztVgX; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48kX0c11ZJzF0Bm
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2020 05:11:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=p6kUQaVzyG/7aafQEj2oYoGKarn6agZvQF5qHrKX8Tc=; b=eyNztVgX76i16/jeYqqPpZu4sX
 sXc8vs25jMw4vVAYXjoA8DgM2uzIMN5yBWkGawjo5WX9KQRuVqhyOMcR+1OXjTrnmUOvKFLlajWTh
 C/zG1s50fN4WqpS6HehSEJni5oQ1WzUhIAStAK+kmIlg6EMycQupwu059cgWaJPn310ClNl6D4VPx
 0e3/G4ggInF9NSQVBazYXx0s2qIlmusdCkBUh0+eyUkvYj7N4d9XynyqouwQZVf7LWrCI1BgqP8Cs
 UrxUi+eztNgKF6XQIzB1awOkum9npNrbgagQQwgGAqvgh6c/Ea6GWk8cbheHh79L9/ElbL5oi8/X6
 G99RY7Ig==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jFM7I-0001VF-Jx; Fri, 20 Mar 2020 18:11:32 +0000
Date: Fri, 20 Mar 2020 11:11:32 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v9 12/25] mm: Move end_index check out of readahead loop
Message-ID: <20200320181132.GD4971@bombadil.infradead.org>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-13-willy@infradead.org>
 <20200320165828.GB851@sol.localdomain>
 <20200320173040.GB4971@bombadil.infradead.org>
 <20200320180017.GE851@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320180017.GE851@sol.localdomain>
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
Cc: cluster-devel@redhat.com, linux-mm@kvack.org,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 William Kucharski <william.kucharski@oracle.com>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Mar 20, 2020 at 11:00:17AM -0700, Eric Biggers wrote:
> On Fri, Mar 20, 2020 at 10:30:40AM -0700, Matthew Wilcox wrote:
> > On Fri, Mar 20, 2020 at 09:58:28AM -0700, Eric Biggers wrote:
> > > On Fri, Mar 20, 2020 at 07:22:18AM -0700, Matthew Wilcox wrote:
> > > > +	/* Avoid wrapping to the beginning of the file */
> > > > +	if (index + nr_to_read < index)
> > > > +		nr_to_read = ULONG_MAX - index + 1;
> > > > +	/* Don't read past the page containing the last byte of the file */
> > > > +	if (index + nr_to_read >= end_index)
> > > > +		nr_to_read = end_index - index + 1;
> > > 
> > > There seem to be a couple off-by-one errors here.  Shouldn't it be:
> > > 
> > > 	/* Avoid wrapping to the beginning of the file */
> > > 	if (index + nr_to_read < index)
> > > 		nr_to_read = ULONG_MAX - index;
> > 
> > I think it's right.  Imagine that index is ULONG_MAX.  We should read one
> > page (the one at ULONG_MAX).  That would be ULONG_MAX - ULONG_MAX + 1.
> > 
> > > 	/* Don't read past the page containing the last byte of the file */
> > > 	if (index + nr_to_read > end_index)
> > > 		nr_to_read = end_index - index + 1;
> > > 
> > > I.e., 'ULONG_MAX - index' rather than 'ULONG_MAX - index + 1', so that
> > > 'index + nr_to_read' is then ULONG_MAX rather than overflowed to 0.
> > > 
> > > Then 'index + nr_to_read > end_index' rather 'index + nr_to_read >= end_index',
> > > since otherwise nr_to_read can be increased by 1 rather than decreased or stay
> > > the same as expected.
> > 
> > Ooh, I missed the overflow case here.  It should be:
> > 
> > +	if (index + nr_to_read - 1 > end_index)
> > +		nr_to_read = end_index - index + 1;
> > 
> 
> But then if someone passes index=0 and nr_to_read=0, this underflows and the
> entire file gets read.

nr_to_read == 0 doesn't make sense ... I thought we filtered that out
earlier, but I can't find anywhere that does that right now.  I'd
rather return early from __do_page_cache_readahead() to fix that.

> The page cache isn't actually supposed to contain a page at index ULONG_MAX,
> since MAX_LFS_FILESIZE is at most ((loff_t)ULONG_MAX << PAGE_SHIFT), right?  So
> I don't think we need to worry about reading the page with index ULONG_MAX.
> I.e. I think it's fine to limit nr_to_read to 'ULONG_MAX - index', if that makes
> it easier to avoid an overflow or underflow in the next check.

I think we can get a page at ULONG_MAX on 32-bit systems?  I mean, we can buy
hard drives which are larger than 16TiB these days:
https://www.pcmag.com/news/seagate-will-ship-18tb-and-20tb-hard-drives-in-2020
(even ignoring RAID devices)
