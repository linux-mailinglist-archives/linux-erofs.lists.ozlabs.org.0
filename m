Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA7F2D284D
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 10:59:42 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CqwdR5RJSzDqYd
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 20:59:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=c4j4dkF7; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=c4j4dkF7; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CqwdM3g3pzDqXS
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 20:59:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607421571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=ER2dtzMqprG7J9HbVf1fvYN7CoUKFSvEFh/6/rpKs4k=;
 b=c4j4dkF7s4nxzKnP0Bmu1prO5YJ/8QrOXf8vuHISvvBBSVUs9CQv6FwUq82EM6FqzInGOq
 aYul2hPDoT8AzfPo9rdjW5c8BtmkRhSebhxCpIxffEQuG24P/IwJFWdFBE8GaLCHd4sLx3
 uhNyryl/4VxBBB3I0ULrvNyIgpXJUR4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607421571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=ER2dtzMqprG7J9HbVf1fvYN7CoUKFSvEFh/6/rpKs4k=;
 b=c4j4dkF7s4nxzKnP0Bmu1prO5YJ/8QrOXf8vuHISvvBBSVUs9CQv6FwUq82EM6FqzInGOq
 aYul2hPDoT8AzfPo9rdjW5c8BtmkRhSebhxCpIxffEQuG24P/IwJFWdFBE8GaLCHd4sLx3
 uhNyryl/4VxBBB3I0ULrvNyIgpXJUR4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-ynKsPIhuM6mKJMBCN4CddQ-1; Tue, 08 Dec 2020 04:59:29 -0500
X-MC-Unique: ynKsPIhuM6mKJMBCN4CddQ-1
Received: by mail-pl1-f198.google.com with SMTP id bd1so6621730plb.22
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Dec 2020 01:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ER2dtzMqprG7J9HbVf1fvYN7CoUKFSvEFh/6/rpKs4k=;
 b=mATkYhHlXqHqzjxDWep92SkPIorHhy8oezmqVcc/yN+I2myazUEQ0YYPP2LTjgzTs6
 E1zQQCtbo6LzE/UI3ESPn9nZpOz3AtN8PAoWaq6gUfeyAurUOahTkSdNoLiOM9AxGrQw
 KU48uhkZFSuqK+ISAlD9iVOSWP90xwucpVIbThFgl0HwR9vXecA9zpTDYDQLygTPg3pr
 pfO23St2cj2OhODAsUFiGnV83OQHvBD1t/afrXcMpJ70QfWyD/kcRTQ+7QAqTyegg24/
 P5ZPb0vBIy2FW3yM2BTsRU9lFX1ZLKLZBBJ7JSojDI4IDJf7lhifrOSkRtPPrk1VZOpp
 D37A==
X-Gm-Message-State: AOAM533byufNLAoqXEOHqW+sf2rsgm+GtVzeXNudpvQ6BrDC7fy3qhq0
 Rul3eDwEYX/4D4sOYgNCfF9aW6RG+wmn9+p7wCZVGNGoYNjvizwnaasamhgh85VWvJXke/pUbD8
 usuAEm9mtnRT9mxdAX7HDCNMntDU6R6bkD+D+eQW+8zgJpynB7AxdSWUhurBnX422jFllAYD8x/
 Xz1w==
X-Received: by 2002:a17:90a:9d88:: with SMTP id
 k8mr3571993pjp.141.1607421567845; 
 Tue, 08 Dec 2020 01:59:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLUTghucmkzVgPAUx0ZGEwsspw0qn6g0bcNXllG5s3im2rNknhFbUqWzUA7ymff2/N8OeTIQ==
X-Received: by 2002:a17:90a:9d88:: with SMTP id
 k8mr3571967pjp.141.1607421567433; 
 Tue, 08 Dec 2020 01:59:27 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z7sm11529018pfq.193.2020.12.08.01.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 01:59:27 -0800 (PST)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3 1/3] erofs: get rid of magical Z_EROFS_MAPPING_STAGING
Date: Tue,  8 Dec 2020 17:58:32 +0800
Message-Id: <20201208095834.3133565-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.4
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Previously, we played around with magical page->mapping for short-lived
temporary pages since we need to identify different types of pages in
the same pcluster but both invalidated and short-lived temporary pages
can have page->mapping == NULL. It was considered as safe because that
temporary pages are all non-LRU / non-movable pages.

