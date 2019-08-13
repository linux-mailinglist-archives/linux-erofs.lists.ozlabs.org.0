Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE648ACB0
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2019 04:31:46 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 466xYV5h8nzDqS0
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2019 12:31:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 466xYP3HHczDqRY
 for <linux-erofs@lists.ozlabs.org>; Tue, 13 Aug 2019 12:31:35 +1000 (AEST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 9382B2D925058D1B3E30;
 Tue, 13 Aug 2019 10:31:30 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 13 Aug
 2019 10:31:23 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 1/3] staging: erofs: inline erofs_inode_is_data_compressed()
Date: Tue, 13 Aug 2019 10:30:52 +0800
Message-ID: <20190813023054.73126-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
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

As a helper in erofs_fs.h, erofs_inode_is_data_compressed()
should be inlined.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/erofs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/erofs_fs.h b/drivers/staging/erofs/erofs_fs.h
index e82e833985e4..8dc2a75e478f 100644
--- a/drivers/staging/erofs/erofs_fs.h
+++ b/drivers/staging/erofs/erofs_fs.h
@@ -62,7 +62,7 @@ enum {
 	EROFS_INODE_LAYOUT_MAX
 };
 
-static bool erofs_inode_is_data_compressed(unsigned int datamode)
+static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 {
 	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
 		return true;
-- 
2.17.1

