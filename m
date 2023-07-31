Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A8258768F47
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jul 2023 09:58:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RDrFt3pRrz2ysB
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jul 2023 17:58:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.160.78; helo=mail-oa1-f78.google.com; envelope-from=3hmnhzakbakmvbcndoohudsslg.jrrjohxvhufrqwhqw.frp@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RDrFm2hRNz2yhN
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Jul 2023 17:58:02 +1000 (AEST)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1a663daf3a0so9703139fac.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 31 Jul 2023 00:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690790278; x=1691395078;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iPXHzk/BZ/Q4PQzBz4wJPb3Eoe2+5Gm/gYE7LjWFAwQ=;
        b=MC8bcFWW0eSaLw7utw1rt4UIuz2n4z972b0+QH0CgBKE31QxvwGzBoy0XrDKikhA10
         nmcSmKT/d+Jdo0PBHRtxtsVKvkLb4vJHBmtB4RxAntVJZzcZNKB7hWtQ51JDhlihwuUC
         EhG+UF07EgXcSK0V7skM7vsJeSPa5j7sdjpw+0T5Lz5e52R8HutyTl0BReDXo7wupc2l
         rTidYdh1CySDjkX1/Icp3A3gYKaQwXXeGS0rMMN+px68VwtCJ8HBtxcUWVlTNJdOHy2v
         77eec67E+61zE55yxCrl5RVSBbroIO4y+l2YN2F95Brmf3SNYZ0j+dNb+IPl4wFMMR3m
         9kBg==
X-Gm-Message-State: ABy/qLZ6mN96MG1glYBbsHfqnUGa+MHNHF7pY55+J6Ax4SX9bIHKx6qC
	cNmlVmJ3GJD1LiAuGIqZqoTRluxaaGfOrRJKiEE6x+zgissJ
X-Google-Smtp-Source: APBJJlE72MwYWSbzqqQTBsauH9F3ycZfcx7u7sahtIOvp55hjEgxEiPtapmcPi+7a6rDuNw+iY16OH9GPLA3RRteHW4BgUOGnJ1+
MIME-Version: 1.0
X-Received: by 2002:a05:6870:956f:b0:1bb:6993:1fb5 with SMTP id
 v47-20020a056870956f00b001bb69931fb5mr12182255oal.0.1690790278739; Mon, 31
 Jul 2023 00:57:58 -0700 (PDT)
Date: Mon, 31 Jul 2023 00:57:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f43cab0601c3c902@google.com>
Subject: [syzbot] [erofs?] [fat?] WARNING in erofs_kill_sb
From: syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, hch@lst.de, huyue2@coolpad.com, 
	jack@suse.cz, jefflexu@linux.alibaba.com, linkinjeon@kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello,

syzbot found the following issue on:

HEAD commit:    d7b3af5a77e8 Add linux-next specific files for 20230728
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13018b26a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62dd327c382e3fe
dashboard link: https://syzkaller.appspot.com/bug?extid=69c477e882e44ce41ad9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b490c5a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139a9c7ea80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5efa5e68267f/disk-d7b3af5a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b1f5d3e10263/vmlinux-d7b3af5a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/57cab469d186/bzImage-d7b3af5a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2cf2189f623b/mount_0.gz

The issue was bisected to:

commit 1dbd9ceb390c4c61d28cf2c9251dd2015946ce51
Author: Jan Kara <jack@suse.cz>
Date:   Mon Jul 24 17:51:45 2023 +0000

    fs: open block device after superblock creation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1613d586a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1513d586a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1113d586a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com
Fixes: 1dbd9ceb390c ("fs: open block device after superblock creation")

/dev/nullb0: Can't open blockdev
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5047 at fs/erofs/super.c:862 erofs_kill_sb+0x206/0x260 fs/erofs/super.c:862
Modules linked in:
CPU: 0 PID: 5047 Comm: syz-executor356 Not tainted 6.5.0-rc3-next-20230728-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:erofs_kill_sb+0x206/0x260 fs/erofs/super.c:862
Code: 00 00 5b 5d 41 5c 41 5d e9 e7 27 b7 fd e8 e2 27 b7 fd 48 89 df e8 6a 81 1b fe 5b 5d 41 5c 41 5d e9 cf 27 b7 fd e8 ca 27 b7 fd <0f> 0b e9 41 fe ff ff e8 5e f6 0b fe e9 1a fe ff ff e8 54 f6 0b fe
RSP: 0018:ffffc90003c2fca0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888029aee000 RCX: 0000000000000000
RDX: ffff8880268e9dc0 RSI: ffffffff83cfdc26 RDI: 0000000000000007
RBP: 00000000e0f5e1e2 R08: 0000000000000007 R09: 00000000e0f5e1e2
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 1ffff92000785fa0 R14: 00000000fffffff0 R15: ffff88807d747cf8
FS:  0000555556001380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055aecc7b6468 CR3: 000000007b9d9000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 deactivate_locked_super+0x9a/0x170 fs/super.c:330
 get_tree_bdev+0x4c7/0x6a0 fs/super.c:1347
 vfs_get_tree+0x88/0x350 fs/super.c:1521
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7610a75f09
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffaf351d38 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 6c756e2f7665642f RCX: 00007f7610a75f09
RDX: 0000000020000080 RSI: 0000000020000040 RDI: 0000000020000000
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000555556002378
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffaf351d70 R14: 00007fffaf351d5c R15: 00007f7610abf03b
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
