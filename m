Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE46278589
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2019 08:54:40 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45xr5n3b0KzDqFL
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2019 16:54:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45xr3c5P83zDqCM
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jul 2019 16:52:42 +1000 (AEST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 48CE2B3AE36412AE277F;
 Mon, 29 Jul 2019 14:52:40 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul
 2019 14:52:31 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 <devel@driverdev.osuosl.org>
Subject: [PATCH 16/22] staging: erofs: tidy up decompression frontend
Date: Mon, 29 Jul 2019 14:51:53 +0800
Message-ID: <20190729065159.62378-17-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729065159.62378-1-gaoxiang25@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Although this patch has an amount of changes, it is hard to
separate into smaller patches.

Most changes are due to structure renaming for better understand
and straightforward,
 z_erofs_vle_workgroup to z_erofs_pcluster
             since it represents a physical cluster;
 z_erofs_vle_work to z_erofs_collection
             since it represents a collection of logical pages;
 z_erofs_vle_work_builder to z_erofs_collector
             since it's used to fill z_erofs_{pcluster,collection}.

struct z_erofs_vle_work_finder has no extra use compared with
struct z_erofs_collector, delete it.

FULL_LENGTH bit is integrated into .length of pcluster so that it
can be updated with the corresponding length change in atomic.

Minor, add comments for better description.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/zdata.c | 983 +++++++++++++++-------------------
 drivers/staging/erofs/zdata.h |  96 ++--
 2 files changed, 465 insertions(+), 614 deletions(-)

diff --git a/drivers/staging/erofs/zdata.c b/drivers/staging/erofs/zdata.c
index 29900ca7c9d4..34ee19b4721d 100644
--- a/drivers/staging/erofs/zdata.c
+++ b/drivers/staging/erofs/zdata.c
@@ -18,7 +18,7 @@
  */
 #define PAGE_UNALLOCATED     ((void *)0x5F0E4B1D)
 
-/* how to allocate cached pages for a workgroup */
+/* how to allocate cached pages for a pcluster */
 enum z_erofs_cache_alloctype {
 	DONTALLOC,	/* don't allocate any cached pages */
 	DELAYEDALLOC,	/* delayed allocation (at the time of submitting io) */
@@ -34,156 +34,158 @@ typedef tagptr1_t compressed_page_t;
 	tagptr_fold(compressed_page_t, page, 1)
 
 static struct workqueue_struct *z_erofs_workqueue __read_mostly;
-static struct kmem_cache *z_erofs_workgroup_cachep __read_mostly;
+static struct kmem_cache *pcluster_cachep __read_mostly;
 
 void z_erofs_exit_zip_subsystem(void)
 {
 	destroy_workqueue(z_erofs_workqueue);
-	kmem_cache_destroy(z_erofs_workgroup_cachep);
+	kmem_cache_destroy(pcluster_cachep);
 }
 
 static inline int init_unzip_workqueue(void)
 {
 	const unsigned int onlinecpus = num_possible_cpus();
+	const unsigned int flags = WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE;
 
 	/*
-	 * we don't need too many threads, limiting threads
-	 * could improve scheduling performance.
+	 * no need to spawn too many threads, limiting threads could minimum
+	 * scheduling overhead, perhaps per-CPU threads should be better?
 	 */
-	z_erofs_workqueue =
-		alloc_workqueue("erofs_unzipd",
-				WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE,
-				onlinecpus + onlinecpus / 4);
-
+	z_erofs_workqueue = alloc_workqueue("erofs_unzipd", flags,
+					    onlinecpus + onlinecpus / 4);
 	return z_erofs_workqueue ? 0 : -ENOMEM;
 }
 
 static void init_once(void *ptr)
 {
-	struct z_erofs_vle_workgroup *grp = ptr;
-	struct z_erofs_vle_work *const work =
-		z_erofs_vle_grab_primary_work(grp);
+	struct z_erofs_pcluster *pcl = ptr;
+	struct z_erofs_collection *cl = z_erofs_primarycollection(pcl);
 	unsigned int i;
 
-	mutex_init(&work->lock);
-	work->nr_pages = 0;
-	work->vcnt = 0;
+	mutex_init(&cl->lock);
+	cl->nr_pages = 0;
+	cl->vcnt = 0;
 	for (i = 0; i < Z_EROFS_CLUSTER_MAX_PAGES; ++i)
-		grp->compressed_pages[i] = NULL;
+		pcl->compressed_pages[i] = NULL;
 }
 
-static void init_always(struct z_erofs_vle_workgroup *grp)
+static void init_always(struct z_erofs_pcluster *pcl)
 {
-	struct z_erofs_vle_work *const work =
-		z_erofs_vle_grab_primary_work(grp);
+	struct z_erofs_collection *cl = z_erofs_primarycollection(pcl);
 
-	atomic_set(&grp->obj.refcount, 1);
-	grp->flags = 0;
+	atomic_set(&pcl->obj.refcount, 1);
 
-	DBG_BUGON(work->nr_pages);
-	DBG_BUGON(work->vcnt);
+	DBG_BUGON(cl->nr_pages);
+	DBG_BUGON(cl->vcnt);
 }
 
 int __init z_erofs_init_zip_subsystem(void)
 {
-	z_erofs_workgroup_cachep =
-		kmem_cache_create("erofs_compress",
-				  Z_EROFS_WORKGROUP_SIZE, 0,
-				  SLAB_RECLAIM_ACCOUNT, init_once);
-
-	if (z_erofs_workgroup_cachep) {
+	pcluster_cachep = kmem_cache_create("erofs_compress",
+					    Z_EROFS_WORKGROUP_SIZE, 0,
+					    SLAB_RECLAIM_ACCOUNT, init_once);
+	if (pcluster_cachep) {
 		if (!init_unzip_workqueue())
 			return 0;
 
-		kmem_cache_destroy(z_erofs_workgroup_cachep);
+		kmem_cache_destroy(pcluster_cachep);
 	}
 	return -ENOMEM;
 }
 
-enum z_erofs_vle_work_role {
-	Z_EROFS_VLE_WORK_SECONDARY,
-	Z_EROFS_VLE_WORK_PRIMARY,
+enum z_erofs_collectmode {
+	COLLECT_SECONDARY,
+	COLLECT_PRIMARY,
 	/*
-	 * The current work was the tail of an exist chain, and the previous
-	 * processed chained works are all decided to be hooked up to it.
-	 * A new chain should be created for the remaining unprocessed works,
-	 * therefore different from Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED,
-	 * the next work cannot reuse the whole page in the following scenario:
+	 * The current collection was the tail of an exist chain, in addition
+	 * that the previous processed chained collections are all decided to
+	 * be hooked up to it.
+	 * A new chain will be created for the remaining collections which are
+	 * not processed yet, therefore different from COLLECT_PRIMARY_FOLLOWED,
+	 * the next collection cannot reuse the whole page safely in
+	 * the following scenario:
 	 *  ________________________________________________________________
 	 * |      tail (partial) page     |       head (partial) page       |
-	 * |  (belongs to the next work)  |  (belongs to the current work)  |
+	 * |   (belongs to the next cl)   |   (belongs to the current cl)   |
 	 * |_______PRIMARY_FOLLOWED_______|________PRIMARY_HOOKED___________|
 	 */
-	Z_EROFS_VLE_WORK_PRIMARY_HOOKED,
+	COLLECT_PRIMARY_HOOKED,
+	COLLECT_PRIMARY_FOLLOWED_NOINPLACE,
 	/*
-	 * The current work has been linked with the processed chained works,
-	 * and could be also linked with the potential remaining works, which
-	 * means if the processing page is the tail partial page of the work,
-	 * the current work can safely use the whole page (since the next work
-	 * is under control) for in-place decompression, as illustrated below:
+	 * The current collection has been linked with the owned chain, and
+	 * could also be linked with the remaining collections, which means
+	 * if the processing page is the tail page of the collection, thus
+	 * the current collection can safely use the whole page (since
+	 * the previous collection is under control) for in-place I/O, as
+	 * illustrated below:
 	 *  ________________________________________________________________
-	 * |  tail (partial) page  |          head (partial) page           |
-	 * | (of the current work) |         (of the previous work)         |
-	 * |  PRIMARY_FOLLOWED or  |                                        |
-	 * |_____PRIMARY_HOOKED____|____________PRIMARY_FOLLOWED____________|
+	 * |  tail (partial) page |          head (partial) page           |
+	 * |  (of the current cl) |      (of the previous collection)      |
+	 * |  PRIMARY_FOLLOWED or |                                        |
+	 * |_____PRIMARY_HOOKED___|____________PRIMARY_FOLLOWED____________|
 	 *
-	 * [  (*) the above page can be used for the current work itself.  ]
+	 * [  (*) the above page can be used as inplace I/O.               ]
 	 */
-	Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED,
-	Z_EROFS_VLE_WORK_MAX
+	COLLECT_PRIMARY_FOLLOWED,
 };
 
-struct z_erofs_vle_work_builder {
-	enum z_erofs_vle_work_role role;
-	/*
-	 * 'hosted = false' means that the current workgroup doesn't belong to
-	 * the owned chained workgroups. In the other words, it is none of our
-	 * business to submit this workgroup.
-	 */
-	bool hosted;
-
-	struct z_erofs_vle_workgroup *grp;
-	struct z_erofs_vle_work *work;
+struct z_erofs_collector {
 	struct z_erofs_pagevec_ctor vector;
 
-	/* pages used for reading the compressed data */
-	struct page **compressed_pages;
-	unsigned int compressed_deficit;
+	struct z_erofs_pcluster *pcl;
+	struct z_erofs_collection *cl;
+	struct page **compressedpages;
+	z_erofs_next_pcluster_t owned_head;
+
+	enum z_erofs_collectmode mode;
 };
 
-#define VLE_WORK_BUILDER_INIT()	\
-	{ .work = NULL, .role = Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED }
+struct z_erofs_decompress_frontend {
+	struct inode *const inode;
+
+	struct z_erofs_collector clt;
+	struct erofs_map_blocks map;
+
+	/* used for applying cache strategy on the fly */
+	bool backmost;
+	erofs_off_t headoffset;
+};
+
+#define COLLECTOR_INIT() { \
+	.owned_head = Z_EROFS_PCLUSTER_TAIL, \
+	.mode = COLLECT_PRIMARY_FOLLOWED }
+
+#define DECOMPRESS_FRONTEND_INIT(__i) { \
+	.inode = __i, .clt = COLLECTOR_INIT(), \
+	.backmost = true, }
+
+static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
+static DEFINE_MUTEX(z_pagemap_global_lock);
 
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
-static void preload_compressed_pages(struct z_erofs_vle_work_builder *bl,
+static void preload_compressed_pages(struct z_erofs_collector *clt,
 				     struct address_space *mc,
-				     pgoff_t index,
-				     unsigned int clusterpages,
 				     enum z_erofs_cache_alloctype type,
-				     struct list_head *pagepool,
-				     gfp_t gfp)
+				     struct list_head *pagepool)
 {
-	struct page **const pages = bl->compressed_pages;
-	const unsigned int remaining = bl->compressed_deficit;
+	const struct z_erofs_pcluster *pcl = clt->pcl;
+	const unsigned int clusterpages = BIT(pcl->clusterbits);
+	struct page **pages = clt->compressedpages;
+	pgoff_t index = pcl->obj.index + (pages - pcl->compressed_pages);
 	bool standalone = true;
-	unsigned int i, j = 0;
 
-	if (bl->role < Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED)
+	if (clt->mode < COLLECT_PRIMARY_FOLLOWED)
 		return;
 
-	gfp = mapping_gfp_constraint(mc, gfp) & ~__GFP_RECLAIM;
-
-	index += clusterpages - remaining;
-
-	for (i = 0; i < remaining; ++i) {
+	for (; pages < pcl->compressed_pages + clusterpages; ++pages) {
 		struct page *page;
 		compressed_page_t t;
 
 		/* the compressed page was loaded before */
-		if (READ_ONCE(pages[i]))
+		if (READ_ONCE(*pages))
 			continue;
 
-		page = find_get_page(mc, index + i);
+		page = find_get_page(mc, index);
 
 		if (page) {
 			t = tag_compressed_page_justfound(page);
@@ -191,32 +193,30 @@ static void preload_compressed_pages(struct z_erofs_vle_work_builder *bl,
 			t = tagptr_init(compressed_page_t, PAGE_UNALLOCATED);
 		} else {	/* DONTALLOC */
 			if (standalone)
-				j = i;
+				clt->compressedpages = pages;
 			standalone = false;
 			continue;
 		}
 
-		if (!cmpxchg_relaxed(&pages[i], NULL, tagptr_cast_ptr(t)))
+		if (!cmpxchg_relaxed(pages, NULL, tagptr_cast_ptr(t)))
 			continue;
 
 		if (page)
 			put_page(page);
 	}
-	bl->compressed_pages += j;
-	bl->compressed_deficit = remaining - j;
 
-	if (standalone)
-		bl->role = Z_EROFS_VLE_WORK_PRIMARY;
+	if (standalone)		/* downgrade to PRIMARY_FOLLOWED_NOINPLACE */
+		clt->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
 }
 
 /* called by erofs_shrinker to get rid of all compressed_pages */
 int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
-				       struct erofs_workgroup *egrp)
+				       struct erofs_workgroup *grp)
 {
-	struct z_erofs_vle_workgroup *const grp =
-		container_of(egrp, struct z_erofs_vle_workgroup, obj);
+	struct z_erofs_pcluster *const pcl =
+		container_of(grp, struct z_erofs_pcluster, obj);
 	struct address_space *const mapping = MNGD_MAPPING(sbi);
-	const int clusterpages = erofs_clusterpages(sbi);
+	const unsigned int clusterpages = BIT(pcl->clusterbits);
 	int i;
 
 	/*
@@ -224,18 +224,20 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 	 * therefore no need to worry about available decompression users.
 	 */
 	for (i = 0; i < clusterpages; ++i) {
-		struct page *page = grp->compressed_pages[i];
+		struct page *page = pcl->compressed_pages[i];
 
-		if (!page || page->mapping != mapping)
+		if (!page)
 			continue;
 
 		/* block other users from reclaiming or migrating the page */
 		if (!trylock_page(page))
 			return -EBUSY;
 
-		/* barrier is implied in the following 'unlock_page' */
-		WRITE_ONCE(grp->compressed_pages[i], NULL);
+		if (unlikely(page->mapping != mapping))
+			continue;
 
+		/* barrier is implied in the following 'unlock_page' */
+		WRITE_ONCE(pcl->compressed_pages[i], NULL);
 		set_page_private(page, 0);
 		ClearPagePrivate(page);
 
@@ -248,22 +250,21 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 int erofs_try_to_free_cached_page(struct address_space *mapping,
 				  struct page *page)
 {
-	struct erofs_sb_info *const sbi = EROFS_SB(mapping->host->i_sb);
-	const unsigned int clusterpages = erofs_clusterpages(sbi);
-	struct z_erofs_vle_workgroup *const grp = (void *)page_private(page);
+	struct z_erofs_pcluster *const pcl = (void *)page_private(page);
+	const unsigned int clusterpages = BIT(pcl->clusterbits);
 	int ret = 0;	/* 0 - busy */
 
-	if (erofs_workgroup_try_to_freeze(&grp->obj, 1)) {
+	if (erofs_workgroup_try_to_freeze(&pcl->obj, 1)) {
 		unsigned int i;
 
 		for (i = 0; i < clusterpages; ++i) {
-			if (grp->compressed_pages[i] == page) {
-				WRITE_ONCE(grp->compressed_pages[i], NULL);
+			if (pcl->compressed_pages[i] == page) {
+				WRITE_ONCE(pcl->compressed_pages[i], NULL);
 				ret = 1;
 				break;
 			}
 		}
-		erofs_workgroup_unfreeze(&grp->obj, 1);
+		erofs_workgroup_unfreeze(&pcl->obj, 1);
 
 		if (ret) {
 			ClearPagePrivate(page);
@@ -273,361 +274,267 @@ int erofs_try_to_free_cached_page(struct address_space *mapping,
 	return ret;
 }
 #else
-static void preload_compressed_pages(struct z_erofs_vle_work_builder *bl,
+static void preload_compressed_pages(struct z_erofs_collector *clt,
 				     struct address_space *mc,
-				     pgoff_t index,
-				     unsigned int clusterpages,
 				     enum z_erofs_cache_alloctype type,
-				     struct list_head *pagepool,
-				     gfp_t gfp)
+				     struct list_head *pagepool)
 {
 	/* nowhere to load compressed pages from */
 }
 #endif
 
 /* page_type must be Z_EROFS_PAGE_TYPE_EXCLUSIVE */
-static inline bool try_to_reuse_as_compressed_page(
-	struct z_erofs_vle_work_builder *b,
-	struct page *page)
+static inline bool try_inplace_io(struct z_erofs_collector *clt,
+				  struct page *page)
 {
-	while (b->compressed_deficit) {
-		--b->compressed_deficit;
-		if (!cmpxchg(b->compressed_pages++, NULL, page))
+	struct z_erofs_pcluster *const pcl = clt->pcl;
+	const unsigned int clusterpages = BIT(pcl->clusterbits);
+
+	while (clt->compressedpages < pcl->compressed_pages + clusterpages) {
+		if (!cmpxchg(clt->compressedpages++, NULL, page))
 			return true;
 	}
-
 	return false;
 }
 
-/* callers must be with work->lock held */
-static int z_erofs_vle_work_add_page(
-	struct z_erofs_vle_work_builder *builder,
-	struct page *page,
-	enum z_erofs_page_type type)
+/* callers must be with collection lock held */
+static int z_erofs_attach_page(struct z_erofs_collector *clt,
+			       struct page *page,
+			       enum z_erofs_page_type type)
 {
 	int ret;
 	bool occupied;
 
-	/* give priority for the compressed data storage */
-	if (builder->role >= Z_EROFS_VLE_WORK_PRIMARY &&
+	/* give priority for inplaceio */
+	if (clt->mode >= COLLECT_PRIMARY &&
 	    type == Z_EROFS_PAGE_TYPE_EXCLUSIVE &&
-	    try_to_reuse_as_compressed_page(builder, page))
+	    try_inplace_io(clt, page))
 		return 0;
 
-	ret = z_erofs_pagevec_enqueue(&builder->vector,
+	ret = z_erofs_pagevec_enqueue(&clt->vector,
 				      page, type, &occupied);
-	builder->work->vcnt += (unsigned int)ret;
+	clt->cl->vcnt += (unsigned int)ret;
 
 	return ret ? 0 : -EAGAIN;
 }
 
-static enum z_erofs_vle_work_role
-try_to_claim_workgroup(struct z_erofs_vle_workgroup *grp,
-		       z_erofs_vle_owned_workgrp_t *owned_head,
-		       bool *hosted)
+static enum z_erofs_collectmode
+try_to_claim_pcluster(struct z_erofs_pcluster *pcl,
+		      z_erofs_next_pcluster_t *owned_head)
 {
-	DBG_BUGON(*hosted);
-
-	/* let's claim these following types of workgroup */
+	/* let's claim these following types of pclusters */
 retry:
-	if (grp->next == Z_EROFS_VLE_WORKGRP_NIL) {
-		/* type 1, nil workgroup */
-		if (cmpxchg(&grp->next, Z_EROFS_VLE_WORKGRP_NIL,
-			    *owned_head) != Z_EROFS_VLE_WORKGRP_NIL)
+	if (pcl->next == Z_EROFS_PCLUSTER_NIL) {
+		/* type 1, nil pcluster */
+		if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_NIL,
+			    *owned_head) != Z_EROFS_PCLUSTER_NIL)
 			goto retry;
 
-		*owned_head = &grp->next;
-		*hosted = true;
+		*owned_head = &pcl->next;
 		/* lucky, I am the followee :) */
-		return Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED;
-
-	} else if (grp->next == Z_EROFS_VLE_WORKGRP_TAIL) {
+		return COLLECT_PRIMARY_FOLLOWED;
+	} else if (pcl->next == Z_EROFS_PCLUSTER_TAIL) {
 		/*
 		 * type 2, link to the end of a existing open chain,
 		 * be careful that its submission itself is governed
 		 * by the original owned chain.
 		 */
-		if (cmpxchg(&grp->next, Z_EROFS_VLE_WORKGRP_TAIL,
-			    *owned_head) != Z_EROFS_VLE_WORKGRP_TAIL)
+		if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
+			    *owned_head) != Z_EROFS_PCLUSTER_TAIL)
 			goto retry;
-		*owned_head = Z_EROFS_VLE_WORKGRP_TAIL;
-		return Z_EROFS_VLE_WORK_PRIMARY_HOOKED;
+		*owned_head = Z_EROFS_PCLUSTER_TAIL;
+		return COLLECT_PRIMARY_HOOKED;
 	}
-
-	return Z_EROFS_VLE_WORK_PRIMARY; /* :( better luck next time */
+	return COLLECT_PRIMARY;	/* :( better luck next time */
 }
 
-struct z_erofs_vle_work_finder {
-	struct super_block *sb;
-	pgoff_t idx;
-	unsigned int pageofs;
-
-	struct z_erofs_vle_workgroup **grp_ret;
-	enum z_erofs_vle_work_role *role;
-	z_erofs_vle_owned_workgrp_t *owned_head;
-	bool *hosted;
-};
-
-static struct z_erofs_vle_work *
-z_erofs_vle_work_lookup(const struct z_erofs_vle_work_finder *f)
+static struct z_erofs_collection *cllookup(struct z_erofs_collector *clt,
+					   struct inode *inode,
+					   struct erofs_map_blocks *map)
 {
-	bool tag, primary;
-	struct erofs_workgroup *egrp;
-	struct z_erofs_vle_workgroup *grp;
-	struct z_erofs_vle_work *work;
-
-	egrp = erofs_find_workgroup(f->sb, f->idx, &tag);
-	if (!egrp) {
-		*f->grp_ret = NULL;
+	struct erofs_workgroup *grp;
+	struct z_erofs_pcluster *pcl;
+	struct z_erofs_collection *cl;
+	unsigned int length;
+	bool tag;
+
+	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT, &tag);
+	if (!grp)
 		return NULL;
-	}
 
-	grp = container_of(egrp, struct z_erofs_vle_workgroup, obj);
-	*f->grp_ret = grp;
+	pcl = container_of(grp, struct z_erofs_pcluster, obj);
+
+	cl = z_erofs_primarycollection(pcl);
+	if (unlikely(cl->pageofs != (map->m_la & ~PAGE_MASK))) {
+		DBG_BUGON(1);
+		return ERR_PTR(-EIO);
+	}
 
-	work = z_erofs_vle_grab_work(grp, f->pageofs);
-	/* if multiref is disabled, `primary' is always true */
-	primary = true;
+	length = READ_ONCE(pcl->length);
+	if (length & Z_EROFS_PCLUSTER_FULL_LENGTH) {
+		if ((map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) > length) {
+			DBG_BUGON(1);
+			return ERR_PTR(-EIO);
+		}
+	} else {
+		unsigned int llen = map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT;
 
-	DBG_BUGON(work->pageofs != f->pageofs);
+		if (map->m_flags & EROFS_MAP_FULL_MAPPED)
+			llen |= Z_EROFS_PCLUSTER_FULL_LENGTH;
 
-	/*
-	 * lock must be taken first to avoid grp->next == NIL between
-	 * claiming workgroup and adding pages:
-	 *                        grp->next != NIL
-	 *   grp->next = NIL
-	 *   mutex_unlock_all
-	 *                        mutex_lock(&work->lock)
-	 *                        add all pages to pagevec
-	 *
-	 * [correct locking case 1]:
-	 *   mutex_lock(grp->work[a])
-	 *   ...
-	 *   mutex_lock(grp->work[b])     mutex_lock(grp->work[c])
-	 *   ...                          *role = SECONDARY
-	 *                                add all pages to pagevec
-	 *                                ...
-	 *                                mutex_unlock(grp->work[c])
-	 *   mutex_lock(grp->work[c])
-	 *   ...
-	 *   grp->next = NIL
-	 *   mutex_unlock_all
-	 *
-	 * [correct locking case 2]:
-	 *   mutex_lock(grp->work[b])
-	 *   ...
-	 *   mutex_lock(grp->work[a])
-	 *   ...
-	 *   mutex_lock(grp->work[c])
-	 *   ...
-	 *   grp->next = NIL
-	 *   mutex_unlock_all
-	 *                                mutex_lock(grp->work[a])
-	 *                                *role = PRIMARY_OWNER
-	 *                                add all pages to pagevec
-	 *                                ...
-	 */
-	mutex_lock(&work->lock);
-
-	*f->hosted = false;
-	if (!primary)
-		*f->role = Z_EROFS_VLE_WORK_SECONDARY;
-	else	/* claim the workgroup if possible */
-		*f->role = try_to_claim_workgroup(grp, f->owned_head,
-						  f->hosted);
-	return work;
+		while (llen > length &&
+		       length != cmpxchg_relaxed(&pcl->length, length, llen)) {
+			cpu_relax();
+			length = READ_ONCE(pcl->length);
+		}
+	}
+	mutex_lock(&cl->lock);
+	clt->mode = try_to_claim_pcluster(pcl, &clt->owned_head);
+	clt->pcl = pcl;
+	clt->cl = cl;
+	return cl;
 }
 
-static struct z_erofs_vle_work *
-z_erofs_vle_work_register(const struct z_erofs_vle_work_finder *f,
-			  struct erofs_map_blocks *map)
+static struct z_erofs_collection *clregister(struct z_erofs_collector *clt,
+					     struct inode *inode,
+					     struct erofs_map_blocks *map)
 {
-	bool gnew = false;
-	struct z_erofs_vle_workgroup *grp = *f->grp_ret;
-	struct z_erofs_vle_work *work;
-
-	/* if multiref is disabled, grp should never be nullptr */
-	if (unlikely(grp)) {
-		DBG_BUGON(1);
-		return ERR_PTR(-EINVAL);
-	}
+	struct z_erofs_pcluster *pcl;
+	struct z_erofs_collection *cl;
+	int err;
 
 	/* no available workgroup, let's allocate one */
-	grp = kmem_cache_alloc(z_erofs_workgroup_cachep, GFP_NOFS);
-	if (unlikely(!grp))
+	pcl = kmem_cache_alloc(pcluster_cachep, GFP_NOFS);
+	if (unlikely(!pcl))
 		return ERR_PTR(-ENOMEM);
 
-	init_always(grp);
-	grp->obj.index = f->idx;
-	grp->llen = map->m_llen;
+	init_always(pcl);
+	pcl->obj.index = map->m_pa >> PAGE_SHIFT;
 
-	z_erofs_vle_set_workgrp_fmt(grp, (map->m_flags & EROFS_MAP_ZIPPED) ?
-				    Z_EROFS_VLE_WORKGRP_FMT_LZ4 :
-				    Z_EROFS_VLE_WORKGRP_FMT_PLAIN);
+	pcl->length = (map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) |
+		(map->m_flags & EROFS_MAP_FULL_MAPPED ?
+			Z_EROFS_PCLUSTER_FULL_LENGTH : 0);
 
-	if (map->m_flags & EROFS_MAP_FULL_MAPPED)
-		grp->flags |= Z_EROFS_VLE_WORKGRP_FULL_LENGTH;
+	if (map->m_flags & EROFS_MAP_ZIPPED)
+		pcl->algorithmformat = Z_EROFS_COMPRESSION_LZ4;
+	else
+		pcl->algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
+
+	pcl->clusterbits = EROFS_V(inode)->z_physical_clusterbits[0];
+	pcl->clusterbits -= PAGE_SHIFT;
 
-	/* new workgrps have been claimed as type 1 */
-	WRITE_ONCE(grp->next, *f->owned_head);
-	/* primary and followed work for all new workgrps */
-	*f->role = Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED;
-	/* it should be submitted by ourselves */
-	*f->hosted = true;
+	/* new pclusters should be claimed as type 1, primary and followed */
+	pcl->next = clt->owned_head;
+	clt->mode = COLLECT_PRIMARY_FOLLOWED;
 
-	gnew = true;
-	work = z_erofs_vle_grab_primary_work(grp);
-	work->pageofs = f->pageofs;
+	cl = z_erofs_primarycollection(pcl);
+	cl->pageofs = map->m_la & ~PAGE_MASK;
 
 	/*
 	 * lock all primary followed works before visible to others
-	 * and mutex_trylock *never* fails for a new workgroup.
+	 * and mutex_trylock *never* fails for a new pcluster.
 	 */
-	mutex_trylock(&work->lock);
+	mutex_trylock(&cl->lock);
 
-	if (gnew) {
-		int err = erofs_register_workgroup(f->sb, &grp->obj, 0);
-
-		if (err) {
-			mutex_unlock(&work->lock);
-			kmem_cache_free(z_erofs_workgroup_cachep, grp);
-			return ERR_PTR(-EAGAIN);
-		}
+	err = erofs_register_workgroup(inode->i_sb, &pcl->obj, 0);
+	if (err) {
+		mutex_unlock(&cl->lock);
+		kmem_cache_free(pcluster_cachep, pcl);
+		return ERR_PTR(-EAGAIN);
 	}
-
-	*f->owned_head = &grp->next;
-	*f->grp_ret = grp;
-	return work;
+	clt->owned_head = &pcl->next;
+	clt->pcl = pcl;
+	clt->cl = cl;
+	return cl;
 }
 
-#define builder_is_hooked(builder) \
-	((builder)->role >= Z_EROFS_VLE_WORK_PRIMARY_HOOKED)
+static int z_erofs_collector_begin(struct z_erofs_collector *clt,
+				   struct inode *inode,
+				   struct erofs_map_blocks *map)
+{
+	struct z_erofs_collection *cl;
 
-#define builder_is_followed(builder) \
-	((builder)->role >= Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED)
+	DBG_BUGON(clt->cl);
 
-static int z_erofs_vle_work_iter_begin(struct z_erofs_vle_work_builder *builder,
-				       struct super_block *sb,
-				       struct erofs_map_blocks *map,
-				       z_erofs_vle_owned_workgrp_t *owned_head)
-{
-	const unsigned int clusterpages = erofs_clusterpages(EROFS_SB(sb));
-	struct z_erofs_vle_workgroup *grp;
-	const struct z_erofs_vle_work_finder finder = {
-		.sb = sb,
-		.idx = erofs_blknr(map->m_pa),
-		.pageofs = map->m_la & ~PAGE_MASK,
-		.grp_ret = &grp,
-		.role = &builder->role,
-		.owned_head = owned_head,
-		.hosted = &builder->hosted
-	};
-	struct z_erofs_vle_work *work;
-
-	DBG_BUGON(builder->work);
-
-	/* must be Z_EROFS_WORK_TAIL or the next chained work */
-	DBG_BUGON(*owned_head == Z_EROFS_VLE_WORKGRP_NIL);
-	DBG_BUGON(*owned_head == Z_EROFS_VLE_WORKGRP_TAIL_CLOSED);
-
-	DBG_BUGON(erofs_blkoff(map->m_pa));
+	/* must be Z_EROFS_PCLUSTER_TAIL or pointed to previous collection */
+	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_NIL);
+	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
 
-repeat:
-	work = z_erofs_vle_work_lookup(&finder);
-	if (work) {
-		unsigned int orig_llen;
-
-		/* increase workgroup `llen' if needed */
-		while ((orig_llen = READ_ONCE(grp->llen)) < map->m_llen &&
-		       orig_llen != cmpxchg_relaxed(&grp->llen,
-						    orig_llen, map->m_llen))
-			cpu_relax();
-		goto got_it;
+	if (!PAGE_ALIGNED(map->m_pa)) {
+		DBG_BUGON(1);
+		return -EINVAL;
 	}
 
-	work = z_erofs_vle_work_register(&finder, map);
-	if (unlikely(work == ERR_PTR(-EAGAIN)))
-		goto repeat;
-
-	if (IS_ERR(work))
-		return PTR_ERR(work);
-got_it:
-	z_erofs_pagevec_ctor_init(&builder->vector, Z_EROFS_NR_INLINE_PAGEVECS,
-				  work->pagevec, work->vcnt);
+repeat:
+	cl = cllookup(clt, inode, map);
+	if (!cl) {
+		cl = clregister(clt, inode, map);
 
-	if (builder->role >= Z_EROFS_VLE_WORK_PRIMARY) {
-		/* enable possibly in-place decompression */
-		builder->compressed_pages = grp->compressed_pages;
-		builder->compressed_deficit = clusterpages;
-	} else {
-		builder->compressed_pages = NULL;
-		builder->compressed_deficit = 0;
+		if (unlikely(cl == ERR_PTR(-EAGAIN)))
+			goto repeat;
 	}
 
-	builder->grp = grp;
-	builder->work = work;
+	if (IS_ERR(cl))
+		return PTR_ERR(cl);
+
+	z_erofs_pagevec_ctor_init(&clt->vector, Z_EROFS_NR_INLINE_PAGEVECS,
+				  cl->pagevec, cl->vcnt);
+
+	clt->compressedpages = clt->pcl->compressed_pages;
+	if (clt->mode <= COLLECT_PRIMARY) /* cannot do in-place I/O */
+		clt->compressedpages += Z_EROFS_CLUSTER_MAX_PAGES;
 	return 0;
 }
 
 /*
- * keep in mind that no referenced workgroups will be freed
- * only after a RCU grace period, so rcu_read_lock() could
- * prevent a workgroup from being freed.
+ * keep in mind that no referenced pclusters will be freed
+ * only after a RCU grace period.
  */
 static void z_erofs_rcu_callback(struct rcu_head *head)
 {
-	struct z_erofs_vle_work *work =	container_of(head,
-		struct z_erofs_vle_work, rcu);
-	struct z_erofs_vle_workgroup *grp =
-		z_erofs_vle_work_workgroup(work, true);
+	struct z_erofs_collection *const cl =
+		container_of(head, struct z_erofs_collection, rcu);
 
-	kmem_cache_free(z_erofs_workgroup_cachep, grp);
+	kmem_cache_free(pcluster_cachep,
+			container_of(cl, struct z_erofs_pcluster,
+				     primary_collection));
 }
 
 void erofs_workgroup_free_rcu(struct erofs_workgroup *grp)
 {
-	struct z_erofs_vle_workgroup *const vgrp = container_of(grp,
-		struct z_erofs_vle_workgroup, obj);
-	struct z_erofs_vle_work *const work = &vgrp->work;
+	struct z_erofs_pcluster *const pcl =
+		container_of(grp, struct z_erofs_pcluster, obj);
+	struct z_erofs_collection *const cl = z_erofs_primarycollection(pcl);
 
-	call_rcu(&work->rcu, z_erofs_rcu_callback);
+	call_rcu(&cl->rcu, z_erofs_rcu_callback);
 }
 
-static void
-__z_erofs_vle_work_release(struct z_erofs_vle_workgroup *grp,
-			   struct z_erofs_vle_work *work __maybe_unused)
+static void z_erofs_collection_put(struct z_erofs_collection *cl)
 {
-	erofs_workgroup_put(&grp->obj);
-}
+	struct z_erofs_pcluster *const pcl =
+		container_of(cl, struct z_erofs_pcluster, primary_collection);
 
-static void z_erofs_vle_work_release(struct z_erofs_vle_work *work)
-{
-	struct z_erofs_vle_workgroup *grp =
-		z_erofs_vle_work_workgroup(work, true);
-
-	__z_erofs_vle_work_release(grp, work);
+	erofs_workgroup_put(&pcl->obj);
 }
 
-static inline bool
-z_erofs_vle_work_iter_end(struct z_erofs_vle_work_builder *builder)
+static bool z_erofs_collector_end(struct z_erofs_collector *clt)
 {
-	struct z_erofs_vle_work *work = builder->work;
+	struct z_erofs_collection *cl = clt->cl;
 
-	if (!work)
+	if (!cl)
 		return false;
 
-	z_erofs_pagevec_ctor_exit(&builder->vector, false);
-	mutex_unlock(&work->lock);
+	z_erofs_pagevec_ctor_exit(&clt->vector, false);
+	mutex_unlock(&cl->lock);
 
 	/*
-	 * if all pending pages are added, don't hold work reference
-	 * any longer if the current work isn't hosted by ourselves.
+	 * if all pending pages are added, don't hold its reference
+	 * any longer if the pcluster isn't hosted by ourselves.
 	 */
-	if (!builder->hosted)
-		__z_erofs_vle_work_release(builder->grp, work);
+	if (clt->mode < COLLECT_PRIMARY_FOLLOWED_NOINPLACE)
+		z_erofs_collection_put(cl);
 
-	builder->work = NULL;
-	builder->grp = NULL;
+	clt->cl = NULL;
 	return true;
 }
 
@@ -643,33 +550,9 @@ static inline struct page *__stagingpage_alloc(struct list_head *pagepool,
 	return page;
 }
 
-struct z_erofs_vle_frontend {
-	struct inode *const inode;
-
-	struct z_erofs_vle_work_builder builder;
-	struct erofs_map_blocks map;
-
-	z_erofs_vle_owned_workgrp_t owned_head;
-
-	/* used for applying cache strategy on the fly */
-	bool backmost;
-	erofs_off_t headoffset;
-};
-
-#define VLE_FRONTEND_INIT(__i) { \
-	.inode = __i, \
-	.map = { \
-		.m_llen = 0, \
-		.m_plen = 0, \
-		.mpage = NULL \
-	}, \
-	.builder = VLE_WORK_BUILDER_INIT(), \
-	.owned_head = Z_EROFS_VLE_WORKGRP_TAIL, \
-	.backmost = true, }
-
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
-static inline bool
-should_alloc_managed_pages(struct z_erofs_vle_frontend *fe, erofs_off_t la)
+static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
+				       erofs_off_t la)
 {
 	if (fe->backmost)
 		return true;
@@ -680,25 +563,23 @@ should_alloc_managed_pages(struct z_erofs_vle_frontend *fe, erofs_off_t la)
 	return false;
 }
 #else
-static inline bool
-should_alloc_managed_pages(struct z_erofs_vle_frontend *fe, erofs_off_t la)
+static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
+				       erofs_off_t la)
 {
 	return false;
 }
 #endif
 
-static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
+static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 				struct page *page,
-				struct list_head *page_pool)
+				struct list_head *pagepool)
 {
-	struct super_block *const sb = fe->inode->i_sb;
-	struct erofs_sb_info *const sbi __maybe_unused = EROFS_SB(sb);
+	struct inode *const inode = fe->inode;
+	struct erofs_sb_info *const sbi __maybe_unused = EROFS_I_SB(inode);
 	struct erofs_map_blocks *const map = &fe->map;
-	struct z_erofs_vle_work_builder *const builder = &fe->builder;
+	struct z_erofs_collector *const clt = &fe->clt;
 	const loff_t offset = page_offset(page);
-
-	bool tight = builder_is_hooked(builder);
-	struct z_erofs_vle_work *work = builder->work;
+	bool tight = (clt->mode >= COLLECT_PRIMARY_HOOKED);
 
 	enum z_erofs_cache_alloctype cache_strategy;
 	enum z_erofs_page_type page_type;
@@ -716,8 +597,8 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 	/* lucky, within the range of the current map_blocks */
 	if (offset + cur >= map->m_la &&
 	    offset + cur < map->m_la + map->m_llen) {
-		/* didn't get a valid unzip work previously (very rare) */
-		if (!builder->work)
+		/* didn't get a valid collection previously (very rare) */
+		if (!clt->cl)
 			goto restart_now;
 		goto hitted;
 	}
@@ -725,12 +606,12 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 	/* go ahead the next map_blocks */
 	debugln("%s: [out-of-range] pos %llu", __func__, offset + cur);
 
-	if (z_erofs_vle_work_iter_end(builder))
+	if (z_erofs_collector_end(clt))
 		fe->backmost = false;
 
 	map->m_la = offset + cur;
 	map->m_llen = 0;
-	err = z_erofs_map_blocks_iter(fe->inode, map, 0);
+	err = z_erofs_map_blocks_iter(inode, map, 0);
 	if (unlikely(err))
 		goto err_out;
 
@@ -738,10 +619,7 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 	if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED)))
 		goto hitted;
 
-	DBG_BUGON(map->m_plen != 1 << sbi->clusterbits);
-	DBG_BUGON(erofs_blkoff(map->m_pa));
-
-	err = z_erofs_vle_work_iter_begin(builder, sb, map, &fe->owned_head);
+	err = z_erofs_collector_begin(clt, inode, map);
 	if (unlikely(err))
 		goto err_out;
 
@@ -751,13 +629,10 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 	else
 		cache_strategy = DONTALLOC;
 
-	preload_compressed_pages(builder, MNGD_MAPPING(sbi),
-				 map->m_pa / PAGE_SIZE,
-				 map->m_plen / PAGE_SIZE,
-				 cache_strategy, page_pool, GFP_KERNEL);
+	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
+				 cache_strategy, pagepool);
 
-	tight &= builder_is_hooked(builder);
-	work = builder->work;
+	tight &= (clt->mode >= COLLECT_PRIMARY_HOOKED);
 hitted:
 	cur = end - min_t(unsigned int, offset + end - map->m_la, end);
 	if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED))) {
@@ -772,17 +647,17 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 				Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED));
 
 	if (cur)
