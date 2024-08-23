Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E0195D712
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 22:09:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WrB3y0jfPz302P
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 06:09:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724443756;
	cv=none; b=UGKqXLNPBfyI5FoIuUpBSVN/AD8YMp0WpHKDoADHPWmTEchsLHftVumFeZnUm40eLElNPjZYCrGDwq+hP4SwoCxVOf3ri4ohCuxly4rfMbdMuhjIon3ddEZ08ddc4zvnz7p6LNApxToNE7kEgHe+xlS8EU+HD0mSO/i+ixrr9GJcQWrgEv1A24EHQ8FjJutGBqSeIvxZov95FztjD2cMxy+VA5C5ansIbdqeSfnzHzWH8geEqJP5hs1h1Bp465wX1H7+TvJO7zga7W8ltMOtEkkYd7DOY7A9qLQ6EOaea7OSt8ujMczyEL6verViddHtP3qM0ywMGP6qG6qnvMTORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724443756; c=relaxed/relaxed;
	bh=jhhLpebTwUeEsqiiCXCW6FgURg7tDrbiy/xAxbLEp7c=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Scanned-By; b=XflZkQcr56EofMGpsHmNGRINpRVAkMKtR+LEPzrTNOJV7Sa9wdxiiE91Mx+VAUyDcIFFHLfD/GY2/W4ep21INDGhed6X/9A7sRFzxI0QhoNPDqFjSBCDZpX2GLGNT4Ilp052WGaJXOm3cHTSIfkg7rl+pBdSwMZ1JPdVGwd2bLoavRYVCyyIi7G+DW1Tv7XB1oSzZHu6H183O/ag/87ZiF7m8/iv0f0TzCXWiTnwDLct2J11tD3gly9jtqnzyqtDbHG+EpsVRCyvLBl6cEsLBauDyf6ReH6ViAYX6ZCzGZrLLdJWVZbXxnDUwrnQ30jeqF9NrO+r2p1nJpu6KoxeOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WFSxc58Y; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WFSxc58Y; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WFSxc58Y;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WFSxc58Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WrB3v6jBvz2xZj
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2024 06:09:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhhLpebTwUeEsqiiCXCW6FgURg7tDrbiy/xAxbLEp7c=;
	b=WFSxc58Y17tin6af0kj3KhlumbItLwzXaJRwa3Ht+C1XUl6Z125tAyG9opZd0EoQGuCEEe
	erCgbQUoq3J7C8obFOwP0DAJUd/lDWKoN98O5su5giEzx/DP2PXCxDHaqwPPSojSnEcbNP
	afe91gnU0v1U9hY/0IuzWdwNjqdiKtg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhhLpebTwUeEsqiiCXCW6FgURg7tDrbiy/xAxbLEp7c=;
	b=WFSxc58Y17tin6af0kj3KhlumbItLwzXaJRwa3Ht+C1XUl6Z125tAyG9opZd0EoQGuCEEe
	erCgbQUoq3J7C8obFOwP0DAJUd/lDWKoN98O5su5giEzx/DP2PXCxDHaqwPPSojSnEcbNP
	afe91gnU0v1U9hY/0IuzWdwNjqdiKtg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-X6x6BoSbM_mD1yPRqXW4Vg-1; Fri,
 23 Aug 2024 16:09:07 -0400
X-MC-Unique: X6x6BoSbM_mD1yPRqXW4Vg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E4251955D4B;
	Fri, 23 Aug 2024 20:09:05 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC9E03001FE5;
	Fri, 23 Aug 2024 20:09:00 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 6/9] cifs: Fix lack of credit renegotiation on read retry
Date: Fri, 23 Aug 2024 21:08:14 +0100
Message-ID: <20240823200819.532106-7-dhowells@redhat.com>
In-Reply-To: <20240823200819.532106-1-dhowells@redhat.com>
References: <20240823200819.532106-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, Paulo Alcantara <pc@manguebit.com>, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When netfslib asks cifs to issue a read operation, it prefaces this with a
call to ->clamp_length() which cifs uses to negotiate credits, providing
receive capacity on the server; however, in the event that a read op needs
reissuing, netfslib doesn't call ->clamp_length() again as that could
shorten the subrequest, leaving a gap.

This causes the retried read to be done with zero credits which causes the
server to reject it with STATUS_INVALID_PARAMETER.  This is a problem for a
DIO read that is requested that would go over the EOF.  The short read will
be retried, causing EINVAL to be returned to the user when it fails.

Fix this by making cifs_req_issue_read() negotiate new credits if retrying
(NETFS_SREQ_RETRYING now gets set in the read side as well as the write
side in this instance).

This isn't sufficient, however: the new credits might not be sufficient to
complete the remainder of the read, so also add an additional field,
rreq->actual_len, that holds the actual size of the op we want to perform
without having to alter subreq->len.

We then rely on repeated short reads being retried until we finish the read
or reach the end of file and make a zero-length read.

