Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B7D95C1BE
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 02:00:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WqgFG2Ygkz2yjR
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 10:00:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.199
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724371232;
	cv=none; b=H1Frx8upbFjMUKAA/QH3Vyod7bptLRqNYShJE/SBWKmMmY/gOVYgIBCVc9oyXCBAAwEXSc6/nJrOlBui3LNpHqg8O4fWF9mzduYWsZV7KtFN+C2VktqF75ZLm4VjB32W9UIt9kBV2Z2CCWcZfwwG5bB6vYmDka8cHvSFbl1k9VSXhtmkj5GrL+S1scCIQ5iTweCPiXlfiGnyh3SmjO/gL8wLvMmMblpIp+FZy2Rqa7hjpuL8BSX+zBz6ozbcSDaZtFxNqyJd+t3HgA00sfxwVdWp4/Xs9VNzztRPT8BRfbTm2/ZPW60+dUvug2deFmNnuw/2Yf7i6oqWI98UzJQd0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724371232; c=relaxed/relaxed;
	bh=ZVRJSEL0nD2KAQwy+qrV2FzdIhqngme6cZPNpl0t6Oo=;
	h=Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Google-Smtp-Source:MIME-Version:X-Received:
	 Date:In-Reply-To:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type; b=jmPyLv4ZkWhU7ntK/BOepCEfwdQ/iNIozz85RysfBBIhJChCrqFZhpeLbHSlGxEeAURkVZSYqNWtCAnQC8h/Q6HUmCrVLwpXmPsYR6Hkw+sLgQvNlbolaickmQTMgDjbGYEUYEi30S/lm7I86hHKtEfhbhhyY3Q5nqRlAgODaFOWeXYa4eqvGIj240CbbZ33CfOh3+GciWunAXWGOjVQMXNJVmeH0JhhdxI4pyOJS8hKVI6KTSWaQ1XWQDGqu9xCMxdT/qhS4/NDxyDkXWmYlhrL9cmx+RqGcrQ/9TQ+k1xS/HNcI8RdLLxpL4hcThniM3v9MiNRwcePHXt/oQHIFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.199; helo=mail-il1-f199.google.com; envelope-from=3gthhzgkbabkhno9zaa3gzee72.5dd5a3jh3g1dci3ci.1db@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.199; helo=mail-il1-f199.google.com; envelope-from=3gthhzgkbabkhno9zaa3gzee72.5dd5a3jh3g1dci3ci.1db@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WqgFC454Tz2yDs
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Aug 2024 10:00:30 +1000 (AEST)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d415635e6so15379115ab.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 22 Aug 2024 17:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724371227; x=1724976027;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVRJSEL0nD2KAQwy+qrV2FzdIhqngme6cZPNpl0t6Oo=;
        b=mhSi9zzKjpVvecXtkYAovqVxY+p91hOFt4QwS+qvcaG+6YGWZYdUR2pwlKuAdGyP1D
         QSRzw2ALIZs6tGe6Z/gecLXVbfPLQ+EsgaWXsMb0S2hiSR3BePsMXuteyG2Q5GKk6toO
         bN3yIvxGLtFpbGsWQAutEhGBd1492hxnYiBqLpB9XnnmOUtl0RWg7YWof6tXapcIXu3M
         nJBeR74qmCXTw4sgIF3W7TOOmQ3RTpPC4eu5CPDEDFE0DuuzLw4Df4S0sqa0oKn33kYE
         gRGioFRkzr4h9jKcfatIJuIzU3D1zIoH39ZTB4GOrDTp6JaxQBBDOfluru0U5/Fx0anI
         e/fg==
