Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D023D712E0C
	for <lists+linux-erofs@lfdr.de>; Fri, 26 May 2023 22:15:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QSbl35gCKz3fHK
	for <lists+linux-erofs@lfdr.de>; Sat, 27 May 2023 06:15:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QSbkp5Sg7z3fCb
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 May 2023 06:15:14 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VjXYN5G_1685132110;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjXYN5G_1685132110)
          by smtp.aliyun-inc.com;
          Sat, 27 May 2023 04:15:10 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/6] erofs: adapt managed inode operations into folios
Date: Sat, 27 May 2023 04:14:57 +0800
Message-Id: <20230526201459.128169-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230526201459.128169-1-hsiangkao@linux.alibaba.com>
References: <20230526201459.128169-1-hsiangkao@linux.alibaba.com>
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

This patch gets rid of erofs_try_to_free_cached_page() and fold it
into .release_folio().

It also moves managed inode operations into zdata.c, which simplifies
the code a bit.  No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h |  3 ++-
 fs/erofs/super.c    | 62 ---------------------------------------------
 fs/erofs/zdata.c    | 59 ++++++++++++++++++++++++++++++++++++------
 3 files changed, 53 insertions(+), 71 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index af0431a40647..0b8506c39145 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -506,12 +506,12 @@ int __init z_erofs_init_zip_subsystem(void);
 void z_erofs_exit_zip_subsystem(void);
 int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 				       struct erofs_workgroup *egrp);
-int erofs_try_to_free_cached_page(struct page *page);
 int z_erofs_load_lz4_config(struct super_block *sb,
 			    struct erofs_super_block *dsb,
 			    struct z_erofs_lz4_cfgs *lz4, int len);
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags);
+int erofs_init_managed_cache(struct super_block *sb);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
 static inline void erofs_shrinker_unregister(struct super_block *sb) {}
@@ -529,6 +529,7 @@ static inline int z_erofs_load_lz4_config(struct super_block *sb,
 	}
 	return 0;
 }
+static inline int erofs_init_managed_cache(struct super_block *sb) { return 0; }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #ifdef CONFIG_EROFS_FS_ZIP_LZMA
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 811ab66d805e..c2829c91812b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -599,68 +599,6 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	return 0;
 }
 
-#ifdef CONFIG_EROFS_FS_ZIP
-static const struct address_space_operations managed_cache_aops;
-
-static bool erofs_managed_cache_release_folio(struct folio *folio, gfp_t gfp)
-{
-	bool ret = true;
-	struct address_space *const mapping = folio->mapping;
-
-	DBG_BUGON(!folio_test_locked(folio));
-	DBG_BUGON(mapping->a_ops != &managed_cache_aops);
-
-	if (folio_test_private(folio))
-		ret = erofs_try_to_free_cached_page(&folio->page);
-
-	return ret;
-}
-
-/*
- * It will be called only on inode eviction. In case that there are still some
- * decompression requests in progress, wait with rescheduling for a bit here.
- * We could introduce an extra locking instead but it seems unnecessary.
- */
-static void erofs_managed_cache_invalidate_folio(struct folio *folio,
-					       size_t offset, size_t length)
-{
-	const size_t stop = length + offset;
-
-	DBG_BUGON(!folio_test_locked(folio));
-
-	/* Check for potential overflow in debug mode */
-	DBG_BUGON(stop > folio_size(folio) || stop < length);
-
-	if (offset == 0 && stop == folio_size(folio))
-		while (!erofs_managed_cache_release_folio(folio, GFP_NOFS))
-			cond_resched();
-}
-
-static const struct address_space_operations managed_cache_aops = {
-	.release_folio = erofs_managed_cache_release_folio,
-	.invalidate_folio = erofs_managed_cache_invalidate_folio,
-};
-
-static int erofs_init_managed_cache(struct super_block *sb)
-{
-	struct erofs_sb_info *const sbi = EROFS_SB(sb);
-	struct inode *const inode = new_inode(sb);
-
-	if (!inode)
-		return -ENOMEM;
-
-	set_nlink(inode, 1);
-	inode->i_size = OFFSET_MAX;
-
-	inode->i_mapping->a_ops = &managed_cache_aops;
-	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
-	sbi->managed_cache = inode;
-	return 0;
-}
-#else
-static int erofs_init_managed_cache(struct super_block *sb) { return 0; }
-#endif
-
 static struct inode *erofs_nfs_get_inode(struct super_block *sb,
 					 u64 ino, u32 generation)
 {
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 76488824f146..15a383899540 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -667,29 +667,72 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 	return 0;
 }
 
-int erofs_try_to_free_cached_page(struct page *page)
+static bool z_erofs_cache_release_folio(struct folio *folio, gfp_t gfp)
 {
-	struct z_erofs_pcluster *const pcl = (void *)page_private(page);
-	int ret, i;
+	struct z_erofs_pcluster *pcl = folio_get_private(folio);
+	bool ret;
+	int i;
+
+	if (!folio_test_private(folio))
+		return true;
 
 	if (!erofs_workgroup_try_to_freeze(&pcl->obj, 1))
-		return 0;
+		return false;
 
-	ret = 0;
+	ret = false;
 	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
 	for (i = 0; i < pcl->pclusterpages; ++i) {
-		if (pcl->compressed_bvecs[i].page == page) {
+		if (pcl->compressed_bvecs[i].page == &folio->page) {
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
-			ret = 1;
+			ret = true;
 			break;
 		}
 	}
 	erofs_workgroup_unfreeze(&pcl->obj, 1);
+
 	if (ret)
-		detach_page_private(page);
+		folio_detach_private(folio);
 	return ret;
 }
 
+/*
+ * It will be called only on inode eviction. In case that there are still some
+ * decompression requests in progress, wait with rescheduling for a bit here.
+ * An extra lock could be introduced instead but it seems unnecessary.
+ */
+static void z_erofs_cache_invalidate_folio(struct folio *folio,
+					   size_t offset, size_t length)
+{
+	const size_t stop = length + offset;
+
+	/* Check for potential overflow in debug mode */
+	DBG_BUGON(stop > folio_size(folio) || stop < length);
+
+	if (offset == 0 && stop == folio_size(folio))
+		while (!z_erofs_cache_release_folio(folio, GFP_NOFS))
+			cond_resched();
+}
+
+static const struct address_space_operations z_erofs_cache_aops = {
+	.release_folio = z_erofs_cache_release_folio,
+	.invalidate_folio = z_erofs_cache_invalidate_folio,
+};
+
+int erofs_init_managed_cache(struct super_block *sb)
+{
+	struct inode *const inode = new_inode(sb);
+
+	if (!inode)
+		return -ENOMEM;
+
+	set_nlink(inode, 1);
+	inode->i_size = OFFSET_MAX;
+	inode->i_mapping->a_ops = &z_erofs_cache_aops;
+	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
+	EROFS_SB(sb)->managed_cache = inode;
+	return 0;
+}
+
 static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
 				   struct z_erofs_bvec *bvec)
 {
-- 
2.24.4

