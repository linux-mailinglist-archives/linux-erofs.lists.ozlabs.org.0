Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 015E727A88D
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Sep 2020 09:27:40 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C0Dcn0zJwzDqRp
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Sep 2020 17:27:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
 (client-ip=209.85.166.205; helo=mail-il1-f205.google.com;
 envelope-from=3xjbxxwkbaeuz56rhsslyhwwpk.nvvnsl1zlyjvu0lu0.jvt@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none)
 header.from=syzkaller.appspotmail.com
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com
 [209.85.166.205])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C0Dcj3hzWzDqDp
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Sep 2020 17:27:27 +1000 (AEST)
Received: by mail-il1-f205.google.com with SMTP id q11so95319ilt.3
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Sep 2020 00:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
 bh=/AfpEA6FiFsXUoAejyXfq5OLQ9SrlGOHQTfJuzst7xw=;
 b=fTWFl8y8DuEWBvr7XYmC4auhH7IZ9mjvwC4DyiOA66kCnW0caGAqel4/DpS5r2VgUR
 jvoTWB+Nk36Z7vne0rlI/zldVqHyxhdK+mahNw7ZqU+v6Uq8HDVZgE4AIEqJzPLZ1P6E
 xq7SFCRvwwPk/V7xoHFbKrK/BCsBnKv478B2e22f2wXbHhXJsu7xt9reBfVpkYmytxw3
 pwwmwTz3IWUDovdSzXUHm9OrQ2YnZKIoH0wcT6Ff7S6jao3OvDrSBxg5nlIdcZoxSjXi
 Tn3OuOnQSmRDSpatuuhpsRRPGh4wMBRHgkrSb2lPfiVTb8zAnieMdLzde037zYhjAOFn
 ZAqA==
X-Gm-Message-State: AOAM531msCM7CHjuREM020g4X+2NStdzz3Hm7jlGl5Wt+28nto3a0zPK
 0oWIn40A8JCC6I36uz9pWJGUiGfreXTl/qA/GsdkZJLpuRB8
X-Google-Smtp-Source: ABdhPJxosxXWJt2K90H0pAaytudDmwmJ7O/X0setgYmcz6l+pZbRXoZZLwL8IBIEZmrEg0DW5g8EpHPAmnAgl2TzjnWtIkGO75fX
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d1:: with SMTP id
 y17mr142416jat.3.1601278044027; 
 Mon, 28 Sep 2020 00:27:24 -0700 (PDT)
Date: Mon, 28 Sep 2020 00:27:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000044ba05b05a9961@google.com>
Subject: kernel BUG at fs/erofs/inode.c:LINE!
From: syzbot <syzbot+8afc256dce324523609d@syzkaller.appspotmail.com>
To: chao@kernel.org, devel@driverdev.osuosl.org, gaoxiang25@huawei.com, 
 gregkh@linuxfoundation.org, linux-erofs@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
 xiang@kernel.org, yuchao0@huawei.com
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

HEAD commit:    d1d2220c Add linux-next specific files for 20200924
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=166cb7d9900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=254e028a642027c
dashboard link: https://syzkaller.appspot.com/bug?extid=8afc256dce324523609d
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127762c3900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124ccf3b900000

The issue was bisected to:

commit 382329a9d8553a98418a6f6e3425f0c288837897
Author: Gao Xiang <gaoxiang25@huawei.com>
Date:   Wed Aug 14 10:37:04 2019 +0000

    staging: erofs: differentiate unsupported on-disk format

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149889e3900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=169889e3900000
console output: https://syzkaller.appspot.com/x/log.txt?x=129889e3900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8afc256dce324523609d@syzkaller.appspotmail.com
Fixes: 382329a9d855 ("staging: erofs: differentiate unsupported on-disk format")

erofs: (device loop0): erofs_read_inode: bogus i_mode (0) @ nid 36
------------[ cut here ]------------
kernel BUG at fs/erofs/inode.c:182!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6895 Comm: syz-executor894 Not tainted 5.9.0-rc6-next-20200924-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:erofs_read_inode fs/erofs/inode.c:182 [inline]
RIP: 0010:erofs_fill_inode fs/erofs/inode.c:235 [inline]
RIP: 0010:erofs_iget+0xfd8/0x2390 fs/erofs/inode.c:322
Code: 00 0f 85 aa 10 00 00 49 8b 7c 24 28 49 89 d8 44 89 e9 48 c7 c2 a0 9c ef 88 48 c7 c6 40 9f ef 88 e8 b5 df b0 04 e8 88 5a 07 fe <0f> 0b e8 81 5a 07 fe 4c 89 e7 4c 63 e3 e8 b6 61 5b fe e9 ed f0 ff
RSP: 0018:ffffc90001017c10 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000024 RCX: 0000000000000000
RDX: ffff8880a172e480 RSI: ffffffff836dd6e8 RDI: fffff52000202f72
RBP: ffff8880a8ca4480 R08: 0000000000000042 R09: ffff8880ae5319a7
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880854fd9b8
R13: 0000000000000000 R14: ffffea0002a32900 R15: 0000000000000000
FS:  000000000108e880(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043eb80 CR3: 00000000a7edb000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 erofs_fc_fill_super+0xaa3/0x1010 fs/erofs/super.c:382
 get_tree_bdev+0x421/0x740 fs/super.c:1342
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2896 [inline]
 path_mount+0x12ae/0x1e70 fs/namespace.c:3227
 __do_sys_mount fs/namespace.c:3438 [inline]
 __se_sys_mount fs/namespace.c:3411 [inline]
 __x64_sys_mount+0x278/0x2f0 fs/namespace.c:3411
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446d6a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fffa8ef9ef8 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fffa8ef9f50 RCX: 0000000000446d6a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fffa8ef9f10
RBP: 00007fffa8ef9f10 R08: 00007fffa8ef9f50 R09: 00007fff00000015
R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000001
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003
Modules linked in:
---[ end trace 66a5371a9bd8a3b2 ]---
RIP: 0010:erofs_read_inode fs/erofs/inode.c:182 [inline]
RIP: 0010:erofs_fill_inode fs/erofs/inode.c:235 [inline]
RIP: 0010:erofs_iget+0xfd8/0x2390 fs/erofs/inode.c:322
Code: 00 0f 85 aa 10 00 00 49 8b 7c 24 28 49 89 d8 44 89 e9 48 c7 c2 a0 9c ef 88 48 c7 c6 40 9f ef 88 e8 b5 df b0 04 e8 88 5a 07 fe <0f> 0b e8 81 5a 07 fe 4c 89 e7 4c 63 e3 e8 b6 61 5b fe e9 ed f0 ff
RSP: 0018:ffffc90001017c10 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000024 RCX: 0000000000000000
RDX: ffff8880a172e480 RSI: ffffffff836dd6e8 RDI: fffff52000202f72
RBP: ffff8880a8ca4480 R08: 0000000000000042 R09: ffff8880ae5319a7
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880854fd9b8
R13: 0000000000000000 R14: ffffea0002a32900 R15: 0000000000000000
FS:  000000000108e880(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043eb80 CR3: 00000000a7edb000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
