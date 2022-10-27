Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7ED60F277
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Oct 2022 10:36:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MyfCb5R3vz3cHY
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Oct 2022 19:36:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MyfCJ5fjxz3bdC
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Oct 2022 19:35:56 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VTAawYM_1666859751;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTAawYM_1666859751)
          by smtp.aliyun-inc.com;
          Thu, 27 Oct 2022 16:35:52 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	linux-cachefs@redhat.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/9] fscache,netfs: rename netfs_io_terminated_t as fscache_io_terminated_t
Date: Thu, 27 Oct 2022 16:35:41 +0800
Message-Id: <20221027083547.46933-4-jefflexu@linux.alibaba.com>
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

Rename netfs_io_terminated_t as fscache_io_terminated_t to make raw
fscache APIs more neutral independent on libnetfs.

This is a cleanup without logic change.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/internal.h | 2 +-
 fs/cachefiles/io.c       | 8 ++++----
 fs/fscache/io.c          | 4 ++--
 include/linux/fscache.h  | 8 ++++----
 include/linux/netfs.h    | 6 +++---
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 2ad58c465208..897cc01b8b56 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -239,7 +239,7 @@ extern int __cachefiles_write(struct cachefiles_object *object,
 			      struct file *file,
 			      loff_t start_pos,
 			      struct iov_iter *iter,
-			      netfs_io_terminated_t term_func,
+			      fscache_io_terminated_t term_func,
 			      void *term_func_priv);
 
 /*
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 9214060b4781..6931032b837c 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -23,7 +23,7 @@ struct cachefiles_kiocb {
 		size_t		len;
 	};
 	struct cachefiles_object *object;
-	netfs_io_terminated_t	term_func;
+	fscache_io_terminated_t	term_func;
 	void			*term_func_priv;
 	bool			was_async;
 	unsigned int		inval_counter;	/* Copy of cookie->inval_counter */
@@ -74,7 +74,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 			   loff_t start_pos,
 			   struct iov_iter *iter,
 			   enum netfs_read_from_hole read_hole,
-			   netfs_io_terminated_t term_func,
+			   fscache_io_terminated_t term_func,
 			   void *term_func_priv)
 {
 	struct cachefiles_object *object;
@@ -281,7 +281,7 @@ int __cachefiles_write(struct cachefiles_object *object,
 		       struct file *file,
 		       loff_t start_pos,
 		       struct iov_iter *iter,
-		       netfs_io_terminated_t term_func,
+		       fscache_io_terminated_t term_func,
 		       void *term_func_priv)
 {
 	struct cachefiles_cache *cache;
@@ -370,7 +370,7 @@ int __cachefiles_write(struct cachefiles_object *object,
 static int cachefiles_write(struct netfs_cache_resources *cres,
 			    loff_t start_pos,
 			    struct iov_iter *iter,
-			    netfs_io_terminated_t term_func,
+			    fscache_io_terminated_t term_func,
 			    void *term_func_priv)
 {
 	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE)) {
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 3af3b08a9bb3..3ef93fdcb3b3 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -204,7 +204,7 @@ struct fscache_write_request {
 	loff_t			start;
 	size_t			len;
 	bool			set_bits;
-	netfs_io_terminated_t	term_func;
+	fscache_io_terminated_t	term_func;
 	void			*term_func_priv;
 };
 
@@ -248,7 +248,7 @@ static void fscache_wreq_done(void *priv, ssize_t transferred_or_error,
 void __fscache_write_to_cache(struct fscache_cookie *cookie,
 			      struct address_space *mapping,
 			      loff_t start, size_t len, loff_t i_size,
-			      netfs_io_terminated_t term_func,
+			      fscache_io_terminated_t term_func,
 			      void *term_func_priv,
 			      bool cond)
 {
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 36e5dd84cf59..ee8e14f142e8 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -173,7 +173,7 @@ extern int __fscache_begin_read_operation(struct netfs_cache_resources *, struct
 extern int __fscache_begin_write_operation(struct netfs_cache_resources *, struct fscache_cookie *);
 
 extern void __fscache_write_to_cache(struct fscache_cookie *, struct address_space *,
-				     loff_t, size_t, loff_t, netfs_io_terminated_t, void *,
+				     loff_t, size_t, loff_t, fscache_io_terminated_t, void *,
 				     bool);
 extern void __fscache_clear_page_bits(struct address_space *, loff_t, size_t);
 
@@ -508,7 +508,7 @@ int fscache_read(struct netfs_cache_resources *cres,
 		 loff_t start_pos,
 		 struct iov_iter *iter,
 		 enum netfs_read_from_hole read_hole,
-		 netfs_io_terminated_t term_func,
+		 fscache_io_terminated_t term_func,
 		 void *term_func_priv)
 {
 	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
@@ -566,7 +566,7 @@ static inline
 int fscache_write(struct netfs_cache_resources *cres,
 		  loff_t start_pos,
 		  struct iov_iter *iter,
-		  netfs_io_terminated_t term_func,
+		  fscache_io_terminated_t term_func,
 		  void *term_func_priv)
 {
 	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
@@ -617,7 +617,7 @@ static inline void fscache_clear_page_bits(struct address_space *mapping,
 static inline void fscache_write_to_cache(struct fscache_cookie *cookie,
 					  struct address_space *mapping,
 					  loff_t start, size_t len, loff_t i_size,
-					  netfs_io_terminated_t term_func,
+					  fscache_io_terminated_t term_func,
 					  void *term_func_priv,
 					  bool caching)
 {
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 4cd7341c79b4..2cac478607a8 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -115,7 +115,7 @@ enum fscache_io_source {
 	FSCACHE_INVALID_READ,
 } __mode(byte);
 
-typedef void (*netfs_io_terminated_t)(void *priv, ssize_t transferred_or_error,
+typedef void (*fscache_io_terminated_t)(void *priv, ssize_t transferred_or_error,
 				      bool was_async);
 
 /*
@@ -240,14 +240,14 @@ struct netfs_cache_ops {
 		    loff_t start_pos,
 		    struct iov_iter *iter,
 		    enum netfs_read_from_hole read_hole,
-		    netfs_io_terminated_t term_func,
+		    fscache_io_terminated_t term_func,
 		    void *term_func_priv);
 
 	/* Write data to the cache */
 	int (*write)(struct netfs_cache_resources *cres,
 		     loff_t start_pos,
 		     struct iov_iter *iter,
-		     netfs_io_terminated_t term_func,
+		     fscache_io_terminated_t term_func,
 		     void *term_func_priv);
 
 	/* Expand readahead request */
-- 
2.19.1.6.gb485710b

