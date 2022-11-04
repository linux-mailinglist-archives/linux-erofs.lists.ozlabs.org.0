Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5C86191D9
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Nov 2022 08:26:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N3XJ00Npwz3cd2
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Nov 2022 18:26:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54; helo=out30-54.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N3XHn5Bt2z2yyZ
	for <linux-erofs@lists.ozlabs.org>; Fri,  4 Nov 2022 18:26:44 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VTvwsEP_1667546799;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTvwsEP_1667546799)
          by smtp.aliyun-inc.com;
          Fri, 04 Nov 2022 15:26:40 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	xiang@kernel.org,
	chao@kernel.org,
	linux-cachefs@redhat.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] fscache,cachefiles: add prepare_ondemand_read() callback
Date: Fri,  4 Nov 2022 15:26:36 +0800
Message-Id: <20221104072637.72375-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221104072637.72375-1-jefflexu@linux.alibaba.com>
References: <20221104072637.72375-1-jefflexu@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add prepare_ondemand_read() callback dedicated for the on-demand read
scenario, so that callers from this scenario can be decoupled from
netfs_io_subrequest.

To reuse the hole detecting logic as mush as possible, both the
implementation of prepare_read() and prepare_ondemand_read() inside
Cachefiles call a common routine.

In the near future, prepare_read() will get enhanced and more
information will be needed and then returned to callers. Thus
netfs_io_subrequest is a reasonable candidate for holding places for all
these information needed in the internal implementation.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/io.c                | 42 +++++++++++++++++++++++++------
 include/linux/netfs.h             |  7 ++++++
 include/trace/events/cachefiles.h |  4 +--
 3 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 000a28f46e59..6427259fcba9 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -385,16 +385,11 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 				  term_func, term_func_priv);
 }
 
-/*
- * Prepare a read operation, shortening it to a cached/uncached
- * boundary as appropriate.
- */
-static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
-						      loff_t i_size)
+static enum netfs_io_source cachefiles_do_prepare_read(struct netfs_io_subrequest *subreq,
+						       struct netfs_cache_resources *cres,
+						       loff_t i_size)
 {
 	enum cachefiles_prepare_read_trace why;
-	struct netfs_io_request *rreq = subreq->rreq;
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	struct fscache_cookie *cookie = fscache_cres_cookie(cres);
@@ -501,6 +496,36 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 	return ret;
 }
 
+/*
+ * Prepare a read operation, shortening it to a cached/uncached
+ * boundary as appropriate.
+ */
+static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
+						      loff_t i_size)
+{
+	return cachefiles_do_prepare_read(subreq,
+			&subreq->rreq->cache_resources, i_size);
+}
+
+/*
+ * Prepare an on-demand read operation, shortening it to a cached/uncached
+ * boundary as appropriate.
+ */
+static enum netfs_io_source cachefiles_prepare_ondemand_read(struct netfs_cache_resources *cres,
+		loff_t start, size_t *_len, loff_t i_size)
+{
+	enum netfs_io_source source;
+	struct netfs_io_subrequest subreq = {
+		.start	= start,
+		.len	= *_len,
+		.flags	= 1 << NETFS_SREQ_ONDEMAND,
+	};
+
+	source = cachefiles_do_prepare_read(&subreq, cres, i_size);
+	*_len = subreq.len;
+	return source;
+}
+
 /*
  * Prepare for a write to occur.
  */
@@ -621,6 +646,7 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 	.write			= cachefiles_write,
 	.prepare_read		= cachefiles_prepare_read,
 	.prepare_write		= cachefiles_prepare_write,
+	.prepare_ondemand_read	= cachefiles_prepare_ondemand_read,
 	.query_occupancy	= cachefiles_query_occupancy,
 };
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index f2402ddeafbf..d82071c37133 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -267,6 +267,13 @@ struct netfs_cache_ops {
 			     loff_t *_start, size_t *_len, loff_t i_size,
 			     bool no_space_allocated_yet);
 
+	/* Prepare an on-demand read operation, shortening it to a cached/uncached
+	 * boundary as appropriate.
+	 */
+	enum netfs_io_source (*prepare_ondemand_read)(struct netfs_cache_resources *cres,
+						      loff_t start, size_t *_len,
+						      loff_t i_size);
+
 	/* Query the occupancy of the cache in a region, returning where the
 	 * next chunk of data starts and how long it is.
 	 */
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index d8d4d73fe7b6..655d5900b8ef 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -448,14 +448,14 @@ TRACE_EVENT(cachefiles_prep_read,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->rreq	= sreq->rreq->debug_id;
+		    __entry->rreq	= sreq->rreq ? sreq->rreq->debug_id : 0;
 		    __entry->index	= sreq->debug_index;
 		    __entry->flags	= sreq->flags;
 		    __entry->source	= source;
 		    __entry->why	= why;
 		    __entry->len	= sreq->len;
 		    __entry->start	= sreq->start;
-		    __entry->netfs_inode = sreq->rreq->inode->i_ino;
+		    __entry->netfs_inode = sreq->rreq ? sreq->rreq->inode->i_ino : 0;
 		    __entry->cache_inode = cache_inode;
 			   ),
 
-- 
2.19.1.6.gb485710b

