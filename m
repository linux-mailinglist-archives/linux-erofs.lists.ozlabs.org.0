Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EC795835B6C
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 08:13:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJLzB2MRFz3bnv
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 18:13:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJLz24k82z2yN3
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jan 2024 18:13:00 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.33wn._1705907574;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.33wn._1705907574)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 15:12:54 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: make iov_iter describe target buffer when read from fscache
Date: Mon, 22 Jan 2024 15:12:53 +0800
Message-Id: <20240122071253.119004-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

So far the fscache mode supports uncompressed data only, and the data
read from fscache is put directly into the target page cache.  As the
support for compressed data in fscache mode is going to be introduced,
refactor the interface of reading fscache so that the following
compressed part could make the raw data read from fscache be directed to
the target buffer it wants, decompress the raw data, and finally fill
the page cache with the decompressed data.

As the first step, a new structure, i.e. erofs_fscache_io (cio), is
introduced to describe a generic read request from the fscache, while
the caller can specify the target buffer it wants in the iov_iter
structure (cio->iter).  Besides, the caller can also specify its
completion callback and private data through cio, which will be called
to make further handling, e.g. unlocking the page cache for uncompressed
data or decompressing the read raw data, when the read request from the
fscache completes.  Now erofs_fscache_read_io_async() serves as a
generic interface for reading raw data from fscache for both compressed
and uncompressed data.

