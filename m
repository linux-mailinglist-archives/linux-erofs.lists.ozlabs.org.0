Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9885C6070AB
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 09:04:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtwSm3qZ6z3cfN
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 18:04:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtwSd47trz2xk6
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 18:04:32 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VSiUXvO_1666335866;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSiUXvO_1666335866)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 15:04:27 +0800
Date: Fri, 21 Oct 2022 15:04:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: huyue2@coolpad.com
Subject: Re: [syzbot] general protection fault in erofs_bread
Message-ID: <Y1JEeTVcuI7QEV+2@B-P7TQMD6M-0146.local>
References: <0000000000002e7a8905eb841ddd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000002e7a8905eb841ddd@google.com>
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
Cc: syzbot <syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com>, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Thu, Oct 20, 2022 at 09:45:41PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=168c673c880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
> dashboard link: https://syzkaller.appspot.com/bug?extid=3faecbfd845a895c04cb
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17fb206a880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b166ba880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/c1b35fb0988a/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 264192
> erofs: (device loop0): mounted with root inode @ nid 36.
> general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> CPU: 0 PID: 3611 Comm: syz-executor373 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> RIP: 0010:erofs_bread+0x33/0x760 fs/erofs/data.c:35
> Code: 53 48 83 ec 28 89 cb 41 89 d6 48 89 f5 49 89 fd 49 bc 00 00 00 00 00 fc ff df e8 78 b3 a5 fd 48 83 c5 30 48 89 e8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 ef e8 0e 1e f9 fd 89 5c 24 04 4c 8b 7d
> RSP: 0018:ffffc90003bdf2e0 EFLAGS: 00010206
> RAX: 0000000000000006 RBX: 0000000000000001 RCX: ffff888018de5880
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90003bdf4e0
> RBP: 0000000000000030 R08: ffffffff83e25022 R09: ffffc90003bdf4e0
> R10: fffff5200077be9f R11: 1ffff9200077be9c R12: dffffc0000000000
> R13: ffffc90003bdf4e0 R14: 000000007ec94954 R15: 000032487ec94954
> FS:  00005555571fa300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa00d733260 CR3: 000000007d91f000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  z_erofs_read_fragment fs/erofs/zdata.c:667 [inline]

Could you look into this issue? I think it's a simple issue (the
fragment feature sb flag is not set, but so packed_inode != NULL
needs to be checked in z_erofs_read_fragment()).

Thanks,
Gao Xiang
