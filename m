Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ED251A0FFAC
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jan 2025 04:44:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXFPb1gW6z3bqZ
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Jan 2025 14:44:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736826288;
	cv=none; b=khgMjsJ2q1pesOAGYMYAtCSJtNQIkAsTYc43Ki7BLJ92oWkqio9ei78rzaXesjaIbsjm/3+GeYVHNCTOadrl2FOYO/HnAVbLKZyzGzXMAADU2YyG4tSvcZu2Ixe0hPHGA/1awi37o9X3pTWfbf91NQJZ/ip3xMwU2iWzFgwNT1GbhYQMoihcCLLcEt6TwapWuqSiVRrnu5YJ0znSc61HN4nWdwvQWbLsEvEp1eJc70bKEIiE/y22mYCBorPB8S56S3Z/dEthrRmWN+er5Q5Svh/8UbZmbuejb/z/v2wbI8nZKZCZGWn9AicqujfCLZpcoBQpzvEBlYIrgwdA5AvWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736826288; c=relaxed/relaxed;
	bh=jfLoOQKpaDRBHzUFId2xCwtLHpAs+B/Fg9jq/zdHq4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5mcFK7JOKgahHajn1IrZidBMefD/hjbnqwpauPpN+G5z4piaiGsN5bdo5nHVFadF2H0ssy1OtiYl/YtUxMCmode5kKTphnht+6EiEYLwcbCHS12zm4iKTFCz/hTYSZuU6PHLsaVU72uU63fqj9tp2giWR7bGghv8ZNNsz+G0L5Bs9V+g6YZp26DJS1a+C65Gpp7DbC4i1YVxajgJ4pFYMscNmm4uOijsk/I9l+LRp16pMn0NnSD4A55DxvhWoO3UFTeYAjU0sG9cELB4B3rdxj7zMt3M9RsL4bd7bRlzhgBAgCl9lqSHhUa/b5q9QQpWGzHYVHIJd/anI6XIaFJ0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EPvlpCSS; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EPvlpCSS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXFPT5DG4z2yyx
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Jan 2025 14:44:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736826281; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jfLoOQKpaDRBHzUFId2xCwtLHpAs+B/Fg9jq/zdHq4o=;
	b=EPvlpCSSvHB48XQ+t58ey8QbGCWaVl5Z4O0Zi/Z561U+mW5gjn032NFv+RJ7WPrIURzqqrV3z2RTmfGUnI4VZFCJ5I7zbJGrtxRrBpBd1k6/ta5a2UDI05L5cO+ipjKN0PugNCy/8o2H3aBPvTkhGa8zfuX+4ed1rNdPZyQ6uDM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNdPh3l_1736826279 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jan 2025 11:44:40 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/4] erofs: convert z_erofs_bind_cache() to folios
Date: Tue, 14 Jan 2025 11:44:29 +0800
Message-ID: <20250114034429.431408-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250114034429.431408-1-hsiangkao@linux.alibaba.com>
References: <20250114034429.431408-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The managed cache uses a pseudo inode to keep (necessary) compressed
data.

Currently, it still uses zero-order folios, so this is just a trivial
conversion, except that the use of the pagepool is temporarily dropped.

Drop some obsoleted comments too.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/compress.h | 23 +-------------------
 fs/erofs/zdata.c    | 51 ++++++++++++++++++---------------------------
 2 files changed, 21 insertions(+), 53 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 7bfe251680ec..65ff39401020 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -29,29 +29,8 @@ struct z_erofs_decompressor {
 	char *name;
 };
 
-/* some special page->private (unsigned long, see below) */
 #define Z_EROFS_SHORTLIVED_PAGE		(-1UL << 2)
