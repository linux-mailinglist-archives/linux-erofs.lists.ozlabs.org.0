Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B30BB9F70
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Sep 2019 20:45:31 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46bKK4209LzDqRq
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Sep 2019 04:45:28 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46bKJz44yGzDqC9
 for <linux-erofs@lists.ozlabs.org>; Sun, 22 Sep 2019 04:45:20 +1000 (AEST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C8D3E833CB90D33ABA42;
 Sun, 22 Sep 2019 02:45:15 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sun, 22 Sep
 2019 02:45:10 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v2] erofs: fix erofs_get_meta_page locking by a cleanup
Date: Sun, 22 Sep 2019 02:43:55 +0800
Message-ID: <20190921184355.149928-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190921073035.209811-1-gaoxiang25@huawei.com>
References: <20190921073035.209811-1-gaoxiang25@huawei.com>
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

After doing more drop_caches stress test on
our products, I found the mistake introduced by
a very recent cleanup [1].

The current rule is that "erofs_get_meta_page"
should be returned with page locked (although
it's mostly unnecessary for read-only fs after
pages are PG_uptodate), but a fix should be
done for this.

[1] https://lore.kernel.org/r/20190904020912.63925-26-gaoxiang25@huawei.com
Fixes: 618f40ea026b ("erofs: use read_cache_page_gfp for erofs_get_meta_page")
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
changelog from v1:
 - type of return value should be struct page *.

 fs/erofs/data.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 8a9fcbd0e8ac..fc3a8d8064f8 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -34,11 +34,15 @@ static void erofs_readendio(struct bio *bio)
 
 struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
 {
-	struct inode *const bd_inode = sb->s_bdev->bd_inode;
-	struct address_space *const mapping = bd_inode->i_mapping;
+	struct address_space *const mapping = sb->s_bdev->bd_inode->i_mapping;
+	struct page *page;
 
-	return read_cache_page_gfp(mapping, blkaddr,
+	page = read_cache_page_gfp(mapping, blkaddr,
 				   mapping_gfp_constraint(mapping, ~__GFP_FS));
+	/* should already be PageUptodate */
+	if (!IS_ERR(page))
+		lock_page(page);
+	return page;
 }
 
 static int erofs_map_blocks_flatmode(struct inode *inode,
-- 
2.17.1

