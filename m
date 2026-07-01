Return-Path: <linux-erofs+bounces-3796-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y8HHOFvVRGqY1goAu9opvQ
	(envelope-from <linux-erofs+bounces-3796-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Jul 2026 10:52:43 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1D56EB4EC
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Jul 2026 10:52:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=Bc4JHVRu;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3796-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3796-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqv0m5lShz2xwM;
	Wed, 01 Jul 2026 18:52:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895960;
	cv=none; b=LwKNkpINflM+OVY8iCGPVoaH3R3SryUjEX4XC54TSLNRHfwwsdyX9fg1XJXXv0rfg0WUqnphVbsssv+Y2HrvkhH2aN4U23eHtKRQhnCZH9vvIVymzJIH4x6hCyJgHELSiZl/LyGAp1nVwg9S9hzL3Xmvd+aqzNg8FfRo79Qkk8xIjf1tuONA4n9RuyomvYF6dbsI1WOG/IEVdt2DCHTzFTDt9NZvGmcLV1LRXH2S4yNMwZs/uo2dA6Eo48fzIfe0cA1E3MTuzsQPoZ+PEw2j1vEfCOFUd79DVM/XMwNeuyn6GRhxLOohvDW7c/+3gsyZbkhNUwjlCY+fa3FXTa2Fgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895960; c=relaxed/relaxed;
	bh=/EMA7D9lq6e/2CXNyjM/RTApov9kVqZUZumoMvXXyjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vx3V4WVk33QVk/UJ5Bm0ZEj572Qdg4lmnLPLN+JlrijS/s6Dzmp5kF3+OQvid1NS5CpB/p64l1URUXCcJGh2OThTEMH1vP3r8TjhVJzCmiQjqgfqqx3Xugln4Lg2dceSYd9cDT5UQ6WopynRVIlefASCwr2cFwvXqaZdNL04i7ajNjDg/jmbMmFh+t7vg8+52SQSpS3aIf/ceaALv2OkWOXacnNS89bYcSAZ32SRJyzOxKsBH6xSc6JN63Z5gWQbvW0c8MpJjy8XFeOqDCCrhAq0sO8yyKQyLPrzOHgVqSjLLB09o2oFnz9DWRjavS9iiXzUtrkfz1xUHszx7qf+DQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Bc4JHVRu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqv0k3z7mz2xPb
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Jul 2026 18:52:37 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782895953; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/EMA7D9lq6e/2CXNyjM/RTApov9kVqZUZumoMvXXyjY=;
	b=Bc4JHVRuqt7lN7oyGz1cBGGSY+1MTKO5E9cranvITxvrgc85+VUpe700bc1HVBxjSTisi3hGqr3ZJ7hMwaEMgHq0t3XfYJAfhF8x4ys4ol9eKwcM6+CBKEXgVBz4fbKRFWitp4z4LigJz72XkAOpnxSwm1d6GrLXdNmX+glOEMc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X66AdQO_1782895948;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X66AdQO_1782895948 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 01 Jul 2026 16:52:31 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mkfs: set the default inode fingerprint name
Date: Wed,  1 Jul 2026 16:52:26 +0800
Message-ID: <20260701085226.2390667-1-hsiangkao@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3796-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF1D56EB4EC

Set `erofs.fingerprint.v1` as the default xattr digest name for
inodes so that these xattrs are invisible to users.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mkfs/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 4fadb56c7a5c..33c410d71411 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -34,6 +34,8 @@
 #include "../lib/liberofs_s3.h"
 #include "../lib/liberofs_uuid.h"
 
+#define EROFS_EA_INODE_DIGEST_DEFAULT "erofs.fingerprint.v1"
+
 static struct option long_options[] = {
 	{"version", no_argument, 0, 'V'},
 	{"help", no_argument, 0, 'h'},
@@ -102,7 +104,7 @@ static struct option long_options[] = {
 	{"zD", optional_argument, NULL, 536},
 	{"MZ", optional_argument, NULL, 537},
 	{"xattr-prefix", required_argument, NULL, 538},
-	{"xattr-inode-digest", required_argument, NULL, 539},
+	{"xattr-inode-digest", optional_argument, NULL, 539},
 	{0, 0, 0, 0},
 };
 
@@ -256,7 +258,7 @@ static void usage(int argc, char **argv)
 #ifdef EROFS_MT_ENABLED
 		" --workers=#            set the number of worker threads to # (default: %u)\n"
 #endif
-		" --xattr-inode-digest=X specify extended attribute name X to record inode digests\n"
+		" --xattr-inode-digest=X specify extended attribute name X (\"" EROFS_EA_INODE_DIGEST_DEFAULT "\" if omitted) to record inode digests\n"
 		" --xattr-prefix=X       X=extra xattr name prefix\n"
 		" --zfeature-bits=#      toggle filesystem compression features according to given bits #\n"
 #ifdef WITH_ANDROID
@@ -1483,6 +1485,8 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 			cfg.c_extra_ea_name_prefixes = true;
 			break;
 		case 539:
+			if (!optarg)
+				optarg = EROFS_EA_INODE_DIGEST_DEFAULT;
 			err = erofs_xattr_set_ishare_prefix(&g_sbi, optarg);
 			if (err < 0) {
 				erofs_err("failed to parse ishare name: %s",
-- 
2.43.5


