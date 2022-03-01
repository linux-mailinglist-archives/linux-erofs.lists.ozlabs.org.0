Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 623224C950B
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Mar 2022 20:50:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K7SXw3x9fz3c1Z
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Mar 2022 06:50:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K7SX85fK2z30LL
 for <linux-erofs@lists.ozlabs.org>; Wed,  2 Mar 2022 06:50:14 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V6-vyGs_1646164206; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V6-vyGs_1646164206) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 02 Mar 2022 03:50:07 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] erofs: clean up preload_compressed_pages()
Date: Wed,  2 Mar 2022 03:49:51 +0800
Message-Id: <20220301194951.106227-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220301194951.106227-1-hsiangkao@linux.alibaba.com>
References: <20220301194951.106227-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Rename preload_compressed_pages() as z_erofs_bind_cache()
since we're try to prepare for adapting folios.

Also, add a comment for the gfp setting. No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 2673fc105861..59aecf42e45c 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -219,13 +219,17 @@ struct z_erofs_decompress_frontend {
 static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
 static DEFINE_MUTEX(z_pagemap_global_lock);
 
-static void preload_compressed_pages(struct z_erofs_decompress_frontend *fe,
-				     struct address_space *mc,
-				     enum z_erofs_cache_alloctype type,
-				     struct page **pagepool)
+static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
+			       enum z_erofs_cache_alloctype type,
+			       struct page **pagepool)
 {
+	struct address_space *mc = MNGD_MAPPING(EROFS_I_SB(fe->inode));
 	struct z_erofs_pcluster *pcl = fe->pcl;
 	bool standalone = true;
+	/*
+	 * optimistic allocation without direct reclaim since inplace I/O
+	 * can be used if low memory otherwise.
+	 */
 	gfp_t gfp = (mapping_gfp_mask(mc) & ~__GFP_DIRECT_RECLAIM) |
 			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
 	struct page **pages;
@@ -703,17 +707,15 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		WRITE_ONCE(fe->pcl->compressed_pages[0], fe->map.buf.page);
 		fe->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
 	} else {
-		/* preload all compressed pages (can change mode if needed) */
+		/* bind cache first when cached decompression is preferred */
 		if (should_alloc_managed_pages(fe, sbi->opt.cache_strategy,
 					       map->m_la))
 			cache_strategy = TRYALLOC;
 		else
 			cache_strategy = DONTALLOC;
 
-		preload_compressed_pages(fe, MNGD_MAPPING(sbi),
-					 cache_strategy, pagepool);
+		z_erofs_bind_cache(fe, cache_strategy, pagepool);
 	}
-
 hitted:
 	/*
 	 * Ensure the current partial page belongs to this submit chain rather
-- 
2.24.4

