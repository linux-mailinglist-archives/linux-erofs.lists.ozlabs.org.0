Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F2F7857D
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2019 08:53:50 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45xr4q1rFlzDqLq
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2019 16:53:47 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45xr3W4HQ6zDqBb
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jul 2019 16:52:37 +1000 (AEST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 2F802976BC39CD5CD909;
 Mon, 29 Jul 2019 14:52:35 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul
 2019 14:52:27 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 <devel@driverdev.osuosl.org>
Subject: [PATCH 12/22] staging: erofs: refine erofs_allocpage()
Date: Mon, 29 Jul 2019 14:51:49 +0800
Message-ID: <20190729065159.62378-13-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729065159.62378-1-gaoxiang25@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

remove duplicated code in decompressor by introducing
failable erofs_allocpage().

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/decompressor.c | 12 +++---------
 drivers/staging/erofs/internal.h     |  2 +-
 drivers/staging/erofs/utils.c        |  5 +++--
 drivers/staging/erofs/zdata.c        |  2 +-
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/erofs/decompressor.c b/drivers/staging/erofs/decompressor.c
index ee5762351f80..744c43a456e9 100644
--- a/drivers/staging/erofs/decompressor.c
+++ b/drivers/staging/erofs/decompressor.c
@@ -74,15 +74,9 @@ static int lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 			victim = availables[--top];
 			get_page(victim);
 		} else {
-			if (!list_empty(pagepool)) {
-				victim = lru_to_page(pagepool);
-				list_del(&victim->lru);
-				DBG_BUGON(page_ref_count(victim) != 1);
-			} else {
-				victim = alloc_pages(GFP_KERNEL, 0);
-				if (!victim)
-					return -ENOMEM;
-			}
+			victim = erofs_allocpage(pagepool, GFP_KERNEL, false);
+			if (unlikely(!victim))
+				return -ENOMEM;
 			victim->mapping = Z_EROFS_MAPPING_STAGING;
 		}
 		rq->out[i] = victim;
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index b206a85776b4..e35c7d8f75d2 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -517,7 +517,7 @@ int erofs_namei(struct inode *dir, struct qstr *name,
 extern const struct file_operations erofs_dir_fops;
 
 /* utils.c / zdata.c */
-struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp);
+struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp, bool nofail);
 
 #if (EROFS_PCPUBUF_NR_PAGES > 0)
 void *erofs_get_pcpubuf(unsigned int pagenr);
diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index 0e86e44d60d0..260ea2970b4b 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -9,15 +9,16 @@
 #include "internal.h"
 #include <linux/pagevec.h>
 
-struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp)
+struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp, bool nofail)
 {
 	struct page *page;
 
 	if (!list_empty(pool)) {
 		page = lru_to_page(pool);
+		DBG_BUGON(page_ref_count(page) != 1);
 		list_del(&page->lru);
 	} else {
-		page = alloc_pages(gfp | __GFP_NOFAIL, 0);
+		page = alloc_pages(gfp | (nofail ? __GFP_NOFAIL : 0), 0);
 	}
 	return page;
 }
diff --git a/drivers/staging/erofs/zdata.c b/drivers/staging/erofs/zdata.c
index bc478eebf509..02560b940558 100644
--- a/drivers/staging/erofs/zdata.c
+++ b/drivers/staging/erofs/zdata.c
@@ -634,7 +634,7 @@ z_erofs_vle_work_iter_end(struct z_erofs_vle_work_builder *builder)
 static inline struct page *__stagingpage_alloc(struct list_head *pagepool,
 					       gfp_t gfp)
 {
-	struct page *page = erofs_allocpage(pagepool, gfp);
+	struct page *page = erofs_allocpage(pagepool, gfp, true);
 
 	if (unlikely(!page))
 		return NULL;
-- 
2.17.1

