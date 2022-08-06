Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECEE58B378
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Aug 2022 04:45:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M06JQ06V8z2yn3
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Aug 2022 12:45:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=rrBstr/G;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=trini@konsulko.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=rrBstr/G;
	dkim-atps=neutral
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M06JJ5GsBz2xGm
	for <linux-erofs@lists.ozlabs.org>; Sat,  6 Aug 2022 12:45:02 +1000 (AEST)
Received: by mail-qt1-x831.google.com with SMTP id ff27so566667qtb.11
        for <linux-erofs@lists.ozlabs.org>; Fri, 05 Aug 2022 19:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=FB+XeVQ80mrQdXWFBUx+uWLxEpxIeWoWY/F5wj4d6Gg=;
        b=rrBstr/G7EJ/ByIa+f4a34GP7PBKkxCcJtxyhEiWifJUr3SRhvBux0tAdWZ951WX9H
         BSomfAC5vdoUmI3EyA/mZo/9LPSgb5QQpr0rs1OWvhVXU7Zv4lJjY4BSoCWtqYZS2bNg
         Ak9w2IR/+oK2OLDCF6X+ahbvaKF3Idya/8Olo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=FB+XeVQ80mrQdXWFBUx+uWLxEpxIeWoWY/F5wj4d6Gg=;
        b=Uaj5z1Zfl/Q+CMpIlrl3BjDTMUpIACLom6IkfV2ogfF+rLCD7JpoRSgwQac/gipqhg
         R9O4Ygya8p9/Cq84aeOwbUS3tqCxz/Tgu42SKwXbj9lsIVcmU6firOmgWfN/BPbM5ucW
         ewzBia6zRLw5ewE6Z/Kd+2FS0pSm9IgB7z57PjOBz6a+C6PSD3wxpDU/2K3bP3doNAKp
         EQBTRdKDOn2SPxB7ZR3J8gGYoEvS7x81KLbeAu+nm8I/RX/0jFoYSuftqam29fcwPsqn
         T+mgyzU5/uM76TN0guvkveEKiHTMEA8Huw6o5MfDPj3VB46deK6HSskU9n8fB1u1Hj93
         3wCw==
X-Gm-Message-State: ACgBeo3NdDj36eRb6YF/ZmjNp9CIWwQFgbqTL184xYnZuZ9Z8HqGq7UX
	IKribM7loDxNxALdDU6xgus7Eg==
X-Google-Smtp-Source: AA6agR67MIcXg2DyFEHNmIhZA9Zgf7j3WpoF9+yLOQ5XhM9N1ElRgZ2FZ3W+66i8yfoLqB9dnzvVJQ==
X-Received: by 2002:ac8:5ad1:0:b0:31f:1c49:e1ee with SMTP id d17-20020ac85ad1000000b0031f1c49e1eemr8530995qtd.624.1659753899358;
        Fri, 05 Aug 2022 19:44:59 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-195-139.ec.res.rr.com. [65.184.195.139])
        by smtp.gmail.com with ESMTPSA id v21-20020a05620a0f1500b006b5f0e8d1b9sm4056007qkl.81.2022.08.05.19.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 19:44:58 -0700 (PDT)
Date: Fri, 5 Aug 2022 22:44:55 -0400
From: Tom Rini <trini@konsulko.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 1/8] fs: fat: unexport file_fat_read_at()
Message-ID: <20220806024455.GF1146598@bill-the-cat>
References: <cover.1658812744.git.wqu@suse.com>
 <ee01c16f20f02230c3cfd0b266f06564fa211f62.1658812744.git.wqu@suse.com>
 <20220805211420.GA3027583@bill-the-cat>
 <99d73f60-868c-28e9-e862-04a934e741ef@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7TMqqwj3UF3xJXrt"
Content-Disposition: inline
In-Reply-To: <99d73f60-868c-28e9-e862-04a934e741ef@gmx.com>
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
Cc: joaomarcos.costa@bootlin.com, marek.behun@nic.cz, u-boot@lists.denx.de, Qu Wenruo <wqu@suse.com>, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--7TMqqwj3UF3xJXrt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 06, 2022 at 06:44:38AM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2022/8/6 05:14, Tom Rini wrote:
> > On Tue, Jul 26, 2022 at 01:22:09PM +0800, Qu Wenruo wrote:
> >=20
> > > That function is only utilized inside fat driver, unexport it.
> > >=20
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> >=20
> > Unfortunately, the series fails CI:
> > https://source.denx.de/u-boot/u-boot/-/jobs/478838
> >=20
>=20
> OK, it's a bug in the unsupported fses (which squashfs doesn't support)
>=20
> The actual read bytes is not updated.
>=20
> Sorry for the inconvenience.
>=20
> Any idea that how to run the full tests locally so I can prevent such
> problem?

The steps in CI should be able to be followed in a regular shell.  Also
see doc/develop/testing.rst

--=20
Tom

--7TMqqwj3UF3xJXrt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmLt1aQACgkQFHw5/5Y0
tyzWDAv/dPBmi6Cfn84I6cn0Ox/SenGyuwfUtoXSUKi7TqlNT6uy6vouKdj/+QaH
zDrsYKxsYkR7aa542rVn3Og0Drzlw4IW3Bk7GQl/D0XfYgl4ycopIEZ7U4FiMeO6
nzVSgsEJz+3z7e4/6LGaKcU5NmTH7rdGR2CVah05/3+/4XqB/h5qR2nIGJwDQwvv
zVailfwjcNZBDRjfs1YbUg5Knv66wTh2NvL1K59tnVXBKLvKe/9jmYHgu1O1u5s7
URwfsEH8ObYl2x4w3mpdT1yEdyTWqR2LweQLzic9KImANel2Nv/RjztgOj2wtscy
muMW2Ks9EooV52KjzQbfWmZ3ybpsCptPmv+q3/cMCxpqvaBkFXxYzqA5jKNe1Pfn
wjatx2LIH1n+1kTnWi0kCvRXSs6AFl8v7TE5BVO7cRTLh+JcjWX0I9aTRJQzlipX
3Wclr18ECOF29qHWYdsYZQhsCJJ76iraX+rEIhPl82CveQw+k1kgPeMPpy6Kqom8
yrJfKkIC
=SMbl
-----END PGP SIGNATURE-----

--7TMqqwj3UF3xJXrt--
