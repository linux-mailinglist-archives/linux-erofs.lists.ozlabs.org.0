Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C479925583
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 10:37:58 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=maRxo8Cs;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WDY7l5qL0z3cb2
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 18:37:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=maRxo8Cs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WDY7V55Wyz3cXb
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jul 2024 18:37:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719995855; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TWtZpn2AmPXU7Rc807IwqbcyHLGGB88DxSMU3+UIjZE=;
	b=maRxo8Csgmofc83gQ/Tq7W3dhX2aTaTicJRb/7sc5b9vRHoK1YXCWqzfyiLNn3cJxYTYxHpjxcgUaIqWzoY99CutsnUlNEJXU5SaOPXKiydHXyBOqzKaps+C6rqL0Wjeqj7mM3trNGl6zvRtvUMbAOM0kkTu+wOAOsybf6MnyyQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W9lKS4y_1719995852;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W9lKS4y_1719995852)
          by smtp.aliyun-inc.com;
          Wed, 03 Jul 2024 16:37:33 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: lib: add per-sbi buffer support
Date: Wed,  3 Jul 2024 16:37:20 +0800
Message-Id: <20240703083721.3585434-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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

Get rid of the global sbi and add per-sbi buffer support.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 include/erofs/cache.h    |  36 ++++++---
 include/erofs/internal.h |   5 +-
 lib/cache.c              | 159 +++++++++++++++++++++------------------
 lib/super.c              |  21 +++---
 4 files changed, 128 insertions(+), 93 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index f30fe9f..3e82311 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -53,6 +53,15 @@ struct erofs_buffer_block {
 	struct erofs_buffer_head buffers;
 };
 
+struct erofs_balloc {
+	struct erofs_buffer_block blkh;
+	erofs_blk_t tail_blkaddr, erofs_metablkcnt;
+	/* buckets for all mapped buffer blocks to boost up allocation */
+	struct list_head mapped_buckets[META + 1][EROFS_MAX_BLOCK_SIZE];
+	/* last mapped buffer block to accelerate erofs_mapbh() */
+	struct erofs_buffer_block *last_mapped_block;
+};
+
 static inline const int get_alignsize(int type, int *type_ret)
 {
 	if (type == DATA)
@@ -80,14 +89,15 @@ static inline const int get_alignsize(int type, int *type_ret)
 extern const struct erofs_bhops erofs_drop_directly_bhops;
 extern const struct erofs_bhops erofs_skip_write_bhops;
 
-static inline erofs_off_t erofs_btell(struct erofs_buffer_head *bh, bool end)
+static inline erofs_off_t erofs_btell(struct erofs_sb_info *sbi,
+				      struct erofs_buffer_head *bh, bool end)
 {
 	const struct erofs_buffer_block *bb = bh->block;
 
 	if (bb->blkaddr == NULL_ADDR)
 		return NULL_ADDR_UL;
 
-	return erofs_pos(&sbi, bb->blkaddr) +
+	return erofs_pos(sbi, bb->blkaddr) +
 		(end ? list_next_entry(bh, list)->off : bh->off);
 }
 
@@ -98,21 +108,27 @@ static inline int erofs_bh_flush_generic_end(struct erofs_buffer_head *bh)
 	return 0;
 }
 
-void erofs_buffer_init(erofs_blk_t startblk);
-int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr);
+void erofs_buffer_init(struct erofs_sb_info *sbi, erofs_blk_t startblk);
+int erofs_bh_balloon(struct erofs_sb_info *sbi, struct erofs_buffer_head *bh,
+		     erofs_off_t incr);
 
-struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
+struct erofs_buffer_head *erofs_balloc(struct erofs_sb_info *sbi,
+				       int type, erofs_off_t size,
 				       unsigned int required_ext,
 				       unsigned int inline_ext);
-struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
+struct erofs_buffer_head *erofs_battach(struct erofs_sb_info *sbi,
+					struct erofs_buffer_head *bh,
 					int type, unsigned int size);
 
-erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb);
-int erofs_bflush(struct erofs_buffer_block *bb);
+erofs_blk_t erofs_mapbh(struct erofs_sb_info *sbi,
+			struct erofs_buffer_block *bb);
+int erofs_bflush(struct erofs_sb_info *sbi, struct erofs_buffer_block *bb);
 
