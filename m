Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6564843FEC4
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 16:55:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hglpv0YlDz2ypZ
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Oct 2021 01:55:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
 (client-ip=209.85.166.72; helo=mail-io1-f72.google.com;
 envelope-from=3xwt8yqkbahgouvgwhhanwllez.ckkchaqoanykjpajp.yki@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com;
 receiver=<UNKNOWN>)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hglpq5GVdz2xr5
 for <linux-erofs@lists.ozlabs.org>; Sat, 30 Oct 2021 01:55:30 +1100 (AEDT)
Received: by mail-io1-f72.google.com with SMTP id
 x21-20020a0566022c5500b005ddd625f399so6870648iov.3
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Oct 2021 07:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
 bh=Nc6eX6JxrBpodsbbP9rc/IvjwCtF/vxxtgIRwubdq1g=;
 b=sGAKTn94e3D+AEuNKcbxa2WcyE6cjdtGaPZ80dKXRfUNu63YdWgaZhKspx1s6feJlz
 xm83ClJzfoJD6w/6qv31Ll4jtQCIDO65sjDscRzmDMcsYYwHvBa8HP8hi0FLm7zA01yD
 spX97mKsOnrEXXeN+ygfyzEuCfIOcr9fT07at1m6Bo7/cctQmNDjGsrLp4LNCcQLDAMZ
 WPtk7KjcwyIU+80KhBtbBgR7TQeQHQVf1NFc7QmR7veGB2A3v2NQuBEQIsLZ4VoIrnhj
 FkajigMDQc/Xw1PIQinlYzWj/iA8CXEPFZNvAQiR+QbalZO+pGOEAxblVh8cJZxrCuVW
 A2yQ==
X-Gm-Message-State: AOAM530eGryrf0mB5W55FIOh0tHrP18+2aa/rQuRHJXRfYKQSVUpQJM1
 /RlKiRPrR4G9Mc9cd2K5DmKmwjLjuQtwX21Pa9YghBpSMfPp
X-Google-Smtp-Source: ABdhPJzr5U/5+ySyD7OcHEbSRzLjiyj5aoj6n/nbMvJctfo85r247GhnxBcu3wCfQstkQ9vGrIF8++emiyBUi4InUhcZhq7lw2iT
MIME-Version: 1.0
X-Received: by 2002:a02:cac8:: with SMTP id f8mr8615519jap.65.1635519327045;
 Fri, 29 Oct 2021 07:55:27 -0700 (PDT)
Date: Fri, 29 Oct 2021 07:55:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000830d1205cf7f0477@google.com>
Subject: [syzbot] KASAN: use-after-free Read in LZ4_decompress_safe_partial
From: syzbot <syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com>
To: chao@kernel.org, gaoxiang25@huawei.com, gregkh@linuxfoundation.org, 
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
 viro@zeniv.linux.org.uk, xiang@kernel.org, yuchao0@huawei.com
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

HEAD commit:    87066fdd2e30 Revert "mm/secretmem: use refcount_t instead ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10c2c88cb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59f3ef2b4077575
dashboard link: https://syzkaller.appspot.com/bug?extid=63d688f1d899c588fb71
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17032c4ab00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170f8c3cb00000

The issue was bisected to:

commit f86cf25a609107960cf05263e491463feaae1f99
Author: Gao Xiang <gaoxiang25@huawei.com>
Date:   Tue Aug 28 03:39:48 2018 +0000

    Revert "staging: erofs: disable compiling temporarile"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11de0328b00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13de0328b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15de0328b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com
Fixes: f86cf25a6091 ("Revert "staging: erofs: disable compiling temporarile"")

==================================================================
BUG: KASAN: use-after-free in get_unaligned_le16 include/asm-generic/unaligned.h:27 [inline]
BUG: KASAN: use-after-free in LZ4_readLE16 lib/lz4/lz4defs.h:132 [inline]
BUG: KASAN: use-after-free in LZ4_decompress_generic lib/lz4/lz4_decompress.c:285 [inline]
BUG: KASAN: use-after-free in LZ4_decompress_safe_partial+0xff8/0x1580 lib/lz4/lz4_decompress.c:469
Read of size 2 at addr ffff88806dd1f000 by task kworker/u5:0/150

