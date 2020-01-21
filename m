Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36983143807
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Jan 2020 09:06:31 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4821MS0gr8zDqSB
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Jan 2020 19:06:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4821MM3qySzDqQG
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Jan 2020 19:06:23 +1100 (AEDT)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B75F47C41E2D957151C1;
 Tue, 21 Jan 2020 16:06:18 +0800 (CST)
Received: from architecture4.huawei.com (10.160.196.180) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 21 Jan
 2020 16:06:10 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
Subject: [RFC PATCH] erofs: convert workstn to XArray
Date: Tue, 21 Jan 2020 16:05:22 +0800
Message-ID: <20200121080522.61612-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.160.196.180]
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

XArray has friendly apis and it will replace the old radix
tree in the near future.

This convert makes use of __xa_cmpxchg when inserting on
a just inserted item by other thread. In detail, instead
of totally looking up again as what we did for the old
radix tree, it will try to legitimize the current in-tree
item in the XArray therefore more effective.

In addition, naming is rather a challenge for non-English
speaker like me. The basic idea of workstn is to provide
a runtime sparse array with items arranged in the physical
block number order. Such items (was called workgroup) can be
used to record compress clusters or for later new features.

However, both workgroup and workstn seem not good names from
whatever point of view, so I'd like to rename them as pslot
and managed_pslots to stand for physical slots. This patch
handles the second as a part of the radix root convert.

Cc: Chao Yu <yuchao0@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org> 
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

(This patch is still under testing...)

 fs/erofs/internal.h |  8 ++---
 fs/erofs/super.c    |  2 +-
 fs/erofs/utils.c    | 85 ++++++++++++++++-----------------------------
 fs/erofs/zdata.c    | 65 ++++++++++++++++------------------
 4 files changed, 64 insertions(+), 96 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index c4c6dcdc89ad..b70f52c80852 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -52,8 +52,8 @@ struct erofs_sb_info {
 	struct list_head list;
 	struct mutex umount_mutex;
 
-	/* the dedicated workstation for compression */
-	struct radix_tree_root workstn_tree;
+	/* managed array arranged in physical block number */
+	struct xarray managed_pslots;
 
 	/* threshold for decompression synchronously */
 	unsigned int max_sync_decompress_pages;
@@ -402,8 +402,8 @@ static inline void *erofs_get_pcpubuf(unsigned int pagenr)
 int erofs_workgroup_put(struct erofs_workgroup *grp);
 struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
 					     pgoff_t index);
-int erofs_register_workgroup(struct super_block *sb,
-			     struct erofs_workgroup *grp);
+struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
+					       struct erofs_workgroup *grp);
 void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
 void erofs_shrinker_register(struct super_block *sb);
 void erofs_shrinker_unregister(struct super_block *sb);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 057e6d7b5b7f..b514c67e5fc2 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -425,7 +425,7 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 		sb->s_flags &= ~SB_POSIXACL;
 
 #ifdef CONFIG_EROFS_FS_ZIP
-	INIT_RADIX_TREE(&sbi->workstn_tree, GFP_ATOMIC);
+	xa_init(&sbi->managed_pslots);
 #endif
 
 	/* get the root inode */
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index fddc5059c930..354fa27fe13e 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -37,9 +37,6 @@ void *erofs_get_pcpubuf(unsigned int pagenr)
 /* global shrink count (for all mounted EROFS instances) */
 static atomic_long_t erofs_global_shrink_cnt;
 
