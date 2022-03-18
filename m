Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B47364DE0AC
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 19:03:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KKsMX4c1lz30NV
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Mar 2022 05:03:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JoxqQDlN;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=JoxqQDlN; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KKsMQ3hnlz3089
 for <linux-erofs@lists.ozlabs.org>; Sat, 19 Mar 2022 05:03:46 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C183361ACF;
 Fri, 18 Mar 2022 18:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10289C340E8;
 Fri, 18 Mar 2022 18:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647626621;
 bh=ZdiwMW3roY3Dba6xowNXVsMAmxI6ZyKJcnpFjdDdosg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JoxqQDlN85SQ5TCOoq32HJPyyoTWVUgFLPj360G6n3EG+hr6RaW14jHLgeHpQySi3
 Mf/yhurs31p/BsrD6EXrBNfdo2JGHYrGSGMwiDCmgMpOS7HgVdsFFIUn1B4lRQGQwu
 v/LjXjR5ikSnp1U/18oQ0iky14U1uF8hhu/8nzEWtNWsZRxwmiCzijhZDSPypW9d3Q
 Fz8dk2r8NM2ELN13tmRy1qyetAVE4z3Ux81bjlHP61x1xqxVV7jDx8aeMFpCZOSE4l
 6CLGPGkd2PhqP0pAD4OpX3ALFCibkXc2EUIeSoe9bZ1PR7WnxDio3Ir4i8EWigknbl
 h7qTeLxg1Rfxg==
Date: Sat, 19 Mar 2022 02:02:45 +0800
From: Gao Xiang <xiang@kernel.org>
To: syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>
Subject: Re: [syzbot] WARNING: kobject bug in erofs_unregister_sysfs
Message-ID: <YjTJRQb9eMXdsHOE@debian>
Mail-Followup-To: syzbot
 <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>, 
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 xiang@kernel.org
References: <000000000000dda2f905da80c934@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000dda2f905da80c934@google.com>
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
Cc: syzkaller-bugs@googlegroups.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Mar 18, 2022 at 09:39:20AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    91265a6da44d Add linux-next specific files for 20220303
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11007413700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
> dashboard link: https://syzkaller.appspot.com/bug?extid=f05ba4652c0471416eaf
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137f17d9700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114ebabd700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com

It has already been fixed with
https://lore.kernel.org/r/20220315132814.12332-1-dzm91@hust.edu.cn

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev

Thanks,
Gao Xiang

> 
> RBP: 00007fff8eeb06e0 R08: 00007fff8eeb0720 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000286 R12: 00000000200000b0
> R13: 0000000000000004 R14: 0000000000000005 R15: 0000000000000002
>  </TASK>
> ------------[ cut here ]------------
> kobject: '(null)' (ffff888077324190): is not initialized, yet kobject_put() is being called.
> WARNING: CPU: 0 PID: 3610 at lib/kobject.c:750 kobject_put+0x22b/0x540 lib/kobject.c:750
> Modules linked in:
> CPU: 0 PID: 3610 Comm: syz-executor471 Not tainted 5.17.0-rc6-next-20220303-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:kobject_put+0x22b/0x540 lib/kobject.c:750
> Code: e8 6a 83 67 fd 48 89 e8 48 c1 e8 03 42 80 3c 20 00 0f 85 94 02 00 00 48 8b 75 00 48 89 ea 48 c7 c7 c0 0d 2a 8a e8 c1 5b 07 05 <0f> 0b e9 32 fe ff ff e8 39 83 67 fd 4d 89 f9 48 89 e9 4c 89 f2 49
> RSP: 0018:ffffc90003b9fc48 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff88801c67ba80 RSI: ffffffff81602878 RDI: fffff52000773f7b
> RBP: ffff888077324190 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff815fd23e R11: 0000000000000000 R12: dffffc0000000000
> R13: ffff8880773241cc R14: ffff888073799cf8 R15: ffff8880207dc068
> FS:  0000555556165300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff8eeb1000 CR3: 000000001ac3f000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  erofs_unregister_sysfs+0x46/0x60 fs/erofs/sysfs.c:225
>  erofs_put_super+0x37/0xb0 fs/erofs/super.c:771
>  generic_shutdown_super+0x14c/0x400 fs/super.c:462
>  kill_block_super+0x97/0xf0 fs/super.c:1394
>  erofs_kill_sb+0x60/0x190 fs/erofs/super.c:752
>  deactivate_locked_super+0x94/0x160 fs/super.c:332
>  get_tree_bdev+0x573/0x760 fs/super.c:1294
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1497
>  do_new_mount fs/namespace.c:3025 [inline]
>  path_mount+0x1320/0x1fa0 fs/namespace.c:3355
>  do_mount fs/namespace.c:3368 [inline]
>  __do_sys_mount fs/namespace.c:3576 [inline]
>  __se_sys_mount fs/namespace.c:3553 [inline]
>  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3553
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fa80fa1344a
> Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff8eeb06c8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007fff8eeb0720 RCX: 00007fa80fa1344a
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fff8eeb06e0
> RBP: 00007fff8eeb06e0 R08: 00007fff8eeb0720 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000286 R12: 00000000200000b0
> R13: 0000000000000004 R14: 0000000000000005 R15: 0000000000000002
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
