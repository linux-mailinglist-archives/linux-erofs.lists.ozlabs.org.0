Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4832660F27A
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Oct 2022 10:36:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MyfCm1dFCz3cGm
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Oct 2022 19:36:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MyfCQ0crtz2y84
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Oct 2022 19:36:01 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VTAl7c2_1666859756;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTAl7c2_1666859756)
          by smtp.aliyun-inc.com;
          Thu, 27 Oct 2022 16:35:57 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	linux-cachefs@redhat.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 7/9] fscache,netfs: define flags for prepare_read()
Date: Thu, 27 Oct 2022 16:35:45 +0800
Message-Id: <20221027083547.46933-8-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221027083547.46933-1-jefflexu@linux.alibaba.com>
References: <20221027083547.46933-1-jefflexu@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Decouple flags used in prepare_read() from netfs_io_subrequest flags to
make raw fscache APIs more neutral independent on libnetfs.  Currently
only *REQ_[COPY_TO_CACHE|ONDEMAND] flags are exposed to fscache, thus
define these two flags for fscache variant, while keep other
netfs_io_subrequest flags untouched.

This is a cleanup without logic change.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/io.c      | 10 +++++-----
 fs/erofs/fscache.c      |  5 +++--
 fs/netfs/io.c           | 14 ++++++++++----
 include/linux/fscache.h |  3 +++
 include/linux/netfs.h   |  1 -
 5 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 9aace92a7503..a9c7463eb3e1 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -415,9 +415,9 @@ static enum fscache_io_source cachefiles_prepare_read(struct fscache_resources *
 	}
 
 	if (test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags)) {
-		__set_bit(NETFS_SREQ_COPY_TO_CACHE, _flags);
+		__set_bit(FSCACHE_REQ_COPY_TO_CACHE, _flags);
 		why = cachefiles_trace_read_no_data;
-		if (!test_bit(NETFS_SREQ_ONDEMAND, _flags))
+		if (!test_bit(FSCACHE_REQ_ONDEMAND, _flags))
 			goto out_no_object;
 	}
 
@@ -487,11 +487,11 @@ static enum fscache_io_source cachefiles_prepare_read(struct fscache_resources *
 	goto out;
 
 download_and_store:
-	__set_bit(NETFS_SREQ_COPY_TO_CACHE, _flags);
-	if (test_bit(NETFS_SREQ_ONDEMAND, _flags)) {
+	__set_bit(FSCACHE_REQ_COPY_TO_CACHE, _flags);
+	if (test_bit(FSCACHE_REQ_ONDEMAND, _flags)) {
 		rc = cachefiles_ondemand_read(object, start, len);
 		if (!rc) {
-			__clear_bit(NETFS_SREQ_ONDEMAND, _flags);
+			__clear_bit(FSCACHE_REQ_ONDEMAND, _flags);
 			goto retry;
 		}
 		ret = FSCACHE_INVALID_READ;
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 6fbdf067a669..e30a42a35ae7 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -148,6 +148,7 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 	struct iov_iter iter;
 	loff_t start = rreq->start;
 	size_t len = rreq->len;
+	unsigned long flags;
 	size_t done = 0;
 	int ret;
 
@@ -172,12 +173,12 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 
 		subreq->start = pstart + done;
 		subreq->len	=  len - done;
-		subreq->flags = 1 << NETFS_SREQ_ONDEMAND;
 
 		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
 
+		flags = 1 << FSCACHE_REQ_ONDEMAND;
 		source = cres->ops->prepare_read(cres, &subreq->start,
-				&subreq->len, &subreq->flags, LLONG_MAX);
+				&subreq->len, &flags, LLONG_MAX);
 		if (WARN_ON(subreq->len == 0))
 			source = FSCACHE_INVALID_READ;
 		if (source != FSCACHE_READ_FROM_CACHE) {
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 7fd2627e259a..13ac74f2e32f 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -485,10 +485,16 @@ static enum fscache_io_source netfs_cache_prepare_read(struct netfs_io_subreques
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct fscache_resources *cres = &rreq->cache_resources;
-
-	if (cres->ops)
-		return cres->ops->prepare_read(cres, &subreq->start,
-				&subreq->len, &subreq->flags, i_size);
+	enum fscache_io_source source;
+	unsigned long flags = 0;
+
+	if (cres->ops) {
+		source = cres->ops->prepare_read(cres, &subreq->start,
+				&subreq->len, &flags, i_size);
+		if (test_bit(FSCACHE_REQ_COPY_TO_CACHE, &flags))
+			__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
+		return source;
+	}
 	if (subreq->start >= rreq->i_size)
 		return FSCACHE_FILL_WITH_ZEROES;
 	return FSCACHE_DOWNLOAD_FROM_SERVER;
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index e955df30845b..9df2988be804 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -147,6 +147,9 @@ struct fscache_cookie {
 	};
 };
 
+#define FSCACHE_REQ_COPY_TO_CACHE	0	/* Set if should copy the data to the cache */
+#define FSCACHE_REQ_ONDEMAND		1	/* Set if it's from on-demand read mode */
+
 /*
  * slow-path functions for when there is actually caching available, and the
  * netfs does actually have a valid token
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 91a4382cbd1f..146a13e6a9d2 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -160,7 +160,6 @@ struct netfs_io_subrequest {
 #define NETFS_SREQ_SHORT_IO		2	/* Set if the I/O was short */
 #define NETFS_SREQ_SEEK_DATA_READ	3	/* Set if ->read() should SEEK_DATA first */
 #define NETFS_SREQ_NO_PROGRESS		4	/* Set if we didn't manage to read any data */
-#define NETFS_SREQ_ONDEMAND		5	/* Set if it's from on-demand read mode */
 };
 
 enum netfs_io_origin {
-- 
2.19.1.6.gb485710b

