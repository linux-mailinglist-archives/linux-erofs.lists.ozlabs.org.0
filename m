Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5618B8025D5
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Dec 2023 18:01:53 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WKzz08k+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SjtPT5F67z3cLk
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Dec 2023 04:01:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WKzz08k+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com; envelope-from=qkrwngud825@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SjtPN6L5gz2yhT
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Dec 2023 04:01:43 +1100 (AEDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54ca339ae7aso806649a12.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 03 Dec 2023 09:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701622898; x=1702227698; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzuNvt1M83C1nZ2ailqYr8YmM+HGUOe16GkYorpbLx0=;
        b=WKzz08k+W+VPDRarKotYuRgqY6pyA7+tqXepELug2ihaoUlct4kyq9yivm5LfZO6Zj
         7h91LmJkmPO4ja+ZkbjY4e1r3O5lwDsJKlSYDg7lDRPjB2Zew2NM/GM+ZAS+fJ1DKQ/O
         Em+G53TDKsRiUYZBJLZgWFSETWMO4pAs1+XbaGThX9p2wuEBWbmgwEZcTgF0Pd3kte2V
         2YLZNWCc8lVf7q83kFAkFFy0HbaRABVFOAXe/ODrwfsbvkcSXjiRTYmft+BD2aNgOPRz
         2dDL3+iTcQcgfxyTMBXFUboMmCsL5xhtXQNaRKbm+FYfdn+qXFc8nV760TLuao6YI1/O
         5XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701622898; x=1702227698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzuNvt1M83C1nZ2ailqYr8YmM+HGUOe16GkYorpbLx0=;
        b=PKZQ+xfJG8cCRWmeO+Y9pLF5HoV/vTTYcHFIOWvosM7XoS3DxhMNz/1H7IeIfXaCFT
         Pv3mGnn82c+s9XB8CS6hgE5JkBLAsdV3nYi/K5ahSYK7yP5neI2BfP53YaI3lUeFNvCq
         kwadS3fOvkdv6Q1O8hKY6Tbs7DgVBLEGZWFKxpnLlv/NZ2LA6VXuWCL6hBVzZGv/mrRY
         WIaMDVmE2pArmbVsC8GG1tcwzLcTc/DriCJZnuKWpenp/s0ZopsRd3z/y8aBDmBfhjGL
         W10aYBhvT5CFhLY99pJNYTVTahhSVVhXOVvVpwvCSaygE8AjEpttsMCP2XWuTL/QPXVK
         eU2A==
X-Gm-Message-State: AOJu0YxRKMXwSekBz1wPbZU3v1WfZmnK9ADvYZow4EQIZ1CQoKLEoWKQ
	+K8j41/bZT15XNtdHorZjakmqE8GSf4R1DaWikI=
X-Google-Smtp-Source: AGHT+IFGRfJA6vGF4av1eLxwU3W7g2Js190Id7mzSP/GKPFCqEGGZt4G5+O1IszyNsyfe9jADDoKeynZS4hp2WOF4Hc=
X-Received: by 2002:a17:907:12c6:b0:a19:a1ba:da55 with SMTP id
 vp6-20020a17090712c600b00a19a1bada55mr2035935ejb.124.1701622897981; Sun, 03
 Dec 2023 09:01:37 -0800 (PST)
MIME-Version: 1.0
References: <CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com>
 <5a0e8b44-6feb-b489-cdea-e3be3811804a@linux.alibaba.com>
In-Reply-To: <5a0e8b44-6feb-b489-cdea-e3be3811804a@linux.alibaba.com>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Mon, 4 Dec 2023 02:01:27 +0900
Message-ID: <CAD14+f2G-buxTaWgb23DYW-HSd1sch6tJNKV2strt=toASZXQQ@mail.gmail.com>
Subject: Re: Weird EROFS data corruption
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Yann Collet <yann.collet.73@gmail.com>, linux-erofs@lists.ozlabs.org, linux-crypto@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao,

On Mon, Dec 4, 2023 at 1:52=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
> Hi Juhyung,
>
> On 2023/12/4 00:22, Juhyung Park wrote:
> > (Cc'ing f2fs and crypto as I've noticed something similar with f2fs a
> > while ago, which may mean that this is not specific to EROFS:
> > https://lore.kernel.org/all/CAD14+f2nBZtLfLC6CwNjgCOuRRRjwzttp3D3iK4Of+=
1EEjK+cw@mail.gmail.com/
> > )
> >
> > Hi.
> >
> > I'm encountering a very weird EROFS data corruption.
> >
> > I noticed when I build an EROFS image for AOSP development, the device
> > would randomly not boot from a certain build.
> > After inspecting the log, I noticed that a file got corrupted.
>
> Is it observed on your laptop (i7-1185G7), yes? or some other arm64
> device?

Yes, only on my laptop. The arm64 device seems fine.
The reason that it would not boot was that the host machine (my
laptop) was repacking the EROFS image wrongfully.

The workflow is something like this:
Server-built EROFS AOSP image -> Image copied to laptop -> Laptop
mounts the EROFS image -> Copies the entire content to a scratch
directory (CORRUPT!) -> Changes some files -> mkfs.erofs

So the device is not responsible for the corruption, the laptop is.

>
> >
> > After adding a hash check during the build flow, I noticed that EROFS
> > would randomly read data wrong.
> >
> > I now have a reliable method of reproducing the issue, but here's the
> > funny/weird part: it's only happening on my laptop (i7-1185G7). This
> > is not happening with my 128 cores buildfarm machine (Threadripper
> > 3990X).>
> > I first suspected a hardware issue, but:
> > a. The laptop had its motherboard replaced recently (due to a failing
> > physical Type-C port).
> > b. The laptop passes memory test (memtest86).
> > c. This happens on all kernel versions from v5.4 to the latest v6.6
> > including my personal custom builds and Canonical's official Ubuntu
> > kernels.
> > d. This happens on different host SSDs and file-system combinations.
> > e. This only happens on LZ4. LZ4HC doesn't trigger the issue.
> > f. This only happens when mounting the image natively by the kernel.
> > Using fuse with erofsfuse is fine.
>
> I think it's a weird issue with inplace decompression because you said
> it depends on the hardware.  In addition, with your dataset sadly I
> cannot reproduce on my local server (Xeon(R) CPU E5-2682 v4).

As I feared. Bummer :(

>
> What is the difference between these two machines? just different CPU or
> they have some other difference like different compliers?

I fully and exclusively control both devices, and the setup is almost the s=
ame.
Same Ubuntu version, kernel/compiler version.

But as I said, on my laptop, the issue happens on kernels that someone
else (Canonical) built, so I don't think it matters.

>
> Thanks,
> Gao Xiang
