Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id F39B88E529
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2019 09:01:51 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 468HSF3s06zDqNm
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2019 17:01:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=ucw.cz
 (client-ip=195.113.26.193; helo=atrey.karlin.mff.cuni.cz;
 envelope-from=pavel@ucw.cz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=denx.de
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 468HS90LYczDqHh
 for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2019 17:01:40 +1000 (AEST)
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 34AD7806FD; Thu, 15 Aug 2019 09:01:20 +0200 (CEST)
Date: Thu, 15 Aug 2019 09:01:32 +0200
From: Pavel Machek <pavel@denx.de>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH v7 08/24] erofs: add namei functions
Message-ID: <20190815070132.GB3669@amd>
References: <20190813091326.84652-1-gaoxiang25@huawei.com>
 <20190813091326.84652-9-gaoxiang25@huawei.com>
 <20190813114821.GB11559@amd> <20190813122332.GA17429@138>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <20190813122332.GA17429@138>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
 David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
 devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Pavel Machek <pavel@denx.de>, LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +	/*
> > > +	 * on-disk error, let's only BUG_ON in the debugging mode.
> > > +	 * otherwise, it will return 1 to just skip the invalid name
> > > +	 * and go on (in consideration of the lookup performance).
> > > +	 */
> > > +	DBG_BUGON(qd->name > qd->end);
> >=20
> > I believe you should check for errors in non-debug mode, too.
>=20
> Thanks for your kindly reply!
>=20
> The following is just my personal thought... If I am wrong, please
> kindly point out...
>=20
> As you can see, this is a new prefixed string binary search algorithm
> which can provide similar performance with hashed approach (but no
> need to store hash value at all), so I really care about its lookup
> performance.
>=20
> There is something needing to be concerned, is, whether namei() should
> report any potential on-disk issues or just return -ENOENT for these
> corrupted dirs, I think I tend to use the latter one.

-ENOENT is okay for corrupted directories, as long as corrupted
directories do not cause some kind of security bugs (memory
corruption, crashes, ...)


Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1VA0wACgkQMOfwapXb+vJ0RACeIl9SXkQ+HyKjoz6KEOY1IIxQ
fokAoLx3vqeReYdzJjSOjFpCjcgEgtud
=GkrJ
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
