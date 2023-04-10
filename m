Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A07D6DC514
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Apr 2023 11:26:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pw3WX3yFrz3cfH
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Apr 2023 19:26:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.200; helo=mail-il1-f200.google.com; envelope-from=3p9yzzakbaoiwcdoeppivettmh.ksskpiywivgsrxirx.gsq@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=<UNKNOWN>)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pw3WR3zhLz3cBj
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Apr 2023 19:26:25 +1000 (AEST)
Received: by mail-il1-f200.google.com with SMTP id i4-20020a056e020d8400b00325a80f683cso3758160ilj.22
        for <linux-erofs@lists.ozlabs.org>; Mon, 10 Apr 2023 02:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681118783; x=1683710783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wc2sUwlFpKZrrDVUHkKjAK8MSfapluqU8r9yqcMm9YE=;
        b=eJz0ZYuuRm2A+6BkzEU2Hz+qEARWLi9EQ094CNiOXxtlQ2howsEQ72KbTRVVvukH5b
         RjKFxu2K64YMSGLM4lgyU5CevbmiVmtoaW1QpmQ7nGs+gjxlTSs1QMnIBrP3fUQ113UL
         uOf0WU+Vl8XSCXDp/W0n2jNRqyFMPIXkw/F+Y6oMln2bVXrc3PdOwgguMgQHwLl8K++Q
         st91zFQvsV7xwtSCbBRRxGV9gtD1PYBPfKRXNjaIfQ6QOaSav6FHZijhyAoaAgsjsuF7
         xH4hW0bjT8djwuwYnTVmwzUB4PIIJuomHU5CQ3h8Hb0myvhYPoZRF8+0o16fohTMZ08B
         Oomg==
X-Gm-Message-State: AAQBX9dl8CaQs8oSO/8utjtsBvap2reZ9aG+2CWsC0z6zN7ZdcX+59r2
	NH5WxfHLwSG7cU15u3oCecHLIHB3Zz4XN2jgwVNGhdvTHzbK
X-Google-Smtp-Source: AKy350Yuion+XBa4D0xRy1+ObWUdzEIinu0vbNGMiPEVTe1OLQgW0zQvLwdl21uU0vfUVhEmhuHMhRg1iBFw9rWvXbu+rIA81XP7
MIME-Version: 1.0
X-Received: by 2002:a02:6287:0:b0:3a7:e46f:2a32 with SMTP id
 d129-20020a026287000000b003a7e46f2a32mr3783038jac.6.1681118783588; Mon, 10
 Apr 2023 02:26:23 -0700 (PDT)
Date: Mon, 10 Apr 2023 02:26:23 -0700
In-Reply-To: <90d29dc6-39b3-439c-904b-7a2207610d64@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebd27d05f8f7f713@google.com>
Subject: Re: [syzbot] [erofs?] WARNING in rmqueue
From: syzbot <syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel paging request in z_erofs_decompress_queue

BUG: unable to handle page fault for address: fffff52101a3fff9
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 23ffed067 P4D 23ffed067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 4398 Comm: kworker/u5:1 Not tainted 6.3.0-rc6-syzkaller-g09a9639e56c0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Workqueue: erofs_worker z_erofs_decompressqueue_work
RIP: 0010:z_erofs_decompress_queue+0xb7e/0x2b40
Code: 0a 48 8b 7c 24 68 e8 51 fe 00 fe 89 db 48 c1 e3 03 48 03 9c 24 20 03 00 00 49 89 de 49 c1 ee 03 48 b8 00 00 00 00 00 fc ff df <41> 80 3c 06 00 74 08 48 89 df e8 23 fe 00 fe 48 83 3b 00 0f 84 a1
RSP: 0018:ffffc90006a5f7c0 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffffc9080d1fffc8 RCX: 1ffff92000d4bf5c
RDX: ffff88802b800000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90006a5fbb0 R08: ffffffff83ddecfa R09: fffff52001a40000
R10: 0000000000000000 R11: dffffc0000000001 R12: 00000000ffff8f00
R13: ffff888073fad0b8 R14: 1ffff92101a3fff9 R15: ffffea0001b54b40
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff52101a3fff9 CR3: 000000002b4b9000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 z_erofs_decompressqueue_work+0x99/0xe0
 process_one_work+0x8f6/0x1170
 worker_thread+0xa63/0x1210
 kthread+0x270/0x300
 ret_from_fork+0x1f/0x30
 </TASK>
Modules linked in:
CR2: fffff52101a3fff9
---[ end trace 0000000000000000 ]---
RIP: 0010:z_erofs_decompress_queue+0xb7e/0x2b40
Code: 0a 48 8b 7c 24 68 e8 51 fe 00 fe 89 db 48 c1 e3 03 48 03 9c 24 20 03 00 00 49 89 de 49 c1 ee 03 48 b8 00 00 00 00 00 fc ff df <41> 80 3c 06 00 74 08 48 89 df e8 23 fe 00 fe 48 83 3b 00 0f 84 a1
RSP: 0018:ffffc90006a5f7c0 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffffc9080d1fffc8 RCX: 1ffff92000d4bf5c
RDX: ffff88802b800000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90006a5fbb0 R08: ffffffff83ddecfa R09: fffff52001a40000
R10: 0000000000000000 R11: dffffc0000000001 R12: 00000000ffff8f00
R13: ffff888073fad0b8 R14: 1ffff92101a3fff9 R15: ffffea0001b54b40
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff52101a3fff9 CR3: 000000002b4b9000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	48 8b 7c 24 68       	mov    0x68(%rsp),%rdi
   5:	e8 51 fe 00 fe       	callq  0xfe00fe5b
   a:	89 db                	mov    %ebx,%ebx
   c:	48 c1 e3 03          	shl    $0x3,%rbx
  10:	48 03 9c 24 20 03 00 	add    0x320(%rsp),%rbx
  17:	00
  18:	49 89 de             	mov    %rbx,%r14
  1b:	49 c1 ee 03          	shr    $0x3,%r14
  1f:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  26:	fc ff df
* 29:	41 80 3c 06 00       	cmpb   $0x0,(%r14,%rax,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 23 fe 00 fe       	callq  0xfe00fe5b
  38:	48 83 3b 00          	cmpq   $0x0,(%rbx)
  3c:	0f                   	.byte 0xf
  3d:	84                   	.byte 0x84
  3e:	a1                   	.byte 0xa1


Tested on:

commit:         09a9639e Linux 6.3-rc6
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.3-rc6
console output: https://syzkaller.appspot.com/x/log.txt?x=1125d353c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=174dd96f08254844
dashboard link: https://syzkaller.appspot.com/bug?extid=aafb3f37cfeb6534c4ac
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
