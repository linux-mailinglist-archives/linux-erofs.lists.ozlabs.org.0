Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0F66DD4DB
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Apr 2023 10:13:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pwdrn0gmqz3cMk
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Apr 2023 18:13:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.198; helo=mail-il1-f198.google.com; envelope-from=3oxy1zakbamwagh2s33w9s770v.y66y3wcaw9u65bw5b.u64@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=<UNKNOWN>)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pwdrk28kmz3bhL
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Apr 2023 18:13:25 +1000 (AEST)
Received: by mail-il1-f198.google.com with SMTP id z13-20020a921a4d000000b00328a272a056so4324856ill.18
        for <linux-erofs@lists.ozlabs.org>; Tue, 11 Apr 2023 01:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681200803; x=1683792803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djjgIgk1VBqK4RbpYBgfm+h8QwgOT9VRNFK+aNQOl2Y=;
        b=aKI1R+NRxk2DMTgAdh5ubACgLh57FvgpF1pa2FYXMZLiM+QpBLvrfNmIOELI4c3Or9
         VITABELmbbHKiY+InX+FUF0OVSJwHqcUc9pHN2np+p9iieyqPyD/PymLHFhHZZo+PxrB
         pwMcQpz7lwXOXF7hdGXf/6IpnM5l3wb0poqwcXiu6h3C1IgN/hIPfVmoIRBIf1qK5Ahe
         uarb8Lxp2U36ZxZCpBMP8QCSXBjCd+onCS4feJYD8BrIBSJPq1u76IJn7sOiIM9TZILw
         Ppuo7uXFy94tujamMP7H5G/TTtG5gHGdElT4ai4cLt09PGjlDvIQ0tvUNkgFg18byKd/
         2akw==
X-Gm-Message-State: AAQBX9eaDlFyvDKDp1c5hEY9zpturT68doVZKpU/jh82ALPnZkvSWHN6
	lTBo5XBKePdux4bBaMQaKVpsayHDcD1H/J36yV3auCuPVRAk
X-Google-Smtp-Source: AKy350Z7gtlhP31HcuwhBvlRatMCqL3+8ybejEWbkaZEGdhua9vgHG48v6hnsbZbEqnnqS4G024NkH7T7BA/QMsE1YZqkoCBLMFI
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152f:b0:326:21b:6e66 with SMTP id
 i15-20020a056e02152f00b00326021b6e66mr1357815ilu.1.1681200803193; Tue, 11 Apr
 2023 01:13:23 -0700 (PDT)
Date: Tue, 11 Apr 2023 01:13:23 -0700
In-Reply-To: <9be0b507-4c02-86cb-20d8-052e9c7b97be@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000abaf4f05f90b1083@google.com>
Subject: Re: [syzbot] [erofs?] WARNING in rmqueue
From: syzbot <syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com

Tested on:

commit:         349ea8a3 erofs: enable long extended attribute name pr..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/ dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=113f800fc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7094f4ecb462be3
dashboard link: https://syzkaller.appspot.com/bug?extid=aafb3f37cfeb6534c4ac
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
