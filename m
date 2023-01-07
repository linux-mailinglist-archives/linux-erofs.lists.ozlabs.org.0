Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DD24D660FD8
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Jan 2023 16:12:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nq3b75L9Nz3c72
	for <lists+linux-erofs@lfdr.de>; Sun,  8 Jan 2023 02:12:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZNxGrxfY;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZNxGrxfY;
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nq3b444LZz3bTs
	for <linux-erofs@lists.ozlabs.org>; Sun,  8 Jan 2023 02:12:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cq3Tcm7OLVA1me+kKR9zka8dfFlwNGfvdQ54sCCOFy0=; b=ZNxGrxfYZ18g+iYGTFB+S1ko54
	lj1sxWXhAn78Z3mSPVR2VNhutJKCAxFaz7EvlYN14xY1q6+NBT5BmqFVf/nJJRXx3rkyJLyzNsotg
	p2AncToaCGxm00OtMsKBilhhcwdZaLAT92+SGg+aiYltEWGvShClAy8z/ZR/bi7VI7vE5J+bt26Am
	gl2QLP2YD9kfgP/iz1ffl1HiLzGCokiMepgI+S3Woob+xpPYF/t/jYpqc9CydIc1SEn5K9QJfINJB
	3kqKLKrmueMObbikddZ9gvcsiGZattD6U4HvI2cIcSbuPAQJI15Mvcrjjs0mZKc3oACChoxW3lSC/
	5B9rSMTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEArM-000dly-Pt; Sat, 07 Jan 2023 15:11:48 +0000
Date: Sat, 7 Jan 2023 15:11:48 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v5 1/3] mm: Merge
 folio_has_private()/filemap_release_folio() call pairs
Message-ID: <Y7mLtPpRz8boODVX@casper.infradead.org>
References: <167172131368.2334525.8569808925687731937.stgit@warthog.procyon.org.uk>
 <167172132272.2334525.13617516784050484518.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167172132272.2334525.13617516784050484518.stgit@warthog.procyon.org.uk>
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Andreas Dilger <adilger.kernel@dilger.ca>, linux-afs@lists.infradead.org, Shyam Prasad N <nspmangalore@gmail.com>, linux-cifs@vger.kernel.org, linux-cachefs@redhat.com, v9fs-developer@lists.sourceforge.net, Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Rohith Surabattula <rohiths.msft@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Dave Wysochanski <dwysocha@redhat.com>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, linux-ext4@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Dec 22, 2022 at 03:02:02PM +0000, David Howells wrote:
> Make filemap_release_folio() check folio_has_private().  Then, in most
> cases, where a call to folio_has_private() is immediately followed by a
> call to filemap_release_folio(), we can get rid of the test in the pair.
> 
> The same is done to page_has_private()/try_to_release_page() call pairs.

This line is now obsolete.

> There are a couple of sites in mm/vscan.c that this can't so easily be
> done.  In shrink_folio_list(), there are actually three cases (something
> different is done for incompletely invalidated buffers), but
> filemap_release_folio() elides two of them.
> 
> In shrink_active_list(), we don't have have the folio lock yet, so the
> check allows us to avoid locking the page unnecessarily.
> 
> A wrapper function to check if a folio needs release is provided for those
> places that still need to do it in the mm/ directory.  This will acquire
> additional parts to the condition in a future patch.
> 
> After this, the only remaining caller of folio_has_private() outside of mm/
> is a check in fuse.

But there are a few remaining places which check page_has_private().
I think they're all wrong and should be PagePrivate(), but I'll look
at them more next week.

