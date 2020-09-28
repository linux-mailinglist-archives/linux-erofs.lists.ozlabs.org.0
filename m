Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B06F27B670
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Sep 2020 22:38:15 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C0Z9050KyzDqHg
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Sep 2020 06:38:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1601325492;
	bh=Mas9p/r0hRQAt6cOrzfhv0xStHJXFzsSg3H+T9tPeVw=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=juQIXFEQbClnlqLm6ixOd6G0fEB/tnsTDIuNpp93Q1NIeNkIWK+LtcWOzJE/Bl2+6
	 +Pk7CaiABnPwTHZx8fzfLSjbrds7HdZqopwAEBOFRVXZSYL99vToUUJLinxvuNg8Du
	 LL2psuzRrTQf96/lykaD+/+c4YicLLHLSwuIRvCX+njS8ScgWHdnfd5/elrtJT5S+B
	 1fWjJlxfhBnTWsYaToUesWKUCv9UF3ev3a5OmhOFY+839axzkwhvLB4ymQ+c/9PbYb
	 d0UydwcGsJsywxff73lzK4faedCRgy9Y8o/6Nom6QikKMsae6CRScyL7JWlfuT/Z8/
	 ace1AmZ4SLCLA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.148; helo=sonic302-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=ZVJJJ+yQ; dkim-atps=neutral
