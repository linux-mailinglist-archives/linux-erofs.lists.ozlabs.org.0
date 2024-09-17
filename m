Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5064397AADD
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 06:59:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X78hq0pmxz2yN2
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 14:59:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726549177;
	cv=none; b=ONHLOzm9JLjg1bZdYQ4R4IHAgQPVF7AKmW2Ry1/0P8TS1tO6haBuNKcJbqpnZSZTOjq5PHQrsmqmdgvPzTGOwvohMFEEEVf+XB4x4vDAc3JRKifPsKh9SuBxNhKncnaBqZ7x60rQHI8yjcU9ZP2Xy8YfFb8lljbbMzAjJJ6mIS0h6sTfjFjOe4MW7x7SJd0xU8o1Yq3GaNXiUeet/qjkMYL3rXKC4TBLqEBHLrMSI7uNiKzt6WaaeO7KSqTVtp0QLBEyUdV83OaOs4bqioj8teAYpcth1sueiHlDJdrGgmLvTbBUSs5A6uIWfRf/Y9qHxQuVowDb/Tqz/QGrfZez9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726549177; c=relaxed/relaxed;
	bh=gPcssxtsyqLzduep4ooXUuQW7AYN0Kh/6amIF3Oa4fE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DGMBo20YYT6YkzacjKGB88yBobkWBa38L6ANZjbq7TxSYYd24E8DVOaZ1JtlEC4qDJxrFf6C7bM9yNQIz2VShhzcmJiN0vbOdF3b1q6Nytrj5OA8JxVpHUVNcahL2lNVIkxIdEtSNC0MWCDxUZdnDLZboodoKbXFhmipMo0gOYrFVsiFyQAZwfDGx+WpQHRaE0bYzv+sdAMvNe4GwAqVYR0iFX/XxNCxb9Pv4vQNIX/bgUH52E9OzYn6hWGga/lPitWs+Gk+pZ5q4edBFqsfHUvhHJpC3H1V/rurTwo70J5B8aNlrn0DCOmJneOIS0lsOI4nW6Y5EYF+NyQ4/mtqPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.70; helo=mail-io1-f70.google.com; envelope-from=3swzpzgkbak4gmnyozzsfoddwr.uccuzsigsfqcbhsbh.qca@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.70; helo=mail-io1-f70.google.com; envelope-from=3swzpzgkbak4gmnyozzsfoddwr.uccuzsigsfqcbhsbh.qca@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X78hm1pSDz2xfb
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 14:59:34 +1000 (AEST)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa94d4683so995628739f.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 21:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726549172; x=1727153972;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gPcssxtsyqLzduep4ooXUuQW7AYN0Kh/6amIF3Oa4fE=;
        b=ky/7sYUNPm0SrGCWsnUdKRDpQ2R6bx22SPxbeR3sE5bIZq3VHi8Boxjn6XJlqPizUu
         ljl0FhaxBJlkLOj02pnUk1Rm7o94Lsd1XhICEpQDInVX/8PlXht+aLLZmAj9So2lkTWN
         TrLiRGhb+DOhZagp/7B9GHhu7dkUGRbi7z6PN8/GRWeJZSV5lBkvsLCgw5oq5WnEnaI+
         QRWCrGt/PwMOLOy5YRRJIs9RpVkXgdk9ipVGzaD/5xXJBGq+3Q3enkKLGHU/oUKH/ZLy
         CUKdZsIS7ZyxWd7C5bD4KePgz/zGt+qoGdU5dOv0I/LgaG2OxPJ9IDqV8dUU7V3IZf1r
         UCeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNe5d7HF3GS4bvkvhb09e1IbZYZQUZXRx/WRrpKoTILkhrl3vI5fprVlDE5TD7x3q1uc6seKrprDNUew==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxqYyUO8+Z980ybCaIyEIZEI3MiuZabbwE4D5RU15MmSh6Jwz+G
	NeBbHDuzMiPkIyHIcmIjwelMNGL91USGf0numy8Aqi090XkSBGx+CY2KaCfXotaqVr9PMpPlbhJ
	vHuNAfsb8kENqyz91cSngDzjhMoepdlwIHXVWaBXlDe6krE5YLsnF/Bk=