The erofs_fscache_request structure is kept to describe a request to
fill the page cache in the specified range.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 219 ++++++++++++++++++++++++---------------------
 1 file changed, 118 insertions(+), 101 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index bc12030393b2..10709f20bef5 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -13,8 +13,6 @@ static LIST_HEAD(erofs_domain_cookies_list);
 static struct vfsmount *erofs_pseudo_mnt;
 
 struct erofs_fscache_request {
-	struct erofs_fscache_request *primary;
-	struct netfs_cache_resources cache_resources;
 	struct address_space	*mapping;	/* The mapping being accessed */
 	loff_t			start;		/* Start position */
 	size_t			len;		/* Length of the request */
@@ -23,42 +21,13 @@ struct erofs_fscache_request {
 	refcount_t		ref;
 };
 
-static struct erofs_fscache_request *erofs_fscache_req_alloc(struct address_space *mapping,
-					     loff_t start, size_t len)
-{
-	struct erofs_fscache_request *req;
-
-	req = kzalloc(sizeof(struct erofs_fscache_request), GFP_KERNEL);
-	if (!req)
-		return ERR_PTR(-ENOMEM);
-
-	req->mapping = mapping;
-	req->start   = start;
-	req->len     = len;
-	refcount_set(&req->ref, 1);
-
-	return req;
-}
-
-static struct erofs_fscache_request *erofs_fscache_req_chain(struct erofs_fscache_request *primary,
-					     size_t len)
-{
-	struct erofs_fscache_request *req;
-
-	/* use primary request for the first submission */
-	if (!primary->submitted) {
-		refcount_inc(&primary->ref);
-		return primary;
-	}
-
-	req = erofs_fscache_req_alloc(primary->mapping,
-			primary->start + primary->submitted, len);
-	if (!IS_ERR(req)) {
-		req->primary = primary;
-		refcount_inc(&primary->ref);
-	}
-	return req;
-}
+struct erofs_fscache_io {
+	struct netfs_cache_resources cache_resources;
+	struct iov_iter		iter;
+	netfs_io_terminated_t	end_io;
+	void			*private;
+	refcount_t		ref;
+};
 
 static void erofs_fscache_req_complete(struct erofs_fscache_request *req)
 {
@@ -83,82 +52,116 @@ static void erofs_fscache_req_complete(struct erofs_fscache_request *req)
 static void erofs_fscache_req_put(struct erofs_fscache_request *req)
 {
 	if (refcount_dec_and_test(&req->ref)) {
-		if (req->cache_resources.ops)
-			req->cache_resources.ops->end_operation(&req->cache_resources);
-		if (!req->primary)
-			erofs_fscache_req_complete(req);
-		else
-			erofs_fscache_req_put(req->primary);
+		erofs_fscache_req_complete(req);
 		kfree(req);
 	}
 }
 
-static void erofs_fscache_subreq_complete(void *priv,
+static struct erofs_fscache_request *erofs_fscache_req_alloc(struct address_space *mapping,
+						loff_t start, size_t len)
+{
+	struct erofs_fscache_request *req;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (req) {
+		req->mapping = mapping;
+		req->start = start;
+		req->len = len;
+		refcount_set(&req->ref, 1);
+	}
+	return req;
+}
+
+static bool erofs_fscache_io_put(struct erofs_fscache_io *cio)
+{
+	if (refcount_dec_and_test(&cio->ref)) {
+		if (cio->cache_resources.ops)
+			cio->cache_resources.ops->end_operation(&cio->cache_resources);
+		kfree(cio);
+		return true;
+	}
+	return false;
+}
+
+static void erofs_fscache_req_io_put(struct erofs_fscache_io *cio)
+{
+	struct erofs_fscache_request *req = cio->private;
+
+	if (erofs_fscache_io_put(cio))
+		erofs_fscache_req_put(req);
+}
+
+static void erofs_fscache_req_end_io(void *priv,
 		ssize_t transferred_or_error, bool was_async)
 {
-	struct erofs_fscache_request *req = priv;
+	struct erofs_fscache_io *cio = priv;
+	struct erofs_fscache_request *req = cio->private;
+
+	if (IS_ERR(transferred_or_error))
+		req->error = transferred_or_error;
+	erofs_fscache_req_io_put(cio);
+}
+
+static struct erofs_fscache_io *erofs_fscache_req_io_alloc(struct erofs_fscache_request *req)
+{
+	struct erofs_fscache_io *cio;
 
-	if (IS_ERR_VALUE(transferred_or_error)) {
-		if (req->primary)
-			req->primary->error = transferred_or_error;
-		else
-			req->error = transferred_or_error;
+	cio = kzalloc(sizeof(*cio), GFP_KERNEL);
+	if (cio) {
+		cio->end_io = erofs_fscache_req_end_io;
+		cio->private = req;
+		refcount_inc(&req->ref);
+		refcount_set(&cio->ref, 1);
 	}
-	erofs_fscache_req_put(req);
+	return cio;
 }
 
 /*
- * Read data from fscache (cookie, pstart, len), and fill the read data into
- * page cache described by (req->mapping, lstart, len). @pstart describeis the
- * start physical address in the cache file.
+ * Read data from fscache described by cookie at pstart physical address
+ * offset, and fill the read data into buffer described by cio->iter.
  */
-static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
-		struct erofs_fscache_request *req, loff_t pstart, size_t len)
+static int erofs_fscache_read_io_async(struct fscache_cookie *cookie,
+		loff_t pstart, struct erofs_fscache_io *cio)
 {
 	enum netfs_io_source source;
-	struct super_block *sb = req->mapping->host->i_sb;
-	struct netfs_cache_resources *cres = &req->cache_resources;
-	struct iov_iter iter;
-	loff_t lstart = req->start + req->submitted;
-	size_t done = 0;
+	struct netfs_cache_resources *cres = &cio->cache_resources;
+	struct iov_iter *iter = &cio->iter;
 	int ret;
 
-	DBG_BUGON(len > req->len - req->submitted);
-
 	ret = fscache_begin_read_operation(cres, cookie);
 	if (ret)
 		return ret;
 
-	while (done < len) {
-		loff_t sstart = pstart + done;
-		size_t slen = len - done;
+	while (iov_iter_count(iter)) {
+		size_t len, remain = iov_iter_count(iter);
 		unsigned long flags = 1 << NETFS_SREQ_ONDEMAND;
 
+		len = remain;
 		source = cres->ops->prepare_ondemand_read(cres,
-				sstart, &slen, LLONG_MAX, &flags, 0);
-		if (WARN_ON(slen == 0))
+				pstart, &len, LLONG_MAX, &flags, 0);
+		if (WARN_ON(len == 0))
 			source = NETFS_INVALID_READ;
 		if (source != NETFS_READ_FROM_CACHE) {
-			erofs_err(sb, "failed to fscache prepare_read (source %d)", source);
+			erofs_err(NULL, "prepare_read failed (source %d)", source);
 			return -EIO;
 		}
 
-		refcount_inc(&req->ref);
-		iov_iter_xarray(&iter, ITER_DEST, &req->mapping->i_pages,
-				lstart + done, slen);
-
-		ret = fscache_read(cres, sstart, &iter, NETFS_READ_HOLE_FAIL,
-				   erofs_fscache_subreq_complete, req);
+		iov_iter_truncate(iter, len);
+		refcount_inc(&cio->ref);
+		ret = fscache_read(cres, pstart, iter, NETFS_READ_HOLE_FAIL,
+				   cio->end_io, cio);
 		if (ret == -EIOCBQUEUED)
 			ret = 0;
 		if (ret) {
-			erofs_err(sb, "failed to fscache_read (ret %d)", ret);
+			erofs_err(NULL, "fscache_read failed (ret %d)", ret);
 			return ret;
 		}
+		if (WARN_ON(iov_iter_count(iter)))
+			return -EIO;
 
-		done += slen;
+		iov_iter_reexpand(iter, remain - len);
+		pstart += len;
 	}
-	DBG_BUGON(done != len);
 	return 0;
 }
 
@@ -167,33 +170,43 @@ static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
 	int ret;
 	struct erofs_fscache *ctx = folio->mapping->host->i_private;
 	struct erofs_fscache_request *req;
+	struct erofs_fscache_io *cio;
 
+	ret = -ENOMEM;
 	req = erofs_fscache_req_alloc(folio->mapping,
 				folio_pos(folio), folio_size(folio));
-	if (IS_ERR(req)) {
+	if (!req) {
 		folio_unlock(folio);
-		return PTR_ERR(req);
+		return ret;
 	}
 
-	ret = erofs_fscache_read_folios_async(ctx->cookie, req,
-				folio_pos(folio), folio_size(folio));
+	cio = erofs_fscache_req_io_alloc(req);
+	if (!cio) {
+		req->error = ret;
+		goto out;
+	}
+	iov_iter_xarray(&cio->iter, ITER_DEST, &folio->mapping->i_pages,
+			folio_pos(folio), folio_size(folio));
+
+	ret = erofs_fscache_read_io_async(ctx->cookie, folio_pos(folio), cio);
 	if (ret)
 		req->error = ret;
 
+	erofs_fscache_req_io_put(cio);
+out:
 	erofs_fscache_req_put(req);
 	return ret;
 }
 
-static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
+static int erofs_fscache_data_read_slice(struct erofs_fscache_request *req)
 {
-	struct address_space *mapping = primary->mapping;
+	struct address_space *mapping = req->mapping;
 	struct inode *inode = mapping->host;
 	struct super_block *sb = inode->i_sb;
-	struct erofs_fscache_request *req;
+	struct erofs_fscache_io *cio;
 	struct erofs_map_blocks map;
 	struct erofs_map_dev mdev;
-	struct iov_iter iter;
-	loff_t pos = primary->start + primary->submitted;
+	loff_t pos = req->start + req->submitted;
 	size_t count;
 	int ret;
 
@@ -204,6 +217,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 
 	if (map.m_flags & EROFS_MAP_META) {
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+		struct iov_iter iter;
 		erofs_blk_t blknr;
 		size_t offset, size;
 		void *src;
@@ -224,15 +238,17 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 		}
 		iov_iter_zero(PAGE_SIZE - size, &iter);
 		erofs_put_metabuf(&buf);
-		primary->submitted += PAGE_SIZE;
+		req->submitted += PAGE_SIZE;
 		return 0;
 	}
 
-	count = primary->len - primary->submitted;
+	count = req->len - req->submitted;
 	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+		struct iov_iter iter;
+
 		iov_iter_xarray(&iter, ITER_DEST, &mapping->i_pages, pos, count);
 		iov_iter_zero(count, &iter);
-		primary->submitted += count;
+		req->submitted += count;
 		return 0;
 	}
 
@@ -247,14 +263,15 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 	if (ret)
 		return ret;
 
-	req = erofs_fscache_req_chain(primary, count);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
+	cio = erofs_fscache_req_io_alloc(req);
+	if (!cio)
+		return -ENOMEM;
+	iov_iter_xarray(&cio->iter, ITER_DEST, &mapping->i_pages, pos, count);
+	ret = erofs_fscache_read_io_async(mdev.m_fscache->cookie,
+			mdev.m_pa + (pos - map.m_la), cio);
+	erofs_fscache_req_io_put(cio);
 
-	ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
-			req, mdev.m_pa + (pos - map.m_la), count);
-	erofs_fscache_req_put(req);
-	primary->submitted += count;
+	req->submitted += count;
 	return ret;
 }
 
@@ -278,9 +295,9 @@ static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
 
 	req = erofs_fscache_req_alloc(folio->mapping,
 			folio_pos(folio), folio_size(folio));
-	if (IS_ERR(req)) {
+	if (!req) {
 		folio_unlock(folio);
-		return PTR_ERR(req);
+		return -ENOMEM;
 	}
 
 	ret = erofs_fscache_data_read(req);
@@ -297,7 +314,7 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
 
 	req = erofs_fscache_req_alloc(rac->mapping,
 			readahead_pos(rac), readahead_length(rac));
-	if (IS_ERR(req))
+	if (!req)
 		return;
 
 	/* The request completion will drop refs on the folios. */
-- 
2.19.1.6.gb485710b

