Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 694BB8B77CC
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Apr 2024 16:01:25 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c985YWO7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c985YWO7;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VTMLW0Mv1z3cSV
	for <lists+linux-erofs@lfdr.de>; Wed,  1 May 2024 00:01:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c985YWO7;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c985YWO7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VTMLQ3FPFz3cTH
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 May 2024 00:01:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVvsQkYCcJVRpP2m+QZDwQmmWSsKMODgUlfWruXZbkI=;
	b=c985YWO7qxS7MYCWoQD9q2j5WlDqX1OrRpnb3DjUzYa/5JHswqjtVT9u3erBToWHl90T9X
	rXUvrq+3nfIEsFHaj01FIXrgdek1bwSsLjoPCjehvk/SaIRccTK/3CYFVEXIicl8UO/iQ1
	DzP1+Bn4nyK0rhCnGrI8eZOj3eMev68=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVvsQkYCcJVRpP2m+QZDwQmmWSsKMODgUlfWruXZbkI=;
	b=c985YWO7qxS7MYCWoQD9q2j5WlDqX1OrRpnb3DjUzYa/5JHswqjtVT9u3erBToWHl90T9X
	rXUvrq+3nfIEsFHaj01FIXrgdek1bwSsLjoPCjehvk/SaIRccTK/3CYFVEXIicl8UO/iQ1
	DzP1+Bn4nyK0rhCnGrI8eZOj3eMev68=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-zRMsxZfENTaJb65jT9Kr8g-1; Tue, 30 Apr 2024 10:01:09 -0400
X-MC-Unique: zRMsxZfENTaJb65jT9Kr8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9CEC830D37;
	Tue, 30 Apr 2024 14:01:06 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 71CEA1121313;
	Tue, 30 Apr 2024 14:01:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v2 01/22] netfs: Update i_blocks when write committed to pagecache
Date: Tue, 30 Apr 2024 15:00:32 +0100
Message-ID: <20240430140056.261997-2-dhowells@redhat.com>
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
Cc: David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <nspmangalore@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Update i_blocks when i_size is updated when we finish making a write to the
pagecache to reflect the amount of space we think will be consumed.

This maintains cifs commit dbfdff402d89854126658376cbcb08363194d3cd ("smb3:
update allocation size more accurately on write completion") which would
otherwise be removed by the cifs part of the netfs writeback rewrite.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_write.c | 45 +++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 267b622d923b..f7455a579f21 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -130,6 +130,37 @@ static struct folio *netfs_grab_folio_for_write(struct address_space *mapping,
 				   mapping_gfp_mask(mapping));
 }
 
+/*
+ * Update i_size and estimate the update to i_blocks to reflect the additional
+ * data written into the pagecache until we can find out from the server what
+ * the values actually are.
+ */
+static void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
+				loff_t i_size, loff_t pos, size_t copied)
+{
+	blkcnt_t add;
+	size_t gap;
+
+	if (ctx->ops->update_i_size) {
+		ctx->ops->update_i_size(inode, pos);
+		return;
+	}
+
+	i_size_write(inode, pos);
+#if IS_ENABLED(CONFIG_FSCACHE)
+	fscache_update_cookie(ctx->cache, NULL, &pos);
+#endif
+
+	gap = SECTOR_SIZE - (i_size & (SECTOR_SIZE - 1));
+	if (copied > gap) {
+		add = DIV_ROUND_UP(copied - gap, SECTOR_SIZE);
+
+		inode->i_blocks = min_t(blkcnt_t,
+					DIV_ROUND_UP(pos, SECTOR_SIZE),
+					inode->i_blocks + add);
+	}
+}
+
 /**
  * netfs_perform_write - Copy data into the pagecache.
  * @iocb: The operation parameters
@@ -351,18 +382,10 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		trace_netfs_folio(folio, trace);
 
 		/* Update the inode size if we moved the EOF marker */
-		i_size = i_size_read(inode);
 		pos += copied;
-		if (pos > i_size) {
-			if (ctx->ops->update_i_size) {
-				ctx->ops->update_i_size(inode, pos);
-			} else {
-				i_size_write(inode, pos);
-#if IS_ENABLED(CONFIG_FSCACHE)
-				fscache_update_cookie(ctx->cache, NULL, &pos);
-#endif
-			}
-		}
+		i_size = i_size_read(inode);
+		if (pos > i_size)
+			netfs_update_i_size(ctx, inode, i_size, pos, copied);
 		written += copied;
 
 		if (likely(!wreq)) {

