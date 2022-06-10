Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E452E546DC1
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Jun 2022 21:57:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LKWvk6VDJz3c4h
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jun 2022 05:57:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HYn8G1nV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HYn8G1nV;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HYn8G1nV;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HYn8G1nV;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LKWvf37qcz3c8x
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jun 2022 05:57:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1654891035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NSkt+9OBeiMDSzKoOk1px92nniKwBrH90yvJxWMzUc=;
	b=HYn8G1nVjVIpIdNIJ/JitCyI/pIW1DahtqRc2R/yY3/wKa54OB1/GQtUPvv7SV4Zz5AE8l
	0W0v5+jyS4epI0UU3TjKr52nwsG+22cEU0P30aPS53v3Kr0x2/dtmQf71ClWRvuwPukjFh
	Ok23/iCkuCMkd4IXCFVOMMBrn9Y+kDc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1654891035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NSkt+9OBeiMDSzKoOk1px92nniKwBrH90yvJxWMzUc=;
	b=HYn8G1nVjVIpIdNIJ/JitCyI/pIW1DahtqRc2R/yY3/wKa54OB1/GQtUPvv7SV4Zz5AE8l
	0W0v5+jyS4epI0UU3TjKr52nwsG+22cEU0P30aPS53v3Kr0x2/dtmQf71ClWRvuwPukjFh
	Ok23/iCkuCMkd4IXCFVOMMBrn9Y+kDc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-av3RAJm5M3qyoV1NkwL1hw-1; Fri, 10 Jun 2022 15:57:12 -0400
X-MC-Unique: av3RAJm5M3qyoV1NkwL1hw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75773811E76;
	Fri, 10 Jun 2022 19:57:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B1EAB492C3B;
	Fri, 10 Jun 2022 19:57:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/3] netfs: Rename the netfs_io_request cleanup op and give it
 an op pointer
From: David Howells <dhowells@redhat.com>
Date: Fri, 10 Jun 2022 20:57:09 +0100
Message-ID:  <165489102899.703883.17034408390431788184.stgit@warthog.procyon.org.uk>
In-Reply-To:  <165489100590.703883.11054313979289027590.stgit@warthog.procyon.org.uk>
References:  <165489100590.703883.11054313979289027590.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The netfs_io_request cleanup op is now always in a position to be given a
pointer to a netfs_io_request struct, so this can be passed in instead of
the mapping and private data arguments (both of which are included in the
struct).

So rename the ->cleanup op to ->free_request (to match ->init_request) and
pass in the I/O pointer.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
---

 Documentation/filesystems/netfs_library.rst |   24 ++++++++++++------------
 fs/9p/vfs_addr.c                            |   11 +++++------
 fs/afs/file.c                               |    6 +++---
 fs/ceph/addr.c                              |    9 ++++-----
 fs/netfs/objects.c                          |    6 +++---
 include/linux/netfs.h                       |    3 ++-
 6 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 9332f66373ee..4d19b19bcc08 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -158,9 +158,10 @@ The helpers manage the read request, calling back into the network filesystem
 through the suppplied table of operations.  Waits will be performed as
 necessary before returning for helpers that are meant to be synchronous.
 
-If an error occurs and netfs_priv is non-NULL, ops->cleanup() will be called to
-deal with it.  If some parts of the request are in progress when an error
-occurs, the request will get partially completed if sufficient data is read.
+If an error occurs, the ->free_request() will be called to clean up the
+netfs_io_request struct allocated.  If some parts of the request are in
+progress when an error occurs, the request will get partially completed if
+sufficient data is read.
 
 Additionally, there is::
 
@@ -208,8 +209,7 @@ The above fields are the ones the netfs can use.  They are:
  * ``netfs_priv``
 
    The network filesystem's private data.  The value for this can be passed in
-   to the helper functions or set during the request.  The ->cleanup() op will
-   be called if this is non-NULL at the end.
+   to the helper functions or set during the request.
 
  * ``start``
  * ``len``
@@ -294,6 +294,7 @@ through which it can issue requests and negotiate::
 
 	struct netfs_request_ops {
 		void (*init_request)(struct netfs_io_request *rreq, struct file *file);
+		void (*free_request)(struct netfs_io_request *rreq);
 		int (*begin_cache_operation)(struct netfs_io_request *rreq);
 		void (*expand_readahead)(struct netfs_io_request *rreq);
 		bool (*clamp_length)(struct netfs_io_subrequest *subreq);
@@ -302,7 +303,6 @@ through which it can issue requests and negotiate::
 		int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
 					 struct folio *folio, void **_fsdata);
 		void (*done)(struct netfs_io_request *rreq);
-		void (*cleanup)(struct address_space *mapping, void *netfs_priv);
 	};
 
 The operations are as follows:
@@ -310,7 +310,12 @@ The operations are as follows:
  * ``init_request()``
 
    [Optional] This is called to initialise the request structure.  It is given
-   the file for reference and can modify the ->netfs_priv value.
+   the file for reference.
+
+ * ``free_request()``
+
+   [Optional] This is called as the request is being deallocated so that the
+   filesystem can clean up any state it has attached there.
 
  * ``begin_cache_operation()``
 
@@ -384,11 +389,6 @@ The operations are as follows:
    [Optional] This is called after the folios in the request have all been
    unlocked (and marked uptodate if applicable).
 
