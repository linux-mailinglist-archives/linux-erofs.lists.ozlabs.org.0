Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1B923F71B
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Aug 2020 11:35:12 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BNxsT73MCzDqGx
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Aug 2020 19:35:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=huawei.com;
 envelope-from=linmiaohe@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BNxsN17ZWzDqDN
 for <linux-erofs@lists.ozlabs.org>; Sat,  8 Aug 2020 19:35:00 +1000 (AEST)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C8169DEA7AD9721ED9F6;
 Sat,  8 Aug 2020 17:19:07 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 8 Aug 2020
 17:18:58 +0800
From: linmiaohe <linmiaohe@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>
Subject: [PATCH] erofs: Convert to use the fallthrough macro
Date: Sat, 8 Aug 2020 17:21:26 +0800
Message-ID: <1596878486-23499-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
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
Cc: linmiaohe@huawei.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Miaohe Lin <linmiaohe@huawei.com>

Convert the uses of fallthrough comments to fallthrough macro.

Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/erofs/zmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 7d40d78ea864..ae325541884e 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -359,7 +359,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		return z_erofs_extent_lookback(m, m->delta[0]);
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		map->m_flags &= ~EROFS_MAP_ZIPPED;
-		/* fallthrough */
+		fallthrough;
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
 		map->m_la = (lcn << lclusterbits) | m->clusterofs;
 		break;
@@ -416,7 +416,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		if (endoff >= m.clusterofs)
 			map->m_flags &= ~EROFS_MAP_ZIPPED;
-		/* fallthrough */
+		fallthrough;
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
 		if (endoff >= m.clusterofs) {
 			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
@@ -433,7 +433,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		end = (m.lcn << lclusterbits) | m.clusterofs;
 		map->m_flags |= EROFS_MAP_FULL_MAPPED;
 		m.delta[0] = 1;
-		/* fallthrough */
+		fallthrough;
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		/* get the correspoinding first chunk */
 		err = z_erofs_extent_lookback(&m, m.delta[0]);
-- 
2.19.1

