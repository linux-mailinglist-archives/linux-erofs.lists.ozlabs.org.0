Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC45574EE8
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Jul 2022 15:21:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LkFW74rQ7z3c3w
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Jul 2022 23:21:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.3; helo=out199-3.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-3.us.a.mail.aliyun.com (out199-3.us.a.mail.aliyun.com [47.90.199.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LkFW41SYqz3051
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Jul 2022 23:21:18 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJJkPG0_1657804862;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJJkPG0_1657804862)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 21:21:03 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 03/16] erofs: introduce `z_erofs_parse_out_bvecs()'
Date: Thu, 14 Jul 2022 21:20:38 +0800
Message-Id: <20220714132051.46012-4-hsiangkao@linux.alibaba.com>
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

`z_erofs_decompress_pcluster()' is too long therefore it'd be better
to introduce another helper to parse decompressed pages (or laterly,
decompressed bvecs.)

BTW, since `decompressed_bvecs' is too long as a part of the function
name, `out_bvecs' is used instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 81 +++++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 38 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index c7be447ac64d..c183cd0bc42b 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -778,18 +778,58 @@ static bool z_erofs_page_is_invalidated(struct page *page)
 	return !page->mapping && !z_erofs_is_shortlived_page(page);
 }
 
+static int z_erofs_parse_out_bvecs(struct z_erofs_pcluster *pcl,
+				   struct page **pages, struct page **pagepool)
+{
+	struct z_erofs_pagevec_ctor ctor;
+	enum z_erofs_page_type page_type;
+	int i, err = 0;
+
+	z_erofs_pagevec_ctor_init(&ctor, Z_EROFS_NR_INLINE_PAGEVECS,
+				  pcl->pagevec, 0);
+	for (i = 0; i < pcl->vcnt; ++i) {
+		struct page *page = z_erofs_pagevec_dequeue(&ctor, &page_type);
+		unsigned int pagenr;
+
+		/* all pages in pagevec ought to be valid */
+		DBG_BUGON(!page);
+		DBG_BUGON(z_erofs_page_is_invalidated(page));
+
+		if (z_erofs_put_shortlivedpage(pagepool, page))
+			continue;
+
+		if (page_type == Z_EROFS_VLE_PAGE_TYPE_HEAD)
+			pagenr = 0;
+		else
+			pagenr = z_erofs_onlinepage_index(page);
+
+		DBG_BUGON(pagenr >= pcl->nr_pages);
+		/*
+		 * currently EROFS doesn't support multiref(dedup),
+		 * so here erroring out one multiref page.
+		 */
+		if (pages[pagenr]) {
+			DBG_BUGON(1);
+			SetPageError(pages[pagenr]);
+			z_erofs_onlinepage_endio(pages[pagenr]);
+			err = -EFSCORRUPTED;
+		}
+		pages[pagenr] = page;
+	}
+	z_erofs_pagevec_ctor_exit(&ctor, true);
+	return err;
+}
+
 static int z_erofs_decompress_pcluster(struct super_block *sb,
 				       struct z_erofs_pcluster *pcl,
 				       struct page **pagepool)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
-	struct z_erofs_pagevec_ctor ctor;
 	unsigned int i, inputsize, outputsize, llen, nr_pages;
 	struct page *pages_onstack[Z_EROFS_VMAP_ONSTACK_PAGES];
 	struct page **pages, **compressed_pages, *page;
 
-	enum z_erofs_page_type page_type;
 	bool overlapped, partial;
 	int err;
 
@@ -823,42 +863,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 	for (i = 0; i < nr_pages; ++i)
 		pages[i] = NULL;
 
-	err = 0;
-	z_erofs_pagevec_ctor_init(&ctor, Z_EROFS_NR_INLINE_PAGEVECS,
-				  pcl->pagevec, 0);
-
-	for (i = 0; i < pcl->vcnt; ++i) {
-		unsigned int pagenr;
-
-		page = z_erofs_pagevec_dequeue(&ctor, &page_type);
-
-		/* all pages in pagevec ought to be valid */
-		DBG_BUGON(!page);
-		DBG_BUGON(z_erofs_page_is_invalidated(page));
-
-		if (z_erofs_put_shortlivedpage(pagepool, page))
-			continue;
-
-		if (page_type == Z_EROFS_VLE_PAGE_TYPE_HEAD)
-			pagenr = 0;
-		else
-			pagenr = z_erofs_onlinepage_index(page);
-
-		DBG_BUGON(pagenr >= nr_pages);
-
-		/*
-		 * currently EROFS doesn't support multiref(dedup),
-		 * so here erroring out one multiref page.
-		 */
-		if (pages[pagenr]) {
-			DBG_BUGON(1);
-			SetPageError(pages[pagenr]);
-			z_erofs_onlinepage_endio(pages[pagenr]);
-			err = -EFSCORRUPTED;
-		}
-		pages[pagenr] = page;
-	}
-	z_erofs_pagevec_ctor_exit(&ctor, true);
+	err = z_erofs_parse_out_bvecs(pcl, pages, pagepool);
 
 	overlapped = false;
 	compressed_pages = pcl->compressed_pages;
-- 
2.24.4

