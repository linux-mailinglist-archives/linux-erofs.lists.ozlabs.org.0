Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DFF9BE9E5
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 13:38:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xk4W84ls6z3bd4
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 23:38:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730896707;
	cv=none; b=g5e+3c1O/nZysjib5Qhd9/14X/oujrfuJrL1TnmYEyu7TdeG/EU+lCaSREuuEVRDRctl1IPQSbj+pVkvF+6FpteRTcBGu7tLdUY1OHgK2c2MbDwG5OLo4WQHx1+oHLJpkuIZXGbyX6cJxyRghGpNbtmPT5eNHyEtzUJvmONfunFmCiTTfh2KllnqEV03Fi4tDoJXefiEmKO/gN8X7uLgWexRXixKhQbzTfDFj9PO3j5cZRx9ssRT7MWieB23HwG7hMr/0beWqjwhJAX8pmisSh49LtwJqK8pHc40/iTNkO3eZAhbr6TLbio8ApvJPiprskYI3PYMOORrMnviWSmo1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730896707; c=relaxed/relaxed;
	bh=3kDl7vtgTz4UJLk1NBKECBmgzlrlbYChuV4j2ks8Pq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3VhAHL3BZJ1d2lYt0LWqtrS7Afyu3NKE+nEkPLhiI0q+sL5w8MfbTGiikSpTuKyDsXa3PT3O87P3QJUzTze5BCGIq+cjXawoaRqDjRn2UrHlIYVayPlqOUsa85yy8HnvPrxJKvSAVZ4xRkDpp6QRarM+fMiyqoy4QG60pS0T82lCeDZ2ge99/Z1yfT322UaJuvzzces2ojQNPZl6TzHKDUCVmPyi28fBjP2G845YzjOOnBHCx8Ay4byRPZynuvo61bn/0Wf3XiROkNDqpxmvtCqe3ud9/zINN9vEcHJ9E0Du4fD1RSAt4Qwc0g27M6TQrgAD9FeTRKc7CuuwCb+JQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ey7jRoSL; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ey7jRoSL; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ey7jRoSL;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ey7jRoSL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xk4W60V7dz2yfj
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Nov 2024 23:38:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3kDl7vtgTz4UJLk1NBKECBmgzlrlbYChuV4j2ks8Pq0=;
	b=ey7jRoSLaOMRzd5mwwtpS22nRmUtqqK9xn4Z882jJbVhfkVhObRtWuNZUcZmtNCQwZk6Kc
	LXkCwyAqCokWTX4j1h4tqeWBSVSYIPY2ZI+iq4JJuZAKGi9wFnY83M51HRku6fhq/3DRdh
	XCqURTupN/9CxtZFwx9nInMzsncGjvo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3kDl7vtgTz4UJLk1NBKECBmgzlrlbYChuV4j2ks8Pq0=;
	b=ey7jRoSLaOMRzd5mwwtpS22nRmUtqqK9xn4Z882jJbVhfkVhObRtWuNZUcZmtNCQwZk6Kc
	LXkCwyAqCokWTX4j1h4tqeWBSVSYIPY2ZI+iq4JJuZAKGi9wFnY83M51HRku6fhq/3DRdh
	XCqURTupN/9CxtZFwx9nInMzsncGjvo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-PfD41vzZNW--l4zT_hgaRw-1; Wed,
 06 Nov 2024 07:38:21 -0500
X-MC-Unique: PfD41vzZNW--l4zT_hgaRw-1
X-Mimecast-MFC-AGG-ID: PfD41vzZNW--l4zT_hgaRw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F54E1955EA9;
	Wed,  6 Nov 2024 12:38:19 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6580119560AA;
	Wed,  6 Nov 2024 12:38:13 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 17/33] cachefiles: Add some subrequest tracepoints
Date: Wed,  6 Nov 2024 12:35:41 +0000
Message-ID: <20241106123559.724888-18-dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-1-dhowells@redhat.com>
References: <20241106123559.724888-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-mm@kvack.org, netfs@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add some tracepoints into the cachefiles write paths.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: netfs@lists.linux.dev
---
 fs/cachefiles/io.c           | 4 ++++
 include/trace/events/netfs.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 6a821a959b59..92058ae43488 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -13,6 +13,7 @@
 #include <linux/falloc.h>
 #include <linux/sched/mm.h>
 #include <trace/events/fscache.h>
+#include <trace/events/netfs.h>
 #include "internal.h"
 
 struct cachefiles_kiocb {
@@ -366,6 +367,7 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE)) {
 		if (term_func)
 			term_func(term_func_priv, -ENOBUFS, false);
+		trace_netfs_sreq(term_func_priv, netfs_sreq_trace_cache_nowrite);
 		return -ENOBUFS;
 	}
 
@@ -695,6 +697,7 @@ static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
 		iov_iter_truncate(&subreq->io_iter, len);
 	}
 
+	trace_netfs_sreq(subreq, netfs_sreq_trace_cache_prepare);
 	cachefiles_begin_secure(cache, &saved_cred);
 	ret = __cachefiles_prepare_write(object, cachefiles_cres_file(cres),
 					 &start, &len, len, true);
@@ -704,6 +707,7 @@ static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
 		return;
 	}
 
+	trace_netfs_sreq(subreq, netfs_sreq_trace_cache_write);
 	cachefiles_write(&subreq->rreq->cache_resources,
 			 subreq->start, &subreq->io_iter,
 			 netfs_write_subrequest_terminated, subreq);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index a0f5b13aab86..7c3c866ae183 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -74,6 +74,9 @@
 #define netfs_sreq_traces					\
 	EM(netfs_sreq_trace_add_donations,	"+DON ")	\
 	EM(netfs_sreq_trace_added,		"ADD  ")	\
+	EM(netfs_sreq_trace_cache_nowrite,	"CA-NW")	\
+	EM(netfs_sreq_trace_cache_prepare,	"CA-PR")	\
+	EM(netfs_sreq_trace_cache_write,	"CA-WR")	\
 	EM(netfs_sreq_trace_clear,		"CLEAR")	\
 	EM(netfs_sreq_trace_discard,		"DSCRD")	\
 	EM(netfs_sreq_trace_donate_to_prev,	"DON-P")	\

