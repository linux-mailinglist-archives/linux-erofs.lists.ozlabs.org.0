Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ABC547494
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 14:37:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LKy6F2LrRz3bks
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 22:37:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=sSxz2SDH;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2607:5300:60:148a::1; helo=zeniv-ca.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=sSxz2SDH;
	dkim-atps=neutral
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LKy696DtTz3bdY
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 22:37:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SBb05lsgd+OOO2FAPABsHHQaP96X8u5Au9bw5c2kfU4=; b=sSxz2SDHX74tI+Mh9uDjx3JBjg
	w3M60laG/7hD1NiTZNVfdfPuo8p/SykNo8lqbTv5uGDaFkO3ewl0sgcDlNAKK/p0o3SOsRxZD+IrE
	cMycJ9Xhpv/ja36hHX2jBp3TCQZarjEWFVG/BpJxm7T0W79NVhBFLRLzBcyn5nVH9KgbsB7TG+FIn
	INxBFAgn08urU27wENZJuOmqUTmdXIC99VaA6g0D3qEU6lOjwksGiTP9dwcKjQCgIGXpAHdag0GhL
	wiV/BRwo2T/sZ6hMVJWEHrU+8TAL9zodMFX4uklEQI/nDGBoO4DrbD4aodbPrAPoKbqaai2dCUNvb
	E7js933w==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o00N6-0065ri-LL; Sat, 11 Jun 2022 12:37:44 +0000
Date: Sat, 11 Jun 2022 12:37:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: mainline build failure due to 6c77676645ad ("iov_iter: Fix
 iter_xarray_get_pages{,_alloc}()")
Message-ID: <YqSMmC/UuQpXdxtR@zeniv-ca.linux.org.uk>
References: <YqRyL2sIqQNDfky2@debian>
 <YqSGv6uaZzLxKfmG@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqSGv6uaZzLxKfmG@zeniv-ca.linux.org.uk>
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

On Sat, Jun 11, 2022 at 12:12:47PM +0000, Al Viro wrote:


> At a guess, should be
> 	return min((size_t)nr * PAGE_SIZE - offset, maxsize);
> 
> in both places.  I'm more than half-asleep right now; could you verify that it
> (as the last lines of both iter_xarray_get_pages() and iter_xarray_get_pages_alloc())
> builds correctly?

No, I'm misreading it - it's unsigned * unsigned long - unsigned vs. size_t.
On arm it ends up with unsigned long vs. unsigned int; functionally it *is*
OK (both have the same range there), but it triggers the tests.  Try 

	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);

there (both places).

Al, going back to sleep - 4 hours is not enough...
