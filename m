Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3D3642441
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Dec 2022 09:14:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NQbsy35WTz3bb6
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Dec 2022 19:13:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.71; helo=mail-io1-f71.google.com; envelope-from=3o6inywkbaoqyefqgrrkxgvvoj.muumrkaykxiutzktz.ius@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=<UNKNOWN>)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NQbsr2PWqz3bW6
	for <linux-erofs@lists.ozlabs.org>; Mon,  5 Dec 2022 19:13:50 +1100 (AEDT)
Received: by mail-io1-f71.google.com with SMTP id r25-20020a6bfc19000000b006e002cb217fso3313180ioh.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 05 Dec 2022 00:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8i/wDEfc2YB2gznAkrflsfKbP/vJesSYpsaE4dlwq1A=;
        b=h6AKZrRzyPjVM4cAg/4IlkcGn9KblntExfI4gknAo5u8ZCURakk2iCDhlSeYoRqo0B
         VUFFuzrlGRtVjHB/3QJfMz1woxKYteSOKDdAXUFmv35O7gZ5MnmOJw3dNtvEMQna17kX
         aYD5agdPW/1FjfzxDABRPpP2bOswtcJ3zLuaDB0nLYYPf8/bb07s1wL0YVUS4lmn6kOk
         VUwz+BLdvsed+fqz6RYK+VjUV2YWyDfGGnud3gM3UbtrOGr9/CLVjebK2/Mt/W+SFY2h
         e3q/uXx18KW31ABSfC423z1ovCO7qwboYHX2WscfgH1ae0Iz/9iupOzpi1xZtrrp2Yo1
         Oulg==
X-Gm-Message-State: ANoB5pnDMgkvkue+OriVff8EepCWi8pcHLQgcuFjE6IzMR8UWuowKozH
	sH2UG39uFdfMjcqgBKVCBTswauNKxOL/6loBUzop2AIVWCCf
X-Google-Smtp-Source: AA0mqf6ZnVLUajD1KlarEa6U88xifCPmg3o2FVaWI7zxOYNdFJWNgPtXHhtvLx/1gzrE58+DajHHegwHyj4V4xGqBwHrjkWnMzX3
MIME-Version: 1.0
X-Received: by 2002:a92:b750:0:b0:302:f51d:9ac2 with SMTP id
 c16-20020a92b750000000b00302f51d9ac2mr21415765ilm.58.1670228027181; Mon, 05
 Dec 2022 00:13:47 -0800 (PST)
Date: Mon, 05 Dec 2022 00:13:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041127805ef10446a@google.com>
Subject: [syzbot] KASAN: use-after-free Read in z_erofs_transform_plain
From: syzbot <syzbot+2ae90e873e97f1faf6f2@syzkaller.appspotmail.com>
To: chao@kernel.org, hsiangkao@linux.alibaba.com, huyue2@coolpad.com, 
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

HEAD commit:    97ee9d1c1696 Merge tag 'block-6.1-2022-12-02' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1786b2f5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=2ae90e873e97f1faf6f2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115e5c47880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170fa3d5880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6a6a9ff34dfa/disk-97ee9d1c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a01a4182c2b/vmlinux-97ee9d1c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4371158e8c25/bzImage-97ee9d1c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/22dcea976d97/mount_0.gz

The issue was bisected to:

commit dcbe6803fffd387f72b48c2373b5f5ed12a5804b
Author: Gao Xiang <hsiangkao@linux.alibaba.com>
Date:   Thu May 12 11:58:33 2022 +0000

    erofs: fix buffer copy overflow of ztailpacking feature

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=104527bd880000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=124527bd880000
console output: https://syzkaller.appspot.com/x/log.txt?x=144527bd880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2ae90e873e97f1faf6f2@syzkaller.appspotmail.com
Fixes: dcbe6803fffd ("erofs: fix buffer copy overflow of ztailpacking feature")

loop0: detected capacity change from 0 to 16
erofs: (device loop0): mounted with root inode @ nid 36.
==================================================================
BUG: KASAN: use-after-free in z_erofs_transform_plain+0x387/0x490 fs/erofs/decompressor.c:355
Read of size 4096 at addr ffff88801d4cb000 by task syz-executor139/3634

