Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934D799E20B
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 11:03:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XSSnQ3mnWz3bpn
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 20:03:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.198
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728983017;
	cv=none; b=XYnflG+4LyOtpaFB6by1tKjo3cNuARPqEA0mqOa/FizVLfN3u7pVE1Q6aXENeQ0GdJCQdhQvx0IYT9cypDcsTKTvsR/WT4A/S7On/OivLcfkqYobFzPO7sEL+VN+iOXbLKpcR+J7HKyc7KOY3+f2z01x3FH1IACApzBlf8aebin6d3LLqCdaVsBXlEQ/2uqoVp9pRPOCVzY/warAFw5sJyDk9V/IJ14/Kv7rqO/4O6E/ttK8HqQIYT5alvfyZKq9xvl/rti/k44uvjlk7/rF75uDVXJkAe033XR4dkBuInFeSidur7nzbjtSbnPRp+7wxX6o2T84nICjZWJ7MQe4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728983017; c=relaxed/relaxed;
	bh=QIgyvK2789ssuMdmTWMqyL5nugwz4pmlemR7A0aasco=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JauAruWXwtvUJMPw5e2LxyJCiHEfAiBRU0e6o8+Vq0ctessjqd2YXomllLEFPqAFA7UpqzMsOHF6isMPT1N689pY473Hgnv5dbxrh7uNFRZrZPT3lpoQ+GfYBUMle2/8ZpdYG1Ch/yhqbmUAxDenjI4UMsUrpbpdC839IoSkBzMy3i2DcTVf4q6JDuwp8rfirljDFiFlfOwvf763B3/uyLDvHU5AO/c2ONO/+Dz2QtrKa7MCTp/pM5DPUdciH8FjoOx5vpWE6k2hVLsMMQcT0llhXnauOYVLdlv0TCFLRnuOTpHAn9HxxezsEyjGoEe3sTJ3TzEeBEYLXY7mbnPrhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.198; helo=mail-il1-f198.google.com; envelope-from=34s8ozwkbalgqwxiyjjcpynngb.emmejcsqcpamlrclr.amk@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.198; helo=mail-il1-f198.google.com; envelope-from=34s8ozwkbalgqwxiyjjcpynngb.emmejcsqcpamlrclr.amk@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XSSnK3P2dz3bk0
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 20:03:32 +1100 (AEDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b7d1e8a0so26137375ab.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 02:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983009; x=1729587809;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QIgyvK2789ssuMdmTWMqyL5nugwz4pmlemR7A0aasco=;
        b=O4BV9BzAdCeDFIpK/kc8ZQwyuWUkNGQGNmSIf1ZGjghUgI939tqHsi6Y4Uq6cxu3vb
         3mGS9JVgJ7CJmMnl8nT7HQf8h4zm/d8gGHml4zW2/tGSMzTrxCJM41LlnOR2cJzyc/hh
         slbT/RbDTw54DSkdlckkbJE78/0P9Xt1+bCOdSuC2hgqTXTfuZu5Lgx9Z1QRk0L3BVEH
         gzNJh+M10Lmi9GMugv+cbhhFpIN96Uk1TBs29Y4EakPTX2vIfreb4IqhcwwKspuMAw3i
         SRZdUDmrIurkWomkhFlWgo8FN8Ndx7RRz1CSL4WG6gBnaobBkOnAlwzhp4CyEx4U0BFw
         VouA==
X-Forwarded-Encrypted: i=1; AJvYcCWA9Vjnt0w/rxOMNqL0I4m0cIwSERAQy8yoNhFUgn6b72TFyiwgzJf5Xemp9Q1Q29JdEs0/LBxstXuRQw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzmccj2NiM9zJx+HP7SmZGwRqe4M3dIRx6BkLKuNbxqCVsJrm+f
	SdP6OZSV3UNV53/CT29taFL6QqMy3GB2hwL5A7SD6x4Wq8kSdwM1WCgDOOvFRhD8sh3n0cI4KG0
	wjbavxWP72chTtwAVmjAR1Nsm0aPqVJS/hKukXv1QNujd+4RTDXEwN00=
X-Google-Smtp-Source: AGHT+IFFYZyrAGS/UzyHNKkwU7tGU7x9vGFAB4+n1gb4UKvA5/dsCXYHlEr8ggOao+F3qH4Y7BPYqMXRdvPY0z9Sva+IDAm93akU
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cb:b0:3a2:463f:fd9e with SMTP id
 e9e14a558f8ab-3a3bcdbb642mr87105465ab.6.1728983009102; Tue, 15 Oct 2024
 02:03:29 -0700 (PDT)
Date: Tue, 15 Oct 2024 02:03:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e2fe1.050a0220.d5849.0004.GAE@google.com>
Subject: [syzbot] [iomap?] WARNING in iomap_iter (3)
From: syzbot <syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, dhavale@google.com, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, huyue2@coolpad.com, jefflexu@linux.alibaba.com, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

HEAD commit:    d61a00525464 Add linux-next specific files for 20241011
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=175a3b27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8554528c7f4bf3fb
dashboard link: https://syzkaller.appspot.com/bug?extid=74cc7d98ae5484c2744d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1513b840580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1313b840580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f615720e9964/disk-d61a0052.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c4a45c7583c6/vmlinux-d61a0052.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d767ab86d0d0/bzImage-d61a0052.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fce276498eea/mount_0.gz

The issue was bisected to:

commit 56bd565ea59192bbc7d5bbcea155e861a20393f4
Author: Gao Xiang <hsiangkao@linux.alibaba.com>
Date:   Thu Oct 10 09:04:20 2024 +0000

    erofs: get rid of kaddr in `struct z_erofs_maprecorder`

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fd305f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13fd305f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15fd305f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com
Fixes: 56bd565ea591 ("erofs: get rid of kaddr in `struct z_erofs_maprecorder`")

erofs: (device loop0): mounted with root inode @ nid 36.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5233 at fs/iomap/iter.c:51 iomap_iter_done fs/iomap/iter.c:51 [inline]
WARNING: CPU: 1 PID: 5233 at fs/iomap/iter.c:51 iomap_iter+0x9db/0xf60 fs/iomap/iter.c:95
Modules linked in:
CPU: 1 UID: 0 PID: 5233 Comm: syz-executor323 Not tainted 6.12.0-rc2-next-20241011-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:iomap_iter_done fs/iomap/iter.c:51 [inline]
RIP: 0010:iomap_iter+0x9db/0xf60 fs/iomap/iter.c:95
Code: 0f 0b 90 e9 0a f9 ff ff e8 d2 10 62 ff 90 0f 0b 90 e9 42 fd ff ff e8 c4 10 62 ff 90 0f 0b 90 e9 71 fd ff ff e8 b6 10 62 ff 90 <0f> 0b 90 e9 d5 fd ff ff e8 a8 10 62 ff 90 0f 0b 90 43 80 3c 2e 00
RSP: 0018:ffffc900036af6e0 EFLAGS: 00010293
RAX: ffffffff8232e26a RBX: 0000000000004000 RCX: ffff88802b559e00
RDX: 0000000000000000 RSI: 0000000000018057 RDI: 0000000000004000
RBP: 0000000000018057 R08: ffffffff8232e03a R09: 1ffffd40001490be
R10: dffffc0000000000 R11: fffff940001490bf R12: 1ffff920006d5f05
R13: dffffc0000000000 R14: 1ffff920006d5f04 R15: ffffc900036af820
FS:  000055556b120380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 000000007edfe000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iomap_fiemap+0x73b/0x9b0 fs/iomap/fiemap.c:80
 ioctl_fiemap fs/ioctl.c:220 [inline]
 do_vfs_ioctl+0x1bf8/0x2e40 fs/ioctl.c:841
 __do_sys_ioctl fs/ioctl.c:905 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5ca9685679
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8eaa5b98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffd8eaa5d68 RCX: 00007f5ca9685679
RDX: 0000000020000040 RSI: 00000000c020660b RDI: 0000000000000004
RBP: 00007f5ca96f8610 R08: 0000000000000000 R09: 00007ffd8eaa5d68
R10: 00000000000001e1 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd8eaa5d58 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
