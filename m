Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A06A520A
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 10:43:14 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MNrw0L15zDqd7
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 18:43:12 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MNrq0kFkzDqc9
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2019 18:43:07 +1000 (AEST)
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id ACB57809D3; Mon,  2 Sep 2019 10:42:50 +0200 (CEST)
Date: Mon, 2 Sep 2019 10:43:03 +0200
From: Pavel Machek <pavel@denx.de>
To: dsterba@suse.cz, Joe Perches <joe@perches.com>,
 Gao Xiang <gaoxiang25@huawei.com>, Christoph Hellwig <hch@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
 Amir Goldstein <amir73il@gmail.com>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Dave Chinner <david@fromorbit.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
 LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
 Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v6 01/24] erofs: add on-disk layout
Message-ID: <20190902084303.GC19557@amd>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-2-gaoxiang25@huawei.com>
 <20190829095954.GB20598@infradead.org>
 <20190829103252.GA64893@architecture4>
 <67d6efbbc9ac6db23215660cb970b7ef29dc0c1d.camel@perches.com>
 <20190830120714.GN2752@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <20190830120714.GN2752@twin.jikos.cz>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Rather than they didn't run "gdb" or "pahole" and change it by mistak=
e.
> >=20
> > I think Christoph is not right here.
> >=20
> > Using external tools for validation is extra work
> > when necessary for understanding the code.
>=20
> The advantage of using the external tools that the information about
> offsets is provably correct ...

No. gdb tells you what the actual offsets _are_.

> > The expected offset is somewhat valuable, but
> > perhaps the form is a bit off given the visual
> > run-in to the field types.
> >=20
> > The extra work with this form is manipulating all
> > the offsets whenever a structure change occurs.
>=20
> ... while this is error prone.

While the comment tells you what they _should be_.

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1s1hcACgkQMOfwapXb+vLwegCgmC1y9HxKZu/YFm0T4U+rH5ko
oJcAni3phOqqriczOS1slpVzLy+HY7Nv
=pnr4
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
