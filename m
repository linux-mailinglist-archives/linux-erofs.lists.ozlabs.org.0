Return-Path: <linux-erofs+bounces-144-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FACA7C95C
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Apr 2025 15:39:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZVGmp5gl1z2yGY;
	Sun,  6 Apr 2025 00:39:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743860394;
	cv=none; b=E1O1E5Hqpc3AEyGZw+P1Ic9fUAPE7Lb6UYu6aUFCVQsh3Pd5bbzxDEIobiFhMpMdDbtn2787VW65B6uQeUwr1z0IEMZcMeDRsxGU7rpQQmhlYcFsqsskX8z/2fpK0UCl2ZNNMxGsChNrLpUcUKT9nc8uJbS7QfscOalDdUZ36zub6+kPrDwQrvNYqDZ8LAnKra5YrA+UKMU1n/grxHE/ft8DsnLgDoCjSaK+Ct+ibc7UzBMZHCE8dUKKW/n+7fk+y4tO4SIkRd1OEasTZ2cam9cKFMe7AWUuLeARGA9VNT2UhtopsBaQEEGge8n+a+S4PQbWIMuPWPBwLqMfFGXm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743860394; c=relaxed/relaxed;
	bh=lREHCsv0mHK22l/DpMvzSGoMFcuU6VKe1VOxw4FZ9B8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Geh95iVDpRAghjWTKY89aKc/4mCFfbHt7Gj05po+bY1JY4ZBcIUY+DG4MopgbmUxRZ6LWrbRVqczl7HsgPkw2QqFiKIJZmoFOqAqzOVFay84ol2BKXkwvCkiKEV7c2WFEkpG9GmM7fGYdpTmmXmjkwpbZGFSmTWlKYG9cj3N6HZ8bCHkRnwNTxeh0RsFTjDQCTjXrRZNWmAWjHIjZu2fQwMwa7Ctpc2hXVkKb0tC6AvDSq/tNCdgo43foKjcJO3X2ib70+SUkYun4802HyLk1KPDNMUh5CePByrSdFgevugCM3Ba+seGi1TYd2PBvx1AVYPz/F1P+NeahdTzDhoUXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZkUJZYQJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZkUJZYQJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZVGml3gYQz2ySW
	for <linux-erofs@lists.ozlabs.org>; Sun,  6 Apr 2025 00:39:49 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743860385; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lREHCsv0mHK22l/DpMvzSGoMFcuU6VKe1VOxw4FZ9B8=;
	b=ZkUJZYQJjeA9NP8SSjcCm+3U1A1yvjmET91/21qrPk7Ih6ki3POWJz0QwA7lOCB/VndxxBI1D5OIv0G+yf0tQlw+AOuIYWUBUPm/gHzcREc5DXhGJjms4GCKciP+sg8OU9CEM9Ik/zkse8SOd3RlvlfZBPKOrTZ532syl7/87Hg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WVGxffq_1743860378 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 05 Apr 2025 21:39:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: allocate `struct erofs_inode` with zeroed memory
Date: Sat,  5 Apr 2025 21:39:36 +0800
Message-ID: <20250405133937.2665477-1-hsiangkao@linux.alibaba.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

The kernel implementation has the same constraint, so the code can
be shared.

Fixes: 9fd2a2250fa9 ("erofs-utils: fuse: switch to FUSE 2/3 lowlevel APIs")
Fixes: f44043561491 ("erofs-utils: introduce fsck.erofs")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fsck/main.c | 5 +----
 fuse/main.c | 6 +++---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 0e8b944..f7e33c0 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -974,12 +974,9 @@ verify:
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 {
 	int ret, i;
-	struct erofs_inode inode;
+	struct erofs_inode inode = {.sbi = &g_sbi, .nid = nid};
 
 	erofs_dbg("check inode: nid(%llu)", nid | 0ULL);
-
-	inode.nid = nid;
-	inode.sbi = &g_sbi;
 	ret = erofs_read_inode_from_disk(&inode);
 	if (ret) {
 		if (ret == -EIO)
diff --git a/fuse/main.c b/fuse/main.c
index cb2759e..db4f323 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -231,7 +231,7 @@ static void erofsfuse_open(fuse_req_t req, fuse_ino_t ino,
 		return;
 	}
 
-	vi = (struct erofs_inode *)malloc(sizeof(struct erofs_inode));
+	vi = calloc(1, sizeof(struct erofs_inode));
 	if (!vi) {
 		fuse_reply_err(req, ENOMEM);
 		return;
@@ -281,7 +281,7 @@ static void erofsfuse_opendir(fuse_req_t req, fuse_ino_t ino,
 	int ret;
 	struct erofs_inode *vi;
 
-	vi = (struct erofs_inode *)malloc(sizeof(struct erofs_inode));
+	vi = calloc(1, sizeof(struct erofs_inode));
 	if (!vi) {
 		fuse_reply_err(req, ENOMEM);
 		return;
@@ -324,7 +324,7 @@ static void erofsfuse_lookup(fuse_req_t req, fuse_ino_t parent,
 	struct fuse_entry_param fentry = { 0 };
 	struct erofsfuse_lookupdir_context ctx = { 0 };
 
-	vi = (struct erofs_inode *)malloc(sizeof(struct erofs_inode));
+	vi = calloc(1, sizeof(struct erofs_inode));
 	if (!vi) {
 		fuse_reply_err(req, ENOMEM);
 		return;
-- 
2.43.5


