Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C00959115
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 01:21:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WpQTT4262z2yRF
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 09:21:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uu2EAl4n;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uu2EAl4n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WpQTR2spmz2yVF
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2024 09:21:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724196104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pcRiiH/lYTDVoni9WSyylXIzj+0iyqYBGBDYoCG5zI=;
	b=Uu2EAl4n0v+4kmOMUajbWhmqlBITdmxrUbLuaQ+SsZJrM2OJQ9ElaGAy3QtXWywMx4ZBuA
	qfotm2dscPhzwCv27eJ78s7cJAQsrAc3d66MGqJ+0aF+lv9u/sbXDo7kRURAjPeRzh9bz/
	UXAcwU8Elqj4oD3do/LyuNN4xCceXJs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724196104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pcRiiH/lYTDVoni9WSyylXIzj+0iyqYBGBDYoCG5zI=;
	b=Uu2EAl4n0v+4kmOMUajbWhmqlBITdmxrUbLuaQ+SsZJrM2OJQ9ElaGAy3QtXWywMx4ZBuA
	qfotm2dscPhzwCv27eJ78s7cJAQsrAc3d66MGqJ+0aF+lv9u/sbXDo7kRURAjPeRzh9bz/
	UXAcwU8Elqj4oD3do/LyuNN4xCceXJs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-JolRJguvP_SguD5LijFaFg-1; Tue,
 20 Aug 2024 19:21:39 -0400
X-MC-Unique: JolRJguvP_SguD5LijFaFg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA9DE19560AD;
	Tue, 20 Aug 2024 23:21:36 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9E6F1955F54;
	Tue, 20 Aug 2024 23:21:32 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 4/4] netfs: Fix trimming of streaming-write folios in netfs_inval_folio()
Date: Wed, 21 Aug 2024 00:20:58 +0100
Message-ID: <20240820232105.3792638-5-dhowells@redhat.com>
In-Reply-To: <20240820232105.3792638-1-dhowells@redhat.com>
References: <20240820232105.3792638-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Marc Dionne <marc.dionne@auristor.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When netfslib writes to a folio that it doesn't have data for, but that
data exists on the server, it will make a 'streaming write' whereby it
stores data in a folio that is marked dirty, but not uptodate.  When it
does this, it attaches a record to folio->private to track the dirty
region.

When truncate() or fallocate() wants to invalidate part of such a folio, it
will call into ->invalidate_folio(), specifying the part of the folio that
is to be invalidated.  netfs_invalidate_folio(), on behalf of the
filesystem, must then determine how to trim the streaming write record.  In
a couple of cases, however, it does this incorrectly (the reduce-length and
move-start cases are switched over and don't, in any case, calculate the
value correctly).

Fix this by making the logic tree more obvious and fixing the cases.

Fixes: 9ebff83e6481 ("netfs: Prep to use folio->private for write grouping and streaming write")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Pankaj Raghav <p.raghav@samsung.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/misc.c | 50 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 69324761fcf7..c1f321cf5999 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -97,10 +97,20 @@ EXPORT_SYMBOL(netfs_clear_inode_writeback);
 void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 {
 	struct netfs_folio *finfo;
+	struct netfs_inode *ctx = netfs_inode(folio_inode(folio));
 	size_t flen = folio_size(folio);
 
 	_enter("{%lx},%zx,%zx", folio->index, offset, length);
 
+	if (offset == 0 && length == flen) {
+		unsigned long long i_size = i_size_read(&ctx->inode);
+		unsigned long long fpos = folio_pos(folio), end;
+
+		end = umin(fpos + flen, i_size);
+		if (fpos < i_size && end > ctx->zero_point)
+			ctx->zero_point = end;
+	}
+
 	folio_wait_private_2(folio); /* [DEPRECATED] */
 
 	if (!folio_test_private(folio))
@@ -115,18 +125,34 @@ void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 		/* We have a partially uptodate page from a streaming write. */
 		unsigned int fstart = finfo->dirty_offset;
 		unsigned int fend = fstart + finfo->dirty_len;
-		unsigned int end = offset + length;
+		unsigned int iend = offset + length;
 
 		if (offset >= fend)
 			return;
-		if (end <= fstart)
+		if (iend <= fstart)
+			return;
+
+		/* The invalidation region overlaps the data.  If the region
+		 * covers the start of the data, we either move along the start
+		 * or just erase the data entirely.
+		 */
+		if (offset <= fstart) {
+			if (iend >= fend)
+				goto erase_completely;
+			/* Move the start of the data. */
+			finfo->dirty_len = fend - iend;
+			finfo->dirty_offset = offset;
+			return;
+		}
+
+		/* Reduce the length of the data if the invalidation region
+		 * covers the tail part.
+		 */
+		if (iend >= fend) {
+			finfo->dirty_len = offset - fstart;
 			return;
-		if (offset <= fstart && end >= fend)
-			goto erase_completely;
-		if (offset <= fstart && end > fstart)
-			goto reduce_len;
-		if (offset > fstart && end >= fend)
-			goto move_start;
+		}
+
 		/* A partial write was split.  The caller has already zeroed
 		 * it, so just absorb the hole.
 		 */
@@ -139,12 +165,6 @@ void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 	folio_clear_uptodate(folio);
 	kfree(finfo);
 	return;
-reduce_len:
-	finfo->dirty_len = offset + length - finfo->dirty_offset;
-	return;
-move_start:
-	finfo->dirty_len -= offset - finfo->dirty_offset;
-	finfo->dirty_offset = offset;
 }
 EXPORT_SYMBOL(netfs_invalidate_folio);
 
@@ -164,7 +184,7 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp)
 	if (folio_test_dirty(folio))
 		return false;
 
-	end = folio_pos(folio) + folio_size(folio);
+	end = umin(folio_pos(folio) + folio_size(folio), i_size_read(&ctx->inode));
 	if (end > ctx->zero_point)
 		ctx->zero_point = end;
 

