Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365C24CE568
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Mar 2022 15:57:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K9nrB13x1z30N5
	for <lists+linux-erofs@lfdr.de>; Sun,  6 Mar 2022 01:57:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=mfz1PD9J;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::735;
 helo=mail-qk1-x735.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mfz1PD9J; dkim-atps=neutral
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K9nr63tzfz2xXy
 for <linux-erofs@lists.ozlabs.org>; Sun,  6 Mar 2022 01:57:08 +1100 (AEDT)
Received: by mail-qk1-x735.google.com with SMTP id c7so8624932qka.7
 for <linux-erofs@lists.ozlabs.org>; Sat, 05 Mar 2022 06:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Gm3Kx/9IUFJp/TIbnXfxSBSxq3xhCBUQ0PFXYVFcOXM=;
 b=mfz1PD9JfHtUiNGeztO58O1D9SQNEazlnWImctI6ngwuzXbQ4omeK8/3gBg0JkS8MS
 532uZhFDTS+zAge2DxgQ665c0RxobRImvOID0gi9SVKfn/Zx+bzAjQfdzVwWCUIWBpal
 BJhs5+6gQKVlNTxphGkQtyWgzbVVRNE6b6Qlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Gm3Kx/9IUFJp/TIbnXfxSBSxq3xhCBUQ0PFXYVFcOXM=;
 b=wArDUOb2PD9S2kENXxLDqv2cgz0Yix3cfM/ujo0sCS7Avt+owm7g8cW7ShPfY8VLXI
 P4KOTZAxlJH6fMrOZx0R5HIS0KMWL58ZKJOFILVCqfFNba81PSs1BYtr/lyjk1PWeH6H
 JOgWHrZITjotdnK1qO4kmEpV7bwmeZtwIAn3WKGL//+5oVmvXEw885S5E4oZHxHT7aRw
 38fqaJYbUyNQ0Py1BKsUswqXpEoJXP5tKmSWRQJw25/m7XAAjoRA3jeKp9gs9LGa+Ark
 V4nCg6uZQWGtW4NZYtCiaI3IGHzppcyanjUKcsZD4NIYJza5IWh6x1PtK4tq80kl+nkq
 0X2g==
X-Gm-Message-State: AOAM530dbGFudeA2Lq6jGbFqKiLcVTK8rAbu4rvMwZH5WY3m9nXVu5IJ
 6cJmGZ8e9JGE9XJRjz7H2FXabg==
X-Google-Smtp-Source: ABdhPJxr3vb1CvTDL0Y1exHXkXhqwUOyli/TiIxam5fco7N3RKczqFwcrrP1NEKZ36Qq9kGaI9Tbhw==
X-Received: by 2002:a05:620a:3190:b0:67b:3f5:803b with SMTP id
 bi16-20020a05620a319000b0067b03f5803bmr834027qkb.493.1646492225580; 
 Sat, 05 Mar 2022 06:57:05 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b01-cbda-2ef0-5dff-fedb-a8ba.res6.spectrum.com.
 [2603:6081:7b01:cbda:2ef0:5dff:fedb:a8ba])
 by smtp.gmail.com with ESMTPSA id
 p68-20020a378d47000000b006491d2d1450sm3876692qkd.10.2022.03.05.06.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Mar 2022 06:57:04 -0800 (PST)
Date: Sat, 5 Mar 2022 09:57:02 -0500
From: Tom Rini <trini@konsulko.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH v4 0/5] fs/erofs: new filesystem
Message-ID: <20220305145702.GA5020@bill-the-cat>
References: <20220226070551.9833-1-jnhuang95@gmail.com>
 <a028ed71-b694-2c95-094b-c50551245770@gmail.com>
 <20220303191524.GF5020@bill-the-cat>
 <3d6e3fb8-1b96-6f45-0aa9-9f330ee71432@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/0GU/Wxy4LypDMTk"
Content-Disposition: inline
In-Reply-To: <3d6e3fb8-1b96-6f45-0aa9-9f330ee71432@gmail.com>
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


--/0GU/Wxy4LypDMTk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 05, 2022 at 09:06:36PM +0800, Huang Jianan wrote:
>=20
>=20
> =E5=9C=A8 2022/3/4 3:15, Tom Rini =E5=86=99=E9=81=93:
> > On Thu, Mar 03, 2022 at 10:51:18PM +0800, Huang Jianan wrote:
> >=20
> > > Hi Tom,
> > >=20
> > > Would you mind taking some time to check if this version meets
> > > the requirements =EF=BC=9FSo we could have a chance to be merged
> > > into the next version ?
> > >=20
> > > I have triggered a CI via Github PR based on this version :
> > > https://github.com/u-boot/u-boot/pull/133
> > It seems fine, yes.  The thing about that PR is that it doesn't use a
> > custom build of the Docker container that also has the tools, so the FS
> > tests aren't actually run.  I'll do that when I get to testing and
> > applying this, but if you can do that before hand to ensure the tests
> > really do run and pass, especially on Azure where things can be a tiny
> > bit trickier (since source directory is enforced read-only), that would
> > be great.
> I verified the test on my own machine, but I overlooked that the container
> used in CI is prebuilt ...
> I replaced the container in the .azure-pipelines.yml with my own build and
> re-triggered the CI on this PR. Now I can see from the log that the newly
> added test_erofs is working properly.

Great, thanks for confirming!

--=20
Tom

--/0GU/Wxy4LypDMTk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmIjejsACgkQFHw5/5Y0
tyy8ZQv9Ff8lV3BacrcptGEXCkwV7sLm1+egulnzWd+KyPZrldch2fywfOYxl2c1
/4BB8AWW66EGPpx9Im8iPOrtdO1wDAP5R7cYw+6kJuNIJmbFSAV9NMT4TFAj4WD7
8R17dhHn+c+rp2pYoL0p81k9Rzroo5y/WSWewOSxEg+8xW9Ho6pakUMkiG+K5WY1
1lbtboIRCcatX+u6zux15DV/nOe6H4qP5Qzjjxg7xSN8B3SVZLfVDbqwYYUR/aKJ
U+ULglyVc4BWY+ZmrqBScsiTDE17XmVpg4lbg6/VvJggNPmPUBOSc/wcQCrNLDwm
wJc+tWEMhPBvYBYRoNYjkb4OqSvDlSsTFXgVPkxSPx8QigFX2fCv5VZMD6jkr3A+
VwCq3PCrsIieYVRDT4ts1AnxyPeHWwzj/QvOBfFUA2zZhP8IaEfEc6hDA5IfPLC0
gyBjAOzAI9U/0TsrPVjXkSkYhisc1li+4gj6B0H8UZuVN+UblhsHbexWOP9AxI2q
qeDca+KF
=KNYg
-----END PGP SIGNATURE-----

--/0GU/Wxy4LypDMTk--
