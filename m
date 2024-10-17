Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E429A2199
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 13:57:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XTmY62ntwz3btc
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 22:57:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729166247;
	cv=none; b=Fg3f0jz2TULAq4j2pYMjEhCWXPdQd1Xw/J0L0qr3GG1SbiEsjYuBAj+cEQtIR6dywvtx23j7D2o9mFwOsedzAuycWzVNZus0Y52BnMCD40ROeZ0Or0939gBhlBXDJsCOTb8RQMLWLjvQzuTLG2zxKpdVQVQjSy3beRphF42CmdWh3FznLak2gyD7YyFvIWlhLJiiShvxXCAdHoLRMH5HFlcB8DT2jgUPx8hKT+5u0/PIi2lG6DORcIJeMmY+1myB753bWHDhXXyne8qsT9QN0HuMh014b/kPCc04WN2A22ee3tIYIReEVUmk3XD7wfHxiahwUff1g9fZNyIGJHqSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729166247; c=relaxed/relaxed;
	bh=+0k3fKbkmiBfeJSp47PplMF3yEs2JVdVQUW+a1FcgDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mAmKcZ+YBPf65ffBwCfp9XBHYR0UqVb2qPTyMkc0G9duj+s4sIAgQe9wgjKGVZdsR5wqHCItWJU+TUEb1+Wt8yJxNbVtLhGZz7d1Z59QMKayRtOXI2ypTvSHjNUUIoGbXyihHF01s1/SNzM4V6K6epZcu8w+qW2vKJmlta2vqKrACARMA4ew05QZxAs952IUJZXmZxj9dM4w4Du+i3Cete+XbH5RlyBtD80ywjz4Lw9HScJnQTHl+1gv2ZYfO3XHkuG4Zr0DsG2E4qP7UfqMn8l+Soxz4LtXEQUdMZtdt5wALauHpZ9FLyX6y71IfuEzz69dMKF26gLncz410Pdy5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YZbsUr7w; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YZbsUr7w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XTmY00xHNz2yMD
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Oct 2024 22:57:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729166235; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+0k3fKbkmiBfeJSp47PplMF3yEs2JVdVQUW+a1FcgDM=;
	b=YZbsUr7wyi51zWeIR2eavaPTEyspYWr5mY7Rv/t4cTv59gQOPAghEhIiV/rtrYxf8votiUymOpdUJyUwlpAUuxeXs2WAzL//I/8Y1mf5X+Oh2PRBp0a40M68/OwnIYpSKSlYe9Zt4a+jna2IzU+Z68WJAJu2cUzE87SzOpAVZkI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHKltBl_1729166227 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 19:57:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs: get rid of erofs_{find,insert}_workgroup
Date: Thu, 17 Oct 2024 19:57:03 +0800
Message-ID: <20241017115705.877515-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Chunhai Guo <guochunhai@vivo.com>, LKML <linux-kernel@vger.kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Just fold them into the only two callers since
they are simple enough.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h |  5 +----
 fs/erofs/zdata.c    | 38 +++++++++++++++++++++++++---------
 fs/erofs/zutil.c    | 50 +--------------------------------------------
 3 files changed, 30 insertions(+), 63 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4efd578d7c62..8081ee43cd83 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -457,10 +457,7 @@ void erofs_release_pages(struct page **pagepool);
 
 #ifdef CONFIG_EROFS_FS_ZIP
 void erofs_workgroup_put(struct erofs_workgroup *grp);
-struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
-					     pgoff_t index);
-struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
-					       struct erofs_workgroup *grp);
+bool erofs_workgroup_get(struct erofs_workgroup *grp);
 void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
 void erofs_shrinker_register(struct super_block *sb);
 void erofs_shrinker_unregister(struct super_block *sb);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a569ff9dfd04..7423354d6957 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -714,9 +714,10 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
 	struct super_block *sb = fe->inode->i_sb;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	bool ztailpacking = map->m_flags & EROFS_MAP_META;
 	struct z_erofs_pcluster *pcl;
