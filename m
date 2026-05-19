Return-Path: <linux-erofs+bounces-3455-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BoLAfprDGoLhgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3455-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 15:56:10 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C33E3580168
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 15:56:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKbmk24DLz2yFK;
	Tue, 19 May 2026 23:56:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4860:4864:20::41"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779198966;
	cv=none; b=VZmdsUPVZBo5NXykXjjO2ax4k+hn+mgeYxo0G0Pk6L+s2W1dJSoVzxMxqdMGzyMxIKln1Yj3ryh63nAgiiY8WlZtik3PR5yF0aWHwKFFHfbNb36mGqyPRNDHxI4iT0NVudg3v7og3fDujvrShxatJ9acXYASXufV4TMO/awwcFZ9rAjzDdC7b7QGNCZye88b6Drajcsh8ewpDIn1Gc2IkBzeqzQIPPtaRHPGqJxKDEjXvUibU1WgADpWp9c6JZ149aMVb24xqvs8GypDyBbB3tZWcHzpMRVT58kqgK7cezH4Akqvo68e4pFc8dE+4mBXNhlwnzyxJ5zlIAR7NWxfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779198966; c=relaxed/relaxed;
	bh=C2ofDaH/iDMzny2yvuMxJqbHkzJNimEG7VLzx15ViXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAD4vX620lbTZqYDyZEEOsXpiU6MQ/4+1gM6Nk6giayxeR4x5sqIK41SZF+ITR4iBR/PxqTb35ze5+9s3WHCrv2EbmbhVQyDcGUtMgv7sgljYk3wtNiE0fg9mLa5CwMRWkRnudwpcM5omx05V/PjvVAZfYPRmveDhegPjJi09iv7ABhzoRmTiXkc7PGB4gflxohFJ3/83DPXsxG2lqA44r1buxkI+igvcc/t0z+N67KbvJYJyOu2fPayU2j7M0c1tz5P8bdawn8Gz3/exuTSnu0xHHh6zMwoeeBFvORvyg+kIRkw8zCIpMfqR0I9ACZCGatwQsvZq9vxTK1Pf+prLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Ibdfhzv6; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::41; helo=mail-oa1-x41.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org) smtp.mailfrom=konsulko.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Ibdfhzv6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2001:4860:4864:20::41; helo=mail-oa1-x41.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKbmj0Cs7z2xqv
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 23:56:04 +1000 (AEST)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-43a833aeda0so2370144fac.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 06:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779198960; x=1779803760; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2ofDaH/iDMzny2yvuMxJqbHkzJNimEG7VLzx15ViXg=;
        b=Ibdfhzv6OOiuhWnkH1eCaM85bUAxCpS7X2gmkYy1StMaATuNQXn1mCJVnHnJFwfRyV
         ubeKKxqngpigAYjQfFsFqZe/bSC9sb4hzIW8gMowrDivX7VHluyD4qHwipvXZn+tYyeq
         ixQGy8rZV357cU1+ZC1Ws6es+bdNNBTdFANZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198960; x=1779803760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2ofDaH/iDMzny2yvuMxJqbHkzJNimEG7VLzx15ViXg=;
        b=QhfrO/WOyvjZ6I2wuRVujw4hVH5wm3fpNQeiGQ+Z5jw1KzxkS5E2BsOYdpk570ZzYo
         MOhzb54fmHt4Qz40HNc06TnBGJHYHtAj1jD7Ofz1+1778grmE9R5AR3w7vwSllsEqMtt
         IXuNF7ssYQQ1vhv0rlj3z+STLdUbk+jTAu8ZPWJ5WpLyVsxC4nIIVbggmjlSoKG4ssGM
         0TpQ9/P3V5KIe36jpYzpNTFQt34c3qMhduN4nErPn7b57z3ngoAWbQOvQqEkZlArQDn3
         EMDSf4bifI8MTH8FjYd0r3fdEJEBLBSn9wTE+Z2RS640fcu/ZCL6v337ijXN0kXnIR7y
         ynZw==
X-Forwarded-Encrypted: i=1; AFNElJ//oIAIGVu2Ov9dgzEvSNeeEV1Zmnd4cXV+mjaYh7AgM3Qafaa4N0fg6wu1jpHriwIUlzy/X0EIN/5ygw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzsfuG/7N9E+fynf2ya/x+ltwteeFGvC7ejIYxYnbzlb04UHIoD
	UGb9CBMBpcc1I1NDNcdBmVK2e8irOHA9HtkUmjY4fJbdWOnytNENfwxWF/um7qgMDRE=