-void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
-erofs_blk_t erofs_total_metablocks(void);
+void erofs_bdrop(struct erofs_sb_info *sbi, struct erofs_buffer_head *bh,
+		 bool tryrevoke);
+erofs_blk_t erofs_total_metablocks(struct erofs_sb_info *sbi);
 
+void erofs_bexit(struct erofs_sb_info *sbi);
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index d5c5ce2..60da612 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -58,6 +58,7 @@ extern struct erofs_sb_info sbi;
 	(roundup(addr, erofs_blksiz(sbi)) >> (sbi)->blkszbits)
 
 struct erofs_buffer_head;
+struct erofs_balloc;
 
 struct erofs_device_info {
 	u8 tag[64];
@@ -132,6 +133,8 @@ struct erofs_sb_info {
 	struct erofs_mkfs_dfops *mkfs_dfops;
 #endif
 	bool useqpl;
+
+	struct erofs_balloc *balloc;
 };
 
 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
@@ -402,7 +405,7 @@ int erofs_read_superblock(struct erofs_sb_info *sbi);
 void erofs_put_super(struct erofs_sb_info *sbi);
 int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
 		  erofs_blk_t *blocks);
-struct erofs_buffer_head *erofs_reserve_sb(void);
+struct erofs_buffer_head *erofs_reserve_sb(struct erofs_sb_info *sbi);
 int erofs_enable_sb_chksum(struct erofs_sb_info *sbi, u32 *crc);
 
 /* namei.c */
diff --git a/lib/cache.c b/lib/cache.c
index 328ca4a..63d7c0c 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -9,17 +9,6 @@
 #include <erofs/cache.h>
 #include "erofs/print.h"
 
-static struct erofs_buffer_block blkh = {
-	.list = LIST_HEAD_INIT(blkh.list),
-	.blkaddr = NULL_ADDR,
-};
-static erofs_blk_t tail_blkaddr, erofs_metablkcnt;
-
-/* buckets for all mapped buffer blocks to boost up allocation */
-static struct list_head mapped_buckets[META + 1][EROFS_MAX_BLOCK_SIZE];
-/* last mapped buffer block to accelerate erofs_mapbh() */
-static struct erofs_buffer_block *last_mapped_block = &blkh;
-
 static int erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
 {
 	return erofs_bh_flush_generic_end(bh);
@@ -38,38 +27,48 @@ const struct erofs_bhops erofs_skip_write_bhops = {
 	.flush = erofs_bh_flush_skip_write,
 };
 
-void erofs_buffer_init(erofs_blk_t startblk)
+void erofs_buffer_init(struct erofs_sb_info *sbi, erofs_blk_t startblk)
 {
 	int i, j;
 
-	for (i = 0; i < ARRAY_SIZE(mapped_buckets); i++)
-		for (j = 0; j < ARRAY_SIZE(mapped_buckets[0]); j++)
-			init_list_head(&mapped_buckets[i][j]);
-	tail_blkaddr = startblk;
+	sbi->balloc = malloc(sizeof(struct erofs_balloc));
+	if (!sbi->balloc) {
+		erofs_err("fail to prepare balloc");
+		return;
+	}
+	init_list_head(&sbi->balloc->blkh.list);
+	sbi->balloc->blkh.blkaddr = NULL_ADDR;
+	sbi->balloc->last_mapped_block = &sbi->balloc->blkh;
+
+	for (i = 0; i < ARRAY_SIZE(sbi->balloc->mapped_buckets); i++)
+		for (j = 0; j < ARRAY_SIZE(sbi->balloc->mapped_buckets[0]); j++)
+			init_list_head(&sbi->balloc->mapped_buckets[i][j]);
+	sbi->balloc->tail_blkaddr = startblk;
 }
 
-static void erofs_bupdate_mapped(struct erofs_buffer_block *bb)
+static void erofs_bupdate_mapped(struct erofs_sb_info *sbi, struct erofs_buffer_block *bb)
 {
 	struct list_head *bkt;
 
 	if (bb->blkaddr == NULL_ADDR)
 		return;
 
-	bkt = mapped_buckets[bb->type] +
-		(bb->buffers.off & (erofs_blksiz(&sbi) - 1));
+	bkt = sbi->balloc->mapped_buckets[bb->type] +
+		(bb->buffers.off & (erofs_blksiz(sbi) - 1));
 	list_del(&bb->mapped_list);
 	list_add_tail(&bb->mapped_list, bkt);
 }
 
 /* return occupied bytes in specific buffer block if succeed */
-static int __erofs_battach(struct erofs_buffer_block *bb,
+static int __erofs_battach(struct erofs_sb_info *sbi,
+			   struct erofs_buffer_block *bb,
 			   struct erofs_buffer_head *bh,
 			   erofs_off_t incr,
 			   unsigned int alignsize,
 			   unsigned int extrasize,
 			   bool dryrun)
 {
-	const unsigned int blksiz = erofs_blksiz(&sbi);
+	const unsigned int blksiz = erofs_blksiz(sbi);
 	const unsigned int blkmask = blksiz - 1;
 	erofs_off_t boff = bb->buffers.off;
 	const erofs_off_t alignedoffset = roundup(boff, alignsize);
@@ -85,8 +84,8 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 
 		blkaddr = bb->blkaddr;
 		if (blkaddr != NULL_ADDR) {
-			tailupdate = (tail_blkaddr == blkaddr +
-				      BLK_ROUND_UP(&sbi, boff));
+			tailupdate = (sbi->balloc->tail_blkaddr == blkaddr +
+				      BLK_ROUND_UP(sbi, boff));
 			if (oob && !tailupdate)
 				return -EINVAL;
 		}
@@ -102,13 +101,14 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 		bb->buffers.off = boff;
 		/* need to update the tail_blkaddr */
 		if (tailupdate)
-			tail_blkaddr = blkaddr + BLK_ROUND_UP(&sbi, boff);
-		erofs_bupdate_mapped(bb);
+			sbi->balloc->tail_blkaddr = blkaddr + BLK_ROUND_UP(sbi, boff);
+		erofs_bupdate_mapped(sbi, bb);
 	}
 	return ((alignedoffset + incr - 1) & blkmask) + 1;
 }
 
-int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr)
+int erofs_bh_balloon(struct erofs_sb_info *sbi, struct erofs_buffer_head *bh,
+		     erofs_off_t incr)
 {
 	struct erofs_buffer_block *const bb = bh->block;
 
@@ -116,16 +116,17 @@ int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr)
 	if (bh->list.next != &bb->buffers.list)
 		return -EINVAL;
 
