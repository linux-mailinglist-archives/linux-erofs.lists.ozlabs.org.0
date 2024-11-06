Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167A59BEA0F
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 13:40:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xk4Y90tykz3bhf
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 23:40:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730896811;
	cv=none; b=YU5BZ6zfNtatYCj8WujlNmmyeENi9mebeKtrlvgrqm6yNYFYEndxvrOViEbcVCXMAcbpKIK1ARV3Fnvc2yWkzkUvNXPSZ5LkCCOl5tyaQzliMhXf5ofgjc/E3MX7RRyzgpkBnkzDIdLD4/76z65608tmKzcdKJXM03P8pSV/CM3x5T9feX1F9FfQUq8TJ5IgIs4H/8viVtfFZ57vMCOgp0nTvnuAa+ejdhfMh2CcfmDIUi7XZ/OtQ76G1Ra747aY6Fb/uhftIf04eBiN2g3nMnO8DKAvDx57j5HNiZ2Ri5/4tAShuifiaaKr83Otjz5FpJ81mWIK8i2cV0dVPXjVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730896811; c=relaxed/relaxed;
	bh=XXoKBAczFzEdxforFlZoT0jqB8v2JMkojevHnwPW6bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDDfhDSmFSe2j4nSl5yN0wArJiBO2Jv7tNMyLU1fyv20vTPqo4JDLX9v4T6f9n8hTPgt6NQRVgUIQVcy+GZbAi+xYhCD0sStfttoxH3SKObhMuHBnwjbWSNIxgiwWV89ToU4dyAz4vnnesaFY8XjiIt3Na51nGHzIklMk0YI6TmKld/OMHYAKMmaOWVHJPTAvYpz+hjVLYXO3vPwjtO5tl7/2NR8vwFUGqqVOdcEBwIwEj5YpjNQ6Dxd8DCom6jDaVNOHRFjOdJF9QXK1D7LCJkYeARIrnuV+4rc0PBMN1MT+KUyra3xi+0i4Phc5bLpOCGq/i/pXYqA9ndhuRHWrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZYU5Lh2C; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZYU5Lh2C; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZYU5Lh2C;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZYU5Lh2C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xk4Y62XsSz3bZr
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Nov 2024 23:40:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXoKBAczFzEdxforFlZoT0jqB8v2JMkojevHnwPW6bc=;
	b=ZYU5Lh2CxFDFqQfl/J8Zi4RVLIJ6ZPh0oSb7mFyZ0MeX11Ev/ZYVKfI86UGfHtpWl5Jiv6
	b3aGAeH4uiapaUth9LwliKkHuHE68yU7fsWGP30fkFZvf5I4I2qMgIRCeWYogrzq66R7Nh
	6rmvfqvSpVqP3tnWGsIN1KFmR67UcR0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXoKBAczFzEdxforFlZoT0jqB8v2JMkojevHnwPW6bc=;
	b=ZYU5Lh2CxFDFqQfl/J8Zi4RVLIJ6ZPh0oSb7mFyZ0MeX11Ev/ZYVKfI86UGfHtpWl5Jiv6
	b3aGAeH4uiapaUth9LwliKkHuHE68yU7fsWGP30fkFZvf5I4I2qMgIRCeWYogrzq66R7Nh
	6rmvfqvSpVqP3tnWGsIN1KFmR67UcR0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-lO_jK5jjM1WCcN-ItRvP8g-1; Wed,
 06 Nov 2024 07:40:03 -0500
X-MC-Unique: lO_jK5jjM1WCcN-ItRvP8g-1
X-Mimecast-MFC-AGG-ID: lO_jK5jjM1WCcN-ItRvP8g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF90719560A2;
	Wed,  6 Nov 2024 12:40:00 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 268B319560AD;
	Wed,  6 Nov 2024 12:39:54 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 31/33] afs: Locally initialise the contents of a new symlink on creation
Date: Wed,  6 Nov 2024 12:35:55 +0000
Message-ID: <20241106123559.724888-32-dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-1-dhowells@redhat.com>
References: <20241106123559.724888-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

