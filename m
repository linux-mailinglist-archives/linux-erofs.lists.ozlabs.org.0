Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5216DA2F3D4
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Feb 2025 17:42:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ys9Mt5sBCz30RK
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2025 03:42:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1134"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739205720;
	cv=none; b=O80vVLJnUZnK+4hSidZRw6v0YWBigoLdBT7KwoYEpMJFKDwLDVWuIgZ8mzxqQJjhi6w8K6G4Ns9kmrZ8tWsXYXgFChAswpZT+5pEk3aiGH379DCSIuN+BHdgdIMUdDn/thEj8X3f461srj8ISq4zKprzGNGvTyV/IBIYPWzwgG/pgZtDQci0fqqPf7zMNP/0rE6sC/hg1Q0KQpBTcIiKeUhukf8WA/poWQv9jLSCCK7D/vlnosUq/LBM6a+HWBivLo0DEeFQMx2UgOgwoyrTA70Vb3s1PCzAjhTw2jO2mUltft/xZR1jszYb+pTowJ9nz/F7Z/B4YP3s+Ohys9hTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739205720; c=relaxed/relaxed;
	bh=nB1fJMYCiNBYsRe00bg+hOWzuP4Au/oMPxdorAZOTDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jw6vrxUhRXc+E2mVCaObwHs0EFAWUo7Bb1bxKx36OHcaiSXyQNd9J5IKwPQQEcBeTh4u4zXzdcEEBzlgvQqYcu7YjGcFJzErfIlykxf7Gd1MH+0FiUrH/XjVmi/OQvA8vDyb+sNPbekGgTKBQYkfG92VIt7cnhqvlSALbJKhGmmyGj6KiwX1Zzy5L/rcfpFpxmTy9w1bKl5jl767GewuRj1X2DqgY7mbjJ7hSeW5WtZZxJiNbDMmG/nrfz82dinLqXrl/5XYvDlfjY5AESSBuQEePdGFRK3+u0vZKs29NXKjs8FhSyp/eiCOEfT3MH2pbs+RTW0wXLHP4GhKeUXImw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=rlFKHw87; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org) smtp.mailfrom=konsulko.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=rlFKHw87;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ys9Mp69Tkz2yRD
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Feb 2025 03:41:57 +1100 (AEDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-6f8c58229f1so39746007b3.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 10 Feb 2025 08:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1739205715; x=1739810515; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nB1fJMYCiNBYsRe00bg+hOWzuP4Au/oMPxdorAZOTDs=;
        b=rlFKHw878brlksK/jV6KoPAe744CPen04fF0+bE5HwgVzbjs+/+vvvV+U5Bi3LszCU
         ivnsXzidjtl3MPI1TTaxY6e+dFLRKtY/ZaFXbJRulPUIwpt/gw62v7O2uZG+R+cXsb8q
         yoL426QafOfF4Q+UKQc9j8UJOK/+T5t44eBGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739205715; x=1739810515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nB1fJMYCiNBYsRe00bg+hOWzuP4Au/oMPxdorAZOTDs=;
        b=BjjW9lfixiGkFEmesehtMQOyJ956aMOfNEVMbxja9CGIetX5Mlz1UIMW9EseiJgZKq
         QDgOnCUhuCz5uy79hCq8jO8jAGzjQ4cXaAFX7xRmi62RYPQvhvTOmFmeLj3+HuSgdNnK
         Z0baKXzSG3alZUO4iYgEwJJHdcyhFecKFU67bBQ8gZ4QbehMK0bh+TnMAAXfr83ZAhJT
         Vc5ukVPy/lnIthA85NfOyqjXFNClrqh5ODDeFEwnUJooMoazm/OTQzoFmO8KY3FtPr/I
         iR2MfvjGnt29FfNKAQxbFysMzenuCLZrDiMJoXXikzDZUosgQdYKRdNBph5n9HT6h6uo
         xxzw==
X-Forwarded-Encrypted: i=1; AJvYcCU2AjqoMt1mh1MdmWiJJGBTwUQ04ljqlI0cDS85EBYbgCBZIthsDGQhp2UTvKT3V/i34fB1enuCqvfCoQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzVKC1zT0Zat3NdNfqgldlrX5ES4H/LPVq4yDmm6mIlQi/eRJJx
	nXtzj7Ge1sO9QF6iaefxX3qxUIB+nWOywF6h5Y2kZRruEpJmDPsOdmqAYR7rXW8=
X-Gm-Gg: ASbGnctFjgz6DLtd5emRKMa3eP2uRW5mLciCf95eGnwCC9ILGK2QqgB83gwkL1hE/3Z
	TcR5aNchxEJ8TwYRl2rPbPJrQEEUD7WH82ofT5gT/U+8EB9FO/MpN9GzDCW3ylgxsTp9FHVIL+a
	lH5LKrHNt8pK+fcliee5a1Qif7EGz8UG0i1Vktg0VzdvxbScfdn/d/VP4kv/47kfXkayU9p5qzT
	GVKqLuJEzbzq5C2VADH9JgF9RG0Ah6obEcyB0FEosmQ4ZeiIq6JrxUrfip/tRRDK3QXuyv+ITlw
	yq17D7L09gYcBPE=
X-Google-Smtp-Source: AGHT+IEBU5OnxC1xFP9Kif+n8C34fLH0e704sOLFwHBpRfYqgWAh+DyUoYqlQEV+VQjd6jNLuK4POA==
X-Received: by 2002:a05:690c:4887:b0:6f9:b027:1bfc with SMTP id 00721157ae682-6f9b0271c7amr95914047b3.3.1739205714964;
        Mon, 10 Feb 2025 08:41:54 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f99ff6a5d6sm17157957b3.91.2025.02.10.08.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:41:54 -0800 (PST)
Date: Mon, 10 Feb 2025 10:41:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonathan Bar Or <jonathanbaror@gmail.com>,
	Huang Jianan <jnhuang95@gmail.com>,
	Joao Marcos Costa <jmcosta944@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: Security vulnerabilities report to Das-U-Boot
Message-ID: <20250210164151.GN1233568@bill-the-cat>
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
 <20250207155048.GX1233568@bill-the-cat>
 <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9oKgVojFNYPhzzii"
Content-Disposition: inline
In-Reply-To: <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--9oKgVojFNYPhzzii
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2025 at 09:53:01AM -0800, Jonathan Bar Or wrote:

> Thank you.
>=20
> So, I'm attaching my findings in a md file - see attachment.
> All of those could be avoided by using safe math, such as
> __builtin_mul_overflow and __builtin_add_overflow, which are used in some
> modules in Das-U-Boot.
> There are many cases where seemingly unsafe addition and multiplication c=
an
> cause integer overflows, but not all are exploitable - I believe the ones=
 I
> report here are.
>=20
> Let me know your thoughts.

Adding in the eorfs and squashfs maintainers..

>=20
> Best regards,
>             Jonathan
>=20
> On Fri, Feb 7, 2025 at 7:50=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>=20
> > On Thu, Feb 06, 2025 at 07:47:54PM -0800, Jonathan Bar Or wrote:
> >
> > > Dear U-boot maintainers,
> > >
> > > What is the best way of reporting security vulnerabilities (memory
> > > corruption issues) to Das-U-Boot? Is there a PGP key I should be usin=
g?
> > > I have 4 issues that I think are worth fixing (with very easy fixes).
> > >
> > > Best regards,
> > >             Jonathan
> >
> > Hey. As per https://docs.u-boot.org/en/latest/develop/security.html
> > please post them to the list in public. If you have possible solutions
> > for them as well that's even better. Thanks!
> >
> > --
> > Tom
> >

> Filesystem-based Das-U-Boot issues.
>=20
> =3D=3D erofs
>=20
> =3D=3D=3D Integer overflow leading to buffer overflow in symlink resoluti=
on
> In file `fs.c`, when resolving symlinks, the function `erofs_off_t` gets =
an `erofs_inode` argument and performs a lookup on the symlink. =20
> The function blindly trusts the `i_size` member of the input as such:
>=20
> ```c
>     size_t len =3D vi->i_size;
> 	char *target;
> 	int err;
>=20
> 	target =3D malloc(len + 1);
> 	if (!target)
> 		return -ENOMEM;
> 	target[len] =3D '\0';
>=20
> 	err =3D erofs_pread(vi, target, len, 0);
> 	if (err)
> 		goto err_out;
> ```
>=20
> The `erofs_inode` structure's `i_size` member is defined with the type `e=
rofs_off_t` (which is a 64-bit unsigned integer). =20
> Thereofre, if supplied as 0xFFFFFFFFFFFFFFFF, the `len + 1` input to `mal=
loc` would overflow to 0, allocating a chunk with 0. =20
> That chunk (saved in `target`) is later written with `erofs_pread`, overr=
iding the chunk with partial data controlled by an attacker. =20
> Therefore, we will have a heap buffer overflow due to an integer overflow=
 in `len` calculation.
>=20
> =3D=3D squashfs
>=20
> =3D=3D=3D Integer overflow leading to buffer overflow in inode table pars=
ing=20
> In file `sqfs.c`, function `sqfs_read_inode_table` is responsible of read=
ing an inode table. =20
> It gets the superblock (attacker controlled) from the context. Then, it e=
mploys the following logic:
>=20
> ```c
>     n_blks =3D sqfs_calc_n_blks(sblk->inode_table_start, sblk->directory_=
table_start, &table_offset);
>=20
> 	/* Allocate a proper sized buffer (itb) to store the inode table */
> 	itb =3D malloc_cache_aligned(n_blks * ctxt.cur_dev->blksz);
> 	if (!itb)
> 		return -ENOMEM;
>=20
> 	if (sqfs_disk_read(start, n_blks, itb) < 0) {
> 		ret =3D -EINVAL;
> 		goto free_itb;
> 	}
> ```
>=20
> =3D=3D=3D Integer overflow leading to buffer overflow in directory table =
parsing
> Similarly to the previous issue in inode table parsing in `sqfs.c`, the s=
ame unsafe multiplication exists within the function `sqfs_read_directory_t=
able` responsible for reading the directory table:
>=20
> ```c
>     n_blks =3D sqfs_calc_n_blks(sblk->directory_table_start,
> 				  sblk->fragment_table_start, &table_offset);
>=20
> 	/* Allocate a proper sized buffer (dtb) to store the directory table */
> 	dtb =3D malloc_cache_aligned(n_blks * ctxt.cur_dev->blksz);
> 	if (!dtb)
> 		return -ENOMEM;
>=20
> 	if (sqfs_disk_read(start, n_blks, dtb) < 0)
> 		goto out;
> ```
>=20
> The multiplication of `n_blks` and the block size (attacker-controlled 64=
-bit unsigned integer) is unsafe and might overflow, resulting in an out-of=
-bounds write.
>=20
> =3D=3D=3D Integer overflow leading to buffer overflow in nested file read=
ing
> Similarly to the previous issue in inode table parsing in `sqfs.c`, the s=
ame unsafe multiplication exists within the function `sqfs_read_nest` respo=
nsible for reading a file:
>=20
> ```c
> 			data_buffer =3D malloc_cache_aligned(n_blks * ctxt.cur_dev->blksz);
>=20
> 			if (!data_buffer) {
> 				ret =3D -ENOMEM;
> 				goto out;
> 			}
>=20
> 			ret =3D sqfs_disk_read(start, n_blks, data_buffer);
> ```
>=20
> A similar issue exists in the same function also later on:
>=20
> ```c
>     fragment =3D malloc_cache_aligned(n_blks * ctxt.cur_dev->blksz);
>=20
> 	if (!fragment) {
> 		ret =3D -ENOMEM;
> 		goto out;
> 	}
>=20
> 	ret =3D sqfs_disk_read(start, n_blks, fragment);
> 	if (ret < 0)
> 		goto out;
> ```
>=20


--=20
Tom

--9oKgVojFNYPhzzii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqLEgACgkQFHw5/5Y0
tyy3pwv+IeNKXeHjB3yx5JGNhrU+oAarezqT3d1oAkiF5FW43E76xhYUJxFNIhEv
MZqWBZfTFaH5PzGeO/2dDIdInyCVvuiNxZiEKkJ3N7VUjmgaekr6b3WNCrR/FH2u
njDXSbv/QJrPqT9Kr9qlceurDCaAVYpsZsN2kHbHUBIv+EauIEMu6+GV37YbOynN
CJ/X0yHHnEb/bRsZIMKQjggTjijiZxEPGLYQqaLlxjEg/nBJduGiJLqYY5Cl4ae7
yLMxVodwLh7J7U5y9zp0Z5ocosRJaGA+51ey6AjfJoGlNnjeRTxJH5nXaT5L/FUJ
pL7RLZHY+ANC4PGuJMbNEkYYWVtwbeubFBKygMZmIU/IFAzFJ0Vr0P4XPgu/7N8X
vyUZqU2ckeyIhqEUvkPReg3KQCDVjKznP9Z50smCT7iQx0dXhqmwA82fFe0F0LAi
cBxbGyZl+YY1QRDXunIJUiNTxpHjikfnMACOBcxkjev0dbWtN3CPAFBd+jEOd7aT
P9NDqytY
=mtNV
-----END PGP SIGNATURE-----

--9oKgVojFNYPhzzii--
