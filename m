Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9409D03E3
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Nov 2024 13:53:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XrrK403Rmz30Vp
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Nov 2024 23:53:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.199
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731847989;
	cv=none; b=ncaK1DOF5IgTj6VFaZMOIhRdTLuqjcPaUEkifm0eyXshSKupxxLVz7yFmmqwdT7o9KROBdDfS/xSMfn4Azr43JQF6SxjV2Vp1V2iSC2208iZZe4PrzKao/K0HXmJCvJSV1RcJjYly+S5XIriBgB2qSW4ficuUPkAcumZPbIKLuwDd4EuWhUf1zKs5NjEJWpdqZYrrctt4ynzbgfsCYJGBM4XhSIzs4edMXJYIldjj21QOsKwf5GBlFek+lZ3XexhqOi43CjTycmVCqsxWHKGhnDN3olaiAlh9psqRTlx6BRPBD5fX2CEpQJb52nxHof5xyr17x4WSzSvof2fIZjaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731847989; c=relaxed/relaxed;
	bh=VQFhShpCFFfqPZwz2aZH0sjh2uJyuJz+k8kyZhQ1m2E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C55D/f2OYWmVRv/LgWi3UnJ3NiuxHrWXJn8XtoUqFuP2//aImkoGexDaRBliyGsQYJxNsYF0r0/Xf0So8hJFs9o3HRQ+XWRY0gXKHfRqU3MgTHVUG2xWdnhwgcGEVyiebGB+aJM2IitzRvOKLRy+EUIJQRc9/BeRrtztdi4RerzMqQ4732b00+GNcIWW0Sqbb5t5uWhS4G97gZBcXCn2skTKxu8OaMKhnEPPwI1Z1Ao3PQrCyHZ4nIzUdHomVmfm0Q2fZHgJHn26N/EnUnTjASyVuEKDyiLh0MHWr3YTNVrXhQhAC5/OIBRwdHQJAGbqPWaM7KNeMrb43M9u2ds1jQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.199; helo=mail-il1-f199.google.com; envelope-from=3l-c5zwkbacyuabmcnngtcrrkf.iqqingwugteqpvgpv.eqo@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.199; helo=mail-il1-f199.google.com; envelope-from=3l-c5zwkbacyuabmcnngtcrrkf.iqqingwugteqpvgpv.eqo@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XrrJz5CSSz2xKN
	for <linux-erofs@lists.ozlabs.org>; Sun, 17 Nov 2024 23:53:06 +1100 (AEDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a743d76ed9so24560065ab.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 17 Nov 2024 04:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731847983; x=1732452783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQFhShpCFFfqPZwz2aZH0sjh2uJyuJz+k8kyZhQ1m2E=;
        b=TrClW1lqtXmd6kboPqj1pcwy5XpFWdjKZFoFM5bbRDMKwNz55Q0KpBh0DL44sqt+bi
         oTPHjujEFCSf0708Kw6lB1dXUtyxrvPbKbUqrHnFObqe1ULralvOrg3NiAd12YvI4uWT
         IsRYfADlqlN6/xb686LaQy5qVdAHcNYE3HVel+SqYY2qtcbSRux8uHDeEWTaxw+jLBe+
         R5p4ECUtYURJ/HIumRIIPg2jzYoGITBfSM1ZJJbRETGHwQj3ibDNKj3XWOGT3lFgVzOA
         Bf6uSZ3nue0s8WYhFfkZufJbFetBcVraPedsIZ/LGlvL6kKE5ZIeWPvEAvBnEoy9+x0V
         eVQw==
X-Forwarded-Encrypted: i=1; AJvYcCU7YsafUaMd3rBdHrp/SRotj1tXtSF2W/DtGnTM/JEa/UJ2du7ZWSopfpZiW3KFn2maZeuwRq0SQe4G8A==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyS1hJ2io05o3Rw7jMNHbs1Yw/RUt15HqpSYe7aOwiFV2pTksNm
	j0Olydg/6df+6y4u0Ze8cSn3jqhw1Cw+Na3xcZJsCRnflsx4w0xzTTYTrbiZUD1cgGuZrJpjRSG
	mTMpUjilqgBuNaFRH0mon2dGQ9i8EXhwt5RV6v3CCQL+3foeXDuU+/Fg=
X-Google-Smtp-Source: AGHT+IHH42tRIhFkR/AgZmPHwUk0sE72aX9yFGbSTU9HuCw52hfPuXvwon0zb3cTuC/NEMyQeriJMsyFdp7bupcvK2YJp/vVZLtN
MIME-Version: 1.0
X-Received: by 2002:a92:dcc6:0:b0:3a7:47ff:546a with SMTP id
 e9e14a558f8ab-3a747ff559bmr70003765ab.0.1731847983117; Sun, 17 Nov 2024
 04:53:03 -0800 (PST)
Date: Sun, 17 Nov 2024 04:53:03 -0800
In-Reply-To: <79b938a8-ecb9-4d3a-b1a3-76f1a9c9f351@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6739e72f.050a0220.e1c64.0014.GAE@google.com>
Subject: Re: [syzbot] [iomap?] [erofs?] WARNING in iomap_iter (4)
From: syzbot <syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, djwong@kernel.org, hch@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Level: ***
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

Reported-by: syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com
Tested-by: syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com

Tested on:

commit:         2795294b erofs: handle NONHEAD !delta[1] lclusters gra..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=1058db5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=921b01cbfd887a9b
dashboard link: https://syzkaller.appspot.com/bug?extid=6c0b301317aa0156f9eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
