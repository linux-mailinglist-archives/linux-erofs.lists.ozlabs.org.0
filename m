Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E253A4D9B76
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 13:44:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KHtQd61MVz30Dp
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 23:44:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=BQBqXj/R;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52d;
 helo=mail-ed1-x52d.google.com; envelope-from=mudongliangabcd@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=BQBqXj/R; dkim-atps=neutral
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KHtQY4t6Jz2yHp
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Mar 2022 23:44:35 +1100 (AEDT)
Received: by mail-ed1-x52d.google.com with SMTP id w4so24017661edc.7
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Mar 2022 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rfq986Ngid7vqyFyvLMRUqbrd21pr/MIsn9OsbU3BVY=;
 b=BQBqXj/R4v3UTpbm4iKkbLClg8I2FnpJHbtUjcL2lpt98dawcMO3hEx1UsQiTwZ01t
 CErIuNFN4HUchNhZ6jVC8mAUaiGqyxkiCSvScNgnWUIOI53ggrCUnBv5z+b1dAsRUMDw
 9oJDsQRtvJRgrvZlZqE7S7p6xC58mhllZ/yITHLGygpAT8rd8la7gAcoIvBWgGOStRv+
 QMmIdjfBdYUJmepNsnKU66MPk5R2RyQt9dWF5tzQXrLkWpleTlULvb3lvJruh1bUWMIj
 adDX5tNYky9uhRzkpVbGT947rIeEIZYaEE/d4j1KPWe4pixLmNNteBKaI7ksp+lAXnAh
 9Vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rfq986Ngid7vqyFyvLMRUqbrd21pr/MIsn9OsbU3BVY=;
 b=D11ar24hObdH8hNeQVrQ7ZTINMXr8gtDUzYjFncsg+iPitEqOUXIQn4ScqG8blo7b+
 w+DmGiaSYvdvHegszJnt7hQ8Z46E3zJOWKJEah8g1XJYrKOAcvhb8QDIYlbxCmAZBPar
 aDM0S+gHrAfZJ7bM9pB0Nfs473c9O3S2a8YQ3/KFAN4dGAOq3X4zDrW0dzt87XE6a0xy
 UdZxexPd/ZoQ+eUPOzuZaPMEKZ1yk1ZggjO+85tlNK+s5yFLawXlQDEjqHN5Ksv8A+4q
 cnXepKg2Aha8i0J00/qGkA746Shuo46vVBdGzSBz3TdStgMcMZTPUHrvBofQAxlMwtyK
 vNQg==
X-Gm-Message-State: AOAM533yrHLa7NuYD9t6EiLH/Jqi9gMOZ1S90IPugODjUetTUKawpIYI
 DMk9o6/U2fLM+8CbuHn/WXdEJJ0JKNukIE42VIwbsrbX6/g=
X-Google-Smtp-Source: ABdhPJyNoXfe2mx/IZX4LuxqBOHPWULEAUWiyJKBy7+WD0cGObLgTjyqXIcrehNhAw5Um1afnYkXW1WLHdXqKmw5bt0=
X-Received: by 2002:a05:6402:50c9:b0:418:7fbc:14ee with SMTP id
 h9-20020a05640250c900b004187fbc14eemr10098729edb.53.1647348271321; Tue, 15
 Mar 2022 05:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220315075152.63789-1-dzm91@hust.edu.cn>
 <bca8f865-bc3e-44d7-7298-c2c7e8973580@gmail.com>
 <YjBwtqsEOZ5JbqvS@B-P7TQMD6M-0146.local>
 <8d832e7a-c8da-d2fa-571a-ea150b8deb1b@gmail.com>
 <CAD-N9QX2cajf0LXKcOji_Em26-0bw9wfhx7KDV_TLDWhgQ90hQ@mail.gmail.com>
 <YjCFz1dxVJZnF3M/@B-P7TQMD6M-0146.local>
In-Reply-To: <YjCFz1dxVJZnF3M/@B-P7TQMD6M-0146.local>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Tue, 15 Mar 2022 20:44:04 +0800
Message-ID: <CAD-N9QXp4sCKUY2zwJduOG22B0NaMGRLevn3FVMO0qOQFxO3Bg@mail.gmail.com>
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

On Tue, Mar 15, 2022 at 8:26 PM Gao Xiang <hsiangkao@linux.alibaba.com> wro=
te:
>
> Hi Dongliang,
>
> On Tue, Mar 15, 2022 at 07:59:26PM +0800, Dongliang Mu wrote:
> > On Tue, Mar 15, 2022 at 7:05 PM Huang Jianan <jnhuang95@gmail.com> wrot=
e:
> > >
> > > =E5=9C=A8 2022/3/15 18:55, Gao Xiang =E5=86=99=E9=81=93:
> > > > On Tue, Mar 15, 2022 at 06:43:01PM +0800, Huang Jianan wrote:
> > > >> =E5=9C=A8 2022/3/15 15:51, Dongliang Mu =E5=86=99=E9=81=93:
> > > >>> From: Dongliang Mu <mudongliangabcd@gmail.com>
> > > >>>
> > > >>> Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. T=
his bug
> > > >>> is triggered by injecting fault in kobject_init_and_add of
> > > >>> erofs_unregister_sysfs.
> > > >>>
> > > >>> Fix this by remembering if kobject_init_and_add is successful.
> > > >>>
> > > >>> Note that I've tested the patch and the crash does not occur any =
more.
> > > >>>
> > > >>> Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > >>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > >>> ---
> > > >>>    fs/erofs/internal.h | 1 +
> > > >>>    fs/erofs/sysfs.c    | 9 ++++++---
> > > >>>    2 files changed, 7 insertions(+), 3 deletions(-)
> > > >>>
> > > >>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > > >>> index 5aa2cf2c2f80..9e20665e3f68 100644
> > > >>> --- a/fs/erofs/internal.h
> > > >>> +++ b/fs/erofs/internal.h
> > > >>> @@ -144,6 +144,7 @@ struct erofs_sb_info {
> > > >>>     u32 feature_incompat;
> > > >>>     /* sysfs support */
> > > >>> +   bool s_sysfs_inited;
> > > >> Hi Dongliang,
> > > >>
> > > >> How about using sbi->s_kobj.state_in_sysfs to avoid adding a extra=
 member in
> > > >> sbi ?
> > > > Ok, I have no tendency of these (I'm fine with either ways).
> > > > I've seen some usage like:
> > > >
> > > > static inline int device_is_registered(struct device *dev)
> > > > {
> > > >          return dev->kobj.state_in_sysfs;
> > > > }
> > > >
> > > > But I'm still not sure if we need to rely on such internal
> > > > interface.. More thoughts?
> > >
> > > Yeah... It seems that it is better to use some of the interfaces
> > > provided by kobject,
> > > otherwise we should still maintain this state in sbi.
> > >
> >
> > I am fine with either way. Let me know if you reach to an agreement.
>
> If you have time, would you mind sending another patch by using
> state_in_sysfs? I'd like to know Chao's perference later, and
> apply one of them...

OK, let me test this patch in my local workspace. If it works, I will
send it later.

>
> Thanks,
> Gao Xiang
>
