Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 482F6161A76
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2020 19:47:59 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48LtK76hjMzDqRq
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2020 05:47:55 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=Y7W3hykN; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48LtHK2hhszDqgj
 for <linux-erofs@lists.ozlabs.org>; Tue, 18 Feb 2020 05:46:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=eXmGOwIH2jpYulUEG8Zc1CpZzmFCoe4ryYpWkEu7ztU=; b=Y7W3hykN9PWiGQMVy6Nf1Iq07d
 TX9lYS+aB4W/H6JX5GOUvRAO+zA72+02fKLSnf50aPbdXg8LzxxdxXjkmFWwCHMvxpZOT3tlzmJuB
 172pIKk4xlwuVUmRYtUHACAYK9Bh+xwcDRCeSLG64CvWp3090uIfidiMp3wyXCl9kdp2OOjGwpl92
 uyD8R1AKIdVtiFyhqmZIr5XtIGnC2sfSkEXAnFghbfjJWrSA9bi7mHKAo4LkpiOr8bKL2ngIFmsGv
 ljsfAJfGg8WbI3W14skTLYLZnQ9OWS8X/CkNZU7EnFJFlKh9jiTnJq0w21BYfWSNhEMKAUWUG1VfI
 uLiQX3mw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j3lPL-00058n-CQ; Mon, 17 Feb 2020 18:46:15 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 03/19] mm: Use readahead_control to pass arguments
Date: Mon, 17 Feb 2020 10:45:44 -0800
Message-Id: <20200217184613.19668-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217184613.19668-1-willy@infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
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

In this patch, only between __do_page_cache_readahead() and
read_pages(), but it will be extended in upcoming patches.  Also add
the readahead_count() accessor.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 17 +++++++++++++++++
 mm/readahead.c          | 36 +++++++++++++++++++++---------------
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ccb14b6a16b5..982ecda2d4a2 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -630,6 +630,23 @@ static inline int add_to_page_cache(struct page *page,
 	return error;
 }
 
+/*
+ * Readahead is of a block of consecutive pages.
+ */
+struct readahead_control {
+	struct file *file;
+	struct address_space *mapping;
+/* private: use the readahead_* accessors instead */
+	pgoff_t _start;
+	unsigned int _nr_pages;
+};
+
+/* The number of pages in this readahead block */
+static inline unsigned int readahead_count(struct readahead_control *rac)
+{
+	return rac->_nr_pages;
+}
+
 static inline unsigned long dir_pages(struct inode *inode)
 {
 	return (unsigned long)(inode->i_size + PAGE_SIZE - 1) >>
diff --git a/mm/readahead.c b/mm/readahead.c
index 12d13b7792da..15329309231f 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -113,26 +113,29 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
 
 EXPORT_SYMBOL(read_cache_pages);
 
-static void read_pages(struct address_space *mapping, struct file *filp,
-		struct list_head *pages, unsigned int nr_pages, gfp_t gfp)
+static void read_pages(struct readahead_control *rac, struct list_head *pages,
+		gfp_t gfp)
 {
+	const struct address_space_operations *aops = rac->mapping->a_ops;
 	struct blk_plug plug;
 	unsigned page_idx;
 
 	blk_start_plug(&plug);
 
-	if (mapping->a_ops->readpages) {
-		mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
+	if (aops->readpages) {
+		aops->readpages(rac->file, rac->mapping, pages,
+				readahead_count(rac));
 		/* Clean up the remaining pages */
 		put_pages_list(pages);
 		goto out;
 	}
 
-	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
+	for (page_idx = 0; page_idx < readahead_count(rac); page_idx++) {
 		struct page *page = lru_to_page(pages);
 		list_del(&page->lru);
-		if (!add_to_page_cache_lru(page, mapping, page->index, gfp))
-			mapping->a_ops->readpage(filp, page);
+		if (!add_to_page_cache_lru(page, rac->mapping, page->index,
+				gfp))
+			aops->readpage(rac->file, page);
 		put_page(page);
 	}
 
@@ -155,9 +158,13 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	int page_idx;
-	unsigned int nr_pages = 0;
 	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
+	struct readahead_control rac = {
+		.mapping = mapping,
+		.file = filp,
+		._nr_pages = 0,
+	};
 
 	if (isize == 0)
 		return;
@@ -180,10 +187,9 @@ void __do_page_cache_readahead(struct address_space *mapping,
 			 * contiguous pages before continuing with the next
 			 * batch.
 			 */
-			if (nr_pages)
-				read_pages(mapping, filp, &page_pool, nr_pages,
-						gfp_mask);
-			nr_pages = 0;
+			if (readahead_count(&rac))
+				read_pages(&rac, &page_pool, gfp_mask);
+			rac._nr_pages = 0;
 			continue;
 		}
 
@@ -194,7 +200,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		list_add(&page->lru, &page_pool);
 		if (page_idx == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
-		nr_pages++;
+		rac._nr_pages++;
 	}
 
 	/*
@@ -202,8 +208,8 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	 * uptodate then the caller will launch readpage again, and
 	 * will then handle the error.
 	 */
-	if (nr_pages)
-		read_pages(mapping, filp, &page_pool, nr_pages, gfp_mask);
+	if (readahead_count(&rac))
+		read_pages(&rac, &page_pool, gfp_mask);
 	BUG_ON(!list_empty(&page_pool));
 }
 
-- 
2.25.0

