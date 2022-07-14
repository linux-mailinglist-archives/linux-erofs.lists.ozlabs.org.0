Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C979F574EE7
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Jul 2022 15:21:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LkFW95cPnz3c7b
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Jul 2022 23:21:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.12; helo=out199-12.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LkFW42J2xz3bcv
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Jul 2022 23:21:19 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJJkPKY_1657804869;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJJkPKY_1657804869)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 21:21:10 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 08/16] erofs: rework online page handling
Date: Thu, 14 Jul 2022 21:20:43 +0800
Message-Id: <20220714132051.46012-9-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
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

Since all decompressed offsets have been integrated to bvecs[], this
patch avoids all sub-indexes so that page->private only includes a
part count and an eio flag, thus in the future folio->private can have
the same meaning.

In addition, PG_error will not be used anymore after this patch and
we're heading to use page->private (later folio->private) and
page->mapping  (later folio->mapping) only.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 51 ++++++++++++++----------------------
 fs/erofs/zdata.h | 68 ++++++++++++++----------------------------------
 2 files changed, 38 insertions(+), 81 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index f2e3f07baad7..9065e160d6a6 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -743,7 +743,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		map->m_llen = 0;
 		err = z_erofs_map_blocks_iter(inode, map, 0);
 		if (err)
-			goto err_out;
+			goto out;
 	} else {
 		if (fe->pcl)
 			goto hitted;
@@ -755,7 +755,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 
 	err = z_erofs_collector_begin(fe);
 	if (err)
-		goto err_out;
+		goto out;
 
 	if (z_erofs_is_inline_pcluster(fe->pcl)) {
 		void *mp;
@@ -766,7 +766,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 			err = PTR_ERR(mp);
 			erofs_err(inode->i_sb,
 				  "failed to get inline page, err %d", err);
-			goto err_out;
+			goto out;
 		}
 		get_page(fe->map.buf.page);
 		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page,
@@ -823,16 +823,15 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 
 	if (err) {
 		DBG_BUGON(err == -EAGAIN && fe->candidate_bvpage);
-		goto err_out;
+		goto out;
 	}
 
-	index = page->index - (map->m_la >> PAGE_SHIFT);
-
-	z_erofs_onlinepage_fixup(page, index, true);
-
+	z_erofs_onlinepage_split(page);
 	/* bump up the number of spiltted parts of a page */
 	++spiltted;
+
 	/* also update nr_pages */
+	index = page->index - (map->m_la >> PAGE_SHIFT);
 	fe->pcl->nr_pages = max_t(pgoff_t, fe->pcl->nr_pages, index + 1);
 next_part:
 	/* can be used for verification */
@@ -843,16 +842,13 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto repeat;
 
 out:
+	if (err)
+		z_erofs_page_mark_eio(page);
 	z_erofs_onlinepage_endio(page);
 
 	erofs_dbg("%s, finish page: %pK spiltted: %u map->m_llen %llu",
 		  __func__, page, spiltted, map->m_llen);
 	return err;
-
-	/* if some error occurred while processing this page */
-err_out:
-	SetPageError(page);
-	goto out;
 }
 
 static bool z_erofs_get_sync_decompress_policy(struct erofs_sb_info *sbi,
@@ -901,7 +897,7 @@ static int z_erofs_parse_out_bvecs(struct z_erofs_pcluster *pcl,
 		 */
 		if (pages[pagenr]) {
 			DBG_BUGON(1);
-			SetPageError(pages[pagenr]);
+			z_erofs_page_mark_eio(pages[pagenr]);
 			z_erofs_onlinepage_endio(pages[pagenr]);
 			err = -EFSCORRUPTED;
 		}
@@ -957,19 +953,13 @@ static struct page **z_erofs_parse_in_bvecs(struct erofs_sb_info *sbi,
 			DBG_BUGON(pgnr >= pcl->nr_pages);
 			if (pages[pgnr]) {
 				DBG_BUGON(1);
-				SetPageError(pages[pgnr]);
+				z_erofs_page_mark_eio(pages[pgnr]);
 				z_erofs_onlinepage_endio(pages[pgnr]);
 				err = -EFSCORRUPTED;
 			}
 			pages[pgnr] = page;
 			*overlapped = true;
 		}
-
-		/* PG_error needs checking for all non-managed pages */
-		if (PageError(page)) {
-			DBG_BUGON(PageUptodate(page));
-			err = -EIO;
-		}
 	}
 
 	if (err) {
@@ -981,7 +971,7 @@ static struct page **z_erofs_parse_in_bvecs(struct erofs_sb_info *sbi,
 
 static int z_erofs_decompress_pcluster(struct super_block *sb,
 				       struct z_erofs_pcluster *pcl,
-				       struct page **pagepool)
+				       struct page **pagepool, int err)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
@@ -990,7 +980,6 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 	struct page **pages, **compressed_pages, *page;
 
 	bool overlapped, partial;
-	int err;
 
 	might_sleep();
 	DBG_BUGON(!READ_ONCE(pcl->nr_pages));
@@ -1090,10 +1079,8 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		/* recycle all individual short-lived pages */
 		if (z_erofs_put_shortlivedpage(pagepool, page))
 			continue;
-
-		if (err < 0)
-			SetPageError(page);
-
+		if (err)
+			z_erofs_page_mark_eio(page);
 		z_erofs_onlinepage_endio(page);
 	}
 
@@ -1129,7 +1116,8 @@ static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		pcl = container_of(owned, struct z_erofs_pcluster, next);
 		owned = READ_ONCE(pcl->next);
 
-		z_erofs_decompress_pcluster(io->sb, pcl, pagepool);
+		z_erofs_decompress_pcluster(io->sb, pcl, pagepool,
+					    io->eio ? -EIO : 0);
 		erofs_workgroup_put(&pcl->obj);
 	}
 }
