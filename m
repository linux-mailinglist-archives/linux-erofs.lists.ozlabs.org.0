Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7372D4248
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 13:42:09 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrcBM35RhzDqfY
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 23:42:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607517723;
	bh=bvBp6EDzmLDqV5NeJ7Gpwp+RgUwnA91WYZC9Eupu2AY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=AEnpF3oQ+0bGNl8sk3vUCu+tJcqPNT9liPOpozrkWfn8cr0T3qCxArfO4qAx+8o12
	 pkzC7owjS8vuiJ0W9mZTT75Mf77BSTARg/QN7T+bnVZ22voNuNHt0LmxNIRhCJEC6Z
	 oGhkebE0wywmm/RTzMYRqboa4ocUvgMRN0nUiXlAjupHkjlV94DhNnnGUojTXmjr86
	 gFQoHp4U3HXMrwDk4RDeK1dXNw7Rf5iDDI4DqaRHM1JGXtO1xMU5gXcDqm4loT2I5Y
	 lO8jHk9/FDMcw3KXQwXeM6P7s4GW70iuoWeHHWGXR+u+SYn04xkKjXBMZh8KuXq1Ok
	 vk0VemWhNTKfg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.204; helo=sonic312-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=NZ+6E3zE; dkim-atps=neutral
Received: from sonic312-23.consmr.mail.gq1.yahoo.com
 (sonic312-23.consmr.mail.gq1.yahoo.com [98.137.69.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Crc5S5TkdzDqpM
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Dec 2020 23:37:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1607517461; bh=tNdncxCi0Pa8Lvl0HBTdYErlq2kxqIbaUCUsecM+Gzk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=NZ+6E3zExC4Kt7esUBdMUsrdNmWKRmxYLx+MZorDUxO7b3Epokf1H+L9iqW2Dudkjs9OheK5FSL6tE1nn/QuFx/45kAkLd3x7Ey9mpffhp2aZkBecYNpqJvG/jhIAhgN05l8bP1jjO0m+u2j/3Fnot6bb/G0zkKi5svLEWQl9d/gve8ZMYBDPITKuXRAyyXmj9gDzJwrzlBSZ+TDRF3xUD2kvQvbYxQlTAJ4Pu9zs0+NJQwvAxZV6D2TdMdcKE05tL9sdetLNnPThONw/cC5m+sZc3hTz4ED+pblhiCJjoD04T/JcXsVEFqGgRfaA7WGme8ty5GgYaPGKjQCPi+e2g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1607517461; bh=XKzWkTKBEAmTO5L8h0T3hjtr47AB/bFYVNLAU+aLiD6=;
 h=From:To:Subject:Date:From:Subject;
 b=XIf4FVq19MQwx54ZzEgMJWNqxo3yYhESUXf1RUEXStTMR/sy5wNRQk0eIEZkzv00v2ZbgxTkBe4P2d6LqInbIvR+MpaW4VLBVkeCxXrqpl7ot692gYg1oWa2K2UlnwxlpM4GkVw2WVmxYFcFXs8/mv9dPqEIewueYEqysrJZ0yR5San5MxZWsvQyxVAzsE2CHuhPEO/jVALzfvHFRNZzn/ikY6RNpUkBSpdl0eqYtuqKsm+5zCfFQo2H1WkoGjpNkBHiFovN7oEoyHOVmCg9/LxuwaXRDWA1WOXYofyJnjXL3J5ObrKCRRd8SgITzvchC3v4Ne5EmeAKhC/Jpvu/Jw==
X-YMail-OSG: 2sCnM_0VM1knb9kjFysOPyMofLTLsX1wARA2bPiAeazy7qtOBOcf51syYGg_Ewq
 OhlG9Pz67iRWtdN1UZdTpd32I4aCVk3ISsrOmFjXjx4tt2BMj6B3VY7IHVZQwTlXyZWPvcVMYE1f
 n1XKY7HAE3WBboXU8cdwAeT5M9ZSqErhLlHgRfmATE5uBCRS3BudnKGi_RSECSY6YjNMPyt_9RlM
 LvVq3znE9C.zoOdoPBWAD6b4vVYjaFKi6CKbD8uBfh1eG0uUn3cLdU5t9ac_o76VvUgJy7aluRkY
 USMydsipU28T6UGViPvXURtgfRGvIE_6aA5NcsD4pVaHpVsAsJfre16Tkq4NbI89UE7uNhYdIgwE
 _4UmOD1HBy_vHMOdawALS1fogJ81B8RRO8k.YKakfRKo.VV_Ri_4_pvWqWNGiK2fvrLxx5W4I9zf
 RkkgVA4OIEVncT0fFMugp.Ii5nt8iypoHQZiLjFeEaxnC8jBC02NTVsmhkhmO6Bwym7si4RtIg4_
 xpYdK4KJzctrNppqxy9z8GJ5nrGl1RWTEo4ovq_Zok3vRs4x6Qm4R.yUXpTK.lHZvxnOo.xxbH.a
 vfkgTyY3WwhGjOdlk.lXK4gdTM2lMG.YpkKbu52UC7FfoNJX2haoGu3g2ayTbOE_aKq_bY_KejpK
 vJaccjxR_UMyJ9yB1oIKk3HgJ.jwdWNMKOa0QKBCV1KtBTUCikC4x3FrfzXOVsCtFY_2H.8mT791
 6qgVpM5T.9UPJzCG27McL8RNAOldX9GkgWBfjujBjUsg_zFAsm2UPDOrHKSwrdgdo_cgyo1Pmao1
 12AFEjF2WJoGe_EKzoUa_Ke8DWoXMR5Qa23x5euoyzs0bKFFtHOPdd.jmWjgTAm0PwjNtXv6iGd2
 MRFduhuspBaecAsaOvmtD_De_PhgSXKHWd9Sm9O3LAgUalcQEUwy.RWSH_uYoqzwrN6XfM5.oM2G
 mmMctvQHkGqbUEPCyfv0fh87g8UoDwUcIQ.O1lPoM_agVZLrK53cCp3jGzkSl.FHxu2p1saXbawc
 RxBdJIlAEG0q8tM9L4r52rNK02yQsOM6BxoRHShY0gSpfiJCbUyetYfMbU4GAd0sf3HfUgEx_lDU
 N8qM9CXcWL2OL5wgBcqKL.G3xqRkpeOhyl721nNYyoN94CE1w2ru9ZdVo9I4lbg_rfyFDvMUYn4_
 GiS.8WpbqqwDCpUJcpczEl1d9yoHIU7LZFbwzENTTHH0DHGOmSZeuMg.khRzKyzT0MJjfWwluFsg
 F2ZBkrI21QAp_432vXmz5GFI8wHaYfS8W591HtABNB194YkanqHdKwzgHXVo8j23li..qgRv8h2t
 2t_SQQ.7XcSDn9LitI2nDqCSmzt6vxn95NfHXYS1n5NxU73PlZYJXZhj8zOtotM5CN7dqbcqBC.I
 hrYzFbFi_jy.3dZd_bfpw9W_mUZyZHPJ439kqphRm35TVsKbYvyfVUImAP_uS46DGh4oMMYRpt0Q
 8QjTqRu3TziClr0i3UsE9ydsZAu1nI8yvfNg.n9q6sd4oAP.x1xF7mXTUsY8vqx1b0GHeU_jsG5e
 jD_DMYhtiL6ePT554oPI91EEQZoSQDMsBXIICCrY_QR6M3I7qM0NHX5.XELiyLARq2Iid2okdPYr
 IVaIDjhr1.eSgY188rAXKR7L2BLd97KPkj95cWiafNDSkrRnJyisiWJHp89yBLD2AAv.XjVzN5I8
 REveVNkei_mFVDyvzVbBVeiJvzgCzWKZ_6NhxL5TyyUcaMD9t.BHmtckX.q6.b_sVDVOPzb49fXM
 T0STLfdME8WCLyyFH0Olf0CTcQgn5sU2pe9cgT_68rifX1SpXz9ybzisy9f0A2LJHyPx8boeOMfX
 DTvptION.I_4gNLljWq15pT8lYaC5txeA3Zyf5T04Ozq8uO8y0A3L5ZA7aK1abJ6dEvlrmSaVwVv
 9hN2zKTtYS37zZBV.fp0AZpG.T7Azz6FKEkvwPXkWi_fwy9pbBtF_KKvezHAlMfk6eFjr1cft73k
 UP15fn.aBnj7matc_4r6YRZVoXkOJg3331d69btz11ZWkR21gTExddGSUkMZFbD1wMej5rgsx6Qq
 WLwZfW4oWq4vKQbtsKjewlur_uKxxTFKrsKpII6CMzO4kYyeHXil5miZ3i3JLxag4KsD.sORwrBY
 C3lnYDbMzxWhxgAE9hxag37GW.TR5T3qhaxqIhZqpvAWluDE9Coy2H8OE1Nmf8PGC5GpspPT1kuS
 doW3kYfROhBtRyUlxC6CHgrmhDsuTDRrYVuWqw_unGTVGeF3yxG9J2JLs8r_MwdFWCGf4bXr4vvO
 4j8eWsnVkTzrEfn5qvWIDLHpMUQWqs2vRbT.G4bsY75LsIQET7obqtOfVz7BFCjxeBODHrDuHUVD
 HHx1iGZ3KlraYK5wiD0FHJJwo5CKCHbzuX6HuE4g.RP26H_bFa.6LGWlV1CZUpy.po7OndkDcPmC
 rWT0lqV1z.kqyW11icz_kKfYLdVbiEvty4IvedO_4HA2SwvvJntZTqUL8C46TgIAnnByTtsD1VHu
 WZHDOLDzCpKO42gAWHF7JadYGoi1lGVsHWJi3EPzj5pujyTIuNmB.GJIt9wJuzz758OZjBBA9gHT
 re0MB_DF85.TV9vSG
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.gq1.yahoo.com with HTTP; Wed, 9 Dec 2020 12:37:41 +0000
Received: by smtp404.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 9e0fb22ba0f0c86a14fe5482d52ef85e; 
 Wed, 09 Dec 2020 12:37:35 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] erofs: force inplace I/O under low memory scenario
Date: Wed,  9 Dec 2020 20:37:17 +0800
Message-Id: <20201209123717.12430-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201208054600.16302-1-hsiangkao@aol.com>
References: <20201208054600.16302-1-hsiangkao@aol.com>
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

Try to forcely switch to inplace I/O under low memory scenario in
order to avoid direct memory reclaim due to cached page allocation.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
v2:
 refine the gfp definition.

 fs/erofs/compress.h |  3 +++
 fs/erofs/zdata.c    | 48 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 4dadde18cdf1..aea129ddda74 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -28,11 +28,13 @@ struct z_erofs_decompress_req {
 
 /* some special page->private (unsigned long, see below) */
 #define Z_EROFS_SHORTLIVED_PAGE		(-1UL << 2)
+#define Z_EROFS_PREALLOCATED_PAGE	(-2UL << 2)
 
 /*
  * For all pages in a pcluster, page->private should be one of
  * Type                         Last 2bits      page->private
  * short-lived page             00              Z_EROFS_SHORTLIVED_PAGE
+ * preallocated page (tryalloc) 00              Z_EROFS_PREALLOCATED_PAGE
  * cached/managed page          00              pointer to z_erofs_pcluster
  * online page (file-backed,    01/10/11        sub-index << 2 | count
  *              some pages can be used for inplace I/O)
@@ -40,6 +42,7 @@ struct z_erofs_decompress_req {
  * page->mapping should be one of
  * Type                 page->mapping
  * short-lived page     NULL
+ * preallocated page    NULL
  * cached/managed page  non-NULL or NULL (invalidated/truncated page)
  * online page          non-NULL
  *
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 777790038bc9..6cb356c4217b 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -20,6 +20,11 @@
 enum z_erofs_cache_alloctype {
 	DONTALLOC,	/* don't allocate any cached pages */
 	DELAYEDALLOC,	/* delayed allocation (at the time of submitting io) */
+	/*
+	 * try to use cached I/O if page allocation succeeds or fallback
+	 * to in-place I/O instead to avoid any direct reclaim.
+	 */
+	TRYALLOC,
 };
 
 /*
@@ -154,13 +159,16 @@ static DEFINE_MUTEX(z_pagemap_global_lock);
 
 static void preload_compressed_pages(struct z_erofs_collector *clt,
 				     struct address_space *mc,
-				     enum z_erofs_cache_alloctype type)
+				     enum z_erofs_cache_alloctype type,
+				     struct list_head *pagepool)
 {
 	const struct z_erofs_pcluster *pcl = clt->pcl;
 	const unsigned int clusterpages = BIT(pcl->clusterbits);
 	struct page **pages = clt->compressedpages;
 	pgoff_t index = pcl->obj.index + (pages - pcl->compressed_pages);
 	bool standalone = true;
+	gfp_t gfp = (mapping_gfp_mask(mc) & ~__GFP_DIRECT_RECLAIM) |
+			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
 
 	if (clt->mode < COLLECT_PRIMARY_FOLLOWED)
 		return;
@@ -168,6 +176,7 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 	for (; pages < pcl->compressed_pages + clusterpages; ++pages) {
 		struct page *page;
 		compressed_page_t t;
+		struct page *newpage = NULL;
 
 		/* the compressed page was loaded before */
 		if (READ_ONCE(*pages))
@@ -179,7 +188,15 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 			t = tag_compressed_page_justfound(page);
 		} else if (type == DELAYEDALLOC) {
 			t = tagptr_init(compressed_page_t, PAGE_UNALLOCATED);
+		} else if (type == TRYALLOC) {
+			newpage = erofs_allocpage(pagepool, gfp);
+			if (!newpage)
+				goto dontalloc;
+
+			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
+			t = tag_compressed_page_justfound(newpage);
 		} else {	/* DONTALLOC */
+dontalloc:
 			if (standalone)
 				clt->compressedpages = pages;
 			standalone = false;
@@ -189,8 +206,12 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 		if (!cmpxchg_relaxed(pages, NULL, tagptr_cast_ptr(t)))
 			continue;
 
-		if (page)
+		if (page) {
 			put_page(page);
+		} else if (newpage) {
+			set_page_private(newpage, 0);
+			list_add(&newpage->lru, pagepool);
+		}
 	}
 
 	if (standalone)		/* downgrade to PRIMARY_FOLLOWED_NOINPLACE */
