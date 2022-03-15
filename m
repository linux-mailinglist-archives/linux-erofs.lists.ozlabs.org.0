Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEBF4D9C48
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 14:31:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KHvSZ1qX5z30Dk
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 00:31:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=KVWpVMvt;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::632;
 helo=mail-ej1-x632.google.com; envelope-from=mudongliangabcd@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=KVWpVMvt; dkim-atps=neutral
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KHvST4C0cz2yQC
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Mar 2022 00:31:20 +1100 (AEDT)
Received: by mail-ej1-x632.google.com with SMTP id yy13so41372420ejb.2
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Mar 2022 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LgZYqSdx3kMslzrtLD5lB/zfxM/+O4tI8gltW+rfTZU=;
 b=KVWpVMvt++DrdNgN6xWztR2tG7lkShIA329EZfk0aibDvgJJDSM0f55vYsGOG//q/+
 eImSFwEWReP/k9ENtzYGuTlj/X2kgc1Q30bGY3MnqgMfWvWTnuzK6nal97jMhw8aEYzw
 OTd+FB/jxGu59AkwiqZ8cD+zNofqur4mOzHYEwahN3NQojKykKmATKW5E7jhNGcZnPKT
 r0Fi3kDngJvHNrAUfqh49N6YTs0UdVFCqJbr033sU8qhEWRWQ+q9OB3dqTEYzZnsj3X9
 w8AdxXfe4aIDRscpxTCOR2DsUJ2NuDZF5kXMZQJzRGQXtNSYQ6FEk582PJaK5S9nPFsW
 rjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LgZYqSdx3kMslzrtLD5lB/zfxM/+O4tI8gltW+rfTZU=;
 b=MTQaLqhhahBUM3XAEoRb7lmHAsdSOvMuG/y/RW9KuvI53d2cC198/YvR01qa/x3ght
 D+XQoc6cjtdHQXEtLE5pGV7K27d0Fw7VcQH6Q3fGkPh19H1ykWoRroSrW4OI9IryGZzP
 GDoxH67tIXBL3zOKQD8zKOEkmW413QY8vIazrC/FqT+esTGwhI6k2GCY7iTPkGm46vQU
 /yLvyMS6uvu9qTJtRDxBLlBJfV52oRqpOKo8840srNMAcX1Z6nAL71y5fP6JWuwfVkeg
 78BQKB1mtYCMxe5iVcwuvrTdVf6a3HPFkY9go/KUBvBGBFQrxL8ORnzMQqJajz3F854j
 uoIA==
X-Gm-Message-State: AOAM531Ck+vS+TXOCAFHmfgTdBhm903ZEACGVBpiCBC5ywGR50iEpCuZ
 oUDQV8jPyPfPjATe+N4PFYwVxRSX06/BGPBzRoE=
X-Google-Smtp-Source: ABdhPJzcETTF1nWx3Yi8xHAMNYPnEF5dCz8U1aJXdwGDUsFZhk02nBx3LTkczqtIYKXj8g/eWvJ/wrIiq/CSbAtXuBg=
X-Received: by 2002:a17:907:9956:b0:6cf:cd25:c5a7 with SMTP id
 kl22-20020a170907995600b006cfcd25c5a7mr22415503ejc.635.1647351072526; Tue, 15
 Mar 2022 06:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220315075152.63789-1-dzm91@hust.edu.cn>
 <bca8f865-bc3e-44d7-7298-c2c7e8973580@gmail.com>
 <YjBwtqsEOZ5JbqvS@B-P7TQMD6M-0146.local>
 <8d832e7a-c8da-d2fa-571a-ea150b8deb1b@gmail.com>
 <CAD-N9QX2cajf0LXKcOji_Em26-0bw9wfhx7KDV_TLDWhgQ90hQ@mail.gmail.com>
 <YjCFz1dxVJZnF3M/@B-P7TQMD6M-0146.local>
 <CAD-N9QXp4sCKUY2zwJduOG22B0NaMGRLevn3FVMO0qOQFxO3Bg@mail.gmail.com>
