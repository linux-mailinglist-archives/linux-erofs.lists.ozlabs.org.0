Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB893740F35
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 12:49:23 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JUD5v9Pg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JUD5v9Pg;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qrdcd5XYgz30Nt
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 20:49:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JUD5v9Pg;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JUD5v9Pg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QrdcS52bJz30fV
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jun 2023 20:49:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687949350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35xC16dMlQgwE6owW0vdiolQSi7usOC9ELk4zbmo8S8=;
	b=JUD5v9PgaJppHqztxiRdmmBlcF33LLzwOJ0zAw/xZUVJRBzlpL6dTXbDNijSEGwl3PUQNM
	fqT8zGYEnAktCmqXryhJqVigQffAeKTwsz2PwFyMCV/wGa27qL7CO00hfnfLtlUccOFzzH
	5vVTnTGIoK9Om0tokPjmoLz3QaagXb0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687949350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35xC16dMlQgwE6owW0vdiolQSi7usOC9ELk4zbmo8S8=;
	b=JUD5v9PgaJppHqztxiRdmmBlcF33LLzwOJ0zAw/xZUVJRBzlpL6dTXbDNijSEGwl3PUQNM
	fqT8zGYEnAktCmqXryhJqVigQffAeKTwsz2PwFyMCV/wGa27qL7CO00hfnfLtlUccOFzzH
	5vVTnTGIoK9Om0tokPjmoLz3QaagXb0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-etuXAlI0MLCPNHRgBXUBRA-1; Wed, 28 Jun 2023 06:49:04 -0400
X-MC-Unique: etuXAlI0MLCPNHRgBXUBRA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3433C3C02B6D;
	Wed, 28 Jun 2023 10:49:03 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D68A8C09A07;
	Wed, 28 Jun 2023 10:49:00 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 2/2] mm, netfs, fscache: Stop read optimisation when folio removed from pagecache
Date: Wed, 28 Jun 2023 11:48:52 +0100
Message-ID: <20230628104852.3391651-3-dhowells@redhat.com>
In-Reply-To: <20230628104852.3391651-1-dhowells@redhat.com>
References: <20230628104852.3391651-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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
Cc: Shyam Prasad N <nspmangalore@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, linux-cifs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, linux-erofs@lists.ozlabs.org, Dave Wysochanski <dwysocha@redhat.com>, Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, linux-cachefs@redhat.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-afs@lists.infradead.org, Dominique Martinet <asmadeus@codewreck.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fscache has an optimisation by which reads from the cache are skipped until
we know that (a) there's data there to be read and (b) that data isn't
entirely covered by pages resident in the netfs pagecache.  This is done
with two flags manipulated by fscache_note_page_release():

	if (...
	    test_bit(FSCACHE_COOKIE_HAVE_DATA, &cookie->flags) &&
	    test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags))
		clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);

where the NO_DATA_TO_READ flag causes cachefiles_prepare_read() to indicate
that netfslib should download from the server or clear the page instead.

The fscache_note_page_release() function is intended to be called from
->releasepage() - but that only gets called if PG_private or PG_private_2
is set - and currently the former is at the discretion of the network
filesystem and the latter is only set whilst a page is being written to the
cache, so sometimes we miss clearing the optimisation.

Fix this by following Willy's suggestion[1] and adding an address_space
flag, AS_RELEASE_ALWAYS, that causes filemap_release_folio() to always call
->release_folio() if it's set, even if PG_private or PG_private_2 aren't
set.

Note that this would require folio_test_private() and page_has_private() to
become more complicated.  To avoid that, in the places[*] where these are
used to conditionalise calls to filemap_release_folio() and
try_to_release_page(), the tests are removed the those functions just
jumped to unconditionally and the test is performed there.

[*] There are some exceptions in vmscan.c where the check guards more than
just a call to the releaser.  I've added a function, folio_needs_release()
to wrap all the checks for that.

AS_RELEASE_ALWAYS should be set if a non-NULL cookie is obtained from
fscache and cleared in ->evict_inode() before truncate_inode_pages_final()
is called.

Additionally, the FSCACHE_COOKIE_NO_DATA_TO_READ flag needs to be cleared
and the optimisation cancelled if a cachefiles object already contains data
when we open it.

Fixes: 1f67e6d0b188 ("fscache: Provide a function to note the release of a page")
Fixes: 047487c947e8 ("cachefiles: Implement the I/O routines")
Reported-by: Rohith Surabattula <rohiths.msft@gmail.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Dave Wysochanski <dwysocha@redhat.com>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: linux-cachefs@redhat.com
cc: linux-cifs@vger.kernel.org
cc: linux-afs@lists.infradead.org
cc: v9fs-developer@lists.sourceforge.net
cc: ceph-devel@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---

