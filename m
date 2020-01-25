Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFB11492AA
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2020 02:36:37 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 484JWk0r5WzDqgj
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2020 12:36:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=dyR6fc6y; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 484JW50BQBzDqgG
 for <linux-erofs@lists.ozlabs.org>; Sat, 25 Jan 2020 12:36:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ldyBROX4ttpX20xjGcZ0P9RkozwGCLMwi7om00TCIb8=; b=dyR6fc6y9sdVtK/E+BuhZ9EVVF
 mr0y+PMYQ0N7jUnGxzxKPi8UI68siHl1iJL5omatmrcERsFESzhoeWGX66TkS/UM4Zs29rvPx8VV7
 SSFPZivDF0kzqiosJk8HmWPRxj4DJ5qQBtt0BS8Jfng2qcBxG970OV44R1EaSbdA1EIti3/ocHPzf
 eYkPs8iOf547JKSDVIkvfg2aJJ/2U6nVZzVjFevdQRKAuKNUDlZ+Pr0Mj0QaaIAFzSrxrjljkcFhu
 FURJN+d83dnQol8EYNSD/v5SpxfiubylgjHMtL0teGBENyW1mAd2sOqbyo/KPsRj+AHV9UDIqOtsb
 VJuUsloA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1ivAMd-0006Vi-DH; Sat, 25 Jan 2020 01:35:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/12] erofs: Convert uncompressed files from readpages to
 readahead
Date: Fri, 24 Jan 2020 17:35:48 -0800
Message-Id: <20200125013553.24899-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200125013553.24899-1-willy@infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
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
Cc: linux-mm@kvack.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the new readahead operation in erofs.  Fix what I believe to be
a refcounting bug in the error case.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: linux-erofs@lists.ozlabs.org
---
 fs/erofs/data.c              | 34 ++++++++++++++--------------------
 fs/erofs/zdata.c             |  2 +-
 include/trace/events/erofs.h |  6 +++---
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fc3a8d8064f8..335c1ab05312 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -280,42 +280,36 @@ static int erofs_raw_access_readpage(struct file *file, struct page *page)
 	return 0;
 }
 
-static int erofs_raw_access_readpages(struct file *filp,
+static unsigned erofs_raw_access_readahead(struct file *file,
 				      struct address_space *mapping,
-				      struct list_head *pages,
+				      pgoff_t start,
 				      unsigned int nr_pages)
 {
 	erofs_off_t last_block;
 	struct bio *bio = NULL;
-	gfp_t gfp = readahead_gfp_mask(mapping);
-	struct page *page = list_last_entry(pages, struct page, lru);
 
-	trace_erofs_readpages(mapping->host, page, nr_pages, true);
+	trace_erofs_readpages(mapping->host, start, nr_pages, true);
 
 	for (; nr_pages; --nr_pages) {
-		page = list_entry(pages->prev, struct page, lru);
+		struct page *page = readahead_page(mapping, start++);
 
 		prefetchw(&page->flags);
-		list_del(&page->lru);
 
-		if (!add_to_page_cache_lru(page, mapping, page->index, gfp)) {
-			bio = erofs_read_raw_page(bio, mapping, page,
-						  &last_block, nr_pages, true);
+		bio = erofs_read_raw_page(bio, mapping, page, &last_block,
+				nr_pages, true);
 
-			/* all the page errors are ignored when readahead */
-			if (IS_ERR(bio)) {
-				pr_err("%s, readahead error at page %lu of nid %llu\n",
-				       __func__, page->index,
-				       EROFS_I(mapping->host)->nid);
+		/* all the page errors are ignored when readahead */
+		if (IS_ERR(bio)) {
+			pr_err("%s, readahead error at page %lu of nid %llu\n",
+			       __func__, page->index,
+			       EROFS_I(mapping->host)->nid);
 
-				bio = NULL;
-			}
+			bio = NULL;
+			put_page(page);
 		}
 
-		/* pages could still be locked */
 		put_page(page);
 	}
-	DBG_BUGON(!list_empty(pages));
 
 	/* the rare case (end in gaps) */
 	if (bio)
@@ -358,7 +352,7 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
 /* for uncompressed (aligned) files and raw access for other files */
 const struct address_space_operations erofs_raw_access_aops = {
 	.readpage = erofs_raw_access_readpage,
-	.readpages = erofs_raw_access_readpages,
+	.readahead = erofs_raw_access_readahead,
 	.bmap = erofs_bmap,
 };
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ca99425a4536..d3dd8cf1fc01 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1340,7 +1340,7 @@ static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
 	struct page *head = NULL;
 	LIST_HEAD(pagepool);
 
-	trace_erofs_readpages(mapping->host, lru_to_page(pages),
+	trace_erofs_readpages(mapping->host, lru_to_page(pages)->index,
 			      nr_pages, false);
 
 	f.headoffset = (erofs_off_t)lru_to_page(pages)->index << PAGE_SHIFT;
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index 27f5caa6299a..bf9806fd1306 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -113,10 +113,10 @@ TRACE_EVENT(erofs_readpage,
 
 TRACE_EVENT(erofs_readpages,
 
-	TP_PROTO(struct inode *inode, struct page *page, unsigned int nrpage,
+	TP_PROTO(struct inode *inode, pgoff_t start, unsigned int nrpage,
 		bool raw),
 
-	TP_ARGS(inode, page, nrpage, raw),
+	TP_ARGS(inode, start, nrpage, raw),
 
 	TP_STRUCT__entry(
 		__field(dev_t,		dev	)
@@ -129,7 +129,7 @@ TRACE_EVENT(erofs_readpages,
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->nid	= EROFS_I(inode)->nid;
-		__entry->start	= page->index;
+		__entry->start	= start;
 		__entry->nrpage	= nrpage;
 		__entry->raw	= raw;
 	),
-- 
2.24.1

