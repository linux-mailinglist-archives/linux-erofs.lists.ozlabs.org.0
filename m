Return-Path: <linux-erofs+bounces-406-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B709AD9BE6
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jun 2025 11:46:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bKBGp2HmTz2xd3;
	Sat, 14 Jun 2025 19:46:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.198
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749894370;
	cv=none; b=WstrLx/7B4QgW0lCuh4DtIF1l6VLE8R4WWqZqlKuL5GTBxnXB3OVVqA639eAgR+GBlrvDTXYziVwLditOl5w9yMrR1WmB1vRQDSpeprLW/ZJNWfrgpdcfFYr2LLQvJISor922/zGDJKQvY5zy2pl43kKPh28P5ZsZeZ5Q9XOEOc/IPcRtyqeHZMbn3Lmq/XBR4gRGmc7xJrWE3/zfpUZbffnrhlQ6t+Bt+wk5zU+Ps5Ammdu1e9Gqjn4YjrKCihidm8HBLyE0b4lpfUvkdFZwTDZPMbqG/uS+PpnVdvVpgqDVT/Q/WcdwT7ebgayoFw1qtvqUmipcyCegT7BH8lztg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749894370; c=relaxed/relaxed;
	bh=OOullEj6fbTIFAODytKrgDERNVpRSjN594Q2Nd4pVdg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WBZsVjr5oXFWMd3pJHBDd6YGVVeaE2vaPnpIVFQSOjha6sxI9pmh1HzHj9C5cmA2eoxJtmalZzsphyMEhgdz964db+wKkHmp2VnYXIlxfnnlR+VFCp4udkkipaNVL9VxPqxIuiOk+/MsgPgSkF+DOe8td2sIU3JPffMCyms3YAejqcGO7HBNzP/njeAsMOF5m1LletU2BgaIL44pCjkV+7TvKy7YMnIYsOTnrHiJ4/2viyrDq6Qt/cqse7ZCxrJVjHRxFt9R3AcYcvtQIR06CLw3cINEUx5JHO0+1k3nVPEgtC4fnUzxKCexB79DI8Vp6h9RiblXiguBi9mLev5Ipg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.198; helo=mail-il1-f198.google.com; envelope-from=32krnaakbaoevbcndoohudsslg.jrrjohxvhufrqwhqw.frp@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.198; helo=mail-il1-f198.google.com; envelope-from=32krnaakbaoevbcndoohudsslg.jrrjohxvhufrqwhqw.frp@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bKBGj710Wz2xHZ
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Jun 2025 19:46:05 +1000 (AEST)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddc5137992so32895195ab.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 14 Jun 2025 02:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749894362; x=1750499162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOullEj6fbTIFAODytKrgDERNVpRSjN594Q2Nd4pVdg=;
        b=wgtSItWSJx6/m4rNxR9sWhMQdt7YSxxK2C23cTF6ePshTZXVJsvrhx67KCGPP2n/GO
         nJjCL+j9dk0oV45Uv0+AnJiaC6WPFGxPSAhUcivmK6HQcamvihhTNDFiT/HgfUOTAo1K
         FUxkdLLqtxJBkZ9USRzT0jukkyaOF8Sn5fhtq6EZJICFED0bGuaWkVXj0B+UIPjl5Y7z
         02BborOeJb8c+mIEJ3IG7P+oD60V93ll7UaurfJ9kfS/VX5T9JX+cWuuFZI7FuIEd+rw
         MjAD7CQPDYn5sfiMEgTCMMvRlyW7hRY2f/NVAB6SROkrlxg3MbPsrY1mv3NixpgFONE3
         +56w==
X-Forwarded-Encrypted: i=1; AJvYcCWRZ0JoUPdb0TbGYozuM873q74zHmIr68Cr2DqCmkKCodRWGwg7xlSpnyHIcaCauovVJrZ8mqH/ZdQMUQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzFtXbOIxgCT1We5o0pgielmtm77JJ9ZgwxZONGPA7PkdiZRyVT
	N5EvLLzBUtWVDEk48PseDmYbBPCpIlWS4R2ptHheGKeh5oUsvEkenhJio9Ch/1keppNWnvMvFkL
	8KqGXnTHrh5Kc40ku6XPA/wmrqiMikATYCrEDvL6boKahGMKHvKZTfmmU7MU=
X-Google-Smtp-Source: AGHT+IEVUfA3mPXS3hA0DJoSSRV+Ghh9W3bYlbB4sUQ+RiorkpWaQkzcHee8EanONeMMSXpA5+N9R0E0c+PhDvzwN0h/7WUL0Klg
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
X-Received: by 2002:a05:6e02:170b:b0:3dd:bfbc:2e84 with SMTP id
 e9e14a558f8ab-3de07cd17c6mr26890655ab.19.1749894362680; Sat, 14 Jun 2025
 02:46:02 -0700 (PDT)
Date: Sat, 14 Jun 2025 02:46:02 -0700
In-Reply-To: <684cb499.a00a0220.c6bd7.0010.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684d44da.050a0220.be214.02b2.GAE@google.com>
Subject: Re: [syzbot] [iomap?] [erofs?] WARNING in iomap_iter (5)
From: syzbot <syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, djwong@kernel.org, eadavis@qq.com, 
	hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

syzbot has bisected this issue to:

commit 1d191b4ca51d73699cb127386b95ac152af2b930
Author: Gao Xiang <hsiangkao@linux.alibaba.com>
Date:   Mon Mar 10 09:54:58 2025 +0000

    erofs: implement encoded extent metadata

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1352dd70580000
start commit:   02adc1490e6d Merge tag 'spi-fix-v6.16-rc1' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10d2dd70580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1752dd70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=162faeb2d1eaefb4
dashboard link: https://syzkaller.appspot.com/bug?extid=d8f000c609f05f52d9b5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115f9e0c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1688b10c580000

Reported-by: syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com
Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

