Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B8D3CDB3E
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jul 2021 17:23:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GT5Fp0Lxkz30Fs
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jul 2021 01:23:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
X-Greylist: delayed 583 seconds by postgrey-1.36 at boromir;
 Tue, 20 Jul 2021 01:23:04 AEST
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GT5Fh0Jr1z2xKP
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jul 2021 01:23:03 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1206568BFE; Mon, 19 Jul 2021 17:13:12 +0200 (CEST)
Date: Mon, 19 Jul 2021 17:13:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] iomap: support tail packing inline read
Message-ID: <20210719151310.GA22355@lst.de>
References: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
 <YPWUBhxhoaEp8Frn@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPWUBhxhoaEp8Frn@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: "Darrick J . Wong" <djwong@kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 19, 2021 at 04:02:30PM +0100, Matthew Wilcox wrote:
> > +	if (iomap->type == IOMAP_INLINE) {
> > +		iomap_read_inline_data(inode, page, iomap, pos);
> > +		plen = PAGE_SIZE - poff;
> > +		goto done;
> > +	}
> 
> This is going to break Andreas' case that he just patched to work.
> GFS2 needs for there to _not_ be an iop for inline data.  That's
> why I said we need to sort out when to create an iop before moving
> the IOMAP_INLINE case below the creation of the iop.
> 
> If we're not going to do that first, then I recommend leaving the
> IOMAP_INLINE case where it is and changing it to ...
> 
> 	if (iomap->type == IOMAP_INLINE)
> 		return iomap_read_inline_data(inode, page, iomap, pos);
> 
> ... and have iomap_read_inline_data() return the number of bytes that
> it copied + zeroed (ie PAGE_SIZE - poff).

Returning the bytes is much cleaner anyway.  But we still need to deal
with the sub-page uptodate status in one form or another.
