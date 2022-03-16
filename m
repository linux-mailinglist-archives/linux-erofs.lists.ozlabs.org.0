Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6949F4DAF60
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 13:10:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJTd9239Jz30Cm
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 23:10:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZqK2O2+S;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::f36;
 helo=mail-qv1-xf36.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZqK2O2+S; dkim-atps=neutral
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJTd418LFz30Gj
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Mar 2022 23:10:48 +1100 (AEDT)
Received: by mail-qv1-xf36.google.com with SMTP id r1so1602375qvr.12
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Mar 2022 05:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dWLvxa3pyYZwHXiBkmriCW1Rf+XFHgLd6070EH/1BXM=;
 b=ZqK2O2+SxWAFBtLM5MLu2iHLLBZDAVvCB2OfPbzUyqcjnm12thfvg2JICSPnli5sy6
 5i4DvoKvF2faHLmcbkBZAlIJREMLiSQTep3gxY+qqvcdbs/nC7Tyuz5vI8ApJD3upeaS
 bPZwoWfOM+vLA/tr9HlhW8QcmSUwiPvMhypIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dWLvxa3pyYZwHXiBkmriCW1Rf+XFHgLd6070EH/1BXM=;
 b=7d8pyoBXQcjeN7q7HCSK2U7KSyH/1zhaewRsmjCyA9p5WL2zRnnu+8Bp7CtZxfkwCI
 UzkFOdz/8DRpO/CP3yVrSwACaXESZ7Wgz172RQBHC+jnML7JqmVMFkIFrKqWZo0L9rii
 /kmCsbWt139KrGxdIMX+M9LtAcbb0trXWrrzvIyyXI60iOaaWG1uTeycz87tmQK9JM9n
 nGazTw8mRmVfwcZB2Zl0X/8Ei0U9T2kq91Xzs+P7VMeAUDyEO4nWDuw65gl5/V2joYym
 UuHYiRb0yTUbokQNK+NpoxmnPZ/mupT5S3yShqWc0QtLkc3Qz+7Lpv01z8sQOBAloUWb
 91Pw==
X-Gm-Message-State: AOAM530xMuHzqENTIsFNXW3sg3VoDjGMu9+5Zp/+y5Y54wH3zB3tOx9a
 tfUPkeZpJq7/oMmu97tA74Znew==
X-Google-Smtp-Source: ABdhPJzeBp9tKApLTNaZl1p6hoF59/p61hnmeTe7ebLGhFvMOcGyL4kdm8sm4nMEjYfgPapYACeiEA==
X-Received: by 2002:a0c:c1d3:0:b0:440:da6b:a3e2 with SMTP id
 v19-20020a0cc1d3000000b00440da6ba3e2mr775673qvh.82.1647432645367; 
 Wed, 16 Mar 2022 05:10:45 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b01-cbda-2ef0-5dff-fedb-a8ba.res6.spectrum.com.
 [2603:6081:7b01:cbda:2ef0:5dff:fedb:a8ba])
 by smtp.gmail.com with ESMTPSA id
 u17-20020ac858d1000000b002e1cdbb50besm1190618qta.78.2022.03.16.05.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Mar 2022 05:10:44 -0700 (PDT)
Date: Wed, 16 Mar 2022 08:10:42 -0400
From: Tom Rini <trini@konsulko.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH v4 4/5] fs/erofs: add filesystem commands
Message-ID: <20220316121042.GJ577378@bill-the-cat>
References: <20220226070551.9833-1-jnhuang95@gmail.com>
 <20220226070551.9833-5-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/qIPZgKzMPM+y5U5"
Content-Disposition: inline
In-Reply-To: <20220226070551.9833-5-jnhuang95@gmail.com>
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


--/qIPZgKzMPM+y5U5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 26, 2022 at 03:05:50PM +0800, Huang Jianan wrote:

> Add 'ls' and 'load' commands.
>=20
> Signed-off-by: Huang Jianan <jnhuang95@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--/qIPZgKzMPM+y5U5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmIx08IACgkQFHw5/5Y0
tywK5Qv/SSsnOAsdv8ajqun7T7NSx48pj+DrME7k5naB4ksRC+nkckVG+aVYyWRq
ssESOiSSFM5TDiK3dmPWKe8EceF3xNCYVcbjjRtyQoHHqgU2ydFipZc0rZTExlRg
47B5/+8jKCvXNwjqwLLSnhY3RzBIbc002o8tBHH5s6EIXMJePMeSXiQMreXQaisf
08Z5H/8zPLleI5qrP1OxST8InW9ea8UxxPv6F7QMG+vjFyE4yMVL7Vs6kmGYO9eX
pCg5Wwm4hEYKqNtIUlbRd6UNcCcIKcEoU3RZh9Hhr+WsYSKJ2iyJCgz1Wpj0tTM3
vuFa6aGTgicC74iSlpNrP9zKB6gwmjcr5Fg3WXk+kHpxEi87qQUGoiKuhjLBk4RN
bEInDpnsIJXyh2CfDvxIAe397jOeMC+hzq8OMJtbvJ7M9vMxtT0p8p8f5vM2vC/E
Ey/mObvoYzlTKkSCKjZRyZxZ+DuwZaQ8f/XrVaCiZItNIaoikS84Rf3ASCW4yihW
w3NabGL3
=N3l8
-----END PGP SIGNATURE-----

--/qIPZgKzMPM+y5U5--
