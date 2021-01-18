Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4B52FA015
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jan 2021 13:42:44 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DKBJd10NnzDr3l
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jan 2021 23:42:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DKB830BfKzDr2s
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Jan 2021 23:35:14 +1100 (AEDT)
Received: from DESKTOP-N4CECTO.scut-smil.cn (unknown [125.216.246.30])
 by front (Coremail) with SMTP id AWSowAC3WABogAVgh4zKAQ--.57876S4;
 Mon, 18 Jan 2021 20:34:50 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: Gao Xiang <xiang@kernel.org>
Subject: [PATCH v5 2/2] erofs-utils: optimize buffer allocation logic
Date: Mon, 18 Jan 2021 20:34:31 +0800
Message-Id: <20210118123431.22533-1-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210116063106.5031-1-hsiangkao@aol.com>
References: <20210116063106.5031-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowAC3WABogAVgh4zKAQ--.57876S4
X-Coremail-Antispam: 1UD129KBjvJXoW3XFy5Aw18Xw18KF18Xr1kZrb_yoWxuF4xpF
 9IyF1ktrWkXr1S9Fn7twnxtryfX3s3XF1Fk3yrCwnavw45JrWvgFyDJF98ArWrKrZ7Xr42
 qF42934rCFWjkrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0E
 wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
 80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
 I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
 k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
 c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUUU==
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAFBlepTBDbawABsR
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
Cc: Hu Weiwen <sehuww@mail.scut.edu.cn>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When using EROFS to pack our dataset which consists of millions of
files, mkfs.erofs is very slow compared with mksquashfs.

The bottleneck is `erofs_balloc' and `erofs_mapbh' function, which
iterate over all previously allocated buffer blocks, making the
complexity of the algrithm O(N^2) where N is the number of files.

With this patch:

