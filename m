Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6A63D3D02
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jul 2021 17:57:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GWYqB6x5fz30H4
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 01:57:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Wxnyx+dw;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=Wxnyx+dw; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GWYq81KCgz30BL
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Jul 2021 01:57:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ovsyxI38eNvliEW3ps0I8aR1LXX7PaOVRwl/PkPRFDM=; b=Wxnyx+dw5dcaJEYk7A89PoveYG
 dA8Nw8DvgO2pjZqcy/y8tpZrV64svCyzBmRc/Gy4epobh41YlOfrukZvPFMZKaDuDgRSixj+x74+8
 00UAFBs1Z0nkdxFm5I1rUKVQOJnBb1GiIOIfe3rk7YOPWjLbhOLitR++IQOvGval1ceVQ8xMAOmD1
 vxEh5cCcxzU+c54cdxTVTtzz4Fz7zl1OwsM6MalIKvBJLh5nwtMzF3gueE10t+emldzVdMmHfpw6B
 QLyWdJV9mA0XiEtVWlpW3Y/3s1Z2rbjwDR1ZybmhJIHGnQ5ECIM/neeB7i0/iUlddaXiE1S+SHxbE
 rtiZ4Uyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m6xXP-00BVcv-W7; Fri, 23 Jul 2021 15:56:43 +0000
Date: Fri, 23 Jul 2021 16:56:35 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v6] iomap: support tail packing inline read
Message-ID: <YPrms0fWPwEZGNAL@casper.infradead.org>
References: <20210722031729.51628-1-hsiangkao@linux.alibaba.com>
 <20210722053947.GA28594@lst.de>
 <YPrauRjG7+vCw7f9@casper.infradead.org>
 <YPre+j906ywgRHEZ@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPre+j906ywgRHEZ@B-P7TQMD6M-0146.local>
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

On Fri, Jul 23, 2021 at 11:23:38PM +0800, Gao Xiang wrote:
> Hi Matthew,
> 
> On Fri, Jul 23, 2021 at 04:05:29PM +0100, Matthew Wilcox wrote:
> > On Thu, Jul 22, 2021 at 07:39:47AM +0200, Christoph Hellwig wrote:
> > > @@ -675,7 +676,7 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
> > >  
> > >  	flush_dcache_page(page);
> > >  	addr = kmap_atomic(page);
> > > -	memcpy(iomap->inline_data + pos, addr + pos, copied);
> > > +	memcpy(iomap_inline_buf(iomap, pos), addr + pos, copied);
> > 
> > This is wrong; pos can be > PAGE_SIZE, so this needs to be
> > addr + offset_in_page(pos).
> 
> Yeah, thanks for pointing out. It seems so, since EROFS cannot test
> such write path, previously it was disabled explicitly. I could
> update it in the next version as above.

We're also missing a call to __set_page_dirty_nobuffers().  This
matters to nobody right now -- erofs is read-only and gfs2 only
supports inline data in the inode.  I presume what is happening
for gfs2 is that at inode writeback time, it copies the ~60 bytes
from the page cache into the inode and then schedules the inode
for writeback.

But logically, we should mark the page as dirty.  It'll be marked
as dirty by ->mkwrite, should the page be mmaped, so gfs2 must
already cope with a dirty page for inline data.
