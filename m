Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD8415879C
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2020 02:06:04 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Gl2c5jN2zDqFs
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2020 12:06:00 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=r7btMVTs; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Gl0L3dkXzDqBS
 for <linux-erofs@lists.ozlabs.org>; Tue, 11 Feb 2020 12:04:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=FwYPRApt9MEps3qpGONd/jYopCot/Kg4OipuQfj8Ggc=; b=r7btMVTsJVRO//FavP+XSS9Fcr
 UAgB2OuBMu7Z2PEeA2W93FbAu6I62DBI01zRjNyu4ECUugBIZNxhlmfMIssKX2LmZlE5vufGFJ+4E
 KfGqov8206P01RC3UDK7rg8poS8Ij9DiQqBmKP+dLXmqceYnLXxzA2RO3IIubqIRxHWJjZOWJYm4x
 dg53qGkJEkn8pBU0oywSkSLVIlFnDxEsY40ItbRgCauvq2jGLK/J0lYGg70pUT4F/hyRYDcuLfa5+
 1vKXfyl5zb3PRd4IekbsyTgo02ibVJhS56dUudba5k8OAFKLekS9Du11uxj4Aj5UkiaPiI1FuqUon
 8EQDTIhw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j1Jxu-0001oH-KS; Tue, 11 Feb 2020 01:03:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 10/13] ext4: Convert from readpages to readahead
Date: Mon, 10 Feb 2020 17:03:45 -0800
Message-Id: <20200211010348.6872-11-willy@infradead.org>
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

Use the new readahead operation in ext4

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/ext4.h     |  3 +--
 fs/ext4/inode.c    | 23 ++++++++++-------------
 fs/ext4/readpage.c | 22 ++++++++--------------
 3 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9a2ee2428ecc..3af755da101d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3276,8 +3276,7 @@ static inline void ext4_set_de_type(struct super_block *sb,
 
 /* readpages.c */
 extern int ext4_mpage_readpages(struct address_space *mapping,
-				struct list_head *pages, struct page *page,
-				unsigned nr_pages, bool is_readahead);
+		struct readahead_control *rac, struct page *page);
 extern int __init ext4_init_post_read_processing(void);
 extern void ext4_exit_post_read_processing(void);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3313168b680f..f07bacb05df5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3218,7 +3218,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 static int ext4_readpage(struct file *file, struct page *page)
 {
 	int ret = -EAGAIN;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = file_inode(file);
 
 	trace_ext4_readpage(page);
 
@@ -3226,23 +3226,20 @@ static int ext4_readpage(struct file *file, struct page *page)
 		ret = ext4_readpage_inline(inode, page);
 
 	if (ret == -EAGAIN)
-		return ext4_mpage_readpages(page->mapping, NULL, page, 1,
-						false);
+		return ext4_mpage_readpages(page->mapping, NULL, page);
 
 	return ret;
 }
 
-static int
-ext4_readpages(struct file *file, struct address_space *mapping,
-		struct list_head *pages, unsigned nr_pages)
+static void ext4_readahead(struct readahead_control *rac)
 {
-	struct inode *inode = mapping->host;
+	struct inode *inode = rac->mapping->host;
 
-	/* If the file has inline data, no need to do readpages. */
+	/* If the file has inline data, no need to do readahead. */
 	if (ext4_has_inline_data(inode))
-		return 0;
+		return;
 
-	return ext4_mpage_readpages(mapping, pages, NULL, nr_pages, true);
+	ext4_mpage_readpages(rac->mapping, rac, NULL);
 }
 
 static void ext4_invalidatepage(struct page *page, unsigned int offset,
@@ -3587,7 +3584,7 @@ static int ext4_set_page_dirty(struct page *page)
 
 static const struct address_space_operations ext4_aops = {
 	.readpage		= ext4_readpage,
-	.readpages		= ext4_readpages,
+	.readahead		= ext4_readahead,
 	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_write_begin,
@@ -3604,7 +3601,7 @@ static const struct address_space_operations ext4_aops = {
 
 static const struct address_space_operations ext4_journalled_aops = {
 	.readpage		= ext4_readpage,
-	.readpages		= ext4_readpages,
+	.readahead		= ext4_readahead,
 	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_write_begin,
@@ -3620,7 +3617,7 @@ static const struct address_space_operations ext4_journalled_aops = {
 
 static const struct address_space_operations ext4_da_aops = {
 	.readpage		= ext4_readpage,
-	.readpages		= ext4_readpages,
+	.readahead		= ext4_readahead,
 	.writepage		= ext4_writepage,
 	.writepages		= ext4_writepages,
 	.write_begin		= ext4_da_write_begin,
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index c1769afbf799..e14841ade612 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -7,8 +7,8 @@
  *
  * This was originally taken from fs/mpage.c
  *
- * The intent is the ext4_mpage_readpages() function here is intended
- * to replace mpage_readpages() in the general case, not just for
+ * The ext4_mpage_readahead() function here is intended to
+ * replace mpage_readahead() in the general case, not just for
  * encrypted files.  It has some limitations (see below), where it
  * will fall back to read_block_full_page(), but these limitations
  * should only be hit when page_size != block_size.
@@ -222,8 +222,7 @@ static inline loff_t ext4_readpage_limit(struct inode *inode)
 }
 
 int ext4_mpage_readpages(struct address_space *mapping,
-			 struct list_head *pages, struct page *page,
-			 unsigned nr_pages, bool is_readahead)
+		struct readahead_control *rac, struct page *page)
 {
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
@@ -241,6 +240,7 @@ int ext4_mpage_readpages(struct address_space *mapping,
 	int length;
 	unsigned relative_block = 0;
 	struct ext4_map_blocks map;
+	unsigned int nr_pages = rac ? readahead_count(rac) : 1;
 
 	map.m_pblk = 0;
 	map.m_lblk = 0;
@@ -251,14 +251,9 @@ int ext4_mpage_readpages(struct address_space *mapping,
 		int fully_mapped = 1;
 		unsigned first_hole = blocks_per_page;
 
-		if (pages) {
-			page = lru_to_page(pages);
-
+		if (rac) {
+			page = readahead_page(rac);
 			prefetchw(&page->flags);
-			list_del(&page->lru);
-			if (add_to_page_cache_lru(page, mapping, page->index,
-				  readahead_gfp_mask(mapping)))
-				goto next_page;
 		}
 
 		if (page_has_buffers(page))
@@ -381,7 +376,7 @@ int ext4_mpage_readpages(struct address_space *mapping,
 			bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
 			bio->bi_end_io = mpage_end_io;
 			bio_set_op_attrs(bio, REQ_OP_READ,
-						is_readahead ? REQ_RAHEAD : 0);
+						rac ? REQ_RAHEAD : 0);
 		}
 
 		length = first_hole << blkbits;
@@ -406,10 +401,9 @@ int ext4_mpage_readpages(struct address_space *mapping,
 		else
 			unlock_page(page);
 	next_page:
-		if (pages)
+		if (rac)
 			put_page(page);
 	}
-	BUG_ON(pages && !list_empty(pages));
 	if (bio)
 		submit_bio(bio);
 	return 0;
-- 
2.25.0

