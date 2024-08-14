Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D80952398
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 22:41:15 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UKNApt7Z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RPMoPFaj;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WkgBx00ZFz2yNB
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2024 06:41:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UKNApt7Z;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RPMoPFaj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WkgBn3k9fz2yWK
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2024 06:41:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/f0iKQp5bBeHLiH6VB9r17X0Ct4wL+73s2Qpqqd9fI=;
	b=UKNApt7Zo8HIK8Cr/VX3aV6uJ6BW0f+vPG8xD24jdqVexD8yro3tvboCqI0PPycxxQuw0u
	r72L2iuP+ESh5rOFGilE0nWpNq4EdZkXIqcoIHNU7Pz8Ex9elTfzWnO7adaXHxbcW4eMz1
	TXJhdz/H6KhE6MZZ/+krWGF9o2vkPqY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/f0iKQp5bBeHLiH6VB9r17X0Ct4wL+73s2Qpqqd9fI=;
	b=RPMoPFajzVHNsg8bmYR+2PYaDeKHPb0wfm76wEo0gfQ9J7pWKV7xTwmuQbxH7lhlTrYOik
	86cEiaPFkJdPkihSt/6SOX3f3KmeKH+1HafUCZVTSIHlrfY7SaSosrS93Y0ynBr1/M+/uo
	pEDaz/xb/kVsj711VkeEglcZc8vFtvM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-hsTaR9U-PLSDYPegYtMkMg-1; Wed,
 14 Aug 2024 16:40:58 -0400
X-MC-Unique: hsTaR9U-PLSDYPegYtMkMg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EB631944F02;
	Wed, 14 Aug 2024 20:40:55 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8ABA19560AA;
	Wed, 14 Aug 2024 20:40:49 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 15/25] netfs: Use new folio_queue data type and iterator instead of xarray iter
Date: Wed, 14 Aug 2024 21:38:35 +0100
Message-ID: <20240814203850.2240469-16-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Make the netfs write-side routines use the new folio_queue struct to hold a
rolling buffer of folios, with the issuer adding folios at the tail and the
collector removing them from the head as they're processed instead of using
an xarray.

This will allow a subsequent patch to simplify the write collector.

The primary mark (as tested by folioq_is_marked()) is used to note if the
corresponding folio needs putting.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/internal.h          |  9 +++-
 fs/netfs/misc.c              | 76 ++++++++++++++++++++++++++++++++
 fs/netfs/objects.c           |  1 +
 fs/netfs/stats.c             |  4 +-
 fs/netfs/write_collect.c     | 84 +++++++++++++++++++-----------------
 fs/netfs/write_issue.c       | 28 ++++++------
 include/linux/netfs.h        |  8 ++--
 include/trace/events/netfs.h |  1 +
 8 files changed, 150 insertions(+), 61 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index f2920b4ee726..e1149e05a5c8 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -7,6 +7,7 @@
 
 #include <linux/slab.h>
 #include <linux/seq_file.h>
+#include <linux/folio_queue.h>
 #include <linux/netfs.h>
 #include <linux/fscache.h>
 #include <linux/fscache-cache.h>
@@ -64,6 +65,10 @@ static inline void netfs_proc_del_rreq(struct netfs_io_request *rreq) {}
 /*
  * misc.c
  */
