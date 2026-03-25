Return-Path: <linux-erofs+bounces-2990-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABiOO6Syw2litgQAu9opvQ
	(envelope-from <linux-erofs+bounces-2990-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 11:02:12 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6AE322978
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 11:02:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgjB60R83z2xS3;
	Wed, 25 Mar 2026 21:02:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.161.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774432925;
	cv=none; b=IVAeUFO9IvBQYmr4IPmKciVnDD/DQ6/cbsrA3qu2HPZ9iaHbkT4giy9aJnUvR2XgHYgeKLvOx1URsbqzlzOXGyVoWdgI05ulj0XKeW0vIva8cq2NNy/jiTU6QwB3cy9rczzoqchYL+WaNGqlhQ42zT4inutL9uY7VlluvzGw6OsfXVtSbnlShra32pfkiCZCG7ABM+8MozLBRPSD05OccZLX0kUeGmM2dZHVrTxCdwykP2VQ3B0jdlUiDTLWPnv2kYOvqcrxUajp3QONobU2Je+RpjjlriACgW7hTzUOn9RWT4umUb9POHSg3CgI/2sFsR5spQ98o90/5ex01r2ruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774432925; c=relaxed/relaxed;
	bh=Wt/zP7gPXdc5BLZeGKzYLZVGgArFgcuj62q8DwXFGXM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f20u5VjtMPTyOpVRXP/f3PwSL64wJIO2xHGosXvZRo6XCzjsZoElEihiJ9QHdvwFsY3U9taJFr4L+RYR7bluC37zk+9d8i4QKYbPdo8s4Uml0nHiyo3yz1Cfy2XYeYC1LRlyqD7dyHmLvX23DQmmdd7R4JQZBZyaZI4XMFCw3c1NvB+OKw/ihrq8v5JaKyQvLtMGUNB+IHA5pmRsdTOX1A8MTp7Bu5A3fctQU5vywhXy8OF6Fpv94XOKKYSzHEtjXW5VP4iWzRLsFLhh3K1kk4mDjAuSe2Vm1Ct6MuK/cR8VyNYna3vV57qzA6GJ38Xe8LpKr8Qu8wl9VNwXxYNKTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.161.70; helo=mail-oo1-f70.google.com; envelope-from=3mbldaqkbagisyzkallerappid.googleusercontent.com@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.161.70; helo=mail-oo1-f70.google.com; envelope-from=3mbldaqkbagisyzkallerappid.googleusercontent.com@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgjB44Zckz2xMY
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2026 21:02:03 +1100 (AEDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-66308f16ea1so18801138eaf.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2026 03:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774432921; x=1775037721;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt/zP7gPXdc5BLZeGKzYLZVGgArFgcuj62q8DwXFGXM=;
        b=qAqk0Fr0++gIji2inwGuk+MRJMiePU0poCWMw1JkqLAZWPsWv5+yAnqNBpUBjKNp2I
         gc2qagH2D3TwVsFCnuv22+eNnOZa4kvDrQIdcyeoDqQZwpFcVgqA+mWJ0MLmByiYlUxB
         MCGq931B5DA9h4NsYKzeygy9oWESa9fmFEN6qIja9Gz/hM43cl46CaUm9k565IWfO6Mt
         ye/QD09q+QSnQYqIthzJP0QBoPeM+X8zdKl4jndR7AYhRx0eZmbe/unFOzbsTIAhJLbi
         taGa4g9W5FpMneV1XSpZgWktHAGzbOsqZYSzQqeLKCusXmi+O28uUq0TIZWHAozr1mo/
         gBWw==
X-Forwarded-Encrypted: i=1; AJvYcCX0UZRLS9hYbxTft0H5wIM4vM+eNnXmot5Bm7AYe0IYwGsO1fF/H/9H5y82HwuNWIKoxULUrAFaMiCYnQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyX8qlodLFDttVx4UyTd+bFlWGawcVyY302jqsDjD4FazDzxPvp
	FXQacbk3Qy0TaYov128JGwa6BOvm31F7QQdO9lxPblw2JFPZ69ym+dENK0nQChA3vmP198CKuxB
	86UZk5/V7izQF1NYA9GCDl4VRwtA8ZAGuqhjP8BlX6QhZf3FV6JhrGEhMDRg=
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
X-Received: by 2002:a05:6820:4b17:b0:67c:1689:c388 with SMTP id
 006d021491bc7-67dff56248bmr1652131eaf.56.1774432921702; Wed, 25 Mar 2026
 03:02:01 -0700 (PDT)
Date: Wed, 25 Mar 2026 03:02:01 -0700
In-Reply-To: <5a1e8d3e-6533-4db4-a4d5-14f977d8514b@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c3b299.a70a0220.234938.004b.GAE@google.com>
Subject: Re: [v6.6] BUG: Bad page state in z_erofs_do_read_page
From: syzbot <syzbot+b6353e35ae2bab997538@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	syzkaller-lts-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.3 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.40 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=cf30d9e358c58220];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2990-lists,linux-erofs=lfdr.de,b6353e35ae2bab997538];
	URIBL_MULTI_FAIL(0.00)[appspotmail.com:server fail,lists.ozlabs.org:server fail,syzkaller.appspot.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:syzkaller-lts-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email]
X-Rspamd-Queue-Id: CA6AE322978
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b6353e35ae2bab997538@syzkaller.appspotmail.com
Tested-by: syzbot+b6353e35ae2bab997538@syzkaller.appspotmail.com

Tested on:

commit:         4fc00fe3 Linux 6.6.129
git tree:       linux-6.6.y
console output: https://syzkaller.appspot.com/x/log.txt?x=135ff6da580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf30d9e358c58220
dashboard link: https://syzkaller.appspot.com/bug?extid=b6353e35ae2bab997538
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1029ecba580000

Note: testing is done by a robot and is best-effort only.

