Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E42B797ABC7
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 09:02:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X7CQD3wcVz2yMv
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 17:02:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.200
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726556528;
	cv=none; b=Jb0SF6Tr75jfAXKGVuPMFK19w/oXwY1NIKA8Tv+zFL1j3aDNlK4xejvBEuiqsCx0fWPogHN8ZQrvWOWeIQeNNsGxGBvEYbzbjZ3u7Y6FS4l+7ujzg/+MiiOm4GqXD64HfiaWTj757jMUujuaoil3gTN7t9GlAJ17REPNgv4gGi1Hsf47nWAA3+e+JaU5Q960B3PvupIl9U6QkmxsMok2kd4eSavtDj7MGB86tfuvMaoeC0srgi5Y1DVrp+WqjKplA8V4cCHJeDqTNkjGr6uvyaXeN6koRlr2/PMX7abAAC9OlAH9LJGO1rZYrKgwXie5wdF1soV5hfejAZFr1zuV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726556528; c=relaxed/relaxed;
	bh=0HSv32HeGpYbI3uL9CkUI9gRqEnD6C5ndl4yRdjzD7Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LBSb5wEfputAvnkYvjJGNCNd6JdpRU2zUCSP07LzbY3Jd//rVbvKvVCaczWHGJyvTeSCrTurGn+WCN7JzjGqWju6Du/G48Ryi4XIK7Jkc+8XQlC894VmWK8QA0HGiEhkDU5ifQbOKrSctn8WUSAgkYSncKowzZ/W7VjTYMoWpq4EYRllWoSXMoq04bdZLKhS3oUSzfDRBf1tffhgMreKp2BxQbfctKkAFMV6xqaLMWRqxqHpQpv/XvsRS3R7HPjfhjHcS5oM7a+qF9DxR90Y77q2H2LrmeMOiney+fx468VmOi4xa2Esp7Ccpxjij624aMMGQTxWf6M1Ameq9lk7xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.200; helo=mail-il1-f200.google.com; envelope-from=3bcnpzgkbaketzalbmmfsbqqje.hpphmfvtfsdpoufou.dpn@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.200; helo=mail-il1-f200.google.com; envelope-from=3bcnpzgkbaketzalbmmfsbqqje.hpphmfvtfsdpoufou.dpn@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X7CQ74ftGz2xY6
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 17:02:06 +1000 (AEST)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a093440d95so55265095ab.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 00:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726556524; x=1727161324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HSv32HeGpYbI3uL9CkUI9gRqEnD6C5ndl4yRdjzD7Q=;
        b=HtnWYlA1gGJS3aPLq6fPAfL7xRposTJcbHkKquMW+hu+3lE8GKbMUjXoF7d5Mmwnpn
         4YRZNM6Be1VcVx01v2BZOu1BAa1stdoi7Fqe3NrQ5GwXT2Bs4KiWHfN0ttFtSqdIZQLg
         xItEjAP1M2vRdd2TI9DFp/E7QAw23ICE8XEp0b175ibFtFvYf+l+Zr5AmEnxKeBCdqu6
         BLkpvhA77cM6aekubnOuViZcTTz7EBO3ikkh31vRySw4bmcNCufPfnloKVUNbx6P/wMg
         SfI+h/LtxjWYTlfydMDCA4EaGKJh8uXNEnm7r+7zq2HCjEM7LSWOCb5tXtI5VUkn8YAI
         /2Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWt5ri42AU4k66cc8Sy9UO98ujt2ZZZjifAu+RnihCVrEZ3+owNoCpmazxIoNr/t19n9ixpdGdaRGwQZw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwoqYzkcsflyqsURxn8XKKAjqyUgnq/9+EZZfamt4Ub7AsM2R+g
	XcA0FAeqwh89dFGM1SnpiFo77pbazdXDnIJZW4Uo/+kFL36+9YQnYBLxILvOKWZH4E67ICzI73D
	45TS1H0UaQhSvnkv517KeYTMpqPX8zFzBp0vC2OOHeN0f6tILXUsPSmQ=
X-Google-Smtp-Source: AGHT+IGw8MIimOumCcBH/mbb+XShL8ROcJkfpG6tiQ4cOqJf4vE+Ssk3Q/tTlw6EZZn4NTFoq+T7ItW8chy/Sbh4o0NPuCpCuNcj
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4c:b0:3a0:4c4e:2e53 with SMTP id
 e9e14a558f8ab-3a08b6f86c2mr132203285ab.5.1726556524044; Tue, 17 Sep 2024
 00:02:04 -0700 (PDT)
Date: Tue, 17 Sep 2024 00:02:04 -0700
In-Reply-To: <f58a6956-5029-4764-962c-ffc02602a755@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e9296c.050a0220.252d9a.0005.GAE@google.com>
Subject: Re: [syzbot] [erofs?] [mm?] BUG: unable to handle kernel NULL pointer
 dereference in filemap_read_folio (3)
From: syzbot <syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
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

Reported-by: syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com
Tested-by: syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com

Tested on:

commit:         2830df2e erofs: ensure regular inodes for file-backed ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=11b168a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a43f85ec3262ab75
dashboard link: https://syzkaller.appspot.com/bug?extid=001306cd9c92ce0df23f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
