Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A585B97ED9F
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 17:08:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XC5wc4X6xz2ygG
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 01:08:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727104110;
	cv=none; b=Y00ABVXvbSi8jjXg9N5WC6dbfTSNll2INXVDQvlG1BknWimvBq075RI1zgH1Q2bGy4Q9qJ5Hm/LgDZIuCH5RfIVidIN+XLUBI11EzK2baV6jDUW+9tCOC2MFZEOinPZ3Oz07L02ifpPT9xjw93JQPm4YJR6inqISQWSOsXlBGZdDq8jLQB8HHcECRgcW+aD6AxV+KdB8efYgk+rFUOM9w+sriexHn9kNrqMQA4UDRybHJOK3ZAhmX74eq4EV1YNyijmAxCI6lNOfKPMBH13su8BAidn7XMHUlrWpfgO57yVlsdeInwUvaY1/td2qfU8GlpjPHFTNpaRk7eeE/NmADw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727104110; c=relaxed/relaxed;
	bh=gjwTy2CufmK+GO1xgTXd2oAVeAy0cQHbPCXVo8T8uFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7OYsQkON7s1akMKiF89K82oKVMev8VlGKX6SiwOs3QzSsYRwAsFn9znWNKR302kFIzTHJcBA7uSgcVh2NlgClHdgEfgH/aXmgNGOGKYgZBGB+bPLZgE5robR7RSKnMHOqXqEFSda/trED6DRkVoqbh98ScLUJtpvUb1m7hitiOAHZuKipMjskYQ4guYkhAJy5MSauIqOQ5VHGFA2jzyYY21JKgzrE21j8C6oMIB0YBbTWsHTSXyoL3XOpAa7KO11EK9hzWRIQq7zcWX+6lxezdcuC90MABPyLAf093f1OcMSNJ1eJafBOxoDpXcQRJgx9o4M61rcka76n1TvIBniw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NzVX9lQ2; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NzVX9lQ2; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NzVX9lQ2;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NzVX9lQ2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XC5wY53QTz2xb9
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 01:08:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjwTy2CufmK+GO1xgTXd2oAVeAy0cQHbPCXVo8T8uFE=;
	b=NzVX9lQ2oRm0Zb/uImSuTPiRIcWK7z0LPoz2qkJ36lHc7+eaU3oLRU5svkqZw0cimF6B42
	53QOFMduGY7aDpewsQGhEFsoDWHzDwGBO4blpTurg/eyoH4s/4r9zC1iE4gZm2aHmaBxKV
	GypKZ63RfTml1/ECmS8q4a+7LtcrlUs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjwTy2CufmK+GO1xgTXd2oAVeAy0cQHbPCXVo8T8uFE=;
	b=NzVX9lQ2oRm0Zb/uImSuTPiRIcWK7z0LPoz2qkJ36lHc7+eaU3oLRU5svkqZw0cimF6B42
	53QOFMduGY7aDpewsQGhEFsoDWHzDwGBO4blpTurg/eyoH4s/4r9zC1iE4gZm2aHmaBxKV
	GypKZ63RfTml1/ECmS8q4a+7LtcrlUs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-UWp1-QJNN32pkqNt_84yjg-1; Mon,
 23 Sep 2024 11:08:21 -0400
X-MC-Unique: UWp1-QJNN32pkqNt_84yjg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C48718FFACF;
	Mon, 23 Sep 2024 15:08:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.145])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 866FE19349BD;
	Mon, 23 Sep 2024 15:08:12 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH 2/8] netfs: Drop the was_async arg from netfs_read_subreq_terminated()
Date: Mon, 23 Sep 2024 16:07:46 +0100
Message-ID: <20240923150756.902363-3-dhowells@redhat.com>
In-Reply-To: <20240923150756.902363-1-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Drop the was_async argument from netfs_read_subreq_terminated().  Almost
every caller is either in process context and passes false.  Some
filesystems delegate the call to a workqueue to avoid doing the work in
their network message queue parsing thread.