X-Forwarded-Encrypted: i=1; AJvYcCVI1iJ5YfCQzmyGDdr0w6+B4uzdzwCqKtHPC0GkzLwixKAvHMmZKEnEMHg4QNGPXZJ6YayriZYzjbGghg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyw7vtlWGXG/g2d0KEEByvxKusWIWHhUrBNKkH/eZ6qS/x/8Zbd
	L4BXVVF7hrAUe/zh5peNBzt1V/3G4w7Lgjw/s6Jo8nD7Zbt9VPC9zB2lsG+94LhTA9FWX4Atl+k
	0VI0L6puatr2UgMPRjmPHjwBWYA15GpuMZPFMasCVfv79BUODcxPtv3U=
X-Google-Smtp-Source: AGHT+IHXbHDGNacgb61MXzh5K83wTC7QH/vGfSUPjXAH8Dc9UTkiOleqFpQjekZZZgaaUAtOseHimbxptwskYbXOwhRIALYBxMwr
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4c:b0:39a:e900:7e3e with SMTP id
 e9e14a558f8ab-39e3c9f0512mr284975ab.3.1724371226662; Thu, 22 Aug 2024
 17:00:26 -0700 (PDT)
Date: Thu, 22 Aug 2024 17:00:26 -0700
In-Reply-To: <0000000000002fda01061e334873@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d2b8f06204e76f8@google.com>
Subject: Re: [syzbot] [erofs?] INFO: task hung in z_erofs_runqueue
From: syzbot <syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, hsiangkao@linux.alibaba.com, 
	huyue2@coolpad.com, jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    048499f92ed7 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1118b433980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c686716759500c2
dashboard link: https://syzkaller.appspot.com/bug?extid=4fc98ed414ae63d1ada2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d09f83980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e3247b980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/66c48334a6dc/disk-048499f9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a8e45cac172b/vmlinux-048499f9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/80940291bc58/Image-048499f9.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f7747709ae10/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com

INFO: task syz-executor173:6412 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc4-syzkaller-g048499f92ed7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor173 state:D stack:0     pid:6412  tgid:6412  ppid:6411   flags:0x00000005
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:553
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x13d4/0x2418 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xbc/0x238 kernel/sched/core.c:6621
 io_schedule+0x8c/0x124 kernel/sched/core.c:7401
 folio_wait_bit_common+0x65c/0xb90 mm/filemap.c:1307
 __folio_lock+0x2c/0x3c mm/filemap.c:1645
 folio_lock include/linux/pagemap.h:1050 [inline]
 z_erofs_fill_bio_vec fs/erofs/zdata.c:1470 [inline]
 z_erofs_submit_queue fs/erofs/zdata.c:1650 [inline]
 z_erofs_runqueue+0x838/0x17ec fs/erofs/zdata.c:1732
 z_erofs_readahead+0x858/0xc18 fs/erofs/zdata.c:1863
 read_pages+0x160/0x694 mm/readahead.c:160
 page_cache_ra_unbounded+0x484/0x584 mm/readahead.c:273
 do_page_cache_ra mm/readahead.c:303 [inline]
 force_page_cache_ra+0x22c/0x290 mm/readahead.c:332
 force_page_cache_readahead mm/internal.h:338 [inline]
 generic_fadvise+0x3e8/0x6a0 mm/fadvise.c:106
 vfs_fadvise mm/fadvise.c:185 [inline]
 ksys_fadvise64_64 mm/fadvise.c:199 [inline]
 __do_sys_fadvise64_64 mm/fadvise.c:207 [inline]
 __se_sys_fadvise64_64 mm/fadvise.c:205 [inline]
 __arm64_sys_fadvise64_64+0x12c/0x174 mm/fadvise.c:205
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffff80008f6edb60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:325
2 locks held by getty/6155:
 #0: ffff0000d23b60a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff80009836e2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x41c/0x1228 drivers/tty/n_tty.c:2211
1 lock held by syz-executor173/6412:
 #0: ffff0000deee0330 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:854 [inline]
 #0: ffff0000deee0330 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: page_cache_ra_unbounded+0xc8/0x584 mm/readahead.c:225

=============================================



---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
