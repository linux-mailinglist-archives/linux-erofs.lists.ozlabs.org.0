Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C967C7F1
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2019 18:00:00 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45zJ64499czDqfS
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Aug 2019 01:59:56 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45zJ4Q6lnTzDqjb
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Aug 2019 01:58:30 +1000 (AEST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id DD1B386E5F4DE52E5264;
 Wed, 31 Jul 2019 23:58:25 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 23:58:15 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chao Yu
 <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>
Subject: [PATCH v2 05/22] staging: erofs: sunset erofs_workstn_{lock,unlock}
Date: Wed, 31 Jul 2019 23:57:35 +0800
Message-ID: <20190731155752.210602-6-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731155752.210602-1-gaoxiang25@huawei.com>
References: <20190731155752.210602-1-gaoxiang25@huawei.com>
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

It was used for Linux backward compatibility, and
no use for upstream kernel.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/internal.h |  3 ---
 drivers/staging/erofs/utils.c    | 10 +++++-----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 501429ec0f91..ed487ee56f74 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -179,9 +179,6 @@ static inline void *erofs_kmalloc(struct erofs_sb_info *sbi,
 #define test_opt(sbi, option)	((sbi)->mount_opt & EROFS_MOUNT_##option)
 
 #ifdef CONFIG_EROFS_FS_ZIP
-#define erofs_workstn_lock(sbi)         xa_lock(&(sbi)->workstn_tree)
-#define erofs_workstn_unlock(sbi)       xa_unlock(&(sbi)->workstn_tree)
-
 /* basic unit of the workstation of a super_block */
 struct erofs_workgroup {
 	/* the workgroup index in the workstation */
diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index a68dbe375fa0..024806003297 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -102,14 +102,14 @@ int erofs_register_workgroup(struct super_block *sb,
 		return err;
 
 	sbi = EROFS_SB(sb);
-	erofs_workstn_lock(sbi);
+	xa_lock(&sbi->workstn_tree);
 
 	grp = xa_tag_pointer(grp, tag);
 
 	/*
 	 * Bump up reference count before making this workgroup
 	 * visible to other users in order to avoid potential UAF
-	 * without serialized by erofs_workstn_lock.
+	 * without serialized by workstn_lock.
 	 */
 	__erofs_workgroup_get(grp);
 
@@ -122,7 +122,7 @@ int erofs_register_workgroup(struct super_block *sb,
 		 */
 		__erofs_workgroup_put(grp);
 
-	erofs_workstn_unlock(sbi);
+	xa_unlock(&sbi->workstn_tree);
 	radix_tree_preload_end();
 	return err;
 }
@@ -225,7 +225,7 @@ unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 
 	int i, found;
 repeat:
-	erofs_workstn_lock(sbi);
+	xa_lock(&sbi->workstn_tree);
 
 	found = radix_tree_gang_lookup(&sbi->workstn_tree,
 				       batch, first_index, PAGEVEC_SIZE);
@@ -243,7 +243,7 @@ unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 		if (unlikely(!--nr_shrink))
 			break;
 	}
-	erofs_workstn_unlock(sbi);
+	xa_unlock(&sbi->workstn_tree);
 
 	if (i && nr_shrink)
 		goto repeat;
-- 
2.17.1

