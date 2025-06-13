Return-Path: <linux-erofs+bounces-402-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 36808AD98B2
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jun 2025 01:30:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJwcZ6Hm7z2xjN;
	Sat, 14 Jun 2025 09:30:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.206
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749857438;
	cv=none; b=G8EtAvAzMcfsdZNIdzca8RMwmuKFQpanmE7ZOsHq8YCcVDpngS7bX1I2oSk3ViHI34M38CtkMBPZDLyBUH8eOS1iQwl9r5n09lm8VbwMWyKLUKOz+nmld+/evZxDTXWh3TMlKEoZMJVy5ZO1fmwgDTJHrwfdbb2tNR1CXwsGNxC/0k3bNiFUBkseUsSooVGhDszdfpioLFr0Dc4Li9Qxp13lMFaFesJXqpx52RLsC+OpHCJLqNNzOytFAI3+1qAnh1HO5ScrRlFKTARVT6a1bMTVEkzgY0TxFgaGgCJYGWWfUR77Elm67qC/U8Z4W588l43XwPZfTdHK12k1Fs/e7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749857438; c=relaxed/relaxed;
	bh=vF7xs1A3Q2dAycwY5p/OJbr9P/yojYK9Yt6rhyL/AFs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PRBHA31HGKWuJcbY5nc7CuePgM7zK212BxyYjQihPG4uQaTtelRlfCxpia4yUL4wG9E7VBcfNla9XC2/j8YPHQ9e/jk4Cyr/X7GbzfEpbgZSST1WRYDmRQ5tL2ZHpQL/cacS0Fm9G7HakQeLoOC89ka8qziNxOxZe34BctrSH6WW/W9Rp0YSbXpP4Bs2nmuob+PXSEgMBbd0rXYyAQAgtJZcDSLcL5qZrdkPgInji+wMpGY51/c7/y28YP4haCvL9DDWbG08Yus8J2nDXMrO8DBNnMbeDRve7b8kdmsm07fMJ7l5PjPqag0cV84Z24PWQ/5MzDchtVjCPBQ/Qpm2Qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.206; helo=mail-il1-f206.google.com; envelope-from=3mbrmaakbah4u01mcnngtcrrkf.iqqingwugteqpvgpv.eqo@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.206; helo=mail-il1-f206.google.com; envelope-from=3mbrmaakbah4u01mcnngtcrrkf.iqqingwugteqpvgpv.eqo@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJwcY0bQVz2xgp
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Jun 2025 09:30:36 +1000 (AEST)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddc0a6d4bdso36432455ab.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 13 Jun 2025 16:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749857434; x=1750462234;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vF7xs1A3Q2dAycwY5p/OJbr9P/yojYK9Yt6rhyL/AFs=;
        b=f84voP0p2C989adDK8OafuCLbxEgNIRghTpgQsdVJ7myrT6EnCbmaGVhfovtCohsMa
         CVgPH/b5AXdSFQ6JJSDqzKxmWnvAAp7nNVs8ebt2Z1Ui4QAUIEsAIzvJtIBwOGHArxOB
         gvTnAceAPenNAvKHVXbJlj+3SFXqAdlvBHQ0/2XTzwy/w9FXbv1Y/krKenqjXZaxlUuO
         jtOJg6dWY13eKRcgz0F32gT/LZPg7MRx2ExAkSSiLILZh4g5NL8ybN56z8xiwj1Uaikr
         bBhJgoivlxJwBS4VSqIIdDdVlyMOOGIjYOMMinCeM2rTosdOfcWbZoH9gqnvL/73Y1wv
         j+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQo7Ku1+2zUeybkw8FSaWENsYSYyQSjSaMNvBrFmbTxSvtl51U2Dc0jDZdbkgEnSiKBxIctn2ODL2xWw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxwZecXlQHloONL/59arhgRNf4EyzKyAn6KqcdGYpTHhIqy/oxR
	ZGDxGeczm4iiY0uP9FCXhxundP9jJ0k3lhnZcNyJxSI3Ex8HELqzoLEg6AqBGbHuG7Q/eJzgA5x
	PZxuagPoHo8YgSwMLbdmKR/RB/M24nf7VEbCIpcKnqfgkvIQS5je2ZY4LIRo=
