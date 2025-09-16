Return-Path: <linux-erofs+bounces-1035-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A418FB59235
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Sep 2025 11:30:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cQxSw1kngz30NF;
	Tue, 16 Sep 2025 19:30:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.197
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758015008;
	cv=none; b=BCIKg8TbpAl5JXywcdOjM+l3k3p0v1uyhaThN1byYiF0jbYE8/ho4rdJcF4eLIYIuoJn+lY4AX6PzYtTJw+s1bxDLi4+7VDn2PHarZgOsnP0L1t4EtDbEEeLp3p3IbZz8s8CsRMEowIQDj/ll3bejpvOJCEu/LaMis5u86fyGGPCvcdGPFS01MA88twmcMRekEgh8yuy5cuEZAsjF41gHhlg4Xx+k00nNjqELPcNDOv0zBOhofO++J0tqZmCCylxQK5YD7yMBJ2oClHFjrTfvW1KQddWeZQYJKOv30pwUrH/g+yyccdm/JTJGXbJkqCZbzze99yYAFCYz/QVGzJaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758015008; c=relaxed/relaxed;
	bh=S5z//DIkbOSKstGPfsK/oOb9sQP56ONMueHPNYK4aR4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XMiFw5qzZ88uCR1S/q/MT6Rjgq1G1ZuJ4uWQ7Mer5S3qIzAytWQwY8M7A8XRnl3VZ2CUQKJL/M0/FKf8JIjvNOZDszGB7BAF6N9EJ1SWF6Koq9vs4PkqRwiQlV+iibdoFa+lfU+KWxdy5HD/DKAwF/sxLk0Y6CNipxRZeYVkvSPpEvvdFLEK4+azyzc1bhIUkEpM1elj1qYXS+sfhrDdVcsnjjwuh1D7EsU95Dcbfo2/sg3ISXUKtCxoV/K9vWoPAFkQ1gf85GOzBlDpGMj19o2ClmKX7Tx//QQYIv/5ivdbl5KSyz3fFS9ng0sDiiMSYDAA26t2lavgEo41yinmKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.197; helo=mail-il1-f197.google.com; envelope-from=3hc7jaakbaokdjkvlwwpclaato.rzzrwpfdpcnzyepye.nzx@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.197; helo=mail-il1-f197.google.com; envelope-from=3hc7jaakbaokdjkvlwwpclaato.rzzrwpfdpcnzyepye.nzx@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cQxSv1XrBz304h
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Sep 2025 19:30:06 +1000 (AEST)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-423feb240a7so63098405ab.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 16 Sep 2025 02:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015004; x=1758619804;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5z//DIkbOSKstGPfsK/oOb9sQP56ONMueHPNYK4aR4=;
        b=epF4O/BIEv21Z5eUZuKRTknx/hQ1UTqjoQcOJ3JwU4lbHyQNQKSR4B2g6izOfeajmq
         WtTww3VQyIOrP80sQkynmsKVKzG+Z08BVaC6DxbYgv7GATDzqEQPl+Yln+q9W1AEH1wl
         YfgnGhmS9mSd3FlRKIII8Zhiu/jbr/mZNSSQKfbJYol4p4udgoazHwIfyKMEeGpnebrj
         JiTtqKQp3xw9nlPGOjTIXAneR3dMO6kk1fpbXwEMZ+17VLKnF8ZqaO/8C04QAPQq160e
         wduOY0u/Xqb/hwfgK/whVXeLg/FFQP70u2QRGH7g43V+wWDpEdD6RyvE4FpCTMiQnYQL
         dnjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQLBHQb6Ge/1lVOI5/yOx9sFHZyYjMed0/1mtZLl4qiHO8WJWsQ8/yQtoucAtXsPsJviKw8Y0l0jAe6A==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzfKc+bu+aVwza+bMwxCuvreDC5J9u8B6aIAgqkXJd+GyGvZpRC
	JajzOJ4sBi9HJQlppKbS7VDdlfugeNMw0LCCoNEsLPVoqxgsF0xRZ7sr0YiIECKQoFDx9XDGQ/4
	dkjPNT4IOzg7y8lTmnP9WlT1BLgL/MFWo3pePQnVOo9JDKNJtWgnow6lHoVo=
X-Google-Smtp-Source: AGHT+IG1tIG0BnbUPWVspbgw7zSN1aerhiz3aPyorawhOOGyO7qNXtdqfQCbdSbL73k2yPyo9lJqrESPiz1Xts2QcKczgvlGAoQn
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
X-Received: by 2002:a05:6e02:1886:b0:424:a30:d64b with SMTP id
 e9e14a558f8ab-4240a30dd29mr38740815ab.19.1758015004340; Tue, 16 Sep 2025
 02:30:04 -0700 (PDT)
Date: Tue, 16 Sep 2025 02:30:04 -0700
In-Reply-To: <e0650e39-f555-4fe3-8c80-cddc6414a449@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c92e1c.050a0220.2ff435.03c0.GAE@google.com>
Subject: Re: [syzbot] [erofs?] INFO: task hung in erofs_bread
From: syzbot <syzbot+1a9af3ef3c84c5e14dcc@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.0 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,RCVD_IN_PSBL,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Report: 
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.3 FROM_LOCAL_HEX From: localpart has long hexadecimal sequence
	*  0.0 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level mail
	*      domains are different
	*  0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
	*      [209.85.166.197 listed in wl.mailspike.net]
	*  2.7 RCVD_IN_PSBL RBL: Received via a relay in PSBL
	*      [209.85.166.197 listed in psbl.surriel.com]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1a9af3ef3c84c5e14dcc@syzkaller.appspotmail.com
Tested-by: syzbot+1a9af3ef3c84c5e14dcc@syzkaller.appspotmail.com

Tested on:

commit:         e8795f31 erofs: avoid reading more for fragment maps
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=11137762580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4239c29711f936f
dashboard link: https://syzkaller.appspot.com/bug?extid=1a9af3ef3c84c5e14dcc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