Notes:
    ver #7)
     - Make NFS set AS_RELEASE_ALWAYS.
    
    ver #4)
     - Split out merging of folio_has_private()/filemap_release_folio() call
       pairs into a preceding patch.
     - Don't need to clear AS_RELEASE_ALWAYS in ->evict_inode().
    
    ver #3)
     - Fixed mapping_clear_release_always() to use clear_bit() not set_bit().
     - Moved a '&&' to the correct line.
    
    ver #2)
     - Rewrote entirely according to Willy's suggestion[1].

 fs/9p/cache.c           |  2 ++
 fs/afs/internal.h       |  2 ++
 fs/cachefiles/namei.c   |  2 ++
 fs/ceph/cache.c         |  2 ++
 fs/nfs/fscache.c        |  3 +++
 fs/smb/client/fscache.c |  2 ++
 include/linux/pagemap.h | 16 ++++++++++++++++
 mm/internal.h           |  5 ++++-
 8 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/fs/9p/cache.c b/fs/9p/cache.c
index cebba4eaa0b5..12c0ae29f185 100644
--- a/fs/9p/cache.c
+++ b/fs/9p/cache.c
@@ -68,6 +68,8 @@ void v9fs_cache_inode_get_cookie(struct inode *inode)
 				       &path, sizeof(path),
 				       &version, sizeof(version),
 				       i_size_read(&v9inode->netfs.inode));
+	if (v9inode->netfs.cache)
+		mapping_set_release_always(inode->i_mapping);
 
 	p9_debug(P9_DEBUG_FSC, "inode %p get cookie %p\n",
 		 inode, v9fs_inode_cookie(v9inode));
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 9d3d64921106..da73b97e19a9 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -681,6 +681,8 @@ static inline void afs_vnode_set_cache(struct afs_vnode *vnode,
 {
 #ifdef CONFIG_AFS_FSCACHE
 	vnode->netfs.cache = cookie;
+	if (cookie)
+		mapping_set_release_always(vnode->netfs.inode.i_mapping);
 #endif
 }
 
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index d9d22d0ec38a..7bf7a5fcc045 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -585,6 +585,8 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	if (ret < 0)
 		goto check_failed;
 
+	clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &object->cookie->flags);
+
 	object->file = file;
 
 	/* Always update the atime on an object we've just looked up (this is
diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 177d8e8d73fe..de1dee46d3df 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -36,6 +36,8 @@ void ceph_fscache_register_inode_cookie(struct inode *inode)
 				       &ci->i_vino, sizeof(ci->i_vino),
 				       &ci->i_version, sizeof(ci->i_version),
 				       i_size_read(inode));
+	if (ci->netfs.cache)
+		mapping_set_release_always(inode->i_mapping);
 }
 
 void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info *ci)
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 8c35d88a84b1..b05717fe0d4e 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -180,6 +180,9 @@ void nfs_fscache_init_inode(struct inode *inode)
 					       &auxdata,      /* aux_data */
 					       sizeof(auxdata),
 					       i_size_read(inode));
+
+	if (netfs_inode(inode)->cache)
+		mapping_set_release_always(inode->i_mapping);
 }
 
 /*
diff --git a/fs/smb/client/fscache.c b/fs/smb/client/fscache.c
index 8f6909d633da..3677525ee993 100644
--- a/fs/smb/client/fscache.c
+++ b/fs/smb/client/fscache.c
@@ -108,6 +108,8 @@ void cifs_fscache_get_inode_cookie(struct inode *inode)
 				       &cifsi->uniqueid, sizeof(cifsi->uniqueid),
 				       &cd, sizeof(cd),
 				       i_size_read(&cifsi->netfs.inode));
+	if (cifsi->netfs.cache)
+		mapping_set_release_always(inode->i_mapping);
 }
 
 void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool update)
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a56308a9d1a4..a1176ceb4a0c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -199,6 +199,7 @@ enum mapping_flags {
 	/* writeback related tags are not used */
 	AS_NO_WRITEBACK_TAGS = 5,
 	AS_LARGE_FOLIO_SUPPORT = 6,
+	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
 };
 
 /**
@@ -269,6 +270,21 @@ static inline int mapping_use_writeback_tags(struct address_space *mapping)
 	return !test_bit(AS_NO_WRITEBACK_TAGS, &mapping->flags);
 }
 
+static inline bool mapping_release_always(const struct address_space *mapping)
+{
+	return test_bit(AS_RELEASE_ALWAYS, &mapping->flags);
+}
+
+static inline void mapping_set_release_always(struct address_space *mapping)
+{
+	set_bit(AS_RELEASE_ALWAYS, &mapping->flags);
+}
+
+static inline void mapping_clear_release_always(struct address_space *mapping)
+{
+	clear_bit(AS_RELEASE_ALWAYS, &mapping->flags);
+}
+
 static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
 {
 	return mapping->gfp_mask;
diff --git a/mm/internal.h b/mm/internal.h
index a76314764d8c..86aef26df905 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -175,7 +175,10 @@ static inline void set_page_refcounted(struct page *page)
  */
 static inline bool folio_needs_release(struct folio *folio)
 {
-	return folio_has_private(folio);
+	struct address_space *mapping = folio->mapping;
+
+	return folio_has_private(folio) ||
+		(mapping && mapping_release_always(mapping));
 }
 
 extern unsigned long highest_memmap_pfn;

