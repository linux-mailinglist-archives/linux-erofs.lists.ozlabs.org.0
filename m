Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCA456006D
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 14:53:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LY1cH2PQ0z3cdV
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 22:53:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=bjxYUzrN;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=trini@konsulko.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=bjxYUzrN;
	dkim-atps=neutral
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LY1c90Ygtz30D8
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Jun 2022 22:53:42 +1000 (AEST)
Received: by mail-qv1-xf30.google.com with SMTP id c1so24518456qvi.11
        for <linux-erofs@lists.ozlabs.org>; Wed, 29 Jun 2022 05:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/4bff15D+nY/gHRlKW2uLNIt4hIWR6BwmCkO+OKY2JY=;
        b=bjxYUzrN+ACXmAzWcgEKqpuWfySTW6JwiMhM9Tf622JeZxWQusqKkjNkjacADEGnt4
         aM3LAyGKsi3S5AVB9AqHgzd1X/ad2ih2ksBATvBDhezpvMNX7tkRI8h6H2YJgU1Km6lq
         kcW25hDLpvhTfCeXPxoZbbDB2jPWWpigcIKV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/4bff15D+nY/gHRlKW2uLNIt4hIWR6BwmCkO+OKY2JY=;
        b=cf+etys8OQ6xCEX6Gi6B1j9302DiTlulhg7JoP3Aw3YGCE+9Wqdq2/jG82Y2ImVne4
         cUqZTBkhlox0z/JYcwNaqeHvBQCO4Y6/nekF9f3wLtPlNdwZlndE6+os0NlJPK6k1Vvw
         P4BYubZTJTi8a3qYpx06W+Gweboga7gCEyxEcS3BlU3waDJxCL+jKvlD0u8U1BXHjcYU
         Yt21OF3gz1Vlr5UrWSP7Nw0puOaN+YYUGXlZywFNF3JGTtztElNau7ud0H9clOQiU4St
         vP4u26WFnvKoWABR7WrUbJHBYt3zAYI6ofh7LuYF71oa4j3ZAz4p3UfyAgeymhBYv+nk
         jUJg==
X-Gm-Message-State: AJIora+2IoJeo+Fm+bnKk4YamrXPOg/eAGxXVVntf7++C0vPNVAN6Ruy
	vMEXrXkCv3mZqHvjP/hQazyQeA==
X-Google-Smtp-Source: AGRyM1v4wuMFHQhhOaVqEyWZEijAcwxUejvBWDUdHQeQBzSWPvdSO7BWNBpROZNlam4ucAkAL5fufw==
X-Received: by 2002:a05:622a:354:b0:317:7a1d:ce4e with SMTP id r20-20020a05622a035400b003177a1dce4emr2244347qtw.419.1656507217043;
        Wed, 29 Jun 2022 05:53:37 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-195-139.ec.res.rr.com. [65.184.195.139])
        by smtp.gmail.com with ESMTPSA id 196-20020a3704cd000000b006a6ae9150fesm12637186qke.41.2022.06.29.05.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 05:53:36 -0700 (PDT)
Date: Wed, 29 Jun 2022 08:53:34 -0400
From: Tom Rini <trini@konsulko.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 0/8] u-boot: fs: add generic unaligned read handling
Message-ID: <20220629125334.GC1146598@bill-the-cat>
References: <cover.1656401086.git.wqu@suse.com>
 <20220628141708.GJ1146598@bill-the-cat>
 <8728cb97-6bb6-fae9-025b-42bd1a439386@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hCRFYJKfs6IGypzU"
Content-Disposition: inline
In-Reply-To: <8728cb97-6bb6-fae9-025b-42bd1a439386@gmx.com>
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
Cc: jnhuang95@gmail.com, joaomarcos.costa@bootlin.com, marek.behun@nic.cz, u-boot@lists.denx.de, Qu Wenruo <wqu@suse.com>, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


