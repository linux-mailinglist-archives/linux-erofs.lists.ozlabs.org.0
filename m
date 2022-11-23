Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 520E8636D88
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Nov 2022 23:49:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NHbsN1YLvz3cL7
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Nov 2022 09:49:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cp2tbFWh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cp2tbFWh;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cp2tbFWh;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cp2tbFWh;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NHbsK0HnDz3cKv
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Nov 2022 09:49:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669243746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHpeeqm1MJ8TYn1nRD3MVhIBofwqjS4Ni77i3McPwEA=;
	b=cp2tbFWhHQ2NLEZmpFVGMHDesFlEC8N70md4dQLj6CklI0yWgPheVZMflmo8XuNhYOISSJ
	50jmEhiQqdDuXGjWMdgOpFP0RqK67yRcc+YKeuIPZDzXaokFY6yeASGZkS6QUA98arsdlV
	HJdBnAURUhk1oJtrEaQUf4kn0sBSZww=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669243746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHpeeqm1MJ8TYn1nRD3MVhIBofwqjS4Ni77i3McPwEA=;
	b=cp2tbFWhHQ2NLEZmpFVGMHDesFlEC8N70md4dQLj6CklI0yWgPheVZMflmo8XuNhYOISSJ
	50jmEhiQqdDuXGjWMdgOpFP0RqK67yRcc+YKeuIPZDzXaokFY6yeASGZkS6QUA98arsdlV
	HJdBnAURUhk1oJtrEaQUf4kn0sBSZww=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-q0o80RfhNxCJu3990DjGhg-1; Wed, 23 Nov 2022 17:49:02 -0500
X-MC-Unique: q0o80RfhNxCJu3990DjGhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7020D1C05AA3;
	Wed, 23 Nov 2022 22:49:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2B620111E413;
	Wed, 23 Nov 2022 22:48:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH v4 3/3] mm: Make filemap_release_folio() better inform
 shrink_folio_list()
From: David Howells <dhowells@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Nov 2022 22:48:56 +0000
Message-ID:  <166924373637.1772793.2622483388224911574.stgit@warthog.procyon.org.uk>
In-Reply-To:  <166924370539.1772793.13730698360771821317.stgit@warthog.procyon.org.uk>
References:  <166924370539.1772793.13730698360771821317.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
Cc: Shyam Prasad N <nspmangalore@gmail.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>, Dave Wysochanski <dwysocha@redhat.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-afs@lists.infradead.org, Steve French <sfrench@samba.org>, linux-mm@kvack.org, linux-cachefs@redhat.com, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, Ilya Dryomov <idryomov@gmail.com>, linux-erofs@lists.ozlabs.org, Dominique Martinet <asmadeus@codewreck.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Make filemap_release_folio() return one of three values:

 (0) FILEMAP_CANT_RELEASE_FOLIO

     Couldn't release the folio's private data, so the folio can't itself
     be released.

 (1) FILEMAP_RELEASED_FOLIO

     The private data on the folio was released and the folio can be
     released.

 (2) FILEMAP_FOLIO_HAD_NO_PRIVATE

     There was no private data on the folio and the folio can be released.

The first must be zero so that existing tests of !filemap_release_folio()
continue to work as expected; similarly the other two must both be non-zero
so that existing tests of filemap_release_folio() continue to work as
expected.

Using this, make shrink_folio_list() choose which of three cases to follow
based on the return from filemap_release_folio() rather than testing the
folio's private bit itself.

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
Link: https://lore.kernel.org/r/1459152.1669208550@warthog.procyon.org.uk/ # v3
---

 include/linux/pagemap.h |    7 ++++++-
 mm/filemap.c            |   20 ++++++++++++++------
 mm/vmscan.c             |   29 +++++++++++++++--------------
 3 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 9a824b43c6af..b763182b6d3f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1124,7 +1124,12 @@ void replace_page_cache_page(struct page *old, struct page *new);
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct folio_batch *fbatch);
 int try_to_release_page(struct page *page, gfp_t gfp);
