Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DDA89059B
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Mar 2024 17:38:47 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eopYf1HS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eopYf1HS;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V58PK1jTtz3vc0
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Mar 2024 03:38:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eopYf1HS;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eopYf1HS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V58PD6tGyz3vbj
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 Mar 2024 03:38:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08BQVB5a47a8ZK8FFbOaylpdSd6N4VkCmtEx277bjMw=;
	b=eopYf1HSusfEijkOSL75g8EcQo5BY6CJp7A4Qi/3PofbAOBThnWX+j3FJjv9IbK3F5Nyn2
	1CcUv7JhcT9YtZJzXqTWM5MgjZeRwA+MLSKV2IrScHM5E0F+Akw8fAjiUjrCJBSYGmyCby
	X1oxV6iQSnbD3OBFkuAo92v2l7Buzos=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08BQVB5a47a8ZK8FFbOaylpdSd6N4VkCmtEx277bjMw=;
	b=eopYf1HSusfEijkOSL75g8EcQo5BY6CJp7A4Qi/3PofbAOBThnWX+j3FJjv9IbK3F5Nyn2
	1CcUv7JhcT9YtZJzXqTWM5MgjZeRwA+MLSKV2IrScHM5E0F+Akw8fAjiUjrCJBSYGmyCby
	X1oxV6iQSnbD3OBFkuAo92v2l7Buzos=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-ESNBE_2_P8S2T8AJ9Ud0UA-1; Thu, 28 Mar 2024 12:38:34 -0400
X-MC-Unique: ESNBE_2_P8S2T8AJ9Ud0UA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC456857E7C;
	Thu, 28 Mar 2024 16:38:31 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9D693200A384;
	Thu, 28 Mar 2024 16:38:28 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 21/26] netfs, 9p: Implement helpers for new write code
Date: Thu, 28 Mar 2024 16:34:13 +0000
Message-ID: <20240328163424.2781320-22-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Implement the helpers for the new write code in 9p.  There's now an
optional ->prepare_write() that allows the filesystem to set the parameters
for the next write, such as maximum size and maximum segment count, and an
->issue_write() that is called to initiate an (asynchronous) write
operation.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: v9fs@lists.linux.dev
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c        | 48 ++++++++++++++++++++++++++++++++++++++++
 include/net/9p/client.h |  2 ++
 net/9p/Kconfig          |  1 +
 net/9p/client.c         | 49 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 5a943c122d83..07d03efdd594 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -26,6 +26,40 @@
 #include "cache.h"
 #include "fid.h"
 
+/*
+ * Writeback calls this when it finds a folio that needs uploading.  This isn't
+ * called if writeback only has copy-to-cache to deal with.
+ */
+static void v9fs_begin_writeback(struct netfs_io_request *wreq)
+{
+	struct p9_fid *fid;
+
+	fid = v9fs_fid_find_inode(wreq->inode, true, INVALID_UID, true);
+	if (!fid) {
+		WARN_ONCE(1, "folio expected an open fid inode->i_ino=%lx\n",
+			  wreq->inode->i_ino);
+		return;
+	}
+
+	wreq->wsize = fid->clnt->msize - P9_IOHDRSZ;
+	if (fid->iounit)
+		wreq->wsize = min(wreq->wsize, fid->iounit);
+	wreq->netfs_priv = fid;
+	wreq->io_streams[0].avail = true;
+}
+
+/*
+ * Issue a subrequest to write to the server.
+ */
+static void v9fs_issue_write(struct netfs_io_subrequest *subreq)
+{
+	struct p9_fid *fid = subreq->rreq->netfs_priv;
+	int err, len;
+
+	len = p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
+	netfs_write_subrequest_terminated(subreq, len ?: err, false);
+}
+
 static void v9fs_upload_to_server(struct netfs_io_subrequest *subreq)
 {
 	struct p9_fid *fid = subreq->rreq->netfs_priv;
@@ -92,6 +126,14 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 			rreq->origin == NETFS_UNBUFFERED_WRITE ||
 			rreq->origin == NETFS_DIO_WRITE);
 
