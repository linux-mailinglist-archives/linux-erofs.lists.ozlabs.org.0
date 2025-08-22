Return-Path: <linux-erofs+bounces-884-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A098B32278
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 20:55:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7qBt1W6yz3cy9;
	Sat, 23 Aug 2025 04:55:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.80
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755888934;
	cv=none; b=RvbOx1+V79PwSujp6C7W6oSZqOJ+v9uGLjkccFqrAxz9xHqhi6S+cBloGfdAqfces/TKcX3rHms8b/MQEDPrbQFb643AfnCngSQ0Ker2LpVSGpCBi/TkAoUlmXaYMDjx1NO7xqNQ1CroJyqnw2CC4BsUpdXx7HwK16t7SMT8T7MYFdP/sFwFANkNQwvXz2/rk+VM+y32285qGRfHWFV5hFOWh7VLo3bZ21W72hS5xwlIffLWCA16hS4qiRM5ZcZrFxM77gKLFnkKt4qccKci4qXeV6thXK1LtUzzgVV8hJSspAjxdiwoSjMkvngq4pYrM43xy0hXWyBS9602Gtxllw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755888934; c=relaxed/relaxed;
	bh=ESxP4ps4VFtj/7eR3pxdRW3J+PLwa0Tgkn2AHSSMyOU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cxz+TUgjStdrE4W6S/IKvQGtviQPH8FZAWG6TOxKeAeopjmSgbadJiczf5Mwh6bMQI2RAOrI/v8xQK56f6pjbyJGuCFxyDBG23sAE6YSMMPk6+fI47HDxbwAJGwdWXrbJY55eny6DTw5IBy4fes3psXws2qvi+jjn+HKodbDqzm5SxEbC7RtDOJ9usWEQvqgn80hSwWeMp8S2sTHo6SgW9aOZWAwxhgQRfyKoHh4dRtKf3Q6RLj6JJDahvkxZo/KonPq0M1OoQTqk+wYBMDpL2CFMKux7oe4O/ovZu22lMlB/vpLyc56peYTp4gW1alkNxgre6zyL0Bcv4dlQyGcPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.80; helo=mail-io1-f80.google.com; envelope-from=3il2oaakbaik5bcxnyyr4n22vq.t11tyr75r4p106r06.p1z@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.80; helo=mail-io1-f80.google.com; envelope-from=3il2oaakbaik5bcxnyyr4n22vq.t11tyr75r4p106r06.p1z@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7qBr2YCMz3cky
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Aug 2025 04:55:31 +1000 (AEST)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-88432e1f068so295375839f.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 11:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755888929; x=1756493729;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESxP4ps4VFtj/7eR3pxdRW3J+PLwa0Tgkn2AHSSMyOU=;
        b=brAoxJKNgESFL0b+bSdBBe8p1sapR3vWMFNUQ0Fb/onvDzOenfFblI+syqT4Vo5XjW
         6+G7lwke3k0SF5uLTQudz/KaT+9Ho5R3xKmk+I/lTyS24MjFT6q59gqzgXIU4nmvFfGl
         SQLJ8QQkAbS95lfPJEN4n+nuxD8OfntVvM8hOmYK+XlBVa467KEKU9Tso+xBN+x7S+nr
         65WJYSpaI0IbJNp32V6g0PpMbFhyudYP9XS0talHXhY1OQkdTf1jnaFolLd8HmG/0Km5
         JFe7qnr4uTsdryJO1fkxT6GKTUa/GlAmXyC1NpRpfKInB7ZEM6dXbQuJDWZzlEEhPyHH
         Q4VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwr6NlTNHmPd2RibaxTLjmzqyi2T/Iy1eckITGFuw9d0mN8kPygLXVqQmaHkfFsFaVwRXVnXfeTs5jkg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxmSUdDMZwSlP4MviWIgY5jkkYcX+AVGXIMNLiHgzAWCnHXpZ4B
	wx3o0iCMhAmGrSaxDvpDWB/V+3sgisFnE579upiC7Q3CtO6or/P5vGL3+Kjs7X6w03aUGJlb2J3
	lgboeOgOb9TH/9Mr0EKsahfeopxEK64jGmc/IwPdpjQIGuNxLeP6F4HBU+UU=
X-Google-Smtp-Source: AGHT+IHn2TTGvlJS+QXiOxYtabCHdCi0tpf3KzdhcZWwcEvafjQqrVOH2j8cD7Vv9XWBXm0PkEmCP4YyexYWtzea+iSw5oEMeGog
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
X-Received: by 2002:a05:6e02:3801:b0:3e3:d8af:3847 with SMTP id
 e9e14a558f8ab-3e921c4d9bemr61966665ab.16.1755888928572; Fri, 22 Aug 2025
 11:55:28 -0700 (PDT)
Date: Fri, 22 Aug 2025 11:55:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a8bd20.050a0220.37038e.005a.GAE@google.com>
Subject: [syzbot] [erofs?] KASAN: global-out-of-bounds Read in z_erofs_decompress_queue
From: syzbot <syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, jefflexu@linux.alibaba.com, 
	lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiang@kernel.org, zbestahu@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hello,

syzbot found the following issue on:

HEAD commit:    3957a5720157 Merge tag 'cgroup-for-6.17-rc2-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104f0062580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=5a398eb460ddaa6f242f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16650c42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1277dfa2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c5cbe8650b9a/disk-3957a572.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/51911bea9855/vmlinux-3957a572.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b07279b5fcc2/bzImage-3957a572.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b6ca0d9a661b/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=142187bc580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in z_erofs_decompress_pcluster fs/erofs/zdata.c:1274 [inline]
BUG: KASAN: global-out-of-bounds in z_erofs_decompress_queue+0x341/0x3580 fs/erofs/zdata.c:1411
Read of size 8 at addr ffffffff8e05df10 by task kworker/u9:1/5152

CPU: 1 UID: 0 PID: 5152 Comm: kworker/u9:1 Tainted: G        W           syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: erofs_worker z_erofs_decompressqueue_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1274 [inline]
 z_erofs_decompress_queue+0x341/0x3580 fs/erofs/zdata.c:1411
 z_erofs_decompressqueue_work+0x82/0xd0 fs/erofs/zdata.c:1423
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The buggy address belongs to the variable:
 z_erofs_decomp+0x30/0xe0

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xe05d
flags: 0x80000000002000(reserved|node=0|zone=1)
raw: 0080000000002000 ffffea0000381748 ffffea0000381748 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff8e05de00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff8e05de80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffffff8e05df00: 00 00 f9 f9 f9 f9 f9 f9 00 00 00 00 00 00 00 00
                         ^
 ffffffff8e05df80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff8e05e000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


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

