Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9E7890570
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Mar 2024 17:37:04 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cv73PLtK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cv73PLtK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V58ML1S6Rz3vZY
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Mar 2024 03:37:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cv73PLtK;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cv73PLtK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V58MG6jymz3vb3
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 Mar 2024 03:36:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGg2pE70yherxMJt9KbXBpbcL/Vim4d4R7ndYfiDuYs=;
	b=Cv73PLtKTNjS8G55AMgvNt0G81K/Avui6JbnNldGQfHx1Pr22lnTV5qNrbSrSyhIm6UFnn
	eHSRupVjbhUEQkKZhPwE8Tli5zA/wk129g7lTJV7QtZjmNcMEwRipOz37YjHXGfYWxMkJA
	c+P26mxjC5HH4j78xtJtDpIO+KlGTS4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGg2pE70yherxMJt9KbXBpbcL/Vim4d4R7ndYfiDuYs=;
	b=Cv73PLtKTNjS8G55AMgvNt0G81K/Avui6JbnNldGQfHx1Pr22lnTV5qNrbSrSyhIm6UFnn
	eHSRupVjbhUEQkKZhPwE8Tli5zA/wk129g7lTJV7QtZjmNcMEwRipOz37YjHXGfYWxMkJA
	c+P26mxjC5HH4j78xtJtDpIO+KlGTS4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-y-T0ZNXHNhy7gW86I6hEFg-1; Thu, 28 Mar 2024 12:36:52 -0400
X-MC-Unique: y-T0ZNXHNhy7gW86I6hEFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3058E185A789;
	Thu, 28 Mar 2024 16:36:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E3D2E17AA3;
	Thu, 28 Mar 2024 16:36:47 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 10/26] cifs: Use alternative invalidation to using launder_folio
Date: Thu, 28 Mar 2024 16:34:02 +0000
Message-ID: <20240328163424.2781320-11-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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
Cc: David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <nspmangalore@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use writepages-based flushing invalidation instead of
invalidate_inode_pages2() and ->launder_folio().  This will allow
->launder_folio() to be removed eventually.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsfs.h |   1 -
 fs/smb/client/file.c   | 122 -----------------------------------------
 fs/smb/client/inode.c  |  25 ++-------
 3 files changed, 5 insertions(+), 143 deletions(-)

diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index ca55d01117c8..1ab7e5998c58 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -69,7 +69,6 @@ extern int cifs_revalidate_file_attr(struct file *filp);
 extern int cifs_revalidate_dentry_attr(struct dentry *);
 extern int cifs_revalidate_file(struct file *filp);
 extern int cifs_revalidate_dentry(struct dentry *);
-extern int cifs_invalidate_mapping(struct inode *inode);
 extern int cifs_revalidate_mapping(struct inode *inode);
 extern int cifs_zap_mapping(struct inode *inode);
 extern int cifs_getattr(struct mnt_idmap *, const struct path *,
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 59da572d3384..f92d4d42e87e 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2576,64 +2576,6 @@ struct cifs_writedata *cifs_writedata_alloc(work_func_t complete)
 	return wdata;
 }
 
-static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
-{
-	struct address_space *mapping = page->mapping;
-	loff_t offset = (loff_t)page->index << PAGE_SHIFT;
-	char *write_data;
-	int rc = -EFAULT;
-	int bytes_written = 0;
-	struct inode *inode;
-	struct cifsFileInfo *open_file;
-
-	if (!mapping || !mapping->host)
-		return -EFAULT;
-
-	inode = page->mapping->host;
-
-	offset += (loff_t)from;
-	write_data = kmap(page);
-	write_data += from;
-
-	if ((to > PAGE_SIZE) || (from > to)) {
-		kunmap(page);
-		return -EIO;
-	}
-
-	/* racing with truncate? */
-	if (offset > mapping->host->i_size) {
-		kunmap(page);
-		return 0; /* don't care */
-	}
-
-	/* check to make sure that we are not extending the file */
-	if (mapping->host->i_size - offset < (loff_t)to)
-		to = (unsigned)(mapping->host->i_size - offset);
-
-	rc = cifs_get_writable_file(CIFS_I(mapping->host), FIND_WR_ANY,
-				    &open_file);
-	if (!rc) {
-		bytes_written = cifs_write(open_file, open_file->pid,
-					   write_data, to - from, &offset);
-		cifsFileInfo_put(open_file);
-		/* Does mm or vfs already set times? */
-		simple_inode_init_ts(inode);
-		if ((bytes_written > 0) && (offset))
-			rc = 0;
-		else if (bytes_written < 0)
-			rc = bytes_written;
-		else
-			rc = -EFAULT;
-	} else {
-		cifs_dbg(FYI, "No writable handle for write page rc=%d\n", rc);
-		if (!is_retryable_error(rc))
-			rc = -EIO;
-	}
-
-	kunmap(page);
-	return rc;
-}
-
 /*
  * Extend the region to be written back to include subsequent contiguously
  * dirty pages if possible, but don't sleep while doing so.
@@ -3047,47 +2989,6 @@ static int cifs_writepages(struct address_space *mapping,
 	return ret;
 }
 
-static int
-cifs_writepage_locked(struct page *page, struct writeback_control *wbc)
-{
-	int rc;
-	unsigned int xid;
-
-	xid = get_xid();
-/* BB add check for wbc flags */
-	get_page(page);
-	if (!PageUptodate(page))
-		cifs_dbg(FYI, "ppw - page not up to date\n");
-
-	/*
-	 * Set the "writeback" flag, and clear "dirty" in the radix tree.
-	 *
-	 * A writepage() implementation always needs to do either this,
-	 * or re-dirty the page with "redirty_page_for_writepage()" in
-	 * the case of a failure.
-	 *
-	 * Just unlocking the page will cause the radix tree tag-bits
-	 * to fail to update with the state of the page correctly.
-	 */
-	set_page_writeback(page);
-retry_write:
-	rc = cifs_partialpagewrite(page, 0, PAGE_SIZE);
-	if (is_retryable_error(rc)) {
-		if (wbc->sync_mode == WB_SYNC_ALL && rc == -EAGAIN)
-			goto retry_write;
-		redirty_page_for_writepage(wbc, page);
-	} else if (rc != 0) {
-		SetPageError(page);
-		mapping_set_error(page->mapping, rc);
-	} else {
-		SetPageUptodate(page);
-	}
-	end_page_writeback(page);
-	put_page(page);
-	free_xid(xid);
-	return rc;
-}
-
 static int cifs_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *page, void *fsdata)
