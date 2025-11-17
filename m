Return-Path: <linux-erofs+bounces-1389-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032B3C63914
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Nov 2025 11:33:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d93xV68zDz2ypw;
	Mon, 17 Nov 2025 21:33:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.207
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763375614;
	cv=none; b=Xm6f0I+YeUBqijX0Z8IMUIgkUFavxyjVeXLpjuVarzboDl8nJAAvormPU5YZWeEXyem0hw+sWTCEjM6FH1uWCol0xzMpHgkdujjC7J35Vju366quqw26+gphmSaG62y991fmQyXGbqtDt7beBsKyZRyIls/57lKKEmFLEu1XTfnTTBVjNS6W9HPnUcYO4vhSKtruf4OST3F9GgTtHxt0G1fxOmfIdb76x3C/CbNU3nFa9UWlvAi4pjplvFyJrhoObyehujwHGFoic8wvaWBHM9Qb/DoKUwuEfz5M8SGU5Xtj0nE6+Hn4OZIJZwuA7U6OImNDRbdGlLGHnhIhkece2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763375614; c=relaxed/relaxed;
	bh=geOyUl5+j2wBQBzJwdT/dXbRi2B2vNPqsuG73v+4ZUc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JrIfUnkz/tD1CAmd9OOPGWANMcFTOJVBVtxLKzATUEBQCS46sxM8enYrB66B+xUmj0oThl4iiE1/9LtcpqD4VFwqGky38Wmze+OvNylxm+7ak2AXJ1wWb2A/RPIeP/g2yF5k2DvRquLNuh2QVtFIg5O6jJq3KTdsIevG+kOwW9Mu80zEqQ5KXmuzINBUJnPqzwE2TyrYaJhhdrLRY70/k947RW05ACaoF0rje60ggeFTiu+jyWvSeL/BajaZeDq9SXWnhRgsnWiLdUGEvcNrDOoDFZmGn1eM4I8ZITJTNICdI5xB6aGQnipkIo2QsgJpwTWhdhhh+iwwSfFqE29h+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.207; helo=mail-il1-f207.google.com; envelope-from=39vkaaqkbakuxdepfqqjwfuuni.lttlqjzxjwhtsyjsy.htr@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.207; helo=mail-il1-f207.google.com; envelope-from=39vkaaqkbakuxdepfqqjwfuuni.lttlqjzxjwhtsyjsy.htr@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d93xQ3fdJz2yFy
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Nov 2025 21:33:29 +1100 (AEDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-433770ba913so45689185ab.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 17 Nov 2025 02:33:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763375606; x=1763980406;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=geOyUl5+j2wBQBzJwdT/dXbRi2B2vNPqsuG73v+4ZUc=;
        b=S7yetE9Kl/dGqqoEuEbfJEDsV9Y5+fBrsOduKTZwqeExPpsyAbZTCjWOPWO/ivZ1L9
         4ds/DrlaQqw4DGgNiYroaSpEqXRLMI9IS9x4G8rrJuzHJOqB/efKCvncG49LBa3GVaVA
         2M3+L/3MyCVyn8NH2x/zrpmSuNgT0UkE0LGuTSodb0XLd80xNCfd7O6nLMYFncIAbTLt
         9Bm8LOPs5pt9HM5aLiz6bZ2TLKh9ZfAxP0Jl7rGHpUU8A6FunvnC58C8EXrzLnn3/B4a
         DVzBBuVEhfPMIpc+cuasY2QNyllZmppx/xnYFTaZuNjtQzuWZY2ZjIUgjPK0w/g8XHZ9
         eg/g==
X-Forwarded-Encrypted: i=1; AJvYcCX9AMCkkr5PlAvqGlxD7fnMtdwkt4wfVFbjK+wYRrIuKu8Y4KJHrtIQkVSQcKFJUfu3+KkFt6minKXPJw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzX1VqgcOAD9ddAGtXt9v5zyQ8YGtCWTO3y2aaba4ullDs7Dihk
	FFqE6QK8QyICiC53FDY1pz+HUz3VjVQJQzO8hjj5NUGa8KfpfaqpK9Z9MbD8kuSZBPKjjUk3/VZ
	l68fCM0BbM2uw2JEK1LxEhc/bGanDHfOYrmeAul2NGV7+ZaC8oaTt99ww0Xc=
X-Google-Smtp-Source: AGHT+IHKdIUq357rH45TBKWOTBzfVseNE4HURYMw17nP26uf3Yyh0os5nR4aXk9/peiqY0UOn/BaIHhKmPGHTQB/iwulOyb9Pj4E
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
X-Received: by 2002:a05:6e02:2389:b0:433:330a:a572 with SMTP id
 e9e14a558f8ab-4348c8e3e5amr146999495ab.13.1763375606293; Mon, 17 Nov 2025
 02:33:26 -0800 (PST)
Date: Mon, 17 Nov 2025 02:33:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691af9f6.a70a0220.3124cb.0097.GAE@google.com>
Subject: [syzbot] [erofs?] WARNING in get_next_unlocked_entry
From: syzbot <syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, dan.j.williams@intel.com, 
	jack@suse.cz, linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, willy@infradead.org, 
	xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hello,

syzbot found the following issue on:

HEAD commit:    e927c520e1ba Merge tag 'loongarch-fixes-6.18-1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129957cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=31b8fb02cb8a25bd5e78
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16994692580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d58d32580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-e927c520.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/924fb782edf1/vmlinux-e927c520.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7e6af189c28e/bzImage-e927c520.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6a0aec9d15b8/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1740497c580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 16
erofs (device loop0): mounted with root inode @ nid 36.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5492 at fs/dax.c:224 get_next_unlocked_entry+0x329/0x340 fs/dax.c:224
Modules linked in:
CPU: 0 UID: 0 PID: 5492 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:get_next_unlocked_entry+0x329/0x340 fs/dax.c:224
Code: 45 1d 10 48 3b 84 24 c0 00 00 00 75 22 4c 89 e8 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 3e 8a f9 08 cc e8 08 59 6e ff 90 <0f> 0b 90 eb a0 e8 6d a6 f6 08 66 66 66 66 2e 0f 1f 84 00 00 00 00
RSP: 0018:ffffc90002b7e8a0 EFLAGS: 00010093
RAX: ffffffff8251ba68 RBX: 1ffff9200056fd9c RCX: ffff8880354e4900
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002b7e9b0 R08: ffffc90002b7e937 R09: 0000000000000000
R10: ffffc90002b7e900 R11: fffff5200056fd27 R12: ffffc90002b7e918
R13: ffffea00010af380 R14: ffffc90002b7e900 R15: dffffc0000000000
FS:  0000555581eb2500(0000) GS:ffff88808d730000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557f23763138 CR3: 00000000424dd000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 grab_mapping_entry+0x176/0x660 fs/dax.c:660
 dax_iomap_pte_fault fs/dax.c:1891 [inline]
 dax_iomap_fault+0x8ab/0x18d0 fs/dax.c:2080
 __do_fault+0x138/0x390 mm/memory.c:5281
 do_cow_fault mm/memory.c:5746 [inline]
 do_fault mm/memory.c:5852 [inline]
 do_pte_missing mm/memory.c:4362 [inline]
 handle_pte_fault mm/memory.c:6195 [inline]
 __handle_mm_fault+0x1719/0x5400 mm/memory.c:6336
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6505
 faultin_page mm/gup.c:1126 [inline]
 __get_user_pages+0x165c/0x2a00 mm/gup.c:1428
 __get_user_pages_locked mm/gup.c:1692 [inline]
 get_user_pages_remote+0x2f1/0xac0 mm/gup.c:2614
 uprobe_write+0x1b6/0x2160 kernel/events/uprobes.c:529
 uprobe_write_opcode+0xa8/0xf0 kernel/events/uprobes.c:493
 set_swbp+0x121/0x290 arch/x86/kernel/uprobes.c:1090
 install_breakpoint+0x451/0x5a0 kernel/events/uprobes.c:1170
 register_for_each_vma+0xabb/0xc30 kernel/events/uprobes.c:1315
 uprobe_apply+0xfb/0x270 kernel/events/uprobes.c:1459
 uprobe_perf_open kernel/trace/trace_uprobe.c:1371 [inline]
 trace_uprobe_register+0x4df/0x560 kernel/trace/trace_uprobe.c:1533
 perf_trace_event_open kernel/trace/trace_event_perf.c:184 [inline]
 perf_trace_event_init+0x19a/0x9d0 kernel/trace/trace_event_perf.c:206
 perf_uprobe_init+0x12e/0x1a0 kernel/trace/trace_event_perf.c:332
 perf_uprobe_event_init+0xe6/0x180 kernel/events/core.c:11170
 perf_try_init_event+0x17f/0x870 kernel/events/core.c:12615
 perf_init_event kernel/events/core.c:12713 [inline]
 perf_event_alloc+0x133e/0x2be0 kernel/events/core.c:12988
 __do_sys_perf_event_open kernel/events/core.c:13506 [inline]
 __se_sys_perf_event_open+0x772/0x1d70 kernel/events/core.c:13387
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe38998f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe19690378 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007fe389be5fa0 RCX: 00007fe38998f6c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00002000000000c0
RBP: 00007fe389a11f91 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe389be5fa0 R14: 00007fe389be5fa0 R15: 0000000000000005
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