Received: from sonic302-22.consmr.mail.gq1.yahoo.com
 (sonic302-22.consmr.mail.gq1.yahoo.com [98.137.68.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C0Z8s6HcxzDqCc
 for <linux-erofs@lists.ozlabs.org>; Tue, 29 Sep 2020 06:38:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1601325482; bh=GZprWnTl+eBHSNmQV5uJKps1Zts7hTFzMj6gKmT4ZWQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=ZVJJJ+yQ+KR3dNBuJ/amrwqCHhf19H0Ii5HVplUqPqKAXNipeT60DiYPge54rA14LJMoXGV2ymt90/2QFbLatR4Aiye+ng7kZEaalkNVeIfvokX7+J7v0yN4rVNTIMl1/YzQ7tAtUQxOf9DuntvMbwsM7qh+vOnl1E14+6M45aXxEBu+05qYaJfUKEm508rs/ElDjxZOsRhl+EN+Ix95GB9LjFEkjI2dZPRdzRKvRHLqnLkCqn554i3B0GJcOktDtdxhcBhQqcWuQz56q8PylIIwdq2xmp0TuzvKWfrahkKKupDbLFCVFjSETeWYTixW+1gg3mUBUMeWdpD1M/yzjg==
X-YMail-OSG: qxLJVzQVM1lQSqYJ6MoZ3aW5WK957rVzm2ddGQEjg2ehiZR.ERUCkUBB.xK7sZ_
 aW2eDUJjsm7iLn.O1kaR2F2VNLlEWyBYNMs7XjZWS.CmuyZVSCAADky5dr4Po.yuNNklMNKoMqjp
 DkdZV2ujaWNXrGDYrd7pT6noQNS2ZAW70lt_0kEKbEMHe6SgWX3NIC3fDbo.KT7FYHsSpEwlZnI3
 J5CEwM11WUQC6p.0Y2WVqQyv9G.M3I25C5AChyrBu0IjsYCnFY7D6JURCs9sObR1but6K2b2cSet
 ie0BNXAzPgZToDrVJNgbuBxBgfNQ5p1zrILKR2eHgpsarx2kqHIm3b06BoZ3ddfXtKxbI746Er71
 SHgItSCWTgYxX.HlU19Tfc7nERdLL8CpLojpjPU7BozgxxwFL2y7JeeRbanJLtZPMjIxBeED8e8L
 lZhjds.zeOyqtDxlXML40jBrfw.G4RBK1CXKKsN6CURIKYZ7RLGA5NgFQbRIrmYwlWsaCs7iMPwk
 k3vpXwTLJfsdoGtlTM29hQYI_m7nCnhTS0Lg4PCnPZ99kRBGQg6lwgUnXa0F9jHnUlS08XJHo4Pg
 q927lGndaWDjn..2gZ8b8.TGucCUFO8xMNpYrxxeGrESKZoEeWfQ.if5UusmlEh5B3iO2aWp6YR2
 JUS8XSzzqeWtX6oeEmLn.XTQSvIPaH7auIRqTTZm6NWZpenFa11.NjF9K1tGqJAdGt3zfAybBwmD
 5.bXFtcgXIzhZaHhxKQM48YqVN_dl_yDjyCbCP96v03DtxgKrO2gob8vkRyH6GVHJcWKlfg433Yf
 BMuyH2hKQFM64CZ4JcxypRIt.2YWtSlvbxO9gYNHU6TgTRdsHQwzIs.hxCqOQgtK2YvVUIf8iZ.V
 AKH2Sw2kSMq.dVeJ.AdL1D6wkDhEdqVeQaS6fkmg1JrSynb1JJmmX4SEid7bgTBh_RZAFfxBOhdq
 3YBRANepO0Pn4x940jgI12uJ85VQv9fk9VDXabsyid8I3MbWe7HzP6hMlMD55j0726YNnxR0.wZS
 5L7RuDNpnFev9UpuOCsK0h53BcGYPhsj1PqJqjjHfL.SGiOeiRXQkIlXfEJKJjIk61GPC2LGMKHC
 E3W.eyZw7Jam6EYLyIlRHfK0TxoIyNXe.8zGrlBT9ytE4VQG6jnm7yxtci5TuiVh.uAByuTqFy6E
 SiQmoeKGCsbyQ9QLNh_8N9Ce2J6IGN7G9nirvogpfX3UOXBz0AP2gag5Q3wUQR3raivuUJ8GDxpW
 7GRsa1tk19MDTx5d.hMKA0O20APOvs2cDVPWnMu6PkhAAhDgdV1VdtmrM3yC76jIU4YGckBXPX6I
 70H_6DtoTpVZPArRSnA20A8FLrXwtsMvZYYEPpXiTIT49X6fai9BK97_Uj9MbywQWdws70j4O65Y
 XtLCnfMftb45kcnRDZUtBDeTQauBa9KUMgLgg5W1pFAh8w6mpnObAej1lHMdELP7Yel73cKqs_V0
 MUBxL4IG2Pq9P1tyc7E8Kpor0i_3VChL8hOEumjCPgcXD
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Mon, 28 Sep 2020 20:38:02 +0000
Received: by smtp419.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 1dcce5b8f69c9421ae96c4d2986bd734; 
 Mon, 28 Sep 2020 20:36:39 +0000 (UTC)
Date: Tue, 29 Sep 2020 04:36:30 +0800
To: syzbot <syzbot+8afc256dce324523609d@syzkaller.appspotmail.com>
Subject: Re: kernel BUG at fs/erofs/inode.c:LINE!
Message-ID: <20200928203035.GA7770@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <0000000000000044ba05b05a9961@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000044ba05b05a9961@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16674
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 xiang@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On Mon, Sep 28, 2020 at 12:27:24AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d1d2220c Add linux-next specific files for 20200924
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=166cb7d9900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=254e028a642027c
> dashboard link: https://syzkaller.appspot.com/bug?extid=8afc256dce324523609d
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127762c3900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124ccf3b900000
> 
> The issue was bisected to:
> 
> commit 382329a9d8553a98418a6f6e3425f0c288837897
> Author: Gao Xiang <gaoxiang25@huawei.com>
> Date:   Wed Aug 14 10:37:04 2019 +0000
> 
>     staging: erofs: differentiate unsupported on-disk format

if CONFIG_EROFS_DEBUG=y, the kernel will also BUG_ON on
currupted images in order to check potential mkfs fault.

So it's an expected behavior for now (if syzbot needs some more requirement,
e.g. differ from runtime error vs corrupted image error, I can do it if
needed.)

Thanks,
Gao Xiang

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149889e3900000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=169889e3900000
> console output: https://syzkaller.appspot.com/x/log.txt?x=129889e3900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8afc256dce324523609d@syzkaller.appspotmail.com
> Fixes: 382329a9d855 ("staging: erofs: differentiate unsupported on-disk format")
> 
> erofs: (device loop0): erofs_read_inode: bogus i_mode (0) @ nid 36
> ------------[ cut here ]------------
> kernel BUG at fs/erofs/inode.c:182!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 6895 Comm: syz-executor894 Not tainted 5.9.0-rc6-next-20200924-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:erofs_read_inode fs/erofs/inode.c:182 [inline]
> RIP: 0010:erofs_fill_inode fs/erofs/inode.c:235 [inline]
> RIP: 0010:erofs_iget+0xfd8/0x2390 fs/erofs/inode.c:322
> Code: 00 0f 85 aa 10 00 00 49 8b 7c 24 28 49 89 d8 44 89 e9 48 c7 c2 a0 9c ef 88 48 c7 c6 40 9f ef 88 e8 b5 df b0 04 e8 88 5a 07 fe <0f> 0b e8 81 5a 07 fe 4c 89 e7 4c 63 e3 e8 b6 61 5b fe e9 ed f0 ff
> RSP: 0018:ffffc90001017c10 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000024 RCX: 0000000000000000
> RDX: ffff8880a172e480 RSI: ffffffff836dd6e8 RDI: fffff52000202f72
> RBP: ffff8880a8ca4480 R08: 0000000000000042 R09: ffff8880ae5319a7
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880854fd9b8
> R13: 0000000000000000 R14: ffffea0002a32900 R15: 0000000000000000
> FS:  000000000108e880(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000043eb80 CR3: 00000000a7edb000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  erofs_fc_fill_super+0xaa3/0x1010 fs/erofs/super.c:382
>  get_tree_bdev+0x421/0x740 fs/super.c:1342
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1547
>  do_new_mount fs/namespace.c:2896 [inline]
>  path_mount+0x12ae/0x1e70 fs/namespace.c:3227
>  __do_sys_mount fs/namespace.c:3438 [inline]
>  __se_sys_mount fs/namespace.c:3411 [inline]
>  __x64_sys_mount+0x278/0x2f0 fs/namespace.c:3411
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x446d6a
> Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
> RSP: 002b:00007fffa8ef9ef8 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007fffa8ef9f50 RCX: 0000000000446d6a
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fffa8ef9f10
> RBP: 00007fffa8ef9f10 R08: 00007fffa8ef9f50 R09: 00007fff00000015
> R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000001
> R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003
> Modules linked in:
> ---[ end trace 66a5371a9bd8a3b2 ]---
> RIP: 0010:erofs_read_inode fs/erofs/inode.c:182 [inline]
> RIP: 0010:erofs_fill_inode fs/erofs/inode.c:235 [inline]
> RIP: 0010:erofs_iget+0xfd8/0x2390 fs/erofs/inode.c:322
> Code: 00 0f 85 aa 10 00 00 49 8b 7c 24 28 49 89 d8 44 89 e9 48 c7 c2 a0 9c ef 88 48 c7 c6 40 9f ef 88 e8 b5 df b0 04 e8 88 5a 07 fe <0f> 0b e8 81 5a 07 fe 4c 89 e7 4c 63 e3 e8 b6 61 5b fe e9 ed f0 ff
> RSP: 0018:ffffc90001017c10 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000024 RCX: 0000000000000000
> RDX: ffff8880a172e480 RSI: ffffffff836dd6e8 RDI: fffff52000202f72
> RBP: ffff8880a8ca4480 R08: 0000000000000042 R09: ffff8880ae5319a7
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880854fd9b8
> R13: 0000000000000000 R14: ffffea0002a32900 R15: 0000000000000000
> FS:  000000000108e880(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000043eb80 CR3: 00000000a7edb000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
