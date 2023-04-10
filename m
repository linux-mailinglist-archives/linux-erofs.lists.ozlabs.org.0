Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA286DC54D
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Apr 2023 11:43:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pw3v96Hd5z3cdn
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Apr 2023 19:43:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.198; helo=mail-il1-f198.google.com; envelope-from=3ptozzakbaokdjkvlwwpclaato.rzzrwpfdpcnzyepye.nzx@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=<UNKNOWN>)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pw3v606dHz3cKW
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Apr 2023 19:43:28 +1000 (AEST)
Received: by mail-il1-f198.google.com with SMTP id z19-20020a056e02089300b00326098d01d9so27291444ils.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 10 Apr 2023 02:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681119806; x=1683711806;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJKZF44pl91wg5axLuITmc4eT5aKQGmjCOeCJWpfmqE=;
        b=KcqM3Tx3fCzP+fhZYvAOTaG+knLWmErvGm5xg7ocjuLsSqRsqLYMyXrhYfItQxI8jC
         5UpVf+auNY+bDK8o9U1Iz4ZkXclIU2Y0S1MHRyEXnjl08J/2zRS5cC4+DboP6/ir4qbK
         lN1DkO0Ea6XW+DY8Xa9teFigrQIs/BqeMHbMPzkaJzHapR5+oKK2laeuV/t4BemDY/nc
         Em2a5CgqoHkspZRv2bNfa6PtQWG8A3IF8AIXC1v8Qszunj2fAvZaxa9bVGg7pVJTzB2j
         BdVMya7roocaURPJ+sNnuGL4dUJans1fbQ6k6oUR62apWSh2USn3otduq3heikRcJTAt
         TOxQ==
X-Gm-Message-State: AAQBX9cbgXV95QTl45EvfT128zZpQRUIglVTbLO0MGkFkG6KCHbc12OH
	I4PX5pL5Yjn3MRq7AQdOVP69Yf8FdfqqvtgL3lrbOKbHjGvl
X-Google-Smtp-Source: AKy350bDOn1JZxKnq3INKUBPDnuN8dYHrrcXp5jswLb971AVEcfcZpuR7GZ4eQgHEEiPCrKAEPONVF4a+4Gy0+dZMoj2RLDWHnT9
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ee5:b0:310:a298:1c95 with SMTP id
 j5-20020a056e020ee500b00310a2981c95mr5458286ilk.6.1681119806130; Mon, 10 Apr
 2023 02:43:26 -0700 (PDT)
Date: Mon, 10 Apr 2023 02:43:26 -0700
In-Reply-To: <723ddab6-9298-6021-27a9-872aa389ef16@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de8f6a05f8f834e5@google.com>
Subject: Re: [syzbot] [erofs?] BUG: spinlock bad magic in erofs_pcpubuf_growsize
From: syzbot <syzbot+d6a0e4b80bd39f54c2f6@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiang@kernel.org
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

Reported-and-tested-by: syzbot+d6a0e4b80bd39f54c2f6@syzkaller.appspotmail.com

Tested on:

commit:         09a9639e Linux 6.3-rc6
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.3-rc6
console output: https://syzkaller.appspot.com/x/log.txt?x=12cc39abc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c47e989e3f0f1947
dashboard link: https://syzkaller.appspot.com/bug?extid=d6a0e4b80bd39f54c2f6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
