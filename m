Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E65EF1A8251
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2020 17:22:44 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 491q422rBkzDqLl
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2020 01:22:42 +1000 (AEST)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=Prt0RaJR; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 491pd00QhfzDqZw
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2020 01:02:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=lGGXOGXMyka6T3tpeyl3b0+hXD5oslkz5aNH49zanLk=; b=Prt0RaJRpxpoylusLh1a+MfVJl
 jW4VqTMQur4s69slSCdGXoWcZRR69dLG0M2oXOpOTEtsH3No0S5/yVEnuiDBIcQJxlDBdoVcjLQ4t
 OgIGUOW/GzctPYEXuh9HL9uOok2XyqH9vbH/AMWIEeumfUzpveZrMoPss1AGzk01dacVCug+WOhA3
 cq4PHjIYkklhlDEnk9lF+F5IsPpG1St1X6PDBP0yWxbyORDStHJJI5IiBseyuBshOgEKIbksF1Ht1
 naiNLvMU5mV+JFE06KaMFR45eVigd8WcLJOSL5Ii7OBZNeSWD+I6ImByvL79P8ybCdH4FtQEz9lCr
 5EkVX6lw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jON5A-0006Ob-1k; Tue, 14 Apr 2020 15:02:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v11 10/25] mm: Put readahead pages in cache earlier
Date: Tue, 14 Apr 2020 08:02:18 -0700
Message-Id: <20200414150233.24495-11-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414150233.24495-1-willy@infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
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
Cc: linux-xfs@vger.kernel.org, William Kucharski <william.kucharski@oracle.com>,
 linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

When populating the page cache for readahead, mappings that use
->readpages must populate the page cache themselves as the pages are
passed on a linked list which would normally be used for the page cache's
LRU.  For mappings that use ->readpage or the upcoming ->readahead method,
we can put the pages into the page cache as soon as they're allocated,
which solves a race between readahead and direct IO.  It also lets us
remove the gfp argument from read_pages().

Use the new readahead_page() API to implement the repeated calls to
->readpage(), just like most filesystems will.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/readahead.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index ddc63d3b07b8..e52b3a7b9da5 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -114,14 +114,14 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
 EXPORT_SYMBOL(read_cache_pages);
 
 static void read_pages(struct readahead_control *rac, struct list_head *pages,
-		gfp_t gfp)
+		bool skip_page)
 {
 	const struct address_space_operations *aops = rac->mapping->a_ops;
+	struct page *page;
 	struct blk_plug plug;
-	unsigned page_idx;
 
 	if (!readahead_count(rac))
-		return;
+		goto out;
 
 	blk_start_plug(&plug);
 
@@ -130,23 +130,23 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
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
+		rac->_index += rac->_nr_pages;
+		rac->_nr_pages = 0;
+	} else {
+		while ((page = readahead_page(rac))) {
 			aops->readpage(rac->file, page);
-		put_page(page);
+			put_page(page);
+		}
 	}
 
-out:
 	blk_finish_plug(&plug);
 
 	BUG_ON(!list_empty(pages));
-	rac->_nr_pages = 0;
+	BUG_ON(readahead_count(rac));
+
+out:
+	if (skip_page)
+		rac->_index++;
 }
 
 /*
@@ -168,6 +168,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	struct readahead_control rac = {
 		.mapping = mapping,
 		.file = filp,
+		._index = index,
 	};
 	unsigned long i;
 
@@ -183,6 +184,8 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		if (index + i > end_index)
 			break;
 
+		BUG_ON(index + i != rac._index + rac._nr_pages);
+
 		page = xa_load(&mapping->i_pages, index + i);
 		if (page && !xa_is_value(page)) {
 			/*
@@ -190,15 +193,22 @@ void __do_page_cache_readahead(struct address_space *mapping,
 			 * contiguous pages before continuing with the next
 			 * batch.
 			 */
-			read_pages(&rac, &page_pool, gfp_mask);
+			read_pages(&rac, &page_pool, true);
 			continue;
 		}
 
 		page = __page_cache_alloc(gfp_mask);
 		if (!page)
 			break;
-		page->index = index + i;
-		list_add(&page->lru, &page_pool);
+		if (mapping->a_ops->readpages) {
+			page->index = index + i;
+			list_add(&page->lru, &page_pool);
+		} else if (add_to_page_cache_lru(page, mapping, index + i,
+					gfp_mask) < 0) {
+			put_page(page);
+			read_pages(&rac, &page_pool, true);
+			continue;
+		}
 		if (i == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
 		rac._nr_pages++;
@@ -209,7 +219,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	 * uptodate then the caller will launch readpage again, and
 	 * will then handle the error.
 	 */
-	read_pages(&rac, &page_pool, gfp_mask);
+	read_pages(&rac, &page_pool, false);
 }
 
 /*
-- 
2.25.1

