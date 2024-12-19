Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EC29F74F4
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Dec 2024 07:43:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YDLc957pMz3cCM
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Dec 2024 17:43:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734590631;
	cv=none; b=H6DKC4nnzQVy3VOo4eLXWLQV6fG4lHCOP9rONErruxpW8EfCwPGuwirc1UFWMH/YajM/WVTcOl3qiIAxq4c43OQNHnTvkYbX1KaC7Gb2lq7VT2m7/h0wIZRB00PpnEaslKhthxX3gj9y1pW1ZYSw2jQs5x1uAYvYi6WY5I6fy95Yj6PNgSLxngya33WYGoYjfBWVkk34GfM5oyduFoTqBCHAQ5l7XoavnoaMd5eCyI0iESB2JcDmETQPIFeOGXmhzqK1udGQzKaB6Q+35UrY1xptYPhEroBCIfcFzwGoQ2VQcXZ3vuX4GVd1SgsNRjKrO38D7Bsprliyhhtoam6bIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734590631; c=relaxed/relaxed;
	bh=rDALtUbt4fFVTRdA6qJno9OXV3pPIhD7DaNhTSUB0S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mz+Ja+x5otsNz4BHf33LUgG5R02B9+boNy2U3uxl/nWYydfuya+dTZaENooFFwJcZUrzWXwdXx6kf6kcidRgoZWjYKKxAyx/c9cfuaiNiB2UqChu0o+/QKTHaaopuYMxCSR1em853FvkphDCisQqO74o1gOKaOz8BXo3TY2tG6lNPi8bzABUu21nvUAkAK1TdoOClba4FAkT1SWDc2bw8okBoouUMpO4wlcYP+kpabYzaNAlXtVGPWjUPQsMYOLqDn/wJP7wsAIRLTboQyND4XEMi17tCJ/q+3ZarI+L7NfLV7J85whp4UH+9nP88roQEduvWw1pWwuoWRRleot8Bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Myj76a8H; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Myj76a8H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YDLc41LGZz2yRP
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Dec 2024 17:43:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734590623; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rDALtUbt4fFVTRdA6qJno9OXV3pPIhD7DaNhTSUB0S4=;
	b=Myj76a8HFylKp1quWfV9jfsdzNqvewmzAIrzSTfN+teMhKGWsHMdVuBU5ILCWqqgU32O69UtOYaw7rcjH30XsX3GhnYGTWvOsWRbIFu5jFQziE5kSQ78i2eoXnx3Ggl9mBp+KNGwCHSs29D28p8DrojVIUqKBGt4w3QeZKyEcKU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLpMVKa_1734590621 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Dec 2024 14:43:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/4] erofs: support buffer block reservation
Date: Thu, 19 Dec 2024 14:43:30 +0800
Message-ID: <20241219064331.2223001-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241219064331.2223001-1-hsiangkao@linux.alibaba.com>
References: <20241219064331.2223001-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In order to support data alignment, add support for recording multiple
block reservations.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/cache.h | 11 +++++++----
 lib/cache.c           | 32 ++++++++++++++++----------------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 646d6de..d8559a8 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -35,11 +35,14 @@ struct erofs_bhops {
 
 struct erofs_buffer_head {
 	struct list_head list;
-	struct erofs_buffer_block *block;
-
+	union {
+		struct {
+			struct erofs_buffer_block *block;
+			const struct erofs_bhops *op;
+		};
+		erofs_blk_t nblocks;
+	};
 	erofs_off_t off;
-	const struct erofs_bhops *op;
-
 	void *fsprivate;
 };
 
diff --git a/lib/cache.c b/lib/cache.c
index 1cc5007..cb05466 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -74,8 +74,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 {
 	struct erofs_bufmgr *bmgr = bb->buffers.fsprivate;
 	struct erofs_sb_info *sbi = bmgr->sbi;
-	const unsigned int blksiz = erofs_blksiz(sbi);
-	const unsigned int blkmask = blksiz - 1;
+	const unsigned int blkmask = erofs_blksiz(sbi) - 1;
 	erofs_off_t boff = bb->buffers.off;
 	const erofs_off_t alignedoffset = roundup(boff, alignsize);
 	bool tailupdate = false;
@@ -87,7 +86,8 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 			+ inline_ext > blkmask)
 		return -ENOSPC;
 
-	oob = cmpsgn((alignedoffset & blkmask) + incr + inline_ext, blksiz);
+	oob = cmpsgn(roundup(boff, alignsize) + incr + inline_ext,
+		     bb->buffers.nblocks << sbi->blkszbits);
 	if (oob >= 0) {
 		/* the next buffer block should be NULL_ADDR all the time */
 		if (oob && list_next_entry(bb, list)->blkaddr != NULL_ADDR)
@@ -96,7 +96,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 		blkaddr = bb->blkaddr;
 		if (blkaddr != NULL_ADDR) {
 			tailupdate = (bmgr->tail_blkaddr == blkaddr +
-				      BLK_ROUND_UP(sbi, boff));
+				      bb->buffers.nblocks);
 			if (oob && !tailupdate)
 				return -EINVAL;
 		}
@@ -110,10 +110,11 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 		}
 		boff = alignedoffset + incr;
 		bb->buffers.off = boff;
