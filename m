Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08A478773B
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Aug 2023 19:44:02 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=qIxr9oe0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RWr6m3jSmz3c5C
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Aug 2023 03:44:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=qIxr9oe0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::1132; helo=mail-yw1-x1132.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RWr6g0YWZz3c5C
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Aug 2023 03:43:53 +1000 (AEST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59209b12c50so1878527b3.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 24 Aug 2023 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1692899030; x=1693503830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibk2ad6vG++zB2qc8IXBxsKxSt1w/IwmNZC2NEjluRE=;
        b=qIxr9oe0HywRUtldztNfAtTx22zWsEw+rH1C9bBejbTexZsytRTq64f5uQRnk0YsT4
         4ovHFZHyZauXkAmn5MyDNZQulPBfkPGG4Wb5ClpxbYenrVUHDb1Q1FyfhvLdgJIqZjSf
         Ml/aC8s+0TCjrOmS0JIkAjunwEeTiaLkn+3n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692899030; x=1693503830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibk2ad6vG++zB2qc8IXBxsKxSt1w/IwmNZC2NEjluRE=;
        b=HIhXe0VF2xG4sRkzSb7IDmY+65sn0UzEc6WdFLD3A2rxPThd5ca4Nz9hpFA0MCrl2e
         dCf6NogWAje3bNRlw7jJM8i7tG/goJ7wW+SegMsS94lepMVUK2kiMIheeANwm3CD9ufJ
         fh3gP9aFI8Y1+oWrmVqOuu//LgeaiU3zzjddYb489qMGRwQ4c2k7ecKGMHqTpO8Fxmwp
         v3popV31RIh+jmYpTO/mxh90UIxMw4HOnRPRoM/s/H3xicIYdgU3TzwVhV17Mc4YM/7K
         7zDdDBPufgq98hx622844mns83s5phf/1cHUMxKtFYZVD3n+u1rz1Q0m1r21mcMbvk+I
         CCew==
X-Gm-Message-State: AOJu0YyJkwZvojJAqg7XL1098ANTrDN9mynBYCfkDggHL7TMHho6+mpV
	YwxRpEIh5AQXQ4OXYMBbKkMKZQ==
X-Google-Smtp-Source: AGHT+IHWk0nWPORQqHZmK8o8CGuea0600RU0NARnBcUi+5pQepIJCt76YoGvBD3NE+j1mVsOcFgJQA==
X-Received: by 2002:a0d:d752:0:b0:58f:9cd8:9e4d with SMTP id z79-20020a0dd752000000b0058f9cd89e4dmr18774430ywd.46.1692899030170;
        Thu, 24 Aug 2023 10:43:50 -0700 (PDT)
Received: from bill-the-cat (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com. [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
        by smtp.gmail.com with ESMTPSA id df5-20020a05690c0f8500b005928ba6806dsm12057ywb.97.2023.08.24.10.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 10:43:49 -0700 (PDT)
Date: Thu, 24 Aug 2023 13:43:47 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 00/24] bootstd: Support ChromiumOS better
Message-ID: <20230824174347.GA2382340@bill-the-cat>
References: <20230813142708.361456-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jNhTEQqbNpxBcVgD"
Content-Disposition: inline
In-Reply-To: <20230813142708.361456-1-sjg@chromium.org>
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
Cc: Marek Vasut <marex@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Jose Marinho <jose.marinho@arm.com>, Dzmitry Sankouski <dsankouski@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Joshua Watt <jpewhacker@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, U-Boot Mailing List <u-boot@lists.denx.de>, Nikhil M Jain <n-jain1@ti.com>, Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng.cn@gmail.com>, linux-erofs@lists.ozlabs.org, Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--jNhTEQqbNpxBcVgD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2023 at 08:26:28AM -0600, Simon Glass wrote:

> This updates the ChromiumOS bootmeth to detect multiple kernel partitions
> on a disk.
>=20
> It also includes minor code improvements to the partition drivers,
> including accessors for the optional fields.
>=20
> This series also includes some other related tweaks in testing.
>=20
> It is available at u-boot-dm/methb-working

Please rebase this on top of current next, thanks.

--=20
Tom

--jNhTEQqbNpxBcVgD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnlskACgkQFHw5/5Y0
tyy7Swv+LjUacHIp/i+qatBi0yxY0inbYdYAaEaNEN01ZkHSZmET1yImpRJ0uA0j
eEISAcLa913uAT3zmW3f0L/Fqz1/Tt6/aQsY5JJely7YuPd5FZGVh1FYNxgbkZi2
zHxHmxMCCZ20ewmObH1xLcHMPKRs+xduaAd1ezteCI/Ibj8c97qEdlKg5DrJVBvI
d4OREoM2lL7S/G1b4z0XkVbfg33lgYJcV2Uj6PULwxptc2akLjtIKMHPZJhUc+Yt
pQYh1hCu2U0CF9y5k1fBomYYmrKiCOc541gEAeH3+wKtTaIUQLFIMdGsVK0C9AMz
MeVl+6QvYy7oGBmEXCEPlqtreY/89c2TWgETQtL+WlI1yjtfuZhEmAS7hgCtm/xH
5NJxznGCP9qNguk2biQ+UVTddh0pluQR1Xdw/CR26VCQ+byJjRcDM0a0mllAKZN3
z52fht+v3zz+HPbOv/i1FYqInQdUNDvi2mA6KEYlvElXvcg7eeKTMgtvJcpxJpEq
pm8d00gq
=qhNI
-----END PGP SIGNATURE-----

--jNhTEQqbNpxBcVgD--
