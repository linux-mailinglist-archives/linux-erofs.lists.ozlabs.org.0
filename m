Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4683CBB31
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jul 2021 19:29:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GRJCL6Wxbz306F
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Jul 2021 03:29:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=dXMopdFJ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=dXMopdFJ; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GRJCB21Bhz2ysq
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Jul 2021 03:29:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=aZmjSXQT2GBYEBGI1TcwL/i/O3t9bBKdz76mcXGD5rk=; b=dXMopdFJgtdpJIeIYwMMT3lzlM
 dXojkdE1+oWzSS7x+Mp69ajD6KVNhWdk2swxd4P5C9zTFBYuLYVpAC1Wq6pFoQTURx5Hmy6c+SDRS
 JqglNgskvWn+Fuy5TT61n5/FBJcpc1EUd4hxWepM48PvxB84jEmb79BqiNO2CQs+Jwn/lhaU9JXgL
 QDEY2RwoUl/W003MFrZ8gBhI9rdCUveyIVKFcpBizgY5g0yQXYznTAlJIg2tDD2w9dzMPYiSyXq1e
 dTofb9LXvgdtZnMXIZIynvYEOW2sN1IOZ8s3JT0PKIUnO3d4Sx9r1zwHLmEY6X4eA+EZPcf7QimxL
 VsaH4Vjg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m4RdC-004g2W-T4; Fri, 16 Jul 2021 17:28:18 +0000
Date: Fri, 16 Jul 2021 18:28:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] iomap: Add missing flush_dcache_page
Message-ID: <YPHBqlLJQKQgRHqH@casper.infradead.org>
References: <20210716150032.1089982-1-willy@infradead.org>
 <YPGf8o7vo6/9iTE5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPGf8o7vo6/9iTE5@infradead.org>
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
 Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jul 16, 2021 at 04:04:18PM +0100, Christoph Hellwig wrote:
> On Fri, Jul 16, 2021 at 04:00:32PM +0100, Matthew Wilcox (Oracle) wrote:
> > Inline data needs to be flushed from the kernel's view of a page before
> > it's mapped by userspace.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 19e0c58f6552 ("iomap: generic inline data handling")
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/iomap/buffered-io.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 41da4f14c00b..fe60c603f4ca 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -222,6 +222,7 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
> >  	memcpy(addr, iomap->inline_data, size);
> >  	memset(addr + size, 0, PAGE_SIZE - size);
> >  	kunmap_atomic(addr);
> > +	flush_dcache_page(page);
> 
> .. and all writes into a kmap also need such a flush, so this needs to
> move a line up.  My plan was to add a memcpy_to_page_and_pad helper
> ala memcpy_to_page to get various file systems and drivers out of the
> business of cache flushing as much as we can.

hm?  It's absolutely allowed to flush the page after calling kunmap.
Look at zero_user_segments(), for example.
