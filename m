Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF733FB9C3
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Aug 2021 18:07:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GywF10k2pz2yJq
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Aug 2021 02:07:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=QYYvjcEq;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::f2d;
 helo=mail-qv1-xf2d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=QYYvjcEq; dkim-atps=neutral
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GywDv1TYtz2xfG
 for <linux-erofs@lists.ozlabs.org>; Tue, 31 Aug 2021 02:06:53 +1000 (AEST)
Received: by mail-qv1-xf2d.google.com with SMTP id p17so4242504qvo.8
 for <linux-erofs@lists.ozlabs.org>; Mon, 30 Aug 2021 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=CVTWXp7s9BBHihml8SBO596Xipd7Bk4i6qQnKWIOlgU=;
 b=QYYvjcEqkz3Rn2K12Odly/izAiQeqelGqAzuPMrciNO0YS1WTAn59fswvyXryUf8Ow
 tAFiWDWmidIivA93KrboxDdI4ApgxsYsq0xjVp1x6f3wfSZwIZ5MiHEuuEL/GLbN6dTi
 8ww5PMfgQv8bm/wU7fcQ4e1p8VjLd6d8atA8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CVTWXp7s9BBHihml8SBO596Xipd7Bk4i6qQnKWIOlgU=;
 b=JaYj9YMmiSh7cLN4Z2kIwLp7fevgKEWcBeyGsMz+MzDT6WZCvnkq86mf4/wDEcf6Rs
 QboZ22k+Ae1V+g6+CeKd/j95Olstok7b8dTlJdofTWdc7VBnNwSVDr4+SMFXhC/kEUe0
 wwFT79SMbyAg7kqAZV9EnfLFaHNkNZGR3rAf9h+IPnUaCy7KPqRCYXAC+slkuaKZu8XB
 D0u88ckaq6yT5XmevfedrZy8/y+vvQIEgRch7eIHdvLFJX5/lJKgL5DdXI7K5gSTv+7+
 C48IcAOyE0ev6NkgCoxsWA3oJDcMyENCROe3hlVc5xR6H59ew5RZRv4ZoEQkDb7JR3KD
 3wMQ==
X-Gm-Message-State: AOAM531ED4Eik7vjfQmOiEP4ZR6FLniEhWN9OWHlCLzYiEiwpI0k0Uvt
 i4yd4NHnMAZ7dl/XeFKxXPewDw==
X-Google-Smtp-Source: ABdhPJzIXagLMUi1hQ5pkdHu3gqpjipgEhH0AW2n1rmdLkyY0+77VsOPXLod3qiNz0272ZU6YBVHLA==
X-Received: by 2002:a0c:8525:: with SMTP id n34mr24119861qva.19.1630339609595; 
 Mon, 30 Aug 2021 09:06:49 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b01-cbda-8d75-4e9a-efec-7167.res6.spectrum.com.
 [2603:6081:7b01:cbda:8d75:4e9a:efec:7167])
 by smtp.gmail.com with ESMTPSA id 19sm11272843qkf.127.2021.08.30.09.06.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 30 Aug 2021 09:06:48 -0700 (PDT)
Date: Mon, 30 Aug 2021 12:06:46 -0400
From: Tom Rini <trini@konsulko.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH v2 1/3] fs/erofs: add erofs filesystem support
Message-ID: <20210830160646.GY858@bill-the-cat>
References: <20210822154843.10971-1-jnhuang95@gmail.com>
 <20210823123646.9765-1-jnhuang95@gmail.com>
 <20210823123646.9765-2-jnhuang95@gmail.com>
 <20210825223947.GD858@bill-the-cat>
 <177141f0-ebbd-017e-ab63-9445b3f53ac1@gmail.com>
 <35ce7ab3-a21c-0401-c677-eb2140ea908d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8znHms9eZMkWe5DE"
Content-Disposition: inline
In-Reply-To: <35ce7ab3-a21c-0401-c677-eb2140ea908d@gmail.com>
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


