Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD161E7AE7
	for <lists+linux-erofs@lfdr.de>; Fri, 29 May 2020 12:49:37 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49YLt62ZSdzDqcT
	for <lists+linux-erofs@lfdr.de>; Fri, 29 May 2020 20:49:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=205.139.110.61;
 helo=us-smtp-delivery-1.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=DRV8GJ8Q; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DRV8GJ8Q; 
 dkim-atps=neutral
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49YLsy2B5pzDqR1
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 May 2020 20:49:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590749362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=/HBw05kP+zTfu0Derg7s6AHwyAQG/JEIN+uZVj+wF2U=;
 b=DRV8GJ8QRuEKRYJH1mTch4fZ0sL0TUM4l6poZURWw6/BV4pyykMF3oQgCcjibvAqe0OZRV
 +rdrstyNAy80mZRNg5IGDJMdWaj4zZTo+9pgxWfG0PBtUZD2iDpVXz6mSCFChCyw7QzUhO
 lEJCR3si0kPZWg83WJFhUS40E7o7XZY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590749362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=/HBw05kP+zTfu0Derg7s6AHwyAQG/JEIN+uZVj+wF2U=;
 b=DRV8GJ8QRuEKRYJH1mTch4fZ0sL0TUM4l6poZURWw6/BV4pyykMF3oQgCcjibvAqe0OZRV
 +rdrstyNAy80mZRNg5IGDJMdWaj4zZTo+9pgxWfG0PBtUZD2iDpVXz6mSCFChCyw7QzUhO
 lEJCR3si0kPZWg83WJFhUS40E7o7XZY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-g21qMjEENFqOlifxY57HPA-1; Fri, 29 May 2020 06:49:20 -0400
X-MC-Unique: g21qMjEENFqOlifxY57HPA-1
Received: by mail-pg1-f198.google.com with SMTP id p4so1576384pgf.10
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 May 2020 03:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=/HBw05kP+zTfu0Derg7s6AHwyAQG/JEIN+uZVj+wF2U=;
 b=sjB8GgG3haQ3T9++02LGKXI/SfewZEQFf+T5RrLvVHh2rw7d4cZ9MR54nnqCeWSeJt
 aTublAJ1MU6T1rIR/5BJSMpkCS3WXEVRIFHpLzijxcZl4v63TSK9nNiy9QE+esaYXhZw
 n0bjWk/PM23kNKdoEP1kR6F8/FCLe9KCoYcCeE5/r/Qz+I8bkm59fDXrC7IvgLEKBxAw
 hf0SABvuOlw+urX0KZX3e7S2PEm48oJUoZYR/dd6nHRPKnKYol8V+lYC6gYJPIeRVtRt
 p7Wc9idNT5j02/mEYfB2kyG5qpNSFTG4CBXnTcxz17aYvYJgkako0LgGX1CHmh76ap06
 xyjw==
X-Gm-Message-State: AOAM533mOA5e4y7wuLkxHcZ60ZDPA7zjE1zjEqsCWczrKDOOdkwSHTTm
 QybTwPaPYkjoNG/KDNx5ukBluDmn5krPC9NZ3tbf5OF71o5CZ7Diwg5ektJhxvjDTpZTA+HAs2f
 0YTsUrz2YtuBTqQQPR93D+2sf
X-Received: by 2002:a17:90b:50e:: with SMTP id
 r14mr6787577pjz.13.1590749359361; 
 Fri, 29 May 2020 03:49:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4V4cbR3jQYdd3mVEUqi5jemWVohN9uBQ51kPh5BvmlCrKDYQSIId5NchPw4RXHVDF5Ob6Vw==
X-Received: by 2002:a17:90b:50e:: with SMTP id
 r14mr6787537pjz.13.1590749358917; 
 Fri, 29 May 2020 03:49:18 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 5sm6561631pgl.4.2020.05.29.03.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 03:49:18 -0700 (PDT)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v6] erofs: convert to use the new mount fs_context api
Date: Fri, 29 May 2020 18:48:36 +0800
Message-Id: <20200529104836.17843-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: David Howells <dhowells@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Chao Yu <yuchao0@huawei.com>

Convert the erofs to use new internal mount API as the old one will
be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
changes since v5:
 - rebased on the top of erofs dev branch as Al said [1].

