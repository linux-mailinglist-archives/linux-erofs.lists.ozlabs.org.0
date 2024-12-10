Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7193C9EA445
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Dec 2024 02:26:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y6h0V21D8z2yk6
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Dec 2024 12:26:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733794008;
	cv=none; b=EY/57/FqlcOiyzngivbduEk45+eeRx/yGlh8YQQCrPJY+OIbTLIPSeYwjRpk6Y+oo88IJmJpyuiMDVKlWAXRmSOAyxILZDVthRXmyFtUUNzC3mmBE7q9IWVjJcMTCN9matl9czRG5i42gaSlQ/+M8zYC5mZgazuZ5bkuW2RISZYwkaVIBX0asKBULXYT8UATsrCJ5GTk9Tz8f+o3zMspwhpTlbCB43wviZIVFrkCd2ZY0kkW92VSfG8JBq7ltFW0HA+LNwwHVKTnUCEV2eONbPWckwVrvLbos4cz/KAMrH8xOzTvJtt/T8U07v7rHn0A9G+D2jpyJL4CDV4NowCygA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733794008; c=relaxed/relaxed;
	bh=9PUBfpN0x7TmLF+kQOlj98hjCOpBNDzdn8kWGsEAPCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A/Pr7+DYP7CKtUFkFf9KtnGntG6CIQsz/CVawUsZo6NDIDyn9rFktJLeWk37bKLBIhCDKwL0ZzYql0IjpKHWT1ceh+04oCtSjycLNKKt4yNmtQJ7fI3tGruGaCnShjPC9acjzqd8GAqNmywuUTr/44wWeOgM+0fqFFeF9i9y+JCFUcz8uQuqWtHomCzKiWly7IK/t0bJZmsdKKVk3bqYKzZUz+bv+Uj80Puk550OfR5D9Gc6wap1JKFGTjWVWEzEt6QpDolPy6tzuhYjGUrVBfagfUF3u7Cd12sS19zeqkAn+sX2F2CoaDyPr8QMWBtLHKTx2lvU/gzJWegV7jac8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=D0ZIB9EM; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=D0ZIB9EM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y6h0N1sh2z2xHY
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Dec 2024 12:26:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733793993; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9PUBfpN0x7TmLF+kQOlj98hjCOpBNDzdn8kWGsEAPCc=;
	b=D0ZIB9EMm9cOsUOBaHnuZm0f7DHfpXgg0AhG9f80Y/Awd8UXOSscyvrI82eg7svNNNBjEIGDAVjoCC1lcA4Hw8scLbH/2i2wKJQnSmhBzOBTavZqH58SqcUPtbbeD7UUN5YjKpt1XTYwaLOMUhCr0v0Wp0KEBPRpkDDi036/R3I=
Received: from 30.170.86.122(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLD03BA_1733793983 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Dec 2024 09:26:31 +0800
Message-ID: <7986d9f5-10d9-4c29-a39b-6bebc68e3229@linux.alibaba.com>
Date: Tue, 10 Dec 2024 09:26:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] KASAN: slab-use-after-free Read in
 z_erofs_put_pcluster
To: syzbot <syzbot+06bfc1fda6094b0755f0@syzkaller.appspotmail.com>,
 chao@kernel.org, dhavale@google.com, huyue2@coolpad.com,
 jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 xiang@kernel.org
References: <6756d2f0.050a0220.2477f.0040.GAE@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <6756d2f0.050a0220.2477f.0040.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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

#syz dup: KASAN: slab-use-after-free Read in z_erofs_decompress_queue

