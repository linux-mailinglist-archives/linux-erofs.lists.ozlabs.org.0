Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 467E492161
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Aug 2019 12:35:58 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Br1N5qVFzDqjp
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Aug 2019 20:35:52 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Br0p1qWbzDqhs
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Aug 2019 20:35:22 +1000 (AEST)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 6A77A4F10E1188DE1E2D;
 Mon, 19 Aug 2019 18:35:17 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 19 Aug
 2019 18:35:08 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 4/6] staging: erofs: avoid loop in submit chains
Date: Mon, 19 Aug 2019 18:34:24 +0800
Message-ID: <20190819103426.87579-5-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819103426.87579-1-gaoxiang25@huawei.com>
References: <20190819080218.GA42231@138>
 <20190819103426.87579-1-gaoxiang25@huawei.com>
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

As reported by erofs-utils fuzzer, 2 conditions
can happen in corrupted images, which can cause
unexpected behaviors.
 - access the same pcluster one more time;
 - access the tail end pcluster again, e.g.
            _ access again (will trigger tail merging)
           |
     1 2 3 1 2             ->   1 2 3 1
     |_ tail end of the chain    \___/ (unexpected behavior)
Let's detect and avoid them now.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/zdata.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/zdata.c b/drivers/staging/erofs/zdata.c
index 23283c97fd3b..aae2f2b8353f 100644
--- a/drivers/staging/erofs/zdata.c
+++ b/drivers/staging/erofs/zdata.c
@@ -132,7 +132,7 @@ enum z_erofs_collectmode {
 struct z_erofs_collector {
 	struct z_erofs_pagevec_ctor vector;
 
-	struct z_erofs_pcluster *pcl;
+	struct z_erofs_pcluster *pcl, *tailpcl;
 	struct z_erofs_collection *cl;
 	struct page **compressedpages;
 	z_erofs_next_pcluster_t owned_head;
@@ -353,6 +353,11 @@ static struct z_erofs_collection *cllookup(struct z_erofs_collector *clt,
 		return NULL;
 
 	pcl = container_of(grp, struct z_erofs_pcluster, obj);
+	if (clt->owned_head == &pcl->next || pcl == clt->tailpcl) {
+		DBG_BUGON(1);
+		erofs_workgroup_put(grp);
+		return ERR_PTR(-EFSCORRUPTED);
+	}
 
 	cl = z_erofs_primarycollection(pcl);
 	if (unlikely(cl->pageofs != (map->m_la & ~PAGE_MASK))) {
@@ -381,6 +386,9 @@ static struct z_erofs_collection *cllookup(struct z_erofs_collector *clt,
 		}
 	}
 	mutex_lock(&cl->lock);
+	/* used to check tail merging loop due to corrupted images */
+	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
+		clt->tailpcl = pcl;
 	clt->mode = try_to_claim_pcluster(pcl, &clt->owned_head);
 	clt->pcl = pcl;
 	clt->cl = cl;
@@ -434,6 +442,9 @@ static struct z_erofs_collection *clregister(struct z_erofs_collector *clt,
 		kmem_cache_free(pcluster_cachep, pcl);
 		return ERR_PTR(-EAGAIN);
 	}
+	/* used to check tail merging loop due to corrupted images */
+	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
+		clt->tailpcl = pcl;
 	clt->owned_head = &pcl->next;
 	clt->pcl = pcl;
 	clt->cl = cl;
-- 
2.17.1

