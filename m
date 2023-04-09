Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A786DBFC1
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 14:02:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvW215z4Mz3fS5
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 22:02:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.a=rsa-sha256 header.s=202211 header.b=CkHOszDy;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nabijaczleweli.xyz (client-ip=139.28.40.42; helo=tarta.nabijaczleweli.xyz; envelope-from=nabijaczleweli@nabijaczleweli.xyz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.a=rsa-sha256 header.s=202211 header.b=CkHOszDy;
	dkim-atps=neutral
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvW1l2yMnz3cd6
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Apr 2023 22:02:18 +1000 (AEST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 0C4975A28
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Apr 2023 13:56:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202211; t=1681041406;
	bh=dib2ldqsJZRd92tfwYnwiNBVQ8yOx3bWvWeDnNn22Vc=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=CkHOszDy8Fjz7R+eZAcB+F2KKbQMMaPJqPFawRv6Fo+CxA3mgTr5Q9zh5No94UEa5
	 ePGoNCyqMamxXcR12oA0uIjREvnH6I2cAhdAgMk6CTl1P1UherKW9LqYCBNfM+sSqS
	 /aJwyEE4ir1UVzyDqs5EaDqS7xYTOdPjXnD6gjmzz7bslP3g1jYLBkQJq0sl91B1V1
	 EZM16CR/nVVm4M1FUgJu++0qQ9NGZxG7k6xGIkEhXS4aZvjY1rdTkA6Fyv5s/ST61D
	 vl2YEb789lB6A/qDeydX8REQ+wy0F33lQ5/Dgror+V1+t3MVVg35b73UqXGJaY8ugv
	 yfRbSNUZ7vKAA==
Date: Sun, 9 Apr 2023 13:56:44 +0200
From: 	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Subject: [PATCH 5/5] erofs-utils: man: dump.erofs: wording/formatting touchups
Message-ID: <c556cbafa7124d5ab5d20979be068ba36a125ed6.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
References: <d80484200b3ba60127ff3b92e0c7660a2e8726bf.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ctqebchvqg76utzp"
Content-Disposition: inline
In-Reply-To: <d80484200b3ba60127ff3b92e0c7660a2e8726bf.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20230407
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--ctqebchvqg76utzp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some things that gave me pause or were weirdly formatted.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 man/dump.erofs.1 | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/man/dump.erofs.1 b/man/dump.erofs.1
index 209e5f9..7316f4b 100644
--- a/man/dump.erofs.1
+++ b/man/dump.erofs.1
@@ -9,18 +9,28 @@ or overall disk statistics information from an EROFS-form=
atted image.
 .SH DESCRIPTION
 .B dump.erofs
 is used to retrieve erofs metadata from \fIIMAGE\fP and demonstrate
+.br
 1) overall disk statistics,
+.br
 2) superblock information,
+.br
 3) file information of the given inode NID,
+.br
 4) file extent information of the given inode NID.
 .SH OPTIONS
 .TP
 .BI "\-\-device=3D" path
 Specify an extra device to be used together.
-You may give multiple `--device' options in the correct order.
+You may give multiple
+.B --device
+options in the correct order.
 .TP
 .BI "\-\-ls"
-List directory contents. An inode should be specified together.
+List directory contents.
+.I NID
+or
+.I path
+required.
 .TP
 .BI "\-\-nid=3D" NID
 Specify an inode NID in order to print its file information.
@@ -29,16 +39,21 @@ Specify an inode NID in order to print its file informa=
tion.
 Specify an inode path in order to print its file information.
 .TP
 .BI \-e
-Show the file extent information. An inode should be specified together.
+Show the file extent information.
+.I NID
+or
+.I path
+required.
 .TP
 .BI \-V
 Print the version number and exit.
 .TP
 .BI \-s
-Show superblock information of the an EROFS-formatted image.
+Show superblock information.
+This is the default if no options are specified.
 .TP
 .BI \-S
-Show EROFS disk statistics, including file type/size distribution, number =
of (un)compressed files, compression ratio of the whole image, etc.
+Show image statistics, including file type/size distribution, number of (u=
n)compressed files, compression ratio, etc.
 .SH AUTHOR
 Initial code was written by Wang Qi <mpiglet@outlook.com>, Guo Xuenan <guo=
xuenan@huawei.com>.
 .PP
--=20
2.30.2

--ctqebchvqg76utzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmQyp/wACgkQvP0LAY0m
WPESQRAAlsTpJRvCZmBZ1UnWgjvKazTGldsM6g2wXUoEd1wx682MjqV0mjdSeP/W
gxeVy/MKOM8eJ08mTRKp3z7lrobZx+a00ZQ5hqGxLXyZU+86ds4c9fuaQItzXm8K
VW9/DVXG+ccT4eCGMGiEeBaqK5qq8oVlgkuO/ZWsODiM9vW6Z4IoeMgLdOYqYwa5
TjNX6U+V1MNLEvFhQn2Brk1fe8X+lAaRU+ZXQlhiRgvTEPo0pYbJ/wJ47zhw9U1J
Nc7wVXVScvVXhnk8kJDFpTlrND2ro6SX5b1d+tUK6gCUSNyQLAE4FlC/FCv8QluJ
4AhkckTp/yEPLPwo8j8VixTU4/d3M8ABB4bKgPB8Id+U48RmdjFXm8rnUMmTbpKE
oFu+OnxaZ9cddlAlml/30fzZWAQljQpGLLK3aYn4Pm/R/8EA6ZXYx/gPEnkkKCf5
451okwwg+n/WRJi4Vgpgme/f5O0ZXQ6ETw8sHdX5QvxQa38yGgfdPnLdZ6TXUVaU
uLvUazyNjSTp9928wnm2oKlPMflGpfROYlgnpmVWMoV87l1NzFyrz3E0gOz/XAkt
dfISKlipRVd6qOKXkmp38biGZQlJWtrs+R2zHgvsmKdmRnduY+9FAOd5q04xUWZK
NKStZ/wJ3kxhQVaVrUgtzpnV2xFl3jMtqeSvarvFTid6i5hicX0=
=eRpF
-----END PGP SIGNATURE-----

--ctqebchvqg76utzp--
