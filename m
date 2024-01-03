Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF38823007
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 16:00:19 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZcosswAf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EgFHzTmB;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4tDx3RRmz30Q3
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jan 2024 02:00:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZcosswAf;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EgFHzTmB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T4tDp0PxYz3bpk
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Jan 2024 02:00:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704294007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUPriBHgZCe048XAouZ6FVZlUrGVgRcZGkDmJ6vhI+o=;
	b=ZcosswAfmwuQQDPOw/u+XeeOx1T9QEmw5bQsPu+2eaHVWQghGX+4v0Ohw65WDkCa1vRvrH
	WBQc9uwCEP52J6hMbCRYzfFoksEbM1i1J4wbGGV9ik3D+xYqkH9Xo9DaWiw8ChX5jK+UoW
	kFuiqPUeTPM4z3mQbRkheUySAX6hhdI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704294008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUPriBHgZCe048XAouZ6FVZlUrGVgRcZGkDmJ6vhI+o=;
	b=EgFHzTmBMblyMhSmO5BX4Velo6kSGXgv2U13eqKcNgeLRDI7+vIZTZlN3uEKcjrPDIfi1e
	OKlSxc7lH046KJc1CNCcv8YwqJUvMpe+9Oxe4TBMBHaViSY94t3BqdibhwrNYG+TxTpNav
	SdgKebORIDhnZj/2XaF9ZLEHsV+kIDo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-mFIdXobHMneufCW3dOaAMw-1; Wed, 03 Jan 2024 10:00:04 -0500
X-MC-Unique: mFIdXobHMneufCW3dOaAMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FA74185A780;
	Wed,  3 Jan 2024 15:00:02 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0074C3C30;
	Wed,  3 Jan 2024 14:59:58 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 3/5] 9p: Do a couple of cleanups
Date: Wed,  3 Jan 2024 14:59:27 +0000
Message-ID: <20240103145935.384404-4-dhowells@redhat.com>
In-Reply-To: <20240103145935.384404-1-dhowells@redhat.com>
References: <20240103145935.384404-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Do a couple of cleanups to 9p:

 (1) Remove a couple of unused variables.

 (2) Turn a BUG_ON() into a warning, consolidate with another warning and
     make the warning message include the inode number rather than
     whatever's in i_private (which will get hashed anyway).

Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
Link: https://lore.kernel.org/r/ZZULNQAZ0n0WQv7p@codewreck.org/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index d8fb407189a0..f7f83eec3bcc 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -28,8 +28,6 @@
 
 static void v9fs_upload_to_server(struct netfs_io_subrequest *subreq)
 {
-	struct inode *inode = subreq->rreq->inode;
-	struct v9fs_inode __maybe_unused *v9inode = V9FS_I(inode);
 	struct p9_fid *fid = subreq->rreq->netfs_priv;
 	int err;
 
@@ -98,15 +96,13 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 
 	if (file) {
 		fid = file->private_data;
-		BUG_ON(!fid);
+		if (!fid)
+			goto no_fid;
 		p9_fid_get(fid);
 	} else {
 		fid = v9fs_fid_find_inode(rreq->inode, writing, INVALID_UID, true);
-		if (!fid) {
-			WARN_ONCE(1, "folio expected an open fid inode->i_private=%p\n",
-				  rreq->inode->i_private);
-			return -EINVAL;
-		}
+		if (!fid)
+			goto no_fid;
 	}
 
 	/* we might need to read from a fid that was opened write-only
@@ -115,6 +111,11 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 	WARN_ON(rreq->origin == NETFS_READ_FOR_WRITE && !(fid->mode & P9_ORDWR));
 	rreq->netfs_priv = fid;
 	return 0;
+
+no_fid:
+	WARN_ONCE(1, "folio expected an open fid inode->i_ino=%lx\n",
+		  rreq->inode->i_ino);
+	return -EINVAL;
 }
 
 /**

