Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCCC16F242
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2020 22:53:19 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Rt3H5q0XzDqMn
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Feb 2020 08:53:15 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 48RsyB0dM6zDqCb
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Feb 2020 08:48:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Y+DMKEcjJ0PUqBzLJKWtCNhcm7v9FUVVuODqcjMIb+g=; b=BZjHVrtyapAW9nHzSJHblAd4t/
 xUJNrmLG2TNmO7evD2q+2vZmy7zGYx6LGzBpBb2n7of903wqbB1Hs2HLZWoVjDD8HKnY80sEtSMUX
 0gf2/0Nyh2X8fCYNCb32ow+1J37VYQtCN+zxSDpZUwtSh8HU27O0EchtXIEBGxHf2aMkR+DASOYrg
 +YCUuZ7iE+3ud0Vixg+pGI7/2z933+k0NXGV5bej6VfCiAYOgteMZvhiofaLA6Xp+6fVmz5wLkkzT
 ihdZUhzWMwyexX7dASf5FvoWB4q3m8xvEx5ax+rSD12KBcTk8liqYBeBzjTmAKDZ/2LZtqGs7FQsV
 8MWSMm0g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j6i4G-0007pH-UW; Tue, 25 Feb 2020 21:48:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v8 01/25] mm: Move readahead prototypes from mm.h
Date: Tue, 25 Feb 2020 13:48:14 -0800
Message-Id: <20200225214838.30017-2-willy@infradead.org>
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
Cc: linux-xfs@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The readahead code is part of the page cache so should be found in the
pagemap.h file.  force_page_cache_readahead is only used within mm,
so move it to mm/internal.h instead.  Remove the parameter names where
they add no value, and rename the ones which were actively misleading.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c        |  1 +
 include/linux/mm.h      | 19 -------------------
 include/linux/pagemap.h |  8 ++++++++
 mm/fadvise.c            |  2 ++
 mm/internal.h           |  2 ++
 5 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 089e890ab208..41417bb93634 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -20,6 +20,7 @@
 #include <linux/blk-mq.h>
 #include <linux/highmem.h>
 #include <linux/mm.h>
+#include <linux/pagemap.h>
 #include <linux/kernel_stat.h>
 #include <linux/string.h>
 #include <linux/init.h>
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..68dcda9a2112 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2401,25 +2401,6 @@ extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
 int __must_check write_one_page(struct page *page);
 void task_dirty_inc(struct task_struct *tsk);
 
-/* readahead.c */
-#define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
-
-int force_page_cache_readahead(struct address_space *mapping, struct file *filp,
-			pgoff_t offset, unsigned long nr_to_read);
-
-void page_cache_sync_readahead(struct address_space *mapping,
-			       struct file_ra_state *ra,
-			       struct file *filp,
-			       pgoff_t offset,
-			       unsigned long size);
-
-void page_cache_async_readahead(struct address_space *mapping,
-				struct file_ra_state *ra,
-				struct file *filp,
-				struct page *pg,
-				pgoff_t offset,
-				unsigned long size);
-
 extern unsigned long stack_guard_gap;
 /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
 extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ccb14b6a16b5..24894b9b90c9 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -614,6 +614,14 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask);
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct pagevec *pvec);
 
+#define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
+
+void page_cache_sync_readahead(struct address_space *, struct file_ra_state *,
+		struct file *, pgoff_t index, unsigned long req_count);
+void page_cache_async_readahead(struct address_space *, struct file_ra_state *,
+		struct file *, struct page *, pgoff_t index,
+		unsigned long req_count);
+
 /*
  * Like add_to_page_cache_locked, but used to add newly allocated pages:
  * the page is new, so we can just run __SetPageLocked() against it.
diff --git a/mm/fadvise.c b/mm/fadvise.c
index 4f17c83db575..3efebfb9952c 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -22,6 +22,8 @@
 
 #include <asm/unistd.h>
 
+#include "internal.h"
+
 /*
  * POSIX_FADV_WILLNEED could set PG_Referenced, and POSIX_FADV_NOREUSE could
  * deactivate the pages and clear PG_Referenced.
diff --git a/mm/internal.h b/mm/internal.h
index 3cf20ab3ca01..83f353e74654 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -49,6 +49,8 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
 
+int force_page_cache_readahead(struct address_space *, struct file *,
+		pgoff_t index, unsigned long nr_to_read);
 extern unsigned int __do_page_cache_readahead(struct address_space *mapping,
 		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
 		unsigned long lookahead_size);
-- 
2.25.0

