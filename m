Return-Path: <linux-erofs+bounces-885-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B60B32323
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 21:46:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7rKH2zGRz3d0s;
	Sat, 23 Aug 2025 05:46:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.69
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755891971;
	cv=none; b=HG5Dpt6HiK1T4WjUVPGte3k7UUwxCnHZp6SjAhxh+eIXoFCGjoP2hJ8BE3gLW7yKICmGCKnrSug8C/UXLHzNloB4wKRP0PO5T2Dm6V2sjFzJVXvXYpMFRAoe9DW+pBEXV5GQZM3c03tNeLgqu+E5KHECyu14KTdrFe1CEONw0OCiWnXDwQrrDLT6GjaSleKvoLqwv2OnNVEwLOTtPJFzeWtfwkujf9Edq4+whx++GKjjggU2LdUiuENkl6tbokivt5amM2bLL4hkTuawYEJa5H97YiGNHGyP176kxfseE1+SyJJrniervYot9ZyUVKyMMVWvy/WJHDIzvUtVJP0EYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755891971; c=relaxed/relaxed;
	bh=NqSC6tySboQLbJ5EI4n/KR+EKbtxNLb53k76lwO30Xw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=APE91pfwFnZ1J5/HDjc+YvKZ8stXZkIx4psfCovd1iU5so3x2iHRanPw153fKv47anjygULugc5GOGgtR5mxp24U9+4DFry1Ea4P4ZTXhoJDr62fbeRTXPEw8U0kCMhS9WnX/yvN5cjzkXrEnqdYip258bX7o/UzI9jOGNVocaoZ2jZDMDHJBQpniFZYf+Ivg3NGNuQVsp8fBh0RWKch1UnpAN3l3Bvf4YYkquJI37GtJwXx+TYRCLE/cEBSuqBGNDE5h5JmHiDhiz6Ru1KGmvGUYexKb3lpw1Qq/VCboBuV5Sp4mNXxfqCSRCNkLnl9jWE751hlisf3TGxh4UY1Cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.69; helo=mail-io1-f69.google.com; envelope-from=3_mioaakbah0tz0lbmmfsbqqje.hpphmfvtfsdpoufou.dpn@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.69; helo=mail-io1-f69.google.com; envelope-from=3_mioaakbah0tz0lbmmfsbqqje.hpphmfvtfsdpoufou.dpn@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7rKC5VRBz3cnT
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Aug 2025 05:46:07 +1000 (AEST)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88432d8ddb1so239518239f.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 12:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755891965; x=1756496765;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NqSC6tySboQLbJ5EI4n/KR+EKbtxNLb53k76lwO30Xw=;
        b=SF7svHdWL8DHBL4Ksuy9NzrBrI+E1UyWpX3Vu6isHE3CM0a0CFne1i5io5j4ACLh7v
         mjgBEUzWtp5HzcMheqBwGA2gv5KatXMJ/myTdAvGqSvFo0JmHxXpZU6+n6JyLWYSaqzW
         5MxQ4IjklUQQEAaE/Uh9yCl+kKpxXqDPVtGcFzDQaUmqTk9ifRiMc6bXnZhHkYtDNtbj
         44xm7Vm5GKznTNT0VyWjQfWdUfM5obJzvsaResiIKaPM9In9HKtw57g9pblTp1BgMY9G
         TkE3vS7iPytjC3mvmfItH1r54oXD+uFsPVHzHNibwxbdePqSlqILXT3TXxb69coQ+IvP
         Bmeg==
X-Forwarded-Encrypted: i=1; AJvYcCWcsqzXS6FmNPs67/lOnBkroK7U33WA1AsvZwZhMpk2dX+kOHPhupf/9u7WVMFqOHxgfv6LYBYpQMFb/w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy3D+Ev8mNAhvAZaoyL0Q4qLX/TjQnfamBxtRJgWesLVc3KB2C1
	vRE6euw9TQEpQpWwX2Hv3i6tLsYMJS+hE54C4qxHy04WN+nFsK8GuJLQtYGuud8Wuz7tb86ZiDk
	KIwyN4p+GrWGG0vhs0BVyXRgaWiJG2tQhc8zNomh1t4Do0lpUykLXu7LOCzc=
X-Google-Smtp-Source: AGHT+IFotciXfb2/EVLMWr2EFo9hzs2Nns60EL1F8NvVSxbaXh1nQaZZ6WdP4J/p9TwLul/qlKcoHIG9x8l4KEeaMNE3+39TEPH8
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156c:b0:3e5:2df0:4b7e with SMTP id
 e9e14a558f8ab-3e91fe19d9emr67355225ab.7.1755891964741; Fri, 22 Aug 2025
 12:46:04 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:46:04 -0700
In-Reply-To: <68a8bd20.050a0220.37038e.005a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a8c8fc.a00a0220.3557d1.0014.GAE@google.com>
Subject: Re: [syzbot] [erofs?] KASAN: global-out-of-bounds Read in z_erofs_decompress_queue
From: syzbot <syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, hsiangkao@linux.alibaba.com, 
	jefflexu@linux.alibaba.com, lihongbo22@huawei.com, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org, zbestahu@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

syzbot has bisected this issue to:

commit df0ce6cefa453d2236381645e529a27ef2f0a573
Author: Chao Yu <chao@kernel.org>
Date:   Mon Jul 21 02:13:52 2025 +0000

    erofs: support to readahead dirent blocks in erofs_readdir()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e047bc580000
start commit:   3957a5720157 Merge tag 'cgroup-for-6.17-rc2-fixes' of git:..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11e047bc580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16e047bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=5a398eb460ddaa6f242f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151b07bc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131b07bc580000

Reported-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Fixes: df0ce6cefa45 ("erofs: support to readahead dirent blocks in erofs_readdir()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