@@ -4913,27 +4814,6 @@ static void cifs_invalidate_folio(struct folio *folio, size_t offset,
 	folio_wait_private_2(folio); /* [DEPRECATED] */
 }
 
-static int cifs_launder_folio(struct folio *folio)
-{
-	int rc = 0;
-	loff_t range_start = folio_pos(folio);
-	loff_t range_end = range_start + folio_size(folio);
-	struct writeback_control wbc = {
-		.sync_mode = WB_SYNC_ALL,
-		.nr_to_write = 0,
-		.range_start = range_start,
-		.range_end = range_end,
-	};
-
-	cifs_dbg(FYI, "Launder page: %lu\n", folio->index);
-
-	if (folio_clear_dirty_for_io(folio))
-		rc = cifs_writepage_locked(&folio->page, &wbc);
-
-	folio_wait_private_2(folio); /* [DEPRECATED] */
-	return rc;
-}
-
 void cifs_oplock_break(struct work_struct *work)
 {
 	struct cifsFileInfo *cfile = container_of(work, struct cifsFileInfo,
@@ -5112,7 +4992,6 @@ const struct address_space_operations cifs_addr_ops = {
 	.release_folio = cifs_release_folio,
 	.direct_IO = cifs_direct_io,
 	.invalidate_folio = cifs_invalidate_folio,
-	.launder_folio = cifs_launder_folio,
 	.migrate_folio = filemap_migrate_folio,
 	/*
 	 * TODO: investigate and if useful we could add an is_dirty_writeback
@@ -5135,6 +5014,5 @@ const struct address_space_operations cifs_addr_ops_smallbuf = {
 	.dirty_folio = netfs_dirty_folio,
 	.release_folio = cifs_release_folio,
 	.invalidate_folio = cifs_invalidate_folio,
-	.launder_folio = cifs_launder_folio,
 	.migrate_folio = filemap_migrate_folio,
 };
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 91b07ef9e25c..468ea2312a1a 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2430,24 +2430,6 @@ cifs_dentry_needs_reval(struct dentry *dentry)
 	return false;
 }
 
-/*
- * Zap the cache. Called when invalid_mapping flag is set.
- */
-int
-cifs_invalidate_mapping(struct inode *inode)
-{
-	int rc = 0;
-
-	if (inode->i_mapping && inode->i_mapping->nrpages != 0) {
-		rc = invalidate_inode_pages2(inode->i_mapping);
-		if (rc)
-			cifs_dbg(VFS, "%s: invalidate inode %p failed with rc %d\n",
-				 __func__, inode, rc);
-	}
-
-	return rc;
-}
-
 /**
  * cifs_wait_bit_killable - helper for functions that are sleeping on bit locks
  *
@@ -2484,9 +2466,12 @@ cifs_revalidate_mapping(struct inode *inode)
 		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RW_CACHE)
 			goto skip_invalidate;
 
-		rc = cifs_invalidate_mapping(inode);
-		if (rc)
+		rc = filemap_invalidate_inode(inode, true);
+		if (rc) {
+			cifs_dbg(VFS, "%s: invalidate inode %p failed with rc %d\n",
+				 __func__, inode, rc);
 			set_bit(CIFS_INO_INVALID_MAPPING, flags);
+		}
 	}
 
 skip_invalidate:

