Return-Path: <linux-erofs+bounces-2260-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGmaLP//g2nYwgMAu9opvQ
	(envelope-from <linux-erofs+bounces-2260-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Feb 2026 03:27:11 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B8724EDF68
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Feb 2026 03:27:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f61MG6tkqz2xrk;
	Thu, 05 Feb 2026 13:27:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.160.69
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770258426;
	cv=none; b=JZ81F1+9SKqesZPRe/43JAnibGwGwmISSaCUzRxNk5LCXIVrh+PcE0FL12m+zbpb9Xg8GmOC41sxdRRKbXXPB57FmOLd3E5nxY0QY6kkwTN6mUVEf7n31L0DTbZ5muQ79sAwBDgYAqVM8+jobb6cOqHe6w+E9OPq9WT7VcBaTxwXP9w7BjvEGcj0zsm0cvIXVoWgnaBQrR+FmWbS4PtqGoOYDj0/o0hBvzE16vLmi3MNkF8aAi5tJa+6EBws0j25B5QbalFaK7KeiK/FkWqyIYZOOLxRVdhsnTzrsKnoY7jjrpIrFbhtsV5YDYW/xTB/LvrXm3KnY9dMWpP/b/kq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770258426; c=relaxed/relaxed;
	bh=ZXVVX2BF9RqFV/GB/UkW/X0bu5jgkWZjfaVZ1n5Rlaw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kx6qTCDKx+b9YBHgXu43w1caVCj17J4n0PaAXrnK1c8IVzxL8ruBOU1YXtJQk5hetTAJrevtpHs64HWD3ABfyK57hdbiE2mi8EfTxoBN+1XyO5cIPHrvbTazfsC0UPhyW83yhazih/jQhJWlyZIbR7cjFLwJvJ75+0NLs+Gj/LKOPlyutUxhpYuxAp/PoI2B/8l4pXOH0DzAj5DRWLjMwf2dckMjCVqnDQpqygbZPMXb1JdbJY7ApUkBX6Sxp9QSRsdjaAfS37b3u2JM1zCx1tkpz3kavGs4ehOO0FtUAPNC0qtmoz7ZtdDbnk9jRk1c8eTIs7G5A0vw62RTiC0tNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.160.69; helo=mail-oa1-f69.google.com; envelope-from=39f-daqkbafgiopa0bb4h0ff83.6ee6b4ki4h2edj4dj.2ec@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.160.69; helo=mail-oa1-f69.google.com; envelope-from=39f-daqkbafgiopa0bb4h0ff83.6ee6b4ki4h2edj4dj.2ec@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f61MF3Pwhz2xHt
	for <linux-erofs@lists.ozlabs.org>; Thu, 05 Feb 2026 13:27:04 +1100 (AEDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-409496a48c3so922607fac.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 04 Feb 2026 18:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770258421; x=1770863221;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXVVX2BF9RqFV/GB/UkW/X0bu5jgkWZjfaVZ1n5Rlaw=;
        b=pBgtjoAecfkNte+VQp/zxVcyr8EHrAiqjDZEPRhzvLNebZsr/k3hZk0dOGZRYup9Mr
         hCO35vTRE2ZCNd6BiifwlDJ1N6bOEVCHfbUdW4meqartjAzatGK4VuDRkDIC/Uz5i/yC
         rd8yWd4wecKcrrVhwzEIodyYGZPOn1OEYBgBCXKXQnhAtjVcL/MnpvDZDiI/Teu8M2T7
         F4pmGavD3Z9KC22WrTVhjl2JKDAzHQFYubijXsU+dHZz9Teexjqi+9w8R+/UefBIq6GS
         j9kOrM6q6R7rckRFjko3zL/ukP7VocZHJ0eB6X2Ne9xrysKQtu1RAMZC1PBQBiTntZfx
         88ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8mYYTLaUhFHv5WO1nNCHaeWdfwzS216W6irLPgxbY3vniuxE2Lltc8P9FCbAjHoWjw9BrSK7lrQ7HCg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzZUwZP5HMRksIVp6lRgeCXrGMLg2WhHzI0gJcmkT0PrweZjc7Q
	eLmLNG/giSfjDlaJLFMsi70H9Q6m8B1Y1MHWvGYxZAX26CemWaMRvFsp+yQSHp1yTwsos6yygh/
	b+Os98pfQWXIpIFP4C0WhPgdofNoLOYpNKN7tvYfUUl77W3bQxq3Fs5HdSck=
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
X-Received: by 2002:a05:6820:2291:b0:664:86ce:df6d with SMTP id
 006d021491bc7-66a20c6bee8mr2666266eaf.18.1770258421667; Wed, 04 Feb 2026
 18:27:01 -0800 (PST)
Date: Wed, 04 Feb 2026 18:27:01 -0800
In-Reply-To: <a2f8472e-99c9-4f51-b105-76df6fb4078e@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6983fff5.a00a0220.37c87e.0024.GAE@google.com>
Subject: Re: [syzbot] [erofs?] WARNING in erofs_iget (2)
From: syzbot <syzbot+c2dd47dc153320cc4692@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.3 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.40 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2168d83cc33f9cb6];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2260-lists,linux-erofs=lfdr.de,c2dd47dc153320cc4692];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: B8724EDF68
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c2dd47dc153320cc4692@syzkaller.appspotmail.com
Tested-by: syzbot+c2dd47dc153320cc4692@syzkaller.appspotmail.com

Tested on:

commit:         1ec50c08 erofs: update compression algorithm status
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=119f5a5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2168d83cc33f9cb6
dashboard link: https://syzkaller.appspot.com/bug?extid=c2dd47dc153320cc4692
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