The only exception is netfs_cache_read_terminated() which handles
completion in the cache - which is usually a callback from the backing
filesystem in softirq context, though it can be from process context if an
error occurred.  In this case, delegate to a workqueue.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/CAHk-=wiVC5Cgyz6QKXFu6fTaA6h4CjexDR-OV9kL6Vo5x9v8=A@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c         |  3 +-
 fs/afs/file.c            | 15 ++++---
 fs/afs/fsclient.c        |  2 +-
 fs/afs/yfsclient.c       |  2 +-
 fs/ceph/addr.c           | 13 ++++--
 fs/netfs/buffered_read.c | 16 +++----
 fs/netfs/direct_read.c   |  2 +-
 fs/netfs/internal.h      |  2 +-
 fs/netfs/objects.c       | 17 ++++++-
 fs/netfs/read_collect.c  | 95 +++++++++++++++++-----------------------
 fs/netfs/read_retry.c    |  2 +-
 fs/nfs/fscache.c         |  6 ++-
 fs/nfs/fscache.h         |  3 +-
 fs/smb/client/cifssmb.c  | 10 +----
 fs/smb/client/file.c     |  3 +-
 fs/smb/client/smb2pdu.c  | 10 +----
 include/linux/netfs.h    |  7 ++-
 17 files changed, 101 insertions(+), 107 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 819c75233235..e4144e1a10a9 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -83,7 +83,8 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 	if (!err)
 		subreq->transferred += total;
 
-	netfs_read_subreq_terminated(subreq, err, false);
+	subreq->error = err;
+	netfs_read_subreq_terminated(subreq);
 }
 
 /**
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 492d857a3fa0..1d30924cec5b 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -246,7 +246,8 @@ static void afs_fetch_data_notify(struct afs_operation *op)
 		subreq->rreq->i_size = req->file_size;
 		if (req->pos + req->actual_len >= req->file_size)
 			__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
-		netfs_read_subreq_terminated(subreq, error, false);
+		subreq->error = error;
+		netfs_read_subreq_terminated(subreq);
 		req->subreq = NULL;
 	} else if (req->done) {
 		req->done(req);
@@ -301,8 +302,10 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 
 	op = afs_alloc_operation(req->key, vnode->volume);
 	if (IS_ERR(op)) {
-		if (req->subreq)
-			netfs_read_subreq_terminated(req->subreq, PTR_ERR(op), false);
+		if (req->subreq) {
+			req->subreq->error = PTR_ERR(op);
+			netfs_read_subreq_terminated(req->subreq);
+		}
 		return PTR_ERR(op);
 	}
 
@@ -320,8 +323,10 @@ static void afs_read_worker(struct work_struct *work)
 	struct afs_read *fsreq;
 
 	fsreq = afs_alloc_read(GFP_NOFS);
-	if (!fsreq)
-		return netfs_read_subreq_terminated(subreq, -ENOMEM, false);
+	if (!fsreq) {
+		subreq->error = -ENOMEM;
+		return netfs_read_subreq_terminated(subreq);
+	}
 
 	fsreq->subreq	= subreq;
 	fsreq->pos	= subreq->start + subreq->transferred;
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 098fa034a1cc..784f7daab112 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -352,7 +352,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		ret = afs_extract_data(call, true);
 		if (req->subreq) {
 			req->subreq->transferred += count_before - call->iov_len;
-			netfs_read_subreq_progress(req->subreq, false);
+			netfs_read_subreq_progress(req->subreq);
 		}
 		if (ret < 0)
 			return ret;
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 024227aba4cd..368cf277d801 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -398,7 +398,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		ret = afs_extract_data(call, true);
 		if (req->subreq) {
 			req->subreq->transferred += count_before - call->iov_len;
-			netfs_read_subreq_progress(req->subreq, false);
+			netfs_read_subreq_progress(req->subreq);
 		}
 		if (ret < 0)
 			return ret;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 5d9ccda098cc..0d131101db3d 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -254,8 +254,9 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 		subreq->transferred = err;
 		err = 0;
 	}
+	subreq->error = err;
 	trace_netfs_sreq(subreq, netfs_sreq_trace_io_progress);
-	netfs_read_subreq_terminated(subreq, err, false);
+	netfs_read_subreq_terminated(subreq);
 	iput(req->r_inode);
 	ceph_dec_osd_stopping_blocker(fsc->mdsc);
 }
@@ -315,7 +316,9 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 
 	ceph_mdsc_put_request(req);
 out:
-	netfs_read_subreq_terminated(subreq, err, false);
+	subreq->error = err;
+	trace_netfs_sreq(subreq, netfs_sreq_trace_io_progress);
+	netfs_read_subreq_terminated(subreq);
 	return true;
 }
 
@@ -427,8 +430,10 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	ceph_osdc_start_request(req->r_osdc, req);
 out:
 	ceph_osdc_put_request(req);
-	if (err)
-		netfs_read_subreq_terminated(subreq, err, false);
+	if (err) {
+		subreq->error = err;
+		netfs_read_subreq_terminated(subreq);
+	}
 	doutc(cl, "%llx.%llx result %d\n", ceph_vinop(inode), err);
 }
 
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index c40e226053cc..518799894990 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -183,13 +183,12 @@ static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error
 	struct netfs_io_subrequest *subreq = priv;
 
 	if (transferred_or_error < 0) {
-		netfs_read_subreq_terminated(subreq, transferred_or_error, was_async);
-		return;
-	}
-
-	if (transferred_or_error > 0)
+		subreq->error = transferred_or_error;
+	} else {
+		subreq->error = 0;
 		subreq->transferred += transferred_or_error;
-	netfs_read_subreq_terminated(subreq, 0, was_async);
+	}
+	schedule_work(&subreq->work);
 }
 
 /*
@@ -295,7 +294,8 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			netfs_stat(&netfs_n_rh_zero);
 			slice = netfs_prepare_read_iterator(subreq);
 			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
-			netfs_read_subreq_terminated(subreq, 0, false);
+			subreq->error = 0;
+			netfs_read_subreq_terminated(subreq);
 			goto done;
 		}
 
@@ -317,7 +317,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 	} while (size > 0);
 
 	if (atomic_dec_and_test(&rreq->nr_outstanding))
-		netfs_rreq_terminated(rreq, false);
+		netfs_rreq_terminated(rreq);
 
 	/* Defer error return as we may need to wait for outstanding I/O. */
 	cmpxchg(&rreq->error, 0, ret);
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index b1a66a6e6bc2..bde99fe4221b 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -100,7 +100,7 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 	} while (size > 0);
 
 	if (atomic_dec_and_test(&rreq->nr_outstanding))
