Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6646770B658
	for <lists+linux-erofs@lfdr.de>; Mon, 22 May 2023 09:20:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QPpkV5QJwz3cf8
	for <lists+linux-erofs@lfdr.de>; Mon, 22 May 2023 17:20:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QPpkM3MLQz3bkk
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 May 2023 17:20:10 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vj9pHVZ_1684739999;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vj9pHVZ_1684739999)
          by smtp.aliyun-inc.com;
          Mon, 22 May 2023 15:20:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: kill hooked chains to avoid loops on deduplicated compressed images
Date: Mon, 22 May 2023 15:19:58 +0800
Message-Id: <20230522071958.110074-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230519071219.41757-1-hsiangkao@linux.alibaba.com>
References: <20230519071219.41757-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

After heavily stressing EROFS with several images which include a
hand-crafted image of repeated patterns for more than 46 days, I found
two chains could be linked with each other almost simultaneously and
form a loop so that the entire loop won't be submitted.  As a
consequence, the corresponding file pages will remain locked forever.

It can be _only_ observed on data-deduplicated compressed images.
For example, consider two chains with five pclusters in total:
	Chain 1:  2->3->4->5    -- The tail pcluster is 5;
        Chain 2:  5->1->2       -- The tail pcluster is 2.

Chain 2 could link to Chain 1 with pcluster 5; and Chain 1 could link
to Chain 2 at the same time with pcluster 2.

Since hooked chains are all linked locklessly now, I have no idea how
to simply avoid the race.  Instead, let's avoid hooked chains entirely
until a proper way could be worked out to fix this and end users finally
tell us that it's needed to add it back.

Actually, this optimization can be found with multi-threaded workloads
(especially even more often on deduplicated compressed images), yet I'm
not sure about the overall system impacts of not having this compared
with implementation complexity.

Fixes: 267f2492c8f7 ("erofs: introduce multi-reference pclusters (fully-referenced)")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - previous fix is still racy, so get rid of hooked chains entirely.

 fs/erofs/zdata.c | 69 +++++++-----------------------------------------
 1 file changed, 10 insertions(+), 59 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 45f21db2303a..92f3a01262cf 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -96,8 +96,6 @@ struct z_erofs_pcluster {
 
 /* the chained workgroup has't submitted io (still open) */
 #define Z_EROFS_PCLUSTER_TAIL           ((void *)0x5F0ECAFE)
-/* the chained workgroup has already submitted io */
-#define Z_EROFS_PCLUSTER_TAIL_CLOSED    ((void *)0x5F0EDEAD)
 
 #define Z_EROFS_PCLUSTER_NIL            (NULL)
 
@@ -501,20 +499,6 @@ int __init z_erofs_init_zip_subsystem(void)
 
 enum z_erofs_pclustermode {
 	Z_EROFS_PCLUSTER_INFLIGHT,
-	/*
-	 * The current pclusters was the tail of an exist chain, in addition
-	 * that the previous processed chained pclusters are all decided to
-	 * be hooked up to it.
-	 * A new chain will be created for the remaining pclusters which are
-	 * not processed yet, so different from Z_EROFS_PCLUSTER_FOLLOWED,
-	 * the next pcluster cannot reuse the whole page safely for inplace I/O
-	 * in the following scenario:
-	 *  ________________________________________________________________
-	 * |      tail (partial) page     |       head (partial) page       |
-	 * |   (belongs to the next pcl)  |   (belongs to the current pcl)  |
-	 * |_______PCLUSTER_FOLLOWED______|________PCLUSTER_HOOKED__________|
-	 */
-	Z_EROFS_PCLUSTER_HOOKED,
 	/*
 	 * a weak form of Z_EROFS_PCLUSTER_FOLLOWED, the difference is that it
 	 * could be dispatched into bypass queue later due to uptodated managed
@@ -532,8 +516,8 @@ enum z_erofs_pclustermode {
 	 *  ________________________________________________________________
 	 * |  tail (partial) page |          head (partial) page           |
 	 * |  (of the current cl) |      (of the previous collection)      |
-	 * | PCLUSTER_FOLLOWED or |                                        |
-	 * |_____PCLUSTER_HOOKED__|___________PCLUSTER_FOLLOWED____________|
+	 * |                      |                                        |
+	 * |__PCLUSTER_FOLLOWED___|___________PCLUSTER_FOLLOWED____________|
 	 *
 	 * [  (*) the above page can be used as inplace I/O.               ]
 	 */
@@ -546,7 +530,7 @@ struct z_erofs_decompress_frontend {
 	struct z_erofs_bvec_iter biter;
 
 	struct page *candidate_bvpage;
-	struct z_erofs_pcluster *pcl, *tailpcl;
+	struct z_erofs_pcluster *pcl;
 	z_erofs_next_pcluster_t owned_head;
 	enum z_erofs_pclustermode mode;
 
@@ -752,19 +736,7 @@ static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
 		return;
 	}
 
-	/*
-	 * type 2, link to the end of an existing open chain, be careful
-	 * that its submission is controlled by the original attached chain.
-	 */
-	if (*owned_head != &pcl->next && pcl != f->tailpcl &&
-	    cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
-		    *owned_head) == Z_EROFS_PCLUSTER_TAIL) {
-		*owned_head = Z_EROFS_PCLUSTER_TAIL;
-		f->mode = Z_EROFS_PCLUSTER_HOOKED;
-		f->tailpcl = NULL;
-		return;
-	}
-	/* type 3, it belongs to a chain, but it isn't the end of the chain */
+	/* type 2, it belongs to an ongoing chain */
 	f->mode = Z_EROFS_PCLUSTER_INFLIGHT;
 }
 
