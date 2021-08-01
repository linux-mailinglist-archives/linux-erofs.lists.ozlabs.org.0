Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 941DC3DCB20
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Aug 2021 12:29:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gcy6z6GWLz306R
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Aug 2021 20:29:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WRvpjNR1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bm5ddcPg;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=agruenba@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=WRvpjNR1; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bm5ddcPg; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gcy6r1NKfz2yMx
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Aug 2021 20:29:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627813756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UDxWt+sEuVG0LPlCn9qMoQx2SKQ+E9926WuBDpTN9gM=;
 b=WRvpjNR1F4ne4pOjLRErC7Z2PWOsHfqHuuw5Cuc01eZeZuH47Rtsgqb4rnqAlZr37wm3Ua
 Wa7xVue9XKMhum98MhA8z7FWaNYZGnC6tV2K/Q/B3GXLVpm86w8+TfL/rDajXyfeRVlSfn
 FtPqLp+F3WLG9V053Tfcg5W4xWU5QN8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627813757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UDxWt+sEuVG0LPlCn9qMoQx2SKQ+E9926WuBDpTN9gM=;
 b=Bm5ddcPgvj9/heC8n4Xt4Hn5K0cQCv0+0hkgnus07gMNhElgqqtD8EE+zLZzwFkBPwn31q
 RwSR16f6rOD08jxBl5WqIsHpUMm1GxlAfEk6MtRtB+QUfCxWKB6jdVOAtImKTqJAl7O72m
 /mtiI+qgtoglYXcVSIBhV61Qx3Z+mgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-epcbb47KOwGRsYd6bO8vaA-1; Sun, 01 Aug 2021 06:29:12 -0400
X-MC-Unique: epcbb47KOwGRsYd6bO8vaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0FA8107ACF5;
 Sun,  1 Aug 2021 10:29:10 +0000 (UTC)
Received: from max.com (unknown [10.40.193.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF4231036D04;
 Sun,  1 Aug 2021 10:29:07 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Date: Sun,  1 Aug 2021 12:29:06 +0200
Message-Id: <20210801102906.833977-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 "Darrick J . Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 26, 2021 at 2:33 PM Matthew Wilcox <willy@infradead.org> wrote:
> Only tangentially related ... why do we memcpy the data into the tail
> at write_end() time instead of at writepage() time?  I see there's a
> workaround for that in gfs2's page_mkwrite():
>
>         if (gfs2_is_stuffed(ip)) {
>                 err = gfs2_unstuff_dinode(ip);
>
> (an mmap store cannot change the size of the file, so this would be
> unnecessary)
>
> Something like this ...

We can't just bail out after iomap_write_inline_data in
iomap_writepage_map; the page also needs to be unlocked.  Also, we want
to dirty the inode after copying out the inline data and unlocking the
page to make sure the inode gets written out.

Not sure if this can be further simplified.

Tested on gfs2 on top of:

 [PATCH v9] iomap: Support file tail packing [1]
 [PATCH v2] iomap: Support inline data with block size < page size [2]
 [PATCH] gfs2: iomap inline data handling cleanup [3]

[1] https://lore.kernel.org/linux-fsdevel/20210727025956.80684-1-hsiangkao@linux.alibaba.com/	
[2] https://lore.kernel.org/linux-fsdevel/20210729032344.3975412-1-willy@infradead.org/
[3] https://listman.redhat.com/archives/cluster-devel/2021-July/msg00244.html

Thanks,
Andreas

---
 fs/gfs2/bmap.c         |  3 ---
 fs/gfs2/file.c         |  9 ---------
 fs/iomap/buffered-io.c | 29 +++++++++++++++++++----------
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 84ad0fe787ea..4cea16d6a3fa 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2527,9 +2527,6 @@ static int gfs2_map_blocks(struct iomap_writepage_ctx *wpc, struct inode *inode,
 {
 	int ret;
 
-	if (WARN_ON_ONCE(gfs2_is_stuffed(GFS2_I(inode))))
-		return -EIO;
-
 	if (offset >= wpc->iomap.offset &&
 	    offset < wpc->iomap.offset + wpc->iomap.length)
 		return 0;
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 84ec053d43b4..ce8f5eb66db7 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -510,15 +510,6 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 		goto out_trans_fail;
 	}
 
-	/* Unstuff, if required, and allocate backing blocks for page */
-	if (gfs2_is_stuffed(ip)) {
-		err = gfs2_unstuff_dinode(ip);
-		if (err) {
-			ret = block_page_mkwrite_return(err);
-			goto out_trans_end;
-		}
-	}
-
 	lock_page(page);
 	/* If truncated, we must retry the operation, we may have raced
 	 * with the glock demotion code.
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 77d4fe5c1327..a1eb876a9445 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -683,21 +683,23 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	return copied;
 }
 
-static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
-		struct iomap *iomap, loff_t pos, size_t copied)
+static int iomap_write_inline_data(struct inode *inode, struct page *page,
+		struct iomap *iomap)
 {
+	size_t size = i_size_read(inode) - page_offset(page);
 	void *addr;
 
 	WARN_ON_ONCE(!PageUptodate(page));
 	BUG_ON(!iomap_inline_data_valid(iomap));
+	if (WARN_ON_ONCE(size > iomap->length))
+		return -EIO;
 
 	flush_dcache_page(page);
 	addr = kmap_atomic(page);
-	memcpy(iomap_inline_data(iomap, pos), addr + pos, copied);
+	memcpy(iomap->inline_data, addr, size);
 	kunmap_atomic(addr);
 
-	mark_inode_dirty(inode);
-	return copied;
+	return 0;
 }
 
 /* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
@@ -709,9 +711,7 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	loff_t old_size = inode->i_size;
 	size_t ret;
 
-	if (srcmap->type == IOMAP_INLINE) {
-		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
-	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
+	if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
 		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
 				page, NULL);
 	} else {
@@ -1329,6 +1329,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	u64 file_offset; /* file offset of page */
 	int error = 0, count = 0, i;
 	LIST_HEAD(submit_list);
+	bool dirty_inode = false;
 
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
 
@@ -1346,8 +1347,13 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		error = wpc->ops->map_blocks(wpc, inode, file_offset);
 		if (error)
 			break;
-		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
-			continue;
+		if (wpc->iomap.type == IOMAP_INLINE) {
+			error = iomap_write_inline_data(inode, page,
+					&wpc->iomap);
+			if (!error)
+				dirty_inode = true;
+			break;
+		}
 		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
 		iomap_add_to_ioend(inode, file_offset, page, iop, wpc, wbc,
@@ -1405,6 +1411,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 */
 	if (!count)
 		end_page_writeback(page);
+
+	if (dirty_inode)
+		mark_inode_dirty(inode);
 done:
 	mapping_set_error(page->mapping, error);
 	return error;
-- 
2.26.3

