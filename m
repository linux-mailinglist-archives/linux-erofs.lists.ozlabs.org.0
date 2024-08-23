Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3013395D70F
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 22:09:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WrB3k1NPnz304f
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2024 06:09:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724443743;
	cv=none; b=SV/WHBfZS/A1bgCpGSlXNm4hJ+COsNixZPnP3L2O4UWXEk1sSeK6K2ufrSs48CHSYEZmCO5j8Ay+HkC+j6vc7opS7vYOfREUEYNvU26YZe3+yT4hNTAMZyU8JU8dF2JogdaTOAzyS+1q8zIHWcTwfkuLjyfgu3GkXVUyXQyUTbL/AyUYMyoWeVgfaGpoSonPhyTMnJRx6AZjZG/7eFrMoa3YkVFGDAGxp/Vj53rJMRb8MNM7oludfgBqMhjLhL+qfqOSYyYXm6qiDLt1gYm08K5GWlx04u13FqHy6lGYyyIxWTnPMUG/zsPsYTVbaS9ROHUDmyQY/E9zQI8Mnbh89w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724443743; c=relaxed/relaxed;
	bh=9pcRiiH/lYTDVoni9WSyylXIzj+0iyqYBGBDYoCG5zI=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Scanned-By; b=n+8Xt3vHhUMC4DzJVU3+Y/9wIhtSREtLL0F2O6NBou3qp53YLdmRg8fAK7WXYWcGkqkBGlLnNYBhAWOujiYJhz46jHvBLAx429sYYjLYSAyG+Jz6agqDqRQb2WNQqzbkOvhp7iZIt6Jh1A1C7k9I+GiaE+s9cJ8zNUYl5YFTeK3a6ft6ZoixeDIiWP3uKSjGUB9pNTE1rrI/Ix1uJ5ImVvp+di7H1zYqokfvvXk+noPNlM88cFTbtFirXyDR5DhJ7sS5jOhKyDCzOp5dLY7Sv8jJ/CGgQoyKPNEyhoVEL5g0sZ75m4up25wvNZiCsoFW1hDd/hfTqSrmlvhStuFz8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WlJH3dSd; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WlJH3dSd; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WlJH3dSd;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WlJH3dSd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WrB3g2g3mz2yXs
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2024 06:09:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pcRiiH/lYTDVoni9WSyylXIzj+0iyqYBGBDYoCG5zI=;
	b=WlJH3dSdw503Bvt7iGUJrxRE+qWxQruJltx283RHlS4JEfNwqB1uFtB3/xioUWvCw1LrPn
	3w4054W66VgdDHwthjIwzYqFdHWtUpQ5ySUw0K6TTEZ4sl6h+EBpa8OD0Ds16JmTE0nf73
	DNSzEC9YvTDRty/A692Zr8nPF8kgGls=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pcRiiH/lYTDVoni9WSyylXIzj+0iyqYBGBDYoCG5zI=;
	b=WlJH3dSdw503Bvt7iGUJrxRE+qWxQruJltx283RHlS4JEfNwqB1uFtB3/xioUWvCw1LrPn
	3w4054W66VgdDHwthjIwzYqFdHWtUpQ5ySUw0K6TTEZ4sl6h+EBpa8OD0Ds16JmTE0nf73
	DNSzEC9YvTDRty/A692Zr8nPF8kgGls=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-Sz3wsQBWNzSGl0B-Sn23dQ-1; Fri,
 23 Aug 2024 16:08:56 -0400
X-MC-Unique: Sz3wsQBWNzSGl0B-Sn23dQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EEA41955BED;
	Fri, 23 Aug 2024 20:08:53 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B0903001FE5;
	Fri, 23 Aug 2024 20:08:48 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 4/9] netfs: Fix trimming of streaming-write folios in netfs_inval_folio()
Date: Fri, 23 Aug 2024 21:08:12 +0100
Message-ID: <20240823200819.532106-5-dhowells@redhat.com>
In-Reply-To: <20240823200819.532106-1-dhowells@redhat.com>
References: <20240823200819.532106-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, Paulo Alcantara <pc@manguebit.com>, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Marc Dionne <marc.dionne@auristor.com>
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
 

