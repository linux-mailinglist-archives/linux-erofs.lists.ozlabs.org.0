Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCA93D03CB
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jul 2021 23:19:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GTs6d2QM3z30Df
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jul 2021 07:19:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=vtbK6X1Q;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=vtbK6X1Q; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GTs6T3R8jz2xtk
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jul 2021 07:19:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=jH0gd7w7NQ82Sj3yTDMI2muMiPUSaHJ1LlIGDUYck8Q=; b=vtbK6X1QUhUbVCiHXfWP/ExRhw
 KNQBUSvy3uO+ot2vISeYwiVvAmHqXuITG+dcTbAodKGPGppApGDarmD7ySu8lNjM1ROP/urIEfmYA
 8FLE8SulGrQSPoVDPtZkYbqvceKsWuPKzVNyT2zPK1+0UnEjPpe6BEGDkM+lOM+lL3uAin9Hr552g
 VJtJIg/rquTd/yhHBDg8q1Zl5UEj+GcK88pFPQvbvCVtCvEaiSfdKPEpiEcCpviuzAoqmgrhz0FGp
 0uXG+65cOTsV05ZbWzdH7DtYSGYLClzsXM0fBx4Wtn4fjWU1CiJg5Lmnur9R61Eky9YLHdE5X+/Ju
 2mwIgtDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m5x8g-008WDw-B4; Tue, 20 Jul 2021 21:18:57 +0000
Date: Tue, 20 Jul 2021 22:18:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v4] iomap: support tail packing inline read
Message-ID: <YPc9viRAKm6cf2Ey@casper.infradead.org>
References: <20210720133554.44058-1-hsiangkao@linux.alibaba.com>
 <20210720204224.GK23236@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720204224.GK23236@magnolia>
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
Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jul 20, 2021 at 01:42:24PM -0700, Darrick J. Wong wrote:
> > -	BUG_ON(page_has_private(page));
> > -	BUG_ON(page->index);
> > -	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +	/* inline source data must be inside a single page */
> > +	BUG_ON(iomap->length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> 
> Can we reduce the strength of these checks to a warning and an -EIO
> return?

I'm not entirely sure that we need this check, tbh.

> > +	/* handle tail-packing blocks cross the current page into the next */
> > +	size = min_t(unsigned int, iomap->length + pos - iomap->offset,
> > +		     PAGE_SIZE - poff);
> >  
> >  	addr = kmap_atomic(page);
> > -	memcpy(addr, iomap->inline_data, size);
> > -	memset(addr + size, 0, PAGE_SIZE - size);
> > +	memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
> > +	memset(addr + poff + size, 0, PAGE_SIZE - poff - size);
> 
> Hmm, so I guess the point of this is to support reading data from a
> tail-packing block, where each file gets some arbitrary byte range
> within the tp-block, and the range isn't aligned to an fs block?  Hence
> you have to use the inline data code to read the relevant bytes and copy
> them into the pagecache?

I think there are two distinct cases for IOMAP_INLINE.  One is
where the tail of the file is literally embedded into the inode.
Like ext4 fast symbolic links.  Taking the ext4 i_blocks layout
as an example, you could have a 4kB block stored in i_block[0]
and then store bytes 4096-4151 in i_block[1-14] (although reading
https://www.kernel.org/doc/html/latest/filesystems/ext4/dynamic.html
makes me think that ext4 only supports storing 0-59 in the i_blocks;
it doesn't support 0-4095 in i_block[0] and then 4096-4151 in i_blocks)

The other is what I think erofs is doing where, for example, you'd
specify in i_block[1] the block which contains the tail and then in
i_block[2] what offset of the block the tail starts at.

