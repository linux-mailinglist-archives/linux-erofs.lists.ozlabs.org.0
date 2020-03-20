Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE4B18D77E
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2020 19:41:51 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48kXgJ1n3JzF0YP
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2020 05:41:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=wi2vuW5I; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48kXf65BMWzF0ZD
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2020 05:40:46 +1100 (AEDT)
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 275D420739;
 Fri, 20 Mar 2020 18:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584729643;
 bh=0lySpfIbLYVkl86wERt9XwrjnUjq7J+z8XZeuge/+7s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wi2vuW5Igyu46y5Wx05mkvW8a/VLckiN7s/9GNIOdxM9U7yQM1pyY2njL/QMwkPan
 KWQEARrCqs16OuxD5B6Kg1R9790qkHmt4v/O/PZizCk3+z+HWCmu6og3Em53508k9B
 iW3Hml7aQ3jDLnTGNz1ZqdOb+OAH89RjMJ2Qz1nU=
Date: Fri, 20 Mar 2020 11:40:41 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v9 20/25] ext4: Convert from readpages to readahead
Message-ID: <20200320184041.GG851@sol.localdomain>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-21-willy@infradead.org>
 <20200320173734.GD851@sol.localdomain>
 <20200320174848.GC4971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320174848.GC4971@bombadil.infradead.org>
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
Cc: cluster-devel@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 William Kucharski <william.kucharski@oracle.com>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Mar 20, 2020 at 10:48:48AM -0700, Matthew Wilcox wrote:
> On Fri, Mar 20, 2020 at 10:37:34AM -0700, Eric Biggers wrote:
> > On Fri, Mar 20, 2020 at 07:22:26AM -0700, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > Use the new readahead operation in ext4
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> > > ---
> > >  fs/ext4/ext4.h     |  3 +--
> > >  fs/ext4/inode.c    | 21 +++++++++------------
> > >  fs/ext4/readpage.c | 22 ++++++++--------------
> > >  3 files changed, 18 insertions(+), 28 deletions(-)
> > > 
> > 
> > Reviewed-by: Eric Biggers <ebiggers@google.com>
> > 
> > > +		if (rac) {
> > > +			page = readahead_page(rac);
> > >  			prefetchw(&page->flags);
> > > -			list_del(&page->lru);
> > > -			if (add_to_page_cache_lru(page, mapping, page->index,
> > > -				  readahead_gfp_mask(mapping)))
> > > -				goto next_page;
> > >  		}
> > 
> > Maybe the prefetchw(&page->flags) should be included in readahead_page()?
> > Most of the callers do it.
> 
> I did notice that a lot of callers do that.  I wonder whether it (still)
> helps or whether it's just cargo-cult programming.  It can't possibly
> have helped before because we did list_del(&page->lru) as the very next
> instruction after prefetchw(), and they're in the same cacheline.  It'd
> be interesting to take it out and see what happens to performance.

Yeah, it does look like the list_del() made the prefetchw() useless, so it
should just be removed.  The prefetchw() dates all the way back to
mpage_readpages() being added in 2002, but even then the list_del() was
immediately afterwards, and 'flags' and 'lru' were in the same cache line in
'struct page' even then (assuming at least a 32-byte cache line size), so...

- Eric
