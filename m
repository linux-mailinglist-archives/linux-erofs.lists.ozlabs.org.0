Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A34607186
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 09:56:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtxcP6l9Bz3dqr
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 18:56:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=i5rjpsQZ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=i5rjpsQZ;
	dkim-atps=neutral
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtxcL081Yz2xJ7
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 18:56:17 +1100 (AEDT)
Received: by mail-pf1-x42e.google.com with SMTP id p14so1886554pfq.5
        for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 00:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7AnO5H5sLRVB0mgELgO05aF29fMHtt1/HdTD0fWoi8=;
        b=i5rjpsQZ2BYyQz206YUFkH1lNJbiLGLqRUsaHj+pcZs/BprjFe5zAGcr2bHVEWbiFD
         cgXRO+4Zkls5kSDlr8zb4Lg2qUPAIjAclz/FuYRZzSG5+tHxU3GcDVWlV5ptNbCg/Hmz
         LjkKBoaT1O0nEkVsBjrpN20KQbMNsjraBXjLZgIksd3MwNmujELBn1ThF1TyDJDBGSt0
         C4eYqOJ60m6Cnlto3fKhDBEzSG+lYFMMALycMYQ6s7Wvqk+fX8RiiTt7wzQzSXSm/qoe
         +M9GSjAgg8BoN3O9mimv/sP0iR7sI0xjOydV5idEhzhCkTXsBG4Y1jAmFUYzwuM/7Brq
         A+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7AnO5H5sLRVB0mgELgO05aF29fMHtt1/HdTD0fWoi8=;
        b=N/paJCzic/fR9YFgEFFCws2Y4tx/tzYNYUdzCbg+6ocLrcvcpHHMe/PiRVKNGiIZd5
         /5u2Tj/w2Lt2WNj7yG+Z76G/jrg9+RdIF5FNbx46P9waxk4qWuDvUv0XAdmIAaE9mufS
         UwCuNQ2igSL4vlGCT+hACYKs+uwK12FyX06Xf1zGkt/hcl0lYXvTYouCRnOT6sOngY+W
         MuOjaqG1Zhrsj22ZQWnOgVCGSYA2/OZMmsgvaxwBMQuOSEjtbHxTnmGzwGtY1OordZno
         5t5M8rQgo1izxFXJCP1XjCZp+LVM1rFK5uWbSEAI7RK0ftL04GuXlVx6/5OSGNiUwvhm
         NWIQ==
X-Gm-Message-State: ACrzQf1eKsVcWwAyO3XaQwHYTOvwMzJKbMiw4qEjdA7qPEVgal9Yf7On
	4vhFUQrg/81xbBPu+hjK0G4=
X-Google-Smtp-Source: AMsMyM717BLR7IYTlFFPA+etJaeHkC3EFcOQ0JXH1gJwB46O/KaGAkdYps33oM3FzYlmEAGdkh1Xyw==
X-Received: by 2002:a63:b12:0:b0:44a:d193:6b16 with SMTP id 18-20020a630b12000000b0044ad1936b16mr15375023pgl.604.1666338972960;
        Fri, 21 Oct 2022 00:56:12 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902ea0100b001769206a766sm14180740plg.307.2022.10.21.00.56.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Oct 2022 00:56:12 -0700 (PDT)
Date: Fri, 21 Oct 2022 15:59:30 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, zhangwen@coolpad.com
Subject: Re: [syzbot] general protection fault in erofs_bread
Message-ID: <20221021155930.00005eb3.zbestahu@gmail.com>
In-Reply-To: <Y1JEeTVcuI7QEV+2@B-P7TQMD6M-0146.local>
References: <0000000000002e7a8905eb841ddd@google.com>
	<Y1JEeTVcuI7QEV+2@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: syzbot <syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com>, linux-erofs@lists.ozlabs.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 21 Oct 2022 15:04:25 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Thu, Oct 20, 2022 at 09:45:41PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=168c673c880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3faecbfd845a895c04cb
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17fb206a880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b166ba880000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/c1b35fb0988a/mount_0.gz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com
> > 
> > loop0: detected capacity change from 0 to 264192
> > erofs: (device loop0): mounted with root inode @ nid 36.
> > general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> > CPU: 0 PID: 3611 Comm: syz-executor373 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> > RIP: 0010:erofs_bread+0x33/0x760 fs/erofs/data.c:35
> > Code: 53 48 83 ec 28 89 cb 41 89 d6 48 89 f5 49 89 fd 49 bc 00 00 00 00 00 fc ff df e8 78 b3 a5 fd 48 83 c5 30 48 89 e8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 ef e8 0e 1e f9 fd 89 5c 24 04 4c 8b 7d
> > RSP: 0018:ffffc90003bdf2e0 EFLAGS: 00010206
> > RAX: 0000000000000006 RBX: 0000000000000001 RCX: ffff888018de5880
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90003bdf4e0
> > RBP: 0000000000000030 R08: ffffffff83e25022 R09: ffffc90003bdf4e0
> > R10: fffff5200077be9f R11: 1ffff9200077be9c R12: dffffc0000000000
> > R13: ffffc90003bdf4e0 R14: 000000007ec94954 R15: 000032487ec94954
> > FS:  00005555571fa300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fa00d733260 CR3: 000000007d91f000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  z_erofs_read_fragment fs/erofs/zdata.c:667 [inline]  
> 
> Could you look into this issue? I think it's a simple issue (the
> fragment feature sb flag is not set, but so packed_inode != NULL
> needs to be checked in z_erofs_read_fragment()).

Thanks for the tip.
Let me have a look first.

> 
> Thanks,
> Gao Xiang

