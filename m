Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F559BE9CC
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 13:37:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xk4V62P0Jz3bcW
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 23:37:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730896652;
	cv=none; b=KaAS6od747Y5rLolyWoz7MQkGoclcOVnBylkI6qmBtdQAiGpPGTiE8VT6a9S4tugzIAc6wyBrWjJUMTMCf1GVxL43iAjFgGQ1nedmFtHFL1LGZ2YlsoLEPaiGXMReaAnemDVjTRtxsJc1GGzXP3R6HyULR2OlU/GrZNNpLG8CXBJ5V304UCrmDk1JuedubX2nEw8+1vB3bYb7wt2M3mNVd3vfZucKdlXO6tiyFzAbpf1rrurx9YVf90bHLuo4l5D/5F3kBGDJm+pgBy9ZV1BGOiathefDFWadXTnUWhJBQZc0vRX6oBG07Ek7G96Wo0WczL+DgQCIanO0C1et2QzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730896652; c=relaxed/relaxed;
	bh=cXT5ALic3xBUT2yykbdv9+aDxF01hC9kmNJ9X8Q7R1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVg/fP9qwKJv1q2fu4b3UkHPP18pHFQX+yPrwU/pu2CFTFro7Irrw9pyF3pzoYIBpSlVT87493HHTK9w/brwubXeY6oPM6eYz5xw1A5Fqlx9uUf27wX6wsVnbrXQvWg2uIw8lGos9Utww4GbFvItfCKbubpPQ+J3pqis8LvY5Fq6LUPuR+0hJGU6agEw8+Cl7HslTKemRfOQIQi89clVozvS5Tp3Bs3oDn89zU85qny6mlGHpbuGX7OcvGIyhZnDnWRZAV0b+ZVZ34YcIMhIe1/HzqenphW8WuUQD9Nhqos/Lb2m7bQ/Pb7yhzPvmIkqtFvABoWsLz5QSJdMO/JWoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RWrgZ1fQ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RWrgZ1fQ; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RWrgZ1fQ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RWrgZ1fQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xk4V33y39z2yKD
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Nov 2024 23:37:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXT5ALic3xBUT2yykbdv9+aDxF01hC9kmNJ9X8Q7R1c=;
	b=RWrgZ1fQqAjZJ1MfbasiQkuqgbgR8pwg2ke8iZxejWSg4kfNg34lYHr1zaFjVoQ7avQlZh
	M/rGiXVlrXmokh1iZTrTm7A3Rtduyu6MJQ9sx5K2ARg6YGWyJgEU4IDtfmS78c1iZM4+FU
	k4EhIlgLbo11N55rkLdUNCSenBPgFXk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXT5ALic3xBUT2yykbdv9+aDxF01hC9kmNJ9X8Q7R1c=;
	b=RWrgZ1fQqAjZJ1MfbasiQkuqgbgR8pwg2ke8iZxejWSg4kfNg34lYHr1zaFjVoQ7avQlZh
	M/rGiXVlrXmokh1iZTrTm7A3Rtduyu6MJQ9sx5K2ARg6YGWyJgEU4IDtfmS78c1iZM4+FU
	k4EhIlgLbo11N55rkLdUNCSenBPgFXk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-VJlxQPBqPXWVEvxdgL7taQ-1; Wed,
 06 Nov 2024 07:37:24 -0500
X-MC-Unique: VJlxQPBqPXWVEvxdgL7taQ-1
X-Mimecast-MFC-AGG-ID: VJlxQPBqPXWVEvxdgL7taQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58B431955EA9;
	Wed,  6 Nov 2024 12:37:21 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A00F419541A5;
	Wed,  6 Nov 2024 12:37:15 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 09/33] netfs: Split retry code out of fs/netfs/write_collect.c
Date: Wed,  6 Nov 2024 12:35:33 +0000
Message-ID: <20241106123559.724888-10-dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-1-dhowells@redhat.com>
References: <20241106123559.724888-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

Split write-retry code out of fs/netfs/write_collect.c as it will become
more elaborate when content crypto is introduced.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/Makefile        |   3 +-
 fs/netfs/internal.h      |   5 +
 fs/netfs/write_collect.c | 215 ------------------------------------
 fs/netfs/write_retry.c   | 227 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 234 insertions(+), 216 deletions(-)
 create mode 100644 fs/netfs/write_retry.c

diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index 7492c4aa331e..cbb30bdeacc4 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -15,7 +15,8 @@ netfs-y := \
 	read_retry.o \
 	rolling_buffer.o \
 	write_collect.o \
-	write_issue.o
+	write_issue.o \
+	write_retry.o
 
 netfs-$(CONFIG_NETFS_STATS) += stats.o
 
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 6aa2a8d49b37..73887525e939 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -189,6 +189,11 @@ int netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_contr
 			   struct folio *writethrough_cache);
 int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait, size_t len);
 
