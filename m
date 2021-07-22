Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 326023D1D8C
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jul 2021 07:40:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GVh9W167Sz302l
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jul 2021 15:39:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GVh9Q4TGTz2yP5
 for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jul 2021 15:39:53 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5219067373; Thu, 22 Jul 2021 07:39:47 +0200 (CEST)
Date: Thu, 22 Jul 2021 07:39:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v6] iomap: support tail packing inline read
Message-ID: <20210722053947.GA28594@lst.de>
References: <20210722031729.51628-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210722031729.51628-1-hsiangkao@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: "Darrick J . Wong" <djwong@kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

I think some of the language here is confusing - mostly about tail
packing when we otherwise use inline data.  Can you take a look at
the version below?  This mostly cleans up the terminology, adds a
new helper to check the size, and removes the error on trying to
write with a non-zero pos, as it can be trivially supported now.

---
From 0f9c6ac6c2e372739b29195d25bebb8dd87e583a Mon Sep 17 00:00:00 2001
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Thu, 22 Jul 2021 11:17:29 +0800
Subject: iomap: make inline data support more flexible

Add support for offsets into the inline data page at iomap->inline_data
to cater for the EROFS tailpackng case where a small data is stored
right after the inode.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/iomap/buffered-io.c | 35 ++++++++++++++++++-----------------
 fs/iomap/direct-io.c   | 10 ++++++----
 include/linux/iomap.h  | 14 ++++++++++++++
 3 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87ccb3438becd9..0597f5c186a33f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -205,25 +205,29 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static void
-iomap_read_inline_data(struct inode *inode, struct page *page,
-		struct iomap *iomap)
+static int iomap_read_inline_data(struct inode *inode, struct page *page,
+		struct iomap *iomap, loff_t pos)
 {
-	size_t size = i_size_read(inode);
+	size_t size = iomap->length + iomap->offset - pos;
 	void *addr;
 
 	if (PageUptodate(page))
-		return;
+		return PAGE_SIZE;
 
-	BUG_ON(page_has_private(page));
-	BUG_ON(page->index);
-	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	/* inline data must start page aligned in the file */
+	if (WARN_ON_ONCE(offset_in_page(pos)))
+		return -EIO;
+	if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
+		return -EIO;
+	if (WARN_ON_ONCE(page_has_private(page)))
+		return -EIO;
 
 	addr = kmap_atomic(page);
-	memcpy(addr, iomap->inline_data, size);
+	memcpy(addr, iomap_inline_buf(iomap, pos), size);
 	memset(addr + size, 0, PAGE_SIZE - size);
 	kunmap_atomic(addr);
 	SetPageUptodate(page);
+	return PAGE_SIZE;
 }
 
 static inline bool iomap_block_needs_zeroing(struct inode *inode,
@@ -246,11 +250,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	unsigned poff, plen;
 	sector_t sector;
 
-	if (iomap->type == IOMAP_INLINE) {
-		WARN_ON_ONCE(pos);
-		iomap_read_inline_data(inode, page, iomap);
-		return PAGE_SIZE;
-	}
+	if (iomap->type == IOMAP_INLINE)
+		return iomap_read_inline_data(inode, page, iomap, pos);
 
 	/* zero post-eof blocks as the page may be mapped */
 	iop = iomap_page_create(inode, page);
@@ -618,14 +619,14 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 	}
 
 	if (srcmap->type == IOMAP_INLINE)
-		iomap_read_inline_data(inode, page, srcmap);
+		status = iomap_read_inline_data(inode, page, srcmap, pos);
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
 	else
 		status = __iomap_write_begin(inode, pos, len, flags, page,
 				srcmap);
 
-	if (unlikely(status))
+	if (unlikely(status < 0))
 		goto out_unlock;
 
 	*pagep = page;
@@ -675,7 +676,7 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
 
 	flush_dcache_page(page);
 	addr = kmap_atomic(page);
-	memcpy(iomap->inline_data + pos, addr + pos, copied);
+	memcpy(iomap_inline_buf(iomap, pos), addr + pos, copied);
 	kunmap_atomic(addr);
 
 	mark_inode_dirty(inode);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323b3..a6aaea2764a55f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -378,23 +378,25 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 		struct iomap_dio *dio, struct iomap *iomap)
 {
 	struct iov_iter *iter = dio->submit.iter;
+	void *dst = iomap_inline_buf(iomap, pos);
 	size_t copied;
 
-	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
+		return -EIO;
 
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		loff_t size = inode->i_size;
 
 		if (pos > size)
-			memset(iomap->inline_data + size, 0, pos - size);
-		copied = copy_from_iter(iomap->inline_data + pos, length, iter);
+			memset(iomap_inline_buf(iomap, size), 0, pos - size);
+		copied = copy_from_iter(dst, length, iter);
 		if (copied) {
 			if (pos + copied > size)
 				i_size_write(inode, pos + copied);
 			mark_inode_dirty(inode);
 		}
 	} else {
-		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
+		copied = copy_to_iter(dst, length, iter);
 	}
 	dio->size += copied;
 	return copied;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 479c1da3e2211e..5efae7153912ed 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -97,6 +97,20 @@ iomap_sector(struct iomap *iomap, loff_t pos)
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
 }
 
+static inline void *iomap_inline_buf(const struct iomap *iomap, loff_t pos)
+{
+	return iomap->inline_data - iomap->offset + pos;
+}
+
+/*
+ * iomap->inline_data is a potentially kmapped page, ensure it never crosseѕ a
+ * page boundary.
+ */
+static inline bool iomap_inline_data_size_valid(const struct iomap *iomap)
+{
+	return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
+}
+
 /*
  * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
  * and page_done will be called for each page written to.  This only applies to
-- 
2.30.2

