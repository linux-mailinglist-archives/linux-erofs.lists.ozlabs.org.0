Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F41927E285
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Sep 2020 09:23:20 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C1SQs5YWbzDqWy
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Sep 2020 17:23:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1601450597;
	bh=obQT+97N8wd8obywmAiqYTsdY+aahyI+Z2EuEte0FiA=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=UrspOfac8MiaqtWCAug9XuYUuBA6oiCHyUI2oxrW/pV7B+N6MZU7AoX9RKnXiSeA7
	 mVkUesp2C+2hIr1euHy1JIm+KayS+cjCL2tu20uiuYDto5dFbBGbtFSoNhR8/nZeZS
	 PkSgpwv2q8reLM0ycYXl/t39/HWhVP9ZIZ3vyQy8N976xLwGkbDhfJ5NbkoJuMeLvJ
	 tkiqqTVdBMcAFi12jAk5n8cJXknTuMDxrj1DIWkX93rv/yPz6oRwKn2O3pBXc6EpbQ
	 xqDNUCs1mD+JMJGDiwgCqiWJH3iDMHTlRl5yVay7InNRSEt8J8YSMPTb//STaUFN30
	 MTWYmwIEiHBPw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::743;
 helo=mail-qk1-x743.google.com; envelope-from=dvyukov@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=cxyFTAcF; dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C1SQk1shlzDqNZ
 for <linux-erofs@lists.ozlabs.org>; Wed, 30 Sep 2020 17:23:02 +1000 (AEST)
Received: by mail-qk1-x743.google.com with SMTP id w12so485575qki.6
 for <linux-erofs@lists.ozlabs.org>; Wed, 30 Sep 2020 00:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JWvHxjwb5MpXqTvTfHjqJXCbQn32Jzbr/aMnZMP7mUE=;
 b=cxyFTAcFj76JW93eps+PF0HFiGsD4KMMasUi+jmM5hrzrYX/j7XfkRugEQ6K6vXHVU
 oWDxodt5u5aeDbAzw66LkW2qsrvp8lULFzv1QzgFf4/Zd3Gr/vOSO6TxyY4JfS8QDc0c
 l97ViAwqL5mcr4oqDiIHCHPyy7AHSTq5wfSee6v+wcVn3pKqSMJt59Pmpl+RavU6wALK
 anW6s784pigj0oY+aTmC8SHw3MjU/iFOw0h1yy9xKxsINRFHOtFY3Te3613U0x6hdmya
 TUshaliD7ymSHz6/ZO/lIbcIRfJqVpGiIDbm2PaW25xN558lp+uiqWDTsRjUnP0hL+bA
 kBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JWvHxjwb5MpXqTvTfHjqJXCbQn32Jzbr/aMnZMP7mUE=;
 b=K5/id7ivz47rEPgYS6Ota8X6oJmo2XYYD+SxTxCbn9vDwE37WyLKsXrmrN7HznEsII
 sc6sAgi3iCEw58IGui50QsXr8rjuIW1NzZyXtGE8gPBJqLO1qYsrpefOoHdcN6C1VHZS
 gnL5NHdTIAdpGSNGGcCtqwN9EQBBbly4Q5dDN90SkE1vHftgv0luDFGtfQim0zH5m7NR
 0PLCSnwDfTNwJOPxtYSC0SVeMs8AkbVV0xeojWeQS0Ab5v8dY4N59NvxxiTHJnpksMEl
 TKejAB9SOXYs/qfuq0kLv8COtaxofc3MBFejHvkhT8lgjn2i94x/7WftZDpkEW1mCJxA
 zZFw==
X-Gm-Message-State: AOAM5325Huv4LdkIeOd+1MxivQ/LCDfNuQeN240iaS8Cmi38XSUWdldB
 UiHRvIiR8k4GhMnPGXHUYOh+pHQ2WDJIgZpTiO0RPA==
