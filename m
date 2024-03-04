Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C2286FA3E
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Mar 2024 07:51:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tp8VX0qv0z3cHC
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Mar 2024 17:51:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.71; helo=mail-io1-f71.google.com; envelope-from=3v2_lzqkbaaiu01mcnngtcrrkf.iqqingwugteqpvgpv.eqo@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tp8VP3FSzz3bnv
	for <linux-erofs@lists.ozlabs.org>; Mon,  4 Mar 2024 17:51:07 +1100 (AEDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c7c4065282so576582439f.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 03 Mar 2024 22:51:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709535063; x=1710139863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEojSSr1JJCCTe1f41k1uKfweP4Gib3cKMfjn2Bpapg=;
        b=DYEfyxYw+Av2Y25bF/PJZ5AtjBPqOB38zG/uz/xRraZTTeyMRUso5yBbD/DlTdzaQH
         9Rno5pQfOxyZdTv7Ql2XjjjIjFIxZ5SeEJTeS9BtYuoR4TWjA4J7Gw1QFSxk0TLPaFy+
         0axh3UjaG2PaJaJpiHNengH3m4y5ZykccdL61eR3YIymRWt5mpVnJASdXAXymhs0MCIR
         GXFoYt4tOgadBjcEo+7rcrn5qj/6RF14mMjkUYVnCUUyQaPeGSg6ohLzRC67o0hLqDvF
         goEnEIOSjPJzS3XuN3NTDJjO6k5mNLWzDKolrQWM8aY3pqH9dJAPho7leYJSXQdcGJ+R
         9rgw==
X-Forwarded-Encrypted: i=1; AJvYcCUrCDbFniqlyv8nijFMwfG8U/tAaFMK+B9u1pygKXX8qHV7glLPZa03znj+hHKX9GVApzIwsu5Yjyy+X1Tgy6eRcqNRf2vYJePiTDBQ
X-Gm-Message-State: AOJu0Yxji0u4kUgqMDZRvjli98xQXGeuOjsCbocnpdsAcoBo6b4cvJ8S
	kAsGnYHHzlx1UM5f3zft2kBRJKqeqa7JR8buRbLQuvPySIHkZngOkOqtN2w2D5Ihg7/jSRFPMwf
	njLULS4KeEBe0HQn2jA+OXvE9n7Sj1g/+tUm/F3E/rGSRWgoDLLbg6Ng=
X-Google-Smtp-Source: AGHT+IGmNUWUAUqGhO0qdcJQgLgYvG4EI9zj1Re8GV6F4C5VejF5vg4F5PoijEQqvolFbGzuu9fvyZsubMgsRSaj6BtsdKQSH+mp
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22c4:b0:474:bc7d:544b with SMTP id
 j4-20020a05663822c400b00474bc7d544bmr241175jat.6.1709535063114; Sun, 03 Mar
 2024 22:51:03 -0800 (PST)
Date: Sun, 03 Mar 2024 22:51:03 -0800
In-Reply-To: <dfd05ad0-1dae-4121-abba-59b55ad22c99@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b07fe0612d02607@google.com>
Subject: Re: [syzbot] [erofs] KMSAN: uninit-value in ima_add_template_entry
From: syzbot <syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	roberto.sassu@huaweicloud.com, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com

Tested on:

commit:         4288d8d1 erofs: fix uninitialized page cache reported ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=10893754180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db27810a659d0b3d
dashboard link: https://syzkaller.appspot.com/bug?extid=7bc44a489f0ef0670bd5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
