Return-Path: <linux-erofs+bounces-2391-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHB+Gra5nWnERQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2391-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 15:46:14 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAC71889FC
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 15:46:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fL0sF3V2mz3cPR;
	Wed, 25 Feb 2026 01:46:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.161.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771944369;
	cv=none; b=LIDoHhkKKQXb4nIjkCAp2n4aXmv3KbIhf+KH1bQR7PwJNZ+k7o790RZmBEDGXb2HOdeNtPE6RrrX7VW3fjUOJMMGt/inXkq+j7XaIblJQNx+yAQNSDhPa8YuJfiibLwTHBl0e9v88XtsG8H1bjBGexqToERXFkKfjk5t1n54Sb8pXq5s57RRNPg1MAJvHeYyyNyhtKXo05MljZb78HR5dFLTLYVgQIUqr9xmHGtT8mjILW1CQrZDhb51cvGx18j6+VP2ogj6v/lhOXg6mDCYR6e7wrq2c7kEYvX6JO9+nXQhalCgkCDiF48GJVa0JzjkS6wpGcFZY1kBqtNH4bhjDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771944369; c=relaxed/relaxed;
	bh=zi58+sVP6mtMI6o5BoedbTqrbI4lZ+bprroNdTYYz+Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FUvakmKg41SwNNwa0xzmgPctR6tRusyI5kyJSang5D4bWG2vSaPKYzLcQ5u1hFzantUD9n2IbvtcHVFWezRt9+G4DuT7zXHyZ8SpwvNoNYeelNExWGdzlXTUqm8z6qWdaZ9RK6h9GXusNuVT/j34vB4l/WHJdMmYBBn1vwf+l9gFJI8rPj+cbPTJh5Eu1WSlSEBE6W8T551S7GKO+8ejCqBfUKHn5EMkzkoQp/S38hkqzvWAH89NUdChLAVlyxpvRT5cFb7TDPofgSdWfp5XIogB3gXB6QIM7PZeHIvi4P2QEkVkr/CINo+vZW18vGDkTM6/AJLwXyBZGUo3B6+obQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.161.70; helo=mail-oo1-f70.google.com; envelope-from=3q7mdaqkbaogcijukvvobkzzsn.qyyqvoecobmyxdoxd.myw@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.161.70; helo=mail-oo1-f70.google.com; envelope-from=3q7mdaqkbaogcijukvvobkzzsn.qyyqvoecobmyxdoxd.myw@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fL0sD10q8z3cPK
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 01:46:07 +1100 (AEDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-67995e1ecacso77583222eaf.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 24 Feb 2026 06:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771944364; x=1772549164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zi58+sVP6mtMI6o5BoedbTqrbI4lZ+bprroNdTYYz+Y=;
        b=ja/jcCZKu2/vZyezoyrBT5xEifNPpNTRGDAHRCexKMuBctcHbZFnDiuqDRiQ/hYRk4
         /syd/OBZtEqdtxJ0fDdoscdzNgkY80K4/zyTKNdAcYZHrpFAp75wQAXRm9uzn4CBHN1Q
         7a/oWbVx5/jO1Xy6GNQd5qqiFdEATILAc7eWL3Tp2TvMJFm6/JUsRrWct1RxRfv4iLMU
         XYAz9Rwq8lgprrIB7lHILTjqOGxJs1nfn1qlMhHKCqAOO94NRoWmU+Ia7B6+LZj3t7u6
         wVQ/KzbNCElxtvg8/sTJM8fHnOBUk8PH9VIZI3EEbGm6MpEdKxxx0hpowsQ0pfAZNZVA
         Toew==
X-Forwarded-Encrypted: i=1; AJvYcCVGQdX3PqYoT+WCWgO8n0SY1nB8TUL9S0I56PBCASilYN3EXT2Z415mSQvecaK2zHJpVCU/V1LWkrwhbg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyuwPPWiOOSood2pOPvX7VKrL2l+wTuGxWhpE5YuvYeuWDSM3CU
	HiIX9nuc/EtsyYCAgGVPziYckuE7ktS92SLXqoAjgBE6yfdJCxhSFHWz4i417xYmwKMIEzJev07
	EKa39twiMy8LlVOjs+9tOSI2G0VNF1ACoM04z2JXBXVEHKBRxl1dryqjq8Ms=
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
X-Received: by 2002:a05:6820:4912:b0:662:f4cb:207b with SMTP id
 006d021491bc7-679c44b719emr5016694eaf.0.1771944363947; Tue, 24 Feb 2026
 06:46:03 -0800 (PST)
Date: Tue, 24 Feb 2026 06:46:03 -0800
In-Reply-To: <9fab8428-73f4-44b6-afd6-31271dcdd378@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699db9ab.050a0220.3601f3.007c.GAE@google.com>
Subject: Re: [syzbot] [erofs?] KASAN: use-after-free Read in
 z_erofs_transform_plain (2)
From: syzbot <syzbot+d988dc155e740d76a331@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.3 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.40 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d91443204e48b7a1];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2391-lists,linux-erofs=lfdr.de,d988dc155e740d76a331];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 6EAC71889FC
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d988dc155e740d76a331@syzkaller.appspotmail.com
Tested-by: syzbot+d988dc155e740d76a331@syzkaller.appspotmail.com

Tested on:

commit:         f5436aa3 erofs: fix interlaced plain identification fo..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=16a8a394580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d91443204e48b7a1
dashboard link: https://syzkaller.appspot.com/bug?extid=d988dc155e740d76a331
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

