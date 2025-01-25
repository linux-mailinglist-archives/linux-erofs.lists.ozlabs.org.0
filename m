Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 351C2A1C58D
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2025 23:55:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YgVQ25t9zz300g
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Jan 2025 09:55:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::734"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737845721;
	cv=none; b=gdtOy0U5tPTqec2lAJVX+6Og2IYP5NYLK6IynZGDcCPlu0kUZTTGUTq76+Oa1PlPeCIygltYLoy+h5IczRgMwzywMTbC9PhqCtdeAmTriobJq/myDzCsAzlf7Rn/F2JSVTjWJC3RsgEBvd7R9HuzIWt2njPNgu71AOJs5Wa38ULHEFq/aYTF+D+uaSLuYXwx86Rlnz5SW9Qtway9apPZV07cgUK86tq8eJtjNVlTgBsRltu7XG7f8ciDGTh/V9j/+nFx5jEgMPBZCmHt4oq7kGU00TdjadYCWKt30MWWsm5jzlYPVDLXs9zJjjeaHfXH5CqWiVzCOzE0pQA1wP6zog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737845721; c=relaxed/relaxed;
	bh=cLz7wfgGrg58brlZhRHxzcq6FwbES2C6dgppw1rS6nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndSnY/0NhN3x4BQquq3Gj+SUAmpxjfngfewOeDoVzBu8Vn+kIzGJ06t7TuUq5ayXVipvWW/AbhnEkM+nd0l0SBoAmTsBSGxd7JwL7ra6S4KG/d93IhFZ+9kWNkC7kodcWVqn2v2E+TxsIbadjIdTszAS552j81RhhEQ9Rqg+KNWCt+mpbn8OPQPb8asf203zqOJNr5sbIbe9mmyGuRgyYXGfWyLAZnJrEEecXPlvZ+CpP4ExQ3vE9nOWCkGRX2X8xWvcwy3JgODH9dNEr6F5pykV8OL1TXlC9lAcu8glrIpjwtlPr0h8OzEsn4UpoB9X75cux7tSYGP7LXUBY7fsOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=R1GjcQZB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::734; helo=mail-qk1-x734.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org) smtp.mailfrom=konsulko.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=R1GjcQZB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::734; helo=mail-qk1-x734.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YgVQ02Gqdz2xmS
	for <linux-erofs@lists.ozlabs.org>; Sun, 26 Jan 2025 09:55:19 +1100 (AEDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7b6ed9ed5b9so489698585a.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 25 Jan 2025 14:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1737845717; x=1738450517; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cLz7wfgGrg58brlZhRHxzcq6FwbES2C6dgppw1rS6nI=;
        b=R1GjcQZBFF01NU8nE4obiDrwlDJfiImhHZ4NpSM09/8TH3CfpYAhbH5v/ha2eJm67z
         cI3zBjkXHMiPC7lcBmyppOg6yEQkuPqt53PO/KtWHx+1ZMLP5ysVlM8Qe4fmszHXGIlI
         3vU0G6N+kmNHSbW662Gj230ivBuh7QM12v+gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737845717; x=1738450517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLz7wfgGrg58brlZhRHxzcq6FwbES2C6dgppw1rS6nI=;
        b=hXz90ZAEt/LhE2jtGaEy+sldH32Cgf0SHhzPEySASL6nkpkf9tcvgmvy4HHU9x0PLJ
         dg7oCNHur/SbedlW0TU4PLi3977qQ8UA6lnDY1gSXplo8HPBMa3ZPwLAjSIiE4/RCgb3
         ub485uY7oXdJzdKYFwf3uPpD7uXD58RH1Q4YkQiizvQr138OgTug88a+FYdra0GmrS6w
         oCA/+hHH2ayR34W8uFlrqfYtkFhG7EIub9niAsxWm6383V23slhbTIbrQqjwGEB9SgSj
         b5sdcLNTaSmXyLKx6LmufJgMnYCO1uF19DrbacMob8mxNMhLvU64zX1WGaTlvPUpwtAu
         CMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOa9aFAjYz/3R5J07bQwMAsbdhsgeL8wvxdkZsXARYll9wL9pTvLkHashEUEFQVrgCcoztVd9YkbiqaA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxn9gomZeRB+tzDFr4N1fipC44zJz2ViVukw54oELDx5vKYoIl2
	ctIRkWRRVtZscIHDtQR518onsjdG8EJdgzcF4ng9xopGgX9nEh0H8KxZrkm/AvA=
X-Gm-Gg: ASbGnctyFzW2MpPcHZA4jpTX4tySrhyPK4fILG+M8eepN88SeFa9C/7rC++7uNqJiYz
	xed5G6VBH2le/jn+KHZLdr1TF1qKmli2dWD6IRghFttL+3Wauyc/Nsp6XowYU9/r129rCBx0rwb
	4wGMgQVwN8vZ8VMhqTUK2lDUKxqkn+7ChblPZZv7hfFSHAiIt4YyUHeioyDg8GHDmP/Jllmw33t
	J8+A+QBTSAkGecqW1gxnVlNl7Ad/azn39b+4lPKk+T32x8oKdh2xDkyD2WDbEysFp61KgYtD4Xi
	ZN7Z
X-Google-Smtp-Source: AGHT+IFjxUUYhyY0u7Rb+/Ldt35RJKfxI03K0CFf8feVA0RUX1NDOpDfiGENEy2lVBTQqlHx8YtvSA==
X-Received: by 2002:a05:620a:1a0e:b0:7be:3cd7:dd95 with SMTP id af79cd13be357-7be631e7260mr5089293885a.12.1737845716763;
        Sat, 25 Jan 2025 14:55:16 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae8aa00sm235697185a.41.2025.01.25.14.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 14:55:15 -0800 (PST)
Date: Sat, 25 Jan 2025 16:55:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/4] test/py: Shorten u_boot_console
Message-ID: <20250125225510.GJ60249@bill-the-cat>
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-2-sjg@chromium.org>
 <20250125215055.GF60249@bill-the-cat>
 <CAFLszTjG0P0bdwziV4irtiU1JGNMwnoiLO9xhPxLQa9GZPVBtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I79wL8RukflE6lL8"
