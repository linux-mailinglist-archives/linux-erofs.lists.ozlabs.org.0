Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8971650E3
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 22:02:43 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48N9Ch15Z0zDqD5
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Feb 2020 08:02:40 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=ZzC5IVFh; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48N99w2snTzDqNC
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Feb 2020 08:01:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=kI+e3DKHZCvuETM0kGlQ5Wq6KkhuqIaWlS8EiD2lk0A=; b=ZzC5IVFh0zlc1y+RlFNcNpnUtw
 Rge9z5CBVAmxghZo5qqYsD0k2HEyUgXnAgk0o1iJvoENMLpE1iyVC53S+MIvgvKsQ7v098DYPZc2m
 KF32Sjd1voZIcKRvwP8HuYAU8AoNCWgXiGYtvHra3cRAKlyf/kexaB6/QH43CRRhuIQGSXUZ+HtfS
 8hu9zW+gfrUNOvtp+JCnoAMo6GnCXTByaQRymMZ2omEv+9/G9JWerFHF7ao5084aXIYWiRNI3h62w
 yMud0oTZuBULmwcHEZAf3C8oIapUf/waEYUsFR02ezCMGOo/qJrfJqrG+7AAtFgyZifl8unYi8fx/
 KfHDS9Cw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4WSv-0008Ti-0Z; Wed, 19 Feb 2020 21:01:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 08/24] mm: Remove 'page_offset' from readahead loop
Date: Wed, 19 Feb 2020 13:00:47 -0800
Message-Id: <20200219210103.32400-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200219210103.32400-1-willy@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
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

Replace the page_offset variable with 'index + i'.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 8a25fc7e2bf2..83df5c061d33 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -181,12 +181,10 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	 * Preallocate as many pages as we will need.
 	 */
 	for (i = 0; i < nr_to_read; i++) {
-		pgoff_t page_offset = index + i;
-
-		if (page_offset > end_index)
+		if (index + i > end_index)
 			break;
 
-		page = xa_load(&mapping->i_pages, page_offset);
+		page = xa_load(&mapping->i_pages, index + i);
 		if (page && !xa_is_value(page)) {
 			/*
 			 * Page already present?  Kick off the current batch of
@@ -200,7 +198,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		page = __page_cache_alloc(gfp_mask);
 		if (!page)
 			break;
-		page->index = page_offset;
+		page->index = index + i;
 		list_add(&page->lru, &page_pool);
 		if (i == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
-- 
2.25.0

