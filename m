Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6D577211E
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Aug 2023 13:19:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1691407166;
	bh=BzKzY0EneoO0UlcJt4xJM2Sa0N5zE3blYFeUn1CwPvs=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=n+2XUvgY/lac2cFE0B8ecvnmopehfWKiOvI73fROyc9cc+dmvGKcnGYWo9HFYk2wS
	 PEqct2YUctTb6GnxEciyKfVdWAUGWCCx1Q8QakLTUtZ0rDakWOwWFr1wirc/jQKiAc
	 VDyCWvkeZ6k8I/Ur7VdzJeEpURMugKfB6QHJh5fBZf4W1HXE8HvOW2wuX3c+Hh1agy
	 9crNLxdy7HB6qVTcjCpUmlq5VxIJALYCrF5gjN3L9SBXmX/qR3lCBve7xv0+TCz5zy
	 m4VFhvNreAY9QrCYmqWOo9LOYrTSLW2Kq+oQvsK8xXelGymiBGAlgwGbWY0ivKd14b
	 OgJeL4L3P9Lyw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RKDNt34fvz2yGB
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Aug 2023 21:19:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=MbCTfulz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RKDNq4sxVz2yGB
	for <linux-erofs@lists.ozlabs.org>; Mon,  7 Aug 2023 21:19:23 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-268f6ba57b5so625659a91.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 07 Aug 2023 04:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407162; x=1692011962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzKzY0EneoO0UlcJt4xJM2Sa0N5zE3blYFeUn1CwPvs=;
        b=elhudOVRVhxP4AdSGt5fmI9yiYt4rL2lQZtnZ3OuoluGmZje46ba31hhxJdotO9FuD
         1Ha3cQDY0+djto1LqmjZZLGChgSE8GRoOgaZZ5gLK/EQwL4EFTyp2ujAs9zw5mDEROzx
         KeKlwE95pWQAo3Hcn1PGvFsjh12S23659dx/sSGY7YpjQJUtE3r13JZWYgdlsTE5rmxJ
         vARsUE+L9+N/8s1L6lnSaa437rFzmJK96CoDwL7cUvPTJfI3uA26nsW8qk4ozSrLwRId
         W405VcJyc/JFKSNDZqkfgo2i60phs0I8yJzwo83DNboTJGqGZdsyBnp7VPA9taA7TEi8
         u0pQ==
X-Gm-Message-State: ABy/qLa3va5X1k6JvdcJ5FYinP3LpPkzzUmE0KP5m/yF2PL3q6H6QCWd
	9x8swLe/VHqOX2rtZqUUNbTl8g==
X-Google-Smtp-Source: APBJJlGnB4Vyj5FGeoXczgSMBfjSqXYaN0nHE2UQ92aOKZGOd+EBKMKhZPi2ZgbvTuAEcRBjftj7zw==
X-Received: by 2002:a17:90a:6c97:b0:263:730b:f568 with SMTP id y23-20020a17090a6c9700b00263730bf568mr23074339pjj.3.1691407161746;
        Mon, 07 Aug 2023 04:19:21 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:19:20 -0700 (PDT)
To: akpm@linux-foundation.org,
	david@fromorbit.com,
	tkhai@ya.ru,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	djwong@kernel.org,
	brauner@kernel.org,
	paulmck@kernel.org,
	tytso@mit.edu,
	steven.price@arm.com,
	cel@kernel.org,
	senozhatsky@chromium.org,
	yujie.liu@intel.com,
	gregkh@linuxfoundation.org,
	muchun.song@linux.dev,
	simon.horman@corigine.com,
	dlemoal@kernel.org
Subject: [PATCH v4 44/48] mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}
Date: Mon,  7 Aug 2023 19:09:32 +0800
Message-Id: <20230807110936.21819-45-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
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
From: Qi Zheng via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, x86@kernel.org, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-arm-msm@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, Muchun Song <songmuchun@bytedance.com>, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, we maintain two linear arrays per node per memcg, which are
shrinker_info::map and shrinker_info::nr_deferred. And we need to resize
them when the shrinker_nr_max is exceeded, that is, allocate a new array,
and then copy the old array to the new array, and finally free the old
array by RCU.

For shrinker_info::map, we do set_bit() under the RCU lock, so we may set
the value into the old map which is about to be freed. This may cause the
value set to be lost. The current solution is not to copy the old map when
resizing, but to set all the corresponding bits in the new map to 1. This
solves the data loss problem, but bring the overhead of more pointless
loops while doing memcg slab shrink.

