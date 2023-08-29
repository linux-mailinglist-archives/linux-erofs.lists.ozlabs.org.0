Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9C678BD76
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Aug 2023 06:14:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RZYwX3Bkgz30Pn
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Aug 2023 14:14:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.215.197; helo=mail-pg1-f197.google.com; envelope-from=3ondtzakbagcxdepfqqjwfuuni.lttlqjzxjwhtsyjsy.htr@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RZYwQ2Y4Mz2yDM
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Aug 2023 14:14:28 +1000 (AEST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5660839189fso2552169a12.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 28 Aug 2023 21:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693282466; x=1693887266;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMmYsu4NKdKT2dfIhw2ed+qjd72AlV6/9p3jOZJCV0c=;
        b=XiPjm0WnwdeyRff47FltwoIep/tlH6PwWcuTB4fWu8N9Ucrr4j+rzPqalKxaN5ci5F
         vtg3LvN4HaGzTsaB1JknUcDSCEj9anDocUNzP5kuxhyI4eWPtcCUJ9mZikn1NL+NF1UL
         LW+1uH/viSoYIAqEBVjGD8V+xoE3xBc4E6t2bcKN/Nt+X4EcS4jxJv2tXGVhbmawprsq
         bcj6kcEZQDXXC7EQ/q5pW4/D6YEAge428XEY4x3pdOoF5uHzE0KxlQ6iPXzxNJGNPc8S
         OrpPWEyRRQp6lXh0v0ocsJyWLYPlk2OiMmwS61LaqdNFODF03abCKqnn/cWUoGiDTMbk
         TCTA==
X-Gm-Message-State: AOJu0Yw0+bxzsJPL3SCgLewUDBJ+r85Y5/fQsZzW6BeEKbzdpzeKON9d
	489IHgdVKqmdGN9xEAKDW0E3hDOZyPVWBZ9uSkjcqLzM+KwK
X-Google-Smtp-Source: AGHT+IFtO0IOJ9o8ktQhkQF9NokqITfV9+8HmmNkvrcz2kEEOjQ/Gcg24cNQXFJ7Qec9Eumn7CfWSXGerddI/rNUg+wYu/hKy8HP
MIME-Version: 1.0
X-Received: by 2002:a63:3546:0:b0:55a:b9bb:7ca with SMTP id
 c67-20020a633546000000b0055ab9bb07camr3831261pga.10.1693282466124; Mon, 28
 Aug 2023 21:14:26 -0700 (PDT)
Date: Mon, 28 Aug 2023 21:14:26 -0700
In-Reply-To: <e318cb75-510e-6cec-d35d-f29d920468f7@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5e02b0604080b49@google.com>
Subject: Re: [syzbot] [erofs?] WARNING in erofs_kill_sb
From: syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>
To: brauner@kernel.org, hch@lst.de, hsiangkao@linux.alibaba.com, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com

Tested on:

commit:         1c59d383 Merge tag 'linux-kselftest-nolibc-6.6-rc1' of..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14f819dfa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9678e210dd5e4a5f
dashboard link: https://syzkaller.appspot.com/bug?extid=69c477e882e44ce41ad9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
