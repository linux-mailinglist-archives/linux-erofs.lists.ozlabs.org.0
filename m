Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEB34DAF61
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 13:10:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJTdD50qmz3085
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 23:10:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=WvmzwvFt;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::f30;
 helo=mail-qv1-xf30.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WvmzwvFt; dkim-atps=neutral
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJTdB2MRTz30HX
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Mar 2022 23:10:54 +1100 (AEDT)
Received: by mail-qv1-xf30.google.com with SMTP id j5so1599535qvs.13
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Mar 2022 05:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=4ea6CPjT+8qV8ISTiLeKonKOOW211QC2r3Obyi6gsPY=;
 b=WvmzwvFtsJgnFvY6hLTmm/l7KmvkogevFEUu0moUEfyagGm/tWpeTRSwgpgOYC2W3W
 YGyWYkoyQotnQDIpP7bH7QQlsYciXzJNW6+TuggYzhdY/4DU87j3d1BsEymQXccw17Z3
 MylfPHrovrUYXjSSfF26jez5bQs+suzcr7MgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4ea6CPjT+8qV8ISTiLeKonKOOW211QC2r3Obyi6gsPY=;
 b=BBwjBr+Zqdws8R5wZtTMYmLUthsLdSGy7l88vOp0Svg/YITJSwSYTn+FN5dcMUPIz5
 j6cRZv5Dc3cgeiKQ53phzixjAb1NHLImoNeWHLJbNafG3YwgNno82tEMNzRpz2e2lj6/
 x4n5RD/OUfLnr6alFrlHAXx5OX7YGsVBV27ld5WRS7BhXXB1B5eRy2AJr648tLgWSOxh
 +rHeKf44Bhf7kBIaferaidWDd8dbeVlLs3DUsRLq5Swk9elLHnF3kJIyo4mwsiHQ0OEL
 RIgohMa/jnYVvcoIOKFtREZ4zzVEvcBI+xsY2dMB8yRnm8MC/8plw41yvUTbkjLOf/3g
 wbdA==
X-Gm-Message-State: AOAM533hbK3Gta8rlVrchi68GJ4Vmu9yaCAtxjVNQ8iUChF7xqaKsWRk
 LjA15ZjhFIC22tGTfCxhUvRF2w==
X-Google-Smtp-Source: ABdhPJwb6Bosnp6R7Hgtj0y7SQubqT3l83KBU3/aehnOvf6zv/OvDoF4jvakRS0SdGN7FrBktHnKxw==
X-Received: by 2002:ad4:5762:0:b0:43a:5c52:30bd with SMTP id
 r2-20020ad45762000000b0043a5c5230bdmr20483831qvx.131.1647432651640; 
 Wed, 16 Mar 2022 05:10:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b01-cbda-2ef0-5dff-fedb-a8ba.res6.spectrum.com.
 [2603:6081:7b01:cbda:2ef0:5dff:fedb:a8ba])
 by smtp.gmail.com with ESMTPSA id
 m3-20020a05622a118300b002e1beed4908sm1264772qtk.3.2022.03.16.05.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Mar 2022 05:10:50 -0700 (PDT)
Date: Wed, 16 Mar 2022 08:10:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH v4 5/5] test/py: Add tests for the erofs
Message-ID: <20220316121049.GK577378@bill-the-cat>
References: <20220226070551.9833-1-jnhuang95@gmail.com>
 <20220226070551.9833-6-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vk/v8fjDPiDepTtA"
Content-Disposition: inline
In-Reply-To: <20220226070551.9833-6-jnhuang95@gmail.com>
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


--vk/v8fjDPiDepTtA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 26, 2022 at 03:05:51PM +0800, Huang Jianan wrote:

> Add Python scripts to test 'ls' and 'load' commands, as well as
> test related filesystem functions.
>=20
> Signed-off-by: Huang Jianan <jnhuang95@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--vk/v8fjDPiDepTtA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmIx08kACgkQFHw5/5Y0
tyxUzQv9G9SHDE48h2YlnTSgO+/dYbe7JM/9wgnqIbWXzcwQ7+/H0PXLqz6MtL3p
uTAvCrAxoBcazNrLoESc1ljJTDXz/RA8BEH4yo0X6t7oVZEp4uOsYvAGgPP9R4XK
CR7vitk85kVlt2F5rplud3GHC/wtr2t8Hn2bB82ETVW1cpv08m4hEXW8vxJhj2Ho
5hj5QuqE3+qWNX7iLuYNd79GMkwrFBdM4t+ZEV1mZAlFVLUeH3oFuqekX3+aENR3
eOpCqzFwF3gPjpIdVYJ72WtjlWhEsPE0eLClyCAtU97Oyuw5asaV3vGsrmda8Rba
ONEKNGLfTvGXiQW1CrYDXtW1DuwHL2RTGSFZVY/kAZR/a5Dg778Yim2YP8YA+YtK
c9fMwZVMHirjKTIUMUgWTsJ3C8nKZz2MvtE4f1ILYurlffZfLSx5+sSnHwu2WBx5
Ap2o2lmD8lHvdg4FlWrcQ9zpEYXxpZtHAM7rv4nxCB+hsqW56sF9sOTfX8RJzT9S
1YN36Dge
=NWfd
-----END PGP SIGNATURE-----

--vk/v8fjDPiDepTtA--