-	return __erofs_battach(bb, NULL, incr, 1, 0, false);
+	return __erofs_battach(sbi, bb, NULL, incr, 1, 0, false);
 }
 
-static int erofs_bfind_for_attach(int type, erofs_off_t size,
+static int erofs_bfind_for_attach(struct erofs_sb_info *sbi,
+				  int type, erofs_off_t size,
 				  unsigned int required_ext,
 				  unsigned int inline_ext,
 				  unsigned int alignsize,
 				  struct erofs_buffer_block **bbp)
 {
-	const unsigned int blksiz = erofs_blksiz(&sbi);
+	const unsigned int blksiz = erofs_blksiz(sbi);
 	struct erofs_buffer_block *cur, *bb;
 	unsigned int used0, used_before, usedmax, used;
 	int ret;
@@ -150,7 +151,8 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 	used_before = rounddown(blksiz -
 				(size + required_ext + inline_ext), alignsize);
 	for (; used_before; --used_before) {
-		struct list_head *bt = mapped_buckets[type] + used_before;
+		struct list_head *bt = sbi->balloc->mapped_buckets[type] +
+								used_before;
 
 		if (list_empty(bt))
 			continue;
@@ -159,7 +161,7 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 
 		/* last mapped block can be expended, don't handle it here */
 		if (list_next_entry(cur, list)->blkaddr == NULL_ADDR) {
-			DBG_BUGON(cur != last_mapped_block);
+			DBG_BUGON(cur != sbi->balloc->last_mapped_block);
 			continue;
 		}
 
@@ -167,7 +169,7 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 		DBG_BUGON(cur->blkaddr == NULL_ADDR);
 		DBG_BUGON(used_before != (cur->buffers.off & (blksiz - 1)));
 
-		ret = __erofs_battach(cur, NULL, size, alignsize,
+		ret = __erofs_battach(sbi, cur, NULL, size, alignsize,
 				      required_ext + inline_ext, true);
 		if (ret < 0) {
 			DBG_BUGON(1);
@@ -185,10 +187,10 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 
 skip_mapped:
 	/* try to start from the last mapped one, which can be expended */
-	cur = last_mapped_block;
-	if (cur == &blkh)
+	cur = sbi->balloc->last_mapped_block;
+	if (cur == &sbi->balloc->blkh)
 		cur = list_next_entry(cur, list);
-	for (; cur != &blkh; cur = list_next_entry(cur, list)) {
+	for (; cur != &sbi->balloc->blkh; cur = list_next_entry(cur, list)) {
 		used_before = cur->buffers.off & (blksiz - 1);
 
 		/* skip if buffer block is just full */
@@ -199,7 +201,7 @@ skip_mapped:
 		if (cur->type != type)
 			continue;
 
-		ret = __erofs_battach(cur, NULL, size, alignsize,
+		ret = __erofs_battach(sbi, cur, NULL, size, alignsize,
 				      required_ext + inline_ext, true);
 		if (ret < 0)
 			continue;
@@ -226,7 +228,8 @@ skip_mapped:
 	return 0;
 }
 
-struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
+struct erofs_buffer_head *erofs_balloc(struct erofs_sb_info *sbi, int type,
+				       erofs_off_t size,
 				       unsigned int required_ext,
 				       unsigned int inline_ext)
 {
@@ -243,7 +246,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 	alignsize = ret;
 
 	/* try to find if we could reuse an allocated buffer block */
-	ret = erofs_bfind_for_attach(type, size, required_ext, inline_ext,
+	ret = erofs_bfind_for_attach(sbi, type, size, required_ext, inline_ext,
 				     alignsize, &bb);
 	if (ret)
 		return ERR_PTR(ret);
@@ -263,9 +266,9 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 		bb->buffers.off = 0;
 		init_list_head(&bb->buffers.list);
 		if (type == DATA)
-			list_add(&bb->list, &last_mapped_block->list);
+			list_add(&bb->list, &sbi->balloc->last_mapped_block->list);
 		else
-			list_add_tail(&bb->list, &blkh.list);
+			list_add_tail(&bb->list, &sbi->balloc->blkh.list);
 		init_list_head(&bb->mapped_list);
 
 		bh = malloc(sizeof(struct erofs_buffer_head));
@@ -275,7 +278,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 		}
 	}
 
-	ret = __erofs_battach(bb, bh, size, alignsize,
+	ret = __erofs_battach(sbi, bb, bh, size, alignsize,
 			      required_ext + inline_ext, false);
 	if (ret < 0) {
 		free(bh);
@@ -284,7 +287,8 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 	return bh;
 }
 
-struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
+struct erofs_buffer_head *erofs_battach(struct erofs_sb_info *sbi,
+					struct erofs_buffer_head *bh,
 					int type, unsigned int size)
 {
 	struct erofs_buffer_block *const bb = bh->block;
@@ -304,7 +308,7 @@ struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 	if (!nbh)
 		return ERR_PTR(-ENOMEM);
 
-	ret = __erofs_battach(bb, nbh, size, alignsize, 0, false);
+	ret = __erofs_battach(sbi, bb, nbh, size, alignsize, 0, false);
 	if (ret < 0) {
 		free(nbh);
 		return ERR_PTR(ret);
@@ -312,59 +316,62 @@ struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 	return nbh;
 }
 
-static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
+static erofs_blk_t __erofs_mapbh(struct erofs_sb_info *sbi,
+				 struct erofs_buffer_block *bb)
 {
 	erofs_blk_t blkaddr;
 
 	if (bb->blkaddr == NULL_ADDR) {
-		bb->blkaddr = tail_blkaddr;
-		last_mapped_block = bb;
-		erofs_bupdate_mapped(bb);
+		bb->blkaddr = sbi->balloc->tail_blkaddr;
+		sbi->balloc->last_mapped_block = bb;
+		erofs_bupdate_mapped(sbi, bb);
 	}
 
-	blkaddr = bb->blkaddr + BLK_ROUND_UP(&sbi, bb->buffers.off);
-	if (blkaddr > tail_blkaddr)
-		tail_blkaddr = blkaddr;
+	blkaddr = bb->blkaddr + BLK_ROUND_UP(sbi, bb->buffers.off);
+	if (blkaddr > sbi->balloc->tail_blkaddr)
+		sbi->balloc->tail_blkaddr = blkaddr;
 
 	return blkaddr;
 }
 
-erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb)
+erofs_blk_t erofs_mapbh(struct erofs_sb_info *sbi,
+			struct erofs_buffer_block *bb)
 {
-	struct erofs_buffer_block *t = last_mapped_block;
+	struct erofs_buffer_block *t = sbi->balloc->last_mapped_block;
 
 	if (bb && bb->blkaddr != NULL_ADDR)
 		return bb->blkaddr;
 	do {
 		t = list_next_entry(t, list);
-		if (t == &blkh)
+		if (t == &sbi->balloc->blkh)
 			break;
 
 		DBG_BUGON(t->blkaddr != NULL_ADDR);
-		(void)__erofs_mapbh(t);
+		(void)__erofs_mapbh(sbi, t);
 	} while (t != bb);
-	return tail_blkaddr;
+	return sbi->balloc->tail_blkaddr;
 }
 
-static void erofs_bfree(struct erofs_buffer_block *bb)
+static void erofs_bfree(struct erofs_sb_info *sbi,
+			struct erofs_buffer_block *bb)
 {
 	DBG_BUGON(!list_empty(&bb->buffers.list));
 
-	if (bb == last_mapped_block)
-		last_mapped_block = list_prev_entry(bb, list);
+	if (bb == sbi->balloc->last_mapped_block)
+		sbi->balloc->last_mapped_block = list_prev_entry(bb, list);
 
 	list_del(&bb->mapped_list);
 	list_del(&bb->list);
 	free(bb);
 }
 
-int erofs_bflush(struct erofs_buffer_block *bb)
+int erofs_bflush(struct erofs_sb_info *sbi, struct erofs_buffer_block *bb)
 {
-	const unsigned int blksiz = erofs_blksiz(&sbi);
+	const unsigned int blksiz = erofs_blksiz(sbi);
 	struct erofs_buffer_block *p, *n;
 	erofs_blk_t blkaddr;
 
-	list_for_each_entry_safe(p, n, &blkh.list, list) {
+	list_for_each_entry_safe(p, n, &sbi->balloc->blkh.list, list) {
 		struct erofs_buffer_head *bh, *nbh;
 		unsigned int padding;
 		bool skip = false;
@@ -373,7 +380,7 @@ int erofs_bflush(struct erofs_buffer_block *bb)
 		if (p == bb)
 			break;
 
-		blkaddr = __erofs_mapbh(p);
+		blkaddr = __erofs_mapbh(sbi, p);
 
 		list_for_each_entry_safe(bh, nbh, &p->buffers.list, list) {
 			if (bh->op == &erofs_skip_write_bhops) {
@@ -392,18 +399,18 @@ int erofs_bflush(struct erofs_buffer_block *bb)
 
 		padding = blksiz - (p->buffers.off & (blksiz - 1));
 		if (padding != blksiz)
-			erofs_dev_fillzero(&sbi, erofs_pos(&sbi, blkaddr) - padding,
+			erofs_dev_fillzero(sbi, erofs_pos(sbi, blkaddr) - padding,
 					   padding, true);
 
 		if (p->type != DATA)
-			erofs_metablkcnt += BLK_ROUND_UP(&sbi, p->buffers.off);
+			sbi->balloc->erofs_metablkcnt += BLK_ROUND_UP(sbi, p->buffers.off);
 		erofs_dbg("block %u to %u flushed", p->blkaddr, blkaddr - 1);
-		erofs_bfree(p);
+		erofs_bfree(sbi, p);
 	}
 	return 0;
 }
 
-void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
+void erofs_bdrop(struct erofs_sb_info *sbi, struct erofs_buffer_head *bh, bool tryrevoke)
 {
 	struct erofs_buffer_block *const bb = bh->block;
 	const erofs_blk_t blkaddr = bh->block->blkaddr;
@@ -411,7 +418,7 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 
 	/* tail_blkaddr could be rolled back after revoking all bhs */
 	if (tryrevoke && blkaddr != NULL_ADDR &&
-	    tail_blkaddr == blkaddr + BLK_ROUND_UP(&sbi, bb->buffers.off))
+	    sbi->balloc->tail_blkaddr == blkaddr + BLK_ROUND_UP(sbi, bb->buffers.off))
 		rollback = true;
 
 	bh->op = &erofs_drop_directly_bhops;
@@ -421,13 +428,21 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 		return;
 
 	if (!rollback && bb->type != DATA)
-		erofs_metablkcnt += BLK_ROUND_UP(&sbi, bb->buffers.off);
-	erofs_bfree(bb);
+		sbi->balloc->erofs_metablkcnt += BLK_ROUND_UP(sbi, bb->buffers.off);
+	erofs_bfree(sbi, bb);
 	if (rollback)
-		tail_blkaddr = blkaddr;
+		sbi->balloc->tail_blkaddr = blkaddr;
 }
 
-erofs_blk_t erofs_total_metablocks(void)
+erofs_blk_t erofs_total_metablocks(struct erofs_sb_info *sbi)
 {
-	return erofs_metablkcnt;
+	return sbi->balloc->erofs_metablkcnt;
+}
+
+void erofs_bexit(struct erofs_sb_info *sbi)
+{
+	if (sbi->balloc) {
+		free(sbi->balloc);
+		sbi->balloc = NULL;
+	}
 }
diff --git a/lib/super.c b/lib/super.c
index 3fbaf66..2efa193 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -149,6 +149,7 @@ void erofs_put_super(struct erofs_sb_info *sbi)
 		sbi->devs = NULL;
 	}
 	erofs_xattr_prefixes_cleanup(sbi);
+	erofs_bexit(sbi);
 }
 
 int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
@@ -176,7 +177,7 @@ int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
 	char *buf;
 	int ret;
 
-	*blocks         = erofs_mapbh(NULL);
+	*blocks         = erofs_mapbh(sbi, NULL);
 	sb.blocks       = cpu_to_le32(*blocks);
 	memcpy(sb.uuid, sbi->uuid, sizeof(sb.uuid));
 	memcpy(sb.volume_name, sbi->volume_name, sizeof(sb.volume_name));
@@ -194,42 +195,42 @@ int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
 	}
 	memcpy(buf + EROFS_SUPER_OFFSET, &sb, sizeof(sb));
 
-	ret = erofs_dev_write(sbi, buf, sb_bh ? erofs_btell(sb_bh, false) : 0,
+	ret = erofs_dev_write(sbi, buf, sb_bh ? erofs_btell(sbi, sb_bh, false) : 0,
 			      EROFS_SUPER_END);
 	free(buf);
 	if (sb_bh)
-		erofs_bdrop(sb_bh, false);
+		erofs_bdrop(sbi, sb_bh, false);
 	return ret;
 }
 
-struct erofs_buffer_head *erofs_reserve_sb(void)
+struct erofs_buffer_head *erofs_reserve_sb(struct erofs_sb_info *sbi)
 {
 	struct erofs_buffer_head *bh;
 	int err;
 
-	erofs_buffer_init(0);
-	bh = erofs_balloc(META, 0, 0, 0);
+	erofs_buffer_init(sbi, 0);
+	bh = erofs_balloc(sbi, META, 0, 0, 0);
 	if (IS_ERR(bh)) {
 		erofs_err("failed to allocate super: %s", PTR_ERR(bh));
 		return bh;
 	}
 	bh->op = &erofs_skip_write_bhops;
-	err = erofs_bh_balloon(bh, EROFS_SUPER_END);
+	err = erofs_bh_balloon(sbi, bh, EROFS_SUPER_END);
 	if (err < 0) {
 		erofs_err("failed to balloon super: %s", erofs_strerror(err));
 		goto err_bdrop;
 	}
 
 	/* make sure that the super block should be the very first blocks */
-	(void)erofs_mapbh(bh->block);
-	if (erofs_btell(bh, false) != 0) {
+	(void)erofs_mapbh(sbi, bh->block);
+	if (erofs_btell(sbi, bh, false) != 0) {
 		erofs_err("failed to pin super block @ 0");
 		err = -EFAULT;
 		goto err_bdrop;
 	}
 	return bh;
 err_bdrop:
-	erofs_bdrop(bh, true);
+	erofs_bdrop(sbi, bh, true);
 	return ERR_PTR(err);
 }
 
-- 
2.39.3

