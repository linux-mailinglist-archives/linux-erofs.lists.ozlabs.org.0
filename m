Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC25F16F241
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2020 22:53:13 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Rt3B6s92zDqMb
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Feb 2020 08:53:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Rsy66SLnzDqJm
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Feb 2020 08:48:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=QEF4geXX4TFT2W7bpOVZx9/sdYLQlUVMxsVXgZT1wcA=; b=G9qXOYjCJZO/mVwnWreNtEz/PH
 so7mOirRhiBVhmhjkhXbuyG1/CijpDg4CGySHaQjv8k/pURdFPc+6x0mBcsah6XL49/FokeE02ynA
 4UVYdQVV80AzZREGJFFQbwc/u8b8iJti0f6yeg2aRRgjOJIfowFpYCljZriHgR8++XMiJ3hmYxEW8
 kEvLEnkW3A/isQ9KdRaWiA/bwdeZEXVdg1TwLb6/XnVjE11VbXX7oTQZan27NFDKiMyNlCdfZw/fs
 oLSaerdEflcsZRfhzVMS/9hGsEL/TgBtBVwG2K+f+4om3kIot/mpbIT07n6nqDdlkYH9R4B3/8u18
 /V6jPEVg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j6i4H-0007pb-3q; Tue, 25 Feb 2020 21:48:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v8 06/25] mm: Use readahead_control to pass arguments
Date: Tue, 25 Feb 2020 13:48:19 -0800
Message-Id: <20200225214838.30017-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200225214838.30017-1-willy@infradead.org>
References: <20200225214838.30017-1-willy@infradead.org>
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
Cc: linux-xfs@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

In this patch, only between __do_page_cache_readahead() and read_pages(),
but it will be extended in upcoming patches.  The read_pages() function
becomes aops centric, as this makes the most sense by the end of the
patchset.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/readahead.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 9fcd4e32b62d..9d9aa4ffc7d4 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -113,29 +113,32 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
 
 EXPORT_SYMBOL(read_cache_pages);
 
-static void read_pages(struct address_space *mapping, struct file *filp,
-		struct list_head *pages, unsigned int nr_pages, gfp_t gfp)
+static void read_pages(struct readahead_control *rac, struct list_head *pages,
+		gfp_t gfp)
 {
+	const struct address_space_operations *aops = rac->mapping->a_ops;
 	struct blk_plug plug;
 	unsigned page_idx;
 
-	if (!nr_pages)
+	if (!readahead_count(rac))
 		return;
 
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
 
@@ -143,6 +146,7 @@ static void read_pages(struct address_space *mapping, struct file *filp,
 	blk_finish_plug(&plug);
 
 	BUG_ON(!list_empty(pages));
+	rac->_nr_pages = 0;
 }
 
 /*
@@ -160,9 +164,12 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	int page_idx;
-	unsigned int nr_pages = 0;
 	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
+	struct readahead_control rac = {
+		.mapping = mapping,
+		.file = filp,
+	};
 
 	if (isize == 0)
 		return;
@@ -185,9 +192,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 			 * contiguous pages before continuing with the next
 			 * batch.
 			 */
-			read_pages(mapping, filp, &page_pool, nr_pages,
-						gfp_mask);
-			nr_pages = 0;
+			read_pages(&rac, &page_pool, gfp_mask);
 			continue;
 		}
 
@@ -198,7 +203,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		list_add(&page->lru, &page_pool);
 		if (page_idx == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
-		nr_pages++;
+		rac._nr_pages++;
 	}
 
 	/*
@@ -206,7 +211,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	 * uptodate then the caller will launch readpage again, and
 	 * will then handle the error.
 	 */
-	read_pages(mapping, filp, &page_pool, nr_pages, gfp_mask);
+	read_pages(&rac, &page_pool, gfp_mask);
 }
 
 /*
-- 
2.25.0

