Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1BA8B77F9
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Apr 2024 16:02:37 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g1DR6Pg4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g1DR6Pg4;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VTMMv14sxz3cRh
	for <lists+linux-erofs@lfdr.de>; Wed,  1 May 2024 00:02:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g1DR6Pg4;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g1DR6Pg4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VTMMY5nf6z3cV9
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 May 2024 00:02:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6jBpd96zxwzDPK+ctGz8ny53XrmMmE04lbG5qM/Yto=;
	b=g1DR6Pg4okBZXEtX18j3wYptAptXOgi/8/ZjLY6yNsH7P5O9YV156bMk5YEn2h09SyGP1F
	gqksRmmzmb82J03noXKGFhFaxginXMm6WKnJBs2QzGSbiFgcoOG2dqyZg0gMkecX16vCFA
	SOn+ez2+rJGRRburaPwxHhaXD4ZfwqY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6jBpd96zxwzDPK+ctGz8ny53XrmMmE04lbG5qM/Yto=;
	b=g1DR6Pg4okBZXEtX18j3wYptAptXOgi/8/ZjLY6yNsH7P5O9YV156bMk5YEn2h09SyGP1F
	gqksRmmzmb82J03noXKGFhFaxginXMm6WKnJBs2QzGSbiFgcoOG2dqyZg0gMkecX16vCFA
	SOn+ez2+rJGRRburaPwxHhaXD4ZfwqY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-u8RCXgQNPd-xCiJIm3EyRg-1; Tue, 30 Apr 2024 10:02:04 -0400
X-MC-Unique: u8RCXgQNPd-xCiJIm3EyRg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2698104B512;
	Tue, 30 Apr 2024 14:02:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9F0DBEC680;
	Tue, 30 Apr 2024 14:01:57 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v2 13/22] netfs: Switch to using unsigned long long rather than loff_t
Date: Tue, 30 Apr 2024 15:00:44 +0100
Message-ID: <20240430140056.261997-14-dhowells@redhat.com>
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
Cc: David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Switch to using unsigned long long rather than loff_t in netfslib to avoid
problems with the sign flipping in the maths when we're dealing with the
byte at position 0x7fffffffffffffff.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: netfs@lists.linux.dev
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/io.c           |  2 +-
 fs/ceph/addr.c               |  2 +-
 fs/netfs/buffered_read.c     |  4 +++-
 fs/netfs/buffered_write.c    |  2 +-
 fs/netfs/io.c                |  6 +++---
 fs/netfs/main.c              |  2 +-
 fs/netfs/output.c            |  4 ++--
 include/linux/netfs.h        | 16 +++++++++-------
 include/trace/events/netfs.h |  6 +++---
 9 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 1d685357e67f..5ba5c7814fe4 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -493,7 +493,7 @@ cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
  * boundary as appropriate.
  */
 static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
