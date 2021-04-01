Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A73350D10
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 05:30:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9pbQ5HCtz303M
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Apr 2021 14:30:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sDcRCglM;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=sDcRCglM; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9pbM20snz309c
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Apr 2021 14:30:06 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20F42610A5;
 Thu,  1 Apr 2021 03:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617247804;
 bh=NA0+3+wJpQp52UqaeQ3t58MREZUg72PFaniWspE5HWA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sDcRCglM0/zQhce9ukIHeBSO8AVUIO0G9Oxb1odikZyQWfOrVRfVZwCWFqZci7qQh
 EpbHPEOphbYGJi6lsSIZ29OUIk4rMaJWMFTUlZ1gMgjbSSOo9E3JqRz69Jbu53gBbi
 pYNftfbdthzNzxdq/7058GkG7eZD/BmgSLDZaRuzwrSpqHUvn6q2FIFai6a8SlgR5j
 9uSu/nh1CUBi6eCizmRTHzLA1i6NBjz0sUMKUdH8fMQh3R85cQxePbbc1dKW8Rc2jq
 vxyqYMKpFmW0SOgZ6F6BOwkdfRtAzPBxlxfncK07RUdpv7gE2V6nck7sQh/O5rBVNi
 eZqSQSwOWMEIQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH v2 02/10] erofs: introduce multipage per-CPU buffers
Date: Thu,  1 Apr 2021 11:29:46 +0800
Message-Id: <20210401032954.20555-3-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210401032954.20555-1-xiang@kernel.org>
References: <20210401032954.20555-1-xiang@kernel.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

To deal the with the cases which inplace decompression is infeasible
for some inplace I/O. Per-CPU buffers was introduced to get rid of page
allocation latency and thrash for low-latency decompression algorithms
such as lz4.

For the big pcluster feature, introduce multipage per-CPU buffers to
keep such inplace I/O pclusters temporarily as well but note that
per-CPU pages are just consecutive virtually.

When a new big pcluster fs is mounted, its max pclustersize will be
read and per-CPU buffers can be growed if needed. Shrinking adjustable
per-CPU buffers is more complex (because we don't know if such size
is still be used), so currently just release them all when unloading.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/Makefile       |   2 +-
 fs/erofs/decompressor.c |   8 ++-
 fs/erofs/internal.h     |  24 ++-----
 fs/erofs/pcpubuf.c      | 134 ++++++++++++++++++++++++++++++++++++++++
 fs/erofs/super.c        |   1 +
 fs/erofs/utils.c        |  12 ----
 6 files changed, 147 insertions(+), 34 deletions(-)
 create mode 100644 fs/erofs/pcpubuf.c

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index af159539fc1b..1f9aced49070 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-erofs-objs := super.o inode.o data.o namei.o dir.o utils.o
+erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 27aa6a99b371..fb4838c0f0df 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -47,7 +47,9 @@ int z_erofs_load_lz4_config(struct super_block *sb,
 	EROFS_SB(sb)->lz4.max_distance_pages = distance ?
 					DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
 					LZ4_MAX_DISTANCE_PAGES;
-	return 0;
+
+	/* TODO: use max pclusterblks after bigpcluster is enabled */
+	return erofs_pcpubuf_growsize(1);
 }
 
 static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
