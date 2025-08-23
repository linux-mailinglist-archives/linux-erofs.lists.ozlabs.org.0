Return-Path: <linux-erofs+bounces-892-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 29819B3281E
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Aug 2025 12:07:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c8CQg3PD0z3dDg;
	Sat, 23 Aug 2025 20:07:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.200
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755943627;
	cv=none; b=kyLKo14YgUKW+bKC2DvQMhlT4k15njygoinrtaThvodlpQOPFij8cAuUlFGObaw56JnNqV6QvWHp7+6nOlGb27S+hKxN3j8g5j1NOO+O2iPLl1BuGV7VbTnt+CX7utgR1Dj0L12GvH1UA0Bt37dBxpbUcnJ4dBheL4STsX4+beSMbjo/0ezE/U7po800qATPxdmbcQ2xvsgK52IyLKthZfcmxzrLnhQ6wBTBvZ9RkHkYj3iBFJkLRIcJWOchYWm9XmLy7FpDE7JINnlIUqPuWF3B6/iNXZKEC78X6Nd4z9nzVPpl7Y3xRnEGmzWQBEQbR6cNlVmli6HDh093RMdS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755943627; c=relaxed/relaxed;
	bh=g57y+BXiM5Nz6Zfhj6gnwRUDluuGh19e+iCzrzZgOfQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WvRJ272kIg0Hm3aMUxro24DOGoWlgaCh1GRGfiAKqEH+dVXdxnH1yeJHIaCc9TM5dLZ1dGCvmBiw5uEmVIik6lRReOpDWMcxtUymAI8bjeJB4q1kfZb9rqB7tSPwwGq6pYa+rGjwfFpmbxefhdHK+wk0YEa8CZrs9mxuK1oOKT0J6t5oKIe++ewc6LRVfJCrmA1tF4C3Z7YNuc5ESvCk5L5M3p+5aaK1PQXTwmkot9WLNxYaa9BWzLRQBmPp4OWAdgTf4k4rZvMVkqT1RFyM6t7SjjfCC0YeRuzsrVa3LYr9CwyA4IU34ZF/qDJdZ+MvaJXREHs4eb2F2GNeEDFB/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.200; helo=mail-il1-f200.google.com; envelope-from=3x5kpaakban4syzkallerappid.googleusercontent.com@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.200; helo=mail-il1-f200.google.com; envelope-from=3x5kpaakban4syzkallerappid.googleusercontent.com@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c8CQf2Kfcz3dDP
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Aug 2025 20:07:05 +1000 (AEST)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e67df0ed87so89858215ab.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 23 Aug 2025 03:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755943623; x=1756548423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g57y+BXiM5Nz6Zfhj6gnwRUDluuGh19e+iCzrzZgOfQ=;
        b=rKZzGEsWXRQdTuMCSjdzNMJNZf6TTr5INlN8PQ6J58I86xAcqLiICqfotEb9zc6CrG
         yKbC565YzbAXze8jDvlai/tmVTM/G1vdAZqrdrUO8JeH/30aK2Y7Kmjdes2ffrweBQu6
         XvBcv7KxmK+/05jwMfqYm16IGHzXJnaj1j1t/smQyBfsFLqa8NpNUUS/cUXC8sJFOgv5
         X6WjMq29cXVG1g/k55J5UAvR9J4qy0VYwFfQR0Lp/B/emI0YFaIN/wGqYSmGmu21/ed5
         a8l0wcoOTiAvxWc03U+F4YxkcZWsr45VIytxsIgptPbwPRomVy+0atCTTQZ4rg54JZKi
         nlsw==
X-Forwarded-Encrypted: i=1; AJvYcCUIXwUI7TsTpsqrUljg/p1IAxkLpk1lVapHH5RRSct5qVbI61WpBB2J7D8Ge7Asybxw9mZQ3H/40Ea5qA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwqY5f+l8BMY545SBa3x+d7vXMs7g5pXC0vQPrZYSj3aobCURv2
	/tDdfdyV9OUMnC+dOUV6YoyM99J4BXpr7iESaSRkRKx4XumWsKyRAdwdT1EJhAnobEOfvQNNZjK
	+cpRETXc+vheR390h81BFu9KdQ+JeRGDMTgNU41LTQHHUDMt9yOcbTsysMlE=
X-Google-Smtp-Source: AGHT+IE3skUWEnMKyLZOO8urIqS/9CCXnPLytkg0m6C2twwwl7YxixAzYLgadoNjAO2+nd5UfDj30t+SPhBYCNGRCCWR/vtS0+gx
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
X-Received: by 2002:a05:6e02:170f:b0:3e8:906b:1ece with SMTP id
 e9e14a558f8ab-3e91fb2de2bmr101909455ab.3.1755943623245; Sat, 23 Aug 2025
 03:07:03 -0700 (PDT)
Date: Sat, 23 Aug 2025 03:07:03 -0700
In-Reply-To: <2387bd7a-0abc-4c3a-a547-cdaf101cd555@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a992c7.a00a0220.3557d1.001a.GAE@google.com>
Subject: Re: [syzbot] [erofs?] KASAN: global-out-of-bounds Read in z_erofs_decompress_queue
From: syzbot <syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.0 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,RCVD_IN_PSBL,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	*  0.3 FROM_LOCAL_HEX From: localpart has long hexadecimal sequence
	*  0.0 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level mail
	*      domains are different
	*  0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
	*      [209.85.166.200 listed in wl.mailspike.net]
	*  2.7 RCVD_IN_PSBL RBL: Received via a relay in PSBL
	*      [209.85.166.200 listed in psbl.surriel.com]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Tested-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com

Tested on:

commit:         e64b452f erofs: fix invalid algorithm for encoded exte..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=13f26a34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=5a398eb460ddaa6f242f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

