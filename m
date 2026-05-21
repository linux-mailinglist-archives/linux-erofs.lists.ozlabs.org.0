Return-Path: <linux-erofs+bounces-3476-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Cn7CBEnD2paGgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3476-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 21 May 2026 17:38:57 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7BF5A87E4
	for <lists+linux-erofs@lfdr.de>; Thu, 21 May 2026 17:38:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLsyQ196xz2y7Y;
	Fri, 22 May 2026 01:38:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779377934;
	cv=pass; b=F5T061nNLXWzxZVmI4ElnvTeyyApGadl3zBCqkjgQiJtonje6NYtk/dYL6DtCKOuubO7VAYIuhvPf02KLPILq5zhIUBJ4pn0ARWlsEPEi0S3gtgG6NCeiJBrk53/bPs6wWa4I5NhGUKChhkIHnpx58NazVQOfWhWbWdfv2HOxGQrfIk9B4oDAlLlODMFYFhrCAaNOfD538aevbtrsQoiNP1laUpHqjdN0nKw3CeYgVVilUXgewkpzdUkAgnZvFAqTeO706z0wxblt1/geTIB0Hh+1o7NNcpBruZWBUQtVYKrYFl4PgiH3tR0iBGHApZcam2Qpzf/8gLmMN+ODzQCyw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779377934; c=relaxed/relaxed;
	bh=5SLZg8MSV0b9+QUshF6s35KxxUJ4M1Jt2sSpGw1Doac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGuD3+y7kxyW9RWPpdrbR8Tc4Ja9yVU1kk1RAero8BEDbO1yquIMd64eBQQP6GeWz6I2dir13/hTpIsXo7RxD43l4xPgzKdEK7Okyolfz8r5gguqsHhJgnqgz1xwV5uEfS/ziNwPf51vsCd1SePpz/KmKghmM6AsqAVKBlgduGC86QhIc0Pox3ZD+jpyEBFd8z4Am6xtzuO4M8Lda6i0ioteOZQXLyN7vHFsnWp1/LRiwhWfkN+vT59djkDKYRKTiFt1YG+ZguMFyA7DO3g3mem1+Q+nHnhOOhi9R5Z98rBGqOCFtHl64TJvj4zi99xPlZ5tCDbb1+jDsI91wSCEjA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=T4wFsUo5; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=T4wFsUo5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLsyN5RWVz2xnK
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 May 2026 01:38:52 +1000 (AEST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-b9358bc9c50so929436366b.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 21 May 2026 08:38:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779377928; cv=none;
        d=google.com; s=arc-20240605;
        b=OTuKsrSJGHILpNT9mpabY3yAnBjySgNK5nmpvRgudfnpSUkd7SPYze2lSNBUTY7/zx
         176Gftpn/mHHktI5EOM9dN8TFqnebJ82V50V3sw4tKAD5DbO4a7DKTB5ojASg6YA1ts1
         R0zXegWwg/uZc0zP8Uzpj1g5/8hN6Be+plRTMSFhVX4FzgVns+q+X692PRbj5J/ET9Qv
         PYsjiA4Rrxbhxn4e1EZEhm33oVQJQnTL6f32ZJOIrdI+2tflX0VgNK45+YbN3aoKn5Tv
         Cg04HEE+wVVNmRAVMbD8LKIcrW6GlXwgamV69bPYXI2TKhpM5U5boKgdN5QtpV/NwUlB
         YEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5SLZg8MSV0b9+QUshF6s35KxxUJ4M1Jt2sSpGw1Doac=;
        fh=D1l6EhykTChHJRNgS/wwbG5GgIlnIrGt73fCGDXN6YA=;
        b=VZGggVEIf+kGvKJf4skV/P6BF5JMK9B4O6rT/8QYHaiUdHlVrBwOw4PcgapnZEEHh7
         zaqI8MHWDPPUzeOXjI6SK3n/oaamHGkQ13Y5kWbp0fBmXbIlkgmGz0qlaMtx4CAjApKS
         gSz4XLLY4WrVColOLeuVduirllrY5evgkegS7akPg/UECzUnaR4txRE0J53osP9fMAA7
         wlwuh2IO9sxUq86FhCNl246GUxRksNUnHUVOmNcChe+MU2jgrMTIwEoXX6X/oLqFTYsw
         CNxdgR9M9wWRRaVcdXjdsk9AuF0XRGOF+EggSYiptK0RAWlaaLwQDiKKmX/o77KXbile
         cOFQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779377928; x=1779982728; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5SLZg8MSV0b9+QUshF6s35KxxUJ4M1Jt2sSpGw1Doac=;
        b=T4wFsUo5hU64aq4UK8pOfDITJjBIChExIOPsVqnOfS58lM0Ur9FWrOC3u/GrXgpkPa
         9QYh6TUKmcTLFekzIdfZC1CEfbv9xteERd5wrrVHAg4ngwm/sJh9rYSp3YmpcfpqC8w9
         1KeG6f1KYYLOR5ZN9SKBVKnjq6BZZ0XacWRAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779377928; x=1779982728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SLZg8MSV0b9+QUshF6s35KxxUJ4M1Jt2sSpGw1Doac=;
        b=qppBOzcU7ecEibTnh0kWeFN6WyaSag7BY/SJ8M8ZaB59DI6F0oRDIWvAg6V/s07rnl
         VVrdsURQU49eGab4ZJB9N5T2/lmTQ9W1K2nWQ2qPmyppcV7htBhE4yYfy6N30jp6h9Yh
         1A6tn/0X3WRmfVXIZtfaCAT9xoK72+CZrau2445t64rmbFWqQ1gtASz0YmETmGoh8BnS
         BPL7IS6Ujo4Te2jkHiAbLXbHKj98vCS0U+YHO5I2gjFXOgZHQanNwNee+9ia0GvqybYh
         47EGsVihFM8tJbdljgdrj2rXUc5uz1GunIbP/MdNOrRCpHN8Si5JUrv7oYUEJC5fG8VQ
         eivQ==
X-Forwarded-Encrypted: i=1; AFNElJ84F8MVvvL+AWo0CREkV77jOkCviwqegjBtjX2QuR0q11xZw9dlyVW34s6bUdTkquBqENt2X1Mfxmz6Zg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy1CagmTdEQ0oPRogmxSNMNED3FJm38qC03wcIXvK50BYGceGTi
	NRsLeYfQKhQibrSsMKaw73debd2bvngOsCJQeP7SLvWuOCtgmRR6BppylhJnfzKKx1WIXGOYOdf
	vB93rzanLQLp/RZhHglEHxRbaw1hPwcnzWnhxZZ/L
X-Gm-Gg: Acq92OEMF/il+V4eMSIz5fDSbNYOSvmSIWB8FYnHTbGZQsgn1UQwwYX6QwO4bIt+K12
	triGmL1flMFM5z5Un0JBaMscpoTh5r1i0xW2NYUEUNxap6jCQT5DxV3svqaXGchXh+XTOXyKbuL
	nQUO7XXiVwk/BFVgp9UgBuH/fvP8B7sDzEMlYnpWWY/3TecjPRBhrQ0FK0sPg2u86J6L88Zpaa6
	8xdzy8OyCSk1e3RhR1ZVD3vUJzyyVqo709UyU2wZykf4FhZxI5qpkP6ihbHZWBh+61zoh2250eo
	DaWgPRWQnAS4Y59gdQ==
X-Received: by 2002:a17:907:c70b:b0:b97:1d24:c004 with SMTP id
 a640c23a62f3a-bdc13e8b3a4mr237352566b.21.1779377927804; Thu, 21 May 2026
 08:38:47 -0700 (PDT)
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
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518055728.178507-4-heinrich.schuchardt@canonical.com>
 <CAFLszTgZ=ciSU-ny1+X+8jYsvRD-jc-TVQ3WwfyZ3DYvmR81Ug@mail.gmail.com> <73acbfa7-43aa-4d65-b7ba-1824fda3b348@canonical.com>
In-Reply-To: <73acbfa7-43aa-4d65-b7ba-1824fda3b348@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 21 May 2026 10:38:33 -0500
X-Gm-Features: AVHnY4JdReHmsOJezTh6Jf5rqupT1C2ZliBTRLLzPaCY0wb57v_uuDdrhKnNgls
Message-ID: <CAFLszTiO2TCmT=aD3L7bMG5zNNeoXKBmwf0OCEZ_F6aLSAXqsA@mail.gmail.com>
Subject: Re: [PATCH 3/9] fs: ext4: print change date in directory listing
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Huang Jianan <jnhuang95@gmail.com>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>, 
	=?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
	Francois Berder <fberder@outlook.fr>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
	Daniel Palmer <daniel@thingy.jp>, 
	Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
	Sughosh Ganu <sughosh.ganu@arm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	U-Boot Mailing List <u-boot@lists.denx.de>, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3476-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sjg@chromium.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:heinrich.schuchardt@canonical.com,m:trini@konsulko.com,m:jnhuang95@gmail.com,m:quentin.schulz@cherry.de,m:mibodhi@gmail.com,m:t.preissl@proton.me,m:fberder@outlook.fr,m:andrew.goodbody@linaro.org,m:daniel@thingy.jp,m:varadarajan.narayanan@oss.qualcomm.com,m:sughosh.ganu@arm.com,m:ilias.apalodimas@linaro.org,m:peng.fan@nxp.com,m:marek.vasut+renesas@mailbox.org,m:u-boot@lists.denx.de,m:linux-erofs@lists.ozlabs.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sjg@chromium.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[konsulko.com,gmail.com,cherry.de,proton.me,outlook.fr,linaro.org,thingy.jp,oss.qualcomm.com,arm.com,nxp.com,mailbox.org,lists.denx.de,lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,canonical.com:email,mail.gmail.com:mid,chromium.org:dkim]
X-Rspamd-Queue-Id: 4A7BF5A87E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Heinrich,

On Wed, 20 May 2026, 19:46 Heinrich Schuchardt,
<heinrich.schuchardt@canonical.com> wrote:
>
> On 5/20/26 22:42, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Mon, 18 May 2026 at 00:57, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> Declare FS_CAP_DATE in the ext4 fstype_info entry so that fs_ls_generic()
> >> displays the modification date alongside the file size:
> >>
> >>   4096 2024-03-15 09:30 filename.txt
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   fs/fs.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/fs/fs.c b/fs/fs.c
> >> index f8e4794c10e..482a5523712 100644
> >> --- a/fs/fs.c
> >> +++ b/fs/fs.c
> >> @@ -261,6 +261,9 @@ static struct fstype_info fstypes[] = {
> >>                  .fstype = FS_TYPE_EXT,
> >>                  .name = "ext4",
> >>                  .null_dev_desc_ok = false,
> >> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> >> +               .caps = FS_CAP_DATE,
> >> +#endif
> >>                  .probe = ext4fs_probe,
> >>                  .close = ext4fs_close,
> >>                  .ls = fs_ls_generic,
> >> --
> >> 2.53.0
> >>
> >
> > I would prefer having a head-file macro which expands to nothing for
> > xPL builds, rather than adding preprocessor macros.
> >
> > Regards,
> > Simon
>
> Hello Simon,
>
> In the internet I could not find what a "head-file macro" might be.

Sorry I meant 'header-file macro'

>
> As struct fstype_info is not defined in a header file, a preprocessor
> macro defined in a header file would not make sense here.
>
> Do you mean something like:
>
> #if IS_ENABLED(CONFIG_XPL_BUILD)
> #define FS_CAPS(flags)  /* empty */
> #else
> #define FS_CAPS(flags)  .caps = (flags),
> #endif
>
> static struct fstype_info fstypes[] = {
> #if CONFIG_IS_ENABLED(FS_FAT)
>          {
>                  .fstype = FS_TYPE_FAT,
>                  .name = "fat",
>                  .null_dev_desc_ok = false,
>                  FS_CAPS(FS_CAP_DATE)
>                  .probe = fat_set_blk_dev,
> ...
>
> A line without a comma in the initializer is easily mistaken as
> incorrect. I am not sure that a code reviewers life is made easier with
> defining a new preprocessor macro.

Firstly I wonder if it is actually worth making the field conditional?
We have a null_dev_desc_ok bool which could be turned into flags, if
you are trying to save space.

Ideally we would have a new Kconfig for this, so it is possible to
enable the feature in particular xPL builds.

If you don't like the example above, another option is:

CONFIG_IS_ENABLED(YOUR_OPTION, (FS_CAP_DATE,))

which we use in quite a few places now.

Regards,
Simon

