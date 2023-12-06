Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 41089806A66
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 10:11:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SlWqJ5lgPz3clB
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 20:11:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SlWqD0vMzz3cWG
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Dec 2023 20:11:18 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VxxSRQ7_1701853873;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VxxSRQ7_1701853873)
          by smtp.aliyun-inc.com;
          Wed, 06 Dec 2023 17:11:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/5] erofs: record `pclustersize` in bytes instead of pages
Date: Wed,  6 Dec 2023 17:10:54 +0800
Message-Id: <20231206091057.87027-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
References: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
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

Currently, compressed sizes are recorded in pages using `pclusterpages`,
However, for tailpacking pclusters, `tailpacking_size` is used instead.

This approach doesn't work when dealing with sub-page blocks. To address
this, let's switch them to the unified `pclustersize` in bytes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 64 ++++++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 38 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 421c0a88a0ca..d02989466711 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -56,6 +56,9 @@ struct z_erofs_pcluster {
 	/* L: total number of bvecs */
 	unsigned int vcnt;
 
+	/* I: pcluster size (compressed size) in bytes */
+	unsigned int pclustersize;
+
 	/* I: page offset of start position of decompression */
 	unsigned short pageofs_out;
 
@@ -70,14 +73,6 @@ struct z_erofs_pcluster {
 		struct rcu_head rcu;
 	};
 
-	union {
-		/* I: physical cluster size in pages */
-		unsigned short pclusterpages;
-
-		/* I: tailpacking inline compressed size */
-		unsigned short tailpacking_size;
-	};
-
 	/* I: compression algorithm format */
 	unsigned char algorithmformat;
 
@@ -115,9 +110,7 @@ static inline bool z_erofs_is_inline_pcluster(struct z_erofs_pcluster *pcl)
 
 static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
 {
-	if (z_erofs_is_inline_pcluster(pcl))
-		return 1;
-	return pcl->pclusterpages;
+	return PAGE_ALIGN(pcl->pclustersize) >> PAGE_SHIFT;
 }
 
 /*
@@ -298,12 +291,12 @@ static int z_erofs_create_pcluster_pool(void)
 	return 0;
 }
 
-static struct z_erofs_pcluster *z_erofs_alloc_pcluster(unsigned int nrpages)
+static struct z_erofs_pcluster *z_erofs_alloc_pcluster(unsigned int size)
 {
-	int i;
+	unsigned int nrpages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	struct z_erofs_pcluster_slab *pcs = pcluster_pool;
 
-	for (i = 0; i < ARRAY_SIZE(pcluster_pool); ++i) {
-		struct z_erofs_pcluster_slab *pcs = pcluster_pool + i;
+	for (; pcs < pcluster_pool + ARRAY_SIZE(pcluster_pool); ++pcs) {
 		struct z_erofs_pcluster *pcl;
 
 		if (nrpages > pcs->maxpages)
@@ -312,7 +305,7 @@ static struct z_erofs_pcluster *z_erofs_alloc_pcluster(unsigned int nrpages)
 		pcl = kmem_cache_zalloc(pcs->slab, GFP_NOFS);
 		if (!pcl)
 			return ERR_PTR(-ENOMEM);
-		pcl->pclusterpages = nrpages;
+		pcl->pclustersize = size;
 		return pcl;
 	}
 	return ERR_PTR(-EINVAL);
@@ -559,6 +552,7 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 {
 	struct address_space *mc = MNGD_MAPPING(EROFS_I_SB(fe->inode));
 	struct z_erofs_pcluster *pcl = fe->pcl;
+	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	bool shouldalloc = z_erofs_should_alloc_cache(fe);
 	bool standalone = true;
 	/*
@@ -572,10 +566,9 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED)
 		return;
 
-	for (i = 0; i < pcl->pclusterpages; ++i) {
-		struct page *page;
+	for (i = 0; i < pclusterpages; ++i) {
+		struct page *page, *newpage;
 		void *t;	/* mark pages just found for debugging */
-		struct page *newpage = NULL;
 
 		/* the compressed page was loaded before */
 		if (READ_ONCE(pcl->compressed_bvecs[i].page))
