Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E750D55E540
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 16:17:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXRW75zftz3c9B
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 00:17:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=akyGWAPh;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=trini@konsulko.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=akyGWAPh;
	dkim-atps=neutral
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXRW12RCkz3brJ
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Jun 2022 00:17:16 +1000 (AEST)
Received: by mail-qv1-xf30.google.com with SMTP id o43so20168757qvo.4
        for <linux-erofs@lists.ozlabs.org>; Tue, 28 Jun 2022 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fHm0CiyWSHETp6z498ld+K0sQYjE7jLFHNiGgd3eMCY=;
        b=akyGWAPhtroBWr7EzHV5dgf4YFI+WGYskWDgZqRJrt7XUe38A/YlzQZPnoIHiwRbB0
         dYg0bdHkBrzVKo7If4vopSsxFf5nLkMkao+Q2RqL9f90DJRF6nB/QHXpamx1zq4HOGVm
         s8WWELsQhP7cHJ+dPeFoTGQ9qot48tr1y+njk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fHm0CiyWSHETp6z498ld+K0sQYjE7jLFHNiGgd3eMCY=;
        b=kbWIIS4136POPTRcxRrmNL0tBwpz8DWM1gHV8Y6959TV+LHnWp2urz/K5GEck9u82f
         o7HsQotSIcufcqrkmBGItLuI4zerMIPAIB3+yxLiyU1byA2clO6rDpIjzyVk4sW3oaZU
         wz3bOkllHJj56ooXChyNM76tEyCarW5PY9o55dHVJI8Ce5CWeJwJ3hAZTCuJijypCJoU
         92yMANzUI2ke8dcPAMkSXwuv5VfiqY+QVJ3eSx9gUOClewPLIF9xiYOp14RD3hSq078A
         RIsMAz8y9dO0MsHNE416PZ2jIVG4DrkvkCgtm6WqarJUtIC4Te2YDaJkBZo/Ph08/1xo
         el4w==
X-Gm-Message-State: AJIora/2rWd+8BJZAEvWjCjWMrLWY+VkmAUD8RtfrkJL/CIfF9z6leq6
	hix0mnat/IbLzSRFuskNfPFODw==
X-Google-Smtp-Source: AGRyM1uc/3vUDj6VXEJ5EwykkdJtRsV9TdsqmJs/EdgWZSm7yWChU2GMIn5VtKjI2Ja7iwVjJ7Y2NA==
X-Received: by 2002:ad4:5005:0:b0:470:347e:ccdd with SMTP id s5-20020ad45005000000b00470347eccddmr3744706qvo.123.1656425831906;
        Tue, 28 Jun 2022 07:17:11 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-195-139.ec.res.rr.com. [65.184.195.139])
        by smtp.gmail.com with ESMTPSA id f15-20020ac87f0f000000b00304e8938800sm9367395qtk.96.2022.06.28.07.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:17:10 -0700 (PDT)
Date: Tue, 28 Jun 2022 10:17:08 -0400
From: Tom Rini <trini@konsulko.com>
To: Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 0/8] u-boot: fs: add generic unaligned read handling
Message-ID: <20220628141708.GJ1146598@bill-the-cat>
References: <cover.1656401086.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zOcTNEe3AzgCmdo9"
Content-Disposition: inline
In-Reply-To: <cover.1656401086.git.wqu@suse.com>
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
Cc: jnhuang95@gmail.com, joaomarcos.costa@bootlin.com, marek.behun@nic.cz, u-boot@lists.denx.de, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--zOcTNEe3AzgCmdo9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 28, 2022 at 03:28:00PM +0800, Qu Wenruo wrote:
> [BACKGROUND]
> Unlike FUSE/Kernel which always pass aligned read range, U-boot fs code
> just pass the request range to underlying fses.
>=20
> Under most case, this works fine, as U-boot only really needs to read
> the whole file (aka, 0 for both offset and len, len will be later
> determined using file size).
>=20
> But if some advanced user/script wants to extract kernel/initramfs from
> combined image, we may need to do unaligned read in that case.
>=20
> [ADVANTAGE]
> This patchset will handle unaligned read range in _fs_read():
>=20
> - Get blocksize of the underlying fs
>=20
> - Read the leading block contianing the unaligned range
>   The full block will be stored in a local buffer, then only copy
>   the bytes in the unaligned range into the destination buffer.
>=20
>   If the first block covers the whole range, we just call it aday.
>=20
> - Read the aligned range if there is any
>=20
> - Read the tailing block containing the unaligned range
>   And copy the covered range into the destination.
>=20
> [DISADVANTAGE]
> There are mainly two problems:
>=20
> - Extra memory allocation for every _fs_read() call
>   For the leading and tailing block.
>=20
> - Extra path resolving
>   All those supported fs will have to do extra path resolving up to 2
>   times (one for the leading block, one for the tailing block).
>   This may slow down the read.

This conceptually seems like a good thing.  Can you please post some
before/after times of reading large images from the supported
filesystems?

--=20
Tom

--zOcTNEe3AzgCmdo9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmK7DV0ACgkQFHw5/5Y0
tyw4wgwAgFBSQUmc0vXnm32m15bLKbLt97pqXjfpsq+cDbddcLNsue4tH8KXKvOd
t7L9GnC82BCdcUiAX6hoyEzN75EkZEMmjNU6lDYW7V35LFjab4Qy139pRFdx+DLO
QwP0uvyOb27F9NkbEAH48YF34QB5m6uk2klwdEcj9zUgD6Gff4cNeOLQEjI0WnVr
nxGdyLMMd0L4MiMDHmP8kAGw69viHgxqtRzOJsospvcss5Q0L9yOvEualFasXnfx
RjrFF5pBJGQQXvjG+Uv82cMy4IJkUQ0zPr5RRTE6/ig9QRIAdNwgvPCyRrqt1stQ
DNiUT19fQ8N6V0pfxDOT+3qcFc0CCYvFGyKI2j7VBvZRcLH7CpvZpE//trknCzF8
yk1M32UbRgFrpWS/U5vqbweLE4Oj6eOHndbvZE4DRUWKxHscGkJE2Kc1OYDkAfmi
dAKVJLDMZ1qPs11zGW5Li11vdY1nyQvZoIk4XzgbTmXElItHOkhF5FK6yRvgLmmo
G+IC+hYb
=FjO5
-----END PGP SIGNATURE-----

--zOcTNEe3AzgCmdo9--