This patch tends to use specific page->private to identify short-lived
pages instead so it won't rely on page->mapping anymore. Details are
described in "compress.h" as well.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
changes since v2:
 - use attach_page_private & detach_page_private for managed pages (Chao)
   Note that that pattern isn't necessary for all cases, e.g:
    1. onlinepages, which hold a page lock, so no need to +/- a ref;
    2. shortlivedpages, which are directly from buddy system, no need
       to +/- a ref as well.
 Detail discussion at
   https://lore.kernel.org/r/20200519151632.GX16070@bombadil.infradead.org/

 fs/erofs/compress.h     | 51 ++++++++++++++++++++++++++----------
 fs/erofs/decompressor.c |  2 +-
 fs/erofs/zdata.c        | 57 ++++++++++++++++++++++-------------------
 fs/erofs/zdata.h        |  1 +
 4 files changed, 71 insertions(+), 40 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 3d452443c545..4dadde18cdf1 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -26,30 +26,55 @@ struct z_erofs_decompress_req {
 	bool inplace_io, partial_decoding;
 };
 
+/* some special page->private (unsigned long, see below) */
+#define Z_EROFS_SHORTLIVED_PAGE		(-1UL << 2)
+
 /*
- * - 0x5A110C8D ('sallocated', Z_EROFS_MAPPING_STAGING) -
- * used to mark temporary allocated pages from other
- * file/cached pages and NULL mapping pages.
+ * For all pages in a pcluster, page->private should be one of
+ * Type                         Last 2bits      page->private
+ * short-lived page             00              Z_EROFS_SHORTLIVED_PAGE
+ * cached/managed page          00              pointer to z_erofs_pcluster
+ * online page (file-backed,    01/10/11        sub-index << 2 | count
+ *              some pages can be used for inplace I/O)
+ *
+ * page->mapping should be one of
+ * Type                 page->mapping
+ * short-lived page     NULL
+ * cached/managed page  non-NULL or NULL (invalidated/truncated page)
+ * online page          non-NULL
+ *
+ * For all managed pages, PG_private should be set with 1 extra refcount,
+ * which is used for page reclaim / migration.
  */
-#define Z_EROFS_MAPPING_STAGING         ((void *)0x5A110C8D)
 
-/* check if a page is marked as staging */
-static inline bool z_erofs_page_is_staging(struct page *page)
+/*
+ * short-lived pages are pages directly from buddy system with specific
+ * page->private (no need to set PagePrivate since these are non-LRU /
+ * non-movable pages and bypass reclaim / migration code).
+ */
+static inline bool z_erofs_is_shortlived_page(struct page *page)
 {
-	return page->mapping == Z_EROFS_MAPPING_STAGING;
+	if (page->private != Z_EROFS_SHORTLIVED_PAGE)
+		return false;
+
+	DBG_BUGON(page->mapping);
+	return true;
 }
 
-static inline bool z_erofs_put_stagingpage(struct list_head *pagepool,
-					   struct page *page)
+static inline bool z_erofs_put_shortlivedpage(struct list_head *pagepool,
+					      struct page *page)
 {
-	if (!z_erofs_page_is_staging(page))
+	if (!z_erofs_is_shortlived_page(page))
 		return false;
 
-	/* staging pages should not be used by others at the same time */
-	if (page_ref_count(page) > 1)
+	/* short-lived pages should not be used by others at the same time */
+	if (page_ref_count(page) > 1) {
 		put_page(page);
-	else
+	} else {
+		/* follow the pcluster rule above. */
+		set_page_private(page, 0);
 		list_add(&page->lru, pagepool);
+	}
 	return true;
 }
 
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index cbadbf55c6c2..1cb1ffd10569 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -76,7 +76,7 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 			victim = erofs_allocpage(pagepool, GFP_KERNEL);
 			if (!victim)
 				return -ENOMEM;
-			victim->mapping = Z_EROFS_MAPPING_STAGING;
+			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
 		}
 		rq->out[i] = victim;
 	}
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 86fd3bf62af6..cfb0d11f893b 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -226,11 +226,8 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 
 		/* barrier is implied in the following 'unlock_page' */
 		WRITE_ONCE(pcl->compressed_pages[i], NULL);
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-
+		detach_page_private(page);
 		unlock_page(page);
-		put_page(page);
 	}
 	return 0;
 }
@@ -254,10 +251,8 @@ int erofs_try_to_free_cached_page(struct address_space *mapping,
 		}
 		erofs_workgroup_unfreeze(&pcl->obj, 1);
 
-		if (ret) {
-			ClearPagePrivate(page);
-			put_page(page);
-		}
+		if (ret)
+			detach_page_private(page);
 	}
 	return ret;
 }
@@ -648,12 +643,12 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 
 retry:
 	err = z_erofs_attach_page(clt, page, page_type);
