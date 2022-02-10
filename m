Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 307F94B0EE6
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Feb 2022 14:35:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jvd626BLfz3bY4
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Feb 2022 00:35:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=FHSvrukP;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::82a;
 helo=mail-qt1-x82a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FHSvrukP; dkim-atps=neutral
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jvd5z49kzz306m
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Feb 2022 00:35:01 +1100 (AEDT)
Received: by mail-qt1-x82a.google.com with SMTP id o3so5138941qtm.12
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Feb 2022 05:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=HBy4m0kNyc862wG3crx8WNg6VXzE9fwOz60PrKFYb7g=;
 b=FHSvrukPqFFHgjxq1nrVj8pOFj0g+nCodLJLRwvZTTEJ6DJPOsb3qOK0Yb06246s5l
 nvcAW5KKXROfqp/CWaPoJ6cRA9/IBBrtFN8AiAkP1M5sT1YGOtcSMsKrsgIvqncUhwHy
 tRj4t2FtS9sfRXk9+b84BfbcGk4CKGJ7ivrNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HBy4m0kNyc862wG3crx8WNg6VXzE9fwOz60PrKFYb7g=;
 b=cBUpBlIf5EbcMMfznT+AmM7dD/1xueNMwyQyAVZnk/xJLktOQ7QMozhy67TMlnekQd
 1YyfbY1OPlMMQ5nlBHpGwANS2k6nTrkMy70dy9S94YYl2czZEIz28B83yBIHejBRph7k
 pFhVfSV4Wuc01EsR1PL/TkdTzQn74zFNA80RaIaxCM7+ZsZ87c2zhdUMuBiosXSHM7zH
 kEVivTeFnx/Aekc+3Gg+DHUR6HRqACE2z2TeFhM23NlBz9rBqqMvs7ZxdoaXckX6mtGN
 elBJlw5u3NiMPd0S31dXunAamjm4wsHnY8A6GFtJ70ppZjhZsw7pwQ6SY37NDcx8ZLXY
 7GYA==
X-Gm-Message-State: AOAM530ewxdgbz1F2g9ccYtOKPD3ozKtR8/rlW2Cf0ddTC9PVR1PGfqG
 KLTYRX25q3yAu66S45BqnE54IQ==
X-Google-Smtp-Source: ABdhPJxnjcy9hpfd696IVMY759OpH6Zw87HKI763n25H16DsQr91g6QVW4PLn4RbSB4np4+BQ/61Pw==
X-Received: by 2002:a05:622a:1aa1:: with SMTP id
 s33mr4768157qtc.612.1644500098241; 
 Thu, 10 Feb 2022 05:34:58 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b01-cbda-2ef0-5dff-fedb-a8ba.res6.spectrum.com.
 [2603:6081:7b01:cbda:2ef0:5dff:fedb:a8ba])
 by smtp.gmail.com with ESMTPSA id s2sm9488965qks.60.2022.02.10.05.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Feb 2022 05:34:57 -0800 (PST)
Date: Thu, 10 Feb 2022 08:34:55 -0500
From: Tom Rini <trini@konsulko.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v3 0/5] fs/erofs: new filesystem
Message-ID: <20220210133455.GE2697206@bill-the-cat>
References: <20210823123646.9765-1-jnhuang95@gmail.com>
 <20220208140513.30570-1-jnhuang95@gmail.com>
 <YgUIaIWOpfOJfukN@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline
In-Reply-To: <YgUIaIWOpfOJfukN@B-P7TQMD6M-0146.local>
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


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 10, 2022 at 08:43:20PM +0800, Gao Xiang wrote:

> Hi Tom,
>=20
> Would you mind taking some time having a look at this version
> if it meets what's needed, so we could have a chance to be
> merged in the next u-boot version?
>=20
> It's almost in sync with the latest erofs-utils soruce code,
> so it can be upgraded easily in the future together with the
> later erofs-utils versions.

Things seem fine, we just need to also update the Dockerfile with tools
so that the tests are run.

--=20
Tom

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmIFFHwACgkQFHw5/5Y0
tyzWxAwAsPkDv5kLeHG1qzLhyqeiPWFnI3gZl9ZmZhX/vy96ibUWdZAWXZrNWneB
Lx4uk/WndFN0gSrl2DzjA80qb7RDqi1byJM53thrVAhn3PBrktrn92hM3eItE/9o
Q827xfQUB4Nsf7xdwtc8e9Uj/k5TGnM/O1ZC9gf3ZBIDzu+OFDZCGBAiom17ZZkz
bI+bueH6gSmg9N1He/HROyix0CHkqtTdYFxcY9r7hFgXPt/frT1IcbkJByaaqzi+
CdVogMrS9Z8K0OTTpac4xK6fFe1ZpJ4yhZYiTnz+yAkfBt3D03r5UWt3L2I7pkaz
s+nv1/xB8Q4c269L187FLoWYBl05RjPQtvxCoe9MVeymKDvB/nGrhpAj89z0CNPx
3PTreBACo4YR8/4FOqUKD6eyV6N/MfGqQ0E6ENcyN7UL77DpNqIl55caTG0J4E2X
0PIEq5/uaBKQOv7ZfIOuNwirHy0rUQnYvjFBkKXKl/qRTRm2rgzM5xVa5/bHkUm2
pIJ13HF7
=L7t6
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--
