Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8CE3D1C4F
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jul 2021 05:17:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GVd1d440Gz3084
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jul 2021 13:17:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GVd1Z0Ppbz302B
 for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jul 2021 13:17:51 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R311e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UgZxNdf_1626923850; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UgZxNdf_1626923850) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 22 Jul 2021 11:17:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6] iomap: support tail packing inline read
Date: Thu, 22 Jul 2021 11:17:29 +0800
Message-Id: <20210722031729.51628-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: "Darrick J . Wong" <djwong@kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This tries to add tailpacking inline read to iomap, which only supports
page-aligned tailpacking cases of a few extra inline bytes right after
the inode itself, which is how the current EROFS tail-packing works.
Similar to the previous approach, it cleans post-EOF in one iteration.

The write path remains untouched since EROFS cannot be used for testing.
It'd be better to be implemented if upcoming real users care rather than
leave untested dead code around.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v5: https://lore.kernel.org/r/20210721082323.41933-1-hsiangkao@linux.alibaba.com
changes since v5 (pointed out by Darrick):
 - Update the code to handle inline data mappings where iomap->offset
   is not zero but the start of the mapping is always page-aligned;

 - introduce a new helper called iomap_inline_buf() to wrap up:
    (iomap->inline_data + pos - iomap->offset)
   since it's used for buffered-io.c and direct-io.c, thus it keeps in
   linux/iomap.h;

 - simplify "size = iomap->length + iomap->offset - pos" since
	if (WARN_ON_ONCE(iomap->length > PAGE_SIZE -
			 offset_in_page(iomap->inline_data)))
		return -EIO;
   already limiting iomap->length within the PAGE_SIZE;

 - update 2 inlined comments;

 - note that I leave "BUG_ON(page_has_private(page));" as-is since
   it was just added in 5.14-rc2 and I'm not sure WARN_ON_ONCE and
   bailing out such cases is really safe for fs developers.

Hopefully I don't miss anything and everyone is happy with this version,
and I will retest this version with looping this 2-level random dir test
this evening:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?id=af7de830f86c2f24a510857e413ea7992e699832

Many thanks for your time,
Gao Xiang

 fs/iomap/buffered-io.c | 43 +++++++++++++++++++++++++++++-------------
 fs/iomap/direct-io.c   | 15 +++++++++++----
 include/linux/iomap.h  |  6 ++++++
 3 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87ccb3438bec..a3003f3e4d0e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -205,25 +205,35 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static void
+static int
 iomap_read_inline_data(struct inode *inode, struct page *page,
-		struct iomap *iomap)
+		struct iomap *iomap, loff_t pos)
 {
-	size_t size = i_size_read(inode);
+	unsigned int size;
 	void *addr;
 
 	if (PageUptodate(page))
-		return;
+		return PAGE_SIZE;
 
 	BUG_ON(page_has_private(page));
-	BUG_ON(page->index);
-	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
+	/* only support page-aligned tailpacking for now */
+	if (WARN_ON_ONCE(offset_in_page(pos)))
+		return -EIO;
+	/*
+	 * iomap->inline_data is a kernel-mapped memory page, so we must
+	 * terminate the read at the end of that page.
+	 */
+	if (WARN_ON_ONCE(iomap->length > PAGE_SIZE -
+			 offset_in_page(iomap->inline_data)))
+		return -EIO;
+	size = iomap->length + iomap->offset - pos;
 	addr = kmap_atomic(page);
-	memcpy(addr, iomap->inline_data, size);
+	memcpy(addr, iomap_inline_buf(iomap, pos), size);
 	memset(addr + size, 0, PAGE_SIZE - size);
 	kunmap_atomic(addr);
 	SetPageUptodate(page);
+	return PAGE_SIZE;
 }
 
 static inline bool iomap_block_needs_zeroing(struct inode *inode,
@@ -246,11 +256,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
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
@@ -589,6 +596,16 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 	return 0;
 }
 
+static int iomap_write_begin_inline(struct inode *inode,
+		struct page *page, struct iomap *srcmap)
+{
+	/* needs more work for the tailpacking case, disable for now */
+	if (WARN_ON_ONCE(srcmap->offset != 0))
+		return -EIO;
+	iomap_read_inline_data(inode, page, srcmap, 0);
+	return 0;
+}
+
 static int
 iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
@@ -618,7 +635,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 	}
 
 	if (srcmap->type == IOMAP_INLINE)
-		iomap_read_inline_data(inode, page, srcmap);
+		status = iomap_write_begin_inline(inode, page, srcmap);
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
 	else
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323..f9253cae5b24 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -379,22 +379,29 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 {
 	struct iov_iter *iter = dio->submit.iter;
 	size_t copied;
+	void *dst = iomap_inline_buf(iomap, pos);
 
-	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	/*
+	 * iomap->inline_data is a kernel-mapped memory page, so we must
+	 * terminate the write at the end of that page.
+	 */
+	if (WARN_ON_ONCE(length > PAGE_SIZE -
+			 offset_in_page(iomap->inline_data)))
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
index 479c1da3e221..fb6934943eeb 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -97,6 +97,12 @@ iomap_sector(struct iomap *iomap, loff_t pos)
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
 }
 
+static inline void *
+iomap_inline_buf(const struct iomap *iomap, loff_t pos)
+{
+	return iomap->inline_data + pos - iomap->offset;
+}
+
 /*
  * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
  * and page_done will be called for each page written to.  This only applies to
-- 
2.24.4

