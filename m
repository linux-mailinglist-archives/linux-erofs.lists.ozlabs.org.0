Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 903C3A36B9B
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Feb 2025 04:24:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YvvRZ1wStz3bmy
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Feb 2025 14:24:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::92e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739589880;
	cv=none; b=l4exb62DqrWuCg7T9APF20pMtTQVBXIbtz1yTbePJy1Lr5jDJ1eF8kLFr0y3FVDspMbwxiS59D1iJRXeiSe9r6pJTAGq+PLnzyvNp14OhjT3K0cNk2MJNCpW64BSnk96BOyF6rF6+xkAPeBFOfs8Stg+xKb/41ghCXAS8e5+4pnz5UZPRn+bcpRic2oSOLtCpCiwr0NZH4lJd3W/GLJpM/0yXbQrSbvVr24GF/qg1qJCMyl2pWluJXfyrT7wJL7LJdl+Wf0O4z7BXy6gi/qWd7WTQU1T+LQDTgxxyLtNko9jsoZ+/2GyKxTHrid9J84x1q3bFYyN4FlFtUrR84gUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739589880; c=relaxed/relaxed;
	bh=cRVyUPsMSzLuveyUCfRMYI1870pmgWGGv9ydJBObdy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVZDlBErFFJ3+Zbh5DTcH7vAPHk4urizWvQV/kn5X9GxQfbIZqfXgmC4cuGtxKPswhgh8gt4zNJhIbpiaiZ/pzGXvggJ/6y4ORJ3sBH+CdMLbwNkyA1SWCxpGBg8co38kg2dwgBzKyZh9P6BCFbsVr+lFKFfdPBaxEDGpv3ufeNayKGH4Niz5YniDmIW3Vnb/ruGgDgV15ikA45w7FawGBvVrIpfN+Ya3VEVsw09SnwZ04sykjjTyUp0ZJpzKTBIeALc4ndwDhLuV/Y18UoQPn6WzfOLiTlj2yfdMZu6jRWFpeCW3RbsUuX6rH/t+Om+9nyOlVF+cdMDqDbGmkp0qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YOGInGmj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::92e; helo=mail-ua1-x92e.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YOGInGmj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::92e; helo=mail-ua1-x92e.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvvRW42Dgz2yZN
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Feb 2025 14:24:38 +1100 (AEDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-86715793b1fso727946241.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 14 Feb 2025 19:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739589877; x=1740194677; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRVyUPsMSzLuveyUCfRMYI1870pmgWGGv9ydJBObdy0=;
        b=YOGInGmjugzBKSbNRnNLz0hK0Ad4QsmpzAgyryr6U8UV+jzCW4NoMEZHLM92o1mYzc
         a52OMgaJZYw1jsuEWKUTvpVBG/EkKkM/E8dInhHIvooajY2PGABd7WqLy547aPpfcgee
         LIuJKc6P9A0A8V2kshS7HxhUTGjOdiFnanw5BZW0b9t39/lbd51ykpBfeqrI6rpBm9gg
         OUM0OetNy2yTMaQFYi66PT3yDmrJ+GKaLmnOdkXENkY+cn1USDVDDlkNkgFcxxCgL7Im
         VYyuMKDqA2+E1/ywEnFepN12bBPGnj1AcUmR+3CaSzUCx52pXkD0SyHfysL/71M28M9j
         kOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739589877; x=1740194677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRVyUPsMSzLuveyUCfRMYI1870pmgWGGv9ydJBObdy0=;
        b=Xd3XLeMvaErKVI8HfSfVrJCc8BzdSVRwuP23qD9nV9JPnBtZNstU3UQwtjGraRC0FH
         QfCLM6tMuTZZpLv8v8K9RtnEyNLP4UKfuJJBIhIzCkFSvi4qdq1+3SasiUyO2bjNjhJV
         0eNYGAtWVgZx/hXqE8e/2yv3DZKZ0bgDwVNQeqYHzPB6RWV46z7tfqCQvGzoJhk+HYI7
         HftjIPn33mIXGh8vhFjuvsT4M9hTDIOvww2XVLuCOhLo+KlFS53bJMiT430/Z29GR4LW
         TLwlJy8GlZuvYstGXvYKwx625tGS4MpiXy2fK4dQY5bmMmHXS9wG5nF2fDPyKjohbTGI
         F2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9q/jZeKJzm2XdaQBmjxFDmkndyA1z92f1+ApM1yAQX3iUyAWDNfdcbamRlSDC3dPYs5Znds078NCEcw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyT7GEgQoxbqxk+bMYvyP52jxRqwiLQldjzY4d60D8BTrrk4uNp
	cqFxeM6gu2ohc2unskhJOV+unDzDh5gTS5cnEp9oy3Z04G0p9iCYfIRHpc7UPZxD7xpka0LoHzf
	nNdo6u1BFFK7wFrlKjBhvNnSibgnV88zE/18=
X-Gm-Gg: ASbGncs/y14oND3TktySQx5nEF6VWybzWrXy3JIi0IBRAhe+CQqqWQ9EToVD4NjqOPE
	xihrqyh994BhkvM0Rqbwe0AEAIN3pVjy+gtZ55UVgiO+AKP6YfA3gOnqtFgQSGruHvJ8pF9HrKN
	bzBbV9WyMbHc81+M8LpQ0pyje0jhzY
X-Google-Smtp-Source: AGHT+IFypluWmnDkKtvIGGiWpbhspJdBkel7BnLRu7j0NgHXyR65z6XQxMfIsFfuxkTxqkTO3P2YcjOBTAtixQ/laRg=
X-Received: by 2002:a05:6122:29ce:b0:520:3914:e6bb with SMTP id
 71dfb90a1353d-5209dc22be3mr1040957e0c.7.1739589876941; Fri, 14 Feb 2025
 19:24:36 -0800 (PST)
MIME-Version: 1.0
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
 <20250207155048.GX1233568@bill-the-cat> <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat> <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
 <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
 <20250211212909.GI1233568@bill-the-cat> <8734gjsh8t.fsf@bootlin.com> <CABMsoEGq+s2qudAHVwydpwXw_ROVfgw90yU7+VKYO6x27AWdew@mail.gmail.com>
In-Reply-To: <CABMsoEGq+s2qudAHVwydpwXw_ROVfgw90yU7+VKYO6x27AWdew@mail.gmail.com>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Fri, 14 Feb 2025 19:24:26 -0800
X-Gm-Features: AWEUYZnajkda29ArdJ9WH2JXzTaGyLRTusvUnSP1A4A5xHenQgeEim-Q_Q41rJs
Message-ID: <CABMsoEFcL-D2OzJWQM685TfLq20L+d2gNmy4XD7yW6aDwpKb4w@mail.gmail.com>
Subject: Re: Security vulnerabilities report to Das-U-Boot
To: Miquel Raynal <miquel.raynal@bootlin.com>
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
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, Joao Marcos Costa <jmcosta944@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Please disregard the previous message, those are the actual CVE numbers:

- CVE-2025-26726 :SquashFS directory table parsing buffer overflow
- CVE-2025-26727: SquashFS inode parsing buffer overflow.
- CVE-2025-26728: SquashFS nested file reading buffer overflow.
- CVE-2025-26729: EroFS symlink resolution buffer overflow.

Best regards,
           Jonathan


On Fri, Feb 14, 2025 at 7:17=E2=80=AFPM Jonathan Bar Or <jonathanbaror@gmai=
l.com> wrote:
>
> Hi folks.
>
> Here are the CVEs assigned by MITRE:
> - CVE-2025-26721: buffer overflow in the persistent storage for file crea=
tion
> - CVE-2025-26722: buffer overflow in SquashFS symlink resolution
> - CVE-2025-26723: buffer overflow in EXT4 symlink resolution
> - CVE-2025-26724: buffer overflow in CramFS symlink resolution
> - CVE-2025-26724: buffer overflow in JFFS2 dirent parsing
>
> Best regards,
>            Jonathan
>
> On Wed, Feb 12, 2025 at 12:24=E2=80=AFAM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > Hello Tom,
> >
> > On 11/02/2025 at 15:29:09 -06, Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Tue, Feb 11, 2025 at 08:26:37AM -0800, Jonathan Bar Or wrote:
> > >> Hi Tom and the rest of the team,
> > >>
> > >> Please let me know about fix time, whether this is acknowledged and
> > >> whether you're going to request CVE IDs for those or if I should do
> > >> it.
> > >> The reason is that I found similar issues in other bootloaders, so I=
'm
> > >> trying to synchronize all of them. For what it's worth, Barebox has
> > >> similar issues and are currently fixing.
> > >
> > > Yes, these seem valid. We don't have a CVE requesting authority so if
> > > you want them, go ahead and request them. You saw Gao Xiang's respons=
e
> > > for erofs, and I'm hoping one of the squashfs maintainers will chime
> > > in.
> >
> > Either Jo=C3=A3o or me, we will have a look.
> >
> > Thanks,
> > Miqu=C3=A8l
