Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC2F97EDAE
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 17:09:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XC5xP36yhz2yVX
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 01:09:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727104151;
	cv=none; b=cKAW8tGq6sdOJqYgvUTgS+hfkoXimz6IPbP/jujQbO1qAWGDu5jHYxqVZryd5oH+xy5q5O9EmW5BZg+87cVXLJxGtNSNN9/b8SQWddv/Q6BneNWZWBiOL7DQNneevWLq27epk+S5N3vYQcemwcGoBk2LAcMf2nrTO40Z30TB7kG1evViAELPHa+3JHkJeKf9pm/s/qKpFnbdZuzhS4ER4woZX4UNgaL3IQSR5a/KQK8+Hs4EUcwj2iC7Whr/F3J6japVyN+ko/i+lMF+xOVbgHbw4R+FFYmUGo+mOdOKpNFCEa94rLf17hRaZkeeSWHla5PHLctDzk6tMBPVXOLEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727104151; c=relaxed/relaxed;
	bh=h43zAABX1+Y84szWbuf6Y3zUUIJDGkYGOYZIeY5MUOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfHDUBJpuuZ2VQS35/NTC5ZAwzYRIvpsSrb5bOIvq9BzICxDF01MqRTdKJHVcWTNusU1AnOQRlFMw1C/QQN+R/A6FuEeW+WmVNuR8tT/q2Oh3MTa6gO3NSTPDW6kjPBSnpE+ubq/WH3WBzjIusYsY5+z/aoGTjCqSTHsninBlcADuFVo+qDA2BdI9MUgzSV0rG4emYAEbVszcNr49qgGwmarmbeE+vuewErhV8JxjtLVm3zoWu8f0iWf/kdHxxm04SsEdzIscBdthkWcp7tZeoauSzO4rAOy4cPi/h8dps5n+9T2cKR0ErjkzrxyrRK3VWJiUgmJhK/RI5m7dFPxWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RRmE80p3; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RRmE80p3; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RRmE80p3;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RRmE80p3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XC5xL6rx8z2xb9
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 01:09:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h43zAABX1+Y84szWbuf6Y3zUUIJDGkYGOYZIeY5MUOA=;
	b=RRmE80p33NIU7tSwXen16MpXTd3K1+3ItexiPwRipm3oW42BpwMoMHC31wpyOsla3EzzR6
	1evdtBCxrx1FrHizBVl+218gR4fXSy048BxSpjYB4cNeocO0ipe/4hjJMfBUuhHL3r68uO
	3Rtw5KHw9QlcJclFrejd9GVZpaU8MoE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h43zAABX1+Y84szWbuf6Y3zUUIJDGkYGOYZIeY5MUOA=;
	b=RRmE80p33NIU7tSwXen16MpXTd3K1+3ItexiPwRipm3oW42BpwMoMHC31wpyOsla3EzzR6
	1evdtBCxrx1FrHizBVl+218gR4fXSy048BxSpjYB4cNeocO0ipe/4hjJMfBUuhHL3r68uO
	3Rtw5KHw9QlcJclFrejd9GVZpaU8MoE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-iresh_brOiyWhufnlrfLWA-1; Mon,
 23 Sep 2024 11:09:02 -0400
X-MC-Unique: iresh_brOiyWhufnlrfLWA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0E2718BC2C9;
	Mon, 23 Sep 2024 15:08:52 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.145])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B0E21955D87;
	Mon, 23 Sep 2024 15:08:48 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH 8/8] cifs: Make the write_{enter,done,err} tracepoints display netfs info
