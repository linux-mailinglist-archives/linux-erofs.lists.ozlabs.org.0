Return-Path: <linux-erofs+bounces-3596-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id noWTDAXlMGq8YQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3596-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 07:54:13 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AD068C474
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 07:54:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b="Dj34RyP/";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3596-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3596-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfblj05t6z2yFc;
	Tue, 16 Jun 2026 15:54:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781589248;
	cv=none; b=Uvf2fKBpD4jlUF5/qwhmwE3GyFeYqNI9reibiCPcWOhkSd9QlZdIYfpLKeapMhEepfNMd7UnLZ4yQ2mB9URuXsTUsq9sj06N31cf9MHu+8WIujLx2zwBf/JuPRPFKJeVcmr5I6L8ulWNZLk2LEVsGg3iEKfWAqepdriyJVUYdAGwJ5zb6Z6c/wBTHcFwL+maUsVIhjRfJOXHKWm35nwPvE9hEhiwS98IdG8wW5QKUi2n6vz7I/j2n16jeLEaKjMs1BkyimpKkVSXHMWLlJXsTk2t/ax9n+Er4L9emek+tZlRRtnDkt2SekeLjSsQNE6bvtShqA9k09lbIHsrsbL8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781589248; c=relaxed/relaxed;
	bh=I1tdsUfjjvNiGRL2idkcPjO8nSKKjD1GhdePucVn5Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtCcPUsBLYZAA/RsAUj0rkOXXw9PVpRXVG85puUjCEdf+yZiM4cBzYRSvcImTpNAM5CXYAbq7X8++JbjAEbpBbknV+GQCXLfPgDlG+6kEIxLhUiBzJUNb5kNkzUodoa1VSGwIZSM9eWn9QUO9LrwGoRdJ/VSXJAnDWC+Q9XPiv56TKudA03ZfYVhOyzcGGsCeqvObkzmjmXiA5p7QCyAdpkkPH8ccUmvWlr0qQ2rMcUQkKoQioKMeSM03zXnoocXSbcrD3l/40+sLwZM0ib8GvG52SGhO4ddKmlfI1RYnQ702aPHD+Y+hF7FWLvkNjMdxQHmQLleIW2i1TMGVzBwfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Dj34RyP/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfblf1hwXz2xd2
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jun 2026 15:54:04 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781589240; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=I1tdsUfjjvNiGRL2idkcPjO8nSKKjD1GhdePucVn5Mw=;
	b=Dj34RyP/j94FmAsAN8T85HaGZai6dAioUuNlEnyLQAmlKJ6ljaOqINAsZY8g7UkRojEWHnR884+HaacsqCn1xpZVtO7Tvi101DZ9la8l3bdLCSsoA5YZvjIyrV1aZGY/lKN42xGn+9Tg1nWQ9Lkv6Z7GPhhkH6BYi462FMhUb1o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X5-EbMP_1781589234;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5-EbMP_1781589234 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 16 Jun 2026 13:53:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Tristan <TristanInSec@gmail.com>
Subject: [PATCH v2 1/3] erofs-utils: fsck: fix unsigned integer overflow in symlink extraction
Date: Tue, 16 Jun 2026 13:53:53 +0800
Message-ID: <20260616055353.2007932-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260615084011.325686-1-hsiangkao@linux.alibaba.com>
References: <20260615084011.325686-1-hsiangkao@linux.alibaba.com>
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
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3596-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88AD068C474

erofs_extract_symlink() allocates a buffer using malloc(i_size + 1)
where i_size is a 64-bit value read directly from the on-disk inode
with no upper bound validation. When i_size equals UINT64_MAX, the
addition wraps to zero, and malloc(0) returns a minimal allocation.
The subsequent erofs_pread() writes i_size bytes into this tiny
buffer.

Reported-by: Tristan <TristanInSec@gmail.com>
Closes: https://lore.kernel.org/r/CAA1XrhPMekMqAnRkC-jV9rTsO4LHjzh=kxn6zQKMgBrqfrnp8A@mail.gmail.com/5-symlink-integer-overflow.txt
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20260615084011.325686-1-hsiangkao@linux.alibaba.com
---
 fsck/main.c          | 5 +++--
 include/erofs/defs.h | 9 +++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 21ada195edab..f7f1387fe642 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -784,6 +784,7 @@ static inline int erofs_extract_symlink(struct erofs_inode *inode)
 {
 	struct erofs_vfile vf;
 	bool tryagain = true;
+	erofs_off_t bufsz;
 	int ret;
 	char *buf = NULL;
 
@@ -794,8 +795,8 @@ static inline int erofs_extract_symlink(struct erofs_inode *inode)
 	if (ret)
 		return ret;
 
-	buf = malloc(inode->i_size + 1);
-	if (!buf) {
+	if (check_add_overflow(inode->i_size, (erofs_off_t)1, &bufsz) ||
+	    !(buf = malloc(bufsz))) {
 		ret = -ENOMEM;
 		goto out;
 	}
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 8151b76ad0f5..fabd867d159c 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -392,6 +392,15 @@ unsigned long __roundup_pow_of_two(unsigned long n)
 #define __erofs_stringify_1(x...)	#x
 #define __erofs_stringify(x...)		__erofs_stringify_1(x)
 
+#define check_add_overflow(a, b, d) ({		\
+	typeof(a) __a = (a);			\
+	typeof(b) __b = (b);			\
+	typeof(d) __d = (d);			\
+	(void) (&__a == &__b);			\
+	(void) (&__a == __d);			\
+	__builtin_add_overflow(__a, __b, __d);	\
+})
+
 #define check_sub_overflow(a, b, d) ({		\
 	typeof(a) __a = (a);			\
 	typeof(b) __b = (b);			\
-- 
2.43.5


