Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBAE95D717
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 22:09:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WrB4144mjz305j
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 06:09:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724443760;
	cv=none; b=lGXfLapmYu41FmmkZB5Fs9H/zSXwZu7+rUawJDz6ntBnNtAeksKJcp/tM2A2lKirFySUeMjGiGsNIVq/ugj6JjSUrroC0UWCNPoxrEgj+CJKCOukErisRt6YHhJ1CH80PkKZYR9AHYjYj9iwGTrtuS/rScyZTitLsf/2v2KPtP77JzFU5Sk0ppdnqpAECBu+HK7JlBjApKBYTK5HEZ+3IJy/u5mX7DX9a1XtYHK0sqaKu6X2mYaMiociR7YOWkioB43AYqPJvsP2qiqqKhcUkdBhJI2moULvgrCBBwHjR37TFPR1Yq5RYmNZ//sEuLLpnIIw3Sra8P3jVxmt7oj8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724443760; c=relaxed/relaxed;
	bh=QRzYATgp/3eeTZkiFzTxq5j7styCnaCIZoOTDKL0BZk=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Scanned-By; b=nqwCFSsmNJjhiIcWxvcOl/D0VyYTizr7kISmuNqHlYXa7hBukdHsD2QolpPUDNCB7/JYHkRiilyI1QO19Guz3wvz4xOSMqjM9VvuG9a/f6GDSu39l79WK/sGGrVCDtVFx20hPPim5p6ngBcF3Od659tTBJGj8EwTE36f1/6SzMEDb7x7CfmeWyK/bh1WljJn4xY9hEBPpAXzgDSq2Vm+qfcdpYVTpeKTjdgNrsCt2U8SkMbYtyxVNtkctJ9Uu4bFxt/DhTl057XRka3ThQiGJ5+CCKP73mfRMhFsxVc7HKcLIPOKvpHx3XqxC5I+pSiKRlQVoChyMqM329YjNVvBfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LVc9KgCd; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LVc9KgCd; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LVc9KgCd;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LVc9KgCd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WrB3z49v0z2x9T
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2024 06:09:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRzYATgp/3eeTZkiFzTxq5j7styCnaCIZoOTDKL0BZk=;
	b=LVc9KgCdGpXldQyKHvyZ13WT/jtdEdDwSHpNuJEADwSubsgkwvhP7GEoce6a87H+2ouMPb
	EWF2feecM5h1kgblTPT2olWr1Bwmu2We9WM0hVe38+ywlonhyGGNCtjBNcVgs7XCP+7scW
	iY81eutvjLNF5UV/fJUnSZ34akvy85Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRzYATgp/3eeTZkiFzTxq5j7styCnaCIZoOTDKL0BZk=;
	b=LVc9KgCdGpXldQyKHvyZ13WT/jtdEdDwSHpNuJEADwSubsgkwvhP7GEoce6a87H+2ouMPb
	EWF2feecM5h1kgblTPT2olWr1Bwmu2We9WM0hVe38+ywlonhyGGNCtjBNcVgs7XCP+7scW
	iY81eutvjLNF5UV/fJUnSZ34akvy85Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146--Hm1Ra-bNfy8Awu75_bZog-1; Fri,
 23 Aug 2024 16:09:13 -0400
X-MC-Unique: -Hm1Ra-bNfy8Awu75_bZog-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE8F51955BF7;
	Fri, 23 Aug 2024 20:09:10 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76A741954B3E;
	Fri, 23 Aug 2024 20:09:06 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 7/9] netfs, cifs: Fix handling of short DIO read
Date: Fri, 23 Aug 2024 21:08:15 +0100
Message-ID: <20240823200819.532106-8-dhowells@redhat.com>
In-Reply-To: <20240823200819.532106-1-dhowells@redhat.com>
References: <20240823200819.532106-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Short DIO reads, particularly in relation to cifs, are not being handled
correctly by cifs and netfslib.  This can be tested by doing a DIO read of
a file where the size of read is larger than the size of the file.  When it
crosses the EOF, it gets a short read and this gets retried, and in the
case of cifs, the retry read fails, with the failure being translated to
ENODATA.