@@ -114,7 +116,7 @@ static void *generic_copy_inplace_data(struct z_erofs_decompress_req *rq,
 	 * pages should be copied in order to avoid being overlapped.
 	 */
 	struct page **in = rq->in;
-	u8 *const tmp = erofs_get_pcpubuf(0);
+	u8 *const tmp = erofs_get_pcpubuf(1);
 	u8 *tmpp = tmp;
 	unsigned int inlen = rq->inputsize - pageofs_in;
 	unsigned int count = min_t(uint, inlen, PAGE_SIZE - pageofs_in);
@@ -271,7 +273,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	 * compressed data is preferred.
 	 */
 	if (rq->outputsize <= PAGE_SIZE * 7 / 8) {
-		dst = erofs_get_pcpubuf(0);
+		dst = erofs_get_pcpubuf(1);
 		if (IS_ERR(dst))
 			return PTR_ERR(dst);
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 05b02f99324c..f707d28a46d9 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -197,9 +197,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
 
 /* hard limit of pages per compressed cluster */
 #define Z_EROFS_CLUSTER_MAX_PAGES       (CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT)
-#define EROFS_PCPUBUF_NR_PAGES          Z_EROFS_CLUSTER_MAX_PAGES
-#else
-#define EROFS_PCPUBUF_NR_PAGES          0
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 /* we strictly follow PAGE_SIZE and no buffer head yet */
@@ -405,24 +402,15 @@ int erofs_namei(struct inode *dir, struct qstr *name,
 /* dir.c */
 extern const struct file_operations erofs_dir_fops;
 
+/* pcpubuf.c */
+void *erofs_get_pcpubuf(unsigned int requiredpages);
+void erofs_put_pcpubuf(void *ptr);
+int erofs_pcpubuf_growsize(unsigned int nrpages);
+void erofs_pcpubuf_exit(void);
+
 /* utils.c / zdata.c */
 struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp);
 
-#if (EROFS_PCPUBUF_NR_PAGES > 0)
-void *erofs_get_pcpubuf(unsigned int pagenr);
-#define erofs_put_pcpubuf(buf) do { \
-	(void)&(buf);	\
-	preempt_enable();	\
-} while (0)
-#else
-static inline void *erofs_get_pcpubuf(unsigned int pagenr)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
-#define erofs_put_pcpubuf(buf) do {} while (0)
-#endif
-
 #ifdef CONFIG_EROFS_FS_ZIP
 int erofs_workgroup_put(struct erofs_workgroup *grp);
 struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
diff --git a/fs/erofs/pcpubuf.c b/fs/erofs/pcpubuf.c
new file mode 100644
index 000000000000..24ad0a1a4dd1
--- /dev/null
+++ b/fs/erofs/pcpubuf.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020-2021 Gao Xiang <xiang@kernel.org>
+ *
+ * For low-latency decompression algorithms (e.g. lz4), reserve continuous
+ * per-CPU virtual memory (in pages) in advance to store such inplace I/O
+ * data if inplace decompression is failed (due to unmet inplace margin for
+ * example).
+ */
+#include "internal.h"
+
+struct erofs_pcpubuf {
+	raw_spinlock_t lock;
+	void *ptr;
+	struct page **pages;
+	unsigned int nrpages;
+};
+
+static DEFINE_PER_CPU(struct erofs_pcpubuf, erofs_pcb);
+
+void *erofs_get_pcpubuf(unsigned int requiredpages)
+{
+	struct erofs_pcpubuf *pcb = &get_cpu_var(erofs_pcb);
+
+	raw_spin_lock(&pcb->lock);
+	if (requiredpages > pcb->nrpages) {
+		raw_spin_unlock(&pcb->lock);
+		put_cpu_var(erofs_pcb);
+		return NULL;
+	}
+	return pcb->ptr;
+}
+
+void erofs_put_pcpubuf(void *ptr)
+{
+	struct erofs_pcpubuf *pcb = &per_cpu(erofs_pcb, smp_processor_id());
+
+	DBG_BUGON(pcb->ptr != ptr);
+	raw_spin_unlock(&pcb->lock);
+	put_cpu_var(erofs_pcb);
+}
+
+/* the next step: support per-CPU page buffers hotplug */
+int erofs_pcpubuf_growsize(unsigned int nrpages)
+{
+	static DEFINE_MUTEX(pcb_resize_mutex);
+	static unsigned int pcb_nrpages;
+	LIST_HEAD(pagepool);
+	int delta, cpu, ret, i;
+
+	mutex_lock(&pcb_resize_mutex);
+	delta = nrpages - pcb_nrpages;
+	ret = 0;
+	/* avoid shrinking pcpubuf, since no idea how many fses rely on */
+	if (delta <= 0)
+		goto out;
+
+	for_each_possible_cpu(cpu) {
+		struct erofs_pcpubuf *pcb = &per_cpu(erofs_pcb, cpu);
+		struct page **pages, **oldpages;
+		void *ptr, *old_ptr;
+
+		pages = kmalloc_array(nrpages, sizeof(*pages), GFP_KERNEL);
+		if (!pages) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		for (i = 0; i < nrpages; ++i) {
+			pages[i] = erofs_allocpage(&pagepool, GFP_KERNEL);
+			if (!pages[i]) {
+				ret = -ENOMEM;
+				oldpages = pages;
+				goto free_pagearray;
+			}
+		}
+		ptr = vmap(pages, nrpages, VM_MAP, PAGE_KERNEL);
+		if (!ptr) {
+			ret = -ENOMEM;
+			oldpages = pages;
+			goto free_pagearray;
+		}
+		raw_spin_lock(&pcb->lock);
+		old_ptr = pcb->ptr;
+		pcb->ptr = ptr;
+		oldpages = pcb->pages;
+		pcb->pages = pages;
+		i = pcb->nrpages;
+		pcb->nrpages = nrpages;
+		raw_spin_unlock(&pcb->lock);
+
+		if (!oldpages) {
+			DBG_BUGON(old_ptr);
+			continue;
+		}
+
+		if (old_ptr)
+			vunmap(old_ptr);
+free_pagearray:
+		while (i)
+			list_add(&oldpages[--i]->lru, &pagepool);
+		kfree(oldpages);
+		if (ret)
+			break;
+	}
+	pcb_nrpages = nrpages;
+	put_pages_list(&pagepool);
+out:
+	mutex_unlock(&pcb_resize_mutex);
+	return ret;
+}
+
+void erofs_pcpubuf_exit(void)
+{
+	int cpu, i;
+
+	for_each_possible_cpu(cpu) {
+		struct erofs_pcpubuf *pcb = &per_cpu(erofs_pcb, cpu);
+
+		if (pcb->ptr) {
+			vunmap(pcb->ptr);
+			pcb->ptr = NULL;
+		}
+		if (!pcb->pages)
+			continue;
+
+		for (i = 0; i < pcb->nrpages; ++i)
+			if (pcb->pages[i])
+				put_page(pcb->pages[i]);
+		kfree(pcb->pages);
+		pcb->pages = NULL;
+	}
+}
+
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index b641658e772f..41fbfee4990c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -684,6 +684,7 @@ static void __exit erofs_module_exit(void)
 	/* Ensure all RCU free inodes are safe before cache is destroyed. */
 	rcu_barrier();
 	kmem_cache_destroy(erofs_inode_cachep);
+	erofs_pcpubuf_exit();
 }
 
 /* get filesystem statistics */
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index de9986d2f82f..6758c5b19f7c 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -21,18 +21,6 @@ struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp)
 	return page;
 }
 
-#if (EROFS_PCPUBUF_NR_PAGES > 0)
-static struct {
-	u8 data[PAGE_SIZE * EROFS_PCPUBUF_NR_PAGES];
-} ____cacheline_aligned_in_smp erofs_pcpubuf[NR_CPUS];
-
-void *erofs_get_pcpubuf(unsigned int pagenr)
-{
-	preempt_disable();
-	return &erofs_pcpubuf[smp_processor_id()].data[pagenr * PAGE_SIZE];
-}
-#endif
-
 #ifdef CONFIG_EROFS_FS_ZIP
 /* global shrink count (for all mounted EROFS instances) */
 static atomic_long_t erofs_global_shrink_cnt;
-- 
2.20.1