+#if 0 // TODO: Cut over
+	if (rreq->origin == NETFS_WRITEBACK)
+		return 0; /* We don't get the write handle until we find we
+			   * have actually dirty data and not just
+			   * copy-to-cache data.
+			   */
+#endif
+
 	if (file) {
 		fid = file->private_data;
 		if (!fid)
@@ -103,6 +145,10 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 			goto no_fid;
 	}
 
+	rreq->wsize = fid->clnt->msize - P9_IOHDRSZ;
+	if (fid->iounit)
+		rreq->wsize = min(rreq->wsize, fid->iounit);
+
 	/* we might need to read from a fid that was opened write-only
 	 * for read-modify-write of page cache, use the writeback fid
 	 * for that */
@@ -131,6 +177,8 @@ const struct netfs_request_ops v9fs_req_ops = {
 	.init_request		= v9fs_init_request,
 	.free_request		= v9fs_free_request,
 	.issue_read		= v9fs_issue_read,
+	.begin_writeback	= v9fs_begin_writeback,
+	.issue_write		= v9fs_issue_write,
 	.create_write_requests	= v9fs_create_write_requests,
 };
 
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 78ebcf782ce5..4f785098c67a 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -207,6 +207,8 @@ int p9_client_read(struct p9_fid *fid, u64 offset, struct iov_iter *to, int *err
 int p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 		int *err);
 int p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err);
+struct netfs_io_subrequest;
+void p9_client_write_subreq(struct netfs_io_subrequest *subreq);
 int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset);
 int p9dirent_read(struct p9_client *clnt, char *buf, int len,
 		  struct p9_dirent *dirent);
diff --git a/net/9p/Kconfig b/net/9p/Kconfig
index 00ebce9e5a65..bcdab9c23b40 100644
--- a/net/9p/Kconfig
+++ b/net/9p/Kconfig
@@ -5,6 +5,7 @@
 
 menuconfig NET_9P
 	tristate "Plan 9 Resource Sharing Support (9P2000)"
+	select NETFS_SUPPORT
 	help
 	  If you say Y here, you will get experimental support for
 	  Plan 9 resource sharing via the 9P2000 protocol.
diff --git a/net/9p/client.c b/net/9p/client.c
index e265a0ca6bdd..844aca4fe4d8 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -18,6 +18,7 @@
 #include <linux/sched/signal.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
+#include <linux/netfs.h>
 #include <net/9p/9p.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
@@ -1661,6 +1662,54 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 }
 EXPORT_SYMBOL(p9_client_write);
 
+void
+p9_client_write_subreq(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *wreq = subreq->rreq;
+	struct p9_fid *fid = wreq->netfs_priv;
+	struct p9_client *clnt = fid->clnt;
+	struct p9_req_t *req;
+	unsigned long long start = subreq->start + subreq->transferred;
+	size_t len = subreq->len - subreq->transferred;
+	int written, err;
+
+	p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu len %zd\n",
+		 fid->fid, start, len);
+
+	/* Don't bother zerocopy for small IO (< 1024) */
+	if (clnt->trans_mod->zc_request && len > 1024) {
+		req = p9_client_zc_rpc(clnt, P9_TWRITE, NULL, &subreq->io_iter,
+				       0, wreq->len, P9_ZC_HDR_SZ, "dqd",
+				       fid->fid, start, len);
+	} else {
+		req = p9_client_rpc(clnt, P9_TWRITE, "dqV", fid->fid,
+				    start, len, &subreq->io_iter);
+	}
+	if (IS_ERR(req)) {
+		netfs_write_subrequest_terminated(subreq, PTR_ERR(req), false);
+		return;
+	}
+
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "d", &written);
+	if (err) {
+		trace_9p_protocol_dump(clnt, &req->rc);
+		p9_req_put(clnt, req);
+		netfs_write_subrequest_terminated(subreq, err, false);
+		return;
+	}
+
+	if (written > len) {
+		pr_err("bogus RWRITE count (%d > %lu)\n", written, len);
+		written = len;
+	}
+
+	p9_debug(P9_DEBUG_9P, "<<< RWRITE count %zd\n", len);
+
+	p9_req_put(clnt, req);
+	netfs_write_subrequest_terminated(subreq, written, false);
+}
+EXPORT_SYMBOL(p9_client_write_subreq);
+
 struct p9_wstat *p9_client_stat(struct p9_fid *fid)
 {
 	int err;

