Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2307D35A570
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Apr 2021 20:14:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FH5qn6tK0z3bpW
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Apr 2021 04:14:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W/mASdui;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W/mASdui;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=W/mASdui; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=W/mASdui; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FH5ql607gz2ysr
 for <linux-erofs@lists.ozlabs.org>; Sat, 10 Apr 2021 04:14:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617992046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9cxnipGcOQ8CcCKiRMMTjqef1u0BHrZmiuaF7aZ+aCk=;
 b=W/mASduiSGyzyL4rsz9rtZrwcBwBPM+Fg1VpW+gT5mAg3amNfQ8+G9L2iOvnN8YcTO0DFx
 oqlMwgAZVJboMuUYdJxDxPvUNFdJZ9LiMcoh90FOXS+9otJQr0LYDnoWe5U6slicdTw+Uq
 +1pQMuFqtP0MjDF8+iNMPv64OnXNFwA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617992046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9cxnipGcOQ8CcCKiRMMTjqef1u0BHrZmiuaF7aZ+aCk=;
 b=W/mASduiSGyzyL4rsz9rtZrwcBwBPM+Fg1VpW+gT5mAg3amNfQ8+G9L2iOvnN8YcTO0DFx
 oqlMwgAZVJboMuUYdJxDxPvUNFdJZ9LiMcoh90FOXS+9otJQr0LYDnoWe5U6slicdTw+Uq
 +1pQMuFqtP0MjDF8+iNMPv64OnXNFwA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-aWweFkNQMbKDSbd1nmj2mw-1; Fri, 09 Apr 2021 14:14:02 -0400
X-MC-Unique: aWweFkNQMbKDSbd1nmj2mw-1
Received: by mail-pj1-f70.google.com with SMTP id m15so1253619pjz.2
 for <linux-erofs@lists.ozlabs.org>; Fri, 09 Apr 2021 11:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9cxnipGcOQ8CcCKiRMMTjqef1u0BHrZmiuaF7aZ+aCk=;
 b=gZerNqhYKbhOFUTvfKXt+3+LDnK9E3LDFeaIWiUJvfTR4vvf8MY0dSZt1VUR99z0VW
 US26+n00s2iF+71YjT/a4RtDY8WuS7KISejdS/+WCnZ5FmTOxAdqqzzmKzvbFd7CnX55
 FdGVdB2/W1h3gLhxWjw7r8YNN5pXJo1rVuqNleAJr6UdvLveIOd4SaXPLupv1OpSSAqm
 Df4e1L7hTy1MzZTq7SabK2vZEWM0pkR6Hwi01K7ABqYRU+xOu2A4ri7uUAM5jdpv6G0L
 IGA2+MbqFW2j1R6ZQzPb1rcmYTME423JFxGmmsz2ImqGWNwSuNBu8xiMHYXJmcWpM4pu
 jnKA==
X-Gm-Message-State: AOAM533lKBYbPK08pIZLK0gqne6a9fG/I06OLESEZUCErkCvGNqoOR3f
 VL0wlC3fA7wHIZjyPMrDMUzSscg/z8YuwVBTOVQmVawuJZRFfNrGNjzHBY7x0CZ8RV9C6tctoPj
 6eBTpkq0UPGyXB+wGC7l64QsO
X-Received: by 2002:a17:90a:116:: with SMTP id
 b22mr9198849pjb.128.1617992041315; 
 Fri, 09 Apr 2021 11:14:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/hRH3Vgz3SM+P6g9kyScDLaNcTV74DrN8WtrqAE9AzUV24YoQUM8ZhORkL3ZWQP6B2ZIOIg==
X-Received: by 2002:a17:90a:116:: with SMTP id
 b22mr9198805pjb.128.1617992041012; 
 Fri, 09 Apr 2021 11:14:01 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f6sm3672500pgd.61.2021.04.09.11.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Apr 2021 11:14:00 -0700 (PDT)
Date: Sat, 10 Apr 2021 02:13:43 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: syzbot <syzbot+d6a0e4b80bd39f54c2f6@syzkaller.appspotmail.com>
Subject: Re: [syzbot] BUG: spinlock bad magic in erofs_pcpubuf_growsize
Message-ID: <20210409181343.GA875233@xiangao.remote.csb>
References: <00000000000012002d05bf8dec8d@google.com>
MIME-Version: 1.0
In-Reply-To: <00000000000012002d05bf8dec8d@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: mark.rutland@arm.com, x86@kernel.org, wanpengli@tencent.com,
 kvm@vger.kernel.org, peterz@infradead.org, hpa@zytor.com, will@kernel.org,
 joro@8bytes.org, rafael.j.wysocki@intel.com, mingo@redhat.com,
 xiang@kernel.org, syzkaller-bugs@googlegroups.com, rostedt@goodmis.org,
 bp@alien8.de, tglx@linutronix.de, akpm@linux-foundation.org,
 jmattson@google.com, seanjc@google.com, linux-kernel@vger.kernel.org,
 pbonzini@redhat.com, vkuznets@redhat.com, linux-erofs@lists.ozlabs.org,
 masahiroy@kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On Fri, Apr 09, 2021 at 10:59:15AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9c54130c Add linux-next specific files for 20210406
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1654617ed00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d125958c3995ddcd
> dashboard link: https://syzkaller.appspot.com/bug?extid=d6a0e4b80bd39f54c2f6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101a5786d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1147dd0ed00000
> 
> The issue was bisected to:
> 
> commit 997acaf6b4b59c6a9c259740312a69ea549cc684
> Author: Mark Rutland <mark.rutland@arm.com>
> Date:   Mon Jan 11 15:37:07 2021 +0000
> 
>     lockdep: report broken irq restoration
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d8d7aad00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=13d8d7aad00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15d8d7aad00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d6a0e4b80bd39f54c2f6@syzkaller.appspotmail.com
> Fixes: 997acaf6b4b5 ("lockdep: report broken irq restoration")
> 
> loop0: detected capacity change from 0 to 31
> BUG: spinlock bad magic on CPU#1, syz-executor062/8434
>  lock: 0xffff8880b9c31d60, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> CPU: 1 PID: 8434 Comm: syz-executor062 Not tainted 5.12.0-rc6-next-20210406-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x141/0x1d7 lib/dump_stack.c:120
>  debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
>  do_raw_spin_lock+0x216/0x2b0 kernel/locking/spinlock_debug.c:112
>  erofs_pcpubuf_growsize+0x36f/0x620 fs/erofs/pcpubuf.c:83
>  z_erofs_load_lz4_config+0x1ef/0x3e0 fs/erofs/decompressor.c:64
>  erofs_read_superblock fs/erofs/super.c:331 [inline]
>  erofs_fc_fill_super+0xe84/0x1d10 fs/erofs/super.c:499
>  get_tree_bdev+0x440/0x760 fs/super.c:1293
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1498
>  do_new_mount fs/namespace.c:2905 [inline]
>  path_mount+0x132a/0x1fa0 fs/namespace.c:3235
>  do_mount fs/namespace.c:3248 [inline]
>  __do_sys_mount fs/namespace.c:3456 [inline]
>  __se_sys_mount fs/namespace.c:3433 [inline]
>  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3433
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x444f7a
> Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe1fa3c2a8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007ffe1fa3c300 RCX: 0000000000444f7a
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffe1fa3c2c0
> RBP: 00007ffe1fa3c2c0 R08: 00007ffe1fa3c300 R09: 
> 

Thanks for the report. It's a spinlock uninitialization issue actually
due to the new patchset (bisect was wrong here), I will fix it up soon.

Thanks,
Gao Xiang