[1] https://lore.kernel.org/r/20200529015111.GA23230@ZenIV.linux.org.uk

 fs/erofs/internal.h |  27 +++--
 fs/erofs/super.c    | 253 ++++++++++++++++++++------------------------
 fs/erofs/xattr.c    |   4 +-
 fs/erofs/zdata.c    |   4 +-
 4 files changed, 132 insertions(+), 156 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 5eead7fdc7a6..1c077b7bb43d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -46,6 +46,17 @@ typedef u64 erofs_off_t;
 /* data type for filesystem-wide blocks number */
 typedef u32 erofs_blk_t;
 
+struct erofs_fs_context {
+#ifdef CONFIG_EROFS_FS_ZIP
+	/* current strategy of how to use managed cache */
+	unsigned char cache_strategy;
+
+	/* threshold for decompression synchronously */
+	unsigned int max_sync_decompress_pages;
+#endif
+	unsigned int mount_opt;
+};
+
 struct erofs_sb_info {
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* list for all registered superblocks, mainly for shrinker */
@@ -55,14 +66,8 @@ struct erofs_sb_info {
 	/* managed XArray arranged in physical block number */
 	struct xarray managed_pslots;
 
-	/* threshold for decompression synchronously */
-	unsigned int max_sync_decompress_pages;
-
 	unsigned int shrinker_run_no;
 
-	/* current strategy of how to use managed cache */
-	unsigned char cache_strategy;
-
 	/* pseudo inode to manage cached pages */
 	struct inode *managed_cache;
 #endif	/* CONFIG_EROFS_FS_ZIP */
@@ -88,7 +93,7 @@ struct erofs_sb_info {
 	u32 feature_compat;
 	u32 feature_incompat;
 
-	unsigned int mount_opt;
+	struct erofs_fs_context ctx;	/* options */
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -98,17 +103,17 @@ struct erofs_sb_info {
 #define EROFS_MOUNT_XATTR_USER		0x00000010
 #define EROFS_MOUNT_POSIX_ACL		0x00000020
 
-#define clear_opt(sbi, option)	((sbi)->mount_opt &= ~EROFS_MOUNT_##option)
-#define set_opt(sbi, option)	((sbi)->mount_opt |= EROFS_MOUNT_##option)
-#define test_opt(sbi, option)	((sbi)->mount_opt & EROFS_MOUNT_##option)
+#define clear_opt(ctx, option)	((ctx)->mount_opt &= ~EROFS_MOUNT_##option)
+#define set_opt(ctx, option)	((ctx)->mount_opt |= EROFS_MOUNT_##option)
+#define test_opt(ctx, option)	((ctx)->mount_opt & EROFS_MOUNT_##option)
 
-#ifdef CONFIG_EROFS_FS_ZIP
 enum {
 	EROFS_ZIP_CACHE_DISABLED,
 	EROFS_ZIP_CACHE_READAHEAD,
 	EROFS_ZIP_CACHE_READAROUND
 };
 
+#ifdef CONFIG_EROFS_FS_ZIP
 #define EROFS_LOCKED_MAGIC     (INT_MIN | 0xE0F510CCL)
 
 /* basic unit of the workstation of a super_block */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 8e46d204a0c2..7a13ffb07c23 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -10,6 +10,8 @@
 #include <linux/parser.h>
 #include <linux/seq_file.h>
 #include <linux/crc32c.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -192,53 +194,18 @@ static int erofs_read_superblock(struct super_block *sb)
 	return ret;
 }
 
-#ifdef CONFIG_EROFS_FS_ZIP
-static int erofs_build_cache_strategy(struct super_block *sb,
-				      substring_t *args)
-{
-	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	const char *cs = match_strdup(args);
-	int err = 0;
-
-	if (!cs) {
-		erofs_err(sb, "Not enough memory to store cache strategy");
-		return -ENOMEM;
-	}
-
-	if (!strcmp(cs, "disabled")) {
-		sbi->cache_strategy = EROFS_ZIP_CACHE_DISABLED;
-	} else if (!strcmp(cs, "readahead")) {
-		sbi->cache_strategy = EROFS_ZIP_CACHE_READAHEAD;
-	} else if (!strcmp(cs, "readaround")) {
-		sbi->cache_strategy = EROFS_ZIP_CACHE_READAROUND;
-	} else {
-		erofs_err(sb, "Unrecognized cache strategy \"%s\"", cs);
-		err = -EINVAL;
-	}
-	kfree(cs);
-	return err;
-}
-#else
-static int erofs_build_cache_strategy(struct super_block *sb,
-				      substring_t *args)
-{
-	erofs_info(sb, "EROFS compression is disabled, so cache strategy is ignored");
-	return 0;
-}
-#endif
-
 /* set up default EROFS parameters */
-static void erofs_default_options(struct erofs_sb_info *sbi)
+static void erofs_default_options(struct erofs_fs_context *ctx)
 {
 #ifdef CONFIG_EROFS_FS_ZIP
-	sbi->cache_strategy = EROFS_ZIP_CACHE_READAROUND;
-	sbi->max_sync_decompress_pages = 3;
+	ctx->cache_strategy = EROFS_ZIP_CACHE_READAROUND;
+	ctx->max_sync_decompress_pages = 3;
 #endif
 #ifdef CONFIG_EROFS_FS_XATTR
-	set_opt(sbi, XATTR_USER);
+	set_opt(ctx, XATTR_USER);
 #endif
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-	set_opt(sbi, POSIX_ACL);
+	set_opt(ctx, POSIX_ACL);
 #endif
 }
 
@@ -251,73 +218,62 @@ enum {
 	Opt_err
 };
 
-static match_table_t erofs_tokens = {
-	{Opt_user_xattr, "user_xattr"},
-	{Opt_nouser_xattr, "nouser_xattr"},
-	{Opt_acl, "acl"},
-	{Opt_noacl, "noacl"},
-	{Opt_cache_strategy, "cache_strategy=%s"},
-	{Opt_err, NULL}
+static const struct constant_table erofs_param_cache_strategy[] = {
+	{"disabled",	EROFS_ZIP_CACHE_DISABLED},
+	{"readahead",	EROFS_ZIP_CACHE_READAHEAD},
+	{"readaround",	EROFS_ZIP_CACHE_READAROUND},
+	{}
 };
 
-static int erofs_parse_options(struct super_block *sb, char *options)
-{
-	substring_t args[MAX_OPT_ARGS];
-	char *p;
-	int err;
-
-	if (!options)
-		return 0;
-
-	while ((p = strsep(&options, ","))) {
-		int token;
+static const struct fs_parameter_spec erofs_fs_parameters[] = {
+	fsparam_flag_no("user_xattr",	Opt_user_xattr),
+	fsparam_flag_no("acl",		Opt_acl),
+	fsparam_enum("cache_strategy",	Opt_cache_strategy,
+		     erofs_param_cache_strategy),
+	{}
+};
 
-		if (!*p)
-			continue;
+static int erofs_fc_parse_param(struct fs_context *fc,
+				struct fs_parameter *param)
+{
+	struct erofs_fs_context *ctx __maybe_unused = fc->fs_private;
+	struct fs_parse_result result;
+	int opt;
 
-		args[0].to = args[0].from = NULL;
-		token = match_token(p, erofs_tokens, args);
+	opt = fs_parse(fc, erofs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
 
-		switch (token) {
+	switch (opt) {
+	case Opt_user_xattr:
 #ifdef CONFIG_EROFS_FS_XATTR
-		case Opt_user_xattr:
-			set_opt(EROFS_SB(sb), XATTR_USER);
-			break;
-		case Opt_nouser_xattr:
-			clear_opt(EROFS_SB(sb), XATTR_USER);
-			break;
+		if (result.boolean)
+			set_opt(ctx, XATTR_USER);
+		else
+			clear_opt(ctx, XATTR_USER);
 #else
-		case Opt_user_xattr:
-			erofs_info(sb, "user_xattr options not supported");
-			break;
-		case Opt_nouser_xattr:
-			erofs_info(sb, "nouser_xattr options not supported");
-			break;
+		errorfc(fc, "{,no}user_xattr options not supported");
 #endif
+		break;
+	case Opt_acl:
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-		case Opt_acl:
-			set_opt(EROFS_SB(sb), POSIX_ACL);
-			break;
-		case Opt_noacl:
-			clear_opt(EROFS_SB(sb), POSIX_ACL);
-			break;
+		if (result.boolean)
+			set_opt(ctx, POSIX_ACL);
+		else
+			clear_opt(ctx, POSIX_ACL);
 #else
-		case Opt_acl:
-			erofs_info(sb, "acl options not supported");
-			break;
-		case Opt_noacl:
-			erofs_info(sb, "noacl options not supported");
-			break;
+		errorfc(fc, "{,no}acl options not supported");
 #endif
-		case Opt_cache_strategy:
-			err = erofs_build_cache_strategy(sb, args);
-			if (err)
-				return err;
-			break;
-		default:
-			erofs_err(sb, "Unrecognized mount option \"%s\" or missing value", p);
-			return -EINVAL;
-		}
+		break;
+	case Opt_cache_strategy:
+#ifdef CONFIG_EROFS_FS_ZIP
+		ctx->cache_strategy = result.uint_32;
+#else
+		errorfc(fc, "compression not supported, cache_strategy ignored");
+#endif
+		break;
+	default:
+		return -ENOPARAM;
 	}
 	return 0;
 }
@@ -381,10 +337,11 @@ static int erofs_init_managed_cache(struct super_block *sb)
 static int erofs_init_managed_cache(struct super_block *sb) { return 0; }
 #endif
 
-static int erofs_fill_super(struct super_block *sb, void *data, int silent)
+static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
 	struct erofs_sb_info *sbi;
+	struct erofs_fs_context *ctx = fc->fs_private;
 	int err;
 
 	sb->s_magic = EROFS_SUPER_MAGIC;
@@ -410,18 +367,13 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_op = &erofs_sops;
 	sb->s_xattr = erofs_xattr_handlers;
 
-	/* set erofs default mount options */
-	erofs_default_options(sbi);
-
-	err = erofs_parse_options(sb, data);
-	if (err)
-		return err;
-
-	if (test_opt(sbi, POSIX_ACL))
+	if (test_opt(ctx, POSIX_ACL))
 		sb->s_flags |= SB_POSIXACL;
 	else
 		sb->s_flags &= ~SB_POSIXACL;
 
+	sbi->ctx = *ctx;
+
 #ifdef CONFIG_EROFS_FS_ZIP
 	xa_init(&sbi->managed_pslots);
 #endif
@@ -448,15 +400,58 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		return err;
 
-	erofs_info(sb, "mounted with opts: %s, root inode @ nid %llu.",
-		   (char *)data, ROOT_NID(sbi));
+	erofs_info(sb, "mounted with root inode @ nid %llu.", ROOT_NID(sbi));
+	return 0;
+}
+
+static int erofs_fc_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, erofs_fc_fill_super);
+}
+
+static int erofs_fc_reconfigure(struct fs_context *fc)
+{
+	struct super_block *sb = fc->root->d_sb;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_fs_context *ctx = fc->fs_private;
+
+	DBG_BUGON(!sb_rdonly(sb));
+
+	if (test_opt(ctx, POSIX_ACL))
+		fc->sb_flags |= SB_POSIXACL;
+	else
+		fc->sb_flags &= ~SB_POSIXACL;
+
+	sbi->ctx = *ctx;
+
+	fc->sb_flags |= SB_RDONLY;
 	return 0;
 }
 
-static struct dentry *erofs_mount(struct file_system_type *fs_type, int flags,
-				  const char *dev_name, void *data)
+static void erofs_fc_free(struct fs_context *fc)
+{
+	kfree(fc->fs_private);
+}
+
+static const struct fs_context_operations erofs_context_ops = {
+	.parse_param	= erofs_fc_parse_param,
+	.get_tree       = erofs_fc_get_tree,
+	.reconfigure    = erofs_fc_reconfigure,
+	.free		= erofs_fc_free,
+};
+
+static int erofs_init_fs_context(struct fs_context *fc)
 {
-	return mount_bdev(fs_type, flags, dev_name, data, erofs_fill_super);
+	fc->fs_private = kzalloc(sizeof(struct erofs_fs_context), GFP_KERNEL);
+	if (!fc->fs_private)
+		return -ENOMEM;
+
+	/* set default mount options */
+	erofs_default_options(fc->fs_private);
+
+	fc->ops = &erofs_context_ops;
+
+	return 0;
 }
 
 /*
@@ -495,7 +490,7 @@ static void erofs_put_super(struct super_block *sb)
 static struct file_system_type erofs_fs_type = {
 	.owner          = THIS_MODULE,
 	.name           = "erofs",
-	.mount          = erofs_mount,
+	.init_fs_context = erofs_init_fs_context,
 	.kill_sb        = erofs_kill_sb,
 	.fs_flags       = FS_REQUIRES_DEV,
 };
@@ -576,61 +571,37 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct erofs_sb_info *sbi __maybe_unused = EROFS_SB(root->d_sb);
+	struct erofs_fs_context *ctx __maybe_unused = &sbi->ctx;
 
 #ifdef CONFIG_EROFS_FS_XATTR
-	if (test_opt(sbi, XATTR_USER))
+	if (test_opt(ctx, XATTR_USER))
 		seq_puts(seq, ",user_xattr");
 	else
 		seq_puts(seq, ",nouser_xattr");
 #endif
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-	if (test_opt(sbi, POSIX_ACL))
+	if (test_opt(ctx, POSIX_ACL))
 		seq_puts(seq, ",acl");
 	else
 		seq_puts(seq, ",noacl");
 #endif
 #ifdef CONFIG_EROFS_FS_ZIP
-	if (sbi->cache_strategy == EROFS_ZIP_CACHE_DISABLED) {
+	if (ctx->cache_strategy == EROFS_ZIP_CACHE_DISABLED)
 		seq_puts(seq, ",cache_strategy=disabled");
-	} else if (sbi->cache_strategy == EROFS_ZIP_CACHE_READAHEAD) {
+	else if (ctx->cache_strategy == EROFS_ZIP_CACHE_READAHEAD)
 		seq_puts(seq, ",cache_strategy=readahead");
-	} else if (sbi->cache_strategy == EROFS_ZIP_CACHE_READAROUND) {
+	else if (ctx->cache_strategy == EROFS_ZIP_CACHE_READAROUND)
 		seq_puts(seq, ",cache_strategy=readaround");
-	}
 #endif
 	return 0;
 }
 
-static int erofs_remount(struct super_block *sb, int *flags, char *data)
-{
-	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	unsigned int org_mnt_opt = sbi->mount_opt;
-	int err;
-
-	DBG_BUGON(!sb_rdonly(sb));
-	err = erofs_parse_options(sb, data);
-	if (err)
-		goto out;
-
-	if (test_opt(sbi, POSIX_ACL))
-		sb->s_flags |= SB_POSIXACL;
-	else
-		sb->s_flags &= ~SB_POSIXACL;
-
-	*flags |= SB_RDONLY;
-	return 0;
-out:
-	sbi->mount_opt = org_mnt_opt;
-	return err;
-}
-
 const struct super_operations erofs_sops = {
 	.put_super = erofs_put_super,
 	.alloc_inode = erofs_alloc_inode,
 	.free_inode = erofs_free_inode,
 	.statfs = erofs_statfs,
 	.show_options = erofs_show_options,
-	.remount_fs = erofs_remount,
 };
 
 module_init(erofs_module_init);
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index b766c3ee5fa8..87e437e7b34f 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -422,7 +422,7 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
 
 static bool erofs_xattr_user_list(struct dentry *dentry)
 {
-	return test_opt(EROFS_SB(dentry->d_sb), XATTR_USER);
+	return test_opt(&EROFS_SB(dentry->d_sb)->ctx, XATTR_USER);
 }
 
 static bool erofs_xattr_trusted_list(struct dentry *dentry)
@@ -469,7 +469,7 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
 
 	switch (handler->flags) {
 	case EROFS_XATTR_INDEX_USER:
-		if (!test_opt(sbi, XATTR_USER))
+		if (!test_opt(&sbi->ctx, XATTR_USER))
 			return -EOPNOTSUPP;
 		break;
 	case EROFS_XATTR_INDEX_TRUSTED:
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index c4b6c9aa87ec..5086b1218aac 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -615,7 +615,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto err_out;
 
 	/* preload all compressed pages (maybe downgrade role if necessary) */
-	if (should_alloc_managed_pages(fe, sbi->cache_strategy, map->m_la))
+	if (should_alloc_managed_pages(fe, sbi->ctx.cache_strategy, map->m_la))
 		cache_strategy = DELAYEDALLOC;
 	else
 		cache_strategy = DONTALLOC;
@@ -1302,7 +1302,7 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 static bool should_decompress_synchronously(struct erofs_sb_info *sbi,
 					    unsigned int nr)
 {
-	return nr <= sbi->max_sync_decompress_pages;
+	return nr <= sbi->ctx.max_sync_decompress_pages;
 }
 
 static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
-- 
2.18.1

