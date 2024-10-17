Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49899A219A
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 13:57:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XTmYB5SsFz3bmN
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 22:57:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729166249;
	cv=none; b=DCXwNb3gnJK6yDaRAMAAFCn8hFXtxAUjz0sUFdY6/pkrXiHowCfhlvIgEUkNou1n9N+NBRbcs0s3vzCIh5TV/n67glpGPQtp3i1dkhqljJj4OGL61IBSOoB+ZbGQPEMJMVGeJkMTGaRF3RWT2nPXIqHHPf0dEpzzzcq24NaW0UJsdthxyW6pS9rAqpghX+MoHFj7KJXmBGvERJVOwu6d/dGAfYKIeG7S4/pKSpKqXKG36+1qC1quOcIV1/23+SBaoMKpnvUbJ0NbeQT4Z39c+jWvXcQr4PWImYNcna8dGvT4yGlZvdGBEQyAISZW+jYNSmoJMF1Z+NXKGFBxRPUuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729166249; c=relaxed/relaxed;
	bh=QBOiO5DCDuqymgqFkVqeffNKMjz5K9SEriFkFK01Vrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuXsSoWrsRE+jwSeKv8ct/SgIsPuePez5CyOMiP9puNFmoVt8S4TuwAtZBovLtxNpnHtV9a8V6FkqWWwBSHdJGmURS+O9QqGvqIZOar6cYrBLDwL8lt/U5/4V3sTucrNldG9kDqTdm3Hq+rW1uhpvWn96ETWkcjcplkfI71vpIpqtTfaRM6b+JwS/ZdmzVIWwDT2U0aCQ2o9kaEcQxgKgitzliLosdQYy1KJE+EG/tS8wxVvX/Kp6WlpqRXaGorDH94P9wBvrM88E09vnH8nxpo1ZgB723Kxe8XLOljQz402Ahfe21lglmrJIKeH/KYVduG6xXD1eIveLUZ7Ici24g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=J15isDiG; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=J15isDiG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XTmY06djpz2yMk
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Oct 2024 22:57:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729166236; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QBOiO5DCDuqymgqFkVqeffNKMjz5K9SEriFkFK01Vrg=;
	b=J15isDiGc6IUyhDSnH+Wd4Pn3jzsxo7VJtKcbCz3qm3ZCyyoZq0W/h2VdR0KX6/kvo9dj6g9ylKhZqvOc94a1s4ClF811V0h60IpgbvX3CLuYcuspSl6UKx818ysVqIG/UOvriY4fPzS3fIxf7wdfS+ZVUmoArsrMLHfOi88yuQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHKltDs_1729166234 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 19:57:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs: move erofs_workgroup operations into zdata.c
Date: Thu, 17 Oct 2024 19:57:04 +0800
Message-ID: <20241017115705.877515-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017115705.877515-1-hsiangkao@linux.alibaba.com>
References: <20241017115705.877515-1-hsiangkao@linux.alibaba.com>
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
Cc: Chunhai Guo <guochunhai@vivo.com>, LKML <linux-kernel@vger.kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Move related helpers into zdata.c as an intermediate step of getting
rid of `struct erofs_workgroup`, and rename:

 erofs_workgroup_put => z_erofs_put_pcluster
 erofs_workgroup_get => z_erofs_get_pcluster
 erofs_try_to_release_workgroup => erofs_try_to_release_pcluster
 erofs_shrink_workstation => z_erofs_shrink_scan

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h |   8 ++--
 fs/erofs/zdata.c    | 102 ++++++++++++++++++++++++++++++++++++++---
 fs/erofs/zutil.c    | 107 +++-----------------------------------------
 3 files changed, 105 insertions(+), 112 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 8081ee43cd83..5fa7ac0575b2 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -456,17 +456,15 @@ static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
 void erofs_release_pages(struct page **pagepool);
 
 #ifdef CONFIG_EROFS_FS_ZIP
-void erofs_workgroup_put(struct erofs_workgroup *grp);
-bool erofs_workgroup_get(struct erofs_workgroup *grp);
-void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
+extern atomic_long_t erofs_global_shrink_cnt;
 void erofs_shrinker_register(struct super_block *sb);
 void erofs_shrinker_unregister(struct super_block *sb);
 int __init erofs_init_shrinker(void);
 void erofs_exit_shrinker(void);
 int __init z_erofs_init_subsystem(void);
 void z_erofs_exit_subsystem(void);
-int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
-					struct erofs_workgroup *egrp);
+unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
+				  unsigned long nr_shrink);
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags);
 void *z_erofs_get_gbuf(unsigned int requiredpages);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 7423354d6957..cd181bb837a4 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -587,8 +587,8 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 }
 
 /* (erofs_shrinker) disconnect cached encoded data with pclusters */
-int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
-					struct erofs_workgroup *grp)
+static int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
+					       struct erofs_workgroup *grp)
 {
 	struct z_erofs_pcluster *const pcl =
 		container_of(grp, struct z_erofs_pcluster, obj);
@@ -710,6 +710,23 @@ static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
 	return ret;
 }
 
