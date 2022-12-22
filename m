Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABFF6548BB
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Dec 2022 23:56:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NdQdk6nzXz3bVZ
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Dec 2022 09:55:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.72; helo=mail-io1-f72.google.com; envelope-from=3ceckywkbaogcijukvvobkzzsn.qyyqvoecobmyxdoxd.myw@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=<UNKNOWN>)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NdQdf0m2Rz3bP1
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Dec 2022 09:55:48 +1100 (AEDT)
Received: by mail-io1-f72.google.com with SMTP id l21-20020a5d9315000000b006df7697880aso1277470ion.23
        for <linux-erofs@lists.ozlabs.org>; Thu, 22 Dec 2022 14:55:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXosvzq+A5vhYtuAlYzsv0/1c7zz/aBO/fowD1BzMYI=;
        b=IpS20mFRw/glFjur7WA+5HPbdRKLx0jXmNkvjGspmz8P2kMzLkwc4KfJ81lH80VH7k
         zc67bMWiLdXLFuP4NyMgZEL0CK7IlWEejhCbLs30KOrg+OR0jhennuYYqUTQohfu6oEm
         fMPlru20Kayd+C3MZB8Vad4gRykPteQlUTMfIk4W75qzWWqet6T4rgFd0VmUBtMI2eEY
         0BQXGrLDFGCbpCXafASOh5rD/cmCQk1OHW70Y45fpGsdBT5jFaw2RG18azFpFRsonbyM
         h1XHSF2ojidpc2E3lMbGoDSg/3+2E2gK4gPDyBVrPRjGF/kPg3sVp1rW1Mh8X4TPFiD8
         gDDg==
X-Gm-Message-State: AFqh2kpqxkDNZYHt5D8hlu3n0tp+rKLQlhKjUBU3/7Ss2w0+50ogl/nO
	R50WgK5N4Qi59UDz35+SGUgBVlNu5NICLUsVzC6SkaU7zXxC
X-Google-Smtp-Source: AMrXdXvYmJJ7+eFLnjMIqZuM5kFZXz/Oth90FBvGMSa/1IQ24ZqM8yFCBJwCzt5wTL4cQoXYsuNsEAKFO+o3FMK8oM3o2z9D6EV0
MIME-Version: 1.0
X-Received: by 2002:a5e:850f:0:b0:6ec:f27e:58a5 with SMTP id
 i15-20020a5e850f000000b006ecf27e58a5mr584311ioj.15.1671749745808; Thu, 22 Dec
 2022 14:55:45 -0800 (PST)
Date: Thu, 22 Dec 2022 14:55:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0a08805f07291a0@google.com>
Subject: [syzbot] [erofs?] WARNING: CPU: NUM PID: NUM at mm/page_alloc.c:LINE get_page_from_freeli
From: syzbot <syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chao@kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
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

Hello,

syzbot found the following issue on:

HEAD commit:    f9ff5644bcc0 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15aa58f7880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=827916bd156c2ec6
dashboard link: https://syzkaller.appspot.com/bug?extid=c3729cda01706a04fb98
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bdd020480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c53ab3880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0c8a5f06ceb3/disk-f9ff5644.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/be222e852ae2/vmlinux-f9ff5644.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d9f42a53b05e/bzImage-f9ff5644.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7f2f76b76cd2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 4386 at mm/page_alloc.c:3829 get_page_from_freeli


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
