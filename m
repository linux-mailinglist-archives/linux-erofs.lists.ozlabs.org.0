Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC33165135
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 22:04:40 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48N9Fx2mdyzDqNp
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Feb 2020 08:04:37 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=lhfsuXTk; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48N9B11StzzDqBV
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Feb 2020 08:01:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=TC+iDjjJNO5NGm7wEewjDmH7JQd9SRV5n6oXnN+6v1w=; b=lhfsuXTkieskCpsv61dvIQWojz
 Zn2VtZ2+SeozWtVdMftMMJjqnpmd6xeyXr5LPtqJONSdWX+zybk10mVe8F2WcraRKkm+mxywm9e/J
 L88RMaLBdKnCHzgnc3ro/4sctl4ok3Z5Mm9YnNpaAweFH2wt60SlSYUneeGB9qwgf0FIBEWLr3+Oc
 kt8np8WlKJ3UIUaVAhWxcsITdvJ4tyZSbUENIPX74SjmM9ENZvqPZKVV6IrJ3XpDG8w2HRJrYRYsp
 QVNjESGMmJ/9RYKdmyax+9Ct4swRXcEWIPXL8z8708sCCnlibNsAEupCv+OtbbkXSmY5JYsdjYjih
 aUDAXg+A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4WSv-0008Ty-4z; Wed, 19 Feb 2020 21:01:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 12/24] mm: Add page_cache_readahead_unbounded
Date: Wed, 19 Feb 2020 13:00:51 -0800
Message-Id: <20200219210103.32400-13-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200219210103.32400-1-willy@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
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
 fs/ext4/verity.c        | 35 ++-------------------
 fs/f2fs/verity.c        | 35 ++-------------------
 include/linux/pagemap.h |  3 ++
 mm/readahead.c          | 70 ++++++++++++++++++++++++++++-------------
 4 files changed, 55 insertions(+), 88 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index dc5ec724d889..dec1244dd062 100644
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
+			page_cache_readahead_unbounded(inode->i_mapping, NULL,
+					index, num_ra_pages, 0);
 		page = read_mapping_page(inode->i_mapping, index, NULL);
 	}
 	return page;
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index d7d430a6f130..865c9fb774fb 100644
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
+			page_cache_readahead_unbounded(inode->i_mapping, NULL,
+					index, num_ra_pages, 0);
 		page = read_mapping_page(inode->i_mapping, index, NULL);
 	}
 	return page;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index b3008605fd1b..60f9b8d4da6c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -621,6 +621,9 @@ void page_cache_sync_readahead(struct address_space *, struct file_ra_state *,
 void page_cache_async_readahead(struct address_space *, struct file_ra_state *,
 		struct file *, struct page *, pgoff_t index,
 		unsigned long req_count);
+void page_cache_readahead_unbounded(struct address_space *, struct file *,
+		pgoff_t index, unsigned long nr_to_read,
+		unsigned long lookahead_count);
 
 /*
  * Like add_to_page_cache_locked, but used to add newly allocated pages:
diff --git a/mm/readahead.c b/mm/readahead.c
index ace611f4bf05..453ef146de83 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -155,40 +155,36 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages)
 	rac->_index++;
 }
 
-/*
- * __do_page_cache_readahead() actually reads a chunk of disk.  It allocates
- * the pages first, then submits them for I/O. This avoids the very bad
- * behaviour which would occur if page allocations are causing VM writeback.
- * We really don't want to intermingle reads and writes like that.
+/**
+ * page_cache_readahead_unbounded - Start unchecked readahead.
+ * @mapping: File address space.
+ * @file: This instance of the open file; used for authentication.
+ * @index: First page index to read.
+ * @nr_to_read: The number of pages to read.
+ * @lookahead_size: Where to start the next readahead.
+ *
+ * This function is for filesystems to call when they want to start
+ * readahead beyond a file's stated i_size.  This is almost certainly
+ * not the function you want to call.  Use page_cache_async_readahead()
+ * or page_cache_sync_readahead() instead.
+ *
+ * Context: File is referenced by caller.  Mutexes may be held by caller.
+ * May sleep, but will not reenter filesystem to reclaim memory.
  */
-void __do_page_cache_readahead(struct address_space *mapping,
-		struct file *filp, pgoff_t index, unsigned long nr_to_read,
+void page_cache_readahead_unbounded(struct address_space *mapping,
+		struct file *file, pgoff_t index, unsigned long nr_to_read,
 		unsigned long lookahead_size)
 {
-	struct inode *inode = mapping->host;
 	LIST_HEAD(page_pool);
-	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 	bool use_list = mapping->a_ops->readpages;
 	struct readahead_control rac = {
 		.mapping = mapping,
-		.file = filp,
+		.file = file,
 		._index = index,
 		._nr_pages = 0,
 	};
 	unsigned long i;
-	pgoff_t end_index;	/* The last page we want to read */
-
-	if (isize == 0)
-		return;
-
-	end_index = (isize - 1) >> PAGE_SHIFT;
-	if (index > end_index)
-		return;
-	if (index + nr_to_read < index)
-		nr_to_read = ULONG_MAX - index + 1;
-	if (index + nr_to_read >= end_index)
-		nr_to_read = end_index - index + 1;
 
 	/*
 	 * Preallocate as many pages as we will need.
@@ -232,6 +228,36 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	 */
 	read_pages(&rac, &page_pool);
 }
+EXPORT_SYMBOL_GPL(page_cache_readahead_unbounded);
+
+/*
+ * __do_page_cache_readahead() actually reads a chunk of disk.  It allocates
+ * the pages first, then submits them for I/O. This avoids the very bad
+ * behaviour which would occur if page allocations are causing VM writeback.
+ * We really don't want to intermingle reads and writes like that.
+ */
+void __do_page_cache_readahead(struct address_space *mapping,
+		struct file *file, pgoff_t index, unsigned long nr_to_read,
+		unsigned long lookahead_size)
+{
+	struct inode *inode = mapping->host;
+	loff_t isize = i_size_read(inode);
+	pgoff_t end_index;	/* The last page we want to read */
+
+	if (isize == 0)
+		return;
+
+	end_index = (isize - 1) >> PAGE_SHIFT;
+	if (index > end_index)
+		return;
+	if (index + nr_to_read < index)
+		nr_to_read = ULONG_MAX - index + 1;
+	if (index + nr_to_read >= end_index)
+		nr_to_read = end_index - index + 1;
+
+	page_cache_readahead_unbounded(mapping, file, index, nr_to_read,
+			lookahead_size);
+}
 
 /*
  * Chunk the readahead into 2 megabyte units, so that we don't pin too much
-- 
2.25.0