+static bool z_erofs_get_pcluster(struct erofs_workgroup *grp)
+{
+	if (lockref_get_not_zero(&grp->lockref))
+		return true;
+
+	spin_lock(&grp->lockref.lock);
+	if (__lockref_is_dead(&grp->lockref)) {
+		spin_unlock(&grp->lockref.lock);
+		return false;
+	}
+
+	if (!grp->lockref.count++)
+		atomic_long_dec(&erofs_global_shrink_cnt);
+	spin_unlock(&grp->lockref.lock);
+	return true;
+}
+
 static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
@@ -757,7 +774,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 			xa_lock(&sbi->managed_pslots);
 			pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
 					   NULL, grp, GFP_KERNEL);
-			if (!pre || xa_is_err(pre) || erofs_workgroup_get(pre)) {
+			if (!pre || xa_is_err(pre) || z_erofs_get_pcluster(pre)) {
 				xa_unlock(&sbi->managed_pslots);
 				break;
 			}
@@ -801,7 +818,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 		while (1) {
 			rcu_read_lock();
 			grp = xa_load(&EROFS_SB(sb)->managed_pslots, blknr);
-			if (erofs_workgroup_get(grp)) {
+			if (z_erofs_get_pcluster(grp)) {
 				DBG_BUGON(blknr != grp->index);
 				rcu_read_unlock();
 				break;
@@ -869,7 +886,7 @@ static void z_erofs_rcu_callback(struct rcu_head *head)
 			struct z_erofs_pcluster, rcu));
 }
 
-void erofs_workgroup_free_rcu(struct erofs_workgroup *grp)
+static void erofs_workgroup_free_rcu(struct erofs_workgroup *grp)
 {
 	struct z_erofs_pcluster *const pcl =
 		container_of(grp, struct z_erofs_pcluster, obj);
@@ -877,6 +894,77 @@ void erofs_workgroup_free_rcu(struct erofs_workgroup *grp)
 	call_rcu(&pcl->rcu, z_erofs_rcu_callback);
 }
 
+static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+					  struct erofs_workgroup *grp)
+{
+	int free = false;
+
+	spin_lock(&grp->lockref.lock);
+	if (grp->lockref.count)
+		goto out;
+
+	/*
+	 * Note that all cached folios should be detached before deleted from
+	 * the XArray.  Otherwise some folios could be still attached to the
+	 * orphan old pcluster when the new one is available in the tree.
+	 */
+	if (erofs_try_to_free_all_cached_folios(sbi, grp))
+		goto out;
+
+	/*
+	 * It's impossible to fail after the pcluster is freezed, but in order
+	 * to avoid some race conditions, add a DBG_BUGON to observe this.
+	 */
+	DBG_BUGON(__xa_erase(&sbi->managed_pslots, grp->index) != grp);
+
+	lockref_mark_dead(&grp->lockref);
+	free = true;
+out:
+	spin_unlock(&grp->lockref.lock);
+	if (free) {
+		atomic_long_dec(&erofs_global_shrink_cnt);
+		erofs_workgroup_free_rcu(grp);
+	}
+	return free;
+}
+
+unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
+				  unsigned long nr_shrink)
+{
+	struct erofs_workgroup *grp;
+	unsigned int freed = 0;
+	unsigned long index;
+
+	xa_lock(&sbi->managed_pslots);
+	xa_for_each(&sbi->managed_pslots, index, grp) {
+		/* try to shrink each valid pcluster */
+		if (!erofs_try_to_release_pcluster(sbi, grp))
+			continue;
+		xa_unlock(&sbi->managed_pslots);
+
+		++freed;
+		if (!--nr_shrink)
+			return freed;
+		xa_lock(&sbi->managed_pslots);
+	}
+	xa_unlock(&sbi->managed_pslots);
+	return freed;
+}
+
+static void z_erofs_put_pcluster(struct z_erofs_pcluster *pcl)
+{
+	struct erofs_workgroup *grp = &pcl->obj;
+
+	if (lockref_put_or_lock(&grp->lockref))
+		return;
+
+	DBG_BUGON(__lockref_is_dead(&grp->lockref));
+	if (grp->lockref.count == 1)
+		atomic_long_inc(&erofs_global_shrink_cnt);
+	--grp->lockref.count;
+	spin_unlock(&grp->lockref.lock);
+}
+
 static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 {
 	struct z_erofs_pcluster *pcl = fe->pcl;
@@ -895,7 +983,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 	 * any longer if the pcluster isn't hosted by ourselves.
 	 */
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
-		erofs_workgroup_put(&pcl->obj);
+		z_erofs_put_pcluster(pcl);
 
 	fe->pcl = NULL;
 }
@@ -1327,7 +1415,7 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		if (z_erofs_is_inline_pcluster(be.pcl))
 			z_erofs_free_pcluster(be.pcl);
 		else
-			erofs_workgroup_put(&be.pcl->obj);
+			z_erofs_put_pcluster(be.pcl);
 	}
 	return err;
 }
diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 218b0249a482..75704f58ecfa 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             https://www.huawei.com/
+ * Copyright (C) 2024 Alibaba Cloud
  */
 #include "internal.h"
 
@@ -19,13 +20,12 @@ static unsigned int z_erofs_gbuf_count, z_erofs_gbuf_nrpages,
 module_param_named(global_buffers, z_erofs_gbuf_count, uint, 0444);
 module_param_named(reserved_pages, z_erofs_rsv_nrpages, uint, 0444);
 
-static atomic_long_t erofs_global_shrink_cnt;	/* for all mounted instances */
-/* protected by 'erofs_sb_list_lock' */
-static unsigned int shrinker_run_no;
+atomic_long_t erofs_global_shrink_cnt;	/* for all mounted instances */
 
-/* protects the mounted 'erofs_sb_list' */
+/* protects `erofs_sb_list_lock` and the mounted `erofs_sb_list` */
 static DEFINE_SPINLOCK(erofs_sb_list_lock);
 static LIST_HEAD(erofs_sb_list);
+static unsigned int shrinker_run_no;
 static struct shrinker *erofs_shrinker_info;
 
 static unsigned int z_erofs_gbuf_id(void)
@@ -214,97 +214,6 @@ void erofs_release_pages(struct page **pagepool)
 	}
 }
 
-bool erofs_workgroup_get(struct erofs_workgroup *grp)
-{
-	if (lockref_get_not_zero(&grp->lockref))
-		return true;
-
-	spin_lock(&grp->lockref.lock);
-	if (__lockref_is_dead(&grp->lockref)) {
-		spin_unlock(&grp->lockref.lock);
-		return false;
-	}
-
-	if (!grp->lockref.count++)
-		atomic_long_dec(&erofs_global_shrink_cnt);
-	spin_unlock(&grp->lockref.lock);
-	return true;
-}
-
-static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
-{
-	atomic_long_dec(&erofs_global_shrink_cnt);
-	erofs_workgroup_free_rcu(grp);
-}
-
-void erofs_workgroup_put(struct erofs_workgroup *grp)
-{
-	if (lockref_put_or_lock(&grp->lockref))
-		return;
-
-	DBG_BUGON(__lockref_is_dead(&grp->lockref));
-	if (grp->lockref.count == 1)
-		atomic_long_inc(&erofs_global_shrink_cnt);
-	--grp->lockref.count;
-	spin_unlock(&grp->lockref.lock);
-}
-
-static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
-					   struct erofs_workgroup *grp)
-{
-	int free = false;
-
-	spin_lock(&grp->lockref.lock);
-	if (grp->lockref.count)
-		goto out;
-
-	/*
-	 * Note that all cached pages should be detached before deleted from
-	 * the XArray. Otherwise some cached pages could be still attached to
-	 * the orphan old workgroup when the new one is available in the tree.
-	 */
-	if (erofs_try_to_free_all_cached_folios(sbi, grp))
-		goto out;
-
-	/*
-	 * It's impossible to fail after the workgroup is freezed,
-	 * however in order to avoid some race conditions, add a
-	 * DBG_BUGON to observe this in advance.
-	 */
-	DBG_BUGON(__xa_erase(&sbi->managed_pslots, grp->index) != grp);
-
-	lockref_mark_dead(&grp->lockref);
-	free = true;
-out:
-	spin_unlock(&grp->lockref.lock);
-	if (free)
-		__erofs_workgroup_free(grp);
-	return free;
-}
-
-static unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
-					      unsigned long nr_shrink)
-{
-	struct erofs_workgroup *grp;
-	unsigned int freed = 0;
-	unsigned long index;
-
-	xa_lock(&sbi->managed_pslots);
-	xa_for_each(&sbi->managed_pslots, index, grp) {
-		/* try to shrink each valid workgroup */
-		if (!erofs_try_to_release_workgroup(sbi, grp))
-			continue;
-		xa_unlock(&sbi->managed_pslots);
-
-		++freed;
-		if (!--nr_shrink)
-			return freed;
-		xa_lock(&sbi->managed_pslots);
-	}
-	xa_unlock(&sbi->managed_pslots);
-	return freed;
-}
-
 void erofs_shrinker_register(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
@@ -321,8 +230,8 @@ void erofs_shrinker_unregister(struct super_block *sb)
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 
 	mutex_lock(&sbi->umount_mutex);
-	/* clean up all remaining workgroups in memory */
-	erofs_shrink_workstation(sbi, ~0UL);
+	/* clean up all remaining pclusters in memory */
+	z_erofs_shrink_scan(sbi, ~0UL);
 
 	spin_lock(&erofs_sb_list_lock);
 	list_del(&sbi->list);
@@ -370,9 +279,7 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 
 		spin_unlock(&erofs_sb_list_lock);
 		sbi->shrinker_run_no = run_no;
-
-		freed += erofs_shrink_workstation(sbi, nr - freed);
-
+		freed += z_erofs_shrink_scan(sbi, nr - freed);
 		spin_lock(&erofs_sb_list_lock);
 		/* Get the next list element before we move this one */
 		p = p->next;
-- 
2.43.5

