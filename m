Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 52996926EAC
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jul 2024 07:03:22 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xJqMJ/AD;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WF4Kb1KSXz3dXg
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jul 2024 15:03:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xJqMJ/AD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WF4KT2DWsz3cTQ
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Jul 2024 15:03:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720069382; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/NoRxgVazpT9Yk6KpCjGO+i2k4CzidO4tCwyLjqM6j8=;
	b=xJqMJ/ADC3WysQJlEh/huq6LStda1eu4h0si7XjnqQpRxUtxJtBza36XsRM1djRUE6sGWmFdpiQIAQj1G0j7Q78aYoCJ+STcKcE1XoI8YJOxDysJI44zhW3PnL7GDywntZnq6QtXxQ9EeOaPjSMg+gVOBIVpyM0EpoEfKJFf1uk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W9pH7cT_1720069380;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W9pH7cT_1720069380)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 13:03:01 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/2] erofs-utils: lib: get rid of global sbi in lib/inode.c
Date: Thu,  4 Jul 2024 13:02:58 +0800
Message-Id: <20240704050259.520618-1-hongzhen@linux.alibaba.com>
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
Cc: Hongzhen Luo <hongzhen@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Get rid of the global sbi when EROFS_MT_ENABLED is defined.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: Minor cleanup on the patch.
v1: https://lore.kernel.org/all/20240703121247.3797289-1-hongzhen@linux.alibaba.com/
---
 lib/inode.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 3e82af7..8d60088 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1800,6 +1800,7 @@ static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 {
 	struct erofs_mkfs_dfops *q;
 	int err, err2;
+	struct erofs_sb_info *sbi = ctx->sbi ? ctx->sbi : ctx->u.root->sbi;
 
 	q = malloc(sizeof(*q));
 	if (!q)
@@ -1818,15 +1819,15 @@ static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 
 	q->head = 0;
 	q->tail = 0;
-	sbi.mkfs_dfops = q;
-	err = pthread_create(&sbi.dfops_worker, NULL,
-			     z_erofs_mt_dfops_worker, &sbi);
+	sbi->mkfs_dfops = q;
+	err = pthread_create(&sbi->dfops_worker, NULL,
+			     z_erofs_mt_dfops_worker, sbi);
 	if (err)
 		goto fail;
 
 	err = __erofs_mkfs_build_tree(ctx);
-	erofs_mkfs_go(&sbi, ~0, NULL, 0);
-	err2 = pthread_join(sbi.dfops_worker, NULL);
+	erofs_mkfs_go(sbi, ~0, NULL, 0);
+	err2 = pthread_join(sbi->dfops_worker, NULL);
 	if (!err)
 		err = err2;
 
-- 
2.39.3

