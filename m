Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F805480699
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 06:46:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JNNnp2zS6z2ywR
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 16:46:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.88.44.36;
 helo=out4436.biz.mail.alibaba.com; envelope-from=hsiangkao@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JNNnl53R4z302G
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Dec 2021 16:46:34 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V0240kf_1640670365; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V0240kf_1640670365) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 28 Dec 2021 13:46:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v4 4/5] erofs: support inline data decompression
Date: Tue, 28 Dec 2021 13:46:03 +0800
Message-Id: <20211228054604.114518-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
References: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

Currently, we have already support tail-packing inline for
uncompressed file, let's also implement this for compressed
files to save I/Os and storage space.

Different from normal pclusters, compressed data is available
in advance because of other metadata I/Os. Therefore, they
directly move into the bypass queue without extra I/O submission.

It's the last compression feature before folio/subpage support.

Signed-off-by: Yue Hu <huyue2@yulong.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 139 +++++++++++++++++++++++++++++++----------------
 fs/erofs/zdata.h |  24 +++++++-
 2 files changed, 115 insertions(+), 48 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bc765d8a6dc2..170222babc5b 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -82,12 +82,13 @@ static struct z_erofs_pcluster *z_erofs_alloc_pcluster(unsigned int nrpages)
 
 static void z_erofs_free_pcluster(struct z_erofs_pcluster *pcl)
 {
+	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(pcluster_pool); ++i) {
 		struct z_erofs_pcluster_slab *pcs = pcluster_pool + i;
 
-		if (pcl->pclusterpages > pcs->maxpages)
+		if (pclusterpages > pcs->maxpages)
 			continue;
 
 		kmem_cache_free(pcs->slab, pcl);
@@ -298,6 +299,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 		container_of(grp, struct z_erofs_pcluster, obj);
 	int i;
 
+	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
 	/*
 	 * refcount of workgroup is now freezed as 1,
 	 * therefore no need to worry about available decompression users.
@@ -331,6 +333,7 @@ int erofs_try_to_free_cached_page(struct page *page)
 	if (erofs_workgroup_try_to_freeze(&pcl->obj, 1)) {
 		unsigned int i;
 
+		DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
 		for (i = 0; i < pcl->pclusterpages; ++i) {
 			if (pcl->compressed_pages[i] == page) {
 				WRITE_ONCE(pcl->compressed_pages[i], NULL);
@@ -458,6 +461,7 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 				       struct inode *inode,
 				       struct erofs_map_blocks *map)
 {
+	bool ztailpacking = map->m_flags & EROFS_MAP_META;
 	struct z_erofs_pcluster *pcl;
 	struct z_erofs_collection *cl;
 	struct erofs_workgroup *grp;
@@ -469,12 +473,12 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 	}
 
 	/* no available pcluster, let's allocate one */
-	pcl = z_erofs_alloc_pcluster(map->m_plen >> PAGE_SHIFT);
+	pcl = z_erofs_alloc_pcluster(ztailpacking ? 1 :
+				     map->m_plen >> PAGE_SHIFT);
 	if (IS_ERR(pcl))
 		return PTR_ERR(pcl);
 
 	atomic_set(&pcl->obj.refcount, 1);
-	pcl->obj.index = map->m_pa >> PAGE_SHIFT;
 	pcl->algorithmformat = map->m_algorithmformat;
 	pcl->length = (map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) |
 		(map->m_flags & EROFS_MAP_FULL_MAPPED ?
@@ -494,16 +498,25 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 	mutex_init(&cl->lock);
 	DBG_BUGON(!mutex_trylock(&cl->lock));
 
-	grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
-	if (IS_ERR(grp)) {
-		err = PTR_ERR(grp);
-		goto err_out;
-	}
+	if (ztailpacking) {
+		pcl->obj.index = 0;	/* which indicates ztailpacking */
+		pcl->pageofs_in = erofs_blkoff(map->m_pa);
+		pcl->tailpacking_size = map->m_plen;
+	} else {
+		pcl->obj.index = map->m_pa >> PAGE_SHIFT;
 
-	if (grp != &pcl->obj) {
-		clt->pcl = container_of(grp, struct z_erofs_pcluster, obj);
-		err = -EEXIST;
-		goto err_out;
+		grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
+		if (IS_ERR(grp)) {
+			err = PTR_ERR(grp);
+			goto err_out;
+		}
+
+		if (grp != &pcl->obj) {
+			clt->pcl = container_of(grp,
+					struct z_erofs_pcluster, obj);
+			err = -EEXIST;
+			goto err_out;
+		}
 	}
 	/* used to check tail merging loop due to corrupted images */
 	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
@@ -532,17 +545,20 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
 	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_NIL);
 	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
 
-	if (!PAGE_ALIGNED(map->m_pa)) {
-		DBG_BUGON(1);
-		return -EINVAL;
+	if (map->m_flags & EROFS_MAP_META) {
+		if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
+		goto tailpacking;
 	}
 
 	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT);
 	if (grp) {
 		clt->pcl = container_of(grp, struct z_erofs_pcluster, obj);
 	} else {
+tailpacking:
 		ret = z_erofs_register_collection(clt, inode, map);
-
 		if (!ret)
 			goto out;
 		if (ret != -EEXIST)
@@ -558,9 +574,9 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
 out:
 	z_erofs_pagevec_ctor_init(&clt->vector, Z_EROFS_NR_INLINE_PAGEVECS,
 				  clt->cl->pagevec, clt->cl->vcnt);
-
 	/* since file-backed online pages are traversed in reverse order */
-	clt->icpage_ptr = clt->pcl->compressed_pages + clt->pcl->pclusterpages;
+	clt->icpage_ptr = clt->pcl->compressed_pages +
+			z_erofs_pclusterpages(clt->pcl);
 	return 0;
 }
 
@@ -681,14 +697,33 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	if (err)
 		goto err_out;
 
-	/* preload all compressed pages (maybe downgrade role if necessary) */
-	if (should_alloc_managed_pages(fe, sbi->opt.cache_strategy, map->m_la))
-		cache_strategy = TRYALLOC;
-	else
-		cache_strategy = DONTALLOC;
+	if (z_erofs_is_inline_pcluster(clt->pcl)) {
+		struct page *mpage;
+
+		mpage = erofs_get_meta_page(inode->i_sb,
+					    erofs_blknr(map->m_pa));
+		if (IS_ERR(mpage)) {
+			err = PTR_ERR(mpage);
+			erofs_err(inode->i_sb,
+				  "failed to get inline page, err %d", err);
+			goto err_out;
+		}
+		/* TODO: new subpage feature will get rid of it */
+		unlock_page(mpage);
+
+		WRITE_ONCE(clt->pcl->compressed_pages[0], mpage);
+		clt->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
+	} else {
+		/* preload all compressed pages (can change mode if needed) */
+		if (should_alloc_managed_pages(fe, sbi->opt.cache_strategy,
+					       map->m_la))
+			cache_strategy = TRYALLOC;
+		else
+			cache_strategy = DONTALLOC;
 
-	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
-				 cache_strategy, pagepool);
+		preload_compressed_pages(clt, MNGD_MAPPING(sbi),
+					 cache_strategy, pagepool);
+	}
 
 hitted:
 	/*
@@ -844,6 +879,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 				       struct page **pagepool)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
+	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	struct z_erofs_pagevec_ctor ctor;
 	unsigned int i, inputsize, outputsize, llen, nr_pages;
 	struct page *pages_onstack[Z_EROFS_VMAP_ONSTACK_PAGES];
@@ -925,16 +961,15 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 	overlapped = false;
 	compressed_pages = pcl->compressed_pages;
 
-	for (i = 0; i < pcl->pclusterpages; ++i) {
+	for (i = 0; i < pclusterpages; ++i) {
 		unsigned int pagenr;
 
 		page = compressed_pages[i];
-
 		/* all compressed pages ought to be valid */
 		DBG_BUGON(!page);
-		DBG_BUGON(z_erofs_page_is_invalidated(page));
 
-		if (!z_erofs_is_shortlived_page(page)) {
+		if (!z_erofs_is_inline_pcluster(pcl) &&
+		    !z_erofs_is_shortlived_page(page)) {
 			if (erofs_page_is_managed(sbi, page)) {
 				if (!PageUptodate(page))
 					err = -EIO;
@@ -960,10 +995,8 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		}
 
 		/* PG_error needs checking for all non-managed pages */
-		if (PageError(page)) {
-			DBG_BUGON(PageUptodate(page));
+		if (!PageUptodate(page))
 			err = -EIO;
-		}
 	}
 
 	if (err)
@@ -978,11 +1011,16 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		partial = true;
 	}
 
-	inputsize = pcl->pclusterpages * PAGE_SIZE;
+	if (z_erofs_is_inline_pcluster(pcl))
+		inputsize = pcl->tailpacking_size;
+	else
+		inputsize = pclusterpages * PAGE_SIZE;
+
 	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.sb = sb,
 					.in = compressed_pages,
 					.out = pages,
+					.pageofs_in = pcl->pageofs_in,
 					.pageofs_out = cl->pageofs,
 					.inputsize = inputsize,
 					.outputsize = outputsize,
@@ -992,17 +1030,22 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 				 }, pagepool);
 
 out:
