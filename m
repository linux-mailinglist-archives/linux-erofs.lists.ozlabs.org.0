Return-Path: <linux-erofs+bounces-3491-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFc9M5XwGWoX0AgAu9opvQ
	(envelope-from <linux-erofs+bounces-3491-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 29 May 2026 22:01:25 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 927EB6082AE
	for <lists+linux-erofs@lfdr.de>; Fri, 29 May 2026 22:01:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRvPY50cPz2yN8;
	Sat, 30 May 2026 06:01:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780084881;
	cv=none; b=CPaD+j0mXQkdGUs5g8ToPgfDuS5vayxsWS4E3CjC8YU2u34Axv5JpVv1aVA7jLAi3xEaGaPOp6HB7dv4kulW+6cNfbko3A4nU3DOHjIx6rK+/Z/tVKYWDbs0ekSSMQcM4R03BNeQ+c4Uwd2oBTpFDYEtnUZnCKTgZUbt+Iod0N5eMjSJ7+yttQ1fkekCoMc7zVapzHTRFKecM8eK+eXreHdYqGwksAGJXawvegv9HV1evUongGUhTVxQAjZSv3zn7W1nQMtIk50Cs6udoBgfo6BXLEKEYtOV4zzOVxAq29lCHWB8qaH5IUwbfd6qBL64DBHJ5N3Op+D+UNQitwulUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780084881; c=relaxed/relaxed;
	bh=BflQpILYNsdV418HEymaoaI5jvicSdyjwWiaN4KjVE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A49YqLKzqSsiD+wfOBZMK1bt84ke7yqxbIW/oYFPd79sZ2mFEU/vfreDVgspZN4pjFCK3pcmEDsddWoRlvr6BjtUbLiY4CIxs7OL5HUb8XZrYybH8IBzj6mxEBDv10PNleZNc5aQZ7l9SZOLjAdF9XzGPcaBhgnPaj5EA4teOKdrRp+mdNTYNIRHSGz77onKtduZUplwz7H9N0ohHpMbyKCtnUuHACoM9CdOVAHIHWYziMy6fbhOcjtkXcqhAm2OujmSAUBy3R6G3CQhm65dxoORRD6+mAZtdXcqROXeQ5QScOGfbgJdLF6wj7I8Z5yKPHup+9IKs9q1pekCtW3vkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=IaFs+4RE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org) smtp.mailfrom=konsulko.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=IaFs+4RE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRvPX2Z1qz2xmX
	for <linux-erofs@lists.ozlabs.org>; Sat, 30 May 2026 06:01:19 +1000 (AEST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-7de431da8fbso11613640a34.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 29 May 2026 13:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780084876; x=1780689676; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BflQpILYNsdV418HEymaoaI5jvicSdyjwWiaN4KjVE0=;
        b=IaFs+4REb3n5TjaP3S5NlFs6ba3WpvkIKwSDO3ePRkcNch7EKgHuoRhyU++5yA4zhD
         iSZkDofU0pG1UUYn5szdK+Zj/JIGZKTN2Jw39QXmDv1R4YnDsD/YW6AbG2bJtb2IxQLh
         /ypjXrvY/iOrvq4//tdnsQ4qGu1cJh29L5deg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084876; x=1780689676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BflQpILYNsdV418HEymaoaI5jvicSdyjwWiaN4KjVE0=;
        b=nwNqyXobzBIQ4WEYdjRjQftGJPV/ZQHt+A9iNIu6SQgIPMDL385nuovw4nL0N0ZtHq
         hI0DIlRgh2EpT7N1FZSIlBYx3fW6nmr9HHuRUwdwjIH7C7OfG4mpyDCcuJf8at7LknKq
         wpxPXgTd3KWEwbtPAiQz3l80IAL2s/vdKmQrh6+fLCnTSvYDI9t/B+l4x4ql/N5OMNaG
         mhAns0t1723iR1g2Q0mir60YW4FQN3PgVl/WfVQ6bonQibUx6q9nxFxKXQbyY4fYFL0G
         747Tp14duOJpCmnNnSQ8xeRhueKzeXGAu1T8vEHXph5vmgKHDDDq2eqNXGU3n+Q6d688
         sX+A==
X-Forwarded-Encrypted: i=1; AFNElJ/khelGetQwnUxZSTHWlHICaxQX0nCd3nCAHSI2FoS8JlYMKuoq5vzE+bJfchL0YAGsyePprZ2Mq9xSdA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzRApLcNONFTmuyaXDKZy5FJiglkytdrNr2QpUc3WJfTVrpoDZI
	xbPVNHP4T4zIBlJH+cDfVmA3zxWx9AqZpbIWV2D81gjC9fPunfXrfIxW00y0DGD0FFo=
X-Gm-Gg: Acq92OFhCHbvUYaf1bJHQHr4M3blwcnMaieYlwzbdsX4uDVtV4uK6Qf+aQEJsj3VeZn
	BGF1fMFU9Gwk0xAsiYtfKxfXu75zbQHV2clSPrwj1xb0etpU/MY5TQBeHm5s3hO5xYNeA/d2YsP
	u5Vx354Wuv8/rmbaWceAuvHqYwjOUDxCysArIvVtTrDtlarq8Yvw8VFPTxUr/KTb8bIwzN3CrHh
	Wul8djFozYS6BM9ECSCXZb7fzcYGLa/h03kZSplBTw65ekje+uCUI8x0QCxM6Zt5LzkMmsHoBDj
	7ug4UJ4QcYjcKmxb1ao+jZPoV2x71FkU+bcnc7A3XDlbPrqIGf5UoocgMlTH1j5hUFMsdO8ntXb
	WI4aWxasQ/Km38yu+21kjzrsuW93BnfqDRI+TyPL0Vx21kEFAddiPf61hemfTu/sA9EmKaWJ5vP
	nzm+Gl+ebbVgf4HQGixt5YNE7TEdZS4+rt94GvyGOkAfSdgQ0sp5O2T99B8tdZlr6EhpskrsyMM
	kxrY8qCO93v/Ybv7hRPNJV1tP185iazo8KnAfGyJT3Z+p1a1irNzlnV
X-Received: by 2002:a05:6830:378f:b0:7dd:e032:3ce5 with SMTP id 46e09a7af769-7e6a1e6334bmr837498a34.17.1780084876426;
        Fri, 29 May 2026 13:01:16 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695d6b1d4sm2144644a34.21.2026.05.29.13.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:01:15 -0700 (PDT)
Date: Fri, 29 May 2026 14:01:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Tony Dinh <mibodhi@gmail.com>,
	Timo tp =?iso-8859-1?Q?Prei=DFl?= <t.preissl@proton.me>,
	Francois Berder <fberder@outlook.fr>,
	Andrew Goodbody <andrew.goodbody@linaro.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
	Sughosh Ganu <sughosh.ganu@arm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Peng Fan <peng.fan@nxp.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
	linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 3/9] fs: ext4: print change date in directory listing
