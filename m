Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A7163BBE7
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Nov 2022 09:44:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NLwqk595Mz3bfJ
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Nov 2022 19:44:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.197; helo=mail-il1-f197.google.com; envelope-from=3ocafywkbap4y45qgrrkxgvvoj.muumrk0ykxiutzktz.ius@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=<UNKNOWN>)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NLwq267wfz30Qg
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Nov 2022 19:43:41 +1100 (AEDT)
Received: by mail-il1-f197.google.com with SMTP id l4-20020a056e021aa400b00300ad9535c8so11439101ilv.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 29 Nov 2022 00:43:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zg5az6xrnSvzem2gwMfor+gDgHn0N57V8GOUL7tP8Vs=;
        b=FZZPC+BGs1n6uKSWZ5aJPGALm4iACFpE6J+nTkgV72Ntk7zIrYI//DAAjNxWOGoGHD
         AmK1naDqakV8vpKbbgQ15IZ8z56l/IHPkqOKlwKoZzK2pV9NX++MYarOwmP5eIvv//me
         +XQxvFXX7seibdcWbUtjITceTCa9SvuQcCH63uFROiWuskQChkl8CAcs/j1/OtIm4Wsa
         E3cfeAXylWQEfbWd+t5RLIm+N02n7apFs+mPs7p2yyI+NxVmg8ILHhPSlomNb83bWWXL
         QnfQD6g/oCrwRb9hgMgIDnqkF/oYjZLOuYDLMP+KB5LKmi8onOhVFqSPYz13etKqxwkR
         ezXg==
X-Gm-Message-State: ANoB5pm8jl42BWGThTAwki3bIdslHgBACr7Re5ZtGa3hc9zsJgKR4f0f
	3K6+HcoRr3TGFsqhGPk/ZucfG/PWLULvd85i5flZFIxBdGgr
X-Google-Smtp-Source: AA0mqf42d/jX0JIdrKgatOfuS0V1VVLRZ/xgvKBJO2A+0Zyg1bC4Sd5T3GZtgMUGAeIPdwxzOhTcwyeGsoyPqqDqiCEfCt8LS4Yz
MIME-Version: 1.0
X-Received: by 2002:a02:5146:0:b0:371:1431:d4f2 with SMTP id
 s67-20020a025146000000b003711431d4f2mr26840101jaa.184.1669711417600; Tue, 29
 Nov 2022 00:43:37 -0800 (PST)
Date: Tue, 29 Nov 2022 00:43:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec75b005ee97fbaa@google.com>
Subject: [syzbot] WARNING in rmqueue
From: syzbot <syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com>
To: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
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

HEAD commit:    b7b275e60bcd Linux 6.1-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16a70187880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=aafb3f37cfeb6534c4ac
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15dde8a1880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15685e8d880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/525233126d34/disk-b7b275e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e8299bf41400/vmlinux-b7b275e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eebf691dbf6f/bzImage-b7b275e6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d643567f551d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 48 at mm/page_alloc.c:3837 __count_numa_events include/linux/vmstat.h:249 [inline]
WARNING: CPU: 0 PID: 48 at mm/page_alloc.c:3837 zone_statistics mm/page_alloc.c:3692 [inline]
WARNING: CPU: 0 PID: 48 at mm/page_alloc.c:3837 rmqueue_buddy mm/page_alloc.c:3728 [inline]
WARNING: CPU: 0 PID: 48 at mm/page_alloc.c:3837 rmqueue+0x1d6b/0x1ed0 mm/page_alloc.c:3853
Modules linked in:
CPU: 0 PID: 48 Comm: kworker/u5:0 Not tainted 6.1.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: erofs_unzipd z_erofs_decompressqueue_work
RIP: 0010:rmqueue+0x1d6b/0x1ed0 mm/page_alloc.c:3837
Code: 48 8b 02 65 48 ff 40 20 49 83 f6 05 42 80 3c 2b 00 74 08 4c 89 e7 e8 a4 44 0b 00 49 8b 04 24 65 4a ff 44 f0 10 e9 2a fe ff ff <0f> 0b e9 29 e3 ff ff 48 89 df be 08 00 00 00 e8 31 46 0b 00 f0 41
RSP: 0018:ffffc90000b97260 EFLAGS: 00010202
RAX: f301f204f1f1f1f1 RBX: ffff88813fffae00 RCX: 000000000000adc2
RDX: 1ffff92000172e70 RSI: 1ffff92000172e70 RDI: ffff88813fffae00
RBP: ffffc90000b97420 R08: 0000000000000901 R09: 0000000000000009
R10: ffffed1027fff5b3 R11: 1ffff11027fff5b2 R12: ffff88813fffc310
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88813fffa700
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7bec722f10 CR3: 000000004a430000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 get_page_from_freelist+0x4b6/0x7c0 mm/page_alloc.c:4288
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 vm_area_alloc_pages mm/vmalloc.c:2975 [inline]
 __vmalloc_area_node mm/vmalloc.c:3043 [inline]
 __vmalloc_node_range+0x8f4/0x1290 mm/vmalloc.c:3213
 kvmalloc_node+0x13e/0x180 mm/util.c:606
 kvmalloc include/linux/slab.h:706 [inline]
 kvmalloc_array include/linux/slab.h:724 [inline]
 kvcalloc include/linux/slab.h:729 [inline]
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1049 [inline]
 z_erofs_decompress_queue+0x693/0x2c30 fs/erofs/zdata.c:1155
 z_erofs_decompressqueue_work+0x95/0xe0 fs/erofs/zdata.c:1167
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
