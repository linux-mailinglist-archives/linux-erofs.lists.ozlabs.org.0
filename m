Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D383CB521
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jul 2021 11:20:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GR5Lp2wNMz300C
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jul 2021 19:20:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=p2vq/OzL;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+382ccfd9051a34597009+6536+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GR5LG3p37z2yRD
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jul 2021 19:20:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=9YTjbkFFuJ3p7Dou0+SBFN6U9uCNz73Kju0y+iDMBPg=; b=p2vq/OzL7M/kfm03Ldbvdi6tEO
 Oohe70lzt2AhQRCAn2d5n4d7Nd5F4eUbG+72h+yDCNG0HhHu9FzMd7otp1E93GkuCR+iTdjE0VpcL
 HkkpPC/O+KCEMhXT2097gnDSXQEe81jd3XU1AcWN0aG61/h7thcSQsrPwqxEmrBL2LJXMwv3Sy2J+
 vA609QB9TOChAhfKiyTEOnR0yLPhqDBRRjwKjyi0Rmib9qeE1hg8010E0tlxZEjN9bxIvlXBMCHUb
 hc09KqVeCgRRmRYIYIgdGnMgwHKWEYpu2TQXjLrSDtTjQ4Zu3HdXrL7Siw1zHzJZXM3DmyoMDnND1
 8No8MSLw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m4Jzx-004LKp-2N; Fri, 16 Jul 2021 09:19:13 +0000
Date: Fri, 16 Jul 2021 10:19:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPFPDS5ktWJEUKTo@infradead.org>
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
 <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
 "Darrick J. Wong" <djwong@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
 Liu Jiang <gerry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

I'm pretty sure gfs2 supports direct writes to inline data, so we should
not disable it.  I also think we should share the code rather than
duplicating it.  Suggested version against the iomap-for-next branch
attached, but this needs careful check from Andreas (please keep him on
CC).

---
From 6067cd3462cea80cb2739602862296db41fc5638 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 16 Jul 2021 10:52:48 +0200
Subject: iomap: support tail packing inline read

This tries to add tail packing inline read to iomap. Different from
the previous approach, it only marks the block range uptodate in the
page it covers.

The write path remains untouched since EROFS cannot be used for
testing. It'd be better to be implemented if upcoming real users care
rather than leave untested dead code around.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/iomap/buffered-io.c | 56 ++++++++++++++++++++++++++++--------------
 fs/iomap/direct-io.c   |  6 +++--
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87ccb3438becd9..2efd4bc0328995 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -207,29 +207,28 @@ struct iomap_readpage_ctx {
 
 static void
 iomap_read_inline_data(struct inode *inode, struct page *page,
-		struct iomap *iomap)
+		struct iomap *iomap, loff_t pos, unsigned int size)
 {
-	size_t size = i_size_read(inode);
+	unsigned int block_aligned_size = round_up(size, i_blocksize(inode));
+	unsigned int poff = offset_in_page(pos);
 	void *addr;
 
-	if (PageUptodate(page))
-		return;
-
-	BUG_ON(page_has_private(page));
-	BUG_ON(page->index);
+	/* make sure that inline_data doesn't cross page boundary */
 	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	BUG_ON(size != i_size_read(inode) - pos);
 
 	addr = kmap_atomic(page);
-	memcpy(addr, iomap->inline_data, size);
-	memset(addr + size, 0, PAGE_SIZE - size);
+	memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
+	memset(addr + poff + size, 0, block_aligned_size - size);
 	kunmap_atomic(addr);
-	SetPageUptodate(page);
+
+	iomap_set_range_uptodate(page, poff, block_aligned_size);
 }
 
 static inline bool iomap_block_needs_zeroing(struct inode *inode,
 		struct iomap *iomap, loff_t pos)
 {
-	return iomap->type != IOMAP_MAPPED ||
+	return (iomap->type != IOMAP_MAPPED && iomap->type != IOMAP_INLINE) ||
 		(iomap->flags & IOMAP_F_NEW) ||
 		pos >= i_size_read(inode);
 }
@@ -240,20 +239,18 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 {
 	struct iomap_readpage_ctx *ctx = data;
 	struct page *page = ctx->cur_page;
-	struct iomap_page *iop;
+	struct iomap_page *iop = NULL;
 	bool same_page = false, is_contig = false;
 	loff_t orig_pos = pos;
 	unsigned poff, plen;
 	sector_t sector;
 
-	if (iomap->type == IOMAP_INLINE) {
-		WARN_ON_ONCE(pos);
-		iomap_read_inline_data(inode, page, iomap);
-		return PAGE_SIZE;
-	}
+	if (iomap->type == IOMAP_INLINE && !pos)
+		WARN_ON_ONCE(to_iomap_page(page) != NULL);
+	else
+		iop = iomap_page_create(inode, page);
 
 	/* zero post-eof blocks as the page may be mapped */
-	iop = iomap_page_create(inode, page);
 	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
@@ -264,6 +261,15 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		goto done;
 	}
 
+	if (iomap->type == IOMAP_INLINE) {
+		iomap_read_inline_data(inode, page, iomap, pos, plen);
+		/*
+		 * TODO: the old code used to return PAGE_SIZE here
+		 * unconditionally.  I think the actual i_size return should
+		 * be fine for gfs2 as well, but please double check.
+		 */
+		goto done;
+	}
 	ctx->cur_page_in_bio = true;
 	if (iop)
 		atomic_add(plen, &iop->read_bytes_pending);
@@ -589,6 +595,18 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 	return 0;
 }
 
+static int iomap_write_begin_inline(struct inode *inode, loff_t pos,
+		struct page *page, struct iomap *srcmap)
+{
+	/* needs more work for the tailpacking case, disable for now */
+	if (WARN_ON_ONCE(pos != 0))
+		return -EIO;
+	if (PageUptodate(page))
+		return 0;
+	iomap_read_inline_data(inode, page, srcmap, pos, i_size_read(inode));
+	return 0;
+}
+
 static int
 iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
@@ -618,7 +636,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 	}
 
 	if (srcmap->type == IOMAP_INLINE)
-		iomap_read_inline_data(inode, page, srcmap);
+		status = iomap_write_begin_inline(inode, pos, page, srcmap);
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
 	else
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323b3..a70a8632df226f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -380,7 +380,8 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 	struct iov_iter *iter = dio->submit.iter;
 	size_t copied;
 
-	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
+	/* inline data must be inside a single page */
+	BUG_ON(length > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
 	if (dio->flags & IOMAP_DIO_WRITE) {
 		loff_t size = inode->i_size;
@@ -394,7 +395,8 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 			mark_inode_dirty(inode);
 		}
 	} else {
-		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
+		copied = copy_to_iter(iomap->inline_data + pos - iomap->offset,
+				length, iter);
 	}
 	dio->size += copied;
 	return copied;
-- 
2.30.2