Content-Disposition: inline
In-Reply-To: <CAFLszTjG0P0bdwziV4irtiU1JGNMwnoiLO9xhPxLQa9GZPVBtA@mail.gmail.com>
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


--I79wL8RukflE6lL8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 03:42:00PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 25 Jan 2025 at 14:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Jan 25, 2025 at 02:31:36PM -0700, Simon Glass wrote:
> >
> > > This fixture name is quite long and results in lots of verbose code.
> > > We know this is U-Boot so the 'u_boot_' part is not necessary.
> > >
> > > But it is also a bit of a misnomer, since it provides access to all t=
he
> > > information available to tests. It is not just the console.
> > >
> > > It would be too confusing to use con as it would be confused with
> > > config and it is probably too short.
> > >
> > > So shorten it to 'ubpy'.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > [snip]
> > >  102 files changed, 2591 insertions(+), 2591 deletions(-)
> >
> > First, I'm not sure I like "ubpy". I believe "u_boot_console" is because
> > it's how we interact with the stdin/stdout of the running U-Boot. And
> > indeed it provides more than that. But ubpy is too abstract and unclear,
> > and looking at the diffstat, I don't know that big global rename is
> > justified to save text space.
>=20
> I actually get quite confused hunting around in the fixtures so I
> suspect others do too. I would like to settle on some better names.
>=20
> Yes, I don't like ubpy much, either. Your favourite AI suggests
> 'fixture' or 'test_env', both I which I prefer. The only challenge is
> that 'env' has various other meanings in U-Boot.

Yes, until someone has a better suggestion than "ubpy", we should leave
things alone. "fixture" has its own meaning within pytest and so that
would also be confusing.

--=20
Tom

--I79wL8RukflE6lL8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVa84ACgkQFHw5/5Y0
tyx4Vgv/VyPUb0LZfjt1/JjdS7LPbbMaQGclrNkfRnggtxWlbE02Q46+fkv5THOQ
/KYpClFVhHppJkwVQ+ksGK+bZnTyAwRRAp4y7yn3fhv2c5LElD7nQHhL3LzE1D0b
+7L5kgZ1SKO51eqP/5CefjpPmmzDLPMB/ikiMSontX+misKI9f8kOJAhLT886stm
mRBGzIhS8oPCCGBSexgqpM+FAGyPXyRWaUI2jNnJsJX0tzRPIg+gtlhahz4PRkrK
KCsonaXEVdUHCU4+9ScNENB5fLWFTtVwKaRybBas1LnlzyxhFipo58KT856aUHBq
h+f2nAz05EXt/l5IBgxaZlrneHb/FzaEMGYTFKRUOwRfVjPuW6bhwT1CN/vO+4C2
ENMF7IJd0gm2Ea3Nqv4YDQguTPaaNQoc1g/8x/qKRj/tmxFBGruqHtUk/LcveKHb
zVSkcD0AX8GkTNTPJct5tVJAhcjoUHRTGtWY58YPnleVbrvWKAgXmnSXK10F/Tik
UVymMluO
=l3Is
-----END PGP SIGNATURE-----

--I79wL8RukflE6lL8--
