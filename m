Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006623CB8FD
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jul 2021 16:45:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GRDYN42cYz304V
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Jul 2021 00:45:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=emAymVMz;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=emAymVMz; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GRDYL0sp1z2yXJ
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Jul 2021 00:45:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=lPJ4scFs3yvXxESCFVBF78XiNiFyNppuXI+phYKQryQ=; b=emAymVMzXtKIMdSrzivMRA7Dum
 UM6z0WnkT1pJUkEy6EcXBioyjRVteMFYAd3UNB1nnRqj62tDlD7sSBHTBqya45BuH1/HHdLhqJR4U
 bxuIX0rMTmv4ipy24LbHu7DVPO8ba4GQX8OD32XKRYUElitXIzW+hfrHJ4Yjr48dZ0XCT+Mm4JRum
 0lwXjANsIH31x4hySUKDvisR0EqmgLEODjtw74J2hze0vzAaNJ6MAEWhG0a4PWSYadGu6BRObmodz
 pWN3VjHNlN+jz+ud6++f9pau0chJebRBfPcT1uPm7dtazLWahEq8e4EKVAK0nkDFryAVajGU65wQj
 yQW2HHew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m4P4O-004YbU-2a; Fri, 16 Jul 2021 14:44:11 +0000
Date: Fri, 16 Jul 2021 15:44:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Chao Yu <chao@kernel.org>,
 Liu Bo <bo.liu@linux.alibaba.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPGbNCdCNXIpNdqd@casper.infradead.org>
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
 <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
 <YPGDZYT9OxdgNYf2@casper.infradead.org>
 <YPGQB3zT4Wp4Q38X@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPGQB3zT4Wp4Q38X@B-P7TQMD6M-0146.local>
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

On Fri, Jul 16, 2021 at 09:56:23PM +0800, Gao Xiang wrote:
> Hi Matthew,
> 
> On Fri, Jul 16, 2021 at 02:02:29PM +0100, Matthew Wilcox wrote:
> > On Fri, Jul 16, 2021 at 01:07:23PM +0800, Gao Xiang wrote:
> > > This tries to add tail packing inline read to iomap. Different from
> > > the previous approach, it only marks the block range uptodate in the
> > > page it covers.
> > 
> > Why?  This path is called under two circumstances: readahead and readpage.
> > In both cases, we're trying to bring the entire page uptodate.  The inline
> > extent is always the tail of the file, so we may as well zero the part of
> > the page past the end of file and mark the entire page uptodate instead
> > and leaving the end of the page !uptodate.
> > 
> > I see the case where, eg, we have the first 2048 bytes of the file
> > out-of-inode and then 20 bytes in the inode.  So we'll create the iop
> > for the head of the file, but then we may as well finish the entire
> > PAGE_SIZE chunk as part of this iteration rather than update 2048-3071
> > as being uptodate and leave the 3072-4095 block for a future iteration.
> 
> Thanks for your comments. Hmm... If I understand the words above correctly,
> what I'd like to do is to cover the inline extents (blocks) only
> reported by iomap_begin() rather than handling other (maybe)
> logical-not-strictly-relevant areas such as post-EOF (even pages
> will be finally entirely uptodated), I think such zeroed area should
> be handled by from the point of view of the extent itself
> 
>          if (iomap_block_needs_zeroing(inode, iomap, pos)) {
>                  zero_user(page, poff, plen);
>                  iomap_set_range_uptodate(page, poff, plen);
>                  goto done;
>          }

That does work.  But we already mapped the page to write to it, and
we already have to zero to the end of the block.  Why not zero to
the end of the page?  It saves an iteration around the loop, it saves
a mapping of the page, and it saves a call to flush_dcache_page().

> The benefits I can think out are 1) it makes the logic understand
> easier and no special cases just for tail-packing handling 2) it can
> be then used for any inline extent cases (I mean e.g. in the middle of
> the file) rather than just tail-packing inline blocks although currently
> there is a BUG_ON to prevent this but it's easier to extend even further.
> 3) it can be used as a part for later partial page uptodate logic in
> order to match the legacy buffer_head logic (I remember something if my
> memory is not broken about this...)

Hopefully the legacy buffer_head logic will go away soon.