* global `last_mapped_block' is mantained to avoid full scan in
`erofs_mapbh` function.

* global `mapped_buckets' maintains a list of already mapped buffer
blocks for each type and for each possible used bytes in the last
EROFS_BLKSIZ. Then it is used to identify the most suitable blocks in
future `erofs_balloc', avoiding full scan. Note that not-mapped (and the
last mapped) blocks can be expended, so we deal with them separately.

When I test it with ImageNet dataset (1.33M files, 147GiB), it takes
about 4 hours. Most time is spent on IO.

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 include/erofs/cache.h |  1 +
 lib/cache.c           | 94 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 83 insertions(+), 12 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index f8dff67..611ca5b 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -39,6 +39,7 @@ struct erofs_buffer_head {
 
 struct erofs_buffer_block {
 	struct list_head list;
+	struct list_head mapped_list;
 
 	erofs_blk_t blkaddr;
 	int type;
diff --git a/lib/cache.c b/lib/cache.c
index 32a5831..9e65429 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -18,6 +18,11 @@ static struct erofs_buffer_block blkh = {
 };
 static erofs_blk_t tail_blkaddr;
 
+/* buckets for all mapped buffer blocks to boost up allocation */
+static struct list_head mapped_buckets[2][EROFS_BLKSIZ];
+/* last mapped buffer block to accelerate erofs_mapbh() */
+static struct erofs_buffer_block *last_mapped_block = &blkh;
+
 static bool erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
 {
 	return erofs_bh_flush_generic_end(bh);
@@ -62,15 +67,32 @@ struct erofs_bhops erofs_buf_write_bhops = {
 /* return buffer_head of erofs super block (with size 0) */
 struct erofs_buffer_head *erofs_buffer_init(void)
 {
+	int i, j;
 	struct erofs_buffer_head *bh = erofs_balloc(META, 0, 0, 0);
 
 	if (IS_ERR(bh))
 		return bh;
 
 	bh->op = &erofs_skip_write_bhops;
+
+	for (i = 0; i < ARRAY_SIZE(mapped_buckets); i++)
+		for (j = 0; j < ARRAY_SIZE(mapped_buckets[0]); j++)
+			init_list_head(&mapped_buckets[i][j]);
 	return bh;
 }
 
+static void erofs_bupdate_mapped(struct erofs_buffer_block *bb)
+{
+	struct list_head *bkt;
+
+	if (bb->blkaddr == NULL_ADDR)
+		return;
+
+	bkt = mapped_buckets[bb->type] + bb->buffers.off % EROFS_BLKSIZ;
+	list_del(&bb->mapped_list);
+	list_add_tail(&bb->mapped_list, bkt);
+}
+
 /* return occupied bytes in specific buffer block if succeed */
 static int __erofs_battach(struct erofs_buffer_block *bb,
 			   struct erofs_buffer_head *bh,
@@ -110,6 +132,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 		/* need to update the tail_blkaddr */
 		if (tailupdate)
 			tail_blkaddr = blkaddr + BLK_ROUND_UP(bb->buffers.off);
+		erofs_bupdate_mapped(bb);
 	}
 	return (alignedoffset + incr) % EROFS_BLKSIZ;
 }
@@ -131,21 +154,57 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 {
 	struct erofs_buffer_block *cur, *bb;
 	struct erofs_buffer_head *bh;
-	unsigned int alignsize, used0, usedmax;
+	unsigned int alignsize, used0, usedmax, used;
+	int used_before;
 
 	int ret = get_alignsize(type, &type);
 
 	if (ret < 0)
 		return ERR_PTR(ret);
+
+	DBG_BUGON(type < 0 || type > META);
 	alignsize = ret;
 
 	used0 = (size + required_ext) % EROFS_BLKSIZ + inline_ext;
 	usedmax = 0;
 	bb = NULL;
 
-	list_for_each_entry(cur, &blkh.list, list) {
-		unsigned int used_before, used;
+	if (!used0 || alignsize == EROFS_BLKSIZ)
+		goto alloc;
+
+	/* try to find a most-fit mapped buffer block first */
+	used_before = EROFS_BLKSIZ -
+		round_up(size + required_ext + inline_ext, alignsize);
+	for (;used_before > 0; used_before--) {
+		struct list_head *bt = mapped_buckets[type] + used_before;
+
+		if (list_empty(bt))
+			continue;
+		cur = list_first_entry(bt, struct erofs_buffer_block,
+				       mapped_list);
+
+		/* last mapped block can be expended, don't handle it here */
+		if (cur == last_mapped_block)
+			continue;
+
+		ret = __erofs_battach(cur, NULL, size, alignsize,
+				      required_ext + inline_ext, true);
+		DBG_BUGON(ret < 0);
+
+		/* should contain all data in the current block */
+		used = ret + required_ext + inline_ext;
+		DBG_BUGON(used > EROFS_BLKSIZ);
+
+		bb = cur;
+		usedmax = used;
+		break;
+	}
 
+	/* try to start from the last mapped one, which can be expended */
+	cur = last_mapped_block;
+	if (cur == &blkh)
+		cur = list_next_entry(cur, list);
+	for (; cur != &blkh; cur = list_next_entry(cur, list)) {
 		used_before = cur->buffers.off % EROFS_BLKSIZ;
 
 		/* skip if buffer block is just full */
@@ -187,6 +246,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 		goto found;
 	}
 
+alloc:
 	/* allocate a new buffer block */
 	if (used0 > EROFS_BLKSIZ)
 		return ERR_PTR(-ENOSPC);
@@ -200,6 +260,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 	bb->buffers.off = 0;
 	init_list_head(&bb->buffers.list);
 	list_add_tail(&bb->list, &blkh.list);
+	init_list_head(&bb->mapped_list);
 
 	bh = malloc(sizeof(struct erofs_buffer_head));
 	if (!bh) {
@@ -247,8 +308,11 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 {
 	erofs_blk_t blkaddr;
 
-	if (bb->blkaddr == NULL_ADDR)
+	if (bb->blkaddr == NULL_ADDR) {
 		bb->blkaddr = tail_blkaddr;
+		last_mapped_block = bb;
+		erofs_bupdate_mapped(bb);
+	}
 
 	blkaddr = bb->blkaddr + BLK_ROUND_UP(bb->buffers.off);
 	if (blkaddr > tail_blkaddr)
@@ -259,15 +323,16 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 
 erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb)
 {
-	struct erofs_buffer_block *t, *nt;
+	struct erofs_buffer_block *t = last_mapped_block;
 
-	if (!bb || bb->blkaddr == NULL_ADDR) {
-		list_for_each_entry_safe(t, nt, &blkh.list, list) {
-			(void)__erofs_mapbh(t);
-			if (t == bb)
-				break;
-		}
-	}
+	do {
+		t = list_next_entry(t, list);
+		if (t == &blkh)
+			break;
+
+		DBG_BUGON(t->blkaddr != NULL_ADDR);
+		(void)__erofs_mapbh(t);
+	} while (t != bb);
 	return tail_blkaddr;
 }
 
@@ -309,6 +374,7 @@ bool erofs_bflush(struct erofs_buffer_block *bb)
 
 		erofs_dbg("block %u to %u flushed", p->blkaddr, blkaddr - 1);
 
+		list_del(&p->mapped_list);
 		list_del(&p->list);
 		free(p);
 	}
@@ -332,6 +398,10 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 	if (!list_empty(&bb->buffers.list))
 		return;
 
+	if (bb == last_mapped_block)
+		last_mapped_block = list_prev_entry(bb, list);
+
+	list_del(&bb->mapped_list);
 	list_del(&bb->list);
 	free(bb);
 
-- 
2.30.0