X-Gm-Gg: Acq92OE8kqQUilkT4KVdA+hU06UZJ6k70XpBUU1BlEY3A1pG9IW1umicltcfzy7FZOb
	up33bb5isBUY8WE12ZPyUuRPX5647HfaZRzhLw7bJ/1C+IJYr3ukqQhmwP0FDaSZcDgyE3dt6Qd
	ztPaMqVs7sfzl8WfHlAk5Z/idecDIlTNSeh+Jhot1eqVaorLrNrBRHLjEBF3KMDqd/NOTmQ66ql
	wOrKqsJDvyI4iqOpI3IS7CtoEo32ulPF7HEbkAiBz5JrgylWpnUB7NAPyKpT0ykGPvICZPshKBY
	u5+V1QCKGHPCtm7Qt5T6Bmfwxcu8F+6yhQS+NOcGeGeZvfF9f8gh2W3Yiupwjwijfs52G1EBPJz
	nUNgpp9zKQQZQdOzvrWtHSq3kd4TOfh/ZrvQnp9ZoUmRu+fgd4ZM6rqmGR9aeeVKkxOLpBhMP1U
	T/LBHwgZgVWKW62xdJf6lHRkO9bp2ArBGdAH1PYfxMbsC4VCWnBjK414SmhBgz/6NOJPm/z5u6Q
	YORWEhTNdWrywCLkWEyEtnPXFO9m2ss7Dy4pSFhNb4Qx1JFwQA=
X-Received: by 2002:a05:6870:3182:b0:417:685e:3748 with SMTP id 586e51a60fabf-43a2d7b9058mr13279492fac.0.1779198960380;
        Tue, 19 May 2026 06:56:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a957639b2sm7058694fac.14.2026.05.19.06.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:55:59 -0700 (PDT)
Date: Tue, 19 May 2026 07:55:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Tony Dinh <mibodhi@gmail.com>,
	Timo tp =?iso-8859-1?Q?Prei=DFl?= <t.preissl@proton.me>,
	Francois Berder <fberder@outlook.fr>,
	Andrew Goodbody <andrew.goodbody@linaro.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
	Sughosh Ganu <sughosh.ganu@arm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Peng Fan <peng.fan@nxp.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
	linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 0/9] fs: add change date to ls output
Message-ID: <20260519135556.GX1858239@bill-the-cat>
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518181553.GU1858239@bill-the-cat>
 <aebdf20c-c93a-4711-8ea8-2b92334714bc@canonical.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6yiov/VBg8GGtcD+"
Content-Disposition: inline
In-Reply-To: <aebdf20c-c93a-4711-8ea8-2b92334714bc@canonical.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.30 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[konsulko.com,none];
	R_DKIM_ALLOW(-0.20)[konsulko.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[trini@konsulko.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3455-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:heinrich.schuchardt@canonical.com,m:sjg@chromium.org,m:jnhuang95@gmail.com,m:quentin.schulz@cherry.de,m:mibodhi@gmail.com,m:t.preissl@proton.me,m:fberder@outlook.fr,m:andrew.goodbody@linaro.org,m:daniel@thingy.jp,m:varadarajan.narayanan@oss.qualcomm.com,m:sughosh.ganu@arm.com,m:ilias.apalodimas@linaro.org,m:peng.fan@nxp.com,m:marek.vasut+renesas@mailbox.org,m:u-boot@lists.denx.de,m:linux-erofs@lists.ozlabs.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[konsulko.com:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trini@konsulko.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[chromium.org,gmail.com,cherry.de,proton.me,outlook.fr,linaro.org,thingy.jp,oss.qualcomm.com,arm.com,nxp.com,mailbox.org,lists.denx.de,lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs,renesas];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,konsulko.com:dkim,denx.de:url]
X-Rspamd-Queue-Id: C33E3580168
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--6yiov/VBg8GGtcD+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 09:25:37AM +0200, Heinrich Schuchardt wrote:
> On 5/18/26 20:15, Tom Rini wrote:
> > On Mon, May 18, 2026 at 07:57:19AM +0200, Heinrich Schuchardt wrote:
> >=20
> > > The ls command currently only displays the size and name of files and
> > > directories.
> > >=20
> > > * Add the change date to the output on FAT and ext2/3/4.
> > > * Use the actual date when updating the change date in ext2/3/4
> > >    file-systems.
> >=20
> > What's the motivation for this change, and how much of a size impact
> > does this have in general?
> >=20
>=20
> For qemu_arm64_defconfig fs/fs.o shows a growth of 260 bytes in .text and
> .data sections.

OK, can you please use something like
https://source.denx.de/u-boot/u-boot-extras/-/blob/master/contrib/trini/u-b=
oot-size-test.sh?ref_type=3Dheads
for the whole board?

> Change times let users immediately spot which files were modified most
> recently (kernel images, device trees).
>=20
> If a device stops booting, seeing a file=E2=80=99s change date helps dete=
rmine
> whether a recent change could be the cause.

Yes, that is useful and more user friendly than hashing a file. But I do
worry about global size growth.

--=20
Tom

--6yiov/VBg8GGtcD+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagxr5QAKCRAr4qD1Cr/k
CvOTAQDvzng/P1d539wOJvnf7WoIM+Lt/y+SFSuc7GiqtRGbDwEAjqkyjbWh6gxj
FQKb6J9Iq46vS4YM40o0+NBfCeydcQI=
=rC3d
-----END PGP SIGNATURE-----

--6yiov/VBg8GGtcD+--

