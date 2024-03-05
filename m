Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 80205871950
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Mar 2024 10:15:37 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cp3LZ+3X;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tpqfb29pPz3cJW
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Mar 2024 20:15:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cp3LZ+3X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tpqdy6Jt9z2xPZ
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Mar 2024 20:15:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709630097; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=FJUQnbv03TDanaApqCFhn5ON5sBfkERUUs9MYWmPJ3Q=;
	b=cp3LZ+3XgRGkTZ9OU2ANUsC1CQ2YvwaMGMVFyAE6ctW6NVd0s7dii5PhWW+p5pbSgsGg7rkSSr42jOupvJhNYBCFe4SvdeCe9DeiZPhD4orQxajHF6Hxug4i4vSuuLjnyIZ3X+fkKamLt3Q+x3CwDEDtK4RyHgNS9Y45BoPrXuU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W1tgGgn_1709630095;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1tgGgn_1709630095)
          by smtp.aliyun-inc.com;
          Tue, 05 Mar 2024 17:14:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/6] erofs: get rid of `justfound` debugging tag
Date: Tue,  5 Mar 2024 17:14:45 +0800
Message-Id: <20240305091448.1384242-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240305091448.1384242-1-hsiangkao@linux.alibaba.com>
References: <20240305091448.1384242-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

`justfound` is introduced to identify cached folios that are just added
to compressed bvecs so that more checks can be applied in the I/O
submission path.

EROFS is quite now stable compared to the codebase at that stage.
`justfound` becomes a burden for upcoming features.  Drop it.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index c25074657708..75b05990b571 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -565,17 +565,13 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 
 	for (i = 0; i < pclusterpages; ++i) {
 		struct page *page, *newpage;
-		void *t;	/* mark pages just found for debugging */
 
 		/* Inaccurate check w/o locking to avoid unneeded lookups */
 		if (READ_ONCE(pcl->compressed_bvecs[i].page))
 			continue;
 
 		page = find_get_page(mc, pcl->obj.index + i);
-		if (page) {
-			t = (void *)((unsigned long)page | 1);
-			newpage = NULL;
-		} else {
+		if (!page) {
 			/* I/O is needed, no possible to decompress directly */
 			standalone = false;
 			if (!shouldalloc)
@@ -589,11 +585,10 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
 			if (!newpage)
 				continue;
 			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
-			t = (void *)((unsigned long)newpage | 1);
 		}
 		spin_lock(&pcl->obj.lockref.lock);
 		if (!pcl->compressed_bvecs[i].page) {
-			pcl->compressed_bvecs[i].page = t;
+			pcl->compressed_bvecs[i].page = page ? page : newpage;
 			spin_unlock(&pcl->obj.lockref.lock);
 			continue;
 		}
@@ -1423,7 +1418,7 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	struct z_erofs_bvec zbv;
 	struct address_space *mapping;
 	struct page *page;
-	int justfound, bs = i_blocksize(f->inode);
+	int bs = i_blocksize(f->inode);
 
 	/* Except for inplace pages, the entire page can be used for I/Os */
 	bvec->bv_offset = 0;
@@ -1432,9 +1427,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	spin_lock(&pcl->obj.lockref.lock);
 	zbv = pcl->compressed_bvecs[nr];
 	page = zbv.page;
-	justfound = (unsigned long)page & 1UL;
-	page = (struct page *)((unsigned long)page & ~1UL);
-	pcl->compressed_bvecs[nr].page = page;
 	spin_unlock(&pcl->obj.lockref.lock);
 	if (!page)
 		goto out_allocpage;
@@ -1465,9 +1457,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	}
 
 	lock_page(page);
-	/* only true if page reclaim goes wrong, should never happen */
-	DBG_BUGON(justfound && PagePrivate(page));
-
 	/* the cached page is still in managed cache */
 	if (page->mapping == mc) {
 		/*
@@ -1475,7 +1464,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 		 * `->private` pcluster hint.  Let's reconnect them.
 		 */
 		if (!PagePrivate(page)) {
-			DBG_BUGON(!justfound);
 			/* compressed_bvecs[] already takes a ref */
 			attach_page_private(page, pcl);
 			put_page(page);
@@ -1494,8 +1482,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	 * allocate a new page for compressed data.
 	 */
 	DBG_BUGON(page->mapping);
-	DBG_BUGON(!justfound);
-
 	tocache = true;
 	unlock_page(page);
 	put_page(page);
-- 
2.39.3