Date: Mon, 23 Sep 2024 16:07:52 +0100
Message-ID: <20240923150756.902363-9-dhowells@redhat.com>
In-Reply-To: <20240923150756.902363-1-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com>
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
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Steve French <stfrench@microsoft.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Make the write RPC tracepoints use the same trace macro complexes as the
read tracepoints and display the netfs request and subrequest IDs where
available (see commit 519be989717c ("cifs: Add a tracepoint to track
credits involved in R/W requests")).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2pdu.c | 22 +++++++++++++++-------
 fs/smb/client/trace.h   |  6 +++---
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 0b63608aeecb..9afc3baba27b 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4858,7 +4858,9 @@ smb2_writev_callback(struct mid_q_entry *mid)
 #endif
 	if (result) {
 		cifs_stats_fail_inc(tcon, SMB2_WRITE_HE);
-		trace_smb3_write_err(wdata->xid,
+		trace_smb3_write_err(wdata->rreq->debug_id,
+				     wdata->subreq.debug_index,
+				     wdata->xid,
 				     wdata->req->cfile->fid.persistent_fid,
 				     tcon->tid, tcon->ses->Suid, wdata->subreq.start,
 				     wdata->subreq.len, wdata->result);
@@ -4866,7 +4868,9 @@ smb2_writev_callback(struct mid_q_entry *mid)
 			pr_warn_once("Out of space writing to %s\n",
 				     tcon->tree_name);
 	} else
-		trace_smb3_write_done(0 /* no xid */,
+		trace_smb3_write_done(wdata->rreq->debug_id,
+				      wdata->subreq.debug_index,
+				      wdata->xid,
 				      wdata->req->cfile->fid.persistent_fid,
 				      tcon->tid, tcon->ses->Suid,
 				      wdata->subreq.start, wdata->subreq.len);
@@ -4944,7 +4948,9 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 				offsetof(struct smb2_write_req, Buffer));
 	req->RemainingBytes = 0;
 
-	trace_smb3_write_enter(wdata->xid,
+	trace_smb3_write_enter(wdata->rreq->debug_id,
+			       wdata->subreq.debug_index,
+			       wdata->xid,
 			       io_parms->persistent_fid,
 			       io_parms->tcon->tid,
 			       io_parms->tcon->ses->Suid,
@@ -5024,7 +5030,9 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 			     wdata, flags, &wdata->credits);
 	/* Can't touch wdata if rc == 0 */
 	if (rc) {
-		trace_smb3_write_err(xid,
+		trace_smb3_write_err(wdata->rreq->debug_id,
+				     wdata->subreq.debug_index,
+				     xid,
 				     io_parms->persistent_fid,
 				     io_parms->tcon->tid,
 				     io_parms->tcon->ses->Suid,
@@ -5104,7 +5112,7 @@ SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
 				offsetof(struct smb2_write_req, Buffer));
 	req->RemainingBytes = 0;
 
-	trace_smb3_write_enter(xid, io_parms->persistent_fid,
+	trace_smb3_write_enter(0, 0, xid, io_parms->persistent_fid,
 		io_parms->tcon->tid, io_parms->tcon->ses->Suid,
 		io_parms->offset, io_parms->length);
 
@@ -5125,7 +5133,7 @@ SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
 	rsp = (struct smb2_write_rsp *)rsp_iov.iov_base;
 
 	if (rc) {
-		trace_smb3_write_err(xid,
+		trace_smb3_write_err(0, 0, xid,
 				     req->PersistentFileId,
 				     io_parms->tcon->tid,
 				     io_parms->tcon->ses->Suid,
@@ -5134,7 +5142,7 @@ SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
 		cifs_dbg(VFS, "Send error in write = %d\n", rc);
 	} else {
 		*nbytes = le32_to_cpu(rsp->DataLength);
-		trace_smb3_write_done(xid,
+		trace_smb3_write_done(0, 0, xid,
 				      req->PersistentFileId,
 				      io_parms->tcon->tid,
 				      io_parms->tcon->ses->Suid,
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 8e9964001e2a..0b52d22a91a0 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -157,6 +157,7 @@ DEFINE_EVENT(smb3_rw_err_class, smb3_##name,    \
 	TP_ARGS(rreq_debug_id, rreq_debug_index, xid, fid, tid, sesid, offset, len, rc))
 
 DEFINE_SMB3_RW_ERR_EVENT(read_err);
+DEFINE_SMB3_RW_ERR_EVENT(write_err);
 
 /* For logging errors in other file I/O ops */
 DECLARE_EVENT_CLASS(smb3_other_err_class,
@@ -202,7 +203,6 @@ DEFINE_EVENT(smb3_other_err_class, smb3_##name, \
 		int	rc),			\
 	TP_ARGS(xid, fid, tid, sesid, offset, len, rc))
 
-DEFINE_SMB3_OTHER_ERR_EVENT(write_err);
 DEFINE_SMB3_OTHER_ERR_EVENT(query_dir_err);
 DEFINE_SMB3_OTHER_ERR_EVENT(zero_err);
 DEFINE_SMB3_OTHER_ERR_EVENT(falloc_err);
@@ -370,6 +370,8 @@ DEFINE_EVENT(smb3_rw_done_class, smb3_##name,   \
 
 DEFINE_SMB3_RW_DONE_EVENT(read_enter);
 DEFINE_SMB3_RW_DONE_EVENT(read_done);
+DEFINE_SMB3_RW_DONE_EVENT(write_enter);
+DEFINE_SMB3_RW_DONE_EVENT(write_done);
 
 /* For logging successful other op */
 DECLARE_EVENT_CLASS(smb3_other_done_class,
@@ -411,11 +413,9 @@ DEFINE_EVENT(smb3_other_done_class, smb3_##name,   \
 		__u32	len),			\
 	TP_ARGS(xid, fid, tid, sesid, offset, len))
 
-DEFINE_SMB3_OTHER_DONE_EVENT(write_enter);
 DEFINE_SMB3_OTHER_DONE_EVENT(query_dir_enter);
 DEFINE_SMB3_OTHER_DONE_EVENT(zero_enter);
 DEFINE_SMB3_OTHER_DONE_EVENT(falloc_enter);
-DEFINE_SMB3_OTHER_DONE_EVENT(write_done);
 DEFINE_SMB3_OTHER_DONE_EVENT(query_dir_done);
 DEFINE_SMB3_OTHER_DONE_EVENT(zero_done);
 DEFINE_SMB3_OTHER_DONE_EVENT(falloc_done);

