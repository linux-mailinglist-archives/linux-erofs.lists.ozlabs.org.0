Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F908B785F
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Apr 2024 16:08:47 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JduDY4ce;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JduDY4ce;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VTMW04kJnz3vxQ
	for <lists+linux-erofs@lfdr.de>; Wed,  1 May 2024 00:08:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JduDY4ce;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JduDY4ce;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VTMNW1JwQz3cWG
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 May 2024 00:03:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Odg3aZxytikbkfbMJrl0CzuPexMShHC0Kl20ZMSfA0U=;
	b=JduDY4ceBGBHae8Q9RKfwFJT/PwdD4jbcLVvnOs8ZKXJtQ0iyFW/UyBQlkGN6GIgsfAh/F
	bvbwWXS9LL7pp8ySrW02/Ho3ZuWdZz4SUgnb7HhJEYIob5PNNpJjdLJFzLrYv9QVdau8wz
	j9gLDUDcu9xFrZ7vhQUn7n8IG9BPlZI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Odg3aZxytikbkfbMJrl0CzuPexMShHC0Kl20ZMSfA0U=;
	b=JduDY4ceBGBHae8Q9RKfwFJT/PwdD4jbcLVvnOs8ZKXJtQ0iyFW/UyBQlkGN6GIgsfAh/F
	bvbwWXS9LL7pp8ySrW02/Ho3ZuWdZz4SUgnb7HhJEYIob5PNNpJjdLJFzLrYv9QVdau8wz
	j9gLDUDcu9xFrZ7vhQUn7n8IG9BPlZI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-MRk4RIKmNLehtOWuC76kKg-1; Tue, 30 Apr 2024 10:03:00 -0400
X-MC-Unique: MRk4RIKmNLehtOWuC76kKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF5AD18065DC;
	Tue, 30 Apr 2024 14:02:19 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9AF33EC680;
	Tue, 30 Apr 2024 14:02:16 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v2 18/22] netfs, cachefiles: Implement helpers for new write code
Date: Tue, 30 Apr 2024 15:00:49 +0100
Message-ID: <20240430140056.261997-19-dhowells@redhat.com>
In-Reply-To: <20240430140056.261997-1-dhowells@redhat.com>
References: <20240430140056.261997-1-dhowells@redhat.com>
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, linux-mm@kvack.org, netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Implement the helpers for the new write code in cachefiles.  There's now an
optional ->prepare_write() that allows the filesystem to set the parameters
for the next write, such as maximum size and maximum segment count, and an
->issue_write() that is called to initiate an (asynchronous) write
operation.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-erofs@lists.ozlabs.org
cc: linux-fsdevel@vger.kernel.org
---

Notes:
    Changes
    =======
    ver #2)
     - Add missing linux/bio.h for BIO_MAX_VECS.

 fs/cachefiles/io.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 5ba5c7814fe4..e667dbcd20e8 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/uio.h>
+#include <linux/bio.h>
 #include <linux/falloc.h>
 #include <linux/sched/mm.h>
 #include <trace/events/fscache.h>
@@ -622,6 +623,77 @@ static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
 	return ret;
 }
 
+static void cachefiles_prepare_write_subreq(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *wreq = subreq->rreq;
+	struct netfs_cache_resources *cres = &wreq->cache_resources;
+
+	_enter("W=%x[%x] %llx", wreq->debug_id, subreq->debug_index, subreq->start);
+
+	subreq->max_len = ULONG_MAX;
+	subreq->max_nr_segs = BIO_MAX_VECS;
+
+	if (!cachefiles_cres_file(cres)) {
+		if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE))
+			return netfs_prepare_write_failed(subreq);
+		if (!cachefiles_cres_file(cres))
+			return netfs_prepare_write_failed(subreq);
+	}
+}
+
+static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *wreq = subreq->rreq;
+	struct netfs_cache_resources *cres = &wreq->cache_resources;
+	struct cachefiles_object *object = cachefiles_cres_object(cres);
+	struct cachefiles_cache *cache = object->volume->cache;
+	const struct cred *saved_cred;
+	size_t off, pre, post, len = subreq->len;
+	loff_t start = subreq->start;
+	int ret;
+
+	_enter("W=%x[%x] %llx-%llx",
+	       wreq->debug_id, subreq->debug_index, start, start + len - 1);
+
+	/* We need to start on the cache granularity boundary */
+	off = start & (CACHEFILES_DIO_BLOCK_SIZE - 1);
+	if (off) {
+		pre = CACHEFILES_DIO_BLOCK_SIZE - off;
+		if (pre >= len) {
+			netfs_write_subrequest_terminated(subreq, len, false);
+			return;
+		}
+		subreq->transferred += pre;
+		start += pre;
+		len -= pre;
+		iov_iter_advance(&subreq->io_iter, pre);
+	}
+
+	/* We also need to end on the cache granularity boundary */
+	post = len & (CACHEFILES_DIO_BLOCK_SIZE - 1);
+	if (post) {
+		len -= post;
+		if (len == 0) {
+			netfs_write_subrequest_terminated(subreq, post, false);
+			return;
+		}
+		iov_iter_truncate(&subreq->io_iter, len);
+	}
+
+	cachefiles_begin_secure(cache, &saved_cred);
+	ret = __cachefiles_prepare_write(object, cachefiles_cres_file(cres),
+					 &start, &len, len, true);
+	cachefiles_end_secure(cache, saved_cred);
+	if (ret < 0) {
+		netfs_write_subrequest_terminated(subreq, ret, false);
+		return;
+	}
+
+	cachefiles_write(&subreq->rreq->cache_resources,
+			 subreq->start, &subreq->io_iter,
+			 netfs_write_subrequest_terminated, subreq);
+}
+
 /*
  * Clean up an operation.
  */
@@ -638,8 +710,10 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 	.end_operation		= cachefiles_end_operation,
 	.read			= cachefiles_read,
 	.write			= cachefiles_write,
+	.issue_write		= cachefiles_issue_write,
 	.prepare_read		= cachefiles_prepare_read,
 	.prepare_write		= cachefiles_prepare_write,
+	.prepare_write_subreq	= cachefiles_prepare_write_subreq,
 	.prepare_ondemand_read	= cachefiles_prepare_ondemand_read,
 	.query_occupancy	= cachefiles_query_occupancy,
 };

