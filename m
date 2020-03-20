Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id DD71318D6D9
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2020 19:25:04 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48kXHy0nWvzDrRY
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2020 05:25:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=w2Kwf2qr; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48kXHs1Lg2zDrJ7
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2020 05:24:56 +1100 (AEDT)
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E406F20767;
 Fri, 20 Mar 2020 18:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584728694;
 bh=iXk1jLxqgPXgnR9ja2pvER1tlxPb7y75DLTL+2ZEEvs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=w2Kwf2qrgq9mF3e+Y3DstRvcRM3IPcP1rBsX2IFVwGk7IR9XNsgwueVzsL3c0gBZe
 +MuPXs0V8pB0UpnbySniOTBsbDmUlJD9DiQwI2PQqZKV0rdBr17ai4ecQWWo63ilaO
 umg5VrnjKfVftfBjPZrbhNTs/LLm4csl2Am6T0gA=
Date: Fri, 20 Mar 2020 11:24:52 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v9 12/25] mm: Move end_index check out of readahead loop
Message-ID: <20200320182452.GF851@sol.localdomain>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-13-willy@infradead.org>
 <20200320165828.GB851@sol.localdomain>
 <20200320173040.GB4971@bombadil.infradead.org>
 <20200320180017.GE851@sol.localdomain>
 <20200320181132.GD4971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320181132.GD4971@bombadil.infradead.org>
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

On Fri, Mar 20, 2020 at 11:11:32AM -0700, Matthew Wilcox wrote:
> On Fri, Mar 20, 2020 at 11:00:17AM -0700, Eric Biggers wrote:
> > On Fri, Mar 20, 2020 at 10:30:40AM -0700, Matthew Wilcox wrote:
> > > On Fri, Mar 20, 2020 at 09:58:28AM -0700, Eric Biggers wrote:
> > > > On Fri, Mar 20, 2020 at 07:22:18AM -0700, Matthew Wilcox wrote:
> > > > > +	/* Avoid wrapping to the beginning of the file */
> > > > > +	if (index + nr_to_read < index)
> > > > > +		nr_to_read = ULONG_MAX - index + 1;
> > > > > +	/* Don't read past the page containing the last byte of the file */
> > > > > +	if (index + nr_to_read >= end_index)
> > > > > +		nr_to_read = end_index - index + 1;
> > > > 
> > > > There seem to be a couple off-by-one errors here.  Shouldn't it be:
> > > > 
> > > > 	/* Avoid wrapping to the beginning of the file */
> > > > 	if (index + nr_to_read < index)
> > > > 		nr_to_read = ULONG_MAX - index;
> > > 
> > > I think it's right.  Imagine that index is ULONG_MAX.  We should read one
> > > page (the one at ULONG_MAX).  That would be ULONG_MAX - ULONG_MAX + 1.
> > > 
> > > > 	/* Don't read past the page containing the last byte of the file */
> > > > 	if (index + nr_to_read > end_index)
> > > > 		nr_to_read = end_index - index + 1;
> > > > 
> > > > I.e., 'ULONG_MAX - index' rather than 'ULONG_MAX - index + 1', so that
> > > > 'index + nr_to_read' is then ULONG_MAX rather than overflowed to 0.
> > > > 
> > > > Then 'index + nr_to_read > end_index' rather 'index + nr_to_read >= end_index',
> > > > since otherwise nr_to_read can be increased by 1 rather than decreased or stay
> > > > the same as expected.
> > > 
> > > Ooh, I missed the overflow case here.  It should be:
> > > 
> > > +	if (index + nr_to_read - 1 > end_index)
> > > +		nr_to_read = end_index - index + 1;
> > > 
> > 
> > But then if someone passes index=0 and nr_to_read=0, this underflows and the
> > entire file gets read.
> 
> nr_to_read == 0 doesn't make sense ... I thought we filtered that out
> earlier, but I can't find anywhere that does that right now.  I'd
> rather return early from __do_page_cache_readahead() to fix that.
> 
> > The page cache isn't actually supposed to contain a page at index ULONG_MAX,
> > since MAX_LFS_FILESIZE is at most ((loff_t)ULONG_MAX << PAGE_SHIFT), right?  So
> > I don't think we need to worry about reading the page with index ULONG_MAX.
> > I.e. I think it's fine to limit nr_to_read to 'ULONG_MAX - index', if that makes
> > it easier to avoid an overflow or underflow in the next check.
> 
> I think we can get a page at ULONG_MAX on 32-bit systems?  I mean, we can buy
> hard drives which are larger than 16TiB these days:
> https://www.pcmag.com/news/seagate-will-ship-18tb-and-20tb-hard-drives-in-2020
> (even ignoring RAID devices)

The max file size is ((loff_t)ULONG_MAX << PAGE_SHIFT) which means the maximum
page *index* is ULONG_MAX - 1, not ULONG_MAX.

Anyway, I think we may be making this much too complicated.  How about just:

	pgoff_t i_nrpages = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);

	if (index >= i_nrpages)
		return;
	/* Don't read past the end of the file */
	nr_to_read = min(nr_to_read, i_nrpages - index);

That's 2 branches instead of 4.  (Note that assigning to i_nrpages can't
overflow, since the max number of pages is ULONG_MAX not ULONG_MAX + 1.)

- Eric
