Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E44E840214
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jan 2024 10:49:53 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UtIP4a3K;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UtIP4a3K;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TNk6l2FT0z3btl
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jan 2024 20:49:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UtIP4a3K;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UtIP4a3K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TNk6Y1CWdz3bZ3
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jan 2024 20:49:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706521776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRcl53v/D7LNYmHWLVDHFLzWMRLsRvElPDySPluG9Xk=;
	b=UtIP4a3K3gl07BS+AJ1VHn1V6u/wMwkpL8Ci+z3nn4lz2XMq1zazaa8bNMzeCqJBg8rQxS
	bGVVCMZfqvZsu1DZxYvq/6a65DJA5AZhuZ+uGcJpLB7p/dekRQg2NrxFx7cMjAJjqZzH/J
	W8bEbgfChYSg9W7kkhW2fYZO4KQio7w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706521776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRcl53v/D7LNYmHWLVDHFLzWMRLsRvElPDySPluG9Xk=;
	b=UtIP4a3K3gl07BS+AJ1VHn1V6u/wMwkpL8Ci+z3nn4lz2XMq1zazaa8bNMzeCqJBg8rQxS
	bGVVCMZfqvZsu1DZxYvq/6a65DJA5AZhuZ+uGcJpLB7p/dekRQg2NrxFx7cMjAJjqZzH/J
	W8bEbgfChYSg9W7kkhW2fYZO4KQio7w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-2MqNdY6VNp-CfaPkR9IzXg-1; Mon,
 29 Jan 2024 04:49:32 -0500
X-MC-Unique: 2MqNdY6VNp-CfaPkR9IzXg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0F563C2B606;
	Mon, 29 Jan 2024 09:49:31 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4EF73492BC7;
	Mon, 29 Jan 2024 09:49:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 1/2] netfs: Fix i_dio_count leak on DIO read past i_size
Date: Mon, 29 Jan 2024 09:49:18 +0000
Message-ID: <20240129094924.1221977-2-dhowells@redhat.com>
In-Reply-To: <20240129094924.1221977-1-dhowells@redhat.com>
References: <20240129094924.1221977-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Marc Dionne <marc.dionne@auristor.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Marc Dionne <marc.dionne@auristor.com>

If netfs_begin_read gets a NETFS_DIO_READ request that begins
past i_size, it won't perform any i/o and just return 0.  This
will leak an increment to i_dio_count that is done at the top
of the function.

This can cause subsequent buffered read requests to block
indefinitely, waiting for a non existing dio operation to complete.

Add a inode_dio_end() for the NETFS_DIO_READ case, before returning.

Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index e8ff1e61ce79..4261ad6c55b6 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -748,6 +748,8 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 
 	if (!rreq->submitted) {
 		netfs_put_request(rreq, false, netfs_rreq_trace_put_no_submit);
+		if (rreq->origin == NETFS_DIO_READ)
+			inode_dio_end(rreq->inode);
 		ret = 0;
 		goto out;
 	}

