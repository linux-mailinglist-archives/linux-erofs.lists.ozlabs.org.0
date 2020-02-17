Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E64161A87
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2020 19:49:39 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48LtM45jsYzDqjH
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2020 05:49:36 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=ix32q8WH; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48LtHP00KlzDqXw
 for <linux-erofs@lists.ozlabs.org>; Tue, 18 Feb 2020 05:46:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=I1GrzS7L4wzPm7geM3wW86KX4FUImofIwAilu7nvV3Q=; b=ix32q8WHH8zPa3IuDx557J28f6
 6gwSJycMUBovtTizb1MRP43anmYzGy1Xd1AyU4NeWzMilT9NEaCl0iqWcei6nwERt2mucUBB1Mezy
 IGBKneWhAijkzMYxp7qnDy4un5Pu2WEHOtLncNgmSNDSvp0/DXmJWvuRuG0AOd5t4gdSrwEqXf3Y+
 t8EBVIzVDvF+oCmLNIqYbHO+v/+STZS3gGCoLRCbzIfaOZ6UmFt7M2Atb6UW5F2hUGsdV8UQyv/OQ
 AgJnGSDxjfrTvnIDWJoH611N5FCqmUzSgrGBIpPoHFi9dFsU51tYU1ev2x2x3hbh3fLnixuly4GAy
 dXE+N8zw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j3lPL-00058z-FT; Mon, 17 Feb 2020 18:46:15 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 05/16] mm: Put readahead pages in cache earlier
Date: Mon, 17 Feb 2020 10:45:47 -0800
Message-Id: <20200217184613.19668-7-willy@infradead.org>
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

At allocation time, put the pages in the cache unless we're using
->readpages.  Add the readahead_for_each() iterator for the benefit of
the ->readpage fallback.  This iterator supports huge pages, even though
none of the filesystems to be converted do yet.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 24 ++++++++++++++++++++++++
 mm/readahead.c          | 34 +++++++++++++++++-----------------
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 982ecda2d4a2..3613154e79e4 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -639,8 +639,32 @@ struct readahead_control {
 /* private: use the readahead_* accessors instead */
 	pgoff_t _start;
 	unsigned int _nr_pages;
+	unsigned int _batch_count;
 };
 
+static inline struct page *readahead_page(struct readahead_control *rac)
+{
+	struct page *page;
+
+	if (!rac->_nr_pages)
+		return NULL;
+
+	page = xa_load(&rac->mapping->i_pages, rac->_start);
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	rac->_batch_count = hpage_nr_pages(page);
+
+	return page;
+}
+
+static inline void readahead_next(struct readahead_control *rac)
+{
+	rac->_nr_pages -= rac->_batch_count;
+	rac->_start += rac->_batch_count;
+}
+
+#define readahead_for_each(rac, page)					\
+	for (; (page = readahead_page(rac)); readahead_next(rac))
+
 /* The number of pages in this readahead block */
 static inline unsigned int readahead_count(struct readahead_control *rac)
 {
diff --git a/mm/readahead.c b/mm/readahead.c
index 74791b96013f..7663de534734 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -113,12 +113,11 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
 
 EXPORT_SYMBOL(read_cache_pages);
 
-static void read_pages(struct readahead_control *rac, struct list_head *pages,
-		gfp_t gfp)
+static void read_pages(struct readahead_control *rac, struct list_head *pages)
 {
 	const struct address_space_operations *aops = rac->mapping->a_ops;
+	struct page *page;
 	struct blk_plug plug;
-	unsigned page_idx;
 
 	blk_start_plug(&plug);
 
@@ -127,19 +126,13 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 				readahead_count(rac));
 		/* Clean up the remaining pages */
 		put_pages_list(pages);
-		goto out;
-	}
-
-	for (page_idx = 0; page_idx < readahead_count(rac); page_idx++) {
-		struct page *page = lru_to_page(pages);
-		list_del(&page->lru);
-		if (!add_to_page_cache_lru(page, rac->mapping, page->index,
-				gfp))
+	} else {
+		readahead_for_each(rac, page) {
 			aops->readpage(rac->file, page);
-		put_page(page);
+			put_page(page);
+		}
 	}
 
-out:
 	blk_finish_plug(&plug);
 }
 
@@ -159,6 +152,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	int page_idx;
 	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
+	bool use_list = mapping->a_ops->readpages;
 	struct readahead_control rac = {
 		.mapping = mapping,
 		.file = filp,
@@ -196,8 +190,14 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		page = __page_cache_alloc(gfp_mask);
 		if (!page)
 			break;
-		page->index = offset;
-		list_add(&page->lru, &page_pool);
+		if (use_list) {
+			page->index = offset;
+			list_add(&page->lru, &page_pool);
+		} else if (add_to_page_cache_lru(page, mapping, offset,
+					gfp_mask) < 0) {
+			put_page(page);
+			goto read;
+		}
 		if (page_idx == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
 		rac._nr_pages++;
@@ -205,7 +205,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		continue;
 read:
 		if (readahead_count(&rac))
-			read_pages(&rac, &page_pool, gfp_mask);
+			read_pages(&rac, &page_pool);
 		rac._nr_pages = 0;
 		rac._start = ++offset;
 	}
@@ -216,7 +216,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	 * will then handle the error.
 	 */
 	if (readahead_count(&rac))
-		read_pages(&rac, &page_pool, gfp_mask);
+		read_pages(&rac, &page_pool);
 	BUG_ON(!list_empty(&page_pool));
 }
 
-- 
2.25.0