Message-ID: <20260529200112.GA694169@bill-the-cat>
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518055728.178507-4-heinrich.schuchardt@canonical.com>
 <CAFLszTgZ=ciSU-ny1+X+8jYsvRD-jc-TVQ3WwfyZ3DYvmR81Ug@mail.gmail.com>
 <73acbfa7-43aa-4d65-b7ba-1824fda3b348@canonical.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LnZKIoigaDDXZoCB"
Content-Disposition: inline
In-Reply-To: <73acbfa7-43aa-4d65-b7ba-1824fda3b348@canonical.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.30 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[konsulko.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[konsulko.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.19)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3491-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[trini@konsulko.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:heinrich.schuchardt@canonical.com,m:sjg@chromium.org,m:jnhuang95@gmail.com,m:quentin.schulz@cherry.de,m:mibodhi@gmail.com,m:t.preissl@proton.me,m:fberder@outlook.fr,m:andrew.goodbody@linaro.org,m:daniel@thingy.jp,m:varadarajan.narayanan@oss.qualcomm.com,m:sughosh.ganu@arm.com,m:ilias.apalodimas@linaro.org,m:peng.fan@nxp.com,m:marek.vasut+renesas@mailbox.org,m:u-boot@lists.denx.de,m:linux-erofs@lists.ozlabs.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[konsulko.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trini@konsulko.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[chromium.org,gmail.com,cherry.de,proton.me,outlook.fr,linaro.org,thingy.jp,oss.qualcomm.com,arm.com,nxp.com,mailbox.org,lists.denx.de,lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs,renesas];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,konsulko.com:dkim]
X-Rspamd-Queue-Id: 927EB6082AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--LnZKIoigaDDXZoCB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 02:46:51AM +0200, Heinrich Schuchardt wrote:
> On 5/20/26 22:42, Simon Glass wrote:
> > Hi Heinrich,
> >=20
> > On Mon, 18 May 2026 at 00:57, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >=20
> > > Declare FS_CAP_DATE in the ext4 fstype_info entry so that fs_ls_gener=
ic()
> > > displays the modification date alongside the file size:
> > >=20
> > >   4096 2024-03-15 09:30 filename.txt
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   fs/fs.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/fs/fs.c b/fs/fs.c
> > > index f8e4794c10e..482a5523712 100644
> > > --- a/fs/fs.c
> > > +++ b/fs/fs.c
> > > @@ -261,6 +261,9 @@ static struct fstype_info fstypes[] =3D {
> > >                  .fstype =3D FS_TYPE_EXT,
> > >                  .name =3D "ext4",
> > >                  .null_dev_desc_ok =3D false,
> > > +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> > > +               .caps =3D FS_CAP_DATE,
> > > +#endif
> > >                  .probe =3D ext4fs_probe,
> > >                  .close =3D ext4fs_close,
> > >                  .ls =3D fs_ls_generic,
> > > --
> > > 2.53.0
> > >=20
> >=20
> > I would prefer having a head-file macro which expands to nothing for
> > xPL builds, rather than adding preprocessor macros.
> >=20
> > Regards,
> > Simon
>=20
> Hello Simon,
>=20
> In the internet I could not find what a "head-file macro" might be.
>=20
> As struct fstype_info is not defined in a header file, a preprocessor mac=
ro
> defined in a header file would not make sense here.
>=20
> Do you mean something like:
>=20
> #if IS_ENABLED(CONFIG_XPL_BUILD)
> #define FS_CAPS(flags)  /* empty */
> #else
> #define FS_CAPS(flags)  .caps =3D (flags),
> #endif
>=20
> static struct fstype_info fstypes[] =3D {
> #if CONFIG_IS_ENABLED(FS_FAT)
> =A0=A0=A0=A0=A0=A0=A0=A0{
>                 .fstype =3D FS_TYPE_FAT,
>                 .name =3D "fat",
>                 .null_dev_desc_ok =3D false,
>                 FS_CAPS(FS_CAP_DATE)
>                 .probe =3D fat_set_blk_dev,
> ...
>=20
> A line without a comma in the initializer is easily mistaken as incorrect=
=2E I
> am not sure that a code reviewers life is made easier with defining a new
> preprocessor macro.

We have a lot of other examples like this in-tree already such as
ENV_NAME(..) so I think it's reasonable to make an FS_CAPS macro like
this.

--=20
Tom

--LnZKIoigaDDXZoCB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahnwhQAKCRAr4qD1Cr/k
Cr2kAQCgadsybh4J7JeK8gNZFoxFWxsAanUeadtWkzWgoniXMAEAwJkNH02zDbmW
WQPr1wdeUdrnL8L68LzU6wnAQiPJrgM=
=qb4P
-----END PGP SIGNATURE-----

--LnZKIoigaDDXZoCB--

