Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E39171492A2
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2020 02:36:28 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 484JWZ0zy3zDqgs
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2020 12:36:26 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=COEUCYCq; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 484JW22jnTzDqgC
 for <linux-erofs@lists.ozlabs.org>; Sat, 25 Jan 2020 12:35:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=04UCiG/20t3FCGYn9DWPtGoOuyQcfxr5hH9Iq5Vewm4=; b=COEUCYCqKEjyVamYeoH8fXaTOX
 9KTszdyPH+LaFUpmmD9eVqUTOJ16y/yVdI6WF6/nMDNEQv+mxhDYCizNvwn1iGCpcLGsSgpqdnqAZ
 Nsuu1+5POYrllMfRGKyj7/bBG2c1opmtREx1IKmq5G1Ppqyb8ORrfys48Pahlfr1VQmZM7qU3Kb0b
 79V8GJOsUg8MyhWViXRWt0GL3sqcd01ohY41EWHI/3DaX5GMQof8exvHWhbBYGxu2JpG5R2epSiH3
 /lHrqA38FKS9CKpnlLy/IQRWWWpW97JEjF1FqjUBt90RiJWBFxwt0sSJ7w315eLm6DzGPEf2bzQY/
 e9hA3Vqg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1ivAMd-0006Vp-EK; Sat, 25 Jan 2020 01:35:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/12] erofs: Convert compressed files from readpages to
 readahead
Date: Fri, 24 Jan 2020 17:35:49 -0800
Message-Id: <20200125013553.24899-9-willy@infradead.org>
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

Use the new readahead operation in erofs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: linux-erofs@lists.ozlabs.org
---
 fs/erofs/zdata.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d3dd8cf1fc01..20efb87dd957 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1328,28 +1328,26 @@ static bool should_decompress_synchronously(struct erofs_sb_info *sbi,
 	return nr <= sbi->max_sync_decompress_pages;
 }
 
-static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
-			     struct list_head *pages, unsigned int nr_pages)
+static
+unsigned z_erofs_readahead(struct file *file, struct address_space *mapping,
+			     pgoff_t start, unsigned int nr_pages)
 {
 	struct inode *const inode = mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 
 	bool sync = should_decompress_synchronously(sbi, nr_pages);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
-	gfp_t gfp = mapping_gfp_constraint(mapping, GFP_KERNEL);
 	struct page *head = NULL;
 	LIST_HEAD(pagepool);
 
-	trace_erofs_readpages(mapping->host, lru_to_page(pages)->index,
-			      nr_pages, false);
+	trace_erofs_readpages(inode, start, nr_pages, false);
 
-	f.headoffset = (erofs_off_t)lru_to_page(pages)->index << PAGE_SHIFT;
+	f.headoffset = (erofs_off_t)start << PAGE_SHIFT;
 
 	for (; nr_pages; --nr_pages) {
-		struct page *page = lru_to_page(pages);
+		struct page *page = readahead_page(mapping, start);
 
 		prefetchw(&page->flags);
-		list_del(&page->lru);
 
 		/*
 		 * A pure asynchronous readahead is indicated if
@@ -1358,11 +1356,6 @@ static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
 		 */
 		sync &= !(PageReadahead(page) && !head);
 
-		if (add_to_page_cache_lru(page, mapping, page->index, gfp)) {
-			list_add(&page->lru, &pagepool);
-			continue;
-		}
-
 		set_page_private(page, (unsigned long)head);
 		head = page;
 	}
@@ -1396,6 +1389,6 @@ static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
 
 const struct address_space_operations z_erofs_aops = {
 	.readpage = z_erofs_readpage,
-	.readpages = z_erofs_readpages,
+	.readahead = z_erofs_readahead,
 };
 
-- 
2.24.1

