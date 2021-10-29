Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A229A43FFA7
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 17:34:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HgmhH3nV0z304v
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Oct 2021 02:34:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZUpHS5YE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZUpHS5YE; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HgmhD1ZjYz2xXx
 for <linux-erofs@lists.ozlabs.org>; Sat, 30 Oct 2021 02:34:52 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E7276117A;
 Fri, 29 Oct 2021 15:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635521689;
 bh=qT1Szh+ndbqyM/0hD/TUs97RBYUAdlEIkgLut+Otmpo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZUpHS5YENNdKqDKeqXpArD4masKrX19zCdqZAKUBnvaRpCueOfO5EVEm/qojbtjHU
 iM0wfvxXPiXWRNyNweDxXfKaEjvbUOD5L3BWpwkiAEKAefr8TXZvd7YQXHaJn/y4l8
 cB6WJfQmYgA1WvctwHjphAABAYWhG/1nzHJCZTHSU/knO79aJj2P0v8894DehJdwfy
 RufeOY1eUUwxP9/dvmNCyLbA9mTL5EEV04U6E0oVJ6uwEv2nxRAatAp2e2olhu8r8S
 9H4+bWQfkCsqftZ92pXl/5RDbYXCFg6BKNx00t5S7nZMphKh3R0bIL29Zjoi4hmdPK
 zV2OjXitr8+Lw==
Date: Fri, 29 Oct 2021 23:32:21 +0800
From: Gao Xiang <xiang@kernel.org>
To: syzbot <syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in LZ4_decompress_safe_partial
Message-ID: <20211029153214.GA15359@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: syzbot
 <syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com>, 
 chao@kernel.org, gaoxiang25@huawei.com, gregkh@linuxfoundation.org,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 viro@zeniv.linux.org.uk, xiang@kernel.org, yuchao0@huawei.com,
 Chengyang Fan <cy.fan@huawei.com>
References: <000000000000830d1205cf7f0477@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000830d1205cf7f0477@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: yuchao0@huawei.com, gaoxiang25@huawei.com, gregkh@linuxfoundation.org,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 Chengyang Fan <cy.fan@huawei.com>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

(+cc Chengyang Fan)

On Fri, Oct 29, 2021 at 07:55:27AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    87066fdd2e30 Revert "mm/secretmem: use refcount_t instead ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10c2c88cb00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=59f3ef2b4077575
> dashboard link: https://syzkaller.appspot.com/bug?extid=63d688f1d899c588fb71
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17032c4ab00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170f8c3cb00000
> 
> The issue was bisected to:
> 
> commit f86cf25a609107960cf05263e491463feaae1f99
> Author: Gao Xiang <gaoxiang25@huawei.com>
> Date:   Tue Aug 28 03:39:48 2018 +0000
> 
>     Revert "staging: erofs: disable compiling temporarile"
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11de0328b00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=13de0328b00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15de0328b00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com
> Fixes: f86cf25a6091 ("Revert "staging: erofs: disable compiling temporarile"")
> 
> ==================================================================
> BUG: KASAN: use-after-free in get_unaligned_le16 include/asm-generic/unaligned.h:27 [inline]
> BUG: KASAN: use-after-free in LZ4_readLE16 lib/lz4/lz4defs.h:132 [inline]
> BUG: KASAN: use-after-free in LZ4_decompress_generic lib/lz4/lz4_decompress.c:285 [inline]
> BUG: KASAN: use-after-free in LZ4_decompress_safe_partial+0xff8/0x1580 lib/lz4/lz4_decompress.c:469
> Read of size 2 at addr ffff88806dd1f000 by task kworker/u5:0/150
> 
> CPU: 1 PID: 150 Comm: kworker/u5:0 Not tainted 5.15.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: erofs_unzipd z_erofs_decompressqueue_work
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
>  print_address_description+0x66/0x3e0 mm/kasan/report.c:256
>  __kasan_report mm/kasan/report.c:442 [inline]
>  kasan_report+0x19a/0x1f0 mm/kasan/report.c:459
>  get_unaligned_le16 include/asm-generic/unaligned.h:27 [inline]
>  LZ4_readLE16 lib/lz4/lz4defs.h:132 [inline]
>  LZ4_decompress_generic lib/lz4/lz4_decompress.c:285 [inline]
>  LZ4_decompress_safe_partial+0xff8/0x1580 lib/lz4/lz4_decompress.c:469
>  z_erofs_lz4_decompress+0x4c3/0x1100 fs/erofs/decompressor.c:226
>  z_erofs_decompress_generic fs/erofs/decompressor.c:354 [inline]
>  z_erofs_decompress+0xa8e/0xe30 fs/erofs/decompressor.c:407
>  z_erofs_decompress_pcluster+0x15e4/0x2550 fs/erofs/zdata.c:977
>  z_erofs_decompress_queue fs/erofs/zdata.c:1055 [inline]
>  z_erofs_decompressqueue_work+0x123/0x1a0 fs/erofs/zdata.c:1066
>  process_one_work+0x853/0x1140 kernel/workqueue.c:2297
>  worker_thread+0xac1/0x1320 kernel/workqueue.c:2444
>  kthread+0x453/0x480 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30
> 

It's quite similar to
https://lore.kernel.org/r/CC666AE8-4CA4-4951-B6FB-A2EFDE3AC03B@fb.com

But I'm not sure if Chengyang Fan is still working on this stuff.

Anyway, it can only be reproduced by specific craft compressed data.

Thanks,
Gao Xiang

