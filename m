Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEE39F3B1C
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 21:42:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBsMT3QRCz30T0
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Dec 2024 07:42:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734381764;
	cv=none; b=bJ2wVK1irE680ud+J1IccJaa//cDgGtM02bgVh7G0LQYJWGh9ZJH26V4s1dCvBVH2VGTQgaUtWEluBxSvwcz+FfzY0Zw0Lz4C9TQbHw9xLUo9T7iOOFK0HLYAhfq6+9outjDgrEdOHbOcy5VUdzcC+jrCzGx7EOFWhV9ILvXqthzlRsmDAuUtJwM3os8DXMqjGuCUQYcthfVkS5wUb3Yi3fdFZP6Kv/DtpcDtikMWR0j8J+5D3Vd8pcdVppfwiAy37BPwqZGCBEIN04wlecF0fHnVDSmz29TKXytlfT4l5jU7llT+cWUA3ms/hQBLcvsaBKvqgTMSuuiS0jpwzIC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734381764; c=relaxed/relaxed;
	bh=68H8yJ//jAcIb7XO17c9bCwEaC0FxOXp9orZUEAld/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWyS2pV09ghDKgrc76dL4B7hIlcqjEucNe3ik9SoFK0u5XM7958u0hYpqFImrg7/hpFvFvBOhmg8UZ966WS4q3ky4r01Xo8Sl1WlDZzNfZlm657a8KsbBzSmF7mVvCbMCEe+AZxRm23IKGC8Ue7cJqHKtenGhDi12fTP2/L+Ynv5e+pN2jWxoqnRvyv0awxNP+pO4JxPUgBYRsHtFnfF3r9Q+6z7vhqch87bDORgeuB/4WROVkWrdDBSIANP2E0MlO/dTCFZOHmhhtckdc0/FOhUTvMf9XBKJORtAy7u4k9D+SUVI3JQi1JqFFw6jT5X69bhqIs4oYRtjdL5fXRYGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i192Ow7P; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i192Ow7P; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i192Ow7P;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i192Ow7P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBsMR1g0Zz2y8V
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Dec 2024 07:42:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68H8yJ//jAcIb7XO17c9bCwEaC0FxOXp9orZUEAld/s=;
	b=i192Ow7PkBAu1C0KQJxuY6H/yy5jlDkTSzXJrL5qCVivJNfdAstBVDpgh+wTsnW8lIBdc5
	mLgCE8bgOT/TzBrYgYjaggcsgO/HvuTTm7N+pbrGKbuvbHsyI57Je8eSLhc9N4QnfdNOdp
	3BtcjSHJpe9cdKR5wx5nOzSJ891njGY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68H8yJ//jAcIb7XO17c9bCwEaC0FxOXp9orZUEAld/s=;
	b=i192Ow7PkBAu1C0KQJxuY6H/yy5jlDkTSzXJrL5qCVivJNfdAstBVDpgh+wTsnW8lIBdc5
	mLgCE8bgOT/TzBrYgYjaggcsgO/HvuTTm7N+pbrGKbuvbHsyI57Je8eSLhc9N4QnfdNOdp
	3BtcjSHJpe9cdKR5wx5nOzSJ891njGY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-OjhmU796OKWXsUET-UnaQA-1; Mon,
 16 Dec 2024 15:42:37 -0500
X-MC-Unique: OjhmU796OKWXsUET-UnaQA-1
X-Mimecast-MFC-AGG-ID: OjhmU796OKWXsUET-UnaQA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F112E1955E8D;
	Mon, 16 Dec 2024 20:42:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6DDE81956053;
	Mon, 16 Dec 2024 20:42:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 08/32] netfs: Drop the error arg from netfs_read_subreq_terminated()
Date: Mon, 16 Dec 2024 20:40:58 +0000
Message-ID: <20241216204124.3752367-9-dhowells@redhat.com>
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

