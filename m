Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AA74CC5D8
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Mar 2022 20:15:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K8ggB4lMfz3c2b
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Mar 2022 06:15:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=rxQcgRAL;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::72b;
 helo=mail-qk1-x72b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=rxQcgRAL; dkim-atps=neutral
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K8gg53clRz3c1h
 for <linux-erofs@lists.ozlabs.org>; Fri,  4 Mar 2022 06:15:28 +1100 (AEDT)
Received: by mail-qk1-x72b.google.com with SMTP id n185so4706183qke.5
 for <linux-erofs@lists.ozlabs.org>; Thu, 03 Mar 2022 11:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ShDD4m3YL69ae65uKnc85TTs9UhkTA4eNhzJp/ErX/I=;
 b=rxQcgRALxKnsjud7s+Xg1t+QQ3tNVF11/WprIZs68RRspcaJtu4iahRO0l8FUSjGK6
 WAnp7wWGQrknalneoRooA22pcpxTPg1yHvObo+jFwgy0oOvBn0pOX5dq2f2U27ZRV1AQ
 DOOVriZJFb9jf7EIvn5gqNZTV424ZZmcRMhno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ShDD4m3YL69ae65uKnc85TTs9UhkTA4eNhzJp/ErX/I=;
 b=tXS/MP2rru1wFf6kVspeqRfTq1/9ct/nTqy8cHut8BZ8rsbbyWRHBYxWJjF3jTwyHT
 lKE4WJYbK64E+IBKrtw0d7+wYajGO/0jwqP7tRzyxaWVp1Amsq0ZFGtQ7HX3wMdxOiPC
 WuV2C9+5oBlvZPPDBW3/+HVmwWGv+92xverS5Vf3C4C3l/tCeYlPUDvEZVNjQkkIvKlx
 m8zsR1sgehedm0ChYqETKvtkam6W0fnZ3FhnZfsFNsEhLsQi7X4PNiF48Hag/+7pcSsg
 y1sQbztLZKYBFQnKjPXGHPJeHhLYjozQXUwX2PID+dwSgIE7lsUfnZnmqt4EYFL+J7vd
 8lug==
X-Gm-Message-State: AOAM533dOZY4BV9kwBlofnKTpvGLjxHp0eqbVh+Ror9wQoGml0vSVDHm
 H/JOKp+uJOyEzm9jW0M1j6oPiw==
X-Google-Smtp-Source: ABdhPJyERgOgeVL3wVCpriqQyGNWjHK//8X1CsBE9mFk6+vUWHcQw5rno2Z6VjkodhRTCponllRZ+A==
X-Received: by 2002:a37:a43:0:b0:663:7c52:5421 with SMTP id
 64-20020a370a43000000b006637c525421mr458263qkk.234.1646334926465; 
 Thu, 03 Mar 2022 11:15:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b01-cbda-2ef0-5dff-fedb-a8ba.res6.spectrum.com.
 [2603:6081:7b01:cbda:2ef0:5dff:fedb:a8ba])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a05622a104700b002d4b318692esm1990346qte.31.2022.03.03.11.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 11:15:25 -0800 (PST)
Date: Thu, 3 Mar 2022 14:15:24 -0500
From: Tom Rini <trini@konsulko.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH v4 0/5] fs/erofs: new filesystem
Message-ID: <20220303191524.GF5020@bill-the-cat>
References: <20220226070551.9833-1-jnhuang95@gmail.com>
 <a028ed71-b694-2c95-094b-c50551245770@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lGQpFNrcSq0Rb43w"
Content-Disposition: inline
In-Reply-To: <a028ed71-b694-2c95-094b-c50551245770@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--lGQpFNrcSq0Rb43w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 03, 2022 at 10:51:18PM +0800, Huang Jianan wrote:

> Hi Tom,
>=20
> Would you mind taking some time to check if this version meets
> the requirements =EF=BC=9FSo we could have a chance to be merged
> into the next version ?
>=20
> I have triggered a CI via Github PR based on this version :
> https://github.com/u-boot/u-boot/pull/133

It seems fine, yes.  The thing about that PR is that it doesn't use a
custom build of the Docker container that also has the tools, so the FS
tests aren't actually run.  I'll do that when I get to testing and
applying this, but if you can do that before hand to ensure the tests
really do run and pass, especially on Azure where things can be a tiny
bit trickier (since source directory is enforced read-only), that would
be great.

