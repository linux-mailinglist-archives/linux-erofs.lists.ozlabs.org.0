Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF5C54762F
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 17:39:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LL2814zZ1z3c7l
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Jun 2022 01:39:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=eHg0+OU8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2607:5300:60:148a::1; helo=zeniv-ca.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=eHg0+OU8;
	dkim-atps=neutral
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LL27z0R4Jz3btt
	for <linux-erofs@lists.ozlabs.org>; Sun, 12 Jun 2022 01:39:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ti+2AANXX2O8MAB4FF8D2MuTxZeEKRqkYWjOlelpBa8=; b=eHg0+OU8W/nrYlQJlJYgZ9OA5O
	JqazKQBmjlFvunvi9gzljs37rl2Oa5VtTvtmDVbS87YWv6HXm7B+Jvx9k+QuOMrOR+Ul/iTf93iyr
	xjKbyuWKIGwwWFyw5KZVNlW1gMrGEhXyht4WhHci+l4Nin/S1FRCdv3kMmFFgjLRJtkbP4gPVsQRZ
	Zj/CRNvjQ2HyJjevRDmaB0CIEzb3wn4VsNmJwhfkqGiMiM1ldx1Bq+v0U/TEjXYPt8jdPOpMk4n1c
	vQEERdRFkMfu8I1VH64q2IwRqYEq+vZnRz1AwE6zjsVJgHmnjFgXctZpbaETDntZ18RWNYE+Tn3ii
	VbxTN1BQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o03Cw-0069LO-Mm; Sat, 11 Jun 2022 15:39:26 +0000
Date: Sat, 11 Jun 2022 15:39:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: mainline build failure due to 6c77676645ad ("iov_iter: Fix
 iter_xarray_get_pages{,_alloc}()")
Message-ID: <YqS3LqioLdSYIWgS@zeniv-ca.linux.org.uk>
References: <YqRyL2sIqQNDfky2@debian>
 <YqSGv6uaZzLxKfmG@zeniv-ca.linux.org.uk>
 <YqSMmC/UuQpXdxtR@zeniv-ca.linux.org.uk>
 <YqSQ++8UnEW0AJ2y@zeniv-ca.linux.org.uk>
 <20220611140052.GA288528@roeck-us.net>
 <YqSuPPM0rNQaRwlm@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqSuPPM0rNQaRwlm@zeniv-ca.linux.org.uk>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, devel@lists.orangefs.org, Mike Marshall <hubcap@omnibond.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jun 11, 2022 at 03:01:16PM +0000, Al Viro wrote:
> On Sat, Jun 11, 2022 at 07:00:52AM -0700, Guenter Roeck wrote:
> > On Sat, Jun 11, 2022 at 12:56:27PM +0000, Al Viro wrote:
> > > On Sat, Jun 11, 2022 at 12:37:44PM +0000, Al Viro wrote:
> > > > On Sat, Jun 11, 2022 at 12:12:47PM +0000, Al Viro wrote:
> > > > 
> > > > 
> > > > > At a guess, should be
> > > > > 	return min((size_t)nr * PAGE_SIZE - offset, maxsize);
> > > > > 
> > > > > in both places.  I'm more than half-asleep right now; could you verify that it
> > > > > (as the last lines of both iter_xarray_get_pages() and iter_xarray_get_pages_alloc())
> > > > > builds correctly?
> > > > 
> > > > No, I'm misreading it - it's unsigned * unsigned long - unsigned vs. size_t.
> > > > On arm it ends up with unsigned long vs. unsigned int; functionally it *is*
> > > > OK (both have the same range there), but it triggers the tests.  Try 
> > > > 
> > > > 	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
> > > > 
> > > > there (both places).
> > > 
> > > The reason we can't overflow on multiplication there, BTW, is that we have
> > > nr <= count, and count has come from weirdly open-coded
> > > 	DIV_ROUND_UP(size + offset, PAGE_SIZE)
> > 
> > That is often done to avoid possible overflows. Is size + offset
> > guaranteed to be smaller than ULONG_MAX ?
> 
> You'd need iter->count and maxsize argument to be within PAGE_SIZE of
> ULONG_MAX.  How would you populate that xarray, anyway?

	FWIW, it probably would be a good idea to truncate maxsize to LONG_MAX
in iov_iter_get_pages()/iov_iter_get_pages_alloc(), just to avoid that kind
of crap in the future.  Check that maxpages is not zero on the top level,
while we are at it...

	Any caller of iov_iter_get_pages{,_alloc}() must be ready to handle
getting less than what they'd asked for - if nothing else, get_user_pages_fast()
might refuse to give you more than this many pages, etc.  All in-tree callers
do, AFAICS.  And if anyone comes with "pin me more than LONG_MAX bytes of RAM
in one call, I can't accept anything less than that", well...  ISO9000-compliant
response per Dilbert would be called for.
