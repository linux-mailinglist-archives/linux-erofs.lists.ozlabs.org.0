Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284D14D9ACB
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 13:00:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KHsRF5y2Nz30FZ
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Mar 2022 23:00:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Jc9BG6eb;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52f;
 helo=mail-ed1-x52f.google.com; envelope-from=mudongliangabcd@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=Jc9BG6eb; dkim-atps=neutral
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KHsR70TPbz2yfZ
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Mar 2022 23:00:00 +1100 (AEDT)
Received: by mail-ed1-x52f.google.com with SMTP id g3so23901392edu.1
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Mar 2022 05:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0IagKtBfxcpixmoMTBMoMWqgkvRfAgiw9IXMcNoH3GM=;
 b=Jc9BG6ebO65hDOwsgATtbOXJvK1Nwh0MvD9yTfeAlBn09fSSqU5uLdc0yYMD/CzYjF
 JnA11+NIRsQUEwt9kiwjEFDlZwfCrWxDFwUDSNYSXIhoDCPaIyZIKuL27gkfcOFZiCQm
 z9FBxmOYVeOM0ikZxPziEZMZ8mdLjim6v/ApfuIpGgWeDuBUmdY0DId/ie9x+DfpIGcg
 nPPGw6ALMItE3tm6tnPloiV4VNVxqYBmbjS9zwf4NDHUirNgj/B5SEw3QIF2tMCvKZ8k
 oMcOJ+Xuc38ORVemUSrVid3OJZTTygqvkM7UeN9391ASp0+4BaJ2h//dGllAYKUp6FA3
 TutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0IagKtBfxcpixmoMTBMoMWqgkvRfAgiw9IXMcNoH3GM=;
 b=5AdYrod4hEugKo5g+mwyR2/yWEUOaWFKHiT8s/mR8pd9taRV4OCHOCGziFi0EwhDbm
 1NGGh0e0QpcJowq23Wgrg8/AWBcGd8DyYO1R2SqXu9jZUNNmtlF6nfbWZOMUmMe37nyY
 ZLlZL0JS4kvxXPEuhOuGeL0LiNrjhvuAjFSoFrlCa5twIXu0NrRdtXsOjnViv6RbtBvv
 QVorpgUoOQc60oSvDcl4iWxlsy00jt5/k2NyA7hcc/I8nIKhuGose5bSbhjzwy6lrff6
 Po/TMDZYYK/NM+cYv4wLbr424s5US4MwflCfYHM+siIw8BnZWzPGa8Jd5c1a53cVfEjS
 xtSw==
X-Gm-Message-State: AOAM533IdVHzQDCXSm83D6d49g+EjN59nLNfHkUTOFlHu4LNAT0Dmilg
 rLPt4Xlo+2FiEZtWrwG+zcNioANsSRXnXiQ0fkA=
X-Google-Smtp-Source: ABdhPJw3vTWKpyc85/05ZqjGiVLTuKEo7jyXrBXqyusgxTgudMfdBBD+qF4ycHQkWAL3HNHktvM2aSHO8cd+cELAabI=
X-Received: by 2002:a05:6402:5cb:b0:415:e04a:5230 with SMTP id
 n11-20020a05640205cb00b00415e04a5230mr25066821edx.352.1647345595723; Tue, 15
 Mar 2022 04:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220315075152.63789-1-dzm91@hust.edu.cn>
 <bca8f865-bc3e-44d7-7298-c2c7e8973580@gmail.com>
 <YjBwtqsEOZ5JbqvS@B-P7TQMD6M-0146.local>
 <8d832e7a-c8da-d2fa-571a-ea150b8deb1b@gmail.com>
In-Reply-To: <8d832e7a-c8da-d2fa-571a-ea150b8deb1b@gmail.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Tue, 15 Mar 2022 19:59:26 +0800
Message-ID: <CAD-N9QX2cajf0LXKcOji_Em26-0bw9wfhx7KDV_TLDWhgQ90hQ@mail.gmail.com>
Subject: Re: [PATCH] fs: erofs: remember if kobject_init_and_add was done
To: Huang Jianan <jnhuang95@gmail.com>
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
 syzkaller <syzkaller@googlegroups.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Mar 15, 2022 at 7:05 PM Huang Jianan <jnhuang95@gmail.com> wrote:
