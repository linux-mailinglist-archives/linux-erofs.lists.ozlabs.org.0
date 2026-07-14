Return-Path: <linux-erofs+bounces-3892-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NKpqK3XPVWogtwAAu9opvQ
	(envelope-from <linux-erofs+bounces-3892-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jul 2026 07:56:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD96751457
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jul 2026 07:56:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=d2pV2EXi;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3892-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3892-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzpSw0qpxz2y71;
	Tue, 14 Jul 2026 15:56:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784008560;
	cv=none; b=n/SSeLxPtLoWatGNb/Bgi4JquNSeGZIu9wjJu4HCK9dt90+pJF7e928KvSyv+yP7r8t0/jVkedMRDlNJnRhc0r3oF+YGS8ycl70ybxJxB0V9iPKoBzDm4rr+4ifk9Vd5HshfcbUQf1bR/XZ+8zqh38TLHy0WE0v12X5mISkbeORkCS2MHH9AGx2vKqe6xtyzLjaf2GY2+gc8k5Z7DebqtaUxsqfeTNiydjG7NJcg8WcMKUXVateGaN0oVROMUMHpL3th2EcZYPAZldyMQz+GcWPVNEBmeaWJb00KYSwsiUJNL7qqmoKtiRbjiz0JyIFgZeVIDRmj9Dhwy+5ImuknIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784008560; c=relaxed/relaxed;
	bh=mHn6JG6x/AJt0TgwaMB9zfWK9GHqrvRmWx19wvuNMGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXQtlgNB575fH3N8JgtK7+Mgdv4yEwWs+MCetMvEvhRIpQddhGwh1FpcKrpe1JOkzV1ynz53CbiEmWYz+dNpvrqmz/x99orGxvbvZWnTMGNQXRyicnQrN773p87NeFkDIMu7aAN/jVM/akUSMxHSjxiGjyuL8brf1/4HYa6PQ2Mi11ZIhW1yHD/7SH6u3LwaU+g8Ij2i6XmZxcTODtgmhbU+hsWg+SHtypo5eYMkJHPCBcSeYAWLOPZhPexJRTfB3hvsik/PqAh3Ap0kRKVzc4YoPcgfSa3fRv3Ya4wDV8hkP9YUDHGRy1lH8Bngu20kU32LT2sx0q763q29l04ecQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d2pV2EXi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzpSs3YZnz2xPb
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Jul 2026 15:55:56 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784008551; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mHn6JG6x/AJt0TgwaMB9zfWK9GHqrvRmWx19wvuNMGU=;
	b=d2pV2EXi+FWG82rDNjU38ZnuqlPKqrBD4uM4AKYZA1zla1KWr6+danGEGmFWWmaoltIKeCeueZZcP0fbYjMVcpaIq+YiDwfi2ImDvwM48mSly+B8xwT9S1sH/m/jwCSMgKzgS72ddDBwfR5FK5b7W0mc6CCatLHoMkSGDqxsbhg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X731r9r_1784008545;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X731r9r_1784008545 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jul 2026 13:55:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: fix undeclared gettid()
Date: Tue, 14 Jul 2026 13:55:44 +0800
Message-ID: <20260714055544.742154-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3892-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid,configure.ac:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AD96751457

gettid() is only available since glibc 2.30.

Fixes: 799c933bbefb ("erofs-utils: add ublk userspace block device backend")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac        | 1 +
 lib/backends/ublk.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/configure.ac b/configure.ac
index ddee374b6e85..25a48922c1dc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -284,6 +284,7 @@ AC_CHECK_FUNCS(m4_flatten([
 	fallocate
 	getrandom
 	getrlimit
+	gettid
 	gettimeofday
 	lgetxattr
 	llistxattr
diff --git a/lib/backends/ublk.c b/lib/backends/ublk.c
index b63d121e54ac..d2c5e1968014 100644
--- a/lib/backends/ublk.c
+++ b/lib/backends/ublk.c
@@ -29,6 +29,11 @@
 #include <liburing.h>
 #endif
 
+#ifndef HAVE_GETTID
+#include <sys/syscall.h>
+#define gettid() syscall(__NR_gettid)
+#endif
+
 /* (Legacy) Admin commands, issued by ublk server, and handled by ublk driver */
 #define UBLK_CMD_GET_QUEUE_AFFINITY	0x01
 #define UBLK_CMD_GET_DEV_INFO		0x02
-- 
2.43.5


