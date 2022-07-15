Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3697B576497
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 17:42:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lkwbf0Wr1z3cDh
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Jul 2022 01:42:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LkwbS4BjKz3c5D
	for <linux-erofs@lists.ozlabs.org>; Sat, 16 Jul 2022 01:42:27 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJPnC51_1657899739;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJPnC51_1657899739)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 23:42:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 07/16] erofs: switch compressed_pages[] to bufvec
Date: Fri, 15 Jul 2022 23:41:54 +0800
Message-Id: <20220715154203.48093-8-hsiangkao@linux.alibaba.com>
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

Convert compressed_pages[] to bufvec in order to avoid using
page->private to keep onlinepage_index (decompressed offset)
for inplace I/O pages.

In the future, we only rely on folio->private to keep a countdown
to unlock folios and set folio_uptodate.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 113 +++++++++++++++++++++++------------------------
 fs/erofs/zdata.h |   4 +-
 2 files changed, 57 insertions(+), 60 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 423d4daf7ed9..2ea8c97be5b6 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -134,7 +134,7 @@ static int z_erofs_create_pcluster_pool(void)
 
 	for (pcs = pcluster_pool;
 	     pcs < pcluster_pool + ARRAY_SIZE(pcluster_pool); ++pcs) {
-		size = struct_size(a, compressed_pages, pcs->maxpages);
+		size = struct_size(a, compressed_bvecs, pcs->maxpages);
 
 		sprintf(pcs->name, "erofs_pcluster-%u", pcs->maxpages);
 		pcs->slab = kmem_cache_create(pcs->name, size, 0,
@@ -287,16 +287,16 @@ struct z_erofs_decompress_frontend {
 
 	struct page *candidate_bvpage;
 	struct z_erofs_pcluster *pcl, *tailpcl;
-	/* a pointer used to pick up inplace I/O pages */
-	struct page **icpage_ptr;
 	z_erofs_next_pcluster_t owned_head;
-
 	enum z_erofs_collectmode mode;
 
 	bool readahead;
 	/* used for applying cache strategy on the fly */
 	bool backmost;
 	erofs_off_t headoffset;
+
+	/* a pointer used to pick up inplace I/O pages */
+	unsigned int icur;
 };
 
 #define DECOMPRESS_FRONTEND_INIT(__i) { \
@@ -319,24 +319,21 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 	 */
 	gfp_t gfp = (mapping_gfp_mask(mc) & ~__GFP_DIRECT_RECLAIM) |
 			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
-	struct page **pages;
-	pgoff_t index;
+	unsigned int i;
 
 	if (fe->mode < COLLECT_PRIMARY_FOLLOWED)
 		return;
 
-	pages = pcl->compressed_pages;
-	index = pcl->obj.index;
-	for (; index < pcl->obj.index + pcl->pclusterpages; ++index, ++pages) {
+	for (i = 0; i < pcl->pclusterpages; ++i) {
 		struct page *page;
 		compressed_page_t t;
 		struct page *newpage = NULL;
 
 		/* the compressed page was loaded before */
-		if (READ_ONCE(*pages))
+		if (READ_ONCE(pcl->compressed_bvecs[i].page))
 			continue;
 
-		page = find_get_page(mc, index);
+		page = find_get_page(mc, pcl->obj.index + i);
 
 		if (page) {
 			t = tag_compressed_page_justfound(page);
@@ -357,7 +354,8 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 			}
 		}
 
-		if (!cmpxchg_relaxed(pages, NULL, tagptr_cast_ptr(t)))
+		if (!cmpxchg_relaxed(&pcl->compressed_bvecs[i].page, NULL,
+				     tagptr_cast_ptr(t)))
 			continue;
 
 		if (page)
@@ -388,7 +386,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 	 * therefore no need to worry about available decompression users.
 	 */
 	for (i = 0; i < pcl->pclusterpages; ++i) {
-		struct page *page = pcl->compressed_pages[i];
+		struct page *page = pcl->compressed_bvecs[i].page;
 
 		if (!page)
 			continue;
@@ -401,7 +399,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 			continue;
 
 		/* barrier is implied in the following 'unlock_page' */
-		WRITE_ONCE(pcl->compressed_pages[i], NULL);
+		WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
 		detach_page_private(page);
 		unlock_page(page);
 	}
@@ -411,36 +409,39 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 int erofs_try_to_free_cached_page(struct page *page)
 {
 	struct z_erofs_pcluster *const pcl = (void *)page_private(page);
-	int ret = 0;	/* 0 - busy */
+	int ret, i;
 
-	if (erofs_workgroup_try_to_freeze(&pcl->obj, 1)) {
-		unsigned int i;
+	if (!erofs_workgroup_try_to_freeze(&pcl->obj, 1))
+		return 0;
 
-		DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
-		for (i = 0; i < pcl->pclusterpages; ++i) {
-			if (pcl->compressed_pages[i] == page) {
-				WRITE_ONCE(pcl->compressed_pages[i], NULL);
-				ret = 1;
-				break;
-			}
+	ret = 0;
+	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
+	for (i = 0; i < pcl->pclusterpages; ++i) {
+		if (pcl->compressed_bvecs[i].page == page) {
+			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
+			ret = 1;
+			break;
 		}
-		erofs_workgroup_unfreeze(&pcl->obj, 1);
-
-		if (ret)
-			detach_page_private(page);
 	}
+	erofs_workgroup_unfreeze(&pcl->obj, 1);
+	if (ret)
+		detach_page_private(page);
 	return ret;
 }
 
 /* page_type must be Z_EROFS_PAGE_TYPE_EXCLUSIVE */
 static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
-				   struct page *page)
+				   struct z_erofs_bvec *bvec)
 {
 	struct z_erofs_pcluster *const pcl = fe->pcl;
 
-	while (fe->icpage_ptr > pcl->compressed_pages)
-		if (!cmpxchg(--fe->icpage_ptr, NULL, page))
+	while (fe->icur > 0) {
+		if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
+			     NULL, bvec->page)) {
+			pcl->compressed_bvecs[fe->icur] = *bvec;
 			return true;
+		}
+	}
 	return false;
 }
 
@@ -454,7 +455,7 @@ static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
 	if (fe->mode >= COLLECT_PRIMARY &&
 	    type == Z_EROFS_PAGE_TYPE_EXCLUSIVE) {
 		/* give priority for inplaceio to use file pages first */
-		if (z_erofs_try_inplace_io(fe, bvec->page))
+		if (z_erofs_try_inplace_io(fe, bvec))
 			return 0;
 		/* otherwise, check if it can be used as a bvpage */
 		if (fe->mode >= COLLECT_PRIMARY_FOLLOWED &&
@@ -648,8 +649,7 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
 	z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
 				Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
 	/* since file-backed online pages are traversed in reverse order */
-	fe->icpage_ptr = fe->pcl->compressed_pages +
-			z_erofs_pclusterpages(fe->pcl);
+	fe->icur = z_erofs_pclusterpages(fe->pcl);
 	return 0;
 }
 
@@ -769,7 +769,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 			goto err_out;
 		}
 		get_page(fe->map.buf.page);
-		WRITE_ONCE(fe->pcl->compressed_pages[0], fe->map.buf.page);
+		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page,
+			   fe->map.buf.page);
 		fe->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
 	} else {
 		/* bind cache first when cached decompression is preferred */
@@ -927,8 +928,9 @@ static struct page **z_erofs_parse_in_bvecs(struct erofs_sb_info *sbi,
 	*overlapped = false;
 
 	for (i = 0; i < pclusterpages; ++i) {
-		unsigned int pagenr;
-		struct page *page = pcl->compressed_pages[i];
+		struct z_erofs_bvec *bvec = &pcl->compressed_bvecs[i];
+		struct page *page = bvec->page;
+		unsigned int pgnr;
 
 		/* compressed pages ought to be present before decompressing */
 		if (!page) {
@@ -951,21 +953,15 @@ static struct page **z_erofs_parse_in_bvecs(struct erofs_sb_info *sbi,
 				continue;
 			}
 
-			/*
-			 * only if non-head page can be selected
-			 * for inplace decompression
-			 */
-			pagenr = z_erofs_onlinepage_index(page);
-
-			DBG_BUGON(pagenr >= pcl->nr_pages);
-			if (pages[pagenr]) {
+			pgnr = (bvec->offset + pcl->pageofs_out) >> PAGE_SHIFT;
+			DBG_BUGON(pgnr >= pcl->nr_pages);
+			if (pages[pgnr]) {
 				DBG_BUGON(1);
-				SetPageError(pages[pagenr]);
-				z_erofs_onlinepage_endio(pages[pagenr]);
+				SetPageError(pages[pgnr]);
+				z_erofs_onlinepage_endio(pages[pgnr]);
 				err = -EFSCORRUPTED;
 			}
-			pages[pagenr] = page;
-
+			pages[pgnr] = page;
 			*overlapped = true;
 		}
 
@@ -1067,19 +1063,19 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 out:
 	/* must handle all compressed pages before actual file pages */
 	if (z_erofs_is_inline_pcluster(pcl)) {
-		page = pcl->compressed_pages[0];
-		WRITE_ONCE(pcl->compressed_pages[0], NULL);
+		page = pcl->compressed_bvecs[0].page;
+		WRITE_ONCE(pcl->compressed_bvecs[0].page, NULL);
 		put_page(page);
 	} else {
 		for (i = 0; i < pclusterpages; ++i) {
-			page = pcl->compressed_pages[i];
+			page = pcl->compressed_bvecs[i].page;
 
 			if (erofs_page_is_managed(sbi, page))
 				continue;
 
 			/* recycle all individual short-lived pages */
 			(void)z_erofs_put_shortlivedpage(pagepool, page);
-			WRITE_ONCE(pcl->compressed_pages[i], NULL);
+			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
 		}
 	}
 	kfree(compressed_pages);
@@ -1193,7 +1189,7 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	int justfound;
 
 repeat:
-	page = READ_ONCE(pcl->compressed_pages[nr]);
+	page = READ_ONCE(pcl->compressed_bvecs[nr].page);
 	oldpage = page;
 
 	if (!page)
@@ -1209,7 +1205,7 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	 * otherwise, it will go inplace I/O path instead.
 	 */
 	if (page->private == Z_EROFS_PREALLOCATED_PAGE) {
-		WRITE_ONCE(pcl->compressed_pages[nr], page);
+		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
 		set_page_private(page, 0);
 		tocache = true;
 		goto out_tocache;
@@ -1235,14 +1231,14 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 
 	/* the page is still in manage cache */
 	if (page->mapping == mc) {
-		WRITE_ONCE(pcl->compressed_pages[nr], page);
+		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
 
 		ClearPageError(page);
 		if (!PagePrivate(page)) {
 			/*
 			 * impossible to be !PagePrivate(page) for
 			 * the current restriction as well if
-			 * the page is already in compressed_pages[].
+			 * the page is already in compressed_bvecs[].
 			 */
 			DBG_BUGON(!justfound);
 
@@ -1271,7 +1267,8 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	put_page(page);
 out_allocpage:
 	page = erofs_allocpage(pagepool, gfp | __GFP_NOFAIL);
-	if (oldpage != cmpxchg(&pcl->compressed_pages[nr], oldpage, page)) {
+	if (oldpage != cmpxchg(&pcl->compressed_bvecs[nr].page,
+			       oldpage, page)) {
 		erofs_pagepool_add(pagepool, page);
 		cond_resched();
 		goto repeat;
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 468f6308fc90..5d236c8b40c5 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -87,8 +87,8 @@ struct z_erofs_pcluster {
 	/* I: compression algorithm format */
 	unsigned char algorithmformat;
 
-	/* A: compressed pages (can be cached or inplaced pages) */
-	struct page *compressed_pages[];
+	/* A: compressed bvecs (can be cached or inplaced pages) */
+	struct z_erofs_bvec compressed_bvecs[];
 };
 
 /* let's avoid the valid 32-bit kernel addresses */
-- 
2.24.4

