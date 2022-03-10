Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E884D5140
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Mar 2022 19:28:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KDyHH0Lq1z30Fn
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 05:28:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KDyH46PBSz3015
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 05:27:57 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R711e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V6pgl6q_1646936870; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V6pgl6q_1646936870) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 11 Mar 2022 02:27:51 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] erofs: refine managed inode stuffs
Date: Fri, 11 Mar 2022 02:27:43 +0800
Message-Id: <20220310182743.102365-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
References: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Set up the correct gfp mask and use it instead of hard coding.
Also add comments about .invalidatepage() to show more details.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 8 ++++++--
 fs/erofs/zdata.c | 7 +++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 12755217631f..e178100c162a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -532,6 +532,11 @@ static int erofs_managed_cache_releasepage(struct page *page, gfp_t gfp_mask)
 	return ret;
 }
 
+/*
+ * It will be called only on inode eviction. In case that there are still some
+ * decompression requests in progress, wait with rescheduling for a bit here.
+ * We could introduce an extra locking instead but it seems unnecessary.
+ */
 static void erofs_managed_cache_invalidatepage(struct page *page,
 					       unsigned int offset,
 					       unsigned int length)
@@ -565,8 +570,7 @@ static int erofs_init_managed_cache(struct super_block *sb)
 	inode->i_size = OFFSET_MAX;
 
 	inode->i_mapping->a_ops = &managed_cache_aops;
-	mapping_set_gfp_mask(inode->i_mapping,
-			     GFP_NOFS | __GFP_HIGHMEM | __GFP_MOVABLE);
+	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 	sbi->managed_cache = inode;
 	return 0;
 }
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 59aecf42e45c..f5e17c03b2fb 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1091,10 +1091,10 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 					       unsigned int nr,
 					       struct page **pagepool,
-					       struct address_space *mc,
-					       gfp_t gfp)
+					       struct address_space *mc)
 {
 	const pgoff_t index = pcl->obj.index;
+	gfp_t gfp = mapping_gfp_mask(mc);
 	bool tocache = false;
 
 	struct address_space *mapping;
@@ -1350,8 +1350,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
 			struct page *page;
 
 			page = pickup_page_for_submission(pcl, i++, pagepool,
-							  MNGD_MAPPING(sbi),
-							  GFP_NOFS);
+							  MNGD_MAPPING(sbi));
 			if (!page)
 				continue;
 
-- 
2.24.4

