Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201D15A2973
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Aug 2022 16:30:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MDj0k67Ggz3bkk
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Aug 2022 00:30:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=J9iTFXaD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::f2a; helo=mail-qv1-xf2a.google.com; envelope-from=trini@konsulko.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=J9iTFXaD;
	dkim-atps=neutral
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MDj0c0XtFz2yn3
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Aug 2022 00:30:05 +1000 (AEST)
Received: by mail-qv1-xf2a.google.com with SMTP id w4so930150qvs.4
        for <linux-erofs@lists.ozlabs.org>; Fri, 26 Aug 2022 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=7djctMO83sCUteqToXrmSm4HkVVRXqci+u3SX9On+cE=;
        b=J9iTFXaDV5zKnqScM3qCfHEwKY91JI3KS81f3pw3LCsw4UMqIbK9jCTlxzkUp+V+bX
         dKbfrjdtKYjfN+FgcxrLPugRSqmRsUsOpcZfRfdJ/FaU9E8bhaf5ngRODlNB9sA3OcOW
         sHULwKSQg+Y9c0JycF/Ti7aEokvFHtZFF2OBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=7djctMO83sCUteqToXrmSm4HkVVRXqci+u3SX9On+cE=;
        b=cLg1H4Q9JhEPWcXROHFyJE8C3m4GEeobkQwq3dDvxufckPDL7rsHNiGl6jDXhpm8B6
         Gg0UbnMi75zwUDGsq/+7zPNr60oy0WQzuk3Jnj4y/K+V6xNWlF8+IKEpZ3QKTDr4NVcR
         KZE3hX35BzGwQm+Pl+dyGVONj03crO0WSS2FZozoPqZ6+SKGwhq4eEQFWKSu4hLebhNk
         ksnx3HWtOMV2fXHXlu1yV5ebK+SYAm2EMlmREMqtjoPs6pSkI/UZ6eFVqQwD7d+F+Z8Q
         cYa+T/YsMEsM0rtf5fOFyWL8Kp6WO3+R0KImHYYRrupWrbhlCnWB0+e/yeZeXLe2Boii
         Uukg==
X-Gm-Message-State: ACgBeo3Q2xk2kHqaiVEpqMlIxl01JdmLo0h+/vdrqrN17uiGVBn4Z8LW
	HQCi2KmmPKq5+P+xfWUh70DlZA==
X-Google-Smtp-Source: AA6agR5OFeG1GMQT2U3GUgWkAD+f5eY2z6StvNKaU5RCgy6i1wfJv7eY1seT8Djap4gZPp7OtLwG3w==
X-Received: by 2002:a05:6214:21a7:b0:496:fe62:1aeb with SMTP id t7-20020a05621421a700b00496fe621aebmr8408778qvc.60.1661524201943;
        Fri, 26 Aug 2022 07:30:01 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-195-139.ec.res.rr.com. [65.184.195.139])
        by smtp.gmail.com with ESMTPSA id f7-20020a05620a408700b006b555509398sm1854285qko.136.2022.08.26.07.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 07:30:01 -0700 (PDT)
Date: Fri, 26 Aug 2022 10:29:59 -0400
From: Tom Rini <trini@konsulko.com>
To: Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v3 0/8] U-boot: fs: add generic unaligned read offset
 handling
Message-ID: <20220826142959.GA2641429@bill-the-cat>
References: <cover.1660563403.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <cover.1660563403.git.wqu@suse.com>
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
Cc: joaomarcos.costa@bootlin.com, marek.behun@nic.cz, u-boot@lists.denx.de, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 15, 2022 at 07:45:11PM +0800, Qu Wenruo wrote:

> [CHANGELOG]
> v3:
> - Fix an error that we always return 0 actread bytes for unsupported fses
>   For unsupported fses, we should also populate @total_read.
>   Or we will just read the data but still return 0 for actually bytes.
>=20
>   Now it pass all test_fs* cases.

We're failing squashfs still, sorry:
https://source.denx.de/u-boot/u-boot/-/jobs/486819#L399

--=20
Tom

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmMI2OMACgkQFHw5/5Y0
tyzu1Qv/ReTXvdoay5Pq8nGzLMiVatpiimZAFQGmXUbKcBrtiloM59Yuc1QAgBEv
RrDdsLZFXunS46iGDSM5aPOio1/gXvz4PrIrSP5ctxtZaQS9TojuE7tHsxTSvfd9
0iawlgkxjjbFIofpO8g8MJGsqxz6TDJ1Bvg9r0/YCNANzY2RJgeTCBtkolelxV+U
QdS+BCzKNIUM69mXKK1C7NSbhh1OXt2tGNEFlTP41qSC5CDdX41Y62LvzYpXT7Ny
QlYfbvubrL3pDEkDNGPeHDusOpaoBrDnfydcYANrl80LXVvdi6vziaI2s+qsnRz4
oUbKLPi/glv//uOcpOy9ebAvYPHusG4K62Czwjf8JO588zM81Ep+c5jNkv1rNeig
pOXDRw84Tc/CMheT7mm+mGS0eDb0gtZ3eLpUIZk6QI4CNaWAIwYUVEGUwNYkt0ML
CguZ5FUMf3o0/DZPYBLlRPIIJEDZEwNzAPb1oUytrpwHwQg370mT0fmbESQe6tvn
jkQ3wgZp
=csTn
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
