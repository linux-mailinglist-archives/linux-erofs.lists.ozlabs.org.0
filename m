Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 01168437432
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 11:02:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HbJJ73GDrz3c8m
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 20:01:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HbJJ34CzYz2y7V
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Oct 2021 20:01:54 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R591e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0UtEhF74_1634893282; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UtEhF74_1634893282) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 22 Oct 2021 17:01:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] erofs: get rid of ->lru usage
Date: Fri, 22 Oct 2021 17:01:20 +0800
Message-Id: <20211022090120.14675-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Kent Overstreet <kent.overstreet@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, ->lru is a way to arrange non-LRU pages and has some
in-kernel users. In order to minimize noticable issues of page
reclaim and cache thrashing under high memory presure, limited
temporary pages were all chained with ->lru and can be reused
during the request. However, it seems that ->lru could be removed
when folio is landing.

Let's use page->private to chain temporary pages for now instead
and transform EROFS formally after the topic of the folio / file
page design is finalized.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/compress.h          | 11 +++++-----
 fs/erofs/decompressor.c      |  8 +++----
 fs/erofs/decompressor_lzma.c |  2 +-
 fs/erofs/internal.h          |  9 +++++++-
 fs/erofs/pcpubuf.c           |  6 +++---
 fs/erofs/utils.c             | 19 +++++++++++-----
 fs/erofs/zdata.c             | 42 ++++++++++++++++--------------------
 7 files changed, 53 insertions(+), 44 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 8ea6a9b14962..579406504919 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -22,7 +22,7 @@ struct z_erofs_decompress_req {
 
 struct z_erofs_decompressor {
 	int (*decompress)(struct z_erofs_decompress_req *rq,
-			  struct list_head *pagepool);
+			  struct page **pagepool);
 	char *name;
 };
 
@@ -64,7 +64,7 @@ static inline bool z_erofs_is_shortlived_page(struct page *page)
 	return true;
 }
 
-static inline bool z_erofs_put_shortlivedpage(struct list_head *pagepool,
+static inline bool z_erofs_put_shortlivedpage(struct page **pagepool,
 					      struct page *page)
 {
 	if (!z_erofs_is_shortlived_page(page))
@@ -75,8 +75,7 @@ static inline bool z_erofs_put_shortlivedpage(struct list_head *pagepool,
 		put_page(page);
 	} else {
 		/* follow the pcluster rule above. */
-		set_page_private(page, 0);
-		list_add(&page->lru, pagepool);
+		erofs_pagepool_add(pagepool, page);
 	}
 	return true;
 }
@@ -89,9 +88,9 @@ static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
 }
 
 int z_erofs_decompress(struct z_erofs_decompress_req *rq,
-		       struct list_head *pagepool);
+		       struct page **pagepool);
 
 /* prototypes for specific algorithms */
 int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
-			    struct list_head *pagepool);
+			    struct page **pagepool);
 #endif
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 8a624d73c185..a0786b95cdf9 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -57,7 +57,7 @@ int z_erofs_load_lz4_config(struct super_block *sb,
  * all physical pages are consecutive, which can be seen for moderate CR.
  */
 static int z_erofs_lz4_prepare_dstpages(struct z_erofs_decompress_req *rq,
-					struct list_head *pagepool)
+					struct page **pagepool)
 {
 	const unsigned int nr =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -254,7 +254,7 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq,
 }
 
 static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
-				  struct list_head *pagepool)
+				  struct page **pagepool)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -296,7 +296,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 }
 
 static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
-				     struct list_head *pagepool)
+				     struct page **pagepool)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -352,7 +352,7 @@ static struct z_erofs_decompressor decompressors[] = {
 };
 
 int z_erofs_decompress(struct z_erofs_decompress_req *rq,
-		       struct list_head *pagepool)
+		       struct page **pagepool)
 {
 	return decompressors[rq->alg].decompress(rq, pagepool);
 }
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index bd7d9809ecf7..50045510a1f4 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -150,7 +150,7 @@ int z_erofs_load_lzma_config(struct super_block *sb,
 }
 
 int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
