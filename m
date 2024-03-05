Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFCF871952
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Mar 2024 10:15:43 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VNIEPCTK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tpqfj1FXbz3dVK
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Mar 2024 20:15:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VNIEPCTK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tpqf05wdYz2xPZ
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Mar 2024 20:15:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709630100; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Vme30tGzoG9Q13+YlWKekwuRS+55dVw55EvFDe7Rrgg=;
	b=VNIEPCTK5qCEHAlZVCfGL/AebXwWHFsP13ZGsj2NGJEsiHFVw0PbLNFlmmuM7GTx+Aa1ENqJgaYj/R+6c4lb0BglaLALKyhaq7KqgrgkCqAUuuVh6/bYRabNF69+kf+21oq7lJjm2PMncC9p1hR3mYi0oQPSGdWjSKGP3OEA0xk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W1tgGhY_1709630098;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1tgGhY_1709630098)
          by smtp.aliyun-inc.com;
          Tue, 05 Mar 2024 17:14:59 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 6/6] erofs: refine managed cache operations to folios
Date: Tue,  5 Mar 2024 17:14:48 +0800
Message-Id: <20240305091448.1384242-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240305091448.1384242-1-hsiangkao@linux.alibaba.com>
References: <20240305091448.1384242-1-hsiangkao@linux.alibaba.com>
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

Convert erofs_try_to_free_all_cached_pages() and
z_erofs_cache_release_folio().

Besides, erofs_page_is_managed() is moved to zdata.c and renamed
as erofs_folio_is_managed().

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/compress.h             |  7 ----
 fs/erofs/decompressor_deflate.c |  3 --
 fs/erofs/decompressor_lzma.c    |  3 --
 fs/erofs/internal.h             |  4 +--
 fs/erofs/utils.c                |  2 +-
 fs/erofs/zdata.c                | 63 ++++++++++++++++-----------------
 6 files changed, 34 insertions(+), 48 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 7cc5841577b2..333587ba6183 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -81,13 +81,6 @@ static inline bool z_erofs_put_shortlivedpage(struct page **pagepool,
 	return true;
 }
 
-#define MNGD_MAPPING(sbi)	((sbi)->managed_cache->i_mapping)
-static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
-					 struct page *page)
-{
-	return page->mapping == MNGD_MAPPING(sbi);
-}
-
 int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
 			 unsigned int padbufsize);
 extern const struct z_erofs_decompressor erofs_decompressors[];
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index b98872058abe..81e65c453ef0 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -212,9 +212,6 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 
 			if (rq->out[no] != rq->in[j])
 				continue;
-
-			DBG_BUGON(erofs_page_is_managed(EROFS_SB(sb),
-							rq->in[j]));
 			tmppage = erofs_allocpage(pgpl, rq->gfp);
 			if (!tmppage) {
 				err = -ENOMEM;
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 6ca357d83cfa..4b28dc130c9f 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -258,9 +258,6 @@ int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 
 			if (rq->out[no] != rq->in[j])
 				continue;
-
-			DBG_BUGON(erofs_page_is_managed(EROFS_SB(rq->sb),
-							rq->in[j]));
 			tmppage = erofs_allocpage(pgpl, rq->gfp);
 			if (!tmppage) {
 				err = -ENOMEM;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b0409badb017..65db0250f146 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -467,8 +467,8 @@ int __init erofs_init_shrinker(void);
 void erofs_exit_shrinker(void);
 int __init z_erofs_init_zip_subsystem(void);
 void z_erofs_exit_zip_subsystem(void);
-int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
-				       struct erofs_workgroup *egrp);
+int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
+					struct erofs_workgroup *egrp);
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags);
 void *erofs_get_pcpubuf(unsigned int requiredpages);
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index e146d09151af..518bdd69c823 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -129,7 +129,7 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 	 * the XArray. Otherwise some cached pages could be still attached to
 	 * the orphan old workgroup when the new one is available in the tree.
 	 */
