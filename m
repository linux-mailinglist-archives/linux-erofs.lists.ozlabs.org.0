Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC4B168BE0
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Feb 2020 02:54:51 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48PWbs086GzDqlK
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Feb 2020 12:54:49 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=okpmlLDU; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48PWbn0GrTzDqfJ
 for <linux-erofs@lists.ozlabs.org>; Sat, 22 Feb 2020 12:54:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=3z9OxyAbSn1SdH2kkHfL31c9BGogsy9OLW6r1AiETwA=; b=okpmlLDUcn2WJSLgCMGAQ/y3ea
 wUx7sYNdOzqYPRD79lRmEtjSkrPrcJfVsD9xPGx/OEj4opTESHh6CYwZzOmuJEsyumYBwdnBSPv7g
 16GkwPCUQhbT1ezTB0jognGyz8oIm6SUil1aybwZf5s5+OhrDRLxuYqnAi5mVLeaU2RxOwOxA/zNs
 KYbdl3XUppUek8iRi+5uW/I3hpcLPqxH+AmdzbPTNFg7qp4grnRwvEiCEJmAo3/C8soB6NZZdaPwo
 6XP9UHgU7AUBNbe3o0CA3AZUkjmFriX3wxHNG3GcDmgcTse+CtXbmuDxLU2MsixE0H2J7aWT8SIfZ
 PnUpa2Fw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j5K03-0000tY-FT; Sat, 22 Feb 2020 01:54:35 +0000
Date: Fri, 21 Feb 2020 17:54:35 -0800
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v7 21/24] iomap: Restructure iomap_readpages_actor
Message-ID: <20200222015435.GH24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-22-willy@infradead.org>
 <20200222004425.GG9506@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222004425.GG9506@magnolia>
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Feb 21, 2020 at 04:44:25PM -0800, Darrick J. Wong wrote:
> On Wed, Feb 19, 2020 at 01:01:00PM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > By putting the 'have we reached the end of the page' condition at the end
> > of the loop instead of the beginning, we can remove the 'submit the last
> > page' code from iomap_readpages().  Also check that iomap_readpage_actor()
> > didn't return 0, which would lead to an endless loop.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/iomap/buffered-io.c | 32 ++++++++++++++++++--------------
> >  1 file changed, 18 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index cb3511eb152a..31899e6cb0f8 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -400,15 +400,9 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
> >  		void *data, struct iomap *iomap, struct iomap *srcmap)
> >  {
> >  	struct iomap_readpage_ctx *ctx = data;
> > -	loff_t done, ret;
> > -
> > -	for (done = 0; done < length; done += ret) {
> > -		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
> > -			if (!ctx->cur_page_in_bio)
> > -				unlock_page(ctx->cur_page);
> > -			put_page(ctx->cur_page);
> > -			ctx->cur_page = NULL;
> > -		}
> > +	loff_t ret, done = 0;
> > +
> > +	while (done < length) {
> >  		if (!ctx->cur_page) {
> >  			ctx->cur_page = iomap_next_page(inode, ctx->pages,
> >  					pos, length, &done);
> > @@ -418,6 +412,20 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
> >  		}
> >  		ret = iomap_readpage_actor(inode, pos + done, length - done,
> >  				ctx, iomap, srcmap);
> > +		done += ret;
> > +
> > +		/* Keep working on a partial page */
> > +		if (ret && offset_in_page(pos + done))
> > +			continue;
> > +
> > +		if (!ctx->cur_page_in_bio)
> > +			unlock_page(ctx->cur_page);
> > +		put_page(ctx->cur_page);
> > +		ctx->cur_page = NULL;
> > +
> > +		/* Don't loop forever if we made no progress */
> > +		if (WARN_ON(!ret))
> > +			break;
> >  	}
> >  
> >  	return done;
> > @@ -451,11 +459,7 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
> >  done:
> >  	if (ctx.bio)
> >  		submit_bio(ctx.bio);
> > -	if (ctx.cur_page) {
> > -		if (!ctx.cur_page_in_bio)
> > -			unlock_page(ctx.cur_page);
> > -		put_page(ctx.cur_page);
> > -	}
> > +	BUG_ON(ctx.cur_page);
> 
> Whoah, is the system totally unrecoverably hosed at this point?
> 
> I get that this /shouldn't/ happen, but should we somehow end up with a
> page here, are we unable either to release it or even just leak it?  I'd
> have thought a WARN_ON would be just fine here.

If we do find a page here, we don't actually know what to do with it.
It might be (currently) locked, it might have the wrong refcount.
Whatever is going on, it's probably better that we stop everything right
here rather than allow things to go further and possibly present bad
data to the application.  I mean, we could even be leaking the previous
contents of this page to userspace.  Or maybe the future contents of a
page which shouldn't be in the page cache any more, but userspace gets
a mapping to it.

I'm not enthusiastic about putting in some code here to try to handle
a "can't happen" case, since it's never going to be tested, and might
end up causing more problems than it tries to solve.  Let's just stop.
