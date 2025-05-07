Return-Path: <linux-erofs+bounces-298-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9AEAAE70E
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 18:45:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zt1Mr2yLHz30Lt;
	Thu,  8 May 2025 02:45:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.219.36.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746636312;
	cv=none; b=GDWJjJ/6Zcs91bC5m36mm/pNz3Y7h+PKRLkRWgbFl5dzjL7thqGF1y/g4IlNJ1zaAv8SvcM5c1lfqJ8UddB6gDLPDo+1k7Nn7Tupu7cxGCIh7MtccSrBYP9Ta5n/eMVIM7UvdH7ZaDQN+8np3GMDYA11YBNO2VuK18quvw1p8v1dcP/7Ao8xUSHugwNFAV8xngWhvhk2sljnNhAKPFl3+Izp8feC9y1vRA9Zga57fcDUBcvDTlZGoQqrl9ZRfj3fwFAd3fy+7IQgjWaABuYate8wZ944//rYvnYTzEdH2XGcknaCzZ6SedeVftd8DajHvCmlMMjTfQB5x9c7K7ac8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746636312; c=relaxed/relaxed;
	bh=I0rFiB+oxYgNb2S2WvSkA9ZDK1EOhpKXNopgoCiSZQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLCg0rKBE6rCOQRHESCDn0dDzCBirbudr9ctAgByIWh8SCd/4DmlcQFRlovMgjCtnOu77Or95aaXJsNvLW7YfWsmuPBBTQS5gJllveFZFs0NrxVxaZlmdAWKoeezuhfV7C/WKiNiC+M7oqv8jmi+BEvP9JOW4DwQPAT143PLZ1QabH8eOs4yCerKBBdaXvPpptYZ+FHoeKVL7lXBAz1XirMkMJnBQEvM0tqMofpemmlOJhX5JqYNZECjkGFO85v98ehtU5dGgboAT3KFNiDs/e7r3RzZTRulFUcaFBq0+HKpe4r371Z4f6RQqEUMtKsy3ujPiBj8PCxOXA09gPCyAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org; dkim=pass (1024-bit key; unprotected) header.d=alpinelinux.org header.i=@alpinelinux.org header.a=rsa-sha256 header.s=smtp header.b=MCyAcj85; dkim-atps=neutral; spf=pass (client-ip=213.219.36.190; helo=gbr-app-1.alpinelinux.org; envelope-from=ncopa@alpinelinux.org; receiver=lists.ozlabs.org) smtp.mailfrom=alpinelinux.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=alpinelinux.org header.i=@alpinelinux.org header.a=rsa-sha256 header.s=smtp header.b=MCyAcj85;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alpinelinux.org (client-ip=213.219.36.190; helo=gbr-app-1.alpinelinux.org; envelope-from=ncopa@alpinelinux.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 592 seconds by postgrey-1.37 at boromir; Thu, 08 May 2025 02:45:10 AEST
Received: from gbr-app-1.alpinelinux.org (gbr-app-1.alpinelinux.org [213.219.36.190])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zt1Mp1Mmwz30DP
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 May 2025 02:45:09 +1000 (AEST)
Received: from ncopa-desktop (unknown [IPv6:2001:4646:fb05:0:2019:9f78:bd61:c917])
	(Authenticated sender: ncopa@alpinelinux.org)
	by gbr-app-1.alpinelinux.org (Postfix) with ESMTPSA id E0653223654;
	Wed,  7 May 2025 16:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpinelinux.org;
	s=smtp; t=1746635711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0rFiB+oxYgNb2S2WvSkA9ZDK1EOhpKXNopgoCiSZQE=;
	b=MCyAcj85VnD9iJxxBD7p3xm5S2Z+wlQqc7/gaQIhhEyVEBDEGs7oJ39m1mATCdnUKbNbdp
	Vt9XBnLoe2gtNsGNCk9d77Yk5tXQ1twUsTu3PifVUUPodgalGXbEo5i5Ta2spoLwqbh92R
	XRlHdXaKNsniRm4E96bK8cygj0bf76Q=
Date: Wed, 7 May 2025 18:35:07 +0200
From: Natanael Copa <ncopa@alpinelinux.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, "Milan P . =?ISO-8859-1?B?U3Rhbmkq?="
 <mps@arvanta.net>
Subject: Re: [PATCH v2] erofs-utils: fix build failure with musl libc
Message-ID: <20250507183507.09027ea8@ncopa-desktop>
In-Reply-To: <20250507132548.2293699-1-hsiangkao@linux.alibaba.com>
References: <20250506121102.GA15164@m1pro.arvanta.net>
	<20250507132548.2293699-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-alpine-linux-musl)
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed,  7 May 2025 21:25:48 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> because musl use readdir, pread and lseek instead of readdir64,
> pread64 and lseek64.
>=20
> Reported-by: Milan P. Stani* <mps@arvanta.net>
> Thanks-to: Natanael Copa <ncopa@alpinelinux.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> (Fix wrong email address typo..)
>=20
> Hi,
>=20
> Due to the original patch lacks of the commit message and
> SOB, so I revised myself.

Ok with me.

>=20
> I add "_FILE_OFFSET_BITS 64" in the top since "contrib/stress.c"
> can be compiled individually.

This looks correct.


Thank you!

