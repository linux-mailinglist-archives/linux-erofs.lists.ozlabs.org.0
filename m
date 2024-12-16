Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7829F3B2E
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 21:43:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBsNW00RSz30RJ
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Dec 2024 07:43:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734381816;
	cv=none; b=Alpyms359F5kBgdc2+J88n2FTeaLRzzQFWcWv49g+YB3W4Abfb/efBQjveLH+yN3YUFPJte17TfAEPz8cD2Rbj6uhtdREhIG6D5YJy6a8WPF7elUn0w6ECNxLtAR8NowQwEnOhX+FJgGEgmkbB8/RsUbOoWaarojwOkXYZ61MQ3MFw336+YRFa7nPpLd6B1hESjIriRmHybOBtOnnn4w5xIakKphoJm+yf1kRYKiKuegKVz0X64iD1LiZEWnIAvD7v7bW3FDtaIVcO1U5sSbzSqVrHjbi4Z+bgXvc745pr4R9ZGCM6E3JOqRgkIrrL8t17qlRrF6mfYya7osdMW8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734381816; c=relaxed/relaxed;
	bh=+h5xevLUTgx7DT+yXa3KdTAzsT6twp0kWM1j+wkaZ80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMmQLB8qO9aus764+K+XxDQy5yobZpFZ0DtZ0uKY0ioESJ6dFtpQAfGYdovJrhbT9Nja+mjKvOb7g/+SfIJsMvf47kgrmGFAsptY/Bv8IVkTCBkotFCHrhQVxTkr8Um1pMoOIzqGlTpc3QSgi/nFRVpYrfNbIrg32L4Hr+S88KrazwjiqXcO0gUgziTcgGqt2Utb80QBaUa5CX2K2RtYsIsbJH4G4yLrqoMpk33uBqCY24FBBrJMGaDpkt52A7agWoLL6HTJO23swtFxSAoK2grGcKwFi5P2D3/mytRCK1Axw+I0nxizcZWkp52vvD+zgXQpO2Ow/pVYETBDTWCKYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OQa4S10D; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OQa4S10D; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OQa4S10D;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OQa4S10D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBsNR6SX5z300g
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Dec 2024 07:43:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+h5xevLUTgx7DT+yXa3KdTAzsT6twp0kWM1j+wkaZ80=;
	b=OQa4S10DZXzEGPd+hMYVyooWXnUuSopQZH9MEF2+9cPiUeRb1j4mq4U6tkLb4OEE7Rewgr
	+RfNT+y8RFeB6oIWvWktUOEcl2ueVsGirOGEuPEOrWLWFLITUBVL38wXoeSlffQlFPtxma
	2AAc/AH+xyzNiTvf6uNRzNxWcVV4N7Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+h5xevLUTgx7DT+yXa3KdTAzsT6twp0kWM1j+wkaZ80=;
	b=OQa4S10DZXzEGPd+hMYVyooWXnUuSopQZH9MEF2+9cPiUeRb1j4mq4U6tkLb4OEE7Rewgr
	+RfNT+y8RFeB6oIWvWktUOEcl2ueVsGirOGEuPEOrWLWFLITUBVL38wXoeSlffQlFPtxma
	2AAc/AH+xyzNiTvf6uNRzNxWcVV4N7Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-8FHzIFyHP_G1A-tElrmP_g-1; Mon,
 16 Dec 2024 15:43:29 -0500
X-MC-Unique: 8FHzIFyHP_G1A-tElrmP_g-1
X-Mimecast-MFC-AGG-ID: 8FHzIFyHP_G1A-tElrmP_g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 173481956064;
	Mon, 16 Dec 2024 20:43:27 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79E3719560B0;
	Mon, 16 Dec 2024 20:43:21 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 15/32] cachefiles: Add some subrequest tracepoints
Date: Mon, 16 Dec 2024 20:41:05 +0000
Message-ID: <20241216204124.3752367-16-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
index 2dfc9f716e3b..02f6e179b7bc 100644
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