+/*
+ * write_retry.c
+ */
+void netfs_retry_writes(struct netfs_io_request *wreq);
+
 /*
  * Miscellaneous functions.
  */
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index f3fab41ca3e5..85e8e94da90a 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -151,221 +151,6 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
 	wreq->buffer.first_tail_slot = slot;
 }
 
-/*
- * Perform retries on the streams that need it.
- */
-static void netfs_retry_write_stream(struct netfs_io_request *wreq,
-				     struct netfs_io_stream *stream)
-{
-	struct list_head *next;
-
-	_enter("R=%x[%x:]", wreq->debug_id, stream->stream_nr);
-
-	if (list_empty(&stream->subrequests))
-		return;
-
-	if (stream->source == NETFS_UPLOAD_TO_SERVER &&
-	    wreq->netfs_ops->retry_request)
-		wreq->netfs_ops->retry_request(wreq, stream);
-
-	if (unlikely(stream->failed))
-		return;
-
-	/* If there's no renegotiation to do, just resend each failed subreq. */
-	if (!stream->prepare_write) {
-		struct netfs_io_subrequest *subreq;
-
-		list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
-			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
-				break;
-			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
-				struct iov_iter source = subreq->io_iter;
-
-				iov_iter_revert(&source, subreq->len - source.count);
-				__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
-				netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-				netfs_reissue_write(stream, subreq, &source);
-			}
-		}
-		return;
-	}
-
-	next = stream->subrequests.next;
-
-	do {
-		struct netfs_io_subrequest *subreq = NULL, *from, *to, *tmp;
-		struct iov_iter source;
-		unsigned long long start, len;
-		size_t part;
-		bool boundary = false;
-
-		/* Go through the stream and find the next span of contiguous
-		 * data that we then rejig (cifs, for example, needs the wsize
-		 * renegotiating) and reissue.
-		 */
-		from = list_entry(next, struct netfs_io_subrequest, rreq_link);
-		to = from;
-		start = from->start + from->transferred;
-		len   = from->len   - from->transferred;
-
-		if (test_bit(NETFS_SREQ_FAILED, &from->flags) ||
-		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
-			return;
-
-		list_for_each_continue(next, &stream->subrequests) {
-			subreq = list_entry(next, struct netfs_io_subrequest, rreq_link);
-			if (subreq->start + subreq->transferred != start + len ||
-			    test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags) ||
-			    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
-				break;
-			to = subreq;
-			len += to->len;
-		}
-
-		/* Determine the set of buffers we're going to use.  Each
-		 * subreq gets a subset of a single overall contiguous buffer.
-		 */
-		netfs_reset_iter(from);
-		source = from->io_iter;
-		source.count = len;
-
-		/* Work through the sublist. */
-		subreq = from;
-		list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
-			if (!len)
-				break;
-			/* Renegotiate max_len (wsize) */
-			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
-			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
-			stream->prepare_write(subreq);
-
-			part = min(len, stream->sreq_max_len);
-			subreq->len = part;
-			subreq->start = start;
-			subreq->transferred = 0;
-			len -= part;
-			start += part;
-			if (len && subreq == to &&
-			    __test_and_clear_bit(NETFS_SREQ_BOUNDARY, &to->flags))
-				boundary = true;
-
-			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-			netfs_reissue_write(stream, subreq, &source);
-			if (subreq == to)
-				break;
-		}
-
-		/* If we managed to use fewer subreqs, we can discard the
-		 * excess; if we used the same number, then we're done.
-		 */
-		if (!len) {
-			if (subreq == to)
-				continue;
-			list_for_each_entry_safe_from(subreq, tmp,
-						      &stream->subrequests, rreq_link) {
-				trace_netfs_sreq(subreq, netfs_sreq_trace_discard);
-				list_del(&subreq->rreq_link);
-				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_done);
-				if (subreq == to)
-					break;
-			}
-			continue;
-		}
-
-		/* We ran out of subrequests, so we need to allocate some more
-		 * and insert them after.
-		 */
-		do {
-			subreq = netfs_alloc_subrequest(wreq);
-			subreq->source		= to->source;
-			subreq->start		= start;
-			subreq->debug_index	= atomic_inc_return(&wreq->subreq_counter);
-			subreq->stream_nr	= to->stream_nr;
-			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
-
-			trace_netfs_sreq_ref(wreq->debug_id, subreq->debug_index,
-					     refcount_read(&subreq->ref),
-					     netfs_sreq_trace_new);
-			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-
-			list_add(&subreq->rreq_link, &to->rreq_link);
-			to = list_next_entry(to, rreq_link);
-			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
-
-			stream->sreq_max_len	= len;
-			stream->sreq_max_segs	= INT_MAX;
-			switch (stream->source) {
-			case NETFS_UPLOAD_TO_SERVER:
-				netfs_stat(&netfs_n_wh_upload);
-				stream->sreq_max_len = umin(len, wreq->wsize);
-				break;
-			case NETFS_WRITE_TO_CACHE:
-				netfs_stat(&netfs_n_wh_write);
-				break;
-			default:
-				WARN_ON_ONCE(1);
-			}
-
-			stream->prepare_write(subreq);
-
-			part = umin(len, stream->sreq_max_len);
-			subreq->len = subreq->transferred + part;
-			len -= part;
-			start += part;
-			if (!len && boundary) {
-				__set_bit(NETFS_SREQ_BOUNDARY, &to->flags);
-				boundary = false;
-			}
-
-			netfs_reissue_write(stream, subreq, &source);
-			if (!len)
-				break;
-
-		} while (len);
-
-	} while (!list_is_head(next, &stream->subrequests));
-}
-
-/*
- * Perform retries on the streams that need it.  If we're doing content
- * encryption and the server copy changed due to a third-party write, we may
- * need to do an RMW cycle and also rewrite the data to the cache.
- */
-static void netfs_retry_writes(struct netfs_io_request *wreq)
-{
-	struct netfs_io_subrequest *subreq;
-	struct netfs_io_stream *stream;
-	int s;
-
-	/* Wait for all outstanding I/O to quiesce before performing retries as
-	 * we may need to renegotiate the I/O sizes.
-	 */
-	for (s = 0; s < NR_IO_STREAMS; s++) {
-		stream = &wreq->io_streams[s];
-		if (!stream->active)
-			continue;
-
-		list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
-			wait_on_bit(&subreq->flags, NETFS_SREQ_IN_PROGRESS,
-				    TASK_UNINTERRUPTIBLE);
-		}
-	}
-
-	// TODO: Enc: Fetch changed partial pages
-	// TODO: Enc: Reencrypt content if needed.
-	// TODO: Enc: Wind back transferred point.
-	// TODO: Enc: Mark cache pages for retry.
-
-	for (s = 0; s < NR_IO_STREAMS; s++) {
-		stream = &wreq->io_streams[s];
-		if (stream->need_retry) {
-			stream->need_retry = false;
-			netfs_retry_write_stream(wreq, stream);
-		}
-	}
-}
-
 /*
  * Collect and assess the results of various write subrequests.  We may need to
  * retry some of the results - or even do an RMW cycle for content crypto.
diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
new file mode 100644
index 000000000000..2222c3a6b9d1
--- /dev/null
+++ b/fs/netfs/write_retry.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Network filesystem write retrying.
+ *
+ * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+/*
+ * Perform retries on the streams that need it.
+ */
+static void netfs_retry_write_stream(struct netfs_io_request *wreq,
+				     struct netfs_io_stream *stream)
+{
+	struct list_head *next;
+
+	_enter("R=%x[%x:]", wreq->debug_id, stream->stream_nr);
+
+	if (list_empty(&stream->subrequests))
+		return;
+
+	if (stream->source == NETFS_UPLOAD_TO_SERVER &&
+	    wreq->netfs_ops->retry_request)
+		wreq->netfs_ops->retry_request(wreq, stream);
+
+	if (unlikely(stream->failed))
+		return;
+
+	/* If there's no renegotiation to do, just resend each failed subreq. */
+	if (!stream->prepare_write) {
+		struct netfs_io_subrequest *subreq;
+
+		list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
+			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
+				break;
+			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
+				struct iov_iter source = subreq->io_iter;
+
+				iov_iter_revert(&source, subreq->len - source.count);
+				__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
+				netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
+				netfs_reissue_write(stream, subreq, &source);
+			}
+		}
+		return;
+	}
+
+	next = stream->subrequests.next;
+
+	do {
+		struct netfs_io_subrequest *subreq = NULL, *from, *to, *tmp;
+		struct iov_iter source;
+		unsigned long long start, len;
+		size_t part;
+		bool boundary = false;
+
+		/* Go through the stream and find the next span of contiguous
+		 * data that we then rejig (cifs, for example, needs the wsize
+		 * renegotiating) and reissue.
+		 */
+		from = list_entry(next, struct netfs_io_subrequest, rreq_link);
+		to = from;
+		start = from->start + from->transferred;
+		len   = from->len   - from->transferred;
+
+		if (test_bit(NETFS_SREQ_FAILED, &from->flags) ||
+		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
+			return;
+
+		list_for_each_continue(next, &stream->subrequests) {
+			subreq = list_entry(next, struct netfs_io_subrequest, rreq_link);
+			if (subreq->start + subreq->transferred != start + len ||
+			    test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags) ||
+			    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
+				break;
+			to = subreq;
+			len += to->len;
+		}
+
+		/* Determine the set of buffers we're going to use.  Each
+		 * subreq gets a subset of a single overall contiguous buffer.
+		 */
+		netfs_reset_iter(from);
+		source = from->io_iter;
+		source.count = len;
+
+		/* Work through the sublist. */
+		subreq = from;
+		list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
+			if (!len)
+				break;
+			/* Renegotiate max_len (wsize) */
+			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
+			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
+			stream->prepare_write(subreq);
+
+			part = min(len, stream->sreq_max_len);
+			subreq->len = part;
+			subreq->start = start;
+			subreq->transferred = 0;
+			len -= part;
+			start += part;
+			if (len && subreq == to &&
+			    __test_and_clear_bit(NETFS_SREQ_BOUNDARY, &to->flags))
+				boundary = true;
+
+			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
+			netfs_reissue_write(stream, subreq, &source);
+			if (subreq == to)
+				break;
+		}
+
+		/* If we managed to use fewer subreqs, we can discard the
+		 * excess; if we used the same number, then we're done.
+		 */
+		if (!len) {
+			if (subreq == to)
+				continue;
+			list_for_each_entry_safe_from(subreq, tmp,
+						      &stream->subrequests, rreq_link) {
+				trace_netfs_sreq(subreq, netfs_sreq_trace_discard);
+				list_del(&subreq->rreq_link);
+				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_done);
+				if (subreq == to)
+					break;
+			}
+			continue;
+		}
+
+		/* We ran out of subrequests, so we need to allocate some more
+		 * and insert them after.
+		 */
+		do {
+			subreq = netfs_alloc_subrequest(wreq);
+			subreq->source		= to->source;
+			subreq->start		= start;
+			subreq->debug_index	= atomic_inc_return(&wreq->subreq_counter);
+			subreq->stream_nr	= to->stream_nr;
+			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
+
+			trace_netfs_sreq_ref(wreq->debug_id, subreq->debug_index,
+					     refcount_read(&subreq->ref),
+					     netfs_sreq_trace_new);
+			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
+
+			list_add(&subreq->rreq_link, &to->rreq_link);
+			to = list_next_entry(to, rreq_link);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
+
+			stream->sreq_max_len	= len;
+			stream->sreq_max_segs	= INT_MAX;
+			switch (stream->source) {
+			case NETFS_UPLOAD_TO_SERVER:
+				netfs_stat(&netfs_n_wh_upload);
+				stream->sreq_max_len = umin(len, wreq->wsize);
+				break;
+			case NETFS_WRITE_TO_CACHE:
+				netfs_stat(&netfs_n_wh_write);
+				break;
+			default:
+				WARN_ON_ONCE(1);
+			}
+
+			stream->prepare_write(subreq);
+
+			part = umin(len, stream->sreq_max_len);
+			subreq->len = subreq->transferred + part;
+			len -= part;
+			start += part;
+			if (!len && boundary) {
+				__set_bit(NETFS_SREQ_BOUNDARY, &to->flags);
+				boundary = false;
+			}
+
+			netfs_reissue_write(stream, subreq, &source);
+			if (!len)
+				break;
+
+		} while (len);
+
+	} while (!list_is_head(next, &stream->subrequests));
+}
+
+/*
+ * Perform retries on the streams that need it.  If we're doing content
+ * encryption and the server copy changed due to a third-party write, we may
+ * need to do an RMW cycle and also rewrite the data to the cache.
+ */
+void netfs_retry_writes(struct netfs_io_request *wreq)
+{
+	struct netfs_io_subrequest *subreq;
+	struct netfs_io_stream *stream;
+	int s;
+
+	/* Wait for all outstanding I/O to quiesce before performing retries as
+	 * we may need to renegotiate the I/O sizes.
+	 */
+	for (s = 0; s < NR_IO_STREAMS; s++) {
+		stream = &wreq->io_streams[s];
+		if (!stream->active)
+			continue;
+
+		list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
+			wait_on_bit(&subreq->flags, NETFS_SREQ_IN_PROGRESS,
+				    TASK_UNINTERRUPTIBLE);
+		}
+	}
+
+	// TODO: Enc: Fetch changed partial pages
+	// TODO: Enc: Reencrypt content if needed.
+	// TODO: Enc: Wind back transferred point.
+	// TODO: Enc: Mark cache pages for retry.
+
+	for (s = 0; s < NR_IO_STREAMS; s++) {
+		stream = &wreq->io_streams[s];
+		if (stream->need_retry) {
+			stream->need_retry = false;
+			netfs_retry_write_stream(wreq, stream);
+		}
+	}
+}

