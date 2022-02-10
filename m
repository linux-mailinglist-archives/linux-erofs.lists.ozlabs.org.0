Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B5C4B0E10
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Feb 2022 14:03:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JvcPS3RZQz3bY3
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Feb 2022 00:03:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Fatb/AC2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::730;
 helo=mail-qk1-x730.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Fatb/AC2; dkim-atps=neutral
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JvcPP3Wl8z3bTy
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Feb 2022 00:03:19 +1100 (AEDT)
Received: by mail-qk1-x730.google.com with SMTP id g145so4694156qke.3
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Feb 2022 05:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KLEF0g27NpGUpINJYAK/lQp6tMP7RpaLA3kXOfEqSnU=;
 b=Fatb/AC2+fhVyrxmDkC1Pg14HeMBFxbJxOspS5mdPk3hDt7lJC+Wb9zefR3yo3c5FJ
 4YfiH0cSaD9wGksgRg2xsKDiI9RnGNwBEFeYSO7dego3XB3m2zZA2wqCOXb898gHTwwV
 q8NgDNkV7gaWhYHijBDy+R52nmEw7Wo8sNRZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KLEF0g27NpGUpINJYAK/lQp6tMP7RpaLA3kXOfEqSnU=;
 b=efTQt2fvq+P9Zu+aG9t6LSB9a8eLswKZ1iiedA89HMVgliY8kUr9Z/1wHel85V/HmI
 naE7eGmJur4K3oOSLaXvkdAY2KPLPbG/gf/I/qaCL3CDGZ4QEcmyiXO3NQRUAc6WeVTC
 neqqrwqGJMAd0cxWugEunnNgTyKZl1Hm1iK0fIMwBz0l3BpRzWBOzPuLqkLO8hQtJdKj
 Ux19O6n0SO0sEXETQl/+fxSM3iFucQN2zs8RnDRkwax5eyRv7NEas7kAkcXSbsuFvRoV
 BpvPePkgy0j5RM2txuYOlcC6kly47EYL1hUQnG6/le18mS+vXkGHC4FxymhL5VqmP74d
 NO2w==
X-Gm-Message-State: AOAM5338+V95s0tWOn13NQz9gS7rcZ4n/y8DMpic6v0edALup07qEftp
 i2Wyerz7VUftmTRmVNihQR1jyQ==
X-Google-Smtp-Source: ABdhPJwMxis5jCislWhRgSIw8qpxkohKa3dh14LIyUg5wmDisB55yECLcCjg4RxII6ccqfbK8CL1vw==
X-Received: by 2002:a05:620a:c41:: with SMTP id
 u1mr3650078qki.31.1644498195077; 
 Thu, 10 Feb 2022 05:03:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b01-cbda-2ef0-5dff-fedb-a8ba.res6.spectrum.com.
 [2603:6081:7b01:cbda:2ef0:5dff:fedb:a8ba])
 by smtp.gmail.com with ESMTPSA id x3sm7637383qkp.54.2022.02.10.05.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Feb 2022 05:03:14 -0800 (PST)
Date: Thu, 10 Feb 2022 08:03:12 -0500
From: Tom Rini <trini@konsulko.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH v3 5/5] test/py: Add tests for the erofs
Message-ID: <20220210130312.GD2697206@bill-the-cat>
References: <20210823123646.9765-1-jnhuang95@gmail.com>
 <20220208140513.30570-1-jnhuang95@gmail.com>
 <20220208140513.30570-6-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <20220208140513.30570-6-jnhuang95@gmail.com>
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


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 08, 2022 at 10:05:13PM +0800, Huang Jianan wrote:

> Add Python scripts to test 'ls' and 'load' commands, as well as
> test related filesystem functions.
>=20
> Signed-off-by: Huang Jianan <jnhuang95@gmail.com>
> ---
>  MAINTAINERS                         |   1 +
>  configs/sandbox_defconfig           |   1 +
>  test/py/tests/test_fs/test_erofs.py | 211 ++++++++++++++++++++++++++++
>  3 files changed, 213 insertions(+)
>  create mode 100644 test/py/tests/test_fs/test_erofs.py

Please update tools/docker/Dockerfile so that we can run these in CI as
well, thanks.

--=20
Tom

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmIFDQ0ACgkQFHw5/5Y0
tyz0ugv8CJAFffDXPjZ6HzyEAlSECTt28BTARUUx+SbNtGKdR94lknS0GS8UnlPZ
GLq3+u1JvLqQ3BrENDIeT6GSDml42G3Vo8HM2CIHarbh/ifnVbP0frKDiPFXDqI+
0VZfUIDPszKcQHnFsgDwTrJ+VDfHU/VOczaubuUX24SxkStp3O+MEg40QQXU5SVs
b833YnWW65qUtyQ5scSw5bZtIamqu38TMomGpQA8GHjMId8a7xtdByhyNyPDuPRa
utAn09smCUoj50vrglRz5G7DcaJEV3xpqtxqWVoJB852Wk6YNcwBs//UI07q/B9M
BbBDsiojDjmJfZ4chPvoUBhQutEHkG9JNlB90zs/yCtcE/z5AD3quEE9QQ7No9I4
gmF42dm7StxGNjW88hvsPDtLc/wAOILJBPiveuw2EvSMH66j2SzbKyIfmPYVwl5k
bhZ9+p4Pozz/ximuvsuAP8MAj+itV5+gjkb7R/i8XQu2yAOewi1ePA6S+cuDmQPN
88IkadBc
=kUnB
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
