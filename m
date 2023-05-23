Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E769270D27E
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 05:48:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QQKzH4Zp8z3cNj
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 13:48:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=qJ02P5uw;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=bagasdotme@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=qJ02P5uw;
	dkim-atps=neutral
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QQKz94bVCz2yPD
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 May 2023 13:48:03 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae40dcdc18so48914575ad.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 22 May 2023 20:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684813679; x=1687405679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VItIS/bhx2pK7DKXgbtLqFfQgcnhEjrZ88zDqSjOgsU=;
        b=qJ02P5uwWA1Ced6+iu1nAT2ocQ60lNyuLW9VHQzfvGyRQPB5+d9PlXYBHVAtIy+ie1
         BDXssGyGGY3PrOwUe3zpSvLEmAN+1Yfy8Jpj+ungxW8SBd+w4+P6Qe3byUuPFB6pYut4
         o5vlmNTZ3XQ1NdE51/Hs9Jx+5bKTmCZ51JgrKcnRp/ZiW00WpgJ2Kv+ykDXIie6obsSA
         QVSabBSISJ6J7zjslCASKqc55mtiafwWJRGNdABfkK7B30SgjDze+JOhPkGoAzKdufgW
         VQy9LU9PsW7l00X17g8R4KcxV9ekgZlAk4VOc04wURNXb742BmGVfDXFOCPn157SpB2w
         cdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684813679; x=1687405679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VItIS/bhx2pK7DKXgbtLqFfQgcnhEjrZ88zDqSjOgsU=;
        b=NnPmw8sSDJCq1PTmcpdU2v6XvqrBsd/MhRxbAXifHuInV2OJIbD1s5Hh63xZ8Db0Yg
         FfwT6m4jhv4L0sKEirRA9qtUH/LEEI9g887jm8sK3lsvEcDy3VSliHEEbLzW7kRdM/O8
         3Sg/T5OvzVIwTLMs2yrdDDWlOigeggs8Zrk5MfpKJpkP3cZH/ZCpby7MCAXYDkB2pUKk
         0QV/NQb9H7g3ohPJfUSBW2Us6GgQxaIeuyAy6N7UZ9kcjyVti0MZxepDQsbP/Q4SI+6j
         xic0gVjzrh59s6F+MFhODxDbH2SzH2UPN4zUhKOGuJoA4ZPY+s+5x3kkR+S8Oquxj7O7
         BSPA==
X-Gm-Message-State: AC+VfDzqIqLqIc1o6AYbsCIDKuZ+6ypKFcKde3duZymPXZTrv5AZoru9
	NVTBsiNHgNukdYHXi5K09po=
X-Google-Smtp-Source: ACHHUZ4hY2FoUuh40sPKkbwFlfMPRzU3YX5ic+8UeEraTfd5+ivIDPRAKLqH6wPQMI+nSu6p61m6Vw==
X-Received: by 2002:a17:902:8607:b0:1af:c0cb:ddd8 with SMTP id f7-20020a170902860700b001afc0cbddd8mr2010182plo.56.1684813679319;
        Mon, 22 May 2023 20:47:59 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-32.three.co.id. [116.206.28.32])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902654700b001a9a3b3f931sm5673238pln.99.2023.05.22.20.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 20:47:58 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id C8BF01069CE; Tue, 23 May 2023 10:47:55 +0700 (WIB)
Date: Tue, 23 May 2023 10:47:55 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Turritopsis Dohrnii Teo En Ming <tdtemccnp@gmail.com>,
	linux-erofs@lists.ozlabs.org
Subject: Re: EROFS Receives Some Useful Improvements With Linux 6.4
Message-ID: <ZGw3a63tT6E+YjS5@debian.me>
References: <CAD3upLsZ_Y=b4vyWzv4_aX9JOGes=Y-rwqMJ52pDQ+Na+j0xtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zd6w3TNRDbQTelQn"
Content-Disposition: inline
In-Reply-To: <CAD3upLsZ_Y=b4vyWzv4_aX9JOGes=Y-rwqMJ52pDQ+Na+j0xtg@mail.gmail.com>
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
Cc: ceo@teo-en-ming-corp.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--zd6w3TNRDbQTelQn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 01, 2023 at 05:05:06PM +0800, Turritopsis Dohrnii Teo En Ming w=
rote:
> Article: EROFS Receives Some Useful Improvements With Linux 6.4
> Link: https://www.phoronix.com/news/Linux-6.4-EROFS

Linux 6.4 is on -rc phase (currently v6.4-rc3). Can you try it with
erofs enabled and report any issues found?

Also, again, you've mistaken LKML with personal blog/forum. There are
many forums on the Web discussing Linux for this kind of message (for
example: Hacker News and linux.org forums). Please DO NOT do spam like
this in the future.

Bye!

--=20
An old man doll... just what I always wanted! - Clara

--zd6w3TNRDbQTelQn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGw3awAKCRD2uYlJVVFO
oxzkAP4mhEGfVA99VOR/zZBvhWQrmdmDvduP+6tAg2J+8qExvgEAyqKbkFsvF6dc
ZSjii4GHgvBIpPhvhGHW0UTL8ll9Ig4=
=EAFr
-----END PGP SIGNATURE-----

--zd6w3TNRDbQTelQn--
