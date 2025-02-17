Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DECA38A71
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2025 18:15:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YxTmw4DDpz30WX
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2025 04:15:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739812511;
	cv=none; b=Ko17ze5kAxbhk7MAAu2gexhfJQwIerjLp13TDOIE3oWa19opUlOjbwd20pjnkKjs1bZ0W109LQImjxnuuEZZ7F7AYJROvXDCWVtlRRxBx1fuVelYiI75H9FQfV7IL5jX0LEL2y9Edmzt6EDS3WtB/WHHF7ocql0SIJknylMK1MvCve1As/c4TfGzOvV6fiQXFnNV7ikGWOKmGo7UDCkPa89ryS+dPEK0mONA6ajafo3DXEjBwtfihVe8ueTi5H2lt00tOLQFVbu8mg1vcIxY9ywaul4ktkGw20dQYXTqyG+TGvWP0Kq32W5XfdSrinYF7Gjv5m+a2KlLF3h8xVub5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739812511; c=relaxed/relaxed;
	bh=d6w6SrLfSq/BmPHBzE73HkAlQRW4hXvADKDcTrFfKOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWbv3xrO+s/Nijs69VEqtslLPbBazuYT1i8qpq/VFALdW3YERSVZarHxD7YggyRkrvUfd0bRhfy9FQ12DsfNZ3yrg1lB+EBmzLhlZtk2Lqi/2D1SvcKf/hMQvaHyUSAyixlsAEwHnkDB8xofExPdckBAIah2e3F4kT7jDzI1Nj3QcaVBepBn2whw235SEk/dJ8RfXSzm4Qwh2ruUXCkxpjn3yLCx4lUMLETxQ/PqxrQV5mlDGJxrHBu4Hpd/491/7kHT7zgL8d9LJAyHfHLUPQyflbwdD+8u26yDL5ekWtUGuafackCaMfh840Anft7LmQLWo8Qw5kcCQsf7eej2rA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=pI4tswe7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org) smtp.mailfrom=konsulko.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=pI4tswe7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YxTms748Rz2xCW
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Feb 2025 04:15:08 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-220c8cf98bbso92122655ad.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 17 Feb 2025 09:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1739812507; x=1740417307; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d6w6SrLfSq/BmPHBzE73HkAlQRW4hXvADKDcTrFfKOM=;
        b=pI4tswe7+ybEWjnlTwiCeSdmqtFI+eZM9fRgn3LYwRj4Nwr987Noe+xtXuYoRWSjlq
         u42dhxw+butkuxkhBJmFicNS/flWps/fgf7KNV21E0rITr0hdCpm/HNm/OGJ+gBsSs0U
         uh89E0Ga9GiXJzJ4RpZfkez0P/tcYIhGP4FpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739812507; x=1740417307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6w6SrLfSq/BmPHBzE73HkAlQRW4hXvADKDcTrFfKOM=;
        b=fGIEz9SOzxlLxIsXqcc/1ChsA56KDhWK6HXCejNIjitpp2AR6ylQnp9AB/3QogOA+0
         NCM+ha1vXUeaIQ/XEACMpUeBeI3WqUEq2UlPHF+pmlJQJxBMJSbDbmn3+DYzQ8Rjopxa
         5e+xe8Th9/7FRkl6uH3dGBDdaMj5CxPIR7vIOF8u8MurrUWSJAwr0zL7mCy5FPPsSAOy
         Rx55oZrhE2mmhHTOGEHexK9BhYpEA9xyV49K5iWB/wRYtZ9HRsdiKzOStPcAD2uIBAqN
         NA7R25moNOzw7Kqhv3b3s6r8HyEFwh8RPCNhJApB8PiyI8mtWNuT6tUcGa9BZVpPo8z5
         +MsA==
X-Forwarded-Encrypted: i=1; AJvYcCXJcEV2PXSWGTgDqIE7ONKPAX3snZTHUK7QCyhzLHi9bWJj18zLRHInck/fbZNIo2SOoFnbEJPNx0IbFQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyb1gd6trBxWGKP+vpAYsOyZcIkVShtYtKEg7+DW0sZs+swa+ut
	Ovj9/ePHS/dbuWYOFxD8my+TqFwB/sIX4l4i0/SxStHl49tzSRnEKgCI/OlLP5Y=
