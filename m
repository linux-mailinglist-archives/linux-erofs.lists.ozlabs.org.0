Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD98F2FBDD3
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Jan 2021 18:38:36 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DKwqZ2MJ4zDr30
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Jan 2021 04:38:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
 (client-ip=209.85.166.71; helo=mail-io1-f71.google.com;
 envelope-from=3crkhyakbaf4ouvg6hhan6lle9.ckkchaqoan8kjpajp.8ki@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com;
 receiver=<UNKNOWN>)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DKwqR3KrCzDqrN
 for <linux-erofs@lists.ozlabs.org>; Wed, 20 Jan 2021 04:38:20 +1100 (AEDT)
Received: by mail-io1-f71.google.com with SMTP id l18so36920948iok.7
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Jan 2021 09:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
 bh=40gJjNkwJtrlm4insO0rPudC8qItU3LszLGVCfoZwTM=;
 b=cDqLBQ0gOWJHBk/OkS4pbeP4SEutJZP5hJNsP75q7Cfy5zJTGu4SsEopzvgzaXjFDW
 R9SBnUtStGYJmySpeWx7pSJfOdCh1Z7aXXTLVw8R11ovtOz2QzzOUxUwXVx8km92KVwI
 M6nWJdKFY46dAr6wgd1ybYdACUZ0su+yCXAc8P6ZIvbC2qeg4owfOzdLxNd1sXNhhzef
 7ZD6Qj18qNJywGCviaSlGbMnN2U6M/jyAoojlI95UiHqnHkAYxVRknTl5p0Law4DU51V
 FEu0kxUlz6nQ4/QtNyXRwB/87o1JF4i5ctzrrISx0MtR9NWvExXUmG342sVm+qrb0BPw
 PdfA==
X-Gm-Message-State: AOAM530TtcbXkPMJhhQ+tOXz7hT8Y+qNhhM54NZe4wwH7UnQrifLuqG1
 /IGNNHtLHCZdmiGKkLtx/gM9x1b5cH0cJiSnWLp/om6NXYL7
X-Google-Smtp-Source: ABdhPJxyjXk5JbNLx/UUaby10LaGPXZY3MGKluQT3eHA5u+3VXPu8XJuDmy46ovk01N0F3Ee7p0VdBMOw+2iigKYTG6jD7h336eF
MIME-Version: 1.0
X-Received: by 2002:a02:634b:: with SMTP id j72mr4366118jac.106.1611077897365; 
 Tue, 19 Jan 2021 09:38:17 -0800 (PST)
Date: Tue, 19 Jan 2021 09:38:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c72ddd05b9444d2f@google.com>
Subject: UBSAN: shift-out-of-bounds in erofs_fc_fill_super
From: syzbot <syzbot+c68f467cd7c45860e8d4@syzkaller.appspotmail.com>
To: chao@kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
 xiang@kernel.org
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello,

syzbot found the following issue on:

HEAD commit:    b3a3cbde Add linux-next specific files for 20210115
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1060b83b500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ea08dae6aab586f
dashboard link: https://syzkaller.appspot.com/bug?extid=c68f467cd7c45860e8d4
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fd46af500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e2a858d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c68f467cd7c45860e8d4@syzkaller.appspotmail.com

loop0: detected capacity change from 4 to 0
================================================================================
UBSAN: shift-out-of-bounds in fs/erofs/super.c:161:3
shift exponent 59 is too large for 32-bit type 'int'
CPU: 1 PID: 8462 Comm: syz-executor591 Not tainted 5.11.0-rc3-next-20210115-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:395
 erofs_read_superblock fs/erofs/super.c:161 [inline]
 erofs_fc_fill_super.cold+0x6c/0x35c fs/erofs/super.c:357
 get_tree_bdev+0x440/0x760 fs/super.c:1291
 vfs_get_tree+0x89/0x2f0 fs/super.c:1496
 do_new_mount fs/namespace.c:2889 [inline]
 path_mount+0x12ae/0x1e70 fs/namespace.c:3220
 do_mount fs/namespace.c:3233 [inline]
 __do_sys_mount fs/namespace.c:3441 [inline]
 __se_sys_mount fs/namespace.c:3418 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3418
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446d1a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fff68419868 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff684198c0 RCX: 0000000000446d1a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fff68419880
RBP: 00007fff68419880 R08: 00007fff684198c0 R09: 00007fff00000015
R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000001
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
