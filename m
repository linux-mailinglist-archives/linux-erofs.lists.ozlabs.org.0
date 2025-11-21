Return-Path: <linux-erofs+bounces-1417-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FC7C76EFC
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Nov 2025 03:06:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dCJVD5wl4z2yFq;
	Fri, 21 Nov 2025 13:06:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.197
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763690772;
	cv=none; b=WvDqw99IF23ijMgW1F56+DEQbznDnYZldzwzLd8gE31i4t/tcig/ankLENkgW/g+QByonHjDEH3Ix6soTrf5VGXazvNmTuaItWy6oCApCJSqE8d1EqrwYo1kRFnHqOl3HhPOK4yOZooBPYxJtiNFDF5Hq7pi0liddHbDaddfWFls8Dqua3uvvo+wfBZjLaysT0SmjwIS8CV2r5KGEj2eXv3Fs4pogYvGfJK2D5/hfKDjwhb6ciqnmSwGHn5bBv3T16CXjvbjs63iEDa9VBXC67G5OdjdWjAF6y4tZ9Y3kOgtMC6qz97dsmqPJMYoLCgCFZVrqADh7Ii7v2q25KqO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763690772; c=relaxed/relaxed;
	bh=7OCdpbCt3wNjnRexiXCbilmmMxUr0JfnovhkDRuiHMw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MDjnQJrkXf7EKD1Tnfc8QUyNgoV1IpKR4bU0hzCxOrPBpKYqdlvc1DAWASUR6VhJlLL683iopSJ23fuys7Lnm5JMdGM3046t6W+wyhe0YxsypE5W/OhkmiTPPEEF2vJVhwtrgcLeYdfHqqiPOu+D9YFTHOPM3z+5Nnh7qRbuQM6jcII/GgZQmnQJifaVTh2+PIDvzzV2gidB9qC1EZ1RnlGN/I2dq88bvC8POpDB5cFOZXiGq5cVtQ6CKn0ZsBQTKjxOk1ju9sqLDXtzHiUJTx6d6hrgWDe/jH8KYy2WEMTI/bWbEnYjlyA9930hDLBHN8C42k4V9Mi3HlpX5t6fsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.197; helo=mail-il1-f197.google.com; envelope-from=3c8kfaqkbagwcijukvvobkzzsn.qyyqvoecobmyxdoxd.myw@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.197; helo=mail-il1-f197.google.com; envelope-from=3c8kfaqkbagwcijukvvobkzzsn.qyyqvoecobmyxdoxd.myw@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dCJV75C5Zz2yD5
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Nov 2025 13:06:07 +1100 (AEDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43329b607e0so13695375ab.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 20 Nov 2025 18:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763690763; x=1764295563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OCdpbCt3wNjnRexiXCbilmmMxUr0JfnovhkDRuiHMw=;
        b=K0e5QHBUDUAXqg9ynX+fRKQyxJAzoPFIxEJstiPtYB200vBC8rmBhivTSQz7XySF84
         wPS0ympPPylfG395+U8ToGLoqnyO0Rw9gdvYqgNKBPvePBk/DclGTaqJPNa/IXARABb9
         NO8KpiWVTy2DlCXuEwsT2ajM2Rr71gr6q51WC6PmJiQ4GfMSUTTpSMKb3l7gg/JCXmaN
         3n8s+JitOoXBqhDmpsH2M5qBebTWyVplJi/faCyPwGmAIzW0pp7kavKulqx+9IkQQh9/
         7dK7N6ilYgq04gNVoyjcxTCIEmUtePEIW5wDi0LYa2TJHnJpRn0QPRW4PiK6vw3FTn8H
         jpJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw4n+fTAPJ59IBBOYY7VBm6EJBl4wr6ih8FZVFjN/o/Sqd8y+OEySZ0/cyujldcP1+5O8D4kmmMttg2Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx4LWAP/n7CFVDLCrL+PkJF4N3+vfve5+P3hYFB18VVLZOyYiap
	ym/0uXHO++iDJr2Flst23Pj1CgOkeyX4VjC6MUHDxgo8Dsp6yYvPcRH90XpKKsWlK8KHbg/abln
	cbzGWHnMSlfp+HEfeWjdEkfS1149Hp9X2p11HlwfDCyQs90J4fZiMtFD7WnA=
X-Google-Smtp-Source: AGHT+IERcIc1Yb4CzJivjqJVbeE9z0kQcPZljxjvjHd8lnfDE2lKDDAofdZeFq+S7IKH5Uleere/h9iRDE6DhenRM1S2gF2TBV8M
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c3:b0:434:767d:8a4a with SMTP id
 e9e14a558f8ab-435b8c43cecmr7815205ab.18.1763690763609; Thu, 20 Nov 2025
 18:06:03 -0800 (PST)
Date: Thu, 20 Nov 2025 18:06:03 -0800
In-Reply-To: <1939a99d-c1d2-4b98-93c3-1951db367b3f@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691fc90b.a70a0220.d98e3.003a.GAE@google.com>
Subject: Re: [syzbot] [erofs?] WARNING in get_next_unlocked_entry
From: syzbot <syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com
Tested-by: syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com

Tested on:

commit:         3027b141 erofs: correct FSDAX detection
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=16e2597c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1db0fea040c2a9f
dashboard link: https://syzkaller.appspot.com/bug?extid=31b8fb02cb8a25bd5e78
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

