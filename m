Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75296939BBD
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jul 2024 09:30:46 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nEDimZ4Y;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WSpj02gDZz3cdZ
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jul 2024 17:30:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nEDimZ4Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WSphs1sdgz3cWc
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jul 2024 17:30:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721719830; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HB1dyrSyOC/tIOSBfm9aosUYtjucq0jEOTKIvfimrw0=;
	b=nEDimZ4Y980qbdANfEcdpdAp4eBVt33i06YxuVMYLhS8r4G6NZizNN8p58mTCZ1iDKKjPnrEx5qzcYJ8ub0vPsJMh1wFH95eey/ZK8QelB0dkZVyanp7P8QnUptULj/5jwSnurxLi9tsOhfG6MwjrqBbXFTu+4Mdmc9uY5T1Zgc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0WB8jQxT_1721719825;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WB8jQxT_1721719825)
          by smtp.aliyun-inc.com;
          Tue, 23 Jul 2024 15:30:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: support multi-page folios for erofs_bread()
Date: Tue, 23 Jul 2024 15:30:24 +0800
Message-ID: <20240723073024.875290-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

If the requested page is part of the previous multi-page folio, there
is no need to call read_mapping_folio() again.

Also, get rid of the remaining one of page->index [1] in our codebase.

[1] https://lore.kernel.org/r/Zp8fgUSIBGQ1TN0D@casper.infradead.org
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
(I plan to test now and take this for this cycle since this patch is
 not quite complex.)

 fs/erofs/data.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 8be60797ea2f..4b8b2b004453 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -21,38 +21,33 @@ void erofs_put_metabuf(struct erofs_buf *buf)
 	if (!buf->page)
 		return;
 	erofs_unmap_metabuf(buf);
-	put_page(buf->page);
+	folio_put(page_folio(buf->page));
 	buf->page = NULL;
 }
 
-/*
- * Derive the block size from inode->i_blkbits to make compatible with
- * anonymous inode in fscache mode.
- */
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
 		  enum erofs_kmap_type type)
 {
 	pgoff_t index = offset >> PAGE_SHIFT;
-	struct page *page = buf->page;
-	struct folio *folio;
-	unsigned int nofs_flag;
+	struct folio *folio = NULL;
 
-	if (!page || page->index != index) {
+	if (buf->page) {
+		folio = page_folio(buf->page);
+		if (folio_file_page(folio, index) != buf->page)
+			erofs_unmap_metabuf(buf);
+	}
+	if (!folio || !folio_contains(folio, index)) {
 		erofs_put_metabuf(buf);
 
-		nofs_flag = memalloc_nofs_save();
-		folio = read_cache_folio(buf->mapping, index, NULL, NULL);
-		memalloc_nofs_restore(nofs_flag);
+		folio = read_mapping_folio(buf->mapping, index, NULL);
 		if (IS_ERR(folio))
 			return folio;
-
-		/* should already be PageUptodate, no need to lock page */
-		page = folio_file_page(folio, index);
-		buf->page = page;
 	}
+	buf->page = folio_file_page(folio, index);
+
 	if (buf->kmap_type == EROFS_NO_KMAP) {
 		if (type == EROFS_KMAP)
-			buf->base = kmap_local_page(page);
+			buf->base = kmap_local_page(buf->page);
 		buf->kmap_type = type;
 	} else if (buf->kmap_type != type) {
 		DBG_BUGON(1);
-- 
2.43.5

