Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B2F7E4AA3
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Nov 2023 22:27:18 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=NXRUiGQ1;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SQ1Wl4yQ0z3c2k
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Nov 2023 08:27:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=NXRUiGQ1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SQ1WW5WJnz2ytJ
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 Nov 2023 08:27:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=YwVh6l/W1yK7KiZyEJlfwu5hHInPV2A4ijrPzoQDwKI=; b=NXRUiGQ1reyOncWjpC1pyDdJ+t
	Goyz1m7qTUWS0PRa/Dqn9ZSWvv43hjble24CYNoFlr32oR55XcZH/Jj7lZQw8H4+QtgUfaFWb6Bg1
	lpy32NyNeBhJIQLv69u6pNYFuraoYFPTBVud2E0OB81JpP2aCBnk5F2SXfKYn/TYkAPXbX45LWjEv
	YCQF5Jur5FhRtADhxyVqfdjtTQx6DYyn2v2lOleAdnTl5BIhR+cLF3aK8GnlceSt41tUQrOjOw4lI
	ZvudLz1DMbRYtjOxKV1MhQMqsYpI2wVlhYaf8W7OMT9qySFBUL0TJZCGfq07whhAZ9PNya5D8c2Z7
	QNM1r6Iw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0Tav-00Ee0X-6a; Tue, 07 Nov 2023 21:26:45 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/3] mm: Add folio_fill_tail() and use it in iomap
Date: Tue,  7 Nov 2023 21:26:41 +0000
Message-Id: <20231107212643.3490372-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231107212643.3490372-1-willy@infradead.org>
References: <20231107212643.3490372-1-willy@infradead.org>
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
Cc: linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Andreas Gruenbacher <agruenba@redhat.com>, "Darrick J . Wong" <djwong@kernel.org>, "Matthew Wilcox \(Oracle\)" <willy@infradead.org>, gfs2@lists.linux.dev, Andreas Dilger <adilger.kernel@dilger.ca>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The iomap code was limited to PAGE_SIZE bytes; generalise it to cover
an arbitrary-sized folio, and move it to be a common helper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c  | 14 ++------------
 include/linux/highmem.h | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f72df2babe56..093c4515b22a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -305,28 +305,18 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 {
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
 	size_t size = i_size_read(iter->inode) - iomap->offset;
-	size_t poff = offset_in_page(iomap->offset);
 	size_t offset = offset_in_folio(folio, iomap->offset);
-	void *addr;
 
 	if (folio_test_uptodate(folio))
 		return 0;
 
-	if (WARN_ON_ONCE(size > PAGE_SIZE - poff))
-		return -EIO;
-	if (WARN_ON_ONCE(size > PAGE_SIZE -
-			 offset_in_page(iomap->inline_data)))
-		return -EIO;
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
 	if (offset > 0)
 		ifs_alloc(iter->inode, folio, iter->flags);
 
-	addr = kmap_local_folio(folio, offset);
-	memcpy(addr, iomap->inline_data, size);
-	memset(addr + size, 0, PAGE_SIZE - poff - size);
-	kunmap_local(addr);
-	iomap_set_range_uptodate(folio, offset, PAGE_SIZE - poff);
+	folio_fill_tail(folio, offset, iomap->inline_data, size);
+	iomap_set_range_uptodate(folio, offset, folio_size(folio) - offset);
 	return 0;
 }
 
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 1b81416196dd..0fbb60ffefc9 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -521,6 +521,44 @@ static inline __must_check void *folio_zero_tail(struct folio *folio,
 	return kaddr;
 }
 
+/**
+ * folio_fill_tail - Copy some data to a folio and pad with zeroes.
+ * @folio: The destination folio.
+ * @offset: The offset into @folio at which to start copying.
+ * @from: The data to copy.
+ * @len: How many bytes of data to copy.
+ *
+ * This function is most useful for filesystems which support inline data.
+ * When they want to copy data from the inode into the page cache, this
+ * function does everything for them.  It supports large folios even on
+ * HIGHMEM configurations.
+ */
+static inline void folio_fill_tail(struct folio *folio, size_t offset,
+		const char *from, size_t len)
+{
+	char *to = kmap_local_folio(folio, offset);
+
+	VM_BUG_ON(offset + len > folio_size(folio));
+
+	if (folio_test_highmem(folio)) {
+		size_t max = PAGE_SIZE - offset_in_page(offset);
+
+		while (len > max) {
+			memcpy(to, from, max);
+			kunmap_local(to);
+			len -= max;
+			from += max;
+			offset += max;
+			max = PAGE_SIZE;
+			to = kmap_local_folio(folio, offset);
+		}
+	}
+
+	memcpy(to, from, len);
+	to = folio_zero_tail(folio, offset, to);
+	kunmap_local(to);
+}
+
 /**
  * memcpy_from_file_folio - Copy some bytes from a file folio.
  * @to: The destination buffer.
-- 
2.42.0

