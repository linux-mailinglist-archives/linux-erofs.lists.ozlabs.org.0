Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE6A4DE163
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 19:52:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KKtRN4Wklz30NV
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Mar 2022 05:52:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
 (client-ip=209.85.166.197; helo=mail-il1-f197.google.com;
 envelope-from=319q0ygkbagwcijukvvobkzzsn.qyyqvoecobmyxdoxd.myw@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com;
 receiver=<UNKNOWN>)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KKtRG6NJnz30BF
 for <linux-erofs@lists.ozlabs.org>; Sat, 19 Mar 2022 05:52:09 +1100 (AEDT)
Received: by mail-il1-f197.google.com with SMTP id
 t16-20020a056e02061000b002c7ddaa0006so4040460ils.7
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Mar 2022 11:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
 :from:to;
 bh=/4mPg3CJhiYczFxDFNRkAaBcypBHoPLTRaLTCzvtw/I=;
 b=37cacbxNSsSM2JFO2vu+VHCkhYDZj0ue040lfg3Fvprd0EFD0IdJcRKw/RCNI1JqBY
 YbnxDke7TjIpYjMSXz+3K2yNWeXvNOd+ruc6LyWVT6iK6devE6tf/bmt8BaU7jxl4U98
 ecttNjMlY45J+SPqDBSLcH/+0U8CzZ2bEQc6XTYc8zUyrCmUE8O1aFkLH0zUzyYlrqIL
 HEEgTT3+VSUEpU9w5oYo/lmmttjT2/Aq2/VQfRLnQc80pZnDcYZ15p4oF5ALnryBUQNp
 X7H1e3/QJVHra47fwT2qMm2VThA02FHbFmxZdRu9hF7MmMNqKeWxo/905Qdkq0o4A1/7
 /opg==
X-Gm-Message-State: AOAM5334W+mbV2UZnYC2Ux0STjtjkDWsIW/nMRwv8TN6mkfXHq3LgZJP
 7xJe3gyxoKbYiKzga//gnUjvRu58cR3UbLmEaSq+RWapdJJD
X-Google-Smtp-Source: ABdhPJzU9Nigo5iCFfFbdXki7fcEbns1SuethIp2/0qBuen2s1zpDHhbiRu8WCIp2/WUkX0sFNX0ri5+1Qx8xXz5axsuhcCuyK+7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1746:b0:2c7:f247:b378 with SMTP id
 y6-20020a056e02174600b002c7f247b378mr3302331ill.298.1647629527149; Fri, 18
 Mar 2022 11:52:07 -0700 (PDT)
Date: Fri, 18 Mar 2022 11:52:07 -0700
In-Reply-To: <YjTJRQb9eMXdsHOE@debian>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aff2c805da82a426@google.com>
Subject: Re: [syzbot] WARNING: kobject bug in erofs_unregister_sysfs
From: syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>
To: chao@kernel.org, linux-erofs@lists.ozlabs.org, 
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com

Tested on:

commit:         a1108dcd erofs: rename ctime to mtime
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
kernel config:  https://syzkaller.appspot.com/x/.config?x=442f8ac61e60a75e
dashboard link: https://syzkaller.appspot.com/bug?extid=f05ba4652c0471416eaf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
