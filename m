Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B8236959112
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 01:21:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WpQTG5KH0z2yM6
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 09:21:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NTx8y2UC;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AjxUT9w7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WpQTD1q5sz2xJV
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2024 09:21:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724196092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLNXobqu9Lr51n4CzgcItZvbbRppxWdYVF89daxGYJk=;
	b=NTx8y2UCGrDpOXgoO+Q6ezrh6GJxZhFkcobLfiufpCOr7ewr7d2gqa/4zJZ8U/KVGjA3hN
	5FEus/lnc0prLV1tb52ZvbbVUHGVtMtjDFe67EVAsoY0wL8e8onRX8OvC3o8OL2mfTuGaq
	f07Q3JJXSOBbJqJB19tRTKALuan3Epw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724196093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLNXobqu9Lr51n4CzgcItZvbbRppxWdYVF89daxGYJk=;
	b=AjxUT9w7f423TfXyGz36GTvbBWHM8FDTmdYVGwHZo7qVCqdclE75JVjld/bCQ4Rmswy43Z
	BscwszPu9DOeNLC+kg7HQHHfI7GBOXemxarQ1ZwlQu+HKzd+Hx5KBCTmWPVkLiCIZD8ygU
	qgIk1gJVGJtIw1Jj7Hx47QeQ6vA5bOQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-12CfHN9WNkObG7tnXd9WhA-1; Tue,
 20 Aug 2024 19:21:29 -0400
X-MC-Unique: 12CfHN9WNkObG7tnXd9WhA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3436B195608A;
	Tue, 20 Aug 2024 23:21:25 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 09A0F1955E8C;
	Tue, 20 Aug 2024 23:21:20 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 2/4] afs: Fix post-setattr file edit to do truncation correctly
Date: Wed, 21 Aug 2024 00:20:56 +0100
Message-ID: <20240820232105.3792638-3-dhowells@redhat.com>
In-Reply-To: <20240820232105.3792638-1-dhowells@redhat.com>
References: <20240820232105.3792638-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Marc Dionne <marc.dionne@auristor.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

At the end of an kAFS RPC operation, there is an "edit" phase (originally
intended for post-directory modification ops to edit the local image) that
the setattr VFS op uses to fix up the pagecache if the RPC that requested
truncation of a file was successful.

afs_setattr_edit_file() calls truncate_setsize() which sets i_size, expands
the pagecache if needed and truncates the pagecache.  The first two of
those, however, are redundant as they've already been done by
afs_setattr_success() under the io_lock and the first is also done under
the callback lock (cb_lock).

Fix afs_setattr_edit_file() to call truncate_pagecache() instead (which is
called by truncate_setsize(), thereby skipping the redundant parts.

Fixes: 100ccd18bb41 ("netfs: Optimise away reads above the point at which there can be no data")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Pankaj Raghav <p.raghav@samsung.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/inode.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 3acf5e050072..a95e77670b49 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -695,13 +695,18 @@ static void afs_setattr_edit_file(struct afs_operation *op)
 {
 	struct afs_vnode_param *vp = &op->file[0];
 	struct afs_vnode *vnode = vp->vnode;
+	struct inode *inode = &vnode->netfs.inode;
 
 	if (op->setattr.attr->ia_valid & ATTR_SIZE) {
 		loff_t size = op->setattr.attr->ia_size;
-		loff_t i_size = op->setattr.old_i_size;
+		loff_t old = op->setattr.old_i_size;
+
+		/* Note: inode->i_size was updated by afs_apply_status() inside
+		 * the I/O and callback locks.
+		 */
 
-		if (size != i_size) {
-			truncate_setsize(&vnode->netfs.inode, size);
+		if (size != old) {
+			truncate_pagecache(inode, size);
 			netfs_resize_file(&vnode->netfs, size, true);
 			fscache_resize_cookie(afs_vnode_cache(vnode), size);
 		}