X-Google-Smtp-Source: AGHT+IFdWMCEBYAtT2JsW8vcJq0ngnldxzQFfNwXQHfe6PBK9K8f5Tggp2K2jn4EX+SN05Gypa8ycfbKVzMqzEHE5rGW35vcTJ1P
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168c:b0:3a0:9cd5:931c with SMTP id
 e9e14a558f8ab-3a09cd595c8mr73028625ab.20.1726549171744; Mon, 16 Sep 2024
 21:59:31 -0700 (PDT)
Date: Mon, 16 Sep 2024 21:59:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011bdde0622498ee3@google.com>
Subject: [syzbot] [erofs?] [mm?] BUG: unable to handle kernel NULL pointer
 dereference in filemap_read_folio (3)
From: syzbot <syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, huyue2@coolpad.com, 
	jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
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

HEAD commit:    a430d95c5efa Merge tag 'lsm-pr-20240911' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118e68a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1653f803fffa3848
dashboard link: https://syzkaller.appspot.com/bug?extid=001306cd9c92ce0df23f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1452dc07980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158e68a9980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a430d95c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/66a65abf87c4/vmlinux-a430d95c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/09c88015f9aa/bzImage-a430d95c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/00e0bb849690/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 256
vfat: Unknown parameter 's'
./file1: Can't lookup blockdev
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 127b0067 P4D 127b0067 PUD 127b1067 PMD 0 
Oops: Oops: 0010 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5096 Comm: syz-executor418 Not tainted 6.11.0-syzkaller-02574-ga430d95c5efa #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90002d7f9f8 EFLAGS: 00010293
RAX: ffffffff81cb4ee0 RBX: 0000000000000000 RCX: ffff88801e428000
RDX: 0000000000000000 RSI: ffffea00004bfec0 RDI: 0000000000000000
RBP: ffffc90002d7fac0 R08: ffffea00004bfec7 R09: 1ffffd4000097fd8
R10: dffffc0000000000 R11: 0000000000000000 R12: ffffea00004bfec0
R13: 1ffffd4000097fd9 R14: 0000000000000000 R15: ffffea00004bfec8
FS:  000055558992f380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000011be2000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 filemap_read_folio+0x1a0/0x790 mm/filemap.c:2355
 do_read_cache_folio+0x134/0x820 mm/filemap.c:3796
 read_mapping_folio include/linux/pagemap.h:915 [inline]
 erofs_bread+0x499/0xd40 fs/erofs/data.c:41
 erofs_read_superblock fs/erofs/super.c:277 [inline]
 erofs_fc_fill_super+0x345/0x1770 fs/erofs/super.c:621
 vfs_get_super fs/super.c:1280 [inline]
 get_tree_nodev+0xb7/0x140 fs/super.c:1299
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb0eb9a7f59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff42b6ec8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 6d616e74726f6873 RCX: 00007fb0eb9a7f59
RDX: 00000000200005c0 RSI: 0000000020000580 RDI: 0000000020000540
RBP: 0031656c69662f2e R08: 0000000000000000 R09: 00005555899304c0
R10: 0000000000200000 R11: 0000000000000246 R12: 74616c785f696e75
R13: 746e6e69773d656d R14: 646578696d3d656d R15: 00007fb0eb9f103b
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90002d7f9f8 EFLAGS: 00010293
RAX: ffffffff81cb4ee0 RBX: 0000000000000000 RCX: ffff88801e428000
RDX: 0000000000000000 RSI: ffffea00004bfec0 RDI: 0000000000000000
RBP: ffffc90002d7fac0 R08: ffffea00004bfec7 R09: 1ffffd4000097fd8
R10: dffffc0000000000 R11: 0000000000000000 R12: ffffea00004bfec0
R13: 1ffffd4000097fd9 R14: 0000000000000000 R15: ffffea00004bfec8
FS:  000055558992f380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000011be2000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
