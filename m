Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A49A96DC4D6
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Apr 2023 11:07:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pw35W4L4Vz3chr
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Apr 2023 19:07:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.207; helo=mail-il1-f207.google.com; envelope-from=3xtezzakbagerxyj9kkdq9oohc.fnnfkdtrdqbnmsdms.bnl@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=<UNKNOWN>)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pw35R49CQz3ccw
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Apr 2023 19:07:21 +1000 (AEST)
Received: by mail-il1-f207.google.com with SMTP id d14-20020a056e021c4e00b00328b531634bso1907532ilg.4
        for <linux-erofs@lists.ozlabs.org>; Mon, 10 Apr 2023 02:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681117638; x=1683709638;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4mjMa2eOSiMmSgDp3BEz6uoAL80dYdOLwOuzJ5/3SI=;
        b=FcGFkEw5mTj36x0zOpVazZKU5cAXjiXpb+G+CZjwFIg9J7BcjwYrYRS9xUex+Pr75a
         zfj7MenHQdFfDDMO5f+SDqSUEviN87w8tlT3Nz3TLW5YECEur7RKxd+LJwKUNCKcyOBH
         /NUTs2OJg2T+vcWey70xTMg3jOBwaoY4d5PS6NDca9Bc1rt+zLzuwoQbbvUkb8VRmK8k
         rVe9IaJzJVRmF9DJy4xXDznymtBab/QHzGhHWPEVzNFKolA96oEtotC4F82CJXBD1QBb
         6ySK0jNAHXCqYGNikOwmNN4AKD1/I1VgRHTzQZAiZN6t9rA4SliIDcTbocjseNXbgjyg
         mGkg==
X-Gm-Message-State: AAQBX9cCLstzKOu4peuTk6K4PsHV+hg4W8dKarJPGEapqtRWFRSwVKVT
	trtDp7FPTyAFZ1gUEyUawDg5pcnLjqxV3seAARHF/w39dPz5
X-Google-Smtp-Source: AKy350Zc2TZbP0bvmbKxVpax9yehbVBLUrbDoo9lccQi6o/mMK/gvLQ+nApQeWLk2cDZsYQn6XdOM22VYr052sD20vv9s5ioN6YJ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:970:b0:323:cab8:3c0a with SMTP id
 q16-20020a056e02097000b00323cab83c0amr5423301ilt.5.1681117638525; Mon, 10 Apr
 2023 02:07:18 -0700 (PDT)
Date: Mon, 10 Apr 2023 02:07:18 -0700
In-Reply-To: <5854d826-14c9-d055-9147-55b16d8906cf@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab899a05f8f7b300@google.com>
Subject: Re: [syzbot] [erofs?] WARNING in z_erofs_decompress_queue
From: syzbot <syzbot+c679d2fb47506ba04298@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com
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
Cc: syzkaller-bugs@googlegroups.com, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

>
>
> On 2023/1/30 16:18, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    7c46948a6e9c Merge tag 'fs.fuse.acl.v6.2-rc6' of git://git..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1360d6c1480000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d5c2ee6c2bd4b8
>> dashboard link: https://syzkaller.appspot.com/bug?extid=c679d2fb47506ba04298
>> compiler:       Debian clang version 13.0.1-6~deb11u1, GNU ld (GNU Binutils for Debian) 2.35.2
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/cc51645b6401/disk-7c46948a.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/be036b5604a3/vmlinux-7c46948a.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/274f5abf2c8f/bzImage-7c46948a.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+c679d2fb47506ba04298@syzkaller.appspotmail.com
>> 
>
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.3-rc6

This crash does not have a reproducer. I cannot test it.