In-Reply-To: <CAD-N9QXp4sCKUY2zwJduOG22B0NaMGRLevn3FVMO0qOQFxO3Bg@mail.gmail.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Tue, 15 Mar 2022 21:30:46 +0800
Message-ID: <CAD-N9QUERu_ZurAyACT+rKnPLp8ZFGDcifENLufT2sq1N9tzoQ@mail.gmail.com>
Subject: Re: [PATCH] fs: erofs: remember if kobject_init_and_add was done
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
Cc: Dongliang Mu <dzm91@hust.edu.cn>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 syzkaller <syzkaller@googlegroups.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Mar 15, 2022 at 8:44 PM Dongliang Mu <mudongliangabcd@gmail.com> wr=
ote:
>
> On Tue, Mar 15, 2022 at 8:26 PM Gao Xiang <hsiangkao@linux.alibaba.com> w=
rote:
> >
> > Hi Dongliang,
> >
> > On Tue, Mar 15, 2022 at 07:59:26PM +0800, Dongliang Mu wrote:
> > > On Tue, Mar 15, 2022 at 7:05 PM Huang Jianan <jnhuang95@gmail.com> wr=
ote:
> > > >
> > > > =E5=9C=A8 2022/3/15 18:55, Gao Xiang =E5=86=99=E9=81=93:
> > > > > On Tue, Mar 15, 2022 at 06:43:01PM +0800, Huang Jianan wrote:
> > > > >> =E5=9C=A8 2022/3/15 15:51, Dongliang Mu =E5=86=99=E9=81=93:
> > > > >>> From: Dongliang Mu <mudongliangabcd@gmail.com>
> > > > >>>
> > > > >>> Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'.=
 This bug
> > > > >>> is triggered by injecting fault in kobject_init_and_add of
> > > > >>> erofs_unregister_sysfs.
> > > > >>>
> > > > >>> Fix this by remembering if kobject_init_and_add is successful.
> > > > >>>
> > > > >>> Note that I've tested the patch and the crash does not occur an=
y more.
> > > > >>>
> > > > >>> Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > > >>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > > >>> ---
> > > > >>>    fs/erofs/internal.h | 1 +
> > > > >>>    fs/erofs/sysfs.c    | 9 ++++++---
> > > > >>>    2 files changed, 7 insertions(+), 3 deletions(-)
> > > > >>>
> > > > >>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > > > >>> index 5aa2cf2c2f80..9e20665e3f68 100644
> > > > >>> --- a/fs/erofs/internal.h
> > > > >>> +++ b/fs/erofs/internal.h
> > > > >>> @@ -144,6 +144,7 @@ struct erofs_sb_info {
> > > > >>>     u32 feature_incompat;
> > > > >>>     /* sysfs support */
> > > > >>> +   bool s_sysfs_inited;
> > > > >> Hi Dongliang,
> > > > >>
> > > > >> How about using sbi->s_kobj.state_in_sysfs to avoid adding a ext=
ra member in
> > > > >> sbi ?
> > > > > Ok, I have no tendency of these (I'm fine with either ways).
> > > > > I've seen some usage like:
> > > > >
> > > > > static inline int device_is_registered(struct device *dev)
> > > > > {
> > > > >          return dev->kobj.state_in_sysfs;
> > > > > }
> > > > >
> > > > > But I'm still not sure if we need to rely on such internal
> > > > > interface.. More thoughts?
> > > >
> > > > Yeah... It seems that it is better to use some of the interfaces
> > > > provided by kobject,
> > > > otherwise we should still maintain this state in sbi.
> > > >
> > >
> > > I am fine with either way. Let me know if you reach to an agreement.
> >
> > If you have time, would you mind sending another patch by using
> > state_in_sysfs? I'd like to know Chao's perference later, and
> > apply one of them...
>
> OK, let me test this patch in my local workspace. If it works, I will
> send it later.

Hi Gao Xiang,

I've sent another patch. Please double-check.

>
> >
> > Thanks,
> > Gao Xiang
> >
