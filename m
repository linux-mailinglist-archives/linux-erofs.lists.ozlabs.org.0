Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A934DAF5C
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 13:10:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJTcs0r63z30C2
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 23:10:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Ax+XOvQU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::835;
 helo=mail-qt1-x835.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Ax+XOvQU; dkim-atps=neutral
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJTcn6QcZz2yxP
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Mar 2022 23:10:31 +1100 (AEDT)
Received: by mail-qt1-x835.google.com with SMTP id d15so426235qty.8
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Mar 2022 05:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=tZiS1vNpoSR7M/8Mlw1o+4wJuQ2PTaJzyUeJrSmRExM=;
 b=Ax+XOvQUYYFjAZbcCeiYmS24Te2suvSqD/t9t/AqmJEIdPhLlPnYCkj8zbYNOMuGIf
 rVFT4KDJa4pP2uWU0rk/RpBR78Lf/mPGCcDJNGtBpKV2U7GR5QzCjWDyaXpp/jJzjhBm
 kHgoLai8DPQn+YJlW3PWfuNynpxOuAxN0apMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tZiS1vNpoSR7M/8Mlw1o+4wJuQ2PTaJzyUeJrSmRExM=;
 b=C7bVcMj/IYlNyWiYn7UAWgZQUBxfGuyoHo3keoECmrWg++LI1EdMndo9QMCH3Z53Ka
 bXmggnc5GPmpQ6BJGdkeKtmp7g3558IxSxQJAndrltf0jh3RdYk9zm2nk1wMBgOyCWMi
 fkDWHpWedRYcjId4Nb3apNkfxKEc/2d5BHPWbN1SllB/us9PrLA5R8wHWnDbu+3JTv2w
 IbajH9+UnrnjOSopFvfEcxXoP2M8f1aTNcEUCrGxjSSfGrN1wzB7XaOePJqiSrjdvXXC
 UxTWuxm+JlwfTkVlhlpUSrvSDG+oJ0houBNGJS3C4fT3ZfuvzIiImLnDuX1oFwlVo+MS
 VFAw==
X-Gm-Message-State: AOAM531ivpvhhgHe9PvKdLjuB71SQ+LVIy5TsXHMJLlVp8O0sC/xbRwh
 K9BP9CF+z4bSeEtOSehS4Ic9kg==
X-Google-Smtp-Source: ABdhPJzv2zpgX9+qvCPZ8E47HeVIZ02ThQ7MKjfnYkb8NowP8cOkxbS/TA9Kt61KUwtiGuILBWL/tg==
X-Received: by 2002:ac8:5e0c:0:b0:2cb:b7de:bdcd with SMTP id
 h12-20020ac85e0c000000b002cbb7debdcdmr25493590qtx.102.1647432627230; 
 Wed, 16 Mar 2022 05:10:27 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b01-cbda-2ef0-5dff-fedb-a8ba.res6.spectrum.com.
 [2603:6081:7b01:cbda:2ef0:5dff:fedb:a8ba])
 by smtp.gmail.com with ESMTPSA id
 z6-20020ae9c106000000b0067d3b9ef387sm800320qki.28.2022.03.16.05.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Mar 2022 05:10:26 -0700 (PDT)
Date: Wed, 16 Mar 2022 08:10:24 -0400
From: Tom Rini <trini@konsulko.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH v4 1/5] fs/erofs: add erofs filesystem support
Message-ID: <20220316121024.GG577378@bill-the-cat>
References: <20220226070551.9833-1-jnhuang95@gmail.com>
 <20220226070551.9833-2-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Content-Disposition: inline
In-Reply-To: <20220226070551.9833-2-jnhuang95@gmail.com>
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


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 26, 2022 at 03:05:47PM +0800, Huang Jianan wrote:

> This patch mainly deals with uncompressed files.
>=20
> Signed-off-by: Huang Jianan <jnhuang95@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmIx07AACgkQFHw5/5Y0
tyxyKQv/QsgA+rNiXQpK1n7N0cR4procKtCoaDTvK4kB1k3dGy24s5E+SPqWnaH6
NZpKeLLOdZPUKdzp3w4ZYsrheb4aC0skWi1ikayhGni9WIbMKNJDnKle5Gda/Jix
ufgkv9Wfz5pDIY1Jjzp2M26plPcZ2b3j0MG9K2MatA9GiTAB8CDvZtSWA1vmHjhk
J+4t4aE4QYMbq63FQF5qKrh7A1sYd4rf3UndIsGduHVU8MWYiB6T65BHZ+2sd8tN
/k38NiRBbDlxgAWzw2PypHExdKtt36ldrF/ieKEjia8T86PwTdnxa6055GunxrYM
XDozP5EBDcqfof+efvZaYmK7zeNfLeI0vSkbuYRR8qaOlq32+a/pY3jndKjBkLNP
YC7mXNF05Tt/fSLTVzdRnpbrF28FwD1LKwJOAw70msxE5azlgNEz3tWMWG/Y0Q96
G/wM3jS4e5KgOCp9vK+PLMTIxDN9+FgIWI4uB/87K4wEjwF9hIgAQUPC6WhB5PxD
kFgR2iCV
=qD3k
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--