>
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 11026 at mm/page_alloc.c:5525 __alloc_pages+0x30a/0x560 mm/page_alloc.c:5525
>> Modules linked in:
>> CPU: 1 PID: 11026 Comm: syz-executor.2 Not tainted 6.2.0-rc5-syzkaller-00047-g7c46948a6e9c #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
>> RIP: 0010:__alloc_pages+0x30a/0x560 mm/page_alloc.c:5525
>> Code: 5c 24 04 0f 85 f3 00 00 00 44 89 e1 81 e1 7f ff ff ff a9 00 00 04 00 41 0f 44 cc 41 89 cc e9 e3 00 00 00 c6 05 30 8a ad 0c 01 <0f> 0b 83 fb 0a 0f 86 c8 fd ff ff 31 db 48 c7 44 24 20 0e 36 e0 45
>> RSP: 0018:ffffc9000552db20 EFLAGS: 00010246
>> RAX: ffffc9000552db80 RBX: 000000000000000b RCX: 0000000000000000
>> RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc9000552dba8
>> RBP: ffffc9000552dc38 R08: dffffc0000000000 R09: ffffc9000552db80
>> R10: fffff52000aa5b75 R11: 1ffff92000aa5b70 R12: 0000000000048dc0
>> R13: 1ffff92000aa5b6c R14: dffffc0000000000 R15: 1ffff92000aa5b68
>> FS:  00007f3ea5dfe700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000055555612f888 CR3: 000000001d1c2000 CR4: 00000000003506e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   __alloc_pages_node include/linux/gfp.h:237 [inline]
>>   alloc_pages_node include/linux/gfp.h:260 [inline]
>>   __kmalloc_large_node+0x95/0x1e0 mm/slab_common.c:1113
>>   __do_kmalloc_node mm/slab_common.c:956 [inline]
>>   __kmalloc+0xfe/0x190 mm/slab_common.c:981
>>   kmalloc_array include/linux/slab.h:636 [inline]
>>   kcalloc include/linux/slab.h:667 [inline]
>>   z_erofs_decompress_pcluster fs/erofs/zdata.c:1035 [inline]
>>   z_erofs_decompress_queue+0x68e/0x2c20 fs/erofs/zdata.c:1141
>>   z_erofs_decompressqueue_work fs/erofs/zdata.c:1153 [inline]
>>   z_erofs_decompress_kickoff+0x24c/0x2f0 fs/erofs/zdata.c:1181
>>   z_erofs_submit_queue+0xe8e/0x1050 fs/erofs/zdata.c:1509
>>   z_erofs_runqueue fs/erofs/zdata.c:1519 [inline]
>>   z_erofs_readahead+0x70b/0x910 fs/erofs/zdata.c:1666
>>   read_pages+0x169/0x9c0 mm/readahead.c:161
>>   page_cache_ra_unbounded+0x703/0x820 mm/readahead.c:270
>>   page_cache_sync_readahead include/linux/pagemap.h:1210 [inline]
>>   filemap_get_pages+0x465/0x10d0 mm/filemap.c:2600
>>   filemap_read+0x3cf/0xea0 mm/filemap.c:2694
>>   __kernel_read+0x3fc/0x830 fs/read_write.c:428
>>   integrity_kernel_read+0xac/0xf0 security/integrity/iint.c:199
>>   ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
>>   ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
>>   ima_calc_file_hash+0x178f/0x1ca0 security/integrity/ima/ima_crypto.c:573
>>   ima_collect_measurement+0x444/0x8c0 security/integrity/ima/ima_api.c:292
>>   process_measurement+0xf41/0x1bc0 security/integrity/ima/ima_main.c:339
>>   ima_file_check+0xd8/0x130 security/integrity/ima/ima_main.c:519
>>   do_open fs/namei.c:3559 [inline]
>>   path_openat+0x2600/0x2dd0 fs/namei.c:3714
>>   do_filp_open+0x264/0x4f0 fs/namei.c:3741
>>   do_sys_openat2+0x124/0x4e0 fs/open.c:1310
>>   do_sys_open fs/open.c:1326 [inline]
>>   __do_sys_open fs/open.c:1334 [inline]
>>   __se_sys_open fs/open.c:1330 [inline]
>>   __x64_sys_open+0x221/0x270 fs/open.c:1330
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> RIP: 0033:0x7f3ea728c0c9
>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007f3ea5dfe168 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
>> RAX: ffffffffffffffda RBX: 00007f3ea73abf80 RCX: 00007f3ea728c0c9
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000040
>> RBP: 00007f3ea72e7ae9 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 00007ffd3dfcbf0f R14: 00007f3ea5dfe300 R15: 0000000000022000
>>   </TASK>
>> 
>> 
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>> 
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> 
