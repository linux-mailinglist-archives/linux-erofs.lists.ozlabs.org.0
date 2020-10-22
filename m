Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4033296147
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Oct 2020 16:58:42 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CH9V64N3rzDqtR
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Oct 2020 01:58:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1603378718;
	bh=nFvtJDpYG1jL35y3bfITkMBZUo5yMTRkmaDa+PAqm+Q=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Pfy6kY5r7wVLQdOneRUPR6x3pYzHnhgsZz96vidhgUMn1chPoGZCEbvqK5dnvp3Pa
	 3cWYnPj7stHb5G1BwsBBK+OVljnJeK/HmNMQ0M/jZP8Q+xIj2nS85HI4rcECBFjGOp
	 JmllMDtb558onZA785vYQssp04XiDA0KBJOFTGPAfM7GBYcnDDFWWn/G/gQF6K7/Bu
	 GjfFHVse0P9pE+gjI+rHdnDMeY93ai6k9xSAsetjHbw9jxW45vQfKfXbTNrsli/8Xf
	 y729xK1i4MS/eSeAcUG0P6IRKEBr99TFnjZg6Tf5OQi42Wn1eFabZQUu7ValfC3MZh
	 Zm7dAmlLeXj4A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.147; helo=sonic310-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=fkGpkM3u; dkim-atps=neutral
