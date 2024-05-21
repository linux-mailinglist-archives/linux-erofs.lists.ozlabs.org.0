Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id AC1DF8CA838
	for <lists+linux-erofs@lfdr.de>; Tue, 21 May 2024 08:56:43 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gSbmZ02n;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vk4pJ73PWz3fyS
	for <lists+linux-erofs@lfdr.de>; Tue, 21 May 2024 16:51:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gSbmZ02n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vk4p044pvz3frB
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 May 2024 16:50:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716274241; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bcLcSpygRskX8FbZ85z5VIkgvrvkWEO0qut+0yi1ja8=;
	b=gSbmZ02nB4KbS1EYEATkWZ9YyN/hn7CeMwKq70K5LnFaukukIJ+Qekip6FFQipUrCrTm8Vgw5AlokiHtZ6PYZVIBOlxExUtF39ikeResaM+2KMAiNdnHMPVQWsbaMN8rQ751ryz15MndsQOPkrWkRp/R5LAOgLJTwtQO/XtTdw0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W6wiTe1_1716274234;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6wiTe1_1716274234)
          by smtp.aliyun-inc.com;
          Tue, 21 May 2024 14:50:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.8.y 1/2] erofs: get rid of erofs_fs_context
Date: Tue, 21 May 2024 14:50:31 +0800
Message-Id: <20240521065032.4192363-1-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Baokun Li <libaokun1@huawei.com>

commit 07abe43a28b2c660f726d66f5470f7f114f9643a upstream.

Instead of allocating the erofs_sb_info in fill_super() allocate it during
erofs_init_fs_context() and ensure that erofs can always have the info
available during erofs_kill_sb(). After this erofs_fs_context is no longer
needed, replace ctx with sbi, no functional changes.

Suggested-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20240419123611.947084-2-libaokun1@huawei.com
[ Gao Xiang: trivial conflict due to a warning message. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h |   7 ---
 fs/erofs/super.c    | 116 ++++++++++++++++++++------------------------
 2 files changed, 53 insertions(+), 70 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 410f5af62354..c69174675caf 100644
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
index 24788c230b49..8d7a3abb9c1b 100644
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
 
@@ -426,17 +426,17 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 {
 #ifdef CONFIG_FS_DAX
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
 
 	switch (mode) {
 	case EROFS_MOUNT_DAX_ALWAYS:
 		warnfc(fc, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
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
@@ -451,7 +451,7 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 static int erofs_fc_parse_param(struct fs_context *fc,
 				struct fs_parameter *param)
 {
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
 	struct fs_parse_result result;
 	struct erofs_device_info *dif;
 	int opt, ret;
@@ -464,9 +464,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
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
@@ -474,16 +474,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
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
@@ -505,27 +505,27 @@ static int erofs_fc_parse_param(struct fs_context *fc,
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
@@ -582,8 +582,7 @@ static const struct export_operations erofs_export_ops = {
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
-	struct erofs_sb_info *sbi;
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	int err;
 
 	sb->s_magic = EROFS_SUPER_MAGIC;
@@ -591,19 +590,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -707,9 +693,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
-	struct erofs_fs_context *ctx = fc->fs_private;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
 
-	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->fsid)
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		return get_tree_nodev(fc, erofs_fc_fill_super);
 
 	return get_tree_bdev(fc, erofs_fc_fill_super);
@@ -719,19 +705,19 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
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
@@ -762,12 +748,15 @@ static void erofs_free_dev_context(struct erofs_dev_context *devs)
 
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
@@ -779,21 +768,22 @@ static const struct fs_context_operations erofs_context_ops = {
 
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
2.39.3

