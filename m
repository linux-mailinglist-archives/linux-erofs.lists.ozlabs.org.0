Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABA53DE376
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Aug 2021 02:17:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GdwSG1cxTz2yxW
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Aug 2021 10:17:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GdwSB4RRZz2yYS
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Aug 2021 10:17:44 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0UhoymnS_1627949850; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UhoymnS_1627949850) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 03 Aug 2021 08:17:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v10] iomap: support reading inline data from non-zero pos
Date: Tue,  3 Aug 2021 08:17:27 +0800
Message-Id: <20210803001727.50281-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <YQfh7V0lvLNx0QlR@B-P7TQMD6M-0146.local>
References: <YQfh7V0lvLNx0QlR@B-P7TQMD6M-0146.local>
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
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
 "Darrick J . Wong" <djwong@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The existing inline data support only works for cases where the entire
file is stored as inline data.  For larger files, EROFS stores the
initial blocks separately and the remainder of the file ("file tail")
adjacent to the inode.  Generalise inline data to allow reading the
inline file tail.  Tails may not cross a page boundary in memory.

We currently have no filesystems that support tails and writing,
so that case is currently disabled (see iomap_write_begin_inline).

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v9:
 - update commit message suggested by Darrick and
   collect his RVB;
 - update a semicolon suggested by Andreas.

 fs/iomap/buffered-io.c | 42 ++++++++++++++++++++++++++++++------------
 fs/iomap/direct-io.c   | 10 ++++++----
 include/linux/iomap.h  | 18 ++++++++++++++++++
 3 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87ccb3438bec..dd1e2cbec5a0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -205,25 +205,32 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static void
-iomap_read_inline_data(struct inode *inode, struct page *page,
+static int iomap_read_inline_data(struct inode *inode, struct page *page,
 		struct iomap *iomap)
 {
-	size_t size = i_size_read(inode);
+	size_t size = i_size_read(inode) - iomap->offset;
 	void *addr;
 
 	if (PageUptodate(page))
-		return;
+		return 0;
 
-	BUG_ON(page_has_private(page));
-	BUG_ON(page->index);
-	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	/* inline data must start page aligned in the file */
+	if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
+		return -EIO;
+	if (WARN_ON_ONCE(size > PAGE_SIZE -
+			 offset_in_page(iomap->inline_data)))
+		return -EIO;
+	if (WARN_ON_ONCE(size > iomap->length))
+		return -EIO;
+	if (WARN_ON_ONCE(page_has_private(page)))
+		return -EIO;
 
 	addr = kmap_atomic(page);
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - size);
 	kunmap_atomic(addr);
 	SetPageUptodate(page);
+	return 0;
 }
 
 static inline bool iomap_block_needs_zeroing(struct inode *inode,
@@ -247,8 +254,10 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	sector_t sector;
 
 	if (iomap->type == IOMAP_INLINE) {
-		WARN_ON_ONCE(pos);
-		iomap_read_inline_data(inode, page, iomap);
+		int ret = iomap_read_inline_data(inode, page, iomap);
+
+		if (ret)
+			return ret;
 		return PAGE_SIZE;
 	}
 
@@ -589,6 +598,15 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 	return 0;
 }
 
+static int iomap_write_begin_inline(struct inode *inode,
+		struct page *page, struct iomap *srcmap)
+{
+	/* needs more work for the tailpacking case; disable for now */
+	if (WARN_ON_ONCE(srcmap->offset != 0))
+		return -EIO;
+	return iomap_read_inline_data(inode, page, srcmap);
+}
+
 static int
 iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
@@ -618,7 +636,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 	}
 
 	if (srcmap->type == IOMAP_INLINE)
-		iomap_read_inline_data(inode, page, srcmap);
+		status = iomap_write_begin_inline(inode, page, srcmap);
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
 	else
@@ -671,11 +689,11 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
 	void *addr;
 
 	WARN_ON_ONCE(!PageUptodate(page));
-	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	BUG_ON(!iomap_inline_data_valid(iomap));
 
 	flush_dcache_page(page);
 	addr = kmap_atomic(page);
-	memcpy(iomap->inline_data + pos, addr + pos, copied);
+	memcpy(iomap_inline_data(iomap, pos), addr + pos, copied);
 	kunmap_atomic(addr);
 
 	mark_inode_dirty(inode);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323..41ccbfc9dc82 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -378,23 +378,25 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 		struct iomap_dio *dio, struct iomap *iomap)
 {
 	struct iov_iter *iter = dio->submit.iter;
+	void *inline_data = iomap_inline_data(iomap, pos);
 	size_t copied;
 
-	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	if (WARN_ON_ONCE(!iomap_inline_data_valid(iomap)))
+		return -EIO;
 
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		loff_t size = inode->i_size;
 
 		if (pos > size)
-			memset(iomap->inline_data + size, 0, pos - size);
-		copied = copy_from_iter(iomap->inline_data + pos, length, iter);
+			memset(iomap_inline_data(iomap, size), 0, pos - size);
+		copied = copy_from_iter(inline_data, length, iter);
 		if (copied) {
 			if (pos + copied > size)
 				i_size_write(inode, pos + copied);
 			mark_inode_dirty(inode);
 		}
 	} else {
-		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
+		copied = copy_to_iter(inline_data, length, iter);
 	}
 	dio->size += copied;
 	return copied;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 479c1da3e221..b8ec145b2975 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -97,6 +97,24 @@ iomap_sector(struct iomap *iomap, loff_t pos)
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
 }
 
+/*
+ * Returns the inline data pointer for logical offset @pos.
+ */
+static inline void *iomap_inline_data(struct iomap *iomap, loff_t pos)
+{
+	return iomap->inline_data + pos - iomap->offset;
+}
+
+/*
+ * Check if the mapping's length is within the valid range for inline data.
+ * This is used to guard against accessing data beyond the page inline_data
+ * points at.
+ */
+static inline bool iomap_inline_data_valid(struct iomap *iomap)
+{
+	return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
+}
+
 /*
  * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
  * and page_done will be called for each page written to.  This only applies to
-- 
2.24.4

