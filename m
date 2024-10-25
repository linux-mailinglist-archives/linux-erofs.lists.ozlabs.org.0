Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D449B0FF4
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2024 22:41:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZvnY6Kdcz3bdV
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Oct 2024 07:41:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729888864;
	cv=none; b=IartEp8UY5UOVfbeRCQaY/OWsXzE6frVYuVyBctxbss59U2dpsdMMjMGGYf+v/5QPk9587N5HjlYS9eM3NbkfFmFaPS9WC5KE9nhriy81pXhHF1cgCyQet4eIJJttKWPjt9CTW1xUDmkREMSMeMt615egHlqPviosZA/xL1eRPIcH8S03eMM4EsvcqbR52lFiLDVrgXqPcu9fci8oxpXTpJpZVEo8hbt2HhwqHOfc1zj9MIEF9blm5jhMmplbzdX/7zt90QqJfPePXEL48fT6CwOLVlgIiiuCqhgbK0pt+i5b16+cBV0dFpv/CW/5ag7qWBYq7WdGAWkMznwpz2oBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729888864; c=relaxed/relaxed;
	bh=DUlYZzbaKUHX76MZjhLNdaJFIvV/RRK5UT5LJFkHe/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNf4IxnnuNZ8wqkHRkGH+j5rBf+HCTJZa3Rd1aW2UxXs+BYhmIMgUwdpg34GMu2EiOSkZzxdonjg6eVWceXcBuVUgBB1ovP9eQcaFkbS509U7qqH/vcMr8B2ZgxKmfiEZxokDWZai79Itws+coTp7kCn5Wo0+J8mtbXKQaWKos50ofbbm7Ne9FgIFRjpY7Yx0j5YUbZdbOjyhs0AJpuiAaoycsqUItLt3wF2EeLwtkvS55mCe2PBrEhSW0Y+2HPcGz+g02v1tOmX2N056/uo5+No4RsYB7DdIY9c9hVFB6gwe6jIJ7FxiPNE5nXb5ZqD4RFIfEt94SH8hIIc83eX1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f86jeAsd; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f86jeAsd; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f86jeAsd;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f86jeAsd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZvnV6HCzz2yD6
	for <linux-erofs@lists.ozlabs.org>; Sat, 26 Oct 2024 07:41:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729888859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DUlYZzbaKUHX76MZjhLNdaJFIvV/RRK5UT5LJFkHe/Y=;
	b=f86jeAsdmAxwmKVz5v/UwXL/1IXAamiv+OuZg+A4CcFw1NmYpVRMekqPgo9Yk/w18Pu2Wf
	ZV2VqcPkga/hQr74xIx/fPIER5c1cQrx37gPfPGHOnzW8kovNV55upnGG56E7AjnmbedYl
	Pi3jHAsFas8IHHtD3AMJRIqf6BS+NG0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729888859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DUlYZzbaKUHX76MZjhLNdaJFIvV/RRK5UT5LJFkHe/Y=;
	b=f86jeAsdmAxwmKVz5v/UwXL/1IXAamiv+OuZg+A4CcFw1NmYpVRMekqPgo9Yk/w18Pu2Wf
	ZV2VqcPkga/hQr74xIx/fPIER5c1cQrx37gPfPGHOnzW8kovNV55upnGG56E7AjnmbedYl
	Pi3jHAsFas8IHHtD3AMJRIqf6BS+NG0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-EO2hKmbnNG-xrVEdoqjWHA-1; Fri,
 25 Oct 2024 16:40:52 -0400
X-MC-Unique: EO2hKmbnNG-xrVEdoqjWHA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84BE91955EA3;
	Fri, 25 Oct 2024 20:40:49 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C7951956056;
	Fri, 25 Oct 2024 20:40:44 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 04/31] netfs: Use a folio_queue allocation and free functions
Date: Fri, 25 Oct 2024 21:39:31 +0100
Message-ID: <20241025204008.4076565-5-dhowells@redhat.com>
In-Reply-To: <20241025204008.4076565-1-dhowells@redhat.com>
References: <20241025204008.4076565-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Provide and use folio_queue allocation and free functions to combine the
allocation, initialisation and stat (un)accounting steps that are repeated
in several places.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c | 12 +++---------
 fs/netfs/misc.c          | 38 ++++++++++++++++++++++++++++++++++----
 include/linux/netfs.h    |  5 +++++
 3 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 7ac34550c403..b5a7beb9d01b 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -131,11 +131,9 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
 			struct folio_queue *tail = rreq->buffer_tail, *new;
 			size_t added;
 