X-Google-Smtp-Source: AGHT+IGRAA9OJyHdZx3olCjGPopW4j7o8RyPYuTFqvQIi0A6jUryimHBx8pugZDlISqy0X3182xYzFab7qTndPBx+vXNFNIaT6dB
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168b:b0:3dc:7cc1:b731 with SMTP id
 e9e14a558f8ab-3de07c21db4mr17551605ab.0.1749857433818; Fri, 13 Jun 2025
 16:30:33 -0700 (PDT)
Date: Fri, 13 Jun 2025 16:30:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684cb499.a00a0220.c6bd7.0010.GAE@google.com>
Subject: [syzbot] [iomap?] [erofs?] WARNING in iomap_iter (5)
From: syzbot <syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, djwong@kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hello,

syzbot found the following issue on:

HEAD commit:    27605c8c0f69 Merge tag 'net-6.16-rc2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171079d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a936e3316f9e2dc
dashboard link: https://syzkaller.appspot.com/bug?extid=d8f000c609f05f52d9b5
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1725310c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115e0e82580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-27605c8c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c55edb669703/vmlinux-27605c8c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e12830584492/bzImage-27605c8c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/36391cabb242/mount_2.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=165e0e82580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com

erofs (device loop0): EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!
erofs (device loop0): mounted with root inode @ nid 36.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5317 at fs/iomap/iter.c:33 iomap_iter_done fs/iomap/iter.c:33 [inline]
WARNING: CPU: 0 PID: 5317 at fs/iomap/iter.c:33 iomap_iter+0x87c/0xdf0 fs/iomap/iter.c:113
Modules linked in:
CPU: 0 UID: 0 PID: 5317 Comm: syz-executor245 Not tainted 6.16.0-rc1-syzkaller-00101-g27605c8c0f69 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:iomap_iter_done fs/iomap/iter.c:33 [inline]
RIP: 0010:iomap_iter+0x87c/0xdf0 fs/iomap/iter.c:113
Code: cc cc cc e8 a6 eb 6b ff 90 0f 0b 90 e9 31 f8 ff ff e8 98 eb 6b ff 90 0f 0b 90 bd fb ff ff ff e9 ad fb ff ff e8 85 eb 6b ff 90 <0f> 0b 90 e9 22 fd ff ff e8 77 eb 6b ff 90 0f 0b 90 e9 53 fd ff ff
RSP: 0018:ffffc9000d08f808 EFLAGS: 00010293
RAX: ffffffff8254736b RBX: ffffc9000d08f920 RCX: ffff88803a692440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000074
RBP: 1ffff92001a11f2a R08: ffffea00010c5277 R09: 1ffffd4000218a4e
R10: dffffc0000000000 R11: fffff94000218a4f R12: 0000000000000074
R13: 0000000000000000 R14: ffffc9000d08f950 R15: 1ffff92001a11f25
FS:  0000555562dab380(0000) GS:ffff88808d252000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffeb97cc968 CR3: 0000000043323000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iomap_fiemap+0x117/0x530 fs/iomap/fiemap.c:79
 ioctl_fiemap fs/ioctl.c:220 [inline]
 do_vfs_ioctl+0x16d3/0x1990 fs/ioctl.c:841
 __do_sys_ioctl fs/ioctl.c:905 [inline]
 __se_sys_ioctl+0x82/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbc6028fe59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffccc462b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbc6028fe59
RDX: 0000200000000580 RSI: 00000000c020660b RDI: 0000000000000005
RBP: 00007fbc603045f0 R08: 0000555562dac4c0 R09: 0000555562dac4c0
R10: 00000000000001ca R11: 0000000000000246 R12: 00007ffccc462b90
R13: 00007ffccc462db8 R14: 431bde82d7b634db R15: 00007fbc602d903b
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

