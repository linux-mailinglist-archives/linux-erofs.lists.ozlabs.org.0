Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160488025FC
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Dec 2023 18:32:38 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VQ2GQCUL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sjv4z3pxPz3cLk
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Dec 2023 04:32:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VQ2GQCUL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=qkrwngud825@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sjv4r1cQcz2yjD
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Dec 2023 04:32:26 +1100 (AEDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54c67b0da54so2726934a12.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 03 Dec 2023 09:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701624734; x=1702229534; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p8xwvjykJ1KZRdzNx19vS2jHg0/UOJdCMHKZdpDhKc=;
        b=VQ2GQCULC4LLKDQvnu8cU4iGF1TW1iRiP9zcqbu0rnn0MIeD19UBuVt/t9MpR2B9TB
         bUUOgk6iFRrIj/imT41bOuN503LVitXCwPzei7CJ5ImCMPmcwpfVNEAEmbzvwyPrNuPt
         m1+epiL/2gV6z83Xy0z6HAOjMyJJitgs+e1Ec9/mPZt5ozRDFaMxsnUQ7KdorAySRzIJ
         31AsUUTxwaK4yRuPnS7P0cL0VGn/X8ebYNrI2lzQPwpPRk5c1kHC7XuPNfVx7VyAji0J
         SLmr04d1ewTVfhN3T6h7wa+2Dr/T1LJnl6G21Yq2x3BWRWIFXw9ZRJwx4+sfl/bRWnCS
         o6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701624734; x=1702229534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1p8xwvjykJ1KZRdzNx19vS2jHg0/UOJdCMHKZdpDhKc=;
        b=V/jUsWN0TO6RRz6lcXzlfOkDY0BWihG97orsPohL6Q/OAqB/9sjeyLWmOxVxiIXOSw
         sPGxfJSPX6TZIp4bVkxs1aob8LcRAodZ6EloKJUbLztFyd/63U3jFD3a2rtqkUva4/1l
         dHmB75h9a3CDTN4clcJCtUnwmX7t1mgZSCHAtE6SUOc1BLhStpKh43cOd2rOtFyrgNgg
         855R+V1FukI+ZzuOwCOLFc5EMLDOmAyQZXTqcJA+XA5qD7ldY408PzAHe3YusbDiYjIX
         3QPV2LUFkNZGaj7sNpFwJWNEBWuVbA5ZF9GbPhR6/tJflI2dquirIzOZVS1EMCSrnRh0
         K4/A==
X-Gm-Message-State: AOJu0YyxgdbwrSnJcQGnUQFCKVJkSIrvzmhqPtbKRFSN2DbJDH0IWDbL
	XQocpr6MSey499NQKsBx7eczzQ6ZJGSbrC7dKHk=
X-Google-Smtp-Source: AGHT+IFkqs0+qXxcb7yc+NPy0ORQdgHGpVNo+d/A7Zys0n6CGax9JnRVG4tP1V/BHxTyVjJa77MxCzciwPA8zumuGPI=
X-Received: by 2002:a17:906:538e:b0:a18:ae8c:4b44 with SMTP id
 g14-20020a170906538e00b00a18ae8c4b44mr2505854ejo.27.1701624734246; Sun, 03
 Dec 2023 09:32:14 -0800 (PST)
MIME-Version: 1.0
References: <CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com>
 <5a0e8b44-6feb-b489-cdea-e3be3811804a@linux.alibaba.com> <CAD14+f2G-buxTaWgb23DYW-HSd1sch6tJNKV2strt=toASZXQQ@mail.gmail.com>
 <649a3bc4-58bb-1dc8-85fb-a56e47b3d5c9@linux.alibaba.com>
In-Reply-To: <649a3bc4-58bb-1dc8-85fb-a56e47b3d5c9@linux.alibaba.com>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Mon, 4 Dec 2023 02:32:02 +0900
Message-ID: <CAD14+f1u6gnHLhGSoQxL9wLq9vDYse+Ac8zxep-O2E8hHreT2w@mail.gmail.com>
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

On Mon, Dec 4, 2023 at 2:22=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
>
>
> On 2023/12/4 01:01, Juhyung Park wrote:
> > Hi Gao,
> >
> > On Mon, Dec 4, 2023 at 1:52=E2=80=AFAM Gao Xiang <hsiangkao@linux.aliba=
ba.com> wrote:
> >>
> >> Hi Juhyung,
> >>
> >> On 2023/12/4 00:22, Juhyung Park wrote:
> >>> (Cc'ing f2fs and crypto as I've noticed something similar with f2fs a
> >>> while ago, which may mean that this is not specific to EROFS:
> >>> https://lore.kernel.org/all/CAD14+f2nBZtLfLC6CwNjgCOuRRRjwzttp3D3iK4O=
f+1EEjK+cw@mail.gmail.com/
> >>> )
> >>>
> >>> Hi.
> >>>
> >>> I'm encountering a very weird EROFS data corruption.
> >>>
> >>> I noticed when I build an EROFS image for AOSP development, the devic=
e
> >>> would randomly not boot from a certain build.
> >>> After inspecting the log, I noticed that a file got corrupted.
> >>
> >> Is it observed on your laptop (i7-1185G7), yes? or some other arm64
> >> device?
> >
> > Yes, only on my laptop. The arm64 device seems fine.
> > The reason that it would not boot was that the host machine (my
> > laptop) was repacking the EROFS image wrongfully.
> >
> > The workflow is something like this:
> > Server-built EROFS AOSP image -> Image copied to laptop -> Laptop
> > mounts the EROFS image -> Copies the entire content to a scratch
> > directory (CORRUPT!) -> Changes some files -> mkfs.erofs
> >
> > So the device is not responsible for the corruption, the laptop is.
>
> Ok.
>
> >
> >>
> >>>
> >>> After adding a hash check during the build flow, I noticed that EROFS
> >>> would randomly read data wrong.
> >>>
> >>> I now have a reliable method of reproducing the issue, but here's the
> >>> funny/weird part: it's only happening on my laptop (i7-1185G7). This
> >>> is not happening with my 128 cores buildfarm machine (Threadripper
> >>> 3990X).>
> >>> I first suspected a hardware issue, but:
> >>> a. The laptop had its motherboard replaced recently (due to a failing
> >>> physical Type-C port).
> >>> b. The laptop passes memory test (memtest86).
> >>> c. This happens on all kernel versions from v5.4 to the latest v6.6
> >>> including my personal custom builds and Canonical's official Ubuntu
> >>> kernels.
> >>> d. This happens on different host SSDs and file-system combinations.
> >>> e. This only happens on LZ4. LZ4HC doesn't trigger the issue.
> >>> f. This only happens when mounting the image natively by the kernel.
> >>> Using fuse with erofsfuse is fine.
> >>
> >> I think it's a weird issue with inplace decompression because you said
> >> it depends on the hardware.  In addition, with your dataset sadly I
> >> cannot reproduce on my local server (Xeon(R) CPU E5-2682 v4).
> >
> > As I feared. Bummer :(
> >
> >>
> >> What is the difference between these two machines? just different CPU =
or
> >> they have some other difference like different compliers?
> >
> > I fully and exclusively control both devices, and the setup is almost t=
he same.
> > Same Ubuntu version, kernel/compiler version.
> >
> > But as I said, on my laptop, the issue happens on kernels that someone
> > else (Canonical) built, so I don't think it matters.
>
> The only thing I could say is that the kernel side has optimized
> inplace decompression compared to fuse so that it will reuse the
> same buffer for decompression but with a safe margin (according to
> the current lz4 decompression implementation).  It shouldn't behave
> different just due to different CPUs.  Let me find more clues
> later, also maybe we should introduce a way for users to turn off
> this if needed.

Cool :)

I'm comfortable changing and building my own custom kernel for this
specific laptop. Feel free to ask me to try out some patches.

Thanks.

>
> Thanks,
> Gao Xiang
