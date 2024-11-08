Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4459C2333
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Nov 2024 18:35:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XlR0p1Ktrz3c20
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Nov 2024 04:35:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731087321;
	cv=none; b=EPWDZtt/5Rmx5NTtlzVmuVt6xIkDK+qbPH1g4JWWkYcwQKWisKtdxwXgLNdwgXuc2Bot8VWof500+/yUZCeLczHs1dxW3hXlUb5pdoKM3RUP0XmJ7yUqAlizLIED7MQtNU+v9shVl3jXDSlga17F5GUrVAdy2iIsxIGUfy60yivh0xOu90qwZIboVnwYJWf5348++EjAc0GTi3B42O8Q7jKVadvjlmv5tRJAByUUeIxAh8nCBdG/lQd2f05rWD4ctazhzWrxRgh2rYhQuBnse5mC11Rg51aTvveMNl6BOdejCxq26Jf25uAXj46xmjAn0hP4hY/rrijkGnDLxn1/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731087321; c=relaxed/relaxed;
	bh=NCjiDuYPLh8EX/SFjmoUAd9DPkvd6EWcQ/jqW9O8MdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7Uc07oGQtnIoe1LGpZROfObdLSjT3+v93LeJZSQmjUsklE+D0qxV97AQnfWLreCnTpY+r5+vNMIhaDPtER3a4TRA4pgUOlXriVw9OeQuN7xoOQTrwwoqwiuGuFUEhbbnHfavt0gnPiHRm7CNcsX6FIEaJNuwNFqXwiDTh6mGZTJISdAjsa+NWceI5fs2Yrw6DbUcvx1xXMPJ2/1gJHuiyh1WoyX7+b1WtvyA0JNYZkpjMpK8D0r+oJr9S6cVeA/zkWvvK3Yn5PRw2kXWuIWDAYfQDuzJnU5FnhjiaY5Txp9YN0ewstfe5COWP9AMqga3Y6Gr8NZHmrXxCDBkgEYZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RHcn6Jdm; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RHcn6Jdm; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RHcn6Jdm;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RHcn6Jdm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XlR0m0SSNz3bkY
	for <linux-erofs@lists.ozlabs.org>; Sat,  9 Nov 2024 04:35:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731087317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NCjiDuYPLh8EX/SFjmoUAd9DPkvd6EWcQ/jqW9O8MdE=;
	b=RHcn6JdmpNYLVUj/kRFAe0SznavZHav+OhUxM4NvYbPRR4cEd0NXBsWS+A0zofVuk8Ceyx
	gaxbSN96cr6qrqE0TsA4+ED7ckBIDPVW84cACZE134MD/HI7qWDxuk+6L8Q7xsz5gV70mO
	90F6vpKDP2bgm/2oj838dNk1lWHo1RY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731087317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NCjiDuYPLh8EX/SFjmoUAd9DPkvd6EWcQ/jqW9O8MdE=;
	b=RHcn6JdmpNYLVUj/kRFAe0SznavZHav+OhUxM4NvYbPRR4cEd0NXBsWS+A0zofVuk8Ceyx
	gaxbSN96cr6qrqE0TsA4+ED7ckBIDPVW84cACZE134MD/HI7qWDxuk+6L8Q7xsz5gV70mO
	90F6vpKDP2bgm/2oj838dNk1lWHo1RY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-qDKTEzG6PWWaHc7ckoxNVQ-1; Fri,
 08 Nov 2024 12:35:12 -0500
X-MC-Unique: qDKTEzG6PWWaHc7ckoxNVQ-1
X-Mimecast-MFC-AGG-ID: qDKTEzG6PWWaHc7ckoxNVQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78DC219560B0;
	Fri,  8 Nov 2024 17:35:09 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 09DB9300019E;
	Fri,  8 Nov 2024 17:35:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 20/33] netfs: Add functions to build/clean a buffer in a folio_queue
Date: Fri,  8 Nov 2024 17:32:21 +0000
Message-ID: <20241108173236.1382366-21-dhowells@redhat.com>
In-Reply-To: <20241108173236.1382366-1-dhowells@redhat.com>
References: <20241108173236.1382366-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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

Add two netfslib functions to build up or clean up a buffer in a
folio_queue.  The first, netfs_alloc_folioq_buffer() will add folios to a
buffer, extending up at least to the given size.  If it can, it will add
multipage folios.  The folios are optionally have the mapping set and will
have the index set according to the distance from the front of the folio
queue.

The second function will free up a folio queue and put any folios in the
queue that have the first mark set.

The netfs_folio tracepoint is also altered to cope with folios that have a
NULL mapping, and the folios being added/put will have trace lines emitted
and will be accounted in the stats.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: netfs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/misc.c              | 95 ++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h        |  6 +++
 include/trace/events/netfs.h |  6 +--
 3 files changed, 103 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 4249715f4171..01a6ba0e2f82 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -8,6 +8,101 @@
 #include <linux/swap.h>
 #include "internal.h"
 
