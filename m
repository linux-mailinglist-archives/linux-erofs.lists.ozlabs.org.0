Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A8F910EBC
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2024 19:33:39 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B9gh5+1K;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UszRmDaG;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W4ndq6st5z3cRJ
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 03:33:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B9gh5+1K;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UszRmDaG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W4ndj0rPpz3cVv
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2024 03:33:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uX8xcUkGpuu8sXJI7G0aibuVHEQvl2VRr7qcOSjNkD0=;
	b=B9gh5+1KU85aaAL6SOrsPKEtFGzAIdGajDHA4wquUcFSbtgdK/EojfSiFPFTtR08ZvG4dR
	bplsN3dKOgSSQfK1f72YGryp/djA2Ey7UTI39ilBVhlyn1OI7G6EsxXlN6vEaYuI81r7np
	7sqqhMpGo/17BCvZkO89JMzp9TXt5vs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uX8xcUkGpuu8sXJI7G0aibuVHEQvl2VRr7qcOSjNkD0=;
	b=UszRmDaG/9eHWNxikibYtd6wrIyMqf6LfU3sNy2sUNZYrLDnVilUlXBmbcyVMmcVKcQj4r
	ZgjxPpSZ1GX4s3+7Q2/5tKhP9jwqJsso/s8ivknDRtseGzY6XyqZhocC2zsRvCggIzX6+F
	wRmPe1zpWazDbd7ISXz2utwuzZzLcJQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-5gkrIObUOdmWGIEp57IBsQ-1; Thu,
 20 Jun 2024 13:33:22 -0400
X-MC-Unique: 5gkrIObUOdmWGIEp57IBsQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDA6719560BE;
	Thu, 20 Jun 2024 17:33:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.156])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76B5219560AF;
	Thu, 20 Jun 2024 17:33:12 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 11/17] cifs: Move the 'pid' from the subreq to the req
Date: Thu, 20 Jun 2024 18:31:29 +0100
Message-ID: <20240620173137.610345-12-dhowells@redhat.com>
In-Reply-To: <20240620173137.610345-1-dhowells@redhat.com>
References: <20240620173137.610345-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

Move the reference pid from the cifs_io_subrequest struct to the
cifs_io_request struct as it's the same for all subreqs of a particular
request.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsglob.h |  2 +-
 fs/smb/client/cifssmb.c  |  8 ++++----
 fs/smb/client/file.c     | 10 +++-------
 fs/smb/client/smb2pdu.c  |  4 ++--
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index b48d3f5e8889..bbcc552c07be 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1495,6 +1495,7 @@ struct cifs_io_request {
 	struct netfs_io_request		rreq;
 	struct cifsFileInfo		*cfile;
 	struct TCP_Server_Info		*server;
+	pid_t				pid;
 };
 
 /* asynchronous read support */
@@ -1505,7 +1506,6 @@ struct cifs_io_subrequest {
 		struct cifs_io_request *req;
 	};
 	ssize_t				got_bytes;
-	pid_t				pid;
 	unsigned int			xid;
 	int				result;
 	bool				have_xid;
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 25e9ab947c17..595c4b673707 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1345,8 +1345,8 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 	if (rc)
 		return rc;
 
-	smb->hdr.Pid = cpu_to_le16((__u16)rdata->pid);
-	smb->hdr.PidHigh = cpu_to_le16((__u16)(rdata->pid >> 16));
+	smb->hdr.Pid = cpu_to_le16((__u16)rdata->req->pid);
+	smb->hdr.PidHigh = cpu_to_le16((__u16)(rdata->req->pid >> 16));
 
 	smb->AndXCommand = 0xFF;	/* none */
 	smb->Fid = rdata->req->cfile->fid.netfid;
@@ -1689,8 +1689,8 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 	if (rc)
 		goto async_writev_out;
 
-	smb->hdr.Pid = cpu_to_le16((__u16)wdata->pid);
-	smb->hdr.PidHigh = cpu_to_le16((__u16)(wdata->pid >> 16));
+	smb->hdr.Pid = cpu_to_le16((__u16)wdata->req->pid);
+	smb->hdr.PidHigh = cpu_to_le16((__u16)(wdata->req->pid >> 16));
 
 	smb->AndXCommand = 0xFF;	/* none */
 	smb->Fid = wdata->req->cfile->fid.netfid;
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 16fa1ac1ed2d..45c860f0e7fd 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -178,14 +178,8 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
-	pid_t pid;
 	int rc = 0;
 
-	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
-		pid = req->cfile->pid;
-	else
-		pid = current->tgid; // Ummm...  This may be a workqueue
-
 	cifs_dbg(FYI, "%s: op=%08x[%x] mapping=%p len=%zu/%zu\n",
 		 __func__, rreq->debug_id, subreq->debug_index, rreq->mapping,
 		 subreq->transferred, subreq->len);
@@ -199,7 +193,6 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 	}
 
 	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
-	rdata->pid = pid;
 
 	rc = rdata->server->ops->async_readv(rdata);
 out:
@@ -236,12 +229,15 @@ static int cifs_init_request(struct netfs_io_request *rreq, struct file *file)
 
 	rreq->rsize = cifs_sb->ctx->rsize;
 	rreq->wsize = cifs_sb->ctx->wsize;
+	req->pid = current->tgid; // Ummm...  This may be a workqueue
 
 	if (file) {
 		open_file = file->private_data;
 		rreq->netfs_priv = file->private_data;
 		req->cfile = cifsFileInfo_get(open_file);
 		req->server = cifs_pick_channel(tlink_tcon(req->cfile->tlink)->ses);
+		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
+			req->pid = req->cfile->pid;
 	} else if (rreq->origin != NETFS_WRITEBACK) {
 		WARN_ON_ONCE(1);
 		return -EIO;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index e213cecd5094..2ae2dbb6202b 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4621,7 +4621,7 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 	io_parms.length = rdata->subreq.len;
 	io_parms.persistent_fid = rdata->req->cfile->fid.persistent_fid;
 	io_parms.volatile_fid = rdata->req->cfile->fid.volatile_fid;
-	io_parms.pid = rdata->pid;
+	io_parms.pid = rdata->req->pid;
 
 	rc = smb2_new_read_req(
 		(void **) &buf, &total_len, &io_parms, rdata, 0, 0);
@@ -4873,7 +4873,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 		.length = wdata->subreq.len,
 		.persistent_fid = wdata->req->cfile->fid.persistent_fid,
 		.volatile_fid = wdata->req->cfile->fid.volatile_fid,
-		.pid = wdata->pid,
+		.pid = wdata->req->pid,
 	};
 	io_parms = &_io_parms;
 