CPU: 0 PID: 3634 Comm: syz-executor139 Not tainted 6.1.0-rc7-syzkaller-00190-g97ee9d1c1696 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 kasan_check_range+0x2a7/0x2e0 mm/kasan/generic.c:189
 memcpy+0x25/0x60 mm/kasan/shadow.c:65
 z_erofs_transform_plain+0x387/0x490 fs/erofs/decompressor.c:355
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1068 [inline]
 z_erofs_decompress_queue+0x18f9/0x2c30 fs/erofs/zdata.c:1155
 z_erofs_runqueue fs/erofs/zdata.c:1536 [inline]
 z_erofs_read_folio+0x467/0x650 fs/erofs/zdata.c:1631
 filemap_read_folio+0x187/0x7d0 mm/filemap.c:2407
 filemap_update_page+0x3ca/0x550 mm/filemap.c:2492
 filemap_get_pages+0x888/0x10d0 mm/filemap.c:2605
 filemap_read+0x3cf/0xea0 mm/filemap.c:2675
 __kernel_read+0x3fc/0x830 fs/read_write.c:428
 integrity_kernel_read+0xac/0xf0 security/integrity/iint.c:199
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x178f/0x1ca0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x444/0x8c0 security/integrity/ima/ima_api.c:292
 process_measurement+0xf4b/0x1bd0 security/integrity/ima/ima_main.c:337
 ima_file_check+0xd8/0x130 security/integrity/ima/ima_main.c:517
 do_open fs/namei.c:3559 [inline]
 path_openat+0x2642/0x2df0 fs/namei.c:3714
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8441888e59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdc2716278 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0032656c69662f2e RCX: 00007f8441888e59
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000140
R10: 00007ffdc2716140 R11: 0000000000000246 R12: 00007ffdc27162b0
R13: 00007ffdc2716390 R14: 431bde82d7b634db R15: 00007ffdc2716290
 </TASK>

Allocated by task 3606:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 __kasan_slab_alloc+0x65/0x70 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc+0x1cc/0x300 mm/slub.c:3422
 vm_area_dup+0x23/0x1b0 kernel/fork.c:466
 dup_mmap+0x833/0xfc0 kernel/fork.c:640
 dup_mm+0x8c/0x310 kernel/fork.c:1526
 copy_mm+0xcb/0x160 kernel/fork.c:1575
 copy_process+0x1998/0x4000 kernel/fork.c:2253
 kernel_clone+0x21b/0x620 kernel/fork.c:2671
 __do_sys_clone kernel/fork.c:2812 [inline]
 __se_sys_clone kernel/fork.c:2796 [inline]
 __x64_sys_clone+0x228/0x290 kernel/fork.c:2796
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 3626:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 kmem_cache_free+0x94/0x1d0 mm/slub.c:3683
 remove_vma mm/mmap.c:144 [inline]
 exit_mmap+0x40d/0x630 mm/mmap.c:3115
 __mmput+0x114/0x3b0 kernel/fork.c:1185
 exec_mmap+0x506/0x590 fs/exec.c:1035
 begin_new_exec+0x7a1/0xfc0 fs/exec.c:1294
 load_elf_binary+0x912/0x2850 fs/binfmt_elf.c:1002
 search_binary_handler fs/exec.c:1727 [inline]
 exec_binprm fs/exec.c:1768 [inline]
 bprm_execve+0x8dc/0x1590 fs/exec.c:1837
 do_execveat_common+0x598/0x750 fs/exec.c:1942
 do_execve fs/exec.c:2016 [inline]
 __do_sys_execve fs/exec.c:2092 [inline]
 __se_sys_execve fs/exec.c:2087 [inline]
 __x64_sys_execve+0x8e/0xa0 fs/exec.c:2087
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801d4cb000
 which belongs to the cache vm_area_struct of size 152
The buggy address is located 0 bytes inside of
 152-byte region [ffff88801d4cb000, ffff88801d4cb098)

The buggy address belongs to the physical page:
page:ffffea00007532c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1d4cb
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 0000000000000000 dead000000000122 ffff888140007b40
raw: 0000000000000000 0000000000120012 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 3606, tgid 3606 (dhcpcd-run-hook), ts 47464663770, free_ts 42105860719
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4291
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 alloc_slab_page+0xbd/0x190 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc+0x24c/0x300 mm/slub.c:3422
 vm_area_dup+0x23/0x1b0 kernel/fork.c:466
 dup_mmap+0x833/0xfc0 kernel/fork.c:640
 dup_mm+0x8c/0x310 kernel/fork.c:1526
 copy_mm+0xcb/0x160 kernel/fork.c:1575
 copy_process+0x1998/0x4000 kernel/fork.c:2253
 kernel_clone+0x21b/0x620 kernel/fork.c:2671
 __do_sys_clone kernel/fork.c:2812 [inline]
 __se_sys_clone kernel/fork.c:2796 [inline]
 __x64_sys_clone+0x228/0x290 kernel/fork.c:2796
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3483
 pipe_buf_release include/linux/pipe_fs_i.h:183 [inline]
 pipe_read+0x718/0x1340 fs/pipe.c:324
 call_read_iter include/linux/fs.h:2193 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x7ac/0xbf0 fs/read_write.c:470
 ksys_read+0x177/0x2a0 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88801d4caf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88801d4caf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88801d4cb000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88801d4cb080: fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb fb
 ffff88801d4cb100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
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
