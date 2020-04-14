Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E20F41A8252
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2020 17:22:51 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 491q484PVLzDqfH
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2020 01:22:48 +1000 (AEST)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=iR+CobgK; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 491pd13NbGzDqNk
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2020 01:02:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=ZGpBhfHigVcgOfk1c7Q+Xdyiwq9eQj/GlJHwhBPXodQ=; b=iR+CobgKquFIO8DquoWJkbXqP0
 srAnDkDiDMphePxANu3js5tGwBJPc9kEV+DY9/7/MTffoUjflZZZY2NMAJNNs36hARCgl7W8+6k0f
 RV9P3keREFmvNfIaWkLZQ3irLOA/wwRVXYLu3nxnqQRQZbeZaaaRyN3r5sNyVLzUyGc2kd18fd+yW
 dZQVwKt4cLe8ra5m+PhWYWE0eyh5xOAcxLKpRLQnbySBKUQErvPQEQ9YCEWfzCtBTo0Otx++8Ea3i
 lgO/tmXlJ/R9lbLDAYyQjA02QbUeOqtKW5IkuPWCgXK9T40EwLSABsRzYAt0tHFvHLjvYKzwlF+1h
 ZTvhu+5Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jON5A-0006Og-2q; Tue, 14 Apr 2020 15:02:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v11 11/25] mm: Add readahead address space operation
Date: Tue, 14 Apr 2020 08:02:19 -0700
Message-Id: <20200414150233.24495-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414150233.24495-1-willy@infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
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
Cc: linux-xfs@vger.kernel.org, William Kucharski <william.kucharski@oracle.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This replaces ->readpages with a saner interface:
 - Return void instead of an ignored error code.
 - Page cache is already populated with locked pages when ->readahead
   is called.
 - New arguments can be passed to the implementation without changing
   all the filesystems that use a common helper function like
   mpage_readahead().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 Documentation/filesystems/locking.rst |  6 +++++-
 Documentation/filesystems/vfs.rst     | 15 +++++++++++++++
 include/linux/fs.h                    |  2 ++
 mm/readahead.c                        | 12 ++++++++++--
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 5057e4d9dcd1..0af2e0e11461 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -239,6 +239,7 @@ prototypes::
 	int (*readpage)(struct file *, struct page *);
 	int (*writepages)(struct address_space *, struct writeback_control *);
 	int (*set_page_dirty)(struct page *page);
+	void (*readahead)(struct readahead_control *);
 	int (*readpages)(struct file *filp, struct address_space *mapping,
 			struct list_head *pages, unsigned nr_pages);
 	int (*write_begin)(struct file *, struct address_space *mapping,
@@ -271,7 +272,8 @@ writepage:		yes, unlocks (see below)
 readpage:		yes, unlocks
 writepages:
 set_page_dirty		no
-readpages:
+readahead:		yes, unlocks
+readpages:		no
 write_begin:		locks the page		 exclusive
 write_end:		yes, unlocks		 exclusive
 bmap:
@@ -295,6 +297,8 @@ the request handler (/dev/loop).
 ->readpage() unlocks the page, either synchronously or via I/O
 completion.
 
+->readahead() unlocks the pages that I/O is attempted on like ->readpage().
+
 ->readpages() populates the pagecache with the passed pages and starts
 I/O against them.  They come unlocked upon I/O completion.
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 7d4d09dd5e6d..ed17771c212b 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -706,6 +706,7 @@ cache in your filesystem.  The following members are defined:
 		int (*readpage)(struct file *, struct page *);
 		int (*writepages)(struct address_space *, struct writeback_control *);
 		int (*set_page_dirty)(struct page *page);
+		void (*readahead)(struct readahead_control *);
 		int (*readpages)(struct file *filp, struct address_space *mapping,
 				 struct list_head *pages, unsigned nr_pages);
 		int (*write_begin)(struct file *, struct address_space *mapping,
@@ -781,12 +782,26 @@ cache in your filesystem.  The following members are defined:
 	If defined, it should set the PageDirty flag, and the
 	PAGECACHE_TAG_DIRTY tag in the radix tree.
 
+``readahead``
+	Called by the VM to read pages associated with the address_space
+	object.  The pages are consecutive in the page cache and are
+	locked.  The implementation should decrement the page refcount
+	after starting I/O on each page.  Usually the page will be
+	unlocked by the I/O completion handler.  If the filesystem decides
+	to stop attempting I/O before reaching the end of the readahead
+	window, it can simply return.  The caller will decrement the page
+	refcount and unlock the remaining pages for you.  Set PageUptodate
+	if the I/O completes successfully.  Setting PageError on any page
+	will be ignored; simply unlock the page if an I/O error occurs.
+
 ``readpages``
 	called by the VM to read pages associated with the address_space
 	object.  This is essentially just a vector version of readpage.
 	Instead of just one page, several pages are requested.
 	readpages is only used for read-ahead, so read errors are
 	ignored.  If anything goes wrong, feel free to give up.
+	This interface is deprecated and will be removed by the end of
+	2020; implement readahead instead.
 
 ``write_begin``
 	Called by the generic buffered write code to ask the filesystem
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f6f59b4f22a..55c743925c40 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -292,6 +292,7 @@ enum positive_aop_returns {
 struct page;
 struct address_space;
 struct writeback_control;
+struct readahead_control;
 
 /*
  * Write life time hint values.
@@ -375,6 +376,7 @@ struct address_space_operations {
 	 */
 	int (*readpages)(struct file *filp, struct address_space *mapping,
 			struct list_head *pages, unsigned nr_pages);
+	void (*readahead)(struct readahead_control *);
 
 	int (*write_begin)(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned flags,
diff --git a/mm/readahead.c b/mm/readahead.c
index e52b3a7b9da5..d01531ef9f3c 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -125,7 +125,14 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 
 	blk_start_plug(&plug);
 
-	if (aops->readpages) {
+	if (aops->readahead) {
+		aops->readahead(rac);
+		/* Clean up the remaining pages */
+		while ((page = readahead_page(rac))) {
+			unlock_page(page);
+			put_page(page);
+		}
+	} else if (aops->readpages) {
 		aops->readpages(rac->file, rac->mapping, pages,
 				readahead_count(rac));
 		/* Clean up the remaining pages */
@@ -233,7 +240,8 @@ void force_page_cache_readahead(struct address_space *mapping,
 	struct file_ra_state *ra = &filp->f_ra;
 	unsigned long max_pages;
 
-	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages))
+	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages &&
+			!mapping->a_ops->readahead))
 		return;
 
 	/*
-- 
2.25.1

