Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DCD4DAF5F
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 13:10:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJTd202L3z30Bl
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 23:10:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=PTO0X1Pe;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::82c;
 helo=mail-qt1-x82c.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PTO0X1Pe; dkim-atps=neutral
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJTcx6Fp3z2yxP
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Mar 2022 23:10:41 +1100 (AEDT)
Received: by mail-qt1-x82c.google.com with SMTP id t7so1522583qta.10
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Mar 2022 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=U96Swc0MbMTG7DvA4iTR1z1AFx26mUmnyJgzCBJ5hb8=;
 b=PTO0X1PeOI926RpCLE/1/XfRSESXGN0Gzmo68dWZU2jo3oK4qWIG1/8dCQmIIQy8Jz
 kALfIwiu7I5FIS/1dJVumF6aTQ69zDxfnQKGZF8ixGnCwW5KM/JbNWIVtX/oYo9vYxcd
 2qX50e233uMFs211tIlsKISOXZvaiIOJUbnWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=U96Swc0MbMTG7DvA4iTR1z1AFx26mUmnyJgzCBJ5hb8=;
 b=rSB7TIx82Fd/iNsXloLqY8uAFVq9dDC3l9DG85jDdb5XmSzJlgPwDgRLrEy6g/E2wN
 th0EBZGnUakPHCk8oYErpfcwOZ6FxPQJW3T+oP5yRysgumU0HpCy5KM0EY3RHUWLOnDA
 1ByRjrt6yyqzeRVtCzj+qQil/k1ugMo4gYSvJwBuq/o/Aa0vCgdPl21IOZIVvBVP9Sz0
 Hrz1JrVb4sCg/inCUearqDjqfEpMVlrRXHOwYFq/tOIZMuYKYoD7+TJlN4HKhE7+gKPw
 J74KvsPeibwwcTIdOfC1DOTD+qnl4k5UkoT0MqO7nQ9w0PAmZrg7e+RDMzJjlLpuq1zT
 uH/g==
X-Gm-Message-State: AOAM531m9h21BfYO4OhAHnfx0S3jmicw/BnUt2WU4txHJGhP9eA6q5hZ
 5rrvfhcuKax1p+3qW0APJTSyGw==
X-Google-Smtp-Source: ABdhPJx161PCpZvnLlRjfBlyQlmODEAPy1EcTuRdqUNo8OAGXdnmy+unW+G0geSxGGYjHp9/20xwVA==
X-Received: by 2002:ac8:5a8f:0:b0:2e1:df21:d86f with SMTP id
 c15-20020ac85a8f000000b002e1df21d86fmr6532803qtc.450.1647432639269; 
 Wed, 16 Mar 2022 05:10:39 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b01-cbda-2ef0-5dff-fedb-a8ba.res6.spectrum.com.
 [2603:6081:7b01:cbda:2ef0:5dff:fedb:a8ba])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a05620a288100b0067b1be3201bsm790675qkp.112.2022.03.16.05.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Mar 2022 05:10:38 -0700 (PDT)
Date: Wed, 16 Mar 2022 08:10:36 -0400
From: Tom Rini <trini@konsulko.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH v4 3/5] fs/erofs: add lz4 decompression support
Message-ID: <20220316121036.GI577378@bill-the-cat>
References: <20220226070551.9833-1-jnhuang95@gmail.com>
 <20220226070551.9833-4-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l0l+eSofNeLXHSnY"
Content-Disposition: inline
In-Reply-To: <20220226070551.9833-4-jnhuang95@gmail.com>
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


--l0l+eSofNeLXHSnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 26, 2022 at 03:05:49PM +0800, Huang Jianan wrote:

> Support EROFS lz4 compressed files.
>=20
> Signed-off-by: Huang Jianan <jnhuang95@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--l0l+eSofNeLXHSnY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmIx07wACgkQFHw5/5Y0
tyw1fAv+KPVe6DS4jGgcPCWowsB+fOiKH51nJJlITpoWrBm4KEn/wSM2Ngx9UvA7
R9GyxoQzin+olxPh/qv6KOsrH8D7MYandttENc9M4dURDL83zQrHZVi/1wAcBntW
rxXSC3xuu3w6Ef+BRRK/LucemCSSBGwjlsE1cYjdGusSRn2u8pnt0X0RFDmxeWk3
iMZMhHOJg6MtqWSj9mRicy8Oj4olN07s7Hril2YkaIqW5/KUMKMHkly9K82DtMQb
WOZNp0KBuseLsYMHE4hVvmW3MfUe47+Sa1yvANNSnIIGc4+7150HW+LOxCQqhkvL
eCozH+1JLUArZFwXu1DOKeGLC8alFY42cs/emLYfWmybTozcnSFYQPtAMOLn2gEN
jli/HBy7WlsllTkreoN1qBqQh33CPU+hc+JOQaVvTfbs58GTiI79Qj2xgqBDVGSU
pVLLxCOpGe6JBYF0N/Cc9hrMlCC3j5hCWKAoTQRJ/bfEAfBGlxMRq3KFhZMh040z
J9jkz528
=SMFR
-----END PGP SIGNATURE-----

--l0l+eSofNeLXHSnY--
