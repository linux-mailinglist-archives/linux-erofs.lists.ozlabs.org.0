Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 616E96DBFC2
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 14:02:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvW2822bdz3f6r
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 22:02:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.a=rsa-sha256 header.s=202211 header.b=bhC3gzTZ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nabijaczleweli.xyz (client-ip=139.28.40.42; helo=tarta.nabijaczleweli.xyz; envelope-from=nabijaczleweli@nabijaczleweli.xyz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.a=rsa-sha256 header.s=202211 header.b=bhC3gzTZ;
	dkim-atps=neutral
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvW1l35VQz3cdL
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Apr 2023 22:02:19 +1000 (AEST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 0BB8A565E
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Apr 2023 13:56:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202211; t=1681041402;
	bh=9iAuCTfykOHJgohJWoUSXILBtTHoubPSQESaXjqW4pQ=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=bhC3gzTZMNcuTB0R3b3HZbNSSyHYCXvojjWJEMtpV2qGUNzllCZo3mqgaQT+CPur4
	 OALODvXR87VY2QKM8isCx0uDXbaxLhZBlhRoKbQi0Il4SuVRM1s7KlmF1a9E6KURRr
	 IN6nUu1z/oDSTs6ZWGh9vO19I7I1ZEZIUed0t9ZFfqDmPxKw18hO/JU4bMYWUU7MLf
	 iHQoKP21ecpW2Iz/YqrYjG4NOf+WT3EiMhWxz0LfencvnFqITE7ONZkeyj0iHQqQA8
	 NylQ9LmgC8kEwAqtcKJkkK48cB5duBWBOCLr1hweNnIYxN7hAyXDLlpKGo6sDYyQBp
	 F+5DbPucHLlNg==
Date: Sun, 9 Apr 2023 13:56:40 +0200
From: 	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Subject: [PATCH 4/5] erofs-utils: man: fsck.erofs: wording/formatting touchups
Message-ID: <6243c9715ab5dfa283e540da8f701da4a58d49a2.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
References: <d80484200b3ba60127ff3b92e0c7660a2e8726bf.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3hkhafflcnqkwlyq"
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


--3hkhafflcnqkwlyq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some things that gave me pause or were weirdly formatted.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 man/fsck.erofs.1 | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/man/fsck.erofs.1 b/man/fsck.erofs.1
index f3e9c3b..d53f36b 100644
--- a/man/fsck.erofs.1
+++ b/man/fsck.erofs.1
@@ -2,7 +2,7 @@
 .\"
 .TH FSCK.EROFS 1
 .SH NAME
-fsck.erofs \- tool to check the EROFS filesystem's integrity
+fsck.erofs \- tool to check an EROFS filesystem's integrity
 .SH SYNOPSIS
 \fBfsck.erofs\fR [\fIOPTIONS\fR] \fIIMAGE\fR
 .SH DESCRIPTION
@@ -22,15 +22,18 @@ Print total compression ratio of all files including co=
mpressed and
 non-compressed files.
 .TP
 .BI "\-\-device=3D" path
-Specify an extra device to be used together.
-You may give multiple `--device' options in the correct order.
+Specify an extra blob device to be used together.
+You may give multiple
+.B --device
+options in the correct order.
 .TP
 .B \-\-extract
-Check if all files are well encoded. This will induce more I/Os to read
-compressed file data, so it might take too much time depending on the imag=
e.
+Check if all files are well encoded. This read all compressed files,
+and hence create more I/O load,
+so it might take too much time depending on the image.
 .TP
 .B \-\-help
-Display this help and exit.
+Display help string exit.
 .SH AUTHOR
 This version of \fBfsck.erofs\fR is written by
 Daeho Jeong <daehojeong@google.com>.
--=20
2.30.2


--3hkhafflcnqkwlyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmQyp/gACgkQvP0LAY0m
WPEIbBAAldDnhDi2XIsPHMr8hyoe5xl+ZrU/TYTxa0iG02eOJ8UhBBp8/7CqVwVB
OvglDOtHckLH93gNXcrKQei4LWSEC8kEPzvt3uORGAVWEXiSjE4+dinsEABdnsKA
RkQndzQFwdHMwmNwi36ah9XE69gj38G2vbxUxLH3F8LncwX0i9JFlJIBgEvvUWC/
lsy53NrhnFjs6Nw4k2/fywAoPaLJ3UJwgkf8+/9pEo76jqZQz4euibsiDh8MnPlk
7ogXyTurNZO4kpRzWG5mIMnNxngqpBqvcCvYuUjbmoIMMdsK7koeJohGfdaJglHz
OJ9Yu0bmz8AtDKpMGId7UDpem/5Mc4jquufMIUXnkYkNBZgaqdH/BYQvyMcbtn6Q
X3Y4lSRc6sg8elcm0WtGm7qrMfjxt4YonMka2QbGgpi4fc5OoFzcn4jqv2uTRTEE
Ti9aDdPaoZHIHMT4TYUwnRk6vQinoNHGi6KSQcPZNTVzcIDzgFUQqPoUiVTopchT
3n93KkEkUGUW/VHCbvipVU2sfGZ2i0l1u08+PnkIAoH1LcE6vJv9JS0LJYhSjloV
RnOeuxEM9qnFg2Rkr8I6hQunh5ieT8Uxoa/mMvMUTZfLsjVHxxwgUAJjRF7Ol5PK
DU54sM9Yy7FVQXJZEmY4XhYauCjvo6WF2cVnprW++zvemN2nVCQ=
=qG7E
-----END PGP SIGNATURE-----

--3hkhafflcnqkwlyq--
