Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB96D3F7EBD
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Aug 2021 00:40:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gw1Cn4YJfz2yJk
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Aug 2021 08:40:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=G9wSn7kY;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::82c;
 helo=mail-qt1-x82c.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=G9wSn7kY; dkim-atps=neutral
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gw1Ch1tDSz2xs0
 for <linux-erofs@lists.ozlabs.org>; Thu, 26 Aug 2021 08:40:48 +1000 (AEST)
Received: by mail-qt1-x82c.google.com with SMTP id l24so867413qtj.4
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Aug 2021 15:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=CkpB1l1wAzRtRKT3iGhsyNFyda3QBXQEUrJS2S98pGk=;
 b=G9wSn7kYZ1uwXNXOLjVEjxYdBzIYnO2GS0KoSOmqHOgQW5Wo6HkHdDQrU/mys6qcIj
 GMLEacKm9m7KZDQS5uFvfb/NaO6bK6Ba0hy2agSyI9ixSXR6eKtOb+UBoBP7Jbx5aQqr
 +HTJIoqDJ13qLdEJVqj+pjSB6mFmWX77vqSRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CkpB1l1wAzRtRKT3iGhsyNFyda3QBXQEUrJS2S98pGk=;
 b=UkZgIOGD1eaRjiQ/XBKQl+89tFToYIVV4992Y5x6cHGiech0UDaU4ncfIrI6duE6qY
 quZc6os9l42Hw1QIgtskcf35unyrV71pGbitvI+hfeqITSwhUb4b060VsVBBG96e577s
 QLE3MBEmQuXQTrw1y/jv6Jnt0S9mOLRbUw4x34WKV8L/EHDGdzMOqDugAO5HAKf8lcbb
 jEvhJcMnVKTiV872a8fo4axcJEZvlp/nZD3P4HJ9hDTgtIvx92L0jjDofPBiaPds84g9
 0bNqHHj3CgpWYKUOYIaoXrCVGFXgMjpGNe2GRrRtwGICMQYnCXtDyAJF3vEFQzDEiQfp
 vCGA==
X-Gm-Message-State: AOAM530cPM0YQQ7WYuiQ1EU1xwghhAB0bduoN9nWywn1NPg8p/WSo+lJ
 3aT9DT9dHDOIfn0vaxhXlK3cdA==
X-Google-Smtp-Source: ABdhPJzOSiQKnY+uoSlxWPYbKzFK/5pV90EZdLs21NlDB1lp+wHoZlEeTVRINkC3Ov7e5Dvd3wMhAA==
X-Received: by 2002:ac8:7b5b:: with SMTP id m27mr597770qtu.316.1629931245147; 
 Wed, 25 Aug 2021 15:40:45 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b01-cbda-519a-4843-2801-9790.res6.spectrum.com.
 [2603:6081:7b01:cbda:519a:4843:2801:9790])
 by smtp.gmail.com with ESMTPSA id d26sm1100156qkl.6.2021.08.25.15.40.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 25 Aug 2021 15:40:44 -0700 (PDT)
Date: Wed, 25 Aug 2021 18:40:42 -0400
From: Tom Rini <trini@konsulko.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH v2 0/3] fs/erofs: new filesystem
Message-ID: <20210825224042.GF858@bill-the-cat>
References: <20210822154843.10971-1-jnhuang95@gmail.com>
 <20210823123646.9765-1-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xmwyzkDopBxrzBoc"
Content-Disposition: inline
In-Reply-To: <20210823123646.9765-1-jnhuang95@gmail.com>
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


--xmwyzkDopBxrzBoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 23, 2021 at 08:36:43PM +0800, Huang Jianan wrote:

> From: Huang Jianan <huangjianan@oppo.com>
>=20
> Add erofs filesystem support.
>=20
> The code is adapted from erofs-utils in order to reduce maintenance
> burden and keep with the latest feature.
>=20
> Changes since v1:
>  - fix the inconsistency between From and SoB (Bin Meng);
>  - add missing license header;
>=20
> Huang Jianan (3):
>   fs/erofs: add erofs filesystem support
>   fs/erofs: add lz4 1.8.3 decompressor
>   fs/erofs: add lz4 decompression support

Aside from what I've just now sent, can you please extend the existing
py/tests/ to cover basic functionality here, ensure they run on sandbox
and in CI?  Thanks.

--=20
Tom

--xmwyzkDopBxrzBoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmEmxuoACgkQFHw5/5Y0
tyytiQv7BBIriB0prrfJHZb49UI5HZE20IlgstJjSTZ8/1st3nkfna+6HJ9RZX/s
h22MCLVdWLMqnNDIjZ+j5HUvPimRVDNdJoXf8Gjrq3xZvJrttyk9Ok+62Ru2GQzU
ajl7d90NJ/exEoDfpVybTTPjzdTyIQU24JysPdfSJGB055PzNG2RSKmRq6sJnnY8
MNw+TQPd6hM7H9ByModuuQV1vcCzWYFYqyL8ISZODNw4h2TnqpbMdWSb/CcqccoD
kmzPoFAk36OJ/q56u7TrKCborIJWBCAJNQghv0LxPIOXQMtSp8J12uozFrNCpFPS
vFlj3Bl4Mjb/L996OKPdSyVNqREdSdblTeLegOUp9OYCLIygtUcrBO0XQ5OWxrN8
Mue3wicYtkSnOntG5mT6Hh/mQQwh2JjQL37YB4g96uvf+HIqThgb50Idkp5vC/5D
XByy+F0ErmB8JjDYrSfxOz8ixMpPySzYJlgksRmSv/i0CHemZHtAIy6ileuDkWP4
klwWHjZJ
=8JLT
-----END PGP SIGNATURE-----

--xmwyzkDopBxrzBoc--