-		netfs_rreq_terminated(rreq, false);
+		netfs_rreq_terminated(rreq);
 	return ret;
 }
 
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index c9f0ed24cb7b..c7f23dd3556a 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -87,7 +87,7 @@ static inline void netfs_see_request(struct netfs_io_request *rreq,
  * read_collect.c
  */
 void netfs_read_termination_worker(struct work_struct *work);
-void netfs_rreq_terminated(struct netfs_io_request *rreq, bool was_async);
+void netfs_rreq_terminated(struct netfs_io_request *rreq);
 
 /*
  * read_pgpriv2.c
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 31e388ec6e48..d32964e8ca5d 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -56,7 +56,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	    origin == NETFS_READ_GAPS ||
 	    origin == NETFS_READ_FOR_WRITE ||
 	    origin == NETFS_DIO_READ)
-		INIT_WORK(&rreq->work, netfs_read_termination_worker);
+		INIT_WORK(&rreq->work, NULL);
 	else
 		INIT_WORK(&rreq->work, netfs_write_collection_worker);
 
@@ -191,7 +191,20 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq
 	}
 
 	memset(subreq, 0, kmem_cache_size(cache));
-	INIT_WORK(&subreq->work, NULL);
+
+	switch (rreq->origin) {
+	case NETFS_READAHEAD:
+	case NETFS_READPAGE:
+	case NETFS_READ_GAPS:
+	case NETFS_READ_FOR_WRITE:
+	case NETFS_DIO_READ:
+		INIT_WORK(&subreq->work, netfs_read_subreq_termination_worker);
+		break;
+	default:
+		INIT_WORK(&subreq->work, NULL);
+		break;
+	}
+
 	INIT_LIST_HEAD(&subreq->rreq_link);
 	refcount_set(&subreq->ref, 2);
 	subreq->rreq = rreq;
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index b18c65ba5580..4ff4e520fc95 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -83,7 +83,7 @@ static void netfs_unlock_read_folio(struct netfs_io_subrequest *subreq,
  * Unlock any folios that are now completely read.  Returns true if the
  * subrequest is removed from the list.
  */
-static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was_async)
+static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_subrequest *prev, *next;
 	struct netfs_io_request *rreq = subreq->rreq;
