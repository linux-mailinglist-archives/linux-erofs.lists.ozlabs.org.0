Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207D26425CE
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Dec 2022 10:30:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NQdZR6rFsz3bZl
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Dec 2022 20:30:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54; helo=out30-54.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NQdZM34Mvz30RH
	for <linux-erofs@lists.ozlabs.org>; Mon,  5 Dec 2022 20:30:34 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=0;PH=DS;RN=8;SR=0;TI=SMTPD_---0VWQvSYN_1670232627;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VWQvSYN_1670232627)
          by smtp.aliyun-inc.com;
          Mon, 05 Dec 2022 17:30:29 +0800
Date: Mon, 5 Dec 2022 17:30:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: syzbot <syzbot+2ae90e873e97f1faf6f2@syzkaller.appspotmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in z_erofs_transform_plain
Message-ID: <Y426Mo9cweiBi77q@B-P7TQMD6M-0146.local>
References: <00000000000041127805ef10446a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00000000000041127805ef10446a@google.com>
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
Cc: syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Dec 05, 2022 at 12:13:47AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    97ee9d1c1696 Merge tag 'block-6.1-2022-12-02' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1786b2f5880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
> dashboard link: https://syzkaller.appspot.com/bug?extid=2ae90e873e97f1faf6f2
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115e5c47880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170fa3d5880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6a6a9ff34dfa/disk-97ee9d1c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2a01a4182c2b/vmlinux-97ee9d1c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4371158e8c25/bzImage-97ee9d1c.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/22dcea976d97/mount_0.gz
> 

It seems another report due to mixed ztailpacking (inline) and
non-inlined pclusters at once.

(Although I need to add another check for mixed algorithm formats for
 a single pcluster as well..)

#syz fix: erofs: Fix pcluster memleak when its block address is zero 

> The issue was bisected to:
> 
> commit dcbe6803fffd387f72b48c2373b5f5ed12a5804b
> Author: Gao Xiang <hsiangkao@linux.alibaba.com>
> Date:   Thu May 12 11:58:33 2022 +0000
> 
>     erofs: fix buffer copy overflow of ztailpacking feature
> 

It caused KASAN to begin to report, but it's not the root cause. Just
ignore it.

Thanks,
Gao Xiang
