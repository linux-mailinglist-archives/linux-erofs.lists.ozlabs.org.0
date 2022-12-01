Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 555F163EA76
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Dec 2022 08:43:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NN7NP1tqCz3bbY
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Dec 2022 18:43:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NN7N83Mbpz3bVs
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Dec 2022 18:43:03 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VW7gJ--_1669880577;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VW7gJ--_1669880577)
          by smtp.aliyun-inc.com;
          Thu, 01 Dec 2022 15:42:58 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 1/2] erofs: support large folios for fscache mode
Date: Thu,  1 Dec 2022 15:42:55 +0800
Message-Id: <20221201074256.16639-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221201074256.16639-1-jefflexu@linux.alibaba.com>
References: <20221201074256.16639-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When large folios supported, one folio can be split into several slices,
each of which may be mapped to META/UNMAPPED/MAPPED, and the folio can
be unlocked as a whole only when all slices have completed.

Thus always allocate erofs_fscache_request for each .read_folio() or
.readahead(), in which case the allocated request is responsible for
unlocking folios when all slices have completed.

As described above, each folio or folio range can be mapped into several
slices, while these slices may be mapped to different cookies, and thus
each slice needs its own netfs_cache_resources.  Here we introduce
chained requests to support this, where each .read_folio() or
.readahead() calling can correspond to multiple requests.  Each request
has its own netfs_cache_resources and thus is used to access one cookie.
Among these requests, there's a primary request, with the others
pointing to the primary request.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 148 ++++++++++++++++++++++++---------------------
 1 file changed, 80 insertions(+), 68 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 3e794891cd91..f14886c479bd 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -12,6 +12,7 @@ static LIST_HEAD(erofs_domain_list);
 static struct vfsmount *erofs_pseudo_mnt;
 
 struct erofs_fscache_request {
+	struct erofs_fscache_request *primary;
 	struct netfs_cache_resources cache_resources;
 	struct address_space	*mapping;	/* The mapping being accessed */
 	loff_t			start;		/* Start position */
@@ -38,6 +39,26 @@ static struct erofs_fscache_request *erofs_fscache_req_alloc(struct address_spac
 	return req;
 }
 
+static struct erofs_fscache_request *erofs_fscache_req_chain(struct erofs_fscache_request *primary,
+					     size_t len)
+{
+	struct erofs_fscache_request *req;
+
+	/* use primary request for the first submission */
+	if (!primary->submitted) {
+		refcount_inc(&primary->ref);
+		return primary;
+	}
+
+	req = erofs_fscache_req_alloc(primary->mapping,
+			primary->start + primary->submitted, len);
+	if (!IS_ERR(req)) {
+		req->primary = primary;
+		refcount_inc(&primary->ref);
+	}
+	return req;
+}
+
 static void erofs_fscache_req_complete(struct erofs_fscache_request *req)
 {
 	struct folio *folio;
@@ -56,17 +77,19 @@ static void erofs_fscache_req_complete(struct erofs_fscache_request *req)
 		folio_unlock(folio);
 	}
 	rcu_read_unlock();
-
-	if (req->cache_resources.ops)
-		req->cache_resources.ops->end_operation(&req->cache_resources);
-
-	kfree(req);
 }
 
 static void erofs_fscache_req_put(struct erofs_fscache_request *req)
 {
-	if (refcount_dec_and_test(&req->ref))
-		erofs_fscache_req_complete(req);
+	if (refcount_dec_and_test(&req->ref)) {
+		if (req->cache_resources.ops)
+			req->cache_resources.ops->end_operation(&req->cache_resources);
+		if (!req->primary)
+			erofs_fscache_req_complete(req);
+		else
+			erofs_fscache_req_put(req->primary);
+		kfree(req);
+	}
 }
 
 static void erofs_fscache_subreq_complete(void *priv,
@@ -74,8 +97,12 @@ static void erofs_fscache_subreq_complete(void *priv,
 {
 	struct erofs_fscache_request *req = priv;
 
-	if (IS_ERR_VALUE(transferred_or_error))
-		req->error = transferred_or_error;
+	if (IS_ERR_VALUE(transferred_or_error)) {
+		if (req->primary)
+			req->primary->error = transferred_or_error;
+		else
+			req->error = transferred_or_error;
+	}
 	erofs_fscache_req_put(req);
 }
 
@@ -131,7 +158,6 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 		done += slen;
 	}
 	DBG_BUGON(done != len);
-	req->submitted += len;
 	return 0;
 }
 
@@ -167,32 +193,19 @@ static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
 	return ret;
 }
 
