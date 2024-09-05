Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6A196CD67
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 05:36:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WzlQ33z8jz2ysh
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 13:36:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.197
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725507368;
	cv=none; b=EBbJKQsrlNWGAmli1qECL5Q131KloIDxksqxO9CbVRKV3ts2qZuaOmfJEvOyx+YICYRAS0Qjmt7HKb0Yz1W8OxR+Wpwujf/94ihl8I4lkAZxZPkD63pc6gEKUojISykixPzC4d+Wq0NiQgImrSNl8FBW+ltRFbJtoRDUYOcvX6XqzjLVy2ZvZfhro6yaQ1ULes8HrxNc8vlyr6QVZTRii8L2rQjHmCezIphLBp4Id8seJ28TVdWQQ/yvIwNgpSVK6rE4rwCm20Y0OMPAwMe6qcNS6vWQ49JB9iJ1BjbAOrXBifUtG8XWR4W8xmsunKDwA0/NBFKiVj81Qs0F4+dZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725507368; c=relaxed/relaxed;
	bh=lWC0ltEAXp0mtaOhR7JjRJQRO63ul804XOUVSx6FfIg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DMyw3A2pnQGsfrw0qBvA82HfnZ0+PoeMzps7FQ6TRMlVUwcGQRWeM09CcZfLe0c6NkCN0ZHEcFgsx4vddlfiqS6kazy1o7nw6KHCVue64fT+HLYltmsKooVgUzfLYEwtYJxzvliKkuxPkFsULXU7Kw4zvRg1eBzLJ2C66PqxE/B3yr751HwbDFu47Ej/4wJnkUjpYGeMkjMPvBoxnVOHrz/kbEXfr6mrC9IEF3MluU4V8c4VhC5Jhm6ugW27KhpeCqhx04fqttA4whuVX/emhDcOlm6oIOdXzf0kYRIhCreARilmXBmCxaaGQAARilVcK3eAswJkNIZ0f46gee5t8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.197; helo=mail-il1-f197.google.com; envelope-from=3iyfzzgkbabqcij4u55ybu992x.08805yecybw87dy7d.w86@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.197; helo=mail-il1-f197.google.com; envelope-from=3iyfzzgkbabqcij4u55ybu992x.08805yecybw87dy7d.w86@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WzlPz4RmLz2xxr
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 13:36:06 +1000 (AEST)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d4b5b9fa0so4605375ab.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 04 Sep 2024 20:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725507363; x=1726112163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWC0ltEAXp0mtaOhR7JjRJQRO63ul804XOUVSx6FfIg=;
        b=iCUcbXJI5VBxnewgxVbdaSqqo/UBTmWGodrwAodCXZGCe7CTljM4oGtTv//MQl4gEo
         S9QPyAoJgvXYAMB1kIy6V0Hd9SqumxQq7JHJX/Mn3Y30DmUTf7xTWrw7kdyI6+ECp135
         Sh+7kCTXPrUy7mR+Ehd9xQb+8DUGd7bvQLeHoEmgcQe57qhICNm2hG281vVhmlRUH/y+
         h/W3324bcVWSyGrRftAenuDSWDxJyt0ElkAjlNYqkMMmYg2Tvj8Sd0Np3kzU18zCof1k
         PFH9jqrqfNEHPaORnKJ6XO6uE+m9clKCyGKBWT8JB3BZlp/Nslnh/QsquvdAslSfci9/
         p6OA==
X-Forwarded-Encrypted: i=1; AJvYcCUsQ55Gl81vQP0JB7OS6rh5z2M5jOEL8RIWm4AIqdahWkTZaErxEDl/th/rEbV3I9Z6B3ONMjL1uF8yvQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyQwjgJOE+N5O9N2tpZ2pvCcZT83ycTUtH0Mne7jjUdxIbELX5e
	vkqBtrRmw3JQt+azPIXozfYhYL2n2Dm03P/ECz0tAmFv+9XJNUD7nHwwAQ1mLtqSSfpoD2Cny1U
	TH+j/oTXW4c4tmasA+4bA5lU/UJzi6b6xAu46Xw7UVMRBnB4i9MNzqrY=
X-Google-Smtp-Source: AGHT+IHuggzUQvgjXydkyLrL6SK4jj097SxIfk71LgRrMQGly6nNEvlpsA1RvKpPPJtTZE9P1kXsejCnetaJ2eW5VMvrRssuhHWJ
MIME-Version: 1.0
X-Received: by 2002:a92:c24f:0:b0:397:9426:e7fc with SMTP id
 e9e14a558f8ab-39f40e21b22mr12075555ab.0.1725507363662; Wed, 04 Sep 2024
 20:36:03 -0700 (PDT)
Date: Wed, 04 Sep 2024 20:36:03 -0700
In-Reply-To: <80045cd0-338d-43c5-bea7-378504032006@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077ff1f062156fd2e@google.com>
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
Tested-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com

Tested on:

commit:         e96d8572 erofs: handle overlapped pclusters out of cra..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=10d14e8f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=264b71bd0896c2bf
dashboard link: https://syzkaller.appspot.com/bug?extid=4fc98ed414ae63d1ada2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
