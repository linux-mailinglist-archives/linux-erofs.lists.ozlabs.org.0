Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCCCA3113A
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2025 17:26:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ysmzz2Qjpz3bpn
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 03:26:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::a30"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739291214;
	cv=none; b=joc6pYQIZfidIa4nb2Xx425tmf4QlAFgIkP/3rtLR4KSXfpNqZFkSMu48U0jmIZgzmqG4hJ8uB0ZFW7djaDjnyfxpxUR05YvsxaGQUGSEpWLdjuOkbyL8jJZdkRFzY78qsDC2Wi+EMDlIHzVKD7kk+TtfGR+50/rjmEN+NZ4QkF/5Uytwl9tCVNFnNzI1zcvIuRCxHG3bPUZOQ6CXWHLytxH6go654cKW65pBtJO0Z3Ye2SO3g8sGso/i81JLuht/stYQztscwPa+kyBZxvgwAd9CebLPqsAMrynfwV/PD6FzmmtdOvohUE+eratyQoUZAfTqGDsmTpPJFiQtvS8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739291214; c=relaxed/relaxed;
	bh=wi+ump/MfCur6IZzFvvLwGZPl6m86RL9j0ArclMdnEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+4r/r/jRWB9QicbaH1Ci10LxqMmp2sgMq7wLS5L9RBI7p/W9SqDy284R8om/JRSqV3L6kvamMptWNaCYp2n3ZDMzfQqCWXrtbyTviwtTh+G84ndGWjmuhPthCzz6ZPT7FNEnsYnIVczTSqWPsrJtJeHt7zbAe77qr0PYgNQwZ0kYfHE7UWWmLgxprowLqiaLYIBov7HUrpenLB0JQ8Do1n1LW6PsNPDz7+dmtDfEraGsJX+V1M71isdvBhUnFRSMK8byc4FAcFX65aKisZav5p/7UH+XSmNhGMPsDqvTVbpVD9/CxKKAIUUNzpn2XJTo8ZPDgW2xP8dmCx+Yz3W4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WqfAvBP4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::a30; helo=mail-vk1-xa30.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WqfAvBP4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::a30; helo=mail-vk1-xa30.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ysmzx0Nnyz2ywM
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Feb 2025 03:26:52 +1100 (AEDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-5205276bdb8so559711e0c.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 11 Feb 2025 08:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739291209; x=1739896009; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wi+ump/MfCur6IZzFvvLwGZPl6m86RL9j0ArclMdnEY=;
        b=WqfAvBP4Tn2Jvlwoc3KnQYrVX22c9qr1wZqOkO4vJ80nQldkj11boUWj7t4OTamMAn
         IKVYkRFLAGWW18Nrg9FMUYNuodlCpeBtHzWU3SWzr8sgH5nGh5i5i2Z16KbZsz8RB5qP
         xMO1fB18GJjyB7xJKU9imH9GujG9jvGvR6A9TKK/hJ9MHuzY3zcDMvcp3t93AH9FZdOh
         z8nwxfP3JAu5Rktz+6hl5lE7POp1e2XO6JWaFdnxHVCwlW4c8621Er5ynL7VautqLf7R
         dq74o2wiIarCCB6o3ENZC2mboZtJLVa0x8tiZeWI0LawBTfUrglCd6vo1/PdSdRcUv6l
         XSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739291209; x=1739896009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wi+ump/MfCur6IZzFvvLwGZPl6m86RL9j0ArclMdnEY=;
        b=jzeOWRL1NfOFt0VPoJ1kW/dsBMXlOBCzPvt9/Ar5kBYEufTzI9Zfs2SCP3Jjg6vjGd
         cWWVWaO2vh5aq662P5HyIrpHhG6ZLs9nBCJ435dZDgFaYxIgrICIlgpNvnkLPKJAB1Jm
         xUfXehgqn4yuPUY+rWvEsSiCRxtVUc/cxKTIfMXR7YYtzMDZ00ixam0g+Ru2LZk7Kn95
         cd4mAXbNNdEtMka58ya+GHvHjDF6LdynPHj0cq79028C1659ayVM4p9ky/+U8nuOdYpX
         q5CfPIY+VrdBweyIpx24jTwZ1tq/3IaEm1OqE65h7t8/p29SvBYHdXQ/RmFq7zAH+iZ3
         vAEA==
X-Forwarded-Encrypted: i=1; AJvYcCW8GHmHBfShrGDeRtSfeCE26L3NdbbxqtRgDQPwZNfs5yOylPCtZpcL5xKgxHuxCsF+QhaJr4XP1SDv1g==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxYmegwyZOYX22ZkIsedJ/MDXuC9RhFN40CouhK+IsTUOL8p2En
	+sybEYPuEuidHIqgpULH+ajlbBVjo6KBRJKJ1ahuOb3McEtG7JEk9Y6iIcdiXAoOVgYr1Th6VxC
	DNy8mvTgCFOmJ/uHNi9LEAzZS3UA=
X-Gm-Gg: ASbGnctyuZAHIhRbU5kgI9qzR82dIv595TMF7s8mh+/nsgCYTfZBVM7K25sq6CfO8ok
	BUgEdXTKstVdASdHyyL1a2+et7BoiWwniFztb4BBikBpbPeTl04FYzzAModNZvY69nmrhUtrcg5
	vh1/PS5fYseF3tAnMtzhV/cUZZhiGL
X-Google-Smtp-Source: AGHT+IG7ldC5YdinnSrhBGWmb37qbqOZ+zAj0J+/Ta93EcOW2DuNgQbXwZHkgroISIVsVimtpH5D4kkMhxWVkkd/LBM=
X-Received: by 2002:a05:6122:1d8c:b0:520:5a87:66eb with SMTP id
 71dfb90a1353d-52067b755c1mr215494e0c.3.1739291209303; Tue, 11 Feb 2025
 08:26:49 -0800 (PST)
MIME-Version: 1.0
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
 <20250207155048.GX1233568@bill-the-cat> <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat> <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
In-Reply-To: <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Tue, 11 Feb 2025 08:26:37 -0800
X-Gm-Features: AWEUYZmF5t_mzkCXCoy_PA9qmB_PJgoYreUfTd2BwD0dYWohRtUpZjbdtVChG9g
Message-ID: <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
Subject: Re: Security vulnerabilities report to Das-U-Boot
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
Cc: Tom Rini <trini@konsulko.com>, Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Tom and the rest of the team,

Please let me know about fix time, whether this is acknowledged and
whether you're going to request CVE IDs for those or if I should do
it.
The reason is that I found similar issues in other bootloaders, so I'm
trying to synchronize all of them. For what it's worth, Barebox has
similar issues and are currently fixing.

Best regards,
             Jonathan

On Mon, Feb 10, 2025 at 7:51=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Tom,
>
> On 2025/2/11 00:41, Tom Rini wrote:
> > On Fri, Feb 07, 2025 at 09:53:01AM -0800, Jonathan Bar Or wrote:
> >
> >> Thank you.
> >>
> >> So, I'm attaching my findings in a md file - see attachment.
> >> All of those could be avoided by using safe math, such as
> >> __builtin_mul_overflow and __builtin_add_overflow, which are used in s=
ome
> >> modules in Das-U-Boot.
> >> There are many cases where seemingly unsafe addition and multiplicatio=
n can
> >> cause integer overflows, but not all are exploitable - I believe the o=
nes I
> >> report here are.
> >>
> >> Let me know your thoughts.
> >
> > Adding in the eorfs and squashfs maintainers..
> >
> >>
> >> Best regards,
> >>              Jonathan
> >>
> >> On Fri, Feb 7, 2025 at 7:50=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> >>
> >>> On Thu, Feb 06, 2025 at 07:47:54PM -0800, Jonathan Bar Or wrote:
> >>>
> >>>> Dear U-boot maintainers,
> >>>>
> >>>> What is the best way of reporting security vulnerabilities (memory
> >>>> corruption issues) to Das-U-Boot? Is there a PGP key I should be usi=
ng?
> >>>> I have 4 issues that I think are worth fixing (with very easy fixes)=
.
> >>>>
> >>>> Best regards,
> >>>>              Jonathan
> >>>
> >>> Hey. As per https://docs.u-boot.org/en/latest/develop/security.html
> >>> please post them to the list in public. If you have possible solution=
s
> >>> for them as well that's even better. Thanks!
> >>>
> >>> --
> >>> Tom
> >>>
> >
> >> Filesystem-based Das-U-Boot issues.
> >>
> >> =3D=3D erofs
> >>
> >> =3D=3D=3D Integer overflow leading to buffer overflow in symlink resol=
ution
> >> In file `fs.c`, when resolving symlinks, the function `erofs_off_t` ge=
ts an `erofs_inode` argument and performs a lookup on the symlink.
> >> The function blindly trusts the `i_size` member of the input as such:
> >>
> >> ```c
> >>      size_t len =3D vi->i_size;
> >>      char *target;
> >>      int err;
> >>
> >>      target =3D malloc(len + 1);
> >>      if (!target)
> >>              return -ENOMEM;
> >>      target[len] =3D '\0';
> >>
> >>      err =3D erofs_pread(vi, target, len, 0);
> >>      if (err)
> >>              goto err_out;
> >> ```
> >>
> >> The `erofs_inode` structure's `i_size` member is defined with the type=
 `erofs_off_t` (which is a 64-bit unsigned integer).
> >> Thereofre, if supplied as 0xFFFFFFFFFFFFFFFF, the `len + 1` input to `=
malloc` would overflow to 0, allocating a chunk with 0.
> >> That chunk (saved in `target`) is later written with `erofs_pread`, ov=
erriding the chunk with partial data controlled by an attacker.
> >> Therefore, we will have a heap buffer overflow due to an integer overf=
low in `len` calculation.
>
> Yeah, it's a corner case, I will try to address it later.
>
> Thanks,
> Gao Xiang
