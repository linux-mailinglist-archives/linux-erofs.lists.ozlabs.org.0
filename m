Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B42489058F
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Mar 2024 17:38:22 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fZv3qLVM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S3EBvgcq;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V58Nq6hM0z3vZ3
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Mar 2024 03:38:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fZv3qLVM;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S3EBvgcq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V58Nl22Jlz3vcD
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 Mar 2024 03:38:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JI9PX3u9k9FTrB5i0WWXWgMwPBin4UAr3u+00DhFGiU=;
	b=fZv3qLVM0NKjWPOGEMU62mJ9a/cM1KrYUHCp9s7CK/rNlVMlrzx4jR227LiS/TDimciEjE
	yF9+SF2bJWg5kHWXIIqSgD99qu1I9buMXYpdPU2L0NxtVING24ov5rWNLmMxN7lpu/tBhC
	p1YOSl+0YqhsoCFSAixEuX2Nz34xzcY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JI9PX3u9k9FTrB5i0WWXWgMwPBin4UAr3u+00DhFGiU=;
	b=S3EBvgcqAmWOG/KAVx2rSD+u/7BRLXaC/JS0l1LNkrcAUpx0Tu3ldg5JR43pyKUszXHtM8
	oW4AQMyFZVl11NmVwA42N1kbGJpCnhxYLXy+w3jcnzZAqeeGJ+TKyM80F5pfA72so0jD3s
	QnQ/4bwj65GGu8FY2qUa+ylaiO4kDYo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-2sgLOBL1P_u0EwB7rUYwvg-1; Thu,
 28 Mar 2024 12:38:09 -0400
X-MC-Unique: 2sgLOBL1P_u0EwB7rUYwvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F7C2383CD7C;
	Thu, 28 Mar 2024 16:38:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1B5A11C060D0;
	Thu, 28 Mar 2024 16:38:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 18/26] netfs: Add some write-side stats and clean up some stat names
Date: Thu, 28 Mar 2024 16:34:10 +0000
Message-ID: <20240328163424.2781320-19-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, linux-mm@kvack.org, netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add some write-side stats to count buffered writes, buffered writethrough,
and writepages calls.

Whilst we're at it, clean up the naming on some of the existing stats
counters and organise the output into two sets.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c  |  2 +-
 fs/netfs/buffered_write.c |  3 +++
 fs/netfs/direct_write.c   |  2 +-
 fs/netfs/internal.h       |  7 +++++--
 fs/netfs/stats.c          | 17 ++++++++++++-----
 5 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 47603f08680e..a6bb03bea920 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -282,7 +282,7 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
 		goto discard;
 
-	netfs_stat(&netfs_n_rh_readpage);
+	netfs_stat(&netfs_n_rh_read_folio);
 	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
 
 	/* Set up the output buffer */
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index db4ad158948b..244d67a43972 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -215,6 +215,9 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		if (!is_sync_kiocb(iocb))
 			wreq->iocb = iocb;
 		wreq->cleanup = netfs_cleanup_buffered_write;
+		netfs_stat(&netfs_n_wh_writethrough);
+	} else {
+		netfs_stat(&netfs_n_wh_buffered_write);
 	}
 
 	do {
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index bee047e20f5d..37c91188107b 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -143,7 +143,7 @@ ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		return 0;
 
 	trace_netfs_write_iter(iocb, from);
-	netfs_stat(&netfs_n_rh_dio_write);
+	netfs_stat(&netfs_n_wh_dio_write);
 
 	ret = netfs_start_io_direct(inode);
 	if (ret < 0)
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index c67da478cd2b..58289cc65e25 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -106,9 +106,8 @@ int netfs_end_writethrough(struct netfs_io_request *wreq, struct kiocb *iocb);
  */
 #ifdef CONFIG_NETFS_STATS
 extern atomic_t netfs_n_rh_dio_read;
-extern atomic_t netfs_n_rh_dio_write;
 extern atomic_t netfs_n_rh_readahead;
-extern atomic_t netfs_n_rh_readpage;
+extern atomic_t netfs_n_rh_read_folio;
 extern atomic_t netfs_n_rh_rreq;
 extern atomic_t netfs_n_rh_sreq;
 extern atomic_t netfs_n_rh_download;
@@ -125,6 +124,10 @@ extern atomic_t netfs_n_rh_write_begin;
 extern atomic_t netfs_n_rh_write_done;
 extern atomic_t netfs_n_rh_write_failed;
 extern atomic_t netfs_n_rh_write_zskip;
+extern atomic_t netfs_n_wh_buffered_write;
+extern atomic_t netfs_n_wh_writethrough;
+extern atomic_t netfs_n_wh_dio_write;
+extern atomic_t netfs_n_wh_writepages;
 extern atomic_t netfs_n_wh_wstream_conflict;
 extern atomic_t netfs_n_wh_upload;
 extern atomic_t netfs_n_wh_upload_done;
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index deeba9f9dcf5..0892768eea32 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -10,9 +10,8 @@
 #include "internal.h"
 
 atomic_t netfs_n_rh_dio_read;
-atomic_t netfs_n_rh_dio_write;
 atomic_t netfs_n_rh_readahead;
-atomic_t netfs_n_rh_readpage;
+atomic_t netfs_n_rh_read_folio;
 atomic_t netfs_n_rh_rreq;
 atomic_t netfs_n_rh_sreq;
 atomic_t netfs_n_rh_download;
@@ -29,6 +28,10 @@ atomic_t netfs_n_rh_write_begin;
 atomic_t netfs_n_rh_write_done;
 atomic_t netfs_n_rh_write_failed;
 atomic_t netfs_n_rh_write_zskip;
+atomic_t netfs_n_wh_buffered_write;
+atomic_t netfs_n_wh_writethrough;
+atomic_t netfs_n_wh_dio_write;
+atomic_t netfs_n_wh_writepages;
 atomic_t netfs_n_wh_wstream_conflict;
 atomic_t netfs_n_wh_upload;
 atomic_t netfs_n_wh_upload_done;
@@ -39,13 +42,17 @@ atomic_t netfs_n_wh_write_failed;
 
 int netfs_stats_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "Netfs  : DR=%u DW=%u RA=%u RP=%u WB=%u WBZ=%u\n",
+	seq_printf(m, "Netfs  : DR=%u RA=%u RF=%u WB=%u WBZ=%u\n",
 		   atomic_read(&netfs_n_rh_dio_read),
-		   atomic_read(&netfs_n_rh_dio_write),
 		   atomic_read(&netfs_n_rh_readahead),
-		   atomic_read(&netfs_n_rh_readpage),
+		   atomic_read(&netfs_n_rh_read_folio),
 		   atomic_read(&netfs_n_rh_write_begin),
 		   atomic_read(&netfs_n_rh_write_zskip));
+	seq_printf(m, "Netfs  : BW=%u WT=%u DW=%u WP=%u\n",
+		   atomic_read(&netfs_n_wh_buffered_write),
+		   atomic_read(&netfs_n_wh_writethrough),
+		   atomic_read(&netfs_n_wh_dio_write),
+		   atomic_read(&netfs_n_wh_writepages));
 	seq_printf(m, "Netfs  : ZR=%u sh=%u sk=%u\n",
 		   atomic_read(&netfs_n_rh_zero),
 		   atomic_read(&netfs_n_rh_short_read),