--8znHms9eZMkWe5DE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 30, 2021 at 11:31:28PM +0800, Huang Jianan wrote:
> =E5=9C=A8 2021/8/30 21:27, Huang Jianan =E5=86=99=E9=81=93:
> >=20
> >=20
> > =E5=9C=A8 2021/8/26 6:39, Tom Rini =E5=86=99=E9=81=93:
> > > On Mon, Aug 23, 2021 at 08:36:44PM +0800, Huang Jianan wrote:
> > >=20
> > > > From: Huang Jianan <huangjianan@oppo.com>
> > > >=20
> > > > This patch mainly deals with uncompressed files.
> > > >=20
> > > > Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > > > ---
> > > > =C2=A0 fs/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 +
> > > > =C2=A0 fs/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0=C2=A0 1 +
> > > > =C2=A0 fs/erofs/Kconfig=C2=A0=C2=A0=C2=A0 |=C2=A0 12 ++
> > > > =C2=A0 fs/erofs/Makefile=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> > > > =C2=A0 fs/erofs/data.c=C2=A0=C2=A0=C2=A0=C2=A0 | 124 ++++++++++++++
> > > > =C2=A0 fs/erofs/erofs_fs.h | 384
> > > > ++++++++++++++++++++++++++++++++++++++++++++
> > > > =C2=A0 fs/erofs/fs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 231 ++++=
++++++++++++++++++++++
> > > > =C2=A0 fs/erofs/internal.h | 203 +++++++++++++++++++++++
> > > > =C2=A0 fs/erofs/namei.c=C2=A0=C2=A0=C2=A0 | 238 +++++++++++++++++++=
++++++++
> > > > =C2=A0 fs/erofs/super.c=C2=A0=C2=A0=C2=A0 |=C2=A0 65 ++++++++
> > > > =C2=A0 fs/fs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 22 +++
> > > > =C2=A0 include/erofs.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 19 +++
> > > > =C2=A0 include/fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> > > > =C2=A0 13 files changed, 1308 insertions(+)
> > > > =C2=A0 create mode 100644 fs/erofs/Kconfig
> > > > =C2=A0 create mode 100644 fs/erofs/Makefile
> > > > =C2=A0 create mode 100644 fs/erofs/data.c
> > > > =C2=A0 create mode 100644 fs/erofs/erofs_fs.h
> > > > =C2=A0 create mode 100644 fs/erofs/fs.c
> > > > =C2=A0 create mode 100644 fs/erofs/internal.h
> > > > =C2=A0 create mode 100644 fs/erofs/namei.c
> > > > =C2=A0 create mode 100644 fs/erofs/super.c
> > > > =C2=A0 create mode 100644 include/erofs.h
> > > Do the style problems checkpatch.pl complains about here match what's=
 in
> > > the linux kernel?=C2=A0 I expect at lease some of them come from usin=
g custom
> > > debug/etc macros rather than the standard logging functions. Thanks.
> >=20
> > The code is mainly come from erofs-utils, thems it has the same problem,
> > i
> > will fix it ASAP.
> >=20
> > Thanks,
> > Jianan
> >=20
> I have checked checkpatch.pl complains, some need to be fixed, and some
> come frome using custom macros. It seems that there are still some warnin=
gs
> that are inconsistent with the linux kernel, such as :
>=20
> WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where
> possible
> #835: FILE: fs/erofs/fs.c:224:
> +#ifdef CONFIG_LIB_UUID
>=20
> WARNING: Possible switch case/default not preceded by break or fallthrough
> comment
> #763: FILE: fs/erofs/zmap.c:489:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case Z_EROFS_VLE_CLUSTER_TYPE_NONHE=
AD:
>=20
> erofs-utils is written according to the linux kernel coding style, I expe=
ct
> this
> part can be consistent in order to reduce maintenance burden and keep
> with the latest feature.

Yes, please fix what can be easily fixed and still kept in sync with
other projects.

--=20
Tom

--8znHms9eZMkWe5DE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmEtAhYACgkQFHw5/5Y0
tywNMwv9E09dQu8OFxzLTYa3E0zmA0cEeSp3ne9vCBGjCI9Vz02aEYTuwAtV10Aj
x1WY7NUSf6qitDqWTdQ/xbCnaEbQWhyPFCtaLiDBz9xA37CmPzuczs0x1il+CWoQ
iAQkPY3ryS3VQVZAKQzLRPUFidFXIqU4axAHjdUWGGy01HO9Y4CDPGwPeKdr+lNA
0SEl6yE/HpocK+VuJwT58/7A6mt3nElpx+q+5v2D+kgO/qki7Hp8J9O9ZKxsZdrV
Twm+2RCn9kpmUnGMSd9L9TdEBO/21Dt7DPvGvhZ0iYrjtmH2EWQ5ULi1mPwxzg8w
mqnWSoWY65AEF4e5dQrj36npyJSNe02WdtwYXn5MwJuqlxRk8J49BX7OVnWePSih
t8AghVA7mMuNngcRc8VZd88NItlwnCR22V0GT0ZROvJ8ZYqLHlog5O+tIc8KPofh
lmxgyoPv6KQjqtzGDHtd2sBPkoiI17FxzRPyZ801eGFputPmV3weGadnq0HLmmmB
9T9v38Yb
=Fboa
-----END PGP SIGNATURE-----

--8znHms9eZMkWe5DE--
