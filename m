Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1415E7DC634
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Oct 2023 07:05:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SKKPq2qncz3c3g
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Oct 2023 17:05:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SKKPc0Kx8z2xpp
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Oct 2023 17:05:37 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VvGHDFU_1698732325;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VvGHDFU_1698732325)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 14:05:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix erofs_insert_workgroup() lockref usage
Date: Tue, 31 Oct 2023 14:05:24 +0800
Message-Id: <20231031060524.1103921-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As Linus pointed out [1], lockref_put_return() is fundamentally
designed to be something that can fail.  It behaves as a fastpath-only
thing, and the failure case needs to be handled anyway.

Actually, since the new pcluster was just allocated without being
populated, it won't be accessed by others until it is inserted into
XArray, so lockref helpers are actually unneeded here.

Let's just set the proper reference count on initializing.

[1] https://lore.kernel.org/r/CAHk-=whCga8BeQnJ3ZBh_Hfm9ctba_wpF444LpwRybVNMzO6Dw@mail.gmail.com
Fixes: 7674a42f35ea ("erofs: use struct lockref to replace handcrafted approach")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/utils.c | 8 +-------
 fs/erofs/zdata.c | 1 +
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index cc6fb9e98899..4256a85719a1 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -77,12 +77,7 @@ struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 	struct erofs_workgroup *pre;
 
-	/*
-	 * Bump up before making this visible to others for the XArray in order
-	 * to avoid potential UAF without serialized by xa_lock.
-	 */
-	lockref_get(&grp->lockref);
-
+	DBG_BUGON(grp->lockref.count < 1);
 repeat:
 	xa_lock(&sbi->managed_pslots);
 	pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
@@ -96,7 +91,6 @@ struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
 			cond_resched();
 			goto repeat;
 		}
-		lockref_put_return(&grp->lockref);
 		grp = pre;
 	}
 	xa_unlock(&sbi->managed_pslots);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 036f610e044b..a7e6847f6f8f 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -796,6 +796,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 		return PTR_ERR(pcl);
 
 	spin_lock_init(&pcl->obj.lockref.lock);
+	pcl->obj.lockref.count = 1;	/* one ref for this request */
 	pcl->algorithmformat = map->m_algorithmformat;
 	pcl->length = 0;
 	pcl->partial = true;
-- 
2.39.3

