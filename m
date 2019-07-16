Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 467766A2A6
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 09:06:30 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nrzR4JB6zDqTh
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 17:06:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com; envelope-from=yuchao0@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nrzN2y1czDqKM
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 17:06:24 +1000 (AEST)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 0211B411FFDFF9F98B34;
 Tue, 16 Jul 2019 15:06:22 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 16 Jul 2019 15:06:11 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>
Subject: [PATCH] staging: erofs: support bmap
Date: Tue, 16 Jul 2019 15:05:42 +0800
Message-ID: <20190716070543.88863-1-yuchao0@huawei.com>
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

Add erofs_bmap() to support FIBMAP ioctl on flatmode inode.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 drivers/staging/erofs/data.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
index fbce71403d87..03da57f04347 100644
--- a/drivers/staging/erofs/data.c
+++ b/drivers/staging/erofs/data.c
@@ -308,9 +308,38 @@ static int erofs_raw_access_readpages(struct file *filp,
 	return iomap_readpages(mapping, pages, nr_pages, &erofs_iomap_ops);
 }
 
+static int erofs_get_block(struct inode *inode, sector_t iblock,
+			   struct buffer_head *bh, int create)
+{
+	struct erofs_map_blocks map = {
+		.m_la = iblock << 9,
+	};
+	int err;
+
+	err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+	if (err)
+		return err;
+
+	if (map.m_flags & EROFS_MAP_MAPPED)
+		bh->b_blocknr = erofs_blknr(map.m_pa);
+
+	return err;
+}
+
+static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
+{
+	struct inode *inode = mapping->host;
+
+	if (is_inode_flat_inline(inode))
+		return 0;
+
+	return generic_block_bmap(mapping, block, erofs_get_block);
+}
+
 /* for uncompressed (aligned) files and raw access for other files */
 const struct address_space_operations erofs_raw_access_aops = {
 	.readpage = erofs_raw_access_readpage,
 	.readpages = erofs_raw_access_readpages,
+	.bmap = erofs_bmap,
 };
 
-- 
2.18.0.rc1

