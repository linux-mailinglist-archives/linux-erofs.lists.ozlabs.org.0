Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DC44E20CA
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Mar 2022 07:55:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KMQPP68Dwz30J9
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Mar 2022 17:55:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1647845753;
	bh=Wc7ThkaLJZR7210QtzX2oyJpNFvUx6zmHKI3fEwxV1k=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=YZ/hCEKRae7Dye9y2j3zKcfzcR3IL6dVGzoJqaZFiTaAoAtKwnGPWFd4lTjcyJDfX
	 EhXbsGIrmG/6HoPFB5aEGSnnT6/rn9K8HfGecXq10k9PxTcLmLZcAoYZCX4Zz1mwzR
	 pFQV57qu+6kYXskBo+ElhG1u6RAGmxTSgoWp13QyYP2vMTGS+Rn1Rau0I2ysDhFCrX
	 WCt4p1NcGgppzAvdIkaUEt+lM8QAaB7Y0ycCUWibB9IGi56RHyWDKMXoq3TJxfzRNr
	 b7+RoIkcNXCA5DgsGaAJtN0kcsZtLezyf/W4URzforOqdXSNEsrMewUAjfAcuPOKfa
	 /ajOFwm5UvvNg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::331;
 helo=mail-ot1-x331.google.com; envelope-from=dvyukov@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=BvK9/xmg; dkim-atps=neutral
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KMQPJ2K98z2xm1
 for <linux-erofs@lists.ozlabs.org>; Mon, 21 Mar 2022 17:55:46 +1100 (AEDT)
Received: by mail-ot1-x331.google.com with SMTP id
 d15-20020a05683018ef00b005b2304fdeecso9933413otf.1
 for <linux-erofs@lists.ozlabs.org>; Sun, 20 Mar 2022 23:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wc7ThkaLJZR7210QtzX2oyJpNFvUx6zmHKI3fEwxV1k=;
 b=yG9f6oIX9Thtgn6CWv5x2nnyxD15gimZBeXA9AJpTjrDbSGeDsKPUEJ1qrkq8rq50N
 xuqxk9W4X3tt4uWmANP1ODPlrCMvMqel26BmgQTIZdAkwF2uB4cffj/x/EIrsJiVvKZV
 aVTBNG6JMdU73MuIEOlOdvpGR29a7TYqlwGRxokZ3LQyO0C3XlO3ghAksooYfqw1SOHY
 ZYwlxRFsO4c8mx7qjoyo7BKOSENZRTez3uhSYFwmFGL+rvCh1zSJ0oxH6FA5Dak5d8UP
 fBLD414PDVRF0kh0PsuWjbL0qozxnXaBeGqFZaY+PCP7exjbD5hIs8YrGbcsQ71LU+GB
 JWCQ==
X-Gm-Message-State: AOAM533aKa9BUrG57VQC82hip3PCgRCpAs3JK2mjmI8X/cvEkEUku0yp
 pIqbydss5qnZnJyBWaaHcVlXesZBEtb49hAgXXxuWw==
X-Google-Smtp-Source: ABdhPJxs66SQ7AlLchmppjScFi0PWxUVPW97mA7V9Pe6BdZ1UrrvgXFOuKMfA3wO/VHOJxyOXq7T8GsAw6vHTAzTKbQ=
X-Received: by 2002:a05:6830:23b6:b0:5b2:4ac0:9130 with SMTP id
 m22-20020a05683023b600b005b24ac09130mr7439221ots.196.1647845741145; Sun, 20
 Mar 2022 23:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000dda2f905da80c934@google.com>
 <00000000000009cf1e05da85bb31@google.com>
 <CAMZfGtWL-2+en7=FKBoPUwq1FMGYYqZCvB1jmJ7fhiQc1XX4oQ@mail.gmail.com>
 <CAD-N9QU1CDatEhzBzFL_GMB5qcCJgZ+wfmK8ND_=7ki9pKJ-Cw@mail.gmail.com>
In-Reply-To: <CAD-N9QU1CDatEhzBzFL_GMB5qcCJgZ+wfmK8ND_=7ki9pKJ-Cw@mail.gmail.com>
Date: Mon, 21 Mar 2022 07:55:29 +0100
Message-ID: <CACT4Y+Yh7t=wBftzCA9zxtVFKFiYFurBOq-5GFe1Le3W5ujOPw@mail.gmail.com>
Subject: Re: [syzbot] WARNING: kobject bug in erofs_unregister_sysfs
To: Dongliang Mu <mudongliangabcd@gmail.com>
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
From: Dmitry Vyukov via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Dmitry Vyukov <dvyukov@google.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 LKML <linux-kernel@vger.kernel.org>,
 syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>,
 Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, 20 Mar 2022 at 05:19, Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Sat, Mar 19, 2022 at 10:21 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > On Sat, Mar 19, 2022 at 6:33 AM syzbot
> > <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot has bisected this issue to:
> > >
> > > commit 2768c206f2c3e95c0e5cf2e7f846103fda7cd429
> > > Author: Muchun Song <songmuchun@bytedance.com>
> > > Date:   Thu Mar 3 01:15:36 2022 +0000
> > >
> > >     mm: list_lru: allocate list_lru_one only when needed
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1495694d700000
> > > start commit:   91265a6da44d Add linux-next specific files for 20220303
> > > git tree:       linux-next
> > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=1695694d700000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1295694d700000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=f05ba4652c0471416eaf
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137f17d9700000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114ebabd700000
> > >
> > > Reported-by: syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com
> > > Fixes: 2768c206f2c3 ("mm: list_lru: allocate list_lru_one only when needed")
> >
> > Does this patch [1] fix the issue? If yes, I am confused why the Fixes tag
> > should be the commit 2768c206f2c3?  What am I missing here?
>
> Sometimes syzkaller bisection may make mistakes. Please ignore it.
>
> >
> > [1] https://lore.kernel.org/r/20220315132814.12332-1-dzm91@hust.edu.cn
>

Let's tell syzbot so that it reports new bugs in future:

#syz fix: fs: erofs: add sanity check for kobject in erofs_unregister_sysfs
