Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB052EFEAB
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Jan 2021 09:48:46 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DCYXr11HDzDr10
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Jan 2021 19:48:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=fail (SPF fail - not authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=47.90.104.110;
 helo=aliyun-sdnproxy-3.icoremail.net; envelope-from=sehuww@mail.scut.edu.cn;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none)
 header.from=mail.scut.edu.cn
Received: from aliyun-sdnproxy-3.icoremail.net (aliyun-cloud.icoremail.net
 [47.90.104.110])
 by lists.ozlabs.org (Postfix) with SMTP id 4DCYXZ6Q5pzDr0k
 for <linux-erofs@lists.ozlabs.org>; Sat,  9 Jan 2021 19:48:27 +1100 (AEDT)
Received: from DESKTOP-N4CECTO.scut-smil.cn (unknown [125.216.246.30])
 by front (Coremail) with SMTP id AWSowAAnLeEbaflfXVeLAQ--.39566S5;
 Sat, 09 Jan 2021 16:28:20 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: Gao Xiang <hsiangkao@redhat.com>, Li Guifu <bluce.liguifu@huawei.com>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: [PATCH v2 1/2] erofs-utils: optimize mkfs to O(N), N = #files
Date: Sat,  9 Jan 2021 16:28:09 +0800
Message-Id: <20210109082810.32169-2-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210109082810.32169-1-sehuww@mail.scut.edu.cn>
References: <20210108181545.GA613131@xiangao.remote.csb>
 <20210109082810.32169-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowAAnLeEbaflfXVeLAQ--.39566S5
X-Coremail-Antispam: 1UD129KBjvJXoWxKFykXr47WryxZFy8tFWxXrb_yoWxXryxpF
 ZIkF18trWkXr1fuFn7trsxA343Xwn7Xr1UCayrG3savw45Xr4v9as8JF98ArWrGr4kXr42
 qFnF9348CFWj9rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBq14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
 e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
 8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
 jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r43MxAIw2
 8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
 x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
 CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
 42IY6xAIw20EY4v20xvaj40_JFI_Gr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
 80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjzVbPUUUUU==
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAIBlepTBC2twAMsg
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

The bottleneck is `erofs_balloc` and `erofs_mapbh` function, which
iterate over all previously allocated buffer blocks, making the
complexity of the algrithm O(N^2) where N is the number of files.

With this patch:

* global `last_mapped_block` is mantained to avoid full scan in
  `erofs_mapbh` function.

* global `non_full_buffer_blocks` mantains a list of buffer block for
  each type and each possible remaining bytes in the block. Then it is
  used to identify the most suitable blocks in future `erofs_balloc`,
  avoiding full scan.

