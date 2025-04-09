Return-Path: <linux-erofs+bounces-177-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5082BA82C7C
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Apr 2025 18:33:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZXpR5326wz30VZ;
	Thu, 10 Apr 2025 02:33:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744216401;
	cv=none; b=Fi5apPp6rigsxgLoX9uOksBk8BiXaihaml8erBJ89Pxnwqh51abWlDhHyP6cyydVUzccpdFozTo5RxQgorBNULUnYizM8w3Gqoy93osp6cY53yKdPHdWz9KpOKUFh8lzI/Grk1VE/Kg2kLIWe2ycYp4aNQYvwDQdXKov2nXuyxQRg0uXgKHXdovVeC/cKCj9tz+llTJG4wrj1sGWD9u63FSQnyeGE23+VRecJTnENdzBKYPJoKblMZYTTYog3m4nOrphHeLT2E0pXsRvwnSs7CoDjGRmHJYQt7m3W3zKZqBx+9i856FNVe/VL2qs46g47EAdsbkXUXzzz6aEoKsRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744216401; c=relaxed/relaxed;
	bh=mWAnMiLloL/KJKZ/sarxxeeIRfhGJfQpMkqbjn3Pa/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJQOm4M45VojJtcEQzYcdrXKvkRp8OMEAw9B5oth3Ink+4d3pxI7KskvnevQVSS0H4jVjxsgqpcSuwAU2bl0E0uY9oW3ap0pQGMlD/2zNNgU/MDkJJQoITLcqOoxPTnDFr6ErqoeE6GcyZ104zM0widYQ0zCXl+wNkGE/iPTvHvuUTSFrzVdMhFC9If4Z4EkMa2tPOK9CW6Pe1PmHO+L/uaRTRTJwnE47EE0bTQinvk568MoM9R3eMhQQUX+h6uO4fuv5hpmE68NUNuUZbjJlizU1BD0nrt8/FGBO4JTTWwX6HUQ+2onfXMr68Bh0Y8VHpDUC6PbpD5fgUpB2S1jVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FloRszcm; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FloRszcm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZXpR247sXz30Vj
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Apr 2025 02:33:18 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744216389; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mWAnMiLloL/KJKZ/sarxxeeIRfhGJfQpMkqbjn3Pa/g=;
	b=FloRszcmLTZ1S8qSNYyCqXbYb0immifNAEASDAGYZpOsDrx8wgWPgFLnTdg9wHWZvdXQPi7AgHeE38ipKAR1TWxvgitkOpp7yfij5kTuW9LDWRYfRJQ+AdOPvMNRX4Ur4LEt50tapND1O4yHZ1ZPMnJFZMltRntcQ9RlJ7D1W+c=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WWKsZTe_1744216387 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Apr 2025 00:33:08 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 04/10] erofs-utils: get rid of NULL_ADDR{,_UL}
Date: Thu, 10 Apr 2025 00:32:53 +0800
Message-ID: <20250409163259.2077865-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250409163259.2077865-1-hsiangkao@linux.alibaba.com>
References: <20250409163259.2077865-1-hsiangkao@linux.alibaba.com>
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

.. And replace them with EROFS_NULL_ADDR.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/cache.h    |  4 ++--
 include/erofs/internal.h |  3 ---
 lib/cache.c              | 24 ++++++++++++------------
 lib/inode.c              |  2 +-
 lib/rebuild.c            |  2 +-
 5 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 87d743a..0c665e8 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -107,8 +107,8 @@ static inline erofs_off_t erofs_btell(struct erofs_buffer_head *bh, bool end)
 	struct erofs_bufmgr *bmgr =
 			(struct erofs_bufmgr *)bb->buffers.fsprivate;
 
-	if (bb->blkaddr == NULL_ADDR)
-		return NULL_ADDR_UL;
+	if (bb->blkaddr == EROFS_NULL_ADDR)
+		return EROFS_NULL_ADDR;
 
 	return erofs_pos(bmgr->sbi, bb->blkaddr) +
 		(end ? list_next_entry(bh, list)->off : bh->off);
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 36df13a..244aa82 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -44,9 +44,6 @@ typedef u64 erofs_nid_t;
 /* data type for filesystem-wide blocks number */
 typedef u32 erofs_blk_t;
 
-#define NULL_ADDR	((unsigned int)-1)
-#define NULL_ADDR_UL	((unsigned long)-1)
-
 /* global sbi */
 extern struct erofs_sb_info g_sbi;
 
diff --git a/lib/cache.c b/lib/cache.c
index eddf21f..b91a288 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -49,7 +49,7 @@ struct erofs_bufmgr *erofs_buffer_init(struct erofs_sb_info *sbi,
 		}
 	}
 	init_list_head(&bmgr->blkh.list);
-	bmgr->blkh.blkaddr = NULL_ADDR;
+	bmgr->blkh.blkaddr = EROFS_NULL_ADDR;
 	bmgr->tail_blkaddr = startblk;
 	bmgr->last_mapped_block = &bmgr->blkh;
 	bmgr->dsunit = 0;
@@ -79,7 +79,7 @@ static void erofs_update_bwatermeter(struct erofs_buffer_block *bb, bool free)
 	struct erofs_bufmgr *bmgr = bb->buffers.fsprivate;
 	struct erofs_sb_info *sbi = bmgr->sbi;
 	unsigned int blksiz = erofs_blksiz(sbi);
