Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B677E4AA7
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Nov 2023 22:27:36 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=qvaEl+On;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SQ1X64B9mz3bxZ
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Nov 2023 08:27:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=qvaEl+On;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SQ1WW5T44z2yVZ
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 Nov 2023 08:27:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=lkRC7Bno9DMh6U/8dcyjn2uoQxPsQ9ZkkBeHr6QdQXc=; b=qvaEl+OnLXfSQi27oJIuxxgw/f
	pcHChr1doAR5IJsp57EmVuuypKh5J7C1t3dACGsq4kXC74yDDP4rRy5irG0n8jE9/IRBodPRqZ/2z
	aGo3EOiIfNoUSsA68+IU7JLv9+7Zpbrp1CEif/NZ5UH30jwe0Ix5qg3LVU/FTxt/8J587B+hEaBGj
	YCIA2GgcwDNw1o7c+WriS4JuWbB8zQ1OdnlUB+dahdQBY2SHI1acyDtpR+gWNXm1hy0XWdewtIdNt
	hTsTvoWdSvGz7CSS6+3DAlR8yBBwAGNHYExaun3WAkutpeFQwLEn/+lKq/FC8VhwgEZ+5tEsdCKoa
	yrhLKNmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0Tav-00Ee0V-3c; Tue, 07 Nov 2023 21:26:45 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/3] mm: Add folio_zero_tail() and use it in ext4
Date: Tue,  7 Nov 2023 21:26:40 +0000
Message-Id: <20231107212643.3490372-2-willy@infradead.org>
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

Instead of unmapping the folio after copying the data to it, then mapping
it again to zero the tail, provide folio_zero_tail() to zero the tail
of an already-mapped folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inline.c        |  3 +--
 include/linux/highmem.h | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 9a84a5f9fef4..d5bd1e3a5d36 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -502,9 +502,8 @@ static int ext4_read_inline_folio(struct inode *inode, struct folio *folio)
 	BUG_ON(len > PAGE_SIZE);
 	kaddr = kmap_local_folio(folio, 0);
 	ret = ext4_read_inline_data(inode, kaddr, len, &iloc);
-	flush_dcache_folio(folio);
+	kaddr = folio_zero_tail(folio, len, kaddr + len);
 	kunmap_local(kaddr);
-	folio_zero_segment(folio, len, folio_size(folio));
 	folio_mark_uptodate(folio);
 	brelse(iloc.bh);
 
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 4cacc0e43b51..1b81416196dd 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -483,6 +483,44 @@ static inline void memcpy_to_folio(struct folio *folio, size_t offset,
 	flush_dcache_folio(folio);
 }
 
+/**
+ * folio_zero_tail - Zero the tail of a folio.
+ * @folio: The folio to zero.
+ * @kaddr: The address the folio is currently mapped to.
+ * @offset: The byte offset in the folio to start zeroing at.
+ *
+ * If you have already used kmap_local_folio() to map a folio, written
+ * some data to it and now need to zero the end of the folio (and flush
+ * the dcache), you can use this function.  If you do not have the
+ * folio kmapped (eg the folio has been partially populated by DMA),
+ * use folio_zero_range() or folio_zero_segment() instead.
+ *
+ * Return: An address which can be passed to kunmap_local().
+ */
+static inline __must_check void *folio_zero_tail(struct folio *folio,
+		size_t offset, void *kaddr)
+{
+	size_t len = folio_size(folio) - offset;
+
+	if (folio_test_highmem(folio)) {
+		size_t max = PAGE_SIZE - offset_in_page(offset);
+
+		while (len > max) {
+			memset(kaddr, 0, max);
+			kunmap_local(kaddr);
+			len -= max;
+			offset += max;
+			max = PAGE_SIZE;
+			kaddr = kmap_local_folio(folio, offset);
+		}
+	}
+
+	memset(kaddr, 0, len);
+	flush_dcache_folio(folio);
+
+	return kaddr;
+}
+
 /**
  * memcpy_from_file_folio - Copy some bytes from a file folio.
  * @to: The destination buffer.
-- 
2.42.0