@@ -585,6 +578,7 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 
 		if (page) {
 			t = (void *)((unsigned long)page | 1);
+			newpage = NULL;
 		} else {
 			/* I/O is needed, no possible to decompress directly */
 			standalone = false;
@@ -592,9 +586,8 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 				continue;
 
 			/*
-			 * try to use cached I/O if page allocation
-			 * succeeds or fallback to in-place I/O instead
-			 * to avoid any direct reclaim.
+			 * Try cached I/O if allocation succeeds or fallback to
+			 * in-place I/O instead to avoid any direct reclaim.
 			 */
 			newpage = erofs_allocpage(&fe->pagepool, gfp);
 			if (!newpage)
@@ -626,6 +619,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 {
 	struct z_erofs_pcluster *const pcl =
 		container_of(grp, struct z_erofs_pcluster, obj);
+	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	int i;
 
 	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
@@ -633,7 +627,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 	 * refcount of workgroup is now freezed as 0,
 	 * therefore no need to worry about available decompression users.
 	 */
-	for (i = 0; i < pcl->pclusterpages; ++i) {
+	for (i = 0; i < pclusterpages; ++i) {
 		struct page *page = pcl->compressed_bvecs[i].page;
 
 		if (!page)
@@ -657,6 +651,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 static bool z_erofs_cache_release_folio(struct folio *folio, gfp_t gfp)
 {
 	struct z_erofs_pcluster *pcl = folio_get_private(folio);
+	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	bool ret;
 	int i;
 
@@ -669,7 +664,7 @@ static bool z_erofs_cache_release_folio(struct folio *folio, gfp_t gfp)
 		goto out;
 
 	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
-	for (i = 0; i < pcl->pclusterpages; ++i) {
+	for (i = 0; i < pclusterpages; ++i) {
 		if (pcl->compressed_bvecs[i].page == &folio->page) {
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
 			ret = true;
@@ -778,20 +773,20 @@ static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
 static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
+	struct super_block *sb = fe->inode->i_sb;
 	bool ztailpacking = map->m_flags & EROFS_MAP_META;
 	struct z_erofs_pcluster *pcl;
 	struct erofs_workgroup *grp;
 	int err;
 
 	if (!(map->m_flags & EROFS_MAP_ENCODED) ||
-	    (!ztailpacking && !(map->m_pa >> PAGE_SHIFT))) {
+	    (!ztailpacking && !erofs_blknr(sb, map->m_pa))) {
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
 
 	/* no available pcluster, let's allocate one */
-	pcl = z_erofs_alloc_pcluster(ztailpacking ? 1 :
-				     map->m_plen >> PAGE_SHIFT);
+	pcl = z_erofs_alloc_pcluster(map->m_plen);
 	if (IS_ERR(pcl))
 		return PTR_ERR(pcl);
 
@@ -816,9 +811,8 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	if (ztailpacking) {
 		pcl->obj.index = 0;	/* which indicates ztailpacking */
 		pcl->pageofs_in = erofs_blkoff(fe->inode->i_sb, map->m_pa);
-		pcl->tailpacking_size = map->m_plen;
 	} else {
-		pcl->obj.index = map->m_pa >> PAGE_SHIFT;
+		pcl->obj.index = erofs_blknr(sb, map->m_pa);
 
 		grp = erofs_insert_workgroup(fe->inode->i_sb, &pcl->obj);
 		if (IS_ERR(grp)) {
@@ -1244,8 +1238,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	const struct z_erofs_decompressor *decompressor =
 				&erofs_decompressors[pcl->algorithmformat];
-	unsigned int i, inputsize;
-	int err2;
+	int i, err2;
 	struct page *page;
 	bool overlapped;
 
@@ -1282,18 +1275,13 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	if (err)
 		goto out;
 
-	if (z_erofs_is_inline_pcluster(pcl))
-		inputsize = pcl->tailpacking_size;
-	else
-		inputsize = pclusterpages * PAGE_SIZE;
-
 	err = decompressor->decompress(&(struct z_erofs_decompress_req) {
 					.sb = be->sb,
 					.in = be->compressed_pages,
 					.out = be->decompressed_pages,
 					.pageofs_in = pcl->pageofs_in,
 					.pageofs_out = pcl->pageofs_out,
-					.inputsize = inputsize,
+					.inputsize = pcl->pclustersize,
 					.outputsize = pcl->length,
 					.alg = pcl->algorithmformat,
 					.inplace_io = overlapped,
@@ -1668,7 +1656,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 		(void)erofs_map_dev(sb, &mdev);
 
 		cur = mdev.m_pa;
-		end = cur + pcl->pclusterpages << PAGE_SHIFT;
+		end = cur + pcl->pclustersize;
 		do {
 			z_erofs_fill_bio_vec(&bvec, f, pcl, i++, mc);
 			if (!bvec.bv_page)
-- 
2.39.3

