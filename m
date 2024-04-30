Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDD38B77DE
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Apr 2024 16:01:55 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gQwvqtRF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gQwvqtRF;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VTMM462rxz3cTs
	for <lists+linux-erofs@lfdr.de>; Wed,  1 May 2024 00:01:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gQwvqtRF;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gQwvqtRF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VTMLs1KBJz3cSK
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 May 2024 00:01:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSmTGGISerpaaT9aJOrv4cy/yLYw7vFSX4krrCAu5wI=;
	b=gQwvqtRFEvdV/06ZlX/TvJAZBRBW0gcUQiUdL4csaRJRwoDPHyXYGbpvuEvUIZozFrR+VG
	yHBc7MwnPgkefGAHS2c8Z5ZNmUE5WwHuDj32IZ7/niBcwJAFwXhziPtpqM+9T+ebJfjAU6
	tLGpKLy51Ac+HknpXV9rUWBOJaSENxI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSmTGGISerpaaT9aJOrv4cy/yLYw7vFSX4krrCAu5wI=;
	b=gQwvqtRFEvdV/06ZlX/TvJAZBRBW0gcUQiUdL4csaRJRwoDPHyXYGbpvuEvUIZozFrR+VG
	yHBc7MwnPgkefGAHS2c8Z5ZNmUE5WwHuDj32IZ7/niBcwJAFwXhziPtpqM+9T+ebJfjAU6
	tLGpKLy51Ac+HknpXV9rUWBOJaSENxI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-dQcRgBBrN6WTDH9brex0BA-1; Tue,
 30 Apr 2024 10:01:34 -0400
X-MC-Unique: dQcRgBBrN6WTDH9brex0BA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E49C29AC01C;
	Tue, 30 Apr 2024 14:01:32 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3FC0020128EF;
	Tue, 30 Apr 2024 14:01:28 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v2 07/22] mm: Provide a means of invalidation without using launder_folio
Date: Tue, 30 Apr 2024 15:00:38 +0100
Message-ID: <20240430140056.261997-8-dhowells@redhat.com>
In-Reply-To: <20240430140056.261997-1-dhowells@redhat.com>
References: <20240430140056.261997-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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
Cc: David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Ilya Dryomov <idryomov@gmail.com>, devel@lists.orangefs.org, Shyam Prasad N <sprasad@microsoft.com>, Christian Brauner <brauner@kernel.org>, Tom Talpey <tom@talpey.com>, Alexander Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Implement a replacement for launder_folio.  The key feature of
invalidate_inode_pages2() is that it locks each folio individually, unmaps
it to prevent mmap'd accesses interfering and calls the ->launder_folio()
address_space op to flush it.  This has problems: firstly, each folio is
written individually as one or more small writes; secondly, adjacent folios
cannot be added so easily into the laundry; thirdly, it's yet another op to
implement.

Instead, use the invalidate lock to cause anyone wanting to add a folio to
the inode to wait, then unmap all the folios if we have mmaps, then,
conditionally, use ->writepages() to flush any dirty data back and then
discard all pages.

The invalidate lock prevents ->read_iter(), ->write_iter() and faulting
through mmap all from adding pages for the duration.

This is then used from netfslib to handle the flusing in unbuffered and
direct writes.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <brauner@kernel.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: ceph-devel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: devel@lists.orangefs.org
---

Notes:
    Changes
    =======
    ver #2)
     - Make filemap_invalidate_inode() take a range.
     - Make netfs_unbuffered_write_iter() use filemap_invalidate_inode().

 fs/netfs/direct_write.c | 28 ++++++++++++++++++---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 54 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index bee047e20f5d..2b81cd4aae6e 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -132,12 +132,14 @@ static ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov
 ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
 	struct netfs_inode *ictx = netfs_inode(inode);
-	unsigned long long end;
 	ssize_t ret;
+	loff_t pos = iocb->ki_pos;
+	unsigned long long end = pos + iov_iter_count(from) - 1;
 
