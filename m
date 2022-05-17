Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5AE529FA3
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 12:41:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L2Xjw1MV0z3bxh
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 20:41:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LkbnQ0vi;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=LkbnQ0vi; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L2Xjp2lxfz3bZY
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 May 2022 20:41:50 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4324A6166F;
 Tue, 17 May 2022 10:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95684C34100;
 Tue, 17 May 2022 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652784105;
 bh=rEjHDbuf51t9QAOOo/GMmQiQFx59C37vt/2A1ZBKTyE=;
 h=From:To:Cc:Subject:Date:From;
 b=LkbnQ0viorSecGNLevKgXLYcHzYv0JUcwbBmLFv1aMjGQEBoXZ/q/kjqZ/Jd+Eds4
 WdCH5ZWwQAC/5V9eVmkYwq9nj4pmVGgr5dldC3EJqTRwN+9kbcWEV3CIy4Y8h6p2ZA
 5VZi9GocsHbsvHHJQPlYn1aUMeOmY5AhpFybGYgDcMafKKyKItCZvI/FMymFIkA9X1
 /LPH4Lbc+RTy/r1K3y6Hh7lU1a4QRutqz1H5/DzdwNRIiPR47zCBsmSmy813ggwqI9
 Kwy//d9KWMhkejdiSChQrcgNYGxdGI0zUAB4Xdjib+/SgNgFqo74u8XdVC4dyRXw3S
 3HZ8ZqSa6pTqg==
From: Chao Yu <chao@kernel.org>
To: xiang@kernel.org
Subject: [PATCH v2] erofs: support idmapped mounts
Date: Tue, 17 May 2022 18:41:03 +0800
Message-Id: <20220517104103.3570721-1-chao@kernel.org>
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
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
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

6. mount-idmapped --map-mount b:1000:1001:1 /mnt/erofs/ /mnt/scratch_erofs/

7. ls -ln /mnt/scratch_erofs/
total 0
-rw-rw-r-- 1 1001 1001 0 May 17 15:26 file

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
v2:
- fix testcase pointed out by Christian Brauner.
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