> Feel free to repost a formal patch if inappropriate.
>=20
> Thanks,
> Gao Xiang
>=20
>  contrib/stress.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/contrib/stress.c b/contrib/stress.c
> index d8def6a..0ef8c67 100644
> --- a/contrib/stress.c
> +++ b/contrib/stress.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright (C) 2019-2025 Gao Xiang <xiang@kernel.org>
>   */
> +#define _FILE_OFFSET_BITS 64
>  #define _GNU_SOURCE
>  #include "erofs/defs.h"
>  #include <errno.h>
> @@ -271,7 +272,7 @@ static int __getdents_f(unsigned int sn, struct fent =
*fe)
>  	}
> =20
>  	dir =3D fdopendir(dfd);
> -	while (readdir64(dir) !=3D NULL)
> +	while (readdir(dir) !=3D NULL)
>  		continue;
>  	closedir(dir);
>  	return 0;
> @@ -428,7 +429,7 @@ static int __read_f(unsigned int sn, struct fent *fe,=
 uint64_t filesize)
> =20
>  	printf("%d[%u]/%u read_f: %llu bytes @ %llu of %s\n", getpid(), procid,
>  	       sn, len | 0ULL, off | 0ULL, fe->subpath);
> -	nread =3D pread64(fe->fd, buf, len, off);
> +	nread =3D pread(fe->fd, buf, len, off);
>  	if (nread !=3D trimmed) {
>  		fprintf(stderr, "%d[%u]/%u read_f: failed to read %llu bytes @ %llu of=
 %s\n",
>  			getpid(), procid, sn, len | 0ULL, off | 0ULL,
> @@ -439,7 +440,7 @@ static int __read_f(unsigned int sn, struct fent *fe,=
 uint64_t filesize)
>  	if (fe->chkfd < 0)
>  		return 0;
> =20
> -	nread2 =3D pread64(fe->chkfd, chkbuf, len, off);
> +	nread2 =3D pread(fe->chkfd, chkbuf, len, off);
>  	if (nread2 <=3D 0) {
>  		fprintf(stderr, "%d[%u]/%u read_f: failed to check %llu bytes @ %llu o=
f %s\n",
>  			getpid(), procid, sn, len | 0ULL, off | 0ULL,
> @@ -477,14 +478,14 @@ static int read_f(int op, unsigned int sn)
>  	if (ret)
>  		return ret;
> =20
> -	fsz =3D lseek64(fe->fd, 0, SEEK_END);
> +	fsz =3D lseek(fe->fd, 0, SEEK_END);
>  	if (fsz <=3D 0) {
>  		if (!fsz) {
>  			printf("%d[%u]/%u %s: zero size @ %s\n",
>  			       getpid(), procid, sn, __func__, fe->subpath);
>  			return 0;
>  		}
> -		fprintf(stderr, "%d[%u]/%u %s: lseek64 %s failed %d\n",
> +		fprintf(stderr, "%d[%u]/%u %s: lseek %s failed %d\n",
>  			getpid(), procid, sn, __func__, fe->subpath, errno);
>  		return -errno;
>  	}
> @@ -504,7 +505,7 @@ static int __doscan_f(unsigned int sn, const char *op=
, struct fent *fe,
>  	for (pos =3D 0; pos < filesize; pos +=3D chunksize) {
>  		ssize_t nread, nread2;
> =20
> -		nread =3D pread64(fe->fd, buf, chunksize, pos);
> +		nread =3D pread(fe->fd, buf, chunksize, pos);
> =20
>  		if (nread <=3D 0)
>  			return -errno;
> @@ -515,7 +516,7 @@ static int __doscan_f(unsigned int sn, const char *op=
, struct fent *fe,
>  		if (fe->chkfd < 0)
>  			continue;
> =20
> -		nread2 =3D pread64(fe->chkfd, chkbuf, chunksize, pos);
> +		nread2 =3D pread(fe->chkfd, chkbuf, chunksize, pos);
>  		if (nread2 <=3D 0)
>  			return -errno;
> =20
> @@ -547,14 +548,14 @@ static int doscan_f(int op, unsigned int sn)
>  	if (ret)
>  		return ret;
> =20
> -	fsz =3D lseek64(fe->fd, 0, SEEK_END);
> +	fsz =3D lseek(fe->fd, 0, SEEK_END);
>  	if (fsz <=3D 0) {
>  		if (!fsz) {
>  			printf("%d[%u]/%u %s: zero size @ %s\n",
>  			       getpid(), procid, sn, __func__, fe->subpath);
>  			return 0;
>  		}
> -		fprintf(stderr, "%d[%u]/%u %s: lseek64 %s failed %d\n",
> +		fprintf(stderr, "%d[%u]/%u %s: lseek %s failed %d\n",
>  			getpid(), procid, sn, __func__, fe->subpath, errno);
>  		return -errno;
>  	}
> @@ -576,7 +577,7 @@ static int doscan_aligned_f(int op, unsigned int sn)
>  	ret =3D tryopen(sn, __func__, fe);
>  	if (ret)
>  		return ret;
> -	fsz =3D lseek64(fe->fd, 0, SEEK_END);
> +	fsz =3D lseek(fe->fd, 0, SEEK_END);
>  	if (fsz <=3D psz) {
>  		if (fsz >=3D 0) {
>  			printf("%d[%u]/%u %s: size too small %lld @ %s\n",
> @@ -584,7 +585,7 @@ static int doscan_aligned_f(int op, unsigned int sn)
>  			       fe->subpath);
>  			return 0;
>  		}
> -		fprintf(stderr, "%d[%u]/%u %s: lseek64 %s failed %d\n",
> +		fprintf(stderr, "%d[%u]/%u %s: lseek %s failed %d\n",
>  			getpid(), procid, sn, __func__, fe->subpath, errno);
>  		return -errno;
>  	}