+int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio *folio,
+			      bool needs_put);
+struct folio_queue *netfs_delete_buffer_head(struct netfs_io_request *wreq);
+void netfs_clear_buffer(struct netfs_io_request *rreq);
 
 /*
  * objects.c
@@ -120,6 +125,7 @@ extern atomic_t netfs_n_wh_write_done;
 extern atomic_t netfs_n_wh_write_failed;
 extern atomic_t netfs_n_wb_lock_skip;
 extern atomic_t netfs_n_wb_lock_wait;
+extern atomic_t netfs_n_folioq;
 
 int netfs_stats_show(struct seq_file *m, void *v);
 
@@ -153,7 +159,8 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 						loff_t start,
 						enum netfs_io_origin origin);
 void netfs_reissue_write(struct netfs_io_stream *stream,
-			 struct netfs_io_subrequest *subreq);
+			 struct netfs_io_subrequest *subreq,
+			 struct iov_iter *source);
 int netfs_advance_write(struct netfs_io_request *wreq,
 			struct netfs_io_stream *stream,
 			loff_t start, size_t len, bool to_eof);
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 554a1a4615ad..e642e5cacb8d 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -8,6 +8,82 @@
 #include <linux/swap.h>
 #include "internal.h"
 
+/*
+ * Append a folio to the rolling queue.
+ */
+int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio *folio,
+			      bool needs_put)
+{
+	struct folio_queue *tail = rreq->buffer_tail;
+	unsigned int slot, order = folio_order(folio);
+
+	if (WARN_ON_ONCE(!rreq->buffer && tail) ||
+	    WARN_ON_ONCE(rreq->buffer && !tail))
+		return -EIO;
+
+	if (!tail || folioq_full(tail)) {
+		tail = kmalloc(sizeof(*tail), GFP_NOFS);
+		if (!tail)
+			return -ENOMEM;
+		netfs_stat(&netfs_n_folioq);
+		folioq_init(tail);
+		tail->prev = rreq->buffer_tail;
+		if (tail->prev)
+			tail->prev->next = tail;
+		rreq->buffer_tail = tail;
+		if (!rreq->buffer) {
+			rreq->buffer = tail;
+			iov_iter_folio_queue(&rreq->io_iter, ITER_SOURCE, tail, 0, 0, 0);
+		}
+		rreq->buffer_tail_slot = 0;
+	}
+
+	rreq->io_iter.count += PAGE_SIZE << order;
+
+	slot = folioq_append(tail, folio);
+	/* Store the counter after setting the slot. */
+	smp_store_release(&rreq->buffer_tail_slot, slot);
+	return 0;
+}
+
+/*
+ * Delete the head of a rolling queue.
+ */
+struct folio_queue *netfs_delete_buffer_head(struct netfs_io_request *wreq)
+{
+	struct folio_queue *head = wreq->buffer, *next = head->next;
+
+	if (next)
+		next->prev = NULL;
+	netfs_stat_d(&netfs_n_folioq);
+	kfree(head);
+	wreq->buffer = next;
+	return next;
+}
+
+/*
+ * Clear out a rolling queue.
+ */
+void netfs_clear_buffer(struct netfs_io_request *rreq)
+{
+	struct folio_queue *p;
+
+	while ((p = rreq->buffer)) {
+		rreq->buffer = p->next;
+		for (int slot = 0; slot < folioq_nr_slots(p); slot++) {
+			struct folio *folio = folioq_folio(p, slot);
+			if (!folio)
+				continue;
+			if (folioq_is_marked(p, slot)) {
+				trace_netfs_folio(folio, netfs_folio_trace_put);
+				folio_put(folio);
+			}
+		}
+		netfs_stat_d(&netfs_n_folioq);
+		kfree(p);
+	}
+}
+
 /**
  * netfs_dirty_folio - Mark folio dirty and pin a cache object for writeback
  * @mapping: The mapping the folio belongs to.
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index d6e9785ce7a3..4291cd405fc1 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -141,6 +141,7 @@ static void netfs_free_request(struct work_struct *work)
 		}
 		kvfree(rreq->direct_bv);
 	}
+	netfs_clear_buffer(rreq);
 
 	if (atomic_dec_and_test(&ictx->io_count))
 		wake_up_var(&ictx->io_count);
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index 5fe1c396e24f..5065289f5555 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -41,6 +41,7 @@ atomic_t netfs_n_wh_write_done;
 atomic_t netfs_n_wh_write_failed;
 atomic_t netfs_n_wb_lock_skip;
 atomic_t netfs_n_wb_lock_wait;
+atomic_t netfs_n_folioq;
 
 int netfs_stats_show(struct seq_file *m, void *v)
 {
@@ -76,9 +77,10 @@ int netfs_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&netfs_n_wh_write),
 		   atomic_read(&netfs_n_wh_write_done),
 		   atomic_read(&netfs_n_wh_write_failed));
-	seq_printf(m, "Objs   : rr=%u sr=%u wsc=%u\n",
+	seq_printf(m, "Objs   : rr=%u sr=%u foq=%u wsc=%u\n",
 		   atomic_read(&netfs_n_rh_rreq),
 		   atomic_read(&netfs_n_rh_sreq),
+		   atomic_read(&netfs_n_folioq),
 		   atomic_read(&netfs_n_wh_wstream_conflict));
 	seq_printf(m, "WbLock : skip=%u wait=%u\n",
 		   atomic_read(&netfs_n_wb_lock_skip),
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 5f504b03a1e7..1521a23077c3 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -74,42 +74,6 @@ int netfs_folio_written_back(struct folio *folio)
 	return gcount;
 }
 
-/*
- * Get hold of a folio we have under writeback.  We don't want to get the
- * refcount on it.
- */
-static struct folio *netfs_writeback_lookup_folio(struct netfs_io_request *wreq, loff_t pos)
-{
-	XA_STATE(xas, &wreq->mapping->i_pages, pos / PAGE_SIZE);
-	struct folio *folio;
-
-	rcu_read_lock();
-
-	for (;;) {
-		xas_reset(&xas);
-		folio = xas_load(&xas);
-		if (xas_retry(&xas, folio))
-			continue;
-
-		if (!folio || xa_is_value(folio))
-			kdebug("R=%08x: folio %lx (%llx) not present",
-			       wreq->debug_id, xas.xa_index, pos / PAGE_SIZE);
-		BUG_ON(!folio || xa_is_value(folio));
-
-		if (folio == xas_reload(&xas))
-			break;
-	}
-
-	rcu_read_unlock();
-
-	if (WARN_ONCE(!folio_test_writeback(folio),
-		      "R=%08x: folio %lx is not under writeback\n",
-		      wreq->debug_id, folio->index)) {
-		trace_netfs_folio(folio, netfs_folio_trace_not_under_wback);
-	}
-	return folio;
-}
-
 /*
  * Unlock any folios we've finished with.
  */