-/*
- * Read into page cache in the range described by (@pos, @len).
- *
- * On return, if the output @unlock is true, the caller is responsible for page
- * unlocking; otherwise the callee will take this responsibility through request
- * completion.
- *
- * The return value is the number of bytes successfully handled, or negative
- * error code on failure. The only exception is that, the length of the range
- * instead of the error code is returned on failure after request is allocated,
- * so that .readahead() could advance rac accordingly.
- */
-static int erofs_fscache_data_read(struct address_space *mapping,
-				   loff_t pos, size_t len, bool *unlock)
+static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 {
+	struct address_space *mapping = primary->mapping;
 	struct inode *inode = mapping->host;
 	struct super_block *sb = inode->i_sb;
 	struct erofs_fscache_request *req;
 	struct erofs_map_blocks map;
 	struct erofs_map_dev mdev;
 	struct iov_iter iter;
+	loff_t pos = primary->start + primary->submitted;
 	size_t count;
 	int ret;
 
-	*unlock = true;
-
 	map.m_la = pos;
 	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
 	if (ret)
@@ -220,17 +233,19 @@ static int erofs_fscache_data_read(struct address_space *mapping,
 		}
 		iov_iter_zero(PAGE_SIZE - size, &iter);
 		erofs_put_metabuf(&buf);
-		return PAGE_SIZE;
+		primary->submitted += PAGE_SIZE;
+		return 0;
 	}
 
+	count = primary->len - primary->submitted;
 	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
-		count = len;
 		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, count);
 		iov_iter_zero(count, &iter);
-		return count;
+		primary->submitted += count;
+		return 0;
 	}
 
-	count = min_t(size_t, map.m_llen - (pos - map.m_la), len);
+	count = min_t(size_t, map.m_llen - (pos - map.m_la), count);
 	DBG_BUGON(!count || count % PAGE_SIZE);
 
 	mdev = (struct erofs_map_dev) {
@@ -241,68 +256,65 @@ static int erofs_fscache_data_read(struct address_space *mapping,
 	if (ret)
 		return ret;
 
-	req = erofs_fscache_req_alloc(mapping, pos, count);
+	req = erofs_fscache_req_chain(primary, count);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	*unlock = false;
 	ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
 			req, mdev.m_pa + (pos - map.m_la), count);
-	if (ret)
-		req->error = ret;
-
 	erofs_fscache_req_put(req);
-	return count;
+	primary->submitted += count;
+	return ret;
 }
 
-static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
+static int erofs_fscache_data_read(struct erofs_fscache_request *req)
 {
-	bool unlock;
 	int ret;
 
-	DBG_BUGON(folio_size(folio) != EROFS_BLKSIZ);
+	do {
+		ret = erofs_fscache_data_read_slice(req);
+		if (ret)
+			req->error = ret;
+	} while (!ret && req->submitted < req->len);
 
-	ret = erofs_fscache_data_read(folio_mapping(folio), folio_pos(folio),
-				      folio_size(folio), &unlock);
-	if (unlock) {
-		if (ret > 0)
-			folio_mark_uptodate(folio);
+	return ret;
+}
+
+static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
+{
+	struct erofs_fscache_request *req;
+	int ret;
+
+	req = erofs_fscache_req_alloc(folio_mapping(folio),
+			folio_pos(folio), folio_size(folio));
+	if (IS_ERR(req)) {
 		folio_unlock(folio);
+		return PTR_ERR(req);
 	}
-	return ret < 0 ? ret : 0;
+
+	ret = erofs_fscache_data_read(req);
+	erofs_fscache_req_put(req);
+	return ret;
 }
 
 static void erofs_fscache_readahead(struct readahead_control *rac)
 {
-	struct folio *folio;
-	size_t len, done = 0;
-	loff_t start, pos;
-	bool unlock;
-	int ret, size;
+	struct erofs_fscache_request *req;
 
 	if (!readahead_count(rac))
 		return;
 
-	start = readahead_pos(rac);
-	len = readahead_length(rac);
+	req = erofs_fscache_req_alloc(rac->mapping,
+			readahead_pos(rac), readahead_length(rac));
+	if (IS_ERR(req))
+		return;
 
-	do {
-		pos = start + done;
-		ret = erofs_fscache_data_read(rac->mapping, pos,
-					      len - done, &unlock);
-		if (ret <= 0)
-			return;
+	/* The request completion will drop refs on the folios. */
+	while (readahead_folio(rac))
+		;
 
-		size = ret;
-		while (size) {
-			folio = readahead_folio(rac);
-			size -= folio_size(folio);
-			if (unlock) {
-				folio_mark_uptodate(folio);
-				folio_unlock(folio);
-			}
-		}
-	} while ((done += ret) < len);
+	erofs_fscache_data_read(req);
+	erofs_fscache_req_put(req);
 }
 
 static const struct address_space_operations erofs_fscache_meta_aops = {
-- 
2.19.1.6.gb485710b

