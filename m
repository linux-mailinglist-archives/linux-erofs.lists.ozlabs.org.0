Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2763C438FD2
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Oct 2021 08:59:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hd5Rt0XtBz2xtP
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Oct 2021 17:59:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hd5Rm01G5z2xX5
 for <linux-erofs@lists.ozlabs.org>; Mon, 25 Oct 2021 17:59:43 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UtYQvGX_1635145164; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UtYQvGX_1635145164) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 25 Oct 2021 14:59:25 +0800
Date: Mon, 25 Oct 2021 14:59:23 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [syzbot] WARNING in z_erofs_lz4_decompress
Message-ID: <YXZVy1cqr4o6YOHT@B-P7TQMD6M-0146.local>
References: <000000000000b3586105cf0ff45e@google.com>
 <YXX3e1i/f2uvMDm0@B-P7TQMD6M-0146.local>
 <CACT4Y+bV-Fe+nX2pWf2+M0mwvQYM394uAAo2efdDqnvCWxyxKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+bV-Fe+nX2pWf2+M0mwvQYM394uAAo2efdDqnvCWxyxKA@mail.gmail.com>
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
Cc: syzbot <syzbot+d8aaffc3719597e8cfb4@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Dmitry,

On Mon, Oct 25, 2021 at 08:55:51AM +0200, Dmitry Vyukov wrote:
> On Mon, 25 Oct 2021 at 02:17, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >
> > Hi,
> >
> > On Sat, Oct 23, 2021 at 07:25:20PM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    60e8840126bd Add linux-next specific files for 20211018
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=125932af300000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=4bd44cafcda7632e
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=d8aaffc3719597e8cfb4
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+d8aaffc3719597e8cfb4@syzkaller.appspotmail.com
> > >
> > > erofs: (device loop4): z_erofs_lz4_decompress_mem: failed to decompress -4100 in[4096, 0] out[9000]
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 1 PID: 9895 at fs/erofs/decompressor.c:230 z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:227 [inline]
> > > WARNING: CPU: 1 PID: 9895 at fs/erofs/decompressor.c:230 z_erofs_lz4_decompress+0x841/0x1400 fs/erofs/decompressor.c:289
> >
> > If you fuzz compressed data, that is what you'd expect..
> 
> Hi Gao,
> 
> If you mean this is not a kernel bug, then the code should not use WARN.
> WARN if for kernel bugs and is recognized as such by all testing
> systems and humans.
> 
> Please fix it to use pr_err. If it's intended for the end user, pr_err
> can also give a meaningful message and no stack trace (which is I
> assume only huge clutter in this case).

Thanks, I will submit a patch to address that.

Thanks,
Gao Xiang

> 
> 
> > Thanks,
> > Gao Xiang
> >
> > > Modules linked in:
> > > CPU: 1 PID: 9895 Comm: kworker/u5:3 Not tainted 5.15.0-rc5-next-20211018-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > Workqueue: erofs_unzipd z_erofs_decompressqueue_work
> > > RIP: 0010:z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:230 [inline]
> > > RIP: 0010:z_erofs_lz4_decompress+0x841/0x1400 fs/erofs/decompressor.c:289
> > > Code: e9 03 80 3c 11 00 0f 85 8c 0a 00 00 41 56 48 8b 7d 00 45 89 e9 89 d9 48 c7 c2 20 eb fb 89 48 c7 c6 40 ed fb 89 e8 ee 5d 85 05 <0f> 0b 48 b8 00 00 00 00 00 fc ff df 48 8b 4c 24 08 5f 48 89 ca 48
> > > RSP: 0018:ffffc90001b3f718 EFLAGS: 00010286
> > > RAX: 0000000000000000 RBX: ffffffffffffeffc RCX: 0000000000000000
> > > RDX: ffff8880795b3a00 RSI: ffffffff815ef308 RDI: fffff52000367ed3
> > > RBP: ffffc90001b3f858 R08: 0000000000000063 R09: 0000000000000000
> > > R10: ffffffff815e90de R11: 0000000000000000 R12: 0000000000000000
> > > R13: 0000000000000000 R14: 0000000000002328 R15: 0000000000000000
> > > FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000001b2ef25000 CR3: 000000002b3f7000 CR4: 00000000003506e0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  z_erofs_decompress_pcluster.isra.0+0x1389/0x2450 fs/erofs/zdata.c:977
> > >  z_erofs_decompress_queue fs/erofs/zdata.c:1055 [inline]
> > >  z_erofs_decompressqueue_work+0xe0/0x170 fs/erofs/zdata.c:1066
> > >  process_one_work+0x9b2/0x1690 kernel/workqueue.c:2297
> > >  worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
> > >  kthread+0x405/0x4f0 kernel/kthread.c:327
> > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > >  </TASK>
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
