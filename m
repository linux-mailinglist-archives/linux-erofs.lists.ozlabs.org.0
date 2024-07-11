Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA2D92DFA8
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Jul 2024 07:37:21 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ureB9AOt;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WKNlg1WWbz3cXs
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Jul 2024 15:37:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ureB9AOt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WKNlZ2NLPz3c5R
	for <linux-erofs@lists.ozlabs.org>; Thu, 11 Jul 2024 15:37:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720676226; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cYoC/QRYRRwbVegGtKBjZ29Tb3iJi7EnOc+Fcjt/RH0=;
	b=ureB9AOtdoJ6Qr4ubSsFDPxgQkOFFEgn0x+GxQKLfUaw4TKUEyNrtecch1Jtti8PDha/+9jOZaFc+8lqePTsi/rAfOrTzPXpIzHXouOoLFTiEjiRg9coZiMZMha/2Ttjv5FzsU2zMxGKxuEsVajBRUwxTCiKs+twEd5nTt4Vufo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WAIfNAJ_1720676220;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAIfNAJ_1720676220)
          by smtp.aliyun-inc.com;
          Thu, 11 Jul 2024 13:37:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: avoid refcounting short-lived pages
Date: Thu, 11 Jul 2024 13:36:59 +0800
Message-ID: <20240711053659.1364989-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

LZ4 always reuses the decompressed buffer as its LZ77 sliding window
(dynamic dictionary) for optimal performance.  However, in specific
cases, the output buffer may not fully contain valid page cache pages,
resulting in the use of short-lived pages for temporary purposes.

Due to the limited sliding window size, LZ4 shortlived bounce pages can
also be reused in a sliding manner, so each bounce page can be vmapped
multiple times in different relative positions by design.  In order to
avoiding double frees, currently, reuse counts are recorded via page
refcount, but it will be no longer used as is in the future world of
Memdescs.

Just maintain a lookup table to check if a shortlived page is reused.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/compress.h     | 22 ++++++----------------
 fs/erofs/decompressor.c |  1 -
 fs/erofs/zdata.c        | 27 ++++++++++++++++++---------
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 526edc0a7d2d..7bfe251680ec 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -54,17 +54,14 @@ struct z_erofs_decompressor {
  */
 
 /*
- * short-lived pages are pages directly from buddy system with specific
- * page->private (no need to set PagePrivate since these are non-LRU /
- * non-movable pages and bypass reclaim / migration code).
+ * Currently, short-lived pages are pages directly from buddy system
+ * with specific page->private (Z_EROFS_SHORTLIVED_PAGE).
+ * In the future world of Memdescs, it should be type 0 (Misc) memory
+ * which type can be checked with a new helper.
  */
 static inline bool z_erofs_is_shortlived_page(struct page *page)
 {
-	if (page->private != Z_EROFS_SHORTLIVED_PAGE)
-		return false;
-
-	DBG_BUGON(page->mapping);
-	return true;
+	return page->private == Z_EROFS_SHORTLIVED_PAGE;
 }
 
 static inline bool z_erofs_put_shortlivedpage(struct page **pagepool,
@@ -72,14 +69,7 @@ static inline bool z_erofs_put_shortlivedpage(struct page **pagepool,
 {
 	if (!z_erofs_is_shortlived_page(page))
 		return false;
-
-	/* short-lived pages should not be used by others at the same time */
-	if (page_ref_count(page) > 1) {
-		put_page(page);
-	} else {
-		/* follow the pcluster rule above. */
-		erofs_pagepool_add(pagepool, page);
-	}
+	erofs_pagepool_add(pagepool, page);
 	return true;
 }
 
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index eac9e415194b..c2253b6a5416 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -110,7 +110,6 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
 
 		if (top) {
 			victim = availables[--top];
-			get_page(victim);
 		} else {
 			victim = __erofs_allocpage(pagepool, rq->gfp, true);
 			if (!victim)
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index aff3cdf114ad..544fa0f922b4 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1221,7 +1221,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	const struct z_erofs_decompressor *decomp =
 				z_erofs_decomp[pcl->algorithmformat];
-	int i, err2;
+	int i, j, jtop, err2;
 	struct page *page;
 	bool overlapped;
 
@@ -1279,10 +1279,9 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		WRITE_ONCE(pcl->compressed_bvecs[0].page, NULL);
 		put_page(page);
 	} else {
+		/* managed folios are still left in compressed_bvecs[] */
 		for (i = 0; i < pclusterpages; ++i) {
-			/* consider shortlived pages added when decompressing */
 			page = be->compressed_pages[i];
-
 			if (!page ||
 			    erofs_folio_is_managed(sbi, page_folio(page)))
 				continue;
@@ -1293,21 +1292,31 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	if (be->compressed_pages < be->onstack_pages ||
 	    be->compressed_pages >= be->onstack_pages + Z_EROFS_ONSTACK_PAGES)
 		kvfree(be->compressed_pages);
-	z_erofs_fill_other_copies(be, err);
 
+	jtop = 0;
+	z_erofs_fill_other_copies(be, err);
 	for (i = 0; i < be->nr_pages; ++i) {
 		page = be->decompressed_pages[i];
 		if (!page)
 			continue;
 
 		DBG_BUGON(z_erofs_page_is_invalidated(page));
-
-		/* recycle all individual short-lived pages */
-		if (z_erofs_put_shortlivedpage(be->pagepool, page))
+		if (!z_erofs_is_shortlived_page(page)) {
+			z_erofs_onlinefolio_end(page_folio(page), err);
 			continue;
-		z_erofs_onlinefolio_end(page_folio(page), err);
+		}
+		if (pcl->algorithmformat != Z_EROFS_COMPRESSION_LZ4) {
+			erofs_pagepool_add(be->pagepool, page);
+			continue;
+		}
+		for (j = 0; j < jtop && be->decompressed_pages[j] != page; ++j)
+			;
+		if (j >= jtop)	/* this bounce page is newly detected */
+			be->decompressed_pages[jtop++] = page;
 	}
-
+	while (jtop)
+		erofs_pagepool_add(be->pagepool,
+				   be->decompressed_pages[--jtop]);
 	if (be->decompressed_pages != be->onstack_pages)
 		kvfree(be->decompressed_pages);
 
-- 
2.43.5

