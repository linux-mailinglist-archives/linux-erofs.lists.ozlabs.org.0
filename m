Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 644F2158774
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2020 02:05:44 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Gl2C6CB7zDqBy
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2020 12:05:39 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=TMd14DIO; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Gl0H2CRFzDqD0
 for <linux-erofs@lists.ozlabs.org>; Tue, 11 Feb 2020 12:03:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Cx0LUqifB1yYnmojEZZvvnccbKChns1lCEVtLd6hs7c=; b=TMd14DIOI5DcC8yQFFTMnysnlE
 RK0v7KxnkobGkPJh0WApA17G/VV3w1pA69bo0vVroQuDZcAw45nRVfzVbXcIn4htXW3+3fbpPr6IL
 V9Q1u0nW6I8yM6CUF8Td59CugBzCesebghNfnOlTgGRBVVX17KoGnpP1QEZcR3Sy7I18NBjg/OKFF
 WyxqulgXS7kuJQtxzj+TRx3mP74SPYFF2S2IgoGvUmXsh1edE50TXTb5BziYVRpg2jwQrOJUPRZfU
 X1LfECI6zU8m90sEKTSmDHqMVJfs8fVkTUfIIDMCoWWaqM4CaXLyhKutEB+QZuPG5fs81y9CNopyM
 BitRn2zw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j1Jxu-0001np-CU; Tue, 11 Feb 2020 01:03:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 03/13] mm: Put readahead pages in cache earlier
Date: Mon, 10 Feb 2020 17:03:38 -0800
Message-Id: <20200211010348.6872-4-willy@infradead.org>
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

At allocation time, put the pages in the cache unless we're using
->readpages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 66 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index fc77d13af556..96c6ca68a174 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -114,10 +114,10 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
 EXPORT_SYMBOL(read_cache_pages);
 
 static void read_pages(struct address_space *mapping, struct file *filp,
-		struct list_head *pages, unsigned int nr_pages, gfp_t gfp)
+		struct list_head *pages, pgoff_t start,
+		unsigned int nr_pages)
 {
 	struct blk_plug plug;
-	unsigned page_idx;
 
 	blk_start_plug(&plug);
 
@@ -125,18 +125,17 @@ static void read_pages(struct address_space *mapping, struct file *filp,
 		mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
 		/* Clean up the remaining pages */
 		put_pages_list(pages);
-		goto out;
-	}
+	} else {
+		struct page *page;
+		unsigned long index;
 
-	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
-		struct page *page = lru_to_page(pages);
-		list_del(&page->lru);
-		if (!add_to_page_cache_lru(page, mapping, page->index, gfp))
+		xa_for_each_range(&mapping->i_pages, index, page, start,
+				start + nr_pages - 1) {
 			mapping->a_ops->readpage(filp, page);
-		put_page(page);
+			put_page(page);
+		}
 	}
 
-out:
 	blk_finish_plug(&plug);
 }
 
@@ -149,17 +148,18 @@ static void read_pages(struct address_space *mapping, struct file *filp,
  * Returns the number of pages requested, or the maximum amount of I/O allowed.
  */
 unsigned long __do_page_cache_readahead(struct address_space *mapping,
-		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
+		struct file *filp, pgoff_t start, unsigned long nr_to_read,
 		unsigned long lookahead_size)
 {
 	struct inode *inode = mapping->host;
-	struct page *page;
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	int page_idx;
+	pgoff_t page_offset = start;
 	unsigned long nr_pages = 0;
 	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
+	bool use_list = mapping->a_ops->readpages;
 
 	if (isize == 0)
 		goto out;
@@ -170,7 +170,7 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
 	 * Preallocate as many pages as we will need.
 	 */
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
-		pgoff_t page_offset = offset + page_idx;
+		struct page *page;
 
 		if (page_offset > end_index)
 			break;
@@ -178,25 +178,43 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
 		page = xa_load(&mapping->i_pages, page_offset);
 		if (page && !xa_is_value(page)) {
 			/*
-			 * Page already present?  Kick off the current batch of
-			 * contiguous pages before continuing with the next
-			 * batch.
+			 * Page already present?  Kick off the current batch
+			 * of contiguous pages before continuing with the
+			 * next batch.
+			 * It's possible this page is the page we should
+			 * be marking with PageReadahead.  However, we
+			 * don't have a stable ref to this page so it might
+			 * be reallocated to another user before we can set
+			 * the bit.  There's probably another page in the
+			 * cache marked with PageReadahead from the other
+			 * process which accessed this file.
 			 */
-			if (nr_pages)
-				read_pages(mapping, filp, &page_pool, nr_pages,
-						gfp_mask);
-			nr_pages = 0;
-			continue;
+			goto skip;
 		}
 
 		page = __page_cache_alloc(gfp_mask);
 		if (!page)
 			break;
-		page->index = page_offset;
-		list_add(&page->lru, &page_pool);
+		if (use_list) {
+			page->index = page_offset;
+			list_add(&page->lru, &page_pool);
+		} else if (add_to_page_cache_lru(page, mapping, page_offset,
+					gfp_mask) < 0) {
+			put_page(page);
+			goto skip;
+		}
+
 		if (page_idx == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
 		nr_pages++;
+		page_offset++;
+		continue;
+skip:
+		if (nr_pages)
+			read_pages(mapping, filp, &page_pool, start, nr_pages);
+		nr_pages = 0;
+		page_offset++;
+		start = page_offset;
 	}
 
 	/*
@@ -205,7 +223,7 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
 	 * will then handle the error.
 	 */
 	if (nr_pages)
-		read_pages(mapping, filp, &page_pool, nr_pages, gfp_mask);
+		read_pages(mapping, filp, &page_pool, start, nr_pages);
 	BUG_ON(!list_empty(&page_pool));
 out:
 	return nr_pages;
-- 
2.25.0

