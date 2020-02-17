Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2585C161A37
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2020 19:47:21 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48LtJQ2LJlzDqXv
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2020 05:47:18 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=KwiTBfAm; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48LtHK1s8MzDqgd
 for <linux-erofs@lists.ozlabs.org>; Tue, 18 Feb 2020 05:46:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=+TXbfoC7OhLaTWBRfdmrI045E/aNC188d51jOi0q5AY=; b=KwiTBfAmNSramg93zsbmeMe93l
 ZrqnhSVfpTjg1D+RZ65c/0U+Gzn6kYjk8i98GZCTSnNxpNztwTENNatDJ6HdQDKXjmzilkYKcMSUr
 +lO9Xs8zhoQQf02i4Im2eZpLW+0bpjyxbYdZPqv43MIYmbmwXnrCvbi4rvMZBjnmHBn5YE/N+YoJC
 Zczha9h/rPLXmuCp/L/K+qpguhk9+Z21I0xrPieUJ49fusKlLYnmksE4sHTjNVRPLlLJlVB6bV6N4
 8+B4iJV9GlxmS9pkW8wqfJ7SJe5gFiLNb/A99vIJeJ/uLIqdZFaRAYKCFVCaXiBob2S6z5qTej1B6
 up3uu9Ig==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j3lPL-00058j-BO; Mon, 17 Feb 2020 18:46:15 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 02/19] mm: Ignore return value of ->readpages
Date: Mon, 17 Feb 2020 10:45:43 -0800
Message-Id: <20200217184613.19668-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217184613.19668-1-willy@infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
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
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

We used to assign the return value to a variable, which we then ignored.
Remove the pretence of caring.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/readahead.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 8ce46d69e6ae..12d13b7792da 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -113,17 +113,16 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
 
 EXPORT_SYMBOL(read_cache_pages);
 
-static int read_pages(struct address_space *mapping, struct file *filp,
+static void read_pages(struct address_space *mapping, struct file *filp,
 		struct list_head *pages, unsigned int nr_pages, gfp_t gfp)
 {
 	struct blk_plug plug;
 	unsigned page_idx;
-	int ret;
 
 	blk_start_plug(&plug);
 
 	if (mapping->a_ops->readpages) {
-		ret = mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
+		mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
 		/* Clean up the remaining pages */
 		put_pages_list(pages);
 		goto out;
@@ -136,12 +135,9 @@ static int read_pages(struct address_space *mapping, struct file *filp,
 			mapping->a_ops->readpage(filp, page);
 		put_page(page);
 	}
-	ret = 0;
 
 out:
 	blk_finish_plug(&plug);
-
-	return ret;
 }
 
 /*
-- 
2.25.0

