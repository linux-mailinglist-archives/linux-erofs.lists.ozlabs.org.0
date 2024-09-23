Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E579D97EDAC
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 17:09:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XC5xG70d1z2yZN
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 01:09:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727104144;
	cv=none; b=MKDeGdykzwLULh2XHWmTI0sPmiAAn46ktuy1mwTdfvzFRhEP72ECRLVJR+xvw9xPxpbXSqLvHybZNWGKhXRF0GW41C8HJi5CsvIiyGaKDA8Jcy44Ak0noIRuVY2RYfK7YFKIWuqKdOsWYZQzJ+NM+DWgy5OgODdnqflNCCNjLhZ8LGg+ChfFAzhuLP/QZfC558+zjdYln9IGVGM5PC/q3xlsA67l/xtc2G6FqST2lRJfFse2RDKjAgVPRbRDPjYyFw4Pi+rLHKRtUiPCaZtnYlARoMS5WPtAe5xOXiNA40Ed6L0X4egXsI5yMx9fhwkngsp+WBi56SWx4pmEfPUZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727104144; c=relaxed/relaxed;
	bh=en0FbhjuTrTUZN9cCFkNjaE5g8iEA8EQ8DfNicZc0lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wf1ZEUOSm9C0Ms8qL4ty3sMbpHMCdbZT2AVYWbpevC4OC8tzTyXOv5DH8wIdbt3ohrcTVtboaD2eE1g6y/u1ISjD37FLNue5X84lPG3+iIi7oNI0ZB0vPSkDaODxEcCjUQ0kJ+mUw23fHpiSAZqKBy+owgRLFyjI6lDDyNJaAV2rn+LXc7s+b5U1YO05dm7SKnl9A7jNUKfSJSkmAuf5I++/Gd6FQ7OQUk8RuJDCx36TxbdyBAVAi9ixyQay4N9m7e2XLi6qG01/DdjYXspRvi2B4Z5IoVt9sFlPJdcWZsULioCgtGeIbJiuhiOqZHDtk5Bq2DQe5QVwNyE9ojbEKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GaIqYkGJ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GaIqYkGJ; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GaIqYkGJ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GaIqYkGJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XC5xD1gwKz2xb9
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 01:09:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=en0FbhjuTrTUZN9cCFkNjaE5g8iEA8EQ8DfNicZc0lg=;
	b=GaIqYkGJZ7pqeQf0+OuFQL6eg3wsMkiyDBDiT7K60VHhV4MxMKeqcjZpNQKu6+FMqFCurG
	7glZ5fO4ppS+tVfb1lS+IEkDdyKg2SFoXtoIIApNOA8i7cv3hbz867NXZ/4prQrHcYqdIk
	wOwkyzY69iIokhyQF40h0CMbAJYsbR0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727104141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=en0FbhjuTrTUZN9cCFkNjaE5g8iEA8EQ8DfNicZc0lg=;
	b=GaIqYkGJZ7pqeQf0+OuFQL6eg3wsMkiyDBDiT7K60VHhV4MxMKeqcjZpNQKu6+FMqFCurG
	7glZ5fO4ppS+tVfb1lS+IEkDdyKg2SFoXtoIIApNOA8i7cv3hbz867NXZ/4prQrHcYqdIk
	wOwkyzY69iIokhyQF40h0CMbAJYsbR0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-hNdBfCa9Nk6QzasA8zlp7Q-1; Mon,
 23 Sep 2024 11:08:57 -0400
X-MC-Unique: hNdBfCa9Nk6QzasA8zlp7Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 102351895D51;
	Mon, 23 Sep 2024 15:08:50 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.145])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5CF4197700E;
	Mon, 23 Sep 2024 15:08:42 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH 7/8] cifs: Fix reversion of the iter in cifs_readv_receive().
Date: Mon, 23 Sep 2024 16:07:51 +0100
Message-ID: <20240923150756.902363-8-dhowells@redhat.com>
In-Reply-To: <20240923150756.902363-1-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Shyam Prasad N <nspmangalore@gmail.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

cifs_read_iter_from_socket() copies the iterator that's passed in for the
socket to modify as and if it will, and then advances the original iterator
by the amount sent.  However, both callers revert the advancement (although
receive_encrypted_read() zeros beyond the iterator first).  The problem is,
though, that cifs_readv_receive() reverts by the original length, not the
amount transmitted which can cause an oops in iov_iter_revert().

Fix this by:

 (1) Remove the iov_iter_advance() from cifs_read_iter_from_socket().

 (2) Remove the iov_iter_revert() from both callers.  This fixes the bug in
     cifs_readv_receive().

 (3) In receive_encrypted_read(), if we didn't get back as much data as the
     buffer will hold, copy the iterator, advance the copy and use the copy
     to drive iov_iter_zero().

As a bonus, this gets rid of some unnecessary work.

This was triggered by generic/074 with the "-o sign" mount option.

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/connect.c   | 6 +-----
 fs/smb/client/smb2ops.c   | 9 ++++++---
 fs/smb/client/transport.c | 3 ---
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 08a41c7aaf72..be6e632388f8 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -811,13 +811,9 @@ cifs_read_iter_from_socket(struct TCP_Server_Info *server, struct iov_iter *iter
 			   unsigned int to_read)
 {
 	struct msghdr smb_msg = { .msg_iter = *iter };
-	int ret;
 
 	iov_iter_truncate(&smb_msg.msg_iter, to_read);
-	ret = cifs_readv_from_socket(server, &smb_msg);
-	if (ret > 0)
-		iov_iter_advance(iter, ret);
-	return ret;
+	return cifs_readv_from_socket(server, &smb_msg);
 }
 
 static bool
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7381ec333c6d..1ee2dd4a1cae 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4869,9 +4869,12 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 		goto discard_data;
 
 	server->total_read += rc;
-	if (rc < len)
-		iov_iter_zero(len - rc, &iter);
-	iov_iter_revert(&iter, len);
+	if (rc < len) {
+		struct iov_iter tmp = iter;
+
+		iov_iter_advance(&tmp, rc);
+		iov_iter_zero(len - rc, &tmp);
+	}
 	iov_iter_truncate(&iter, dw->len);
 
 	rc = cifs_discard_remaining_data(server);
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index fd5a85d43759..91812150186c 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1817,11 +1817,8 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		length = data_len; /* An RDMA read is already done. */
 	else
 #endif
-	{
 		length = cifs_read_iter_from_socket(server, &rdata->subreq.io_iter,
 						    data_len);
-		iov_iter_revert(&rdata->subreq.io_iter, data_len);
-	}
 	if (length > 0)
 		rdata->got_bytes += length;
 	server->total_read += length;