-#define __erofs_workgroup_get(grp)	atomic_inc(&(grp)->refcount)
-#define __erofs_workgroup_put(grp)	atomic_dec(&(grp)->refcount)
-
 static int erofs_workgroup_get(struct erofs_workgroup *grp)
 {
 	int o;
@@ -66,7 +63,7 @@ struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
 
 repeat:
 	rcu_read_lock();
-	grp = radix_tree_lookup(&sbi->workstn_tree, index);
+	grp = xa_load(&sbi->managed_pslots, index);
 	if (grp) {
 		if (erofs_workgroup_get(grp)) {
 			/* prefer to relax rcu read side */
@@ -80,43 +77,36 @@ struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
 	return grp;
 }
 
-int erofs_register_workgroup(struct super_block *sb,
-			     struct erofs_workgroup *grp)
+struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
+					       struct erofs_workgroup *grp)
 {
 	struct erofs_sb_info *sbi;
-	int err;
-
-	/* grp shouldn't be broken or used before */
-	if (atomic_read(&grp->refcount) != 1) {
-		DBG_BUGON(1);
-		return -EINVAL;
-	}
-
-	err = radix_tree_preload(GFP_NOFS);
-	if (err)
-		return err;
-
-	sbi = EROFS_SB(sb);
-	xa_lock(&sbi->workstn_tree);
+	struct erofs_workgroup *pre;
 
 	/*
-	 * Bump up reference count before making this workgroup
-	 * visible to other users in order to avoid potential UAF
-	 * without serialized by workstn_lock.
+	 * Bump up a reference count before making this visible
+	 * to others for the XArray in order to avoid potential
+	 * UAF without serialized by xa_lock.
 	 */
-	__erofs_workgroup_get(grp);
+	atomic_inc(&grp->refcount);
 
-	err = radix_tree_insert(&sbi->workstn_tree, grp->index, grp);
-	if (err)
-		/*
-		 * it's safe to decrease since the workgroup isn't visible
-		 * and refcount >= 2 (cannot be freezed).
-		 */
-		__erofs_workgroup_put(grp);
-
-	xa_unlock(&sbi->workstn_tree);
-	radix_tree_preload_end();
-	return err;
+	sbi = EROFS_SB(sb);
+repeat:
+	xa_lock(&sbi->managed_pslots);
+	pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
+			   NULL, grp, GFP_NOFS);
+	if (pre != NULL) {
+		/* try to legitimize the current in-tree one */
+		if (erofs_workgroup_get(pre)) {
+			xa_unlock(&sbi->managed_pslots);
+			cond_resched();
+			goto repeat;
+		}
+		atomic_dec(&grp->refcount);
+		grp = pre;
+	}
+	xa_unlock(&sbi->managed_pslots);
+	return grp;
 }
 
 static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
@@ -155,7 +145,7 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 
 	/*
 	 * Note that all cached pages should be unattached
-	 * before deleted from the radix tree. Otherwise some
+	 * before deleted from the XArray. Otherwise some
 	 * cached pages could be still attached to the orphan
 	 * old workgroup when the new one is available in the tree.
 	 */
@@ -169,7 +159,7 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 	 * however in order to avoid some race conditions, add a
 	 * DBG_BUGON to observe this in advance.
 	 */
-	DBG_BUGON(radix_tree_delete(&sbi->workstn_tree, grp->index) != grp);
+	DBG_BUGON(xa_erase(&sbi->managed_pslots, grp->index) != grp);
 
 	/*
 	 * If managed cache is on, last refcount should indicate
@@ -182,22 +172,11 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 static unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 					      unsigned long nr_shrink)
 {
-	pgoff_t first_index = 0;
-	void *batch[PAGEVEC_SIZE];
+	struct erofs_workgroup *grp;
 	unsigned int freed = 0;
+	unsigned long index;
 
-	int i, found;
-repeat:
-	xa_lock(&sbi->workstn_tree);
-
-	found = radix_tree_gang_lookup(&sbi->workstn_tree,
-				       batch, first_index, PAGEVEC_SIZE);
-
-	for (i = 0; i < found; ++i) {
-		struct erofs_workgroup *grp = batch[i];
-
-		first_index = grp->index + 1;
-
+	xa_for_each(&sbi->managed_pslots, index, grp) {
 		/* try to shrink each valid workgroup */
 		if (!erofs_try_to_release_workgroup(sbi, grp))
 			continue;
@@ -206,10 +185,6 @@ static unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 		if (!--nr_shrink)
 			break;
 	}
-	xa_unlock(&sbi->workstn_tree);
-
-	if (i && nr_shrink)
-		goto repeat;
 	return freed;
 }
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 4fedeb4496e4..df1a27536918 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -67,16 +67,6 @@ static void z_erofs_pcluster_init_once(void *ptr)
 		pcl->compressed_pages[i] = NULL;
 }
 
