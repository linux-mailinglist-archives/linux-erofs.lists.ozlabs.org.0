Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC7957649A
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 17:42:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lkwbk67zHz3cfQ
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Jul 2022 01:42:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42; helo=out30-42.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LkwbX1770z3c93
	for <linux-erofs@lists.ozlabs.org>; Sat, 16 Jul 2022 01:42:31 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJPnC3d_1657899735;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJPnC3d_1657899735)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 23:42:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 04/16] erofs: introduce bufvec to store decompressed buffers
Date: Fri, 15 Jul 2022 23:41:51 +0800
Message-Id: <20220715154203.48093-5-hsiangkao@linux.alibaba.com>
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

For each pcluster, the total compressed buffers are determined in
advance, yet the number of decompressed buffers actually vary.  Too
many decompressed pages can be recorded if one pcluster is highly
compressed or its pcluster size is large.  That takes extra memory
footprints compared to uncompressed filesystems, especially a lot of
I/O in flight on low-ended devices.

Therefore, similar to inplace I/O, pagevec was introduced to reuse
page cache to store these pointers in the time-sharing way since
these pages are actually unused before decompressing.

In order to make it more flexable, a cleaner bufvec is used to
replace the old pagevec stuffs so that

 - Decompressed offsets can be stored inline, thus it can be used
   for the upcoming feature like compressed data deduplication.
   It's calculated by `page_offset(page) - map->m_la';

 - Towards supporting large folios for compressed inodes since
   our final goal is to completely avoid page->private but use
   folio->private only for all page cache pages.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 177 +++++++++++++++++++++++++++++++++++------------
 fs/erofs/zdata.h |  26 +++++--
 2 files changed, 153 insertions(+), 50 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index c183cd0bc42b..f52c54058f31 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
  *             https://www.huawei.com/
+ * Copyright (C) 2022 Alibaba Cloud
  */
 #include "zdata.h"
 #include "compress.h"
@@ -26,6 +27,82 @@ static struct z_erofs_pcluster_slab pcluster_pool[] __read_mostly = {
 	_PCLP(Z_EROFS_PCLUSTER_MAX_PAGES)
 };
 
+struct z_erofs_bvec_iter {
+	struct page *bvpage;
+	struct z_erofs_bvset *bvset;
+	unsigned int nr, cur;
+};
+
+static struct page *z_erofs_bvec_iter_end(struct z_erofs_bvec_iter *iter)
+{
+	if (iter->bvpage)
+		kunmap_local(iter->bvset);
+	return iter->bvpage;
+}
+
+static struct page *z_erofs_bvset_flip(struct z_erofs_bvec_iter *iter)
+{
+	unsigned long base = (unsigned long)((struct z_erofs_bvset *)0)->bvec;
+	/* have to access nextpage in advance, otherwise it will be unmapped */
+	struct page *nextpage = iter->bvset->nextpage;
+	struct page *oldpage;
+
+	DBG_BUGON(!nextpage);
+	oldpage = z_erofs_bvec_iter_end(iter);
+	iter->bvpage = nextpage;
+	iter->bvset = kmap_local_page(nextpage);
+	iter->nr = (PAGE_SIZE - base) / sizeof(struct z_erofs_bvec);
+	iter->cur = 0;
+	return oldpage;
+}
+
+static void z_erofs_bvec_iter_begin(struct z_erofs_bvec_iter *iter,
+				    struct z_erofs_bvset_inline *bvset,
+				    unsigned int bootstrap_nr,
+				    unsigned int cur)
+{
+	*iter = (struct z_erofs_bvec_iter) {
+		.nr = bootstrap_nr,
+		.bvset = (struct z_erofs_bvset *)bvset,
+	};
+
+	while (cur > iter->nr) {
+		cur -= iter->nr;
+		z_erofs_bvset_flip(iter);
+	}
+	iter->cur = cur;
+}
+
+static int z_erofs_bvec_enqueue(struct z_erofs_bvec_iter *iter,
+				struct z_erofs_bvec *bvec,
+				struct page **candidate_bvpage)
+{
+	if (iter->cur == iter->nr) {
+		if (!*candidate_bvpage)
+			return -EAGAIN;
+
+		DBG_BUGON(iter->bvset->nextpage);
+		iter->bvset->nextpage = *candidate_bvpage;
+		z_erofs_bvset_flip(iter);
+
+		iter->bvset->nextpage = NULL;
+		*candidate_bvpage = NULL;
+	}
+	iter->bvset->bvec[iter->cur++] = *bvec;
+	return 0;
+}
+
+static void z_erofs_bvec_dequeue(struct z_erofs_bvec_iter *iter,
+				 struct z_erofs_bvec *bvec,
+				 struct page **old_bvpage)
+{
+	if (iter->cur == iter->nr)
+		*old_bvpage = z_erofs_bvset_flip(iter);
+	else
+		*old_bvpage = NULL;
+	*bvec = iter->bvset->bvec[iter->cur++];
+}
+
 static void z_erofs_destroy_pcluster_pool(void)
 {
 	int i;
@@ -195,9 +272,10 @@ enum z_erofs_collectmode {
 struct z_erofs_decompress_frontend {
 	struct inode *const inode;
 	struct erofs_map_blocks map;
-
+	struct z_erofs_bvec_iter biter;
 	struct z_erofs_pagevec_ctor vector;
 
+	struct page *candidate_bvpage;
 	struct z_erofs_pcluster *pcl, *tailpcl;
 	/* a pointer used to pick up inplace I/O pages */
 	struct page **icpage_ptr;
@@ -358,21 +436,24 @@ static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
 
 /* callers must be with pcluster lock held */
 static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
-			       struct page *page, enum z_erofs_page_type type,
-			       bool pvec_safereuse)
+			       struct z_erofs_bvec *bvec,
+			       enum z_erofs_page_type type)
 {
 	int ret;
 
-	/* give priority for inplaceio */
 	if (fe->mode >= COLLECT_PRIMARY &&
-	    type == Z_EROFS_PAGE_TYPE_EXCLUSIVE &&
-	    z_erofs_try_inplace_io(fe, page))
-		return 0;
-
-	ret = z_erofs_pagevec_enqueue(&fe->vector, page, type,
-				      pvec_safereuse);
-	fe->pcl->vcnt += (unsigned int)ret;
-	return ret ? 0 : -EAGAIN;
+	    type == Z_EROFS_PAGE_TYPE_EXCLUSIVE) {
+		/* give priority for inplaceio to use file pages first */
+		if (z_erofs_try_inplace_io(fe, bvec->page))
+			return 0;
+		/* otherwise, check if it can be used as a bvpage */
+		if (fe->mode >= COLLECT_PRIMARY_FOLLOWED &&
+		    !fe->candidate_bvpage)
+			fe->candidate_bvpage = bvec->page;
+	}
+	ret = z_erofs_bvec_enqueue(&fe->biter, bvec, &fe->candidate_bvpage);
+	fe->pcl->vcnt += (ret >= 0);
+	return ret;
 }
 
 static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