X-Google-Smtp-Source: ABdhPJxoAA8wjL4V7MC/6BjOBr0OUsPMNYHvrFFseqNPXV8pgIiRhx9hGGFDnnqYRWDYin4zKZAb3SzX0uYZALZU16Y=
X-Received: by 2002:a37:a785:: with SMTP id q127mr1247858qke.256.1601450577883; 
 Wed, 30 Sep 2020 00:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000044ba05b05a9961@google.com>
 <20200928203035.GA7770@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1026c918-9f08-6b0f-f3b0-3dd1016dbf71@huawei.com>
In-Reply-To: <1026c918-9f08-6b0f-f3b0-3dd1016dbf71@huawei.com>
Date: Wed, 30 Sep 2020 09:22:46 +0200
Message-ID: <CACT4Y+bcyqvVdYxe1TmejcpyDH4=jkg+Z6DCX8R5K2SYGm=PDQ@mail.gmail.com>
Subject: Re: kernel BUG at fs/erofs/inode.c:LINE!
To: Chao Yu <yuchao0@huawei.com>
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
Cc: "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
 syzbot <syzbot+8afc256dce324523609d@syzkaller.appspotmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 LKML <linux-kernel@vger.kernel.org>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Sep 29, 2020 at 3:57 AM Chao Yu <yuchao0@huawei.com> wrote:
>
> Hi syzbot administrator,
>
> CONFIG_EROFS_DEBUG was introduced for debug purpose during
> development, this should not be enabled on release version.
>
> Can you please turn off this config, and retest with erofs module?
>
> Thanks,

Hi Chao,

Thanks for looking into this. I've disabled CONFIG_EROFS_FS_DEBUG in
syzbot config:
https://github.com/google/syzkaller/commit/5abc3f1ab298244473b613c289f1536e366fcf04

#syz invalid



