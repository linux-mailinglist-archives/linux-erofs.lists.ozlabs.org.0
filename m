Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id F207ECFA6F
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2019 14:53:41 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46ncjG46RGzDqNk
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2019 23:53:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46ncj42g4rzDqKT
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2019 23:53:26 +1100 (AEDT)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id E8BFF7BAEF272BFF2464;
 Tue,  8 Oct 2019 20:53:20 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 8 Oct 2019
 20:53:10 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH for-next 1/5] erofs: clean up collection handling routines
Date: Tue, 8 Oct 2019 20:56:12 +0800
Message-ID: <20191008125616.183715-1-gaoxiang25@huawei.com>
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
Cc: Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

 - change return value to int since collection is
   already returned within the collector.
 - better function naming.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/zdata.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index fad80c97d247..ef32757d1aac 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -337,9 +337,9 @@ try_to_claim_pcluster(struct z_erofs_pcluster *pcl,
 	return COLLECT_PRIMARY;	/* :( better luck next time */
 }
 
-static struct z_erofs_collection *cllookup(struct z_erofs_collector *clt,
-					   struct inode *inode,
-					   struct erofs_map_blocks *map)
+static int z_erofs_lookup_collection(struct z_erofs_collector *clt,
+				     struct inode *inode,
+				     struct erofs_map_blocks *map)
 {
 	struct erofs_workgroup *grp;
 	struct z_erofs_pcluster *pcl;
@@ -349,20 +349,20 @@ static struct z_erofs_collection *cllookup(struct z_erofs_collector *clt,
 
 	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT, &tag);
 	if (!grp)
-		return NULL;
+		return -ENOENT;
 
 	pcl = container_of(grp, struct z_erofs_pcluster, obj);
 	if (clt->owned_head == &pcl->next || pcl == clt->tailpcl) {
 		DBG_BUGON(1);
 		erofs_workgroup_put(grp);
-		return ERR_PTR(-EFSCORRUPTED);
+		return -EFSCORRUPTED;
 	}
 
 	cl = z_erofs_primarycollection(pcl);
 	if (cl->pageofs != (map->m_la & ~PAGE_MASK)) {
 		DBG_BUGON(1);
 		erofs_workgroup_put(grp);
-		return ERR_PTR(-EFSCORRUPTED);
+		return -EFSCORRUPTED;
 	}
 
 	length = READ_ONCE(pcl->length);
@@ -370,7 +370,7 @@ static struct z_erofs_collection *cllookup(struct z_erofs_collector *clt,
 		if ((map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) > length) {
 			DBG_BUGON(1);
 			erofs_workgroup_put(grp);
-			return ERR_PTR(-EFSCORRUPTED);
+			return -EFSCORRUPTED;
 		}
 	} else {
 		unsigned int llen = map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT;
@@ -394,12 +394,12 @@ static struct z_erofs_collection *cllookup(struct z_erofs_collector *clt,
 		clt->tailpcl = NULL;
 	clt->pcl = pcl;
 	clt->cl = cl;
-	return cl;
+	return 0;
 }
 
-static struct z_erofs_collection *clregister(struct z_erofs_collector *clt,
-					     struct inode *inode,
-					     struct erofs_map_blocks *map)
+static int z_erofs_register_collection(struct z_erofs_collector *clt,
+				       struct inode *inode,
+				       struct erofs_map_blocks *map)
 {
 	struct z_erofs_pcluster *pcl;
 	struct z_erofs_collection *cl;
@@ -408,7 +408,7 @@ static struct z_erofs_collection *clregister(struct z_erofs_collector *clt,
 	/* no available workgroup, let's allocate one */
 	pcl = kmem_cache_alloc(pcluster_cachep, GFP_NOFS);
 	if (!pcl)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	z_erofs_pcluster_init_always(pcl);
 	pcl->obj.index = map->m_pa >> PAGE_SHIFT;
@@ -442,7 +442,7 @@ static struct z_erofs_collection *clregister(struct z_erofs_collector *clt,
 	if (err) {
 		mutex_unlock(&cl->lock);
 		kmem_cache_free(pcluster_cachep, pcl);
-		return ERR_PTR(-EAGAIN);
+		return -EAGAIN;
 	}
 	/* used to check tail merging loop due to corrupted images */
 	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
@@ -450,14 +450,14 @@ static struct z_erofs_collection *clregister(struct z_erofs_collector *clt,
 	clt->owned_head = &pcl->next;
 	clt->pcl = pcl;
 	clt->cl = cl;
-	return cl;
+	return 0;
 }
 
 static int z_erofs_collector_begin(struct z_erofs_collector *clt,
 				   struct inode *inode,
 				   struct erofs_map_blocks *map)
 {
-	struct z_erofs_collection *cl;
+	int ret;
 
 	DBG_BUGON(clt->cl);
 
@@ -471,19 +471,22 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
 	}
 
 repeat:
-	cl = cllookup(clt, inode, map);
-	if (!cl) {
-		cl = clregister(clt, inode, map);
+	ret = z_erofs_lookup_collection(clt, inode, map);
+	if (ret == -ENOENT) {
+		ret = z_erofs_register_collection(clt, inode, map);
 
-		if (cl == ERR_PTR(-EAGAIN))
+		/* someone registered at the same time, give another try */
+		if (ret == -EAGAIN) {
+			cond_resched();
 			goto repeat;
+		}
 	}
 
-	if (IS_ERR(cl))
-		return PTR_ERR(cl);
+	if (ret)
+		return ret;
 
 	z_erofs_pagevec_ctor_init(&clt->vector, Z_EROFS_NR_INLINE_PAGEVECS,
-				  cl->pagevec, cl->vcnt);
+				  clt->cl->pagevec, clt->cl->vcnt);
 
 	clt->compressedpages = clt->pcl->compressed_pages;
 	if (clt->mode <= COLLECT_PRIMARY) /* cannot do in-place I/O */
-- 
2.17.1

