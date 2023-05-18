Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F477076B7
	for <lists+linux-erofs@lfdr.de>; Thu, 18 May 2023 02:06:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QM9Hv4tJGz3f5p
	for <lists+linux-erofs@lfdr.de>; Thu, 18 May 2023 10:06:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.70; helo=mail-io1-f70.google.com; envelope-from=3awxlzakbajgkqrc2dd6j2hha5.8gg8d6mk6j4gfl6fl.4ge@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=<UNKNOWN>)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QM9Hp1dkRz3drM
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 May 2023 10:06:28 +1000 (AEST)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-76c27782e30so92175739f.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 17 May 2023 17:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684368385; x=1686960385;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JoMoqXQ0K9ottZ20H37Za5eMXtoOXhgZyhPciqIVH40=;
        b=CJlP41p54Ek/tsUmuN18IbGvCJ5au06+efnsQL0FG92QCnHVAwwjX5RAUtw4xoSk74
         5AD4mDSqxdDPX1kCnj5zVEafDr6RYe4KYkkOVVC9Cg/tOjEVTmdvwVBTDBioAI7vgEhJ
         OwVtAk/s8fxg7wpr3pD4R8LyZeP3dXNTRq03Y9VbZt9Q3Hs4DRfgtGqkY89xr9WZE3pr
         cLR3rwhfKIWEItumcsgnIZq8WFhNpSpWfVmDjuiedjlXT05Ewm8HqIlSq6T7HKVa3MKj
         h+rZSlspsBNeTrTwMyGJJu6NrA0yFuHf0wheMh6x5CyleOa/pgxADoyOlJGXEC6+m44K
         wHDA==
X-Gm-Message-State: AC+VfDwwobHtTq4I+OqAbJ/aVFMDbO8OGlG7RYYXDz/sH/o+U6Agi+bs
	42m+S0zwH4m9p5xMo8baqmhQJnSpa0YHEUc6Dhso1txSxeVw
X-Google-Smtp-Source: ACHHUZ6DNGJMApeEtlCbWYZKgYUwbD77h7Sl32mT1FuFXMAbv1g8H2Rp/h6l/JOhvlYQ3m90Yo89xTWn99FpYmbgBWBt1f8GKVyH
MIME-Version: 1.0
X-Received: by 2002:a5e:db04:0:b0:76f:d7c2:aa54 with SMTP id
 q4-20020a5edb04000000b0076fd7c2aa54mr3866659iop.1.1684368385810; Wed, 17 May
 2023 17:06:25 -0700 (PDT)
Date: Wed, 17 May 2023 17:06:25 -0700
In-Reply-To: <000000000000d03b0805fbe71d55@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ea77505fbec93b6@google.com>
Subject: Re: [syzbot] [erofs?] general protection fault in erofs_bread (2)
From: syzbot <syzbot+bbb353775d51424087f2@syzkaller.appspotmail.com>
To: chao@kernel.org, hsiangkao@linux.alibaba.com, huyue2@coolpad.com, 
	jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
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

syzbot has bisected this issue to:

commit 6a318ccd7e083729cbcdbd174d7070f6b7d24130
Author: Jingbo Xu <jefflexu@linux.alibaba.com>
Date:   Fri Apr 7 22:28:08 2023 +0000

    erofs: enable long extended attribute name prefixes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=159afed9280000
start commit:   f1fcbaa18b28 Linux 6.4-rc2
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=179afed9280000
console output: https://syzkaller.appspot.com/x/log.txt?x=139afed9280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6beb6ffe4f59ef2a
dashboard link: https://syzkaller.appspot.com/bug?extid=bbb353775d51424087f2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dd834e280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167ef106280000

Reported-by: syzbot+bbb353775d51424087f2@syzkaller.appspotmail.com
Fixes: 6a318ccd7e08 ("erofs: enable long extended attribute name prefixes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
