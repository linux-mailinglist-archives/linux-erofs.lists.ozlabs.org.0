Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670949AE7A3
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Oct 2024 16:09:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZ77s2wbrz3bh2
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2024 01:09:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729778952;
	cv=none; b=Nz6upAUBdW2om9Peen2uTq2FHpg/tnCqYzha32JnFm8o8qCQbN58PvGUeQv8NHzPDYnewDFMogzQY2r4YtCkPGy+x55XHKbii6kQ5AQzg2X9lPxqEaseRFbj3P2gyxRTfEm1YOuahXcr30rO80JVKTrQIDkcChDOTlxyH42tmGugLxfeRIWGWtfYCrQabI7q3q51liXP1MPpRhaMCcTtG32yLIISA1KJSPFw1nDqO5vtdv/k2iEmaSEfKOgQgxCz7vvk4PS1gqd4PWQsqsgA1A6QOQaHaM0eU4HcDE5o34NZ2jKTlfcGsH2gTUrPu3txmUjW7pBtFvAX4UrbiNsLgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729778952; c=relaxed/relaxed;
	bh=tRd0Nhb3yGtu5VQWGgXymCPm7LcbWAmM7MrJDAvDuiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guxGDzDcYV/TKP8bUO5TcIgIuLP92GwX9Y2EIU4RblCXrLp7FWFS5PVQAqsllPLg1vGxJgR/e5KRToBfYzIu9idArZXNWXFjeEw5xxC68fT2qJKW6jOk96b4cuDemaU5DkEsf5Xvvuz3GtKj1GSElbxNuvgXkl2p+pc95W7JOJ9B6pH7JHmc8UF9aVpOYFNxLyjMuhoSoARK0flStCNpIcIo6uuETPJrkpSNCQZjKo8fl6MPKIpMV8mXUE97HJabA0rQ1OyEXVgOlmwzMFbfjlzOp6QGtRSCQYGA5YlU0yclVP6amEelrqli2vIzB5x9aArvpSRpyBSnFARYR4H6ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e7it+VJY; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e7it+VJY; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e7it+VJY;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e7it+VJY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZ77p6phdz3bbp
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Oct 2024 01:09:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRd0Nhb3yGtu5VQWGgXymCPm7LcbWAmM7MrJDAvDuiQ=;
	b=e7it+VJYlRiiGOgEJj1vNPTQtN7j50Kw5Z33eJdaiNx83a+pmWRLSc6wWh4auOYXagVZ/d
	WbCjeBQ2LAPSj6p6YEEA+Upvgu7U/fNOz9xf437em+q94YikRqbkZOgTFHI0JllWR1Mvog
	oskGinIoG+FC7Ma2JtwN1a2NDR8LUpI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRd0Nhb3yGtu5VQWGgXymCPm7LcbWAmM7MrJDAvDuiQ=;
	b=e7it+VJYlRiiGOgEJj1vNPTQtN7j50Kw5Z33eJdaiNx83a+pmWRLSc6wWh4auOYXagVZ/d
	WbCjeBQ2LAPSj6p6YEEA+Upvgu7U/fNOz9xf437em+q94YikRqbkZOgTFHI0JllWR1Mvog
	oskGinIoG+FC7Ma2JtwN1a2NDR8LUpI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-in_XcD5xMBmX5sxJEKu7fw-1; Thu,
 24 Oct 2024 10:09:04 -0400
X-MC-Unique: in_XcD5xMBmX5sxJEKu7fw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 735CC1955F68;
	Thu, 24 Oct 2024 14:09:01 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9779C1956056;
	Thu, 24 Oct 2024 14:08:55 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 25/27] afs: Make {Y,}FS.FetchData an asynchronous operation
Date: Thu, 24 Oct 2024 15:05:23 +0100
Message-ID: <20241024140539.3828093-26-dhowells@redhat.com>
In-Reply-To: <20241024140539.3828093-1-dhowells@redhat.com>
References: <20241024140539.3828093-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Make FS.FetchData and YFS.FetchData an asynchronous operation in that the
request is queued in AF_RXRPC and then we return to the caller rather than
waiting.  Processing of the returning packets is then done inline if it's a
synchronous VFS/VM call (readdir, read_folio, sync DIO, prep for write) or
offloaded to a workqueue if asynchronous VM calls (eg. readahead, async
DIO).