For shrinker_info::nr_deferred, we will only modify it under the read lock
of shrinker_rwsem, so it will not run concurrently with the resizing. But
after we make memcg slab shrink lockless, there will be the same data loss
problem as shrinker_info::map, and we can't work around it like the map.

For such resizable arrays, the most straightforward idea is to change it
to xarray, like we did for list_lru [1]. We need to do xa_store() in the
list_lru_add()-->set_shrinker_bit(), but this will cause memory
allocation, and the list_lru_add() doesn't accept failure. A possible
solution is to pre-allocate, but the location of pre-allocation is not
well determined.

Therefore, this commit chooses to introduce a secondary array for
shrinker_info::{map, nr_deferred}, so that we only need to copy this
secondary array every time the size is resized. Then even if we get the
old secondary array under the RCU lock, the found map and nr_deferred are
also true, so no data is lost.

[1]. https://lore.kernel.org/all/20220228122126.37293-13-songmuchun@bytedance.com/

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  12 +-
 include/linux/shrinker.h   |  17 +++
 mm/shrinker.c              | 250 +++++++++++++++++++++++--------------
 3 files changed, 172 insertions(+), 107 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 11810a2cfd2d..b49515bb6fbd 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -21,6 +21,7 @@
 #include <linux/vmstat.h>
 #include <linux/writeback.h>
 #include <linux/page-flags.h>
+#include <linux/shrinker.h>
 
 struct mem_cgroup;
 struct obj_cgroup;
@@ -88,17 +89,6 @@ struct mem_cgroup_reclaim_iter {
 	unsigned int generation;
 };
 
-/*
- * Bitmap and deferred work of shrinker::id corresponding to memcg-aware
- * shrinkers, which have elements charged to this memcg.
- */
-struct shrinker_info {
-	struct rcu_head rcu;
-	atomic_long_t *nr_deferred;
-	unsigned long *map;
-	int map_nr_max;
-};
-
 struct lruvec_stats_percpu {
 	/* Local (CPU and cgroup) state */
 	long state[NR_VM_NODE_STAT_ITEMS];
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 025c8070dd86..eb342994675a 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -5,6 +5,23 @@
 #include <linux/atomic.h>
 #include <linux/types.h>
 
+#define SHRINKER_UNIT_BITS	BITS_PER_LONG
+
+/*
+ * Bitmap and deferred work of shrinker::id corresponding to memcg-aware
+ * shrinkers, which have elements charged to the memcg.
+ */
+struct shrinker_info_unit {
+	atomic_long_t nr_deferred[SHRINKER_UNIT_BITS];
+	DECLARE_BITMAP(map, SHRINKER_UNIT_BITS);
+};
+
+struct shrinker_info {
+	struct rcu_head rcu;
+	int map_nr_max;
+	struct shrinker_info_unit *unit[];
+};
+
 /*
  * This struct is used to pass information from page reclaim to the shrinkers.
  * We consolidate the values for easier extension later.
diff --git a/mm/shrinker.c b/mm/shrinker.c
index a27779ed3798..1911c06b8af5 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -12,15 +12,50 @@ DECLARE_RWSEM(shrinker_rwsem);
 #ifdef CONFIG_MEMCG
 static int shrinker_nr_max;
 
-/* The shrinker_info is expanded in a batch of BITS_PER_LONG */
-static inline int shrinker_map_size(int nr_items)
+static inline int shrinker_unit_size(int nr_items)
 {
-	return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
+	return (DIV_ROUND_UP(nr_items, SHRINKER_UNIT_BITS) * sizeof(struct shrinker_info_unit *));
 }
 
-static inline int shrinker_defer_size(int nr_items)
+static inline void shrinker_unit_free(struct shrinker_info *info, int start)
 {
-	return (round_up(nr_items, BITS_PER_LONG) * sizeof(atomic_long_t));
+	struct shrinker_info_unit **unit;
+	int nr, i;
+
+	if (!info)
+		return;
+
+	unit = info->unit;
+	nr = DIV_ROUND_UP(info->map_nr_max, SHRINKER_UNIT_BITS);
+
+	for (i = start; i < nr; i++) {
+		if (!unit[i])
+			break;
+
+		kvfree(unit[i]);
+		unit[i] = NULL;
+	}
+}
+
+static inline int shrinker_unit_alloc(struct shrinker_info *new,
+				       struct shrinker_info *old, int nid)
+{
+	struct shrinker_info_unit *unit;
+	int nr = DIV_ROUND_UP(new->map_nr_max, SHRINKER_UNIT_BITS);
+	int start = old ? DIV_ROUND_UP(old->map_nr_max, SHRINKER_UNIT_BITS) : 0;
+	int i;
+
+	for (i = start; i < nr; i++) {
+		unit = kvzalloc_node(sizeof(*unit), GFP_KERNEL, nid);
+		if (!unit) {
+			shrinker_unit_free(new, start);
+			return -ENOMEM;
+		}
+
+		new->unit[i] = unit;
+	}
+
+	return 0;
 }
 
 void free_shrinker_info(struct mem_cgroup *memcg)
@@ -32,6 +67,7 @@ void free_shrinker_info(struct mem_cgroup *memcg)
 	for_each_node(nid) {
 		pn = memcg->nodeinfo[nid];
 		info = rcu_dereference_protected(pn->shrinker_info, true);
+		shrinker_unit_free(info, 0);
 		kvfree(info);
 		rcu_assign_pointer(pn->shrinker_info, NULL);
 	}
@@ -40,28 +76,27 @@ void free_shrinker_info(struct mem_cgroup *memcg)
 int alloc_shrinker_info(struct mem_cgroup *memcg)
 {
 	struct shrinker_info *info;
-	int nid, size, ret = 0;
-	int map_size, defer_size = 0;
+	int nid, ret = 0;
+	int array_size = 0;
 
 	down_write(&shrinker_rwsem);
-	map_size = shrinker_map_size(shrinker_nr_max);
-	defer_size = shrinker_defer_size(shrinker_nr_max);
-	size = map_size + defer_size;
+	array_size = shrinker_unit_size(shrinker_nr_max);
 	for_each_node(nid) {
-		info = kvzalloc_node(sizeof(*info) + size, GFP_KERNEL, nid);
-		if (!info) {
-			free_shrinker_info(memcg);
-			ret = -ENOMEM;
-			break;
-		}
-		info->nr_deferred = (atomic_long_t *)(info + 1);
-		info->map = (void *)info->nr_deferred + defer_size;
+		info = kvzalloc_node(sizeof(*info) + array_size, GFP_KERNEL, nid);
+		if (!info)
+			goto err;
 		info->map_nr_max = shrinker_nr_max;
+		if (shrinker_unit_alloc(info, NULL, nid))
+			goto err;
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
 	}
 	up_write(&shrinker_rwsem);
 
 	return ret;
+
+err:
+	free_shrinker_info(memcg);
+	return -ENOMEM;
 }
 
 static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
@@ -71,15 +106,12 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
 					 lockdep_is_held(&shrinker_rwsem));
 }
 
