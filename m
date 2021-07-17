Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723823CC58B
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Jul 2021 20:41:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GRxlX4kLhz2yyK
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Jul 2021 04:41:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=I2b1oobD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=I2b1oobD; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GRxlN0mhGz2yhf
 for <linux-erofs@lists.ozlabs.org>; Sun, 18 Jul 2021 04:41:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=34IDPVr1FFgLa52/AyVJqWmL3gtZnKkbcxspv1mGiNc=; b=I2b1oobDIa9kR66Da+BrMpc96u
 8qwvH+/Bzx9JFf2cZXlzgwO7lopBcV9cvwWLWo4tPAqfskgTbVnSxk969GtFfdRsVJ10jxWvYMeJr
 /AhW3bBHX7rLl2SYQUpz0r+F2Rk1fLECQDEM2pNTGB1k71nHkvq+/5vOcAcHox4oWj7R2EJ59nW5u
 SfA5gk4IUeM+gdGAjSZQoqs0v59/FTotmz5e+1zjNzsJ6pUhe/mR7E4Cuyw0uRPs8yW08QM3JFwzx
 L4HRbGanuBnmEvb6furh2pwZJKqeKHmLMJ07Y+ZsF8rdre0OKZfyVYjzs8h/nGf2qgrJ0plAsOT/0
 Djc9zL5A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m4pEv-005Tso-4z; Sat, 17 Jul 2021 18:40:49 +0000
Date: Sat, 17 Jul 2021 19:40:41 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andreas =?iso-8859-1?Q?Gr=FCnbacher?= <andreas.gruenbacher@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, linux-erofs@lists.ozlabs.org,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Chao Yu <chao@kernel.org>,
 Liu Bo <bo.liu@linux.alibaba.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPMkKfegS+9KzEhK@casper.infradead.org>
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
 <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
 <YPGDZYT9OxdgNYf2@casper.infradead.org>
 <YPGQB3zT4Wp4Q38X@B-P7TQMD6M-0146.local>
 <YPGbNCdCNXIpNdqd@casper.infradead.org>
 <YPGfqLcSiH3/z2RT@B-P7TQMD6M-0146.local>
 <CAHpGcMJzEiJUbD=7ZOdH7NF+gq9MuEi8=ym34ay7QAm5_91s7g@mail.gmail.com>
 <YPLdSja/4FBsjss/@B-P7TQMD6M-0146.local>
 <YPLw0uc1jVKI8uKo@casper.infradead.org>
 <YPL0LqHzEbUY4zY/@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPL0LqHzEbUY4zY/@B-P7TQMD6M-0146.local>
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

On Sat, Jul 17, 2021 at 11:15:58PM +0800, Gao Xiang wrote:
> Hi Matthew,
> 
> On Sat, Jul 17, 2021 at 04:01:38PM +0100, Matthew Wilcox wrote:
> > On Sat, Jul 17, 2021 at 09:38:18PM +0800, Gao Xiang wrote:
> > > Sorry about some late. I've revised a version based on Christoph's
> > > version and Matthew's thought above. I've preliminary checked with
> > > EROFS, if it does make sense, please kindly help check on the gfs2
> > > side as well..
> > 
> > I don't understand how this bit works:
> 
> This part inherited from the Christoph version without change.
> The following thoughts are just my own understanding...
> 
> > 
> > >  	struct page *page = ctx->cur_page;
> > > -	struct iomap_page *iop;
> > > +	struct iomap_page *iop = NULL;
> > >  	bool same_page = false, is_contig = false;
> > >  	loff_t orig_pos = pos;
> > >  	unsigned poff, plen;
> > >  	sector_t sector;
> > >  
> > > -	if (iomap->type == IOMAP_INLINE) {
> > > -		WARN_ON_ONCE(pos);
> > > -		iomap_read_inline_data(inode, page, iomap);
> > > -		return PAGE_SIZE;
> > > -	}
> > > +	if (iomap->type == IOMAP_INLINE && !pos)
> > > +		WARN_ON_ONCE(to_iomap_page(page) != NULL);
> > > +	else
> > > +		iop = iomap_page_create(inode, page);
> > 
> > Imagine you have a file with bytes 0-2047 in an extent which is !INLINE
> > and bytes 2048-2051 in the INLINE extent.  When you read the page, first
> > you create an iop for the !INLINE extent.  Then this function is called
> 
> Yes, it first created an iop for the !INLINE extent.
> 
> > again for the INLINE extent and you'll hit the WARN_ON_ONCE.  No?
> 
> If it is called again with another INLINE extent, pos will be non-0?
> so (!pos) == false. Am I missing something?

Well, either sense of a WARN_ON is wrong.

For a file which is PAGE_SIZE + 3 bytes in size, to_iomap_page() will
be NULL.  For a file which is PAGE_SIZE/2 + 3 bytes in size,
to_iomap_page() will not be NULL.  (assuming the block size is <=
PAGE_SIZE / 2).

I think we need a prep patch that looks something like this:

+++ b/fs/iomap/buffered-io.c
@@ -252,8 +252,12 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
                return PAGE_SIZE;
        }

+       if (offset_in_page(pos) || length < PAGE_SIZE)
+               iop = iomap_page_create(inode, page);
+       else
+               iop = NULL;
+
        /* zero post-eof blocks as the page may be mapped */
-       iop = iomap_page_create(inode, page);
        iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
        if (plen == 0)
                goto done;


ie first get the conditions right under which we should create an iop.
