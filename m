Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE07F7E7039
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Nov 2023 18:27:27 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=P113lzxw;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SR8644GMKz3cJW
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Nov 2023 04:27:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=P113lzxw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SR85y3cp6z3c01
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Nov 2023 04:27:17 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C189F61921;
	Thu,  9 Nov 2023 17:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329DBC433BA;
	Thu,  9 Nov 2023 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1699550832;
	bh=/iXik9FGY/j8fU7q/WT2BYxZ4459aBKtixWI7gW0Gy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P113lzxwo814DeFndWkAaSyJ+DLb8VNTEP7P6j/vCWGSSKY2QDBBCpyUJtXKsvZt8
	 yVSynsnJ8XhLaIqnbxNEa9vIPier0gLp7yXoMzqsfeZ25GvHh45wYNq+pLR/4wNIBl
	 YqtZ8j7nGGcDw1o6QRhQLfQDovsx9kZS0r7BiWJc=
Date: Thu, 9 Nov 2023 09:27:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Andreas =?ISO-8859-1?Q?Gr=FCnbacher?= <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH 1/3] mm: Add folio_zero_tail() and use it in ext4
Message-Id: <20231109092711.cf73f30a2fa84d4400377839@linux-foundation.org>
In-Reply-To: <CAHpGcMLU9CeX=P=718Gp=oYNnfbft_Mh1Nhdx45qWXY0DAf6Mg@mail.gmail.com>
References: <20231107212643.3490372-1-willy@infradead.org>
	<20231107212643.3490372-2-willy@infradead.org>
	<20231108150606.2ec3cafb290f757f0e4c92d8@linux-foundation.org>
	<CAHpGcMLU9CeX=P=718Gp=oYNnfbft_Mh1Nhdx45qWXY0DAf6Mg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-xfs <linux-xfs@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Gruenbacher <agruenba@redhat.com>, "Darrick J . Wong" <djwong@kernel.org>, "Matthew Wilcox \(Oracle\)" <willy@infradead.org>, gfs2@lists.linux.dev, Andreas Dilger <adilger.kernel@dilger.ca>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 9 Nov 2023 01:12:15 +0100 Andreas Gr=FCnbacher <andreas.gruenbacher=
@gmail.com> wrote:

> Andrew,
>=20
> Andrew Morton <akpm@linux-foundation.org> schrieb am Do., 9. Nov. 2023, 0=
0:06:
> > > +
> > > +     if (folio_test_highmem(folio)) {
> > > +             size_t max =3D PAGE_SIZE - offset_in_page(offset);
> > > +
> > > +             while (len > max) {
> >
> > Shouldn't this be `while (len)'?  AFAICT this code can fail to clear
> > the final page.
>=20
> not sure what you're seeing there, but this looks fine to me.

I was right!  This code does fail to handle the final page.

: static inline void folio_fill_tail(struct folio *folio, size_t offset,
: 		const char *from, size_t len)
: {
: 	char *to =3D kmap_local_folio(folio, offset);
:=20
: 	VM_BUG_ON(offset + len > folio_size(folio));
:=20
: 	if (folio_test_highmem(folio)) {
: 		size_t max =3D PAGE_SIZE - offset_in_page(offset);
:=20
: 		while (len > max) {
: 			memcpy(to, from, max);
: 			kunmap_local(to);
: 			len -=3D max;
: 			from +=3D max;
: 			offset +=3D max;
: 			max =3D PAGE_SIZE;
: 			to =3D kmap_local_folio(folio, offset);
: 		}
: 	}
:=20
: 	memcpy(to, from, len);

This code down here handles it, doh.

: 	to =3D folio_zero_tail(folio, offset, to);
: 	kunmap_local(to);
: }

Implementation seems less straightforward than it might be?  Oh well.

Has it been runtime tested?

Anyway, let's please change the function argument ordering and remember
to cc linux-mm on v2?
