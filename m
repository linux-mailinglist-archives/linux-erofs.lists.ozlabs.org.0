Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 503E527B6B9
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Sep 2020 22:53:47 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C0ZVw39MLzDqCs
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Sep 2020 06:53:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=gmx.com
 (client-ip=82.165.159.41; helo=mout-xforward.gmx.net;
 envelope-from=hsiangkao@gmx.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256
 header.s=badeba3b8450 header.b=aX5AEzbs; 
 dkim-atps=neutral
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C0ZSj6Sb5zDqKW
 for <linux-erofs@lists.ozlabs.org>; Tue, 29 Sep 2020 06:51:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1601326295;
 bh=EPZL/NujJsVZNPYsfdvjpeJWhp8BnqAniz5B+sF8nzI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aX5AEzbsCG8rlRkQtuOoFpgBR+X74yzMV6i4jS/vTvw5PQ6s+jl+Yd9jhPiXKkZww
 gKVkoEad0GnWRG/GR3r3Z4PI+50vkm9MuAr9j2jzlRP1NVolFq+3+AVnu19Kp4RD+5
 0abmX6C8GaE8NpVW5yKdXDstFaKNPPT14PME8LO4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([36.63.173.96]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MmUHp-1knq5K3fnt-00iVbp; Mon, 28 Sep 2020 22:30:44 +0200
Date: Tue, 29 Sep 2020 04:30:36 +0800
From: Gao Xiang <hsiangkao@gmx.com>
To: syzbot <syzbot+8afc256dce324523609d@syzkaller.appspotmail.com>
Subject: Re: kernel BUG at fs/erofs/inode.c:LINE!
Message-ID: <20200928203035.GA7770@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <0000000000000044ba05b05a9961@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000044ba05b05a9961@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:qX5JEJtmSwCYlQuaeYftyFY4oOTFZemw3qrihm8qW8JNjstw0Il
 ux7Uw9mOghzIEWthGeyRlGn0uVYr3HYWLtuoh54hW2ImscDzOMl0JpoAtVL+f+2BWd7jRhA
 qJ+lw1/pqlfGJiHIwqYK2vcwxQz/4ohFs1mmTXkOhyLrCuyBR1gfYbi+aGsLxqBVbKtB3fH
 2XVqpMNtr41bnru93gVfw==
X-Spam-Flag: YES
X-UI-Out-Filterresults: junk:10;V03:K0:iD+x02DeLRw=:gqgww9l1fmwbBM89NQoBu7MT
 wd2sIUFrAs0/ThTfzOCfofVME7VLjsXbbtdl6YBqsSFDUEuXS0KFyf8daNO0ds2XIfX+TxOdB
 Klw/UXfCP9THWNKPQAW5hnLw6T57kdLXdZ44HQuwmGrwG3EXTFW2yZZSKnv2BtT1a3Id0Osni
 prrhPbzdByrr3SRFCTH4x14zEutpXaWnUwuPsjQb9olXHZjHsOy5sWD7Pz9TM1w/zAnx+LdBT
 1xJnuSiFDAgkMrLDmJ7f0/d23KSR6+44lB6v8gl03rWHb3y8d+w+4Sx5EvH2cmysrLa0rDcJN
 HC5pbvE9SPP78+SyHAmKxqzPTkXTAbxkwla4rQr6aC3zpGQauMXQEp2G9GhOGsn77m22Y0Nt7
 k5SJ5bfyuHU6kDqalF8Z3TAVkL/SCGsDSc7JiTyVDJ9Eq+k/Cx4yfdZ0AQEZrca7I2z/7Ymku
 nprhBOQgDzDYLVJf9b7dTCBDkPuPOzph1b7eChpdVbElkAnFrgcp92lTKB+mvyBLJjAZ7TIPA
 MwG7J+15f6P2QGle//cQfJMK5GRyoisCnRDtqaj3ZfcOPRx1RviWGhOgHAz5OJncJBV8ZuPW/
 Pz4n3nVTP3JiGBdG/SE9lSo1b6+jKjJS4yr1FP+7PNKrkPuF0BkQhflQx/SCLeWR/YmiV0ia6
 wtXQXYFUeXi+Nuqk4Lgy5KBZp/HMBW9ox3rrhUfJQjeG2MVE5+jKZAvlJRw6ineokuqQ+AH5D
 l2LrWp1Phc6AxMmVABKxqknH/RAUKHwWi5Y2OUFlmeUD7AN+7aydef4tFoAkuPxLolCVqG4Mf
 m7HYJ137p0xs0bdGrwxVXlrpzpTXKTxZt5bjlSguc1+ukIP2hN1mbRZKoGgANL4MnIyoL6kRD
 /n6jGovt1sXxsDndWJvgR/FOanQa32tljgCelgeMBdTDgbnPrRbegWGo5hBSeH/VcZH1zzSZN
 PuiOb73gDtM/Q+eUrzKmdGcbVyaJcBGBqutfzyn2GTAZnWSgI5lr0kA7AgtcO4NqZfJ5y5fWs
 6T8zmutlRGiRDgVHRMwSgFAGtb5V+p7nYymvgFYBpBPH6m0lrVQRg3KNk1DD3VQ1rb9HGXITC
 H3b5q+kfDHTxg2r1B3QUrHr8TmhawDgsDJXKQP2I1ElXK/BkZvhxZsWkewywst8IBtoDRacXR
 0P6iuiVLbEmXDjQlb7LAS2l23dIhJc8TUqIkOtTQZ9HRWbpYQmcxu8TMuj9RUv5z7fb3AX+IU
 rfw0ksP3uj6lFDtoQoe3fwdFJNZDksNyEc9TOBLGAWlv9tnxJREhrgfGetwCrX4E0rW8lick4
 jjdW7/
Content-Transfer-Encoding: quoted-printable
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
Cc: devel@driverdev.osuosl.org, gaoxiang25@huawei.com,
 gregkh@linuxfoundation.org, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org, xiang@kernel.org, linux-erofs@lists.ozlabs.org
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
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D166cb7d99000=
00
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D254e028a6420=
27c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D8afc256dce3245=
23609d
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D127762c390=
0000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D124ccf3b9000=
00
>
> The issue was bisected to:
>
> commit 382329a9d8553a98418a6f6e3425f0c288837897
> Author: Gao Xiang <gaoxiang25@huawei.com>
> Date:   Wed Aug 14 10:37:04 2019 +0000
>
>     staging: erofs: differentiate unsupported on-disk format

if CONFIG_EROFS_DEBUG =3D y, the kernel will also BUG_ON on
currupted images in order to check potential mkfs fault.

So it's an expected behavior for now (if syzbot needs more
requirement, e.g. differ from runtime error vs corrupted error,
I can do it if needed.)

Thanks,
Gao Xiang

>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D149889e39=
00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D169889e39=
00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D129889e39000=
00
>
> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
> Reported-by: syzbot+8afc256dce324523609d@syzkaller.appspotmail.com
> Fixes: 382329a9d855 ("staging: erofs: differentiate unsupported on-disk =
format")
>
> erofs: (device loop0): erofs_read_inode: bogus i_mode (0) @ nid 36
> ------------[ cut here ]------------
> kernel BUG at fs/erofs/inode.c:182!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 6895 Comm: syz-executor894 Not tainted 5.9.0-rc6-next-202009=
24-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 01/01/2011
> RIP: 0010:erofs_read_inode fs/erofs/inode.c:182 [inline]
> RIP: 0010:erofs_fill_inode fs/erofs/inode.c:235 [inline]
> RIP: 0010:erofs_iget+0xfd8/0x2390 fs/erofs/inode.c:322
> Code: 00 0f 85 aa 10 00 00 49 8b 7c 24 28 49 89 d8 44 89 e9 48 c7 c2 a0 =
9c ef 88 48 c7 c6 40 9f ef 88 e8 b5 df b0 04 e8 88 5a 07 fe <0f> 0b e8 81 =
5a 07 fe 4c 89 e7 4c 63 e3 e8 b6 61 5b fe e9 ed f0 ff
> RSP: 0018:ffffc90001017c10 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000024 RCX: 0000000000000000
> RDX: ffff8880a172e480 RSI: ffffffff836dd6e8 RDI: fffff52000202f72
> RBP: ffff8880a8ca4480 R08: 0000000000000042 R09: ffff8880ae5319a7
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880854fd9b8
> R13: 0000000000000000 R14: ffffea0002a32900 R15: 0000000000000000
> FS:  000000000108e880(0000) GS:ffff8880ae500000(0000) knlGS:000000000000=
0000
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
> Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e =
0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 =
ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
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
> Code: 00 0f 85 aa 10 00 00 49 8b 7c 24 28 49 89 d8 44 89 e9 48 c7 c2 a0 =
9c ef 88 48 c7 c6 40 9f ef 88 e8 b5 df b0 04 e8 88 5a 07 fe <0f> 0b e8 81 =
5a 07 fe 4c 89 e7 4c 63 e3 e8 b6 61 5b fe e9 ed f0 ff
> RSP: 0018:ffffc90001017c10 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000024 RCX: 0000000000000000
> RDX: ffff8880a172e480 RSI: ffffffff836dd6e8 RDI: fffff52000202f72
> RBP: ffff8880a8ca4480 R08: 0000000000000042 R09: ffff8880ae5319a7
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880854fd9b8
> R13: 0000000000000000 R14: ffffea0002a32900 R15: 0000000000000000
> FS:  000000000108e880(0000) GS:ffff8880ae500000(0000) knlGS:000000000000=
0000
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
> For information about bisection process see: https://goo.gl/tpsmEJ#bisec=
tion
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
