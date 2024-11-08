Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838199C2307
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Nov 2024 18:33:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XlQyd4KmMz3c20
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Nov 2024 04:33:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731087207;
	cv=none; b=LBhxYxBrpciEhWM0N/u4tw5zAFRjTaOu6expQt4aAakVYDJ9rAXVGFunp3/YyKvlIv1l+hImLfowLgy94niTTHsigsRhGW+c0QywxtiLHuSVdAik6nw/fy0QTKhKl3pQF32Iv0Tetd0/iQJBml071ZszJpjv/B/Jz5t8PkeTSVRsAWT0lQENMrHdZXw31u2gn7WoKhJ4NZp2ZHHNMIqewbr35NKvPYnQWaYdm5Oj2RlSeu56A1CErI9oAn6aQu26KSpl2yfxih7NMYm9lwP5bwOlVg65PWWxZHGDuXfa0djcdg7kWie+djAHMYnxNcoxJO8c5WeQbyyDsuj6N3QD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731087207; c=relaxed/relaxed;
	bh=2WJ3IwRH8RLBNIi0Kxo/o1E5+hUSf0Z9V2WPyhSRrlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiYMGLniQhHCQJ4QjGoL6a2rmMbpifLfa44WpgDnuWMp1kgUKWtfZ69qLO8zbjg3I47J1SgmNE7pJsyc6j9Rt1wyGfWQEazyx0SkNhpJEQ7oKbODqLUW/1KJ1OhSYUBACnnN2hJqRvBsMl/ZkaW5Ynn3IyVBlrLRc4nkRxmDhqWeKcV3xRPdL0oi9S7RButVGIHIUkLKucv3c531q3ZF4eauGJmSaISZQHVuROJI552HIcFtLyBrPzO2JrRtJPbt3fqiOQ8dIx5VWhrbjErHs9RBLq5vvOJ6aFLX7+wkw0FS8O2c9DfcTgDlp0fty5eCkcR/bNQRqk/Gk5rP7uV1Kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N0/qcLWJ; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N0/qcLWJ; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N0/qcLWJ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N0/qcLWJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XlQyZ5zM5z3bkY
	for <linux-erofs@lists.ozlabs.org>; Sat,  9 Nov 2024 04:33:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731087204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WJ3IwRH8RLBNIi0Kxo/o1E5+hUSf0Z9V2WPyhSRrlg=;
	b=N0/qcLWJtUb6I6Ew8vTH1XPZ6RQdhGePB4fhkvjepFCom5kS8vkEX2SPhsRalCvAeT8RLC
	wY3w4AJFg+7sFY3UJpwuhGbKEW2hvo3BqMDSbXWWZkMWRuH/W2L+wkdk5UHlkCPNvSDz37
	daBiKZnIoAFsdBz5+wWZ5HPpQh+miN4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731087204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WJ3IwRH8RLBNIi0Kxo/o1E5+hUSf0Z9V2WPyhSRrlg=;
	b=N0/qcLWJtUb6I6Ew8vTH1XPZ6RQdhGePB4fhkvjepFCom5kS8vkEX2SPhsRalCvAeT8RLC
	wY3w4AJFg+7sFY3UJpwuhGbKEW2hvo3BqMDSbXWWZkMWRuH/W2L+wkdk5UHlkCPNvSDz37
	daBiKZnIoAFsdBz5+wWZ5HPpQh+miN4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-5-atHLbkMQ6QM_uhS-NvvQ-1; Fri,
 08 Nov 2024 12:33:20 -0500
X-MC-Unique: 5-atHLbkMQ6QM_uhS-NvvQ-1
X-Mimecast-MFC-AGG-ID: 5-atHLbkMQ6QM_uhS-NvvQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1189219541BE;
	Fri,  8 Nov 2024 17:33:16 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C637300019E;
	Fri,  8 Nov 2024 17:33:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 04/33] netfs: Remove unnecessary references to pages
