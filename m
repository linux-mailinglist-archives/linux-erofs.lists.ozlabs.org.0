Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D887158094C
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Jul 2022 04:12:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LsL665NCDz3bqn
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Jul 2022 12:12:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=XKCIA4PL;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com; envelope-from=trini@konsulko.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=XKCIA4PL;
	dkim-atps=neutral
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LsL642xDxz3bXD
	for <linux-erofs@lists.ozlabs.org>; Tue, 26 Jul 2022 12:12:42 +1000 (AEST)
Received: by mail-qv1-xf36.google.com with SMTP id b11so5183663qvo.11
        for <linux-erofs@lists.ozlabs.org>; Mon, 25 Jul 2022 19:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JHEl4AsUGM2/gSizYBBfeutiug8IP3uRWF4Ytkdrbvg=;
        b=XKCIA4PLHALCAXI1cRbpmJo0JCQWA9+MmPFEsxMPxts1mCWLtE5d28ctL3AJmlSGHe
         tuVqLvMmw2h9MBuWKPBTHqyFLZPPMPqlV8dvoX65fjtmaHZ34NK2AAXoxvuc4nrqd5PI
         Tloorl3JUxNA3CF/GJGlxc3j7s2aqXGzGfyxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JHEl4AsUGM2/gSizYBBfeutiug8IP3uRWF4Ytkdrbvg=;
        b=tf9XcfcwQnirO2Kv7ShxgC7Y0ew3xjNibidxL6y/1Xx01lJw4PM5nnUtsLl2Nl5KY1
         BiOkubUJ5yfwGGCCqOhhbWj17R2qJcJgtPXMPykEgWllzddSTba0PePf6hpev+LGI12C
         B0Sdq6eimWURCUEoFPV3tcUoaR1dHULjh6AISXSXyS9PVwwmJiUFoDA1ZUn05ezyY42l
         0LN0md1c1Cc4Ua5KIGbwdvdYw8bC6EKqvBMsl1orXDB9SYpoHKdaj98v9JtSB70nX8PL
         hPQ9d/oGb3g0pyRMIZyOsXx8ELT8GcLGwp2hyychrFPPOYskA/P/QzzScBDCB/pKgVcn
         wQfg==
X-Gm-Message-State: AJIora+tEddu0jIIHowXMw6W1lJ1CGzsaqyJmju00vERvjgBouud/XYw
	VvA+c+XtC19jVDkJR8VSN+rKvg==
X-Google-Smtp-Source: AGRyM1vTK5tY/1suFzgnsOa4YOOdPA42xGdhEl0IFNgTY/LosxdnFPYOqQPqht804UrbM0+bXSee4g==
X-Received: by 2002:a05:6214:19cb:b0:474:5447:2090 with SMTP id j11-20020a05621419cb00b0047454472090mr4303603qvc.93.1658801558834;
        Mon, 25 Jul 2022 19:12:38 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-195-139.ec.res.rr.com. [65.184.195.139])
        by smtp.gmail.com with ESMTPSA id m9-20020a05620a13a900b006ab935c1563sm9785937qki.8.2022.07.25.19.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 19:12:37 -0700 (PDT)
Date: Mon, 25 Jul 2022 22:12:35 -0400
From: Tom Rini <trini@konsulko.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 1/8] fs: fat: unexport file_fat_read_at()
Message-ID: <20220726021235.GI1146598@bill-the-cat>
References: <cover.1656502685.git.wqu@suse.com>
 <b28b8d554dd3d1fc6bed8fc7f5b9cb71e1880e38.1656502685.git.wqu@suse.com>
 <20220725222850.GA3420905@bill-the-cat>
 <6271e1a2-db85-fb20-6ea8-d23afcb6bc69@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J7ZhEZwEjSe6poEw"
Content-Disposition: inline
In-Reply-To: <6271e1a2-db85-fb20-6ea8-d23afcb6bc69@gmx.com>
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
Cc: joaomarcos.costa@bootlin.com, marek.behun@nic.cz, u-boot@lists.denx.de, Qu Wenruo <wqu@suse.com>, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--J7ZhEZwEjSe6poEw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2022 at 09:35:51AM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2022/7/26 06:28, Tom Rini wrote:
> > On Wed, Jun 29, 2022 at 07:38:22PM +0800, Qu Wenruo wrote:
> >=20
> > > That function is only utilized inside fat driver, unexport it.
> > >=20
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> >=20
> > The series has a fails to build on nokia_rx51:
> > https://source.denx.de/u-boot/u-boot/-/jobs/471877#L483
> > which to me says doing 64bit division (likely related to block size,
> > etc) without using the appropriate helper macros to turn them in to bit
> > shifts instead.
> >=20
> Should I update and resend the series or just send the incremental
> update to fix the U64/U32 division?

Please rebase and resend the whole series, thanks.

--=20
Tom

--J7ZhEZwEjSe6poEw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmLfTZAACgkQFHw5/5Y0
tyzamAv/VH/kckEoZrZfP9tTiGmXdHr8Cx9Moey60Y0h8J/WoUaWdZiVF8wNbI6e
8teJBnbQnmJoeG7BGcbQNv4z+r/G6V1qX8wKjdHvAMArRIg2HmeDjRl50oHTUmag
BNQEBzE5nSGrz03GOUuSTeey1uQjwHHAiNVxRhJ6e9j2SEpBgDv3Nc2Ohycqowui
v8xsSaEiXFOcI4PUoRjo0+EIoIjvWRMXYbVbAvqtXI9oMSTISfKpMTvi5dvHvICz
ANCN9hkiIzXu/hAQ7dQA4/sVfUhc2E4VSkfY+0NkUQrVxtm5VN/beMeiUNesoFcz
tMRy7dN81IKJrjVbp6Qu+ZF7rC/ZTTXqRZIzjh6gfuwqPnHcTYoSOSOlMVnlAcpc
uU/34xyLOMBr2me1e0tdm9QQ8yQOTPF8VCzoo3OnSmLpgTUuKYg+RmQD68Zv6Pfr
tBqhfam87jCVBlt8CRBI5LFSGEnulBPdG2IbM6FLHD0gX1HyCBK8PR9aBL7Rdqo9
XO0aET4o
=EqzV
-----END PGP SIGNATURE-----

--J7ZhEZwEjSe6poEw--