Some new data structure is allocated in this patch, more RAM usage is
expected, but not much. When I test it with ImageNet dataset (1.33M
files), 7GiB RAM is consumed, and it takes about 4 hours. Most time is
spent on IO.

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
---
 include/erofs/cache.h |  1 +
 lib/cache.c           | 89 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 77 insertions(+), 13 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 8c171f5..b5bf6c0 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -39,6 +39,7 @@ struct erofs_buffer_head {
 
 struct erofs_buffer_block {
 	struct list_head list;
+	struct list_head nonfull_list;
 
 	erofs_blk_t blkaddr;
 	int type;
diff --git a/lib/cache.c b/lib/cache.c
index 0d5c4a5..aa972d8 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -18,6 +18,15 @@ static struct erofs_buffer_block blkh = {
 };
 static erofs_blk_t tail_blkaddr;
 
+/**
+ * Some buffers are not full, we can reuse it to store more data
+ * 2 for DATA, META
+ * EROFS_BLKSIZ for each possible remaining bytes in the last block
+ **/
+static struct list_head nonfull_bb_buckets[2][EROFS_BLKSIZ];
+
+static struct erofs_buffer_block *last_mapped_block = &blkh;
+
 static bool erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
 {
 	return erofs_bh_flush_generic_end(bh);
@@ -62,6 +71,10 @@ struct erofs_bhops erofs_buf_write_bhops = {
 /* return buffer_head of erofs super block (with size 0) */
 struct erofs_buffer_head *erofs_buffer_init(void)
 {
+	for (int i = 0; i < 2; i++)
+		for (int j = 0; j < EROFS_BLKSIZ; j++)
+			init_list_head(&nonfull_bb_buckets[i][j]);
+
 	struct erofs_buffer_head *bh = erofs_balloc(META, 0, 0, 0);
 
 	if (IS_ERR(bh))
@@ -131,7 +144,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 {
 	struct erofs_buffer_block *cur, *bb;
 	struct erofs_buffer_head *bh;
-	unsigned int alignsize, used0, usedmax;
+	unsigned int alignsize, used0, usedmax, total_size;
 
 	int ret = get_alignsize(type, &type);
 
@@ -143,7 +156,36 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 	usedmax = 0;
 	bb = NULL;
 
-	list_for_each_entry(cur, &blkh.list, list) {
+	erofs_dbg("balloc size=%lu alignsize=%u used0=%u", size, alignsize, used0);
+	if (used0 == 0 || alignsize == EROFS_BLKSIZ)
+		goto alloc;
+
+	total_size = size + required_ext + inline_ext;
+	if (total_size < EROFS_BLKSIZ) {
+		// Try find a most fit block.
+		DBG_BUGON(type < 0 || type > 1);
+		struct list_head *non_fulls = nonfull_bb_buckets[type];
+		for (struct list_head *r = non_fulls + round_up(total_size, alignsize);
+				r < non_fulls + EROFS_BLKSIZ; r++) {
+			if (!list_empty(r)) {
+				struct erofs_buffer_block *reuse_candidate =
+						list_first_entry(r, struct erofs_buffer_block, nonfull_list);
+				ret = __erofs_battach(reuse_candidate, NULL, size, alignsize,
+						required_ext + inline_ext, true);
+				if (ret >= 0) {
+					bb = reuse_candidate;
+					usedmax = (ret + required_ext) % EROFS_BLKSIZ + inline_ext;
+				}
+				break;
+			}
+		}
+	}
+
+	/* Try reuse last ones, which are not mapped and can be extended */
+	cur = last_mapped_block;
+	if (cur == &blkh)
+		cur = list_next_entry(cur, list);
+	for (; cur != &blkh; cur = list_next_entry(cur, list)) {
 		unsigned int used_before, used;
 
 		used_before = cur->buffers.off % EROFS_BLKSIZ;
@@ -181,16 +223,23 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 	}
 
 	if (bb) {
+		erofs_dbg("reusing buffer. usedmax=%u", usedmax);
 		bh = malloc(sizeof(struct erofs_buffer_head));
 		if (!bh)
 			return ERR_PTR(-ENOMEM);
+		if (bb->nonfull_list.next != NULL)
+			list_del(&bb->nonfull_list);
 		goto found;
 	}
 
+alloc:
 	/* allocate a new buffer block */
-	if (used0 > EROFS_BLKSIZ)
+	if (used0 > EROFS_BLKSIZ) {
+		erofs_dbg("used0 > EROFS_BLKSIZ");
 		return ERR_PTR(-ENOSPC);
+	}
 
+	erofs_dbg("new buffer block");
 	bb = malloc(sizeof(struct erofs_buffer_block));
 	if (!bb)
 		return ERR_PTR(-ENOMEM);
@@ -211,6 +260,14 @@ found:
 			      required_ext + inline_ext, false);
 	if (ret < 0)
 		return ERR_PTR(ret);
+	if (ret == 0)
+		bb->nonfull_list.next = bb->nonfull_list.prev = NULL;
+	else {
+		/* This buffer is not full yet, we may reuse it */
+		int reusable_size = EROFS_BLKSIZ - ret - required_ext - inline_ext;
+		list_add_tail(&bb->nonfull_list, &nonfull_bb_buckets[type][reusable_size]);
+	}
+
 	return bh;
 }
 
@@ -247,8 +304,10 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 {
 	erofs_blk_t blkaddr;
 
-	if (bb->blkaddr == NULL_ADDR)
+	if (bb->blkaddr == NULL_ADDR) {
 		bb->blkaddr = tail_blkaddr;
+		last_mapped_block = bb;
+	}
 
 	blkaddr = bb->blkaddr + BLK_ROUND_UP(bb->buffers.off);
 	if (blkaddr > tail_blkaddr)
@@ -259,15 +318,16 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 
 erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb, bool end)
 {
-	struct erofs_buffer_block *t, *nt;
-
-	if (!bb || bb->blkaddr == NULL_ADDR) {
-		list_for_each_entry_safe(t, nt, &blkh.list, list) {
-			if (!end && (t == bb || nt == &blkh))
-				break;
-			(void)__erofs_mapbh(t);
-			if (end && t == bb)
-				break;
+	DBG_BUGON(!end);
+	struct erofs_buffer_block *t = last_mapped_block;
+	while (1) {
+		t = list_next_entry(t, list);
+		if (t == &blkh) {
+			break;
+		}
+		(void)__erofs_mapbh(t);
+		if (t == bb) {
+			break;
 		}
 	}
 	return tail_blkaddr;
@@ -334,6 +394,9 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 	if (!list_empty(&bb->buffers.list))
 		return;
 
+	if (bb == last_mapped_block)
+		last_mapped_block = list_prev_entry(bb, list);
+
 	list_del(&bb->list);
 	free(bb);
 
-- 
2.17.1