-	_enter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read(inode));
+	_enter("%llx,%zx,%llx", pos, iov_iter_count(from), i_size_read(inode));
 
 	if (!iov_iter_count(from))
 		return 0;
@@ -157,7 +159,25 @@ ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ret = file_update_time(file);
 	if (ret < 0)
 		goto out;
-	ret = kiocb_invalidate_pages(iocb, iov_iter_count(from));
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		/* We could block if there are any pages in the range. */
+		ret = -EAGAIN;
+		if (filemap_range_has_page(mapping, pos, end))
+			if (filemap_invalidate_inode(inode, true, pos, end))
+				goto out;
+	} else {
+		ret = filemap_write_and_wait_range(mapping, pos, end);
+		if (ret < 0)
+			goto out;
+	}
+
+	/*
+	 * After a write we want buffered reads to be sure to go to disk to get
+	 * the new data.  We invalidate clean cached page from the region we're
+	 * about to write.  We do this *before* the write so that we can return
+	 * without clobbering -EIOCBQUEUED from ->direct_IO().
+	 */
+	ret = filemap_invalidate_inode(inode, true, pos, end);
 	if (ret < 0)
 		goto out;
 	end = iocb->ki_pos + iov_iter_count(from);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2df35e65557d..c5e33e2ca48a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -40,6 +40,8 @@ int filemap_fdatawait_keep_errors(struct address_space *mapping);
 int filemap_fdatawait_range(struct address_space *, loff_t lstart, loff_t lend);
 int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
 		loff_t start_byte, loff_t end_byte);
+int filemap_invalidate_inode(struct inode *inode, bool flush,
+			     loff_t start, loff_t end);
 
 static inline int filemap_fdatawait(struct address_space *mapping)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index 9a2e28bf298a..53516305b4b4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4134,6 +4134,60 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
 }
 EXPORT_SYMBOL(filemap_release_folio);
 
+/**
+ * filemap_invalidate_inode - Invalidate/forcibly write back a range of an inode's pagecache
+ * @inode: The inode to flush
+ * @flush: Set to write back rather than simply invalidate.
+ * @start: First byte to in range.
+ * @end: Last byte in range (inclusive), or LLONG_MAX for everything from start
+ *       onwards.
+ *
+ * Invalidate all the folios on an inode that contribute to the specified
+ * range, possibly writing them back first.  Whilst the operation is
+ * undertaken, the invalidate lock is held to prevent new folios from being
+ * installed.
+ */
+int filemap_invalidate_inode(struct inode *inode, bool flush,
+			     loff_t start, loff_t end)
+{
+	struct address_space *mapping = inode->i_mapping;
+	pgoff_t first = start >> PAGE_SHIFT;
+	pgoff_t last = end >> PAGE_SHIFT;
+	pgoff_t nr = end == LLONG_MAX ? ULONG_MAX : last - first + 1;
+
+	if (!mapping || !mapping->nrpages || end < start)
+		goto out;
+
+	/* Prevent new folios from being added to the inode. */
+	filemap_invalidate_lock(mapping);
+
+	if (!mapping->nrpages)
+		goto unlock;
+
+	unmap_mapping_pages(mapping, first, nr, false);
+
+	/* Write back the data if we're asked to. */
+	if (flush) {
+		struct writeback_control wbc = {
+			.sync_mode	= WB_SYNC_ALL,
+			.nr_to_write	= LONG_MAX,
+			.range_start	= first,
+			.range_end	= last,
+		};
+
+		filemap_fdatawrite_wbc(mapping, &wbc);
+	}
+
+	/* Wait for writeback to complete on all folios and discard. */
+	truncate_inode_pages_range(mapping, first, last);
+
+unlock:
+	filemap_invalidate_unlock(mapping);
+out:
+	return filemap_check_errors(mapping);
+}
+EXPORT_SYMBOL(filemap_invalidate_inode);
+
 #ifdef CONFIG_CACHESTAT_SYSCALL
 /**
  * filemap_cachestat() - compute the page cache statistics of a mapping

