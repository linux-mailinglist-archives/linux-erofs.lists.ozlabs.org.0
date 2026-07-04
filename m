Return-Path: <linux-erofs+bounces-3816-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FVKsERpqSGoWqAAAu9opvQ
	(envelope-from <linux-erofs+bounces-3816-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 04 Jul 2026 04:04:10 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CAE70669E
	for <lists+linux-erofs@lfdr.de>; Sat, 04 Jul 2026 04:04:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b="rwr/xqNI";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3816-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3816-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsYnw6byqz2yRn;
	Sat, 04 Jul 2026 12:04:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783130644;
	cv=none; b=fkV5QpBfHfVYh2FKjZDaoTjrWWhS2YJ+b6vq8RfngW3i4IIFVhlQW+Nv/EvJRyUnWAfKcg0o0ZW+wljo0vX8oBVZsE/Z3Fk8konFunkHjza3p39zf308tVipmlmUghmFKdSGq4hriBkdgJ5EbTXTxisDo0fEgREGE6IZX+1b+l0PCdXDmy8iP9++Uqkjd9u9cr8lPxHkcg+ZM1LVJOfd1VAOggHhGUbrEZcT7gVoBhPsBRv7SXJDN4BeAxHc6yvF/TMwkkF3i8MfGNnmQaHQlVnK+qPbWUiHwjHyXTBuJWJjeZ8y+4TWJucufbGwJDfGfQofnPZMq9XUVOdDEcu5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783130644; c=relaxed/relaxed;
	bh=H6KxvWy2ZhEWFgK9TQYV1SjxegR9TblZ1kM7edHDKv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LyVyppcw79ij6hNrkKoygxC8ANw1+PtYKzstZgvhdlpzL0vMCNRSTNr1rn3z9rxp9Bi48NBMVEqWrLCW1W+W8270l5/gcqVPHME4ft1Z8JHbR+stH5WduWJIWIqDdVCfwWRbHA9eIn9GoOUg4j1PzYSosCmxIikOpxkD+LasgNQxVHi/EYHUmuhn/xtwMaokPknHa9SX+TCwtRmt1MSmKR9cq6wTO1EfIcB9VhhOLYX51BUgWj6XhZLSP2gwx3g8CJmOI1XAnEzuRolwXTcWJT0ksOEP1zA5YJmTy2/b97utn5N3oIlzf7zbUy/kaSjZJJmBUufey6FY0nIdYPX4oQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rwr/xqNI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsYnt4wNfz2xfB
	for <linux-erofs@lists.ozlabs.org>; Sat, 04 Jul 2026 12:04:00 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783130635; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=H6KxvWy2ZhEWFgK9TQYV1SjxegR9TblZ1kM7edHDKv4=;
	b=rwr/xqNIisKrT86hsYvcYFBcSXNx3m0wt5SYqya1CDoQHdaCye5xJIKYRwWua3tD+kahfTvxG0TT+QKO7VO3NnE/ApFNitA7iMAnSZ3kgFM6m2UjiqmJyF+5ECF9V1m/lmJpHNtK/APv1sXmgo1fZW+NbiyR5o8Vvbh/Lxm5UHI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X6KPazU_1783130627;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X6KPazU_1783130627 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 04 Jul 2026 10:03:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: fix 'warn_unused_result'
Date: Sat,  4 Jul 2026 10:03:47 +0800
Message-ID: <20260704020347.3119610-1-hsiangkao@linux.alibaba.com>
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
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3816-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93CAE70669E

backends/ublk.c: In function 'ublk_queue_thread':
backends/ublk.c:758:23: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
  758 |                 (void)write(q->dev->stop_efd, &val, sizeof(val));
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

main.c: In function 'erofsmount_fanotify_child':
main.c:2043:9: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
 2043 |         write(pipefd, &err, sizeof(err));
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/backends/ublk.c | 5 ++++-
 mount/main.c        | 6 ++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/backends/ublk.c b/lib/backends/ublk.c
index 090c6d5bd1e8..b63d121e54ac 100644
--- a/lib/backends/ublk.c
+++ b/lib/backends/ublk.c
@@ -755,7 +755,10 @@ static void *ublk_queue_thread(void *arg)
 	if (q->dev->stop_efd >= 0) {
 		uint64_t val = 1;
 
-		(void)write(q->dev->stop_efd, &val, sizeof(val));
+		ret = write(q->dev->stop_efd, &val, sizeof(val));
+		if (ret < 0)
+			erofs_err("failed to write stop event for queue %d: %s",
+				  q->q_id, strerror(errno));
 	}
 	return NULL;
 }
diff --git a/mount/main.c b/mount/main.c
index ec27dcb53eb3..347a71b8a41c 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -2026,7 +2026,7 @@ static void erofsmount_fanotify_ctx_cleanup(struct erofs_fanotify_ctx *ctx)
 static int erofsmount_fanotify_child(struct erofs_fanotify_ctx *ctx,
 				     int pipefd)
 {
-	int err;
+	int err, err2;
 
 	ctx->fan_fd = erofs_fanotify_init_precontent();
 	if (ctx->fan_fd < 0) {
@@ -2040,7 +2040,9 @@ static int erofsmount_fanotify_child(struct erofs_fanotify_ctx *ctx,
 
 	err = 0;
 notify:
-	write(pipefd, &err, sizeof(err));
+	err2 = write(pipefd, &err, sizeof(err));
+	if (err2 < 0)
+		erofs_err("failed to notify parent: %s", strerror(errno));
 	close(pipefd);
 
 	if (err)
-- 
2.43.5