>
> =E5=9C=A8 2022/3/15 18:55, Gao Xiang =E5=86=99=E9=81=93:
> > On Tue, Mar 15, 2022 at 06:43:01PM +0800, Huang Jianan wrote:
> >> =E5=9C=A8 2022/3/15 15:51, Dongliang Mu =E5=86=99=E9=81=93:
> >>> From: Dongliang Mu <mudongliangabcd@gmail.com>
> >>>
> >>> Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. This =
bug
> >>> is triggered by injecting fault in kobject_init_and_add of
> >>> erofs_unregister_sysfs.
> >>>
> >>> Fix this by remembering if kobject_init_and_add is successful.
> >>>
> >>> Note that I've tested the patch and the crash does not occur any more=
.
> >>>
> >>> Reported-by: syzkaller <syzkaller@googlegroups.com>
> >>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> >>> ---
> >>>    fs/erofs/internal.h | 1 +
> >>>    fs/erofs/sysfs.c    | 9 ++++++---
> >>>    2 files changed, 7 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> >>> index 5aa2cf2c2f80..9e20665e3f68 100644
> >>> --- a/fs/erofs/internal.h
> >>> +++ b/fs/erofs/internal.h
> >>> @@ -144,6 +144,7 @@ struct erofs_sb_info {
> >>>     u32 feature_incompat;
> >>>     /* sysfs support */
> >>> +   bool s_sysfs_inited;
> >> Hi Dongliang,
> >>
> >> How about using sbi->s_kobj.state_in_sysfs to avoid adding a extra mem=
ber in
> >> sbi ?
> > Ok, I have no tendency of these (I'm fine with either ways).
> > I've seen some usage like:
> >
> > static inline int device_is_registered(struct device *dev)
> > {
> >          return dev->kobj.state_in_sysfs;
> > }
> >
> > But I'm still not sure if we need to rely on such internal
> > interface.. More thoughts?
>
> Yeah... It seems that it is better to use some of the interfaces
> provided by kobject,
> otherwise we should still maintain this state in sbi.
>

I am fine with either way. Let me know if you reach to an agreement.

> Thanks,
> Jianan
>
> > Thanks,
> > Gao Xiang
> >> Thanks,
> >> Jianan
> >>
> >>>     struct kobject s_kobj;          /* /sys/fs/erofs/<devname> */
> >>>     struct completion s_kobj_unregister;
> >>>    };
> >>> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> >>> index dac252bc9228..2b48a4df19b4 100644
> >>> --- a/fs/erofs/sysfs.c
> >>> +++ b/fs/erofs/sysfs.c
> >>> @@ -209,6 +209,7 @@ int erofs_register_sysfs(struct super_block *sb)
> >>>                                "%s", sb->s_id);
> >>>     if (err)
> >>>             goto put_sb_kobj;
> >>> +   sbi->s_sysfs_inited =3D true;
> >>>     return 0;
> >>>    put_sb_kobj:
> >>> @@ -221,9 +222,11 @@ void erofs_unregister_sysfs(struct super_block *=
sb)
> >>>    {
> >>>     struct erofs_sb_info *sbi =3D EROFS_SB(sb);
> >>> -   kobject_del(&sbi->s_kobj);
> >>> -   kobject_put(&sbi->s_kobj);
> >>> -   wait_for_completion(&sbi->s_kobj_unregister);
> >>> +   if (sbi->s_sysfs_inited) {
> >>> +           kobject_del(&sbi->s_kobj);
> >>> +           kobject_put(&sbi->s_kobj);
> >>> +           wait_for_completion(&sbi->s_kobj_unregister);
> >>> +   }
> >>>    }
> >>>    int __init erofs_init_sysfs(void)
>
