Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D162576495
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 17:42:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lkwbb2NK1z3cdr
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Jul 2022 01:42:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LkwbQ5mDZz3c68
	for <linux-erofs@lists.ozlabs.org>; Sat, 16 Jul 2022 01:42:23 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VJPnC2I_1657899733;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJPnC2I_1657899733)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 23:42:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 02/16] erofs: clean up z_erofs_collector_begin()
Date: Fri, 15 Jul 2022 23:41:49 +0800
Message-Id: <20220715154203.48093-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220715154203.48093-1-hsiangkao@linux.alibaba.com>
References: <20220715154203.48093-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Rearrange the code and get rid of all gotos.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 1b6816dd235f..c7be447ac64d 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -521,7 +521,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
-	struct erofs_workgroup *grp;
+	struct erofs_workgroup *grp = NULL;
 	int ret;
 
 	DBG_BUGON(fe->pcl);
@@ -530,33 +530,31 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
 	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
 	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
 
-	if (map->m_flags & EROFS_MAP_META) {
-		if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
-		goto tailpacking;
+	if (!(map->m_flags & EROFS_MAP_META)) {
+		grp = erofs_find_workgroup(fe->inode->i_sb,
+					   map->m_pa >> PAGE_SHIFT);
+	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
 	}
 
-	grp = erofs_find_workgroup(fe->inode->i_sb, map->m_pa >> PAGE_SHIFT);
 	if (grp) {
 		fe->pcl = container_of(grp, struct z_erofs_pcluster, obj);
+		ret = -EEXIST;
 	} else {
-tailpacking:
 		ret = z_erofs_register_pcluster(fe);
-		if (!ret)
-			goto out;
-		if (ret != -EEXIST)
-			return ret;
 	}
 
-	ret = z_erofs_lookup_pcluster(fe);
-	if (ret) {
-		erofs_workgroup_put(&fe->pcl->obj);
+	if (ret == -EEXIST) {
+		ret = z_erofs_lookup_pcluster(fe);
+		if (ret) {
+			erofs_workgroup_put(&fe->pcl->obj);
+			return ret;
+		}
+	} else if (ret) {
 		return ret;
 	}
 
-out:
 	z_erofs_pagevec_ctor_init(&fe->vector, Z_EROFS_NR_INLINE_PAGEVECS,
 				  fe->pcl->pagevec, fe->pcl->vcnt);
 	/* since file-backed online pages are traversed in reverse order */
-- 
2.24.4

