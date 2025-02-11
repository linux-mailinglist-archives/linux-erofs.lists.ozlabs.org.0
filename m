Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B5BA317B5
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2025 22:29:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ysvhs13XYz3blF
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 08:29:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739309356;
	cv=none; b=brGyAgiAA9OX9FnbsbX7idv2cc813q4gD/KaqS5ahEGzwb7ExUvv7MUfJoJF4VfnSlR7EMITDlkU48SJIYsVXrpA0EryuqVjIP40ZfU682OGEOq/F0C8eX3n3YUvcv2/BDVdIBGB/Dr492YV8lmjJMlPvfumjhKL0yPebW9Dkqiun3XVH31QB/NLGEOcemTmAGqEh3pRehl1/P6crwBhdbgkIIQi6CYfJj6WDfr3Anwk1TAMRbk2prM8gDh9sXKgYIi/Xwj5yKBAA4AU1vTFI4XcT8SrKc03DYPAPcGXsN2vNtQV1s2nOmbcuEF2YRo213NU0eoLta724M1ToQnkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739309356; c=relaxed/relaxed;
	bh=CRTs7G6i3v93mDWeUBdzW8G+iPnbGQ6HqdZysyJzan8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grxvo00ppU6iu+oh7EdxcC7LGmeOoV++ycl4zd28kP/q1Tl2KJvcH/Gm30GYyI8GVewg7juFwEgWIoFEPY8r57PXMn5mxKtwSinq5f/NRARflcgjR/lpN4WHLUzyDKnRNP104hkT5WO0Viex3/INlpY7Vci3VjXsg87rNfMYeKH679Qd4F9u3kv2uyXC9j49jP2vUjbgLPSVUl2ZKx1wV+Z39kQgD/5PGYHqQ+4Ne7DgmtQYryLAPQTqwaq4Nw9MC78saLBbIKnpmzR7wA9JhYjmTKmmDYWdgGF35Tmk7Ea8tMziuodfkTlsd+4Y5CoC3w0Can0+hlj0VQ0bs8AbEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ozoyVgrV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org) smtp.mailfrom=konsulko.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ozoyVgrV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ysvhq3P4gz2ysf
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Feb 2025 08:29:14 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-21f6d2642faso91306465ad.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 11 Feb 2025 13:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1739309353; x=1739914153; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRTs7G6i3v93mDWeUBdzW8G+iPnbGQ6HqdZysyJzan8=;
        b=ozoyVgrVcvaNccOTKYTrdt+SeycYqxTg04W9JqAiSHxTW14E9U9djE0Zp2UjA6tjaq
         G/qSdlPleoTAhIu9gRHrhfCiWitPtVQJePvzet/70ANBDW3mrmWIbrSegCuk/GZWDrXS
         ECqb3O5ezt45wdybXksLxzPt9A0fBq+ss+BeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739309353; x=1739914153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRTs7G6i3v93mDWeUBdzW8G+iPnbGQ6HqdZysyJzan8=;
        b=W06vZscj8gXqDNPJ4ta2JPdqHtwwmDOVcsKQ/E7mXJfnWoiD5usZC1raiJdvZRW4Ac
         mewuGMS9dSp0VqgH5iez+2nJTerQS313id+z3dlcCPrrNv9UqU9SAgnCCbwBP4CcfVTI
         H9ekkzLUyhCAcfmL2bk1qSMRoI/gcPM319cgRy2ELmtjhHpvzSk92J4uIuldMGOQqWOt
         z3QUhVQod8tUL/9gNT0SaUfGrAxIEme4yVe+E4o0PEI5fG3UV4pj7Cr+EVBma+tO9sAI
         mVBmZgPFUICbMQxgLszymUnWQ/H+fSVXnzMSiygolBalFUnEETnUeBlGnu6h86677oMO
         oZtg==
