Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 998BAA3AC8F
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2025 00:31:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YyG4C3jFPz30TQ
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2025 10:31:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739921465;
	cv=none; b=f9YhkZ4sRmGQdHeDcgtFOuLNX5lWv8Vo0pPmbKnI+fTum8icquW7zCbjuoLZmQFDQ5Kcv2A5ldc6wD+ik2qrWjctSWN/5ftSVbQEKNlswT3jXu7IVrZVO0SZWiVKdtsWFrRlcjRHpEVGOobUTiixZnaIGYUux2b3pgYU+Xpsetr5zZlNzv8zt5Oy/7gBbR4ygsQ1RgrCGEx7Er/6j28+nrTopKCbf7GjVj1T5Luf4WyouW/mubLfM2guiPN4HZmGbVvkGSDaxv8LWlqE2O31WcEyzqTcI81CW9dzHy6tDUSLnc64sEYrj1Hs5+U44SZyJapp4q2aRJVtfBRzLp5pMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739921465; c=relaxed/relaxed;
	bh=WPhspwsKzxQxyliqvSvVrQUJp0CAezLZJGZq/vM9U8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm4Ep7bJhJU6WS/l7ijYq0bfFqcO8kreeXMmC1uVtSdT3kc5bIitfQDf7Blswrb1UmNFm7MyJ8syMcPLU22xH4/0jbLp335RvCcZO1TFB8gMpUP7eeq/zY10AVqFiKy6ggeGw9FKheOmLvN0+MI3SPZXLuI8ztUIq4JWlYNvH+uUPAvg9PnJ5ZBeAqep9EVGeR+/px8NDGksWcMs7dOynnMWrnR/JoVJSkH2/Cu+1Bwd7iC84Gzu4TZ91/nbeZHrhX4DPq6qwi6MDQOS61CRyYAJHj+237KJ+JM1B5cmt4erj1prtcnzYaMknVJ8aoORnRAmcJ+kHQiGUYC5F3lrmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RWC2tFmP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org) smtp.mailfrom=konsulko.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RWC2tFmP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YyG452vDnz2ysh
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2025 10:31:01 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-220e989edb6so122735005ad.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 18 Feb 2025 15:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1739921459; x=1740526259; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPhspwsKzxQxyliqvSvVrQUJp0CAezLZJGZq/vM9U8w=;
        b=RWC2tFmPsezXCxJHqONRdSfAyTPOH+K9LnLG8h9UnthZu8J7WGWufB+inyADuvSVMM
         EJQ50EOWMVFsYifs13+YSw+QZtd9bMDNdYJwtKW9DLAIlu1TZZEkf/MwO7FkFqCtN6+o
         EvT16GQcFcKRdQHLacS0kzzWZU4ix6BQ1wiyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739921459; x=1740526259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPhspwsKzxQxyliqvSvVrQUJp0CAezLZJGZq/vM9U8w=;
        b=KHMXXtL+Rg2XTz3z+WilZ5CUwsnk1H1QK2q4/QAU3psA09A6hPSU3n3fyNsqeafYmk
         g/ZuNOyJI2Ysve9cJSRz9whsJ6G0GFeaLG7MWsKo/ijo32DXTshaLEULKaawBzkM8bsv
         HeAYtxpqDbgg6KaGG68q8KYNkP4rp7g4Q4B2+INgfxWXAHuZY4ZngAjM6TMQs10GxeYX
         +aE7h8DsuI7A7GM1Hk23aYcON9Z5m1ADW2BgoZSO52T6qFdEK2h+RzMkhnG7i+/GMIRc
         9MdGlMi0jk0k7iOAgYahguInoir4YDXgUc0R/TRBxbyvkL7evFFps/MHbu+fbzFpDAH9
         ItuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrOBg/ZLQLQy3YM52/VvVe4fh/wJoPXjd42uctWGWuCnCg2S6fZYvGZDMhDi2ed79EKGEBujzjZ0Sv5g==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzyjNqUyDcZ0tarjrAEhmyumbkMYpWiG+avt74gFQHzCx8JVMxZ
	dRRG1+QK87BtmioIHqmnWSgIaA2YtQY/OsPOHFIAT2tTxMd/mWRjXWwP0ylMTNY=
