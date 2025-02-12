Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C46A33272
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 23:24:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YtXtS2Vd2z30Vr
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Feb 2025 09:24:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739399086;
	cv=none; b=UgdvzUe4JJIc2DqgfoCNbDP/xZF/i39d6q+WgJGmS8f5RSr9jSI1S6f9H9nFxPQ3pMRfG9yehBo9bstypGCNI+WbGRnTv0rY+IzS9SdJgq91YcNChhQVSpAOgk4zKeCmTMJTkxnMC2bLjRYWsCAtZpTtGDZIRS43gqUGJzcDqcY+yJ2LeUBzmr3jREm2cDy3YAfRyviy2M0b35vxGKPmZfCeiJHN/Jg56lrHQI2Iz381GXqgphyIUVRHZ1USefa53DEO4DtWQKJMSx+BWOG935FwCDchmG2F9SGWKNCzfKp5UjUX21IQrEgXEGkk+hnV1B0eupgT2nV7ZxBjmqJWiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739399086; c=relaxed/relaxed;
	bh=EHAXmEebuXfGaW+Cbp856q5t3oORgVUeZdmoxZNWAV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdNgnd2i53Hbg22qB7PVBzYJh3ZbK6yfN27b0D3vZqehcFKGVKzenzRrk1f3ynkHP42Pve8ODZFuoVk8v0A68xcc7n9RWZmn75x3CmvHlwo5LpFL1WxWDW66aYh1aO9zBmGMmIus7iIo7lMaDCcWhyluznpkaSPFBDfK5Yd2sJJ2tH9K0q4eVYTzcn6VaZ43rjzZ/nJipvrpyqJIrYZVs5SgQ368kQ008DCE8UKBHo4/35c96xDDkRi2kdKCH9eFBFkRftG7qxp6Hy0Xf8WD3DosxznbRTTbSFzXZADElgaSePfaqEfZ0Pg/bITH7fM1/oS33sEa50QfH0gIQyP+Cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g85hxtSl; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g85hxtSl; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g85hxtSl;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g85hxtSl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtXtP75CHz307V
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Feb 2025 09:24:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739399083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHAXmEebuXfGaW+Cbp856q5t3oORgVUeZdmoxZNWAV4=;
	b=g85hxtSlLAmGhyh28+aEt4Hs1NQ8ZNnAr+gJeHzW0sWyTB0+wUbtgIxnhPz3PRKyNxKhjU
	eJ1eDXBb8Tb+7/sfkUyb0mZ5UWfvdCHqEmABrzCt/KTsdibekiF2krqqIblo2ScsuoJJ4W
	oOLjrYXI64jdUt8AA+lgKV96/59umaA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739399083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHAXmEebuXfGaW+Cbp856q5t3oORgVUeZdmoxZNWAV4=;
	b=g85hxtSlLAmGhyh28+aEt4Hs1NQ8ZNnAr+gJeHzW0sWyTB0+wUbtgIxnhPz3PRKyNxKhjU
	eJ1eDXBb8Tb+7/sfkUyb0mZ5UWfvdCHqEmABrzCt/KTsdibekiF2krqqIblo2ScsuoJJ4W
	oOLjrYXI64jdUt8AA+lgKV96/59umaA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-0JhFd5MBMq-N6YBSpy5hVg-1; Wed,
 12 Feb 2025 17:24:40 -0500
X-MC-Unique: 0JhFd5MBMq-N6YBSpy5hVg-1
X-Mimecast-MFC-AGG-ID: 0JhFd5MBMq-N6YBSpy5hVg_1739399077
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B56B7195608B;
	Wed, 12 Feb 2025 22:24:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B79951955F21;
	Wed, 12 Feb 2025 22:24:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 3/3] netfs: Fix setting NETFS_RREQ_ALL_QUEUED to be after all subreqs queued
Date: Wed, 12 Feb 2025 22:24:01 +0000
Message-ID: <20250212222402.3618494-4-dhowells@redhat.com>
In-Reply-To: <20250212222402.3618494-1-dhowells@redhat.com>
References: <20250212222402.3618494-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, David Howells <dhowells@redhat.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, linux-mm@kvack.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, Ihor Solodrai <ihor.solodrai@pm.me>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, Steve French <stfrench@microsoft.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Due to the code that queues a subreq on the active subrequest list getting
moved to netfs_issue_read(), the NETFS_RREQ_ALL_QUEUED flag may now get set
before the list-add actually happens.  This is not a problem if the
collection worker happens after the list-add, but it's a race - and, for
9P, where the read from the server is synchronous and done in the
submitting thread, this is a lot more likely.

The result is that, if the timing is wrong, a ref gets leaked because the
collector thinks that all the subreqs have completed (because it can't see
the last one yet) and clears NETFS_RREQ_IN_PROGRESS - at which point, the
collection worker no longer goes into the collector.

This can be provoked with AFS by injecting an msleep() right before the
final subreq is queued.

Fix this by splitting the queuing part out of netfs_issue_read() into a new
function, netfs_queue_read(), and calling it separately.  The setting of
NETFS_RREQ_ALL_QUEUED is then done by netfs_queue_read() whilst it is
holding the spinlock (that's probably unnecessary, but shouldn't hurt).

It might be better to set a flag on the final subreq, but this could be a
problem if an error occurs and we can't queue it.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
Reported-by: Ihor Solodrai <ihor.solodrai@pm.me>
Closes: https://lore.kernel.org/r/a7x33d4dnMdGTtRivptq6S1i8btK70SNBP2XyX_xwDAhLvgQoPox6FVBOkifq4eBinfFfbZlIkMZBe3QarlWTxoEtHZwJCZbNKtaqrR7PvI=@pm.me/
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Steve French <stfrench@microsoft.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: v9fs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index f761d44b3436..0d1b6d35ff3b 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -155,8 +155,9 @@ static void netfs_read_cache_to_pagecache(struct netfs_io_request *rreq,
 			netfs_cache_read_terminated, subreq);
 }
 
-static void netfs_issue_read(struct netfs_io_request *rreq,
-			     struct netfs_io_subrequest *subreq)
+static void netfs_queue_read(struct netfs_io_request *rreq,
+			     struct netfs_io_subrequest *subreq,
+			     bool last_subreq)
 {
 	struct netfs_io_stream *stream = &rreq->io_streams[0];
 
@@ -177,8 +178,17 @@ static void netfs_issue_read(struct netfs_io_request *rreq,
 		}
 	}
 
+	if (last_subreq) {
+		smp_wmb(); /* Write lists before ALL_QUEUED. */
+		set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
+	}
+
 	spin_unlock(&rreq->lock);
+}
 
+static void netfs_issue_read(struct netfs_io_request *rreq,
+			     struct netfs_io_subrequest *subreq)
+{
 	switch (subreq->source) {
 	case NETFS_DOWNLOAD_FROM_SERVER:
 		rreq->netfs_ops->issue_read(subreq);
@@ -293,11 +303,8 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 		}
 		size -= slice;
 		start += slice;
-		if (size <= 0) {
-			smp_wmb(); /* Write lists before ALL_QUEUED. */
-			set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
-		}
 
+		netfs_queue_read(rreq, subreq, size <= 0);
 		netfs_issue_read(rreq, subreq);
 		cond_resched();
 	} while (size > 0);

