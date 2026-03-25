Return-Path: <linux-erofs+bounces-2989-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIcwI6quw2nAtAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2989-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 10:45:14 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC4832267D
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 10:45:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fghpZ6c3gz2xcB;
	Wed, 25 Mar 2026 20:45:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.161.71
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774431910;
	cv=none; b=kFEVzrDshkmwrLQTKWg3KHS6GauMQsr2gzk6ZKvYg+3gs7gfYY9ZZxQEwxAPSmVEGOXs0G/PgylIHrPuBdB/DzdjYmB+dKKcrZYucBVBKVU93zceTnLls+nVAq7C0nCpvSR/yOklq5Sq5jBuun1cUGRlMn47rDiENE502MPDvYbf1hlGb37SYhKpKaLe7oKCkwQaJZxRorHc/xh8pFAMU460xMDdgm+uaUae8I8y10W7YrZiHwHIRu86EFSpox3zf55tsITPUFTS10f1OBBMDzU5w+ktTxBA+i0IEu7fHNIRwGAl5XjPVOD0JCfT9umFKS9zp38bU28Jh+J8i7ENtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774431910; c=relaxed/relaxed;
	bh=h6/ctJIsRFLJPdLyccki9SaL5jRXJqTkAKjRzqfrbh8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f8YXCGXddHo9KhQ1n8QfB3FaM4uo/78hRyVMgjpc27/U/JZBW2rGAtPgXJbqBHvvCZBh/lNPdLkMjp+aHOxEMDxUjHF3ZHuK7oH+F0FjsGauW5NkQ9rDCcjQFuVkVQ6ND1Gly7PhZvHwnQUvjuDcuv5eBuh53/fWFQGIelauyOhJfuvXaTrfCOEY7/kTiYuTdEoUdgIVVvFtiDkGjzaK6W0QQVZzsHAtRflgU36DF3PQ/eboBvuoZPFcwT3T9+spO6Z5f/QrdShSF5UQfTK9LeYxjohAd4pjEgmI6aW1LjX+sXypzDYdXJFstggulejThDCL6JsI0Ej6vS0jv5rdug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.161.71; helo=mail-oo1-f71.google.com; envelope-from=3oa7daqkbagisyzkallerappid.googleusercontent.com@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.161.71; helo=mail-oo1-f71.google.com; envelope-from=3oa7daqkbagisyzkallerappid.googleusercontent.com@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fghpX74XVz2xSX
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2026 20:45:08 +1100 (AEDT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-67baeba7a53so2155672eaf.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2026 02:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774431905; x=1775036705;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6/ctJIsRFLJPdLyccki9SaL5jRXJqTkAKjRzqfrbh8=;
        b=jDJl+5w7MBs3yquimsz2Exh9fg94tY+2AjQhhD2vSkiXztMm/QA0cPgXfeOaGxcu3D
         1IdkG5zQMF6s3YCAjU/0NQuXdapAr/TgB57NnUmuQ5vnokFbGkOIPIPGyI3KKSwVNV9g
         sSyOPAk3F5sttOR/W9YGEJCq7gdHPWrzQsTdp80i7gfRuJ1mhXw8sRkrljCzi9rRLatk
         x9pnZW/dFHzEQcQoIeg1UJj9XecdmelPy4S/Rxkv6VAtnnqt/Gv5potHlX3l+QxpugCa
         k5BrJYpNz3CDo1H3mvgmG+NtcP2vSKMlD6VAwkxvh8NDUwr8L/eajUfuRcAK9j7SY6BK
         znxw==
X-Forwarded-Encrypted: i=1; AJvYcCX+iN2TGGabK3v2fYQXRC9VFWRyFUy/g7JGgKbkiLbDI1WGr4c9MJZUAPb2DDJnTi0ujVKJMnRuX+qo5w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxd/9F+8d33u00KX7cdgvyXUZ7hiMJhTqy4nQUv6NuK2J+5JF3H
	ocFEfKUklXEVUiHZqF8x0/+pEVECRLI/lHOUeXlCrPLhpbVTTrqnaDERDGXhAF6vcBm1WZv3gtr
	rqEdOGy6uOgvMWCV9RE/zahzRaNdHDmE/ccbKcIyRcgx4gQty4+MisGoI07I=
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
X-Received: by 2002:a05:6820:22a9:b0:67d:eb47:8db4 with SMTP id
 006d021491bc7-67df5d8bf51mr4087717eaf.22.1774431905649; Wed, 25 Mar 2026
 02:45:05 -0700 (PDT)
Date: Wed, 25 Mar 2026 02:45:05 -0700
In-Reply-To: <8bed2474-4e2c-4a28-a959-bce3bc5190fb@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c3aea1.050a0220.abc16.0013.GAE@google.com>
Subject: Re: [v6.6] BUG: Bad page state in z_erofs_do_read_page
From: syzbot <syzbot+b6353e35ae2bab997538@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	syzkaller-lts-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.3 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.40 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=691a6769a86ac817];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2989-lists,linux-erofs=lfdr.de,b6353e35ae2bab997538];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:syzkaller-lts-bugs@googlegroups.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 8EC4832267D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/erofs/zdata.c
Hunk #1 FAILED at 1538.
1 out of 1 hunk FAILED



Tested on:

commit:         4fc00fe3 Linux 6.6.129
git tree:       linux-6.6.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=691a6769a86ac817
dashboard link: https://syzkaller.appspot.com/bug?extid=b6353e35ae2bab997538
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=105721d6580000