-			    struct list_head *pagepool)
+			    struct page **pagepool)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index a6a53d22dfd6..3265688af7f9 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -499,7 +499,14 @@ void erofs_pcpubuf_init(void);
 void erofs_pcpubuf_exit(void);
 
 /* utils.c / zdata.c */
-struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp);
+struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp);
+static inline void erofs_pagepool_add(struct page **pagepool,
+		struct page *page)
+{
+	set_page_private(page, (unsigned long)*pagepool);
+	*pagepool = page;
+}
+void erofs_release_pages(struct page **pagepool);
 
 #ifdef CONFIG_EROFS_FS_ZIP
 int erofs_workgroup_put(struct erofs_workgroup *grp);
diff --git a/fs/erofs/pcpubuf.c b/fs/erofs/pcpubuf.c
index 6c885575128a..a2efd833d1b6 100644
--- a/fs/erofs/pcpubuf.c
+++ b/fs/erofs/pcpubuf.c
@@ -49,7 +49,7 @@ int erofs_pcpubuf_growsize(unsigned int nrpages)
 {
 	static DEFINE_MUTEX(pcb_resize_mutex);
 	static unsigned int pcb_nrpages;
-	LIST_HEAD(pagepool);
+	struct page *pagepool = NULL;
 	int delta, cpu, ret, i;
 
 	mutex_lock(&pcb_resize_mutex);
@@ -102,13 +102,13 @@ int erofs_pcpubuf_growsize(unsigned int nrpages)
 			vunmap(old_ptr);
 free_pagearray:
 		while (i)
-			list_add(&oldpages[--i]->lru, &pagepool);
+			erofs_pagepool_add(&pagepool, oldpages[--i]);
 		kfree(oldpages);
 		if (ret)
 			break;
 	}
 	pcb_nrpages = nrpages;
-	put_pages_list(&pagepool);
+	erofs_release_pages(&pagepool);
 out:
 	mutex_unlock(&pcb_resize_mutex);
 	return ret;
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index bd86067a63f7..84da2c280012 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -6,20 +6,29 @@
 #include "internal.h"
 #include <linux/pagevec.h>
 
-struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp)
+struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp)
 {
-	struct page *page;
+	struct page *page = *pagepool;
 
-	if (!list_empty(pool)) {
-		page = lru_to_page(pool);
+	if (page) {
 		DBG_BUGON(page_ref_count(page) != 1);
-		list_del(&page->lru);
+		*pagepool = (struct page *)page_private(page);
 	} else {
 		page = alloc_page(gfp);
 	}
 	return page;
 }
 
+void erofs_release_pages(struct page **pagepool)
+{
+	while (*pagepool) {
+		struct page *page = *pagepool;
+
+		*pagepool = (struct page *)page_private(page);
+		put_page(page);
+	}
+}
+
 #ifdef CONFIG_EROFS_FS_ZIP
 /* global shrink count (for all mounted EROFS instances) */
 static atomic_long_t erofs_global_shrink_cnt;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d55e6215cd44..bcb1b91b234f 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -236,7 +236,7 @@ static DEFINE_MUTEX(z_pagemap_global_lock);
 static void preload_compressed_pages(struct z_erofs_collector *clt,
 				     struct address_space *mc,
 				     enum z_erofs_cache_alloctype type,
-				     struct list_head *pagepool)
+				     struct page **pagepool)
 {
 	struct z_erofs_pcluster *pcl = clt->pcl;
 	bool standalone = true;
@@ -287,12 +287,10 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 		if (!cmpxchg_relaxed(pages, NULL, tagptr_cast_ptr(t)))
 			continue;
 
-		if (page) {
+		if (page)
 			put_page(page);
-		} else if (newpage) {
-			set_page_private(newpage, 0);
-			list_add(&newpage->lru, pagepool);
-		}
+		else if (newpage)
+			erofs_pagepool_add(pagepool, newpage);
 	}
 
 	/*
@@ -643,7 +641,7 @@ static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
 }
 
 static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
-				struct page *page, struct list_head *pagepool)
+				struct page *page, struct page **pagepool)
 {
 	struct inode *const inode = fe->inode;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
@@ -836,7 +834,7 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
 
 static int z_erofs_decompress_pcluster(struct super_block *sb,
 				       struct z_erofs_pcluster *pcl,
-				       struct list_head *pagepool)
+				       struct page **pagepool)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 	struct z_erofs_pagevec_ctor ctor;
@@ -1036,7 +1034,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 }
 
 static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
-				     struct list_head *pagepool)
+				     struct page **pagepool)
 {
 	z_erofs_next_pcluster_t owned = io->head;
 
@@ -1060,18 +1058,18 @@ static void z_erofs_decompressqueue_work(struct work_struct *work)
 {
 	struct z_erofs_decompressqueue *bgq =
 		container_of(work, struct z_erofs_decompressqueue, u.work);
-	LIST_HEAD(pagepool);
+	struct page *pagepool = NULL;
 
 	DBG_BUGON(bgq->head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
 	z_erofs_decompress_queue(bgq, &pagepool);
 
-	put_pages_list(&pagepool);
+	erofs_release_pages(&pagepool);
 	kvfree(bgq);
 }
 
 static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 					       unsigned int nr,
-					       struct list_head *pagepool,
+					       struct page **pagepool,
 					       struct address_space *mc,
 					       gfp_t gfp)
 {
@@ -1173,7 +1171,7 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 out_allocpage:
 	page = erofs_allocpage(pagepool, gfp | __GFP_NOFAIL);
 	if (oldpage != cmpxchg(&pcl->compressed_pages[nr], oldpage, page)) {
-		list_add(&page->lru, pagepool);
+		erofs_pagepool_add(pagepool, page);
 		cond_resched();
 		goto repeat;
 	}
@@ -1257,7 +1255,7 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 
 static void z_erofs_submit_queue(struct super_block *sb,
 				 struct z_erofs_decompress_frontend *f,
-				 struct list_head *pagepool,
+				 struct page **pagepool,
 				 struct z_erofs_decompressqueue *fgq,
 				 bool *force_fg)
 {
@@ -1365,7 +1363,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
 
 static void z_erofs_runqueue(struct super_block *sb,
 			     struct z_erofs_decompress_frontend *f,
-			     struct list_head *pagepool, bool force_fg)
+			     struct page **pagepool, bool force_fg)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 
@@ -1394,7 +1392,7 @@ static void z_erofs_runqueue(struct super_block *sb,
 static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 				      struct readahead_control *rac,
 				      erofs_off_t end,
-				      struct list_head *pagepool,
+				      struct page **pagepool,
 				      bool backmost)
 {
 	struct inode *inode = f->inode;
@@ -1457,8 +1455,8 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 {
 	struct inode *const inode = page->mapping->host;
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
+	struct page *pagepool = NULL;
 	int err;
-	LIST_HEAD(pagepool);
 
 	trace_erofs_readpage(page, false);
 	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
@@ -1479,8 +1477,7 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 	if (f.map.mpage)
 		put_page(f.map.mpage);
 
-	/* clean up the remaining free pages */
-	put_pages_list(&pagepool);
+	erofs_release_pages(&pagepool);
 	return err;
 }
 
@@ -1489,9 +1486,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct inode *const inode = rac->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
-	struct page *page, *head = NULL;
+	struct page *pagepool = NULL, *head = NULL, *page;
 	unsigned int nr_pages;
-	LIST_HEAD(pagepool);
 
 	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
@@ -1528,9 +1524,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 			 nr_pages <= sbi->opt.max_sync_decompress_pages);
 	if (f.map.mpage)
 		put_page(f.map.mpage);
-
-	/* clean up the remaining free pages */
-	put_pages_list(&pagepool);
+	erofs_release_pages(&pagepool);
 }
 
 const struct address_space_operations z_erofs_aops = {
-- 
2.24.4

