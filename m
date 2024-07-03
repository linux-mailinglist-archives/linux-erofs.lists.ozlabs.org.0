Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AD4925F82
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 14:01:31 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CJ//tgM/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WDdfd4Xjnz3dDJ
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 22:01:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CJ//tgM/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WDdf9403Tz3d3Z
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jul 2024 22:01:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720008061; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=f3NfSFOztXDR1P17ftTq4m6tI075p02Cmv9kVZVzihc=;
	b=CJ//tgM/dfVB52T/mR9OkamKoal9J10XUhBI6aJvJttnS/Fdze8Ln6t2u2ZsADnTN6oUsu5sK9cX+GlfaiUYVnS4GVY8uPwkVXLjuApmb2jxjYDllZi/Yqe2qjHdx1vpUwwe4FSHvKo9pzLpRXlGERftVcICY/2FUgfAOMokDBM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W9mSOMt_1720008059;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9mSOMt_1720008059)
          by smtp.aliyun-inc.com;
          Wed, 03 Jul 2024 20:01:00 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/4] erofs: tidy up `struct z_erofs_bvec`
Date: Wed,  3 Jul 2024 20:00:51 +0800
Message-ID: <20240703120051.3653452-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240703120051.3653452-1-hsiangkao@linux.alibaba.com>
References: <20240703120051.3653452-1-hsiangkao@linux.alibaba.com>
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

After revisiting the design, I believe `struct z_erofs_bvec` should
be page-based instead of folio-based due to the reasons below:

 - The minimized memory mapping block is a page;

 - Under the certain circumstances, only temporary pages needs to be
   used instead of folios since refcount, mapcount for such pages are
   unnecessary;

 - Decompressors handle all types of pages including temporary pages,
   not only folios.

When handling `struct z_erofs_bvec`, all folio-related information
is now accessed using the page_folio() helper.

The final goal of this round adaptation is to eliminate direct
accesses to `struct page` in the EROFS codebase, except for some
exceptions like `z_erofs_is_shortlived_page()` and
`z_erofs_page_is_invalidated()`, which require a new helper to
determine the memdesc type of an arbitrary page.

Actually large folios of compressed files seems to work now, yet I tend
to conduct more tests before officially enabling this for all scenarios.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 101 +++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 52 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index cb017ca2c7e3..988f67cc0145 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -19,10 +19,7 @@
 typedef void *z_erofs_next_pcluster_t;
 
 struct z_erofs_bvec {
-	union {
-		struct page *page;
-		struct folio *folio;
-	};
+	struct page *page;
 	int offset;
 	unsigned int end;
 };
@@ -617,32 +614,31 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 }
 
-/* called by erofs_shrinker to get rid of all cached compressed bvecs */
+/* (erofs_shrinker) disconnect cached encoded data with pclusters */
 int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
 					struct erofs_workgroup *grp)
 {
 	struct z_erofs_pcluster *const pcl =
 		container_of(grp, struct z_erofs_pcluster, obj);
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
+	struct folio *folio;
 	int i;
 
 	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
-	/* There is no actice user since the pcluster is now freezed */
+	/* Each cached folio contains one page unless bs > ps is supported */
 	for (i = 0; i < pclusterpages; ++i) {
-		struct folio *folio = pcl->compressed_bvecs[i].folio;
+		if (pcl->compressed_bvecs[i].page) {
+			folio = page_folio(pcl->compressed_bvecs[i].page);
+			/* Avoid reclaiming or migrating this folio */
+			if (!folio_trylock(folio))
+				return -EBUSY;
 
-		if (!folio)
-			continue;
-
-		/* Avoid reclaiming or migrating this folio */
-		if (!folio_trylock(folio))
-			return -EBUSY;
-
-		if (!erofs_folio_is_managed(sbi, folio))
-			continue;
-		pcl->compressed_bvecs[i].folio = NULL;
-		folio_detach_private(folio);
-		folio_unlock(folio);
+			if (!erofs_folio_is_managed(sbi, folio))
+				continue;
+			pcl->compressed_bvecs[i].page = NULL;
+			folio_detach_private(folio);
+			folio_unlock(folio);
+		}
 	}
 	return 0;
 }