X-Forwarded-Encrypted: i=1; AJvYcCUld5zMlQBzLyx6FbNscv/icurAS69a8y+GnKSyHXUBLT2iP4a/1USGEESEKuVB+BoyNUfHkU50RJ2UyA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzaoBidWBOxmSLfZRQvhnxzrZ6oGAY9PBRJ56H9bW5u1Ow03tes
	PYypSjh7DBrpvblZMARf1gAYUn9F3NHhCTQHxuuaBCSLpy2O/xVgceCVbBsW+Ms=
X-Gm-Gg: ASbGnctTOCyGL9gYv0xbhxNBVtA0YVEAs+PAE3nuWXVLENqZt5NToOlY8NRKrWz1i0z
	cytvEAjRgJGfHDEBR+QEZNLGZoSRXKx0g3X0rNXjARd6DcStyei/idyaJlhKKrxGtWWRIoWScbb
	Eadf4qSZ05H1PzpSwNcSYJrDVPH/hdXU1SxWvby+J0uyhZNL/MahlaR8st1FaEW++Is2amrJrHO
	eUpRo+uECLQS8LXWAKw9ziucE9M+3kgN4lDsF1BbwzwKJM7Kip6ZCEz7+mWmZGLiNWlfTeCqiUE
	wX9jAkqsFS09nIA=
X-Google-Smtp-Source: AGHT+IG1xr9VC7XBUWx+v2r1uZF4jmkMjJIdIJoBn61twFjSmdSjdCbTjAKiZlMokbJbjn7Xsd1A+A==
X-Received: by 2002:a05:6a00:9286:b0:730:9204:f0c3 with SMTP id d2e1a72fcca58-7322c4116bemr797173b3a.23.1739309352808;
        Tue, 11 Feb 2025 13:29:12 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048e20c32sm10102954b3a.170.2025.02.11.13.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 13:29:12 -0800 (PST)
Date: Tue, 11 Feb 2025 15:29:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonathan Bar Or <jonathanbaror@gmail.com>
Subject: Re: Security vulnerabilities report to Das-U-Boot
Message-ID: <20250211212909.GI1233568@bill-the-cat>
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
 <20250207155048.GX1233568@bill-the-cat>
 <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat>
 <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
 <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EOLOpZqCsF/TXrAC"
Content-Disposition: inline
In-Reply-To: <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--EOLOpZqCsF/TXrAC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 08:26:37AM -0800, Jonathan Bar Or wrote:
> Hi Tom and the rest of the team,
>=20
> Please let me know about fix time, whether this is acknowledged and
> whether you're going to request CVE IDs for those or if I should do
> it.
> The reason is that I found similar issues in other bootloaders, so I'm
> trying to synchronize all of them. For what it's worth, Barebox has
> similar issues and are currently fixing.

Yes, these seem valid. We don't have a CVE requesting authority so if
you want them, go ahead and request them. You saw Gao Xiang's response
for erofs, and I'm hoping one of the squashfs maintainers will chime in.

>=20
> Best regards,
>              Jonathan
>=20
> On Mon, Feb 10, 2025 at 7:51=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibab=
a.com> wrote:
> >
> > Hi Tom,
> >
> > On 2025/2/11 00:41, Tom Rini wrote:
> > > On Fri, Feb 07, 2025 at 09:53:01AM -0800, Jonathan Bar Or wrote:
> > >
> > >> Thank you.
> > >>
> > >> So, I'm attaching my findings in a md file - see attachment.
> > >> All of those could be avoided by using safe math, such as
> > >> __builtin_mul_overflow and __builtin_add_overflow, which are used in=
 some
> > >> modules in Das-U-Boot.
> > >> There are many cases where seemingly unsafe addition and multiplicat=
ion can
> > >> cause integer overflows, but not all are exploitable - I believe the=
 ones I
> > >> report here are.
> > >>
> > >> Let me know your thoughts.
> > >
> > > Adding in the eorfs and squashfs maintainers..
> > >
> > >>
> > >> Best regards,
> > >>              Jonathan
> > >>
> > >> On Fri, Feb 7, 2025 at 7:50=E2=80=AFAM Tom Rini <trini@konsulko.com>=
 wrote:
> > >>
> > >>> On Thu, Feb 06, 2025 at 07:47:54PM -0800, Jonathan Bar Or wrote:
> > >>>
> > >>>> Dear U-boot maintainers,
> > >>>>
> > >>>> What is the best way of reporting security vulnerabilities (memory
> > >>>> corruption issues) to Das-U-Boot? Is there a PGP key I should be u=
sing?
> > >>>> I have 4 issues that I think are worth fixing (with very easy fixe=
s).
> > >>>>
> > >>>> Best regards,
> > >>>>              Jonathan
> > >>>
> > >>> Hey. As per https://docs.u-boot.org/en/latest/develop/security.html
> > >>> please post them to the list in public. If you have possible soluti=
ons
> > >>> for them as well that's even better. Thanks!
> > >>>
> > >>> --
> > >>> Tom
> > >>>
> > >
> > >> Filesystem-based Das-U-Boot issues.
> > >>
> > >> =3D=3D erofs
> > >>
> > >> =3D=3D=3D Integer overflow leading to buffer overflow in symlink res=
olution
> > >> In file `fs.c`, when resolving symlinks, the function `erofs_off_t` =
gets an `erofs_inode` argument and performs a lookup on the symlink.
> > >> The function blindly trusts the `i_size` member of the input as such:
> > >>
> > >> ```c
> > >>      size_t len =3D vi->i_size;
> > >>      char *target;
> > >>      int err;
> > >>
> > >>      target =3D malloc(len + 1);
> > >>      if (!target)
> > >>              return -ENOMEM;
> > >>      target[len] =3D '\0';
> > >>
> > >>      err =3D erofs_pread(vi, target, len, 0);
> > >>      if (err)
> > >>              goto err_out;
> > >> ```
> > >>
> > >> The `erofs_inode` structure's `i_size` member is defined with the ty=
pe `erofs_off_t` (which is a 64-bit unsigned integer).
> > >> Thereofre, if supplied as 0xFFFFFFFFFFFFFFFF, the `len + 1` input to=
 `malloc` would overflow to 0, allocating a chunk with 0.
> > >> That chunk (saved in `target`) is later written with `erofs_pread`, =
overriding the chunk with partial data controlled by an attacker.
> > >> Therefore, we will have a heap buffer overflow due to an integer ove=
rflow in `len` calculation.
> >
> > Yeah, it's a corner case, I will try to address it later.
> >
> > Thanks,
> > Gao Xiang

--=20
Tom

--EOLOpZqCsF/TXrAC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmerwSUACgkQFHw5/5Y0
tyzQbwv/Y++LG9rG/4fMhWzQaGEyPvQ8r6P3RkyucImnEpvCD/XsW2THxHQlq7vY
DanXxpd6wD2Q5fWoAZirBYYNDwipQoQktuOQy2QcIsV9ke3OTO1nMAtsniVexgak
ET9nw3yB6X3K5Css2yBai5OfxKDjOl+mtmsuTW0T328G2FCjk2+0nWvn+OVcD4OO
/jWvw5w3Xm8qWB5ena2PLDYtg7BMCSySucpT75/AqwT6+BytuAtQRMYfD5M9Qs5k
BRjG8kVB7pPFUxqNTT9P8w+kKgZC0OTMkw5yj+vzLhjOzP4phv94hbSeUGGRhsW7
s10btCk8imiIizCWY8vPuGmQUXz4EstfpsiJNhnnQopyZstPSlp0Db6ZHgRhtWBy
YRdFAoErzYEGm0mgOn+wsIHpPo8a1pyWAu5EfhglAXir5yBIW1mjkrthRqsLS9Pu
rdr5HRFEmqgyiwg2oVuxitxr3EJwoYfbvlDB96bdf7i+UEOR3UsabdQl/0P07h7f
sEAebW/5
=ylbr
-----END PGP SIGNATURE-----

--EOLOpZqCsF/TXrAC--
