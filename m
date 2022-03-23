Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE2D4E4AA8
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Mar 2022 02:55:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KNWf00wk7z3000
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Mar 2022 12:55:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UDkkIC8q;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=UDkkIC8q; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KNWdt0ydnz2xF8
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Mar 2022 12:55:29 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A54296148C;
 Wed, 23 Mar 2022 01:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89537C340EC;
 Wed, 23 Mar 2022 01:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648000524;
 bh=kSCpaZcs6hkCplY9uGNsf2FJl2K9ZAY3Artf7nx/gh4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UDkkIC8qCfqNXvOhBliX16ZFmvwqMnHs7g//69mXSFegupyNnnUm7oZEWXPQVom0d
 NUN/kGRbOMAx8Q5h25oh0rhmk2ybJ+VhqIoHiP3Pg6eEhIjoREiGcpbcf5bxsX6UWb
 VgqqWSB1b2y5GKRaLzoSfNVFhX9DH5nye3HogFr+vAaQ84OFMSOrEqjxyowMUTSVpv
 SFL90xpWi0hjORb+xyhfmMVSpVLXGvvVjU7hNmT7OeIuIEGTWrjLU1Pdj7iIDpS+S2
 3nnKwZruLijlRN7Vp+CjxIrVLV9MR0YJsZ5UzpQ6R9ln36C2+bG73dDx35ctjTRFJB
 GVEY4g2Pw/0yQ==
Date: Wed, 23 Mar 2022 09:54:58 +0800
From: Gao Xiang <xiang@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [syzbot] WARNING: kobject bug in erofs_unregister_sysfs
Message-ID: <Yjp98n5sxzfu2q36@debian>
Mail-Followup-To: Dmitry Vyukov <dvyukov@google.com>,
 Dongliang Mu <mudongliangabcd@gmail.com>,
 Muchun Song <songmuchun@bytedance.com>,
 syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000dda2f905da80c934@google.com>
 <00000000000009cf1e05da85bb31@google.com>
 <CAMZfGtWL-2+en7=FKBoPUwq1FMGYYqZCvB1jmJ7fhiQc1XX4oQ@mail.gmail.com>
 <CAD-N9QU1CDatEhzBzFL_GMB5qcCJgZ+wfmK8ND_=7ki9pKJ-Cw@mail.gmail.com>
 <CACT4Y+Yh7t=wBftzCA9zxtVFKFiYFurBOq-5GFe1Le3W5ujOPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Yh7t=wBftzCA9zxtVFKFiYFurBOq-5GFe1Le3W5ujOPw@mail.gmail.com>
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
 Dongliang Mu <mudongliangabcd@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>,
 Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Mar 21, 2022 at 07:55:29AM +0100, Dmitry Vyukov wrote:
> On Sun, 20 Mar 2022 at 05:19, Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> >
> > On Sat, Mar 19, 2022 at 10:21 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > On Sat, Mar 19, 2022 at 6:33 AM syzbot
> > > <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com> wrote:
> > > >
> > > > syzbot has bisected this issue to:
> > > >
> > > > commit 2768c206f2c3e95c0e5cf2e7f846103fda7cd429
> > > > Author: Muchun Song <songmuchun@bytedance.com>
> > > > Date:   Thu Mar 3 01:15:36 2022 +0000
> > > >
> > > >     mm: list_lru: allocate list_lru_one only when needed
> > > >
> > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1495694d700000
> > > > start commit:   91265a6da44d Add linux-next specific files for 20220303
> > > > git tree:       linux-next
> > > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=1695694d700000
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1295694d700000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=f05ba4652c0471416eaf
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137f17d9700000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114ebabd700000
> > > >
> > > > Reported-by: syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com
> > > > Fixes: 2768c206f2c3 ("mm: list_lru: allocate list_lru_one only when needed")
> > >
> > > Does this patch [1] fix the issue? If yes, I am confused why the Fixes tag
> > > should be the commit 2768c206f2c3?  What am I missing here?
> >
> > Sometimes syzkaller bisection may make mistakes. Please ignore it.
> >
> > >
> > > [1] https://lore.kernel.org/r/20220315132814.12332-1-dzm91@hust.edu.cn
> >
> 
> Let's tell syzbot so that it reports new bugs in future:
> 
> #syz fix: fs: erofs: add sanity check for kobject in erofs_unregister_sysfs

Thanks! The fix has been landed upstream now.

Thanks,
Gao Xiang