Since we know what the contents of a symlink will be when we create it on
the server, initialise its contents locally too to avoid the need to
download it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dir.c             |  2 ++
 fs/afs/inode.c           | 44 ++++++++++++++++++++++++++++++++++------
 fs/afs/internal.h        |  1 +
 fs/netfs/buffered_read.c |  2 +-
 fs/netfs/read_single.c   |  2 +-
 5 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 6a4fc1cffb7e..663a212964d8 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1270,6 +1270,8 @@ static void afs_vnode_new_inode(struct afs_operation *op)
 	set_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
 	if (S_ISDIR(inode->i_mode))
 		afs_mkdir_init_dir(vnode, dvp->vnode);
+	else if (S_ISLNK(inode->i_mode))
+		afs_init_new_symlink(vnode, op);
 	if (!afs_op_error(op))
 		afs_cache_permit(vnode, op->key, vnode->cb_break, &vp->scb);
 	d_instantiate(op->dentry, inode);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index c3b720fda525..f5618564b3fc 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -25,6 +25,23 @@
 #include "internal.h"
 #include "afs_fs.h"
 
+void afs_init_new_symlink(struct afs_vnode *vnode, struct afs_operation *op)
+{
+	size_t size = strlen(op->create.symlink) + 1;
+	size_t dsize = 0;
+	char *p;
+
+	if (netfs_alloc_folioq_buffer(NULL, &vnode->directory, &dsize, size,
+				      mapping_gfp_mask(vnode->netfs.inode.i_mapping)) < 0)
+		return;
+
+	vnode->directory_size = dsize;
+	p = kmap_local_folio(folioq_folio(vnode->directory, 0), 0);
+	memcpy(p, op->create.symlink, size);
+	kunmap_local(p);
+	netfs_single_mark_inode_dirty(&vnode->netfs.inode);
+}
+
 static void afs_put_link(void *arg)
 {
 	struct folio *folio = virt_to_folio(arg);
@@ -41,15 +58,30 @@ const char *afs_get_link(struct dentry *dentry, struct inode *inode,
 	char *content;
 	ssize_t ret;
 
-	if (atomic64_read(&vnode->cb_expires_at) == AFS_NO_CB_PROMISE ||
-	    !vnode->directory) {
-		if (!dentry)
+	if (!dentry) {
+		/* RCU pathwalk. */
+		if (!vnode->directory || !afs_check_validity(vnode))
 			return ERR_PTR(-ECHILD);
-		ret = afs_read_single(vnode, NULL);
-		if (ret < 0)
-			return ERR_PTR(ret);
+		goto good;
 	}
 
+	if (!vnode->directory)
+		goto fetch;
+
+	ret = afs_validate(vnode, NULL);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	if (!test_and_clear_bit(AFS_VNODE_ZAP_DATA, &vnode->flags) &&
+	    vnode->directory)
+		goto good;
+
+fetch:
+	ret = afs_read_single(vnode, NULL);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+good:
 	folio = folioq_folio(vnode->directory, 0);
 	folio_get(folio);
 	content = kmap_local_folio(folio, 0);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 8a2daa75b095..a5da0dd8e9cc 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1220,6 +1220,7 @@ extern void afs_fs_probe_cleanup(struct afs_net *);
  */
 extern const struct afs_operation_ops afs_fetch_status_operation;
 
+void afs_init_new_symlink(struct afs_vnode *vnode, struct afs_operation *op);
 const char *afs_get_link(struct dentry *dentry, struct inode *inode,
 			 struct delayed_call *callback);
 int afs_readlink(struct dentry *dentry, char __user *buffer, int buflen);
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 7036e9f12b07..65d9dd71f65d 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -210,7 +210,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 
 	do {
 		struct netfs_io_subrequest *subreq;
-		enum netfs_io_source source = NETFS_DOWNLOAD_FROM_SERVER;
+		enum netfs_io_source source = NETFS_SOURCE_UNKNOWN;
 		ssize_t slice;
 
 		subreq = netfs_alloc_subrequest(rreq);
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index 14bc61107182..fea0ecdecc53 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -97,7 +97,7 @@ static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
 	if (!subreq)
 		return -ENOMEM;
 
-	subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
+	subreq->source	= NETFS_SOURCE_UNKNOWN;
 	subreq->start	= 0;
 	subreq->len	= rreq->len;
 	subreq->io_iter	= rreq->buffer.iter;

