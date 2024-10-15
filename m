Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4403299E374
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 12:09:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XSVF20tcqz3bpm
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 21:09:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.198
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728986948;
	cv=none; b=cgqWIOZiMPZo0nnYdH7SM+YlB+18eo42jsdhWr6oLOvHwaLIMnz0RuYPSPiaYvJADhh00B8ftN7oTsU2P2HXoI2P9r0Nd1jC148XkUkwjB6Q67DJ65IEk5Wne4aUd7aL/OYWn/8rjuw6JiOUNeYtXKEVhvhOQNUDIqGUjRn4Vz6XP8I0hMtktlQf4RSWn3Icd1N1i98Bzi9WorxdfGVT7RtNwizr16k05Dtq6QmZ8EFmt2YAYOWS9cPHdPqqqJrHUOiPoopEYSRZFRULGZr0IMfiKcWYgbw9vb7knOVvPZbxgQM6NQxZ+mMAM2c2Wh+kBSQ7VxTpOLL9CDoQuYMJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728986948; c=relaxed/relaxed;
	bh=sJ1XgZLD06jZgmdfCG0BxwXZqAtgXOjAbyLjBcsgS6M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=REOjWnOAGzITsJt4kmACzjUWldr+2IZ2jja0qnOvNzNL0Jmfu9ep1yT8f8AEwTrTMujSMtLJBYvkXwoLb14a8TujdzMvk+KykZLKLky/SxjN9dSxmye30YyP31T/U3C+MfFwODr5hvHM59g6HPn81zhfRYkbBrSy2k0sZWkR1+rriVDR+gjUxJbBnFA6JuShogbqpvNHML6vo0PvtQZPmgK15woGFCObF30ccpcTuN3wg/Vy8ie+rmRUYZ7ixR552IKow5B7fRWUV1g8H4sll18EltLOQYMPY1P+I/Q9sDs4fOyRyjFdeWysX5/ut7SEdsJanTc8J7rCGJA5g8JESQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.198; helo=mail-il1-f198.google.com; envelope-from=3pz8ozwkbadykqrcsddwjshhav.yggydwmkwjugflwfl.uge@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.198; helo=mail-il1-f198.google.com; envelope-from=3pz8ozwkbadykqrcsddwjshhav.yggydwmkwjugflwfl.uge@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XSVDy6Nd4z3blN
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 21:09:05 +1100 (AEDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b457f6aeso28908855ab.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 03:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728986943; x=1729591743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ1XgZLD06jZgmdfCG0BxwXZqAtgXOjAbyLjBcsgS6M=;
        b=lCZpB9X4m0SgRrnl480iTGQnBSDHThJLxyCkutoSmzhOftNqnukwHfsDHy85/NQJZ8
         oTS5bjkBdvqKQqbaKrkKyN9iPohia06P81sXtD0tqXV4ArXcQosm/ZeFui98H8iMJU9N
         kLKGRv+Hl6XRDleqveDgHmEDVBmkT86l8aaPyM4oGLsAyntZNfqytDoMFXbgFZ8EpXYi
         tfV5qsDXxFxytc6CLCNbZNUMUBsy6N4vlDkH/86ls944xoPQiFAdyZBAenWPQhFVLxht
         LPtlaU6qeLcTmR0udT2AKhZELx7jNNFVb/Gnt7EKVutYGi8Uey80W8hSIIdpUGb4Ff8m
         n1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUyrJGHtorhXK+EN/XNKXe1HY1FdCKuoZuh6GsjQlpEWDWAb1v2x3oQOtJey2tFoyamPFAWWLSm0QWF4g==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz9wfnSL/6k+NGKDPL1jgggh29UufNcg/pjagijAO+nEIGILTdj
	B42kWEpZ/bMRcUzVPDGwMn01k4k44KA1dUR52OdSr5aiv8wurVAg5SHE1Fi2ON2exrWp7t39V5x
	SBNhsTzlkysw0+hibUvEwUTbCTjEBCeGQtZnvz8kLffgGJPieNUJQ/Ls=
X-Google-Smtp-Source: AGHT+IF1ACL8+aT3InlSzj0jgkv7uhzXC6SoU1xoFZig0zYBBt1vpWJKJJP0NyURctI+RjUawz8qZZtyWUOP4xk2iAc+NLmKXANC
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3dc2:b0:39d:3c87:1435 with SMTP id
 e9e14a558f8ab-3a3a709de06mr122817055ab.1.1728986943585; Tue, 15 Oct 2024
 03:09:03 -0700 (PDT)
Date: Tue, 15 Oct 2024 03:09:03 -0700
In-Reply-To: <120ff6bf-3607-4f6b-9ec4-f1af9bdbdbd0@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e3f3f.050a0220.f16b.000b.GAE@google.com>
Subject: Re: [syzbot] [iomap?] WARNING in iomap_iter (3)
From: syzbot <syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

Reported-by: syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com
Tested-by: syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com

Tested on:

commit:         ae54567e erofs: get rid of kaddr in `struct z_erofs_ma..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git erofs-for-6.12-rc4-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=17bac030580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
dashboard link: https://syzkaller.appspot.com/bug?extid=74cc7d98ae5484c2744d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
