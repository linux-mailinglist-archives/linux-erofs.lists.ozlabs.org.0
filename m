Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E66A43CB943
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jul 2021 17:02:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GRDxg62kBz305k
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Jul 2021 01:02:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=MQxqwRDB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=MQxqwRDB; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GRDxd05HXz2yN4
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Jul 2021 01:02:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=qu55q+Wr3c7nhfV+FWSDuP1bQTjuk+H0uzhdHS2+IkU=; b=MQxqwRDBGj/PAKh/l7fZFZzlSh
 1UZ0IMYIjMZueoCINAu+PJtkqnKREZjdnohgCGsI/PAC/B2ueDFZICpqBtq6LLBNpY6Xdo8T8IUW4
 /2GrIOUfDX9stzRA2FD4N8x4WR4EM+X03WV73VhDG883Q8u/ZoG9Pm/OEfZ4wJwDOKtCt5U1q4rj4
 lDuIai9pXCpu8KlGHtewBCl+kkXv34wNUJeh4n3lM5B9QPzGA7xeiRoFyvleHRsWKKmvjjLF0bVpx
 1xXWh8SesJtPYfVs1vy3z+hOQbw2PA5FpoynPThmdEVFNZBe72hE0sgdh2+9hXjUpimUBjB181Dhb
 wcWaZzrg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m4PKO-004ZZS-U6; Fri, 16 Jul 2021 15:01:09 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>,
 Christoph Hellwig <hch@infradead.org>,
 "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH] iomap: Add missing flush_dcache_page
Date: Fri, 16 Jul 2021 16:00:32 +0100
Message-Id: <20210716150032.1089982-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
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
Cc: stable@vger.kernel.org, linux-xfs@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Inline data needs to be flushed from the kernel's view of a page before
it's mapped by userspace.

Cc: stable@vger.kernel.org
Fixes: 19e0c58f6552 ("iomap: generic inline data handling")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 41da4f14c00b..fe60c603f4ca 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -222,6 +222,7 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - size);
 	kunmap_atomic(addr);
+	flush_dcache_page(page);
 	SetPageUptodate(page);
 }
 
-- 
2.30.2