@@ -554,7 +575,7 @@ static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
 }
 
 static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
-				struct page *page)
+				struct page *page, struct list_head *pagepool)
 {
 	struct inode *const inode = fe->inode;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
@@ -607,11 +628,12 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 
 	/* preload all compressed pages (maybe downgrade role if necessary) */
 	if (should_alloc_managed_pages(fe, sbi->ctx.cache_strategy, map->m_la))
-		cache_strategy = DELAYEDALLOC;
+		cache_strategy = TRYALLOC;
 	else
 		cache_strategy = DONTALLOC;
 
-	preload_compressed_pages(clt, MNGD_MAPPING(sbi), cache_strategy);
+	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
+				 cache_strategy, pagepool);
 
 hitted:
 	/*
@@ -1005,6 +1027,16 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	justfound = tagptr_unfold_tags(t);
 	page = tagptr_unfold_ptr(t);
 
+	/*
+	 * preallocated cached pages, which is used to avoid direct reclaim
+	 * otherwise, it will go inplace I/O path instead.
+	 */
+	if (page->private == Z_EROFS_PREALLOCATED_PAGE) {
+		WRITE_ONCE(pcl->compressed_pages[nr], page);
+		set_page_private(page, 0);
+		tocache = true;
+		goto out_tocache;
+	}
 	mapping = READ_ONCE(page->mapping);
 
 	/*
@@ -1067,7 +1099,7 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 		cond_resched();
 		goto repeat;
 	}
-
+out_tocache:
 	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
 		/* turn into temporary page if fails (1 ref) */
 		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
@@ -1278,7 +1310,7 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 
 	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
 
-	err = z_erofs_do_read_page(&f, page);
+	err = z_erofs_do_read_page(&f, page, &pagepool);
 	(void)z_erofs_collector_end(&f.clt);
 
 	/* if some compressed cluster ready, need submit them anyway */
@@ -1332,7 +1364,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 		/* traversal in reverse order */
 		head = (void *)page_private(page);
 
-		err = z_erofs_do_read_page(&f, page);
+		err = z_erofs_do_read_page(&f, page, &pagepool);
 		if (err)
 			erofs_err(inode->i_sb,
 				  "readahead error at page %lu @ nid %llu",
-- 
2.24.0

