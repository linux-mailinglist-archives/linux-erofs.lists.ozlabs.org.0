Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315CB9C2344
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Nov 2024 18:36:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XlR1f1hpQz3c1w
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Nov 2024 04:36:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731087364;
	cv=none; b=emAgFapJgtdWKitvOlTmyIfSDR+RRa6hvxJP+V8ZZZQzNyLhUCF0h7gz5eWY3kmHFB+xKFkv0glyVVnuEUccbMnjtN5EwgqDlqNi66k9TPQYAzQhQC9JuasJCdZHgn6f5jG4WQBvSx7cGFZxi0GlFIQ7YaIBOkrgBDkz5hqwOqyITf+v9mx9aru1QW6Zfq6ZVW9vUFZRgnzlSqNa7CwDm7KG1NdLHd8TJuGEBOHxTExKkt1EjBP90rLxiuRF5zsAo3Sh6mNkEbvtUjgn5OiqFnPV1SWT7yL5ljN5HkZlpMirGFXlRqsStdZHOZ+PSWJLc908Ig+YUxOtdG4nLeOgrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731087364; c=relaxed/relaxed;
	bh=OrdAljyu/86B7Uupqp5aIMyvZ1Oua6M6rtiSOl8cYT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=la3BaqlSItcT51THnVhRgrVvMOzxHQMLh6klFqm+1MZRMW+20ff/QINHrA8AhqmiVbfv59Ayh9L5j1SERxMDWaxJxvsKJVGU5DsIeByTZ3I0y3RVSErPj9skPBgCvY5Z2jy6nVkZuMKWk8BCsy2wotvbGeN8x4Y+LH6Sfz8cZC9Dp4Bp9Z0TF95g+VeXIg0tn9snB1mynuKxqWTxmDSiNUFntAYGLg4JejQRuWfJvldmQdm7pCJGKpF2wKZgmLUiMyWLp717L9OVaqLbKfL/vuJKcyWreeAHPAGE7PygziW505z8/wnuG+pCssqklE+XgI7U1QlzHFXH+rnL+Kuydw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JQ+RjlYL; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JQ+RjlYL; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JQ+RjlYL;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JQ+RjlYL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XlR1b239dz3bkY
	for <linux-erofs@lists.ozlabs.org>; Sat,  9 Nov 2024 04:36:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731087360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrdAljyu/86B7Uupqp5aIMyvZ1Oua6M6rtiSOl8cYT8=;
	b=JQ+RjlYLMcocX3k38G+JcHf7pZJZ+GLDWELuhPrG6m3fj7W3lH0fnxz9YhdOGIeZFnCc1B
	CAjbrk14sV96bqwAqQBSi8bj0K5QHIZQu4ITKUeudUCQ8cSvHiBbAKnl5PXxmkCN9yIMeP
	R5wgQRbGD3QOWlTN4llhkXkhrHryqf4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731087360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrdAljyu/86B7Uupqp5aIMyvZ1Oua6M6rtiSOl8cYT8=;
	b=JQ+RjlYLMcocX3k38G+JcHf7pZJZ+GLDWELuhPrG6m3fj7W3lH0fnxz9YhdOGIeZFnCc1B
	CAjbrk14sV96bqwAqQBSi8bj0K5QHIZQu4ITKUeudUCQ8cSvHiBbAKnl5PXxmkCN9yIMeP
	R5wgQRbGD3QOWlTN4llhkXkhrHryqf4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-EfyNqsjiPTm6U8UvLq2wbA-1; Fri,
 08 Nov 2024 12:35:57 -0500
X-MC-Unique: EfyNqsjiPTm6U8UvLq2wbA-1
X-Mimecast-MFC-AGG-ID: EfyNqsjiPTm6U8UvLq2wbA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59E7019560A1;
	Fri,  8 Nov 2024 17:35:54 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD9153003B71;
	Fri,  8 Nov 2024 17:35:48 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 26/33] afs: Fix cleanup of immediately failed async calls
Date: Fri,  8 Nov 2024 17:32:27 +0000
Message-ID: <20241108173236.1382366-27-dhowells@redhat.com>
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

If we manage to begin an async call, but fail to transmit any data on it
due to a signal, we then abort it which causes a race between the
notification of call completion from rxrpc and our attempt to cancel the
notification.  The notification will be necessary, however, for async
FetchData to terminate the netfs subrequest.

However, since we get a notification from rxrpc upon completion of a call
(aborted or otherwise), we can just leave it to that.

This leads to calls not getting cleaned up, but appearing in
/proc/net/rxrpc/calls as being aborted with code 6.

Fix this by making the "error_do_abort:" case of afs_make_call() abort the
call and then abandon it to the notification handler.

Fixes: 34fa47612bfe ("afs: Fix race in async call refcounting")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/internal.h          |  9 +++++++++
 fs/afs/rxrpc.c             | 12 +++++++++---
 include/trace/events/afs.h |  2 ++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 39d2e29ed0e0..96fc466efd10 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1336,6 +1336,15 @@ extern void afs_send_simple_reply(struct afs_call *, const void *, size_t);
 extern int afs_extract_data(struct afs_call *, bool);
 extern int afs_protocol_error(struct afs_call *, enum afs_eproto_cause);
 
+static inline void afs_see_call(struct afs_call *call, enum afs_call_trace why)
+{
+	int r = refcount_read(&call->ref);
+
+	trace_afs_call(call->debug_id, why, r,
+		       atomic_read(&call->net->nr_outstanding_calls),
+		       __builtin_return_address(0));
+}
+
 static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *call,
 				    gfp_t gfp)
 {
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 9f2a3bb56ec6..a122c6366ce1 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -430,11 +430,16 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	return;
 
 error_do_abort:
-	if (ret != -ECONNABORTED) {
+	if (ret != -ECONNABORTED)
 		rxrpc_kernel_abort_call(call->net->socket, rxcall,
 					RX_USER_ABORT, ret,
 					afs_abort_send_data_error);
-	} else {
+	if (call->async) {
+		afs_see_call(call, afs_call_trace_async_abort);
+		return;
+	}
+
+	if (ret == -ECONNABORTED) {
 		len = 0;
 		iov_iter_kvec(&msg.msg_iter, ITER_DEST, NULL, 0, 0);
 		rxrpc_kernel_recv_data(call->net->socket, rxcall,
@@ -445,6 +450,8 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	call->error = ret;
 	trace_afs_call_done(call);
 error_kill_call:
+	if (call->async)
+		afs_see_call(call, afs_call_trace_async_kill);
 	if (call->type->done)
 		call->type->done(call);
 
@@ -602,7 +609,6 @@ static void afs_deliver_to_call(struct afs_call *call)
 	abort_code = 0;
 call_complete:
 	afs_set_call_complete(call, ret, remote_abort);
-	state = AFS_CALL_COMPLETE;
 	goto done;
 }
 
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 49a749672e38..cdb5f2af7799 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -118,6 +118,8 @@ enum yfs_cm_operation {
  */
 #define afs_call_traces \
 	EM(afs_call_trace_alloc,		"ALLOC") \
+	EM(afs_call_trace_async_abort,		"ASYAB") \
+	EM(afs_call_trace_async_kill,		"ASYKL") \
 	EM(afs_call_trace_free,			"FREE ") \
 	EM(afs_call_trace_get,			"GET  ") \
 	EM(afs_call_trace_put,			"PUT  ") \