Fix this by the following means:

 (1) Add a flag, NETFS_SREQ_HIT_EOF, for the filesystem to set when it
     detects that the read did hit the EOF.

 (2) Make the netfslib read assessment stop processing subrequests when it
     encounters one with that flag set.

 (3) Return rreq->transferred, the accumulated contiguous amount read to
     that point, to userspace for a DIO read.

 (4) Make cifs set the flag and clear the error if the read RPC returned
     ENODATA.

 (5) Make cifs set the flag and clear the error if a short read occurred
     without error and the read-to file position is now at the remote inode
     size.

Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20240822220650.318774-3-dhowells@redhat.com
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/netfs/io.c           | 17 +++++++++++------
 fs/smb/client/smb2pdu.c | 13 +++++++++----
 include/linux/netfs.h   |  1 +
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 3303b515b536..943128507af5 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -368,7 +368,8 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 		if (subreq->error || subreq->transferred == 0)
 			break;
 		transferred += subreq->transferred;
-		if (subreq->transferred < subreq->len)
+		if (subreq->transferred < subreq->len ||
+		    test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags))
 			break;
 	}
 
@@ -503,7 +504,8 @@ void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
 
 	subreq->error = 0;
 	subreq->transferred += transferred_or_error;
-	if (subreq->transferred < subreq->len)
+	if (subreq->transferred < subreq->len &&
+	    !test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags))
 		goto incomplete;
 
 complete:
@@ -782,10 +784,13 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 			    TASK_UNINTERRUPTIBLE);
 
 		ret = rreq->error;
-		if (ret == 0 && rreq->submitted < rreq->len &&
-		    rreq->origin != NETFS_DIO_READ) {
-			trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
-			ret = -EIO;
+		if (ret == 0) {
+			if (rreq->origin == NETFS_DIO_READ) {
+				ret = rreq->transferred;
+			} else if (rreq->submitted < rreq->len) {
+				trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
+				ret = -EIO;
+			}
 		}
 	} else {
 		/* If we decrement nr_outstanding to 0, the ref belongs to us. */
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index d80107d1ba9e..9829784e8ec5 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4507,6 +4507,7 @@ static void
 smb2_readv_callback(struct mid_q_entry *mid)
 {
 	struct cifs_io_subrequest *rdata = mid->callback_data;
+	struct netfs_inode *ictx = netfs_inode(rdata->rreq->inode);
 	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	struct TCP_Server_Info *server = rdata->server;
 	struct smb2_hdr *shdr =
@@ -4600,11 +4601,15 @@ smb2_readv_callback(struct mid_q_entry *mid)
 				     rdata->got_bytes);
 
 	if (rdata->result == -ENODATA) {
-		/* We may have got an EOF error because fallocate
-		 * failed to enlarge the file.
-		 */
-		if (rdata->subreq.start < rdata->subreq.rreq->i_size)
+		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
+		rdata->result = 0;
+	} else {
+		if (rdata->got_bytes < rdata->actual_len &&
+		    rdata->subreq.start + rdata->subreq.transferred + rdata->got_bytes ==
+		    ictx->remote_i_size) {
+			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 			rdata->result = 0;
+		}
 	}
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, rdata->credits.value,
 			      server->credits, server->in_flight,
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 983816608f15..c47443e7a97e 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -198,6 +198,7 @@ struct netfs_io_subrequest {
 #define NETFS_SREQ_NEED_RETRY		9	/* Set if the filesystem requests a retry */
 #define NETFS_SREQ_RETRYING		10	/* Set if we're retrying */
 #define NETFS_SREQ_FAILED		11	/* Set if the subreq failed unretryably */
+#define NETFS_SREQ_HIT_EOF		12	/* Set if we hit the EOF */
 };
 
 enum netfs_io_origin {

