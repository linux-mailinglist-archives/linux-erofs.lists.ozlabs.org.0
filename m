Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4191D96CCBF
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 04:42:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WzkCj6lK3z2ysh
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 12:42:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.71
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725504128;
	cv=none; b=EUg7sqLAsWFnEUfGpPOxovTLEIBWwG1AmayWiR/X/J03Qw7P6fiSQ8uIuNQOU1Lr9IZ2lqgdVFcMQzAWmWOOpT0FC/ELy1bRVNdJWD8tUcpx89r94EcJn5cZ6EjBZtuYbvBgO6dKAcXZFUORCiayZq4ozY/584NGajEiyzpVqQGp6ZuZWGyV0wD+r5rkxDM6DDp8ypmY+r9i2UNDjihzGqL15dGOZoP0irRDvyeOQazSpaARmblKAQ8wD+r/wBVuRfB8q1Y/HX3DiOxOZmNRm1bP4TI14u6k6TLMkLtDYDOg8tsNrp5tlgpTH4YmL920WzSdE/7s4HsuTgzu9jWTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725504128; c=relaxed/relaxed;
	bh=9h81xMbplpUiXJ1CtVTecnSoMvutk9dvgJyTXkQb2G8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e8gIEU5a+hp5yEKFIwgjpGAZs7E4Ed4G9T/0PsW4dpwF0nTw/ihhUFLH2Gi1UZY6ZIln7AJajF9knF9FJw7vNUPL2utxDtktHQbuSbEwvFfuFvHziq9dtHg5asuMIA5ozAxAH5QFUelcKtq7zu9vS258cTBX97IPlXKpHdRKpYjUpLwZpN2JdkLnmeQINAF+BYzDK5/ri6293lJbG1y2CSsVlOYPuMQgXHgw9OFJXzH9BPY3nr3Wf0svwMP9y1Gv2qq4UCyzrEBPZIxNRyUbKnIM56f73ryd0gw0DzG1o50//gd++bA7pkb0HdFiR0eoK3ZjXuPX+VqFEuZEBZoYPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.71; helo=mail-io1-f71.google.com; envelope-from=3ehrzzgkbafebhi3t44xat881w.z77z4xdbxav76cx6c.v75@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.71; helo=mail-io1-f71.google.com; envelope-from=3ehrzzgkbafebhi3t44xat881w.z77z4xdbxav76cx6c.v75@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WzkCg3JZgz2xYk
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 12:42:05 +1000 (AEST)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a124bc41aso36075639f.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 04 Sep 2024 19:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725504122; x=1726108922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9h81xMbplpUiXJ1CtVTecnSoMvutk9dvgJyTXkQb2G8=;
        b=KFwVxJ9kXeHwStM3pii3k80sjqg7SufRuYIwf3EEcyPm1mWGynauaHpLhLA2R7LpZZ
         jChuQSB+2uTcGsXWu2g6GTl/6EtfU+YRuXsVxIYp+ki+C/dsT2njYLwsKywsW1T2gfnl
         +0X2UOkMAVC/9bH5SHde/r/2DkKIVmQx/cK84dNUMgYy0xOgaIE5yDeIDStkT7Es+pVz
         VyPI3Ok7ENw1r804vfmaxhSaCpihk5zJafXmYvaBdANyDO4jyxdcW0TXfQPvvw3oRKjK
         K/qtSTdWa3MBU8sv1FIEoXBq71CGm2i/ln4OS35Kj9m99EKPTkgI2cJ3JrOt+iL9/6cx
         +Kag==
X-Forwarded-Encrypted: i=1; AJvYcCXgL3hzMMwNtQP6TU5F8Q2LdUMxVnNPJO+m98/sWsAOp57ux/FxxvdGJPnG20IA1XyJTIHldCvJYwvLyg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzOvILagH7TaU4WAEgwz+Z+3patEyoof68rLanV0adlfQiUdPHN
	vlB7ZiGhXZaWypPlZvIXs/OtomxnNsjgw3t09pmzG57wuphY1uNZkSkxdKk1zFgzVC4DhNM9CqZ
	fqFG0tCcH2YSVkPrtnTjabMduKEaszM+DH2jTYcpq/D9s/kdCFcwvnU0=
X-Google-Smtp-Source: AGHT+IHuBTd4EKE8UDEyJ0Wz+pcTa5+vU6TMpKx34FkdO16z8Q9Pbmg0Dv0hibKmzirxwA2sxoLOhyPvplR66N4lZcdJ0QduIOew
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8720:b0:4b9:6f13:fb1a with SMTP id
 8926c6da1cb9f-4d05e73844cmr173124173.4.1725504122671; Wed, 04 Sep 2024
 19:42:02 -0700 (PDT)
Date: Wed, 04 Sep 2024 19:42:02 -0700
In-Reply-To: <012b02d0-97ba-4d5a-86cc-2d3d36ed71b1@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a622f0621563c7d@google.com>
Subject: Re: [syzbot] [erofs?] INFO: task hung in z_erofs_runqueue
From: syzbot <syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com>
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

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/dev-next: failed to run ["git" "fetch" "--force" "3c3147cbfa20ccaaeceb3a944332ec2db65b4a22" "dev-next"]: exit status 128
fatal: couldn't find remote ref dev-next



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c686716759500c2
dashboard link: https://syzkaller.appspot.com/bug?extid=4fc98ed414ae63d1ada2
compiler:       
userspace arch: arm64

Note: no patches were applied.