CPU: 1 PID: 150 Comm: kworker/u5:0 Not tainted 5.15.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: erofs_unzipd z_erofs_decompressqueue_work
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 print_address_description+0x66/0x3e0 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report+0x19a/0x1f0 mm/kasan/report.c:459
 get_unaligned_le16 include/asm-generic/unaligned.h:27 [inline]
 LZ4_readLE16 lib/lz4/lz4defs.h:132 [inline]
 LZ4_decompress_generic lib/lz4/lz4_decompress.c:285 [inline]
 LZ4_decompress_safe_partial+0xff8/0x1580 lib/lz4/lz4_decompress.c:469
 z_erofs_lz4_decompress+0x4c3/0x1100 fs/erofs/decompressor.c:226
 z_erofs_decompress_generic fs/erofs/decompressor.c:354 [inline]
 z_erofs_decompress+0xa8e/0xe30 fs/erofs/decompressor.c:407
 z_erofs_decompress_pcluster+0x15e4/0x2550 fs/erofs/zdata.c:977
 z_erofs_decompress_queue fs/erofs/zdata.c:1055 [inline]
 z_erofs_decompressqueue_work+0x123/0x1a0 fs/erofs/zdata.c:1066
 process_one_work+0x853/0x1140 kernel/workqueue.c:2297
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2444
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30

The buggy address belongs to the page:
page:ffffea0001b747c0 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x6dd1f
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001b74408 ffffea0001b74ac8 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x1100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), pid 6527, ts 51734930672, free_ts 51749499849
 prep_new_page mm/page_alloc.c:2424 [inline]
 get_page_from_freelist+0x779/0xa30 mm/page_alloc.c:4153
 __alloc_pages+0x255/0x580 mm/page_alloc.c:5375
 alloc_pages_vma+0x668/0x1030 mm/mempolicy.c:2152
 do_anonymous_page+0x31b/0x14b0 mm/memory.c:3768
 handle_pte_fault mm/memory.c:4557 [inline]
 __handle_mm_fault mm/memory.c:4694 [inline]
 handle_mm_fault+0x1860/0x2560 mm/memory.c:4792
 do_user_addr_fault+0x8ce/0x10c0 arch/x86/mm/fault.c:1397
 handle_page_fault arch/x86/mm/fault.c:1485 [inline]
 exc_page_fault+0xa1/0x1e0 arch/x86/mm/fault.c:1541
 asm_exc_page_fault+0x1e/0x30
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0xc29/0xd20 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3315 [inline]
 free_unref_page_list+0x11f/0xa50 mm/page_alloc.c:3431
 release_pages+0x18cb/0x1b00 mm/swap.c:963
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu+0x780/0x910 mm/mmu_gather.c:249
 tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:340
 exit_mmap+0x3dd/0x6f0 mm/mmap.c:3173
 __mmput+0x111/0x3a0 kernel/fork.c:1115
 exec_mmap+0x53e/0x640 fs/exec.c:1030
 begin_new_exec+0x6c9/0x1180 fs/exec.c:1288
 load_elf_binary+0x836/0x3bc0 fs/binfmt_elf.c:1001
 search_binary_handler fs/exec.c:1725 [inline]
 exec_binprm fs/exec.c:1766 [inline]
 bprm_execve+0x8eb/0x1470 fs/exec.c:1835
 do_execveat_common+0x44c/0x590 fs/exec.c:1924
 do_execve fs/exec.c:1992 [inline]
 __do_sys_execve fs/exec.c:2068 [inline]
 __se_sys_execve fs/exec.c:2063 [inline]
 __x64_sys_execve+0x8e/0xa0 fs/exec.c:2063
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff88806dd1ef00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88806dd1ef80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88806dd1f000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88806dd1f080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88806dd1f100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
