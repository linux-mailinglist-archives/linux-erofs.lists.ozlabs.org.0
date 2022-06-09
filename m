Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D515154529A
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jun 2022 19:05:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LJr7d142Sz3bqr
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Jun 2022 03:05:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rhg3JZaX;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rhg3JZaX;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LJr7V4tCJz3blQ
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Jun 2022 03:05:10 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 61D9FB82ECD;
	Thu,  9 Jun 2022 17:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7CFC34114;
	Thu,  9 Jun 2022 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654794306;
	bh=TyXSDd71ITvKQbVh8Cn4dAI1JmsPDXjiP1sZFC/KfUM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rhg3JZaXznf78tW/tdEvAZeK/jwmr6IJEVpWLJd1VzkAPNn8y6eM+SNyfgZyDXy6e
	 lzNm1gVEVN6ZxDQI0KQgBKkvEzQ+MruELC+MDfMaYKEPkGtGnbNol3EH4cG6y7wszl
	 RSNzsHsZGrDFkVBcL2W3CtahOkx0VPF8D5bRAHWyKUNBAnwvCdaHOOoRWWBPCZ/LB0
	 EdTtz6w1OAan7q0dkZFoSIYs5zY7KpT60WZA/RwiE64PBTEnog/9i09qZAd8i/ZqaL
	 lUBjad8+Mef5m3Dvqhc486tjVH/i4T9OHs7pJmqLnpyFS54OL7mg+W6iz0arPzr7AY
	 /TBgqR61XVDlQ==
Message-ID: <480f3b02d2cda67cb2a1b68e88afa03e95809b8c.camel@kernel.org>
Subject: Re: [PATCH] iov_iter: Fix iter_xarray_get_pages{,_alloc}()
From: Jeff Layton <jlayton@kernel.org>
To: David Howells <dhowells@redhat.com>
Date: Thu, 09 Jun 2022 13:05:03 -0400
In-Reply-To: <165476202136.3999992.433442175457370240.stgit@warthog.procyon.org.uk>
References: 	<165476202136.3999992.433442175457370240.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, devel@lists.orangefs.org, Mike Marshall <hubcap@omnibond.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 2022-06-09 at 09:07 +0100, David Howells wrote:
> The maths at the end of iter_xarray_get_pages() to calculate the actual
> size doesn't work under some circumstances, such as when it's been asked =
to
> extract a partial single page.  Various terms of the equation cancel out
> and you end up with actual =3D=3D offset.  The same issue exists in
> iter_xarray_get_pages_alloc().
>=20
> Fix these to just use min() to select the lesser amount from between the
> amount of page content transcribed into the buffer, minus the offset, and
> the size limit specified.
>=20
> This doesn't appear to have caused a problem yet upstream because network
> filesystems aren't getting the pages from an xarray iterator, but rather
> passing it directly to the socket, which just iterates over it.  Cachefil=
es
> *does* do DIO from one to/from ext4/xfs/btrfs/etc. but it always asks for
> whole pages to be written or read.
>=20
> Fixes: 7ff5062079ef ("iov_iter: Add ITER_XARRAY")
> Reported-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Mike Marshall <hubcap@omnibond.com>
> cc: Gao Xiang <xiang@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: v9fs-developer@lists.sourceforge.net
> cc: devel@lists.orangefs.org
> cc: linux-erofs@lists.ozlabs.org
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> ---
>=20
>  lib/iov_iter.c |   20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 834e1e268eb6..814f65fd0c42 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1434,7 +1434,7 @@ static ssize_t iter_xarray_get_pages(struct iov_ite=
r *i,
>  {
>  	unsigned nr, offset;
>  	pgoff_t index, count;
> -	size_t size =3D maxsize, actual;
> +	size_t size =3D maxsize;
>  	loff_t pos;
> =20
>  	if (!size || !maxpages)
> @@ -1461,13 +1461,7 @@ static ssize_t iter_xarray_get_pages(struct iov_it=
er *i,
>  	if (nr =3D=3D 0)
>  		return 0;
> =20
> -	actual =3D PAGE_SIZE * nr;
> -	actual -=3D offset;
> -	if (nr =3D=3D count && size > 0) {
> -		unsigned last_offset =3D (nr > 1) ? 0 : offset;
> -		actual -=3D PAGE_SIZE - (last_offset + size);
> -	}
> -	return actual;
> +	return min(nr * PAGE_SIZE - offset, maxsize);
>  }
> =20
>  /* must be done on non-empty ITER_IOVEC one */
> @@ -1602,7 +1596,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct i=
ov_iter *i,
>  	struct page **p;
>  	unsigned nr, offset;
>  	pgoff_t index, count;
> -	size_t size =3D maxsize, actual;
> +	size_t size =3D maxsize;
>  	loff_t pos;
> =20
>  	if (!size)
> @@ -1631,13 +1625,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct =
iov_iter *i,
>  	if (nr =3D=3D 0)
>  		return 0;
> =20
> -	actual =3D PAGE_SIZE * nr;
> -	actual -=3D offset;
> -	if (nr =3D=3D count && size > 0) {
> -		unsigned last_offset =3D (nr > 1) ? 0 : offset;
> -		actual -=3D PAGE_SIZE - (last_offset + size);
> -	}
> -	return actual;
> +	return min(nr * PAGE_SIZE - offset, maxsize);
>  }
> =20
>  ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
>=20
>=20

This seems to fix the bug I was hitting. Thanks!

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
