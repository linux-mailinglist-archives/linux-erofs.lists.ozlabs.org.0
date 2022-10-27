Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8755960F288
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Oct 2022 10:36:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MyfCt3SK9z3c8C
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Oct 2022 19:36:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.18; helo=out199-18.us.a.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MyfCR2kzRz3cCX
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Oct 2022 19:36:02 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VTAtIeX_1666859754;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTAtIeX_1666859754)
          by smtp.aliyun-inc.com;
          Thu, 27 Oct 2022 16:35:55 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	linux-cachefs@redhat.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 5/9] fscache,netfs: rename netfs_cache_ops as fscache_ops
Date: Thu, 27 Oct 2022 16:35:43 +0800
Message-Id: <20221027083547.46933-6-jefflexu@linux.alibaba.com>
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

Rename netfs_cache_ops as fscache_ops to make raw fscache APIs more
neutral independent on libnetfs.

This is a cleanup without logic change.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/io.c      | 4 ++--
 include/linux/fscache.h | 8 ++++----
 include/linux/netfs.h   | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 2dce7af0fbcf..ff4d8a309d51 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -617,7 +617,7 @@ static void cachefiles_end_operation(struct netfs_cache_resources *cres)
 	fscache_end_cookie_access(fscache_cres_cookie(cres), fscache_access_io_end);
 }
 
-static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
+static const struct fscache_ops cachefiles_fscache_ops = {
 	.end_operation		= cachefiles_end_operation,
 	.read			= cachefiles_read,
 	.write			= cachefiles_write,
@@ -635,7 +635,7 @@ bool cachefiles_begin_operation(struct netfs_cache_resources *cres,
 	struct cachefiles_object *object = cachefiles_cres_object(cres);
 
 	if (!cachefiles_cres_file(cres)) {
-		cres->ops = &cachefiles_netfs_cache_ops;
+		cres->ops = &cachefiles_fscache_ops;
 		if (object->file) {
 			spin_lock(&object->lock);
 			if (!cres->cache_priv2 && object->file)
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 80455e00c520..d6546dc714b8 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -423,7 +423,7 @@ void fscache_invalidate(struct fscache_cookie *cookie,
  * Returns a pointer to the operations table if usable or NULL if not.
  */
 static inline
-const struct netfs_cache_ops *fscache_operation_valid(const struct netfs_cache_resources *cres)
+const struct fscache_ops *fscache_operation_valid(const struct netfs_cache_resources *cres)
 {
 	return fscache_resources_valid(cres) ? cres->ops : NULL;
 }
@@ -466,7 +466,7 @@ int fscache_begin_read_operation(struct netfs_cache_resources *cres,
  */
 static inline void fscache_end_operation(struct netfs_cache_resources *cres)
 {
-	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+	const struct fscache_ops *ops = fscache_operation_valid(cres);
 
 	if (ops)
 		ops->end_operation(cres);
@@ -511,7 +511,7 @@ int fscache_read(struct netfs_cache_resources *cres,
 		 fscache_io_terminated_t term_func,
 		 void *term_func_priv)
 {
-	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+	const struct fscache_ops *ops = fscache_operation_valid(cres);
 	return ops->read(cres, start_pos, iter, read_hole,
 			 term_func, term_func_priv);
 }
@@ -569,7 +569,7 @@ int fscache_write(struct netfs_cache_resources *cres,
 		  fscache_io_terminated_t term_func,
 		  void *term_func_priv)
 {
-	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+	const struct fscache_ops *ops = fscache_operation_valid(cres);
 	return ops->write(cres, start_pos, iter, term_func, term_func_priv);
 }
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 998402e34c00..2ff3a65458a6 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -134,7 +134,7 @@ struct netfs_inode {
  * Resources required to do operations on a cache.
  */
 struct netfs_cache_resources {
-	const struct netfs_cache_ops	*ops;
+	const struct fscache_ops	*ops;
 	void				*cache_priv;
 	void				*cache_priv2;
 	unsigned int			debug_id;	/* Cookie debug ID */
@@ -231,7 +231,7 @@ enum fscache_read_from_hole {
  * Table of operations for access to a cache.  This is obtained by
  * rreq->ops->begin_cache_operation().
  */
-struct netfs_cache_ops {
+struct fscache_ops {
 	/* End an operation */
 	void (*end_operation)(struct netfs_cache_resources *cres);
 
-- 
2.19.1.6.gb485710b

