Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C5AF20F5
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2019 22:46:22 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 477g8W3WfgzF5nm
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2019 08:46:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=ucw.cz
 (client-ip=46.255.230.98; helo=jabberwock.ucw.cz; envelope-from=pavel@ucw.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=denx.de
X-Greylist: delayed 513 seconds by postgrey-1.36 at bilbo;
 Thu, 07 Nov 2019 08:46:09 AEDT
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 477g8K5VB7zF5bY
 for <linux-erofs@lists.ozlabs.org>; Thu,  7 Nov 2019 08:46:09 +1100 (AEDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 36D4F1C09B6; Wed,  6 Nov 2019 22:37:26 +0100 (CET)
Date: Wed, 6 Nov 2019 22:37:25 +0100
From: Pavel Machek <pavel@denx.de>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 10/10] errno.h: Provide EFSCORRUPTED for everybody
Message-ID: <20191106213725.GB7020@amd>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
 <20191104014510.102356-11-Valdis.Kletnieks@vt.edu>
 <5c441427-7e65-fcae-3518-eb37cea5f875@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <5c441427-7e65-fcae-3518-eb37cea5f875@huawei.com>
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
Cc: devel@driverdev.osuosl.org, linux-arch@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, Theodore Ts'o <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 Valdis Kletnieks <valdis.kletnieks@vt.edu>, Gao Xiang <xiang@kernel.org>,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Jan Kara <jack@suse.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > There's currently 6 filesystems that have the same #define. Move it
> > into errno.h so it's defined in just one place.
> >=20
> > Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
> > Acked-by: Darrick J. Wong <darrick.wong@oracle.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Acked-by: Theodore Ts'o <tytso@mit.edu>
>=20
> >  fs/erofs/internal.h              | 2 --
>=20
> >  fs/f2fs/f2fs.h                   | 1 -
>=20
> Acked-by: Chao Yu <yuchao0@huawei.com>

Are we still using EUCLEAN for something else than EFSCORRUPTED? Could
we perhaps change the glibc definiton to "your filesystem is
corrupted" in the long run?

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3DPRUACgkQMOfwapXb+vIeLACgumqpgUAXyu1qs1LlH4i+wJ+u
sPEAn0YdeU4hDroZD6g3yLDme7o5MHbL
=nCbA
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