@@ -222,8 +222,7 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
 		subreq->curr_folioq_slot = slot;
 		if (folioq && folioq_folio(folioq, slot))
 			subreq->curr_folio_order = folioq->orders[slot];
-		if (!was_async)
-			cond_resched();
+		cond_resched();
 		goto next_folio;
 	}
 
@@ -359,7 +358,7 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
  * Note that we're in normal kernel thread context at this point, possibly
  * running on a workqueue.
  */
-static void netfs_rreq_assess(struct netfs_io_request *rreq)
+void netfs_rreq_terminated(struct netfs_io_request *rreq)
 {
 	trace_netfs_rreq(rreq, netfs_rreq_trace_assess);
 
@@ -386,56 +385,28 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq)
 		netfs_pgpriv2_write_to_the_cache(rreq);
 }
 
-void netfs_read_termination_worker(struct work_struct *work)
-{
-	struct netfs_io_request *rreq =
-		container_of(work, struct netfs_io_request, work);
-	netfs_see_request(rreq, netfs_rreq_trace_see_work);
-	netfs_rreq_assess(rreq);
-	netfs_put_request(rreq, false, netfs_rreq_trace_put_work_complete);
-}
-
-/*
- * Handle the completion of all outstanding I/O operations on a read request.
- * We inherit a ref from the caller.
- */
-void netfs_rreq_terminated(struct netfs_io_request *rreq, bool was_async)
-{
-	if (!was_async)
-		return netfs_rreq_assess(rreq);
-	if (!work_pending(&rreq->work)) {
-		netfs_get_request(rreq, netfs_rreq_trace_get_work);
-		if (!queue_work(system_unbound_wq, &rreq->work))
-			netfs_put_request(rreq, was_async, netfs_rreq_trace_put_work_nq);
-	}
-}
-
 /**
  * netfs_read_subreq_progress - Note progress of a read operation.
- * @subreq: The read request that has terminated.
- * @was_async: True if we're in an asynchronous context.
  *
  * This tells the read side of netfs lib that a contributory I/O operation has
  * made some progress and that it may be possible to unlock some folios.
  *
  * Before calling, the filesystem should update subreq->transferred to track
  * the amount of data copied into the output buffer.
- *
- * If @was_async is true, the caller might be running in softirq or interrupt
- * context and we can't sleep.
  */
-void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq,
-				bool was_async)
+void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 
+	might_sleep();
+
 	trace_netfs_sreq(subreq, netfs_sreq_trace_progress);
 
 	if (subreq->transferred > subreq->consumed &&
 	    (rreq->origin == NETFS_READAHEAD ||
 	     rreq->origin == NETFS_READPAGE ||
 	     rreq->origin == NETFS_READ_FOR_WRITE)) {
-		netfs_consume_read_data(subreq, was_async);
+		netfs_consume_read_data(subreq);
 		__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
 	}
 }
