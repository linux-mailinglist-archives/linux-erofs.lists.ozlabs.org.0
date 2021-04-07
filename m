Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 04208356294
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Apr 2021 06:39:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FFWry0t9Zz2yx9
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Apr 2021 14:39:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dry1qFMH;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dry1qFMH; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FFWrw6VlXz309X
 for <linux-erofs@lists.ozlabs.org>; Wed,  7 Apr 2021 14:39:44 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E917E613D1;
 Wed,  7 Apr 2021 04:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617770383;
 bh=TTohYEp+Y71eCLSWzJ5NVWMxS82V5f7hL20PML26yNI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dry1qFMHSDDgfSt3aZTQkRE5Exd2j8i6SLfhN+AfqCgdqA21B/EVuVQG1h37asgHC
 6XfZs8/tPJQq45fGCXF96L0LpQfB7WGLX95NpFnzd0qVm0IA32p425vHGT9zgcqP8Z
 jE18pgwPu0OlAzbPL1+RU0P7vec3vV/TkdEtFByrSkuuxWAoXoSwHXAcE2g0mMObo7
 RXxIRkmH70+/hVWjWFLkCPsb1iN9pEMwswOKxULTdtk3NmgRZnkK8CUBSxBvr5ydns
 oVM0LH7gqgg6oforvvcfW0R0827usbuLrAMbOPHO//S+X7gufK+EVuHYNx4E/ZDueP
 pTBXgtIqHLT4g==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH v3 04/10] erofs: fix up inplace I/O pointer for big pcluster
Date: Wed,  7 Apr 2021 12:39:21 +0800
Message-Id: <20210407043927.10623-5-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407043927.10623-1-xiang@kernel.org>
References: <20210407043927.10623-1-xiang@kernel.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

When picking up inplace I/O pages, it should be traversed in reverse
order in aligned with the traversal order of file-backed online pages.
Also, index should be updated together when preloading compressed pages.

Previously, only page-sized pclustersize was supported so no problem
at all. Also rename `compressedpages' to `icpage_ptr' to reflect its
functionality.

Acked-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index db296d324333..78e4b598ecca 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -204,7 +204,8 @@ struct z_erofs_collector {
 
 	struct z_erofs_pcluster *pcl, *tailpcl;
 	struct z_erofs_collection *cl;
-	struct page **compressedpages;
+	/* a pointer used to pick up inplace I/O pages */
+	struct page **icpage_ptr;
 	z_erofs_next_pcluster_t owned_head;
 
 	enum z_erofs_collectmode mode;
@@ -238,17 +239,19 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 				     enum z_erofs_cache_alloctype type,
 				     struct list_head *pagepool)
 {
-	const struct z_erofs_pcluster *pcl = clt->pcl;
-	struct page **pages = clt->compressedpages;
-	pgoff_t index = pcl->obj.index + (pages - pcl->compressed_pages);
+	struct z_erofs_pcluster *pcl = clt->pcl;
 	bool standalone = true;
 	gfp_t gfp = (mapping_gfp_mask(mc) & ~__GFP_DIRECT_RECLAIM) |
 			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
+	struct page **pages;
+	pgoff_t index;
 
 	if (clt->mode < COLLECT_PRIMARY_FOLLOWED)
 		return;
 
-	for (; pages < pcl->compressed_pages + pcl->pclusterpages; ++pages) {
+	pages = pcl->compressed_pages;
+	index = pcl->obj.index;
+	for (; index < pcl->obj.index + pcl->pclusterpages; ++index, ++pages) {
 		struct page *page;
 		compressed_page_t t;
 		struct page *newpage = NULL;
@@ -360,16 +363,14 @@ int erofs_try_to_free_cached_page(struct address_space *mapping,
 }
 
 /* page_type must be Z_EROFS_PAGE_TYPE_EXCLUSIVE */
-static inline bool z_erofs_try_inplace_io(struct z_erofs_collector *clt,
-					  struct page *page)
+static bool z_erofs_try_inplace_io(struct z_erofs_collector *clt,
+				   struct page *page)
 {
 	struct z_erofs_pcluster *const pcl = clt->pcl;
 
-	while (clt->compressedpages <
-	       pcl->compressed_pages + pcl->pclusterpages) {
-		if (!cmpxchg(clt->compressedpages++, NULL, page))
+	while (clt->icpage_ptr > pcl->compressed_pages)
+		if (!cmpxchg(--clt->icpage_ptr, NULL, page))
 			return true;
-	}
 	return false;
 }
 
@@ -576,9 +577,8 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
 	z_erofs_pagevec_ctor_init(&clt->vector, Z_EROFS_NR_INLINE_PAGEVECS,
 				  clt->cl->pagevec, clt->cl->vcnt);
 
-	clt->compressedpages = clt->pcl->compressed_pages;
-	if (clt->mode <= COLLECT_PRIMARY) /* cannot do in-place I/O */
-		clt->compressedpages += clt->pcl->pclusterpages;
+	/* since file-backed online pages are traversed in reverse order */
+	clt->icpage_ptr = clt->pcl->compressed_pages + clt->pcl->pclusterpages;
 	return 0;
 }
 
-- 
2.20.1

