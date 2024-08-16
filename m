Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F49953FF2
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2024 05:05:59 +0200 (CEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="::1"
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.a=rsa-sha256 header.s=202405 header.b=FPkHaHKZ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WlRhP1Qg5z2ymc
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2024 13:05:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.28.40.42
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.a=rsa-sha256 header.s=202405 header.b=FPkHaHKZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nabijaczleweli.xyz (client-ip=139.28.40.42; helo=tarta.nabijaczleweli.xyz; envelope-from=nabijaczleweli@nabijaczleweli.xyz; receiver=lists.ozlabs.org)
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WlRhJ5CDBz2xbd
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2024 13:05:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1723777541;
	bh=uI3E/TLwWF34pcW6wiSMQTMYzNMjUqRNTwO7AA3QZ5Q=;
	h=Date:From:Cc:Subject:From;
	b=FPkHaHKZTFQW65T30KYigUqpZzJxWZOQamVBkAV7B4IuzUupRm7Mt39dBwGjSJn6j
	 j5Da/xvG24LG/FN+hPNhdxZSJ0t3PuJjnJCy23mFWe2Q1MgyC1tgDe9fgl8pnvi6zX
	 CaCRuNalgiJlHQsP570EvigfDMTq4RpYtI6P0QkB0+/utmd2gWFerK3YbpLTr/YYpW
	 ZEd++sMB8HOU1NIx2a1wqYQQoRgM3yXclMeJRxHZqvYdywUPCS3rgpm0snl1SuKdnf
	 IkvWgMCVW9HMw88b2sIs3Vnd9cJPLtP5f6Qa2ZdFxLOCAx/rSqXASuTeFOW1m+Alql
	 JKjVhTDuGqrvQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id DF26EBEDA
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2024 05:05:41 +0200 (CEST)
Date: Fri, 16 Aug 2024 05:05:41 +0200
From: 	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Subject: [PATCH] erofs-utils: use $EROFS_UTILS_VERSION, if set, as the version
Message-ID: <gho2b67qax222ewv5xb5cjkkgjgzftr3pyecl536g6jshcfexa@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nhourteg4wr2ncak"
Content-Disposition: inline
User-Agent: NeoMutt/20240329
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


--nhourteg4wr2ncak
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This lets downstreams embed the unpolluted downstream version;
when building the Debian package (from gbp) the resulting binary yields
  $ mkfs.erofs
  <E> erofs: missing argument: FILE
  mkfs.erofs 1.8.1-fead89d91-dirty
  Try 'mkfs.erofs --help' for more information.

Now, d/rules can
  export EROFS_UTILS_VERSION :=3D $(shell IFS=3D"$$IFS()" read -r _ v _ < d=
ebian/changelog; echo "$$v")
yielding
  $ mkfs.erofs
  <E> erofs: missing argument: FILE
  mkfs.erofs 1.8.1-1
  Try 'mkfs.erofs --help' for more information.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 scripts/get-version-number | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/get-version-number b/scripts/get-version-number
index 26f0b5a..d216b7a 100755
--- a/scripts/get-version-number
+++ b/scripts/get-version-number
@@ -9,7 +9,7 @@ scm_version()
 		# If we are at a tagged commit, we ignore it.
 		if [ -z "$(git describe --exact-match 2>/dev/null)" ]; then
 			# Add -g and 8 hex chars.
-			printf '%s%s' -g "$(echo $head | cut -c1-8)"
+			printf -- '-g%.8s' "$head"
 		fi
 		# Check for uncommitted changes.
 		# This script must avoid any write attempt to the source tree,
@@ -30,4 +30,8 @@ scm_version()
 	fi
 }
=20
-echo $(sed -n '1p' VERSION | tr -d '\n')$(scm_version)
+if [ -n "$EROFS_UTILS_VERSION" ]; then
+	echo "$EROFS_UTILS_VERSION"
+else
+	echo $(head -n1 VERSION)$(scm_version)
+fi
--=20
2.39.2

--nhourteg4wr2ncak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAma+wgUACgkQvP0LAY0m
WPHuCA//ZqbLwm0xS7GhN3TOISTvfN1qww/nu5CQW5jbNTHscLv3l9nGibytxCt1
p7JUeWHVKsMIF0G+d+CGzY6Cj7ikVvZNU8cC3K3Eyeh+B0PMWpYgVqzAnIrjf0Y2
+LAd4qqxQLBkkDesFVA0K6OdvAKiTnZL6KU3LWyMytdiiJdkJiC7A/T/PsZM3k1X
qhxS+FbSLU4+yXoymoes0IHAC8Vte7N5dm1Yi2FJtyWH/8XJgddbGyWqegXYghGI
076dTQqm3RRmsq+FIn+oCi1yMwiNsFSk6s39qYSiI0WcKSOYaN7CAvx+c3W1yCgD
NZrBtdUXIj9w7RtglN4s0XCPOqI75IVKFpxqroxZmvldN6OgtcdHbC4NvNYcYUqx
+U24KXoTm+xv7japS1X4xO62VYDTslzRXUwXSUgSGStqpW6NC14ypWqWUOMTVND4
yE1r6tobKf91++uZ3zPoYzsmsyn1qe5bJh8y6dQbv8rclyZmYl+H2b14rTWQDvM1
n8lR9nJcrGOywXqObgtiL2hqLB/N2eHL43rzwpq92L8jM4TjXKERfg67IdUi+xNm
mRHHDATRsRaluvssH8j4YoHZmkzvBL7hDmHUrafQP/zhjTytBUInW7HGz5ch1pAp
LVZ6jpWFxjP33nuQl+FuEhC/MR8M5tg9QfG5fxAv2iVpGUKVyL8=
=hemp
-----END PGP SIGNATURE-----

--nhourteg4wr2ncak--
