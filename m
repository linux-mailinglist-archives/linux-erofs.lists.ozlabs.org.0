Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0610795239B
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 22:41:22 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eV7bEnim;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eV7bEnim;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WkgC36MtZz2yNR
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2024 06:41:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eV7bEnim;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eV7bEnim;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WkgBw3b84z2ygy
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2024 06:41:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5GudhtF+T887yYtTq2ccnSMC605t1SyQsaR8Y8Wa80=;
	b=eV7bEnimPr44DR3huxoGX9iPjZ9FH3FSeyxavizzGgFzrFC1rMYQYk8FSvQkzPOPW5yCF3
	SBWk0N4R8P98qaJUAwhfk6gAi7/a5/z5u6usS6G9aPIUMD9u343A6PGzA0zQ5HqAyz09UX
	Fhb+/DFLBCX7cEjBlJ0msjAe9HGIjqw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5GudhtF+T887yYtTq2ccnSMC605t1SyQsaR8Y8Wa80=;
	b=eV7bEnimPr44DR3huxoGX9iPjZ9FH3FSeyxavizzGgFzrFC1rMYQYk8FSvQkzPOPW5yCF3
	SBWk0N4R8P98qaJUAwhfk6gAi7/a5/z5u6usS6G9aPIUMD9u343A6PGzA0zQ5HqAyz09UX
	Fhb+/DFLBCX7cEjBlJ0msjAe9HGIjqw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-cuSPPapgNmmADvVkpaXVwA-1; Wed,
 14 Aug 2024 16:41:05 -0400
X-MC-Unique: cuSPPapgNmmADvVkpaXVwA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 837281954B0E;
	Wed, 14 Aug 2024 20:41:02 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E3421300019A;
	Wed, 14 Aug 2024 20:40:56 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 16/25] netfs: Provide an iterator-reset function
Date: Wed, 14 Aug 2024 21:38:36 +0100
Message-ID: <20240814203850.2240469-17-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-mm@kvack.org, netfs@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Provide a function to reset the iterator on a subrequest.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/internal.h      |  4 +---
 fs/netfs/misc.c          | 18 ++++++++++++++++++
 fs/netfs/write_collect.c |  3 +--
 fs/netfs/write_issue.c   |  6 +++---
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index e1149e05a5c8..21a3c7d13585 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -69,6 +69,7 @@ int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio *folio
 			      bool needs_put);
 struct folio_queue *netfs_delete_buffer_head(struct netfs_io_request *wreq);
 void netfs_clear_buffer(struct netfs_io_request *rreq);
+void netfs_reset_iter(struct netfs_io_subrequest *subreq);
 
 /*
  * objects.c
@@ -161,9 +162,6 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 void netfs_reissue_write(struct netfs_io_stream *stream,
 			 struct netfs_io_subrequest *subreq,
 			 struct iov_iter *source);
-int netfs_advance_write(struct netfs_io_request *wreq,
-			struct netfs_io_stream *stream,
-			loff_t start, size_t len, bool to_eof);
 struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len);
 int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
 			       struct folio *folio, size_t copied, bool to_page_end,
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index e642e5cacb8d..08987765306f 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -84,6 +84,24 @@ void netfs_clear_buffer(struct netfs_io_request *rreq)
 	}
 }
 
+/*
+ * Reset the subrequest iterator to refer just to the region remaining to be
+ * read.  The iterator may or may not have been advanced by socket ops or
+ * extraction ops to an extent that may or may not match the amount actually
+ * read.
+ */
+void netfs_reset_iter(struct netfs_io_subrequest *subreq)
+{
+	struct iov_iter *io_iter = &subreq->io_iter;
+	size_t remain = subreq->len - subreq->transferred;
+
+	if (io_iter->count > remain)
+		iov_iter_advance(io_iter, io_iter->count - remain);
+	else if (io_iter->count < remain)
+		iov_iter_revert(io_iter, remain - io_iter->count);
+	iov_iter_truncate(&subreq->io_iter, remain);
+}
+
 /**
  * netfs_dirty_folio - Mark folio dirty and pin a cache object for writeback
  * @mapping: The mapping the folio belongs to.
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 1521a23077c3..801a130a0ce1 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -219,9 +219,8 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 		/* Determine the set of buffers we're going to use.  Each
 		 * subreq gets a subset of a single overall contiguous buffer.
 		 */
+		netfs_reset_iter(from);
 		source = from->io_iter;
-		iov_iter_revert(&source, subreq->len - source.count);
-		iov_iter_advance(&source, from->transferred);
 		source.count = len;
 
 		/* Work through the sublist. */
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index a75b62b202c5..9ead075962f0 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -261,9 +261,9 @@ static void netfs_issue_write(struct netfs_io_request *wreq,
  * we can avoid overrunning the credits obtained (cifs) and try to parallelise
  * content-crypto preparation with network writes.
  */
-int netfs_advance_write(struct netfs_io_request *wreq,
-			struct netfs_io_stream *stream,
-			loff_t start, size_t len, bool to_eof)
+static int netfs_advance_write(struct netfs_io_request *wreq,
+			       struct netfs_io_stream *stream,
+			       loff_t start, size_t len, bool to_eof)
 {
 	struct netfs_io_subrequest *subreq = stream->construct;
 	size_t part;

