Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CC99E34FCA3
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Mar 2021 11:25:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9LWs6Khjz3bmw
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Mar 2021 20:25:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com;
 envelope-from=gongruiqi1@huawei.com; receiver=<UNKNOWN>)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9LWq1F9Qz2yYn
 for <linux-erofs@lists.ozlabs.org>; Wed, 31 Mar 2021 20:25:26 +1100 (AEDT)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9LTB6xRBz1BFhW;
 Wed, 31 Mar 2021 17:23:10 +0800 (CST)
Received: from ubuntu.huawei.com (10.67.174.117) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 17:25:08 +0800
From: Ruiqi Gong <gongruiqi1@huawei.com>
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Subject: [PATCH -next] erofs: Clean up spelling mistakes found in fs/erofs
Date: Wed, 31 Mar 2021 05:39:20 -0400
Message-ID: <20210331093920.31923-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.117]
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
Cc: Wang Weiyang <wangweiyang2@huawei.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

zmap.c:  s/correspoinding/corresponding
zdata.c: s/endding/ending

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ruiqi Gong <gongruiqi1@huawei.com>
---
 fs/erofs/zdata.c | 2 +-
 fs/erofs/zmap.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index cd9b76216925..4226f4115981 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -933,7 +933,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 				 }, pagepool);
 
 out:
-	/* must handle all compressed pages before endding pages */
+	/* must handle all compressed pages before ending pages */
 	for (i = 0; i < clusterpages; ++i) {
 		page = compressed_pages[i];
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 14d2de35110c..b384f546d368 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -443,7 +443,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		m.delta[0] = 1;
 		fallthrough;
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
-		/* get the correspoinding first chunk */
+		/* get the corresponding first chunk */
 		err = z_erofs_extent_lookback(&m, m.delta[0]);
 		if (err)
 			goto unmap_out;
-- 
2.17.1

