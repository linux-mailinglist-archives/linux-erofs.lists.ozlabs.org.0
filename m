Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E30890569
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Mar 2024 17:36:52 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H0/cCt4Y;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H0/cCt4Y;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V58M62BrLz3vXp
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Mar 2024 03:36:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H0/cCt4Y;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H0/cCt4Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V58M23LTnz3vbj
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 Mar 2024 03:36:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SL4EWbx4NBAGR5Ppiq2v7C/YTDepZ3O+7v26rOrM0n0=;
	b=H0/cCt4YWdSSj/e1tZZy+ODn7qJv0xmEhZH/Ab+YdR4yYJ4bIaiHgfTEaMH881WtKbg+EE
	sKaftgCY/wTk1KE9bVLG1X4E0mEDuWIDli7HiXqAX93Zu0BOikrX9q8t8iJ+GzWsfEmB4F
	YUv5x/2uaUc9HUW3GmdI6GdKYMNvsXY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SL4EWbx4NBAGR5Ppiq2v7C/YTDepZ3O+7v26rOrM0n0=;
	b=H0/cCt4YWdSSj/e1tZZy+ODn7qJv0xmEhZH/Ab+YdR4yYJ4bIaiHgfTEaMH881WtKbg+EE
	sKaftgCY/wTk1KE9bVLG1X4E0mEDuWIDli7HiXqAX93Zu0BOikrX9q8t8iJ+GzWsfEmB4F
	YUv5x/2uaUc9HUW3GmdI6GdKYMNvsXY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-ChXRkUr0OMqFZ7Fb17h45A-1; Thu, 28 Mar 2024 12:36:39 -0400
X-MC-Unique: ChXRkUr0OMqFZ7Fb17h45A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4165985A58C;
	Thu, 28 Mar 2024 16:36:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3C6FA111F3C6;
	Thu, 28 Mar 2024 16:36:31 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 08/26] netfs: Use subreq_counter to allocate subreq debug_index values
Date: Thu, 28 Mar 2024 16:34:00 +0000
Message-ID: <20240328163424.2781320-9-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, linux-mm@kvack.org, netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use the subreq_counter in netfs_io_request to allocate subrequest
debug_index values in read ops as well as write ops.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/io.c      | 7 ++-----
 fs/netfs/objects.c | 1 +
 fs/netfs/output.c  | 1 -
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 2641238aae82..8de581ac0cfb 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -501,8 +501,7 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq,
  * Slice off a piece of a read request and submit an I/O request for it.
  */
 static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
-				    struct iov_iter *io_iter,
-				    unsigned int *_debug_index)
+				    struct iov_iter *io_iter)
 {
 	struct netfs_io_subrequest *subreq;
 	enum netfs_io_source source;
@@ -511,7 +510,6 @@ static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
 	if (!subreq)
 		return false;
 
-	subreq->debug_index	= (*_debug_index)++;
 	subreq->start		= rreq->start + rreq->submitted;
 	subreq->len		= io_iter->count;
 
@@ -565,7 +563,6 @@ static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
 int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 {
 	struct iov_iter io_iter;
-	unsigned int debug_index = 0;
 	int ret;
 
 	_enter("R=%x %llx-%llx",
@@ -596,7 +593,7 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 		if (rreq->origin == NETFS_DIO_READ &&
 		    rreq->start + rreq->submitted >= rreq->i_size)
 			break;
-		if (!netfs_rreq_submit_slice(rreq, &io_iter, &debug_index))
+		if (!netfs_rreq_submit_slice(rreq, &io_iter))
 			break;
 		if (test_bit(NETFS_RREQ_BLOCKED, &rreq->flags) &&
 		    test_bit(NETFS_RREQ_NONBLOCK, &rreq->flags))
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 72b52f070270..8acc03a64059 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -152,6 +152,7 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq
 		INIT_LIST_HEAD(&subreq->rreq_link);
 		refcount_set(&subreq->ref, 2);
 		subreq->rreq = rreq;
+		subreq->debug_index = atomic_inc_return(&rreq->subreq_counter);
 		netfs_get_request(rreq, netfs_rreq_trace_get_subreq);
 		netfs_stat(&netfs_n_rh_sreq);
 	}
diff --git a/fs/netfs/output.c b/fs/netfs/output.c
index fbdbb4f78234..e586396d6b72 100644
--- a/fs/netfs/output.c
+++ b/fs/netfs/output.c
@@ -37,7 +37,6 @@ struct netfs_io_subrequest *netfs_create_write_request(struct netfs_io_request *
 		subreq->source	= dest;
 		subreq->start	= start;
 		subreq->len	= len;
-		subreq->debug_index = atomic_inc_return(&wreq->subreq_counter);
 
 		switch (subreq->source) {
 		case NETFS_UPLOAD_TO_SERVER:

