Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FC68284BA
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 12:21:10 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DwDpan72;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DwDpan72;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T8T5H6qVZz30gJ
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 22:21:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DwDpan72;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DwDpan72;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T8T531GXnz30g6
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Jan 2024 22:20:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704799252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPQwieeKN1qerHU6y651BO8nE/WRIhipjKm0fUBOfew=;
	b=DwDpan72kyTzqvXC/JDSq8VUgrFtBiZn9kfZLgESw9JNDrs4KISDVAUWyjOcHy5SlaPQsp
	etvybJ09XGASkHntOu1FADvlRI5Bptncj9DZIv3UnmQxtgdpUu4b86BFuU8MpzBVsctr+e
	jc2OEIf/aCiD19UxlGRwXirl64LC9NY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704799252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPQwieeKN1qerHU6y651BO8nE/WRIhipjKm0fUBOfew=;
	b=DwDpan72kyTzqvXC/JDSq8VUgrFtBiZn9kfZLgESw9JNDrs4KISDVAUWyjOcHy5SlaPQsp
	etvybJ09XGASkHntOu1FADvlRI5Bptncj9DZIv3UnmQxtgdpUu4b86BFuU8MpzBVsctr+e
	jc2OEIf/aCiD19UxlGRwXirl64LC9NY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-E31DJX2lMH602RvDfJCjMg-1; Tue, 09 Jan 2024 06:20:46 -0500
X-MC-Unique: E31DJX2lMH602RvDfJCjMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3D56811E86;
	Tue,  9 Jan 2024 11:20:45 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0C7D83C39;
	Tue,  9 Jan 2024 11:20:42 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 2/6] netfs: Count DIO writes
Date: Tue,  9 Jan 2024 11:20:19 +0000
Message-ID: <20240109112029.1572463-3-dhowells@redhat.com>
In-Reply-To: <20240109112029.1572463-1-dhowells@redhat.com>
References: <20240109112029.1572463-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

Provide a counter for DIO writes to match that for DIO reads.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/direct_write.c |  1 +
 fs/netfs/internal.h     |  1 +
 fs/netfs/stats.c        | 11 +++++++----
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index b9cbfd6a8a01..60a40d293c87 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -140,6 +140,7 @@ ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	_enter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read(inode));
 
 	trace_netfs_write_iter(iocb, from);
+	netfs_stat(&netfs_n_rh_dio_write);
 
 	ret = netfs_start_io_direct(inode);
 	if (ret < 0)
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index a6dfc8888377..3f9620d0fa63 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -104,6 +104,7 @@ int netfs_end_writethrough(struct netfs_io_request *wreq, struct kiocb *iocb);
  */
 #ifdef CONFIG_NETFS_STATS
 extern atomic_t netfs_n_rh_dio_read;
+extern atomic_t netfs_n_rh_dio_write;
 extern atomic_t netfs_n_rh_readahead;
 extern atomic_t netfs_n_rh_readpage;
 extern atomic_t netfs_n_rh_rreq;
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index 15fd5c3f0f39..42db36528d92 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -10,6 +10,7 @@
 #include "internal.h"
 
 atomic_t netfs_n_rh_dio_read;
+atomic_t netfs_n_rh_dio_write;
 atomic_t netfs_n_rh_readahead;
 atomic_t netfs_n_rh_readpage;
 atomic_t netfs_n_rh_rreq;
@@ -37,14 +38,13 @@ atomic_t netfs_n_wh_write_failed;
 
 int netfs_stats_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "Netfs  : DR=%u RA=%u RP=%u WB=%u WBZ=%u rr=%u sr=%u\n",
+	seq_printf(m, "Netfs  : DR=%u DW=%u RA=%u RP=%u WB=%u WBZ=%u\n",
 		   atomic_read(&netfs_n_rh_dio_read),
+		   atomic_read(&netfs_n_rh_dio_write),
 		   atomic_read(&netfs_n_rh_readahead),
 		   atomic_read(&netfs_n_rh_readpage),
 		   atomic_read(&netfs_n_rh_write_begin),
-		   atomic_read(&netfs_n_rh_write_zskip),
-		   atomic_read(&netfs_n_rh_rreq),
-		   atomic_read(&netfs_n_rh_sreq));
+		   atomic_read(&netfs_n_rh_write_zskip));
 	seq_printf(m, "Netfs  : ZR=%u sh=%u sk=%u\n",
 		   atomic_read(&netfs_n_rh_zero),
 		   atomic_read(&netfs_n_rh_short_read),
@@ -66,6 +66,9 @@ int netfs_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&netfs_n_wh_write),
 		   atomic_read(&netfs_n_wh_write_done),
 		   atomic_read(&netfs_n_wh_write_failed));
+	seq_printf(m, "Netfs  : rr=%u sr=%u\n",
+		   atomic_read(&netfs_n_rh_rreq),
+		   atomic_read(&netfs_n_rh_sreq));
 	return fscache_stats_show(m);
 }
 EXPORT_SYMBOL(netfs_stats_show);

