Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41B83F7EBA
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Aug 2021 00:40:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gw1Bv26SLz2yZ6
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Aug 2021 08:40:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=mxUytPHM;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::836;
 helo=mail-qt1-x836.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mxUytPHM; dkim-atps=neutral
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gw1Bk4XMbz2yJ6
 for <linux-erofs@lists.ozlabs.org>; Thu, 26 Aug 2021 08:39:58 +1000 (AEST)
Received: by mail-qt1-x836.google.com with SMTP id u21so861075qtw.8
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Aug 2021 15:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aLtnJNnJQVj3F97g+RoD0GlWcOi+SzVAbv3BWHY3sJw=;
 b=mxUytPHMPNaO2Zj3+XKzDD54/zgnYPk81CY9u8tX/pA5ejVE+MkN0ufzrVxTWSlYKl
 gh6IoMeQ3Nb1fCzgERKYqLS5FZJEFZFbAVKI1U6TEQejgY4nDSBXu5wTB9PoE4qdqgTz
 8ufTxHBT1yQw/pcaWSPI5/3pcikkPTBKBmwt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aLtnJNnJQVj3F97g+RoD0GlWcOi+SzVAbv3BWHY3sJw=;
 b=foh1xg9kxaEQhQPfTW+6+AA4zC/EH+2l47Pq0u5F0de8EMMtSaK7mK9vNmDrAghEb/
 9dACaWCElvMwdgwAVZDJZL3R1a1AtwgjumjLyp8QFNIWWz3lVSplvad7Vi41CM7UqyW0
 7FBLjRVS/MhBF4nnz5mefSHwmP8E2rvf4j0ikiv8RqDYMu62F4PdLGKVXovdNVDuz1kI
 tNB72MmqYjCPN3CuDH3LvYMOWeD/9twMm77hOp5dzReJQHNZCodbwltqlgZNjmaWI1m1
 mWowJoJ5ZccEoTl5/1ACJ3gBo6vGdgXz4ItfcrUI79PGHI9hio+adRgRXHiskE4IJDnK
 6WcA==
X-Gm-Message-State: AOAM531GEeHWNo5LtaJgY6Cvfrxc/w5TsNofKEOZNEXmHl3dn8LKlYCS
 R85d/psIurmk7qhMF0ihRb6hrw==
X-Google-Smtp-Source: ABdhPJwQs3zWR4rSUKzGbTPhtrOnQAxWdmyZagyLy5O4JkBOoK47GvF9F9zSUXwstJRJenTzLfffog==
X-Received: by 2002:ac8:7c44:: with SMTP id o4mr618117qtv.82.1629931196117;
 Wed, 25 Aug 2021 15:39:56 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b01-cbda-519a-4843-2801-9790.res6.spectrum.com.
 [2603:6081:7b01:cbda:519a:4843:2801:9790])
 by smtp.gmail.com with ESMTPSA id v7sm1088491qkd.41.2021.08.25.15.39.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 25 Aug 2021 15:39:55 -0700 (PDT)
Date: Wed, 25 Aug 2021 18:39:53 -0400
From: Tom Rini <trini@konsulko.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH v2 2/3] fs/erofs: add lz4 1.8.3 decompressor
Message-ID: <20210825223953.GE858@bill-the-cat>
References: <20210822154843.10971-1-jnhuang95@gmail.com>
 <20210823123646.9765-1-jnhuang95@gmail.com>
 <20210823123646.9765-3-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="67mEQbfzuM3ONtT/"
Content-Disposition: inline
In-Reply-To: <20210823123646.9765-3-jnhuang95@gmail.com>
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


--67mEQbfzuM3ONtT/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 23, 2021 at 08:36:45PM +0800, Huang Jianan wrote:

> From: Huang Jianan <huangjianan@oppo.com>
>=20
> In order to use the newest LZ4_decompress_safe_partial() which can
> now decode exactly the nb of bytes requested.
>=20
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
>  fs/erofs/Makefile |   3 +-
>  fs/erofs/lz4.c    | 534 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/lz4.h    |   5 +
>  3 files changed, 541 insertions(+), 1 deletion(-)
>  create mode 100644 fs/erofs/lz4.c
>  create mode 100644 fs/erofs/lz4.h

Why not use the existing lz4 support, or if it needs updating for new
features, update it?

--=20
Tom

--67mEQbfzuM3ONtT/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmEmxrkACgkQFHw5/5Y0
tyxxAQv+KicWhjlLVLt/1wFUuT/TaXcNE4zH+gEn9Pbzwfam75o94jdjOs5+WE5U
X4gzDQRtOo/ssYiN3/TGEufmdsgWNhvXg58fpbLRaT6ia5jP+yBH0tim88cTQePW
dmVbjNl3ijd1zSWJdDGckmkfqr4OGMg0Cb2r4EcyX5vc7YEup3HfJooE7uPLlzg3
VsYSDjjHahDzcjf0LfiluC7U8UigTy6GK4l2VyEpl+7Py2RtjFwsNjAEL1QMkuVa
8PSWvc+SmPuX3p25mpNDiT1MnKHj8vOO59NN6cnHAJgaOuiOx2SFy/ON8hn6uIT2
04Gne7iLFN0qpi5U1dodVVVU/rHXSkguYnjtHMLt7urR7ePGBOVD1UW/69K8CWf3
DbJPRlZKqM2V5fChghwWkROzcKOZCJFyXt27QQc+DldK5ZgjjmnPEytQB0X/p0wb
lqnAnFOqH8Bgw2roZkv1cYN/H7YB9ZLZXWrb9/6fAYiGlLWmTXd1bZaPabun7m5T
O6qqFFs6
=+qCy
-----END PGP SIGNATURE-----

--67mEQbfzuM3ONtT/--
