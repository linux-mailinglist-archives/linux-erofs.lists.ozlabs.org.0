Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1648AAE9F
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Apr 2024 14:36:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1713530215;
	bh=sdrIux7B4tJEulhSiW1cOF2vi+90sgpherPTahpb9RQ=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=NH0X8b18WYuESRkkgrD6VGj0YyqVo69AdTh9mnQlzmAZh8ZRDakm5M7trCV/Yk3ik
	 NmZkFeaU7Vn+sjzms4OfVuCQKue1WspEFDL63V7Q115BtcgsJDJ/kXPGLXLkeC+6+j
	 bAyj7gKWJRfdF8gy++FVB1YMxzXmnsO79a6UL4SFgylxjRAxx5MbYItsKVBKpX/wpK
	 RSAmHGP928lD+9xuUjE3nqLmmDkITtwgyY5yJSMi7Y64+5Gr59r5KlHJeLdBAiTOMr
	 9TIca3nYa/mrfEV0t0Kty2o0u3NCXrX3VdKp4EVbeO754CIWZElLaiumeRZhqf87XK
	 RQyKp+ri6Mj7A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VLZ074M5Mz3dGn
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Apr 2024 22:36:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=libaokun1@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VLYzN1YJbz3cgf
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Apr 2024 22:36:14 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VLYvJ1BK4zdb0H;
	Fri, 19 Apr 2024 20:32:44 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B03118007D;
	Fri, 19 Apr 2024 20:35:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Apr
 2024 20:35:38 +0800
To: <linux-erofs@lists.ozlabs.org>
Subject: [PATCH -next v3 1/2] erofs: get rid of erofs_fs_context
Date: Fri, 19 Apr 2024 20:36:10 +0800
Message-ID: <20240419123611.947084-2-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240419123611.947084-1-libaokun1@huawei.com>
References: <20240419123611.947084-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Instead of allocating the erofs_sb_info in fill_super() allocate it during
erofs_init_fs_context() and ensure that erofs can always have the info
available during erofs_kill_sb(). After this erofs_fs_context is no longer
needed, replace ctx with sbi, no functional changes.

Suggested-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/erofs/internal.h |   7 ---
 fs/erofs/super.c    | 116 ++++++++++++++++++++------------------------
 2 files changed, 53 insertions(+), 70 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 39c67119f43b..d28ccfc0352b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -84,13 +84,6 @@ struct erofs_dev_context {
 	bool flatdev;
 };
 
-struct erofs_fs_context {
-	struct erofs_mount_opts opt;
-	struct erofs_dev_context *devs;
-	char *fsid;
-	char *domain_id;
-};
-
 /* all filesystem-wide lz4 configurations */
 struct erofs_sb_lz4_info {
 	/* # of pages needed for EROFS lz4 rolling decompression */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index c0eb139adb07..21faa49bc970 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -370,18 +370,18 @@ static int erofs_read_superblock(struct super_block *sb)
 	return ret;
 }
 
-static void erofs_default_options(struct erofs_fs_context *ctx)
+static void erofs_default_options(struct erofs_sb_info *sbi)
 {
 #ifdef CONFIG_EROFS_FS_ZIP
-	ctx->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
-	ctx->opt.max_sync_decompress_pages = 3;
-	ctx->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_AUTO;
+	sbi->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
+	sbi->opt.max_sync_decompress_pages = 3;
+	sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_AUTO;
 #endif
 #ifdef CONFIG_EROFS_FS_XATTR
-	set_opt(&ctx->opt, XATTR_USER);
+	set_opt(&sbi->opt, XATTR_USER);
 #endif
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-	set_opt(&ctx->opt, POSIX_ACL);
+	set_opt(&sbi->opt, POSIX_ACL);
 #endif
 }
 