@@ -1233,7 +1221,6 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	if (page->mapping == mc) {
 		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
 
-		ClearPageError(page);
 		if (!PagePrivate(page)) {
 			/*
 			 * impossible to be !PagePrivate(page) for
@@ -1305,6 +1292,7 @@ jobqueue_init(struct super_block *sb,
 		q = fgq;
 		init_completion(&fgq->u.done);
 		atomic_set(&fgq->pending_bios, 0);
+		q->eio = true;
 	}
 	q->sb = sb;
 	q->head = Z_EROFS_PCLUSTER_TAIL_CLOSED;
@@ -1365,15 +1353,14 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
 		DBG_BUGON(PageUptodate(page));
 		DBG_BUGON(z_erofs_page_is_invalidated(page));
 
-		if (err)
-			SetPageError(page);
-
 		if (erofs_page_is_managed(EROFS_SB(q->sb), page)) {
 			if (!err)
 				SetPageUptodate(page);
 			unlock_page(page);
 		}
 	}
+	if (err)
+		q->eio = true;
 	z_erofs_decompress_kickoff(q, tagptr_unfold_tags(t), -1);
 	bio_put(bio);
 }
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index a70f1b73e901..852da31e2e91 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -109,6 +109,8 @@ struct z_erofs_decompressqueue {
 		struct completion done;
 		struct work_struct work;
 	} u;
+
+	bool eio;
 };
 
 static inline bool z_erofs_is_inline_pcluster(struct z_erofs_pcluster *pcl)
@@ -123,38 +125,17 @@ static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
 	return pcl->pclusterpages;
 }
 
-#define Z_EROFS_ONLINEPAGE_COUNT_BITS   2
-#define Z_EROFS_ONLINEPAGE_COUNT_MASK   ((1 << Z_EROFS_ONLINEPAGE_COUNT_BITS) - 1)
-#define Z_EROFS_ONLINEPAGE_INDEX_SHIFT  (Z_EROFS_ONLINEPAGE_COUNT_BITS)
-
 /*
- * waiters (aka. ongoing_packs): # to unlock the page
- * sub-index: 0 - for partial page, >= 1 full page sub-index
+ * bit 31: I/O error occurred on this page
+ * bit 0 - 30: remaining parts to complete this page
  */
-typedef atomic_t z_erofs_onlinepage_t;
-
-/* type punning */
-union z_erofs_onlinepage_converter {
-	z_erofs_onlinepage_t *o;
-	unsigned long *v;
-};
-
-static inline unsigned int z_erofs_onlinepage_index(struct page *page)
-{
-	union z_erofs_onlinepage_converter u;
-
-	DBG_BUGON(!PagePrivate(page));
-	u.v = &page_private(page);
-
-	return atomic_read(u.o) >> Z_EROFS_ONLINEPAGE_INDEX_SHIFT;
-}
+#define Z_EROFS_PAGE_EIO			(1 << 31)
 
 static inline void z_erofs_onlinepage_init(struct page *page)
 {
 	union {
-		z_erofs_onlinepage_t o;
+		atomic_t o;
 		unsigned long v;
-	/* keep from being unlocked in advance */
 	} u = { .o = ATOMIC_INIT(1) };
 
 	set_page_private(page, u.v);
@@ -162,45 +143,34 @@ static inline void z_erofs_onlinepage_init(struct page *page)
 	SetPagePrivate(page);
 }
 
-static inline void z_erofs_onlinepage_fixup(struct page *page,
-	uintptr_t index, bool down)
+static inline void z_erofs_onlinepage_split(struct page *page)
 {
-	union z_erofs_onlinepage_converter u = { .v = &page_private(page) };
-	int orig, orig_index, val;
-
-repeat:
-	orig = atomic_read(u.o);
-	orig_index = orig >> Z_EROFS_ONLINEPAGE_INDEX_SHIFT;
-	if (orig_index) {
-		if (!index)
-			return;
+	atomic_inc((atomic_t *)&page->private);
+}
 
-		DBG_BUGON(orig_index != index);
-	}
+static inline void z_erofs_page_mark_eio(struct page *page)
+{
+	int orig;
 
-	val = (index << Z_EROFS_ONLINEPAGE_INDEX_SHIFT) |
-		((orig & Z_EROFS_ONLINEPAGE_COUNT_MASK) + (unsigned int)down);
-	if (atomic_cmpxchg(u.o, orig, val) != orig)
-		goto repeat;
+	do {
+		orig = atomic_read((atomic_t *)&page->private);
+	} while (atomic_cmpxchg((atomic_t *)&page->private, orig,
+				orig | Z_EROFS_PAGE_EIO) != orig);
 }
 
 static inline void z_erofs_onlinepage_endio(struct page *page)
 {
-	union z_erofs_onlinepage_converter u;
 	unsigned int v;
 
 	DBG_BUGON(!PagePrivate(page));
-	u.v = &page_private(page);
-
-	v = atomic_dec_return(u.o);
-	if (!(v & Z_EROFS_ONLINEPAGE_COUNT_MASK)) {
+	v = atomic_dec_return((atomic_t *)&page->private);
+	if (!(v & ~Z_EROFS_PAGE_EIO)) {
 		set_page_private(page, 0);
 		ClearPagePrivate(page);
-		if (!PageError(page))
+		if (!(v & Z_EROFS_PAGE_EIO))
 			SetPageUptodate(page);
 		unlock_page(page);
 	}
-	erofs_dbg("%s, page %p value %x", __func__, page, atomic_read(u.o));
 }
 
 #define Z_EROFS_VMAP_ONSTACK_PAGES	\
-- 
2.24.4

