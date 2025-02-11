Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214FCA3198B
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 00:28:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YsyLn59htz30Q3
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 10:28:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::929"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739316527;
	cv=none; b=ix8g9jrqh7XtDeWBUigLXnfr8c3qOFgzcETPHvxXmePeVdkYnFB9T0PdaXy/NonJMoSU4JkfYy0cQFxBVklGAcvNRoDza3Ax5b75xV7WWcrUozFkb90e3b/BrA7Nygb+/0Yv8P8cIE0x6E0e7hEw6fEWb1R1n2pnCMXg2tYFCK0S1EB6jwjmzK7KD/nHyXmMbAT/KQTTKSdkkNderl/9sPMLzq7wW6IAExQA/BlxETj1WS18XnneBrc4n1azuyTVlHDMQz8AKrxZj+pmJ23ESVJrN/2KDl6c3KEjB9exu0oJLPwBq2Q20tzfX3qVK4ZVAfODL5xbsD7I3K6l0NFyEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739316527; c=relaxed/relaxed;
	bh=qQnH5P2GeliKHpjzSCME0Gs+xwrAlvlU/ufLz+3IVsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSPm9eCVyapXBjvHZ8oAojwNMh0fNf0v5/fy3ZuoFgxXmLU3NB6icHvI6qLKxIjDShd2XjLioEHYjPrjouotU+a7UAxCKp3cq5T2CPJaLsBhH3c4AjXyxs7CdQJjjZdh2vG428w5E5cV/fR1LWcoloK/jCFglCTLydIPgE6hLAQzKgJsOSi26ZmYf9pxgNzUQkqRM0Gy06OPqA9UUtl80AXY1R6AweNtiprx8lx1VKeI5Mk5jrO9mPPw7bgGjNpJmfgk3sErp8Af0Z1Jz6PlJUGIsShsmq76ofmfhv6sSGDEDXAG8Nvxbqo5WGKwfHGWVjspa6sfoP5CT4RF5lQeOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VdDiHY39; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::929; helo=mail-ua1-x929.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VdDiHY39;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::929; helo=mail-ua1-x929.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YsyLk6086z2xmk
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Feb 2025 10:28:45 +1100 (AEDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-8641c7574a5so1761959241.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 11 Feb 2025 15:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739316523; x=1739921323; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQnH5P2GeliKHpjzSCME0Gs+xwrAlvlU/ufLz+3IVsQ=;
        b=VdDiHY39Gj/+AR77YQPwZiIKqQjSlnhBma0q+UvLUDIYFm9MQhyDSLNcQC1/oeHmCK
         b5cmuU3pdDYBVv2EylTxVlN33940U/uKhz+EoMizuaaAgvcMRUhAj/DzofMwbVlbJRt1
         khwAF05edPrbhPCJjLTLNCuLCQwh2cBqbeNPRvN10tULpA9uuVT65AhjCB8bM9UvNPc6
         maJ/jFXzuYkQz5Cq9FcVTPrt037t3nLJWPYQo34ef8owMAR24X1fxUI71asb2xkegeA0
         P4hszI+c6UODHlTAQSmz7cELsP9MM+mbp2MDQjElBJf0TwuK/iNzlDU6dn46jqW44GX5
         kweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739316523; x=1739921323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQnH5P2GeliKHpjzSCME0Gs+xwrAlvlU/ufLz+3IVsQ=;
        b=X2dXRclhQfIKsggvLiLyBm9CDsipz/77MLZ/uoKmmwsMgl6WtORs9XaEZNJQFmMgbG
         t7rslEp5JcUUByIaadDE2c6r2WohLzA+FvHXMIjY7M3WXjYiRrqPDNZZPNQLWF07r6Q2
         0Zcf/ho9EelM+wDGNsknPbrYTw2jwjqqYMZxTRmgDGgaX1+7VNOcC/Ya4PFY9T6W4qvC
         D5okiwGtUDrzNS56tg0RWZBBCvANqumddrVVIui45BoNj0+g6nPku7d89CfFX1xXTSag
         +HrnJTTlZtEalL3AUQHxmyZF93JOMirX07/HoThsO2vPBGra7hkOht1MqREDUFcXPulP
         6Rrw==
X-Forwarded-Encrypted: i=1; AJvYcCXqZEuZvFCpxSW9ZnubO9Pva7jwH5iBNz4YIuY4Z4d87iaIo0X3WSOSPLsT9aJiyLhbpbN4Cy2rpP7Ehw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxLcHw2ymyrRHf+xrFxa3pZwskIeKE1BQyyfGNmdiUGZgGv9Scw
	rVTpszlh9aXCvcFCnz7/ZXzgceEumhHU0VGunhwHMzMT38TE5g0jtscJ4QCHINF4f+DMxLG01jQ
	BZA/OvZH9EwmN9OkojIp4dRyuZ7Y=
X-Gm-Gg: ASbGncsM9ttlg62XPe2laWH+kiC24/vx5p4s6aaR6ZE4r53nVEp3f7YSCt/PpSfsCzn
	IWvrYdrE5zWFmyUB1dsNHGZo5KYglGzfU/Zjt3pXPGkiBed61hpgFSfi+S6F26fPgrgh33T8NQt
	A3u5fUDqKjbCcaHBC+9T1vqmzAEGTE
X-Google-Smtp-Source: AGHT+IHM4M9TMOu+WRtw2j+hdcsgiv9ZnObcd9GSSwp8rRqwkq8/a4xgvi2/qLZ6cPgUgTgZYUl+xDdb7mxpUMRTgRg=
X-Received: by 2002:a05:6102:2d02:b0:4ba:9a20:dcff with SMTP id
 ada2fe7eead31-4bbf217a378mr1729167137.11.1739316522993; Tue, 11 Feb 2025
 15:28:42 -0800 (PST)
MIME-Version: 1.0
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
 <20250207155048.GX1233568@bill-the-cat> <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat> <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
 <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com> <20250211212909.GI1233568@bill-the-cat>
In-Reply-To: <20250211212909.GI1233568@bill-the-cat>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Tue, 11 Feb 2025 15:28:32 -0800
X-Gm-Features: AWEUYZlZ16m252xxTRccJyCo60a0nbsuSjNk4KsZSrKCO8dPXOXA4rIKe54zACg
Message-ID: <CABMsoEGs5N9Uhz-wW2_cq=HguLf8PivRukXJBLnSO+_-+NsJeg@mail.gmail.com>
Subject: Re: Security vulnerabilities report to Das-U-Boot
To: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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
Cc: Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Thank you, I've reached out to MITRE for CVE numbers, I will
communicate them once assigned (hopefully within a few days).

Best regards,
              Jonathan

On Tue, Feb 11, 2025 at 1:29=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, Feb 11, 2025 at 08:26:37AM -0800, Jonathan Bar Or wrote:
> > Hi Tom and the rest of the team,
> >
> > Please let me know about fix time, whether this is acknowledged and
> > whether you're going to request CVE IDs for those or if I should do
> > it.
> > The reason is that I found similar issues in other bootloaders, so I'm
> > trying to synchronize all of them. For what it's worth, Barebox has
> > similar issues and are currently fixing.
>
> Yes, these seem valid. We don't have a CVE requesting authority so if
> you want them, go ahead and request them. You saw Gao Xiang's response
> for erofs, and I'm hoping one of the squashfs maintainers will chime in.
>
> >
> > Best regards,
> >              Jonathan
> >
> > On Mon, Feb 10, 2025 at 7:51=E2=80=AFPM Gao Xiang <hsiangkao@linux.alib=
aba.com> wrote:
> > >
> > > Hi Tom,
> > >
> > > On 2025/2/11 00:41, Tom Rini wrote:
> > > > On Fri, Feb 07, 2025 at 09:53:01AM -0800, Jonathan Bar Or wrote:
> > > >
> > > >> Thank you.
> > > >>
> > > >> So, I'm attaching my findings in a md file - see attachment.
> > > >> All of those could be avoided by using safe math, such as
> > > >> __builtin_mul_overflow and __builtin_add_overflow, which are used =
in some
> > > >> modules in Das-U-Boot.
> > > >> There are many cases where seemingly unsafe addition and multiplic=
ation can
> > > >> cause integer overflows, but not all are exploitable - I believe t=
he ones I
> > > >> report here are.
> > > >>
> > > >> Let me know your thoughts.
> > > >
> > > > Adding in the eorfs and squashfs maintainers..
> > > >
> > > >>
> > > >> Best regards,
> > > >>              Jonathan
> > > >>
> > > >> On Fri, Feb 7, 2025 at 7:50=E2=80=AFAM Tom Rini <trini@konsulko.co=
m> wrote:
> > > >>
> > > >>> On Thu, Feb 06, 2025 at 07:47:54PM -0800, Jonathan Bar Or wrote:
> > > >>>
> > > >>>> Dear U-boot maintainers,
> > > >>>>
> > > >>>> What is the best way of reporting security vulnerabilities (memo=
ry
> > > >>>> corruption issues) to Das-U-Boot? Is there a PGP key I should be=
 using?
> > > >>>> I have 4 issues that I think are worth fixing (with very easy fi=
xes).
> > > >>>>
> > > >>>> Best regards,
> > > >>>>              Jonathan
> > > >>>
> > > >>> Hey. As per https://docs.u-boot.org/en/latest/develop/security.ht=
ml
> > > >>> please post them to the list in public. If you have possible solu=
tions
> > > >>> for them as well that's even better. Thanks!
> > > >>>
> > > >>> --
> > > >>> Tom
> > > >>>
> > > >
> > > >> Filesystem-based Das-U-Boot issues.
> > > >>
> > > >> =3D=3D erofs
> > > >>
> > > >> =3D=3D=3D Integer overflow leading to buffer overflow in symlink r=
esolution
> > > >> In file `fs.c`, when resolving symlinks, the function `erofs_off_t=
` gets an `erofs_inode` argument and performs a lookup on the symlink.
> > > >> The function blindly trusts the `i_size` member of the input as su=
ch:
> > > >>
> > > >> ```c
> > > >>      size_t len =3D vi->i_size;
> > > >>      char *target;
> > > >>      int err;
> > > >>
> > > >>      target =3D malloc(len + 1);
> > > >>      if (!target)
> > > >>              return -ENOMEM;
> > > >>      target[len] =3D '\0';
> > > >>
> > > >>      err =3D erofs_pread(vi, target, len, 0);
> > > >>      if (err)
> > > >>              goto err_out;
> > > >> ```
> > > >>
> > > >> The `erofs_inode` structure's `i_size` member is defined with the =
type `erofs_off_t` (which is a 64-bit unsigned integer).
> > > >> Thereofre, if supplied as 0xFFFFFFFFFFFFFFFF, the `len + 1` input =
to `malloc` would overflow to 0, allocating a chunk with 0.
> > > >> That chunk (saved in `target`) is later written with `erofs_pread`=
, overriding the chunk with partial data controlled by an attacker.
> > > >> Therefore, we will have a heap buffer overflow due to an integer o=
verflow in `len` calculation.
> > >
> > > Yeah, it's a corner case, I will try to address it later.
> > >
> > > Thanks,
> > > Gao Xiang
>
> --
> Tom
