Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEC08A7C9A
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Apr 2024 08:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1713336895;
	bh=SdD2UHHc0m2CStUM4v9MUx7aVjIF7P7uKWtzPEgyptw=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=lVU8+UNhpLJtlQOVDlujPY6lk6I10b938i8TKxw+XpogseBGqUXavTHsf2q0Q+dDW
	 GoqRIbOdcqeRmXs2uMU2FUI/Bx57X2cmEgwV4HpYKe7Sln19JSb4BASpjmfr47i+Jd
	 h2SvOUXSXT6fG24YtXfha71kJGdAYeiFQrOm/sf5/FUDnuQXHZIUsQ16Oy24XhhASd
	 ICqCCX0Ll4p4cZoo9CeoT6DqBkIzoSt5Q0j2Jr3QB7zTpGa91sHfUcplgP4yVjQ+6j
	 cXG2tBXNZIYs3eQ91JFKQhsdDH7YWpj7XzgkKc/Y7V/dstvtIoHV3yemtH79Y3M79B
	 6g9CgkcTbnKJA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKBVR34QJz3dTs
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Apr 2024 16:54:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=libaokun1@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKBVH1Ygrz2y71
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Apr 2024 16:54:43 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VKBT51YpFz1HCMD;
	Wed, 17 Apr 2024 14:53:45 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id BDA291400D9;
	Wed, 17 Apr 2024 14:54:38 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 14:54:38 +0800
To: <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v2] erofs: reliably distinguish block based and fscache mode
Date: Wed, 17 Apr 2024 14:55:13 +0800
Message-ID: <20240417065513.3409744-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)
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
From: Baokun Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Baokun Li <libaokun1@huawei.com>
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When erofs_kill_sb() is called in block dev based mode, s_bdev may not have
been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled, it will
be mistaken for fscache mode, and then attempt to free an anon_dev that has
never been allocated, triggering the following warning:

============================================
ida_free called for id=0 which is not allocated.
WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
Modules linked in:
CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
RIP: 0010:ida_free+0x134/0x140
Call Trace:
 <TASK>
 erofs_kill_sb+0x81/0x90
 deactivate_locked_super+0x35/0x80
 get_tree_bdev+0x136/0x1e0
 vfs_get_tree+0x2c/0xf0
 do_new_mount+0x190/0x2f0
 [...]
============================================

Instead of allocating the erofs_sb_info in fill_super() allocate it
during erofs_get_tree() and ensure that erofs can always have the info
available during erofs_kill_sb().

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
Changes since v1:
  Allocate and initialise fc->s_fs_info in erofs_fc_get_tree() instead of
  modifying fc->sb_flags.

V1: https://lore.kernel.org/r/20240415121746.1207242-1-libaokun1@huawei.com/

 fs/erofs/super.c | 51 ++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index b21bd8f78dc1..4104280be2ea 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -581,8 +581,7 @@ static const struct export_operations erofs_export_ops = {
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
-	struct erofs_sb_info *sbi;
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	int err;
 
 	sb->s_magic = EROFS_SUPER_MAGIC;
@@ -590,19 +589,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_op = &erofs_sops;
 
-	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
-	if (!sbi)
-		return -ENOMEM;
-
-	sb->s_fs_info = sbi;
-	sbi->opt = ctx->opt;
-	sbi->devs = ctx->devs;
-	ctx->devs = NULL;
-	sbi->fsid = ctx->fsid;
-	ctx->fsid = NULL;
-	sbi->domain_id = ctx->domain_id;
-	ctx->domain_id = NULL;
-
 	sbi->blkszbits = PAGE_SHIFT;
 	if (erofs_is_fscache_mode(sb)) {
 		sb->s_blocksize = PAGE_SIZE;
@@ -704,11 +690,32 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	return 0;
 }
 
-static int erofs_fc_get_tree(struct fs_context *fc)
+static void erofs_ctx_to_info(struct fs_context *fc)
 {
 	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
+
+	sbi->opt = ctx->opt;
+	sbi->devs = ctx->devs;
+	ctx->devs = NULL;
+	sbi->fsid = ctx->fsid;
+	ctx->fsid = NULL;
+	sbi->domain_id = ctx->domain_id;
+	ctx->domain_id = NULL;
+}
 
-	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->fsid)
+static int erofs_fc_get_tree(struct fs_context *fc)
+{
+	struct erofs_sb_info *sbi;
+
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+
+	fc->s_fs_info = sbi;
+	erofs_ctx_to_info(fc);
+
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		return get_tree_nodev(fc, erofs_fc_fill_super);
 
 	return get_tree_bdev(fc, erofs_fc_fill_super);
@@ -767,6 +774,7 @@ static void erofs_fc_free(struct fs_context *fc)
 	kfree(ctx->fsid);
 	kfree(ctx->domain_id);
 	kfree(ctx);
+	kfree(fc->s_fs_info);
 }
 
 static const struct fs_context_operations erofs_context_ops = {
@@ -783,6 +791,7 @@ static int erofs_init_fs_context(struct fs_context *fc)
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
+
 	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
 	if (!ctx->devs) {
 		kfree(ctx);
@@ -799,17 +808,13 @@ static int erofs_init_fs_context(struct fs_context *fc)
 
 static void erofs_kill_sb(struct super_block *sb)
 {
-	struct erofs_sb_info *sbi;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (erofs_is_fscache_mode(sb))
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
 
-	sbi = EROFS_SB(sb);
-	if (!sbi)
-		return;
-
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
-- 
2.31.1

