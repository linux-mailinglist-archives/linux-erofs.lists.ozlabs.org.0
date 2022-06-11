Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE5A5474AA
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 14:56:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LKyWs40KBz3c1g
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 22:56:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=F6iHrQPj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2607:5300:60:148a::1; helo=zeniv-ca.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=F6iHrQPj;
	dkim-atps=neutral
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LKyWn4SH0z3blH
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 22:56:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7ECfJmBbWYtsqTXzwSBapwigRDimRB+yDzUlyko8m0Q=; b=F6iHrQPjuQ0xyu1RiBQyyxM9F8
	TcajGIhz0LksFuaovI+QcylO9H9gAsrApJ84iWn5V87n5JeGUxnBgj5FeafaDSF2JmGXalnMLBsFd
	oM8+Vr1ym3K1cHkHVWZvfvSsg2mJAOaMZvY9PEpsAMBIy+qdF+XWvxaL59M65mOXijYkVKD4DDlqH
	RTHSBf4LnWGrpJxxoz9XGy6BrJthRT6bsBsM5eA5DEFgt+FtLuieMpIjasRz4AlRLrL7lbv3gblnB
	clfzSQFsuxXr91IrsOwX1z2kbaUi1nJ+q1N/tedWPrQ7d3Wy0egh1nQmatU4Xp6cBdtQsCDk9nltB
	NYkWpItA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o00fD-0066DC-RO; Sat, 11 Jun 2022 12:56:27 +0000
Date: Sat, 11 Jun 2022 12:56:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: mainline build failure due to 6c77676645ad ("iov_iter: Fix
 iter_xarray_get_pages{,_alloc}()")
Message-ID: <YqSQ++8UnEW0AJ2y@zeniv-ca.linux.org.uk>
References: <YqRyL2sIqQNDfky2@debian>
 <YqSGv6uaZzLxKfmG@zeniv-ca.linux.org.uk>
 <YqSMmC/UuQpXdxtR@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqSMmC/UuQpXdxtR@zeniv-ca.linux.org.uk>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, devel@lists.orangefs.org, Mike Marshall <hubcap@omnibond.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jun 11, 2022 at 12:37:44PM +0000, Al Viro wrote:
> On Sat, Jun 11, 2022 at 12:12:47PM +0000, Al Viro wrote:
> 
> 
> > At a guess, should be
> > 	return min((size_t)nr * PAGE_SIZE - offset, maxsize);
> > 
> > in both places.  I'm more than half-asleep right now; could you verify that it
> > (as the last lines of both iter_xarray_get_pages() and iter_xarray_get_pages_alloc())
> > builds correctly?
> 
> No, I'm misreading it - it's unsigned * unsigned long - unsigned vs. size_t.
> On arm it ends up with unsigned long vs. unsigned int; functionally it *is*
> OK (both have the same range there), but it triggers the tests.  Try 
> 
> 	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
> 
> there (both places).

The reason we can't overflow on multiplication there, BTW, is that we have
nr <= count, and count has come from weirdly open-coded
	DIV_ROUND_UP(size + offset, PAGE_SIZE)
IMO we'd better make it explicit, so how about the following:

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index dda6d5f481c1..150dbd314d25 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1445,15 +1445,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	offset = pos & ~PAGE_MASK;
 	*_start_offset = offset;
 
-	count = 1;
-	if (size > PAGE_SIZE - offset) {
-		size -= PAGE_SIZE - offset;
-		count += size >> PAGE_SHIFT;
-		size &= ~PAGE_MASK;
-		if (size)
-			count++;
-	}
-
+	count = DIV_ROUND_UP(size + offset, PAGE_SIZE);
 	if (count > maxpages)
 		count = maxpages;
 
@@ -1461,7 +1453,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	if (nr == 0)
 		return 0;
 
-	return min(nr * PAGE_SIZE - offset, maxsize);
+	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
 }
 
 /* must be done on non-empty ITER_IOVEC one */
@@ -1607,15 +1599,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
 	offset = pos & ~PAGE_MASK;
 	*_start_offset = offset;
 
-	count = 1;
-	if (size > PAGE_SIZE - offset) {
-		size -= PAGE_SIZE - offset;
-		count += size >> PAGE_SHIFT;
-		size &= ~PAGE_MASK;
-		if (size)
-			count++;
-	}
-
+	count = DIV_ROUND_UP(size + offset, PAGE_SIZE);
 	p = get_pages_array(count);
 	if (!p)
 		return -ENOMEM;
@@ -1625,7 +1609,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
 	if (nr == 0)
 		return 0;
 
-	return min(nr * PAGE_SIZE - offset, maxsize);
+	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
 }
 
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
