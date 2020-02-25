Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id A92F216F22E
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2020 22:51:51 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Rt1b4bZqzDqF6
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Feb 2020 08:51:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Rsy46LL3zDqFM
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Feb 2020 08:48:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=vmBYSWiADbzhrnAmLI0opbogq5zBVEJUJhOq4kDcPa8=; b=eLGdqJe3Wpv+/w36Kw9lMzkWe2
 muOjRb9XmOLI+XfU/D0HqCwq0c0A+rgT2XvDOzoLikexaFECuBqdqM3q0X0VVsFZXDGrh46bXFwLr
 zpc4n1pMWEgpllNb9lQqDYVqpf7+5SsDWBWrGB6Mi+jiOZkq3xN5zavbTvq3VwzPlJplhDBLUeq+h
 i5HgW/WJOIrP2NeuzEa+Gh10M9FogPkyWnPpVSxVKYKyhuiYn5hIS8hAl/fwUpKzqXrCMZOknqc/8
 J8PtWOG2c3IMyUpm25L8fUXFo6wyvoJ22FS1R2oFj3WQcTsdnEOWCRK8OWSzK5zjNuSRq3b07ozah
 PPV2wMtA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j6i4H-0007qu-Jc; Tue, 25 Feb 2020 21:48:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v8 19/25] erofs: Convert compressed files from readpages to
 readahead
Date: Tue, 25 Feb 2020 13:48:32 -0800
Message-Id: <20200225214838.30017-20-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200225214838.30017-1-willy@infradead.org>
References: <20200225214838.30017-1-willy@infradead.org>
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 Dave Chinner <dchinner@redhat.com>, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the new readahead operation in erofs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 fs/erofs/zdata.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 17f45fcb8c5c..e64d8ab0900d 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1303,28 +1303,23 @@ static bool should_decompress_synchronously(struct erofs_sb_info *sbi,
 	return nr <= sbi->max_sync_decompress_pages;
 }
 
-static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
-			     struct list_head *pages, unsigned int nr_pages)
+static void z_erofs_readahead(struct readahead_control *rac)
 {
-	struct inode *const inode = mapping->host;
+	struct inode *const inode = rac->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 
-	bool sync = should_decompress_synchronously(sbi, nr_pages);
+	bool sync = should_decompress_synchronously(sbi, readahead_count(rac));
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
-	gfp_t gfp = mapping_gfp_constraint(mapping, GFP_KERNEL);
-	struct page *head = NULL;
+	struct page *page, *head = NULL;
 	LIST_HEAD(pagepool);
 
-	trace_erofs_readpages(mapping->host, lru_to_page(pages)->index,
-			      nr_pages, false);
+	trace_erofs_readpages(inode, readahead_index(rac),
+			readahead_count(rac), false);
 
-	f.headoffset = (erofs_off_t)lru_to_page(pages)->index << PAGE_SHIFT;
-
-	for (; nr_pages; --nr_pages) {
-		struct page *page = lru_to_page(pages);
+	f.headoffset = readahead_pos(rac);
 
+	while ((page = readahead_page(rac))) {
 		prefetchw(&page->flags);
-		list_del(&page->lru);
 
 		/*
 		 * A pure asynchronous readahead is indicated if
@@ -1333,11 +1328,6 @@ static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
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
@@ -1366,11 +1356,10 @@ static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
 
 	/* clean up the remaining free pages */
 	put_pages_list(&pagepool);
-	return 0;
 }
 
 const struct address_space_operations z_erofs_aops = {
 	.readpage = z_erofs_readpage,
-	.readpages = z_erofs_readpages,
+	.readahead = z_erofs_readahead,
 };
 
-- 
2.25.0