-bool filemap_release_folio(struct folio *folio, gfp_t gfp);
+enum filemap_released_folio {
+	FILEMAP_CANT_RELEASE_FOLIO	= 0, /* (This must be 0) Release failed */
+	FILEMAP_RELEASED_FOLIO		= 1, /* Folio's private data released */
+	FILEMAP_FOLIO_HAD_NO_PRIVATE	= 2, /* Folio had no private data */
+};
+enum filemap_released_folio filemap_release_folio(struct folio *folio, gfp_t gfp);
 loff_t mapping_seek_hole_data(struct address_space *, loff_t start, loff_t end,
 		int whence);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 93757247cd11..859831c70439 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3934,20 +3934,28 @@ EXPORT_SYMBOL(generic_file_write_iter);
  * this page (__GFP_IO), and whether the call may block
  * (__GFP_RECLAIM & __GFP_FS).
  *
- * Return: %true if the release was successful, otherwise %false.
+ * Return: %FILEMAP_RELEASED_FOLIO if the release was successful,
+ * %FILEMAP_CANT_RELEASE_FOLIO if the private data couldn't be released and
+ * %FILEMAP_FOLIO_HAD_NO_PRIVATE if there was no private data.
  */
-bool filemap_release_folio(struct folio *folio, gfp_t gfp)
+enum filemap_released_folio filemap_release_folio(struct folio *folio,
+						  gfp_t gfp)
 {
 	struct address_space * const mapping = folio->mapping;
+	bool released;
 
 	BUG_ON(!folio_test_locked(folio));
 	if (!folio_needs_release(folio))
-		return true;
+		return FILEMAP_FOLIO_HAD_NO_PRIVATE;
 	if (folio_test_writeback(folio))
-		return false;
+		return FILEMAP_CANT_RELEASE_FOLIO;
 
 	if (mapping && mapping->a_ops->release_folio)
-		return mapping->a_ops->release_folio(folio, gfp);
-	return try_to_free_buffers(folio);
+		released = mapping->a_ops->release_folio(folio, gfp);
+	else
+		released = try_to_free_buffers(folio);
+
+	return released ?
+		FILEMAP_RELEASED_FOLIO : FILEMAP_CANT_RELEASE_FOLIO;
 }
 EXPORT_SYMBOL(filemap_release_folio);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b9316f447238..d5c7b3be9947 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1978,25 +1978,26 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * (refcount == 1) it can be freed.  Otherwise, leave
 		 * the folio on the LRU so it is swappable.
 		 */
-		if (folio_needs_release(folio)) {
-			if (!filemap_release_folio(folio, sc->gfp_mask))
-				goto activate_locked;
+		switch (filemap_release_folio(folio, sc->gfp_mask)) {
+		case FILEMAP_CANT_RELEASE_FOLIO:
+			goto activate_locked;
+		case FILEMAP_RELEASED_FOLIO:
 			if (!mapping && folio_ref_count(folio) == 1) {
 				folio_unlock(folio);
 				if (folio_put_testzero(folio))
 					goto free_it;
-				else {
-					/*
-					 * rare race with speculative reference.
-					 * the speculative reference will free
-					 * this folio shortly, so we may
-					 * increment nr_reclaimed here (and
-					 * leave it off the LRU).
-					 */
-					nr_reclaimed += nr_pages;
-					continue;
-				}
+				/*
+				 * rare race with speculative reference.  the
+				 * speculative reference will free this folio
+				 * shortly, so we may increment nr_reclaimed
+				 * here (and leave it off the LRU).
+				 */
+				nr_reclaimed += nr_pages;
+				continue;
 			}
+			break;
+		case FILEMAP_FOLIO_HAD_NO_PRIVATE:
+			break;
 		}
 
 		if (folio_test_anon(folio) && !folio_test_swapbacked(folio)) {


