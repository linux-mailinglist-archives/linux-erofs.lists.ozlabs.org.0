Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A9189CBA4
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Apr 2024 20:23:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VCyCR24lxz3dWc
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 04:23:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.70; helo=mail-io1-f70.google.com; envelope-from=3kjyuzgkbab8ntuf5gg9m5kkd8.bjjbg9pn9m7jio9io.7jh@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VCyCM01Myz3brC
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Apr 2024 04:23:41 +1000 (AEST)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5ea080228so87525939f.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 08 Apr 2024 11:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712600618; x=1713205418;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UUm+szSw9U0u1lY4JPbXO6oWA47+/M/JaLciS0pEX4E=;
        b=F+jDRbOjQMD4J4eLGfPBEEsNO/L9OC9BAnVG5wqaB6mZ6a/SYQXkN7JX4gP0Q8RHpu
         h464VPeZtkxnI6LOFdJ0+uEADpra83a71TsIRDsHq8PTeHB+/n+yVwWIO1uD8xXXoGrp
         bZk4LDJWv25QMUfytVUIn3ApoJccVhMMQHPApFF/eFQNcr8XjUdfMKqU0mBekILk8+jg
         Y1sFSBrCMFFxA6wP+HMVohl1nJQMooP2ux4hhRbr41VSyCuuFCaG7+hLkqfcyNsQD4y+
         0ID1KqX02uZPSiHTRCSSllTC8v7MGC+UEeZELs54NaFaKCEsrC+pmrxt/fzRrsZ+cQmg
         0Nwg==
X-Forwarded-Encrypted: i=1; AJvYcCUnWNzSIbVt7ZBDRufEHEBnNEpX2vENFpIZXvMP7YQrMEEWzC1Dvm44O33B0yqQ3EW3xs6N4VIvOG/fRkrBkPMJl9NMUiCJEP/moR2q
X-Gm-Message-State: AOJu0YwdL1abJ5b5JjYRdGH7q3i1lMrt9Vmw5ljIVIayvKBY+zEent30
	BdFVYkwmiHi+II9mgiI0s0j9ZeTbbGGf++TdmIpx06wgDWoEbspDg1rxFgVz0WpRLP0tQ7oUWKe
	q95TMieBk++adWHASrg4rR/JF0L6Q3j5qjqWjbXjd1L/qOnrOOtEIbfU=
X-Google-Smtp-Source: AGHT+IHdjussmaRyBPs04lU7GBZ+PrtUKgjd+cUrfJsMAVsMdC+0EmkTXDfvReJM3rOZuGh+P149w/69p1SsPv3AYNkODL9CXpXP
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1691:b0:7c8:264d:5e98 with SMTP id
 s17-20020a056602169100b007c8264d5e98mr16146iow.0.1712600618673; Mon, 08 Apr
 2024 11:23:38 -0700 (PDT)
Date: Mon, 08 Apr 2024 11:23:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084b9dd061599e789@google.com>
Subject: [syzbot] [erofs?] BUG: using smp_processor_id() in preemptible code
 in z_erofs_get_gbuf
From: syzbot <syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, huyue2@coolpad.com, 
	jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

HEAD commit:    2b3d5988ae2c Add linux-next specific files for 20240404
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=150f9d29180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c48fd2523cdee5e
dashboard link: https://syzkaller.appspot.com/bug?extid=27cc650ef45b379dfe5a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a60955180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d08115180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/136270ed2c7b/disk-2b3d5988.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/466d2f7c1952/vmlinux-2b3d5988.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7dfaf3959891/bzImage-2b3d5988.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2026b83172a2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com

BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u9:1/4483
caller is z_erofs_gbuf_id fs/erofs/zutil.c:31 [inline]
caller is z_erofs_get_gbuf+0x2c/0xd0 fs/erofs/zutil.c:39
CPU: 0 PID: 4483 Comm: kworker/u9:1 Not tainted 6.9.0-rc2-next-20240404-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: erofs_worker z_erofs_decompressqueue_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_preemption_disabled+0x10e/0x120 lib/smp_processor_id.c:49
 z_erofs_gbuf_id fs/erofs/zutil.c:31 [inline]
 z_erofs_get_gbuf+0x2c/0xd0 fs/erofs/zutil.c:39
 z_erofs_lz4_handle_overlap fs/erofs/decompressor.c:162 [inline]
 z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:234 [inline]
 z_erofs_lz4_decompress+0xe42/0x17b0 fs/erofs/decompressor.c:307
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1260 [inline]
 z_erofs_decompress_queue+0x1e30/0x3960 fs/erofs/zdata.c:1345
 z_erofs_decompressqueue_work+0x99/0xe0 fs/erofs/zdata.c:1360
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380


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