@@ -825,9 +797,6 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 			goto err_out;
 		}
 	}
-	/* used to check tail merging loop due to corrupted images */
-	if (fe->owned_head == Z_EROFS_PCLUSTER_TAIL)
-		fe->tailpcl = pcl;
 	fe->owned_head = &pcl->next;
 	fe->pcl = pcl;
 	return 0;
@@ -848,7 +817,6 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
 
 	/* must be Z_EROFS_PCLUSTER_TAIL or pointed to previous pcluster */
 	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
-	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
 
 	if (!(map->m_flags & EROFS_MAP_META)) {
 		grp = erofs_find_workgroup(fe->inode->i_sb,
@@ -867,10 +835,6 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
 
 	if (ret == -EEXIST) {
 		mutex_lock(&fe->pcl->lock);
-		/* used to check tail merging loop due to corrupted images */
-		if (fe->owned_head == Z_EROFS_PCLUSTER_TAIL)
-			fe->tailpcl = fe->pcl;
-
 		z_erofs_try_to_claim_pcluster(fe);
 	} else if (ret) {
 		return ret;
@@ -1027,8 +991,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	 * those chains are handled asynchronously thus the page cannot be used
 	 * for inplace I/O or bvpage (should be processed in a strict order.)
 	 */
-	tight &= (fe->mode >= Z_EROFS_PCLUSTER_HOOKED &&
-		  fe->mode != Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
+	tight &= (fe->mode > Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
 
 	cur = end - min_t(unsigned int, offset + end - map->m_la, end);
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
@@ -1406,10 +1369,7 @@ static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 	};
 	z_erofs_next_pcluster_t owned = io->head;
 
-	while (owned != Z_EROFS_PCLUSTER_TAIL_CLOSED) {
-		/* impossible that 'owned' equals Z_EROFS_WORK_TPTR_TAIL */
-		DBG_BUGON(owned == Z_EROFS_PCLUSTER_TAIL);
-		/* impossible that 'owned' equals Z_EROFS_PCLUSTER_NIL */
+	while (owned != Z_EROFS_PCLUSTER_TAIL) {
 		DBG_BUGON(owned == Z_EROFS_PCLUSTER_NIL);
 
 		be.pcl = container_of(owned, struct z_erofs_pcluster, next);
@@ -1426,7 +1386,7 @@ static void z_erofs_decompressqueue_work(struct work_struct *work)
 		container_of(work, struct z_erofs_decompressqueue, u.work);
 	struct page *pagepool = NULL;
 
-	DBG_BUGON(bgq->head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
+	DBG_BUGON(bgq->head == Z_EROFS_PCLUSTER_TAIL);
 	z_erofs_decompress_queue(bgq, &pagepool);
 	erofs_release_pages(&pagepool);
 	kvfree(bgq);
@@ -1614,7 +1574,7 @@ static struct z_erofs_decompressqueue *jobqueue_init(struct super_block *sb,
 		q->sync = true;
 	}
 	q->sb = sb;
-	q->head = Z_EROFS_PCLUSTER_TAIL_CLOSED;
+	q->head = Z_EROFS_PCLUSTER_TAIL;
 	return q;
 }
 
@@ -1632,11 +1592,7 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 	z_erofs_next_pcluster_t *const submit_qtail = qtail[JQ_SUBMIT];
 	z_erofs_next_pcluster_t *const bypass_qtail = qtail[JQ_BYPASS];
 
-	DBG_BUGON(owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
-	if (owned_head == Z_EROFS_PCLUSTER_TAIL)
-		owned_head = Z_EROFS_PCLUSTER_TAIL_CLOSED;
-
-	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_TAIL_CLOSED);
+	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_TAIL);
 
 	WRITE_ONCE(*submit_qtail, owned_head);
 	WRITE_ONCE(*bypass_qtail, &pcl->next);
@@ -1707,15 +1663,10 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 		unsigned int i = 0;
 		bool bypass = true;
 
-		/* no possible 'owned_head' equals the following */
-		DBG_BUGON(owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
 		DBG_BUGON(owned_head == Z_EROFS_PCLUSTER_NIL);
-
 		pcl = container_of(owned_head, struct z_erofs_pcluster, next);
+		owned_head = READ_ONCE(pcl->next);
 
-		/* close the main owned chain at first */
-		owned_head = cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
-				     Z_EROFS_PCLUSTER_TAIL_CLOSED);
 		if (z_erofs_is_inline_pcluster(pcl)) {
 			move_to_bypass_jobqueue(pcl, qtail, owned_head);
 			continue;
-- 
2.24.4