On 2024/12/9 19:22, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b86545e02e8c Merge tag 'acpi-6.13-rc1-2' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=137b1f5f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e550a68d9f2e11a3
> dashboard link: https://syzkaller.appspot.com/bug?extid=06bfc1fda6094b0755f0
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f4d196047218/disk-b86545e0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/be50bc18d79a/vmlinux-b86545e0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8b6adb7024e6/bzImage-b86545e0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+06bfc1fda6094b0755f0@syzkaller.appspotmail.com
> 
> erofs (device loop4): failed to decompress -26 in[46, 0] out[9000]
> ==================================================================
> BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
> BUG: KASAN: slab-use-after-free in queued_spin_trylock include/asm-generic/qspinlock.h:92 [inline]
> BUG: KASAN: slab-use-after-free in do_raw_spin_trylock+0x66/0x180 kernel/locking/spinlock_debug.c:123
> Read of size 4 at addr ffff888034ece0b0 by task kworker/u9:5/5868
> 
> CPU: 0 UID: 0 PID: 5868 Comm: kworker/u9:5 Not tainted 6.12.0-syzkaller-10553-gb86545e02e8c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: erofs_worker z_erofs_decompressqueue_work
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:378 [inline]
>   print_report+0xc3/0x620 mm/kasan/report.c:489
>   kasan_report+0xd9/0x110 mm/kasan/report.c:602
>   check_region_inline mm/kasan/generic.c:183 [inline]
>   kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
>   instrument_atomic_read include/linux/instrumented.h:68 [inline]
>   atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
>   queued_spin_trylock include/asm-generic/qspinlock.h:92 [inline]
>   do_raw_spin_trylock+0x66/0x180 kernel/locking/spinlock_debug.c:123
>   __raw_spin_trylock include/linux/spinlock_api_smp.h:89 [inline]
>   _raw_spin_trylock+0x1b/0x80 kernel/locking/spinlock.c:138
>   spin_trylock include/linux/spinlock.h:361 [inline]
>   z_erofs_put_pcluster.part.0+0x112/0x200 fs/erofs/zdata.c:959
>   z_erofs_put_pcluster fs/erofs/zdata.c:1403 [inline]
>   z_erofs_decompress_pcluster fs/erofs/zdata.c:1403 [inline]
>   z_erofs_decompress_queue+0x226a/0x27f0 fs/erofs/zdata.c:1425
>   z_erofs_decompressqueue_work+0x77/0xb0 fs/erofs/zdata.c:1437
>   process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
>   process_scheduled_works kernel/workqueue.c:3310 [inline]
>   worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
>   kthread+0x2c4/0x3a0 kernel/kthread.c:389
>   ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>   </TASK>
> 
> Allocated by task 9350:
>   kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>   poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>   __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
>   kmalloc_noprof include/linux/slab.h:901 [inline]
>   kzalloc_noprof include/linux/slab.h:1037 [inline]
>   erofs_init_fs_context+0x47/0x3a0 fs/erofs/super.c:790
>   alloc_fs_context+0x54d/0x9c0 fs/fs_context.c:318
>   do_new_mount fs/namespace.c:3486 [inline]
>   path_mount+0xb08/0x1f20 fs/namespace.c:3834
>   do_mount fs/namespace.c:3847 [inline]
>   __do_sys_mount fs/namespace.c:4057 [inline]
>   __se_sys_mount fs/namespace.c:4034 [inline]
>   __x64_sys_mount+0x294/0x320 fs/namespace.c:4034
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 5850:
>   kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>   kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
>   poison_slab_object mm/kasan/common.c:247 [inline]
>   __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
>   kasan_slab_free include/linux/kasan.h:233 [inline]
>   slab_free_hook mm/slub.c:2338 [inline]
>   slab_free mm/slub.c:4598 [inline]
>   kfree+0x14f/0x4b0 mm/slub.c:4746
>   erofs_kill_sb+0x1a5/0x240 fs/erofs/super.c:824
>   deactivate_locked_super+0xc1/0x1a0 fs/super.c:473
>   deactivate_super+0xde/0x100 fs/super.c:506
>   cleanup_mnt+0x222/0x450 fs/namespace.c:1373
>   task_work_run+0x151/0x250 kernel/task_work.c:239
>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>   exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>   exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>   syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
>   do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff888034ece000
>   which belongs to the cache kmalloc-1k of size 1024
> The buggy address is located 176 bytes inside of
>   freed 1024-byte region [ffff888034ece000, ffff888034ece400)
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x34ec8
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000040 ffff88801b041dc0 0000000000000000 dead000000000001
> raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
> head: 00fff00000000040 ffff88801b041dc0 0000000000000000 dead000000000001
> head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
> head: 00fff00000000003 ffffea0000d3b201 ffffffffffffffff 0000000000000000
> head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 6062, tgid 6062 (kworker/u8:10), ts 164036055360, free_ts 158527873125
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
>   prep_new_page mm/page_alloc.c:1564 [inline]
>   get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
>   __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4751
>   alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
>   alloc_slab_page mm/slub.c:2408 [inline]
>   allocate_slab mm/slub.c:2574 [inline]
>   new_slab+0x2c9/0x410 mm/slub.c:2627
>   ___slab_alloc+0xdac/0x1870 mm/slub.c:3815
>   __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3905
>   __slab_alloc_node mm/slub.c:3980 [inline]
>   slab_alloc_node mm/slub.c:4141 [inline]
>   __do_kmalloc_node mm/slub.c:4282 [inline]
>   __kmalloc_noprof+0x2ec/0x510 mm/slub.c:4295
>   kmalloc_noprof include/linux/slab.h:905 [inline]
>   kzalloc_noprof include/linux/slab.h:1037 [inline]
>   ieee802_11_parse_elems_full+0xea/0x1680 net/mac80211/parse.c:958
>   ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2386 [inline]
>   ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2393 [inline]
>   ieee80211_inform_bss+0xfd/0x1100 net/mac80211/scan.c:79
>   rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
>   cfg80211_inform_single_bss_data+0x8f9/0x1de0 net/wireless/scan.c:2334
>   cfg80211_inform_bss_data+0x205/0x3ba0 net/wireless/scan.c:3189
>   cfg80211_inform_bss_frame_data+0x272/0x7a0 net/wireless/scan.c:3284
>   ieee80211_bss_info_update+0x311/0xab0 net/mac80211/scan.c:226
>   ieee80211_rx_bss_info net/mac80211/ibss.c:1101 [inline]
>   ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1580 [inline]
>   ieee80211_ibss_rx_queued_mgmt+0x189c/0x2f50 net/mac80211/ibss.c:1607
>   ieee80211_iface_process_skb net/mac80211/iface.c:1616 [inline]
>   ieee80211_iface_work+0xc0b/0xf00 net/mac80211/iface.c:1670
> page last free pid 6620 tgid 6619 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1127 [inline]
>   free_unref_page+0x661/0x1080 mm/page_alloc.c:2657
>   __put_partials+0x14c/0x170 mm/slub.c:3142
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:250 [inline]
>   slab_post_alloc_hook mm/slub.c:4104 [inline]
>   slab_alloc_node mm/slub.c:4153 [inline]
>   __do_kmalloc_node mm/slub.c:4282 [inline]
>   __kmalloc_noprof+0x1cd/0x510 mm/slub.c:4295
>   kmalloc_noprof include/linux/slab.h:905 [inline]
>   tomoyo_realpath_from_path+0xb9/0x720 security/tomoyo/realpath.c:251
>   tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>   tomoyo_path_number_perm+0x248/0x590 security/tomoyo/file.c:723
>   security_file_ioctl+0x9b/0x240 security/security.c:2908
>   __do_sys_ioctl fs/ioctl.c:900 [inline]
>   __se_sys_ioctl fs/ioctl.c:892 [inline]
>   __x64_sys_ioctl+0xb7/0x200 fs/ioctl.c:892
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Memory state around the buggy address:
>   ffff888034ecdf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff888034ece000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff888034ece080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                       ^
>   ffff888034ece100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff888034ece180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> ==================================================================
> BUG: KASAN: slab-use-after-free in arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
> BUG: KASAN: slab-use-after-free in raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
> BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
> BUG: KASAN: slab-use-after-free in queued_spin_trylock include/asm-generic/qspinlock.h:92 [inline]
> BUG: KASAN: slab-use-after-free in do_raw_spin_trylock+0x164/0x180 kernel/locking/spinlock_debug.c:123
> Read of size 4 at addr ffff888034ece0b0 by task kworker/u9:5/5868
> 
> CPU: 0 UID: 0 PID: 5868 Comm: kworker/u9:5 Tainted: G    B              6.12.0-syzkaller-10553-gb86545e02e8c #0
> Tainted: [B]=BAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: erofs_worker z_erofs_decompressqueue_work
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:378 [inline]
>   print_report+0xc3/0x620 mm/kasan/report.c:489
>   kasan_report+0xd9/0x110 mm/kasan/report.c:602
>   arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
>   raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
>   atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
>   queued_spin_trylock include/asm-generic/qspinlock.h:92 [inline]
>   do_raw_spin_trylock+0x164/0x180 kernel/locking/spinlock_debug.c:123
>   __raw_spin_trylock include/linux/spinlock_api_smp.h:89 [inline]
>   _raw_spin_trylock+0x1b/0x80 kernel/locking/spinlock.c:138
>   spin_trylock include/linux/spinlock.h:361 [inline]
>   z_erofs_put_pcluster.part.0+0x112/0x200 fs/erofs/zdata.c:959
>   z_erofs_put_pcluster fs/erofs/zdata.c:1403 [inline]
>   z_erofs_decompress_pcluster fs/erofs/zdata.c:1403 [inline]
>   z_erofs_decompress_queue+0x226a/0x27f0 fs/erofs/zdata.c:1425
>   z_erofs_decompressqueue_work+0x77/0xb0 fs/erofs/zdata.c:1437
>   process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
>   process_scheduled_works kernel/workqueue.c:3310 [inline]
>   worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
>   kthread+0x2c4/0x3a0 kernel/kthread.c:389
>   ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>   </TASK>
> 
> Allocated by task 9350:
>   kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>   poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>   __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
>   kmalloc_noprof include/linux/slab.h:901 [inline]
>   kzalloc_noprof include/linux/slab.h:1037 [inline]
>   erofs_init_fs_context+0x47/0x3a0 fs/erofs/super.c:790
>   alloc_fs_context+0x54d/0x9c0 fs/fs_context.c:318
>   do_new_mount fs/namespace.c:3486 [inline]
>   path_mount+0xb08/0x1f20 fs/namespace.c:3834
>   do_mount fs/namespace.c:3847 [inline]
>   __do_sys_mount fs/namespace.c:4057 [inline]
>   __se_sys_mount fs/namespace.c:4034 [inline]
>   __x64_sys_mount+0x294/0x320 fs/namespace.c:4034
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 5850:
>   kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>   kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
>   poison_slab_object mm/kasan/common.c:247 [inline]
>   __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
>   kasan_slab_free include/linux/kasan.h:233 [inline]
>   slab_free_hook mm/slub.c:2338 [inline]
>   slab_free mm/slub.c:4598 [inline]
>   kfree+0x14f/0x4b0 mm/slub.c:4746
>   erofs_kill_sb+0x1a5/0x240 fs/erofs/super.c:824
>   deactivate_locked_super+0xc1/0x1a0 fs/super.c:473
>   deactivate_super+0xde/0x100 fs/super.c:506
>   cleanup_mnt+0x222/0x450 fs/namespace.c:1373
>   task_work_run+0x151/0x250 kernel/task_work.c:239
>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>   exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>   exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>   syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
>   do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff888034ece000
>   which belongs to the cache kmalloc-1k of size 1024
> The buggy address is located 176 bytes inside of
>   freed 1024-byte region [ffff888034ece000, ffff888034ece400)
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x34ec8
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000040 ffff88801b041dc0 0000000000000000 dead000000000001
> raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
> head: 00fff00000000040 ffff88801b041dc0 0000000000000000 dead000000000001
> head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
> head: 00fff00000000003 ffffea0000d3b201 ffffffffffffffff 0000000000000000
> head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 6062, tgid 6062 (kworker/u8:10), ts 164036055360, free_ts 158527873125
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
>   prep_new_page mm/page_alloc.c:1564 [inline]
>   get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
>   __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4751
>   alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
>   alloc_slab_page mm/slub.c:2408 [inline]
>   allocate_slab mm/slub.c:2574 [inline]
>   new_slab+0x2c9/0x410 mm/slub.c:2627
>   ___slab_alloc+0xdac/0x1870 mm/slub.c:3815
>   __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3905
>   __slab_alloc_node mm/slub.c:3980 [inline]
>   slab_alloc_node mm/slub.c:4141 [inline]
>   __do_kmalloc_node mm/slub.c:4282 [inline]
>   __kmalloc_noprof+0x2ec/0x510 mm/slub.c:4295
>   kmalloc_noprof include/linux/slab.h:905 [inline]
>   kzalloc_noprof include/linux/slab.h:1037 [inline]
>   ieee802_11_parse_elems_full+0xea/0x1680 net/mac80211/parse.c:958
>   ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2386 [inline]
>   ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2393 [inline]
>   ieee80211_inform_bss+0xfd/0x1100 net/mac80211/scan.c:79
>   rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
>   cfg80211_inform_single_bss_data+0x8f9/0x1de0 net/wireless/scan.c:2334
>   cfg80211_inform_bss_data+0x205/0x3ba0 net/wireless/scan.c:3189
>   cfg80211_inform_bss_frame_data+0x272/0x7a0 net/wireless/scan.c:3284
>   ieee80211_bss_info_update+0x311/0xab0 net/mac80211/scan.c:226
>   ieee80211_rx_bss_info net/mac80211/ibss.c:1101 [inline]
>   ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1580 [inline]
>   ieee80211_ibss_rx_queued_mgmt+0x189c/0x2f50 net/mac80211/ibss.c:1607
>   ieee80211_iface_process_skb net/mac80211/iface.c:1616 [inline]
>   ieee80211_iface_work+0xc0b/0xf00 net/mac80211/iface.c:1670
> page last free pid 6620 tgid 6619 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1127 [inline]
>   free_unref_page+0x661/0x1080 mm/page_alloc.c:2657
>   __put_partials+0x14c/0x170 mm/slub.c:3142
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:250 [inline]
>   slab_post_alloc_hook mm/slub.c:4104 [inline]
>   slab_alloc_node mm/slub.c:4153 [inline]
>   __do_kmalloc_node mm/slub.c:4282 [inline]
>   __kmalloc_noprof+0x1cd/0x510 mm/slub.c:4295
>   kmalloc_noprof include/linux/slab.h:905 [inline]
>   tomoyo_realpath_from_path+0xb9/0x720 security/tomoyo/realpath.c:251
>   tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>   tomoyo_path_number_perm+0x248/0x590 security/tomoyo/file.c:723
>   security_file_ioctl+0x9b/0x240 security/security.c:2908
>   __do_sys_ioctl fs/ioctl.c:900 [inline]
>   __se_sys_ioctl fs/ioctl.c:892 [inline]
>   __x64_sys_ioctl+0xb7/0x200 fs/ioctl.c:892
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Memory state around the buggy address:
>   ffff888034ecdf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff888034ece000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff888034ece080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                       ^
>   ffff888034ece100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff888034ece180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> ==================================================================
> BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
> BUG: KASAN: slab-use-after-free in atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1300 [inline]
> BUG: KASAN: slab-use-after-free in queued_spin_trylock include/asm-generic/qspinlock.h:97 [inline]
> BUG: KASAN: slab-use-after-free in do_raw_spin_trylock+0xa2/0x180 kernel/locking/spinlock_debug.c:123
> Write of size 4 at addr ffff888034ece0b0 by task kworker/u9:5/5868
> 
> CPU: 0 UID: 0 PID: 5868 Comm: kworker/u9:5 Tainted: G    B              6.12.0-syzkaller-10553-gb86545e02e8c #0
> Tainted: [B]=BAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: erofs_worker z_erofs_decompressqueue_work
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:378 [inline]
>   print_report+0xc3/0x620 mm/kasan/report.c:489
>   kasan_report+0xd9/0x110 mm/kasan/report.c:602
>   check_region_inline mm/kasan/generic.c:183 [inline]
>   kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
>   instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>   atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1300 [inline]
>   queued_spin_trylock include/asm-generic/qspinlock.h:97 [inline]
>   do_raw_spin_trylock+0xa2/0x180 kernel/locking/spinlock_debug.c:123
>   __raw_spin_trylock include/linux/spinlock_api_smp.h:89 [inline]
>   _raw_spin_trylock+0x1b/0x80 kernel/locking/spinlock.c:138
>   spin_trylock include/linux/spinlock.h:361 [inline]
>   z_erofs_put_pcluster.part.0+0x112/0x200 fs/erofs/zdata.c:959
>   z_erofs_put_pcluster fs/erofs/zdata.c:1403 [inline]
>   z_erofs_decompress_pcluster fs/erofs/zdata.c:1403 [inline]
>   z_erofs_decompress_queue+0x226a/0x27f0 fs/erofs/zdata.c:1425
>   z_erofs_decompressqueue_work+0x77/0xb0 fs/erofs/zdata.c:1437
>   process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
>   process_scheduled_works kernel/workqueue.c:3310 [inline]
>   worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
>   kthread+0x2c4/0x3a0 kernel/kthread.c:389
>   ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>   </TASK>
> 
> Allocated by task 9350:
>   kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>   poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>   __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
>   kmalloc_noprof include/linux/slab.h:901 [inline]
>   kzalloc_noprof include/linux/slab.h:1037 [inline]
>   erofs_init_fs_context+0x47/0x3a0 fs/erofs/super.c:790
>   alloc_fs_context+0x54d/0x9c0 fs/fs_context.c:318
>   do_new_mount fs/namespace.c:3486 [inline]
>   path_mount+0xb08/0x1f20 fs/namespace.c:3834
>   do_mount fs/namespace.c:3847 [inline]
>   __do_sys_mount fs/namespace.c:4057 [inline]
>   __se_sys_mount fs/namespace.c:4034 [inline]
>   __x64_sys_mount+0x294/0x320 fs/namespace.c:4034
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 5850:
>   kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>   kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
>   poison_slab_object mm/kasan/common.c:247 [inline]
>   __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
>   kasan_slab_free include/linux/kasan.h:233 [inline]
>   slab_free_hook mm/slub.c:2338 [inline]
>   slab_free mm/slub.c:4598 [inline]
>   kfree+0x14f/0x4b0 mm/slub.c:4746
>   erofs_kill_sb+0x1a5/0x240 fs/erofs/super.c:824
>   deactivate_locked_super+0xc1/0x1a0 fs/super.c:473
>   deactivate_super+0xde/0x100 fs/super.c:506
>   cleanup_mnt+0x222/0x450 fs/namespace.c:1373
>   task_work_run+0x151/0x250 kernel/task_work.c:239
>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>   exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>   exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>   syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
>   do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff888034ece000
>   which belongs to the cache kmalloc-1k of size 1024
> The buggy address is located 176 bytes inside of
>   freed 1024-byte region [ffff888034ece000, ffff888034ece400)
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x34ec8
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000040 ffff88801b041dc0 0000000000000000 dead000000000001
> raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
> head: 00fff00000000040 ffff88801b041dc0 0000000000000000 dead000000000001
> head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
> head: 00fff00000000003 ffffea0000d3b201 ffffffffffffffff 0000000000000000
> head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 6062, tgid 6062 (kworker/u8:10), ts 164036055360, free_ts 158527873125
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
>   prep_new_page mm/page_alloc.c:1564 [inline]
>   get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
>   __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4751
>   alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
>   alloc_slab_page mm/slub.c:2408 [inline]
>   allocate_slab mm/slub.c:2574 [inline]
>   new_slab+0x2c9/0x410 mm/slub.c:2627
>   ___slab_alloc+0xdac/0x1870 mm/slub.c:3815
>   __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3905
>   __slab_alloc_node mm/slub.c:3980 [inline]
>   slab_alloc_node mm/slub.c:4141 [inline]
>   __do_kmalloc_node mm/slub.c:4282 [inline]
>   __kmalloc_noprof+0x2ec/0x510 mm/slub.c:4295
>   kmalloc_noprof include/linux/slab.h:905 [inline]
>   kzalloc_noprof include/linux/slab.h:1037 [inline]
>   ieee802_11_parse_elems_full+0xea/0x1680 net/mac80211/parse.c:958
>   ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2386 [inline]
>   ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2393 [inline]
>   ieee80211_inform_bss+0xfd/0x1100 net/mac80211/scan.c:79
>   rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
>   cfg80211_inform_single_bss_data+0x8f9/0x1de0 net/wireless/scan.c:2334
>   cfg80211_inform_bss_data+0x205/0x3ba0 net/wireless/scan.c:3189
>   cfg80211_inform_bss_frame_data+0x272/0x7a0 net/wireless/scan.c:3284
>   ieee80211_bss_info_update+0x311/0xab0 net/mac80211/scan.c:226
>   ieee80211_rx_bss_info net/mac80211/ibss.c:1101 [inline]
>   ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1580 [inline]
>   ieee80211_ibss_rx_queued_mgmt+0x189c/0x2f50 net/mac80211/ibss.c:1607
>   ieee80211_iface_process_skb net/mac80211/iface.c:1616 [inline]
>   ieee80211_iface_work+0xc0b/0xf00 net/mac80211/iface.c:1670
> page last free pid 6620 tgid 6619 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1127 [inline]
>   free_unref_page+0x661/0x1080 mm/page_alloc.c:2657
>   __put_partials+0x14c/0x170 mm/slub.c:3142
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:250 [inline]
>   slab_post_alloc_hook mm/slub.c:4104 [inline]
>   slab_alloc_node mm/slub.c:4153 [inline]
>   __do_kmalloc_node mm/slub.c:4282 [inline]
>   __kmalloc_noprof+0x1cd/0x510 mm/slub.c:4295
>   kmalloc_noprof include/linux/slab.h:905 [inline]
>   tomoyo_realpath_from_path+0xb9/0x720 security/tomoyo/realpath.c:251
>   tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>   tomoyo_path_number_perm+0x248/0x590 security/tomoyo/file.c:723
>   security_file_ioctl+0x9b/0x240 security/security.c:2908
>   __do_sys_ioctl fs/ioctl.c:900 [inline]
>   __se_sys_ioctl fs/ioctl.c:892 [inline]
>   __x64_sys_ioctl+0xb7/0x200 fs/ioctl.c:892
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Memory state around the buggy address:
>   ffff888034ecdf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff888034ece000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff888034ece080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                       ^
>   ffff888034ece100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff888034ece180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