Drop the error argument from netfs_read_subreq_terminated() in favour of
passing the value in subreq->error.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c         |  3 ++-
 fs/afs/file.c            | 15 ++++++++-----
 fs/ceph/addr.c           | 13 +++++++----
 fs/netfs/buffered_read.c | 16 +++++++-------
 fs/netfs/objects.c       | 15 ++++++++++++-
 fs/netfs/read_collect.c  | 47 +++++++++++++++++++++++++---------------
 fs/nfs/fscache.c         |  6 +++--
 fs/nfs/fscache.h         |  3 ++-
 fs/smb/client/cifssmb.c  | 10 +--------
 fs/smb/client/file.c     |  3 ++-
 fs/smb/client/smb2pdu.c  | 10 +--------
 include/linux/netfs.h    |  7 +++---
 12 files changed, 86 insertions(+), 62 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 3bc9ce6c575e..40f5acd7b452 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -87,7 +87,8 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	}
 
-	netfs_read_subreq_terminated(subreq, err, false);
+	subreq->error = err;
+	netfs_read_subreq_terminated(subreq, false);
 }
 
 /**
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 6762eff97517..56248a078bca 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -246,7 +246,8 @@ static void afs_fetch_data_notify(struct afs_operation *op)
 		subreq->rreq->i_size = req->file_size;
 		if (req->pos + req->actual_len >= req->file_size)
 			__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
-		netfs_read_subreq_terminated(subreq, error, false);
+		subreq->error = error;
+		netfs_read_subreq_terminated(subreq, false);
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
+			netfs_read_subreq_terminated(req->subreq, false);
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
+		return netfs_read_subreq_terminated(subreq, false);
+	}
 
 	fsreq->subreq	= subreq;
 	fsreq->pos	= subreq->start + subreq->transferred;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 85936f6d2bf7..b1b47af94deb 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -253,8 +253,9 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 		subreq->transferred = err;
 		err = 0;
 	}
+	subreq->error = err;
 	trace_netfs_sreq(subreq, netfs_sreq_trace_io_progress);
-	netfs_read_subreq_terminated(subreq, err, false);
+	netfs_read_subreq_terminated(subreq, false);
 	iput(req->r_inode);
 	ceph_dec_osd_stopping_blocker(fsc->mdsc);
 }
@@ -314,7 +315,9 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 
 	ceph_mdsc_put_request(req);
 out:
-	netfs_read_subreq_terminated(subreq, err, false);
+	subreq->error = err;
+	trace_netfs_sreq(subreq, netfs_sreq_trace_io_progress);
+	netfs_read_subreq_terminated(subreq, false);
 	return true;
 }
 
@@ -426,8 +429,10 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	ceph_osdc_start_request(req->r_osdc, req);
 out:
 	ceph_osdc_put_request(req);
-	if (err)
-		netfs_read_subreq_terminated(subreq, err, false);
+	if (err) {
+		subreq->error = err;
+		netfs_read_subreq_terminated(subreq, false);
+	}
 	doutc(cl, "%llx.%llx result %d\n", ceph_vinop(inode), err);
 }
 
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index db874fea8794..d420d623711c 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -148,14 +148,13 @@ static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error
 {
 	struct netfs_io_subrequest *subreq = priv;
 
-	if (transferred_or_error < 0) {
-		netfs_read_subreq_terminated(subreq, transferred_or_error, was_async);
-		return;
-	}
-
-	if (transferred_or_error > 0)
+	if (transferred_or_error > 0) {
 		subreq->transferred += transferred_or_error;
-	netfs_read_subreq_terminated(subreq, 0, was_async);
+		subreq->error = 0;
+	} else {
+		subreq->error = transferred_or_error;
+	}
+	netfs_read_subreq_terminated(subreq, was_async);
 }
 
 /*
@@ -255,7 +254,8 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			if (slice < 0)
 				goto prep_iter_failed;
 			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
-			netfs_read_subreq_terminated(subreq, 0, false);
+			subreq->error = 0;
+			netfs_read_subreq_terminated(subreq, false);
 			goto done;
 		}
 
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 5cdddaf1f978..f10fd56efa17 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
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
index f7a5cb29dd12..16770a317b22 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -452,28 +452,26 @@ EXPORT_SYMBOL(netfs_read_subreq_progress);
 /**
  * netfs_read_subreq_terminated - Note the termination of an I/O operation.
  * @subreq: The I/O request that has terminated.
- * @error: Error code indicating type of completion.
- * @was_async: The termination was asynchronous
+ * @was_async: True if we're in an asynchronous context.
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
+void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq, bool was_async)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 
+	might_sleep();
+
 	switch (subreq->source) {
 	case NETFS_READ_FROM_CACHE:
 		netfs_stat(&netfs_n_rh_read_done);
@@ -491,7 +489,7 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 		 * If the read completed validly short, then we can clear the
 		 * tail before going on to unlock the folios.
 		 */