-	/* should allocate an additional staging page for pagevec */
+	/* should allocate an additional short-lived page for pagevec */
 	if (err == -EAGAIN) {
 		struct page *const newpage =
 				alloc_page(GFP_NOFS | __GFP_NOFAIL);
 
-		newpage->mapping = Z_EROFS_MAPPING_STAGING;
+		set_page_private(newpage, Z_EROFS_SHORTLIVED_PAGE);
 		err = z_erofs_attach_page(clt, newpage,
 					  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
 		if (!err)
@@ -710,6 +705,11 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 		queue_work(z_erofs_workqueue, &io->u.work);
 }
 
+static bool z_erofs_page_is_invalidated(struct page *page)
+{
+	return !page->mapping && !z_erofs_is_shortlived_page(page);
+}
+
 static void z_erofs_decompressqueue_endio(struct bio *bio)
 {
 	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
@@ -722,7 +722,7 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
 		struct page *page = bvec->bv_page;
 
 		DBG_BUGON(PageUptodate(page));
-		DBG_BUGON(!page->mapping);
+		DBG_BUGON(z_erofs_page_is_invalidated(page));
 
 		if (err)
 			SetPageError(page);
@@ -795,9 +795,9 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 
 		/* all pages in pagevec ought to be valid */
 		DBG_BUGON(!page);
-		DBG_BUGON(!page->mapping);
+		DBG_BUGON(z_erofs_page_is_invalidated(page));
 
-		if (z_erofs_put_stagingpage(pagepool, page))
+		if (z_erofs_put_shortlivedpage(pagepool, page))
 			continue;
 
 		if (page_type == Z_EROFS_VLE_PAGE_TYPE_HEAD)
@@ -831,9 +831,9 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 
 		/* all compressed pages ought to be valid */
 		DBG_BUGON(!page);
-		DBG_BUGON(!page->mapping);
+		DBG_BUGON(z_erofs_page_is_invalidated(page));
 
-		if (!z_erofs_page_is_staging(page)) {
+		if (!z_erofs_is_shortlived_page(page)) {
 			if (erofs_page_is_managed(sbi, page)) {
 				if (!PageUptodate(page))
 					err = -EIO;
@@ -858,7 +858,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 			overlapped = true;
 		}
 
-		/* PG_error needs checking for inplaced and staging pages */
+		/* PG_error needs checking for all non-managed pages */
 		if (PageError(page)) {
 			DBG_BUGON(PageUptodate(page));
 			err = -EIO;
@@ -897,8 +897,8 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		if (erofs_page_is_managed(sbi, page))
 			continue;
 
-		/* recycle all individual staging pages */
-		(void)z_erofs_put_stagingpage(pagepool, page);
+		/* recycle all individual short-lived pages */
+		(void)z_erofs_put_shortlivedpage(pagepool, page);
 
 		WRITE_ONCE(compressed_pages[i], NULL);
 	}
@@ -908,10 +908,10 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 		if (!page)
 			continue;
 
-		DBG_BUGON(!page->mapping);
+		DBG_BUGON(z_erofs_page_is_invalidated(page));
 
-		/* recycle all individual staging pages */
-		if (z_erofs_put_stagingpage(pagepool, page))
+		/* recycle all individual short-lived pages */
+		if (z_erofs_put_shortlivedpage(pagepool, page))
 			continue;
 
 		if (err < 0)
@@ -1011,13 +1011,17 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	mapping = READ_ONCE(page->mapping);
 
 	/*
-	 * unmanaged (file) pages are all locked solidly,
+	 * file-backed online pages in plcuster are all locked steady,
 	 * therefore it is impossible for `mapping' to be NULL.
 	 */
 	if (mapping && mapping != mc)
 		/* ought to be unmanaged pages */
 		goto out;
 
+	/* directly return for shortlived page as well */
+	if (z_erofs_is_shortlived_page(page))
+		goto out;
+
 	lock_page(page);
 
 	/* only true if page reclaim goes wrong, should never happen */
@@ -1062,8 +1066,8 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 out_allocpage:
 	page = erofs_allocpage(pagepool, gfp | __GFP_NOFAIL);
 	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
-		/* non-LRU / non-movable temporary page is needed */
-		page->mapping = Z_EROFS_MAPPING_STAGING;
+		/* turn into temporary page if fails */
+		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
 		tocache = false;
 	}
 
@@ -1080,8 +1084,9 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	}
 
 	if (tocache) {
-		set_page_private(page, (unsigned long)pcl);
-		SetPagePrivate(page);
+		attach_page_private(page, pcl);
+		/* drop a ref added by allocpage (then we have 2 refs here) */
+		put_page(page);
 	}
 out:	/* the only exit (for tracing and debugging) */
 	return page;
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 68c9b29fc0ca..b503b353d4ab 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -173,6 +173,7 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
 
 	v = atomic_dec_return(u.o);
 	if (!(v & Z_EROFS_ONLINEPAGE_COUNT_MASK)) {
+		set_page_private(page, 0);
 		ClearPagePrivate(page);
 		if (!PageError(page))
 			SetPageUptodate(page);
-- 
2.18.4

