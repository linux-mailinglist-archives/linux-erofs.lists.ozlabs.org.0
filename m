Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1679CDE20
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2024 13:18:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xqbdx07G1z30gG
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2024 23:18:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.200
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731673107;
	cv=none; b=B1PzG1SpkjkkM51lGt38PbBfbSa7XmRhhGMdLmheGaxFK7o/J6h9m5++EHafiLkQ9r34BVoGZEwwXZLhGYW86DnRvgbTYNI89NcjE5Bij6dLO0L+rJk6oO/z/it19QsihK1NNd7vQHwDbaEiAy0y6DSz8ZZUoE/vwQWFvw+q1uMgx/BqHZYUT81tj5kxPTefROj8nxdKi3C8i2xMbc1f+XSpQwEJ47lavgbKj6gYFDKqgcODmJEM8iegBHyn/17w3HXoUKZJJmGLLATsL5hFG9D52WzH7RTH3jnLsjKigBqNLKNlh6maEZpsRscO9KlUCewGam6b7gnc5YDanfnszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731673107; c=relaxed/relaxed;
	bh=CWyIAe7Iyu79cPa4yiK4qyYvtRQUg06RByJAlqRtbP8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Dg/PMf+7dh5KE3rMp63jKluVVFLsXzvixM2JYMCWiNqziaZjCfSjl/OgiCdfklmQrFNbwQZ1Gaf107FOlAn3chktegx9HhBgggQGfdQxoI8ISxeZHwDloJVFvGLzQYvb7nRUKvmb7WDnsXttXA1/oKkwWvZN/kPfQm9J4dMCvZIgEL8u0kSbeIgwGMvd3nMF4+MOmXACOn05DfCxtirw4ThaaYMWvOPf368j2KhJjEKJOm9U6wikIfYexXyjSICqD+D6GD0lYT0DVpV1R12u9ZMYsTvIBxNrUTYlNQC3jTyJL3u9wNvvtGrsf2QMFMiApmQe4s3BMgO9QH9yX05iEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.200; helo=mail-il1-f200.google.com; envelope-from=3ddw3zwkbaketzalbmmfsbqqje.hpphmfvtfsdpoufou.dpn@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.200; helo=mail-il1-f200.google.com; envelope-from=3ddw3zwkbaketzalbmmfsbqqje.hpphmfvtfsdpoufou.dpn@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xqbds1tBRz301w
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Nov 2024 23:18:23 +1100 (AEDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6c355b3f5so20765115ab.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 15 Nov 2024 04:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731673100; x=1732277900;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CWyIAe7Iyu79cPa4yiK4qyYvtRQUg06RByJAlqRtbP8=;
        b=QGWIiD5FSkj4nwemZ//7xwgsoIb3r6wDP0HQOloieyEk29qlgmBlgYWPCzEhF5/Fta
         v65D/XBWToCmImhZ09W8vsBtKar9Mg1Y4lpIbdZtyC90mgH7B5Z+IZ6UIivGgZgMZrHM
         8bicuUr5l1abOk0MtGE5nd+nDMcvLmfbPSg1PPBrRVbe0LTyydudMLISwlyMJ4CtNauH
         6zb04Oki8suJM4jqRtRbZ9xuS8ogVO2uGTPEtXDxaQpo9N2l2pPK8YvLUXgsHKyXs0bV
         jsTSu+V9ZZaH/aLbsNsqegNgXpM2I+U+hjS4TbE0t2S1EoFvzeBsikTqbynTXelHKP4e
         qHwg==
X-Forwarded-Encrypted: i=1; AJvYcCVSSFuDVG6hehvAN2VQVQ8QGH8GjGST9cXPwJfOc4xfophFXyw8ocuR9pInCuyh7zC2e5GgbQxO6IlQ2Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyjCqLioP/nOBaRDtb6BQwKTQUGGUmhxpSYytLXGBqmmepIy8gB
	VEy5l0yJDfqeu9zySQFQWF7+zJlGcA2wSUO5x9nxagSP1KXo1dBhrLfPllJRnM1hDv183Hw+yay
	KGGv/U0AR55hfpGzS5idB4/pbzadhNEmBuikdFNmgW5VPoxydMNHAakE=
X-Google-Smtp-Source: AGHT+IHS83RxK07c7iu+7NBNxARqNlY4aGwLt7IOp5zWA1rimRz8w0n+4/b3UaoSpsjx6Op1sPuCWN4W6Gz4v8ZgFCtgF1iFzvnV
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c02:b0:3a7:2237:1c4c with SMTP id
 e9e14a558f8ab-3a747ff8de0mr22755315ab.2.1731673100224; Fri, 15 Nov 2024
 04:18:20 -0800 (PST)
Date: Fri, 15 Nov 2024 04:18:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67373c0c.050a0220.2a2fcc.0079.GAE@google.com>
Subject: [syzbot] [iomap?] [erofs?] WARNING in iomap_iter (4)
From: syzbot <syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, djwong@kernel.org, hch@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, xiang@kernel.org
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

HEAD commit:    2d5404caa8c7 Linux 6.12-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10bee5f7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=6c0b301317aa0156f9eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b0e8c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c13ea7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a2d329b82126/disk-2d5404ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/37a04ca225dd/vmlinux-2d5404ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f837ce9d9dc/bzImage-2d5404ca.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0a46612eab9b/mount_0.gz

The issue was bisected to:

commit 001b8ccd0650727e54ec16ef72bf1b8eeab7168e
Author: Gao Xiang <hsiangkao@linux.alibaba.com>
Date:   Thu Jun 1 11:23:41 2023 +0000

    erofs: fix compact 4B support for 16k block size

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=105174e8580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=125174e8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=145174e8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com
Fixes: 001b8ccd0650 ("erofs: fix compact 4B support for 16k block size")

=======================================================
erofs: (device loop0): mounted with root inode @ nid 36.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5826 at fs/iomap/iter.c:51 iomap_iter_done fs/iomap/iter.c:51 [inline]
WARNING: CPU: 0 PID: 5826 at fs/iomap/iter.c:51 iomap_iter+0x9db/0xf60 fs/iomap/iter.c:95
Modules linked in:
CPU: 0 UID: 0 PID: 5826 Comm: syz-executor236 Not tainted 6.12.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:iomap_iter_done fs/iomap/iter.c:51 [inline]
RIP: 0010:iomap_iter+0x9db/0xf60 fs/iomap/iter.c:95
Code: 0f 0b 90 e9 0a f9 ff ff e8 92 7f 65 ff 90 0f 0b 90 e9 42 fd ff ff e8 84 7f 65 ff 90 0f 0b 90 e9 71 fd ff ff e8 76 7f 65 ff 90 <0f> 0b 90 e9 d5 fd ff ff e8 68 7f 65 ff 90 0f 0b 90 43 80 3c 2e 00
RSP: 0018:ffffc90003ce76e0 EFLAGS: 00010293
RAX: ffffffff822f5a3a RBX: 0000000000670000 RCX: ffff8880490cda00
RDX: 0000000000000000 RSI: 0000000000670000 RDI: 0000000000670000
RBP: 0000000000670000 R08: ffffffff822f580a R09: 1ffffd400024b686
R10: dffffc0000000000 R11: fffff9400024b687 R12: 1ffff9200079cf05
R13: dffffc0000000000 R14: 1ffff9200079cf04 R15: ffffc90003ce7820
FS:  000055556b307380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 000000007d26e000 CR4: 00000000003526f0
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
RIP: 0033:0x7f761d04b679
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc1fa5b488 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffc1fa5b658 RCX: 00007f761d04b679
RDX: 0000000020000040 RSI: 00000000c020660b RDI: 0000000000000004
RBP: 00007f761d0be610 R08: 0000000000000000 R09: 00007ffc1fa5b658
R10: 00000000000001f9 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc1fa5b648 R14: 0000000000000001 R15: 0000000000000001
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
