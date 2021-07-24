Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A1D3D44A0
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 05:46:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GWsYL4BBqz303D
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 13:46:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=jSlxkZ6d;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=jSlxkZ6d; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GWsYJ1wV8z30CJ
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Jul 2021 13:46:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=1QGe1P+AGqPkdhsfqm260/tVRR1SHgGtiI0q85LYd9Q=; b=jSlxkZ6dt/BkPAjxJiUzNne+Pe
 HH17ELba5ZgaAT8GAODPfsrtbkqJiDore0EwcW1z8WohZAWAFQnNmExwprf3CUe+TIG7cqMI5jald
 U1vmlL//zcytFzEEZPe6/TMnZzXOBZ1D1q9J90kg1BMMfuSCuy7gaGbg3m8yMbgW8k4Je2zf8Rftt
 iZ/Q+Ep+gKHR0srywwmGkdm09XJcGkDVQ9eYOjsWjZaJIeQiSRez1tgT0N+PrmSdtfsnM4JTE9iTT
 QGa7y79iCKOuFuN3oYwT1aX9Rmrk+gyn80a58YahVgFt5rN6n3OnymJ5zsamU1ywrGep/wwGsPgzg
 h7xKNjkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m78bS-00Byb9-SM; Sat, 24 Jul 2021 03:45:36 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org
Subject: [PATCH 2/2] iomap: Support inline data with block size < page size
Date: Sat, 24 Jul 2021 04:44:35 +0100
Message-Id: <20210724034435.2854295-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210724034435.2854295-1-willy@infradead.org>
References: <20210724034435.2854295-1-willy@infradead.org>
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
Cc: "Matthew Wilcox \(Oracle\)" <willy@infradead.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Remove the restriction that inline data must start on a page boundary
in a file.  This allows, for example, the first 2KiB to be stored out
of line and the trailing 30 bytes to be stored inline.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7bd8e5de996d..d7d6af29af7f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -209,25 +209,23 @@ static int iomap_read_inline_data(struct inode *inode, struct page *page,
 		struct iomap *iomap, loff_t pos)
 {
 	size_t size = iomap->length + iomap->offset - pos;
+	size_t poff = offset_in_page(pos);
 	void *addr;
 
 	if (PageUptodate(page))
-		return PAGE_SIZE;
+		return PAGE_SIZE - poff;
 
-	/* inline data must start page aligned in the file */
-	if (WARN_ON_ONCE(offset_in_page(pos)))
-		return -EIO;
 	if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
 		return -EIO;
-	if (WARN_ON_ONCE(page_has_private(page)))
-		return -EIO;
+	if (poff > 0)
+		iomap_page_create(inode, page);
 
-	addr = kmap_atomic(page);
+	addr = kmap_atomic(page) + poff;
 	memcpy(addr, iomap_inline_buf(iomap, pos), size);
-	memset(addr + size, 0, PAGE_SIZE - size);
+	memset(addr + size, 0, PAGE_SIZE - poff - size);
 	kunmap_atomic(addr);
-	SetPageUptodate(page);
-	return PAGE_SIZE;
+	iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
+	return PAGE_SIZE - poff;
 }
 
 static inline bool iomap_block_needs_zeroing(struct inode *inode,
-- 
2.30.2

