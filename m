Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C94F654383
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Dec 2022 16:02:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NdD7l0m4cz3bXQ
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Dec 2022 02:02:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RJyES0TD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RJyES0TD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RJyES0TD;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RJyES0TD;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NdD7g5QlMz3bTD
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Dec 2022 02:02:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671721357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75w1pfVKB1Ro0XqkbXmr8eWxoXfk22o+qXL/5b9cucw=;
	b=RJyES0TDThBSqRZCVOF7bAIcfhChVykin+8LFDG/nSg7QFfCJzqgJHixS4F+544kpos2VV
	VSfc4WoaIEqdTWwtO0Lv4vjmD39IcEjTAxUdr8i8P+dhHXDNQ3rDvxRujpUIwa6wMagsBF
	7tPauQkMawlelG/lF/uWqAB0I7T0ouc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671721357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75w1pfVKB1Ro0XqkbXmr8eWxoXfk22o+qXL/5b9cucw=;
	b=RJyES0TDThBSqRZCVOF7bAIcfhChVykin+8LFDG/nSg7QFfCJzqgJHixS4F+544kpos2VV
	VSfc4WoaIEqdTWwtO0Lv4vjmD39IcEjTAxUdr8i8P+dhHXDNQ3rDvxRujpUIwa6wMagsBF
	7tPauQkMawlelG/lF/uWqAB0I7T0ouc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-HaKXfIxlMWuof_yakpjAKg-1; Thu, 22 Dec 2022 10:02:34 -0500
X-MC-Unique: HaKXfIxlMWuof_yakpjAKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1C872803D7E;
	Thu, 22 Dec 2022 15:02:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.96])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4BBDC2166B29;
	Thu, 22 Dec 2022 15:02:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v5 3/3] mm: Make filemap_release_folio() better inform
 shrink_folio_list()
From: David Howells <dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Date: Thu, 22 Dec 2022 15:02:29 +0000
Message-ID:  <167172134962.2334525.570622889806603086.stgit@warthog.procyon.org.uk>
In-Reply-To:  <167172131368.2334525.8569808925687731937.stgit@warthog.procyon.org.uk>
References:  <167172131368.2334525.8569808925687731937.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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
Cc: Shyam Prasad N <nspmangalore@gmail.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>, Dave Wysochanski <dwysocha@redhat.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Steve French <sfrench@samba.org>, linux-mm@kvack.org, linux-cachefs@redhat.com, dhowells@redhat.com, linux-ext4@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, Ilya Dryomov <idryomov@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Dominique Martinet <asmadeus@codewreck.org>
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
Link: https://lore.kernel.org/r/166924373637.1772793.2622483388224911574.stgit@warthog.procyon.org.uk/ # v4
---

 include/linux/pagemap.h |    7 ++++++-
 mm/filemap.c            |   20 ++++++++++++++------
 mm/vmscan.c             |   29 +++++++++++++++--------------
 3 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a0d433e0addd..cd00fb3b524b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1121,7 +1121,12 @@ void __filemap_remove_folio(struct folio *folio, void *shadow);
 void replace_page_cache_folio(struct folio *old, struct folio *new);
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct folio_batch *fbatch);
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
index 344146c170b0..217ca847773a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3953,20 +3953,28 @@ EXPORT_SYMBOL(generic_file_write_iter);
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
index bded71961143..b1e5ca348223 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1996,25 +1996,26 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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


