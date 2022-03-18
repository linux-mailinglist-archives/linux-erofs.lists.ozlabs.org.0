Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BB24DE40B
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 23:33:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KKzLQ25ZWz30HR
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Mar 2022 09:33:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
 (client-ip=209.85.166.199; helo=mail-il1-f199.google.com;
 envelope-from=3owg1ygkbakasyzkallerappid.googleusercontent.com@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com;
 receiver=<UNKNOWN>)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KKzLH6hF1z2xsW
 for <linux-erofs@lists.ozlabs.org>; Sat, 19 Mar 2022 09:33:10 +1100 (AEDT)
Received: by mail-il1-f199.google.com with SMTP id
 g5-20020a92dd85000000b002c79aa519f4so5537951iln.10
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Mar 2022 15:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
 :from:to;
 bh=mIO9yRV3fgG/DVkTsgBW4fDvGqZ5uti//MXNsZwJ45E=;
 b=7HdsZo2590i/IwPf895GAA7NHJfPB8sTfxAJHCePFrfp7PudXuNQUWCdSWP9/0yKLa
 kAoHgJryGaaHA+ZaPOPL/D3OMnM/LmhLWG9QldXx2T+9Dc5xFyThISXue2DggTtBkYp5
 WAbWPBhBuFWRqXsfyM/gqszfIrZ8jeTO3L3RAfXaduEW1zubzdc8Q1a+IZT3MWNfgVFL
 aEmA05OR/9mjNaAn4TGvASQPq54Sjb+zC1SPBFMLBc+ibqk4DNYGdo2HXXnwivFbQPpd
 JE+5M2KPPpuym4+PcXPgkvA/hRGPF73gV2FUfK4rV4CgabA0G2Uk6NnzhYvlwhRXo5qI
 6I0A==
X-Gm-Message-State: AOAM5329AV6cl1o/CjCyBgu1bOHSCI7hnJ32dgFb0zddKfpRNrWkRBAf
 STUKJTeaVVy9P04+qheaC7o9c7DwJwvZC9sWaXXN71/kapHw
X-Google-Smtp-Source: ABdhPJyQ2FOq8nKOfS42EnBuiD0kcWb9Hx8aBpPKskdcVGGzqfnU9wZ8ty9Vzaq2PmqftTKzmHQDWp4Kv8S6lnisQYEEJBYhVGSQ
MIME-Version: 1.0
X-Received: by 2002:a02:5b85:0:b0:319:ff85:ff5 with SMTP id
 g127-20020a025b85000000b00319ff850ff5mr5922420jab.250.1647642787039; Fri, 18
 Mar 2022 15:33:07 -0700 (PDT)
Date: Fri, 18 Mar 2022 15:33:07 -0700
In-Reply-To: <000000000000dda2f905da80c934@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009cf1e05da85bb31@google.com>
Subject: Re: [syzbot] WARNING: kobject bug in erofs_unregister_sysfs
From: syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chao@kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
 songmuchun@bytedance.com, 
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

syzbot has bisected this issue to:

commit 2768c206f2c3e95c0e5cf2e7f846103fda7cd429
Author: Muchun Song <songmuchun@bytedance.com>
Date:   Thu Mar 3 01:15:36 2022 +0000

    mm: list_lru: allocate list_lru_one only when needed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1495694d700000
start commit:   91265a6da44d Add linux-next specific files for 20220303
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1695694d700000
console output: https://syzkaller.appspot.com/x/log.txt?x=1295694d700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
dashboard link: https://syzkaller.appspot.com/bug?extid=f05ba4652c0471416eaf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137f17d9700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114ebabd700000

Reported-by: syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com
Fixes: 2768c206f2c3 ("mm: list_lru: allocate list_lru_one only when needed")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
