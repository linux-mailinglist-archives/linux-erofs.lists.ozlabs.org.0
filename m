Return-Path: <linux-erofs+bounces-905-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 69885B33D53
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Aug 2025 12:57:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9SRR2xv3z3cgd;
	Mon, 25 Aug 2025 20:57:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.199
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756119427;
	cv=none; b=RFm6xmYZcknCqjA2ylj5ffotAy9kdOKq8lR34hcAXD0Fuc/uFqVaXI3yXwE13pEOvw5ukU8hF9u0WXxD6w9EsfkS/DQOiW2PDnCH9Cbbv9wCo9chJb+yAbGJ/mw3jzynMKK8FuF4Gkvgv99t1QVDGVClP3BgubIkJ10cFgOl5jWE/VTiyL47n3i0sHZgQkJFAuP05Hsp/sRo2sbEpfMXameOtjVRs+w8jxftP8K3ZZQ1kGN6zx8vbYiXYyPIsnuP9pCTQiFTJJ6b9w/7NXKF4tDA70tCXjVZaK6WoqWLl8Np8IoMzcXvWM97QZeNUrHjiZeafq23C2eCHBbczRwFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756119427; c=relaxed/relaxed;
	bh=qnAEdxUVLyR7bjk0zgkr5LAOrPsrp1slbvoQ3cASm0A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C/9rquEUFR0taKuF97EfH8H/Lqhy4vo68n4vhY37idog0lR1++g++DSPy/h5Rzn4e++8/tHkyBWljqtIlUE951N80Xn6daK56JmfBSy069oUVSikFc6Ap8jZSqobpxGHN8zRsHGcvUTKeYL+30oAEbGzebJ6CzYFlGU1kMbqmTzGJnwBDNpK4URgiZdG7hjhbi8ey5DNqABcXcQWtrB17KEOpbu4R9dd9MeZI4fr9FZvS664Nc4FC65M9uZNpE3AE2jODxP1f/iqdi13hElkD/xTriEvYCSXCFYzmvc4K3JOMhdQLDr1Kddo5VIXm4YzAPFvc/Z0XVmZZU0tg3aq3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.199; helo=mail-il1-f199.google.com; envelope-from=3f0gsaakbap4y45qgrrkxgvvoj.muumrk0ykxiutzktz.ius@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.199; helo=mail-il1-f199.google.com; envelope-from=3f0gsaakbap4y45qgrrkxgvvoj.muumrk0ykxiutzktz.ius@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9SRQ1kY8z3cbW
	for <linux-erofs@lists.ozlabs.org>; Mon, 25 Aug 2025 20:57:05 +1000 (AEST)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ec4acb4b61so8564425ab.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 25 Aug 2025 03:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756119423; x=1756724223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnAEdxUVLyR7bjk0zgkr5LAOrPsrp1slbvoQ3cASm0A=;
        b=KUQjLl+99y/n4tZh2j9Lm+5tDYk4dCxqIWHE/PVPqEECprKNxw/JDmdkDbro8xcZWg
         AtWj0ZJUETHqo89WPS8liQS728BeqgeJf8DOb2AYMVzMmPLaZfLMY6i4p2UxFqcoDM5N
         6Q1YChtqyWOQteAe80zhSjaNJs9hPqAcpXjIgc4LPogBESu7dPyamJA79LmdtGPqLKsu
         PZ49SgAGWMACnHMNAADIxhQ9vN5jAhYkGuxhfRl1m6oHpKVSJIz0Hj6Y4xIvlrAGkpDg
         RJJz/VlIDc0KYU359qSTfcxY7rkAaRYB6BJ1W0KTxQZ4lwOQvQv7nXh+OckX5RdFWHIY
         wT3g==
X-Forwarded-Encrypted: i=1; AJvYcCXZzmSzH9sY07VlDEFwZZgTWsbfZ01LMUK3CCJfX2MpvvfyekS2hR6DVusNBKD+R6moiBcx4cAdKLuPlQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzzikdPuXyi5tGlCl7pAqblCRxZHyL+/xVQ2s5TaXhiATh3d3vM
	8Si0JqDs6FbHL0flISUZCeI61MgEBQf5Z22ESmCCoxOmewVQThThn5CqpS4VHxH9UaT2t8z688/
	Hbj6tdKoyxVEq3mkIO+aGBjBMps45VfEQGAvMyJgD8u0wgI/So7VjzO6YbJI=
X-Google-Smtp-Source: AGHT+IEQWqLurzZuZnFZmN71S+pzCidDLgfEOupJpOfz+FdDU4Bj+KWNpbn38fN+c9gGxXYqrL0GqZ3FLKgYicvQFxvQt4nABMmO
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
X-Received: by 2002:a05:6e02:3cc6:b0:3e5:7e02:a06d with SMTP id
 e9e14a558f8ab-3e91f93e0dbmr154146905ab.4.1756119423016; Mon, 25 Aug 2025
 03:57:03 -0700 (PDT)
Date: Mon, 25 Aug 2025 03:57:03 -0700
In-Reply-To: <1ebebfcf-99f7-420d-be00-606204aeee29@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac417f.050a0220.37038e.008c.GAE@google.com>
Subject: Re: [syzbot] [erofs?] KASAN: global-out-of-bounds Read in z_erofs_decompress_queue
From: syzbot <syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.3 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Tested-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com

Tested on:

commit:         27ad5346 erofs: fix invalid algorithm for encoded exte..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=1506ec42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=5a398eb460ddaa6f242f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

