Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419F6A44934
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2025 18:59:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2QNL3pk7z3bkP
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Feb 2025 04:59:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::a31"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740506368;
	cv=none; b=J566MvYJB1dgz8DFrL0qyyLdnemghxrtMTZ8lpZxyvaJf/5ZYxAm+8r9NMo30CpWv/QQL4Sc/Xul9RSBSGtScU4Sm0ImX/8eIKH6wFxMWDy05AhjcD5CuablzyJm79+YZixeFE0BznqoKXj9BClG7kilXQrmMRx72+8lc3miK7ZvS/OenRH9eMvEPLiYCOCh4cfxz939EGFdKej8w5wZk6rsKJum67msJDvKD1O20IJ/SSJ3JpM3gpqrDt1YCZCUpZW7AXeArsDzQWlAvUDSSvAHSgSZ5pem5dPF6SAsx4GjztV4m6oJ4zZyHTzydfMW6iPv7XQz9WZO2Nhim33lyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740506368; c=relaxed/relaxed;
	bh=Yzq0j5IAn3sD7/CXGlwhPFUEy0VyUUgkmFQlMEBm7sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HH/s9iS6irwo0QW9vcdNGLUEE1vf6KsKiexZjl4V03frkKKsf7tftyXKi0kp9o9Q3YfjichafxUQxtbzbrgOxpbi/Fz2FpA+CLAtZwtiKO+laZImTpvE4HpgQF8AP40tsQhTU0SUXFkqFeQ8hSOW4fAcUvjGmBbAZnwFr4tALryV4yg1qE1VYEctoEhRH3jCdU2DbYJZHrZjo31X1FOk72/A958FSqQ839zSmt8Ihhltd3LnnLPdu7uWPJOZQpCSE0eSEABtzJbX6jwpeKd3b/ySBAuuQxNEpDCHFLaZ2MhAb40Gmlp5oHLkoPdC75WmU52cSfp1Pq09AH0oY4zWiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=CvNzv/3p; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::a31; helo=mail-vk1-xa31.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org) smtp.mailfrom=konsulko.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=CvNzv/3p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::a31; helo=mail-vk1-xa31.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z2QNH1GwZz2xKh
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Feb 2025 04:59:26 +1100 (AEDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-520af4b872bso1547309e0c.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 25 Feb 2025 09:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1740506363; x=1741111163; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yzq0j5IAn3sD7/CXGlwhPFUEy0VyUUgkmFQlMEBm7sw=;
        b=CvNzv/3pnh8l89+FJcKgtxXoH+e3fpLKHkej/2MgbqSsaCL2Il0Z+IFJRgDC4ID4eX
         TUjiSXx/tX7qAaQ0luJcsEafTfLitPkTCvtMKLvKY+ov1VCHjmV9riZrOYCY5f/VW10Y
         4MWokNRioM8PDVI8OSANIBE4hKEHg16MxccnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506363; x=1741111163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yzq0j5IAn3sD7/CXGlwhPFUEy0VyUUgkmFQlMEBm7sw=;
        b=JTZccharJShBiQleil9ND5EgQOxOlIWzNVqamqcrGpWP8u5tTZLCY2JGKAxXN9hMCp
         JS/G3DjbpFJqhqAlEViUxFZ03FqY3YaeaKARiQMWkRHlFjeBlB1Euhk0tPKz/vqDlpka
         OeFnUorlwMEEg165I+CKvxOlPysu0zUtvRXhEO0ZbOBgh1Be7wowZQcAKbmcosFVDkYG
         FNFtKqxvgrrGN4wp2lrgdLDvPmV63I9VA+jErD9W6J02jmvCo03lnX87I+i/oA+M6bSK
         5UALIuDT5Sc7cBhwO8Qz3FPdq36DkfmTbQToIA3K1jbj2Q6QTkzgmO4FWawlSyHOE/yy
         3HSg==
X-Forwarded-Encrypted: i=1; AJvYcCVem1ErBd6QySqkPXr1P6tq0bt/I5rHRHZAn0mkS8o3e5Uxl5kmOd/3S/HFhElA2+WLEOnD+DqcJ1mksg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwUsPzCkc4sdd+6gdzLKBKoaAj0LhehKUePcQSAxUGkjko6VKp4
	aBoJKBRs78MA4uGXca2K8y95tq4IFUzRlhEjt5UjBlX+GD4yWxiar1TDoYcbG8oy1YuzX1jxSI1
	c
X-Gm-Gg: ASbGncspWWHrlv383/hbdY5QD/rONnQAUKYlHsgRzrDJbXjrJRjXWHbd9CmBGYRZ4G9
	ktVTZbXQkeSeGRyyNzptrVQKWRIg6Ix1i1gjonZ44e7gi+uQJUpE3VC4QjXRvKlTPZi3TTiFkGq
	EzkzLYMi+ZYGgBaD1QkgAS1IN++7k610NyYxFQBg2k+YJGFY9t9lrg+4pFHzESv5CR8U+2z0zco
	1QlmWkBb728qaOxJlfagPzQW5GaDCz860iBaamEA2BNUQkPd/4NF6qarNaTzlr4WSErAf/16A0l
	aq2soLIlfLya+XMOJolAIP0z
X-Google-Smtp-Source: AGHT+IGabwerju1Imh4dTxynGtibP1U/FqxBhXpmyBM9wo45zg/M1sGxbA4/0xyCaYiRQFr1cIWFRg==
X-Received: by 2002:a05:6122:4286:b0:520:3465:7302 with SMTP id 71dfb90a1353d-5223cc12bf8mr2750324e0c.5.1740506362988;
        Tue, 25 Feb 2025 09:59:22 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5223e1e4d7dsm281760e0c.42.2025.02.25.09.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:21 -0800 (PST)
Date: Tue, 25 Feb 2025 11:59:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonathan Bar Or <jonathanbaror@gmail.com>
Subject: Re: Security vulnerabilities report to Das-U-Boot
Message-ID: <20250225175918.GQ1233568@bill-the-cat>
References: <20250207155048.GX1233568@bill-the-cat>
 <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat>
 <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
 <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
 <20250211212909.GI1233568@bill-the-cat>
 <8734gjsh8t.fsf@bootlin.com>
 <CABMsoEGq+s2qudAHVwydpwXw_ROVfgw90yU7+VKYO6x27AWdew@mail.gmail.com>
 <CABMsoEFcL-D2OzJWQM685TfLq20L+d2gNmy4XD7yW6aDwpKb4w@mail.gmail.com>
 <CABMsoEEQPvHM7jKYZZE1UaTgVTuN-TneVi8X9LRsr3+bD7xH3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qv+uw9jvr52Cxb9K"
Content-Disposition: inline
In-Reply-To: <CABMsoEEQPvHM7jKYZZE1UaTgVTuN-TneVi8X9LRsr3+bD7xH3Q@mail.gmail.com>
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
Cc: u-boot@lists.denx.de, Joao Marcos Costa <jmcosta944@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--Qv+uw9jvr52Cxb9K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 12:47:45PM -0800, Jonathan Bar Or wrote:

> Hello Tom and team,
>=20
> Looks like all of the issues were fixed and merged - am I correct?
> I intend to make a public disclosure March 19th, is that okay?

Yes, I've merged all of the patches I'm aware of at this point.

>=20
> Best,
>        Jonathan
>=20
> On Fri, Feb 14, 2025 at 7:24=E2=80=AFPM Jonathan Bar Or <jonathanbaror@gm=
ail.com> wrote:
> >
> > Please disregard the previous message, those are the actual CVE numbers:
> >
> > - CVE-2025-26726 :SquashFS directory table parsing buffer overflow
> > - CVE-2025-26727: SquashFS inode parsing buffer overflow.
> > - CVE-2025-26728: SquashFS nested file reading buffer overflow.
> > - CVE-2025-26729: EroFS symlink resolution buffer overflow.
> >
> > Best regards,
> >            Jonathan
> >
> >
> > On Fri, Feb 14, 2025 at 7:17=E2=80=AFPM Jonathan Bar Or <jonathanbaror@=
gmail.com> wrote:
> > >
> > > Hi folks.
> > >
> > > Here are the CVEs assigned by MITRE:
> > > - CVE-2025-26721: buffer overflow in the persistent storage for file =
creation
> > > - CVE-2025-26722: buffer overflow in SquashFS symlink resolution
> > > - CVE-2025-26723: buffer overflow in EXT4 symlink resolution
> > > - CVE-2025-26724: buffer overflow in CramFS symlink resolution
> > > - CVE-2025-26724: buffer overflow in JFFS2 dirent parsing
> > >
> > > Best regards,
> > >            Jonathan
> > >
> > > On Wed, Feb 12, 2025 at 12:24=E2=80=AFAM Miquel Raynal
> > > <miquel.raynal@bootlin.com> wrote:
> > > >
> > > > Hello Tom,
> > > >
> > > > On 11/02/2025 at 15:29:09 -06, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > > On Tue, Feb 11, 2025 at 08:26:37AM -0800, Jonathan Bar Or wrote:
> > > > >> Hi Tom and the rest of the team,
> > > > >>
> > > > >> Please let me know about fix time, whether this is acknowledged =
and
> > > > >> whether you're going to request CVE IDs for those or if I should=
 do
> > > > >> it.
> > > > >> The reason is that I found similar issues in other bootloaders, =
so I'm
> > > > >> trying to synchronize all of them. For what it's worth, Barebox =
has
> > > > >> similar issues and are currently fixing.
> > > > >
> > > > > Yes, these seem valid. We don't have a CVE requesting authority s=
o if
> > > > > you want them, go ahead and request them. You saw Gao Xiang's res=
ponse
> > > > > for erofs, and I'm hoping one of the squashfs maintainers will ch=
ime
> > > > > in.
> > > >
> > > > Either Jo=C3=A3o or me, we will have a look.
> > > >
> > > > Thanks,
> > > > Miqu=C3=A8l

--=20
Tom

--Qv+uw9jvr52Cxb9K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme+BPIACgkQFHw5/5Y0
tywZTQv/Y356nJw+qtF7DNuhc/jA0QViBtH9BpG68DIe3E6MCgDmqyal2DHgfpD6
LY5L2aLXXQL/formvyBk6BnCNiXyzbiy1N14e8Mp6TmHRPJ9/l0CH8+PMfoHgIgn
NCGLxpVdCfz6CP89sovVIMnWWtuWY1jAJHenOr0xuxrvlTPwS15WYSAualpvqM3W
KSIaKY6bta1ylMicVlsf3aUYPkxr1KZj0B66zp4QrSEKOSSyzsxoHJA7x8hgaDNw
jnxwWwKgbRl9i7dILCO2wtIkd5rPfrnVpPS4nb7WJUgGZ/lXbIzHAwDkLscRmYeP
EUYTHuxoKRlpO3aJXgePuGo+yX2RiQFRI9yHXQsPV1ueysdlQKA4h2jcE3Rlax8q
xUQnNSvNmcPNH/ZegwdSd2YlPAZXoUgGV0CzYuf+OX0+5Fz6BELVQd4Dc5CJ+kVh
+X5XyIAhhGCKdNrMXXbJoPcLts0TOnf6/wNVCBsOI8B2/I/LFpB81M2D8JT0LPq8
0Hjh1lNK
=dup9
-----END PGP SIGNATURE-----

--Qv+uw9jvr52Cxb9K--
