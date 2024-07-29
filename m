Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF6193FA8D
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2024 18:21:44 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EQUQrYPx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EQUQrYPx;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WXkBt568Dz3cdV
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jul 2024 02:21:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EQUQrYPx;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EQUQrYPx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WXkBp2MxXz2y8Z
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jul 2024 02:21:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPT79eRMO93ZrwuayO/GcRsT7PMF2J9kIs2W0R0Ojik=;
	b=EQUQrYPxH7HnG3Y+vkhbr0T5sj3DawoHm2h9vYCW1PbNfxatfZhqwaujj390J5ol6ayG5M
	0m/4sJ9JvQqQ1HOBfEPYMk6mv9p11PSEoMsjXNuUoTlhPEV8lqCFkFFNvNbsSgmlKrN8eY
	G+yH01wvqFBivKlWDcDSpBkX+MKtCbw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPT79eRMO93ZrwuayO/GcRsT7PMF2J9kIs2W0R0Ojik=;
	b=EQUQrYPxH7HnG3Y+vkhbr0T5sj3DawoHm2h9vYCW1PbNfxatfZhqwaujj390J5ol6ayG5M
	0m/4sJ9JvQqQ1HOBfEPYMk6mv9p11PSEoMsjXNuUoTlhPEV8lqCFkFFNvNbsSgmlKrN8eY
	G+yH01wvqFBivKlWDcDSpBkX+MKtCbw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-1Lo1BiuPMUe_TUHCooMZgA-1; Mon,
 29 Jul 2024 12:21:32 -0400
X-MC-Unique: 1Lo1BiuPMUe_TUHCooMZgA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0868F1955D52;
	Mon, 29 Jul 2024 16:21:29 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.216])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 436081955D45;
	Mon, 29 Jul 2024 16:21:23 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 10/24] netfs: Set the request work function upon allocation
Date: Mon, 29 Jul 2024 17:19:39 +0100
Message-ID: <20240729162002.3436763-11-dhowells@redhat.com>
In-Reply-To: <20240729162002.3436763-1-dhowells@redhat.com>
References: <20240729162002.3436763-1-dhowells@redhat.com>
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-mm@kvack.org, netfs@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Set the work function in the netfs_io_request work_struct when we allocate
the request rather than doing this later.  This reduces the number of
places we need to set it in future code.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/internal.h    | 1 +
 fs/netfs/io.c          | 4 +---
 fs/netfs/objects.c     | 9 ++++++++-
 fs/netfs/write_issue.c | 1 -
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 9e6e0e59d7e4..f2920b4ee726 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -29,6 +29,7 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 /*
  * io.c
  */
+void netfs_rreq_work(struct work_struct *work);
 int netfs_begin_read(struct netfs_io_request *rreq, bool sync);
 
 /*
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 27dbea0f3867..874bbf2386a4 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -278,7 +278,7 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
 	netfs_rreq_completed(rreq, was_async);
 }
 
-static void netfs_rreq_work(struct work_struct *work)
+void netfs_rreq_work(struct work_struct *work)
 {
 	struct netfs_io_request *rreq =
 		container_of(work, struct netfs_io_request, work);
@@ -584,8 +584,6 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 	// TODO: Use bounce buffer if requested
 	rreq->io_iter = rreq->iter;
 
-	INIT_WORK(&rreq->work, netfs_rreq_work);
-
 	/* Chop the read into slices according to what the cache and the netfs
 	 * want and submit each one.
 	 */
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index f4a642727479..1dbcd7f44eca 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -52,9 +52,16 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	INIT_LIST_HEAD(&rreq->io_streams[0].subrequests);
 	INIT_LIST_HEAD(&rreq->io_streams[1].subrequests);
 	INIT_LIST_HEAD(&rreq->subrequests);
-	INIT_WORK(&rreq->work, NULL);
 	refcount_set(&rreq->ref, 1);
 
+	if (origin == NETFS_READAHEAD ||
+	    origin == NETFS_READPAGE ||
+	    origin == NETFS_READ_FOR_WRITE ||
+	    origin == NETFS_DIO_READ)
+		INIT_WORK(&rreq->work, netfs_rreq_work);
+	else
+		INIT_WORK(&rreq->work, netfs_write_collection_worker);
+
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 	if (cached) {
 		__set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 2f4f795124a8..6e835670dc58 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -107,7 +107,6 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 
 	wreq->contiguity = wreq->start;
 	wreq->cleaned_to = wreq->start;
-	INIT_WORK(&wreq->work, netfs_write_collection_worker);
 
 	wreq->io_streams[0].stream_nr		= 0;
 	wreq->io_streams[0].source		= NETFS_UPLOAD_TO_SERVER;

