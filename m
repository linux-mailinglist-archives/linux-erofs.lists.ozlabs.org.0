Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11C246FBF6
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 08:42:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J9NCF3Y5nz3c59
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 18:42:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J9NC75rFlz3c9V
 for <linux-erofs@lists.ozlabs.org>; Fri, 10 Dec 2021 18:41:55 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R791e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V-8PLPo_1639121789; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V-8PLPo_1639121789) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 10 Dec 2021 15:36:29 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [RFC 08/19] netfs: refactor netfs_clear_unread()
Date: Fri, 10 Dec 2021 15:36:08 +0800
Message-Id: <20211210073619.21667-9-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, eguan@linux.alibaba.com,
 gerry@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In demand-read case, the input folio of netfs API is may not the page
cache inside the address space of the netfs file. Instead it may be just
a temporary page used to contain the data.

In this case, use bvec based iov_iter.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/netfs/read_helper.c | 33 +++++++++++++++++++++++++++------
 include/linux/netfs.h  |  2 ++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 26fa688f6300..04d0cc2fca83 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -157,6 +157,18 @@ static void __netfs_put_subrequest(struct netfs_read_subrequest *subreq,
 	netfs_put_read_request(rreq, was_async);
 }
 
+static void netfs_init_iov_iter_bvec(struct netfs_read_subrequest *subreq,
+				     struct iov_iter *iter)
+{
+	struct bio_vec *bvec = &subreq->bvec;
+
+	bvec->bv_page	= folio_page(subreq->rreq->folio, 0);
+	bvec->bv_offset	= subreq->start + subreq->transferred;
+	bvec->bv_len	= subreq->len   - subreq->transferred;
+
+	iov_iter_bvec(iter, READ, bvec, 1, bvec->bv_len);
+}
+
 /*
  * Clear the unread part of an I/O request.
  */
@@ -164,9 +176,14 @@ static void netfs_clear_unread(struct netfs_read_subrequest *subreq)
 {
 	struct iov_iter iter;
 
-	iov_iter_xarray(&iter, READ, &subreq->rreq->mapping->i_pages,
-			subreq->start + subreq->transferred,
-			subreq->len   - subreq->transferred);
+	if (subreq->rreq->type == NETFS_TYPE_CACHE) {
+		iov_iter_xarray(&iter, READ, &subreq->rreq->mapping->i_pages,
+				subreq->start + subreq->transferred,
+				subreq->len   - subreq->transferred);
+	} else { /* type == NETFS_TYPE_DEMAND */
+		netfs_init_iov_iter_bvec(subreq, &iter);
+	}
+
 	iov_iter_zero(iov_iter_count(&iter), &iter);
 }
 
@@ -190,9 +207,13 @@ static void netfs_read_from_cache(struct netfs_read_request *rreq,
 	struct iov_iter iter;
 
 	netfs_stat(&netfs_n_rh_read);
-	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages,
-			subreq->start + subreq->transferred,
-			subreq->len   - subreq->transferred);
+	if (subreq->rreq->type == NETFS_TYPE_CACHE) {
+		iov_iter_xarray(&iter, READ, &subreq->rreq->mapping->i_pages,
+				subreq->start + subreq->transferred,
+				subreq->len   - subreq->transferred);
+	} else { /* type == NETFS_TYPE_DEMAND */
+		netfs_init_iov_iter_bvec(subreq, &iter);
+	}
 
 	cres->ops->read(cres, subreq->start, &iter, read_hole,
 			netfs_cache_read_terminated, subreq);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index de6948bcc80a..5f45eb31defd 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -17,6 +17,7 @@
 #include <linux/workqueue.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
+#include <linux/bvec.h>
 
 /*
  * Overload PG_private_2 to give us PG_fscache - this is used to indicate that
@@ -146,6 +147,7 @@ struct netfs_read_subrequest {
 #define NETFS_SREQ_SHORT_READ		2	/* Set if there was a short read from the cache */
 #define NETFS_SREQ_SEEK_DATA_READ	3	/* Set if ->read() should SEEK_DATA first */
 #define NETFS_SREQ_NO_PROGRESS		4	/* Set if we didn't manage to read any data */
+	struct bio_vec 		bvec;
 };
 
 enum netfs_read_request_type {
-- 
2.27.0

