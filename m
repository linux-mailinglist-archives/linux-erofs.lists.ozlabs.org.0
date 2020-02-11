Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3F215876F
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2020 02:05:04 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Gl1T2DmVzDqGS
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2020 12:05:01 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=Isw5m/tT; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Gl0D68gZzDqCX
 for <linux-erofs@lists.ozlabs.org>; Tue, 11 Feb 2020 12:03:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=MOOCl0kElclaL12Bo2vdDIW4gCL68Y7X1xBVMIbuM80=; b=Isw5m/tToyqF5hw2BHaQc66txg
 PLpadc/3h5L6eAeruvyIBlnGL1PP7HBjXzQGHBrgDRT079Q3r/xXZRoyDxjg9eYDqeL9RoWbECgEm
 IViGYNLoYxC8uf/tZ96aGfepdrMqdPmTsRd0IMjX/2KZemd3naXkvF6oAY3AtJ8V4hqLrYX9oKGei
 WdFEds4K+gW630ResAlErqadDoitOedK0m1LuInhQW/SaVHIon6X3nGWBFlKNaEWcziZjkDcH9c4A
 MYXX/W4UN0+2jmsJlL97B3nSSMEXmyOgLqdqFqdm+QN3vnSEn0/Zyg8JczgtVc92uJp3BUxRQVhaa
 4qj969Yw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j1Jxu-0001nl-BQ; Tue, 11 Feb 2020 01:03:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 02/13] mm: Ignore return value of ->readpages
Date: Mon, 10 Feb 2020 17:03:37 -0800
Message-Id: <20200211010348.6872-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200211010348.6872-1-willy@infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
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
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

We used to assign the return value to a variable, which we then ignored.
Remove the pretence of caring.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 6bf73ef33b7e..fc77d13af556 100644
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

