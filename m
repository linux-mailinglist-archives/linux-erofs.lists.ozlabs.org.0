Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2894C9C82C8
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 06:52:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xpq6j3v0cz2ytJ
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 16:52:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.197
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731563531;
	cv=none; b=fmXnnU28jxUR4bnnP1wRJsyibzBsKiEIOB39UXKyUQYBXud4x872hKE98y6ASVcDK1p8MR4KePHVLeMKXGfSBc6bbPWThFhsWSV8j/zrtuxL2vTqfmX/M5khO7m8NcKQmrQROmz4bfQ1vPG3Sg2LtUWZLGaDDMsT1D+oDO+S5ktsQkAYWVHpdtWnMV4ZMKqM+Shorgb+hftG9g/QisKS1k31HCWV20xIbT2s/eiQyJCNhki7KeR+T/dyXvXr3aU36osPlCdLWTsg6PI53QNzYo/jGDUuOMzMVne7D5dxh5saK4jLuB1yQlyER2pC+QlERf0PMy8jnxT4YZlJysIOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731563531; c=relaxed/relaxed;
	bh=1IpFZEQgGIj9TjFRbdLUfNjQq3j1EQcFpxBuYCYzFUE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JtEjhYtV+kbWwb9BSTr8ntaFgqWehg+Sxt+4Bb9t1y4DBW9G7vyV+3GqZ9jBEeeBivZq/5/MoSxYwlNcfTlglFag0FFE03AQxZczmzXmMlp06J0iFePYND33l0Qge4ENnihfulxGX4u0vXxWwTC9Wz76N9dBAjo9d50X3cpcnFVYy3B31YjSVSA2t6/aGbws+E0RlUSWpxDy/QDrKUPrsMrVquM1bYzfDEbNGbt9nuDWqXQnX18rn7a5fDR8shlGUMn51J4oXCm796/0WlHBEVNm7uZ2AjrTSuZEBgo8n6n4ML1E7j75Cvbt6qP44rJ7Df5+ZRoe/UARlRqCTHoeiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.197; helo=mail-il1-f197.google.com; envelope-from=3bja1zwkbadspvwhxiiboxmmfa.dlldibrpbozlkqbkq.zlj@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.197; helo=mail-il1-f197.google.com; envelope-from=3bja1zwkbadspvwhxiiboxmmfa.dlldibrpbozlkqbkq.zlj@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xpq6d4WMRz2yR9
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2024 16:52:08 +1100 (AEDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a715ac91f6so2927065ab.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 13 Nov 2024 21:52:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731563524; x=1732168324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IpFZEQgGIj9TjFRbdLUfNjQq3j1EQcFpxBuYCYzFUE=;
        b=Ag9ScxjWdzxQftZuZWdFu3FnfU9SXLQyxvIjD5VAsweQezIoA//StrdZLI+V8LPl4t
         TRI79xXCeiFVZNMxK+EkqH5PT5ZcYyxOeZhT1TRoRDsWOO7yjauoopkiWO0zX3Y6XBu7
         Udynr/6RZqPZSBpca7s7JTboD3M4omO3FKhmUmQ3tjaXEqFfOokh9KO/xfDyJuzSvVMf
         0/7VdZtSM7RjVHY6+Y1j/Fks8oQheLy7kKH6CYsNizZPqo0LtkL+6rKd6lFq9FQi7zT6
         ROQpZlMmf0qF5vB9zJBrC6ENcxpo3gWUOTNu+1Q9pmZFttxVNJs2vZZ0sY4zR++6xwS9
         68UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlcDO2XuBEyjnjELf5E2hwbYuhQXwwUnAx7YIkN2iDKaW3Q0yqv2g7Y/GsZuiY9I/f160OUqMw/d0iOg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwC2Vdd07WkSXagqc2FRrhNHi96CiRlp0ng2lETKModRpyM0qJl
	DgywNPUtEn9UUpr6bohqusGLgvkPM8lNOEwtGXJRSOtMq8Jamy/cn4jZiCYQ6IdiEsFLxHbo+nf
	HHK8CsazGFTAKG8zeFplf5oVA7YXuFYEgLhluYW45ke0l3Bfn4Q6ljjc=
X-Google-Smtp-Source: AGHT+IEGC6y1/QUxLcKR4nU9hQrJNc0vXYAJaMCUbS301MOJxa+AGUS1nxL2+ypoL/jmba0RuTagI9xdLG5nigEMdFtsK2PT8Cmf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:388d:b0:3a6:aee2:1696 with SMTP id
 e9e14a558f8ab-3a71578db17mr60186115ab.21.1731563524569; Wed, 13 Nov 2024
 21:52:04 -0800 (PST)
Date: Wed, 13 Nov 2024 21:52:04 -0800
In-Reply-To: <e22f5b69-0462-41c6-b7a9-b3ae10fa6992@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67359004.050a0220.2a2fcc.005f.GAE@google.com>
Subject: Re: [syzbot] [fuse?] general protection fault in fuse_do_readpage
From: syzbot <syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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

Reported-by: syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Tested-by: syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com

Tested on:

commit:         779014de erofs: fix file-backed mounts over FUSE
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=155294c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2effb62852f5a821
dashboard link: https://syzkaller.appspot.com/bug?extid=0b1279812c46e48bb0c1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
