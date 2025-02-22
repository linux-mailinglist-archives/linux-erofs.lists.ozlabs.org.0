Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F977A40B96
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Feb 2025 21:48:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z0fGF57S1z30CL
	for <lists+linux-erofs@lfdr.de>; Sun, 23 Feb 2025 07:48:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::e31"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740257283;
	cv=none; b=MWNkEOmJ1WsF8/ORE6T4q8Jc1mjsNMSrd1A2nK5SUDSxQ0GQshn0Q6pX0pI+NIcvtIh61mMFNHWn8sBaJTzva8yREcpQ/E8lmD+/ivuRg1kk5rpT13clJn563bKa4GifuuQmcsw58qcNCo+7MPBHYG67EWZTKrQ7xIvvUmQMY7U3DJqL5VBHp04ab1dUWoqBSiIOVVaRode44m7aItzdP0kY86VRZkhSBIQ31zThJaAW1I7wXNxnmO8LMHOnBlCQPYAhbIcFfDoBeKIoOLC5E4aVo5ydX/i0g3CX4VRDBTqq1NlhPfXFGW1FJtwA0Oukz7ojnbfu6lJW9hkp18WanA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740257283; c=relaxed/relaxed;
	bh=tcLRcReYHNg+jHASaYLW15SWxOcxWSRO/Z6Fnu09K4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqhmnATdg8DIR0DpJVKo4nZDr3XsznDDxpa9+2fm/00rvelmJ3XJedwA/Ff4x51exDE4IlRQKDSGhBAiFFfchAMyHYSrp3vC1xwhf1JJ0j62FJOggTw18mG7dYVqWfHeEr67vnp/mYE3W8XJ1AI8V1dYEaecJLavjUOWK3quzmutm0lj7Abkt1rR2BCoBpA3Pl+dGIUevGCURvUlDU31T/WgXqoWIHgWbyxB6i6br7ru/t4gznkC7iHS3tcUoTMg2/dbEKLbP95DGpeBXcYYOvIZrBLo/YA+tbBzqTJqWso/x1GvlpBtLIJxjUD+aw1ZsdMNUD1Rf714e8hBXXaHrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Zz7ufYkv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e31; helo=mail-vs1-xe31.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Zz7ufYkv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e31; helo=mail-vs1-xe31.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z0fGB3gMLz2ywh
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Feb 2025 07:48:01 +1100 (AEDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-4be6599024cso2150915137.3
        for <linux-erofs@lists.ozlabs.org>; Sat, 22 Feb 2025 12:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740257276; x=1740862076; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcLRcReYHNg+jHASaYLW15SWxOcxWSRO/Z6Fnu09K4c=;
        b=Zz7ufYkvwUOxQwbL9uztca1F8MlNuq+pBJ0s9zz7Lsj56g7vQpX+LXY4h4Bq9MdIN/
         /eAkvpfD9egzMfp8gMIYGg3Yx7WmKB6rCuFMvY1EeQw48zRp/i4KXc1F1uZod2qVFrN7
         dfcESSh7rhj5IT8dT83JaaHEZLStCviElbdUU1tbwQdeF53pE1syn/VfyOoFGsGlsahn
         mM8whCG98zgUEbC9MHT7o7GFLYaR0I4AlvSh2sWXuzDtQaGG3Cy12eCNj6ChqwAO0ecn
         pFfpWS+qxjJvlq7W99fmCJi1zkhyOJYCoZxKdql9pzYbH4NNMxxLpx+W3P09qlvsa4zX
         XLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740257276; x=1740862076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcLRcReYHNg+jHASaYLW15SWxOcxWSRO/Z6Fnu09K4c=;
        b=vy+uv2NZx8d6ivYX5RReYrQjijPJ96HBHgKHfILtMkvI4B5RdrFDPxAcOEqpfSYtUd
         fcZLDudqC6lhfyS4p470Z7RPgMe+7Y2TSMroog3t1r7nLaJGjwjsOWKcrfp/MXaoh9WM
         Qh+Q5vGXbojTdHvjnWdnwWaudiC3fd7VZTrpxb+QS7YwTRRZYk21OsAiKlU4Db1YK/p8
         2pKHa9J9UJ1q2tVQBhP1K1RvUlHfTV+qWtkYWfaFUmlS/DSMI78nMbhLctieZnPDgV4K
         v3EgNftdEpIEz6ebkvKTigB2FW4nNPIkutwAu7FeXmc8CPbxIy5tZZk5XDhK79HRz76W
         zECw==
X-Forwarded-Encrypted: i=1; AJvYcCXUeTmSs67qAhqjWmwDvFrRHJIBcqkuPHrCBZY/q1E5pD24ib7kCvnQACgGnyd1wgVRVgQqwH31AUMstw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyEuYou9IX3vP0c46Ylia4wVd8DnWZmMZL6iNCq1pVLdakL9R10
	ZPw5xquWMpRNvZ0eJiMblMGqs6IPPl5/4vmTascx1NBgNwjoe40fs0/lqyPjqBRHeYrIcGkjzcP
	YhKAYOA82P63lf1y4sYRxjZB11LM=
X-Gm-Gg: ASbGnctCqVj5diQZz1GK3ftlXEwfSuf2cr3SARd7M3DdxaLpdbRBlgeT/Z8wPRSMPc6
	utmllww1obl6TsSLPdogoLDrPnxEooiI16O4LdJy9xD3yqdyg3TG/yccz+gTMVaTfXlrmBOYBmO
	j8F/C2C2KWjy8MbUHPoYGfhzPLJu99x+qL4JnO0Q==
X-Google-Smtp-Source: AGHT+IFq5w9QVYB027ZgOUqp+q6hXHguOwg+4CMia/YUW7un5v3K2GCkkIoG/lcYJ8vEziig2WnCj3PkX5kmS7lrxzw=
X-Received: by 2002:a05:6102:d8d:b0:4bb:e8c5:b162 with SMTP id
 ada2fe7eead31-4bfc00689b3mr4519512137.10.1740257276346; Sat, 22 Feb 2025
 12:47:56 -0800 (PST)
MIME-Version: 1.0
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
 <20250207155048.GX1233568@bill-the-cat> <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat> <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
 <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
 <20250211212909.GI1233568@bill-the-cat> <8734gjsh8t.fsf@bootlin.com>
 <CABMsoEGq+s2qudAHVwydpwXw_ROVfgw90yU7+VKYO6x27AWdew@mail.gmail.com> <CABMsoEFcL-D2OzJWQM685TfLq20L+d2gNmy4XD7yW6aDwpKb4w@mail.gmail.com>
In-Reply-To: <CABMsoEFcL-D2OzJWQM685TfLq20L+d2gNmy4XD7yW6aDwpKb4w@mail.gmail.com>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Sat, 22 Feb 2025 12:47:45 -0800
X-Gm-Features: AWEUYZmxqtkIhHB2xdwy-6M0RUTehhAYi9TC1JJc0-bUL3X1fsJxX-lpnSyA0r8
Message-ID: <CABMsoEEQPvHM7jKYZZE1UaTgVTuN-TneVi8X9LRsr3+bD7xH3Q@mail.gmail.com>
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

Hello Tom and team,

Looks like all of the issues were fixed and merged - am I correct?
I intend to make a public disclosure March 19th, is that okay?

Best,
       Jonathan

On Fri, Feb 14, 2025 at 7:24=E2=80=AFPM Jonathan Bar Or <jonathanbaror@gmai=
l.com> wrote:
>
> Please disregard the previous message, those are the actual CVE numbers:
>
> - CVE-2025-26726 :SquashFS directory table parsing buffer overflow
> - CVE-2025-26727: SquashFS inode parsing buffer overflow.
> - CVE-2025-26728: SquashFS nested file reading buffer overflow.
> - CVE-2025-26729: EroFS symlink resolution buffer overflow.
>
> Best regards,
>            Jonathan
>
>
> On Fri, Feb 14, 2025 at 7:17=E2=80=AFPM Jonathan Bar Or <jonathanbaror@gm=
ail.com> wrote:
> >
> > Hi folks.
> >
> > Here are the CVEs assigned by MITRE:
> > - CVE-2025-26721: buffer overflow in the persistent storage for file cr=
eation
> > - CVE-2025-26722: buffer overflow in SquashFS symlink resolution
> > - CVE-2025-26723: buffer overflow in EXT4 symlink resolution
> > - CVE-2025-26724: buffer overflow in CramFS symlink resolution
> > - CVE-2025-26724: buffer overflow in JFFS2 dirent parsing
> >
> > Best regards,
> >            Jonathan
> >
> > On Wed, Feb 12, 2025 at 12:24=E2=80=AFAM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hello Tom,
> > >
> > > On 11/02/2025 at 15:29:09 -06, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > > On Tue, Feb 11, 2025 at 08:26:37AM -0800, Jonathan Bar Or wrote:
> > > >> Hi Tom and the rest of the team,
> > > >>
> > > >> Please let me know about fix time, whether this is acknowledged an=
d
> > > >> whether you're going to request CVE IDs for those or if I should d=
o
> > > >> it.
> > > >> The reason is that I found similar issues in other bootloaders, so=
 I'm
> > > >> trying to synchronize all of them. For what it's worth, Barebox ha=
s
> > > >> similar issues and are currently fixing.
> > > >
> > > > Yes, these seem valid. We don't have a CVE requesting authority so =
if
> > > > you want them, go ahead and request them. You saw Gao Xiang's respo=
nse
> > > > for erofs, and I'm hoping one of the squashfs maintainers will chim=
e
> > > > in.
> > >
> > > Either Jo=C3=A3o or me, we will have a look.
> > >
> > > Thanks,
> > > Miqu=C3=A8l
