Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EAD576499
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 17:42:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lkwbj4J9zz3c7L
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Jul 2022 01:42:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45; helo=out30-45.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LkwbS5Lvvz3c6J
	for <linux-erofs@lists.ozlabs.org>; Sat, 16 Jul 2022 01:42:28 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJPnC4R_1657899738;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJPnC4R_1657899738)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 23:42:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 06/16] erofs: introduce `z_erofs_parse_in_bvecs'
Date: Fri, 15 Jul 2022 23:41:53 +0800
Message-Id: <20220715154203.48093-7-hsiangkao@linux.alibaba.com>
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

`z_erofs_decompress_pcluster()' is too long therefore it'd be better
to introduce another helper to parse compressed pages (or laterly,
compressed bvecs.)

BTW, since `compressed_bvecs' is too long as a part of the function
name, `in_bvecs' is used here instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 132 ++++++++++++++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 52 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6295f3312f6f..423d4daf7ed9 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -913,6 +913,76 @@ static int z_erofs_parse_out_bvecs(struct z_erofs_pcluster *pcl,
 	return err;
 }
 
+static struct page **z_erofs_parse_in_bvecs(struct erofs_sb_info *sbi,
+			struct z_erofs_pcluster *pcl, struct page **pages,
+			struct page **pagepool, bool *overlapped)
+{
+	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
+	struct page **compressed_pages;
+	int i, err = 0;
+
+	/* XXX: will have a better approach in the following commits */
+	compressed_pages = kmalloc_array(pclusterpages, sizeof(struct page *),
+					 GFP_KERNEL | __GFP_NOFAIL);
+	*overlapped = false;
+
+	for (i = 0; i < pclusterpages; ++i) {
+		unsigned int pagenr;
+		struct page *page = pcl->compressed_pages[i];
+
+		/* compressed pages ought to be present before decompressing */
+		if (!page) {
+			DBG_BUGON(1);
+			continue;
+		}
+		compressed_pages[i] = page;
+
+		if (z_erofs_is_inline_pcluster(pcl)) {
+			if (!PageUptodate(page))
+				err = -EIO;
+			continue;
+		}
+
+		DBG_BUGON(z_erofs_page_is_invalidated(page));
+		if (!z_erofs_is_shortlived_page(page)) {
+			if (erofs_page_is_managed(sbi, page)) {
+				if (!PageUptodate(page))
+					err = -EIO;
+				continue;
+			}
+
+			/*
+			 * only if non-head page can be selected
+			 * for inplace decompression
+			 */
+			pagenr = z_erofs_onlinepage_index(page);
+
+			DBG_BUGON(pagenr >= pcl->nr_pages);
+			if (pages[pagenr]) {
+				DBG_BUGON(1);
+				SetPageError(pages[pagenr]);
+				z_erofs_onlinepage_endio(pages[pagenr]);
+				err = -EFSCORRUPTED;
+			}
+			pages[pagenr] = page;
+
+			*overlapped = true;
+		}
+
+		/* PG_error needs checking for all non-managed pages */
+		if (PageError(page)) {
+			DBG_BUGON(PageUptodate(page));
+			err = -EIO;
+		}
+	}
+
+	if (err) {
+		kfree(compressed_pages);
+		return ERR_PTR(err);
+	}
+	return compressed_pages;
+}
+
 static int z_erofs_decompress_pcluster(struct super_block *sb,
 				       struct z_erofs_pcluster *pcl,
 				       struct page **pagepool)
@@ -957,54 +1027,11 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		pages[i] = NULL;
 
 	err = z_erofs_parse_out_bvecs(pcl, pages, pagepool);
-
-	overlapped = false;
-	compressed_pages = pcl->compressed_pages;
-
-	for (i = 0; i < pclusterpages; ++i) {
-		unsigned int pagenr;
-
-		page = compressed_pages[i];
-		/* all compressed pages ought to be valid */
-		DBG_BUGON(!page);
-
-		if (z_erofs_is_inline_pcluster(pcl)) {
-			if (!PageUptodate(page))
-				err = -EIO;
-			continue;
-		}
-
-		DBG_BUGON(z_erofs_page_is_invalidated(page));
-		if (!z_erofs_is_shortlived_page(page)) {
-			if (erofs_page_is_managed(sbi, page)) {
-				if (!PageUptodate(page))
-					err = -EIO;
-				continue;
-			}
-
-			/*
-			 * only if non-head page can be selected
-			 * for inplace decompression
-			 */
-			pagenr = z_erofs_onlinepage_index(page);
-
-			DBG_BUGON(pagenr >= nr_pages);
-			if (pages[pagenr]) {
-				DBG_BUGON(1);
-				SetPageError(pages[pagenr]);
-				z_erofs_onlinepage_endio(pages[pagenr]);
-				err = -EFSCORRUPTED;
-			}
-			pages[pagenr] = page;
-
-			overlapped = true;
-		}
-
-		/* PG_error needs checking for all non-managed pages */
-		if (PageError(page)) {
-			DBG_BUGON(PageUptodate(page));
-			err = -EIO;
-		}
+	compressed_pages = z_erofs_parse_in_bvecs(sbi, pcl, pages,
+						pagepool, &overlapped);
+	if (IS_ERR(compressed_pages)) {
+		err = PTR_ERR(compressed_pages);
+		compressed_pages = NULL;
 	}
 
 	if (err)
@@ -1040,21 +1067,22 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 out:
 	/* must handle all compressed pages before actual file pages */
 	if (z_erofs_is_inline_pcluster(pcl)) {
-		page = compressed_pages[0];
-		WRITE_ONCE(compressed_pages[0], NULL);
+		page = pcl->compressed_pages[0];
+		WRITE_ONCE(pcl->compressed_pages[0], NULL);
 		put_page(page);
 	} else {
 		for (i = 0; i < pclusterpages; ++i) {
-			page = compressed_pages[i];
+			page = pcl->compressed_pages[i];
 
 			if (erofs_page_is_managed(sbi, page))
 				continue;
 
 			/* recycle all individual short-lived pages */
 			(void)z_erofs_put_shortlivedpage(pagepool, page);
-			WRITE_ONCE(compressed_pages[i], NULL);
+			WRITE_ONCE(pcl->compressed_pages[i], NULL);
 		}
 	}
+	kfree(compressed_pages);
 
 	for (i = 0; i < nr_pages; ++i) {
 		page = pages[i];
-- 
2.24.4

