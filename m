Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E909F0DBA
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 14:51:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8rMn0cNCz3bWP
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Dec 2024 00:51:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734097859;
	cv=none; b=NnsZQr/Sfb603pVZ1bhKbZLmbqmnJ/A1zYzl4+3/fgUdAMcckd9yYlMD9F5LiCJ3l1OZ3yy4nRcz2zc7GioEhsYHoyXzQxZht+4TnDrjz3Aj9gue4TGL47b5Qsne3F+jWyJgkgVtNqGnovzdvTTOukmSqhm2O10TCRPmEPNw/XvVFKlYz3iT+NQu8JAuIf1FX+WwrKiEnAGZS8AwDrYhtzjzR1nMdTxVmmi95W2tsMmw/L4p6S7HFOD8+8Z3OhE3YUo4f32CX/8gKZ/f3m4vlwAach9eY7YTE9O6Q9Obs6c+jJnUgmAtHNeXzVAWwjgmJdzpFNmjw1RLGlJdFuyUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734097859; c=relaxed/relaxed;
	bh=5M1ENZFbO/mNMn248U1qss6F8q2hwKZC+45ijoUGNaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOSj9JqxcRKadGi0ym1UKUKXlLDnSSfs0KWACKPI8JZTZTxEISxPReJ3hvvFT+EuZTfOyz0Scytj4kZhg8Ht+IBaQVZ3DvUaAQ9yILETMy2Nbpg2LLgw8LogSSpQEKumcMaWhTMeX4/vzNr6pCC6a7OLw0gUXzwpGva7/lRzxXCMpM86treIb651+DvxuhcSILkMcCVOH+Uhx48Mriy7iUV16zTJ1WniDpTN5/Lw1LU5pGNB5WLdSmD//7YcQDpFqxRBqUUaMi6isXeqka8Y6keJOk0HrbYJS7KcnZg3fomB5b8/P8WBF1+vugf6Ti0fizyUux1EpUciDss7bn62yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MwVdUgwf; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N7L+xOIG; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MwVdUgwf;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N7L+xOIG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8rMk3bX0z3bTf
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Dec 2024 00:50:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5M1ENZFbO/mNMn248U1qss6F8q2hwKZC+45ijoUGNaQ=;
	b=MwVdUgwfQSQIi4jmyuKEgAO2ZchpnKwypFPV9WsITKHn5sFkT/AA0Tl3NzjgFy9lKEMJ3l
	1l2cWgmr3Jw5hO0t9OmBzeEwq2o7kuuuky/ianG5BZlHTSov57JhquBrIjyngLMZi+DT15
	sjkfVw0YkZNQDEu/Ql3ozUoHhZIgU3Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5M1ENZFbO/mNMn248U1qss6F8q2hwKZC+45ijoUGNaQ=;
	b=N7L+xOIGH6ysdQd2KxR6lkiNo5uPiOh3+urZJUvItES5v3fQj/vjDAcMk65AgupWn0NI/Q
	0X4wOlXh5Y0/H4q/nv/p+Uh869DFAedja0jeKJNEHQrozOycl6e0BwNaZ7EXbDg5nBfA+E
	Xojz8pUQkCYgbRma8Mcp9EoxpawHsEc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-komwBIjYNoKdH0VnGk57oA-1; Fri,
 13 Dec 2024 08:50:52 -0500
X-MC-Unique: komwBIjYNoKdH0VnGk57oA-1
X-Mimecast-MFC-AGG-ID: komwBIjYNoKdH0VnGk57oA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D61E71956056;
	Fri, 13 Dec 2024 13:50:49 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC2561956052;
	Fri, 13 Dec 2024 13:50:44 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 04/10] nfs: Fix oops in nfs_netfs_init_request() when copying to cache
Date: Fri, 13 Dec 2024 13:50:04 +0000
Message-ID: <20241213135013.2964079-5-dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
Cc: Dave Wysochanski <dwysocha@redhat.com>, linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, ceph-devel@vger.kernel.org, Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Trond Myklebust <trondmy@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When netfslib wants to copy some data that has just been read on behalf of
nfs, it creates a new write request and calls nfs_netfs_init_request() to
initialise it, but with a NULL file pointer.  This causes
nfs_file_open_context() to oops - however, we don't actually need the nfs
context as we're only going to write to the cache.

Fix this by just returning if we aren't given a file pointer and emit a
warning if the request was for something other than copy-to-cache.

Further, fix nfs_netfs_free_request() so that it doesn't try to free the
context if the pointer is NULL.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Closes: https://lore.kernel.org/r/CAKPOu+9DyMbKLhyJb7aMLDTb=Fh0T8Teb9sjuf_pze+XWT1VaQ@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Trond Myklebust <trondmy@kernel.org>
cc: Anna Schumaker <anna@kernel.org>
cc: Dave Wysochanski <dwysocha@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-nfs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/nfs/fscache.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 810269ee0a50..d49e4ce27999 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -263,6 +263,12 @@ int nfs_netfs_readahead(struct readahead_control *ractl)
 static atomic_t nfs_netfs_debug_id;
 static int nfs_netfs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
+	if (!file) {
+		if (WARN_ON_ONCE(rreq->origin != NETFS_PGPRIV2_COPY_TO_CACHE))
+			return -EIO;
+		return 0;
+	}
+
 	rreq->netfs_priv = get_nfs_open_context(nfs_file_open_context(file));
 	rreq->debug_id = atomic_inc_return(&nfs_netfs_debug_id);
 	/* [DEPRECATED] Use PG_private_2 to mark folio being written to the cache. */
@@ -274,7 +280,8 @@ static int nfs_netfs_init_request(struct netfs_io_request *rreq, struct file *fi
 
 static void nfs_netfs_free_request(struct netfs_io_request *rreq)
 {
-	put_nfs_open_context(rreq->netfs_priv);
+	if (rreq->netfs_priv)
+		put_nfs_open_context(rreq->netfs_priv);
 }
 
 static struct nfs_netfs_io_data *nfs_netfs_alloc(struct netfs_io_subrequest *sreq)