- * ``cleanup``
-
-   [Optional] This is called as the request is being deallocated so that the
-   filesystem can clean up ->netfs_priv.
-
 
 
 Read Helper Procedure
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index c004b9a73a92..a8f512b44a85 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -66,13 +66,12 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 }
 
 /**
- * v9fs_req_cleanup - Cleanup request initialized by v9fs_init_request
- * @mapping: unused mapping of request to cleanup
- * @priv: private data to cleanup, a fid, guaranted non-null.
+ * v9fs_free_request - Cleanup request initialized by v9fs_init_rreq
+ * @rreq: The I/O request to clean up
  */
-static void v9fs_req_cleanup(struct address_space *mapping, void *priv)
+static void v9fs_free_request(struct netfs_io_request *rreq)
 {
-	struct p9_fid *fid = priv;
+	struct p9_fid *fid = rreq->netfs_priv;
 
 	p9_client_clunk(fid);
 }
@@ -94,9 +93,9 @@ static int v9fs_begin_cache_operation(struct netfs_io_request *rreq)
 
 const struct netfs_request_ops v9fs_req_ops = {
 	.init_request		= v9fs_init_request,
+	.free_request		= v9fs_free_request,
 	.begin_cache_operation	= v9fs_begin_cache_operation,
 	.issue_read		= v9fs_issue_read,
-	.cleanup		= v9fs_req_cleanup,
 };
 
 /**
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 4de7af7c2f09..42118a4f3383 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -382,17 +382,17 @@ static int afs_check_write_begin(struct file *file, loff_t pos, unsigned len,
 	return test_bit(AFS_VNODE_DELETED, &vnode->flags) ? -ESTALE : 0;
 }
 
-static void afs_priv_cleanup(struct address_space *mapping, void *netfs_priv)
+static void afs_free_request(struct netfs_io_request *rreq)
 {
-	key_put(netfs_priv);
+	key_put(rreq->netfs_priv);
 }
 
 const struct netfs_request_ops afs_req_ops = {
 	.init_request		= afs_init_request,
+	.free_request		= afs_free_request,
 	.begin_cache_operation	= afs_begin_cache_operation,
 	.check_write_begin	= afs_check_write_begin,
 	.issue_read		= afs_issue_read,
-	.cleanup		= afs_priv_cleanup,
 };
 
 int afs_write_inode(struct inode *inode, struct writeback_control *wbc)
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 9763e7ea8148..6dee88815491 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -394,11 +394,10 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 	return 0;
 }
 
-static void ceph_readahead_cleanup(struct address_space *mapping, void *priv)
+static void ceph_netfs_free_request(struct netfs_io_request *rreq)
 {
-	struct inode *inode = mapping->host;
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	int got = (uintptr_t)priv;
+	struct ceph_inode_info *ci = ceph_inode(rreq->inode);
+	int got = (uintptr_t)rreq->netfs_priv;
 
 	if (got)
 		ceph_put_cap_refs(ci, got);
@@ -406,12 +405,12 @@ static void ceph_readahead_cleanup(struct address_space *mapping, void *priv)
 
 const struct netfs_request_ops ceph_netfs_ops = {
 	.init_request		= ceph_init_request,
+	.free_request		= ceph_netfs_free_request,
 	.begin_cache_operation	= ceph_begin_cache_operation,
 	.issue_read		= ceph_netfs_issue_read,
 	.expand_readahead	= ceph_netfs_expand_readahead,
 	.clamp_length		= ceph_netfs_clamp_length,
 	.check_write_begin	= ceph_netfs_check_write_begin,
-	.cleanup		= ceph_readahead_cleanup,
 };
 
 #ifdef CONFIG_CEPH_FSCACHE
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index c6afa605b63b..e17cdf53f6a7 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -75,10 +75,10 @@ static void netfs_free_request(struct work_struct *work)
 	struct netfs_io_request *rreq =
 		container_of(work, struct netfs_io_request, work);
 
-	netfs_clear_subrequests(rreq, false);
-	if (rreq->netfs_priv)
-		rreq->netfs_ops->cleanup(rreq->mapping, rreq->netfs_priv);
 	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
+	netfs_clear_subrequests(rreq, false);
+	if (rreq->netfs_ops->free_request)
+		rreq->netfs_ops->free_request(rreq);
 	if (rreq->cache_resources.ops)
 		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
 	kfree(rreq);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index a62739f3726b..097cdd644665 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -206,7 +206,9 @@ struct netfs_io_request {
  */
 struct netfs_request_ops {
 	int (*init_request)(struct netfs_io_request *rreq, struct file *file);
+	void (*free_request)(struct netfs_io_request *rreq);
 	int (*begin_cache_operation)(struct netfs_io_request *rreq);
+
 	void (*expand_readahead)(struct netfs_io_request *rreq);
 	bool (*clamp_length)(struct netfs_io_subrequest *subreq);
 	void (*issue_read)(struct netfs_io_subrequest *subreq);
@@ -214,7 +216,6 @@ struct netfs_request_ops {
 	int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
 				 struct folio *folio, void **_fsdata);
 	void (*done)(struct netfs_io_request *rreq);
-	void (*cleanup)(struct address_space *mapping, void *netfs_priv);
 };
 
 /*