@@ -650,9 +646,9 @@ int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
 static bool z_erofs_cache_release_folio(struct folio *folio, gfp_t gfp)
 {
 	struct z_erofs_pcluster *pcl = folio_get_private(folio);
-	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
+	struct z_erofs_bvec *bvec = pcl->compressed_bvecs;
+	struct z_erofs_bvec *end = bvec + z_erofs_pclusterpages(pcl);
 	bool ret;
-	int i;
 
 	if (!folio_test_private(folio))
 		return true;
@@ -661,9 +657,9 @@ static bool z_erofs_cache_release_folio(struct folio *folio, gfp_t gfp)
 	spin_lock(&pcl->obj.lockref.lock);
 	if (pcl->obj.lockref.count <= 0) {
 		DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
-		for (i = 0; i < pclusterpages; ++i) {
-			if (pcl->compressed_bvecs[i].folio == folio) {
-				pcl->compressed_bvecs[i].folio = NULL;
+		for (; bvec < end; ++bvec) {
+			if (bvec->page && page_folio(bvec->page) == folio) {
+				bvec->page = NULL;
 				folio_detach_private(folio);
 				ret = true;
 				break;
@@ -1062,7 +1058,7 @@ static bool z_erofs_is_sync_decompress(struct erofs_sb_info *sbi,
 
 static bool z_erofs_page_is_invalidated(struct page *page)
 {
-	return !page->mapping && !z_erofs_is_shortlived_page(page);
+	return !page_folio(page)->mapping && !z_erofs_is_shortlived_page(page);
 }
 
 struct z_erofs_decompress_backend {
@@ -1415,7 +1411,7 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	bool tocache = false;
 	struct z_erofs_bvec zbv;
 	struct address_space *mapping;
-	struct page *page;
+	struct folio *folio;
 	int bs = i_blocksize(f->inode);
 
 	/* Except for inplace folios, the entire folio can be used for I/Os */
@@ -1425,23 +1421,25 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	spin_lock(&pcl->obj.lockref.lock);
 	zbv = pcl->compressed_bvecs[nr];
 	spin_unlock(&pcl->obj.lockref.lock);
-	if (!zbv.folio)
+	if (!zbv.page)
 		goto out_allocfolio;
 
-	bvec->bv_page = &zbv.folio->page;
+	bvec->bv_page = zbv.page;
 	DBG_BUGON(z_erofs_is_shortlived_page(bvec->bv_page));
+
+	folio = page_folio(zbv.page);
 	/*
 	 * Handle preallocated cached folios.  We tried to allocate such folios
 	 * without triggering direct reclaim.  If allocation failed, inplace
 	 * file-backed folios will be used instead.
 	 */
-	if (zbv.folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
-		zbv.folio->private = 0;
+	if (folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
+		folio->private = 0;
 		tocache = true;
 		goto out_tocache;
 	}
 
-	mapping = READ_ONCE(zbv.folio->mapping);
+	mapping = READ_ONCE(folio->mapping);
 	/*
 	 * File-backed folios for inplace I/Os are all locked steady,
 	 * therefore it is impossible for `mapping` to be NULL.
@@ -1453,21 +1451,21 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 		return;
 	}
 
-	folio_lock(zbv.folio);
-	if (zbv.folio->mapping == mc) {
+	folio_lock(folio);
+	if (folio->mapping == mc) {
 		/*
 		 * The cached folio is still in managed cache but without
 		 * a valid `->private` pcluster hint.  Let's reconnect them.
 		 */
-		if (!folio_test_private(zbv.folio)) {
-			folio_attach_private(zbv.folio, pcl);
+		if (!folio_test_private(folio)) {
+			folio_attach_private(folio, pcl);
 			/* compressed_bvecs[] already takes a ref before */
-			folio_put(zbv.folio);
+			folio_put(folio);
 		}
 
 		/* no need to submit if it is already up-to-date */
-		if (folio_test_uptodate(zbv.folio)) {
-			folio_unlock(zbv.folio);
+		if (folio_test_uptodate(folio)) {
+			folio_unlock(folio);
 			bvec->bv_page = NULL;
 		}
 		return;
@@ -1477,32 +1475,31 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	 * It has been truncated, so it's unsafe to reuse this one. Let's
 	 * allocate a new page for compressed data.
 	 */
-	DBG_BUGON(zbv.folio->mapping);
+	DBG_BUGON(folio->mapping);
 	tocache = true;
-	folio_unlock(zbv.folio);
-	folio_put(zbv.folio);
+	folio_unlock(folio);
+	folio_put(folio);
 out_allocfolio:
-	page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
+	zbv.page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
 	spin_lock(&pcl->obj.lockref.lock);
-	if (pcl->compressed_bvecs[nr].folio) {
-		erofs_pagepool_add(&f->pagepool, page);
+	if (pcl->compressed_bvecs[nr].page) {
+		erofs_pagepool_add(&f->pagepool, zbv.page);
 		spin_unlock(&pcl->obj.lockref.lock);
 		cond_resched();
 		goto repeat;
 	}
-	pcl->compressed_bvecs[nr].folio = zbv.folio = page_folio(page);
+	bvec->bv_page = pcl->compressed_bvecs[nr].page = zbv.page;
+	folio = page_folio(zbv.page);
+	/* first mark it as a temporary shortlived folio (now 1 ref) */
+	folio->private = (void *)Z_EROFS_SHORTLIVED_PAGE;
 	spin_unlock(&pcl->obj.lockref.lock);
-	bvec->bv_page = page;
 out_tocache:
 	if (!tocache || bs != PAGE_SIZE ||
-	    filemap_add_folio(mc, zbv.folio, pcl->obj.index + nr, gfp)) {
-		/* turn into a temporary shortlived folio (1 ref) */
-		zbv.folio->private = (void *)Z_EROFS_SHORTLIVED_PAGE;
+	    filemap_add_folio(mc, folio, pcl->obj.index + nr, gfp))
 		return;
-	}
-	folio_attach_private(zbv.folio, pcl);
+	folio_attach_private(folio, pcl);
 	/* drop a refcount added by allocpage (then 2 refs in total here) */
-	folio_put(zbv.folio);
+	folio_put(folio);
 }
 
 static struct z_erofs_decompressqueue *jobqueue_init(struct super_block *sb,
-- 
2.43.5

