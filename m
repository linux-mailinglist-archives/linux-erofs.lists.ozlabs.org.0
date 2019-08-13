Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA558ACB6
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2019 04:31:58 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 466xYl359fzDqRb
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2019 12:31:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 466xYS09jvzDqRY
 for <linux-erofs@lists.ozlabs.org>; Tue, 13 Aug 2019 12:31:39 +1000 (AEST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id AB3D69219D8AF292E8CA;
 Tue, 13 Aug 2019 10:31:35 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 13 Aug
 2019 10:31:25 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 2/3] staging: erofs: remove incomplete cleancache
Date: Tue, 13 Aug 2019 10:30:53 +0800
Message-ID: <20190813023054.73126-2-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813023054.73126-1-gaoxiang25@huawei.com>
References: <20190813023054.73126-1-gaoxiang25@huawei.com>
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

cleancache was not fully implemented in EROFS.
In addition, it's tend to remove the whole cleancache in
related attempt [1].

[1] https://lore.kernel.org/linux-fsdevel/20190527103207.13287-3-jgross@suse.com/
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/data.c     | 6 ------
 drivers/staging/erofs/internal.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
index 75b859e48084..4cdb743c8b8d 100644
--- a/drivers/staging/erofs/data.c
+++ b/drivers/staging/erofs/data.c
@@ -201,12 +201,6 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 		goto has_updated;
 	}
 
-	if (cleancache_get_page(page) == 0) {
-		err = 0;
-		SetPageUptodate(page);
-		goto has_updated;
-	}
-
 	/* note that for readpage case, bio also equals to NULL */
 	if (bio &&
 	    /* not continuous */
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 118e7c7e4d4d..4ce5991c381f 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -15,7 +15,6 @@
 #include <linux/pagemap.h>
 #include <linux/bio.h>
 #include <linux/buffer_head.h>
-#include <linux/cleancache.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include "erofs_fs.h"
-- 
2.17.1

