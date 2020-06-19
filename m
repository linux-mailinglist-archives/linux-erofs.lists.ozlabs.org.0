Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9EC200566
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2020 11:39:53 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49pDKy24FGzDrPG
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2020 19:39:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=205.139.110.61;
 helo=us-smtp-delivery-1.mimecast.com; envelope-from=agruenba@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=c487tetR; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=c487tetR; 
 dkim-atps=neutral
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49pDKr014KzDrPL
 for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2020 19:39:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592559581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SldHT58QWZEaNH+GrGNea/awooFbiqL4jxPiQBrZZXc=;
 b=c487tetR2rXAgbJcwiKK0g7xbhxs0OhO0VYOS/Gdqj+UiKMjGvFXY+cyjlCrGmsADSiWVS
 GGIBh8Ydwb5/NUrHrzUvzlxlyyxbwJ34h2UxQa3qk0CKxnpqu+v/Ifiae94WBkJf48wGCB
 PUX+QsNT/xmPZVSa8+SmYhJExikhot4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592559581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SldHT58QWZEaNH+GrGNea/awooFbiqL4jxPiQBrZZXc=;
 b=c487tetR2rXAgbJcwiKK0g7xbhxs0OhO0VYOS/Gdqj+UiKMjGvFXY+cyjlCrGmsADSiWVS
 GGIBh8Ydwb5/NUrHrzUvzlxlyyxbwJ34h2UxQa3qk0CKxnpqu+v/Ifiae94WBkJf48wGCB
 PUX+QsNT/xmPZVSa8+SmYhJExikhot4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-SIB5PbDMObCm2YydCZpjNg-1; Fri, 19 Jun 2020 05:39:37 -0400
X-MC-Unique: SIB5PbDMObCm2YydCZpjNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E25C218FF660;
 Fri, 19 Jun 2020 09:39:34 +0000 (UTC)
Received: from max.home.com (unknown [10.40.195.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 258625D9EF;
 Fri, 19 Jun 2020 09:39:26 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] fs: Add IOCB_CACHED flag for generic_file_read_iter
Date: Fri, 19 Jun 2020 11:39:15 +0200
Message-Id: <20200619093916.1081129-2-agruenba@redhat.com>
In-Reply-To: <20200619093916.1081129-1-agruenba@redhat.com>
References: <20200619093916.1081129-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, Junxiao Bi <junxiao.bi@oracle.com>,
 linux-xfs <linux-xfs@vger.kernel.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-erofs@lists.ozlabs.org,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add an IOCB_CACHED flag which indicates to generic_file_read_iter that
it should only regard the page cache, without triggering any filesystem
I/O for the actual request or for readahead.  With this flag, -EAGAIN is
returned when regular I/O would be triggered similar to the IOCB_NOWAIT
flag, and -ECANCELED is returned when readahead would be triggered.

This allows the caller to perform a tentative read out of the page
cache, and to retry the read if the requested pages are not cached.

Please see the next commit for what this is used for.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/fs.h |  1 +
 mm/filemap.c       | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6c4ab4dc1cd7..74eade571b1c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -315,6 +315,7 @@ enum rw_hint {
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
+#define IOCB_CACHED		(1 << 8)
 
 struct kiocb {
 	struct file		*ki_filp;
diff --git a/mm/filemap.c b/mm/filemap.c
index f0ae9a6308cb..bd11f27bf6ae 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2028,7 +2028,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 		page = find_get_page(mapping, index);
 		if (!page) {
-			if (iocb->ki_flags & IOCB_NOWAIT)
+			if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_CACHED))
 				goto would_block;
 			page_cache_sync_readahead(mapping,
 					ra, filp,
@@ -2038,12 +2038,17 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 				goto no_cached_page;
 		}
 		if (PageReadahead(page)) {
+			if (iocb->ki_flags & IOCB_CACHED) {
+				put_page(page);
+				error = -ECANCELED;
+				goto out;
+			}
 			page_cache_async_readahead(mapping,
 					ra, filp, page,
 					index, last_index - index);
 		}
 		if (!PageUptodate(page)) {
-			if (iocb->ki_flags & IOCB_NOWAIT) {
+			if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_CACHED)) {
 				put_page(page);
 				goto would_block;
 			}
@@ -2249,6 +2254,13 @@ EXPORT_SYMBOL_GPL(generic_file_buffered_read);
  *
  * This is the "read_iter()" routine for all filesystems
  * that can use the page cache directly.
+ *
+ * In the IOCB_NOWAIT flag in iocb->ki_flags indicates that -EAGAIN should be
+ * returned if completing the request would require I/O; this does not prevent
+ * readahead.  The IOCB_CACHED flag indicates that -EAGAIN should be returned
+ * as under the IOCB_NOWAIT flag, and that -ECANCELED should be returned when
+ * readhead would be triggered.
+ *
  * Return:
  * * number of bytes copied, even for partial reads
  * * negative error code if nothing was read
-- 
2.26.2

