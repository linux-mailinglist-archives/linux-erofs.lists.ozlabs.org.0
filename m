Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 282CC63E856
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Dec 2022 04:31:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NN1p70nc5z3bX4
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Dec 2022 14:31:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44; helo=out30-44.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NN1ny6Kycz2xrk
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Dec 2022 14:31:33 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=0;PH=DS;RN=2;SR=0;TI=SMTPD_---0VW5bxDI_1669865480;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VW5bxDI_1669865480)
          by smtp.aliyun-inc.com;
          Thu, 01 Dec 2022 11:31:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: clean up cached I/O strategies
Date: Thu,  1 Dec 2022 11:31:19 +0800
Message-Id: <20221201033119.101682-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

After commit 4c7e42552b3a ("erofs: remove useless cache strategy of
DELAYEDALLOC"), only one cached I/O allocation strategy is supported:

  When cached I/O is preferred, page allocation is applied without
  direct reclaim.  If allocation fails, fall back to inplace I/O.

Let's get rid of z_erofs_cache_alloctype.  No logical changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 65 +++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 40 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d6caf275be77..ab22100be861 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -175,16 +175,6 @@ static void z_erofs_free_pcluster(struct z_erofs_pcluster *pcl)
 	DBG_BUGON(1);
 }
 
-/* how to allocate cached pages for a pcluster */
-enum z_erofs_cache_alloctype {
-	DONTALLOC,	/* don't allocate any cached pages */
-	/*
-	 * try to use cached I/O if page allocation succeeds or fallback
-	 * to in-place I/O instead to avoid any direct reclaim.
-	 */
-	TRYALLOC,
-};
-
 /*
  * tagged pointer with 1-bit tag for all compressed pages
  * tag 0 - the page is just found with an extra page reference
@@ -292,12 +282,29 @@ struct z_erofs_decompress_frontend {
 	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
 	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .backmost = true }
 
+static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
+{
+	unsigned int cachestrategy = EROFS_I_SB(fe->inode)->opt.cache_strategy;
+
+	if (cachestrategy <= EROFS_ZIP_CACHE_DISABLED)
+		return false;
+
+	if (fe->backmost)
+		return true;
+
+	if (cachestrategy >= EROFS_ZIP_CACHE_READAROUND &&
+	    fe->map.m_la < fe->headoffset)
+		return true;
+
+	return false;
+}
+
 static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
-			       enum z_erofs_cache_alloctype type,
 			       struct page **pagepool)
 {
 	struct address_space *mc = MNGD_MAPPING(EROFS_I_SB(fe->inode));
 	struct z_erofs_pcluster *pcl = fe->pcl;
+	bool shouldalloc = z_erofs_should_alloc_cache(fe);
 	bool standalone = true;
 	/*
 	 * optimistic allocation without direct reclaim since inplace I/O
@@ -326,17 +333,18 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 		} else {
 			/* I/O is needed, no possible to decompress directly */
 			standalone = false;
-			switch (type) {
-			case TRYALLOC:
+			if (shouldalloc) {
+				/*
+				 * try to use cached I/O if page allocation
+				 * succeeds or fallback to in-place I/O instead
+				 * to avoid any direct reclaim.
+				 */
 				newpage = erofs_allocpage(pagepool, gfp);
 				if (!newpage)
 					continue;
 				set_page_private(newpage,
 						 Z_EROFS_PREALLOCATED_PAGE);
 				t = tag_compressed_page_justfound(newpage);
-				break;
-			default:        /* DONTALLOC */
-				continue;
 			}
 		}
 
@@ -637,20 +645,6 @@ static bool z_erofs_collector_end(struct z_erofs_decompress_frontend *fe)
 	return true;
 }
 
-static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
-				       unsigned int cachestrategy,
-				       erofs_off_t la)
-{
-	if (cachestrategy <= EROFS_ZIP_CACHE_DISABLED)
-		return false;
-
-	if (fe->backmost)
-		return true;
-
-	return cachestrategy >= EROFS_ZIP_CACHE_READAROUND &&
-		la < fe->headoffset;
-}
-
 static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
 				 struct page *page, unsigned int pageofs,
 				 unsigned int len)
@@ -687,12 +681,9 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 				struct page *page, struct page **pagepool)
 {
 	struct inode *const inode = fe->inode;
-	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct erofs_map_blocks *const map = &fe->map;
 	const loff_t offset = page_offset(page);
 	bool tight = true, exclusive;
-
-	enum z_erofs_cache_alloctype cache_strategy;
 	unsigned int cur, end, spiltted;
 	int err = 0;
 
@@ -746,13 +737,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 	} else {
 		/* bind cache first when cached decompression is preferred */
-		if (should_alloc_managed_pages(fe, sbi->opt.cache_strategy,
-					       map->m_la))
-			cache_strategy = TRYALLOC;
-		else
-			cache_strategy = DONTALLOC;
-
-		z_erofs_bind_cache(fe, cache_strategy, pagepool);
+		z_erofs_bind_cache(fe, pagepool);
 	}
 hitted:
 	/*
-- 
2.24.4