@@ -444,28 +415,25 @@ EXPORT_SYMBOL(netfs_read_subreq_progress);
 /**
  * netfs_read_subreq_terminated - Note the termination of an I/O operation.
  * @subreq: The I/O request that has terminated.
- * @error: Error code indicating type of completion.
- * @was_async: The termination was asynchronous
  *
  * This tells the read helper that a contributory I/O operation has terminated,
  * one way or another, and that it should integrate the results.
  *
- * The caller indicates the outcome of the operation through @error, supplying
- * 0 to indicate a successful or retryable transfer (if NETFS_SREQ_NEED_RETRY
- * is set) or a negative error code.  The helper will look after reissuing I/O
- * operations as appropriate and writing downloaded data to the cache.
+ * The caller indicates the outcome of the operation through @subreq->error,
+ * supplying 0 to indicate a successful or retryable transfer (if
+ * NETFS_SREQ_NEED_RETRY is set) or a negative error code.  The helper will
+ * look after reissuing I/O operations as appropriate and writing downloaded
+ * data to the cache.
  *
  * Before calling, the filesystem should update subreq->transferred to track
  * the amount of data copied into the output buffer.
- *
- * If @was_async is true, the caller might be running in softirq or interrupt
- * context and we can't sleep.
  */
-void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
-				  int error, bool was_async)
+void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 
+	might_sleep();
+
 	switch (subreq->source) {
 	case NETFS_READ_FROM_CACHE:
 		netfs_stat(&netfs_n_rh_read_done);
@@ -483,7 +451,7 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 		 * If the read completed validly short, then we can clear the
 		 * tail before going on to unlock the folios.
 		 */
-		if (error == 0 && subreq->transferred < subreq->len &&
+		if (subreq->error == 0 && subreq->transferred < subreq->len &&
 		    (test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags) ||
 		     test_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags))) {
 			netfs_clear_unread(subreq);
@@ -494,7 +462,7 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 		    (rreq->origin == NETFS_READAHEAD ||
 		     rreq->origin == NETFS_READPAGE ||
 		     rreq->origin == NETFS_READ_FOR_WRITE)) {
-			netfs_consume_read_data(subreq, was_async);
+			netfs_consume_read_data(subreq);
 			__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
 		}
 		rreq->transferred += subreq->transferred;
@@ -503,7 +471,7 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 	/* Deal with retry requests, short reads and errors.  If we retry
 	 * but don't make progress, we abandon the attempt.
 	 */
-	if (!error && subreq->transferred < subreq->len) {
+	if (!subreq->error && subreq->transferred < subreq->len) {
 		if (test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags)) {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_hit_eof);
 		} else {
@@ -517,16 +485,15 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
 			} else {
 				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
-				error = -ENODATA;
+				subreq->error = -ENODATA;
 			}
 		}
 	}
 
-	subreq->error = error;
 	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
 
-	if (unlikely(error < 0)) {
-		trace_netfs_failure(rreq, subreq, error, netfs_fail_read);
+	if (unlikely(subreq->error < 0)) {
+		trace_netfs_failure(rreq, subreq, subreq->error, netfs_fail_read);
 		if (subreq->source == NETFS_READ_FROM_CACHE) {
 			netfs_stat(&netfs_n_rh_read_failed);
 		} else {
@@ -537,8 +504,24 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 	}
 
 	if (atomic_dec_and_test(&rreq->nr_outstanding))
-		netfs_rreq_terminated(rreq, was_async);
+		netfs_rreq_terminated(rreq);
 
-	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
+	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_terminated);
 }
 EXPORT_SYMBOL(netfs_read_subreq_terminated);
+
+/**
+ * netfs_read_subreq_termination_worker - Workqueue helper for read termination
+ * @work: The subreq->work in the I/O request that has been terminated.
+ *
+ * Helper function to jump to netfs_read_subreq_terminated() from the
+ * subrequest work item.
+ */
+void netfs_read_subreq_termination_worker(struct work_struct *work)
+{
+	struct netfs_io_subrequest *subreq =
+		container_of(work, struct netfs_io_subrequest, work);
+
+	netfs_read_subreq_terminated(subreq);
+}
+EXPORT_SYMBOL(netfs_read_subreq_termination_worker);
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 0350592ea804..3f29e823d379 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -232,7 +232,7 @@ void netfs_retry_reads(struct netfs_io_request *rreq)
 	netfs_retry_read_subrequests(rreq);
 
 	if (atomic_dec_and_test(&rreq->nr_outstanding))
