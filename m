Return-Path: <linux-erofs+bounces-1152-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A641BB21B6
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Oct 2025 02:10:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccXHz1S3gz3cZH;
	Thu,  2 Oct 2025 10:10:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.205
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759363839;
	cv=none; b=iZ+FtHOYzz7z8tMjkxFi39usUIaRuezzyv90Femaw/7jLjUBGRikys44KpY+0e04QM6iOvt8kZ5MZaUBjePvTGIN6dqIlP9nsOoNV2MZ0vm9EqSVtKFUcc82OCjlviQwRnxiHtp1I6uSsiX1uOIhjm/L4HIq/V9ETLKbRNj8xYA6SvLcD42HlFlFfa42FRGMwYtZ3qAQ+Fce/nnZYjUeHJE945R05OGMqeAY5i/zCkAjTKAWOGg7OiZ0f3C1mlKlqnQtIU3eQGFaxh2ZvRh6dN9l/qAtz+OIer23CQMniKL0DdhBu1OGNNGoTLcqS7ql38OAx3hQcXyrXD6JUFM+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759363839; c=relaxed/relaxed;
	bh=k+4I3VinM/g0IwZH7qpZY41xIHfXvj8Dn0TeRI7omzg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Cf8aJVedHSjAG/Kow5PZlaoWLAFviclHyipAtki0M6PRau6eXlP30pF3LsbftbyOaguIhYkTlb5Jyt3G9JwcYFQUtfLrVgAvTyFf85f9QTW672Ho8hXTi3xioG8qJTLIomfa+fzb4ZjqNP+uACQ6F4AIZViobPx+UcxvdZe/1rvjn0BRNtZtAy2F77f3EHOv3TpADf4agCVL5foNInC6DgYBIu6eSyItTJB+o9mdrpu1jMWUvBiOwIMtC00ZrVd1vpLC3TwrVVwz7AHfLYKR3/BQrOOD7x1aeqa7yzrPEyln+1JPMMwl8ipH8duM7/jjS1UPq6Fc0/lIhKwGGTz96w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.205; helo=mail-il1-f205.google.com; envelope-from=3-cldaakbaeqy45qgrrkxgvvoj.muumrk0ykxiutzktz.ius@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.205; helo=mail-il1-f205.google.com; envelope-from=3-cldaakbaeqy45qgrrkxgvvoj.muumrk0ykxiutzktz.ius@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccXHx5Fm4z30V1
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Oct 2025 10:10:36 +1000 (AEST)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-42591c9fca7so5001585ab.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 01 Oct 2025 17:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759363833; x=1759968633;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+4I3VinM/g0IwZH7qpZY41xIHfXvj8Dn0TeRI7omzg=;
        b=BHbxIvNT1WikqSGvUjjLvodLzy9SqoHJ3aqgy6QYJn4Bm0XuIWdZeT0Trw5Lnke6gr
         yHVJrXPAC6Sd0Ysrr/d29G/g/H+JeIVHKEH4RUHn1nkfD+3w+5R/Z1gLWtzmTHhAOphZ
         ctdcVP0sUIeVEOTSaiqmLUQr8H1XjUBRK0ZskOdN5VnQhUYDRFmMyhPzdcTWozt5S6GO
         URe7dLluIzOYdxP+Mh7StdwfbVcOrWb1Caayz5UkBuWEf//42AqOrDGuV7V4DcjABHsE
         fAaOUWd1gVeTYkESUTwHfjUoqQfpkt8EKrlftEx7NnwkQSxfHHW6BMNoQPQ1jX3xZM/k
         FjGA==
X-Forwarded-Encrypted: i=1; AJvYcCU03GfPhTAywrdijm3RAuRZMsPxJNhReOngb3T2U+PjSMqaKDgTSJdKjpl2wHbFChPkYgAupICNkiV7pg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyWOmJmSQIvemplUOEI0rUB1wE9BKym3Ghk59Zzczvx6P8v82K6
	DiUxFHomjUXHGWxtgot8A83/bXO8DksPtkXdeYgapog+v62WX+MeHCRqE1xU1CqcDWtqqNm5ynF
	7zmwi4HvQP4Pk0BCsMHZX+Ivr45VYLmx+EEGUpMTwTi/J6Qr6r/lZ8TD0hjU=
