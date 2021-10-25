Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23628439B85
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Oct 2021 18:30:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HdL6V08vvz2y7M
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Oct 2021 03:30:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
 (client-ip=209.85.166.71; helo=mail-io1-f71.google.com;
 envelope-from=3o9t2yqkbaeg289ukvvo1kzzsn.qyyqvo42o1myx3ox3.myw@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com;
 receiver=<UNKNOWN>)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HdL6M4tGGz2xZR
 for <linux-erofs@lists.ozlabs.org>; Tue, 26 Oct 2021 03:30:33 +1100 (AEDT)
Received: by mail-io1-f71.google.com with SMTP id
 z15-20020a5ec90f000000b005dcd32f83a7so9259967iol.13
 for <linux-erofs@lists.ozlabs.org>; Mon, 25 Oct 2021 09:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
 :from:to;
 bh=ED9HaBWqU5sT7krjsMnqS958U0OD+vrR5JGVIAGxfyU=;
 b=SqO+6xZ2EaR1bgytzmtdKjVfvLgf4B1Qktb0qADp5PVm5Qb+Q7JBcXLWfnvi34/UHK
 pZniIYE4QEaQ1IIRwyll5Yd0edZRjiUIcpJEmLfy08wRpy03wyc+e9Q9GUoer/EAGpmT
 WmGVsg/p79pDLlw+guhK2B2txDnH06XnOBQI+KsKJeShcyDdTp4T2f4jnetUnbHfg6Xo
 /JJbIujU8+TAcZhE4flbr+TsCndyA9V8z6UCDgxdvFiY8BmhS18q00dcfHX7KdsYJmAU
 IZsT5Rz82dq6TfwQkIV0DQ3TLY+IzXG4Dsw2Cz7E5tkRkuxSEfJbkAO2YIuPxUpmMoxv
 4M1A==
X-Gm-Message-State: AOAM530eVLT4OBzWq2AciDy9f5fNHq6mY5poYOU5I7C2js41up1/BF52
 JY9rwLzXppQPp7ymQlinRSezhFHps2vubqZmfrw8hi5tD206
X-Google-Smtp-Source: ABdhPJxXkrJYJV80iY0jdxhn9EFabra2d5ekNi5WVz3UGuzf+5S92T5HwcJ39ZEmDR0fR1map4ZfFm8xX6uGJI3PEuGV4BC0Qw+R
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:14d3:: with SMTP id
 o19mr10571457ilk.257.1635179427889; 
 Mon, 25 Oct 2021 09:30:27 -0700 (PDT)
Date: Mon, 25 Oct 2021 09:30:27 -0700
In-Reply-To: <000000000000b3586105cf0ff45e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1887305cf2fe0d4@google.com>
Subject: Re: [syzbot] WARNING in z_erofs_lz4_decompress
From: syzbot <syzbot+d8aaffc3719597e8cfb4@syzkaller.appspotmail.com>
To: chao@kernel.org, dvyukov@google.com, fgheet255t@gmail.com, 
 hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    9ae1fbdeabd3 Add linux-next specific files for 20211025
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1300f7c4b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aeb17e42bc109064
dashboard link: https://syzkaller.appspot.com/bug?extid=d8aaffc3719597e8cfb4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103ac24ab00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177194e2b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8aaffc3719597e8cfb4@syzkaller.appspotmail.com

erofs: (device loop0): z_erofs_lz4_decompress_mem: failed to decompress -4099 in[4096, 0] out[9000]
------------[ cut here ]------------
WARNING: CPU: 1 PID: 45 at fs/erofs/decompressor.c:230 z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:227 [inline]
WARNING: CPU: 1 PID: 45 at fs/erofs/decompressor.c:230 z_erofs_lz4_decompress+0x841/0x1400 fs/erofs/decompressor.c:289
Modules linked in:
CPU: 1 PID: 45 Comm: kworker/u5:0 Not tainted 5.15.0-rc6-next-20211025-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: erofs_unzipd z_erofs_decompressqueue_work
RIP: 0010:z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:230 [inline]
RIP: 0010:z_erofs_lz4_decompress+0x841/0x1400 fs/erofs/decompressor.c:289
Code: e9 03 80 3c 11 00 0f 85 8c 0a 00 00 41 56 48 8b 7d 00 45 89 e9 89 d9 48 c7 c2 00 f0 fb 89 48 c7 c6 20 f2 fb 89 e8 fc 4a 85 05 <0f> 0b 48 b8 00 00 00 00 00 fc ff df 48 8b 4c 24 08 5f 48 89 ca 48
RSP: 0018:ffffc9000115f710 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffffffffeffd RCX: 0000000000000000
RDX: ffff88801599d7c0 RSI: ffffffff815f17d8 RDI: fffff5200022bed2
RBP: ffffc9000115f850 R08: 0000000000000063 R09: 0000000000000000
R10: ffffffff815eb5ae R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000002328 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056199e7f9008 CR3: 000000007f362000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 z_erofs_decompress_pcluster.isra.0+0x1301/0x2250 fs/erofs/zdata.c:975
 z_erofs_decompress_queue fs/erofs/zdata.c:1053 [inline]
 z_erofs_decompressqueue_work+0xe1/0x170 fs/erofs/zdata.c:1064
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

