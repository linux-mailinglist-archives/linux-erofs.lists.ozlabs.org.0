Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC8F41A4EF
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Sep 2021 03:44:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HJMkS5b1kz2yK7
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Sep 2021 11:44:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b4hMMfJg;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=b4hMMfJg; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HJMkQ23v7z2yK7
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Sep 2021 11:44:30 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DE8D6120F;
 Tue, 28 Sep 2021 01:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632793466;
 bh=ZxL0s7aAvgRHmJu6oP5znjIcna3dJ9oHDuY6p6EGw44=;
 h=From:To:Cc:Subject:Date:From;
 b=b4hMMfJgPJ2lsx6MRLDI2xnOXzIxjmrsWFYXDw+XeJ1b8b8rjap9s2NF2h5BILoXD
 cvN306y/VXYJ5vESag1iZDKz5LSof0R+pcrvwKBMRSUAqtfU6+ds14vL+zvXtSrD66
 NjRJ3lRIi1g6B41wu181ii9AqYsUH246//exEWSkwS2GQns+nvWSeI7vmDdEJ4YQ70
 IaQXrjT+7I5cf57gBElsj+HZzUFFxHbCv1fD1NuG8/9O4cEs0dxGsd/l/n/ASQoJy2
 p8LNzkhEsZuWoMPF+PDt7yZiJiwyVdhKdC0Bo7D57UmCermQEazschn7zXYaDmMa1R
 5CoTQbkcHviEQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: fill filesystem inode count
Date: Tue, 28 Sep 2021 09:41:08 +0800
Message-Id: <20210928014108.30079-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Inode count was missing to fill when refactoring. Fix it.

Fixes: a17497f0844a ("erofs-utils: introduce inode operations")
Fixes: 5e35b75ad499 ("erofs-utils: introduce fuse implementation")
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 lib/inode.c | 3 +--
 mkfs/main.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 26ffa4b2bb38..1538673aa0c6 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -855,14 +855,13 @@ static int erofs_fill_inode(struct erofs_inode *inode,
 
 static struct erofs_inode *erofs_new_inode(void)
 {
-	static unsigned int counter;
 	struct erofs_inode *inode;
 
 	inode = calloc(1, sizeof(struct erofs_inode));
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	inode->i_ino[0] = counter++;	/* inode serial number */
+	inode->i_ino[0] = sbi.inos++;	/* inode serial number */
 	inode->i_count = 1;
 
 	init_list_head(&inode->i_subdirs);
diff --git a/mkfs/main.c b/mkfs/main.c
index beba6eb8b905..1c8dea55f0cd 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -387,7 +387,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	struct erofs_super_block sb = {
 		.magic     = cpu_to_le32(EROFS_SUPER_MAGIC_V1),
 		.blkszbits = LOG_BLOCK_SIZE,
-		.inos   = 0,
+		.inos   = cpu_to_le64(sbi.inos),
 		.build_time = cpu_to_le64(sbi.build_time),
 		.build_time_nsec = cpu_to_le32(sbi.build_time_nsec),
 		.blocks = 0,
-- 
2.20.1