@@ -117,13 +81,25 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 					  unsigned long long collected_to,
 					  unsigned int *notes)
 {
+	struct folio_queue *folioq = wreq->buffer;
+	unsigned int slot = wreq->buffer_head_slot;
+
+	if (slot >= folioq_nr_slots(folioq)) {
+		folioq = netfs_delete_buffer_head(wreq);
+		slot = 0;
+	}
+
 	for (;;) {
 		struct folio *folio;
 		struct netfs_folio *finfo;
 		unsigned long long fpos, fend;
 		size_t fsize, flen;
 
-		folio = netfs_writeback_lookup_folio(wreq, wreq->cleaned_to);
+		folio = folioq_folio(folioq, slot);
+		if (WARN_ONCE(!folio_test_writeback(folio),
+			      "R=%08x: folio %lx is not under writeback\n",
+			      wreq->debug_id, folio->index))
+			trace_netfs_folio(folio, netfs_folio_trace_not_under_wback);
 
 		fpos = folio_pos(folio);
 		fsize = folio_size(folio);
@@ -148,9 +124,25 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 		wreq->cleaned_to = fpos + fsize;
 		*notes |= MADE_PROGRESS;
 
+		/* Clean up the head folioq.  If we clear an entire folioq, then
+		 * we can get rid of it provided it's not also the tail folioq
+		 * being filled by the issuer.
+		 */
+		folioq_clear(folioq, slot);
+		slot++;
+		if (slot >= folioq_nr_slots(folioq)) {
+			if (READ_ONCE(wreq->buffer_tail) == folioq)
+				break;
+			folioq = netfs_delete_buffer_head(wreq);
+			slot = 0;
+		}
+
 		if (fpos + fsize >= collected_to)
 			break;
 	}
+
+	wreq->buffer = folioq;
+	wreq->buffer_head_slot = slot;
 }
 
 /*
@@ -181,9 +173,12 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
 				break;
 			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
+				struct iov_iter source = subreq->io_iter;
+
+				iov_iter_revert(&source, subreq->len - source.count);
 				__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
 				netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-				netfs_reissue_write(stream, subreq);
+				netfs_reissue_write(stream, subreq, &source);
 			}
 		}
 		return;
@@ -193,6 +188,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 
 	do {
 		struct netfs_io_subrequest *subreq = NULL, *from, *to, *tmp;
+		struct iov_iter source;
 		unsigned long long start, len;
 		size_t part;
 		bool boundary = false;
@@ -220,6 +216,14 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			len += to->len;
 		}
 
+		/* Determine the set of buffers we're going to use.  Each
+		 * subreq gets a subset of a single overall contiguous buffer.
+		 */
+		source = from->io_iter;
+		iov_iter_revert(&source, subreq->len - source.count);
+		iov_iter_advance(&source, from->transferred);
+		source.count = len;
+
 		/* Work through the sublist. */
 		subreq = from;
 		list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
@@ -242,7 +246,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 				boundary = true;
 
 			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-			netfs_reissue_write(stream, subreq);
+			netfs_reissue_write(stream, subreq, &source);
 			if (subreq == to)
 				break;
 		}
@@ -309,7 +313,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 				boundary = false;
 			}
 
