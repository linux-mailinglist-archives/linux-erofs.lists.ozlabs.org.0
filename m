Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E4C9F3B19
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 21:42:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBsMM6YQmz30TF
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Dec 2024 07:42:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734381758;
	cv=none; b=SmwUOI3qX6gNjv/+vR8kfTJWGtgFxCxNpw6YeOmfpm3cxliOUp1B/qczbanN42xE+LQEkiZbEn30bc1AB1xByDg3pvyLOLB8VUAu4wpc6gCKC3xck4S2miBC1NvbfBi1LmmaBDWLnDfg12Ih1HMaUlO2fnCw3jBQfE6WI1Sy0WQiuP2aWJsr4viM//bi1D+4XPzIcRpuxP1a3vWPhteafKHVT38mqIOiCGRwdJ0BrcmxelK0UJVFsWsTPQgP88DAvU/PzwHvZK1ZJy427W4yV2pSIB0Bofr6jnRQl/f7BsGshDHUVObBw9TLBC28VdFaWdC9G5PxWXcydoMcwqXGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734381758; c=relaxed/relaxed;
	bh=tboFbah+PcU77lvgcwfZknDfZl+xlNs7cV2DYPyMbms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZrabWbBdlb5idiF5BihtPPWP2DD2pUJkPMXhtNJ0ZWFyA8QBIbqxdRFOK/x32EbiaQk1pVeq5pIrMFu7nZiUpCAjzLfzHPyIMhtw57ry+i49aXbQnx/JQ5eq4cdojyhJ+z7zjhj+S/6nYY6JPdmCiaLBfWf2t2/uw4ZKbG2HlukoVTtH43fzbSDtPw03xXpWz2/E01zZvCMYvb1Q/Nm3XEq7fhVUirL4r7z/IPon1vS0BmVBdx0urRz9HrqaD4u2OMZy+6qsYpt0RUk7cHBgjc3jWjn+SYYr0RilRWV7Xmk2fiG5s6i7sDQvFYONh3D4ObF6izoQSq/j+BoN8JVMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=baZwI+9M; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q1SdH235; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=baZwI+9M;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q1SdH235;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBsMK4ZSgz2xxw
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Dec 2024 07:42:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tboFbah+PcU77lvgcwfZknDfZl+xlNs7cV2DYPyMbms=;
	b=baZwI+9MN+K++N5+d3SuMMSf8a55in565s6+s738C1ERWCPjoJKARR/0Nid2TrfzW+/C2p
	IUjfh2JYtgWJYiXHBzdoK5zwFsr2hG3+LmRGuT5AiljSG8rN1jMy1NrHzGjgwER/CvhOff
	Ca6hC65oU2RcEoz0Vny5S0H21z52ofo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tboFbah+PcU77lvgcwfZknDfZl+xlNs7cV2DYPyMbms=;
	b=Q1SdH235ql5CiGUQy3n2q1790t1GtrwkXf1UK4PQAkMRJlzdIM0S9yGpuCs3ICrZmFUV5s
	MO0CGd33G2/Wnn5jdt/0NOrg+mAD80YTgL8tnhlvNI1KRa9pEn43Wt+Hw/KT6S2wimPN5/
	PO0029E/2n5R4bBs36Xu6PwVEotUh+I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-QfGO2vp4N3iChtUdFctM9A-1; Mon,
 16 Dec 2024 15:42:31 -0500
X-MC-Unique: QfGO2vp4N3iChtUdFctM9A-1
X-Mimecast-MFC-AGG-ID: QfGO2vp4N3iChtUdFctM9A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DA6619560B7;
	Mon, 16 Dec 2024 20:42:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F8531956053;
	Mon, 16 Dec 2024 20:42:22 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 07/32] netfs: Split retry code out of fs/netfs/write_collect.c
Date: Mon, 16 Dec 2024 20:40:57 +0000
Message-ID: <20241216204124.3752367-8-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
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
 fs/netfs/write_collect.c | 214 ------------------------------------
 fs/netfs/write_retry.c   | 226 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 233 insertions(+), 215 deletions(-)
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
index 364c1f9d5815..237018caba27 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -151,220 +151,6 @@ static void netfs_writeback_unlock_folios(struct netfs_io_request *wreq,
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
-			subreq->retry_count++;
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
-			subreq->retry_count	= 1;
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
index 000000000000..f3d5e37d4698
--- /dev/null
+++ b/fs/netfs/write_retry.c
@@ -0,0 +1,226 @@
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
+			subreq->retry_count++;
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
+			subreq->retry_count	= 1;
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

