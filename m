Return-Path: <linux-erofs+bounces-2256-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CH/KHrngmlTegMAu9opvQ
	(envelope-from <linux-erofs+bounces-2256-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Feb 2026 07:30:18 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8255DE2566
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Feb 2026 07:30:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5VpG6qmYz2xHt;
	Wed, 04 Feb 2026 17:30:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770186614;
	cv=none; b=jrBjL/h64c+aHcgYHfJTVoBMs1Wei7yY8Hk1qZHpmnnil/a9CbyX+r+B7dgS+s+VWeV9YYO0n4y4aHnTKbsnxekvbFJ5/0FlJO7uWWJa5ax7EX15FuH68bnbCRa4cVOtAerwyB0r6zOetttANFLr8TVYGQDUY9IueKna/az+Gg4m7P/XRx0/15i+KNpbK03K4cEOkOi9nsdXFSo+om3BY+5/OzSW/+6d601P23ZtOAHIfGaeZW0qAy4xSLRfdUptY767CT5Y10/9YzD5S0d1ODAM67gPHD/pcsZtvFb7szPL2xxw3Ds8bWve8gQFeItPJtCaICQgYN9Uv1gKo3whCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770186614; c=relaxed/relaxed;
	bh=u+VEHwJhYQVh4xmStloZYm3eNm0jt4lgYnvgLH1s9U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X96JC+75XAIZ/GoPJ0mSUWWgT+Jq06AtxkCVDdAMQ1MpzBdscSzR1uUfUuJSLJQGfPL5l2eAsDFnCLnIbNFqLSAefLyhgoujIZOuvzHTXJTbKqTxcyc5WOdxpg1NoI3ti88PMTUFUjm/Gt0Za0eM2lAT1RLqVr5kMUIGouxxlXzfyp9sWEXgpZyiVEM5fmas/PzDhBcNWq9p5YeK6LtkTZeAcroQVXWzRSnquGI1ToIF9GKBjFK50nvrdONah8hKz1wpwsJu9HoR8yWG4zUPS1H1iStKMH4Ml99a6xS7pEaFu45DmRIJHbudTxPHnKTN5aDR5bHHvhhZy+zpSSY8lQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OnnYQCQ/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OnnYQCQ/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5VpB5kmyz2xBV
	for <linux-erofs@lists.ozlabs.org>; Wed, 04 Feb 2026 17:30:08 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770186599; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=u+VEHwJhYQVh4xmStloZYm3eNm0jt4lgYnvgLH1s9U0=;
	b=OnnYQCQ/kSpFmlCIPOVFMQmkk6hF9HE1APbm1/khDrhBIRtBC2QH2ShqYuESgaulnsIlgGY6p2mC+xRF4Jih/XgIMILguKSkW4lHiO8JB4GDACeqbN5Rtd8uk0Vn5QjqH/OhmNi7lpKn2/C0mUXCGC4jW9IyAa0HbIXRky4M5EA=
Received: from localhost.localdomain(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WyVl5QG_1770186593 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Feb 2026 14:29:57 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Daniel Colascione <dancol@dancol.org>
Subject: [PATCH] erofs-utils: mkfs: avoid hanging if fragment is on and tmpdir is full
Date: Wed,  4 Feb 2026 14:29:48 +0800
Message-ID: <20260204062948.12525-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2256-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 8255DE2566
X-Rspamd-Action: no action

The main thread should respond to errors from the child process
instead of waiting indefinitely.

Reported-by: Daniel Colascione <dancol@dancol.org>
Closes: https://github.com/erofs/erofs-utils/issues/34
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 14 +++++++++++---
 lib/inode.c    |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 58d1f4d..222e380 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1338,8 +1338,11 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 
 	if (inode->fragment_size) {
 		ret = erofs_fragment_commit(inode, ictx->tofh);
-		if (ret)
+		if (ret) {
+			erofs_err("failed to commit fragment for %s: %s",
+				  inode->i_srcpath, erofs_strerror(ret));
 			goto err_free_idata;
+		}
 		inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 		erofs_sb_set_fragments(sbi);
 	}
@@ -1822,8 +1825,13 @@ void *erofs_prepare_compressed_file(struct erofs_importer *im,
 	if (!z_erofs_mt_enabled || all_fragments) {
 #ifdef EROFS_MT_ENABLED
 		pthread_mutex_lock(&g_ictx.mutex);
-		if (g_ictx.seg_num)
+		while (g_ictx.seg_num) {
+			if (g_ictx.seg_num == INT_MAX) {
+				pthread_mutex_unlock(&g_ictx.mutex);
+				return ERR_PTR(-ECHILD);
+			}
 			pthread_cond_wait(&g_ictx.cond, &g_ictx.mutex);
+		}
 		g_ictx.seg_num = 1;
 		pthread_mutex_unlock(&g_ictx.mutex);
 #endif
@@ -1974,7 +1982,7 @@ err_free_idata:
 out:
 #ifdef EROFS_MT_ENABLED
 	pthread_mutex_lock(&ictx->mutex);
-	ictx->seg_num = 0;
+	ictx->seg_num = ret < 0 ? INT_MAX : 0;
 	pthread_cond_signal(&ictx->cond);
 	pthread_mutex_unlock(&ictx->mutex);
 #endif
diff --git a/lib/inode.c b/lib/inode.c
index 7d20fbd..79e5d3b 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -786,6 +786,7 @@ int erofs_iflush(struct erofs_inode *inode)
 	bool nlink_1 = true;
 	int ret, fmt;
 
+	DBG_BUGON(inode->nid == EROFS_NID_UNALLOCATED);
 	DBG_BUGON(bh && erofs_btell(bh, false) != off);
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 	    S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
-- 
2.43.0


