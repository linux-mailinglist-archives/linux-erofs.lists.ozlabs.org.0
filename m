Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE8226C382
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Sep 2020 16:06:52 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bs22x3t1vzDqYV
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Sep 2020 00:06:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=PFqwM0gq; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bs22g3DHnzDqSC
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Sep 2020 00:06:35 +1000 (AEST)
Received: from localhost.localdomain (unknown [117.89.211.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7E0EE222EA;
 Wed, 16 Sep 2020 14:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600265192;
 bh=GwEG5JAQu1nqxOmIoloCzGY63Zh2Vov4E+GWDy/ADE4=;
 h=From:To:Cc:Subject:Date:From;
 b=PFqwM0gq4Zhl0SbDFWlzadJHoOohdmF9fx0z1xVZRP3rJ2uQVw+PWiOqn10w6r97H
 faV7ZlpUiJ5/kCEL39IjJTT4rh4t2U/MWlXSxYcnpDIScbQIJ9Q9owTVtFwVUK3gM0
 U9RAbQV3xXYr9rPPxU3gFj/HffhroLXHPouWqgMs=
From: Chao Yu <chao@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: remove unneeded parameter
Date: Wed, 16 Sep 2020 22:06:04 +0800
Message-Id: <20200916140604.3799-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Chao Yu <yuchao0@huawei.com>

In below call path, no page will be cached into @pagepool list
or grabbed from @pagepool list:
- z_erofs_readpage
 - z_erofs_do_read_page
  - preload_compressed_pages
  - erofs_allocpage

Let's get rid of this unneeded parameter.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/erofs/utils.c |  2 +-
 fs/erofs/zdata.c | 14 ++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index de9986d2f82f..7a6e5456b0b8 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -11,7 +11,7 @@ struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp)
 {
 	struct page *page;
 
-	if (!list_empty(pool)) {
+	if (pool && !list_empty(pool)) {
 		page = lru_to_page(pool);
 		DBG_BUGON(page_ref_count(page) != 1);
 		list_del(&page->lru);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6c939def00f9..f218f58f4159 100644
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
+			erofs_allocpage(NULL, GFP_NOFS | __GFP_NOFAIL);
 
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
2.22.0

