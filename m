Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BD892CD05
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 10:29:29 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aih2CeEY;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WJrck5Z9Gz3cb7
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jul 2024 18:29:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aih2CeEY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WJrcW0bYTz3bqB
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jul 2024 18:29:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720600150; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=w7DFpXmnMZ2FQSnCDGosP1xozwSmeLXDd6gL+YsieCc=;
	b=aih2CeEYHwv6aPSrxV/WvXqoofcMcUiqBpU+1XFohBP8lDirIIQpVtdp4JsIDpPxvnB05aDCxeBzbTDHJ/E0g3ZxkRaVOJZaykeRcCaDPRM0ZN6VQQWGajkpjmAsfw7MnzESt2nwvdICc5iBh5K9z0RD3MH+HT+q4z4mXoiyAvo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WAElcwQ_1720600148;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WAElcwQ_1720600148)
          by smtp.aliyun-inc.com;
          Wed, 10 Jul 2024 16:29:09 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs-utils: add per-sbi buffer support
Date: Wed, 10 Jul 2024 16:29:06 +0800
Message-ID: <20240710082906.203180-2-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240710082906.203180-1-hongzhen@linux.alibaba.com>
References: <20240710082906.203180-1-hongzhen@linux.alibaba.com>
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

This updates all relevant function definitions and callers
to get rid of the global g_sbi, making it suitable for external
use in liberofs.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: Changes since v1: utilize `bb->buffers.fsprivate` to store `sbi` to minimize code changes. 
v1: https://lore.kernel.org/all/20240710065929.114911-2-hongzhen@linux.alibaba.com/
---
 include/erofs/cache.h    |  31 ++++++---
 include/erofs/internal.h |   5 +-
 lib/blobchunk.c          |  10 +--
 lib/cache.c              | 135 +++++++++++++++++++++++----------------
 lib/compress.c           |  16 ++---
 lib/inode.c              |  23 +++----
 lib/super.c              |  11 ++--
 lib/xattr.c              |   4 +-
 mkfs/main.c              |  15 +++--
 9 files changed, 146 insertions(+), 104 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 288843e..f501449 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -53,10 +53,20 @@ struct erofs_buffer_block {
 	struct erofs_buffer_head buffers;
 };
 
-static inline const int get_alignsize(int type, int *type_ret)
-{
-	struct erofs_sb_info *sbi = &g_sbi;
+struct erofs_buffer_manager {
+	struct erofs_buffer_block blkh;
+	erofs_blk_t tail_blkaddr, erofs_metablkcnt;
+
+	/* buckets for all mapped buffer blocks to boost up allocation */
+	struct list_head mapped_buckets[META + 1][EROFS_MAX_BLOCK_SIZE];
 
+	/* last mapped buffer block to accelerate erofs_mapbh() */
+	struct erofs_buffer_block *last_mapped_block;
+};
+
+static inline const int get_alignsize(struct erofs_sb_info *sbi, int type,
+				      int *type_ret)
+{
 	if (type == DATA)
 		return erofs_blksiz(sbi);
 
@@ -85,7 +95,7 @@ extern const struct erofs_bhops erofs_skip_write_bhops;
 static inline erofs_off_t erofs_btell(struct erofs_buffer_head *bh, bool end)
 {
 	const struct erofs_buffer_block *bb = bh->block;
-	struct erofs_sb_info *sbi = &g_sbi;
+	struct erofs_sb_info *sbi = (struct erofs_sb_info *)bb->buffers.fsprivate;
 
 	if (bb->blkaddr == NULL_ADDR)
 		return NULL_ADDR_UL;
@@ -101,20 +111,23 @@ static inline int erofs_bh_flush_generic_end(struct erofs_buffer_head *bh)
 	return 0;
 }
 
-void erofs_buffer_init(erofs_blk_t startblk);
+void erofs_buffer_init(struct erofs_sb_info *sbi, erofs_blk_t startblk);
 int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr);
 
-struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
+struct erofs_buffer_head *erofs_balloc(struct erofs_sb_info *sbi,
+				       int type, erofs_off_t size,
 				       unsigned int required_ext,
 				       unsigned int inline_ext);
 struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 					int type, unsigned int size);
 
-erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb);
-int erofs_bflush(struct erofs_buffer_block *bb);
+erofs_blk_t erofs_mapbh(struct erofs_sb_info *sbi,
+			struct erofs_buffer_block *bb);
+int erofs_bflush(struct erofs_sb_info *sbi, struct erofs_buffer_block *bb);
 
 void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
-erofs_blk_t erofs_total_metablocks(void);
+erofs_blk_t erofs_total_metablocks(struct erofs_sb_info *sbi);
+void erofs_buffer_exit(struct erofs_sb_info *sbi);
 
 #ifdef __cplusplus
 }
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 5f70570..bad9f13 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -58,6 +58,7 @@ extern struct erofs_sb_info g_sbi;
 	(roundup(addr, erofs_blksiz(sbi)) >> (sbi)->blkszbits)
 
 struct erofs_buffer_head;
+struct erofs_buffer_manager;
 
 struct erofs_device_info {
 	u8 tag[64];
@@ -132,6 +133,8 @@ struct erofs_sb_info {
 	struct erofs_mkfs_dfops *mkfs_dfops;
 #endif
 	bool useqpl;
+
+	struct erofs_buffer_manager *bmngr;
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
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 9af223d..da665cc 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -496,7 +496,7 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 		unsigned int i, ret;
 		erofs_blk_t nblocks;
 
-		nblocks = erofs_mapbh(NULL);
+		nblocks = erofs_mapbh(sbi, NULL);
 		pos_out = erofs_btell(bh_devt, false);
 		i = 0;
 		do {
@@ -517,11 +517,11 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 		return 0;
 	}
 
-	bh = erofs_balloc(DATA, datablob_size, 0, 0);
+	bh = erofs_balloc(sbi, DATA, datablob_size, 0, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
-	erofs_mapbh(bh->block);
+	erofs_mapbh(sbi, bh->block);
 
 	pos_out = erofs_btell(bh, false);
 	remapped_base = erofs_blknr(sbi, pos_out);
@@ -626,13 +626,13 @@ int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int devices)
 	if (!sbi->devs)
 		return -ENOMEM;
 
-	bh_devt = erofs_balloc(DEVT,
+	bh_devt = erofs_balloc(sbi, DEVT,
 		sizeof(struct erofs_deviceslot) * devices, 0, 0);
 	if (IS_ERR(bh_devt)) {
 		free(sbi->devs);
 		return PTR_ERR(bh_devt);
 	}
-	erofs_mapbh(bh_devt->block);
+	erofs_mapbh(sbi, bh_devt->block);
 	bh_devt->op = &erofs_skip_write_bhops;
 	sbi->devt_slotoff = erofs_btell(bh_devt, false) / EROFS_DEVT_SLOT_SIZE;
 	sbi->extra_devices = devices;
diff --git a/lib/cache.c b/lib/cache.c
index 69a3055..4fefbf2 100644
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
@@ -38,25 +27,35 @@ const struct erofs_bhops erofs_skip_write_bhops = {
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
+	sbi->bmngr = malloc(sizeof(struct erofs_buffer_manager));
+	if (!sbi->bmngr) {
+		erofs_err("fail to prepare buffer manager");
+		return;
+	}
+	init_list_head(&sbi->bmngr->blkh.list);
+	sbi->bmngr->blkh.blkaddr = NULL_ADDR;
+	sbi->bmngr->last_mapped_block = &sbi->bmngr->blkh;
+
+	for (i = 0; i < ARRAY_SIZE(sbi->bmngr->mapped_buckets); i++)
+		for (j = 0; j < ARRAY_SIZE(sbi->bmngr->mapped_buckets[0]); j++)
+			init_list_head(&sbi->bmngr->mapped_buckets[i][j]);
+	sbi->bmngr->tail_blkaddr = startblk;
 }
 
 static void erofs_bupdate_mapped(struct erofs_buffer_block *bb)
 {
 	struct list_head *bkt;
-	struct erofs_sb_info *sbi = &g_sbi;
+	struct erofs_sb_info *sbi = (struct erofs_sb_info *)
+						bb->buffers.fsprivate;
 
 	if (bb->blkaddr == NULL_ADDR)
 		return;
 
-	bkt = mapped_buckets[bb->type] +
+	bkt = sbi->bmngr->mapped_buckets[bb->type] +
 		(bb->buffers.off & (erofs_blksiz(sbi) - 1));
 	list_del(&bb->mapped_list);
 	list_add_tail(&bb->mapped_list, bkt);
@@ -70,7 +69,8 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 			   unsigned int extrasize,
 			   bool dryrun)
 {
-	struct erofs_sb_info *sbi = &g_sbi;
+	struct erofs_sb_info *sbi = (struct erofs_sb_info *)
+						bb->buffers.fsprivate;
 	const unsigned int blksiz = erofs_blksiz(sbi);
 	const unsigned int blkmask = blksiz - 1;
 	erofs_off_t boff = bb->buffers.off;
@@ -87,7 +87,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 
 		blkaddr = bb->blkaddr;
 		if (blkaddr != NULL_ADDR) {
-			tailupdate = (tail_blkaddr == blkaddr +
+			tailupdate = (sbi->bmngr->tail_blkaddr == blkaddr +
 				      BLK_ROUND_UP(sbi, boff));
 			if (oob && !tailupdate)
 				return -EINVAL;
@@ -104,8 +104,9 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 		bb->buffers.off = boff;
 		/* need to update the tail_blkaddr */
 		if (tailupdate)
-			tail_blkaddr = blkaddr + BLK_ROUND_UP(sbi, boff);
-		erofs_bupdate_mapped(bb);
+			sbi->bmngr->tail_blkaddr = blkaddr +
+						BLK_ROUND_UP(sbi, boff);
+		erofs_bupdate_mapped( bb);
 	}
 	return ((alignedoffset + incr - 1) & blkmask) + 1;
 }
@@ -121,13 +122,13 @@ int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr)
 	return __erofs_battach(bb, NULL, incr, 1, 0, false);
 }
 
-static int erofs_bfind_for_attach(int type, erofs_off_t size,
+static int erofs_bfind_for_attach(struct erofs_sb_info *sbi,
+				  int type, erofs_off_t size,
 				  unsigned int required_ext,
 				  unsigned int inline_ext,
 				  unsigned int alignsize,
 				  struct erofs_buffer_block **bbp)
 {
-	struct erofs_sb_info *sbi = &g_sbi;
 	const unsigned int blksiz = erofs_blksiz(sbi);
 	struct erofs_buffer_block *cur, *bb;
 	unsigned int used0, used_before, usedmax, used;
@@ -153,7 +154,8 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 	used_before = rounddown(blksiz -
 				(size + required_ext + inline_ext), alignsize);
 	for (; used_before; --used_before) {
-		struct list_head *bt = mapped_buckets[type] + used_before;
+		struct list_head *bt = sbi->bmngr->mapped_buckets[type] +
+								used_before;
 
 		if (list_empty(bt))
 			continue;
@@ -162,7 +164,7 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 
 		/* last mapped block can be expended, don't handle it here */
 		if (list_next_entry(cur, list)->blkaddr == NULL_ADDR) {
-			DBG_BUGON(cur != last_mapped_block);
+			DBG_BUGON(cur != sbi->bmngr->last_mapped_block);
 			continue;
 		}
 
@@ -188,10 +190,10 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 
 skip_mapped:
 	/* try to start from the last mapped one, which can be expended */
-	cur = last_mapped_block;
-	if (cur == &blkh)
+	cur = sbi->bmngr->last_mapped_block;
+	if (cur == &sbi->bmngr->blkh)
 		cur = list_next_entry(cur, list);
-	for (; cur != &blkh; cur = list_next_entry(cur, list)) {
+	for (; cur != &sbi->bmngr->blkh; cur = list_next_entry(cur, list)) {
 		used_before = cur->buffers.off & (blksiz - 1);
 
 		/* skip if buffer block is just full */
@@ -229,7 +231,8 @@ skip_mapped:
 	return 0;
 }
 
-struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
+struct erofs_buffer_head *erofs_balloc(struct erofs_sb_info *sbi,
+				       int type, erofs_off_t size,
 				       unsigned int required_ext,
 				       unsigned int inline_ext)
 {
@@ -237,7 +240,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 	struct erofs_buffer_head *bh;
 	unsigned int alignsize;
 
-	int ret = get_alignsize(type, &type);
+	int ret = get_alignsize(sbi, type, &type);
 
 	if (ret < 0)
 		return ERR_PTR(ret);
@@ -246,7 +249,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 	alignsize = ret;
 
 	/* try to find if we could reuse an allocated buffer block */
-	ret = erofs_bfind_for_attach(type, size, required_ext, inline_ext,
+	ret = erofs_bfind_for_attach(sbi, type, size, required_ext, inline_ext,
 				     alignsize, &bb);
 	if (ret)
 		return ERR_PTR(ret);
@@ -264,11 +267,13 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 		bb->type = type;
 		bb->blkaddr = NULL_ADDR;
 		bb->buffers.off = 0;
+		bb->buffers.fsprivate = sbi;
 		init_list_head(&bb->buffers.list);
 		if (type == DATA)
-			list_add(&bb->list, &last_mapped_block->list);
+			list_add(&bb->list,
+				&sbi->bmngr->last_mapped_block->list);
 		else
-			list_add_tail(&bb->list, &blkh.list);
+			list_add_tail(&bb->list, &sbi->bmngr->blkh.list);
 		init_list_head(&bb->mapped_list);
 
 		bh = malloc(sizeof(struct erofs_buffer_head));
@@ -293,7 +298,10 @@ struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 	struct erofs_buffer_block *const bb = bh->block;
 	struct erofs_buffer_head *nbh;
 	unsigned int alignsize;
-	int ret = get_alignsize(type, &type);
+	struct erofs_sb_info *sbi = (struct erofs_sb_info *)
+						bb->buffers.fsprivate;
+
+	int ret = get_alignsize(sbi, type, &type);
 
 	if (ret < 0)
 		return ERR_PTR(ret);
@@ -318,58 +326,62 @@ struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 {
 	erofs_blk_t blkaddr;
-	struct erofs_sb_info *sbi = &g_sbi;
+	struct erofs_sb_info *sbi = (struct erofs_sb_info *)
+						bb->buffers.fsprivate;
 
 	if (bb->blkaddr == NULL_ADDR) {
-		bb->blkaddr = tail_blkaddr;
-		last_mapped_block = bb;
+		bb->blkaddr = sbi->bmngr->tail_blkaddr;
+		sbi->bmngr->last_mapped_block = bb;
 		erofs_bupdate_mapped(bb);
 	}
 
 	blkaddr = bb->blkaddr + BLK_ROUND_UP(sbi, bb->buffers.off);
-	if (blkaddr > tail_blkaddr)
-		tail_blkaddr = blkaddr;
+	if (blkaddr > sbi->bmngr->tail_blkaddr)
+		sbi->bmngr->tail_blkaddr = blkaddr;
 
 	return blkaddr;
 }
 
-erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb)
+erofs_blk_t erofs_mapbh(struct erofs_sb_info *sbi,
+			struct erofs_buffer_block *bb)
 {
-	struct erofs_buffer_block *t = last_mapped_block;
+	struct erofs_buffer_block *t = sbi->bmngr->last_mapped_block;
 
 	if (bb && bb->blkaddr != NULL_ADDR)
 		return bb->blkaddr;
 	do {
 		t = list_next_entry(t, list);
-		if (t == &blkh)
+		if (t == &sbi->bmngr->blkh)
 			break;
 
 		DBG_BUGON(t->blkaddr != NULL_ADDR);
 		(void)__erofs_mapbh(t);
 	} while (t != bb);
-	return tail_blkaddr;
+	return sbi->bmngr->tail_blkaddr;
 }
 
 static void erofs_bfree(struct erofs_buffer_block *bb)
 {
+	struct erofs_sb_info *sbi = (struct erofs_sb_info *)
+						bb->buffers.fsprivate;
+
 	DBG_BUGON(!list_empty(&bb->buffers.list));
 
-	if (bb == last_mapped_block)
-		last_mapped_block = list_prev_entry(bb, list);
+	if (bb == sbi->bmngr->last_mapped_block)
+		sbi->bmngr->last_mapped_block = list_prev_entry(bb, list);
 
 	list_del(&bb->mapped_list);
 	list_del(&bb->list);
 	free(bb);
 }
 
-int erofs_bflush(struct erofs_buffer_block *bb)
+int erofs_bflush(struct erofs_sb_info *sbi, struct erofs_buffer_block *bb)
 {
-	struct erofs_sb_info *sbi = &g_sbi;
 	const unsigned int blksiz = erofs_blksiz(sbi);
 	struct erofs_buffer_block *p, *n;
 	erofs_blk_t blkaddr;
 
-	list_for_each_entry_safe(p, n, &blkh.list, list) {
+	list_for_each_entry_safe(p, n, &sbi->bmngr->blkh.list, list) {
 		struct erofs_buffer_head *bh, *nbh;
 		unsigned int padding;
 		bool skip = false;
@@ -401,7 +413,8 @@ int erofs_bflush(struct erofs_buffer_block *bb)
 					   padding, true);
 
 		if (p->type != DATA)
-			erofs_metablkcnt += BLK_ROUND_UP(sbi, p->buffers.off);
+			sbi->bmngr->erofs_metablkcnt += BLK_ROUND_UP(sbi,
+								p->buffers.off);
 		erofs_dbg("block %u to %u flushed", p->blkaddr, blkaddr - 1);
 		erofs_bfree(p);
 	}
@@ -413,11 +426,13 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 	struct erofs_buffer_block *const bb = bh->block;
 	const erofs_blk_t blkaddr = bh->block->blkaddr;
 	bool rollback = false;
-	struct erofs_sb_info *sbi = &g_sbi;
+	struct erofs_sb_info *sbi = (struct erofs_sb_info *)
+						bb->buffers.fsprivate;
 
 	/* tail_blkaddr could be rolled back after revoking all bhs */
 	if (tryrevoke && blkaddr != NULL_ADDR &&
-	    tail_blkaddr == blkaddr + BLK_ROUND_UP(sbi, bb->buffers.off))
+	    sbi->bmngr->tail_blkaddr == blkaddr + BLK_ROUND_UP(sbi,
+							bb->buffers.off))
 		rollback = true;
 
 	bh->op = &erofs_drop_directly_bhops;
@@ -427,13 +442,21 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 		return;
 
 	if (!rollback && bb->type != DATA)
-		erofs_metablkcnt += BLK_ROUND_UP(sbi, bb->buffers.off);
+		sbi->bmngr->erofs_metablkcnt += BLK_ROUND_UP(sbi, bb->buffers.off);
 	erofs_bfree(bb);
 	if (rollback)
-		tail_blkaddr = blkaddr;
+		sbi->bmngr->tail_blkaddr = blkaddr;
 }
 
-erofs_blk_t erofs_total_metablocks(void)
+erofs_blk_t erofs_total_metablocks(struct erofs_sb_info *sbi)
 {
-	return erofs_metablkcnt;
+	return sbi->bmngr->erofs_metablkcnt;
 }
+
+void erofs_buffer_exit(struct erofs_sb_info *sbi)
+{
+	if (sbi->bmngr) {
+		free(sbi->bmngr);
+		sbi->bmngr= NULL;
+	}
+}
\ No newline at end of file
diff --git a/lib/compress.c b/lib/compress.c
index b473587..4cc2cbe 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1366,14 +1366,14 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 		pthread_cond_wait(&ictx->cond, &ictx->mutex);
 	pthread_mutex_unlock(&ictx->mutex);
 
-	bh = erofs_balloc(DATA, 0, 0, 0);
+	bh = erofs_balloc(ictx->inode->sbi, DATA, 0, 0, 0);
 	if (IS_ERR(bh)) {
 		ret = PTR_ERR(bh);
 		goto out;
 	}
 
 	DBG_BUGON(!head);
-	blkaddr = erofs_mapbh(bh->block);
+	blkaddr = erofs_mapbh(ictx->inode->sbi, bh->block);
 
 	ret = 0;
 	do {
@@ -1531,12 +1531,12 @@ int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 #endif
 
 	/* allocate main data buffer */
-	bh = erofs_balloc(DATA, 0, 0, 0);
+	bh = erofs_balloc(inode->sbi, DATA, 0, 0, 0);
 	if (IS_ERR(bh)) {
 		ret = PTR_ERR(bh);
 		goto err_free_idata;
 	}
-	blkaddr = erofs_mapbh(bh->block); /* start_blkaddr */
+	blkaddr = erofs_mapbh(inode->sbi, bh->block); /* start_blkaddr */
 
 	ictx->seg_num = 1;
 	sctx = (struct z_erofs_compress_sctx) {
@@ -1601,7 +1601,7 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 			DBG_BUGON(1);
 			return PTR_ERR(bh);
 		}
-		erofs_mapbh(bh->block);
+		erofs_mapbh(sbi, bh->block);
 		ret = erofs_dev_write(sbi, &lz4alg, erofs_btell(bh, false),
 				      sizeof(lz4alg));
 		bh->op = &erofs_drop_directly_bhops;
@@ -1625,7 +1625,7 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 			DBG_BUGON(1);
 			return PTR_ERR(bh);
 		}
-		erofs_mapbh(bh->block);
+		erofs_mapbh(sbi, bh->block);
 		ret = erofs_dev_write(sbi, &lzmaalg, erofs_btell(bh, false),
 				      sizeof(lzmaalg));
 		bh->op = &erofs_drop_directly_bhops;
@@ -1649,7 +1649,7 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 			DBG_BUGON(1);
 			return PTR_ERR(bh);
 		}
-		erofs_mapbh(bh->block);
+		erofs_mapbh(sbi, bh->block);
 		ret = erofs_dev_write(sbi, &zalg, erofs_btell(bh, false),
 				      sizeof(zalg));
 		bh->op = &erofs_drop_directly_bhops;
@@ -1672,7 +1672,7 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 			DBG_BUGON(1);
 			return PTR_ERR(bh);
 		}
-		erofs_mapbh(bh->block);
+		erofs_mapbh(sbi, bh->block);
 		ret = erofs_dev_write(sbi, &zalg, erofs_btell(bh, false),
 				      sizeof(zalg));
 		bh->op = &erofs_drop_directly_bhops;
diff --git a/lib/inode.c b/lib/inode.c
index 8d60088..3962ff1 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -186,7 +186,8 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
 	}
 
 	/* allocate main data buffer */
-	bh = erofs_balloc(type, erofs_pos(inode->sbi, nblocks), 0, 0);
+	bh = erofs_balloc(inode->sbi, type, erofs_pos(inode->sbi, nblocks),
+									0, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
@@ -194,7 +195,7 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
 	inode->bh_data = bh;
 
 	/* get blkaddr of the bh */
-	ret = erofs_mapbh(bh->block);
+	ret = erofs_mapbh(inode->sbi, bh->block);
 	DBG_BUGON(ret < 0);
 
 	/* write blocks except for the tail-end block */
@@ -314,7 +315,7 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 	erofs_off_t off, meta_offset;
 
 	if (bh && (long long)inode->nid <= 0) {
-		erofs_mapbh(bh->block);
+		erofs_mapbh(sbi, bh->block);
 		off = erofs_btell(bh, false);
 
 		meta_offset = erofs_pos(sbi, sbi->meta_blkaddr);
@@ -768,7 +769,7 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 	}
 
-	bh = erofs_balloc(INODE, inodesize, 0, inode->idata_size);
+	bh = erofs_balloc(inode->sbi, INODE, inodesize, 0, inode->idata_size);
 	if (bh == ERR_PTR(-ENOSPC)) {
 		int ret;
 
@@ -781,7 +782,7 @@ noinline:
 		ret = erofs_prepare_tail_block(inode);
 		if (ret)
 			return ret;
-		bh = erofs_balloc(INODE, inodesize, 0, 0);
+		bh = erofs_balloc(inode->sbi, INODE, inodesize, 0, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		DBG_BUGON(inode->bh_inline);
@@ -860,13 +861,13 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		erofs_off_t pos, zero_pos;
 
 		if (!bh) {
-			bh = erofs_balloc(DATA, erofs_blksiz(sbi), 0, 0);
+			bh = erofs_balloc(sbi, DATA, erofs_blksiz(sbi), 0, 0);
 			if (IS_ERR(bh))
 				return PTR_ERR(bh);
 			bh->op = &erofs_skip_write_bhops;
 
 			/* get blkaddr of bh */
-			ret = erofs_mapbh(bh->block);
+			ret = erofs_mapbh(sbi, bh->block);
 			inode->u.i_blkaddr = bh->block->blkaddr;
 			inode->bh_data = bh;
 		} else {
@@ -879,7 +880,7 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 				}
 				inode->lazy_tailblock = false;
 			}
-			ret = erofs_mapbh(bh->block);
+			ret = erofs_mapbh(sbi, bh->block);
 		}
 		DBG_BUGON(ret < 0);
 		pos = erofs_btell(bh, true) - erofs_blksiz(sbi);
@@ -1157,7 +1158,7 @@ static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 	struct erofs_sb_info *sbi = rootdir->sbi;
 	erofs_off_t off, meta_offset;
 
-	erofs_mapbh(bh->block);
+	erofs_mapbh(sbi, bh->block);
 	off = erofs_btell(bh, false);
 
 	if (off > rootnid_maxoffset)
@@ -1176,12 +1177,12 @@ static int erofs_inode_reserve_data_blocks(struct erofs_inode *inode)
 	struct erofs_buffer_head *bh;
 
 	/* allocate data blocks */
-	bh = erofs_balloc(DATA, alignedsz, 0, 0);
+	bh = erofs_balloc(sbi, DATA, alignedsz, 0, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
 	/* get blkaddr of the bh */
-	(void)erofs_mapbh(bh->block);
+	(void)erofs_mapbh(sbi, bh->block);
 
 	/* write blocks except for the tail-end block */
 	inode->u.i_blkaddr = bh->block->blkaddr;
diff --git a/lib/super.c b/lib/super.c
index 3fbaf66..1900dcd 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -149,6 +149,7 @@ void erofs_put_super(struct erofs_sb_info *sbi)
 		sbi->devs = NULL;
 	}
 	erofs_xattr_prefixes_cleanup(sbi);
+	erofs_buffer_exit(sbi);
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
@@ -202,13 +203,13 @@ int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
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
@@ -221,7 +222,7 @@ struct erofs_buffer_head *erofs_reserve_sb(void)
 	}
 
 	/* make sure that the super block should be the very first blocks */
-	(void)erofs_mapbh(bh->block);
+	(void)erofs_mapbh(sbi, bh->block);
 	if (erofs_btell(bh, false) != 0) {
 		erofs_err("failed to pin super block @ 0");
 		err = -EFAULT;
diff --git a/lib/xattr.c b/lib/xattr.c
index b0f80e9..b0bd7a1 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -906,7 +906,7 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 		return -ENOMEM;
 	}
 
-	bh = erofs_balloc(XATTR, shared_xattrs_size, 0, 0);
+	bh = erofs_balloc(sbi, XATTR, shared_xattrs_size, 0, 0);
 	if (IS_ERR(bh)) {
 		free(sorted_n);
 		free(buf);
@@ -914,7 +914,7 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 	}
 	bh->op = &erofs_skip_write_bhops;
 
-	erofs_mapbh(bh->block);
+	erofs_mapbh(sbi, bh->block);
 	off = erofs_btell(bh, false);
 
 	sbi->xattr_blkaddr = off / erofs_blksiz(sbi);
diff --git a/mkfs/main.c b/mkfs/main.c
index 37f250b..1793fd8 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1105,7 +1105,7 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 	return 0;
 }
 
-static void erofs_mkfs_showsummaries(erofs_blk_t nblocks)
+static void erofs_mkfs_showsummaries(struct erofs_sb_info *sbi, erofs_blk_t nblocks)
 {
 	char uuid_str[37] = {};
 	char *incr = incremental_mode ? "new" : "total";
@@ -1121,7 +1121,7 @@ static void erofs_mkfs_showsummaries(erofs_blk_t nblocks)
 		"Filesystem %s metadata blocks: %u\n"
 		"Filesystem %s deduplicated bytes (of source files): %llu\n",
 		uuid_str, nblocks, 1U << g_sbi.blkszbits, g_sbi.inos | 0ULL,
-		incr, erofs_total_metablocks(),
+		incr, erofs_total_metablocks(sbi),
 		incr, g_sbi.saved_by_deduplication | 0ULL);
 }
 
@@ -1245,7 +1245,7 @@ int main(int argc, char **argv)
 	}
 
 	if (!incremental_mode) {
-		sb_bh = erofs_reserve_sb();
+		sb_bh = erofs_reserve_sb(&g_sbi);
 		if (IS_ERR(sb_bh)) {
 			err = PTR_ERR(sb_bh);
 			goto exit;
@@ -1270,7 +1270,7 @@ int main(int argc, char **argv)
 			u.startblk = DIV_ROUND_UP(u.st.st_size, erofs_blksiz(&g_sbi));
 		else
 			u.startblk = g_sbi.primarydevice_blocks;
-		erofs_buffer_init(u.startblk);
+		erofs_buffer_init(&g_sbi, u.startblk);
 		sb_bh = NULL;
 	}
 
@@ -1392,7 +1392,7 @@ int main(int argc, char **argv)
 	}
 
 	/* flush all buffers except for the superblock */
-	err = erofs_bflush(NULL);
+	err = erofs_bflush(&g_sbi, NULL);
 	if (err)
 		goto exit;
 
@@ -1405,7 +1405,7 @@ int main(int argc, char **argv)
 		goto exit;
 
 	/* flush all remaining buffers */
-	err = erofs_bflush(NULL);
+	err = erofs_bflush(&g_sbi, NULL);
 	if (err)
 		goto exit;
 
@@ -1448,6 +1448,7 @@ exit:
 		return 1;
 	}
 	erofs_update_progressinfo("Build completed.\n");
-	erofs_mkfs_showsummaries(nblocks);
+	erofs_mkfs_showsummaries(&g_sbi, nblocks);
+	erofs_put_super(&g_sbi);
 	return 0;
 }
-- 
2.43.5