-	if (erofs_try_to_free_all_cached_pages(sbi, grp))
+	if (erofs_try_to_free_all_cached_folios(sbi, grp))
 		goto out;
 
 	/*
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 63990c8192f2..c1bd4d8392eb 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -119,6 +119,12 @@ static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
 	return PAGE_ALIGN(pcl->pclustersize) >> PAGE_SHIFT;
 }
 
+#define MNGD_MAPPING(sbi)	((sbi)->managed_cache->i_mapping)
+static bool erofs_folio_is_managed(struct erofs_sb_info *sbi, struct folio *fo)
+{
+	return fo->mapping == MNGD_MAPPING(sbi);
+}
+
 /*
  * bit 30: I/O error occurred on this folio
  * bit 0 - 29: remaining parts to complete this folio
@@ -611,9 +617,9 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 }
 
-/* called by erofs_shrinker to get rid of all compressed_pages */
-int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
-				       struct erofs_workgroup *grp)
+/* called by erofs_shrinker to get rid of all cached compressed bvecs */
+int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
+					struct erofs_workgroup *grp)
 {
 	struct z_erofs_pcluster *const pcl =
 		container_of(grp, struct z_erofs_pcluster, obj);
@@ -621,27 +627,22 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 	int i;
 
 	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
-	/*
-	 * refcount of workgroup is now freezed as 0,
-	 * therefore no need to worry about available decompression users.
-	 */
+	/* There is no actice user since the pcluster is now freezed */
 	for (i = 0; i < pclusterpages; ++i) {
-		struct page *page = pcl->compressed_bvecs[i].page;
+		struct folio *folio = pcl->compressed_bvecs[i].folio;
 
-		if (!page)
+		if (!folio)
 			continue;
 
-		/* block other users from reclaiming or migrating the page */
-		if (!trylock_page(page))
+		/* Avoid reclaiming or migrating this folio */
+		if (!folio_trylock(folio))
 			return -EBUSY;
 
-		if (!erofs_page_is_managed(sbi, page))
+		if (!erofs_folio_is_managed(sbi, folio))
 			continue;
-
-		/* barrier is implied in the following 'unlock_page' */
-		WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
-		detach_page_private(page);
-		unlock_page(page);
+		pcl->compressed_bvecs[i].folio = NULL;
+		folio_detach_private(folio);
+		folio_unlock(folio);
 	}
 	return 0;
 }
@@ -658,20 +659,17 @@ static bool z_erofs_cache_release_folio(struct folio *folio, gfp_t gfp)
 
 	ret = false;
 	spin_lock(&pcl->obj.lockref.lock);
-	if (pcl->obj.lockref.count > 0)
-		goto out;
-
-	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
-	for (i = 0; i < pclusterpages; ++i) {
-		if (pcl->compressed_bvecs[i].page == &folio->page) {
-			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
-			ret = true;
-			break;
+	if (pcl->obj.lockref.count <= 0) {
+		DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
+		for (i = 0; i < pclusterpages; ++i) {
+			if (pcl->compressed_bvecs[i].folio == folio) {
+				pcl->compressed_bvecs[i].folio = NULL;
+				folio_detach_private(folio);
+				ret = true;
+				break;
+			}
 		}
 	}
-	if (ret)
-		folio_detach_private(folio);
-out:
 	spin_unlock(&pcl->obj.lockref.lock);
 	return ret;
 }
@@ -1201,7 +1199,7 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 		be->compressed_pages[i] = page;
 
 		if (z_erofs_is_inline_pcluster(pcl) ||
-		    erofs_page_is_managed(EROFS_SB(be->sb), page)) {
+		    erofs_folio_is_managed(EROFS_SB(be->sb), page_folio(page))) {
 			if (!PageUptodate(page))
 				err = -EIO;
 			continue;
@@ -1286,7 +1284,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 			/* consider shortlived pages added when decompressing */
 			page = be->compressed_pages[i];
 
-			if (!page || erofs_page_is_managed(sbi, page))
+			if (!page ||
+			    erofs_folio_is_managed(sbi, page_folio(page)))
 				continue;
 			(void)z_erofs_put_shortlivedpage(be->pagepool, page);
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
@@ -1573,7 +1572,7 @@ static void z_erofs_submissionqueue_endio(struct bio *bio)
 
 		DBG_BUGON(folio_test_uptodate(folio));
 		DBG_BUGON(z_erofs_page_is_invalidated(&folio->page));
-		if (!erofs_page_is_managed(EROFS_SB(q->sb), &folio->page))
+		if (!erofs_folio_is_managed(EROFS_SB(q->sb), folio))
 			continue;
 
 		if (!err)
-- 
2.39.3