>=20
> Thanks=EF=BC=8C
> Jianan
>=20
> =E5=9C=A8 2022/2/26 15:05, Huang Jianan =E5=86=99=E9=81=93:
> > Changes since v3:
> >   - update tools/docker/Dockerfile;
> >=20
> > Changes since v2:
> >   - sync up with erofs-utils 1.4;
> >   - update lib/lz4 to v1.8.3;
> >   - add test for filesystem functions;
> >=20
> > Changes since v1:
> >   - fix the inconsistency between From and SoB;
> >   - add missing license header;
> >=20
> > Huang Jianan (5):
> >    fs/erofs: add erofs filesystem support
> >    lib/lz4: update LZ4 decompressor module
> >    fs/erofs: add lz4 decompression support
> >    fs/erofs: add filesystem commands
> >    test/py: Add tests for the erofs
> >=20
> >   MAINTAINERS                         |   9 +
> >   cmd/Kconfig                         |   6 +
> >   cmd/Makefile                        |   1 +
> >   cmd/erofs.c                         |  42 ++
> >   configs/sandbox_defconfig           |   1 +
> >   fs/Kconfig                          |   2 +
> >   fs/Makefile                         |   1 +
> >   fs/erofs/Kconfig                    |  21 +
> >   fs/erofs/Makefile                   |   9 +
> >   fs/erofs/data.c                     | 311 +++++++++++++
> >   fs/erofs/decompress.c               |  78 ++++
> >   fs/erofs/decompress.h               |  24 +
> >   fs/erofs/erofs_fs.h                 | 436 ++++++++++++++++++
> >   fs/erofs/fs.c                       | 267 +++++++++++
> >   fs/erofs/internal.h                 | 313 +++++++++++++
> >   fs/erofs/namei.c                    | 252 +++++++++++
> >   fs/erofs/super.c                    | 105 +++++
> >   fs/erofs/zmap.c                     | 601 ++++++++++++++++++++++++
> >   fs/fs.c                             |  22 +
> >   include/erofs.h                     |  19 +
> >   include/fs.h                        |   1 +
> >   include/u-boot/lz4.h                |  49 ++
> >   lib/lz4.c                           | 679 ++++++++++++++++++++--------
> >   lib/lz4_wrapper.c                   |  23 +-
> >   test/py/tests/test_fs/test_erofs.py | 211 +++++++++
> >   tools/docker/Dockerfile             |   1 +
> >   26 files changed, 3269 insertions(+), 215 deletions(-)
> >   create mode 100644 cmd/erofs.c
> >   create mode 100644 fs/erofs/Kconfig
> >   create mode 100644 fs/erofs/Makefile
> >   create mode 100644 fs/erofs/data.c
> >   create mode 100644 fs/erofs/decompress.c
> >   create mode 100644 fs/erofs/decompress.h
> >   create mode 100644 fs/erofs/erofs_fs.h
> >   create mode 100644 fs/erofs/fs.c
> >   create mode 100644 fs/erofs/internal.h
> >   create mode 100644 fs/erofs/namei.c
> >   create mode 100644 fs/erofs/super.c
> >   create mode 100644 fs/erofs/zmap.c
> >   create mode 100644 include/erofs.h
> >   create mode 100644 test/py/tests/test_fs/test_erofs.py
> >=20
>=20

--=20
Tom

--lGQpFNrcSq0Rb43w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmIhE8UACgkQFHw5/5Y0
tyzyLAv9G4LcW4NmRff8A8DXbtNwYgDIuyOTmvzkOfp9qyWTal+vcISYPo4wZEZM
1sfXkNk8zjUzkumd6CCGcrCU6YXwAsRky1V2Bs1BYzRMqfCgByQ6kP1EwnXa39D2
e8w7FEym8CkJdM3/COZ0B9RPQIBsKKjjWpB5ulHQ+8NXNkdObxsaH8ApPyKFosHz
Y6ah0lHmfQQSqyKMaPhgSFebnqKYzcAdOCDOdh3K8AqDvNg/VChcMgrlo56m6A0V
7HgBudzeVdjlveFTT39z0UFkfyMMkj9Vxdu3Xh88UeHviC46Fp4yHdLQESxOGk23
sDPE9CP9/EnqHtNV7uhXrdUmgRKuom6VEJ2zBo9EyeBrgQzcwiS25DroFqz8Y+ti
AUyJdUFjWTni8VuVEdEb9lwjOCq9618QDtrZS52NeGXet+WbfR5ChmfP6ui4iuUf
AdGlLONVQTkgD/geFjSR20UBMBdTL4DJfokIwyYUDBkXRYsDfmkVsj6SSIg5vtFZ
lz+8Xl5I
=OeRq
-----END PGP SIGNATURE-----

--lGQpFNrcSq0Rb43w--
