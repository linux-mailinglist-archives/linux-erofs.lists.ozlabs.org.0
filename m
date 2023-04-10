Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5D36DC4CB
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Apr 2023 11:03:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pw30j2xKqz3ccw
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Apr 2023 19:03:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pw30b5gGgz30Lt
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Apr 2023 19:03:10 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VfkBM0n_1681117383;
Received: from 30.97.49.25(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VfkBM0n_1681117383)
          by smtp.aliyun-inc.com;
          Mon, 10 Apr 2023 17:03:04 +0800
Message-ID: <90d29dc6-39b3-439c-904b-7a2207610d64@linux.alibaba.com>
Date: Mon, 10 Apr 2023 17:03:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [syzbot] WARNING in rmqueue
To: syzbot <syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <000000000000ec75b005ee97fbaa@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <000000000000ec75b005ee97fbaa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 2022/11/29 16:43, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b7b275e60bcd Linux 6.1-rc7
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16a70187880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
> dashboard link: https://syzkaller.appspot.com/bug?extid=aafb3f37cfeb6534c4ac
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15dde8a1880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15685e8d880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/525233126d34/disk-b7b275e6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e8299bf41400/vmlinux-b7b275e6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/eebf691dbf6f/bzImage-b7b275e6.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/d643567f551d/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.3-rc6

> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 48 at mm/page_alloc.c:3837 __count_numa_events include/linux/vmstat.h:249 [inline]
> WARNING: CPU: 0 PID: 48 at mm/page_alloc.c:3837 zone_statistics mm/page_alloc.c:3692 [inline]
> WARNING: CPU: 0 PID: 48 at mm/page_alloc.c:3837 rmqueue_buddy mm/page_alloc.c:3728 [inline]
> WARNING: CPU: 0 PID: 48 at mm/page_alloc.c:3837 rmqueue+0x1d6b/0x1ed0 mm/page_alloc.c:3853
> Modules linked in:
> CPU: 0 PID: 48 Comm: kworker/u5:0 Not tainted 6.1.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> Workqueue: erofs_unzipd z_erofs_decompressqueue_work
> RIP: 0010:rmqueue+0x1d6b/0x1ed0 mm/page_alloc.c:3837
> Code: 48 8b 02 65 48 ff 40 20 49 83 f6 05 42 80 3c 2b 00 74 08 4c 89 e7 e8 a4 44 0b 00 49 8b 04 24 65 4a ff 44 f0 10 e9 2a fe ff ff <0f> 0b e9 29 e3 ff ff 48 89 df be 08 00 00 00 e8 31 46 0b 00 f0 41
> RSP: 0018:ffffc90000b97260 EFLAGS: 00010202
> RAX: f301f204f1f1f1f1 RBX: ffff88813fffae00 RCX: 000000000000adc2
> RDX: 1ffff92000172e70 RSI: 1ffff92000172e70 RDI: ffff88813fffae00
> RBP: ffffc90000b97420 R08: 0000000000000901 R09: 0000000000000009
> R10: ffffed1027fff5b3 R11: 1ffff11027fff5b2 R12: ffff88813fffc310
> R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88813fffa700
> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7bec722f10 CR3: 000000004a430000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   get_page_from_freelist+0x4b6/0x7c0 mm/page_alloc.c:4288
>   __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
>   vm_area_alloc_pages mm/vmalloc.c:2975 [inline]
>   __vmalloc_area_node mm/vmalloc.c:3043 [inline]
>   __vmalloc_node_range+0x8f4/0x1290 mm/vmalloc.c:3213
>   kvmalloc_node+0x13e/0x180 mm/util.c:606
>   kvmalloc include/linux/slab.h:706 [inline]
>   kvmalloc_array include/linux/slab.h:724 [inline]
>   kvcalloc include/linux/slab.h:729 [inline]
>   z_erofs_decompress_pcluster fs/erofs/zdata.c:1049 [inline]
>   z_erofs_decompress_queue+0x693/0x2c30 fs/erofs/zdata.c:1155
>   z_erofs_decompressqueue_work+0x95/0xe0 fs/erofs/zdata.c:1167
>   process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
>   worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
>   kthread+0x266/0x300 kernel/kthread.c:376
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>   </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