Date: Fri,  8 Nov 2024 17:32:05 +0000
Message-ID: <20241108173236.1382366-5-dhowells@redhat.com>
In-Reply-To: <20241108173236.1382366-1-dhowells@redhat.com>
References: <20241108173236.1382366-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Christian Brauner <brauner@kernel.org>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

These places should all use folios instead of pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20241005182307.3190401-4-willy@infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/netfs/buffered_read.c  |  8 ++++----
 fs/netfs/buffered_write.c | 14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index af46a598f4d7..7ac34550c403 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -627,7 +627,7 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
 	if (unlikely(always_fill)) {
 		if (pos - offset + len <= i_size)
 			return false; /* Page entirely before EOF */
-		zero_user_segment(&folio->page, 0, plen);
+		folio_zero_segment(folio, 0, plen);
 		folio_mark_uptodate(folio);
 		return true;
 	}
@@ -646,7 +646,7 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
 
 	return false;
 zero_out:
-	zero_user_segments(&folio->page, 0, offset, offset + len, plen);
+	folio_zero_segments(folio, 0, offset, offset + len, plen);
 	return true;
 }
 
@@ -713,7 +713,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	if (folio_test_uptodate(folio))
 		goto have_folio;
 
-	/* If the page is beyond the EOF, we want to clear it - unless it's
+	/* If the folio is beyond the EOF, we want to clear it - unless it's
 	 * within the cache granule containing the EOF, in which case we need
 	 * to preload the granule.
 	 */
@@ -773,7 +773,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 EXPORT_SYMBOL(netfs_write_begin);
 
 /*
- * Preload the data into a page we're proposing to write into.
+ * Preload the data into a folio we're proposing to write into.
  */
 int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 			     size_t offset, size_t len)
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index ff2814da88b1..b4826360a411 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -83,13 +83,13 @@ static void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
  * netfs_perform_write - Copy data into the pagecache.
  * @iocb: The operation parameters
  * @iter: The source buffer
- * @netfs_group: Grouping for dirty pages (eg. ceph snaps).
+ * @netfs_group: Grouping for dirty folios (eg. ceph snaps).
  *
- * Copy data into pagecache pages attached to the inode specified by @iocb.
+ * Copy data into pagecache folios attached to the inode specified by @iocb.
  * The caller must hold appropriate inode locks.
  *
- * Dirty pages are tagged with a netfs_folio struct if they're not up to date
- * to indicate the range modified.  Dirty pages may also be tagged with a
+ * Dirty folios are tagged with a netfs_folio struct if they're not up to date
+ * to indicate the range modified.  Dirty folios may also be tagged with a
  * netfs-specific grouping such that data from an old group gets flushed before
  * a new one is started.
  */
@@ -223,11 +223,11 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		 * we try to read it.
 		 */
 		if (fpos >= ctx->zero_point) {
-			zero_user_segment(&folio->page, 0, offset);
+			folio_zero_segment(folio, 0, offset);
 			copied = copy_folio_from_iter_atomic(folio, offset, part, iter);
 			if (unlikely(copied == 0))
 				goto copy_failed;
-			zero_user_segment(&folio->page, offset + copied, flen);
+			folio_zero_segment(folio, offset + copied, flen);
 			__netfs_set_group(folio, netfs_group);
 			folio_mark_uptodate(folio);
 			trace_netfs_folio(folio, netfs_modify_and_clear);
@@ -407,7 +407,7 @@ EXPORT_SYMBOL(netfs_perform_write);
  * netfs_buffered_write_iter_locked - write data to a file
  * @iocb:	IO state structure (file, offset, etc.)
  * @from:	iov_iter with data to write
- * @netfs_group: Grouping for dirty pages (eg. ceph snaps).
+ * @netfs_group: Grouping for dirty folios (eg. ceph snaps).
  *
  * This function does all the work needed for actually writing data to a
  * file. It does all basic checks, removes SUID from the file, updates