-		tight &= builder_is_followed(builder);
+		tight &= (clt->mode >= COLLECT_PRIMARY_FOLLOWED);
 
 retry:
-	err = z_erofs_vle_work_add_page(builder, page, page_type);
+	err = z_erofs_attach_page(clt, page, page_type);
 	/* should allocate an additional staging page for pagevec */
 	if (err == -EAGAIN) {
 		struct page *const newpage =
-			__stagingpage_alloc(page_pool, GFP_NOFS);
+			__stagingpage_alloc(pagepool, GFP_NOFS);
 
-		err = z_erofs_vle_work_add_page(builder, newpage,
-						Z_EROFS_PAGE_TYPE_EXCLUSIVE);
+		err = z_erofs_attach_page(clt, newpage,
+					  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
 		if (likely(!err))
 			goto retry;
 	}
@@ -790,15 +665,14 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 	if (unlikely(err))
 		goto err_out;
 
-	index = page->index - map->m_la / PAGE_SIZE;
+	index = page->index - (map->m_la >> PAGE_SHIFT);
 
-	/* FIXME! avoid the last relundant fixup & endio */
 	z_erofs_onlinepage_fixup(page, index, true);
 
 	/* bump up the number of spiltted parts of a page */
 	++spiltted;
 	/* also update nr_pages */
-	work->nr_pages = max_t(pgoff_t, work->nr_pages, index + 1);
+	clt->cl->nr_pages = max_t(pgoff_t, clt->cl->nr_pages, index + 1);
 next_part:
 	/* can be used for verification */
 	map->m_llen = offset + cur - map->m_la;
@@ -808,7 +682,6 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 		goto repeat;
 
 out:
-	/* FIXME! avoid the last relundant fixup & endio */
 	z_erofs_onlinepage_endio(page);
 
 	debugln("%s, finish page: %pK spiltted: %u map->m_llen %llu",
@@ -824,7 +697,7 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 static void z_erofs_vle_unzip_kickoff(void *ptr, int bios)
 {
 	tagptr1_t t = tagptr_init(tagptr1_t, ptr);
-	struct z_erofs_vle_unzip_io *io = tagptr_unfold_ptr(t);
+	struct z_erofs_unzip_io *io = tagptr_unfold_ptr(t);
 	bool background = tagptr_unfold_tags(t);
 
 	if (!background) {
@@ -881,45 +754,38 @@ static inline void z_erofs_vle_read_endio(struct bio *bio)
 	bio_put(bio);
 }
 
-static struct page *z_pagemap_global[Z_EROFS_VLE_VMAP_GLOBAL_PAGES];
-static DEFINE_MUTEX(z_pagemap_global_lock);
-
-static int z_erofs_vle_unzip(struct super_block *sb,
-			     struct z_erofs_vle_workgroup *grp,
-			     struct list_head *page_pool)
+static int z_erofs_decompress_pcluster(struct super_block *sb,
+				       struct z_erofs_pcluster *pcl,
+				       struct list_head *pagepool)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
-	const unsigned int clusterpages = erofs_clusterpages(sbi);
-
+	const unsigned int clusterpages = BIT(pcl->clusterbits);
 	struct z_erofs_pagevec_ctor ctor;
-	unsigned int nr_pages;
-	unsigned int sparsemem_pages = 0;
-	struct page *pages_onstack[Z_EROFS_VLE_VMAP_ONSTACK_PAGES];
+	unsigned int i, outputsize, llen, nr_pages;
+	struct page *pages_onstack[Z_EROFS_VMAP_ONSTACK_PAGES];
 	struct page **pages, **compressed_pages, *page;
-	unsigned int algorithm;
-	unsigned int i, outputsize;
 
 	enum z_erofs_page_type page_type;
 	bool overlapped, partial;
-	struct z_erofs_vle_work *work;
+	struct z_erofs_collection *cl;
 	int err;
 
 	might_sleep();
-	work = z_erofs_vle_grab_primary_work(grp);
-	DBG_BUGON(!READ_ONCE(work->nr_pages));
+	cl = z_erofs_primarycollection(pcl);
+	DBG_BUGON(!READ_ONCE(cl->nr_pages));
 
-	mutex_lock(&work->lock);
-	nr_pages = work->nr_pages;
+	mutex_lock(&cl->lock);
+	nr_pages = cl->nr_pages;
 
-	if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES))
+	if (likely(nr_pages <= Z_EROFS_VMAP_ONSTACK_PAGES)) {
 		pages = pages_onstack;
-	else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
-		 mutex_trylock(&z_pagemap_global_lock))
+	} else if (nr_pages <= Z_EROFS_VMAP_GLOBAL_PAGES &&
+		   mutex_trylock(&z_pagemap_global_lock)) {
 		pages = z_pagemap_global;
-	else {
+	} else {
 		gfp_t gfp_flags = GFP_KERNEL;
 
-		if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES)
+		if (nr_pages > Z_EROFS_VMAP_GLOBAL_PAGES)
 			gfp_flags |= __GFP_NOFAIL;
 
 		pages = kvmalloc_array(nr_pages, sizeof(struct page *),
@@ -936,9 +802,9 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		pages[i] = NULL;
 
 	z_erofs_pagevec_ctor_init(&ctor, Z_EROFS_NR_INLINE_PAGEVECS,
-				  work->pagevec, 0);
+				  cl->pagevec, 0);
 
-	for (i = 0; i < work->vcnt; ++i) {
+	for (i = 0; i < cl->vcnt; ++i) {
 		unsigned int pagenr;
 
 		page = z_erofs_pagevec_dequeue(&ctor, &page_type);
@@ -947,7 +813,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		DBG_BUGON(!page);
 		DBG_BUGON(!page->mapping);
 
-		if (z_erofs_put_stagingpage(page_pool, page))
+		if (z_erofs_put_stagingpage(pagepool, page))
 			continue;
 
 		if (page_type == Z_EROFS_VLE_PAGE_TYPE_HEAD)
@@ -960,12 +826,10 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 
 		pages[pagenr] = page;
 	}
-	sparsemem_pages = i;
-
 	z_erofs_pagevec_ctor_exit(&ctor, true);
 
 	overlapped = false;
-	compressed_pages = grp->compressed_pages;
+	compressed_pages = pcl->compressed_pages;
 
 	err = 0;
 	for (i = 0; i < clusterpages; ++i) {
@@ -992,7 +856,6 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 
 			DBG_BUGON(pagenr >= nr_pages);
 			DBG_BUGON(pages[pagenr]);
-			++sparsemem_pages;
 			pages[pagenr] = page;
 
 			overlapped = true;
@@ -1008,30 +871,26 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	if (unlikely(err))
 		goto out;
 
-	if (nr_pages << PAGE_SHIFT >= work->pageofs + grp->llen) {
-		outputsize = grp->llen;
-		partial = !(grp->flags & Z_EROFS_VLE_WORKGRP_FULL_LENGTH);
+	llen = pcl->length >> Z_EROFS_PCLUSTER_LENGTH_BIT;
+	if (nr_pages << PAGE_SHIFT >= cl->pageofs + llen) {
+		outputsize = llen;
+		partial = !(pcl->length & Z_EROFS_PCLUSTER_FULL_LENGTH);
 	} else {
-		outputsize = (nr_pages << PAGE_SHIFT) - work->pageofs;
+		outputsize = (nr_pages << PAGE_SHIFT) - cl->pageofs;
 		partial = true;
 	}
 
-	if (z_erofs_vle_workgrp_fmt(grp) == Z_EROFS_VLE_WORKGRP_FMT_PLAIN)
-		algorithm = Z_EROFS_COMPRESSION_SHIFTED;
-	else
-		algorithm = Z_EROFS_COMPRESSION_LZ4;
-
 	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.sb = sb,
 					.in = compressed_pages,
 					.out = pages,
-					.pageofs_out = work->pageofs,
+					.pageofs_out = cl->pageofs,
 					.inputsize = PAGE_SIZE,
 					.outputsize = outputsize,
-					.alg = algorithm,
+					.alg = pcl->algorithmformat,
 					.inplace_io = overlapped,
 					.partial_decoding = partial
-				 }, page_pool);
+				 }, pagepool);
 
 out:
 	/* must handle all compressed pages before endding pages */
