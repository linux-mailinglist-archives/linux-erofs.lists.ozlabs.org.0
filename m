Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E55C3CFE5B
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jul 2021 17:57:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GTjyj6rZfz3bSt
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jul 2021 01:57:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=oQrmeaLy;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=oQrmeaLy; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GTjyX2Qp8z300J
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jul 2021 01:57:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=xHc3DzHalCTqDobJ5vVOoZ7iaprvb5xHc81pJawU1NY=; b=oQrmeaLyxz9SidxuUn07Z95Stk
 muyQsxJjF9TDXi5Ml/OyTQSInPDeYVOCeIXrERYZKdOMv8uSaANLYFKXr+wCIx0y5vhMZqXqcMdM3
 Qy4lgGy/5UAvD8c26Ca3NPDpdLR1NtcxJ8qskgUyVRbqWgl3xdSAWAPfs0fNJDwxd+9kFVRX8xDwm
 vGJFhU4dFC4vgPa2OSLC5zLrkCPoWAKN6+j5rloh3k/fUuElmtFNuKM90EgWvbg85sfa1J62ILWyl
 +38+96HaN2FY82HlBPVe+qlaxYmGk1ZNxmbZcOpaXW9ISHDoxAvELuXpTqGOsj0bJugmwLjS+GANj
 FjSEK9kA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m5s6M-008Hf9-VV; Tue, 20 Jul 2021 15:56:21 +0000
Date: Tue, 20 Jul 2021 16:56:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] iomap: Add missing flush_dcache_page
Message-ID: <YPbyGnpwsaC006Rk@casper.infradead.org>
References: <20210716150032.1089982-1-willy@infradead.org>
 <YPGf8o7vo6/9iTE5@infradead.org>
 <YPHBqlLJQKQgRHqH@casper.infradead.org>
 <YPU6NVlfIh4PfbPl@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPU6NVlfIh4PfbPl@infradead.org>
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
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
 "Darrick J . Wong" <djwong@kernel.org>, stable@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 Christoph Lameter <cl@linux.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 19, 2021 at 09:39:17AM +0100, Christoph Hellwig wrote:
> On Fri, Jul 16, 2021 at 06:28:10PM +0100, Matthew Wilcox wrote:
> > > >  	memcpy(addr, iomap->inline_data, size);
> > > >  	memset(addr + size, 0, PAGE_SIZE - size);
> > > >  	kunmap_atomic(addr);
> > > > +	flush_dcache_page(page);
> > > 
> > > .. and all writes into a kmap also need such a flush, so this needs to
> > > move a line up.  My plan was to add a memcpy_to_page_and_pad helper
> > > ala memcpy_to_page to get various file systems and drivers out of the
> > > business of cache flushing as much as we can.
> > 
> > hm?  It's absolutely allowed to flush the page after calling kunmap.
> > Look at zero_user_segments(), for example.
> 
> Documentation/core-api/cachetlb.rst states that any user page obtained
> using kmap needs a flush_kernel_dcache_page after modification.
> flush_dcache_page is a strict superset of flush_kernel_dcache_page.

Looks like (the other) Christoph broke this in 2008 with commit
eebd2aa35569 ("Pagecache zeroing: zero_user_segment, zero_user_segments
and zero_user"):

It has one line about it in the changelog:

    Also extract the flushing of the caches to be outside of the kmap.

... which doesn't even attempt to justify why it's safe to do so.

-               memset((char *)kaddr + (offset), 0, (size));    \
-               flush_dcache_page(page);                        \
-               kunmap_atomic(kaddr, (km_type));                \
+       kunmap_atomic(kaddr, KM_USER0);
+       flush_dcache_page(page);

Looks like it came from
https://lore.kernel.org/lkml/20070911060425.472862098@sgi.com/
but there was no discussion of this ... plenty of discussion about
other conceptual problems with the entire patchset.

> That beeing said flushing after kmap updates is a complete mess.
> arm as probably the poster child for dcache challenged plus highmem
> architectures always flushed caches from kunmap and, and arc has
> a flush_dcache_page that doesn't work at all on a highmem page that
> is not kmapped (where kmap_atomic and kmap_local_page don't count as
> kmapped as they don't set page->virtual).
