Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9979FDDE0
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Dec 2024 08:45:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YLWVh25JDz2yvl
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Dec 2024 18:45:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.208
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735458330;
	cv=none; b=IJfOFfYRMmYtHIIhekfqWq1A1KjiSODOV2v0TCl7w7GbrlF6y1B9Rw4gE/CwxRXJ9mpOFag3QbIWPjHtOADOYhNGvTFpb2d23i5TskEjWbaUCsxeoPQw9bOeFi6LdOj4/IKtNhA995+CxI/WmR3bgNQE8HJIfN+YnxZf/LWA5HyKyycl4gfTSa4XE3EVuw6PpxbU5Ono8NBVx8Jhnd5YAhfySdiLrU/sVbdHbJ9/KwMJpjT7T+NVsBdf2aSM6yzfiaM5TXuObaNvJsduhckjI3U04kU8df1RMA1xgzXwtBODScnp1dW6jF/6V4swUeL2q0UysB06g3e2G7fePn1RLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735458330; c=relaxed/relaxed;
	bh=nY6FF6wVIPIvHMSTg3r+V8IDeKu8vi/BaNbTpEgfI7Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A1FEjfeOyq1//+5pgPMJX1+a/q3grueHyRVk2vapLrYbXPrXEWkdc3u+eLiG0HEsp1yYid9fnhFWMSNIIJCatLGh0hkqZoWnxil7S0o3I6u/P05J88BapfxgAq+1yZS0o1/A18F3qO7iyTcTS8l8rJ/izJJcEm9+NiUm548wP/Z9n2dRJip+Vlc+rTS2dc0eeE6uDLWhUgmJvGFHm0jLe3PePuABQYPqmuMQTpzRuzIGLSP+k+Yv0AkdEv/lsLav5zEgE/lTrYmR8W7N/3SJPYfNCKqmP5dA/s+qeM1rJhbr4rfPpz5cLsOKlE1OZuwfsOjjdQQLyZCRPl5qpU9wQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.208; helo=mail-il1-f208.google.com; envelope-from=3ev5wzwkbabudjk5v66zcvaa3y.19916zfdzcx98ez8e.x97@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.208; helo=mail-il1-f208.google.com; envelope-from=3ev5wzwkbabudjk5v66zcvaa3y.19916zfdzcx98ez8e.x97@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YLWVZ67Pzz2xLR
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 Dec 2024 18:45:25 +1100 (AEDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7d60252cbso71000025ab.0
        for <linux-erofs@lists.ozlabs.org>; Sat, 28 Dec 2024 23:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735458322; x=1736063122;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nY6FF6wVIPIvHMSTg3r+V8IDeKu8vi/BaNbTpEgfI7Y=;
        b=RkJr/rTSF6U56UNFoW2Ri1+XVIx7MjnrfDyJCDS7uBQR7iFSCRdnRN0qr3VkqgBWbj
         EsKK8HFI5MmE7tbTJPvXncRR0YugQVPKSnMY8UzJslPlU6qI2+hU3RMDfyWoEdQWljPJ
         WptJT24Qhfka3AcZA4M+y/8BhLkm3u5DAIc6BbJbHstPU3ZtZlaKGf+5p5PsKvHpg2Vf
         hENor7DHb3V60q0HdW7x5JDWPekDrgyohNgdoKOlNzR5aVwg716qiJLXPASUnfAvZBhU
         VBhyRrtMiMSwApSyPNEY1sk2ZKMf9i3cTFrDqioDvLG6LmddCuJyh9m+3iXI/dpOeNw6
         5fFA==
X-Forwarded-Encrypted: i=1; AJvYcCWkxKMKkZV7uKDJZoIapsDjn8CWTtSgoqn0hLiQdlHeqK1y249nlRP27sGiUCcaXgbXDOVnU80l8zFqAw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzKJ3tCgMjJLsmcs9lpFMxWoS0sbjj4eH8YFv/NTbYkLyX4QX+o
	e8NvvkuzhftzWBmfhNcrh6fuiDNEuScjyxY3ZKd1kqGytNmNsy7PcH2cUIdyMsYxom/R82qA0MN
	kxp7f/lbgqmdQnulP7OFN/AIaPEU8c4r+xrsAckknzrvB17TSrJ/x/qU=
X-Google-Smtp-Source: AGHT+IGKspHP6xb6eul/Z3USvCrw5kbj0TtsYcddWmq5Bh47TjtFUExS4AkuKmPn3eRPOY39g4v0ZIwLd423kYKBKRqUq6zKINOz
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c44:b0:3a7:c563:d3ad with SMTP id
 e9e14a558f8ab-3c03093ec46mr274867815ab.11.1735458322154; Sat, 28 Dec 2024
 23:45:22 -0800 (PST)
Date: Sat, 28 Dec 2024 23:45:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6770fe12.050a0220.226966.00bb.GAE@google.com>
Subject: [syzbot] [erofs?] KMSAN: uninit-value in erofs_fc_fill_super
From: syzbot <syzbot+1379ee6b9a14d5dacaf2@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, jefflexu@linux.alibaba.com, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org, zbestahu@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

HEAD commit:    9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112374c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9048090d7bb0d06
dashboard link: https://syzkaller.appspot.com/bug?extid=1379ee6b9a14d5dacaf2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/244f25c1a275/disk-9b2ffa61.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0d14fc6634fd/vmlinux-9b2ffa61.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cb152a4c0fd2/bzImage-9b2ffa61.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1379ee6b9a14d5dacaf2@syzkaller.appspotmail.com

exFAT-fs (loop7): failed to load upcase table (idx : 0x00010000, chksum : 0x1a9973fb, utbl_chksum : 0xe619d30d)
=====================================================
BUG: KMSAN: uninit-value in erofs_read_superblock fs/erofs/super.c:274 [inline]
BUG: KMSAN: uninit-value in erofs_fc_fill_super+0x66a/0x2520 fs/erofs/super.c:614
 erofs_read_superblock fs/erofs/super.c:274 [inline]
 erofs_fc_fill_super+0x66a/0x2520 fs/erofs/super.c:614
 vfs_get_super fs/super.c:1280 [inline]
 get_tree_nodev+0x183/0x350 fs/super.c:1299
 erofs_fc_get_tree+0x34d/0x450 fs/erofs/super.c:721
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3507
 path_mount+0x742/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:4034
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4034
 x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9a7/0xe00 mm/page_alloc.c:4776
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2269
 alloc_pages_noprof mm/mempolicy.c:2348 [inline]
 folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2355
 filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1009
 __filemap_get_folio+0xac4/0x1550 mm/filemap.c:1951
 block_write_begin+0x6e/0x2b0 fs/buffer.c:2221
 exfat_write_begin+0xfb/0x400 fs/exfat/inode.c:434
 exfat_extend_valid_size fs/exfat/file.c:553 [inline]
 exfat_file_write_iter+0x771/0x12a0 fs/exfat/file.c:598
 do_iter_readv_writev+0x88a/0xa30
 vfs_writev+0x56a/0x14f0 fs/read_write.c:1050
 do_pwritev fs/read_write.c:1146 [inline]
 __do_sys_pwritev2 fs/read_write.c:1204 [inline]
 __se_sys_pwritev2+0x262/0x460 fs/read_write.c:1195
 __x64_sys_pwritev2+0x11f/0x1a0 fs/read_write.c:1195
 x64_sys_call+0x368c/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:329
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 8448 Comm: syz.7.643 Not tainted 6.13.0-rc4-syzkaller-00012-g9b2ffa6148b1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
