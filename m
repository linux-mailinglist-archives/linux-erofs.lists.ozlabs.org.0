Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D1B660FCB
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Jan 2023 16:07:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nq3TY0PyTz3c72
	for <lists+linux-erofs@lfdr.de>; Sun,  8 Jan 2023 02:07:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=jMzef1yL;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nq3TK35p1z3bf7
	for <linux-erofs@lists.ozlabs.org>; Sun,  8 Jan 2023 02:06:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FSFM4yR4blaFSxBzfnWN4hnvh0AQgFE6Wy1RI039p5g=; b=jMzef1yLFSyGPSDvT0zTsJnJLd
	jVFKm63WTul1j9a2Hixsj029wDInokmlFGWT0TUL4M6pxQJQELy5UHFflzNSXG4BQejzDN/DM8CfU
	JAGbwFHAr3VVnjFLBqM51AwLMSZPZOiup1A2i2YYOnmsvC5JpJYhHYEFn/bgaIigNxXwgmMhowtMO
	cKK4m2y7lDCYmZW5V55/9UZg+8eHRTTSkq4lPD7dVYjotH0nmZZDQCcHoYsIW+taaamRAIH/z3Rz0
	dw5IuX/yZZPQAmSfFWpEoS+RnfURgU1PHQ1mOOY8hUdreXoSf7vnD6npmHxNgF0f7Gz36dhMMwTKP
	v01R9DGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEAly-000dbw-DB; Sat, 07 Jan 2023 15:06:14 +0000
Date: Sat, 7 Jan 2023 15:06:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 3/3] mm: Make filemap_release_folio() better inform
 shrink_folio_list()
Message-ID: <Y7mKZj/RnD2aW5jU@casper.infradead.org>
References: <167172131368.2334525.8569808925687731937.stgit@warthog.procyon.org.uk>
 <167172134962.2334525.570622889806603086.stgit@warthog.procyon.org.uk>
 <Y6XJwvjKyTgRIiI3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6XJwvjKyTgRIiI3@infradead.org>
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
Cc: Shyam Prasad N <nspmangalore@gmail.com>, Steve French <sfrench@samba.org>, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>, Dave Wysochanski <dwysocha@redhat.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-cachefs@redhat.com, linux-ext4@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, Ilya Dryomov <idryomov@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Dominique Martinet <asmadeus@codewreck.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Dec 23, 2022 at 07:31:14AM -0800, Christoph Hellwig wrote:
> On Thu, Dec 22, 2022 at 03:02:29PM +0000, David Howells wrote:
> > Make filemap_release_folio() return one of three values:
> > 
> >  (0) FILEMAP_CANT_RELEASE_FOLIO
> > 
> >      Couldn't release the folio's private data, so the folio can't itself
> >      be released.
> > 
> >  (1) FILEMAP_RELEASED_FOLIO
> > 
> >      The private data on the folio was released and the folio can be
> >      released.
> > 
> >  (2) FILEMAP_FOLIO_HAD_NO_PRIVATE
> 
> These names read really odd, due to the different placementments
> of FOLIO, the present vs past tense and the fact that 2 also released
> the folio, and the reliance of callers that one value of an enum
> must be 0, while no unprecedented, is a bit ugly.

Agreed.  The thing is that it's not the filemap that's being released,
it's the folio.  So these should be:

	FOLIO_RELEASE_SUCCESS
	FOLIO_RELEASE_FAILED
	FOLIO_RELEASE_NO_PRIVATE

... but of course, NO_PRIVATE is also a success.  So it's a really weird
thing to be reporting.  I'm with you on the latter half of this email:

> But do we even need them?  What abut just open coding
> filemap_release_folio (which is a mostly trivial function) in
> shrink_folio_list, which is the only place that cares?
> 
> 	if (folio_has_private(folio) && folio_needs_release(folio)) {
> 		if (folio_test_writeback(folio))
> 			goto activate_locked;
> 
> 		if (mapping && mapping->a_ops->release_folio) {
> 			if (!mapping->a_ops->release_folio(folio, gfp))
> 				goto activate_locked;
> 		} else {
> 			if (!try_to_free_buffers(folio))
> 				goto activate_locked;
> 		}
> 
> 		if (!mapping && folio_ref_count(folio) == 1) {
> 			...
> 
> alternatively just keep using filemap_release_folio and just add the
> folio_needs_release in the first branch.  That duplicates the test,
> but makes the change a one-liner.

Or just drop patch 3 entirely?
