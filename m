Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EECEA1C553
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2025 22:51:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YgT002Kbsz2yyR
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Jan 2025 08:51:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::730"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737841870;
	cv=none; b=FyadyzfgIMcYrS9VLkHaamWpnLEz/iRQki6LGH9Sdxn5bLd6y27xslMn45z++ROiVE2parzrRpNkjaTo8ycXSdsnrXyFnS6HnOdTfepeEtlEFG5Ec3hwBKNkvKaIgxzJo02q/ZhdSTzmXQqGmyeCHDV1PinwoJAo+YlQBn0q4EyS7+mXNQsJrx2PEXm3+qe59aIqMhI+dsR/UvjjLE3TUxRaipCwfCYGQ1miCtgucUIivJTfkRJF3FuA2oGmTQ++pMOtu9cONcqBgI32BL68GwDn2Z02E2UuRixqJMvIlGnagfSJ8D3/v6V9ziwcMeum5xOcghx72uwHk2N4t0OHjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737841870; c=relaxed/relaxed;
	bh=RCItPAumNi3YkPwAhGuoBy61cd38EX/U8qv2kfxS+Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFjUZPqWND1U38dSqk79bYAUeTjY58piu/CUBCAhTBtYPvmI+HSrD3KdxI7JlE+zvdHtJ85NdQBde8cP45FEv3+TsDdUu2+kkZGQ2UrS/o785r5qNoRM8MU/vpx94rq3BBRRW2vb3uzPQYhtFY5NZjRdovXgrSbv/efUXoEAxlx/5esH84bOG6yCH0Evz1r/TgwmTZUtsyeF55D7GGGhXYU4XnL/pcwwpvn9ujpyJ4b9xqj7+uMDMC6CDjdI1iACnCMkwcSC+YlHytKuMcmpmPM2g2YZFj/v1EyKr+4pCtUh2uFkwPtlEsbas6qMUzNQk4wQ9rj6mDhaZ5aXyoYdrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=uMvezN2E; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::730; helo=mail-qk1-x730.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org) smtp.mailfrom=konsulko.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=uMvezN2E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::730; helo=mail-qk1-x730.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YgSzt0Ngwz2xsW
	for <linux-erofs@lists.ozlabs.org>; Sun, 26 Jan 2025 08:51:04 +1100 (AEDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7b6e5ee6ac7so280483885a.0
        for <linux-erofs@lists.ozlabs.org>; Sat, 25 Jan 2025 13:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1737841862; x=1738446662; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RCItPAumNi3YkPwAhGuoBy61cd38EX/U8qv2kfxS+Pg=;
        b=uMvezN2EWllYvJAdnVn3lPmn9HXmicX+8pmHrd1K6pvQR2ZPWMSUDWFXcjYDOk8e/x
         yDlpT3DzjrBeRFBTRaaBmXbfnvin+p+80um1W8jiGAv8oV9BeIYrsFAmkxADVSVClzVv
         Xrjr0IuPUVzRlD+6E775CDM/BsyeDV2pGhv4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737841862; x=1738446662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCItPAumNi3YkPwAhGuoBy61cd38EX/U8qv2kfxS+Pg=;
        b=dfOweD9zxQbpOjPEfLnel70TeR2F11a0GVH6z4I5LOqNRbnpqviLrq/opHbhdl+MTI
         VEpYF+s89rlBfqYOz7MirKOAw/+0BzGo0l35Gh1u7FS6BdyqUMca3kcOYMOYvkvwBPg/
         sUroOkJCOb03yd9cM6F07eziwCP+u0ijFnVIPlCRNNSRMcVR5CSRCIJaGbnCOkzts6ZD
         yD7m+t5188W48EJB4d2FOFxBsBzLPr4oYPMp736p+raVeRwMyrDP3kZIe4Ah2LEPkN8b
         K50T6yUSxsYuLogELYgWakDPsu2lEZN8Ho8y8gy7+wHoD2KZav18jxiPfbIMLgtE6asu
         xB4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFO/LFOgoHfhT4NxZ2Er6j+MSeOZ1666FWplo7ZJd4NElUagqi5oajWQMw4W5/4UUKAreIhQJufjlUcg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxleLqO9zchFKN/2A9BfyekASW1V7WED5QKynFsxoYqMQe1w88A
	+oGXUH8oRJnPgUGWTN8t394mzXia+S4F9NY9W46OO7fWI/8cabo+i0DYokTY7iM=
X-Gm-Gg: ASbGnct4E+M5NWpJ60r/zRYFKSGKivs07eSUsLAj4WZO0U7a0qCVjFx2age074gI76R
	n0vYFZeXTcG0qLc7sLoC+pH8PU7Xt+iSOlyZJW8O//ZKhhslcq+avpc8gonD9lNkJTCCQtUGndp
	twS4VHzXR2DD6wP7vxSIZccCCGAx1jRU+jK81h4YmbCATe5Aq/WwuCaWSjjFBwE2SyM/rqjCuKM
	n9WfDlzDNpTiMboW5euvdm2Mw245khnyszapsR1t8womPK+6Xv4iC4YmDkd2IAMbWp6g+WUB0SB
	N1OI
X-Google-Smtp-Source: AGHT+IHeK4cv2sXskxlDG8IFY7pxHg4PO1aDJJb7l3aMTWxfgOQSxnxX4eBZRNGqvA1WVhOADmEFgg==
X-Received: by 2002:a05:620a:19a1:b0:7b6:6701:7a4d with SMTP id af79cd13be357-7be6328a7e0mr5997376585a.56.1737841861972;
        Sat, 25 Jan 2025 13:51:01 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae975a3sm230948485a.49.2025.01.25.13.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 13:51:00 -0800 (PST)
Date: Sat, 25 Jan 2025 15:50:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/4] test/py: Shorten u_boot_console
Message-ID: <20250125215055.GF60249@bill-the-cat>
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cKP0ipwRxRNGqurb"
Content-Disposition: inline
In-Reply-To: <20250125213150.1608395-2-sjg@chromium.org>
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