--hCRFYJKfs6IGypzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2022 at 09:40:58AM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2022/6/28 22:17, Tom Rini wrote:
> > On Tue, Jun 28, 2022 at 03:28:00PM +0800, Qu Wenruo wrote:
> > > [BACKGROUND]
> > > Unlike FUSE/Kernel which always pass aligned read range, U-boot fs co=
de
> > > just pass the request range to underlying fses.
> > >=20
> > > Under most case, this works fine, as U-boot only really needs to read
> > > the whole file (aka, 0 for both offset and len, len will be later
> > > determined using file size).
> > >=20
> > > But if some advanced user/script wants to extract kernel/initramfs fr=
om
> > > combined image, we may need to do unaligned read in that case.
> > >=20
> > > [ADVANTAGE]
> > > This patchset will handle unaligned read range in _fs_read():
> > >=20
> > > - Get blocksize of the underlying fs
> > >=20
> > > - Read the leading block contianing the unaligned range
> > >    The full block will be stored in a local buffer, then only copy
> > >    the bytes in the unaligned range into the destination buffer.
> > >=20
> > >    If the first block covers the whole range, we just call it aday.
> > >=20
> > > - Read the aligned range if there is any
> > >=20
> > > - Read the tailing block containing the unaligned range
> > >    And copy the covered range into the destination.
> > >=20
> > > [DISADVANTAGE]
> > > There are mainly two problems:
> > >=20
> > > - Extra memory allocation for every _fs_read() call
> > >    For the leading and tailing block.
> > >=20
> > > - Extra path resolving
> > >    All those supported fs will have to do extra path resolving up to 2
> > >    times (one for the leading block, one for the tailing block).
> > >    This may slow down the read.
> >=20
> > This conceptually seems like a good thing.  Can you please post some
> > before/after times of reading large images from the supported
> > filesystems?
> >=20
>=20
> One thing to mention is, this change doesn't really bother large file rea=
d.
>=20
> As the patchset is splitting a large read into 3 parts:
>=20
> 1) Leading block
> 2) Aligned blocks, aka the main part of a large file
> 3) Tailing block
>=20
> Most time should still be spent on part 2), not much different than the
> old code. Part 1) and Part 3) are at most 2 blocks (aka, 2 * 4KiB for
> most modern large enough fses).
>=20
> So I doubt it would make any difference for large file read.
>=20
>=20
> Furthermore, as pointed out by Huang Jianan, currently the patchset can
> not handle read on soft link correctly, thus I'd update the series to do
> the split into even less parts:
>=20
> 1) Leading block
>    For the unaligned initial block
>=20
> 2) Aligned blocks until the end
>    The tailing block should still starts at a block aligned position,
>    thus most filesystems is already handling them correctly.
>    (Just a min(end, blockend) is enough for most cases already).
>=20
> Anyway, I'll try to craft some benchmarking for file reads using sandbox.
> But please don't expect much (or any) difference in that case.

The rework sounds good.  And doing it without any real impact to
performance either way is good.

--=20
Tom

--hCRFYJKfs6IGypzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmK8S00ACgkQFHw5/5Y0
tyyL7gv/RsMcVnrx02hMQxtQG4UuktxMz9gftbRFDC6xJrV5olnwzqgRXOxT1I3c
Yeabw66LR0XBog1E5UDnGIw/aDwahB5Zv74EHl912Y42PHSRSvV1ILacCih+tyW7
YgzHCnikt6Dp0D6yd9KK+RUxGfCGrD2izWjrpBhKJJkSOAXVMwdTxZyDkf67/Pjq
CCQ4Lc35o45BwBB9bZ1NIQl6FQQ/pXxHADu5Ttnk2ZaHycF07UYsCddvkqD2+kjC
Ta+LLKXGT10FwFEGJwAInRk8oY9xre0wuTbDtMUzGRJry7If65si9KRTWoiQ5Ffq
3zwKTQqr6rL0hvVRDvGdWbTGICd86eANHdkJhRl1ZO5XrsouyZGgH6KB1XPgHk0O
hwANXxtXOnI2sYLN7vCe2zfkOlr+iz5Bx+a7Up/hbrXlhA8YRNba+i1036edcHmg
hhpzbSu4nCJRJVuKakQpg5LSUx5PvCfr7RVp6FHVXf8bdtj1AkrQZnp73DrzJOmK
PrVMFS+t
=W9My
-----END PGP SIGNATURE-----

--hCRFYJKfs6IGypzU--