-			netfs_reissue_write(stream, subreq);
+			netfs_reissue_write(stream, subreq, &source);
 			if (!len)
 				break;
 
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 7880a586343f..a75b62b202c5 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -213,9 +213,11 @@ static void netfs_prepare_write(struct netfs_io_request *wreq,
  * netfs_write_subrequest_terminated() when complete.
  */
 static void netfs_do_issue_write(struct netfs_io_stream *stream,
-				 struct netfs_io_subrequest *subreq)
+				 struct netfs_io_subrequest *subreq,
+				 struct iov_iter *source)
 {
 	struct netfs_io_request *wreq = subreq->rreq;
+	size_t size = subreq->len - subreq->transferred;
 
 	_enter("R=%x[%x],%zx", wreq->debug_id, subreq->debug_index, subreq->len);
 
@@ -223,27 +225,20 @@ static void netfs_do_issue_write(struct netfs_io_stream *stream,
 		return netfs_write_subrequest_terminated(subreq, subreq->error, false);
 
 	// TODO: Use encrypted buffer
-	if (test_bit(NETFS_RREQ_USE_IO_ITER, &wreq->flags)) {
-		subreq->io_iter = wreq->io_iter;
-		iov_iter_advance(&subreq->io_iter,
-				 subreq->start + subreq->transferred - wreq->start);
-		iov_iter_truncate(&subreq->io_iter,
-				 subreq->len - subreq->transferred);
-	} else {
-		iov_iter_xarray(&subreq->io_iter, ITER_SOURCE, &wreq->mapping->i_pages,
-				subreq->start + subreq->transferred,
-				subreq->len   - subreq->transferred);
-	}
+	subreq->io_iter = *source;
+	iov_iter_advance(source, size);
+	iov_iter_truncate(&subreq->io_iter, size);
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 	stream->issue_write(subreq);
 }
 
 void netfs_reissue_write(struct netfs_io_stream *stream,
-			 struct netfs_io_subrequest *subreq)
+			 struct netfs_io_subrequest *subreq,
+			 struct iov_iter *source)
 {
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-	netfs_do_issue_write(stream, subreq);
+	netfs_do_issue_write(stream, subreq, source);
 }
 
 static void netfs_issue_write(struct netfs_io_request *wreq,
@@ -257,7 +252,7 @@ static void netfs_issue_write(struct netfs_io_request *wreq,
 
 	if (subreq->start + subreq->len > wreq->start + wreq->submitted)
 		WRITE_ONCE(wreq->submitted, subreq->start + subreq->len - wreq->start);
-	netfs_do_issue_write(stream, subreq);
+	netfs_do_issue_write(stream, subreq, &wreq->io_iter);
 }
 
 /*
@@ -422,6 +417,9 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 		trace_netfs_folio(folio, netfs_folio_trace_store_plus);
 	}
 
+	/* Attach the folio to the rolling buffer. */
+	netfs_buffer_append_folio(wreq, folio, false);
+
 	/* Move the submission point forward to allow for write-streaming data
 	 * not starting at the front of the page.  We don't do write-streaming
 	 * with the cache as the cache requires DIO alignment.
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index ae4abf121d97..6428be9d99ba 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -38,10 +38,6 @@ static inline void folio_start_private_2(struct folio *folio)
 	folio_set_private_2(folio);
 }
 
-/* Marks used on xarray-based buffers */
-#define NETFS_BUF_PUT_MARK	XA_MARK_0	/* - Page needs putting  */
-#define NETFS_BUF_PAGECACHE_MARK XA_MARK_1	/* - Page needs wb/dirty flag wrangling */
-
 enum netfs_io_source {
 	NETFS_SOURCE_UNKNOWN,
 	NETFS_FILL_WITH_ZEROES,
@@ -232,6 +228,8 @@ struct netfs_io_request {
 	struct netfs_io_stream	io_streams[2];	/* Streams of parallel I/O operations */
 #define NR_IO_STREAMS 2 //wreq->nr_io_streams
 	struct netfs_group	*group;		/* Writeback group being written back */
+	struct folio_queue	*buffer;	/* Head of I/O buffer */
+	struct folio_queue	*buffer_tail;	/* Tail of I/O buffer */
 	struct iov_iter		iter;		/* Unencrypted-side iterator */
 	struct iov_iter		io_iter;	/* I/O (Encrypted-side) iterator */
 	void			*netfs_priv;	/* Private data for the netfs */
@@ -253,6 +251,8 @@ struct netfs_io_request {
 	short			error;		/* 0 or error that occurred */
 	enum netfs_io_origin	origin;		/* Origin of the request */
 	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
+	u8			buffer_head_slot; /* First slot in ->buffer */
+	u8			buffer_tail_slot; /* Next slot in ->buffer_tail */
 	unsigned long long	i_size;		/* Size of the file */
 	unsigned long long	start;		/* Start position */
 	atomic64_t		issued_to;	/* Write issuer folio cursor */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 47cd11aaccac..4e13774a06e6 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -153,6 +153,7 @@
 	EM(netfs_folio_trace_mkwrite,		"mkwrite")	\
 	EM(netfs_folio_trace_mkwrite_plus,	"mkwrite+")	\
 	EM(netfs_folio_trace_not_under_wback,	"!wback")	\
+	EM(netfs_folio_trace_put,		"put")		\
 	EM(netfs_folio_trace_read_gaps,		"read-gaps")	\
 	EM(netfs_folio_trace_redirtied,		"redirtied")	\
 	EM(netfs_folio_trace_store,		"store")	\