@@ -1042,7 +901,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 			continue;
 
 		/* recycle all individual staging pages */
-		(void)z_erofs_put_stagingpage(page_pool, page);
+		(void)z_erofs_put_stagingpage(pagepool, page);
 
 		WRITE_ONCE(compressed_pages[i], NULL);
 	}
@@ -1055,7 +914,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		DBG_BUGON(!page->mapping);
 
 		/* recycle all individual staging pages */
-		if (z_erofs_put_stagingpage(page_pool, page))
+		if (z_erofs_put_stagingpage(pagepool, page))
 			continue;
 
 		if (unlikely(err < 0))
@@ -1069,65 +928,63 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	else if (unlikely(pages != pages_onstack))
 		kvfree(pages);
 
-	work->nr_pages = 0;
-	work->vcnt = 0;
+	cl->nr_pages = 0;
+	cl->vcnt = 0;
 
-	/* all work locks MUST be taken before the following line */
+	/* all cl locks MUST be taken before the following line */
+	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_NIL);
 
-	WRITE_ONCE(grp->next, Z_EROFS_VLE_WORKGRP_NIL);
+	/* all cl locks SHOULD be released right now */
+	mutex_unlock(&cl->lock);
 
-	/* all work locks SHOULD be released right now */
-	mutex_unlock(&work->lock);
-
-	z_erofs_vle_work_release(work);
+	z_erofs_collection_put(cl);
 	return err;
 }
 
 static void z_erofs_vle_unzip_all(struct super_block *sb,
-				  struct z_erofs_vle_unzip_io *io,
-				  struct list_head *page_pool)
+				  struct z_erofs_unzip_io *io,
+				  struct list_head *pagepool)
 {
-	z_erofs_vle_owned_workgrp_t owned = io->head;
+	z_erofs_next_pcluster_t owned = io->head;
 
-	while (owned != Z_EROFS_VLE_WORKGRP_TAIL_CLOSED) {
-		struct z_erofs_vle_workgroup *grp;
+	while (owned != Z_EROFS_PCLUSTER_TAIL_CLOSED) {
+		struct z_erofs_pcluster *pcl;
 
 		/* no possible that 'owned' equals Z_EROFS_WORK_TPTR_TAIL */
-		DBG_BUGON(owned == Z_EROFS_VLE_WORKGRP_TAIL);
+		DBG_BUGON(owned == Z_EROFS_PCLUSTER_TAIL);
 
 		/* no possible that 'owned' equals NULL */
-		DBG_BUGON(owned == Z_EROFS_VLE_WORKGRP_NIL);
+		DBG_BUGON(owned == Z_EROFS_PCLUSTER_NIL);
 
-		grp = container_of(owned, struct z_erofs_vle_workgroup, next);
-		owned = READ_ONCE(grp->next);
+		pcl = container_of(owned, struct z_erofs_pcluster, next);
+		owned = READ_ONCE(pcl->next);
 
-		z_erofs_vle_unzip(sb, grp, page_pool);
+		z_erofs_decompress_pcluster(sb, pcl, pagepool);
 	}
 }
 
 static void z_erofs_vle_unzip_wq(struct work_struct *work)
 {
-	struct z_erofs_vle_unzip_io_sb *iosb = container_of(work,
-		struct z_erofs_vle_unzip_io_sb, io.u.work);
-	LIST_HEAD(page_pool);
+	struct z_erofs_unzip_io_sb *iosb =
+		container_of(work, struct z_erofs_unzip_io_sb, io.u.work);
+	LIST_HEAD(pagepool);
 
-	DBG_BUGON(iosb->io.head == Z_EROFS_VLE_WORKGRP_TAIL_CLOSED);
-	z_erofs_vle_unzip_all(iosb->sb, &iosb->io, &page_pool);
+	DBG_BUGON(iosb->io.head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
+	z_erofs_vle_unzip_all(iosb->sb, &iosb->io, &pagepool);
 
-	put_pages_list(&page_pool);
+	put_pages_list(&pagepool);
 	kvfree(iosb);
 }
 
-static struct page *
-pickup_page_for_submission(struct z_erofs_vle_workgroup *grp,
-			   unsigned int nr,
-			   struct list_head *pagepool,
-			   struct address_space *mc,
-			   gfp_t gfp)
+static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
+					       unsigned int nr,
+					       struct list_head *pagepool,
+					       struct address_space *mc,
+					       gfp_t gfp)
 {
 	/* determined at compile time to avoid too many #ifdefs */
 	const bool nocache = __builtin_constant_p(mc) ? !mc : false;
-	const pgoff_t index = grp->obj.index;
+	const pgoff_t index = pcl->obj.index;
 	bool tocache = false;
 
 	struct address_space *mapping;
@@ -1137,7 +994,7 @@ pickup_page_for_submission(struct z_erofs_vle_workgroup *grp,
 	int justfound;
 
 repeat:
-	page = READ_ONCE(grp->compressed_pages[nr]);
+	page = READ_ONCE(pcl->compressed_pages[nr]);
 	oldpage = page;
 
 	if (!page)
@@ -1189,7 +1046,7 @@ pickup_page_for_submission(struct z_erofs_vle_workgroup *grp,
 
 	/* the page is still in manage cache */
 	if (page->mapping == mc) {
-		WRITE_ONCE(grp->compressed_pages[nr], page);
+		WRITE_ONCE(pcl->compressed_pages[nr], page);
 
 		ClearPageError(page);
 		if (!PagePrivate(page)) {
@@ -1201,7 +1058,7 @@ pickup_page_for_submission(struct z_erofs_vle_workgroup *grp,
 			DBG_BUGON(!justfound);
 
 			justfound = 0;
-			set_page_private(page, (unsigned long)grp);
+			set_page_private(page, (unsigned long)pcl);
 			SetPagePrivate(page);
 		}
 
@@ -1225,7 +1082,7 @@ pickup_page_for_submission(struct z_erofs_vle_workgroup *grp,
 	put_page(page);
 out_allocpage:
 	page = __stagingpage_alloc(pagepool, gfp);
-	if (oldpage != cmpxchg(&grp->compressed_pages[nr], oldpage, page)) {
+	if (oldpage != cmpxchg(&pcl->compressed_pages[nr], oldpage, page)) {
 		list_add(&page->lru, pagepool);
 		cpu_relax();
 		goto repeat;
@@ -1237,18 +1094,17 @@ pickup_page_for_submission(struct z_erofs_vle_workgroup *grp,
 		goto out;
 	}
 
-	set_page_private(page, (unsigned long)grp);
+	set_page_private(page, (unsigned long)pcl);
 	SetPagePrivate(page);
 out:	/* the only exit (for tracing and debugging) */
 	return page;
 }
 
-static struct z_erofs_vle_unzip_io *
-jobqueue_init(struct super_block *sb,
-	      struct z_erofs_vle_unzip_io *io,
-	      bool foreground)
+static struct z_erofs_unzip_io *jobqueue_init(struct super_block *sb,
+					      struct z_erofs_unzip_io *io,
+					      bool foreground)
 {
-	struct z_erofs_vle_unzip_io_sb *iosb;
+	struct z_erofs_unzip_io_sb *iosb;
 
 	if (foreground) {
 		/* waitqueue available for foreground io */
@@ -1267,11 +1123,11 @@ jobqueue_init(struct super_block *sb,
 	iosb->sb = sb;
 	INIT_WORK(&io->u.work, z_erofs_vle_unzip_wq);
 out:
-	io->head = Z_EROFS_VLE_WORKGRP_TAIL_CLOSED;
+	io->head = Z_EROFS_PCLUSTER_TAIL_CLOSED;
 	return io;
 }
 
-/* define workgroup jobqueue types */
+/* define decompression jobqueue types */
 enum {
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
 	JQ_BYPASS,
@@ -1281,15 +1137,15 @@ enum {
 };
 
 static void *jobqueueset_init(struct super_block *sb,
-			      z_erofs_vle_owned_workgrp_t qtail[],
-			      struct z_erofs_vle_unzip_io *q[],
-			      struct z_erofs_vle_unzip_io *fgq,
+			      z_erofs_next_pcluster_t qtail[],
+			      struct z_erofs_unzip_io *q[],
+			      struct z_erofs_unzip_io *fgq,
 			      bool forcefg)
 {
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
 	/*
 	 * if managed cache is enabled, bypass jobqueue is needed,
-	 * no need to read from device for all workgroups in this queue.
+	 * no need to read from device for all pclusters in this queue.
 	 */
 	q[JQ_BYPASS] = jobqueue_init(sb, fgq + JQ_BYPASS, true);
 	qtail[JQ_BYPASS] = &q[JQ_BYPASS]->head;
@@ -1302,26 +1158,26 @@ static void *jobqueueset_init(struct super_block *sb,
 }
 
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
-static void move_to_bypass_jobqueue(struct z_erofs_vle_workgroup *grp,
-				    z_erofs_vle_owned_workgrp_t qtail[],
-				    z_erofs_vle_owned_workgrp_t owned_head)
+static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
+				    z_erofs_next_pcluster_t qtail[],
+				    z_erofs_next_pcluster_t owned_head)
 {
-	z_erofs_vle_owned_workgrp_t *const submit_qtail = qtail[JQ_SUBMIT];
-	z_erofs_vle_owned_workgrp_t *const bypass_qtail = qtail[JQ_BYPASS];
+	z_erofs_next_pcluster_t *const submit_qtail = qtail[JQ_SUBMIT];
+	z_erofs_next_pcluster_t *const bypass_qtail = qtail[JQ_BYPASS];
 
-	DBG_BUGON(owned_head == Z_EROFS_VLE_WORKGRP_TAIL_CLOSED);
-	if (owned_head == Z_EROFS_VLE_WORKGRP_TAIL)
-		owned_head = Z_EROFS_VLE_WORKGRP_TAIL_CLOSED;
+	DBG_BUGON(owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
+	if (owned_head == Z_EROFS_PCLUSTER_TAIL)
+		owned_head = Z_EROFS_PCLUSTER_TAIL_CLOSED;
 
-	WRITE_ONCE(grp->next, Z_EROFS_VLE_WORKGRP_TAIL_CLOSED);
+	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_TAIL_CLOSED);
 
 	WRITE_ONCE(*submit_qtail, owned_head);
-	WRITE_ONCE(*bypass_qtail, &grp->next);
+	WRITE_ONCE(*bypass_qtail, &pcl->next);
 
-	qtail[JQ_BYPASS] = &grp->next;
+	qtail[JQ_BYPASS] = &pcl->next;
 }
 
-static bool postsubmit_is_all_bypassed(struct z_erofs_vle_unzip_io *q[],
+static bool postsubmit_is_all_bypassed(struct z_erofs_unzip_io *q[],
 				       unsigned int nr_bios,
 				       bool force_fg)
 {
@@ -1332,21 +1188,19 @@ static bool postsubmit_is_all_bypassed(struct z_erofs_vle_unzip_io *q[],
 	if (force_fg || nr_bios)
 		return false;
 
-	kvfree(container_of(q[JQ_SUBMIT],
-			    struct z_erofs_vle_unzip_io_sb,
-			    io));
+	kvfree(container_of(q[JQ_SUBMIT], struct z_erofs_unzip_io_sb, io));
 	return true;
 }
 #else
-static void move_to_bypass_jobqueue(struct z_erofs_vle_workgroup *grp,
-				    z_erofs_vle_owned_workgrp_t qtail[],
-				    z_erofs_vle_owned_workgrp_t owned_head)
+static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
+				    z_erofs_next_pcluster_t qtail[],
+				    z_erofs_next_pcluster_t owned_head)
 {
 	/* impossible to bypass submission for managed cache disabled */
 	DBG_BUGON(1);
 }
 
-static bool postsubmit_is_all_bypassed(struct z_erofs_vle_unzip_io *q[],
+static bool postsubmit_is_all_bypassed(struct z_erofs_unzip_io *q[],
 				       unsigned int nr_bios,
 				       bool force_fg)
 {
@@ -1357,17 +1211,14 @@ static bool postsubmit_is_all_bypassed(struct z_erofs_vle_unzip_io *q[],
 #endif
 
 static bool z_erofs_vle_submit_all(struct super_block *sb,
-				   z_erofs_vle_owned_workgrp_t owned_head,
+				   z_erofs_next_pcluster_t owned_head,
 				   struct list_head *pagepool,
-				   struct z_erofs_vle_unzip_io *fgq,
+				   struct z_erofs_unzip_io *fgq,
 				   bool force_fg)
 {
-	struct erofs_sb_info *const sbi = EROFS_SB(sb);
-	const unsigned int clusterpages = erofs_clusterpages(sbi);
-	const gfp_t gfp = GFP_NOFS;
-
-	z_erofs_vle_owned_workgrp_t qtail[NR_JOBQUEUES];
-	struct z_erofs_vle_unzip_io *q[NR_JOBQUEUES];
+	struct erofs_sb_info *const sbi __maybe_unused = EROFS_SB(sb);
+	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
+	struct z_erofs_unzip_io *q[NR_JOBQUEUES];
 	struct bio *bio;
 	void *bi_private;
 	/* since bio will be NULL, no need to initialize last_index */
@@ -1375,7 +1226,7 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 	bool force_submit = false;
 	unsigned int nr_bios;
 
-	if (unlikely(owned_head == Z_EROFS_VLE_WORKGRP_TAIL))
+	if (unlikely(owned_head == Z_EROFS_PCLUSTER_TAIL))
 		return false;
 
 	force_submit = false;
@@ -1387,29 +1238,32 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 	q[JQ_SUBMIT]->head = owned_head;
 
 	do {
-		struct z_erofs_vle_workgroup *grp;
+		struct z_erofs_pcluster *pcl;
+		unsigned int clusterpages;
 		pgoff_t first_index;
 		struct page *page;
 		unsigned int i = 0, bypass = 0;
 		int err;
 
 		/* no possible 'owned_head' equals the following */
-		DBG_BUGON(owned_head == Z_EROFS_VLE_WORKGRP_TAIL_CLOSED);
-		DBG_BUGON(owned_head == Z_EROFS_VLE_WORKGRP_NIL);
+		DBG_BUGON(owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
+		DBG_BUGON(owned_head == Z_EROFS_PCLUSTER_NIL);
+
+		pcl = container_of(owned_head, struct z_erofs_pcluster, next);
 
-		grp = container_of(owned_head,
-				   struct z_erofs_vle_workgroup, next);
+		clusterpages = BIT(pcl->clusterbits);
 
 		/* close the main owned chain at first */
-		owned_head = cmpxchg(&grp->next, Z_EROFS_VLE_WORKGRP_TAIL,
-				     Z_EROFS_VLE_WORKGRP_TAIL_CLOSED);
+		owned_head = cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
+				     Z_EROFS_PCLUSTER_TAIL_CLOSED);
 
-		first_index = grp->obj.index;
+		first_index = pcl->obj.index;
 		force_submit |= (first_index != last_index + 1);
 
 repeat:
-		page = pickup_page_for_submission(grp, i, pagepool,
-						  MNGD_MAPPING(sbi), gfp);
+		page = pickup_page_for_submission(pcl, i, pagepool,
+						  MNGD_MAPPING(sbi),
+						  GFP_NOFS);
 		if (!page) {
 			force_submit = true;
 			++bypass;
@@ -1440,10 +1294,10 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 			goto repeat;
 
 		if (bypass < clusterpages)
-			qtail[JQ_SUBMIT] = &grp->next;
+			qtail[JQ_SUBMIT] = &pcl->next;
 		else
-			move_to_bypass_jobqueue(grp, qtail, owned_head);
-	} while (owned_head != Z_EROFS_VLE_WORKGRP_TAIL);
+			move_to_bypass_jobqueue(pcl, qtail, owned_head);
+	} while (owned_head != Z_EROFS_PCLUSTER_TAIL);
 
 	if (bio)
 		__submit_bio(bio, REQ_OP_READ, 0);
@@ -1455,17 +1309,19 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 	return true;
 }
 
-static void z_erofs_submit_and_unzip(struct z_erofs_vle_frontend *f,
+static void z_erofs_submit_and_unzip(struct super_block *sb,
+				     struct z_erofs_collector *clt,
 				     struct list_head *pagepool,
 				     bool force_fg)
 {
-	struct super_block *sb = f->inode->i_sb;
-	struct z_erofs_vle_unzip_io io[NR_JOBQUEUES];
+	struct z_erofs_unzip_io io[NR_JOBQUEUES];
 
-	if (!z_erofs_vle_submit_all(sb, f->owned_head, pagepool, io, force_fg))
+	if (!z_erofs_vle_submit_all(sb, clt->owned_head,
+				    pagepool, io, force_fg))
 		return;
 
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
+	/* decompress no I/O pclusters immediately */
 	z_erofs_vle_unzip_all(sb, &io[JQ_BYPASS], pagepool);
 #endif
 	if (!force_fg)
@@ -1483,7 +1339,7 @@ static int z_erofs_vle_normalaccess_readpage(struct file *file,
 					     struct page *page)
 {
 	struct inode *const inode = page->mapping->host;
-	struct z_erofs_vle_frontend f = VLE_FRONTEND_INIT(inode);
+	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	int err;
 	LIST_HEAD(pagepool);
 
@@ -1492,14 +1348,14 @@ static int z_erofs_vle_normalaccess_readpage(struct file *file,
 	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
 
 	err = z_erofs_do_read_page(&f, page, &pagepool);
-	(void)z_erofs_vle_work_iter_end(&f.builder);
+	(void)z_erofs_collector_end(&f.clt);
 
 	if (err) {
 		errln("%s, failed to read, err [%d]", __func__, err);
 		goto out;
 	}
 
-	z_erofs_submit_and_unzip(&f, &pagepool, true);
+	z_erofs_submit_and_unzip(inode->i_sb, &f.clt, &pagepool, true);
 out:
 	if (f.map.mpage)
 		put_page(f.map.mpage);
@@ -1524,7 +1380,7 @@ static int z_erofs_vle_normalaccess_readpages(struct file *filp,
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 
 	bool sync = should_decompress_synchronously(sbi, nr_pages);
-	struct z_erofs_vle_frontend f = VLE_FRONTEND_INIT(inode);
+	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	gfp_t gfp = mapping_gfp_constraint(mapping, GFP_KERNEL);
 	struct page *head = NULL;
 	LIST_HEAD(pagepool);
@@ -1570,13 +1426,12 @@ static int z_erofs_vle_normalaccess_readpages(struct file *filp,
 			errln("%s, readahead error at page %lu of nid %llu",
 			      __func__, page->index, vi->nid);
 		}
-
 		put_page(page);
 	}
 
-	(void)z_erofs_vle_work_iter_end(&f.builder);
+	(void)z_erofs_collector_end(&f.clt);
 
-	z_erofs_submit_and_unzip(&f, &pagepool, sync);
+	z_erofs_submit_and_unzip(inode->i_sb, &f.clt, &pagepool, sync);
 
 	if (f.map.mpage)
 		put_page(f.map.mpage);
diff --git a/drivers/staging/erofs/zdata.h b/drivers/staging/erofs/zdata.h
index 6574d43ba877..1f51d80fa89f 100644
--- a/drivers/staging/erofs/zdata.h
+++ b/drivers/staging/erofs/zdata.h
@@ -18,80 +18,77 @@
  * Structure fields follow one of the following exclusion rules.
  *
  * I: Modifiable by initialization/destruction paths and read-only
- *    for everyone else.
+ *    for everyone else;
  *
+ * L: Field should be protected by pageset lock;
+ *
+ * A: Field should be accessed / updated in atomic for parallelized code.
  */
-
-struct z_erofs_vle_work {
+struct z_erofs_collection {
 	struct mutex lock;
 
-	/* I: decompression offset in page */
+	/* I: page offset of start position of decompression */
 	unsigned short pageofs;
+
+	/* L: maximum relative page index in pagevec[] */
 	unsigned short nr_pages;
 
-	/* L: queued pages in pagevec[] */
+	/* L: total number of pages in pagevec[] */
 	unsigned int vcnt;
 
 	union {
-		/* L: pagevec */
+		/* L: inline a certain number of pagevecs for bootstrap */
 		erofs_vtptr_t pagevec[Z_EROFS_NR_INLINE_PAGEVECS];
+
+		/* I: can be used to free the pcluster by RCU. */
 		struct rcu_head rcu;
 	};
 };
 
-#define Z_EROFS_VLE_WORKGRP_FMT_PLAIN        0
-#define Z_EROFS_VLE_WORKGRP_FMT_LZ4          1
-#define Z_EROFS_VLE_WORKGRP_FMT_MASK         1
-#define Z_EROFS_VLE_WORKGRP_FULL_LENGTH      2
+#define Z_EROFS_PCLUSTER_FULL_LENGTH    0x00000001
+#define Z_EROFS_PCLUSTER_LENGTH_BIT     1
 
-typedef void *z_erofs_vle_owned_workgrp_t;
+/*
+ * let's leave a type here in case of introducing
+ * another tagged pointer later.
+ */
+typedef void *z_erofs_next_pcluster_t;
 
-struct z_erofs_vle_workgroup {
+struct z_erofs_pcluster {
 	struct erofs_workgroup obj;
-	struct z_erofs_vle_work work;
+	struct z_erofs_collection primary_collection;
 
-	/* point to next owned_workgrp_t */
-	z_erofs_vle_owned_workgrp_t next;
+	/* A: point to next chained pcluster or TAILs */
+	z_erofs_next_pcluster_t next;
 
-	/* compressed pages (including multi-usage pages) */
+	/* A: compressed pages (including multi-usage pages) */
 	struct page *compressed_pages[Z_EROFS_CLUSTER_MAX_PAGES];
-	unsigned int llen, flags;
+
+	/* A: lower limit of decompressed length and if full length or not */
+	unsigned int length;
+
+	/* I: compression algorithm format */
+	unsigned char algorithmformat;
+	/* I: bit shift of physical cluster size */
+	unsigned char clusterbits;
 };
 
+#define z_erofs_primarycollection(pcluster) (&(pcluster)->primary_collection)
+
 /* let's avoid the valid 32-bit kernel addresses */
 
 /* the chained workgroup has't submitted io (still open) */
-#define Z_EROFS_VLE_WORKGRP_TAIL        ((void *)0x5F0ECAFE)
+#define Z_EROFS_PCLUSTER_TAIL           ((void *)0x5F0ECAFE)
 /* the chained workgroup has already submitted io */
-#define Z_EROFS_VLE_WORKGRP_TAIL_CLOSED ((void *)0x5F0EDEAD)
+#define Z_EROFS_PCLUSTER_TAIL_CLOSED    ((void *)0x5F0EDEAD)
 
-#define Z_EROFS_VLE_WORKGRP_NIL         (NULL)
+#define Z_EROFS_PCLUSTER_NIL            (NULL)
 
-#define z_erofs_vle_workgrp_fmt(grp)	\
-	((grp)->flags & Z_EROFS_VLE_WORKGRP_FMT_MASK)
+#define Z_EROFS_WORKGROUP_SIZE  sizeof(struct z_erofs_pcluster)
 
-static inline void z_erofs_vle_set_workgrp_fmt(
-	struct z_erofs_vle_workgroup *grp,
-	unsigned int fmt)
-{
-	grp->flags = fmt | (grp->flags & ~Z_EROFS_VLE_WORKGRP_FMT_MASK);
-}
-
-
-/* definitions if multiref is disabled */
-#define z_erofs_vle_grab_primary_work(grp)	(&(grp)->work)
-#define z_erofs_vle_grab_work(grp, pageofs)	(&(grp)->work)
-#define z_erofs_vle_work_workgroup(wrk, primary)	\
-	((primary) ? container_of(wrk,	\
-		struct z_erofs_vle_workgroup, work) : \
-		({ BUG(); (void *)NULL; }))
-
-
-#define Z_EROFS_WORKGROUP_SIZE       sizeof(struct z_erofs_vle_workgroup)
-
-struct z_erofs_vle_unzip_io {
+struct z_erofs_unzip_io {
 	atomic_t pending_bios;
-	z_erofs_vle_owned_workgrp_t head;
+	z_erofs_next_pcluster_t head;
 
 	union {
 		wait_queue_head_t wait;
@@ -99,8 +96,8 @@ struct z_erofs_vle_unzip_io {
 	} u;
 };
 
-struct z_erofs_vle_unzip_io_sb {
-	struct z_erofs_vle_unzip_io io;
+struct z_erofs_unzip_io_sb {
+	struct z_erofs_unzip_io io;
 	struct super_block *sb;
 };
 
@@ -117,8 +114,8 @@ static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
 					 struct page *page) { return false; }
 #endif	/* !EROFS_FS_HAS_MANAGED_CACHE */
 
-#define Z_EROFS_ONLINEPAGE_COUNT_BITS 2
-#define Z_EROFS_ONLINEPAGE_COUNT_MASK ((1 << Z_EROFS_ONLINEPAGE_COUNT_BITS) - 1)
+#define Z_EROFS_ONLINEPAGE_COUNT_BITS   2
+#define Z_EROFS_ONLINEPAGE_COUNT_MASK   ((1 << Z_EROFS_ONLINEPAGE_COUNT_BITS) - 1)
 #define Z_EROFS_ONLINEPAGE_INDEX_SHIFT  (Z_EROFS_ONLINEPAGE_COUNT_BITS)
 
 /*
@@ -193,13 +190,12 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
 			SetPageUptodate(page);
 		unlock_page(page);
 	}
-
 	debugln("%s, page %p value %x", __func__, page, atomic_read(u.o));
 }
 
-#define Z_EROFS_VLE_VMAP_ONSTACK_PAGES	\
+#define Z_EROFS_VMAP_ONSTACK_PAGES	\
 	min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page *), 96U)
-#define Z_EROFS_VLE_VMAP_GLOBAL_PAGES	2048
+#define Z_EROFS_VMAP_GLOBAL_PAGES	2048
 
 #endif
 
-- 
2.17.1