@@ -426,16 +426,16 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 {
 #ifdef CONFIG_FS_DAX
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
 
 	switch (mode) {
 	case EROFS_MOUNT_DAX_ALWAYS:
-		set_opt(&ctx->opt, DAX_ALWAYS);
-		clear_opt(&ctx->opt, DAX_NEVER);
+		set_opt(&sbi->opt, DAX_ALWAYS);
+		clear_opt(&sbi->opt, DAX_NEVER);
 		return true;
 	case EROFS_MOUNT_DAX_NEVER:
-		set_opt(&ctx->opt, DAX_NEVER);
-		clear_opt(&ctx->opt, DAX_ALWAYS);
+		set_opt(&sbi->opt, DAX_NEVER);
+		clear_opt(&sbi->opt, DAX_ALWAYS);
 		return true;
 	default:
 		DBG_BUGON(1);
@@ -450,7 +450,7 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 static int erofs_fc_parse_param(struct fs_context *fc,
 				struct fs_parameter *param)
 {
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
 	struct fs_parse_result result;
 	struct erofs_device_info *dif;
 	int opt, ret;
@@ -463,9 +463,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	case Opt_user_xattr:
 #ifdef CONFIG_EROFS_FS_XATTR
 		if (result.boolean)
-			set_opt(&ctx->opt, XATTR_USER);
+			set_opt(&sbi->opt, XATTR_USER);
 		else
-			clear_opt(&ctx->opt, XATTR_USER);
+			clear_opt(&sbi->opt, XATTR_USER);
 #else
 		errorfc(fc, "{,no}user_xattr options not supported");
 #endif
@@ -473,16 +473,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	case Opt_acl:
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
 		if (result.boolean)
-			set_opt(&ctx->opt, POSIX_ACL);
+			set_opt(&sbi->opt, POSIX_ACL);
 		else
-			clear_opt(&ctx->opt, POSIX_ACL);
+			clear_opt(&sbi->opt, POSIX_ACL);
 #else
 		errorfc(fc, "{,no}acl options not supported");
 #endif
 		break;
 	case Opt_cache_strategy:
 #ifdef CONFIG_EROFS_FS_ZIP
-		ctx->opt.cache_strategy = result.uint_32;
+		sbi->opt.cache_strategy = result.uint_32;
 #else
 		errorfc(fc, "compression not supported, cache_strategy ignored");
 #endif
@@ -504,27 +504,27 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 			kfree(dif);
 			return -ENOMEM;
 		}
-		down_write(&ctx->devs->rwsem);
-		ret = idr_alloc(&ctx->devs->tree, dif, 0, 0, GFP_KERNEL);
-		up_write(&ctx->devs->rwsem);
+		down_write(&sbi->devs->rwsem);
+		ret = idr_alloc(&sbi->devs->tree, dif, 0, 0, GFP_KERNEL);
+		up_write(&sbi->devs->rwsem);
 		if (ret < 0) {
 			kfree(dif->path);
 			kfree(dif);
 			return ret;
 		}
-		++ctx->devs->extra_devices;
+		++sbi->devs->extra_devices;
 		break;
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	case Opt_fsid:
-		kfree(ctx->fsid);
-		ctx->fsid = kstrdup(param->string, GFP_KERNEL);
-		if (!ctx->fsid)
+		kfree(sbi->fsid);
+		sbi->fsid = kstrdup(param->string, GFP_KERNEL);
+		if (!sbi->fsid)
 			return -ENOMEM;
 		break;
 	case Opt_domain_id:
-		kfree(ctx->domain_id);
-		ctx->domain_id = kstrdup(param->string, GFP_KERNEL);
-		if (!ctx->domain_id)
+		kfree(sbi->domain_id);
+		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
+		if (!sbi->domain_id)
 			return -ENOMEM;
 		break;
 #else
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
@@ -706,9 +692,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
 
-	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->fsid)
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		return get_tree_nodev(fc, erofs_fc_fill_super);
 
 	return get_tree_bdev(fc, erofs_fc_fill_super);
@@ -718,19 +704,19 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *new_sbi = fc->s_fs_info;
 
 	DBG_BUGON(!sb_rdonly(sb));
 
-	if (ctx->fsid || ctx->domain_id)
+	if (new_sbi->fsid || new_sbi->domain_id)
 		erofs_info(sb, "ignoring reconfiguration for fsid|domain_id.");
 
-	if (test_opt(&ctx->opt, POSIX_ACL))
+	if (test_opt(&new_sbi->opt, POSIX_ACL))
 		fc->sb_flags |= SB_POSIXACL;
 	else
 		fc->sb_flags &= ~SB_POSIXACL;
 
-	sbi->opt = ctx->opt;
+	sbi->opt = new_sbi->opt;
 
 	fc->sb_flags |= SB_RDONLY;
 	return 0;
@@ -761,12 +747,15 @@ static void erofs_free_dev_context(struct erofs_dev_context *devs)
 
 static void erofs_fc_free(struct fs_context *fc)
 {
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
+
+	if (!sbi)
+		return;
 
-	erofs_free_dev_context(ctx->devs);
-	kfree(ctx->fsid);
-	kfree(ctx->domain_id);
-	kfree(ctx);
+	erofs_free_dev_context(sbi->devs);
+	kfree(sbi->fsid);
+	kfree(sbi->domain_id);
+	kfree(sbi);
 }
 
 static const struct fs_context_operations erofs_context_ops = {
@@ -778,21 +767,22 @@ static const struct fs_context_operations erofs_context_ops = {
 
 static int erofs_init_fs_context(struct fs_context *fc)
 {
-	struct erofs_fs_context *ctx;
+	struct erofs_sb_info *sbi;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
+	if (!sbi)
 		return -ENOMEM;
-	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
-	if (!ctx->devs) {
-		kfree(ctx);
+
+	sbi->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
+	if (!sbi->devs) {
+		kfree(sbi);
 		return -ENOMEM;
 	}
-	fc->fs_private = ctx;
+	fc->s_fs_info = sbi;
 
-	idr_init(&ctx->devs->tree);
-	init_rwsem(&ctx->devs->rwsem);
-	erofs_default_options(ctx);
+	idr_init(&sbi->devs->tree);
+	init_rwsem(&sbi->devs->rwsem);
+	erofs_default_options(sbi);
 	fc->ops = &erofs_context_ops;
 	return 0;
 }
-- 
2.31.1

