Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8DD639FE0
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Nov 2022 03:59:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NL9D26Gt6z3f3F
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Nov 2022 13:59:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NL91k3j88z3f8s
	for <linux-erofs@lists.ozlabs.org>; Mon, 28 Nov 2022 13:50:18 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VVnFHae_1669603812;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VVnFHae_1669603812)
          by smtp.aliyun-inc.com;
          Mon, 28 Nov 2022 10:50:13 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/2] erofs: support large folios for fscache mode
Date: Mon, 28 Nov 2022 10:50:10 +0800
Message-Id: <20221128025011.36352-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221128025011.36352-1-jefflexu@linux.alibaba.com>
References: <20221128025011.36352-1-jefflexu@linux.alibaba.com>
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
.readahead(). In this case, only when all slices of the folio or folio
range have completed, the request will be marked as completed and the
folio or folio range will be unlocked then.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 116 +++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 68 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 3cfe1af7a46e..0643b205c7eb 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -167,32 +167,18 @@ static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
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
+static int erofs_fscache_data_read_slice(struct erofs_fscache_request *req)
 {
+	struct address_space *mapping = req->mapping;
 	struct inode *inode = mapping->host;
 	struct super_block *sb = inode->i_sb;
-	struct erofs_fscache_request *req;
+	loff_t pos = req->start + req->submitted;
 	struct erofs_map_blocks map;
 	struct erofs_map_dev mdev;
 	struct iov_iter iter;
 	size_t count;
 	int ret;
 
-	*unlock = true;
-
 	map.m_la = pos;
 	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
 	if (ret)
@@ -201,36 +187,37 @@ static int erofs_fscache_data_read(struct address_space *mapping,
 	if (map.m_flags & EROFS_MAP_META) {
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 		erofs_blk_t blknr;
-		size_t offset, size;
+		size_t offset;
 		void *src;
 
 		/* For tail packing layout, the offset may be non-zero. */
 		offset = erofs_blkoff(map.m_pa);
 		blknr = erofs_blknr(map.m_pa);
-		size = map.m_llen;
+		count = map.m_llen;
 
 		src = erofs_read_metabuf(&buf, sb, blknr, EROFS_KMAP);
 		if (IS_ERR(src))
 			return PTR_ERR(src);
 
-		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, PAGE_SIZE);
-		if (copy_to_iter(src + offset, size, &iter) != size) {
+		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, count);
+		if (copy_to_iter(src + offset, count, &iter) != count) {
 			erofs_put_metabuf(&buf);
 			return -EFAULT;
 		}
-		iov_iter_zero(PAGE_SIZE - size, &iter);
 		erofs_put_metabuf(&buf);
-		return PAGE_SIZE;
+		req->submitted += count;
+		return 0;
 	}
 
+	count = req->len - req->submitted;
 	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
-		count = len;
 		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, count);
 		iov_iter_zero(count, &iter);
-		return count;
+		req->submitted += count;
+		return 0;
 	}
 
-	count = min_t(size_t, map.m_llen - (pos - map.m_la), len);
+	count = min_t(size_t, map.m_llen - (pos - map.m_la), count);
 	DBG_BUGON(!count || count % PAGE_SIZE);
 
 	mdev = (struct erofs_map_dev) {
@@ -241,68 +228,61 @@ static int erofs_fscache_data_read(struct address_space *mapping,
 	if (ret)
 		return ret;
 
-	req = erofs_fscache_req_alloc(mapping, pos, count);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	*unlock = false;
-	ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
+	return erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
 			req, mdev.m_pa + (pos - map.m_la), count);
-	if (ret)
-		req->error = ret;
+}
 
-	erofs_fscache_req_put(req);
-	return count;
+/*
+ * Read into page cache in the range described by (req->start, req->len).
+ */
+static int erofs_fscache_data_read(struct erofs_fscache_request *req)
+{
+	int ret;
+
+	do {
+		ret = erofs_fscache_data_read_slice(req);
+		if (ret)
+			req->error = ret;
+	} while (!ret && req->submitted < req->len);
+
+	return ret;
 }
 
 static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
 {
-	bool unlock;
+	struct erofs_fscache_request *req;
 	int ret;
 
-	DBG_BUGON(folio_size(folio) != EROFS_BLKSIZ);
-
-	ret = erofs_fscache_data_read(folio_mapping(folio), folio_pos(folio),
-				      folio_size(folio), &unlock);
-	if (unlock) {
-		if (ret > 0)
-			folio_mark_uptodate(folio);
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