+/**
+ * netfs_alloc_folioq_buffer - Allocate buffer space into a folio queue
+ * @mapping: Address space to set on the folio (or NULL).
+ * @_buffer: Pointer to the folio queue to add to (may point to a NULL; updated).
+ * @_cur_size: Current size of the buffer (updated).
+ * @size: Target size of the buffer.
+ * @gfp: The allocation constraints.
+ */
+int netfs_alloc_folioq_buffer(struct address_space *mapping,
+			      struct folio_queue **_buffer,
+			      size_t *_cur_size, ssize_t size, gfp_t gfp)
+{
+	struct folio_queue *tail = *_buffer, *p;
+
+	size = round_up(size, PAGE_SIZE);
+	if (*_cur_size >= size)
+		return 0;
+
+	if (tail)
+		while (tail->next)
+			tail = tail->next;
+
+	do {
+		struct folio *folio;
+		int order = 0, slot;
+
+		if (!tail || folioq_full(tail)) {
+			p = netfs_folioq_alloc(0, GFP_NOFS, netfs_trace_folioq_alloc_buffer);
+			if (!p)
+				return -ENOMEM;
+			if (tail) {
+				tail->next = p;
+				p->prev = tail;
+			} else {
+				*_buffer = p;
+			}
+			tail = p;
+		}
+
+		if (size - *_cur_size > PAGE_SIZE)
+			order = umin(ilog2(size - *_cur_size) - PAGE_SHIFT,
+				     MAX_PAGECACHE_ORDER);
+
+		folio = folio_alloc(gfp, order);
+		if (!folio && order > 0)
+			folio = folio_alloc(gfp, 0);
+		if (!folio)
+			return -ENOMEM;
+
+		folio->mapping = mapping;
+		folio->index = *_cur_size / PAGE_SIZE;
+		trace_netfs_folio(folio, netfs_folio_trace_alloc_buffer);
+		slot = folioq_append_mark(tail, folio);
+		*_cur_size += folioq_folio_size(tail, slot);
+	} while (*_cur_size < size);
+
+	return 0;
+}
+EXPORT_SYMBOL(netfs_alloc_folioq_buffer);
+
+/**
+ * netfs_free_folioq_buffer - Free a folio queue.
+ * @fq: The start of the folio queue to free
+ *
+ * Free up a chain of folio_queues and, if marked, the marked folios they point
+ * to.
+ */
+void netfs_free_folioq_buffer(struct folio_queue *fq)
+{
+	struct folio_queue *next;
+	struct folio_batch fbatch;
+
+	folio_batch_init(&fbatch);
+
+	for (; fq; fq = next) {
+		for (int slot = 0; slot < folioq_count(fq); slot++) {
+			struct folio *folio = folioq_folio(fq, slot);
+			if (!folio ||
+			    !folioq_is_marked(fq, slot))
+				continue;
+
+			trace_netfs_folio(folio, netfs_folio_trace_put);
+			if (folio_batch_add(&fbatch, folio))
+				folio_batch_release(&fbatch);
+		}
+
+		netfs_stat_d(&netfs_n_folioq);
+		next = fq->next;
+		kfree(fq);
+	}
+
+	folio_batch_release(&fbatch);
+}
+EXPORT_SYMBOL(netfs_free_folioq_buffer);
+
 /*
  * Reset the subrequest iterator to refer just to the region remaining to be
  * read.  The iterator may or may not have been advanced by socket ops or
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 738c9c8763f0..921cfcfc62f1 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -458,6 +458,12 @@ struct folio_queue *netfs_folioq_alloc(unsigned int rreq_id, gfp_t gfp,
 void netfs_folioq_free(struct folio_queue *folioq,
 		       unsigned int /*enum netfs_trace_folioq*/ trace);
 
+/* Buffer wrangling helpers API. */
+int netfs_alloc_folioq_buffer(struct address_space *mapping,
+			      struct folio_queue **_buffer,
+			      size_t *_cur_size, ssize_t size, gfp_t gfp);
+void netfs_free_folioq_buffer(struct folio_queue *fq);
+
 /**
  * netfs_inode - Get the netfs inode context from the inode
  * @inode: The inode to query
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 7c3c866ae183..167c89bc62e0 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -155,6 +155,7 @@
 	EM(netfs_streaming_filled_page,		"mod-streamw-f") \
 	EM(netfs_streaming_cont_filled_page,	"mod-streamw-f+") \
 	EM(netfs_folio_trace_abandon,		"abandon")	\
+	EM(netfs_folio_trace_alloc_buffer,	"alloc-buf")	\
 	EM(netfs_folio_trace_cancel_copy,	"cancel-copy")	\
 	EM(netfs_folio_trace_cancel_store,	"cancel-store")	\
 	EM(netfs_folio_trace_clear,		"clear")	\
@@ -195,10 +196,7 @@
 	E_(netfs_trace_donate_to_deferred_next,	"defer-next")
 
 #define netfs_folioq_traces					\
-	EM(netfs_trace_folioq_alloc_append_folio, "alloc-apf")	\
-	EM(netfs_trace_folioq_alloc_read_prep,	"alloc-r-prep")	\
-	EM(netfs_trace_folioq_alloc_read_prime,	"alloc-r-prime") \
-	EM(netfs_trace_folioq_alloc_read_sing,	"alloc-r-sing")	\
+	EM(netfs_trace_folioq_alloc_buffer,	"alloc-buf")	\
 	EM(netfs_trace_folioq_clear,		"clear")	\
 	EM(netfs_trace_folioq_delete,		"delete")	\
 	EM(netfs_trace_folioq_make_space,	"make-space")	\

