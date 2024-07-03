Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B642C925FD8
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 14:13:09 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=B3+NRoG4;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WDdw33kDrz3d8t
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 22:13:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=B3+NRoG4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WDdvr1rmKz3cXH
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jul 2024 22:12:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720008771; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8YFQjt+XGzB4cvoXUvDUGzvUmdnbsbhjrbCe/DbOQkE=;
	b=B3+NRoG4pa1FBEeWsd9u9QOdUkEvFyGTZUyC2fva2I7jjjpC7/gbGh05l0N8P5lW+WGrAr7g4bgSyoPTFDwtnvejDOMvayrFxJc6UeWXlPU9kIkRvYOtNjlwCxPpYzx7LqMtv+PW66Y+Nc5MtzCj3fYB2eKCj825RzosPIBvkzM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W9mP1zJ_1720008769;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W9mP1zJ_1720008769)
          by smtp.aliyun-inc.com;
          Wed, 03 Jul 2024 20:12:50 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: lib: get rid of global sbi in lib/inode.c
Date: Wed,  3 Jul 2024 20:12:46 +0800
Message-Id: <20240703121247.3797289-1-hongzhen@linux.alibaba.com>
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
 lib/inode.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 3e82af7..6001013 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1800,6 +1800,7 @@ static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 {
 	struct erofs_mkfs_dfops *q;
 	int err, err2;
+	struct erofs_sb_info *sbi = !!ctx->sbi ? ctx->sbi : ctx->u.root->sbi;
 
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