-	struct erofs_workgroup *grp;
+	struct erofs_workgroup *grp, *pre;
 	int err;
 
 	if (!(map->m_flags & EROFS_MAP_ENCODED) ||
@@ -752,15 +753,23 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 		pcl->obj.index = 0;	/* which indicates ztailpacking */
 	} else {
 		pcl->obj.index = erofs_blknr(sb, map->m_pa);
-
-		grp = erofs_insert_workgroup(fe->inode->i_sb, &pcl->obj);
-		if (IS_ERR(grp)) {
-			err = PTR_ERR(grp);
-			goto err_out;
+		while (1) {
+			xa_lock(&sbi->managed_pslots);
+			pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
+					   NULL, grp, GFP_KERNEL);
+			if (!pre || xa_is_err(pre) || erofs_workgroup_get(pre)) {
+				xa_unlock(&sbi->managed_pslots);
+				break;
+			}
+			/* try to legitimize the current in-tree one */
+			xa_unlock(&sbi->managed_pslots);
+			cond_resched();
 		}
-
-		if (grp != &pcl->obj) {
-			fe->pcl = container_of(grp,
+		if (xa_is_err(pre)) {
+			err = xa_err(pre);
+			goto err_out;
+		} else if (pre) {
+			fe->pcl = container_of(pre,
 					struct z_erofs_pcluster, obj);
 			err = -EEXIST;
 			goto err_out;
@@ -789,7 +798,16 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
 
 	if (!(map->m_flags & EROFS_MAP_META)) {
-		grp = erofs_find_workgroup(sb, blknr);
+		while (1) {
+			rcu_read_lock();
+			grp = xa_load(&EROFS_SB(sb)->managed_pslots, blknr);
+			if (erofs_workgroup_get(grp)) {
+				DBG_BUGON(blknr != grp->index);
+				rcu_read_unlock();
+				break;
+			}
+			rcu_read_unlock();
+		}
 	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 37afe2024840..218b0249a482 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -214,7 +214,7 @@ void erofs_release_pages(struct page **pagepool)
 	}
 }
 
-static bool erofs_workgroup_get(struct erofs_workgroup *grp)
+bool erofs_workgroup_get(struct erofs_workgroup *grp)
 {
 	if (lockref_get_not_zero(&grp->lockref))
 		return true;
@@ -231,54 +231,6 @@ static bool erofs_workgroup_get(struct erofs_workgroup *grp)
 	return true;
 }
 
-struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
-					     pgoff_t index)
-{
-	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	struct erofs_workgroup *grp;
-
-repeat:
-	rcu_read_lock();
-	grp = xa_load(&sbi->managed_pslots, index);
-	if (grp) {
-		if (!erofs_workgroup_get(grp)) {
-			/* prefer to relax rcu read side */
-			rcu_read_unlock();
-			goto repeat;
-		}
-
-		DBG_BUGON(index != grp->index);
-	}
-	rcu_read_unlock();
-	return grp;
-}
-
-struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
-					       struct erofs_workgroup *grp)
-{
-	struct erofs_sb_info *const sbi = EROFS_SB(sb);
-	struct erofs_workgroup *pre;
-
-	DBG_BUGON(grp->lockref.count < 1);
-repeat:
-	xa_lock(&sbi->managed_pslots);
-	pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
-			   NULL, grp, GFP_KERNEL);
-	if (pre) {
-		if (xa_is_err(pre)) {
-			pre = ERR_PTR(xa_err(pre));
-		} else if (!erofs_workgroup_get(pre)) {
-			/* try to legitimize the current in-tree one */
-			xa_unlock(&sbi->managed_pslots);
-			cond_resched();
-			goto repeat;
-		}
-		grp = pre;
-	}
-	xa_unlock(&sbi->managed_pslots);
-	return grp;
-}
-
 static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
 {
 	atomic_long_dec(&erofs_global_shrink_cnt);
-- 
2.43.5

