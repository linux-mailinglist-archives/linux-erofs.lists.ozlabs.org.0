Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F32358B7862
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Apr 2024 16:08:58 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EEnnPn2f;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EEnnPn2f;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VTMWD4Zlmz3w01
	for <lists+linux-erofs@lfdr.de>; Wed,  1 May 2024 00:08:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EEnnPn2f;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EEnnPn2f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VTMNY1gTKz3cWp
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 May 2024 00:03:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVKnlQo0k8LYSKy/5xkID19zXhvzF8VfogUxkP/ClX8=;
	b=EEnnPn2fO7O4HSWRf4BXHnE0cQpI2QG9DmTZOmNGze4ZipqbqrFV5p75Rnsmg6xjJU95pI
	Y1CoiVXhqLUSBAii3CgN7iSsOIIM88oI+qx69IhPq7p6bSJtlqsr1jtcygMin8jEOaB6pB
	Ptr2Ty4kxlfIJjHEg4qJgOdpTQTb32Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVKnlQo0k8LYSKy/5xkID19zXhvzF8VfogUxkP/ClX8=;
	b=EEnnPn2fO7O4HSWRf4BXHnE0cQpI2QG9DmTZOmNGze4ZipqbqrFV5p75Rnsmg6xjJU95pI
	Y1CoiVXhqLUSBAii3CgN7iSsOIIM88oI+qx69IhPq7p6bSJtlqsr1jtcygMin8jEOaB6pB
	Ptr2Ty4kxlfIJjHEg4qJgOdpTQTb32Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-0FXqmQelOLGG4J2V-HVVnQ-1; Tue,
 30 Apr 2024 10:03:00 -0400
X-MC-Unique: 0FXqmQelOLGG4J2V-HVVnQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20E123819C42;
	Tue, 30 Apr 2024 14:02:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 417FE1121312;
	Tue, 30 Apr 2024 14:02:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v2 16/22] netfs, afs: Implement helpers for new write code
Date: Tue, 30 Apr 2024 15:00:47 +0100
Message-ID: <20240430140056.261997-17-dhowells@redhat.com>
In-Reply-To: <20240430140056.261997-1-dhowells@redhat.com>
References: <20240430140056.261997-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, linux-mm@kvack.org, netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Implement the helpers for the new write code in afs.  There's now an
optional ->prepare_write() that allows the filesystem to set the parameters
for the next write, such as maximum size and maximum segment count, and an
->issue_write() that is called to initiate an (asynchronous) write
operation.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---

Notes:
    Changes
    =======
    ver #2)
     - Don't do the StoreData RPC inline, but keep doing it from a workqueue.

 fs/afs/file.c     |  3 +++
 fs/afs/internal.h |  3 +++
 fs/afs/write.c    | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index dfd8f60f5e1f..db9ebae84fa2 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -400,6 +400,9 @@ const struct netfs_request_ops afs_req_ops = {
 	.update_i_size		= afs_update_i_size,
 	.invalidate_cache	= afs_netfs_invalidate_cache,
 	.create_write_requests	= afs_create_write_requests,
+	.begin_writeback	= afs_begin_writeback,
+	.prepare_write		= afs_prepare_write,
+	.issue_write		= afs_issue_write,
 };
 
 static void afs_add_open_mmap(struct afs_vnode *vnode)
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index b93aa026daa4..dcf0ae0323d3 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1598,6 +1598,9 @@ extern int afs_check_volume_status(struct afs_volume *, struct afs_operation *);
 /*
  * write.c
  */
+void afs_prepare_write(struct netfs_io_subrequest *subreq);
+void afs_issue_write(struct netfs_io_subrequest *subreq);
+void afs_begin_writeback(struct netfs_io_request *wreq);
 extern int afs_writepages(struct address_space *, struct writeback_control *);
 extern int afs_fsync(struct file *, loff_t, loff_t, int);
 extern vm_fault_t afs_page_mkwrite(struct vm_fault *vmf);
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 1bc26466eb72..34595f482718 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -194,6 +194,60 @@ void afs_create_write_requests(struct netfs_io_request *wreq, loff_t start, size
 		netfs_queue_write_request(subreq);
 }
 
+/*
+ * Writeback calls this when it finds a folio that needs uploading.  This isn't
+ * called if writeback only has copy-to-cache to deal with.
+ */
+void afs_begin_writeback(struct netfs_io_request *wreq)
+{
+	wreq->io_streams[0].avail = true;
+}
+
+/*
+ * Prepare a subrequest to write to the server.  This sets the max_len
+ * parameter.
+ */
+void afs_prepare_write(struct netfs_io_subrequest *subreq)
+{
+	//if (test_bit(NETFS_SREQ_RETRYING, &subreq->flags))
+	//	subreq->max_len = 512 * 1024;
+	//else
+	subreq->max_len = 256 * 1024 * 1024;
+}
+
+/*
+ * Issue a subrequest to write to the server.
+ */
+static void afs_issue_write_worker(struct work_struct *work)
+{
+	struct netfs_io_subrequest *subreq = container_of(work, struct netfs_io_subrequest, work);
+	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
+	ssize_t ret;
+
+	_enter("%x[%x],%zx",
+	       subreq->rreq->debug_id, subreq->debug_index, subreq->io_iter.count);
+
+#if 0 // Error injection
+	if (subreq->debug_index == 3)
+		return netfs_write_subrequest_terminated(subreq, -ENOANO, false);
+
+	if (!test_bit(NETFS_SREQ_RETRYING, &subreq->flags)) {
+		set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+		return netfs_write_subrequest_terminated(subreq, -EAGAIN, false);
+	}
+#endif
+
+	ret = afs_store_data(vnode, &subreq->io_iter, subreq->start);
+	netfs_write_subrequest_terminated(subreq, ret < 0 ? ret : subreq->len, false);
+}
+
+void afs_issue_write(struct netfs_io_subrequest *subreq)
+{
+	subreq->work.func = afs_issue_write_worker;
+	if (!queue_work(system_unbound_wq, &subreq->work))
+		WARN_ON_ONCE(1);
+}
+
 /*
  * write some of the pending data back to the server
  */