-static void z_erofs_pcluster_init_always(struct z_erofs_pcluster *pcl)
-{
-	struct z_erofs_collection *cl = z_erofs_primarycollection(pcl);
-
-	atomic_set(&pcl->obj.refcount, 1);
-
-	DBG_BUGON(cl->nr_pages);
-	DBG_BUGON(cl->vcnt);
-}
-
 int __init z_erofs_init_zip_subsystem(void)
 {
 	pcluster_cachep = kmem_cache_create("erofs_compress",
@@ -341,26 +331,19 @@ static int z_erofs_lookup_collection(struct z_erofs_collector *clt,
 				     struct inode *inode,
 				     struct erofs_map_blocks *map)
 {
-	struct erofs_workgroup *grp;
-	struct z_erofs_pcluster *pcl;
+	struct z_erofs_pcluster *pcl = clt->pcl;
 	struct z_erofs_collection *cl;
 	unsigned int length;
 
-	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT);
-	if (!grp)
-		return -ENOENT;
-
-	pcl = container_of(grp, struct z_erofs_pcluster, obj);
+	/* to avoid unexpected loop formed by corrupted images */
 	if (clt->owned_head == &pcl->next || pcl == clt->tailpcl) {
 		DBG_BUGON(1);
-		erofs_workgroup_put(grp);
 		return -EFSCORRUPTED;
 	}
 
 	cl = z_erofs_primarycollection(pcl);
 	if (cl->pageofs != (map->m_la & ~PAGE_MASK)) {
 		DBG_BUGON(1);
-		erofs_workgroup_put(grp);
 		return -EFSCORRUPTED;
 	}
 
@@ -368,7 +351,6 @@ static int z_erofs_lookup_collection(struct z_erofs_collector *clt,
 	if (length & Z_EROFS_PCLUSTER_FULL_LENGTH) {
 		if ((map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) > length) {
 			DBG_BUGON(1);
-			erofs_workgroup_put(grp);
 			return -EFSCORRUPTED;
 		}
 	} else {
@@ -391,7 +373,6 @@ static int z_erofs_lookup_collection(struct z_erofs_collector *clt,
 	/* clean tailpcl if the current owned_head is Z_EROFS_PCLUSTER_TAIL */
 	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
 		clt->tailpcl = NULL;
-	clt->pcl = pcl;
 	clt->cl = cl;
 	return 0;
 }
@@ -402,14 +383,14 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 {
 	struct z_erofs_pcluster *pcl;
 	struct z_erofs_collection *cl;
-	int err;
+	struct erofs_workgroup *grp;
 
 	/* no available workgroup, let's allocate one */
 	pcl = kmem_cache_alloc(pcluster_cachep, GFP_NOFS);
 	if (!pcl)
 		return -ENOMEM;
 
-	z_erofs_pcluster_init_always(pcl);
+	atomic_set(&pcl->obj.refcount, 1);
 	pcl->obj.index = map->m_pa >> PAGE_SHIFT;
 
 	pcl->length = (map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) |
@@ -429,20 +410,27 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 	clt->mode = COLLECT_PRIMARY_FOLLOWED;
 
 	cl = z_erofs_primarycollection(pcl);
+
+	/* must be cleaned before freeing to slab */
+	DBG_BUGON(cl->nr_pages);
+	DBG_BUGON(cl->vcnt);
+
 	cl->pageofs = map->m_la & ~PAGE_MASK;
 
 	/*
 	 * lock all primary followed works before visible to others
 	 * and mutex_trylock *never* fails for a new pcluster.
 	 */
-	mutex_trylock(&cl->lock);
+	DBG_BUGON(!mutex_trylock(&cl->lock));
 
-	err = erofs_register_workgroup(inode->i_sb, &pcl->obj);
-	if (err) {
+	grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
+	if (grp != &pcl->obj) {
+		clt->pcl = container_of(grp, struct z_erofs_pcluster, obj);
 		mutex_unlock(&cl->lock);
 		kmem_cache_free(pcluster_cachep, pcl);
-		return -EAGAIN;
+		return -EEXIST;
 	}
+
 	/* used to check tail merging loop due to corrupted images */
 	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
 		clt->tailpcl = pcl;
@@ -456,6 +444,7 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
 				   struct inode *inode,
 				   struct erofs_map_blocks *map)
 {
+	struct erofs_workgroup *grp;
 	int ret;
 
 	DBG_BUGON(clt->cl);
@@ -469,21 +458,25 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
 		return -EINVAL;
 	}
 
-repeat:
-	ret = z_erofs_lookup_collection(clt, inode, map);
-	if (ret == -ENOENT) {
+	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT);
+	if (grp) {
+		clt->pcl = container_of(grp, struct z_erofs_pcluster, obj);
+	} else {
 		ret = z_erofs_register_collection(clt, inode, map);
 
-		/* someone registered at the same time, give another try */
-		if (ret == -EAGAIN) {
-			cond_resched();
-			goto repeat;
-		}
+		if (!ret)
+			goto out;
+		if (ret != -EEXIST)
+			return ret;
 	}
 
-	if (ret)
+	ret = z_erofs_lookup_collection(clt, inode, map);
+	if (ret) {
+		erofs_workgroup_put(&clt->pcl->obj);
 		return ret;
+	}
 
+out:
 	z_erofs_pagevec_ctor_init(&clt->vector, Z_EROFS_NR_INLINE_PAGEVECS,
 				  clt->cl->pagevec, clt->cl->vcnt);
 
-- 
2.17.1

