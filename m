Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E614E199C
	for <lists+linux-erofs@lfdr.de>; Sun, 20 Mar 2022 05:19:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KLkzt0MH3z2yK3
	for <lists+linux-erofs@lfdr.de>; Sun, 20 Mar 2022 15:19:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=CUhqyE9R;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62c;
 helo=mail-ej1-x62c.google.com; envelope-from=mudongliangabcd@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=CUhqyE9R; dkim-atps=neutral
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KLkzp4PBCz2yg5
 for <linux-erofs@lists.ozlabs.org>; Sun, 20 Mar 2022 15:19:49 +1100 (AEDT)
Received: by mail-ej1-x62c.google.com with SMTP id d10so23966552eje.10
 for <linux-erofs@lists.ozlabs.org>; Sat, 19 Mar 2022 21:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ThmAHSwk/7ko3WSXWM03wBAJ2ziyTZM2hGOwlAVmV3E=;
 b=CUhqyE9RpibP0n/dCIwaRSyBSGxH9Lqdejw1SUhMkc1SpTCwph02RbPrQ+I/2cevwS
 9FFFQFqonBAlGnCFuvj2d4DTtfkzTmn3viGjrimp2EZxxg5hybnRZlw0I3rxs5XkLg4b
 JJ6f6Hu5gEeVRMZcvfZbl5cLzkQYtb8UtlsbgdAslYKufXCmaVmIM3jr6PaOip3n9KZX
 NctGeAfFZPNCfSIvPqfbiIBf9CIJntnWG0ZjTbRCa/RZxVuYS7Pe8d+KCg1iQt19N3vk
 KajWfWfdPIYGM4FWjZNGoB/b+NNmJJvCSnwtCYjsC+4rYTyZynPmpXhV7S/Ogbh7/6Do
 VO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ThmAHSwk/7ko3WSXWM03wBAJ2ziyTZM2hGOwlAVmV3E=;
 b=M3u7PNcp5pM45VWQPRo37Qwv4VM+5haSOqQIi33rLEGWR5dzb0+IffK/B1cxRJGeyF
 f4JJpWz0uIRCdQDScbOApVs7Ek6L/NYqNoygVVUzfsbIrET6Mqimsl7ZnPU/fBrUnmS4
 P27LC+2gvvvii77u5Pb4jnmAX+eOAJpmdJ1OCkFkbVBVutCIsxBm/nQlSvQMgEdzbtHt
 1Hr/m9rKzBPdqXQZ/0p1XiJxGtzKnYx/6akWShq3UKrwAH1qTpJ1/Udo5PUHInzd3pXW
 e6I6FJcR2GBWFPKg1expjAUB7jZ58UJskEM1JqMNE7FLws5Jd6WRn2ENH9lBY1g/ULJq
 6WZA==
X-Gm-Message-State: AOAM531BtuQze9ih4m77T2lPlC4VPZ2RhH5FiH8Nu6FIZ+jlhj7DOxqX
 ZlXJenGH2XZpLILawT55/jwMGabOeAETtvosijU=
X-Google-Smtp-Source: ABdhPJziOumFLAwYEoKfif2LckyWSl5LuX77kfLGW4pbcJ62NovQKgrhjk+uXemaFXZ4hWB75vvKgdoXJnsEAO+cpdY=
X-Received: by 2002:a17:906:3a15:b0:6cf:ea4e:a1cc with SMTP id
 z21-20020a1709063a1500b006cfea4ea1ccmr15910082eje.753.1647749981806; Sat, 19
 Mar 2022 21:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000dda2f905da80c934@google.com>
 <00000000000009cf1e05da85bb31@google.com>
 <CAMZfGtWL-2+en7=FKBoPUwq1FMGYYqZCvB1jmJ7fhiQc1XX4oQ@mail.gmail.com>
In-Reply-To: <CAMZfGtWL-2+en7=FKBoPUwq1FMGYYqZCvB1jmJ7fhiQc1XX4oQ@mail.gmail.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Sun, 20 Mar 2022 12:19:15 +0800
Message-ID: <CAD-N9QU1CDatEhzBzFL_GMB5qcCJgZ+wfmK8ND_=7ki9pKJ-Cw@mail.gmail.com>
Subject: Re: [syzbot] WARNING: kobject bug in erofs_unregister_sysfs
To: Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 LKML <linux-kernel@vger.kernel.org>,
 syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Mar 19, 2022 at 10:21 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Sat, Mar 19, 2022 at 6:33 AM syzbot
> <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this issue to:
> >
> > commit 2768c206f2c3e95c0e5cf2e7f846103fda7cd429
> > Author: Muchun Song <songmuchun@bytedance.com>
> > Date:   Thu Mar 3 01:15:36 2022 +0000
> >
> >     mm: list_lru: allocate list_lru_one only when needed
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1495694d700000
> > start commit:   91265a6da44d Add linux-next specific files for 20220303
> > git tree:       linux-next
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=1695694d700000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1295694d700000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f05ba4652c0471416eaf
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137f17d9700000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114ebabd700000
> >
> > Reported-by: syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com
> > Fixes: 2768c206f2c3 ("mm: list_lru: allocate list_lru_one only when needed")
>
> Does this patch [1] fix the issue? If yes, I am confused why the Fixes tag
> should be the commit 2768c206f2c3?  What am I missing here?

Sometimes syzkaller bisection may make mistakes. Please ignore it.

>
> [1] https://lore.kernel.org/r/20220315132814.12332-1-dzm91@hust.edu.cn
>
> Thanks.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CAMZfGtWL-2%2Ben7%3DFKBoPUwq1FMGYYqZCvB1jmJ7fhiQc1XX4oQ%40mail.gmail.com.
