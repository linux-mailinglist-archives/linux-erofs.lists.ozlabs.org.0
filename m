Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CB23F529AE8
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 09:34:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L2SYR5Rl9z3brt
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 17:34:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bLdytL7A;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bLdytL7A; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L2SYN2fShz30QN
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 May 2022 17:34:16 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D0CC560C96;
 Tue, 17 May 2022 07:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3387C34100;
 Tue, 17 May 2022 07:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652772852;
 bh=mWtRFK07XdthxAyT5dCny+PVTYE0BwB4uEKr/xRO3zk=;
 h=From:To:Cc:Subject:Date:From;
 b=bLdytL7ALgmmfQn81ZRSqUooLSS+0Z05fX0kdO1KvKOt+ZhdAe9cGuYMEdjYKwb8y
 psJQtyxYjhQOCNdu6eeHOJp8uCb0Ux8uB7GmdNAKZuoaSE66j4BDbzR0ddIbU2zHtv
 uSzzXAuRMn0CBCXipi/Vq1CFe7y5w789X77Q7CGAmdkXs8M0izbRA1FW2eGPP2K/rf
 sPly7nBMPbAAMGDp35FKAFE4ERIp3cHynAMVPtQGbRXQJInxT5VbBjDZFwhh4KGiHo
 Z6tKa6zAXSojS7+KAV5LYek0hfg9hfvZDOVu0cCQlWL2WO22quFLa5qeI0uPKmpvV5
 z92QWzj3wOxWA==
From: Chao Yu <chao@kernel.org>
To: xiang@kernel.org
Subject: [PATCH] erofs: support idmapped mounts
Date: Tue, 17 May 2022 15:32:10 +0800
Message-Id: <20220517073210.3569589-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Chao Yu <chao.yu@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch enables idmapped mounts for erofs, since all dedicated helpers
for this functionality existsm, so, in this patch we just pass down the
user_namespace argument from the VFS methods to the relevant helpers.

Simple idmap example on erofs image:

1. mkdir dir
2. touch dir/file
3. mkfs.erofs erofs.img dir
4. mount -t erofs -o loop erofs.img  /mnt/erofs/

5. ls -ln /mnt/erofs/
total 0
-rw-rw-r-- 1 1000 1000 0 May 17 15:26 file

6. mount-idmapped --map-mount b:0:1001:1 /mnt/erofs/ /mnt/scratch_erofs/

7. ls -ln /mnt/scratch_erofs/
total 0
-rw-rw-r-- 1 65534 65534 0 May 17 15:26 file

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/erofs/inode.c | 2 +-
 fs/erofs/super.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index e8b37ba5e9ad..5320bf52c1ce 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -370,7 +370,7 @@ int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
 				  STATX_ATTR_IMMUTABLE);
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(mnt_userns, inode, stat);
 	return 0;
 }
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0c4b41130c2f..7dc5f2e8ddee 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -781,7 +781,7 @@ static struct file_system_type erofs_fs_type = {
 	.name           = "erofs",
 	.init_fs_context = erofs_init_fs_context,
 	.kill_sb        = erofs_kill_sb,
-	.fs_flags       = FS_REQUIRES_DEV,
+	.fs_flags       = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("erofs");
 
-- 
2.25.1

