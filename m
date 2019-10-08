Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 379F5CFA77
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2019 14:53:55 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46ncjW0bW4zDqLN
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2019 23:53:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46ncj42jfHzDqKV
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2019 23:53:26 +1100 (AEDT)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id EE0A8341A32B5758DA77;
 Tue,  8 Oct 2019 20:53:20 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 8 Oct 2019
 20:53:14 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH for-next 3/5] erofs: get rid of __stagingpage_alloc helper
Date: Tue, 8 Oct 2019 20:56:14 +0800
Message-ID: <20191008125616.183715-3-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008125616.183715-1-gaoxiang25@huawei.com>
References: <20191008125616.183715-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Now open code is much cleaner due to iterative development.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/zdata.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 93f8bc1a64f6..e2a89aa921b1 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -546,15 +546,6 @@ static bool z_erofs_collector_end(struct z_erofs_collector *clt)
 	return true;
 }
 
-static inline struct page *__stagingpage_alloc(struct list_head *pagepool,
-					       gfp_t gfp)
-{
-	struct page *page = erofs_allocpage(pagepool, gfp, true);
-
-	page->mapping = Z_EROFS_MAPPING_STAGING;
-	return page;
-}
-
 static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
 				       unsigned int cachestrategy,
 				       erofs_off_t la)
@@ -661,8 +652,9 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	/* should allocate an additional staging page for pagevec */
 	if (err == -EAGAIN) {
 		struct page *const newpage =
-			__stagingpage_alloc(pagepool, GFP_NOFS);
+			erofs_allocpage(pagepool, GFP_NOFS, true);
 
+		newpage->mapping = Z_EROFS_MAPPING_STAGING;
 		err = z_erofs_attach_page(clt, newpage,
 					  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
 		if (!err)
@@ -1079,15 +1071,14 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	unlock_page(page);
 	put_page(page);
 out_allocpage:
-	page = __stagingpage_alloc(pagepool, gfp);
+	page = erofs_allocpage(pagepool, gfp, true);
 	if (oldpage != cmpxchg(&pcl->compressed_pages[nr], oldpage, page)) {
 		list_add(&page->lru, pagepool);
 		cpu_relax();
 		goto repeat;
 	}
-	if (!tocache)
-		goto out;
-	if (add_to_page_cache_lru(page, mc, index + nr, gfp)) {
+
+	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
 		page->mapping = Z_EROFS_MAPPING_STAGING;
 		goto out;
 	}
-- 
2.17.1