Also fix a couple of places where the subrequest start and length need to
be altered by the amount so far transferred when being used.

Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20240822220650.318774-2-dhowells@redhat.com
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/netfs/io.c            |  2 ++
 fs/smb/client/cifsglob.h |  1 +
 fs/smb/client/file.c     | 37 +++++++++++++++++++++++++++++++++----
 fs/smb/client/smb2ops.c  |  2 +-
 fs/smb/client/smb2pdu.c  | 28 +++++++++++++++++-----------
 fs/smb/client/trace.h    |  1 +
 6 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 4da0a494e860..3303b515b536 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -306,6 +306,7 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
 				break;
 			subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
 			subreq->error = 0;
+			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
 			netfs_stat(&netfs_n_rh_download_instead);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_download_instead);
 			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
@@ -313,6 +314,7 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
 			netfs_reset_subreq_iter(rreq, subreq);
 			netfs_read_from_server(rreq, subreq);
 		} else if (test_bit(NETFS_SREQ_SHORT_IO, &subreq->flags)) {
+			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
 			netfs_reset_subreq_iter(rreq, subreq);
 			netfs_rreq_short_read(rreq, subreq);
 		}
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 5c9b3e6cd95f..ffd8373bb4b1 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1486,6 +1486,7 @@ struct cifs_io_subrequest {
 		struct cifs_io_request *req;
 	};
 	ssize_t				got_bytes;
+	size_t				actual_len;
 	unsigned int			xid;
 	int				result;
 	bool				have_xid;
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 1fc66bcf49eb..b94802438c62 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -111,6 +111,7 @@ static void cifs_issue_write(struct netfs_io_subrequest *subreq)
 		goto fail;
 	}
 
+	wdata->actual_len = wdata->subreq.len;
 	rc = adjust_credits(wdata->server, wdata, cifs_trace_rw_credits_issue_write_adjust);
 	if (rc)
 		goto fail;
@@ -153,7 +154,7 @@ static bool cifs_clamp_length(struct netfs_io_subrequest *subreq)
 	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
 	struct TCP_Server_Info *server = req->server;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
-	size_t rsize = 0;
+	size_t rsize;
 	int rc;
 
 	rdata->xid = get_xid();
@@ -166,8 +167,8 @@ static bool cifs_clamp_length(struct netfs_io_subrequest *subreq)
 						     cifs_sb->ctx);
 
 
-	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize, &rsize,
-					   &rdata->credits);
+	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize,
+					   &rsize, &rdata->credits);
 	if (rc) {
 		subreq->error = rc;
 		return false;
@@ -183,7 +184,8 @@ static bool cifs_clamp_length(struct netfs_io_subrequest *subreq)
 			      server->credits, server->in_flight, 0,
 			      cifs_trace_rw_credits_read_submit);
 
-	subreq->len = min_t(size_t, subreq->len, rsize);
+	subreq->len = umin(subreq->len, rsize);
+	rdata->actual_len = subreq->len;
 
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (server->smbd_conn)
@@ -203,12 +205,39 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
+	struct TCP_Server_Info *server = req->server;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
 	int rc = 0;
 
 	cifs_dbg(FYI, "%s: op=%08x[%x] mapping=%p len=%zu/%zu\n",
 		 __func__, rreq->debug_id, subreq->debug_index, rreq->mapping,
 		 subreq->transferred, subreq->len);
 
