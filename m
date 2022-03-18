Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3346A4DDF30
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 17:39:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KKqVC0NV5z30QC
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Mar 2022 03:39:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
 (client-ip=209.85.166.198; helo=mail-il1-f198.google.com;
 envelope-from=3ulu0ygkbaa87dezp00t6p44xs.v33v0t97t6r328t28.r31@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com;
 receiver=<UNKNOWN>)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KKqV35gHyz30Kq
 for <linux-erofs@lists.ozlabs.org>; Sat, 19 Mar 2022 03:39:23 +1100 (AEDT)
Received: by mail-il1-f198.google.com with SMTP id
 v11-20020a92c80b000000b002c7e3b707caso3140894iln.15
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Mar 2022 09:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
 bh=A0PKiBGd+xqMYlJRDbW4r7jmAFaIon/xTP2ACrQ8MXA=;
 b=eWoksPRioXEdD0kN6pzwNpPVYlC77TS4exoiCHsshri2y5VD0VPDs5+6ODwRXobKOX
 RMRPmjXCBjbQpIp/GAyoEmSd/ANXhndDYliCXkn4JtXSrn7X8U/pNDV98B0KBpOlSQb9
 AZO97Y3s/mWDabo5+NVjiJoDJnPHXxMu1ENtNiswn7wBsctdrDeu0CxCCVluETxted9Y
 Jws8vCSh26rDwo3o//+KgcX6sFW6w7JAUWGfxZckoJ0I9vMBZZ6Wuzv7qq5t779rMOoG
 v6/FmkGQulwBjzvvIDWQFZsEkMj+YhkZQPE7cj86mXhVNbZJ+//ygqdzKoPoU3ZVW+7V
 0h8w==
X-Gm-Message-State: AOAM530Bo9rAFYQKbSE7y2MFz5NXCSlo4FJt4uqf//j0mSyzXV555myz
 HaG9ySbSrAe4jZYyoyhy9ddvbSAud5SrdXMucPWTqHUp9L6W
X-Google-Smtp-Source: ABdhPJyC6gYZ9Y93i4A4FhPNXoiQvz3JsiCnqMFuUY15iFLSwcseFr3ELOyXfIHXROwGznyLd54okj4K0QY8i1dbJhqJLVpL9sAV
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ec:b0:2c7:e74b:14ba with SMTP id
 l12-20020a056e0212ec00b002c7e74b14bamr3635593iln.215.1647621560965; Fri, 18
 Mar 2022 09:39:20 -0700 (PDT)
Date: Fri, 18 Mar 2022 09:39:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dda2f905da80c934@google.com>
Subject: [syzbot] WARNING: kobject bug in erofs_unregister_sysfs
From: syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>
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

HEAD commit:    91265a6da44d Add linux-next specific files for 20220303
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11007413700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
dashboard link: https://syzkaller.appspot.com/bug?extid=f05ba4652c0471416eaf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137f17d9700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114ebabd700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com

RBP: 00007fff8eeb06e0 R08: 00007fff8eeb0720 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 00000000200000b0
R13: 0000000000000004 R14: 0000000000000005 R15: 0000000000000002
 </TASK>
------------[ cut here ]------------
kobject: '(null)' (ffff888077324190): is not initialized, yet kobject_put() is being called.
WARNING: CPU: 0 PID: 3610 at lib/kobject.c:750 kobject_put+0x22b/0x540 lib/kobject.c:750
Modules linked in:
CPU: 0 PID: 3610 Comm: syz-executor471 Not tainted 5.17.0-rc6-next-20220303-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kobject_put+0x22b/0x540 lib/kobject.c:750
Code: e8 6a 83 67 fd 48 89 e8 48 c1 e8 03 42 80 3c 20 00 0f 85 94 02 00 00 48 8b 75 00 48 89 ea 48 c7 c7 c0 0d 2a 8a e8 c1 5b 07 05 <0f> 0b e9 32 fe ff ff e8 39 83 67 fd 4d 89 f9 48 89 e9 4c 89 f2 49
RSP: 0018:ffffc90003b9fc48 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801c67ba80 RSI: ffffffff81602878 RDI: fffff52000773f7b
RBP: ffff888077324190 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815fd23e R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880773241cc R14: ffff888073799cf8 R15: ffff8880207dc068
FS:  0000555556165300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff8eeb1000 CR3: 000000001ac3f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 erofs_unregister_sysfs+0x46/0x60 fs/erofs/sysfs.c:225
 erofs_put_super+0x37/0xb0 fs/erofs/super.c:771
 generic_shutdown_super+0x14c/0x400 fs/super.c:462
 kill_block_super+0x97/0xf0 fs/super.c:1394
 erofs_kill_sb+0x60/0x190 fs/erofs/super.c:752
 deactivate_locked_super+0x94/0x160 fs/super.c:332
 get_tree_bdev+0x573/0x760 fs/super.c:1294
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3025 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3355
 do_mount fs/namespace.c:3368 [inline]
 __do_sys_mount fs/namespace.c:3576 [inline]
 __se_sys_mount fs/namespace.c:3553 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3553
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fa80fa1344a
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff8eeb06c8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff8eeb0720 RCX: 00007fa80fa1344a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fff8eeb06e0
RBP: 00007fff8eeb06e0 R08: 00007fff8eeb0720 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 00000000200000b0
R13: 0000000000000004 R14: 0000000000000005 R15: 0000000000000002
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
