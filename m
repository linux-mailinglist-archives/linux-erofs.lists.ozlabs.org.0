Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3548241A4F0
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Sep 2021 03:45:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HJMl11LDxz2yNr
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Sep 2021 11:45:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qq7O1ipT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qq7O1ipT; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HJMkz0P0sz2xr5
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Sep 2021 11:44:59 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C3E36120A;
 Tue, 28 Sep 2021 01:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632793497;
 bh=ZxL0s7aAvgRHmJu6oP5znjIcna3dJ9oHDuY6p6EGw44=;
 h=From:To:Cc:Subject:Date:From;
 b=qq7O1ipT6hCmZxJDcg2vI2xgXwncp5Hob/LnzcwLUsBO+AY+8jU62f+BlL/V8Eld2
 JGSjzdXeXYCiBKfUsBgHbxLZG8H+iOjdVAlsZ39R2vADyrGYr3SqFR6kvtNkSlEajb
 PQzwpCTeDXx7FzV+vZjJ8YAkQDP+nFZ/O0JDJK5Vu6ZXwC8Nhd0IwUedhNSW/b6IP7
 bFuvORxHTPewH9nij4DyZpujgrvtN5R9ZI5zXvrBsHTqJm1nMZd8Gc+elli2yGSCGj
 2Y63m/nIZha3IRUYtCwNBZO/n0EjJgNI/Ht0J9S7q8mga2CoVYJXiERjBe8dMjpKJv
 vK6OfKXYqNJdg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: fill filesystem inode count
Date: Tue, 28 Sep 2021 09:44:26 +0800
Message-Id: <20210928014426.30174-1-xiang@kernel.org>
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