-						    loff_t i_size)
+						    unsigned long long i_size)
 {
 	return cachefiles_do_prepare_read(&subreq->rreq->cache_resources,
 					  subreq->start, &subreq->len, i_size,
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 74bfd10b1b1a..8c16bc5250ef 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -193,7 +193,7 @@ static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
 	 * block, but do not exceed the file size, unless the original
 	 * request already exceeds it.
 	 */
-	new_end = min(round_up(end, lo->stripe_unit), rreq->i_size);
+	new_end = umin(round_up(end, lo->stripe_unit), rreq->i_size);
 	if (new_end > end && new_end <= rreq->start + max_len)
 		rreq->len = new_end - rreq->start;
 
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 1622cce535a3..47603f08680e 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -130,7 +130,9 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 }
 
 static void netfs_cache_expand_readahead(struct netfs_io_request *rreq,
-					 loff_t *_start, size_t *_len, loff_t i_size)
+					 unsigned long long *_start,
+					 unsigned long long *_len,
+					 unsigned long long i_size)
 {
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
 
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index d8f66ce94575..eba49bfafe64 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -664,7 +664,7 @@ static void netfs_pages_written_back(struct netfs_io_request *wreq)
 	last = (wreq->start + wreq->len - 1) / PAGE_SIZE;
 	xas_for_each(&xas, folio, last) {
 		WARN(!folio_test_writeback(folio),
-		     "bad %zx @%llx page %lx %lx\n",
+		     "bad %llx @%llx page %lx %lx\n",
 		     wreq->len, wreq->start, folio->index, last);
 
 		if ((finfo = netfs_folio_info(folio))) {
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 8de581ac0cfb..6cfecfcd02e1 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -476,7 +476,7 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq,
 
 set:
 	if (subreq->len > rreq->len)
-		pr_warn("R=%08x[%u] SREQ>RREQ %zx > %zx\n",
+		pr_warn("R=%08x[%u] SREQ>RREQ %zx > %llx\n",
 			rreq->debug_id, subreq->debug_index,
 			subreq->len, rreq->len);
 
@@ -513,7 +513,7 @@ static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
 	subreq->start		= rreq->start + rreq->submitted;
 	subreq->len		= io_iter->count;
 
-	_debug("slice %llx,%zx,%zx", subreq->start, subreq->len, rreq->submitted);
+	_debug("slice %llx,%zx,%llx", subreq->start, subreq->len, rreq->submitted);
 	list_add_tail(&subreq->rreq_link, &rreq->subrequests);
 
 	/* Call out to the cache to find out what it can do with the remaining
@@ -588,7 +588,7 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 	atomic_set(&rreq->nr_outstanding, 1);
 	io_iter = rreq->io_iter;
 	do {
-		_debug("submit %llx + %zx >= %llx",
+		_debug("submit %llx + %llx >= %llx",
 		       rreq->start, rreq->submitted, rreq->i_size);
 		if (rreq->origin == NETFS_DIO_READ &&
 		    rreq->start + rreq->submitted >= rreq->i_size)
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 4805b9377364..5f0f438e5d21 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -62,7 +62,7 @@ static int netfs_requests_seq_show(struct seq_file *m, void *v)
 
 	rreq = list_entry(v, struct netfs_io_request, proc_link);
 	seq_printf(m,
-		   "%08x %s %3d %2lx %4d %3d @%04llx %zx/%zx",
+		   "%08x %s %3d %2lx %4d %3d @%04llx %llx/%llx",
 		   rreq->debug_id,
 		   netfs_origins[rreq->origin],
 		   refcount_read(&rreq->ref),
diff --git a/fs/netfs/output.c b/fs/netfs/output.c
index e586396d6b72..85374322f10f 100644
--- a/fs/netfs/output.c
+++ b/fs/netfs/output.c
@@ -439,7 +439,7 @@ static void netfs_submit_writethrough(struct netfs_io_request *wreq, bool final)
  */
 int netfs_advance_writethrough(struct netfs_io_request *wreq, size_t copied, bool to_page_end)
 {
-	_enter("ic=%zu sb=%zu ws=%u cp=%zu tp=%u",
+	_enter("ic=%zu sb=%llu ws=%u cp=%zu tp=%u",
 	       wreq->iter.count, wreq->submitted, wreq->wsize, copied, to_page_end);
 
 	wreq->iter.count += copied;
@@ -457,7 +457,7 @@ int netfs_end_writethrough(struct netfs_io_request *wreq, struct kiocb *iocb)
 {
 	int ret = -EIOCBQUEUED;
 
-	_enter("ic=%zu sb=%zu ws=%u",
+	_enter("ic=%zu sb=%llu ws=%u",
 	       wreq->iter.count, wreq->submitted, wreq->wsize);
 
 	if (wreq->submitted < wreq->io_iter.count)
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 0b6c2c2d3c23..88269681d4fc 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -149,7 +149,7 @@ struct netfs_io_subrequest {
 	struct work_struct	work;
 	struct list_head	rreq_link;	/* Link in rreq->subrequests */
 	struct iov_iter		io_iter;	/* Iterator for this subrequest */
-	loff_t			start;		/* Where to start the I/O */
+	unsigned long long	start;		/* Where to start the I/O */
 	size_t			len;		/* Size of the I/O */
 	size_t			transferred;	/* Amount of data transferred */
 	refcount_t		ref;
@@ -205,15 +205,15 @@ struct netfs_io_request {
 	atomic_t		subreq_counter;	/* Next subreq->debug_index */
 	atomic_t		nr_outstanding;	/* Number of ops in progress */
 	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
-	size_t			submitted;	/* Amount submitted for I/O so far */
-	size_t			len;		/* Length of the request */
 	size_t			upper_len;	/* Length can be extended to here */
+	unsigned long long	submitted;	/* Amount submitted for I/O so far */
+	unsigned long long	len;		/* Length of the request */
 	size_t			transferred;	/* Amount to be indicated as transferred */
 	short			error;		/* 0 or error that occurred */
 	enum netfs_io_origin	origin;		/* Origin of the request */
 	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
-	loff_t			i_size;		/* Size of the file */
-	loff_t			start;		/* Start position */
+	unsigned long long	i_size;		/* Size of the file */
+	unsigned long long	start;		/* Start position */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
 	refcount_t		ref;
 	unsigned long		flags;
@@ -294,13 +294,15 @@ struct netfs_cache_ops {
 
 	/* Expand readahead request */
 	void (*expand_readahead)(struct netfs_cache_resources *cres,
-				 loff_t *_start, size_t *_len, loff_t i_size);
+				 unsigned long long *_start,
+				 unsigned long long *_len,
+				 unsigned long long i_size);
 
 	/* Prepare a read operation, shortening it to a cached/uncached
 	 * boundary as appropriate.
 	 */
 	enum netfs_io_source (*prepare_read)(struct netfs_io_subrequest *subreq,
-					     loff_t i_size);
+					     unsigned long long i_size);
 
 	/* Prepare a write operation, working out what part of the write we can
 	 * actually do.
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 30769103638f..7126d2ea459c 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -280,7 +280,7 @@ TRACE_EVENT(netfs_sreq,
 		    __entry->start	= sreq->start;
 			   ),
 
-	    TP_printk("R=%08x[%u] %s %s f=%02x s=%llx %zx/%zx e=%d",
+	    TP_printk("R=%08x[%x] %s %s f=%02x s=%llx %zx/%zx e=%d",
 		      __entry->rreq, __entry->index,
 		      __print_symbolic(__entry->source, netfs_sreq_sources),
 		      __print_symbolic(__entry->what, netfs_sreq_traces),
@@ -320,7 +320,7 @@ TRACE_EVENT(netfs_failure,
 		    __entry->start	= sreq ? sreq->start : 0;
 			   ),
 
-	    TP_printk("R=%08x[%d] %s f=%02x s=%llx %zx/%zx %s e=%d",
+	    TP_printk("R=%08x[%x] %s f=%02x s=%llx %zx/%zx %s e=%d",
 		      __entry->rreq, __entry->index,
 		      __print_symbolic(__entry->source, netfs_sreq_sources),
 		      __entry->flags,
@@ -436,7 +436,7 @@ TRACE_EVENT(netfs_write,
 		    __field(unsigned int,		cookie		)
 		    __field(enum netfs_write_trace,	what		)
 		    __field(unsigned long long,		start		)
-		    __field(size_t,			len		)
+		    __field(unsigned long long,		len		)
 			     ),
 
 	    TP_fast_assign(

