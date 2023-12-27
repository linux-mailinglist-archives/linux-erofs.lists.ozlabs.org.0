Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDAC81EEC9
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Dec 2023 13:31:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T0WGb313hz30hC
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Dec 2023 23:31:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.199; helo=mail-il1-f199.google.com; envelope-from=3hbmmzqkbalejpqbrccvirggzu.xffxcvljvitfekvek.tfd@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T0WGV1Lq5z2yRS
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 Dec 2023 23:31:28 +1100 (AEDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fda7cdff8so56338215ab.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 27 Dec 2023 04:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703680285; x=1704285085;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NEQ4OJoMAkL68WzsnkzhcssQVG8oHv67sa72RlVtyng=;
        b=QDwEhNqSxn3OzCg+17YE1Kvr2NQL4EMMnwA04Usob4Fg90qIwEndEtWgqvU2xm6597
         5whCRybth2BdwOMO1Dc6LMvTG977CxBYHO5xQW2kttGy9rI5lShidUhXUfPH4DBtM4NL
         2azOmmJs+PFWPcqESdwSEip09R8SCpyQ+m6L5sDuaRNqYhBw05jSfXdsemsnslIAaRPu
         6FD0A5kRtHzuT3WAneX/tsZjXMveTPAiaUwb614jsSTDrJlHYqIT8Qcx1Lpe/85MIAf4
         GvXPD1vcMzO6VZgBeb8lS3ehpaDUosca8TCoLLJTAlKsZzWTS4vaQhnCxBG7He3/1NeH
         ecxg==
X-Gm-Message-State: AOJu0YxiELP7/HNLV+b9LNaFeRF0ZdW2nNP7xAe+XDmRC9u6gOfk8GOU
	Rk2VEECeAuTfmVPYOXXzIz1oHReALUVUhBHhLxYCYBuE3GiO
X-Google-Smtp-Source: AGHT+IG3QcHBucRp6fJ0eMJKQWSeRMf7Bo6Sb6k7FZV9SWOJsaaMs8xbYRczBh+K/d8ZgOc76cldXvVaDQDjxLvM5q6dr3IUFmTZ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0c:b0:35f:c8aa:b526 with SMTP id
 i12-20020a056e021d0c00b0035fc8aab526mr1144470ila.2.1703680284955; Wed, 27 Dec
 2023 04:31:24 -0800 (PST)
Date: Wed, 27 Dec 2023 04:31:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000321c24060d7cfa1c@google.com>
Subject: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (2)
From: syzbot <syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com>
To: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
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

syzbot found the following issue on:

HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b0a595e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=6c746eea496f34b3161d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169fac19e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14aafc81e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1520f7b6daa4/disk-fbafc3e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b490af009d5/vmlinux-fbafc3e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/202ca200f4a4/bzImage-fbafc3e6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fcf70b38bafb/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 16
erofs: (device loop0): mounted with root inode @ nid 36.
erofs: (device loop0): z_erofs_lz4_decompress_mem: failed to decompress -12 in[46, 4050] out[917]
=====================================================
BUG: KMSAN: uninit-value in hex_dump_to_buffer+0xae9/0x10f0 lib/hexdump.c:194
 hex_dump_to_buffer+0xae9/0x10f0 lib/hexdump.c:194
 print_hex_dump+0x13d/0x3e0 lib/hexdump.c:276
 z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:252 [inline]
 z_erofs_lz4_decompress+0x257e/0x2a70 fs/erofs/decompressor.c:311
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1290 [inline]
 z_erofs_decompress_queue+0x338c/0x6460 fs/erofs/zdata.c:1372
 z_erofs_runqueue+0x36cd/0x3830
 z_erofs_read_folio+0x435/0x810 fs/erofs/zdata.c:1843
 filemap_read_folio+0xce/0x370 mm/filemap.c:2323
 do_read_cache_folio+0x3b4/0x11e0 mm/filemap.c:3691
 read_cache_folio+0x60/0x80 mm/filemap.c:3723
 erofs_bread+0x286/0x6f0 fs/erofs/data.c:46
 erofs_find_target_block fs/erofs/namei.c:103 [inline]
 erofs_namei+0x2fe/0x1790 fs/erofs/namei.c:177
 erofs_lookup+0x100/0x3c0 fs/erofs/namei.c:206
 lookup_one_qstr_excl+0x233/0x520 fs/namei.c:1609
 filename_create+0x2fc/0x6d0 fs/namei.c:3876
 do_mkdirat+0x69/0x800 fs/namei.c:4121
 __do_sys_mkdirat fs/namei.c:4144 [inline]
 __se_sys_mkdirat fs/namei.c:4142 [inline]
 __x64_sys_mkdirat+0xc8/0x120 fs/namei.c:4142
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages mm/mempolicy.c:2204 [inline]
 folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
 filemap_alloc_folio+0xa5/0x430 mm/filemap.c:974
 do_read_cache_folio+0x163/0x11e0 mm/filemap.c:3655
 read_cache_folio+0x60/0x80 mm/filemap.c:3723
 erofs_bread+0x286/0x6f0 fs/erofs/data.c:46
 erofs_find_target_block fs/erofs/namei.c:103 [inline]
 erofs_namei+0x2fe/0x1790 fs/erofs/namei.c:177
 erofs_lookup+0x100/0x3c0 fs/erofs/namei.c:206
 lookup_one_qstr_excl+0x233/0x520 fs/namei.c:1609
 filename_create+0x2fc/0x6d0 fs/namei.c:3876
 do_mkdirat+0x69/0x800 fs/namei.c:4121
 __do_sys_mkdirat fs/namei.c:4144 [inline]
 __se_sys_mkdirat fs/namei.c:4142 [inline]
 __x64_sys_mkdirat+0xc8/0x120 fs/namei.c:4142
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 5006 Comm: syz-executor342 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


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
