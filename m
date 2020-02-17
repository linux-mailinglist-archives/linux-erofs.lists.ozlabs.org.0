Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5E5161AFB
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2020 19:51:39 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48LtPN0b7KzDqjX
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2020 05:51:36 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=mG3ezOVT; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48LtHV1tyVzDqXt
 for <linux-erofs@lists.ozlabs.org>; Tue, 18 Feb 2020 05:46:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=GsjiaZugI72vbGelDXh1gHsSqzMvkN1OtgDj3kywYLo=; b=mG3ezOVTlUwDZANXsCHvcKdwJB
 z3OlpT7AjCBCJphbep/jJMnYwWkqQCv4wTdvjax0x0CW6Nvu8+8tccy4vlbefujrJjJEj82Cnsx1d
 0Z0dVex246tKQbAITwLWjKWZ5u/u/QkHJfmmheFgDcrAuXqy1jKQgdOFfs9OG8e4Jv179uA6lHT0C
 rj7l1UtOFC7pBjOM+uPFkUB4PEe+Mm5ggHB2nPVgYYpq1iZJM1/7wiOXsE7PHbRws4qZi4knTfp9M
 Abo7HX1ADfB8vHy4nwtU2Q4tJcbww1fj8NQ9P/NHWgtRpkc995sdbYd50dglXP3xbP8Qt8cWX4AgS
 6OQh+pkw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j3lPL-00058r-DR; Mon, 17 Feb 2020 18:46:15 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 04/19] mm: Rearrange readahead loop
Date: Mon, 17 Feb 2020 10:45:45 -0800
Message-Id: <20200217184613.19668-5-willy@infradead.org>
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

Move the declaration of 'page' to inside the loop and move the 'kick
off a fresh batch' code to the end of the function for easier use in
subsequent patches.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 15329309231f..3eca59c43a45 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -154,7 +154,6 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		unsigned long lookahead_size)
 {
 	struct inode *inode = mapping->host;
-	struct page *page;
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	int page_idx;
@@ -175,6 +174,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	 * Preallocate as many pages as we will need.
 	 */
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
+		struct page *page;
 		pgoff_t page_offset = offset + page_idx;
 
 		if (page_offset > end_index)
@@ -183,14 +183,14 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		page = xa_load(&mapping->i_pages, page_offset);
 		if (page && !xa_is_value(page)) {
 			/*
-			 * Page already present?  Kick off the current batch of
-			 * contiguous pages before continuing with the next
-			 * batch.
+			 * Page already present?  Kick off the current batch
+			 * of contiguous pages before continuing with the
+			 * next batch.  This page may be the one we would
+			 * have intended to mark as Readahead, but we don't
+			 * have a stable reference to this page, and it's
+			 * not worth getting one just for that.
 			 */
-			if (readahead_count(&rac))
-				read_pages(&rac, &page_pool, gfp_mask);
-			rac._nr_pages = 0;
-			continue;
+			goto read;
 		}
 
 		page = __page_cache_alloc(gfp_mask);
@@ -201,6 +201,11 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		if (page_idx == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
 		rac._nr_pages++;
+		continue;
+read:
+		if (readahead_count(&rac))
+			read_pages(&rac, &page_pool, gfp_mask);
+		rac._nr_pages = 0;
 	}
 
 	/*
-- 
2.25.0