-		if (error == 0 && subreq->transferred < subreq->len &&
+		if (subreq->error == 0 && subreq->transferred < subreq->len &&
 		    (test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags) ||
 		     test_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags))) {
 			netfs_clear_unread(subreq);
@@ -511,7 +509,7 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 	/* Deal with retry requests, short reads and errors.  If we retry
 	 * but don't make progress, we abandon the attempt.
 	 */
-	if (!error && subreq->transferred < subreq->len) {
+	if (!subreq->error && subreq->transferred < subreq->len) {
 		if (test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags)) {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_hit_eof);
 		} else {
@@ -528,16 +526,15 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
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
@@ -553,3 +550,19 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
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
+	netfs_read_subreq_terminated(subreq, false);
+}
+EXPORT_SYMBOL(netfs_read_subreq_termination_worker);
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index d49e4ce27999..be14d30608f6 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -314,8 +314,10 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 			     &nfs_async_read_completion_ops);
 
 	netfs = nfs_netfs_alloc(sreq);
-	if (!netfs)
-		return netfs_read_subreq_terminated(sreq, -ENOMEM, false);
+	if (!netfs) {
+		sreq->error = -ENOMEM;
+		return netfs_read_subreq_terminated(sreq, false);
+	}
 
 	pgio.pg_netfs = netfs; /* used in completion */
 
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 772d485e96d3..1d86f7cc7195 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -74,7 +74,8 @@ static inline void nfs_netfs_put(struct nfs_netfs_io_data *netfs)
 	 */
 	netfs->sreq->transferred = min_t(s64, netfs->sreq->len,
 					 atomic64_read(&netfs->transferred));
-	netfs_read_subreq_terminated(netfs->sreq, netfs->error, false);
+	netfs->sreq->error = netfs->error;
+	netfs_read_subreq_terminated(netfs->sreq, false);
 	kfree(netfs);
 }
 static inline void nfs_netfs_inode_init(struct nfs_inode *nfsi)
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 6cb1e81993f8..7c9cc6945d18 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1258,14 +1258,6 @@ CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms, int *oplock,
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
@@ -1333,8 +1325,8 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	}
 
 	rdata->credits.value = 0;
+	rdata->subreq.error = rdata->result;
 	rdata->subreq.transferred += rdata->got_bytes;
-	INIT_WORK(&rdata->subreq.work, cifs_readv_worker);
 	queue_work(cifsiod_wq, &rdata->subreq.work);
 	release_mid(mid);
 	add_credits(server, &credits, 0);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index a58a3333ecc3..10dd440f8178 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -227,7 +227,8 @@ static void cifs_issue_read(struct netfs_io_subrequest *subreq)
 	return;
 
 failed:
-	netfs_read_subreq_terminated(subreq, rc, false);
+	subreq->error = rc;
+	netfs_read_subreq_terminated(subreq, false);
 }
 
 /*
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 458b53d1f9cb..ce57d8697c7c 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4500,14 +4500,6 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
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
@@ -4621,9 +4613,9 @@ smb2_readv_callback(struct mid_q_entry *mid)
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
index bd922f0936e3..a882921460a9 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -427,10 +427,9 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp);
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group);
 
 /* (Sub)request management API. */
-void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq,
-				bool was_async);
-void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
-				  int error, bool was_async);
+void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq, bool was_async);
+void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq, bool was_async);
+void netfs_read_subreq_termination_worker(struct work_struct *work);
 void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
 void netfs_put_subrequest(struct netfs_io_subrequest *subreq,

