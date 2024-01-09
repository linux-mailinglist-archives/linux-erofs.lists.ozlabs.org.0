Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCC28284B4
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 12:21:04 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eOizN1IT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eOizN1IT;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T8T5B0wtVz3bNs
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 22:21:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eOizN1IT;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eOizN1IT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T8T4v5dTmz30Jy
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Jan 2024 22:20:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704799245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rr5EJ/KUtWAGcPxbo/TizcNZKdZiXnS9Nbdtw3WvDek=;
	b=eOizN1ITc++pFS1NfojjR1I2v1AP8qQ7bM6iJIs1WyhOM30i0o9PMdcmw2cezhKcZuN4Xe
	lLEdJTSBoqibdfpPv2Vw76+DsH9Sfo7LBgbGjBI1vC/ZIKoJdNyC1N2K0AM8TomkXatmdq
	AmyeLA/MNuRCKgn/2QURbFOpdM0W29M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704799245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rr5EJ/KUtWAGcPxbo/TizcNZKdZiXnS9Nbdtw3WvDek=;
	b=eOizN1ITc++pFS1NfojjR1I2v1AP8qQ7bM6iJIs1WyhOM30i0o9PMdcmw2cezhKcZuN4Xe
	lLEdJTSBoqibdfpPv2Vw76+DsH9Sfo7LBgbGjBI1vC/ZIKoJdNyC1N2K0AM8TomkXatmdq
	AmyeLA/MNuRCKgn/2QURbFOpdM0W29M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-EIoi-qiVMCWdOvvkHaBtvw-1; Tue,
 09 Jan 2024 06:20:43 -0500
X-MC-Unique: EIoi-qiVMCWdOvvkHaBtvw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59A0D29AA3A5;
	Tue,  9 Jan 2024 11:20:42 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7E2DBC15A0C;
	Tue,  9 Jan 2024 11:20:39 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 1/6] netfs: Mark netfs_unbuffered_write_iter_locked() static
Date: Tue,  9 Jan 2024 11:20:18 +0000
Message-ID: <20240109112029.1572463-2-dhowells@redhat.com>
In-Reply-To: <20240109112029.1572463-1-dhowells@redhat.com>
References: <20240109112029.1572463-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Mark netfs_unbuffered_write_iter_locked() static as it's only called from
the file in which it is defined.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/direct_write.c | 4 ++--
 fs/netfs/internal.h     | 6 ------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index aad05f2349a4..b9cbfd6a8a01 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -27,8 +27,8 @@ static void netfs_cleanup_dio_write(struct netfs_io_request *wreq)
  * Perform an unbuffered write where we may have to do an RMW operation on an
  * encrypted file.  This can also be used for direct I/O writes.
  */
-ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *iter,
-					   struct netfs_group *netfs_group)
+static ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *iter,
+						  struct netfs_group *netfs_group)
 {
 	struct netfs_io_request *wreq;
 	unsigned long long start = iocb->ki_pos;
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index d2d63120ac60..a6dfc8888377 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -26,12 +26,6 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq);
 int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 			     size_t offset, size_t len);
 
-/*
- * direct_write.c
- */
-ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *iter,
-					   struct netfs_group *netfs_group);
-
 /*
  * io.c
  */