+	if (test_bit(NETFS_SREQ_RETRYING, &subreq->flags)) {
+		/*
+		 * As we're issuing a retry, we need to negotiate some new
+		 * credits otherwise the server may reject the op with
+		 * INVALID_PARAMETER.  Note, however, we may get back less
+		 * credit than we need to complete the op, in which case, we
+		 * shorten the op and rely on additional rounds of retry.
+		 */
+		size_t rsize = umin(subreq->len - subreq->transferred,
+				    cifs_sb->ctx->rsize);
+
+		rc = server->ops->wait_mtu_credits(server, rsize, &rdata->actual_len,
+						   &rdata->credits);
+		if (rc)
+			goto out;
+
+		rdata->credits.in_flight_check = 1;
+
+		trace_smb3_rw_credits(rdata->rreq->debug_id,
+				      rdata->subreq.debug_index,
+				      rdata->credits.value,
+				      server->credits, server->in_flight, 0,
+				      cifs_trace_rw_credits_read_resubmit);
+	}
+
 	if (req->cfile->invalidHandle) {
 		do {
 			rc = cifs_reopen_file(req->cfile, true);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 322cabc69c6f..14c3d11869ba 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -301,7 +301,7 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 		    unsigned int /*enum smb3_rw_credits_trace*/ trace)
 {
 	struct cifs_credits *credits = &subreq->credits;
-	int new_val = DIV_ROUND_UP(subreq->subreq.len, SMB2_MAX_BUFFER_SIZE);
+	int new_val = DIV_ROUND_UP(subreq->actual_len, SMB2_MAX_BUFFER_SIZE);
 	int scredits, in_flight;
 
 	if (!credits->value || credits->value == new_val)
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 83facb54276a..d80107d1ba9e 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4530,9 +4530,9 @@ smb2_readv_callback(struct mid_q_entry *mid)
 		  "rdata server %p != mid server %p",
 		  rdata->server, mid->server);
 
-	cifs_dbg(FYI, "%s: mid=%llu state=%d result=%d bytes=%zu\n",
+	cifs_dbg(FYI, "%s: mid=%llu state=%d result=%d bytes=%zu/%zu\n",
 		 __func__, mid->mid, mid->mid_state, rdata->result,
-		 rdata->subreq.len);
+		 rdata->actual_len, rdata->subreq.len - rdata->subreq.transferred);
 
 	switch (mid->mid_state) {
 	case MID_RESPONSE_RECEIVED:
@@ -4586,15 +4586,18 @@ smb2_readv_callback(struct mid_q_entry *mid)
 				    rdata->subreq.debug_index,
 				    rdata->xid,
 				    rdata->req->cfile->fid.persistent_fid,
-				    tcon->tid, tcon->ses->Suid, rdata->subreq.start,
-				    rdata->subreq.len, rdata->result);
+				    tcon->tid, tcon->ses->Suid,
+				    rdata->subreq.start + rdata->subreq.transferred,
+				    rdata->actual_len,
+				    rdata->result);
 	} else
 		trace_smb3_read_done(rdata->rreq->debug_id,
 				     rdata->subreq.debug_index,
 				     rdata->xid,
 				     rdata->req->cfile->fid.persistent_fid,
 				     tcon->tid, tcon->ses->Suid,
-				     rdata->subreq.start, rdata->got_bytes);
+				     rdata->subreq.start + rdata->subreq.transferred,
+				     rdata->got_bytes);
 
 	if (rdata->result == -ENODATA) {
 		/* We may have got an EOF error because fallocate
@@ -4622,6 +4625,7 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 {
 	int rc, flags = 0;
 	char *buf;
+	struct netfs_io_subrequest *subreq = &rdata->subreq;
 	struct smb2_hdr *shdr;
 	struct cifs_io_parms io_parms;
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
@@ -4632,15 +4636,15 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 	int credit_request;
 
 	cifs_dbg(FYI, "%s: offset=%llu bytes=%zu\n",
-		 __func__, rdata->subreq.start, rdata->subreq.len);
+		 __func__, subreq->start, subreq->len);
 
 	if (!rdata->server)
 		rdata->server = cifs_pick_channel(tcon->ses);
 
 	io_parms.tcon = tlink_tcon(rdata->req->cfile->tlink);
 	io_parms.server = server = rdata->server;
-	io_parms.offset = rdata->subreq.start;
-	io_parms.length = rdata->subreq.len;
+	io_parms.offset = subreq->start + subreq->transferred;
+	io_parms.length = rdata->actual_len;
 	io_parms.persistent_fid = rdata->req->cfile->fid.persistent_fid;
 	io_parms.volatile_fid = rdata->req->cfile->fid.volatile_fid;
 	io_parms.pid = rdata->req->pid;
@@ -4655,11 +4659,13 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 
 	rdata->iov[0].iov_base = buf;
 	rdata->iov[0].iov_len = total_len;
+	rdata->got_bytes = 0;
+	rdata->result = 0;
 
 	shdr = (struct smb2_hdr *)buf;
 
 	if (rdata->credits.value > 0) {
-		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(rdata->subreq.len,
+		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(rdata->actual_len,
 						SMB2_MAX_BUFFER_SIZE));
 		credit_request = le16_to_cpu(shdr->CreditCharge) + 8;
 		if (server->credits >= server->max_credits)
@@ -4683,11 +4689,11 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 	if (rc) {
 		cifs_stats_fail_inc(io_parms.tcon, SMB2_READ_HE);
 		trace_smb3_read_err(rdata->rreq->debug_id,
-				    rdata->subreq.debug_index,
+				    subreq->debug_index,
 				    rdata->xid, io_parms.persistent_fid,
 				    io_parms.tcon->tid,
 				    io_parms.tcon->ses->Suid,
-				    io_parms.offset, io_parms.length, rc);
+				    io_parms.offset, rdata->actual_len, rc);
 	}
 
 async_readv_out:
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 0f0c10c7ada7..8e9964001e2a 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -30,6 +30,7 @@
 	EM(cifs_trace_rw_credits_old_session,		"old-session") \
 	EM(cifs_trace_rw_credits_read_response_add,	"rd-resp-add") \
 	EM(cifs_trace_rw_credits_read_response_clear,	"rd-resp-clr") \
+	EM(cifs_trace_rw_credits_read_resubmit,		"rd-resubmit") \
 	EM(cifs_trace_rw_credits_read_submit,		"rd-submit  ") \
 	EM(cifs_trace_rw_credits_write_prepare,		"wr-prepare ") \
 	EM(cifs_trace_rw_credits_write_response_add,	"wr-resp-add") \