Received: from sonic310-21.consmr.mail.gq1.yahoo.com
 (sonic310-21.consmr.mail.gq1.yahoo.com [98.137.69.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CH9TK4XWWzDqnv
 for <linux-erofs@lists.ozlabs.org>; Fri, 23 Oct 2020 01:57:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1603378674; bh=ynt34DnzYzgFUcUwaxtdHXlhYDGKkh5KhjALkhgRhi0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=fkGpkM3uWG8FT8YmjI5CTs939186q9/AThkRbEu8UPdICYwYH+iNZDLel5IkhY+FcwV/XEIGmqTZ+yF/43Ic0LWzI0rsDsLnIMG1Id8WiQWqdvdFaRdpklPFer8XDQ16/c0k96rk7eqOnjXI1SyAo5BVqC2z8YUcX+30TPOFFnosFOwFQ7kL+z3yrtP53AaHORwRP1xBJiTzAJjXa/WZPtYhEp532zwq/9dbGI6wHSb1tba4qbkOTfjOafW9eMXdTnda3bY1jm985gmNiipzovHHlZXyO6x6hx9qbTrICy4u5kRtkQriUEUfLH9IRjtZ5Q9YWSP6pAkikemOE5pp5A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1603378674; bh=D7v7ses/EQlynD7/kpA1uqF06BkDM9/yEM46FAArVlV=;
 h=From:To:Subject:Date;
 b=f2spgBctehiibXnD6Fyz6WwTzn2qtpwJ/0SoFiVjgSAsGgZHaDD+DdKk1njoa7cTXX2WWhAktpTuess5wQVr067hKCtvfgCuyQDwyErxM1uzZpcusfBr9+/2FYS/OM0ZO9uPmJcYSmtsLLHAF/lcBhN6rcRU1+aPuxC4nvMByYsYsathGIO/Ks0PxyQvkVe5bJVXlbxve0JDpFB1jELZAB2OkXZS4YWJH5X9znjSaDoVlkGMeGUdhXs1EawfjqFqTkAgPsv0yrbbT+4zfZfCvl3vbZ4+bM2Bz6ZaoVElC1kR0OFACzf5trvAPYhAtQtbQntA7C9QXxcFOgLQ0WeVsA==
X-YMail-OSG: XzsQs6AVM1kowrxiKNBE9p9.Y_CpExj2YnS0U5ekyCldx48VKB4kf3Cr8Bfb5pQ
 GUdz3YU.3p3nxi2sopmELoyhCTgce_dTbSwbFgRkl2NRlB.vob2lkLbfD6fH0weRTfoZrw_txN1K
 Uiqsj.SHrlwJ7yKz1fBekH67GO859mDZ8smqeLJMLNS.hOYhVQR0kZOxmT.re3hf56LEEdxv2W50
 RzgQOaCoLi.MJLLzIc_ijGK5iNnIjSQPjJkl6UiVhLUXr1oSULD6Snw6VMr36m2KZAChq95KuOHx
 sNFO87opuU8eNDJUS2Um7kRNEGOoDWSUrwoofRR1JqhbtaXw5ibgZgxzH2evAOrYuV195epKz1Pd
 9D5gIZsgDCDorpWGkKhNraJVqDm_vZitG5tqLPzDoNckB6HqKlmT76wabLFLlVZfIZlUzJjwu8yn
 CILkh_mcyRTKnxSNIDDMjtQ7LMHa4DpWsaDdJZp02On5WLunc5gzU.1LNjxkH6lRBMabnzm4NNxA
 gB6RKMwBPhooQAmlyfvtSI124LzXV6NnwIJkjqIgNC7Xhktw0AUKFRktkhCIT4sfNKm8WkqGDgn5
 1a3NKiObjXYqa.2uu_OVHrzb1peO_Y6POGytXYG_xeS_IBpDvS7f7wBacNSDViB1Zpay_VecS23b
 wF_YSFCvFBGeiuejqkY3kqDUtbehoNAtTYlxvTGYeOv0dzmX.qX2ohfC0oFs_mMm_BVDm5MAK.2I
 FtJGgOybKuj7Kk7jnOXsAEjsAyAuMPs1yNTfKh_GGN9Upds8.LglsOiGtoH1UC2R3Irmjygu.WBr
 _lkM4UbpWp_SC.giZ7ikVA8pDxcizWiVDonXqUsBRUDdK7oLGo9TBaX1GTJJVNkbMERyAXtdzXBD
 FRrjXE379TOPxwqVQNqsF3s.SU6LkoEr46QwH61faN2k2AJrHJn2bxKsFixCMWowjvFD6DajPjq7
 wg.kw5aYX8bICvU03oy8aLMquxMwIMnWXkkhj4mgTDYFn9fQglwybu2LcCG95DxAR9vsk9rB8AWr
 LAOETgBSGNuRVkCmmsmqd3VJtSiR2nytRXG2LGCtFGQqgRGUNcCFCyq5IpTPUZ30zXn7XtN8rxOK
 cJ1En4XFu5ptY6U0HJ_RVGpOIeYJnER7PdnmhEv61XylF4CGFlMTpAq4bhDxp2J4nva90gxK06d8
 rryC93Vogi_HRVuW6VfYQOz6AP_HrV4UZvyHLg8aRLDGAQYxkqU_8vJ91JfoMT29BrxfF.TFFuAi
 CUC7nyiGPJ6vx7K3SdvyHBsNzEX_c498b.Xh.c.r8ZGNRlyP.FmQ.FTvjzhk8uVLemtxShamL00s
 8_CwHXR.4gcEf7tv9rsW8eUbGmR485.LAkHqKC4ygsQOM9HdHjRhW._TeYtatRJnHPHNiHr5P.n_
 QOxQmp3rGQ7yhTWqyhod4jQdR84NJsI940b3XWXzk_6KbRR6cZGM2zlhntSMXYo4AaHviM4LQA09
 P_JsPL87wRmKaBXULMVg2wAnFZeLLYb6QjfjvNAoE.GPNWNEUzO.36Qg83yiSJOYcyuWj6xiBld0
 C5sU-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.gq1.yahoo.com with HTTP; Thu, 22 Oct 2020 14:57:54 +0000
Received: by smtp401.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 354b2034a70b817070abfec37b60849b; 
 Thu, 22 Oct 2020 14:57:50 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/4] erofs: get rid of magical Z_EROFS_MAPPING_STAGING
Date: Thu, 22 Oct 2020 22:57:22 +0800
Message-Id: <20201022145724.27284-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201022145724.27284-1-hsiangkao@aol.com>
References: <20201022145724.27284-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Previously, we played around with magical page->mapping for
short-lived temporary pages since we need to identify different
types of pages in the same pcluster but both invalidated and
short-lived temporary pages can have page->mapping == NULL.
It was considered as safe because temporary pages are all
non-LRU / non-movable pages.

This patch tends to use specific page->private to identify
short-lived pages instead so it won't rely on page->mapping
anymore. Details are described in "compress.h" as well.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
prelimitary test is done. will do stress test then.

 fs/erofs/compress.h     | 50 ++++++++++++++++++++++++++++++-----------
 fs/erofs/decompressor.c |  2 +-
 fs/erofs/zdata.c        | 42 +++++++++++++++++++++-------------
 fs/erofs/zdata.h        |  1 +
 4 files changed, 65 insertions(+), 30 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 3d452443c545..2bbf47f353ef 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -26,30 +26,54 @@ struct z_erofs_decompress_req {
 	bool inplace_io, partial_decoding;
 };
 
+#define Z_EROFS_SHORTLIVED_PAGE		(-1UL << 2)
+
 /*
- * - 0x5A110C8D ('sallocated', Z_EROFS_MAPPING_STAGING) -
- * used to mark temporary allocated pages from other
- * file/cached pages and NULL mapping pages.
+ * For all pages in a pcluster, page->private should be one of
+ * Type                         Last 2bits      page->private
+ * short-lived page             00              Z_EROFS_SHORTLIVED_PAGE
+ * cached/managed page          00              pointer to z_erofs_pcluster
+ * online page (file-backed,    01/10/11        sub-index << 2 | count
+ *              some pages can be used for inplace I/O)
+ *
+ * page->mapping should be one of
+ * Type                 page->mapping
+ * short-lived page     NULL
+ * cached/managed page  non-NULL or NULL (invalidated/truncated page)
+ * online page          non-NULL
+ *
+ * For all managed pages, PG_private should be set with 1 extra refcount,
+ * which is used for page reclaim / migration.
  */
-#define Z_EROFS_MAPPING_STAGING         ((void *)0x5A110C8D)
 
-/* check if a page is marked as staging */
-static inline bool z_erofs_page_is_staging(struct page *page)
+/*
+ * short-lived pages are pages directly from buddy system with specific
+ * page->private (no need to set PagePrivate since these are non-LRU /
+ * non-movable pages and bypass reclaim / migration code).
+ */
+static inline bool z_erofs_is_shortlived_page(struct page *page)
 {
-	return page->mapping == Z_EROFS_MAPPING_STAGING;
+	if (page->private != Z_EROFS_SHORTLIVED_PAGE)
+		return false;
+
+	DBG_BUGON(page->mapping);
+	return true;
 }
 
-static inline bool z_erofs_put_stagingpage(struct list_head *pagepool,
-					   struct page *page)
+static inline bool z_erofs_put_shortlivedpage(struct list_head *pagepool,
+					      struct page *page)
 {
-	if (!z_erofs_page_is_staging(page))
+	if (!z_erofs_is_shortlived_page(page))
 		return false;
 
-	/* staging pages should not be used by others at the same time */
-	if (page_ref_count(page) > 1)
+	/* short-lived pages should not be used by others at the same time */
+	if (page_ref_count(page) > 1) {
 		put_page(page);
-	else
+	} else {
+		/* follow the pcluster rule above. */
+		set_page_private(page, 0);
 		list_add(&page->lru, pagepool);
+	}
 	return true;
 }
 
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index cbadbf55c6c2..1cb1ffd10569 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -76,7 +76,7 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 			victim = erofs_allocpage(pagepool, GFP_KERNEL);
 			if (!victim)
 				return -ENOMEM;
-			victim->mapping = Z_EROFS_MAPPING_STAGING;
+			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
 		}
 		rq->out[i] = victim;
 	}
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 86fd3bf62af6..afeadf413c2c 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -255,6 +255,7 @@ int erofs_try_to_free_cached_page(struct address_space *mapping,
 		erofs_workgroup_unfreeze(&pcl->obj, 1);
 
 		if (ret) {
+			set_page_private(page, 0);
 			ClearPagePrivate(page);
 			put_page(page);
 		}
@@ -648,12 +649,12 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 
 retry:
 	err = z_erofs_attach_page(clt, page, page_type);
-	/* should allocate an additional staging page for pagevec */
+	/* should allocate an additional short-lived page for pagevec */
 	if (err == -EAGAIN) {
 		struct page *const newpage =
 				alloc_page(GFP_NOFS | __GFP_NOFAIL);
 
-		newpage->mapping = Z_EROFS_MAPPING_STAGING;
+		set_page_private(newpage, Z_EROFS_SHORTLIVED_PAGE);
 		err = z_erofs_attach_page(clt, newpage,
 					  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
 		if (!err)
@@ -710,6 +711,11 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 		queue_work(z_erofs_workqueue, &io->u.work);
 }
 
+static bool z_erofs_page_is_invalidated(struct page *page)
+{
+	return !page->mapping && !z_erofs_is_shortlived_page(page);
+}
+
 static void z_erofs_decompressqueue_endio(struct bio *bio)
 {
 	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
@@ -722,7 +728,7 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
 		struct page *page = bvec->bv_page;
 
 		DBG_BUGON(PageUptodate(page));
-		DBG_BUGON(!page->mapping);
+		DBG_BUGON(z_erofs_page_is_invalidated(page));
 
 		if (err)
 			SetPageError(page);
@@ -795,9 +801,9 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 
 		/* all pages in pagevec ought to be valid */
 		DBG_BUGON(!page);
-		DBG_BUGON(!page->mapping);
+		DBG_BUGON(z_erofs_page_is_invalidated(page));
 
-		if (z_erofs_put_stagingpage(pagepool, page))
+		if (z_erofs_put_shortlivedpage(pagepool, page))
 			continue;
 
 		if (page_type == Z_EROFS_VLE_PAGE_TYPE_HEAD)
@@ -831,9 +837,9 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 
 		/* all compressed pages ought to be valid */
 		DBG_BUGON(!page);
-		DBG_BUGON(!page->mapping);
+		DBG_BUGON(z_erofs_page_is_invalidated(page));
 
-		if (!z_erofs_page_is_staging(page)) {
+		if (!z_erofs_is_shortlived_page(page)) {
 			if (erofs_page_is_managed(sbi, page)) {
 				if (!PageUptodate(page))
 					err = -EIO;
@@ -858,7 +864,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 			overlapped = true;
 		}
 
-		/* PG_error needs checking for inplaced and staging pages */
+		/* PG_error needs checking for all non-managed pages */
 		if (PageError(page)) {
 			DBG_BUGON(PageUptodate(page));
 			err = -EIO;
@@ -897,8 +903,8 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		if (erofs_page_is_managed(sbi, page))
 			continue;
 
-		/* recycle all individual staging pages */
-		(void)z_erofs_put_stagingpage(pagepool, page);
+		/* recycle all individual short-lived pages */
+		(void)z_erofs_put_shortlivedpage(pagepool, page);
 
 		WRITE_ONCE(compressed_pages[i], NULL);
 	}
@@ -908,10 +914,10 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		if (!page)
 			continue;
 
-		DBG_BUGON(!page->mapping);
+		DBG_BUGON(z_erofs_page_is_invalidated(page));
 
-		/* recycle all individual staging pages */
-		if (z_erofs_put_stagingpage(pagepool, page))
+		/* recycle all individual short-lived pages */
+		if (z_erofs_put_shortlivedpage(pagepool, page))
 			continue;
 
 		if (err < 0)
@@ -1011,13 +1017,17 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	mapping = READ_ONCE(page->mapping);
 
 	/*
-	 * unmanaged (file) pages are all locked solidly,
+	 * file-backed online pages in plcuster are all locked steady,
 	 * therefore it is impossible for `mapping' to be NULL.
 	 */
 	if (mapping && mapping != mc)
 		/* ought to be unmanaged pages */
 		goto out;
 
+	/* directly return for shortlived page as well */
+	if (z_erofs_is_shortlived_page(page))
+		goto out;
+
 	lock_page(page);
 
 	/* only true if page reclaim goes wrong, should never happen */
@@ -1062,8 +1072,8 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 out_allocpage:
 	page = erofs_allocpage(pagepool, gfp | __GFP_NOFAIL);
 	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
-		/* non-LRU / non-movable temporary page is needed */
-		page->mapping = Z_EROFS_MAPPING_STAGING;
+		/* turn into temporary page if fails */
+		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
 		tocache = false;
 	}
 
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 68c9b29fc0ca..b503b353d4ab 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -173,6 +173,7 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
 
 	v = atomic_dec_return(u.o);
 	if (!(v & Z_EROFS_ONLINEPAGE_COUNT_MASK)) {
+		set_page_private(page, 0);
 		ClearPagePrivate(page);
 		if (!PageError(page))
 			SetPageUptodate(page);
-- 
2.24.0

