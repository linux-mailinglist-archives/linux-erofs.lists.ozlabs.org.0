Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 03841574EFD
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Jul 2022 15:21:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LkFWf6nZfz3chN
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Jul 2022 23:21:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LkFWb0Twgz3cgd
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Jul 2022 23:21:46 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJJkPSH_1657804881;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJJkPSH_1657804881)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 21:21:23 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 16/16] erofs: introduce multi-reference pclusters (fully-referenced)
Date: Thu, 14 Jul 2022 21:20:51 +0800
Message-Id: <20220714132051.46012-17-hsiangkao@linux.alibaba.com>
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

Let's introduce multi-reference pclusters at runtime. In details,
if one pcluster is requested by multiple extents at almost the same
time (even belong to different files), the longest extent will be
decompressed as representative and the other extents are actually
copied from the longest one.

After this patch, fully-referenced extents can be correctly handled
and the full decoding check needs to be bypassed for
partial-referenced extents.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/compress.h     |   2 +-
 fs/erofs/decompressor.c |   2 +-
 fs/erofs/zdata.c        | 120 +++++++++++++++++++++++++++-------------
 fs/erofs/zdata.h        |   3 +
 4 files changed, 88 insertions(+), 39 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 19e6c56a9f47..26fa170090b8 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -17,7 +17,7 @@ struct z_erofs_decompress_req {
 
 	/* indicate the algorithm will be used for decompression */
 	unsigned int alg;
-	bool inplace_io, partial_decoding;
+	bool inplace_io, partial_decoding, fillgaps;
 };
 
 struct z_erofs_decompressor {
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 6dca1900c733..91b9bff10198 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -83,7 +83,7 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
 			j = 0;
 
 		/* 'valid' bounced can only be tested after a complete round */
-		if (test_bit(j, bounced)) {
+		if (!rq->fillgaps && test_bit(j, bounced)) {
 			DBG_BUGON(i < lz4_max_distance_pages);
 			DBG_BUGON(top >= lz4_max_distance_pages);
 			availables[top++] = rq->out[i - lz4_max_distance_pages];
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 8dcfc2a9704e..601cfcb07c50 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -467,7 +467,8 @@ static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
 	 * type 2, link to the end of an existing open chain, be careful
 	 * that its submission is controlled by the original attached chain.
 	 */
-	if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
+	if (*owned_head != &pcl->next && pcl != f->tailpcl &&
+	    cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
 		    *owned_head) == Z_EROFS_PCLUSTER_TAIL) {
 		*owned_head = Z_EROFS_PCLUSTER_TAIL;
 		f->mode = Z_EROFS_PCLUSTER_HOOKED;
@@ -480,20 +481,8 @@ static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
 
 static int z_erofs_lookup_pcluster(struct z_erofs_decompress_frontend *fe)
 {
-	struct erofs_map_blocks *map = &fe->map;
 	struct z_erofs_pcluster *pcl = fe->pcl;
 
-	/* to avoid unexpected loop formed by corrupted images */
-	if (fe->owned_head == &pcl->next || pcl == fe->tailpcl) {
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
-
-	if (pcl->pageofs_out != (map->m_la & ~PAGE_MASK)) {
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
-
 	mutex_lock(&pcl->lock);
 	/* used to check tail merging loop due to corrupted images */
 	if (fe->owned_head == Z_EROFS_PCLUSTER_TAIL)
@@ -785,6 +774,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	z_erofs_onlinepage_split(page);
 	/* bump up the number of spiltted parts of a page */
 	++spiltted;
+	fe->pcl->multibases =
+		(fe->pcl->pageofs_out != (map->m_la & ~PAGE_MASK));
 
 	if (fe->pcl->length < offset + end - map->m_la) {
 		fe->pcl->length = offset + end - map->m_la;
@@ -842,36 +833,90 @@ struct z_erofs_decompress_backend {
 	/* pages to keep the compressed data */
 	struct page **compressed_pages;
 
+	struct list_head decompressed_secondary_bvecs;
 	struct page **pagepool;
 	unsigned int onstack_used, nr_pages;
 };
 
-static int z_erofs_do_decompressed_bvec(struct z_erofs_decompress_backend *be,
-					struct z_erofs_bvec *bvec)
+struct z_erofs_bvec_item {
+	struct z_erofs_bvec bvec;
+	struct list_head list;
+};
+
+static void z_erofs_do_decompressed_bvec(struct z_erofs_decompress_backend *be,
+					 struct z_erofs_bvec *bvec)
 {
-	unsigned int pgnr = (bvec->offset + be->pcl->pageofs_out) >> PAGE_SHIFT;
-	struct page *oldpage;
+	struct z_erofs_bvec_item *item;
 
-	DBG_BUGON(pgnr >= be->nr_pages);
-	oldpage = be->decompressed_pages[pgnr];
-	be->decompressed_pages[pgnr] = bvec->page;
+	if (!((bvec->offset + be->pcl->pageofs_out) & ~PAGE_MASK)) {
+		unsigned int pgnr;
+		struct page *oldpage;
 
-	/* error out if one pcluster is refenenced multiple times. */
-	if (oldpage) {
-		DBG_BUGON(1);
-		z_erofs_page_mark_eio(oldpage);
-		z_erofs_onlinepage_endio(oldpage);
-		return -EFSCORRUPTED;
+		pgnr = (bvec->offset + be->pcl->pageofs_out) >> PAGE_SHIFT;
+		DBG_BUGON(pgnr >= be->nr_pages);
+		oldpage = be->decompressed_pages[pgnr];
+		be->decompressed_pages[pgnr] = bvec->page;
+
+		if (!oldpage)
+			return;
+	}
+
+	/* (cold path) one pcluster is requested multiple times */
+	item = kmalloc(sizeof(*item), GFP_KERNEL | __GFP_NOFAIL);
+	item->bvec = *bvec;
+	list_add(&item->list, &be->decompressed_secondary_bvecs);
+}
+
+static void z_erofs_fill_other_copies(struct z_erofs_decompress_backend *be,
+				      int err)
+{
+	unsigned int off0 = be->pcl->pageofs_out;
+	struct list_head *p, *n;
+
+	list_for_each_safe(p, n, &be->decompressed_secondary_bvecs) {
+		struct z_erofs_bvec_item *bvi;
+		unsigned int end, cur;
+		void *dst, *src;
+
+		bvi = container_of(p, struct z_erofs_bvec_item, list);
+		cur = bvi->bvec.offset < 0 ? -bvi->bvec.offset : 0;
+		end = min_t(unsigned int, be->pcl->length - bvi->bvec.offset,
+			    bvi->bvec.end);
+		dst = kmap_local_page(bvi->bvec.page);
+		while (cur < end) {
+			unsigned int pgnr, scur, len;
+
+			pgnr = (bvi->bvec.offset + cur + off0) >> PAGE_SHIFT;
+			DBG_BUGON(pgnr >= be->nr_pages);
+
+			scur = bvi->bvec.offset + cur -
+					((pgnr << PAGE_SHIFT) - off0);
+			len = min_t(unsigned int, end - cur, PAGE_SIZE - scur);
+			if (!be->decompressed_pages[pgnr]) {
+				err = -EFSCORRUPTED;
+				cur += len;
+				continue;
+			}
+			src = kmap_local_page(be->decompressed_pages[pgnr]);
+			memcpy(dst + cur, src + scur, len);
+			kunmap_local(src);
+			cur += len;
+		}
+		kunmap_local(dst);
+		if (err)
+			z_erofs_page_mark_eio(bvi->bvec.page);
+		z_erofs_onlinepage_endio(bvi->bvec.page);
+		list_del(p);
+		kfree(bvi);
 	}
-	return 0;
 }
 
-static int z_erofs_parse_out_bvecs(struct z_erofs_decompress_backend *be)
+static void z_erofs_parse_out_bvecs(struct z_erofs_decompress_backend *be)
 {
 	struct z_erofs_pcluster *pcl = be->pcl;
 	struct z_erofs_bvec_iter biter;
 	struct page *old_bvpage;
-	int i, err = 0;
+	int i;
 
 	z_erofs_bvec_iter_begin(&biter, &pcl->bvset, Z_EROFS_INLINE_BVECS, 0);
 	for (i = 0; i < pcl->vcnt; ++i) {
@@ -883,13 +928,12 @@ static int z_erofs_parse_out_bvecs(struct z_erofs_decompress_backend *be)
 			z_erofs_put_shortlivedpage(be->pagepool, old_bvpage);
 
 		DBG_BUGON(z_erofs_page_is_invalidated(bvec.page));
-		err = z_erofs_do_decompressed_bvec(be, &bvec);
+		z_erofs_do_decompressed_bvec(be, &bvec);
 	}
 
 	old_bvpage = z_erofs_bvec_iter_end(&biter);
 	if (old_bvpage)
 		z_erofs_put_shortlivedpage(be->pagepool, old_bvpage);
-	return err;
 }
 
 static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
@@ -924,7 +968,7 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 					err = -EIO;
 				continue;
 			}
-			err = z_erofs_do_decompressed_bvec(be, bvec);
+			z_erofs_do_decompressed_bvec(be, bvec);
 			*overlapped = true;
 		}
 	}
@@ -940,7 +984,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
-	unsigned int i, inputsize, err2;
+	unsigned int i, inputsize;
 	struct page *page;
 	bool overlapped;
 
@@ -970,10 +1014,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 			kvcalloc(pclusterpages, sizeof(struct page *),
 				 GFP_KERNEL | __GFP_NOFAIL);
 
-	err = z_erofs_parse_out_bvecs(be);
-	err2 = z_erofs_parse_in_bvecs(be, &overlapped);
-	if (err2)
-		err = err2;
+	z_erofs_parse_out_bvecs(be);
+	err = z_erofs_parse_in_bvecs(be, &overlapped);
 	if (err)
 		goto out;
 
@@ -993,6 +1035,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 					.alg = pcl->algorithmformat,
 					.inplace_io = overlapped,
 					.partial_decoding = pcl->partial,
+					.fillgaps = pcl->multibases,
 				 }, be->pagepool);
 
 out:
@@ -1016,6 +1059,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	if (be->compressed_pages < be->onstack_pages ||
 	    be->compressed_pages >= be->onstack_pages + Z_EROFS_ONSTACK_PAGES)
 		kvfree(be->compressed_pages);
+	z_erofs_fill_other_copies(be, err);
 
 	for (i = 0; i < be->nr_pages; ++i) {
 		page = be->decompressed_pages[i];
@@ -1052,6 +1096,8 @@ static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 	struct z_erofs_decompress_backend be = {
 		.sb = io->sb,
 		.pagepool = pagepool,
+		.decompressed_secondary_bvecs =
+			LIST_HEAD_INIT(be.decompressed_secondary_bvecs),
 	};
 	z_erofs_next_pcluster_t owned = io->head;
 
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index a7fd44d21d9e..515fa2b28b97 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -84,6 +84,9 @@ struct z_erofs_pcluster {
 	/* L: whether partial decompression or not */
 	bool partial;
 
+	/* L: indicate several pageofs_outs or not */
+	bool multibases;
+
 	/* A: compressed bvecs (can be cached or inplaced pages) */
 	struct z_erofs_bvec compressed_bvecs[];
 };
-- 
2.24.4