+		bb->buffers.nblocks = max_t(erofs_blk_t, bb->buffers.nblocks,
+					    BLK_ROUND_UP(sbi, boff));
 		/* need to update the tail_blkaddr */
 		if (tailupdate)
-			bmgr->tail_blkaddr = blkaddr +
-						BLK_ROUND_UP(sbi, boff);
+			bmgr->tail_blkaddr = blkaddr + bb->buffers.nblocks;
 		erofs_bupdate_mapped(bb);
 	}
 	return ((alignedoffset + incr + blkmask) & blkmask) + 1;
@@ -266,6 +267,7 @@ struct erofs_buffer_head *erofs_balloc(struct erofs_bufmgr *bmgr,
 		bb->type = type;
 		bb->blkaddr = NULL_ADDR;
 		bb->buffers.off = 0;
+		bb->buffers.nblocks = 0;
 		bb->buffers.fsprivate = bmgr;
 		init_list_head(&bb->buffers.list);
 		if (type == DATA)
@@ -319,7 +321,7 @@ struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 	return nbh;
 }
 
-static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
+static void __erofs_mapbh(struct erofs_buffer_block *bb)
 {
 	struct erofs_bufmgr *bmgr = bb->buffers.fsprivate;
 	erofs_blk_t blkaddr;
@@ -330,10 +332,9 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 		erofs_bupdate_mapped(bb);
 	}
 
-	blkaddr = bb->blkaddr + BLK_ROUND_UP(bmgr->sbi, bb->buffers.off);
+	blkaddr = bb->blkaddr + bb->buffers.nblocks;
 	if (blkaddr > bmgr->tail_blkaddr)
 		bmgr->tail_blkaddr = blkaddr;
-	return blkaddr;
 }
 
 erofs_blk_t erofs_mapbh(struct erofs_bufmgr *bmgr,
@@ -353,7 +354,7 @@ erofs_blk_t erofs_mapbh(struct erofs_bufmgr *bmgr,
 			break;
 
 		DBG_BUGON(t->blkaddr != NULL_ADDR);
-		(void)__erofs_mapbh(t);
+		__erofs_mapbh(t);
 	} while (t != bb);
 	return bmgr->tail_blkaddr;
 }
@@ -389,7 +390,8 @@ int erofs_bflush(struct erofs_bufmgr *bmgr,
 		if (p == bb)
 			break;
 
-		blkaddr = __erofs_mapbh(p);
+		__erofs_mapbh(p);
+		blkaddr = p->blkaddr + BLK_ROUND_UP(sbi, p->buffers.off);
 
 		list_for_each_entry_safe(bh, nbh, &p->buffers.list, list) {
 			if (bh->op == &erofs_skip_write_bhops) {
@@ -412,8 +414,7 @@ int erofs_bflush(struct erofs_bufmgr *bmgr,
 					   padding, true);
 
 		if (p->type != DATA)
-			bmgr->metablkcnt +=
-				BLK_ROUND_UP(sbi, p->buffers.off);
+			bmgr->metablkcnt += p->buffers.nblocks;
 		erofs_dbg("block %u to %u flushed", p->blkaddr, blkaddr - 1);
 		erofs_bfree(p);
 	}
@@ -424,13 +425,12 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 {
 	struct erofs_buffer_block *const bb = bh->block;
 	struct erofs_bufmgr *bmgr = bb->buffers.fsprivate;
-	struct erofs_sb_info *sbi = bmgr->sbi;
 	const erofs_blk_t blkaddr = bh->block->blkaddr;
 	bool rollback = false;
 
 	/* tail_blkaddr could be rolled back after revoking all bhs */
 	if (tryrevoke && blkaddr != NULL_ADDR &&
-	    bmgr->tail_blkaddr == blkaddr + BLK_ROUND_UP(sbi, bb->buffers.off))
+	    bmgr->tail_blkaddr == blkaddr + bb->buffers.nblocks)
 		rollback = true;
 
 	bh->op = &erofs_drop_directly_bhops;
@@ -440,7 +440,7 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 		return;
 
 	if (!rollback && bb->type != DATA)
-		bmgr->metablkcnt += BLK_ROUND_UP(sbi, bb->buffers.off);
+		bmgr->metablkcnt += bb->buffers.nblocks;
 	erofs_bfree(bb);
 	if (rollback)
 		bmgr->tail_blkaddr = blkaddr;
-- 
2.43.5

