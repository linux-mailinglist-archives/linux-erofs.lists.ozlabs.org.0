Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4336A2A4
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 09:05:44 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nryY1hkVzDqXg
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 17:05:41 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nrxf026jzDqX6
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 17:04:53 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 8C492D99825D6ABE1A18;
 Tue, 16 Jul 2019 15:04:50 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Jul
 2019 15:04:40 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: [PATCH v2 14/17] erofs-utils: non-inline tail-end block should be
 zeroed beyond EOF
Date: Tue, 16 Jul 2019 15:04:16 +0800
Message-ID: <20190716070419.30203-15-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190716070419.30203-1-gaoxiang25@huawei.com>
References: <20190716070419.30203-1-gaoxiang25@huawei.com>
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Otherwise random data from last bdrop() could be readed and
it will cause unexpected behavior accidentally.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 lib/inode.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 16b011e..affd6db 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -523,14 +523,19 @@ int erofs_write_tail_end(struct erofs_inode *inode)
 		ibh->op = &erofs_write_inline_bhops;
 	} else {
 		int ret;
+		erofs_off_t pos;
 
 		erofs_mapbh(bh->block, true);
-		ret = dev_write(inode->idata,
-				erofs_btell(bh, true) - EROFS_BLKSIZ,
-				inode->idata_size);
+		pos = erofs_btell(bh, true) - EROFS_BLKSIZ;
+		ret = dev_write(inode->idata, pos, inode->idata_size);
 		if (ret)
 			return ret;
-
+		if (inode->idata_size < EROFS_BLKSIZ) {
+			ret = dev_fillzero(pos + inode->idata_size,
+					   EROFS_BLKSIZ - inode->idata_size);
+			if (ret)
+				return ret;
+		}
 		inode->idata_size = 0;
 		free(inode->idata);
 		inode->idata = NULL;
-- 
2.17.1

