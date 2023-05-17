Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A52A7070F1
	for <lists+linux-erofs@lfdr.de>; Wed, 17 May 2023 20:39:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QM2240pmpz3f8l
	for <lists+linux-erofs@lfdr.de>; Thu, 18 May 2023 04:39:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.197; helo=mail-il1-f197.google.com; envelope-from=3ih9lzakbab8ntuf5gg9m5kkd8.bjjbg9pn9m7jio9io.7jh@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=<UNKNOWN>)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QM21K4P4Tz3fCY
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 May 2023 04:38:28 +1000 (AEST)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3382e29ab5bso7118705ab.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 17 May 2023 11:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684348706; x=1686940706;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Vamjh5zaT+/xLZPoxv52up73xCnN6/tfSU9g/y8Wto=;
        b=TgX6W+iEIinmlrxa1s39L4bSgU6wzxkni0LxTGhIQkHqsqmMRK+tP2amwzod+TqJJa
         Orz98NPh0DW1OXOkY3wa7YnlNGSzfzFrT+83v7l4ND9FDT5b8sLpOFjsGmWXka0WPXxh
         z7jHbxAsGRtq5Dghyw57B9VHU1y1g/Jh4a6YRF5kB5ST8e/H5yPk3FRMfltJbmtWQuZY
         UID/bxG7hsIa+7ppmlP/fxWSz/ijTnp0VfBRhuT5TzaEudjMhi2Cx9ym6DgaGpMY3kaY
         NmKzLkGxywJusQ5Xk3P4dMRgjQCmxpggjEovLe8lE29Xj/uNe2j5k7jXoTMIrAlA3VjG
         SSJg==
X-Gm-Message-State: AC+VfDw1Rs9/53BaRWSBOBr69yjhsX3ldO+eui/6ymW8qPzJs3qEIWaR
	oj25eaLWV8T8+7Cw/x9aH1gajhwTovu9DvSgwR9fR43LlhdH
X-Google-Smtp-Source: ACHHUZ6+DaqJKQq5UGHV13ZmtB1Lik9tk/rPaeURCGSY41bL/WLiaZFVIqeSPs8lpve1mrKhkaVJF6OOQSxfZVx2zQoYNtzKfQVI
MIME-Version: 1.0
X-Received: by 2002:a92:d152:0:b0:331:9a82:33f8 with SMTP id
 t18-20020a92d152000000b003319a8233f8mr1830905ilg.3.1684348706156; Wed, 17 May
 2023 11:38:26 -0700 (PDT)
Date: Wed, 17 May 2023 11:38:26 -0700
In-Reply-To: <85c61aae-6716-9936-1533-91624f70eefe@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ef96f05fbe7fe6f@google.com>
Subject: Re: [syzbot] [erofs?] general protection fault in erofs_bread (2)
From: syzbot <syzbot+bbb353775d51424087f2@syzkaller.appspotmail.com>
To: chao@kernel.org, hsiangkao@linux.alibaba.com, huyue2@coolpad.com, 
	jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bbb353775d51424087f2@syzkaller.appspotmail.com

Tested on:

commit:         ae0bac79 erofs: avoid pcpubuf.c inclusion if CONFIG_ER..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=16793226280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6beb6ffe4f59ef2a
dashboard link: https://syzkaller.appspot.com/bug?extid=bbb353775d51424087f2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
