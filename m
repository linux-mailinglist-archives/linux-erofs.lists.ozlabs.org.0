Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB5D6DC016
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 15:41:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvYD01mpVz3cdx
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 23:41:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.a=rsa-sha256 header.s=202211 header.b=Z5Vf2oD8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nabijaczleweli.xyz (client-ip=139.28.40.42; helo=tarta.nabijaczleweli.xyz; envelope-from=nabijaczleweli@nabijaczleweli.xyz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.a=rsa-sha256 header.s=202211 header.b=Z5Vf2oD8;
	dkim-atps=neutral
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvYCt4mvnz3cd4
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Apr 2023 23:41:14 +1000 (AEST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 12C425C0C;
	Sun,  9 Apr 2023 15:41:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202211; t=1681047671;
	bh=BI/jzYVW0J4FpNqta/DWu3bKg2SF+Gyx1EApCxzf9Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z5Vf2oD8Chi6z12+Et3i+VDQy7eXZ6XVAHebl/xiaDVR1mRqZStuahf94ADQSM8lW
	 8MavCtqDXFUtZMtBrZVKW7PlcHYHVS9L2f1GA0XPxfMFtW17JlJarFUKhk2ojKAyng
	 ddYrNJ6F/FMuGUTW+WPTIMGLY8VSuMb+hRDX8aj9EjqmDnz7HzYDw4AR9w4ys9YiNT
	 V26p8cV+LppOSomfojX7TuoMqbOqpfOIq7qPUPsewZ69hkmldSPWgDm5xSphWQYYn9
	 iGZk9uRbgkABx3MGaWBp556A4ZTFyjW5Z+DvouxFQxYe7HIaIF4gd9dQXfj/3Lx0MG
	 UnMz8M5H/q0hw==
Date: Sun, 9 Apr 2023 15:41:09 +0200
From: 	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 4/5] erofs-utils: man: fsck.erofs: wording/formatting
 touchups
Message-ID: <nrjslxj7x6fufnvg4qavwm6zy5gues42wbjf23fgxpihsxyrrc@ddkzmz2usmyl>
References: <38744cc8-f791-90e9-67d4-83eecbe81c5e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z5amb6urn7q4kx6b"
Content-Disposition: inline
In-Reply-To: <38744cc8-f791-90e9-67d4-83eecbe81c5e@linux.alibaba.com>
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
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--z5amb6urn7q4kx6b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some things that gave me pause or were weirdly formatted.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
Yep :)

 man/fsck.erofs.1 | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/man/fsck.erofs.1 b/man/fsck.erofs.1
index f3e9c3b..364219a 100644
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
+Display help string and exit.
 .SH AUTHOR
 This version of \fBfsck.erofs\fR is written by
 Daeho Jeong <daehojeong@google.com>.
--=20
2.30.2

--z5amb6urn7q4kx6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmQywHUACgkQvP0LAY0m
WPH0uRAAiKWkPDnLBnxc5ldaVb3q8DSLD8hK6pRQ+Pxjl90EnaTaV1YoU9ILG+LD
3M2BtBwZ7ZDkFYOQJ0BhwzC7uv1XWyYqVxHsU5is3maTIxxU+JEom8FnWpXHv8KM
8PaZ1oVIMXLUxsQpVhs6kWPycj7a05JVdm8+nUNb6TnzoexS49WI5ihgT0uTR2+S
C0u156s8iJbx4VHjUxrEVggRFFQqrbBbBpXvLXNKjiC9K92i8mcLH+VyKLXkP7dP
yoIrJRFu+DyZA+r3Lia3nzyse+k9WZ6Dl0NdeY51RXCtok9kh03SYfs1aWIHvAmx
UBPAiY7MhvfUAkk/0x4rM2hfLeOzQ1JYvwpxGLyT9qkBYDsDn2Jk3W30dNAghoUf
kDm3o78BAngY3c4vWbLo2Rmmvg2BgoYAP5S95bKfEumkw3gE+h1DCODKSqlmN04H
hbxKwb2tYM3i3GkSH5wGJRK3Kdfn2WvGB95y31I3oKst7vTfK5bp203LlENNIlGc
Aq7qcr8HFsgKoQRyOEP/8uqYHKtR2sJo3YTBxUjMm/yLBpGhrIcMwbQDVwTjlxS8
rJNna+unietIdyiBwhCS9XVZku1a2QDLzUSSol8Kn9fzLGAW4PQtvs7nj7Ofnitk
oNuB6ZlSmwmC5Jb0USGNy/F3Jyg0HP9z2isgWEy8xyyXowf256Y=
=YTfi
-----END PGP SIGNATURE-----

--z5amb6urn7q4kx6b--
