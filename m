Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D96E15876C
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2020 02:04:44 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Gl134KshzDqCp
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2020 12:04:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=DHdtZGeV; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Gl0G72cBzDqBS
 for <linux-erofs@lists.ozlabs.org>; Tue, 11 Feb 2020 12:03:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=aRGXOYJKfqUnemNd2/EE+PIGxC7h8UcYZ50qWybxHys=; b=DHdtZGeV6dx9AasdzgsZ7AwumB
 y4YbUuEU4MMCmhdea8evj8EzmKtUcN1PIlxQwwzj3aN8cw0vNA33rnii1eZUADbN9wbPoa0k0y5eD
 UtUIQde61wWRHMGxe6LHa22mOd1OMmHBNEwy2cK/WhwliMvriibB32zqqR5775ETs4XMG+4GqJY1L
 CCVooOXShnHfaHkr5nHvPkpQ28zCC1M7X89h0rrpVpUFWB54NJVDYmcRI1OFzHeVNneSRwb3bzD3d
 KvzWnYWxHLM0F8RdiLUeD317FsBldabHSRJyWR/tjOYG3FadyGe6Edfh32NmJ4HswNBMc2eEdICCS
 m4N+go8g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j1Jxu-0001nx-Eg; Tue, 11 Feb 2020 01:03:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 05/13] mm: Add page_cache_readahead_limit
Date: Mon, 10 Feb 2020 17:03:40 -0800
Message-Id: <20200211010348.6872-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200211010348.6872-1-willy@infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

ext4 and f2fs have duplicated the guts of the readahead code so
they can read past i_size.  Instead, separate out the guts of the
readahead code so they can call it directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/verity.c        | 35 ++--------------------------
 fs/f2fs/verity.c        | 35 ++--------------------------
 include/linux/pagemap.h |  4 ++++
 mm/readahead.c          | 51 ++++++++++++++++++++++++-----------------
 4 files changed, 38 insertions(+), 87 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index dc5ec724d889..f6e0bf05933e 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -342,37 +342,6 @@ static int ext4_get_verity_descriptor(struct inode *inode, void *buf,
 	return desc_size;
 }
 
-/*
- * Prefetch some pages from the file's Merkle tree.
- *
- * This is basically a stripped-down version of __do_page_cache_readahead()
- * which works on pages past i_size.
- */
-static void ext4_merkle_tree_readahead(struct address_space *mapping,
-				       pgoff_t start_index, unsigned long count)
-{
-	LIST_HEAD(pages);
-	unsigned int nr_pages = 0;
-	struct page *page;
-	pgoff_t index;
-	struct blk_plug plug;
-
-	for (index = start_index; index < start_index + count; index++) {
-		page = xa_load(&mapping->i_pages, index);
-		if (!page || xa_is_value(page)) {
-			page = __page_cache_alloc(readahead_gfp_mask(mapping));
-			if (!page)
-				break;
-			page->index = index;
-			list_add(&page->lru, &pages);
-			nr_pages++;
-		}
-	}
-	blk_start_plug(&plug);
-	ext4_mpage_readpages(mapping, &pages, NULL, nr_pages, true);
-	blk_finish_plug(&plug);
-}
-
 static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
@@ -386,8 +355,8 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 		if (page)
 			put_page(page);
 		else if (num_ra_pages > 1)
-			ext4_merkle_tree_readahead(inode->i_mapping, index,
-						   num_ra_pages);
+			page_cache_readahead_limit(inode->i_mapping, NULL,
+					index, LONG_MAX, num_ra_pages, 0);
 		page = read_mapping_page(inode->i_mapping, index, NULL);
 	}
 	return page;
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index d7d430a6f130..71a3e36721fa 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -222,37 +222,6 @@ static int f2fs_get_verity_descriptor(struct inode *inode, void *buf,
 	return size;
 }
 
-/*
- * Prefetch some pages from the file's Merkle tree.
- *
- * This is basically a stripped-down version of __do_page_cache_readahead()
- * which works on pages past i_size.
- */
-static void f2fs_merkle_tree_readahead(struct address_space *mapping,
-				       pgoff_t start_index, unsigned long count)
-{
-	LIST_HEAD(pages);
-	unsigned int nr_pages = 0;
-	struct page *page;
-	pgoff_t index;
-	struct blk_plug plug;
-
-	for (index = start_index; index < start_index + count; index++) {
-		page = xa_load(&mapping->i_pages, index);
-		if (!page || xa_is_value(page)) {
-			page = __page_cache_alloc(readahead_gfp_mask(mapping));
-			if (!page)
-				break;
-			page->index = index;
-			list_add(&page->lru, &pages);
-			nr_pages++;
-		}
-	}
-	blk_start_plug(&plug);
-	f2fs_mpage_readpages(mapping, &pages, NULL, nr_pages, true);
-	blk_finish_plug(&plug);
-}
-
 static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
