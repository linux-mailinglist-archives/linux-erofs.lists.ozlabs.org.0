Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F4F92CB7F
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 08:59:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hGW2eETU;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WJpdC39fkz3cY3
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 16:59:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hGW2eETU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WJpd55mSyz3c3H
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jul 2024 16:59:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720594773; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Vd0xmBCCEulWx0pEz1oPQeZJaKyNTjALSXLpkwxJ7Ik=;
	b=hGW2eETUaLvWjbLm2Aj/fL7FnKzprG2SaVHxP7r1y5rKAcM6IdmHyxbo+I42FRGzC60UF/dzEAhUsnApnXFmGGFAJdQUI/I+boYbIICaMYiC6Dcc+ZqSAC15W++fvUZ+bOU8sGMuFymKYPWiVSUr3q8KWDPvcZpE0y+SLsLuUtk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WAE9oRJ_1720594771;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WAE9oRJ_1720594771)
          by smtp.aliyun-inc.com;
          Wed, 10 Jul 2024 14:59:32 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: lib/cache.c: replace &g_sbi with sbi
Date: Wed, 10 Jul 2024 14:59:28 +0800
Message-ID: <20240710065929.114911-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Hongzhen Luo <hongzhen@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Prepare for the upcoming per-sbi buffer.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 include/erofs/cache.h |  9 ++++++---
 lib/cache.c           | 28 +++++++++++++++++-----------
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 234185f..288843e 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -55,15 +55,17 @@ struct erofs_buffer_block {
 
 static inline const int get_alignsize(int type, int *type_ret)
 {
+	struct erofs_sb_info *sbi = &g_sbi;
+
 	if (type == DATA)
-		return erofs_blksiz(&g_sbi);
+		return erofs_blksiz(sbi);
 
 	if (type == INODE) {
 		*type_ret = META;
 		return sizeof(struct erofs_inode_compact);
 	} else if (type == DIRA) {
 		*type_ret = META;
-		return erofs_blksiz(&g_sbi);
+		return erofs_blksiz(sbi);
 	} else if (type == XATTR) {
 		*type_ret = META;
 		return sizeof(struct erofs_xattr_entry);
@@ -83,11 +85,12 @@ extern const struct erofs_bhops erofs_skip_write_bhops;
 static inline erofs_off_t erofs_btell(struct erofs_buffer_head *bh, bool end)
 {
 	const struct erofs_buffer_block *bb = bh->block;
+	struct erofs_sb_info *sbi = &g_sbi;
 
 	if (bb->blkaddr == NULL_ADDR)
 		return NULL_ADDR_UL;
 
-	return erofs_pos(&g_sbi, bb->blkaddr) +
+	return erofs_pos(sbi, bb->blkaddr) +
 		(end ? list_next_entry(bh, list)->off : bh->off);
 }
 
diff --git a/lib/cache.c b/lib/cache.c
index e3dc9de..69a3055 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -51,12 +51,13 @@ void erofs_buffer_init(erofs_blk_t startblk)
 static void erofs_bupdate_mapped(struct erofs_buffer_block *bb)
 {
 	struct list_head *bkt;
+	struct erofs_sb_info *sbi = &g_sbi;
 
 	if (bb->blkaddr == NULL_ADDR)
 		return;
 
 	bkt = mapped_buckets[bb->type] +
-		(bb->buffers.off & (erofs_blksiz(&g_sbi) - 1));
+		(bb->buffers.off & (erofs_blksiz(sbi) - 1));
 	list_del(&bb->mapped_list);
 	list_add_tail(&bb->mapped_list, bkt);
 }
@@ -69,7 +70,8 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 			   unsigned int extrasize,
 			   bool dryrun)
 {
-	const unsigned int blksiz = erofs_blksiz(&g_sbi);
+	struct erofs_sb_info *sbi = &g_sbi;
+	const unsigned int blksiz = erofs_blksiz(sbi);
 	const unsigned int blkmask = blksiz - 1;
 	erofs_off_t boff = bb->buffers.off;
 	const erofs_off_t alignedoffset = roundup(boff, alignsize);
@@ -86,7 +88,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 		blkaddr = bb->blkaddr;
 		if (blkaddr != NULL_ADDR) {
 			tailupdate = (tail_blkaddr == blkaddr +
-				      BLK_ROUND_UP(&g_sbi, boff));
+				      BLK_ROUND_UP(sbi, boff));
 			if (oob && !tailupdate)
 				return -EINVAL;
 		}
@@ -102,7 +104,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 		bb->buffers.off = boff;
 		/* need to update the tail_blkaddr */
 		if (tailupdate)
-			tail_blkaddr = blkaddr + BLK_ROUND_UP(&g_sbi, boff);
+			tail_blkaddr = blkaddr + BLK_ROUND_UP(sbi, boff);
 		erofs_bupdate_mapped(bb);
 	}
 	return ((alignedoffset + incr - 1) & blkmask) + 1;
@@ -125,7 +127,8 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 				  unsigned int alignsize,
 				  struct erofs_buffer_block **bbp)
 {
-	const unsigned int blksiz = erofs_blksiz(&g_sbi);
+	struct erofs_sb_info *sbi = &g_sbi;
+	const unsigned int blksiz = erofs_blksiz(sbi);
 	struct erofs_buffer_block *cur, *bb;
 	unsigned int used0, used_before, usedmax, used;
 	int ret;
@@ -315,6 +318,7 @@ struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 {
 	erofs_blk_t blkaddr;
+	struct erofs_sb_info *sbi = &g_sbi;
 
 	if (bb->blkaddr == NULL_ADDR) {
 		bb->blkaddr = tail_blkaddr;
@@ -322,7 +326,7 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 		erofs_bupdate_mapped(bb);
 	}
 
-	blkaddr = bb->blkaddr + BLK_ROUND_UP(&g_sbi, bb->buffers.off);
+	blkaddr = bb->blkaddr + BLK_ROUND_UP(sbi, bb->buffers.off);
 	if (blkaddr > tail_blkaddr)
 		tail_blkaddr = blkaddr;
 
@@ -360,7 +364,8 @@ static void erofs_bfree(struct erofs_buffer_block *bb)
 
 int erofs_bflush(struct erofs_buffer_block *bb)
 {
-	const unsigned int blksiz = erofs_blksiz(&g_sbi);
+	struct erofs_sb_info *sbi = &g_sbi;
+	const unsigned int blksiz = erofs_blksiz(sbi);
 	struct erofs_buffer_block *p, *n;
 	erofs_blk_t blkaddr;
 
@@ -392,11 +397,11 @@ int erofs_bflush(struct erofs_buffer_block *bb)
 
 		padding = blksiz - (p->buffers.off & (blksiz - 1));
 		if (padding != blksiz)
-			erofs_dev_fillzero(&g_sbi, erofs_pos(&g_sbi, blkaddr) - padding,
+			erofs_dev_fillzero(sbi, erofs_pos(sbi, blkaddr) - padding,
 					   padding, true);
 
 		if (p->type != DATA)
-			erofs_metablkcnt += BLK_ROUND_UP(&g_sbi, p->buffers.off);
+			erofs_metablkcnt += BLK_ROUND_UP(sbi, p->buffers.off);
 		erofs_dbg("block %u to %u flushed", p->blkaddr, blkaddr - 1);
 		erofs_bfree(p);
 	}
@@ -408,10 +413,11 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 	struct erofs_buffer_block *const bb = bh->block;
 	const erofs_blk_t blkaddr = bh->block->blkaddr;
 	bool rollback = false;
+	struct erofs_sb_info *sbi = &g_sbi;
 
 	/* tail_blkaddr could be rolled back after revoking all bhs */
 	if (tryrevoke && blkaddr != NULL_ADDR &&
-	    tail_blkaddr == blkaddr + BLK_ROUND_UP(&g_sbi, bb->buffers.off))
+	    tail_blkaddr == blkaddr + BLK_ROUND_UP(sbi, bb->buffers.off))
 		rollback = true;
 
 	bh->op = &erofs_drop_directly_bhops;
@@ -421,7 +427,7 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 		return;
 
 	if (!rollback && bb->type != DATA)
-		erofs_metablkcnt += BLK_ROUND_UP(&g_sbi, bb->buffers.off);
+		erofs_metablkcnt += BLK_ROUND_UP(sbi, bb->buffers.off);
 	erofs_bfree(bb);
 	if (rollback)
 		tail_blkaddr = blkaddr;
-- 
2.43.5

