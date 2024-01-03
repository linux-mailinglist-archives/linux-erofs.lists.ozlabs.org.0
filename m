Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE5F82300C
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 16:00:32 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WlvIIMQY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WlvIIMQY;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4tF96G9Dz3btZ
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jan 2024 02:00:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WlvIIMQY;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WlvIIMQY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T4tDy68pKz3bsd
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Jan 2024 02:00:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704294016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QMJZ+3lHeykV3WPSbajID2T4bzMyvXitF+gI+XPTjU=;
	b=WlvIIMQY0Jc70EjRsDm3sWLi9Edks09+k12WzFYdIz6MkmSMAgYdFppVcZRRiyAzDO98EQ
	L/V8725gWJnJeFp2y9pu1q9Mb9X/v9G5vy5rOvpLAQJGWVr2OK9lknruEOsifKbioInJZI
	Yr3skH16iF4m2ohBfQZVaZE0keA3Hxw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704294016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QMJZ+3lHeykV3WPSbajID2T4bzMyvXitF+gI+XPTjU=;
	b=WlvIIMQY0Jc70EjRsDm3sWLi9Edks09+k12WzFYdIz6MkmSMAgYdFppVcZRRiyAzDO98EQ
	L/V8725gWJnJeFp2y9pu1q9Mb9X/v9G5vy5rOvpLAQJGWVr2OK9lknruEOsifKbioInJZI
	Yr3skH16iF4m2ohBfQZVaZE0keA3Hxw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-aceTF6bhNCidJMmyrfkt8A-1; Wed,
 03 Jan 2024 10:00:12 -0500
X-MC-Unique: aceTF6bhNCidJMmyrfkt8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AA321E441CA;
	Wed,  3 Jan 2024 15:00:10 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1A2D21121306;
	Wed,  3 Jan 2024 15:00:06 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 5/5] 9p: Use length of data written to the server in preference to error
Date: Wed,  3 Jan 2024 14:59:29 +0000
Message-ID: <20240103145935.384404-6-dhowells@redhat.com>
In-Reply-To: <20240103145935.384404-1-dhowells@redhat.com>
References: <20240103145935.384404-1-dhowells@redhat.com>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In v9fs_upload_to_server(), we pass the error to netfslib to terminate the
subreq rather than the amount of data written - even if we did actually
write something.

Further, we assume that the write is always entirely done if successful -
but it might have been partially complete - as returned by
p9_client_write(), but we ignore that.

Fix this by indicating the amount written by preference and only returning
the error if we didn't write anything.

(We might want to return both in future if both are available as this
might be useful as to whether we retry or not.)

Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
Link: https://lore.kernel.org/r/ZZULNQAZ0n0WQv7p@codewreck.org/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index f7f83eec3bcc..047855033d32 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -29,12 +29,11 @@
 static void v9fs_upload_to_server(struct netfs_io_subrequest *subreq)
 {
 	struct p9_fid *fid = subreq->rreq->netfs_priv;
-	int err;
+	int err, len;
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-	p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
-	netfs_write_subrequest_terminated(subreq, err < 0 ? err : subreq->len,
-					  false);
+	len = p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
+	netfs_write_subrequest_terminated(subreq, len ?: err, false);
 }
 
 static void v9fs_upload_to_server_worker(struct work_struct *work)

