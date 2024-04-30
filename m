Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C1D8B77EB
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Apr 2024 16:02:13 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UfswuwLg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K+kNnuW5;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VTMMR18Sqz3cSV
	for <lists+linux-erofs@lfdr.de>; Wed,  1 May 2024 00:02:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UfswuwLg;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K+kNnuW5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VTMM12sF7z3cVX
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 May 2024 00:01:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9oW2wSGzdlNxSrhNqwjbv4gFKpPPpe3xHOvb2Tj7Zw=;
	b=UfswuwLgQL2gykutmM5F7+fTjeFN2eF7BsHwKMEDKBVB63OCBL9irSKusjmNEuQhJ/mMf/
	2MT3Q4Kalor+fDv5QtybnCwFBKWxcu8OSJlBrea8BQAxKzBVcGwluu3qkZcyWLnKsw0mFa
	uIxWnddNvY3VmB5lYiafPHc2y78G50s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9oW2wSGzdlNxSrhNqwjbv4gFKpPPpe3xHOvb2Tj7Zw=;
	b=K+kNnuW5dIapfm1TqiKYmeB2BeNPhKcB2Eki4EY7WA6pjYOX2tC54Pvqleu8G7nVGcHLPQ
	mgYbRd44KwI6I4nq2nC9ka23rzGU4EcmGH8oNbrxr3SdAD9U104cPYC9eRZ9nT/oIqHBrs
	jCGvvG/XF3j5P5Jtyw70WvsTW27KBDo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-EJoPS_fbMZ-L5ABNxd-9-w-1; Tue,
 30 Apr 2024 10:01:42 -0400
X-MC-Unique: EJoPS_fbMZ-L5ABNxd-9-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CC533819C68;
	Tue, 30 Apr 2024 14:01:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 549752166B31;
	Tue, 30 Apr 2024 14:01:37 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v2 09/22] afs: Use alternative invalidation to using launder_folio
Date: Tue, 30 Apr 2024 15:00:40 +0100
Message-ID: <20240430140056.261997-10-dhowells@redhat.com>
In-Reply-To: <20240430140056.261997-1-dhowells@redhat.com>
References: <20240430140056.261997-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

Use writepages-based flushing invalidation instead of
invalidate_inode_pages2() and ->launder_folio().  This will allow
->launder_folio() to be removed eventually.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/file.c       |  1 -
 fs/afs/internal.h   |  1 -
 fs/afs/validation.c |  4 ++--
 fs/afs/write.c      | 10 +++-------
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index ef2cc8f565d2..dfd8f60f5e1f 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -54,7 +54,6 @@ const struct address_space_operations afs_file_aops = {
 	.read_folio	= netfs_read_folio,
 	.readahead	= netfs_readahead,
 	.dirty_folio	= netfs_dirty_folio,
-	.launder_folio	= netfs_launder_folio,
 	.release_folio	= netfs_release_folio,
 	.invalidate_folio = netfs_invalidate_folio,
 	.migrate_folio	= filemap_migrate_folio,
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 6ce5a612937c..b93aa026daa4 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -916,7 +916,6 @@ struct afs_operation {
 			loff_t	pos;
 			loff_t	size;
 			loff_t	i_size;
-			bool	laundering;	/* Laundering page, PG_writeback not set */
 		} store;
 		struct {
 			struct iattr	*attr;
diff --git a/fs/afs/validation.c b/fs/afs/validation.c
index 32a53fc8dfb2..bef8af12ebe2 100644
--- a/fs/afs/validation.c
+++ b/fs/afs/validation.c
@@ -365,9 +365,9 @@ static void afs_zap_data(struct afs_vnode *vnode)
 	 * written back in a regular file and completely discard the pages in a
 	 * directory or symlink */
 	if (S_ISREG(vnode->netfs.inode.i_mode))
-		invalidate_remote_inode(&vnode->netfs.inode);
+		filemap_invalidate_inode(&vnode->netfs.inode, true, 0, LLONG_MAX);
 	else
-		invalidate_inode_pages2(vnode->netfs.inode.i_mapping);
+		filemap_invalidate_inode(&vnode->netfs.inode, false, 0, LLONG_MAX);
 }
 
 /*
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 74402d95a884..1bc26466eb72 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -75,8 +75,7 @@ static void afs_store_data_success(struct afs_operation *op)
 	op->ctime = op->file[0].scb.status.mtime_client;
 	afs_vnode_commit_status(op, &op->file[0]);
 	if (!afs_op_error(op)) {
-		if (!op->store.laundering)
-			afs_pages_written_back(vnode, op->store.pos, op->store.size);
+		afs_pages_written_back(vnode, op->store.pos, op->store.size);
 		afs_stat_v(vnode, n_stores);
 		atomic_long_add(op->store.size, &afs_v2net(vnode)->n_store_bytes);
 	}
@@ -91,8 +90,7 @@ static const struct afs_operation_ops afs_store_data_operation = {
 /*
  * write to a file
  */
-static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t pos,
-			  bool laundering)
+static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t pos)
 {
 	struct afs_operation *op;
 	struct afs_wb_key *wbk = NULL;
@@ -123,7 +121,6 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t
 	op->file[0].modification = true;
 	op->store.pos = pos;
 	op->store.size = size;
-	op->store.laundering = laundering;
 	op->flags |= AFS_OPERATION_UNINTR;
 	op->ops = &afs_store_data_operation;
 
@@ -168,8 +165,7 @@ static void afs_upload_to_server(struct netfs_io_subrequest *subreq)
 	       subreq->rreq->debug_id, subreq->debug_index, subreq->io_iter.count);
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-	ret = afs_store_data(vnode, &subreq->io_iter, subreq->start,
-			     subreq->rreq->origin == NETFS_LAUNDER_WRITE);
+	ret = afs_store_data(vnode, &subreq->io_iter, subreq->start);
 	netfs_write_subrequest_terminated(subreq, ret < 0 ? ret : subreq->len,
 					  false);
 }

