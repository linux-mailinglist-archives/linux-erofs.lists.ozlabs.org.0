Return-Path: <linux-erofs+bounces-27-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AA8A58F89
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Mar 2025 10:25:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBBM56vXqz2y8p;
	Mon, 10 Mar 2025 20:25:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741598721;
	cv=none; b=TLIULzS7L7rn2L/ra1/WZFCFYCECBH7h4/5UicsN2AWFdhv4Sdu5jTvP/gfwZ3kq1XP0sJfj6xNVWyVgX12zctfN1jaMZWYAP6a8ygQKvEaWwFnJhAmMelfXpO64fcXDrj45akgT9+pk4XZjYmBqejE8UaCiCx5Y8dt+qJEIlYYcERh3bVloqu2uDC1gfQWUhtrZnj0gcEBIvLvqwHH5uV37Vgn0unLmop6HcQFGt98yMtwVay3EeHBZS2Sz3dLP4xg/th33iazSxU4sWV7kfMnPJlfjPUit8PxVQNwEGdH7jLVkF1IWKKyPMg4x2JfyzXchiE3Gh5UH85RTz3RXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741598721; c=relaxed/relaxed;
	bh=nzM7+iA4NE+Iq7TD7FZvg8VjxDC/KnwV4tNS32caI/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3V3djfj0psPaxvQTCNlXRZ9qKczftHgvxuo/hZtF5IxvU8HSA2l9v26sc32bvOJ4HY23w1o4Jyg0eoqZe0rjo1ffjR14zlapCoulHUE2F1IWz2VQ3IUIUYFpdmbfYjPXjog3TVrEmqOuMlL0Xmqylb7S8+vH/Ix9bBweWkZNZ7owBIVS/supngkO2T+h6NMDXN5wufUNXzc8nazrdxOoOJ7nBptIww2YFJJevOY1KhziShNloJRMvt+wpXEM5oBBq2EPhGowNO4oEPMyS5Q/4OWdCZnvbAEO9m5KfYxyUjkT6VjAofdFA2Ecil1OQhEeHEyyyvf8qex/pUEe9gYZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=piB7adU1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=piB7adU1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBBM43MVwz305v
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Mar 2025 20:25:20 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741598716; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nzM7+iA4NE+Iq7TD7FZvg8VjxDC/KnwV4tNS32caI/o=;
	b=piB7adU1WrlddCSopHPkza+P0DhnsUQ/JsKxGjjn/wR+oHK4Q72ZBl1hf8ktTMKWYxD7AGLpCLRF1uJvH3R1yRFGxRVe3U3EjCzlhuOkgukHe9bXoudhIpZtdI8svBJgfPKYuL+VK6iqy/YCM7xWrsUGUKROSS+yzisXLPXPcDw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR0RN9D_1741598712 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:25:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/7] erofs-utils: get rid of NULL_ADDR{,_UL}
Date: Mon, 10 Mar 2025 17:25:03 +0800
Message-ID: <20250310092508.2573532-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250310092508.2573532-1-hsiangkao@linux.alibaba.com>
References: <20250310092508.2573532-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

.. And replace them with EROFS_NULL_ADDR.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/cache.h    |  4 ++--
 include/erofs/internal.h |  3 ---
 lib/block_list.c         |  4 ++--
 lib/cache.c              | 24 ++++++++++++------------
 lib/inode.c              |  4 ++--
 lib/rebuild.c            |  2 +-
 6 files changed, 19 insertions(+), 22 deletions(-)

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
index 2f71557..b1b971f 100644
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
 
diff --git a/lib/block_list.c b/lib/block_list.c
index 6bbe4ec..8f1c93b 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -111,13 +111,13 @@ void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
 
 	/* XXX: another hack, which means it has been outputed before */
 	if (erofs_blknr(inode->sbi, inode->i_size)) {
-		if (blkaddr == NULL_ADDR)
+		if (blkaddr == EROFS_NULL_ADDR)
 			fprintf(block_list_fp, "\n");
 		else
 			fprintf(block_list_fp, " %u\n", blkaddr);
 		return;
 	}
-	if (blkaddr != NULL_ADDR)
+	if (blkaddr != EROFS_NULL_ADDR)
 		blocklist_write(inode->i_srcpath, blkaddr, 1, true, true);
 }
 #endif
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
index 34c6128..ce77682 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -189,7 +189,7 @@ int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks)
 
 	if (!nblocks) {
 		/* it has only tail-end data */
-		inode->u.i_blkaddr = NULL_ADDR;
+		inode->u.i_blkaddr = EROFS_NULL_ADDR;
 		return 0;
 	}
 
@@ -844,7 +844,7 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		ibh->fsprivate = erofs_igrab(inode);
 		ibh->op = &erofs_write_inline_bhops;
 
-		erofs_droid_blocklist_write_tail_end(inode, NULL_ADDR);
+		erofs_droid_blocklist_write_tail_end(inode, EROFS_NULL_ADDR);
 	} else {
 		int ret;
 		erofs_off_t pos, zero_pos;
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


