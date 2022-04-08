Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091EC4F9FE6
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Apr 2022 01:07:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KZv5Z6L7zz3bXw
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Apr 2022 09:06:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LGoklrW9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LGoklrW9;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=LGoklrW9; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LGoklrW9; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KZv5W6y3Dz2xnL
 for <linux-erofs@lists.ozlabs.org>; Sat,  9 Apr 2022 09:06:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649459213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jqzg2fYMpoH1LLv57GgLSuWlw1HsiXibIwniW9QRYis=;
 b=LGoklrW9zCRVgRBD2kckiBsdJQcbVrr/9xKAcLw8LGtBW4U+EXox1joNx9dRPtFTMNrWR7
 G7LQeQ8tCRPfcKT1sHt05ezDhxJiTJXHixh9EVFrgW0W2WNbyu8fZVGuJrJ6VLmyX8ympA
 rScIpk/pE+C3U4k+HRfxGAlyJujbSlY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649459213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jqzg2fYMpoH1LLv57GgLSuWlw1HsiXibIwniW9QRYis=;
 b=LGoklrW9zCRVgRBD2kckiBsdJQcbVrr/9xKAcLw8LGtBW4U+EXox1joNx9dRPtFTMNrWR7
 G7LQeQ8tCRPfcKT1sHt05ezDhxJiTJXHixh9EVFrgW0W2WNbyu8fZVGuJrJ6VLmyX8ympA
 rScIpk/pE+C3U4k+HRfxGAlyJujbSlY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-xqvezP7MPHKc47y8N8OCYg-1; Fri, 08 Apr 2022 19:06:50 -0400
X-MC-Unique: xqvezP7MPHKc47y8N8OCYg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA6A680B710;
 Fri,  8 Apr 2022 23:06:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 155B420296A6;
 Fri,  8 Apr 2022 23:06:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/8] fscache: Remove the cookie parameter from
 fscache_clear_page_bits()
From: David Howells <dhowells@redhat.com>
To: linux-cachefs@redhat.com
Date: Sat, 09 Apr 2022 00:06:39 +0100
Message-ID: <164945919939.773423.16389718107369702519.stgit@warthog.procyon.org.uk>
In-Reply-To: <164945915630.773423.14655306154231712324.stgit@warthog.procyon.org.uk>
References: <164945915630.773423.14655306154231712324.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
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
Cc: Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
 Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

The cookie is not used at all, remove it and update the usage in io.c
and afs/write.c (which is the only user outside of fscache currently)
at the same time.

[DH: Amended the documentation also]

Signed-off-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://listman.redhat.com/archives/linux-cachefs/2022-April/006659.html
---

 Documentation/filesystems/caching/netfs-api.rst |   25 +++++++++++------------
 fs/afs/write.c                                  |    3 +--
 fs/fscache/io.c                                 |    5 ++---
 include/linux/fscache.h                         |    4 +---
 4 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/Documentation/filesystems/caching/netfs-api.rst b/Documentation/filesystems/caching/netfs-api.rst
index 5066113acad5..7308d76a29dc 100644
--- a/Documentation/filesystems/caching/netfs-api.rst
+++ b/Documentation/filesystems/caching/netfs-api.rst
@@ -404,22 +404,21 @@ schedule a write of that region::
 And if an error occurs before that point is reached, the marks can be removed
 by calling::
 
-	void fscache_clear_page_bits(struct fscache_cookie *cookie,
-				     struct address_space *mapping,
+	void fscache_clear_page_bits(struct address_space *mapping,
 				     loff_t start, size_t len,
 				     bool caching)
 
-In both of these functions, the cookie representing the cache object to be
-written to and a pointer to the mapping to which the source pages are attached
-are passed in; start and len indicate the size of the region that's going to be
-written (it doesn't have to align to page boundaries necessarily, but it does
-have to align to DIO boundaries on the backing filesystem).  The caching
-parameter indicates if caching should be skipped, and if false, the functions
-do nothing.
-
-The write function takes some additional parameters: i_size indicates the size
-of the netfs file and term_func indicates an optional completion function, to
-which term_func_priv will be passed, along with the error or amount written.
+In these functions, a pointer to the mapping to which the source pages are
+attached is passed in and start and len indicate the size of the region that's
+going to be written (it doesn't have to align to page boundaries necessarily,
+but it does have to align to DIO boundaries on the backing filesystem).  The
+caching parameter indicates if caching should be skipped, and if false, the
+functions do nothing.
+
+The write function takes some additional parameters: the cookie representing
+the cache object to be written to, i_size indicates the size of the netfs file
+and term_func indicates an optional completion function, to which
+term_func_priv will be passed, along with the error or amount written.
 
 Note that the write function will always run asynchronously and will unmark all
 the pages upon completion before calling term_func.
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 6bcf1475511b..4763132ca57e 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -616,8 +616,7 @@ static ssize_t afs_write_back_from_locked_folio(struct address_space *mapping,
 		_debug("write discard %x @%llx [%llx]", len, start, i_size);
 
 		/* The dirty region was entirely beyond the EOF. */
-		fscache_clear_page_bits(afs_vnode_cache(vnode),
-					mapping, start, len, caching);
+		fscache_clear_page_bits(mapping, start, len, caching);
 		afs_pages_written_back(vnode, start, len);
 		ret = 0;
 	}
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index c8c7fe9e9a6e..3af3b08a9bb3 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -235,8 +235,7 @@ static void fscache_wreq_done(void *priv, ssize_t transferred_or_error,
 {
 	struct fscache_write_request *wreq = priv;
 
-	fscache_clear_page_bits(fscache_cres_cookie(&wreq->cache_resources),
-				wreq->mapping, wreq->start, wreq->len,
+	fscache_clear_page_bits(wreq->mapping, wreq->start, wreq->len,
 				wreq->set_bits);
 
 	if (wreq->term_func)
@@ -296,7 +295,7 @@ void __fscache_write_to_cache(struct fscache_cookie *cookie,
 abandon_free:
 	kfree(wreq);
 abandon:
-	fscache_clear_page_bits(cookie, mapping, start, len, cond);
+	fscache_clear_page_bits(mapping, start, len, cond);
 	if (term_func)
 		term_func(term_func_priv, ret, false);
 }
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 6727fb0db619..e25539072463 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -573,7 +573,6 @@ int fscache_write(struct netfs_cache_resources *cres,
 
 /**
  * fscache_clear_page_bits - Clear the PG_fscache bits from a set of pages
- * @cookie: The cookie representing the cache object
  * @mapping: The netfs inode to use as the source
  * @start: The start position in @mapping
  * @len: The amount of data to unlock
@@ -582,8 +581,7 @@ int fscache_write(struct netfs_cache_resources *cres,
  * Clear the PG_fscache flag from a sequence of pages and wake up anyone who's
  * waiting.
  */
-static inline void fscache_clear_page_bits(struct fscache_cookie *cookie,
-					   struct address_space *mapping,
+static inline void fscache_clear_page_bits(struct address_space *mapping,
 					   loff_t start, size_t len,
 					   bool caching)
 {