-#define Z_EROFS_PREALLOCATED_PAGE	(-2UL << 2)
-
-/*
- * For all pages in a pcluster, page->private should be one of
- * Type                         Last 2bits      page->private
- * short-lived page             00              Z_EROFS_SHORTLIVED_PAGE
- * preallocated page (tryalloc) 00              Z_EROFS_PREALLOCATED_PAGE
- * cached/managed page          00              pointer to z_erofs_pcluster
- * online page (file-backed,    01/10/11        sub-index << 2 | count
- *              some pages can be used for inplace I/O)
- *
- * page->mapping should be one of
- * Type                 page->mapping
- * short-lived page     NULL
- * preallocated page    NULL
- * cached/managed page  non-NULL or NULL (invalidated/truncated page)
- * online page          non-NULL
- *
- * For all managed pages, PG_private should be set with 1 extra refcount,
- * which is used for page reclaim / migration.
- */
+#define Z_EROFS_PREALLOCATED_FOLIO	((void *)(-2UL << 2))
 
 /*
  * Currently, short-lived pages are pages directly from buddy system
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index dcbb692ac058..b3fb18d1a9c8 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -516,13 +516,11 @@ static void z_erofs_bind_cache(struct z_erofs_frontend *fe)
 	struct z_erofs_pcluster *pcl = fe->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
 	bool shouldalloc = z_erofs_should_alloc_cache(fe);
-	bool standalone = true;
-	/*
-	 * optimistic allocation without direct reclaim since inplace I/O
-	 * can be used if low memory otherwise.
-	 */
+	bool may_bypass = true;
+	/* Optimistic allocation, as in-place I/O can be used as a fallback */
 	gfp_t gfp = (mapping_gfp_mask(mc) & ~__GFP_DIRECT_RECLAIM) |
 			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
+	struct folio *folio, *newfolio;
 	unsigned int i;
 
 	if (i_blocksize(fe->inode) != PAGE_SIZE ||
@@ -530,47 +528,42 @@ static void z_erofs_bind_cache(struct z_erofs_frontend *fe)
 		return;
 
 	for (i = 0; i < pclusterpages; ++i) {
-		struct page *page, *newpage;
-
 		/* Inaccurate check w/o locking to avoid unneeded lookups */
 		if (READ_ONCE(pcl->compressed_bvecs[i].page))
 			continue;
 
-		page = find_get_page(mc, pcl->index + i);
-		if (!page) {
-			/* I/O is needed, no possible to decompress directly */
-			standalone = false;
+		folio = filemap_get_folio(mc, pcl->index + i);
+		if (IS_ERR(folio)) {
+			may_bypass = false;
 			if (!shouldalloc)
 				continue;
 
 			/*
-			 * Try cached I/O if allocation succeeds or fallback to
-			 * in-place I/O instead to avoid any direct reclaim.
+			 * Allocate a managed folio for cached I/O, or it may be
+			 * then filled with a file-backed folio for in-place I/O
 			 */
-			newpage = erofs_allocpage(&fe->pagepool, gfp);
-			if (!newpage)
+			newfolio = filemap_alloc_folio(gfp, 0);
+			if (!newfolio)
 				continue;
-			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
+			newfolio->private = Z_EROFS_PREALLOCATED_FOLIO;
+			folio = NULL;
 		}
 		spin_lock(&pcl->lockref.lock);
 		if (!pcl->compressed_bvecs[i].page) {
-			pcl->compressed_bvecs[i].page = page ? page : newpage;
+			pcl->compressed_bvecs[i].page =
+				folio_page(folio ?: newfolio, 0);
 			spin_unlock(&pcl->lockref.lock);
 			continue;
 		}
 		spin_unlock(&pcl->lockref.lock);
-
-		if (page)
-			put_page(page);
-		else if (newpage)
-			erofs_pagepool_add(&fe->pagepool, newpage);
+		folio_put(folio ?: newfolio);
 	}
 
 	/*
-	 * don't do inplace I/O if all compressed pages are available in
-	 * managed cache since it can be moved to the bypass queue instead.
+	 * Don't perform in-place I/O if all compressed pages are available in
+	 * the managed cache, as the pcluster can be moved to the bypass queue.
 	 */
-	if (standalone)
+	if (may_bypass)
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 }
 
@@ -1481,12 +1474,8 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	DBG_BUGON(z_erofs_is_shortlived_page(bvec->bv_page));
 
 	folio = page_folio(zbv.page);
-	/*
-	 * Handle preallocated cached folios.  We tried to allocate such folios
-	 * without triggering direct reclaim.  If allocation failed, inplace
-	 * file-backed folios will be used instead.
-	 */
-	if (folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
+	/* For preallocated managed folios, add them to page cache here */
+	if (folio->private == Z_EROFS_PREALLOCATED_FOLIO) {
 		tocache = true;
 		goto out_tocache;
 	}
-- 
2.43.5

