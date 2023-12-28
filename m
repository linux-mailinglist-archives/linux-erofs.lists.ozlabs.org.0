Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5BD81F48E
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Dec 2023 05:23:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T0wNc45P7z30hF
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Dec 2023 15:23:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.69; helo=mail-io1-f69.google.com; envelope-from=3kfimzqkbaiaw23oeppivettmh.ksskpiywivgsrxirx.gsq@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T0wNY3PD2z2xQD
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Dec 2023 15:23:08 +1100 (AEDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7baec3f92acso253260139f.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 27 Dec 2023 20:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703737385; x=1704342185;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dd9vr80+WFGKnhM1JNQ66LsYvSI4r3S79KXgQZCzYg8=;
        b=fWtxE8/LLjQGWJyeO6e7nib80wdhwZgl0MfGDzDTNG6b7RbcH64cRQo7MXFGfLevCS
         E3UVg/+C0yO6qS8sJz4HIkNXWngswkxfP/UixkUeam42KmJ2sFhk7ijgnWsnVpNUA0JY
         ALI2eldG+Owg8K2BIrWxs2meZt6Go7BAB9z9CcLy7RDr84lfQ056bM+2VK3+Eh6GrYWe
         S78xOndsAMyeINYk8T99L2lo4MTkSluZ8nNpoARiPyH+oDRc7EdfGGXiiAIXAH4KUmMZ
         oCmva/A7lvt011tkqd9SNME9nLPcZBvYPqpdfgHScx43Kzcnn3R3J4lINuKnO5vlhTKd
         Z+rA==
X-Gm-Message-State: AOJu0YyMxyzQEUA4LBqDrnJeXAb02cgiL3Q0GaTDfuoxnQO/YWRWvCaz
	wJ5GiYtSZG6jgFmL0tl2XeGEB3AKDM8hJ43Ra9ek2P8ASj78
X-Google-Smtp-Source: AGHT+IGaH2neAkdIoyk3jyVZ49xeJ9vANxYmgJtaoyxGuIkm1BlzltdENKQP89j3UrTnEYAGl/eH773XOz1+ZzVlXzqXfTbc77Yh
MIME-Version: 1.0
X-Received: by 2002:a05:6602:18f:b0:7ba:cef9:803a with SMTP id
 m15-20020a056602018f00b007bacef9803amr69602ioo.4.1703737385611; Wed, 27 Dec
 2023 20:23:05 -0800 (PST)
Date: Wed, 27 Dec 2023 20:23:05 -0800
In-Reply-To: <5e2ad1d3-32cc-4f94-963f-a066d2a21536@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8f9a6060d8a4520@google.com>
Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (2)
From: syzbot <syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com

Tested on:

commit:         94da00a0 erofs: avoid debugging output for (de)compres..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=13715b95e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f711bc2a7eb1db25
dashboard link: https://syzkaller.appspot.com/bug?extid=6c746eea496f34b3161d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
