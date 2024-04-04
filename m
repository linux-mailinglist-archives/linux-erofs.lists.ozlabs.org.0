Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 963FD8982B5
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Apr 2024 10:02:07 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CIL+to1g;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IwJre/A/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V9Dbx2Yg7z3dX4
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Apr 2024 19:02:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CIL+to1g;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IwJre/A/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V9Dbp347cz3bZ3
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Apr 2024 19:01:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712217714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IE/xA/cazcP+HXhdhjRdwQDAS2gMvpTgfIxHPPrU41I=;
	b=CIL+to1gmcNj1kqDhAPreSw56HFHr1vnGL9xayGafuRWDQoXzWdESZyw+uRcktx2bVH0JY
	KYTWykiX0lXBxIHvLRemYFoq7LnPRhOjxVjzWNWmfHVfD5GOunPLlqgfRSoXZLydDffM97
	wdJBUr8UZ6m/aT80sU0NlbLrlgy35Lw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712217715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IE/xA/cazcP+HXhdhjRdwQDAS2gMvpTgfIxHPPrU41I=;
	b=IwJre/A/07Ql0EObJeocI/0TiXdDMGqUjm/SjyYg/ZMrzKhZhd4OffCw5ap7LjGWIj0un5
	WlXjYdBycfL/qtmzELFwGR1Mi7Fj13mhsqIfveDr60ORIloHbOBvohSigmC4l/9kXmQlbU
	vlMPn4ZgoX45bLyZqyGNe1ZoizFBCn4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-c0jY6rVYNYiCi_bmX-evYA-1; Thu,
 04 Apr 2024 04:01:52 -0400
X-MC-Unique: c0jY6rVYNYiCi_bmX-evYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BF723C02748;
	Thu,  4 Apr 2024 08:01:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DD1EAC1576F;
	Thu,  4 Apr 2024 08:01:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3655511.1712217111@warthog.procyon.org.uk>
References: <3655511.1712217111@warthog.procyon.org.uk> <20240328163424.2781320-22-dhowells@redhat.com> <20240328163424.2781320-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 21/26] netfs, 9p: Implement helpers for new write code
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3666290.1712217703.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Apr 2024 09:01:43 +0100
Message-ID: <3666291.1712217703@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, dhowells@redhat.com, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

David Howells <dhowells@redhat.com> wrote:

> > +	size_t len =3D subreq->len - subreq->transferred;
> =

> This actually needs to be 'int len' because of the varargs packet format=
ter.

I think the attached change is what's required.

David
---
diff --git a/net/9p/client.c b/net/9p/client.c
index 844aca4fe4d8..04af2a7bf54b 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1670,10 +1670,10 @@ p9_client_write_subreq(struct netfs_io_subrequest =
*subreq)
 	struct p9_client *clnt =3D fid->clnt;
 	struct p9_req_t *req;
 	unsigned long long start =3D subreq->start + subreq->transferred;
-	size_t len =3D subreq->len - subreq->transferred;
-	int written, err;
+	int written, len =3D subreq->len - subreq->transferred;
+	int err;
 =

-	p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu len %zd\n",
+	p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu len %d\n",
 		 fid->fid, start, len);
 =

 	/* Don't bother zerocopy for small IO (< 1024) */
@@ -1699,11 +1699,11 @@ p9_client_write_subreq(struct netfs_io_subrequest =
*subreq)
 	}
 =

 	if (written > len) {
-		pr_err("bogus RWRITE count (%d > %lu)\n", written, len);
+		pr_err("bogus RWRITE count (%d > %u)\n", written, len);
 		written =3D len;
 	}
 =

-	p9_debug(P9_DEBUG_9P, "<<< RWRITE count %zd\n", len);
+	p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", len);
 =

 	p9_req_put(clnt, req);
 	netfs_write_subrequest_terminated(subreq, written, false);

