Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587A83D060A
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jul 2021 02:17:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GTx3p1Z2dz3073
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jul 2021 10:17:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TXSLVz8H;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TXSLVz8H; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GTx3l4Vlpz2yLV
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jul 2021 10:17:23 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 167D761019;
 Wed, 21 Jul 2021 00:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626826641;
 bh=BAf24pBOd5vcvL9pJfGRG9h4uyY5iC2A0LApbSzyhy8=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=TXSLVz8HQpk9sGs6HV8UiQpvtDXi4gyPsPkxqb8syZbXCwCPQm993eJkl8azoE7uz
 0RifQxz3lLU9XdYxG8wwRZU2ehZmN/3CoRWz3LPuYpw0GKFjTpUyodmniyRyqUPRNE
 Y3BPZLtYcvR80ai3m/op3vUpH7utZxLozSBWNoFIBKVGlwXMSYHvHiUjjWRVcbY77u
 Vnj8NC6QJpax5KSyexEJoa5djVmQbMV+vPPy2KL5Fvwf8OLOLyrpj1OEFxtcaWYNwJ
 uExRbAhAx+JZRx2BulWUb+MsHPMpiCjix0IOGgSEoYXvcJfLmPFyH6Cu9fTAe2QdIH
 PEpn5k1jMV+8A==
Date: Tue, 20 Jul 2021 17:17:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v4] iomap: support tail packing inline read
Message-ID: <20210721001720.GS22357@magnolia>
References: <20210720133554.44058-1-hsiangkao@linux.alibaba.com>
 <20210720204224.GK23236@magnolia>
 <YPc9viRAKm6cf2Ey@casper.infradead.org>
 <YPdkYFSjFHDOU4AV@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPdkYFSjFHDOU4AV@B-P7TQMD6M-0146.local>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jul 21, 2021 at 08:03:44AM +0800, Gao Xiang wrote:
> On Tue, Jul 20, 2021 at 10:18:54PM +0100, Matthew Wilcox wrote:
> > On Tue, Jul 20, 2021 at 01:42:24PM -0700, Darrick J. Wong wrote:
> > > > -	BUG_ON(page_has_private(page));
> > > > -	BUG_ON(page->index);
> > > > -	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > > > +	/* inline source data must be inside a single page */
> > > > +	BUG_ON(iomap->length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > > 
> > > Can we reduce the strength of these checks to a warning and an -EIO
> > > return?
> > 
> > I'm not entirely sure that we need this check, tbh.
> 
> I'm fine to get rid of this check, it just inherited from:
>  - BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> 
> It has no real effect, but when reading INLINE extent, its .iomap_begin()
> does:
> 	iomap->private = erofs_get_meta_page()	/* get meta page */
> 
> and in the .iomap_end(), it does:
> 	struct page *ipage = iomap->private;
> 	if (ipage) {
> 		unlock_page(ipage);
> 		put_page(ipage);
> 	}
> 
> > 
> > > > +	/* handle tail-packing blocks cross the current page into the next */
> > > > +	size = min_t(unsigned int, iomap->length + pos - iomap->offset,
> > > > +		     PAGE_SIZE - poff);
> > > >  
> > > >  	addr = kmap_atomic(page);
> > > > -	memcpy(addr, iomap->inline_data, size);
> > > > -	memset(addr + size, 0, PAGE_SIZE - size);
> > > > +	memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
> > > > +	memset(addr + poff + size, 0, PAGE_SIZE - poff - size);
> > > 
> > > Hmm, so I guess the point of this is to support reading data from a
> > > tail-packing block, where each file gets some arbitrary byte range
> > > within the tp-block, and the range isn't aligned to an fs block?  Hence
> > > you have to use the inline data code to read the relevant bytes and copy
> > > them into the pagecache?
> > 
> > I think there are two distinct cases for IOMAP_INLINE.  One is
> > where the tail of the file is literally embedded into the inode.
> > Like ext4 fast symbolic links.  Taking the ext4 i_blocks layout
> > as an example, you could have a 4kB block stored in i_block[0]
> > and then store bytes 4096-4151 in i_block[1-14] (although reading
> > https://www.kernel.org/doc/html/latest/filesystems/ext4/dynamic.html
> > makes me think that ext4 only supports storing 0-59 in the i_blocks;
> > it doesn't support 0-4095 in i_block[0] and then 4096-4151 in i_blocks)
> > 
> > The other is what I think erofs is doing where, for example, you'd
> > specify in i_block[1] the block which contains the tail and then in
> > i_block[2] what offset of the block the tail starts at.
> 
> Nope, EROFS inline data is embedded into the inode in order to save
> I/O as well as space (maybe I didn't express clear before [1]). 
> 
> I understand the other one, but it can only save storage space but
> cannot save I/O (we still need another independent I/O to read its
> meta buffered page).
> 
> In the view of INLINE extent itself, I think both ways can be
> supported with this approach.

OH, I see, so you need the multi-page inline data support because the
ondisk layout is something like this:

+----------- page one ---------+----------- page two...
V                              V
+-------+-----------------------------+---------
| inode |   inline data               | inode...
+-------+-----------------------------+---------

And since you can only kmap one page at a time, an inline read grabs the
first part of the data in "page one" and then we have to call
iomap_begin a second time get a new address so that we can read the rest
from "page two"?

--D

> 
> [1] https://www.kernel.org/doc/html/latest/filesystems/erofs.html
>     "On-disk details" section.
> 
> Thanks,
> Gao Xiang