-		netfs_rreq_terminated(rreq, false);
+		netfs_rreq_terminated(rreq);
 }
 
 /*
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 810269ee0a50..2f3c4f773d73 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -307,8 +307,10 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 			     &nfs_async_read_completion_ops);
 
 	netfs = nfs_netfs_alloc(sreq);
-	if (!netfs)
-		return netfs_read_subreq_terminated(sreq, -ENOMEM, false);
+	if (!netfs) {
+		sreq->error = -ENOMEM;
+		return netfs_read_subreq_terminated(sreq);
+	}
 
 	pgio.pg_netfs = netfs; /* used in completion */
 
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 772d485e96d3..9d86868f4998 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -74,7 +74,8 @@ static inline void nfs_netfs_put(struct nfs_netfs_io_data *netfs)
 	 */
 	netfs->sreq->transferred = min_t(s64, netfs->sreq->len,
 					 atomic64_read(&netfs->transferred));
-	netfs_read_subreq_terminated(netfs->sreq, netfs->error, false);
+	netfs->sreq->error = netfs->error;
+	netfs_read_subreq_terminated(netfs->sreq);
 	kfree(netfs);
 }
 static inline void nfs_netfs_inode_init(struct nfs_inode *nfsi)
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 131f20b91c3e..1f27847350cf 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1261,14 +1261,6 @@ CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms, int *oplock,
 	return rc;
 }
 
-static void cifs_readv_worker(struct work_struct *work)
-{
-	struct cifs_io_subrequest *rdata =
-		container_of(work, struct cifs_io_subrequest, subreq.work);
-
-	netfs_read_subreq_terminated(&rdata->subreq, rdata->result, false);
-}
-
 static void
 cifs_readv_callback(struct mid_q_entry *mid)
 {
@@ -1334,8 +1326,8 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	}
 
 	rdata->credits.value = 0;
+	rdata->subreq.error = rdata->result;
 	rdata->subreq.transferred += rdata->got_bytes;
-	INIT_WORK(&rdata->subreq.work, cifs_readv_worker);
 	queue_work(cifsiod_wq, &rdata->subreq.work);
 	release_mid(mid);
 	add_credits(server, &credits, 0);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 78b59c4ef3ce..fb8e12c3c37c 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -227,7 +227,8 @@ static void cifs_issue_read(struct netfs_io_subrequest *subreq)
 	return;
 
 failed:
-	netfs_read_subreq_terminated(subreq, rc, false);
+	subreq->error = rc;
+	netfs_read_subreq_terminated(subreq);
 }
 
 /*
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 2cb1bf65a172..0b63608aeecb 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4494,14 +4494,6 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 	return rc;
 }
 
-static void smb2_readv_worker(struct work_struct *work)
-{
-	struct cifs_io_subrequest *rdata =
-		container_of(work, struct cifs_io_subrequest, subreq.work);
-
-	netfs_read_subreq_terminated(&rdata->subreq, rdata->result, false);
-}
-
 static void
 smb2_readv_callback(struct mid_q_entry *mid)
 {
@@ -4614,9 +4606,9 @@ smb2_readv_callback(struct mid_q_entry *mid)
 			      server->credits, server->in_flight,
 			      0, cifs_trace_rw_credits_read_response_clear);
 	rdata->credits.value = 0;
+	rdata->subreq.error = rdata->result;
 	rdata->subreq.transferred += rdata->got_bytes;
 	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
-	INIT_WORK(&rdata->subreq.work, smb2_readv_worker);
 	queue_work(cifsiod_wq, &rdata->subreq.work);
 	release_mid(mid);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5eaceef41e6c..d1f96b057b8f 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -429,10 +429,9 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp);
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group);
 
 /* (Sub)request management API. */
-void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq,
-				bool was_async);
-void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
-				  int error, bool was_async);
+void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq);
+void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq);
+void netfs_read_subreq_termination_worker(struct work_struct *work);
 void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
 void netfs_put_subrequest(struct netfs_io_subrequest *subreq,

