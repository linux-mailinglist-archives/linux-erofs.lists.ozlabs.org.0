Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A3E9B102C
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2024 22:43:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZvrY6Xsrz3blF
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Oct 2024 07:43:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729889019;
	cv=none; b=mjoZBuiYTg5g2oApvJ1RGh2r8tavy5Jl2LGVF/MqS7ZumZf7vf2tqD6mdXSWpvNn+1O1FH8c70k9LJggD9XttbgLAzpvAmAKdCssS+Q8wTGCCQUTSg6k8H+cs+Z+25HQpDuFBx+QzmD+H6GqiL8oykP4JEJFNTFYDzEOG5G+hfwGmmbet5Y/hYY5IRBCCW1C7i69XJe0GkQXPH9Wah6NNXuYNgj699yZZyc78tPSxBDqMNkIgPx9g/Ek9xFnAzz95/4fBCEuo/lKzu54ZCZDTeC8vraX8eO+WEcYvhiAg1xnfWNNwOh0cF3N6PH0AVxjqnGtRTNCbGLk4mIjqQGASw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729889019; c=relaxed/relaxed;
	bh=wFqMqWoetmDgJohUIxNDxB+jf1Dpav+HZ2SxzPixQNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1KokReCaJkobwTqo2331dAyKB8FqSnlr7HHFKAmNYJYSk9BPojwumB9TnejPOWeAA8zkxAcgHxVh2BwKMw7mp2HQhEUaj/IGrWafRag4N1RMDxEe6g+Gg1JdxSyr+Yq6zgh+c7kxq/pDqZKwugh2rsWkYcOQsM/8cHc48b4x+MrG+SdypD+TUKDpLX1fnNudlc6wBa127haKj21I+v7f34Xp0z+GTTsSm5WWKqQ5+T4JD8yFEdDLTiYOGSyzYU4wEQk+E+KIPRslG/sXR3TgiaN8fc0b2t+13gS5tMtW+twcPkldwyz9m0UUinEieE5A/zyrgdKBYk+Vz93pGNBIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LtMZdrrU; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jvy2rNTr; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LtMZdrrU;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jvy2rNTr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZvrV3d8bz3bkd
	for <linux-erofs@lists.ozlabs.org>; Sat, 26 Oct 2024 07:43:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729889015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFqMqWoetmDgJohUIxNDxB+jf1Dpav+HZ2SxzPixQNI=;
	b=LtMZdrrUXzK90vcKZ/p7x9sacpv6xd77Ww0fQj4XUIDJINdrI8zFQ6DaUm9VjcfwUV3GWc
	wMHtgb2nYXNGnQW2LFFHusi9vfxwd1DEWWjvQE+GOTgt9xRpP3eL1vRCa1Ip+EiLBnVU0V
	NW4TyJDaIdULOxgvhTBg1EkOB5gzlYc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729889016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFqMqWoetmDgJohUIxNDxB+jf1Dpav+HZ2SxzPixQNI=;
	b=Jvy2rNTr6FADVXyCr/RTbOinAO4geEpemBBCJ82B7GnJ3v6w05jfto70wr/RvkY9ncirmw
	WeCdWVAtLozgo/ET3Pitgoc2afWrjaOJHtviDnn3plVojlKhYebWrbYmnMs1fyuymQm3tD
	M9WHEW2XHgXOVJYovZuj1YZJPuraRUM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-pn1yqeasMsy-bKAE7IAH9g-1; Fri,
 25 Oct 2024 16:43:32 -0400
X-MC-Unique: pn1yqeasMsy-bKAE7IAH9g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A20D1955EA9;
	Fri, 25 Oct 2024 20:43:29 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BAD2196BB7D;
	Fri, 25 Oct 2024 20:43:24 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 29/31] afs: Locally initialise the contents of a new symlink on creation
Date: Fri, 25 Oct 2024 21:39:56 +0100
Message-ID: <20241025204008.4076565-30-dhowells@redhat.com>
In-Reply-To: <20241025204008.4076565-1-dhowells@redhat.com>
References: <20241025204008.4076565-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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
index 0737d729f4e6..b11b2dfb8380 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1216,6 +1216,7 @@ extern void afs_fs_probe_cleanup(struct afs_net *);
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