X-Gm-Gg: ASbGncuSwLWj8ucFieWJ54jv6ZXesaU0/MEaTzUNmZSNe9YPeQxfZ4rka/ZYx+jatbT
	cj1Fb0B68cbzcfraOKeM/PX5Hi7nECdNb3qPZ0NhGftre6tqNWn+HFYmqyBNzIJ9yumvbF8ur7I
	6jWN/2yAa7TyB46hSDivPERlsepKXqvOphabTIDcn0gp5ESXFF8iHCMyrrxRDxfp/CE+P3vQIP5
	mksFaPkdfFSrKD+YQOQI1wg6Fdb7IWF2997FXDafbkjUW3doltzUk4urP0UyRiVREKuBNUW/Umx
	33uFQrADD/ynKg==
X-Google-Smtp-Source: AGHT+IHNt95oG1yVvkU7qQaPH8y6pOFVzehCfsBBXvgd+F04xG1BZKHr5hisa5l8PEYZhW8MV6JRVw==
X-Received: by 2002:a17:902:ce06:b0:21d:3bee:990c with SMTP id d9443c01a7336-221040a99cemr250492695ad.42.1739921458893;
        Tue, 18 Feb 2025 15:30:58 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220e21d2453sm88280255ad.184.2025.02.18.15.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 15:30:58 -0800 (PST)
Date: Tue, 18 Feb 2025 17:30:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonathan Bar Or <jonathanbaror@gmail.com>,
	Joao Marcos Costa <jmcosta944@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2] fs/erofs: fix an integer overflow in symlink
 resolution
Message-ID: <20250218233055.GN1233568@bill-the-cat>
References: <20250213112847.1848317-1-hsiangkao@linux.alibaba.com>
 <173990731183.1542939.8486402584511743095.b4-ty@konsulko.com>
 <CABMsoEF3xcbpFXMAYW-ZzQUfZp3zVf8FsKmtxQ7wfVxu3zjOcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="294FnAg8Qefqg6nM"
Content-Disposition: inline
In-Reply-To: <CABMsoEF3xcbpFXMAYW-ZzQUfZp3zVf8FsKmtxQ7wfVxu3zjOcA@mail.gmail.com>
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org, Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--294FnAg8Qefqg6nM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 03:24:08PM -0800, Jonathan Bar Or wrote:
> That's great! Thank you for your work!
>=20
> Any expected fixes on the other issues I raised Tom?
> I'm asking specifically because GRUB2 maintainers are working on
> solving very similar issues in their repository for SquashFS (being
> rolled out right now).
> It'd be best to solve ASAP as people might realize the similarities
> between GRUB2 and U-boot in that module.

Adding back in the squashfs maintainers.

>=20
> Best regards,
>            Jonathan
>=20
> On Tue, Feb 18, 2025 at 11:35=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Thu, 13 Feb 2025 19:28:47 +0800, Gao Xiang wrote:
> >
> > > See the original report [1], otherwise len + 1 will be overflowed.
> > >
> > > Note that EROFS archive can record arbitary symlink sizes in principl=
e,
> > > so we don't assume a short number like 4096.
> > >
> > > [1] https://lore.kernel.org/r/20250210164151.GN1233568@bill-the-cat
> > >
> > > [...]
> >
> > Applied to u-boot/master, thanks!
> >
> > --
> > Tom
> >
> >

--=20
Tom

--294FnAg8Qefqg6nM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme1GCsACgkQFHw5/5Y0
tyyBRgwAqMaHU2UGacIzn3exB9KF56+eL303p1iRmZa/Ovn/uQ8hU0lvLGRgZZI2
p5Jv1e5lTh8pNZIsZPdfhwBKXyD9o3yMepGD4CnR400/KXiKGL/1hk3kG0rMDWhN
vedBD4ATrbebbOVYX7cmrVppMyc2tjdGJ1qhNB+0211JzSExpPyVs5dcVpCAlPKx
oe5+SnJx9VO0u5aoLm1K3JsKvlHZ1ldPt/bCQPMWOrZMY3XXEB4cFJfx/Ua71OO6
ROSYp77j1d0tlx40OiXxWaT70qlNu61/ptvnM3M6sKm8k6sZ/m66ibu9dKF0S1Fn
8WiQcdm89Hx7QLFd/wFRPtsxPH6sOjY6yidASWEkGKIBXTkf/04tt1irVL6PZNa8
VuLDyRO9YFsvLsScp9zzvqosvEDNqLa4LJU2sww0HOPMljymxoTjB1wrb5abZBge
zBLBc65ADUulE1QGmWi3hzjVGKp4r9n1lm9YzMVZqhVCK8cfxuLFLRSLYO6QsjzQ
ZgdIG5ym
=opwn
-----END PGP SIGNATURE-----

--294FnAg8Qefqg6nM--
