Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8AD26D092
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Sep 2020 03:27:25 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BsK8B5Y3YzF1fb
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Sep 2020 11:27:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BsJyJ0MTDzF0f7
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Sep 2020 11:18:47 +1000 (AEST)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 823DA9CE25251F7AE734;
 Thu, 17 Sep 2020 09:18:40 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 09:18:31 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v2] erofs: remove unneeded parameter
Date: Thu, 17 Sep 2020 09:18:21 +0800
Message-ID: <20200917011821.22767-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

After commit 0615090c5044 ("erofs: convert compressed files from
readpages to readahead"), add_to_page_cache_lru() was moved to mm
code, so that in below call path, no page will be cached into
@pagepool list or grabbed from @pagepool list:
- z_erofs_readpage
 - z_erofs_do_read_page
  - preload_compressed_pages
  - erofs_allocpage

Let's get rid of this unneeded @pagepool parameter.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- improve commit message.
- use alloc_page() instead of erofs_allocpage() in
z_erofs_do_read_page() for cleanup.
 fs/erofs/zdata.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6c939def00f9..b0c977a0b66b 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -153,8 +153,7 @@ static DEFINE_MUTEX(z_pagemap_global_lock);
 
 static void preload_compressed_pages(struct z_erofs_collector *clt,
 				     struct address_space *mc,
-				     enum z_erofs_cache_alloctype type,
-				     struct list_head *pagepool)
+				     enum z_erofs_cache_alloctype type)
 {
 	const struct z_erofs_pcluster *pcl = clt->pcl;
 	const unsigned int clusterpages = BIT(pcl->clusterbits);
@@ -562,8 +561,7 @@ static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
 }
 
 static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
-				struct page *page,
-				struct list_head *pagepool)
+				struct page *page)
 {
 	struct inode *const inode = fe->inode;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
@@ -621,7 +619,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		cache_strategy = DONTALLOC;
 
 	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
-				 cache_strategy, pagepool);
+				 cache_strategy);
 
 hitted:
 	/*
@@ -653,7 +651,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	/* should allocate an additional staging page for pagevec */
 	if (err == -EAGAIN) {
 		struct page *const newpage =
-			erofs_allocpage(pagepool, GFP_NOFS | __GFP_NOFAIL);
+				alloc_page(GFP_NOFS | __GFP_NOFAIL);
 
 		newpage->mapping = Z_EROFS_MAPPING_STAGING;
 		err = z_erofs_attach_page(clt, newpage,
@@ -1282,7 +1280,7 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 
 	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
 
-	err = z_erofs_do_read_page(&f, page, &pagepool);
+	err = z_erofs_do_read_page(&f, page);
 	(void)z_erofs_collector_end(&f.clt);
 
 	/* if some compressed cluster ready, need submit them anyway */
@@ -1341,7 +1339,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 		/* traversal in reverse order */
 		head = (void *)page_private(page);
 
-		err = z_erofs_do_read_page(&f, page, &pagepool);
+		err = z_erofs_do_read_page(&f, page);
 		if (err)
 			erofs_err(inode->i_sb,
 				  "readahead error at page %lu @ nid %llu",
-- 
2.26.2

