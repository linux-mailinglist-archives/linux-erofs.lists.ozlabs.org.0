Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0ED2D234A
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 06:46:45 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cqq1Z04jqzDqXY
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 16:46:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607406402;
	bh=EpzbkYUNw++THGNHOISPaqWdN3XoiNhIMbHbGkT3kCg=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=PDCruOvKG5oDW7Ntmt99K598xIW6VIDkg30YiEYN10klRI4G1kQp+hPQC+o5V2KuW
	 hijE3iR5gVQrzYFRSnNFoiref4jhx2NZLC0Es+x2v5EWDrkBMUdw2KjtIb7EyV4u2B
	 xpgNsLvVCPI0Do9F6mEK6VHe4lgK2osmIKLU0Mt66TRPf9GHP4TUG+jTUqCAhoeTwQ
	 ezQvDkImNN7ads0HLpwNU50ChPiSFKjqzYSXiorZnsXBKLGUhEjn0TWUY4xpf1uKaB
	 zOE9kQhf/bm17FVp5iG2uiUqrMDuYbDzSC7an9t4WklGDV9x0a9gEOZFDs3JE0N3N/
	 4BXOwyxWPODUw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.84; helo=sonic313-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=WJ/bBRyV; dkim-atps=neutral
Received: from sonic313-21.consmr.mail.gq1.yahoo.com
 (sonic313-21.consmr.mail.gq1.yahoo.com [98.137.65.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cqq1R5W4YzDqWp
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 16:46:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1607406387; bh=7toQZcx2h92+S38+gJdGyvWo31V3J+GK8A0SIDJiVS8=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=WJ/bBRyV49RxLxSF1x/m1EinBtqif4Vb6mETJ8m25alTZtiQFjWkEHHtL6WAbaZ/uhm651G0V+gR+PQAUSBkvzmqctUq3GQ8ULH1/n2n/SrfSBLr0j9npDoJWzvGIfaLpOS+AScAMoSkvmL6dnw4Zxj9QYDULwbLnoVjyefYFYzyW017aCeuv1wUUOyNMVw8YBsgQi4HuEf6Fgar4YDfckDCSzsf744FTfr/0PKlqLSzmWimK8vPACcIvSHq2LFU8P25VkDGDEKAyHCuXeueDbcW6SzpuUuGVq4e0xvFKKnPcqzHsN3976pGJ7zH7YCThlbvdPIWNSyIIdLqdE7VeQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1607406387; bh=vOQ5cgi4uLAxGN/EMx7m5C1Fv/lieVJJbjeuYTfqmb9=;
 h=From:To:Subject:Date:From:Subject;
 b=tnYXx4SiV3FagTbpBey/3TuP1IIh3q0VB6tsTgl6bs8DwlmjkxvsCZsZDAvQJagoAfS6ljEvCJnEMG0ctAy9UPOXvoc/+UmAAzgPtFX0gImLLjL/eKeylDF5Kly9cYkhNo9HQ4ELRl7nG5PG+kaIq0t5Glep7rA9Ee4ccgnFgWT2f0Cimgl08izKtQPvPC8BJpl2Zr1hwJ4gNMUbd+wYwk3USJWISIecisaxlFDe+aum0zufRUWUcghBXxHytQ8ExjvFEmMvCp+8Cx4hunfB6gwYYUBHyjmYi2vDCnmsRHyDJp5pqRJ2rBmwkz9H7ZJ87A5A/1sJKlYttT35+u5Z0Q==
X-YMail-OSG: zDqtWYYVM1kNwbQ7yFt51z0o7KV2_Fze26bd3Q3oDw75Hrz12Pfv7yH4cOPdGwY
 noyFImStvCU2BhOOgZOlSoZL7QoGEiqMHtgcynBjhAUwTtN1NpTm0SbeWCWg6XNvIDVdOS_VXJto
 FyALSsoPUYCJtVokaRVjhD92fpJPcSRF9wpgmIPuYoZCSoZ4.TCp52uKafpfQyOWKueUH4eWGwBC
 G5WzRKll.uDnJsMn3noNSCinELQg7mLKKyQs.LnARzW3nFF2fncHpLUmgdGwSBmvWkV8ekShrt2j
 tiXulHGXo93syHlTRgipKeN5wqyLXkSsZaK4elSABiKf6M4PVxT_xOA6KmuHxF36qzTVyHxn6R0Q
 MaLArBVVPbqFgJUX8Ssl.x4aBnnQ7ktfv.FuMYzxx1BGDHw95Hn0_yPUWdAEnS3Nvun3VFdsSzAX
 CbDSmDT_IPn28tUAiivsmcMp2PGxmOKpugZkUGNEhnD4DvSEpJEYRc2iJVljaz6M39Lm8Kh_s17f
 GyKKXxQWgW88Z1DF0sMxCT5Gvxl8am5aDTBdjlI1f9ZcPfDJ4H7DC0a.kYLargOdpdYnuBh4VkjL
 EIh7vsO3HAWZLXtAnQ9CqLstRKM1GO5iFpMB7kWGpMk0D8tL8Ddk5tONYacFIg9YKvP46iHzj4WE
 vsVOOBdwweSQxssm8PetD_YLqKN9WPOK8wFXhVDPn1CZU5TpVD5YVw6cNV..2ZIiezj6c3T1x7B_
 cKzqVZ3e5aiDUJnDPEgpzbT39puaKpDtILrvZZsJcLXCB6IiLc1kJrO.W6UDrzH6TA2yybIXzeWR
 zVhdK8iLtk.ooI9J8mCoBqQ9SstRksgUP02Gyg_pP4W53D5bweeVAVK88QaS3Mln47jo1zZ7kezJ
 HWT4AfI1BDF08WXGRoiqkib1AvDD1XV9Iwpa1dyx.vcUItD570wpRRGfueamo5pYVES4J5GnsSPj
 xVfuIz19QvUc_aD5FxXwl1X.mG4yw27HgypT7S.NIK2rWJtNC2nkCTzfcnapQin2S7duwlEjnmUG
 oInf1OaOsSmuuaCZzk1yDgtNqn7E.vvo5g9wGHm0PThVAcnyaBhZg4el9nxcHaBRPpbj7myXHB02
 UTVVFfu3co9MAZowrGjdLapV7SJqVQI1ybrH84Xr7BtOkYll4BDIYgrJx5CphmBVnMxrV7PBUr9L
 aH3CJV2L8lguFUbMbX2L3oBDDgxVGJ4S0kFxJyUw68AJJFyWCT7UuOPmH_.S67N4.Tbi1Wyt5Ii0
 UEVC7HN8DbaBcexJSlRXnjPOlCEzdqSkl7N6cJO6m95RI4a6Yom8YgOLAmxjgBwOlEViV4rCFyY2
 mJqWQ5nkvCw4augQOjP0Z4syGTaQu31wzvSYVkLbamLgDjneptEi8NfOT3ajkLAkq0qMgSvmlel_
 ySDRZZYn7hzUPt1wozgRUogqvuGDPfA4SwfLvlReJfRa8T2XJah35NT8dTrBF.q_ojV4neNs2mEI
 X20gPHIX.1_7sMfQxxsGHuRHqIXyL79Xh0E5r4SfjZA46Lp4fXmYjZsfDYcFW8nsvWvR8RxCjY6s
 6pd2HNA3lRBHxJHMsMgR9aTipF6.1jjsynALCCyMy1npBQyl.hhhhXVW4lpNuhVWce.y6cgnMcwF
 QARY3OTCo220ArnaDH6qJ5OMhdV9B2.Z0MYueDgLBFktNjlpnTK6U9IhXUt1kq4nXI1izK0v3a8f
 kovDcWbThcd57GyshIEdi_hvsQeEOANksRoN05m.sMejA0LvUg9VGcp9I0SKC5VqsmYyCq4CZpNQ
 O2jYd0N9DUn90RafIrnv3411lrOfJNIAZqWg2TZX1dW7rECHEBjETPFvMGODd4eGOMo7BbdJrkF4
 LIevSS9RMUEKijvSPfXOtVFZc8hHO6A1lA6wR7mQ2c.wH3Sdd4.pwLpv3k8np7v9V85Uf63B5Kbf
 e6_HazqEvi8oOoJ9kgdQM_zU0XnkHxetkcQ4zH4toBd_yzNduI741CvA5BuefzZ9nxlmNzH5CJ3f
 Igm2G3PWnLr8.CgbKwBfEEs0ZPinpmOD4gl2HhEzgUEZLFWqkJfSrrWHwS_jO_aLV8Qy9QWX_KvI
 rUQro4uCi_sse5_SFETa_miUKtlCHmT6IMgD1PdBJ8h7SVumIPMu_nj27naaI3AHJma80vNqALZT
 3V.8yPxz1a_t9NDY1oHY7SBulhVCMAZ4SnDSuthdrLLBopoEO03gG3LkLRygVSqnPhlmoDuIypP1
 dM3d0RUZPQFULE.cTRocxCOdVjOtg.9XoHgoxilv7fGO.Uv4VuwF3yfReNr5iD.Fv.rqExuWtBwq
 pWIZJzWUUMg6234hlGwC4S5thcrvKjuk3h.khRD0AvrlHhOC1pvgseU4XT4zV5.S_lpmvnMC7Z1O
 pFrCSOilQCq3ecrLyNyCh28usqatQp7XYlhCRY5f5D427gwsWukgZz71JC32t4Ak8eDqgjKAMt1X
 G7h3P7nwh8ChhohGrMTYxHyzTVU6ig367OmA1cPFLExnqNPN7sQjOw5Dua3QwPqJMim1XGH7dqdV
 a8UrNmYiUFGmiBgzJ1w9h_sbM41S00lVF.tnofo3qT1UZA0jsVBHU4PSt8CiLZ7BV1igLlQ3UDh0
 IHYH7mPNOwmDGXJAAiWK.kQ.jH8aciiawueT55yjI_Jfg1qCrWC4rzN7iOeUXQw--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 8 Dec 2020 05:46:27 +0000
Received: by smtp406.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID dcc06fca14db8c8945aa97b3b0ce8706; 
 Tue, 08 Dec 2020 05:46:23 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] erofs: force inplace I/O under low memory scenario
Date: Tue,  8 Dec 2020 13:46:00 +0800
Message-Id: <20201208054600.16302-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201208054600.16302-1-hsiangkao.ref@aol.com>
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

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
This was commercially used internally for years, but due to customized
page->mapping before, it cannot cleanly upstream till now. Since magical
page->mapping is now gone, adapt this to the latest dev branch for
better low-memory performance (fully use inplace I/O instead.)

 fs/erofs/compress.h |  3 +++
 fs/erofs/zdata.c    | 49 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 2bbf47f353ef..c51a741a1232 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -27,11 +27,13 @@ struct z_erofs_decompress_req {
 };
 
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
@@ -39,6 +41,7 @@ struct z_erofs_decompress_req {
  * page->mapping should be one of
  * Type                 page->mapping
  * short-lived page     NULL
+ * preallocated page    NULL
  * cached/managed page  non-NULL or NULL (invalidated/truncated page)
  * online page          non-NULL
  *
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index b1b6cd03046f..b84e6a2fb00c 100644
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
@@ -154,13 +159,15 @@ static DEFINE_MUTEX(z_pagemap_global_lock);
 
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
+	gfp_t gfp = mapping_gfp_constraint(mc, GFP_KERNEL) & ~__GFP_DIRECT_RECLAIM;
 
 	if (clt->mode < COLLECT_PRIMARY_FOLLOWED)
 		return;
@@ -168,6 +175,7 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 	for (; pages < pcl->compressed_pages + clusterpages; ++pages) {
 		struct page *page;
 		compressed_page_t t;
+		struct page *newpage = NULL;
 
 		/* the compressed page was loaded before */
 		if (READ_ONCE(*pages))
@@ -179,7 +187,17 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 			t = tag_compressed_page_justfound(page);
 		} else if (type == DELAYEDALLOC) {
 			t = tagptr_init(compressed_page_t, PAGE_UNALLOCATED);
+		} else if (type == TRYALLOC) {
+			gfp |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
+
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
@@ -189,8 +207,12 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
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
@@ -560,7 +582,7 @@ static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
 }
 
 static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
-				struct page *page)
+				struct page *page, struct list_head *pagepool)
 {
 	struct inode *const inode = fe->inode;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
@@ -613,11 +635,12 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 
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
@@ -1011,6 +1034,16 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
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
@@ -1073,7 +1106,7 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 		cond_resched();
 		goto repeat;
 	}
-
+out_tocache:
 	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
 		/* turn into temporary page if fails */
 		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
@@ -1282,7 +1315,7 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 
 	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
 
-	err = z_erofs_do_read_page(&f, page);
+	err = z_erofs_do_read_page(&f, page, &pagepool);
 	(void)z_erofs_collector_end(&f.clt);
 
 	/* if some compressed cluster ready, need submit them anyway */
@@ -1336,7 +1369,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 		/* traversal in reverse order */
 		head = (void *)page_private(page);
 
-		err = z_erofs_do_read_page(&f, page);
+		err = z_erofs_do_read_page(&f, page, &pagepool);
 		if (err)
 			erofs_err(inode->i_sb,
 				  "readahead error at page %lu @ nid %llu",
-- 
2.24.0

