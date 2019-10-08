Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92916CFA7A
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2019 14:54:08 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46ncjn28Y1zDqNw
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2019 23:54:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46ncj42dRlzDqKS
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2019 23:53:26 +1100 (AEDT)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id E389B92ADEDCDF851739;
 Tue,  8 Oct 2019 20:53:20 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 8 Oct 2019
 20:53:13 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH for-next 2/5] erofs: remove dead code since managed cache is
 now built-in
Date: Tue, 8 Oct 2019 20:56:13 +0800
Message-ID: <20191008125616.183715-2-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008125616.183715-1-gaoxiang25@huawei.com>
References: <20191008125616.183715-1-gaoxiang25@huawei.com>
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
Cc: Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

After commit 4279f3f9889f ("staging: erofs: turn cache
strategies into mount options"), cache strategies are
changed into mount options rather than old build configs.

Let's kill useless code for obsoleted build options.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/utils.c | 13 ++++++-------
 fs/erofs/zdata.c | 25 ++++---------------------
 2 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index d92b3e753a6f..f66043ee16b9 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -149,8 +149,7 @@ static void erofs_workgroup_unfreeze_final(struct erofs_workgroup *grp)
 }
 
 static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
-					   struct erofs_workgroup *grp,
-					   bool cleanup)
+					   struct erofs_workgroup *grp)
 {
 	/*
 	 * If managed cache is on, refcount of workgroups
@@ -188,8 +187,7 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 }
 
 static unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
-					      unsigned long nr_shrink,
-					      bool cleanup)
+					      unsigned long nr_shrink)
 {
 	pgoff_t first_index = 0;
 	void *batch[PAGEVEC_SIZE];
@@ -208,7 +206,7 @@ static unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 		first_index = grp->index + 1;
 
 		/* try to shrink each valid workgroup */
-		if (!erofs_try_to_release_workgroup(sbi, grp, cleanup))
+		if (!erofs_try_to_release_workgroup(sbi, grp))
 			continue;
 
 		++freed;
@@ -245,7 +243,8 @@ void erofs_shrinker_unregister(struct super_block *sb)
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 
 	mutex_lock(&sbi->umount_mutex);
-	erofs_shrink_workstation(sbi, ~0UL, true);
+	/* clean up all remaining workgroups in memory */
+	erofs_shrink_workstation(sbi, ~0UL);
 
 	spin_lock(&erofs_sb_list_lock);
 	list_del(&sbi->list);
@@ -294,7 +293,7 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 		spin_unlock(&erofs_sb_list_lock);
 		sbi->shrinker_run_no = run_no;
 
-		freed += erofs_shrink_workstation(sbi, nr, false);
+		freed += erofs_shrink_workstation(sbi, nr);
 
 		spin_lock(&erofs_sb_list_lock);
 		/* Get the next list element before we move this one */
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ef32757d1aac..93f8bc1a64f6 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -574,7 +574,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 				struct list_head *pagepool)
 {
 	struct inode *const inode = fe->inode;
-	struct erofs_sb_info *const sbi __maybe_unused = EROFS_I_SB(inode);
+	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct erofs_map_blocks *const map = &fe->map;
 	struct z_erofs_collector *const clt = &fe->clt;
 	const loff_t offset = page_offset(page);
@@ -997,8 +997,6 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 					       struct address_space *mc,
 					       gfp_t gfp)
 {
-	/* determined at compile time to avoid too many #ifdefs */
-	const bool nocache = __builtin_constant_p(mc) ? !mc : false;
 	const pgoff_t index = pcl->obj.index;
 	bool tocache = false;
 
@@ -1019,7 +1017,7 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	 * the cached page has not been allocated and
 	 * an placeholder is out there, prepare it now.
 	 */
-	if (!nocache && page == PAGE_UNALLOCATED) {
+	if (page == PAGE_UNALLOCATED) {
 		tocache = true;
 		goto out_allocpage;
 	}
@@ -1031,21 +1029,6 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 
 	mapping = READ_ONCE(page->mapping);
 
-	/*
-	 * if managed cache is disabled, it's no way to
-	 * get such a cached-like page.
-	 */
-	if (nocache) {
-		/* if managed cache is disabled, it is impossible `justfound' */
-		DBG_BUGON(justfound);
-
-		/* and it should be locked, not uptodate, and not truncated */
-		DBG_BUGON(!PageLocked(page));
-		DBG_BUGON(PageUptodate(page));
-		DBG_BUGON(!mapping);
-		goto out;
-	}
-
 	/*
 	 * unmanaged (file) pages are all locked solidly,
 	 * therefore it is impossible for `mapping' to be NULL.
@@ -1102,7 +1085,7 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 		cpu_relax();
 		goto repeat;
 	}
-	if (nocache || !tocache)
+	if (!tocache)
 		goto out;
 	if (add_to_page_cache_lru(page, mc, index + nr, gfp)) {
 		page->mapping = Z_EROFS_MAPPING_STAGING;
@@ -1208,7 +1191,7 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 				   struct z_erofs_unzip_io *fgq,
 				   bool force_fg)
 {
-	struct erofs_sb_info *const sbi __maybe_unused = EROFS_SB(sb);
+	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
 	struct z_erofs_unzip_io *q[NR_JOBQUEUES];
 	struct bio *bio;
-- 
2.17.1