-static int expand_one_shrinker_info(struct mem_cgroup *memcg,
-				    int map_size, int defer_size,
-				    int old_map_size, int old_defer_size,
-				    int new_nr_max)
+static int expand_one_shrinker_info(struct mem_cgroup *memcg, int new_size,
+				    int old_size, int new_nr_max)
 {
 	struct shrinker_info *new, *old;
 	struct mem_cgroup_per_node *pn;
 	int nid;
-	int size = map_size + defer_size;
 
 	for_each_node(nid) {
 		pn = memcg->nodeinfo[nid];
@@ -92,21 +124,18 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 		if (new_nr_max <= old->map_nr_max)
 			continue;
 
-		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
+		new = kvmalloc_node(sizeof(*new) + new_size, GFP_KERNEL, nid);
 		if (!new)
 			return -ENOMEM;
 
-		new->nr_deferred = (atomic_long_t *)(new + 1);
-		new->map = (void *)new->nr_deferred + defer_size;
 		new->map_nr_max = new_nr_max;
 
-		/* map: set all old bits, clear all new bits */
-		memset(new->map, (int)0xff, old_map_size);
-		memset((void *)new->map + old_map_size, 0, map_size - old_map_size);
-		/* nr_deferred: copy old values, clear all new values */
-		memcpy(new->nr_deferred, old->nr_deferred, old_defer_size);
-		memset((void *)new->nr_deferred + old_defer_size, 0,
-		       defer_size - old_defer_size);
+		/* copy old values, allocate all new values */
+		memcpy(new->unit, old->unit, old_size);
+		if (shrinker_unit_alloc(new, old, nid)) {
+			kvfree(new);
+			return -ENOMEM;
+		}
 
 		rcu_assign_pointer(pn->shrinker_info, new);
 		kvfree_rcu(old, rcu);
@@ -118,9 +147,8 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 static int expand_shrinker_info(int new_id)
 {
 	int ret = 0;
-	int new_nr_max = round_up(new_id + 1, BITS_PER_LONG);
-	int map_size, defer_size = 0;
-	int old_map_size, old_defer_size = 0;
+	int new_nr_max = round_up(new_id + 1, SHRINKER_UNIT_BITS);
+	int new_size, old_size = 0;
 	struct mem_cgroup *memcg;
 
 	if (!root_mem_cgroup)
@@ -128,15 +156,12 @@ static int expand_shrinker_info(int new_id)
 
 	lockdep_assert_held(&shrinker_rwsem);
 
-	map_size = shrinker_map_size(new_nr_max);
-	defer_size = shrinker_defer_size(new_nr_max);
-	old_map_size = shrinker_map_size(shrinker_nr_max);
-	old_defer_size = shrinker_defer_size(shrinker_nr_max);
+	new_size = shrinker_unit_size(new_nr_max);
+	old_size = shrinker_unit_size(shrinker_nr_max);
 
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
-		ret = expand_one_shrinker_info(memcg, map_size, defer_size,
-					       old_map_size, old_defer_size,
+		ret = expand_one_shrinker_info(memcg, new_size, old_size,
 					       new_nr_max);
 		if (ret) {
 			mem_cgroup_iter_break(NULL, memcg);
@@ -150,17 +175,34 @@ static int expand_shrinker_info(int new_id)
 	return ret;
 }
 
+static inline int shriner_id_to_index(int shrinker_id)
+{
+	return shrinker_id / SHRINKER_UNIT_BITS;
+}
+
+static inline int shriner_id_to_offset(int shrinker_id)
+{
+	return shrinker_id % SHRINKER_UNIT_BITS;
+}
+
+static inline int calc_shrinker_id(int index, int offset)
+{
+	return index * SHRINKER_UNIT_BITS + offset;
+}
+
 void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 {
 	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
 		struct shrinker_info *info;
+		struct shrinker_info_unit *unit;
 
 		rcu_read_lock();
 		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
+		unit = info->unit[shriner_id_to_index(shrinker_id)];
 		if (!WARN_ON_ONCE(shrinker_id >= info->map_nr_max)) {
 			/* Pairs with smp mb in shrink_slab() */
 			smp_mb__before_atomic();
-			set_bit(shrinker_id, info->map);
+			set_bit(shriner_id_to_offset(shrinker_id), unit->map);
 		}
 		rcu_read_unlock();
 	}
@@ -209,26 +251,31 @@ static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
 				   struct mem_cgroup *memcg)
 {
 	struct shrinker_info *info;
+	struct shrinker_info_unit *unit;
 
 	info = shrinker_info_protected(memcg, nid);
-	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
+	unit = info->unit[shriner_id_to_index(shrinker->id)];
+	return atomic_long_xchg(&unit->nr_deferred[shriner_id_to_offset(shrinker->id)], 0);
 }
 
 static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
 				  struct mem_cgroup *memcg)
 {
 	struct shrinker_info *info;
+	struct shrinker_info_unit *unit;
 
 	info = shrinker_info_protected(memcg, nid);
-	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
+	unit = info->unit[shriner_id_to_index(shrinker->id)];
+	return atomic_long_add_return(nr, &unit->nr_deferred[shriner_id_to_offset(shrinker->id)]);
 }
 
 void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 {
-	int i, nid;
+	int nid, index, offset;
 	long nr;
 	struct mem_cgroup *parent;
 	struct shrinker_info *child_info, *parent_info;
+	struct shrinker_info_unit *child_unit, *parent_unit;
 
 	parent = parent_mem_cgroup(memcg);
 	if (!parent)
@@ -239,9 +286,13 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
-		for (i = 0; i < child_info->map_nr_max; i++) {
-			nr = atomic_long_read(&child_info->nr_deferred[i]);
-			atomic_long_add(nr, &parent_info->nr_deferred[i]);
+		for (index = 0; index < shriner_id_to_index(child_info->map_nr_max); index++) {
+			child_unit = child_info->unit[index];
+			parent_unit = parent_info->unit[index];
+			for (offset = 0; offset < SHRINKER_UNIT_BITS; offset++) {
+				nr = atomic_long_read(&child_unit->nr_deferred[offset]);
+				atomic_long_add(nr, &parent_unit->nr_deferred[offset]);
+			}
 		}
 	}
 	up_read(&shrinker_rwsem);
@@ -407,7 +458,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 {
 	struct shrinker_info *info;
 	unsigned long ret, freed = 0;
-	int i;
+	int offset, index = 0;
 
 	if (!mem_cgroup_online(memcg))
 		return 0;
@@ -419,56 +470,63 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	if (unlikely(!info))
 		goto unlock;
 
-	for_each_set_bit(i, info->map, info->map_nr_max) {
-		struct shrink_control sc = {
-			.gfp_mask = gfp_mask,
-			.nid = nid,
-			.memcg = memcg,
-		};
-		struct shrinker *shrinker;
+	for (; index < shriner_id_to_index(info->map_nr_max); index++) {
+		struct shrinker_info_unit *unit;
 
-		shrinker = idr_find(&shrinker_idr, i);
-		if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
-			if (!shrinker)
-				clear_bit(i, info->map);
-			continue;
-		}
+		unit = info->unit[index];
 
-		/* Call non-slab shrinkers even though kmem is disabled */
-		if (!memcg_kmem_online() &&
-		    !(shrinker->flags & SHRINKER_NONSLAB))
-			continue;
+		for_each_set_bit(offset, unit->map, SHRINKER_UNIT_BITS) {
+			struct shrink_control sc = {
+				.gfp_mask = gfp_mask,
+				.nid = nid,
+				.memcg = memcg,
+			};
+			struct shrinker *shrinker;
+			int shrinker_id = calc_shrinker_id(index, offset);
 
-		ret = do_shrink_slab(&sc, shrinker, priority);
-		if (ret == SHRINK_EMPTY) {
-			clear_bit(i, info->map);
-			/*
-			 * After the shrinker reported that it had no objects to
-			 * free, but before we cleared the corresponding bit in
-			 * the memcg shrinker map, a new object might have been
-			 * added. To make sure, we have the bit set in this
-			 * case, we invoke the shrinker one more time and reset
-			 * the bit if it reports that it is not empty anymore.
-			 * The memory barrier here pairs with the barrier in
-			 * set_shrinker_bit():
-			 *
-			 * list_lru_add()     shrink_slab_memcg()
-			 *   list_add_tail()    clear_bit()
-			 *   <MB>               <MB>
-			 *   set_bit()          do_shrink_slab()
-			 */
-			smp_mb__after_atomic();
-			ret = do_shrink_slab(&sc, shrinker, priority);
-			if (ret == SHRINK_EMPTY)
-				ret = 0;
-			else
-				set_shrinker_bit(memcg, nid, i);
-		}
-		freed += ret;
+			shrinker = idr_find(&shrinker_idr, shrinker_id);
+			if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
+				if (!shrinker)
+					clear_bit(offset, unit->map);
+				continue;
+			}
 
-		if (rwsem_is_contended(&shrinker_rwsem)) {
-			freed = freed ? : 1;
-			break;
+			/* Call non-slab shrinkers even though kmem is disabled */
+			if (!memcg_kmem_online() &&
+			    !(shrinker->flags & SHRINKER_NONSLAB))
+				continue;
+
+			ret = do_shrink_slab(&sc, shrinker, priority);
+			if (ret == SHRINK_EMPTY) {
+				clear_bit(offset, unit->map);
+				/*
+				 * After the shrinker reported that it had no objects to
+				 * free, but before we cleared the corresponding bit in
+				 * the memcg shrinker map, a new object might have been
+				 * added. To make sure, we have the bit set in this
+				 * case, we invoke the shrinker one more time and reset
+				 * the bit if it reports that it is not empty anymore.
+				 * The memory barrier here pairs with the barrier in
+				 * set_shrinker_bit():
+				 *
+				 * list_lru_add()     shrink_slab_memcg()
+				 *   list_add_tail()    clear_bit()
+				 *   <MB>               <MB>
+				 *   set_bit()          do_shrink_slab()
+				 */
+				smp_mb__after_atomic();
+				ret = do_shrink_slab(&sc, shrinker, priority);
+				if (ret == SHRINK_EMPTY)
+					ret = 0;
+				else
+					set_shrinker_bit(memcg, nid, shrinker_id);
+			}
+			freed += ret;
+
+			if (rwsem_is_contended(&shrinker_rwsem)) {
+				freed = freed ? : 1;
+				goto unlock;
+			}
 		}
 	}
 unlock:
-- 
2.30.2

