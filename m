Return-Path: <linux-erofs+bounces-3421-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H4OAGlXC2rrFwUAu9opvQ
	(envelope-from <linux-erofs+bounces-3421-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 20:16:09 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B31572179
	for <lists+linux-erofs@lfdr.de>; Mon, 18 May 2026 20:16:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gK5b7310qz2xrC;
	Tue, 19 May 2026 04:16:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779128163;
	cv=none; b=WJkpYestEUlCUd1RK0euAKxkreVCAwM+hxnFsquzI/xzyONzHvlhcbqU9mSz07D1tjN6YVnyy5zPXXhj/Ms5y3Hw6AUhnLOsffv39BXu+3/sQT6z2lQPpDJ+YX4NvrGvGXCnnGR24H0FZ7Zw/j2PMLtsLEM+j7AfwfudRl53M4OZgMWWAh7PSP/hWykBUZFtiGCkJf9DKym67UHZuOVL1s1LP/4zdNBl4LWGCFvYv95FVPjkqxWOytR0m8oThrdz6jhfRWpDVRayV1YATF0hX8T6joQfDhUWHYdvfP1xs/q0qMmHBpWj4hQaMCl/B6kbHU6prRv30x/IVsPAJnKfPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779128163; c=relaxed/relaxed;
	bh=IQCx3UXqbyu+eze8ZcN04Uw1YnxgEr+129PVm9JTRJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtZWmQ4jUQoZINczutDy2W1yNh8a9x9MQVscUO2RJV1FSamzxl7+SKHXlB4dmtAAFF2BbnG0JzipfCecYRZGB3o1i44Vm60A5P+MmnU+ZAGbKxaKnyUqo61yYRGzQXR6eAMIb01CkOxZCkctj0NWyELtllFtDPxDsVIxt9fOsHmnnaFxc6Q+VuTAoSggZua8Dafnl+BJPQEvz/5zJp79bG2GwQgks01FKnDlLITGaqovl/YIODzbMw5oSdkom8VoCVN05bNTQ6Q4w9oEez41CgeOUwL4/YkFPAmbTvKh07p+cxslgrCWAmHTqdyyaAnw660jc0g8q5nBv6Y0boDmyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=MV6CMewV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org) smtp.mailfrom=konsulko.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=MV6CMewV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=konsulko.com (client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com; envelope-from=trini@konsulko.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK5b45Db2z2xlt
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 04:15:59 +1000 (AEST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-47cacb4ed99so1709834b6e.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 18 May 2026 11:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779128157; x=1779732957; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQCx3UXqbyu+eze8ZcN04Uw1YnxgEr+129PVm9JTRJA=;
        b=MV6CMewVN1RhYNhig39M6oG6lHFc93U1ln73Trb0jZqAG2X1uuSxhPGaT/Eh0JiCtV
         HohpP5so2iDPVw6Mqke7sLuFBZkHDl4iF6wxtu1N3xpthiPMBjYIXzapXTh3m6Yqirnw
         WgWDPIFZh2Iis4Ky1s5syscsTY7G+06CB3iQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779128157; x=1779732957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQCx3UXqbyu+eze8ZcN04Uw1YnxgEr+129PVm9JTRJA=;
        b=UcAl8G3jPPZsQEtKpf0OiQIduKcZe+/WdFNj7dNT4H0YFHQr9fz4ga7CbGMdvWv4oH
         W1xTPvoM5h49LbjNPXthDLyq2iMDuHWsKGYZuh6JiRnpuYqL1SPVOA3L6kQJ8z7pMji1
         YjvimOovezXtG0c5Y2CW21A/hSW1gFklMUfomExtI/CcIJDqE9OAYPARyBtYZWSXrDbE
         58vATRMzss2OxvxBnd/XmGUBeEMKc5FN2hluZiCAV+pvzAm1mPWyzsAdk/GWq7YFU4Th
         lCe+G/r4jPOTDhsEFgbEmXraj3xxOC50H4IMSji/F7OQ80XuN61Ty69n612dpa8v44az
         LXiA==
X-Forwarded-Encrypted: i=1; AFNElJ+nkHQtEeX7Kwlbd9YT0SDyR1Masmu+3MpbGAsYLYq6b9Sja6ymxVv2KRugQJv0OA5pkF2lT5XTci424A==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzihKvepUceF00hKIVZH57Jm4DCSY6b63QBgzNaT5gywSfH5TGF
	Tu6FBzigAJBr5J0jpRZu8vnXG/HseVi/dUSQ2y5HFZKwOFuaCUho59QMbN72DkL/xOM=
X-Gm-Gg: Acq92OGAowiWVZrp5Bam3ggMnUwcWf98fifR9WEuv7WNpQijlZDKWfvQV9NZhuNs4KE
	knJ9ZU0HWJie7znTW5803RANtPueu1mt3gIGD32MN0H9oiz+118+dwNahnuILGb7JKqgiyJd5xi
	iXK9vl3XomzvLKylPQnph6TddeLtbNyV25Yy2K09HCq66ghTu0OBPg2rItbglxNv5iAKQNIrqkh
	VLLKD6bNFYPVZ0B1VqvFeW71YB+b/Xw4TqfhPi+TEglpFcG2FBSifmCaIZNlVGqrCQkEAig7efD
	EMw4n7A8qKzgPggcPEioWBWswN+cfkxY15tid81I0+pu1BLNqn111wTeNEv5G4PYql0atAk5HOg
	35296j7BO/Hlp3WiXTQs85lq9CR4/sh5QhCCoU7Lq72jdl2NP+xeZ6COs12eq+wFYgSCmACXLTv
	o55Zh0WBgz6/prNTtNNkXVpNx2RryrOyc8qu1E+UWi8O2FnAqYH02luf69JhYPaixdBG+AZPkFl
	+s5654i37VAeBEPDRVEDDKDbvThW9ToMicThDLdtJMdpx/p2cP0BOQK3FR8cw==
X-Received: by 2002:a05:6808:2f0e:b0:479:d605:64a0 with SMTP id 5614622812f47-482e54e90cfmr10995535b6e.0.1779128156650;
        Mon, 18 May 2026 11:15:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a9576cdb2sm4692779fac.16.2026.05.18.11.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:15:56 -0700 (PDT)
Date: Mon, 18 May 2026 12:15:53 -0600
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
Message-ID: <20260518181553.GU1858239@bill-the-cat>
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
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
	protocol="application/pgp-signature"; boundary="2fwZZD+4raTnncyY"
Content-Disposition: inline
In-Reply-To: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
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
	TAGGED_FROM(0.00)[bounces-3421-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 52B31572179
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--2fwZZD+4raTnncyY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 07:57:19AM +0200, Heinrich Schuchardt wrote:

> The ls command currently only displays the size and name of files and
> directories.
>=20
> * Add the change date to the output on FAT and ext2/3/4.
> * Use the actual date when updating the change date in ext2/3/4
>   file-systems.

What's the motivation for this change, and how much of a size impact
does this have in general?

--=20
Tom

--2fwZZD+4raTnncyY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagtXVQAKCRAr4qD1Cr/k
Cl9hAQDrJiMUJYd5KyIAvY47Ufiq1qHppMjikiKvdFCcP4pCuAD+NiM0k2wncptd
zxRLRYeUlZ7NtgTF50blOaVzxQ5WlQA=
=K9Gk
-----END PGP SIGNATURE-----

--2fwZZD+4raTnncyY--

