Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0684DE584
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Mar 2022 04:46:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KL6HZ3mkkz30R6
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Mar 2022 14:46:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lMpLZWX4;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lMpLZWX4; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KL6HR3Pjnz30J7
 for <linux-erofs@lists.ozlabs.org>; Sat, 19 Mar 2022 14:46:11 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1C2236145C;
 Sat, 19 Mar 2022 03:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AA0C340E8;
 Sat, 19 Mar 2022 03:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647661566;
 bh=G+NuDXG6v+YZYRYM7T7C+PGBCWMAjEc/P2kRROv+lq0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lMpLZWX4oi1Q1NT3X640UADThSxz6H7jK+ycrRA1WPcTO+/hMpGS5yjnVzDcY93Kc
 /1wOYTJa4/UTduuHA2qiDM4NOBSYkBbVRVdfx/0EyaigMqw3IMIw49Nfq/lNbO39lt
 slcRDM/uzUknfMVDag7ugGhtl0MZqnC4x8AVXbBXibmjpcpNj1CF6kms5gzTnZZc0h
 V00Y/PLL4nP9K04vUGnmUsGDEvKVi0SkpCVmalVdDJTISv7mC/BxLbOr+itzB5h4J3
 474oG2EdNH1tCpoLGLUDcsf0nCEQBA9keHI+VG/o2UyVbVAmHatsaQgRzV2VBBHOij
 mVLBneZq4I6JQ==
Date: Sat, 19 Mar 2022 11:45:12 +0800
From: Gao Xiang <xiang@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Subject: Re: [syzbot] WARNING: kobject bug in erofs_unregister_sysfs
Message-ID: <YjVRyIpIUN1jB8iK@debian>
Mail-Followup-To: Muchun Song <songmuchun@bytedance.com>,
 syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, chao@kernel.org,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <000000000000dda2f905da80c934@google.com>
 <00000000000009cf1e05da85bb31@google.com>
 <CAMZfGtWL-2+en7=FKBoPUwq1FMGYYqZCvB1jmJ7fhiQc1XX4oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMZfGtWL-2+en7=FKBoPUwq1FMGYYqZCvB1jmJ7fhiQc1XX4oQ@mail.gmail.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, syzkaller-bugs@googlegroups.com,
 LKML <linux-kernel@vger.kernel.org>,
 syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Mar 19, 2022 at 10:19:12AM +0800, Muchun Song wrote:
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
> 
> [1] https://lore.kernel.org/r/20220315132814.12332-1-dzm91@hust.edu.cn

I think it was an incorrect bisect so we could just ignore it.
The fix is already pending for the next merge window.

Thanks,
Gao Xiang

> 
> Thanks.
