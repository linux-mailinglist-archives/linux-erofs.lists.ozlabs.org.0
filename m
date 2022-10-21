Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766DE6072DD
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 10:49:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mtynd2QdVz3dqr
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 19:49:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtynX1lgZz3ds0
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 19:49:20 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSikm2i_1666342154;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VSikm2i_1666342154)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 16:49:16 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com,
	xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs: use netfs helpers manipulating request and subrequest
Date: Fri, 21 Oct 2022 16:49:12 +0800
Message-Id: <20221021084912.61468-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221021084912.61468-1-jefflexu@linux.alibaba.com>
References: <20221021084912.61468-1-jefflexu@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, jlayton@kernel.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use netfs_put_subrequest() and netfs_rreq_completed() completing request
and subrequest.

It is worth noting that a noop netfs_request_ops is introduced for erofs
since some netfs routine, e.g. netfs_free_request(), will call into
this ops.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 47 ++++++++++------------------------------------
 1 file changed, 10 insertions(+), 37 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index fe05bc51f9f2..fa3f4ab5e3b6 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2022, Bytedance Inc. All rights reserved.
  */
 #include <linux/fscache.h>
+#include <trace/events/netfs.h>
 #include "internal.h"
 
 static DEFINE_MUTEX(erofs_domain_list_lock);
@@ -11,6 +12,8 @@ static DEFINE_MUTEX(erofs_domain_cookies_lock);
 static LIST_HEAD(erofs_domain_list);
 static struct vfsmount *erofs_pseudo_mnt;
 
+static const struct netfs_request_ops erofs_noop_req_ops;
+
 static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
 					     loff_t start, size_t len)
 {
@@ -24,40 +27,12 @@ static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space
 	rreq->len	= len;
 	rreq->mapping	= mapping;
 	rreq->inode	= mapping->host;
+	rreq->netfs_ops	= &erofs_noop_req_ops;
 	INIT_LIST_HEAD(&rreq->subrequests);
 	refcount_set(&rreq->ref, 1);
 	return rreq;
 }
 
-static void erofs_fscache_put_request(struct netfs_io_request *rreq)
-{
-	if (!refcount_dec_and_test(&rreq->ref))
-		return;
-	if (rreq->cache_resources.ops)
-		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
-	kfree(rreq);
-}
-
-static void erofs_fscache_put_subrequest(struct netfs_io_subrequest *subreq)
-{
-	if (!refcount_dec_and_test(&subreq->ref))
-		return;
-	erofs_fscache_put_request(subreq->rreq);
-	kfree(subreq);
-}
-
-static void erofs_fscache_clear_subrequests(struct netfs_io_request *rreq)
-{
-	struct netfs_io_subrequest *subreq;
-
-	while (!list_empty(&rreq->subrequests)) {
-		subreq = list_first_entry(&rreq->subrequests,
-				struct netfs_io_subrequest, rreq_link);
-		list_del(&subreq->rreq_link);
-		erofs_fscache_put_subrequest(subreq);
-	}
-}
-
 static void erofs_fscache_rreq_unlock_folios(struct netfs_io_request *rreq)
 {
 	struct netfs_io_subrequest *subreq;
@@ -114,11 +89,10 @@ static void erofs_fscache_rreq_unlock_folios(struct netfs_io_request *rreq)
 static void erofs_fscache_rreq_complete(struct netfs_io_request *rreq)
 {
 	erofs_fscache_rreq_unlock_folios(rreq);
-	erofs_fscache_clear_subrequests(rreq);
-	erofs_fscache_put_request(rreq);
+	netfs_rreq_completed(rreq, false);
 }
 
-static void erofc_fscache_subreq_complete(void *priv,
+static void erofs_fscache_subreq_complete(void *priv,
 		ssize_t transferred_or_error, bool was_async)
 {
 	struct netfs_io_subrequest *subreq = priv;
@@ -130,7 +104,7 @@ static void erofc_fscache_subreq_complete(void *priv,
 	if (atomic_dec_and_test(&rreq->nr_outstanding))
 		erofs_fscache_rreq_complete(rreq);
 
-	erofs_fscache_put_subrequest(subreq);
+	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_terminated);
 }
 
 /*
@@ -171,9 +145,8 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 		}
 
 		subreq->start = pstart + done;
-		subreq->len	=  len - done;
+		subreq->len   =  len - done;
 		subreq->flags = 1 << NETFS_SREQ_ONDEMAND;
-
 		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
 
 		source = cres->ops->prepare_read(subreq, LLONG_MAX);
@@ -184,7 +157,7 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 				  source);
 			ret = -EIO;
 			subreq->error = ret;
-			erofs_fscache_put_subrequest(subreq);
+			netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_failed);
 			goto out;
 		}
 
@@ -195,7 +168,7 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 
 		ret = fscache_read(cres, subreq->start, &iter,
 				   NETFS_READ_HOLE_FAIL,
-				   erofc_fscache_subreq_complete, subreq);
+				   erofs_fscache_subreq_complete, subreq);
 		if (ret == -EIOCBQUEUED)
 			ret = 0;
 		if (ret) {
-- 
2.19.1.6.gb485710b