-			new = kmalloc(sizeof(*new), GFP_NOFS);
+			new = netfs_folioq_alloc(GFP_NOFS);
 			if (!new)
 				return -ENOMEM;
-			netfs_stat(&netfs_n_folioq);
-			folioq_init(new);
 			new->prev = tail;
 			tail->next = new;
 			rreq->buffer_tail = new;
@@ -359,11 +357,9 @@ static int netfs_prime_buffer(struct netfs_io_request *rreq)
 	struct folio_batch put_batch;
 	size_t added;
 
-	folioq = kmalloc(sizeof(*folioq), GFP_KERNEL);
+	folioq = netfs_folioq_alloc(GFP_KERNEL);
 	if (!folioq)
 		return -ENOMEM;
-	netfs_stat(&netfs_n_folioq);
-	folioq_init(folioq);
 	rreq->buffer = folioq;
 	rreq->buffer_tail = folioq;
 	rreq->submitted = rreq->start;
@@ -436,12 +432,10 @@ static int netfs_create_singular_buffer(struct netfs_io_request *rreq, struct fo
 {
 	struct folio_queue *folioq;
 
-	folioq = kmalloc(sizeof(*folioq), GFP_KERNEL);
+	folioq = netfs_folioq_alloc(GFP_KERNEL);
 	if (!folioq)
 		return -ENOMEM;
 
-	netfs_stat(&netfs_n_folioq);
-	folioq_init(folioq);
 	folioq_append(folioq, folio);
 	BUG_ON(folioq_folio(folioq, 0) != folio);
 	BUG_ON(folioq_folio_order(folioq, 0) != folio_order(folio));
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 78fe5796b2b2..6cd7e1ee7a14 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -8,6 +8,38 @@
 #include <linux/swap.h>
 #include "internal.h"
 
+/**
+ * netfs_folioq_alloc - Allocate a folio_queue struct
+ * @gfp: Allocation constraints
+ *
+ * Allocate, initialise and account the folio_queue struct.
+ */
+struct folio_queue *netfs_folioq_alloc(gfp_t gfp)
+{
+	struct folio_queue *fq;
+
+	fq = kmalloc(sizeof(*fq), gfp);
+	if (fq) {
+		netfs_stat(&netfs_n_folioq);
+		folioq_init(fq);
+	}
+	return fq;
+}
+EXPORT_SYMBOL(netfs_folioq_alloc);
+
+/**
+ * netfs_folioq_free - Free a folio_queue struct
+ * @folioq: The object to free
+ *
+ * Free and unaccount the folio_queue struct.
+ */
+void netfs_folioq_free(struct folio_queue *folioq)
+{
+	netfs_stat_d(&netfs_n_folioq);
+	kfree(folioq);
+}
+EXPORT_SYMBOL(netfs_folioq_free);
+
 /*
  * Make sure there's space in the rolling queue.
  */
@@ -87,8 +119,7 @@ struct folio_queue *netfs_delete_buffer_head(struct netfs_io_request *wreq)
 
 	if (next)
 		next->prev = NULL;
-	netfs_stat_d(&netfs_n_folioq);
-	kfree(head);
+	netfs_folioq_free(head);
 	wreq->buffer = next;
 	return next;
 }
@@ -111,8 +142,7 @@ void netfs_clear_buffer(struct netfs_io_request *rreq)
 				folio_put(folio);
 			}
 		}
-		netfs_stat_d(&netfs_n_folioq);
-		kfree(p);
+		netfs_folioq_free(p);
 	}
 }
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5eaceef41e6c..b2fa569e875d 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -21,6 +21,7 @@
 
 enum netfs_sreq_ref_trace;
 typedef struct mempool_s mempool_t;
+struct folio_queue;
 
 /**
  * folio_start_private_2 - Start an fscache write on a folio.  [DEPRECATED]
@@ -454,6 +455,10 @@ void netfs_end_io_write(struct inode *inode);
 int netfs_start_io_direct(struct inode *inode);
 void netfs_end_io_direct(struct inode *inode);
 
+/* Miscellaneous APIs. */
+struct folio_queue *netfs_folioq_alloc(gfp_t gfp);
+void netfs_folioq_free(struct folio_queue *folioq);
+
 /**
  * netfs_inode - Get the netfs inode context from the inode
  * @inode: The inode to query