X-Google-Smtp-Source: AGHT+IE1y4VBYe8gL4btTD/TP03j3wgZRy1gTrrLiuVEGEC0nLniFFbXaPWxl9JheO+7+RBWePTX/t1UdzDxprw4A+hTUHhJ+Q8n
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188c:b0:42d:bb9d:5358 with SMTP id
 e9e14a558f8ab-42dbb9d5492mr5195145ab.27.1759363833558; Wed, 01 Oct 2025
 17:10:33 -0700 (PDT)
Date: Wed, 01 Oct 2025 17:10:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ddc2f9.a00a0220.102ee.006e.GAE@google.com>
Subject: [syzbot] [erofs?] WARNING in dax_iomap_rw
From: syzbot <syzbot+47680984f2d4969027ea@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, dan.j.williams@intel.com, 
	jack@suse.cz, linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, willy@infradead.org, 
	xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hello,

syzbot found the following issue on:

HEAD commit:    50c19e20ed2e Merge tag 'nolibc-20250928-for-6.18-1' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136ee6e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee1d7eda39c03d2c
dashboard link: https://syzkaller.appspot.com/bug?extid=47680984f2d4969027ea
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1181036f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15875d04580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-50c19e20.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/33a22a854fe0/vmlinux-50c19e20.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e68f79994eb8/bzImage-50c19e20.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/71839d8fa466/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17630a7c580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47680984f2d4969027ea@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 16
erofs (device loop0): mounted with root inode @ nid 36.
process 'syz.0.17' launched './file2' with NULL argv: empty string added
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5507 at fs/dax.c:1756 dax_iomap_rw+0xe34/0xed0 fs/dax.c:1756
Modules linked in:
CPU: 0 UID: 0 PID: 5507 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:dax_iomap_rw+0xe34/0xed0 fs/dax.c:1756
Code: ff ff 49 bd 00 00 00 00 00 fc ff df eb 84 e8 33 d7 6f ff 90 0f 0b 90 80 8c 24 c4 01 00 00 01 e9 b9 f4 ff ff e8 1d d7 6f ff 90 <0f> 0b 90 e9 ab f4 ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 56 f3
RSP: 0018:ffffc9000296f840 EFLAGS: 00010293
RAX: ffffffff824eae63 RBX: ffffc9000296fc00 RCX: ffff88801f938000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000296fb30 R08: ffffc9000296fa9f R09: 0000000000000000
R10: ffffc9000296f9f8 R11: fffff5200052df54 R12: 1ffff9200052df80
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000555575829500(0000) GS:ffff88808d967000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f41f4179286 CR3: 0000000050011000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __kernel_read+0x4cc/0x960 fs/read_write.c:530
 prepare_binprm fs/exec.c:1609 [inline]
 search_binary_handler fs/exec.c:1656 [inline]
 exec_binprm fs/exec.c:1702 [inline]
 bprm_execve+0x8ce/0x1450 fs/exec.c:1754
 do_execveat_common+0x510/0x6a0 fs/exec.c:1860
 do_execveat fs/exec.c:1945 [inline]
 __do_sys_execveat fs/exec.c:2019 [inline]
 __se_sys_execveat fs/exec.c:2013 [inline]
 __x64_sys_execveat+0xc4/0xe0 fs/exec.c:2013
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7556f8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffea3815728 EFLAGS: 00000246 ORIG_RAX: 0000000000000142
RAX: ffffffffffffffda RBX: 00007f75571e5fa0 RCX: 00007f7556f8eec9
RDX: 0000000000000000 RSI: 0000200000000000 RDI: ffffffffffffff9c
RBP: 00007f7557011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f75571e5fa0 R14: 00007f75571e5fa0 R15: 0000000000000005
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

