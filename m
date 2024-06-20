Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01182910EA6
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2024 19:32:27 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hDHAL7Za;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hDHAL7Za;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W4ncR3yZKz3bYc
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 03:32:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hDHAL7Za;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hDHAL7Za;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W4ncM6Jsnz3cXd
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2024 03:32:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUNe0qGPbYPucT2oL0wEdLncnKH7kSG74rEcjvbSDSE=;
	b=hDHAL7ZamITvLdHOgisPZtwUHVj6V6kpl6jP0E5AHeoCSivz0ABa1qqRmLOkiySoquxbVs
	TFY7HbHXVW6Aq30SG2XcIFylQxZ/0MkhKepZUIMb5tDgUWYghZSXCk03v3fZtDSoxsKuWB
	ubqhXoEile3RW5zkfOOp979kKj0VK24=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUNe0qGPbYPucT2oL0wEdLncnKH7kSG74rEcjvbSDSE=;
	b=hDHAL7ZamITvLdHOgisPZtwUHVj6V6kpl6jP0E5AHeoCSivz0ABa1qqRmLOkiySoquxbVs
	TFY7HbHXVW6Aq30SG2XcIFylQxZ/0MkhKepZUIMb5tDgUWYghZSXCk03v3fZtDSoxsKuWB
	ubqhXoEile3RW5zkfOOp979kKj0VK24=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-fOdZNPsaPiG_jKLo6iUksg-1; Thu,
 20 Jun 2024 13:32:13 -0400
X-MC-Unique: fOdZNPsaPiG_jKLo6iUksg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1E6219560B1;
	Thu, 20 Jun 2024 17:32:06 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.156])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E94C31956087;
	Thu, 20 Jun 2024 17:31:59 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 02/17] netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs_inode
Date: Thu, 20 Jun 2024 18:31:20 +0100
Message-ID: <20240620173137.610345-3-dhowells@redhat.com>
In-Reply-To: <20240620173137.610345-1-dhowells@redhat.com>
References: <20240620173137.610345-1-dhowells@redhat.com>
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Move CIFS_INO_MODIFIED_ATTR to netfs_inode as NETFS_ICTX_MODIFIED_ATTR and
then make netfs_perform_write() set it.  This means that cifs doesn't need
to implement the ->post_modify() hook.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c | 10 ++++++++--
 fs/smb/client/cifsglob.h  |  1 -
 fs/smb/client/file.c      |  9 +--------
 include/linux/netfs.h     |  1 +
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 07bc1fd43530..41d556fe382a 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -405,8 +405,14 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	} while (iov_iter_count(iter));
 
 out:
-	if (likely(written) && ctx->ops->post_modify)
-		ctx->ops->post_modify(inode);
+	if (likely(written)) {
+		/* Set indication that ctime and mtime got updated in case
+		 * close is deferred.
+		 */
+		set_bit(NETFS_ICTX_MODIFIED_ATTR, &ctx->flags);
+		if (unlikely(ctx->ops->post_modify))
+			ctx->ops->post_modify(inode);
+	}
 
 	if (unlikely(wreq)) {
 		ret2 = netfs_end_writethrough(wreq, &wbc, writethrough);
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 73482734a8d8..4b00512fb9f9 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1569,7 +1569,6 @@ struct cifsInodeInfo {
 #define CIFS_INO_DELETE_PENDING		  (3) /* delete pending on server */
 #define CIFS_INO_INVALID_MAPPING	  (4) /* pagecache is invalid */
 #define CIFS_INO_LOCK			  (5) /* lock bit for synchronization */
-#define CIFS_INO_MODIFIED_ATTR            (6) /* Indicate change in mtime/ctime */
 #define CIFS_INO_CLOSE_ON_LOCK            (7) /* Not to defer the close when lock is set */
 	unsigned long flags;
 	spinlock_t writers_lock;
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 9d5c2440abfc..67dd8fcd0e6d 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -302,12 +302,6 @@ static void cifs_rreq_done(struct netfs_io_request *rreq)
 		inode_set_atime_to_ts(inode, inode_get_mtime(inode));
 }
 
-static void cifs_post_modify(struct inode *inode)
-{
-	/* Indication to update ctime and mtime as close is deferred */
-	set_bit(CIFS_INO_MODIFIED_ATTR, &CIFS_I(inode)->flags);
-}
-
 static void cifs_free_request(struct netfs_io_request *rreq)
 {
 	struct cifs_io_request *req = container_of(rreq, struct cifs_io_request, rreq);
@@ -346,7 +340,6 @@ const struct netfs_request_ops cifs_req_ops = {
 	.clamp_length		= cifs_clamp_length,
 	.issue_read		= cifs_req_issue_read,
 	.done			= cifs_rreq_done,
-	.post_modify		= cifs_post_modify,
 	.begin_writeback	= cifs_begin_writeback,
 	.prepare_write		= cifs_prepare_write,
 	.issue_write		= cifs_issue_write,
@@ -1369,7 +1362,7 @@ int cifs_close(struct inode *inode, struct file *file)
 		dclose = kmalloc(sizeof(struct cifs_deferred_close), GFP_KERNEL);
 		if ((cfile->status_file_deleted == false) &&
 		    (smb2_can_defer_close(inode, dclose))) {
-			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
+			if (test_and_clear_bit(NETFS_ICTX_MODIFIED_ATTR, &cinode->netfs.flags)) {
 				inode_set_mtime_to_ts(inode,
 						      inode_set_ctime_current(inode));
 			}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5d0288938cc2..2d438aaae685 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -73,6 +73,7 @@ struct netfs_inode {
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
 #define NETFS_ICTX_WRITETHROUGH	2		/* Write-through caching */
+#define NETFS_ICTX_MODIFIED_ATTR 3		/* Indicate change in mtime/ctime */
 #define NETFS_ICTX_USE_PGPRIV2	31		/* [DEPRECATED] Use PG_private_2 to mark
 						 * write to cache on read */
 };

