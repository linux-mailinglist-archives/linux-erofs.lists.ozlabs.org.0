Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EBB8455EF
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Feb 2024 12:04:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TQbdm633Gz3cYR
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Feb 2024 22:04:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.69; helo=mail-io1-f69.google.com; envelope-from=3whq7zqkbanclrsd3ee7k3iib6.9hh9e7nl7k5hgm7gm.5hf@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TQbdd5KQMz3cT9
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Feb 2024 22:04:36 +1100 (AEDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c00a026be0so51347239f.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Feb 2024 03:04:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706785473; x=1707390273;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KOgw1X/RjO2qY7mbi0g6Lpuo4wnW0AiomOH11xZArzA=;
        b=BijA9DOjtkkv6xOLmqFfuAoGEE+ccSBrSMQNLC5sB6g0yF08YLWaScZ3/8hbAD7Boe
         flLubeugotB0MMf5CEeLTGwjs7VUw8i6wQ6GwrrgJkmYs+dWebdbfxds3P3ZYQNvgPJU
         xg+cQ4LES/VP5hDD9Xqv9dvfSjBEaFDlLxYBx0AHwYFXeXMXOVS5Yulfgk9wMA76Y503
         JLI0hzpNK4KmuB+JrTT1xtLy1jaMURSsBEvinaits0wiLRc2CB2JZ2M28zLkigQ2NllN
         xNkn61w/xB/9uaymOlUu0SEQhQU2Oqeooj9JDXZQmelLFi1P9mW6xVfV5+I6HnZHK3Qt
         cofA==
X-Gm-Message-State: AOJu0YyL1QgHYIBMOpgUpStCNumnjIOLXabwE7JbJ1qg/2ZVBQ3uDuew
	jIaxYX4a1tofNYU2+oowL3d4gEqdILyg0NbJFSqafIaZelmZYCbsh6/x9Bp7tak3x7WJgWDu5vC
	HyReaoy+4ev0ZXm3iJkKfJ5Ga4T6o7qlegQ4odAxwoPdBw5CJy91Gr4c=
X-Google-Smtp-Source: AGHT+IGSvQ9NEhTwC/p43OdXZF/lx8bAQEKZKtep8GvhOUc2UNSoU8bMtMnlTR+zOtB4DfU93PCFzT/d7I54JnEnJ5YEkXdMnsda
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bc3:b0:363:9176:c9f9 with SMTP id
 x3-20020a056e021bc300b003639176c9f9mr163528ilv.4.1706785472863; Thu, 01 Feb
 2024 03:04:32 -0800 (PST)
Date: Thu, 01 Feb 2024 03:04:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1668406104ff51e@google.com>
Subject: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (3)
From: syzbot <syzbot+88ad8b0517a9d3bb9dc8@syzkaller.appspotmail.com>
To: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
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

HEAD commit:    9f8413c4a66f Merge tag 'cgroup-for-6.8' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13d26b1fe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
dashboard link: https://syzkaller.appspot.com/bug?extid=88ad8b0517a9d3bb9dc8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11377218180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111fd038180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/79d9f2f4b065/disk-9f8413c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cbc68430d9c6/vmlinux-9f8413c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9740ad9fc172/bzImage-9f8413c4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2f79f30d7608/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+88ad8b0517a9d3bb9dc8@syzkaller.appspotmail.com

erofs: (device loop0): z_erofs_lz4_decompress_mem: failed to decompress -42 in[46, 0] out[9000]
=====================================================
BUG: KMSAN: uninit-value in hex_dump_to_buffer+0xae9/0x10f0 lib/hexdump.c:194
 hex_dump_to_buffer+0xae9/0x10f0 lib/hexdump.c:194
 print_hex_dump+0x13d/0x3e0 lib/hexdump.c:276
 z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:252 [inline]
 z_erofs_lz4_decompress+0x257e/0x2a70 fs/erofs/decompressor.c:311
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1290 [inline]
 z_erofs_decompress_queue+0x338c/0x6460 fs/erofs/zdata.c:1372
 z_erofs_decompressqueue_work+0x57/0x70 fs/erofs/zdata.c:1387
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2706
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2787
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was created at:
 __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages mm/mempolicy.c:2204 [inline]
 folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
 filemap_alloc_folio+0xa5/0x430 mm/filemap.c:974
 page_cache_ra_unbounded+0x2cc/0x960 mm/readahead.c:247
 do_page_cache_ra mm/readahead.c:299 [inline]
 page_cache_ra_order+0xfeb/0x10a0 mm/readahead.c:546
 ondemand_readahead+0x132b/0x1710 mm/readahead.c:668
 page_cache_sync_ra+0x724/0x760 mm/readahead.c:695
 page_cache_sync_readahead include/linux/pagemap.h:1283 [inline]
 filemap_get_pages+0x4c7/0x2c90 mm/filemap.c:2497
 filemap_read+0x59e/0x14d0 mm/filemap.c:2593
 generic_file_read_iter+0x136/0xad0 mm/filemap.c:2781
 __kernel_read+0x3bb/0x9e0 fs/read_write.c:434
 integrity_kernel_read+0x77/0x90 security/integrity/iint.c:221
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1743/0x3cc0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
 process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3624 [inline]
 path_openat+0x4d05/0x5ac0 fs/namei.c:3779
 do_filp_open+0x20d/0x590 fs/namei.c:3806
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 4393 Comm: kworker/u5:1 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: erofs_worker z_erofs_decompressqueue_work
=====================================================


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
