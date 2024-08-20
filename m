Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FA1958064
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 09:57:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wp1z65Q6yz2yDD
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 17:57:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.200
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.200; helo=mail-il1-f200.google.com; envelope-from=3auzezgkbafaagh2s33w9s770v.y66y3wcaw9u65bw5b.u64@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wp1z13tt5z2y7K
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2024 17:57:32 +1000 (AEST)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d2df2e561so41913335ab.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2024 00:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724140650; x=1724745450;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JbNOAtInOvyXakuPD/OSUZBNPPiMvbC5OxiHM9Khf6I=;
        b=GjzJd5Jnvw5HcL5bvL8OWpohSIrsaLASBnG0m26wW1BkJEIOYv5hL4EiEImNDKZ56I
         YPeVqTKQszu39f0nBeyE/YVcCGw5DWXD5fomZc5wm0lqlbI62ZnqhMPFFxePoxelrf1w
         9bIQxN/NT1Tbco0EbBOep4/+8YvB7/DLOlU2Jr80WUl1yRjXLJK7aa1klszKYhJY6CdI
         tMtMAKQYIltB9Li5l01/xbHONdasfa2uHeThFSzhPSCLLMIHz5THUwl9GA6TSTsCjgBq
         mJHDSs+att+dnPFrXy6lkQDmbEmHW3Izf+xEAGexWmWjVWMFk0L3llbC1wG/0+TZcu1l
         GEuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt7ejJGBnJ2kCw26cyIyhPCMpKaTgk277T57/eInKHP+h5IPk+r7X51HrL4Q0qRIv+VxopOuEGwXnRoQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyi9yZv5V81rw6en2KPLmh2jVfjxemE0mulaw5MjaKNuiI36dZg
	qi2pk25kcW3iR8u37DeUQW54RQs6/X8UXDcaLRHknlZr2fWRlRAUH2ObhcW0Sc/S1RKcDo1vuvM
	ACl17MAocN2/TzhPRSbsQ/4dQ2pQYMvPtSLx2g7NbXIVY6ZohgINMxMY=
X-Google-Smtp-Source: AGHT+IH3mbHktfkn4OuNuRTHM9iCVa6hlYjCanXRGzt+Swwv1lrmj024G5+pv6Hkb8MYHrbiFfP4T92F0e9gS5IgJvTf4DaTf1Ea
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c04:b0:398:3831:4337 with SMTP id
 e9e14a558f8ab-39d26d89609mr11938475ab.5.1724140649686; Tue, 20 Aug 2024
 00:57:29 -0700 (PDT)
Date: Tue, 20 Aug 2024 00:57:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7b96e062018c6e3@google.com>
Subject: [syzbot] [erofs?] general protection fault in z_erofs_gbuf_growsize
From: syzbot <syzbot+242ee56aaa9585553766@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, huyue2@coolpad.com, 
	jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello,

syzbot found the following issue on:

HEAD commit:    1fb918967b56 Merge tag 'for-6.11-rc3-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110fcf5d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=242ee56aaa9585553766
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-1fb91896.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cd6e8883313a/vmlinux-1fb91896.xz
kernel image: https://storage.googleapis.com/syzbot-assets/87b718d2d1df/bzImage-1fb91896.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+242ee56aaa9585553766@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 16
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 0 UID: 0 PID: 5102 Comm: syz.0.0 Not tainted 6.11.0-rc3-syzkaller-00066-g1fb918967b56 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail_ex+0x3b0/0x4e0 lib/fault-inject.c:153
 should_failslab+0xac/0x100 mm/failslab.c:45
 slab_pre_alloc_hook mm/slub.c:3941 [inline]
 slab_alloc_node mm/slub.c:4017 [inline]
 kmem_cache_alloc_node_noprof+0x71/0x320 mm/slub.c:4080
 alloc_vmap_area+0x24f/0x2400 mm/vmalloc.c:1986
 __get_vm_area_node+0x1a9/0x270 mm/vmalloc.c:3119
 get_vm_area_caller mm/vmalloc.c:3170 [inline]
 vmap+0x119/0x2b0 mm/vmalloc.c:3439
 z_erofs_gbuf_growsize+0x262/0x520 fs/erofs/zutil.c:96
 z_erofs_load_lz4_config fs/erofs/decompressor.c:58 [inline]
 z_erofs_parse_cfgs+0x1e6/0x680 fs/erofs/decompressor.c:494
 erofs_read_superblock fs/erofs/super.c:357 [inline]
 erofs_fc_fill_super+0x1194/0x1730 fs/erofs/super.c:628
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe726b7b0ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe727918e68 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fe727918ef0 RCX: 00007fe726b7b0ba
RDX: 0000000020000180 RSI: 00000000200001c0 RDI: 00007fe727918eb0
RBP: 0000000020000180 R08: 00007fe727918ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00000000200001c0
R13: 00007fe727918eb0 R14: 0000000000000174 R15: 0000000020000240
 </TASK>
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 5102 Comm: syz.0.0 Not tainted 6.11.0-rc3-syzkaller-00066-g1fb918967b56 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:z_erofs_gbuf_growsize+0x45f/0x520 fs/erofs/zutil.c:114
Code: 57 dc 9e fd 48 8b 1b 48 85 db 74 44 43 80 3c 26 00 74 08 4c 89 ef e8 40 dc 9e fd 48 c1 e5 03 49 03 6d 00 48 89 e8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 ef e8 22 dc 9e fd 48 3b 5d 00 74 18 e8
RSP: 0018:ffffc90002e4f918 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffea000117ce40 RCX: ffff888020388000
RDX: ffff888020388000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff845bf21b R09: 1ffffffff26e5f27
R10: dffffc0000000000 R11: fffffbfff26e5f28 R12: dffffc0000000000
R13: ffff88803267dcc8 R14: 1ffff110064cfb99 R15: 0000000000000000
FS:  00007fe7279196c0(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc5da995ed8 CR3: 00000000369c6000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 z_erofs_load_lz4_config fs/erofs/decompressor.c:58 [inline]
 z_erofs_parse_cfgs+0x1e6/0x680 fs/erofs/decompressor.c:494
 erofs_read_superblock fs/erofs/super.c:357 [inline]
 erofs_fc_fill_super+0x1194/0x1730 fs/erofs/super.c:628
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe726b7b0ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe727918e68 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fe727918ef0 RCX: 00007fe726b7b0ba
RDX: 0000000020000180 RSI: 00000000200001c0 RDI: 00007fe727918eb0
RBP: 0000000020000180 R08: 00007fe727918ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00000000200001c0
R13: 00007fe727918eb0 R14: 0000000000000174 R15: 0000000020000240
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:z_erofs_gbuf_growsize+0x45f/0x520 fs/erofs/zutil.c:114
Code: 57 dc 9e fd 48 8b 1b 48 85 db 74 44 43 80 3c 26 00 74 08 4c 89 ef e8 40 dc 9e fd 48 c1 e5 03 49 03 6d 00 48 89 e8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 ef e8 22 dc 9e fd 48 3b 5d 00 74 18 e8
RSP: 0018:ffffc90002e4f918 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffea000117ce40 RCX: ffff888020388000
RDX: ffff888020388000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff845bf21b R09: 1ffffffff26e5f27
R10: dffffc0000000000 R11: fffffbfff26e5f28 R12: dffffc0000000000
R13: ffff88803267dcc8 R14: 1ffff110064cfb99 R15: 0000000000000000
FS:  00007fe7279196c0(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc5da995ed8 CR3: 00000000369c6000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	57                   	push   %rdi
   1:	dc 9e fd 48 8b 1b    	fcompl 0x1b8b48fd(%rsi)
   7:	48 85 db             	test   %rbx,%rbx
   a:	74 44                	je     0x50
   c:	43 80 3c 26 00       	cmpb   $0x0,(%r14,%r12,1)
  11:	74 08                	je     0x1b
  13:	4c 89 ef             	mov    %r13,%rdi
  16:	e8 40 dc 9e fd       	call   0xfd9edc5b
  1b:	48 c1 e5 03          	shl    $0x3,%rbp
  1f:	49 03 6d 00          	add    0x0(%r13),%rbp
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 ef             	mov    %rbp,%rdi
  34:	e8 22 dc 9e fd       	call   0xfd9edc5b
  39:	48 3b 5d 00          	cmp    0x0(%rbp),%rbx
  3d:	74 18                	je     0x57
  3f:	e8                   	.byte 0xe8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
