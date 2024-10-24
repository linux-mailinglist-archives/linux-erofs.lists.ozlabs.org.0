Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0EC9AE78C
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Oct 2024 16:08:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZ76c6PJwz3bgQ
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2024 01:08:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729778886;
	cv=none; b=Ho4u4qEh6q4BJiQHtVYHdCGGPOICFkFsah0KVbzI93oKuFDLhqUwIdnoyQxqPjUwqGJnovYiOSlx69GLeeg8r6xdGniQ1uSlMQs6HDFnqW8Vq4hQhP7zK0GX8JpeZPYOysaPkGXlzboTy1Bc26jNQL9wMC4n8lIKXSvvZrJWzXWHgUy6gzM1m6UT94qQVN8le9bg/gI1080WORjx0cia36WZVyEhizIRGayYQxpOrQjx0eRCpAPAi4XBAfkJh7RQFdCYJ9tTz6l+arMe/cyWUgKnU3/jD2Y6Hkh3FheIDRzIBkFU9ErK1CUgwRa/+5dcegbR7Y4jMKhr5MeupckTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729778886; c=relaxed/relaxed;
	bh=3kDl7vtgTz4UJLk1NBKECBmgzlrlbYChuV4j2ks8Pq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpI33hJqwyJS+7Nkd7TAekTdVOih8xLXQthUNsaSJVBMv+gyhKwyOedqayBrJTg5kYXC/Okxoj6ohMHakrtKNL4OF1Z3cbtyQrZH3woTRQvuyhJnDKcrq/pXj8eA3CYxIrUEM93NOpsA+epFeGOnb8YXbWKNlOPH/2asbfFORY+vYHC0xq5L7VA0eXV096pK/aLcWlvw4zusdVTXZBWDNl41Zi6wp05mSfQo8fL42CCMFr0qexY6IAxSmhkZBIrwfl5bSgnLbWkCXw2qIDRipbkm640K++CVQqgnI9YgT1FdyLwfd+ockMpqaArLJs5V61A3yd2wC+tq+bBZ9SZ5vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aIfAC7Xs; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aIfAC7Xs; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aIfAC7Xs;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aIfAC7Xs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZ76Y46dGz305n
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Oct 2024 01:08:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3kDl7vtgTz4UJLk1NBKECBmgzlrlbYChuV4j2ks8Pq0=;
	b=aIfAC7XsUn+9zbaWZvI/nyo0qyFVxVnF6j5rpG/SpRNXbYRWy4vSUQOqxuQYiPmxW9E8X6
	L6gSEUl+gR21GHdsMBmWDBPUgWs6VGk9PAmBxW0N5y8JNJ6uYt65ZguloSxBHTPQYKLb+R
	+WPsKQHaNEK0YOwUvEdw9C1pM287VwI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3kDl7vtgTz4UJLk1NBKECBmgzlrlbYChuV4j2ks8Pq0=;
	b=aIfAC7XsUn+9zbaWZvI/nyo0qyFVxVnF6j5rpG/SpRNXbYRWy4vSUQOqxuQYiPmxW9E8X6
	L6gSEUl+gR21GHdsMBmWDBPUgWs6VGk9PAmBxW0N5y8JNJ6uYt65ZguloSxBHTPQYKLb+R
	+WPsKQHaNEK0YOwUvEdw9C1pM287VwI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-eWp8axh7PCKxtyFvvhMAIQ-1; Thu,
 24 Oct 2024 10:07:59 -0400
X-MC-Unique: eWp8axh7PCKxtyFvvhMAIQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66D6A1955F69;
	Thu, 24 Oct 2024 14:07:56 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CAADE300018D;
	Thu, 24 Oct 2024 14:07:50 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 16/27] cachefiles: Add some subrequest tracepoints
Date: Thu, 24 Oct 2024 15:05:14 +0100
Message-ID: <20241024140539.3828093-17-dhowells@redhat.com>
In-Reply-To: <20241024140539.3828093-1-dhowells@redhat.com>
References: <20241024140539.3828093-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

