Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AFB438C42
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Oct 2021 00:09:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HcsgK6KbJz2yHb
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Oct 2021 09:09:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
 (client-ip=209.85.166.72; helo=mail-io1-f72.google.com;
 envelope-from=3emr0yqkbah0tz0lbmmfsbqqje.hpphmfvtfsdpoufou.dpn@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com;
 receiver=<UNKNOWN>)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HcMPd0Kwnz2yMg
 for <linux-erofs@lists.ozlabs.org>; Sun, 24 Oct 2021 13:25:23 +1100 (AEDT)
Received: by mail-io1-f72.google.com with SMTP id
 y11-20020a056602164b00b005de32183909so6288325iow.10
 for <linux-erofs@lists.ozlabs.org>; Sat, 23 Oct 2021 19:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
 bh=7QR9akAHbSinoGJpOVe+XCc1PKKxjmber8Obdn+Lueg=;
 b=SDjZqKShhY/rxhRf1KyIi583UVVFVLkvlCu1juK+D4TuTEGjOZuINKL6xyXvA8rnyd
 VsIIkreyr+fj+tPd2bosjYu6j/m1fr/fvuD0fbKrBmslRqfQ2KaqYhcR4Qhm3wdIgqi6
 ko1qJQw9VDni249IkCApf5t2RM5htLOmuuUcAHDk5M/85jg4wQzU864zAURQfSzAfGyU
 22RRwVSjyDKAvPuyNrZwu37Pyn8GfzooAtUGfyOz8rYmfqcUNltr+GX/e4J1mwXfsERS
 3sV7ZWMsmUlJ49tQt4frQRR1fOBu9Yi0Stmu+0ucfEHrv7MnN9KvtKyQSnGz0qVW6WXW
 VtAg==
X-Gm-Message-State: AOAM530PR39OprElOt3FE3JbHEilMZi+3egJBK2m70pyHb7DyQlZL0p+
 h99/F6oCJFl0XcXCcVX/VbVdcs+Pz1DuXE8raDX0gmEgFwK0
X-Google-Smtp-Source: ABdhPJyJEy3lsFOs4MNeH/Dbm+ITEfcGDVsFhnncp7OjZMfwm4TPo/NM2QBEgmCFQwZ888HOFEvmOC6ae2+Ztzl/Am/T9+jgY3RO
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b8e:: with SMTP id
 r14mr5794228iov.98.1635042320405; 
 Sat, 23 Oct 2021 19:25:20 -0700 (PDT)
Date: Sat, 23 Oct 2021 19:25:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3586105cf0ff45e@google.com>
Subject: [syzbot] WARNING in z_erofs_lz4_decompress
From: syzbot <syzbot+d8aaffc3719597e8cfb4@syzkaller.appspotmail.com>
To: chao@kernel.org, linux-erofs@lists.ozlabs.org, 
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello,

syzbot found the following issue on:

HEAD commit:    60e8840126bd Add linux-next specific files for 20211018
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=125932af300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4bd44cafcda7632e
dashboard link: https://syzkaller.appspot.com/bug?extid=d8aaffc3719597e8cfb4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8aaffc3719597e8cfb4@syzkaller.appspotmail.com

erofs: (device loop4): z_erofs_lz4_decompress_mem: failed to decompress -4100 in[4096, 0] out[9000]
------------[ cut here ]------------
WARNING: CPU: 1 PID: 9895 at fs/erofs/decompressor.c:230 z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:227 [inline]
WARNING: CPU: 1 PID: 9895 at fs/erofs/decompressor.c:230 z_erofs_lz4_decompress+0x841/0x1400 fs/erofs/decompressor.c:289
Modules linked in:
CPU: 1 PID: 9895 Comm: kworker/u5:3 Not tainted 5.15.0-rc5-next-20211018-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: erofs_unzipd z_erofs_decompressqueue_work
RIP: 0010:z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:230 [inline]
RIP: 0010:z_erofs_lz4_decompress+0x841/0x1400 fs/erofs/decompressor.c:289
Code: e9 03 80 3c 11 00 0f 85 8c 0a 00 00 41 56 48 8b 7d 00 45 89 e9 89 d9 48 c7 c2 20 eb fb 89 48 c7 c6 40 ed fb 89 e8 ee 5d 85 05 <0f> 0b 48 b8 00 00 00 00 00 fc ff df 48 8b 4c 24 08 5f 48 89 ca 48
RSP: 0018:ffffc90001b3f718 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffffffffeffc RCX: 0000000000000000
RDX: ffff8880795b3a00 RSI: ffffffff815ef308 RDI: fffff52000367ed3
RBP: ffffc90001b3f858 R08: 0000000000000063 R09: 0000000000000000
R10: ffffffff815e90de R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000002328 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ef25000 CR3: 000000002b3f7000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 z_erofs_decompress_pcluster.isra.0+0x1389/0x2450 fs/erofs/zdata.c:977
 z_erofs_decompress_queue fs/erofs/zdata.c:1055 [inline]
 z_erofs_decompressqueue_work+0xe0/0x170 fs/erofs/zdata.c:1066
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