-	bool mapped = bb->blkaddr != NULL_ADDR;
+	bool mapped = bb->blkaddr != EROFS_NULL_ADDR;
 	struct list_head *h = bmgr->watermeter[bb->type][mapped];
 	unsigned int nr;
 
@@ -127,12 +127,12 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 	oob = cmpsgn(alignedoffset + incr + inline_ext,
 		     bb->buffers.nblocks << sbi->blkszbits);
 	if (oob >= 0) {
-		/* the next buffer block should be NULL_ADDR all the time */
-		if (oob && list_next_entry(bb, list)->blkaddr != NULL_ADDR)
+		/* the next buffer block should be EROFS_NULL_ADDR all the time */
+		if (oob && list_next_entry(bb, list)->blkaddr != EROFS_NULL_ADDR)
 			return -EINVAL;
 
 		blkaddr = bb->blkaddr;
-		if (blkaddr != NULL_ADDR) {
+		if (blkaddr != EROFS_NULL_ADDR) {
 			tailupdate = (bmgr->tail_blkaddr == blkaddr +
 				      bb->buffers.nblocks);
 			if (oob && !tailupdate)
@@ -244,7 +244,7 @@ static int erofs_bfind_for_attach(struct erofs_bufmgr *bmgr,
 
 			/* skip the last mapped block */
 			if (mapped &&
-			    list_next_entry(cur, list)->blkaddr == NULL_ADDR) {
+			    list_next_entry(cur, list)->blkaddr == EROFS_NULL_ADDR) {
 				DBG_BUGON(cur != bmgr->last_mapped_block);
 				cur = list_next_entry(cur, sibling);
 				if (&cur->sibling == bt)
@@ -252,7 +252,7 @@ static int erofs_bfind_for_attach(struct erofs_bufmgr *bmgr,
 			}
 
 			DBG_BUGON(cur->type != type);
-			DBG_BUGON((cur->blkaddr != NULL_ADDR) ^ mapped);
+			DBG_BUGON((cur->blkaddr != EROFS_NULL_ADDR) ^ mapped);
 			DBG_BUGON(used != (cur->buffers.off & blkmask));
 
 			ret = __erofs_battach(cur, NULL, size, alignsize,
@@ -327,7 +327,7 @@ struct erofs_buffer_head *erofs_balloc(struct erofs_bufmgr *bmgr,
 			return ERR_PTR(-ENOMEM);
 
 		bb->type = type;
-		bb->blkaddr = NULL_ADDR;
+		bb->blkaddr = EROFS_NULL_ADDR;
 		bb->buffers.off = 0;
 		bb->buffers.nblocks = 0;
 		bb->buffers.fsprivate = bmgr;
@@ -388,7 +388,7 @@ static void __erofs_mapbh(struct erofs_buffer_block *bb)
 	struct erofs_bufmgr *bmgr = bb->buffers.fsprivate;
 	erofs_blk_t blkaddr = bmgr->tail_blkaddr;
 
-	if (bb->blkaddr == NULL_ADDR) {
+	if (bb->blkaddr == EROFS_NULL_ADDR) {
 		bb->blkaddr = blkaddr;
 		if (__erofs_unlikely(bmgr->dsunit > 1) && bb->type == DATA) {
 			struct erofs_buffer_block *pb = list_prev_entry(bb, list);
@@ -418,14 +418,14 @@ erofs_blk_t erofs_mapbh(struct erofs_bufmgr *bmgr,
 		bmgr = bb->buffers.fsprivate;
 	t = bmgr->last_mapped_block;
 
-	if (bb && bb->blkaddr != NULL_ADDR)
+	if (bb && bb->blkaddr != EROFS_NULL_ADDR)
 		return bb->blkaddr;
 	do {
 		t = list_next_entry(t, list);
 		if (t == &bmgr->blkh)
 			break;
 
-		DBG_BUGON(t->blkaddr != NULL_ADDR);
+		DBG_BUGON(t->blkaddr != EROFS_NULL_ADDR);
 		__erofs_mapbh(t);
 	} while (t != bb);
 	return bmgr->tail_blkaddr;
@@ -501,7 +501,7 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 	bool rollback = false;
 
 	/* tail_blkaddr could be rolled back after revoking all bhs */
-	if (tryrevoke && blkaddr != NULL_ADDR &&
+	if (tryrevoke && blkaddr != EROFS_NULL_ADDR &&
 	    bmgr->tail_blkaddr == blkaddr + bb->buffers.nblocks)
 		rollback = true;
 
diff --git a/lib/inode.c b/lib/inode.c
index 7a10624..f99cbb0 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -189,7 +189,7 @@ int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks)
 
 	if (!nblocks) {
 		/* it has only tail-end data */
-		inode->u.i_blkaddr = NULL_ADDR;
+		inode->u.i_blkaddr = EROFS_NULL_ADDR;
 		return 0;
 	}
 
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 5787bb3..8892d11 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -249,7 +249,7 @@ static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
 		break;
 	case S_IFREG:
 		if (!inode->i_size) {
-			inode->u.i_blkaddr = NULL_ADDR;
+			inode->u.i_blkaddr = EROFS_NULL_ADDR;
 			break;
 		}
 		if (datamode == EROFS_REBUILD_DATA_BLOB_INDEX)
-- 
2.43.5