@@ -554,9 +635,8 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
 	} else if (ret) {
 		return ret;
 	}
-
-	z_erofs_pagevec_ctor_init(&fe->vector, Z_EROFS_NR_INLINE_PAGEVECS,
-				  fe->pcl->pagevec, fe->pcl->vcnt);
+	z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
+				Z_EROFS_NR_INLINE_PAGEVECS, fe->pcl->vcnt);
 	/* since file-backed online pages are traversed in reverse order */
 	fe->icpage_ptr = fe->pcl->compressed_pages +
 			z_erofs_pclusterpages(fe->pcl);
@@ -588,9 +668,14 @@ static bool z_erofs_collector_end(struct z_erofs_decompress_frontend *fe)
 	if (!pcl)
 		return false;
 
-	z_erofs_pagevec_ctor_exit(&fe->vector, false);
+	z_erofs_bvec_iter_end(&fe->biter);
 	mutex_unlock(&pcl->lock);
 
+	if (fe->candidate_bvpage) {
+		DBG_BUGON(z_erofs_is_shortlived_page(fe->candidate_bvpage));
+		fe->candidate_bvpage = NULL;
+	}
+
 	/*
 	 * if all pending pages are added, don't hold its reference
 	 * any longer if the pcluster isn't hosted by ourselves.
@@ -712,22 +797,23 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		tight &= (fe->mode >= COLLECT_PRIMARY_FOLLOWED);
 
 retry:
-	err = z_erofs_attach_page(fe, page, page_type,
-				  fe->mode >= COLLECT_PRIMARY_FOLLOWED);
-	/* should allocate an additional short-lived page for pagevec */
-	if (err == -EAGAIN) {
-		struct page *const newpage =
-				alloc_page(GFP_NOFS | __GFP_NOFAIL);
-
-		set_page_private(newpage, Z_EROFS_SHORTLIVED_PAGE);
-		err = z_erofs_attach_page(fe, newpage,
-					  Z_EROFS_PAGE_TYPE_EXCLUSIVE, true);
-		if (!err)
-			goto retry;
+	err = z_erofs_attach_page(fe, &((struct z_erofs_bvec) {
+					.page = page,
+					.offset = offset - map->m_la,
+					.end = end,
+				  }), page_type);
+	/* should allocate an additional short-lived page for bvset */
+	if (err == -EAGAIN && !fe->candidate_bvpage) {
+		fe->candidate_bvpage = alloc_page(GFP_NOFS | __GFP_NOFAIL);
+		set_page_private(fe->candidate_bvpage,
+				 Z_EROFS_SHORTLIVED_PAGE);
+		goto retry;
 	}
 
-	if (err)
+	if (err) {
+		DBG_BUGON(err == -EAGAIN && fe->candidate_bvpage);
 		goto err_out;
+	}
 
 	index = page->index - (map->m_la >> PAGE_SHIFT);
 
@@ -781,29 +867,24 @@ static bool z_erofs_page_is_invalidated(struct page *page)
 static int z_erofs_parse_out_bvecs(struct z_erofs_pcluster *pcl,
 				   struct page **pages, struct page **pagepool)
 {
-	struct z_erofs_pagevec_ctor ctor;
-	enum z_erofs_page_type page_type;
+	struct z_erofs_bvec_iter biter;
+	struct page *old_bvpage;
 	int i, err = 0;
 
-	z_erofs_pagevec_ctor_init(&ctor, Z_EROFS_NR_INLINE_PAGEVECS,
-				  pcl->pagevec, 0);
+	z_erofs_bvec_iter_begin(&biter, &pcl->bvset,
+				Z_EROFS_NR_INLINE_PAGEVECS, 0);
 	for (i = 0; i < pcl->vcnt; ++i) {
-		struct page *page = z_erofs_pagevec_dequeue(&ctor, &page_type);
+		struct z_erofs_bvec bvec;
 		unsigned int pagenr;
 
-		/* all pages in pagevec ought to be valid */
-		DBG_BUGON(!page);
-		DBG_BUGON(z_erofs_page_is_invalidated(page));
-
-		if (z_erofs_put_shortlivedpage(pagepool, page))
-			continue;
+		z_erofs_bvec_dequeue(&biter, &bvec, &old_bvpage);
 
-		if (page_type == Z_EROFS_VLE_PAGE_TYPE_HEAD)
-			pagenr = 0;
-		else
-			pagenr = z_erofs_onlinepage_index(page);
+		if (old_bvpage)
+			z_erofs_put_shortlivedpage(pagepool, old_bvpage);
 
+		pagenr = (bvec.offset + pcl->pageofs_out) >> PAGE_SHIFT;
 		DBG_BUGON(pagenr >= pcl->nr_pages);
+		DBG_BUGON(z_erofs_page_is_invalidated(bvec.page));
 		/*
 		 * currently EROFS doesn't support multiref(dedup),
 		 * so here erroring out one multiref page.
@@ -814,9 +895,12 @@ static int z_erofs_parse_out_bvecs(struct z_erofs_pcluster *pcl,
 			z_erofs_onlinepage_endio(pages[pagenr]);
 			err = -EFSCORRUPTED;
 		}
-		pages[pagenr] = page;
+		pages[pagenr] = bvec.page;
 	}
-	z_erofs_pagevec_ctor_exit(&ctor, true);
+
+	old_bvpage = z_erofs_bvec_iter_end(&biter);
+	if (old_bvpage)
+		z_erofs_put_shortlivedpage(pagepool, old_bvpage);
 	return err;
 }
 
@@ -986,6 +1070,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		kvfree(pages);
 
 	pcl->nr_pages = 0;
+	pcl->bvset.nextpage = NULL;
 	pcl->vcnt = 0;
 
 	/* pcluster lock MUST be taken before the following line */
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 58053bb5066f..f8daadb19e37 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -21,6 +21,21 @@
  */
 typedef void *z_erofs_next_pcluster_t;
 
+struct z_erofs_bvec {
+	struct page *page;
+	int offset;
+	unsigned int end;
+};
+
+#define __Z_EROFS_BVSET(name, total) \
+struct name { \
+	/* point to the next page which contains the following bvecs */ \
+	struct page *nextpage; \
+	struct z_erofs_bvec bvec[total]; \
+}
+__Z_EROFS_BVSET(z_erofs_bvset,);
+__Z_EROFS_BVSET(z_erofs_bvset_inline, Z_EROFS_NR_INLINE_PAGEVECS);
+
 /*
  * Structure fields follow one of the following exclusion rules.
  *
@@ -41,22 +56,25 @@ struct z_erofs_pcluster {
 	/* A: lower limit of decompressed length and if full length or not */
 	unsigned int length;
 
+	/* L: total number of bvecs */
+	unsigned int vcnt;
+
 	/* I: page offset of start position of decompression */
 	unsigned short pageofs_out;
 
 	/* I: page offset of inline compressed data */
 	unsigned short pageofs_in;
 
-	/* L: maximum relative page index in pagevec[] */
+	/* L: maximum relative page index in bvecs */
 	unsigned short nr_pages;
 
-	/* L: total number of pages in pagevec[] */
-	unsigned int vcnt;
-
 	union {
 		/* L: inline a certain number of pagevecs for bootstrap */
 		erofs_vtptr_t pagevec[Z_EROFS_NR_INLINE_PAGEVECS];
 
+		/* L: inline a certain number of bvec for bootstrap */
+		struct z_erofs_bvset_inline bvset;
+
 		/* I: can be used to free the pcluster by RCU. */
 		struct rcu_head rcu;
 	};
-- 
2.24.4

