Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 323CE18FF76
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2020 21:27:00 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48mQsD6S4lzDqkw
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Mar 2020 07:26:56 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 48mQms5V13zDr5Y
 for <linux-erofs@lists.ozlabs.org>; Tue, 24 Mar 2020 07:23:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=a3v6yDLu6YVVgdwzNLLzwkeJ8vT0YawbuKhMcViKfm0=; b=cful21T9r3bVU98Icr24dfrJyn
 kHFGsNuTm37ajb0PTC7EhOpjwRvV2C8UWCqRCj4X5NaN4lqUXZEJv2zsnY3tsXREFwBthl696zrh5
 w/n3es3aFrUXZcPXNIhDGIfeT7wMfXMu44CfU1sTA+yqYfNZ8FuwAM16U8W2tOJ+zQAyPbag4FZrI
 7AdhoSkTthn9CJYF+rTvr4JzL6GJ3IL/HECYDus+kk6x6XQtEFdifvYUjajTPg5GGPhG/SDspAcec
 64yEPuz4hF66+ytNKqmPHAhGNlfKKWbVSyYYhRLD/aFyEi0XwYBbPyqFEjUAraa7Pzr0/Bi+68CSF
 e9nRWANA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jGTbB-0003Ux-KV; Mon, 23 Mar 2020 20:23:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v10 08/25] mm: rename readahead loop variable to 'i'
Date: Mon, 23 Mar 2020 13:22:42 -0700
Message-Id: <20200323202259.13363-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200323202259.13363-1-willy@infradead.org>
References: <20200323202259.13363-1-willy@infradead.org>
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
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Change the type of page_idx to unsigned long, and rename it -- it's
just a loop counter, not a page index.

Suggested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/readahead.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 8a65d6bd97e0..7ce320854bad 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -163,13 +163,13 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	struct page *page;
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
-	int page_idx;
 	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 	struct readahead_control rac = {
 		.mapping = mapping,
 		.file = filp,
 	};
+	unsigned long i;
 
 	if (isize == 0)
 		return;
@@ -179,8 +179,8 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
-	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
-		pgoff_t page_offset = index + page_idx;
+	for (i = 0; i < nr_to_read; i++) {
+		pgoff_t page_offset = index + i;
 
 		if (page_offset > end_index)
 			break;
@@ -201,7 +201,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 			break;
 		page->index = page_offset;
 		list_add(&page->lru, &page_pool);
-		if (page_idx == nr_to_read - lookahead_size)
+		if (i == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
 		rac._nr_pages++;
 	}
-- 
2.25.1