@@ -266,8 +235,8 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 		if (page)
 			put_page(page);
 		else if (num_ra_pages > 1)
-			f2fs_merkle_tree_readahead(inode->i_mapping, index,
-						   num_ra_pages);
+			page_cache_readahead_limit(inode->i_mapping, NULL,
+					index, LONG_MAX, num_ra_pages, 0);
 		page = read_mapping_page(inode->i_mapping, index, NULL);
 	}
 	return page;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 13efafaf7e1f..ddb2d1b43212 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -389,6 +389,10 @@ extern struct page * read_cache_page_gfp(struct address_space *mapping,
 				pgoff_t index, gfp_t gfp_mask);
 extern int read_cache_pages(struct address_space *mapping,
 		struct list_head *pages, filler_t *filler, void *data);
+unsigned long page_cache_readahead_limit(struct address_space *mapping,
+		struct file *file, pgoff_t start, pgoff_t end_index,
+		unsigned long nr_to_read, unsigned long lookahead_size);
+
 
 static inline struct page *read_mapping_page(struct address_space *mapping,
 				pgoff_t index, void *data)
diff --git a/mm/readahead.c b/mm/readahead.c
index 933b32e0c90a..29ca25c8f01e 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -144,38 +144,22 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages)
 	blk_finish_plug(&plug);
 }
 
-/*
- * __do_page_cache_readahead() actually reads a chunk of disk.  It allocates
- * the pages first, then submits them for I/O. This avoids the very bad
- * behaviour which would occur if page allocations are causing VM writeback.
- * We really don't want to intermingle reads and writes like that.
- *
- * Returns the number of pages requested, or the maximum amount of I/O allowed.
- */
-unsigned long __do_page_cache_readahead(struct address_space *mapping,
-		struct file *filp, pgoff_t start, unsigned long nr_to_read,
-		unsigned long lookahead_size)
+unsigned long page_cache_readahead_limit(struct address_space *mapping,
+		struct file *file, pgoff_t start, pgoff_t end_index,
+		unsigned long nr_to_read, unsigned long lookahead_size)
 {
-	struct inode *inode = mapping->host;
-	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	int page_idx;
 	pgoff_t page_offset = start;
-	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 	bool use_list = mapping->a_ops->readpages;
 	struct readahead_control rac = {
 		.mapping = mapping,
-		.file = filp,
+		.file = file,
 		.start = start,
 		.nr_pages = 0,
 	};
 
-	if (isize == 0)
-		goto out;
-
-	end_index = ((isize - 1) >> PAGE_SHIFT);
-
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
@@ -233,9 +217,34 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
 	 */
 	read_pages(&rac, &page_pool);
 	BUG_ON(!list_empty(&page_pool));
-out:
 	return rac.nr_pages;
 }
+EXPORT_SYMBOL_GPL(page_cache_readahead_limit);
+
+/*
+ * __do_page_cache_readahead() actually reads a chunk of disk.  It allocates
+ * the pages first, then submits them for I/O. This avoids the very bad
+ * behaviour which would occur if page allocations are causing VM writeback.
+ * We really don't want to intermingle reads and writes like that.
+ *
+ * Returns the number of pages requested, or the maximum amount of I/O allowed.
+ */
+unsigned long __do_page_cache_readahead(struct address_space *mapping,
+		struct file *file, pgoff_t start, unsigned long nr_to_read,
+		unsigned long lookahead_size)
+{
+	struct inode *inode = mapping->host;
+	unsigned long end_index;	/* The last page we want to read */
+	loff_t isize = i_size_read(inode);
+
+	if (isize == 0)
+		return 0;
+
+	end_index = ((isize - 1) >> PAGE_SHIFT);
+
+	return page_cache_readahead_limit(mapping, file, start, end_index,
+			nr_to_read, lookahead_size);
+}
 
 /*
  * Chunk the readahead into 2 megabyte units, so that we don't pin too much
-- 
2.25.0

