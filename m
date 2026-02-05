Return-Path: <linux-erofs+bounces-2259-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M1NMzX6g2nwwQMAu9opvQ
	(envelope-from <linux-erofs+bounces-2259-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Feb 2026 03:02:29 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F6BEDD22
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Feb 2026 03:02:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f60pk6qY7z2xrk;
	Thu, 05 Feb 2026 13:02:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770256942;
	cv=none; b=Rhdc/n3fQru/WW3EsDMjPuJiqSYgAZShteulgT7dzELLFHieLy5iXVle96c/IZbfdDnftePs0SKl02IMzsvrbiRhB5T516P7WvWSOIUlsklD3yCPxyMEseUe/f+pfhjBF0iYz9p8i2PkekcL2tTMKCP9uxtefJV5NPoQtuN2i6nrX7pES3blgt8TuI1XvqwrhoiToLORCmFmL4m4MIwgdqgLIfK9dF5AAnt1mLMIyqbOJkBB2SRexKEWBFRBZrkUgXyKEV5AZQYT+JI62svvCCWWLVHNm2PDlBp31b8MQKR6i9agUF66dRq5CdLbHCiA8hyr7O0398NLaZ7S5z3FJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770256942; c=relaxed/relaxed;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EfSZtDGTTgK4MzNTRCVyB8yxu5OndNG2XQGS8KxJVPq5E1REv12NHOzTLueKFSokEGJgXUsenMwA1xCwoMssE8PDcN1GAvw90EQNG7YIbLLI1ORVVSuXcEw0BlALCYA7kn0Xa1qrQ4q2dQgLW0k2xLuUj/PlTvyo0wyREZprj9Ph9b0Ib9GrcmJyASpY/Nuyqz4RFn1TLZx7emFHG6h9GtZ3qYesAl5xmLNi9uk8Gi/LOEnK+5bzMpJ7ZnxONQQeVxByxagPT2h0m3dlPKVNj1/j5n3CYsPIagIyUquc3pD4N1IDkn99uq/+jJOmnctgp0Ewxer3t4vTFBZPksNvmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NRYRTvR9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NRYRTvR9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f60pg73DXz2xHt
	for <linux-erofs@lists.ozlabs.org>; Thu, 05 Feb 2026 13:02:17 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770256932; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	b=NRYRTvR949uT3M1XsNcdzNDojWfI86Lw8U+HxRXmIUjbMzeLOnc+QRASGbIlp3LcV9fAc8FlrY/QP52eIkTi2fY1ju3C6TXpdgJxxlnmkW4kI7F/dhLkz551Y+cvcMeM8e8Pp1LcUmme2+rfQDyYDG+cXOuV3yr8r3lJVKsOLt0=
Received: from 30.221.130.135(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WyZ2z75_1770256929 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Feb 2026 10:02:10 +0800
Message-ID: <a2f8472e-99c9-4f51-b105-76df6fb4078e@linux.alibaba.com>
Date: Thu, 5 Feb 2026 10:02:09 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] WARNING in erofs_iget (2)
To: syzbot <syzbot+c2dd47dc153320cc4692@syzkaller.appspotmail.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <6980e768.050a0220.16b13.00a7.GAE@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <6980e768.050a0220.16b13.00a7.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2259-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:syzbot+c2dd47dc153320cc4692@syzkaller.appspotmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs,c2dd47dc153320cc4692];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 50F6BEDD22
X-Rspamd-Action: no action

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test

