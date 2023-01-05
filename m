Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C093065EECB
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Jan 2023 15:33:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NnpqR4Dc7z3bVx
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Jan 2023 01:33:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.197; helo=mail-il1-f197.google.com; envelope-from=3rn-2ywkbagsbhitjuunajyyrm.pxxpundbnalxwcnwc.lxv@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=<UNKNOWN>)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NnpqN4Fm2z2xvF
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Jan 2023 01:33:18 +1100 (AEDT)
Received: by mail-il1-f197.google.com with SMTP id x8-20020a056e02194800b0030c1ca49d7dso13745428ilu.8
        for <linux-erofs@lists.ozlabs.org>; Thu, 05 Jan 2023 06:33:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EE3LsWNibLxLYoVVm12EwAXtv+NkpUOR3oNx76/MwI=;
        b=c19Vx7NaO6qQ9nopSswJei5CSdn7WdWxb6A38X/DdIByAqdahMQbs+dhSNIGx6C5YB
         EQcw4OlKir7oLXd6YzAbmXTf7TiDcayJ6BBpfqaDtTgj8Lub/mgXeMDoUpAnNNSTElmn
         VCNZ3bg0KCDPkh4qFj0zBb3qr+3zgh4rM/kIHvr+YcGq7OcqjuAlgfR7ceSyAgguraiq
         Y0059yx5XJabBySoUg/nI5W4fJ0OgduoR7y8cD4teRO5oZp3GEC6paubKjrMYNq1dQes
         f0RELzYbMAXYrIJlGxzxOE2KM7PAb/lswif7qmRbe//hyew0xuyWQKJI1uaFHU8X6lSZ
         usTw==
X-Gm-Message-State: AFqh2krRbDg6Rl6IwsQRNg1dWk6MtFQqp9IQuXNG+VGQr39KLgi3IM//
	ceqAAbDbR02c10pbN4u1YfZHO4qxEdMmRMUtoXuMcydUai7i
X-Google-Smtp-Source: AMrXdXtMgvmeF/e4yTusMr+YTqoJZNcvkWXaK41QWlBqub5lVVuHkK9IGjX2d8jwcR7tozTR9Txd3pKK9ZAUUcYQSK3E0K4DdGuu
MIME-Version: 1.0
X-Received: by 2002:a02:3907:0:b0:38a:9c57:2468 with SMTP id
 l7-20020a023907000000b0038a9c572468mr3776149jaa.154.1672929196084; Thu, 05
 Jan 2023 06:33:16 -0800 (PST)
Date: Thu, 05 Jan 2023 06:33:16 -0800
In-Reply-To: <CANp29Y63rCdepVtantxdJEcvbRv0D61gfY_oGV7dgrmEGgPdLw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007796bd05f1852ec2@google.com>
Subject: Re: [syzbot] [erofs?] WARNING: CPU: NUM PID: NUM at
 mm/page_alloc.c:LINE get_page_from_freeli
From: syzbot <syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chao@kernel.org, hsiangkao@linux.alibaba.com, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, nogikh@google.com, 
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in get_page_from_freelist

------------[ cut here ]------------
WARNING: CPU: 1 PID: 4385 at mm/page_alloc.c:3829 rmqueue mm/page_alloc.c:3829 [inline]
WARNING: CPU: 1 PID: 4385 at mm/page_alloc.c:3829 get_page_from_freelist+0xbf3/0x2ce0 mm/page_alloc.c:4280
Modules linked in:
CPU: 1 PID: 4385 Comm: kworker/u5:1 Not tainted 6.2.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: erofs_unzipd z_erofs_decompressqueue_work
RIP: 0010:rmqueue mm/page_alloc.c:3829 [inline]
RIP: 0010:get_page_from_freelist+0xbf3/0x2ce0 mm/page_alloc.c:4280
Code: 48 c1 e8 03 42 80 3c 28 00 0f 85 18 1f 00 00 48 8b 03 f7 84 24 d8 00 00 00 00 80 00 00 48 89 44 24 68 74 08 41 83 fe 01 76 02 <0f> 0b 41 83 fe 09 0f 94 c2 41 83 fe 03 0f 96 c0 08 c2 88 54 24 50
RSP: 0018:ffffc900055e74d8 EFLAGS: 00010202
RAX: ffff88813fffae00 RBX: ffff88813fffc300 RCX: ffff88813fffabe8
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffc900055e7718
RBP: 0000000000000002 R08: 0000000000002b49 R09: 0000000000078534
R10: 0000000000002b48 R11: 0000000000000000 R12: 0000000000002b48
R13: dffffc0000000000 R14: 0000000000000009 R15: ffff88813fffa700
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff496515829 CR3: 000000000c48e000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5549
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2286
 vm_area_alloc_pages mm/vmalloc.c:2989 [inline]
 __vmalloc_area_node mm/vmalloc.c:3057 [inline]
 __vmalloc_node_range+0x978/0x13c0 mm/vmalloc.c:3227
 kvmalloc_node+0x156/0x1a0 mm/util.c:606
 kvmalloc include/linux/slab.h:737 [inline]
 kvmalloc_array include/linux/slab.h:755 [inline]
 kvcalloc include/linux/slab.h:760 [inline]
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1035 [inline]
 z_erofs_decompress_queue+0x6e2/0x3060 fs/erofs/zdata.c:1141
 z_erofs_decompressqueue_work+0x77/0xb0 fs/erofs/zdata.c:1153
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


Tested on:

commit:         88603b6d Linux 6.2-rc2
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1193edc6480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46221e8203c7aca6
dashboard link: https://syzkaller.appspot.com/bug?extid=c3729cda01706a04fb98
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
