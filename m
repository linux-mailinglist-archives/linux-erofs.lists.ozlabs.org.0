Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA9D6A44A
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 10:53:27 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nvLq67WHzDqP3
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 18:53:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com; envelope-from=yuchao0@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nvLl4s81zDqG6
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 18:53:19 +1000 (AEST)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 4C4B38E9AD9D2EE5710D;
 Tue, 16 Jul 2019 16:53:15 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 16 Jul 2019 16:53:07 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>
Subject: [PATCH] staging: erofs: avoid opened loop codes
Date: Tue, 16 Jul 2019 16:52:59 +0800
Message-ID: <20190716085259.103481-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use __GFP_NOFAIL to avoid opened loop codes in z_erofs_vle_unzip().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index f0dab81ff816..3a0dbcb8cc9f 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -921,18 +921,17 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		 mutex_trylock(&z_pagemap_global_lock))
 		pages = z_pagemap_global;
 	else {
-repeat:
-		pages = kvmalloc_array(nr_pages, sizeof(struct page *),
-				       GFP_KERNEL);
+		gfp_t flags = GFP_KERNEL;
+
+		if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES)
+			flags |= __GFP_NOFAIL;
+
+		pages = kvmalloc_array(nr_pages, sizeof(struct page *), flags);
 
 		/* fallback to global pagemap for the lowmem scenario */
 		if (unlikely(!pages)) {
-			if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES)
-				goto repeat;
-			else {
-				mutex_lock(&z_pagemap_global_lock);
-				pages = z_pagemap_global;
-			}
+			mutex_lock(&z_pagemap_global_lock);
+			pages = z_pagemap_global;
 		}
 	}
 
-- 
2.18.0.rc1

