Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E6518EA5F
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2020 17:28:47 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48ljcr2WC9zDqhb
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2020 03:28:44 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=DMIkZSYb; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48ljcb4fpszDqVQ
 for <linux-erofs@lists.ozlabs.org>; Mon, 23 Mar 2020 03:28:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+q5SE8PabkJ4E2ARJpyvT2voAuJ2mKWWauYSLk4KvP8=; b=DMIkZSYbAXVYZnU8ct+6eTALIM
 IIwMq32XvglVnA0tcHkjB7yxlMiata26hBz45kwB5a05tIb02c9RE5ySYhs3Ho1G+lFVSgzlzVVDc
 DUMiK8p2sT6gtwlUuoh5Nc7LPQ6R2kVmwSly/JqhfRE2B1JKygrsPQSdgxP2bs4+VdMciVAE86kHt
 faPtljJno8DX46yFjGcZZwU56Jt23D6buy8qiu9daFTCr8dE5hV5cU6dlBPdz0Fx7mooeF/M7/3E9
 cV1R/zopL7FbuerKPz2Tn81i5E79BF6SUI1praSaJFyVmD8DjvZ9DxsxJvgden2Wq6jHCv3KoNE8F
 cMFMFWAw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jG3SU-0000CF-PX; Sun, 22 Mar 2020 16:28:18 +0000
Date: Sun, 22 Mar 2020 09:28:18 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v9 12/25] mm: Move end_index check out of readahead loop
Message-ID: <20200322162818.GG4971@bombadil.infradead.org>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-13-willy@infradead.org>
 <20200320165828.GB851@sol.localdomain>
 <20200320173040.GB4971@bombadil.infradead.org>
 <20200320180017.GE851@sol.localdomain>
 <20200320181132.GD4971@bombadil.infradead.org>
 <20200320182452.GF851@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320182452.GF851@sol.localdomain>
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

On Fri, Mar 20, 2020 at 11:24:52AM -0700, Eric Biggers wrote:
> On Fri, Mar 20, 2020 at 11:11:32AM -0700, Matthew Wilcox wrote:
> > On Fri, Mar 20, 2020 at 11:00:17AM -0700, Eric Biggers wrote:
> > > But then if someone passes index=0 and nr_to_read=0, this underflows and the
> > > entire file gets read.
> > 
> > nr_to_read == 0 doesn't make sense ... I thought we filtered that out
> > earlier, but I can't find anywhere that does that right now.  I'd
> > rather return early from __do_page_cache_readahead() to fix that.
> > 
> > > The page cache isn't actually supposed to contain a page at index ULONG_MAX,
> > > since MAX_LFS_FILESIZE is at most ((loff_t)ULONG_MAX << PAGE_SHIFT), right?  So
> > > I don't think we need to worry about reading the page with index ULONG_MAX.
> > > I.e. I think it's fine to limit nr_to_read to 'ULONG_MAX - index', if that makes
> > > it easier to avoid an overflow or underflow in the next check.
> > 
> > I think we can get a page at ULONG_MAX on 32-bit systems?  I mean, we can buy
> > hard drives which are larger than 16TiB these days:
> > https://www.pcmag.com/news/seagate-will-ship-18tb-and-20tb-hard-drives-in-2020
> > (even ignoring RAID devices)
> 
> The max file size is ((loff_t)ULONG_MAX << PAGE_SHIFT) which means the maximum
> page *index* is ULONG_MAX - 1, not ULONG_MAX.

I see where we set that for _files_ ... I can't find anywhere that we prevent
i_size getting that big for block devices.  Maybe I'm missing something.

> Anyway, I think we may be making this much too complicated.  How about just:
> 
> 	pgoff_t i_nrpages = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> 
> 	if (index >= i_nrpages)
> 		return;
> 	/* Don't read past the end of the file */
> 	nr_to_read = min(nr_to_read, i_nrpages - index);
> 
> That's 2 branches instead of 4.  (Note that assigning to i_nrpages can't
> overflow, since the max number of pages is ULONG_MAX not ULONG_MAX + 1.)

I like where you're going with this.  Just to be on the safe side, I'd
prefer to do this:

@@ -266,11 +266,8 @@ void __do_page_cache_readahead(struct address_space *mapping,
        end_index = (isize - 1) >> PAGE_SHIFT;
        if (index > end_index)
                return;
-       /* Avoid wrapping to the beginning of the file */
-       if (index + nr_to_read < index)
-               nr_to_read = ULONG_MAX - index + 1;
        /* Don't read past the page containing the last byte of the file */
-       if (index + nr_to_read >= end_index)
+       if (nr_to_read > end_index - index)
                nr_to_read = end_index - index + 1;
 
        page_cache_readahead_unbounded(mapping, file, index, nr_to_read,

end_index - index + 1 could only overflow if end_index is ULONG_MAX
and index is 0.  But if end_index is ULONG_MAX and index is 0, then
nr_to_read is necessarily <= ULONG_MAX, so the condition is false.
And if nr_to_read is 0, then the condition is also false, so it won't
increase nr_to_read from 0 to 1.  It might assign x to nr_to_read when
nr_to_read is already x, but that's harmless.

Thanks!
