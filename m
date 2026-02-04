Return-Path: <linux-erofs+bounces-2255-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JwkI5G2gmnwYgMAu9opvQ
	(envelope-from <linux-erofs+bounces-2255-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Feb 2026 04:01:37 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7CCE11AD
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Feb 2026 04:01:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5Q9T1kcNz30N8;
	Wed, 04 Feb 2026 14:01:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=47.90.199.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770174093;
	cv=none; b=hEIYAnNmsxV4aVvubbVqejeBXfAyIkXJyDB6bLse03BM56Wvh6s/6CLvL6kciRGvm9e9skeamkvTkd41RRDg+OKboNwczpOKDb6fI4ePRc/2VUE6R1KW7jCOdNRakmWMrQqu2XZsjdqKEhRM5NVAEsRfCe/yQ7uGkCUNSY8NhG8WjfsNfEUrCENLgx2dWqck/COT6Ti9R2KPoEi1TPCz9fbiLhn5UsmC5glEXzUOwW6yDnFd+QpUz7qBIIZ+gvGTCN1n2HCroDpU5XeSCgXMe3VhNccRGVMnHhRm5CTAIMoYcQ/bqfRoJcMb9eG3vu1wt5W89YObfvGJnCizx2ZuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770174093; c=relaxed/relaxed;
	bh=g4gqhKXmX8+bbLQefXd1YA7RkIu+2QAyp+JURZzTiU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8SWXsCUgnip+ZKi0noKOfcmk+ZWWKr8N8U68n9rrozZuRZhD4gB3/U1JVRI2TBTct4RuOSjHlmnKsKii1MeBuEeWg3JAksQGPdnixnvPxT9pXksnnOtNvkWJkjLxh2Gi5QdGjFKUGCQ9g2wYzPlxzcO/oGdP8lMxoSo9VuMPakyj33qiL8eL/PGwBMh4QLByJPgbiY3DdoCDXijW8/Q0Ped3lq25vpTbcLv5LDcXJnrPVl03p9i3t1t1TvCAMDispjDM6uhvFcYz68RBbyHxt0bgUq+1sQrYFHObEou86rF2aZf7DjuUsHZHYhUZN7Ye7v7sr5hutNKxCt/IE4gfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oVZL1E9R; dkim-atps=neutral; spf=pass (client-ip=47.90.199.15; helo=out199-15.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oVZL1E9R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.15; helo=out199-15.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5Q9Q212fz2xrk
	for <linux-erofs@lists.ozlabs.org>; Wed, 04 Feb 2026 14:01:28 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770174063; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=g4gqhKXmX8+bbLQefXd1YA7RkIu+2QAyp+JURZzTiU4=;
	b=oVZL1E9RehV28FWbLjG+Qj+2VuAygT8m8f2ML6W/PtOxCnBIFOT/3qqzrumPGQDnEoUm85D73j1XEuZK8zFMITCijVFKiL1WbhvWJAPSQV5OlJFNsqLRmWTK58g9ZtxOCl5XnAUE+eFtS/4w7fjlEAr8rmB/rXS4fhXwp2ZaWS4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WyUxfq1_1770174056 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Feb 2026 11:01:00 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: cache: pass abort semantics down to .flush()
Date: Wed,  4 Feb 2026 11:00:55 +0800
Message-ID: <20260204030055.2374937-1-hsiangkao@linux.alibaba.com>
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
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2255-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: CB7CCE11AD
X-Rspamd-Action: no action

This allows flushers to skip actual writes directly.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/cache.c          | 13 +++++++------
 lib/inode.c          | 32 +++++++++++++++++++-------------
 lib/liberofs_cache.h |  2 +-
 3 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/lib/cache.c b/lib/cache.c
index f23dbb06264a..4c7c3863275b 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -10,7 +10,8 @@
 #include "erofs/print.h"
 #include "liberofs_cache.h"
 
-static int erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
+static int erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh,
+					bool abort)
 {
 	return erofs_bh_flush_generic_end(bh);
 }
@@ -19,7 +20,7 @@ const struct erofs_bhops erofs_drop_directly_bhops = {
 	.flush = erofs_bh_flush_drop_directly,
 };
 
-static int erofs_bh_flush_skip_write(struct erofs_buffer_head *bh)
+static int erofs_bh_flush_skip_write(struct erofs_buffer_head *bh, bool abort)
 {
 	return -EBUSY;
 }
@@ -449,7 +450,7 @@ static void erofs_bfree(struct erofs_buffer_block *bb)
 }
 
 static int __erofs_bflush(struct erofs_bufmgr *bmgr,
-			  struct erofs_buffer_block *bb, bool forget)
+			  struct erofs_buffer_block *bb, bool abort)
 {
 	struct erofs_sb_info *sbi = bmgr->sbi;
 	const unsigned int blksiz = erofs_blksiz(sbi);
@@ -470,7 +471,7 @@ static int __erofs_bflush(struct erofs_bufmgr *bmgr,
 
 		list_for_each_entry_safe(bh, nbh, &p->buffers.list, list) {
 			if (bh->op == &erofs_skip_write_bhops) {
-				if (!forget) {
+				if (!abort) {
 					skip = true;
 					continue;
 				}
@@ -478,8 +479,8 @@ static int __erofs_bflush(struct erofs_bufmgr *bmgr,
 			}
 
 			/* flush and remove bh */
-			ret = bh->op->flush(bh);
-			if (__erofs_unlikely(ret == -EBUSY && !forget)) {
+			ret = bh->op->flush(bh, abort);
+			if (__erofs_unlikely(ret == -EBUSY && !abort)) {
 				skip = true;
 				continue;
 			}
diff --git a/lib/inode.c b/lib/inode.c
index e3ee79a04a04..7d20fbdda6e6 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -897,20 +897,23 @@ int erofs_iflush(struct erofs_inode *inode)
 		if (ret != inode->extent_isize)
 			return ret < 0 ? ret : -EIO;
 	}
-	if (bh) {
-		inode->bh = NULL;
-		erofs_iput(inode);
-		return erofs_bh_flush_generic_end(bh);
-	}
 	return 0;
 }
 
-static int erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
+static int erofs_bh_flush_write_inode(struct erofs_buffer_head *bh, bool abort)
 {
 	struct erofs_inode *inode = bh->fsprivate;
+	int ret;
 
 	DBG_BUGON(inode->bh != bh);
-	return erofs_iflush(inode);
+	if (!abort) {
+		ret = erofs_iflush(inode);
+		if (ret)
+			return ret;
+	}
+	inode->bh = NULL;
+	erofs_iput(inode);
+	return erofs_bh_flush_generic_end(bh);
 }
 
 static struct erofs_bhops erofs_write_inode_bhops = {
@@ -1050,7 +1053,7 @@ noinline:
 	return 0;
 }
 
-static int erofs_bh_flush_write_inline(struct erofs_buffer_head *bh)
+static int erofs_bh_flush_write_inline(struct erofs_buffer_head *bh, bool abort)
 {
 	struct erofs_inode *const inode = bh->fsprivate;
 	struct erofs_sb_info *sbi = inode->sbi;
@@ -1059,11 +1062,14 @@ static int erofs_bh_flush_write_inline(struct erofs_buffer_head *bh)
 	const erofs_off_t off = erofs_btell(bh, false);
 	int ret;
 
-	ret = erofs_io_pwrite(ibmgr->vf, inode->idata, off, inode->idata_size);
-	if (ret < 0)
-		return ret;
-	if (ret != inode->idata_size)
-		return -EIO;
+	if (!abort) {
+		ret = erofs_io_pwrite(ibmgr->vf, inode->idata, off,
+				      inode->idata_size);
+		if (ret < 0)
+			return ret;
+		if (ret != inode->idata_size)
+			return -EIO;
+	}
 	free(inode->idata);
 	inode->idata = NULL;
 
diff --git a/lib/liberofs_cache.h b/lib/liberofs_cache.h
index 215b320da0fd..baac609fb49f 100644
--- a/lib/liberofs_cache.h
+++ b/lib/liberofs_cache.h
@@ -30,7 +30,7 @@ struct erofs_buffer_block;
 #define DEVT		5
 
 struct erofs_bhops {
-	int (*flush)(struct erofs_buffer_head *bh);
+	int (*flush)(struct erofs_buffer_head *bh, bool abort);
 };
 
 struct erofs_buffer_head {
-- 
2.43.5