-	/* must handle all compressed pages before ending pages */
-	for (i = 0; i < pcl->pclusterpages; ++i) {
-		page = compressed_pages[i];
-
-		if (erofs_page_is_managed(sbi, page))
-			continue;
+	/* must handle all compressed pages before actual file pages */
+	if (z_erofs_is_inline_pcluster(pcl)) {
+		page = compressed_pages[0];
+		WRITE_ONCE(compressed_pages[0], NULL);
+		put_page(page);
+	} else {
+		for (i = 0; i < pclusterpages; ++i) {
+			page = compressed_pages[i];
 
-		/* recycle all individual short-lived pages */
-		(void)z_erofs_put_shortlivedpage(pagepool, page);
+			if (erofs_page_is_managed(sbi, page))
+				continue;
 
-		WRITE_ONCE(compressed_pages[i], NULL);
+			/* recycle all individual short-lived pages */
+			(void)z_erofs_put_shortlivedpage(pagepool, page);
+			WRITE_ONCE(compressed_pages[i], NULL);
+		}
 	}
 
 	for (i = 0; i < nr_pages; ++i) {
@@ -1288,6 +1331,14 @@ static void z_erofs_submit_queue(struct super_block *sb,
 
 		pcl = container_of(owned_head, struct z_erofs_pcluster, next);
 
+		/* close the main owned chain at first */
+		owned_head = cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
+				     Z_EROFS_PCLUSTER_TAIL_CLOSED);
+		if (z_erofs_is_inline_pcluster(pcl)) {
+			move_to_bypass_jobqueue(pcl, qtail, owned_head);
+			continue;
+		}
+
 		/* no device id here, thus it will always succeed */
 		mdev = (struct erofs_map_dev) {
 			.m_pa = blknr_to_addr(pcl->obj.index),
@@ -1297,10 +1348,6 @@ static void z_erofs_submit_queue(struct super_block *sb,
 		cur = erofs_blknr(mdev.m_pa);
 		end = cur + pcl->pclusterpages;
 
-		/* close the main owned chain at first */
-		owned_head = cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
-				     Z_EROFS_PCLUSTER_TAIL_CLOSED);
-
 		do {
 			struct page *page;
 
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 4a69515dea75..e043216b545f 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -62,8 +62,16 @@ struct z_erofs_pcluster {
 	/* A: lower limit of decompressed length and if full length or not */
 	unsigned int length;
 
-	/* I: physical cluster size in pages */
-	unsigned short pclusterpages;
+	/* I: page offset of inline compressed data */
+	unsigned short pageofs_in;
+
+	union {
+		/* I: physical cluster size in pages */
+		unsigned short pclusterpages;
+
+		/* I: tailpacking inline compressed size */
+		unsigned short tailpacking_size;
+	};
 
 	/* I: compression algorithm format */
 	unsigned char algorithmformat;
@@ -94,6 +102,18 @@ struct z_erofs_decompressqueue {
 	} u;
 };
 
+static inline bool z_erofs_is_inline_pcluster(struct z_erofs_pcluster *pcl)
+{
+	return !pcl->obj.index;
+}
+
+static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
+{
+	if (z_erofs_is_inline_pcluster(pcl))
+		return 1;
+	return pcl->pclusterpages;
+}
+
 #define Z_EROFS_ONLINEPAGE_COUNT_BITS   2
 #define Z_EROFS_ONLINEPAGE_COUNT_MASK   ((1 << Z_EROFS_ONLINEPAGE_COUNT_BITS) - 1)
 #define Z_EROFS_ONLINEPAGE_INDEX_SHIFT  (Z_EROFS_ONLINEPAGE_COUNT_BITS)
-- 
2.24.4

