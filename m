Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF1254747F
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 14:28:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LKxvR5p2Pz3c1g
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 22:28:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=DTBELQ0X;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2607:5300:60:148a::1; helo=zeniv-ca.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=DTBELQ0X;
	dkim-atps=neutral
X-Greylist: delayed 913 seconds by postgrey-1.36 at boromir; Sat, 11 Jun 2022 22:28:28 AEST
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LKxvJ0kpVz30D0
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 22:28:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=atgndddR6SXbIyqaExtJZJhw3ic+UgK9VwWvZJVDRqM=; b=DTBELQ0XOtAet4aUT4efB1q+ia
	sP7gw1tag71Ut9T9J0Y25hndtEHuQORviFREhu65NZ0JgunSjujQajXnFDN3Uhx2zyhojxkmZdwl0
	qFbkPtFs+jzPUrd06AFHJ66iAw0ZejUG7QGBkdYtMMAUYvF9gwQ6+Ge5hl2MN67J7+9sdYld9SbYL
	7zB8a17jvdMvDNcoBdbiC4mM+jU2vVpWX0/p6VbQ5opblAuQF9I0QDAwkqUReQnlGVQzFY2iASRbs
	tjceebpiSFE/FT8okP3RGX3Tw9QnTYrgEfjEhqkRpch/IGE+mV1sULTrAUnDj20FxAqpoFnIyfoHN
	le1+vSDQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzzyx-0065U6-SO; Sat, 11 Jun 2022 12:12:48 +0000
Date: Sat, 11 Jun 2022 12:12:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: mainline build failure due to 6c77676645ad ("iov_iter: Fix
 iter_xarray_get_pages{,_alloc}()")
Message-ID: <YqSGv6uaZzLxKfmG@zeniv-ca.linux.org.uk>
References: <YqRyL2sIqQNDfky2@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqRyL2sIqQNDfky2@debian>
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

On Sat, Jun 11, 2022 at 11:45:03AM +0100, Sudip Mukherjee wrote:
> Hi All,
> 
> The latest mainline kernel branch fails to build for "arm allmodconfig",
> "xtensa allmodconfig" and "csky allmodconfig" with the error:
> 
> In file included from ./include/linux/kernel.h:26,
>                  from ./include/linux/crypto.h:16,
>                  from ./include/crypto/hash.h:11,
>                  from lib/iov_iter.c:2:
> lib/iov_iter.c: In function 'iter_xarray_get_pages':
> ./include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
>    20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>       |                                   ^~
> ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
>    26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>       |                  ^~~~~~~~~~~
> ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
>    36 |         __builtin_choose_expr(__safe_cmp(x, y), \
>       |                               ^~~~~~~~~~
> ./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
>    45 | #define min(x, y)       __careful_cmp(x, y, <)
>       |                         ^~~~~~~~~~~~~
> lib/iov_iter.c:1464:16: note: in expansion of macro 'min'
>  1464 |         return min(nr * PAGE_SIZE - offset, maxsize);
>       |                ^~~
> lib/iov_iter.c: In function 'iter_xarray_get_pages_alloc':
> ./include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
>    20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>       |                                   ^~
> ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
>    26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>       |                  ^~~~~~~~~~~
> ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
>    36 |         __builtin_choose_expr(__safe_cmp(x, y), \
>       |                               ^~~~~~~~~~
> ./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
>    45 | #define min(x, y)       __careful_cmp(x, y, <)
>       |                         ^~~~~~~~~~~~~
> lib/iov_iter.c:1628:16: note: in expansion of macro 'min'
>  1628 |         return min(nr * PAGE_SIZE - offset, maxsize);
> 
> 
> git bisect pointed to 6c77676645ad ("iov_iter: Fix iter_xarray_get_pages{,_alloc}()")

At a guess, should be
	return min((size_t)nr * PAGE_SIZE - offset, maxsize);

in both places.  I'm more than half-asleep right now; could you verify that it
(as the last lines of both iter_xarray_get_pages() and iter_xarray_get_pages_alloc())
builds correctly?