--cKP0ipwRxRNGqurb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 02:31:36PM -0700, Simon Glass wrote:

> This fixture name is quite long and results in lots of verbose code.
> We know this is U-Boot so the 'u_boot_' part is not necessary.
>=20
> But it is also a bit of a misnomer, since it provides access to all the
> information available to tests. It is not just the console.
>=20
> It would be too confusing to use con as it would be confused with
> config and it is probably too short.
>=20
> So shorten it to 'ubpy'.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
>  102 files changed, 2591 insertions(+), 2591 deletions(-)

First, I'm not sure I like "ubpy". I believe "u_boot_console" is because
it's how we interact with the stdin/stdout of the running U-Boot. And
indeed it provides more than that. But ubpy is too abstract and unclear,
and looking at the diffstat, I don't know that big global rename is
justified to save text space.

--=20
Tom

--cKP0ipwRxRNGqurb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVXL8ACgkQFHw5/5Y0
tywwUgwAmCv9+cbELcIz5xmY51Ptx1hbkOc8rIb+WeKSZQ7cFhIqTVMnzhhYZSq+
BGT6YUm5pkX+YBrSPSfhMGnPQ+ih5s/gAeVukiMGx75yqDF0fo5WHlnw/VgUHTnL
IpB5ey0sUWUXvhC1BvnKY8gT1SQpdP3594C1NYujUz4sExWJ7Q6mPHSnuxs7Lcax
6dJiKJyLsGEQPVtcH28uj9UOyJumdF7XG/ixgON5Pwzlw9koypzLGmOSz+9OXXHI
VnK4MwurWUuwzGguelnngfsDgmDPYtpVm5DxPlpSedHNRhMF6AisqQUqRdV6XbCp
yLncbxFCRRjDlSl8i+4GmZgN8Pm6hKGQ/qBQw/z0veGuzuBp8fpFqEfp0EXubtwl
ZeWvOjHnnM+MHDd05U6aArTstWj4pDAOeD8FfwSFEXhtJ/MyVdVSTM9955hyaUB9
Ss0c4xTDiX21fPpDaoV1zQIy+B0dT0bVcmoUL0PFKD4lTRhMn6xfaGiY1fOPXYuG
5luOhSNh
=P8FY
-----END PGP SIGNATURE-----

--cKP0ipwRxRNGqurb--
