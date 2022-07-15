Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F42E576498
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 17:42:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lkwbg2klyz3cdP
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Jul 2022 01:42:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LkwbV2yKMz3cC4
	for <linux-erofs@lists.ozlabs.org>; Sat, 16 Jul 2022 01:42:29 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJPnC6b_1657899743;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJPnC6b_1657899743)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 23:42:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 10/16] erofs: clean up `enum z_erofs_collectmode'
Date: Fri, 15 Jul 2022 23:41:57 +0800
Message-Id: <20220715154203.48093-11-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220715154203.48093-1-hsiangkao@linux.alibaba.com>
References: <20220715154203.48093-1-hsiangkao@linux.alibaba.com>
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

`enum z_erofs_collectmode' is really ambiguous, but I'm not quite
sure if there are better naming, basically it's used to judge whether
inplace I/O can be used due to the current status of pclusters in
the chain.

Rename it as `enum z_erofs_pclustermode' instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 63 ++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index f2a513299d82..d1f907f4757d 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -227,30 +227,29 @@ int __init z_erofs_init_zip_subsystem(void)
 	return err;
 }
 
-enum z_erofs_collectmode {
-	COLLECT_SECONDARY,
-	COLLECT_PRIMARY,
+enum z_erofs_pclustermode {
+	Z_EROFS_PCLUSTER_INFLIGHT,
 	/*
-	 * The current collection was the tail of an exist chain, in addition
-	 * that the previous processed chained collections are all decided to
+	 * The current pclusters was the tail of an exist chain, in addition
+	 * that the previous processed chained pclusters are all decided to
 	 * be hooked up to it.
-	 * A new chain will be created for the remaining collections which are
-	 * not processed yet, therefore different from COLLECT_PRIMARY_FOLLOWED,
-	 * the next collection cannot reuse the whole page safely in
-	 * the following scenario:
+	 * A new chain will be created for the remaining pclusters which are
+	 * not processed yet, so different from Z_EROFS_PCLUSTER_FOLLOWED,
+	 * the next pcluster cannot reuse the whole page safely for inplace I/O
+	 * in the following scenario:
 	 *  ________________________________________________________________
 	 * |      tail (partial) page     |       head (partial) page       |
-	 * |   (belongs to the next cl)   |   (belongs to the current cl)   |
-	 * |_______PRIMARY_FOLLOWED_______|________PRIMARY_HOOKED___________|
+	 * |   (belongs to the next pcl)  |   (belongs to the current pcl)  |
+	 * |_______PCLUSTER_FOLLOWED______|________PCLUSTER_HOOKED__________|
 	 */
-	COLLECT_PRIMARY_HOOKED,
+	Z_EROFS_PCLUSTER_HOOKED,
 	/*
-	 * a weak form of COLLECT_PRIMARY_FOLLOWED, the difference is that it
+	 * a weak form of Z_EROFS_PCLUSTER_FOLLOWED, the difference is that it
 	 * could be dispatched into bypass queue later due to uptodated managed
 	 * pages. All related online pages cannot be reused for inplace I/O (or
 	 * bvpage) since it can be directly decoded without I/O submission.
 	 */
-	COLLECT_PRIMARY_FOLLOWED_NOINPLACE,
+	Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE,
 	/*
 	 * The current collection has been linked with the owned chain, and
 	 * could also be linked with the remaining collections, which means
@@ -261,12 +260,12 @@ enum z_erofs_collectmode {
 	 *  ________________________________________________________________
 	 * |  tail (partial) page |          head (partial) page           |
 	 * |  (of the current cl) |      (of the previous collection)      |
-	 * |  PRIMARY_FOLLOWED or |                                        |
-	 * |_____PRIMARY_HOOKED___|____________PRIMARY_FOLLOWED____________|
+	 * | PCLUSTER_FOLLOWED or |                                        |
+	 * |_____PCLUSTER_HOOKED__|___________PCLUSTER_FOLLOWED____________|
 	 *
 	 * [  (*) the above page can be used as inplace I/O.               ]
 	 */
-	COLLECT_PRIMARY_FOLLOWED,
+	Z_EROFS_PCLUSTER_FOLLOWED,
 };
 
 struct z_erofs_decompress_frontend {
@@ -277,7 +276,7 @@ struct z_erofs_decompress_frontend {
 	struct page *candidate_bvpage;
 	struct z_erofs_pcluster *pcl, *tailpcl;
 	z_erofs_next_pcluster_t owned_head;
-	enum z_erofs_collectmode mode;
+	enum z_erofs_pclustermode mode;
 
 	bool readahead;
 	/* used for applying cache strategy on the fly */
@@ -290,7 +289,7 @@ struct z_erofs_decompress_frontend {
 
 #define DECOMPRESS_FRONTEND_INIT(__i) { \
 	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
-	.mode = COLLECT_PRIMARY_FOLLOWED, .backmost = true }
+	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .backmost = true }
 
 static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
 static DEFINE_MUTEX(z_pagemap_global_lock);
@@ -310,7 +309,7 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
 	unsigned int i;
 
-	if (fe->mode < COLLECT_PRIMARY_FOLLOWED)
+	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED)
 		return;
 
 	for (i = 0; i < pcl->pclusterpages; ++i) {
@@ -358,7 +357,7 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 	 * managed cache since it can be moved to the bypass queue instead.
 	 */
 	if (standalone)
-		fe->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
+		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 }
 
 /* called by erofs_shrinker to get rid of all compressed_pages */
@@ -439,12 +438,12 @@ static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
 {
 	int ret;
 
-	if (fe->mode >= COLLECT_PRIMARY && exclusive) {
+	if (exclusive) {
 		/* give priority for inplaceio to use file pages first */
 		if (z_erofs_try_inplace_io(fe, bvec))
 			return 0;
 		/* otherwise, check if it can be used as a bvpage */
-		if (fe->mode >= COLLECT_PRIMARY_FOLLOWED &&
+		if (fe->mode >= Z_EROFS_PCLUSTER_FOLLOWED &&
 		    !fe->candidate_bvpage)
 			fe->candidate_bvpage = bvec->page;
 	}
@@ -463,7 +462,7 @@ static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
 		    *owned_head) == Z_EROFS_PCLUSTER_NIL) {
 		*owned_head = &pcl->next;
 		/* so we can attach this pcluster to our submission chain. */
-		f->mode = COLLECT_PRIMARY_FOLLOWED;
+		f->mode = Z_EROFS_PCLUSTER_FOLLOWED;
 		return;
 	}
 
@@ -474,12 +473,12 @@ static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
 	if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
 		    *owned_head) == Z_EROFS_PCLUSTER_TAIL) {
 		*owned_head = Z_EROFS_PCLUSTER_TAIL;
-		f->mode = COLLECT_PRIMARY_HOOKED;
+		f->mode = Z_EROFS_PCLUSTER_HOOKED;
 		f->tailpcl = NULL;
 		return;
 	}
 	/* type 3, it belongs to a chain, but it isn't the end of the chain */
-	f->mode = COLLECT_PRIMARY;
+	f->mode = Z_EROFS_PCLUSTER_INFLIGHT;
 }
 
 static int z_erofs_lookup_pcluster(struct z_erofs_decompress_frontend *fe)
@@ -554,7 +553,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	/* new pclusters should be claimed as type 1, primary and followed */
 	pcl->next = fe->owned_head;
 	pcl->pageofs_out = map->m_la & ~PAGE_MASK;
-	fe->mode = COLLECT_PRIMARY_FOLLOWED;
+	fe->mode = Z_EROFS_PCLUSTER_FOLLOWED;
 
 	/*
 	 * lock all primary followed works before visible to others
@@ -676,7 +675,7 @@ static bool z_erofs_collector_end(struct z_erofs_decompress_frontend *fe)
 	 * if all pending pages are added, don't hold its reference
 	 * any longer if the pcluster isn't hosted by ourselves.
 	 */
-	if (fe->mode < COLLECT_PRIMARY_FOLLOWED_NOINPLACE)
+	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
 		erofs_workgroup_put(&pcl->obj);
 
 	fe->pcl = NULL;
@@ -756,7 +755,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		get_page(fe->map.buf.page);
 		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page,
 			   fe->map.buf.page);
-		fe->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
+		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 	} else {
 		/* bind cache first when cached decompression is preferred */
 		if (should_alloc_managed_pages(fe, sbi->opt.cache_strategy,
@@ -774,8 +773,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	 * those chains are handled asynchronously thus the page cannot be used
 	 * for inplace I/O or bvpage (should be processed in a strict order.)
 	 */
-	tight &= (fe->mode >= COLLECT_PRIMARY_HOOKED &&
-		  fe->mode != COLLECT_PRIMARY_FOLLOWED_NOINPLACE);
+	tight &= (fe->mode >= Z_EROFS_PCLUSTER_HOOKED &&
+		  fe->mode != Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
 
 	cur = end - min_t(unsigned int, offset + end - map->m_la, end);
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
@@ -785,7 +784,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 
 	exclusive = (!cur && (!spiltted || tight));
 	if (cur)
-		tight &= (fe->mode >= COLLECT_PRIMARY_FOLLOWED);
+		tight &= (fe->mode >= Z_EROFS_PCLUSTER_FOLLOWED);
 
 retry:
 	err = z_erofs_attach_page(fe, &((struct z_erofs_bvec) {
-- 
2.24.4

