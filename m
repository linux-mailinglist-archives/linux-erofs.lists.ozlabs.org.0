Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8B5502A65
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Apr 2022 14:42:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kfwvp0817z3fTm
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Apr 2022 22:42:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kfwmq4gb0z3ds4
 for <linux-erofs@lists.ozlabs.org>; Fri, 15 Apr 2022 22:36:26 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=19; SR=0; TI=SMTPD_---0VA7GjEt_1650026176; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VA7GjEt_1650026176) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 15 Apr 2022 20:36:17 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v9 01/21] cachefiles: extract write routine
Date: Fri, 15 Apr 2022 20:35:54 +0800
Message-Id: <20220415123614.54024-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
References: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, fannaihao@baidu.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, zhangjiachen.jaycee@bytedance.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Extract the generic routine of writing data to cache files, and make it
generally available.

This will be used by the following patch implementing on-demand read
mode. Since it's called inside cachefiles module in this case, make the
interface generic and unrelated to netfs_cache_resources.

It is worth noting that, ki->inval_counter is not initialized after
this cleanup. It shall not make any visible difference, since
inval_counter is no longer used in the write completion routine, i.e.
cachefiles_write_complete().

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/internal.h | 10 +++++++
 fs/cachefiles/io.c       | 61 +++++++++++++++++++++++-----------------
 2 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index c793d33b0224..e80673d0ab97 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -201,6 +201,16 @@ extern void cachefiles_put_object(struct cachefiles_object *object,
  */
 extern bool cachefiles_begin_operation(struct netfs_cache_resources *cres,
 				       enum fscache_want_state want_state);
+extern int __cachefiles_prepare_write(struct cachefiles_object *object,
+				      struct file *file,
+				      loff_t *_start, size_t *_len,
+				      bool no_space_allocated_yet);
+extern int __cachefiles_write(struct cachefiles_object *object,
+			      struct file *file,
+			      loff_t start_pos,
+			      struct iov_iter *iter,
+			      netfs_io_terminated_t term_func,
+			      void *term_func_priv);
 
 /*
  * key.c
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 9dc81e781f2b..50a14e8f0aac 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -277,36 +277,33 @@ static void cachefiles_write_complete(struct kiocb *iocb, long ret)
 /*
  * Initiate a write to the cache.
  */
-static int cachefiles_write(struct netfs_cache_resources *cres,
-			    loff_t start_pos,
-			    struct iov_iter *iter,
-			    netfs_io_terminated_t term_func,
-			    void *term_func_priv)
+int __cachefiles_write(struct cachefiles_object *object,
+		       struct file *file,
+		       loff_t start_pos,
+		       struct iov_iter *iter,
+		       netfs_io_terminated_t term_func,
+		       void *term_func_priv)
 {
-	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	struct cachefiles_kiocb *ki;
 	struct inode *inode;
-	struct file *file;
 	unsigned int old_nofs;
-	ssize_t ret = -ENOBUFS;
+	ssize_t ret;
 	size_t len = iov_iter_count(iter);
 
-	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE))
-		goto presubmission_error;
 	fscache_count_write();
-	object = cachefiles_cres_object(cres);
 	cache = object->volume->cache;
-	file = cachefiles_cres_file(cres);
 
 	_enter("%pD,%li,%llx,%zx/%llx",
 	       file, file_inode(file)->i_ino, start_pos, len,
 	       i_size_read(file_inode(file)));
 
-	ret = -ENOMEM;
 	ki = kzalloc(sizeof(struct cachefiles_kiocb), GFP_KERNEL);
-	if (!ki)
-		goto presubmission_error;
+	if (!ki) {
+		if (term_func)
+			term_func(term_func_priv, -ENOMEM, false);
+		return -ENOMEM;
+	}
 
 	refcount_set(&ki->ki_refcnt, 2);
 	ki->iocb.ki_filp	= file;
@@ -314,7 +311,6 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE;
 	ki->iocb.ki_ioprio	= get_current_ioprio();
 	ki->object		= object;
-	ki->inval_counter	= cres->inval_counter;
 	ki->start		= start_pos;
 	ki->len			= len;
 	ki->term_func		= term_func;
@@ -369,11 +365,24 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 	cachefiles_put_kiocb(ki);
 	_leave(" = %zd", ret);
 	return ret;
+}
 
-presubmission_error:
-	if (term_func)
-		term_func(term_func_priv, ret, false);
-	return ret;
+static int cachefiles_write(struct netfs_cache_resources *cres,
+			    loff_t start_pos,
+			    struct iov_iter *iter,
+			    netfs_io_terminated_t term_func,
+			    void *term_func_priv)
+{
+	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE)) {
+		if (term_func)
+			term_func(term_func_priv, -ENOBUFS, false);
+		return -ENOBUFS;
+	}
+
+	return __cachefiles_write(cachefiles_cres_object(cres),
+				  cachefiles_cres_file(cres),
+				  start_pos, iter,
+				  term_func, term_func_priv);
 }
 
 /*
@@ -484,13 +493,12 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 /*
  * Prepare for a write to occur.
  */
-static int __cachefiles_prepare_write(struct netfs_cache_resources *cres,
-				      loff_t *_start, size_t *_len, loff_t i_size,
-				      bool no_space_allocated_yet)
+int __cachefiles_prepare_write(struct cachefiles_object *object,
+			       struct file *file,
+			       loff_t *_start, size_t *_len,
+			       bool no_space_allocated_yet)
 {
-	struct cachefiles_object *object = cachefiles_cres_object(cres);
 	struct cachefiles_cache *cache = object->volume->cache;
-	struct file *file = cachefiles_cres_file(cres);
 	loff_t start = *_start, pos;
 	size_t len = *_len, down;
 	int ret;
@@ -577,7 +585,8 @@ static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
 	}
 
 	cachefiles_begin_secure(cache, &saved_cred);
-	ret = __cachefiles_prepare_write(cres, _start, _len, i_size,
+	ret = __cachefiles_prepare_write(object, cachefiles_cres_file(cres),
+					 _start, _len,
 					 no_space_allocated_yet);
 	cachefiles_end_secure(cache, saved_cred);
 	return ret;
-- 
2.27.0