> On 2020/9/29 4:36, Gao Xiang wrote:
> > Hi,
> >
> > On Mon, Sep 28, 2020 at 12:27:24AM -0700, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    d1d2220c Add linux-next specific files for 20200924
> >> git tree:       linux-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=166cb7d9900000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=254e028a642027c
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=8afc256dce324523609d
> >> compiler:       gcc (GCC) 10.1.0-syz 20200507
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127762c3900000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124ccf3b900000
> >>
> >> The issue was bisected to:
> >>
> >> commit 382329a9d8553a98418a6f6e3425f0c288837897
> >> Author: Gao Xiang <gaoxiang25@huawei.com>
> >> Date:   Wed Aug 14 10:37:04 2019 +0000
> >>
> >>      staging: erofs: differentiate unsupported on-disk format
> >
> > if CONFIG_EROFS_DEBUG=y, the kernel will also BUG_ON on
> > currupted images in order to check potential mkfs fault.
> >
> > So it's an expected behavior for now (if syzbot needs some more requirement,
> > e.g. differ from runtime error vs corrupted image error, I can do it if
> > needed.)
> >
> > Thanks,
> > Gao Xiang
> >
> >>
> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149889e3900000
> >> final oops:     https://syzkaller.appspot.com/x/report.txt?x=169889e3900000
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=129889e3900000
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+8afc256dce324523609d@syzkaller.appspotmail.com
> >> Fixes: 382329a9d855 ("staging: erofs: differentiate unsupported on-disk format")
> >>
> >> erofs: (device loop0): erofs_read_inode: bogus i_mode (0) @ nid 36
> >> ------------[ cut here ]------------
> >> kernel BUG at fs/erofs/inode.c:182!
> >> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> >> CPU: 1 PID: 6895 Comm: syz-executor894 Not tainted 5.9.0-rc6-next-20200924-syzkaller #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> >> RIP: 0010:erofs_read_inode fs/erofs/inode.c:182 [inline]
> >> RIP: 0010:erofs_fill_inode fs/erofs/inode.c:235 [inline]
> >> RIP: 0010:erofs_iget+0xfd8/0x2390 fs/erofs/inode.c:322
> >> Code: 00 0f 85 aa 10 00 00 49 8b 7c 24 28 49 89 d8 44 89 e9 48 c7 c2 a0 9c ef 88 48 c7 c6 40 9f ef 88 e8 b5 df b0 04 e8 88 5a 07 fe <0f> 0b e8 81 5a 07 fe 4c 89 e7 4c 63 e3 e8 b6 61 5b fe e9 ed f0 ff
> >> RSP: 0018:ffffc90001017c10 EFLAGS: 00010293
> >> RAX: 0000000000000000 RBX: 0000000000000024 RCX: 0000000000000000
> >> RDX: ffff8880a172e480 RSI: ffffffff836dd6e8 RDI: fffff52000202f72
> >> RBP: ffff8880a8ca4480 R08: 0000000000000042 R09: ffff8880ae5319a7
> >> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880854fd9b8
> >> R13: 0000000000000000 R14: ffffea0002a32900 R15: 0000000000000000
> >> FS:  000000000108e880(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 000000000043eb80 CR3: 00000000a7edb000 CR4: 00000000001506e0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> Call Trace:
> >>   erofs_fc_fill_super+0xaa3/0x1010 fs/erofs/super.c:382
> >>   get_tree_bdev+0x421/0x740 fs/super.c:1342
> >>   vfs_get_tree+0x89/0x2f0 fs/super.c:1547
> >>   do_new_mount fs/namespace.c:2896 [inline]
> >>   path_mount+0x12ae/0x1e70 fs/namespace.c:3227
> >>   __do_sys_mount fs/namespace.c:3438 [inline]
> >>   __se_sys_mount fs/namespace.c:3411 [inline]
> >>   __x64_sys_mount+0x278/0x2f0 fs/namespace.c:3411
> >>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >> RIP: 0033:0x446d6a
> >> Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
> >> RSP: 002b:00007fffa8ef9ef8 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
> >> RAX: ffffffffffffffda RBX: 00007fffa8ef9f50 RCX: 0000000000446d6a
> >> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fffa8ef9f10
> >> RBP: 00007fffa8ef9f10 R08: 00007fffa8ef9f50 R09: 00007fff00000015
> >> R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000001
> >> R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003
> >> Modules linked in:
> >> ---[ end trace 66a5371a9bd8a3b2 ]---
> >> RIP: 0010:erofs_read_inode fs/erofs/inode.c:182 [inline]
> >> RIP: 0010:erofs_fill_inode fs/erofs/inode.c:235 [inline]
> >> RIP: 0010:erofs_iget+0xfd8/0x2390 fs/erofs/inode.c:322
> >> Code: 00 0f 85 aa 10 00 00 49 8b 7c 24 28 49 89 d8 44 89 e9 48 c7 c2 a0 9c ef 88 48 c7 c6 40 9f ef 88 e8 b5 df b0 04 e8 88 5a 07 fe <0f> 0b e8 81 5a 07 fe 4c 89 e7 4c 63 e3 e8 b6 61 5b fe e9 ed f0 ff
> >> RSP: 0018:ffffc90001017c10 EFLAGS: 00010293
> >> RAX: 0000000000000000 RBX: 0000000000000024 RCX: 0000000000000000
> >> RDX: ffff8880a172e480 RSI: ffffffff836dd6e8 RDI: fffff52000202f72
> >> RBP: ffff8880a8ca4480 R08: 0000000000000042 R09: ffff8880ae5319a7
> >> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880854fd9b8
> >> R13: 0000000000000000 R14: ffffea0002a32900 R15: 0000000000000000
> >> FS:  000000000108e880(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 000000000043eb80 CR3: 00000000a7edb000 CR4: 00000000001506e0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>
> >>
> >> ---
> >> This report is generated by a bot. It may contain errors.
> >> See https://goo.gl/tpsmEJ for more information about syzbot.
> >> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>
> >> syzbot will keep track of this issue. See:
> >> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> >> syzbot can test patches for this issue, for details see:
> >> https://goo.gl/tpsmEJ#testing-patches
> > .
> >
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/1026c918-9f08-6b0f-f3b0-3dd1016dbf71%40huawei.com.