X-Gm-Gg: ASbGncvtMHvLFCIxerj+q7Y3pZf3HTgA4tMy0A77llDZAvzoa/Ot/Ws6XuAj/jvSohv
	4b2lOjVb56RoE0LrqDpxNFCVMwSP2T6XkZWafJOF0W9RQUU2F03IauCyVyKWemzLgGzu8n9aVyn
	mmqh1WQE/pM1V8PNLU4WFK+EELofKFFLq02Ydg8+bmeoKUUsxKOkP4LB8fioynPlVUQGS5iKp3W
	Ili+Pub9OZhd9YbOZj4lLni8Puo/YxX35RByBWlU/55anr1SYEz3bDYVsDS/qBQtYVDpXZ0NI1d
	6vg842WgVdkA+Q==
X-Google-Smtp-Source: AGHT+IGntBBVM0UwMj1HCHAydJTEcS2U+WFc0IoSM5rAQsO5W2p+q4+fm6L0nLW7t29KYiErrQoojw==
X-Received: by 2002:a05:6a21:7783:b0:1ee:c390:58ac with SMTP id adf61e73a8af0-1eec3905c33mr1114179637.34.1739812506665;
        Mon, 17 Feb 2025 09:15:06 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732427801a8sm8369945b3a.167.2025.02.17.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 09:15:06 -0800 (PST)
Date: Mon, 17 Feb 2025 11:15:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 0/6] test: A few quality-of-life improvements
Message-ID: <20250217171500.GA329899@bill-the-cat>
References: <20250209160725.1054845-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QQUigDzOXZl6qp8x"
Content-Disposition: inline
In-Reply-To: <20250209160725.1054845-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Dmitry Rokosov <ddrokosov@salutedevices.com>, Joao Marcos Costa <jmcosta944@gmail.com>, Guillaume La Roque <glaroque@baylibre.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Patrick Rudolph <patrick.rudolph@9elements.com>, William Zhang <william.zhang@broadcom.com>, Stephen Warren <swarren@nvidia.com>, Sean Anderson <sean.anderson@seco.com>, Richard Weinberger <richard@nod.at>, Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>, Roger Knecht <rknecht@pm.me>, Julien Masson <jmasson@baylibre.com>, Weizhao Ouyang <o451686892@gmail.com>, Jerome Forissier <jerome.forissier@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Tim Harvey <tharvey@gateworks.com>, Love Kumar <love.kumar@amd.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Andrew Goodbody <andrew.goodbody@linaro.org>, Caleb Connolly <caleb.connolly@linaro.org>, U-Boot Mailing List <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Padmarao Begari <padmarao.begari@amd.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-erofs@lists.ozlabs.org, Jens Wiklander <jens.wiklander@linaro.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--QQUigDzOXZl6qp8x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2025 at 09:07:13AM -0700, Simon Glass wrote:

> This little series includes a few patches to make it easier to work with
> the Python tests, by shortening identifiers and renaming the 'console'
> fixture to reflect its role as the top-level fixture.
>=20
> It also adds a command to fix testing on samus_tpl
>=20
> This series is based on the previous 'test' series[1]
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D441124

Please note that while the prerequisite series is applied, this does not
apply to u-boot/next and needs to be rebased, thanks.

--=20
Tom

--QQUigDzOXZl6qp8x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezbo0ACgkQFHw5/5Y0
tyyJ6gv+KIRlWAvzxzlpdJoc/BBYr55MIVR/Ckm9FGX93GzTSJ0LHc4awpgKKYWz
qFu6XBX8B998itLHq+s7XL99Ab57qPqUDv1Sb308pKYlvDS+9wClvYFeOggfdZEz
0LrBy47xcox/0x63JePzxhwpCHXMnoN9iLXqYgNNU1456h/h/RmZG/qKnrfyY8M/
Tn5IZIdQIakowAEeHG+FJk/Y6TxMNBgl3kZJVyKC/wlqdkVf87Bgu5gjOxc9wgM4
HB+VPHabEBo04KJ7+A+naZer/PRU1o7+PWaZRnJiEo2UjQO++jX/mZzHySvbE9vI
2YqI5aiTesbJ/FJMAhKNypTnaKbzGxOuSMBtRrJ6zPfwV6C3Dm8CwCfuZk6LY6zs
F/qGSc39eWKCO2seGpcDbEJMoS6BGup3qXz9C8/6qgrHzkEUK2L5a1fodpw3lh6f
gjuhZniaWyeMfS9Z+XzuiAe9bXFzUaHv21YALCzxqQRUaNOTvOsVNIio8rlR5goy
jSftsyIJ
=IB7t
-----END PGP SIGNATURE-----

--QQUigDzOXZl6qp8x--