This reduces the chain of workqueues invoking workqueues and cuts out some
of the overhead, driving rxrpc data extraction and netfslib read collection
from a thread that's going to block to completion anyway if possible.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/file.c         | 109 ++++++++++++++++++++++++++++++++++++++----
 fs/afs/fs_operation.c |   2 +-
 fs/afs/fsclient.c     |   6 ++-
 fs/afs/internal.h     |   7 +++
 fs/afs/main.c         |   2 +-
 fs/afs/rxrpc.c        |   8 ++--
 fs/afs/write.c        |  12 +++++
 fs/afs/yfsclient.c    |   5 +-
 8 files changed, 135 insertions(+), 16 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index b996f4419c0c..6c1ec3b2411d 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -239,12 +239,91 @@ const struct afs_operation_ops afs_fetch_data_operation = {
 	.put		= afs_fetch_data_put,
 };
 
+static void afs_issue_read_call(struct afs_operation *op)
+{
+	op->call_responded = false;
+	op->call_error = 0;
+	op->call_abort_code = 0;
+	if (test_bit(AFS_SERVER_FL_IS_YFS, &op->server->flags))
+		yfs_fs_fetch_data(op);
+	else
+		afs_fs_fetch_data(op);
+}
+
+static void afs_end_read(struct afs_operation *op)
+{
+	if (op->call_responded && op->server)
+		set_bit(AFS_SERVER_FL_RESPONDING, &op->server->flags);
+
+	if (!afs_op_error(op))
+		afs_fetch_data_success(op);
+	else if (op->cumul_error.aborted)
+		afs_fetch_data_aborted(op);
+	else
+		afs_fetch_data_notify(op);
+
+	afs_end_vnode_operation(op);
+	afs_put_operation(op);
+}
+
+/*
+ * Perform I/O processing on an asynchronous call.  The work item carries a ref
+ * to the call struct that we either need to release or to pass on.
+ */
+static void afs_read_receive(struct afs_call *call)
+{
+	struct afs_operation *op = call->op;
+	enum afs_call_state state;
+
+	_enter("");
+
+	state = READ_ONCE(call->state);
+	if (state == AFS_CALL_COMPLETE)
+		return;
+
+	while (state < AFS_CALL_COMPLETE && READ_ONCE(call->need_attention)) {
+		WRITE_ONCE(call->need_attention, false);
+		afs_deliver_to_call(call);
+		state = READ_ONCE(call->state);
+	}
+
+	if (state < AFS_CALL_COMPLETE) {
+		netfs_read_subreq_progress(op->fetch.subreq);
+		if (rxrpc_kernel_check_life(call->net->socket, call->rxcall))
+			return;
+		/* rxrpc terminated the call. */
+		afs_set_call_complete(call, call->error, call->abort_code);
+	}
+
+	op->call_abort_code	= call->abort_code;
+	op->call_error		= call->error;
+	op->call_responded	= call->responded;
+	afs_put_call(op->call);
+
+	/* If the call failed, then we need to crank the server rotation
+	 * handle and try the next.
+	 */
+	if (afs_select_fileserver(op)) {
+		afs_issue_read_call(op);
+		return;
+	}
+
+	afs_end_read(op);
+}
+
+void afs_fetch_data_async_rx(struct work_struct *work)
+{
+	struct afs_call *call = container_of(work, struct afs_call, async_work);
+
+	afs_read_receive(call);
+	afs_put_call(call);
+}
+
 /*
  * Fetch file data from the volume.
  */
-static void afs_read_worker(struct work_struct *work)
+static void afs_issue_read(struct netfs_io_subrequest *subreq)
 {
-	struct netfs_io_subrequest *subreq = container_of(work, struct netfs_io_subrequest, work);
 	struct afs_operation *op;
 	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
 	struct key *key = subreq->rreq->netfs_priv;
@@ -269,13 +348,27 @@ static void afs_read_worker(struct work_struct *work)
 	op->ops		= &afs_fetch_data_operation;
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-	afs_do_sync_operation(op);
-}
 
-static void afs_issue_read(struct netfs_io_subrequest *subreq)
-{
-	INIT_WORK(&subreq->work, afs_read_worker);
-	queue_work(system_long_wq, &subreq->work);
+	if (subreq->rreq->origin == NETFS_READAHEAD ||
+	    subreq->rreq->iocb) {
+		op->flags |= AFS_OPERATION_ASYNC;
+
+		if (!afs_begin_vnode_operation(op)) {
+			subreq->error = PTR_ERR(op);
+			netfs_read_subreq_terminated(subreq);
+			afs_put_operation(op);
+			return;
+		}
+
+		if (!afs_select_fileserver(op)) {
+			afs_end_read(op);
+			return;
+		}
+
+		afs_issue_read_call(op);
+	} else {
+		afs_do_sync_operation(op);
+	}
 }
 
 static int afs_init_request(struct netfs_io_request *rreq, struct file *file)
diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 8488ff8183fa..0b1338d65ae6 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -256,7 +256,7 @@ bool afs_begin_vnode_operation(struct afs_operation *op)
 /*
  * Tidy up a filesystem cursor and unlock the vnode.
  */
-static void afs_end_vnode_operation(struct afs_operation *op)
+void afs_end_vnode_operation(struct afs_operation *op)
 {
 	_enter("");
 
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index d9d224c95454..6380cdcfd4fc 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -352,7 +352,6 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		ret = afs_extract_data(call, true);
 		subreq->transferred += count_before - call->iov_len;
 		call->remaining -= count_before - call->iov_len;
-		netfs_read_subreq_progress(subreq);
 		if (ret < 0)
 			return ret;
 
@@ -409,6 +408,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 static const struct afs_call_type afs_RXFSFetchData = {
 	.name		= "FS.FetchData",
 	.op		= afs_FS_FetchData,
+	.async_rx	= afs_fetch_data_async_rx,
 	.deliver	= afs_deliver_fs_fetch_data,
 	.destructor	= afs_flat_call_destructor,
 };
@@ -416,6 +416,7 @@ static const struct afs_call_type afs_RXFSFetchData = {
 static const struct afs_call_type afs_RXFSFetchData64 = {
 	.name		= "FS.FetchData64",
 	.op		= afs_FS_FetchData64,
+	.async_rx	= afs_fetch_data_async_rx,
 	.deliver	= afs_deliver_fs_fetch_data,
 	.destructor	= afs_flat_call_destructor,
 };
@@ -436,6 +437,9 @@ static void afs_fs_fetch_data64(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
+	if (op->flags & AFS_OPERATION_ASYNC)
+		call->async = true;
+
 	/* marshall the parameters */
 	bp = call->request;
 	bp[0] = htonl(FSFETCHDATA64);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 36125fce0590..c7f0d75eab7f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -202,6 +202,9 @@ struct afs_call_type {
 	/* clean up a call */
 	void (*destructor)(struct afs_call *call);
 
+	/* Async receive processing function */
+	void (*async_rx)(struct work_struct *work);
+
 	/* Work function */
 	void (*work)(struct work_struct *work);
 
@@ -941,6 +944,7 @@ struct afs_operation {
 #define AFS_OPERATION_TRIED_ALL		0x0400	/* Set if we've tried all the fileservers */
 #define AFS_OPERATION_RETRY_SERVER	0x0800	/* Set if we should retry the current server */
 #define AFS_OPERATION_DIR_CONFLICT	0x1000	/* Set if we detected a 3rd-party dir change */
+#define AFS_OPERATION_ASYNC		0x2000	/* Set if should run asynchronously */
 };
 
 /*
@@ -1103,6 +1107,7 @@ extern int afs_cache_wb_key(struct afs_vnode *, struct afs_file *);
 extern void afs_put_wb_key(struct afs_wb_key *);
 extern int afs_open(struct inode *, struct file *);
 extern int afs_release(struct inode *, struct file *);
+void afs_fetch_data_async_rx(struct work_struct *work);
 
 /*
  * flock.c
@@ -1154,6 +1159,7 @@ extern void afs_fs_store_acl(struct afs_operation *);
 extern struct afs_operation *afs_alloc_operation(struct key *, struct afs_volume *);
 extern int afs_put_operation(struct afs_operation *);
 extern bool afs_begin_vnode_operation(struct afs_operation *);
+extern void afs_end_vnode_operation(struct afs_operation *op);
 extern void afs_wait_for_operation(struct afs_operation *);
 extern int afs_do_sync_operation(struct afs_operation *);
 
@@ -1325,6 +1331,7 @@ extern void afs_charge_preallocation(struct work_struct *);
 extern void afs_put_call(struct afs_call *);
 void afs_deferred_put_call(struct afs_call *call);
 void afs_make_call(struct afs_call *call, gfp_t gfp);
+void afs_deliver_to_call(struct afs_call *call);
 void afs_wait_for_call_to_complete(struct afs_call *call);
 extern struct afs_call *afs_alloc_flat_call(struct afs_net *,
 					    const struct afs_call_type *,
diff --git a/fs/afs/main.c b/fs/afs/main.c
index a14f6013e316..1ae0067f772d 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -177,7 +177,7 @@ static int __init afs_init(void)
 	afs_wq = alloc_workqueue("afs", 0, 0);
 	if (!afs_wq)
 		goto error_afs_wq;
-	afs_async_calls = alloc_workqueue("kafsd", WQ_MEM_RECLAIM, 0);
+	afs_async_calls = alloc_workqueue("kafsd", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (!afs_async_calls)
 		goto error_async;
 	afs_lock_manager = alloc_workqueue("kafs_lockd", WQ_MEM_RECLAIM, 0);
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 9f2a3bb56ec6..94fff4e214b0 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -149,7 +149,8 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
 	call->net = net;
 	call->debug_id = atomic_inc_return(&rxrpc_debug_id);
 	refcount_set(&call->ref, 1);
-	INIT_WORK(&call->async_work, afs_process_async_call);
+	INIT_WORK(&call->async_work, type->async_rx ?: afs_process_async_call);
+	INIT_WORK(&call->work, call->type->work);
 	INIT_WORK(&call->free_work, afs_deferred_free_worker);
 	init_waitqueue_head(&call->waitq);
 	spin_lock_init(&call->state_lock);
@@ -254,8 +255,6 @@ static struct afs_call *afs_get_call(struct afs_call *call,
 static void afs_queue_call_work(struct afs_call *call)
 {
 	if (call->type->work) {
-		INIT_WORK(&call->work, call->type->work);
-
 		afs_get_call(call, afs_call_trace_work);
 		if (!queue_work(afs_wq, &call->work))
 			afs_put_call(call);
@@ -501,7 +500,7 @@ static void afs_log_error(struct afs_call *call, s32 remote_abort)
 /*
  * deliver messages to a call
  */
-static void afs_deliver_to_call(struct afs_call *call)
+void afs_deliver_to_call(struct afs_call *call)
 {
 	enum afs_call_state state;
 	size_t len;
@@ -803,6 +802,7 @@ static int afs_deliver_cm_op_id(struct afs_call *call)
 		return -ENOTSUPP;
 
 	trace_afs_cb_call(call);
+	call->work.func = call->type->work;
 
 	/* pass responsibility for the remainer of this message off to the
 	 * cache manager op */
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 17d188aaf101..e87b55792aa8 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -193,6 +193,18 @@ void afs_retry_request(struct netfs_io_request *wreq, struct netfs_io_stream *st
 		list_first_entry(&stream->subrequests,
 				 struct netfs_io_subrequest, rreq_link);
 
+	switch (wreq->origin) {
+	case NETFS_READAHEAD:
+	case NETFS_READPAGE:
+	case NETFS_READ_GAPS:
+	case NETFS_READ_SINGLE:
+	case NETFS_READ_FOR_WRITE:
+	case NETFS_DIO_READ:
+		return;
+	default:
+		break;
+	}
+
 	switch (subreq->error) {
 	case -EACCES:
 	case -EPERM:
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 3718d852fabc..4e7d93ee5a08 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -397,7 +397,6 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 
 		ret = afs_extract_data(call, true);
 		subreq->transferred += count_before - call->iov_len;
-		netfs_read_subreq_progress(subreq);
 		if (ret < 0)
 			return ret;
 
@@ -457,6 +456,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 static const struct afs_call_type yfs_RXYFSFetchData64 = {
 	.name		= "YFS.FetchData64",
 	.op		= yfs_FS_FetchData64,
+	.async_rx	= afs_fetch_data_async_rx,
 	.deliver	= yfs_deliver_fs_fetch_data64,
 	.destructor	= afs_flat_call_destructor,
 };
@@ -486,6 +486,9 @@ void yfs_fs_fetch_data(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
+	if (op->flags & AFS_OPERATION_ASYNC)
+		call->async = true;
+
 	/* marshall the parameters */
 	bp = call->request;
 	bp = xdr_encode_u32(bp, YFSFETCHDATA64);

