Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0856DBFC3
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 14:02:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvW2D1xNYz3chn
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 22:02:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.a=rsa-sha256 header.s=202211 header.b=FoYLhvve;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nabijaczleweli.xyz (client-ip=139.28.40.42; helo=tarta.nabijaczleweli.xyz; envelope-from=nabijaczleweli@nabijaczleweli.xyz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.a=rsa-sha256 header.s=202211 header.b=FoYLhvve;
	dkim-atps=neutral
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvW1l33r4z3cdC
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Apr 2023 22:02:19 +1000 (AEST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 3265754FE
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Apr 2023 13:56:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202211; t=1681041392;
	bh=6Ec9ZJflhAkHSV76kU+JQ2swcQMCcizgSX2EKSZ3QxE=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=FoYLhvve0nCrzJGcJnvjdoSKL+h2OOj9SUov9C6OdDHhL+yk7e6vGxflrAKUVgZwL
	 9tnypOvLvS3nyGqDcHwUbi5uRN5glLR67hTOdzAN2+pELZgj+Pvuvu+N6x07+pE7Z5
	 iDHkdOdkh4Ao+F5h29bCDgYDjKu7yUqWBoKyn3OJicNSmrnVQj2maSuKb+X9BycPbF
	 7mmMOiOIA03Z9pNT4ZSa5gke5yRy0eGc5kMTAv7XpUZKKRrsI5Yynd/CByWuHjSrui
	 hef77pqEVmu0QeBq5n42z8vA1k7NOVDrvmLEzt93hjEMwvBujdZLU65VrHRo0gLzyW
	 bnVuml4mseuHQ==
Date: Sun, 9 Apr 2023 13:56:31 +0200
From: 	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Subject: [PATCH 2/5] erofs-utils: mkfs: drop dead code in -z parsing
Message-ID: <df945a64dbab234faec152a2fca75747f724d0c2.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
References: <d80484200b3ba60127ff3b92e0c7660a2e8726bf.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="63he7v4usnxl6viv"
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


--63he7v4usnxl6viv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

-z is specified as "z:".

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 mkfs/main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 94f51df..d20147c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -276,11 +276,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv=
[])
 				  long_options, NULL)) !=3D -1) {
 		switch (opt) {
 		case 'z':
-			if (!optarg) {
-				cfg.c_compr_alg[0] =3D "(default)";
-				cfg.c_compr_level[0] =3D -1;
-				break;
-			}
 			i =3D mkfs_parse_compress_algs(optarg);
 			if (i)
 				return i;
--=20
2.30.2


--63he7v4usnxl6viv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmQyp+4ACgkQvP0LAY0m
WPHR7g/9E3yO+frCcjMONs8QHH40uqnDkEfVud0WDKSH7966J2cdZwscyz8cZ9rV
Kpenk65AOkNJOZchk55u+8ajIQYD7eb8Qf7hJJeWg5xCrBMuooX8ZN2Ik7Ez74l/
lw907P/QMAV8y+lgNHkzOb4igYTX0DOSvxyFqlzjUgq2UybQV0NdwirG9TXFMaX5
a4VRZtmCPmKVeqS3t4yPwgYQPPTIL2K8CeeDfTr83OVuW1278n1ZzKvQRkUr4Txq
pf7ngkGd1p10A+cxptixXu0eevFg9wyTaRd4p71vp+3Zt6GMay3fTbvz5q1SRCKr
ng4BSUS+P1FWL0zRqYw64heGkOUr5pOJE/hWlKiv2LkOZUfVSkLkKZjKjYIQy2gN
hee2i3tkdrwaB083QvpthMY2DLJbVpnB4oDcNWFr+qdP3Q2NFwt67ycqw388srCv
TmvrrwCbaUpM2v0yFO09c/um+6jUhgyLHXh9Km98WELzco/iXCPPjtXiCzPHRTAP
LZYaw3CUuYKtRERAvcCsuOrsq/kaK+DYeXaMB4eJTaQjFmBi9N3kPEEHWhfJgN1d
zl9UNZvhYdmRF6LMu5WIHhwQ0tWg3cDKyvuiKGuUbh3r9UNbUG3otx6G3O6GZLwx
brJtoccKqsWfRb1N6du7ubTw1dsqep8geBrbZjtxmx4X1z4Edd4=
=16pW
-----END PGP SIGNATURE-----

--63he7v4usnxl6viv--
