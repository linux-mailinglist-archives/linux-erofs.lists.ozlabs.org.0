Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3233F7EBB
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Aug 2021 00:40:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gw1Bp6tsLz2yKB
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Aug 2021 08:40:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=nRfxvR81;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::82d;
 helo=mail-qt1-x82d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nRfxvR81; dkim-atps=neutral
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gw1Bh4VBrz2yJ6
 for <linux-erofs@lists.ozlabs.org>; Thu, 26 Aug 2021 08:39:54 +1000 (AEST)
Received: by mail-qt1-x82d.google.com with SMTP id t32so870178qtc.3
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Aug 2021 15:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ApWnBmxvEbw7cKRXBAFshuPAu1dM6BwKva/L7rx4wAE=;
 b=nRfxvR81Zi1kO2uvSJ5BXuPVVF22m2zs+IR+p8NDbaeYo1s3LQLrPdavfMduEIhsWH
 WKR6MHJQX1p132x+yxA1SU1X3XHLCaK+bYWjYi1DxBFjIQf6slUXEIgeiAbuk4UeTn0Q
 gN9CY4sRTSPWiB8NIjYaZ6kVh+kWKsvuEPnM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ApWnBmxvEbw7cKRXBAFshuPAu1dM6BwKva/L7rx4wAE=;
 b=CK+BW7vGAbSYv3A3PNZTiDVKNL11k/oBKFbXGOuDioDPrjssa57o5kaV6K02/Vx1vT
 C4XtAql4lSL+OaTPlQ6E7xw7K5tpaEf1HcbEOLh3K5CdsRoBPvi9AOT33bOOaQ1BQz7V
 9LlAZc8tW88HAaDRbYaSTip+RcJdsV0VvswypduRRUSgwbOkwa9cyW1s4Zq5GN9ZrqQW
 M2M/tDAVkaVRtMGHEphcFlw9MqkhAbEfP8BnbtVTVMdatYR/mDQ5fVYEs6nSnEAe3KpR
 4YEJNBBQYDZdfp9K1XEKV7m2ZVknsaxLZ/sHXYk6t21PAGYQbCYDLAe9hbnt3SrRQj0t
 0pNg==
X-Gm-Message-State: AOAM531+hZJDYRyq4LPRGcqC9x9tPayQCpdoReMdPEtuL+ycORmgNelu
 1kyf6tYhtbHJC3P7G4GVR3U5RA==
X-Google-Smtp-Source: ABdhPJxOdtSULaC4UZSenWhpqTjlVVBpe3xw6/hP0hbPIWDrzeoSYxfRkuUn1I9UzB3G6zZ9B9rHRw==
X-Received: by 2002:ac8:1084:: with SMTP id a4mr626425qtj.212.1629931189684;
 Wed, 25 Aug 2021 15:39:49 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b01-cbda-519a-4843-2801-9790.res6.spectrum.com.
 [2603:6081:7b01:cbda:519a:4843:2801:9790])
 by smtp.gmail.com with ESMTPSA id w19sm1095561qki.21.2021.08.25.15.39.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 25 Aug 2021 15:39:49 -0700 (PDT)
Date: Wed, 25 Aug 2021 18:39:47 -0400
From: Tom Rini <trini@konsulko.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH v2 1/3] fs/erofs: add erofs filesystem support
Message-ID: <20210825223947.GD858@bill-the-cat>
References: <20210822154843.10971-1-jnhuang95@gmail.com>
 <20210823123646.9765-1-jnhuang95@gmail.com>
 <20210823123646.9765-2-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4yPG2kSYYZSJTtKp"
Content-Disposition: inline
In-Reply-To: <20210823123646.9765-2-jnhuang95@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: u-boot@lists.denx.de, xiang@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--4yPG2kSYYZSJTtKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 23, 2021 at 08:36:44PM +0800, Huang Jianan wrote:

> From: Huang Jianan <huangjianan@oppo.com>
>=20
> This patch mainly deals with uncompressed files.
>=20
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
>  fs/Kconfig          |   1 +
>  fs/Makefile         |   1 +
>  fs/erofs/Kconfig    |  12 ++
>  fs/erofs/Makefile   |   7 +
>  fs/erofs/data.c     | 124 ++++++++++++++
>  fs/erofs/erofs_fs.h | 384 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/fs.c       | 231 ++++++++++++++++++++++++++
>  fs/erofs/internal.h | 203 +++++++++++++++++++++++
>  fs/erofs/namei.c    | 238 +++++++++++++++++++++++++++
>  fs/erofs/super.c    |  65 ++++++++
>  fs/fs.c             |  22 +++
>  include/erofs.h     |  19 +++
>  include/fs.h        |   1 +
>  13 files changed, 1308 insertions(+)
>  create mode 100644 fs/erofs/Kconfig
>  create mode 100644 fs/erofs/Makefile
>  create mode 100644 fs/erofs/data.c
>  create mode 100644 fs/erofs/erofs_fs.h
>  create mode 100644 fs/erofs/fs.c
>  create mode 100644 fs/erofs/internal.h
>  create mode 100644 fs/erofs/namei.c
>  create mode 100644 fs/erofs/super.c
>  create mode 100644 include/erofs.h

Do the style problems checkpatch.pl complains about here match what's in
the linux kernel?  I expect at lease some of them come from using custom
debug/etc macros rather than the standard logging functions.  Thanks.

--=20
Tom

--4yPG2kSYYZSJTtKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmEmxrAACgkQFHw5/5Y0
tywuqgwAkKsSYH9yHh8flafyoJrmyS6WDMRKwH/hGkup8p87BaRmmWZuC6R2bI5c
0c7cW5CLkOsdn1sQTqcvLijPEfulTDdW6E1baySGtUyB8cUUWqB+h3+mWUxWZjFc
PhPYPMDl2BaMD+OuJ6oUN13AUIYONfUNHFFqPdKkqQHQyPDnfinihxrXzDs41EY5
Kmhzm2IY6VNIltu5LHG64+ZhlQ+rjeSvK8jC726VkiV8t0ehLqlVGc/GrDA4fxwK
kzMF5As0KJrRT2r0fdCWLobwIzPcGAwji0oX7JYGkl+Nd6aKFs+M61DMoC6eNpV9
Z5B7x6ZDwIge0R0pq5XIdLm8T2/JVTXLt60ukh1S/2SWnCXl8gR8rDJeqwvcxvTE
nbQaXHU1dw6Ktk0gJD4cMos9inZuKcNvlasq05V+wQ91JAb/tu6mRRQ8uKI1CYy6
0vIXIPtv6kOCK+nM68uhQ2FAZhR4en6AKMn4UzsWbZN1E2mzwrSAqV7OAxNccIuo
Nz4hnb0t
=/OM2
-----END PGP SIGNATURE-----

--4yPG2kSYYZSJTtKp--
