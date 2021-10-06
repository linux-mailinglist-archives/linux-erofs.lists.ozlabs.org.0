Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9208A42475C
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Oct 2021 21:45:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HPlL20lfMz2yp2
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Oct 2021 06:45:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HPlKv5SjDz2yg6
 for <linux-erofs@lists.ozlabs.org>; Thu,  7 Oct 2021 06:45:19 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0Uqm943X_1633549495; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uqm943X_1633549495) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 07 Oct 2021 03:45:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
 Liu Bo <bo.liu@linux.alibaba.com>
Subject: [PATCH v3 1/2] erofs: decouple basic mount options from fs_context
Date: Thu,  7 Oct 2021 03:44:52 +0800
Message-Id: <20211006194453.130447-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Yan Song <imeoer@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Changwei Ge <chge@linux.alibaba.com>, Gao Xiang <hsiangkao@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Previously, EROFS mount options are all in the basic types, so
erofs_fs_context can be directly copied with assignment. However,
when the multiple device feature is introduced, it's hard to handle
multiple device information like the other basic mount options.

There is no need to allocate the whole sb info in advance, instead,
let's separate the basic mount options from fs_context, thus
multiple device information can be handled gracefully then.

No logic changes.

Cc: Liu Bo <bo.liu@linux.alibaba.com>
Cc: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since RFC v2:
 - add a new patch to decouple basic mount options from fs_context
   so that dev_context can be passed safely.

 fs/erofs/inode.c    |  2 +-
 fs/erofs/internal.h | 16 ++++++++-----
 fs/erofs/super.c    | 58 ++++++++++++++++++++++-----------------------
 fs/erofs/xattr.c    |  4 ++--
 fs/erofs/zdata.c    |  8 +++----
 5 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index a552399e211d..2345f1de438e 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -192,7 +192,7 @@ static struct page *erofs_read_inode(struct inode *inode,
 	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec;
 
 	inode->i_flags &= ~S_DAX;
-	if (test_opt(&sbi->ctx, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
+	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
 	    vi->datalayout == EROFS_INODE_FLAT_PLAIN)
 		inode->i_flags |= S_DAX;
 	if (!nblks)
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 9524e155b38f..b1b9d1b5cb66 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -47,7 +47,7 @@ typedef u64 erofs_off_t;
 /* data type for filesystem-wide blocks number */
 typedef u32 erofs_blk_t;
 
-struct erofs_fs_context {
+struct erofs_mount_opts {
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* current strategy of how to use managed cache */
 	unsigned char cache_strategy;
@@ -60,6 +60,10 @@ struct erofs_fs_context {
 	unsigned int mount_opt;
 };
 
+struct erofs_fs_context {
+	struct erofs_mount_opts opt;
+};
+
 /* all filesystem-wide lz4 configurations */
 struct erofs_sb_lz4_info {
 	/* # of pages needed for EROFS lz4 rolling decompression */
@@ -69,6 +73,8 @@ struct erofs_sb_lz4_info {
 };
 
 struct erofs_sb_info {
+	struct erofs_mount_opts opt;	/* options */
+
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* list for all registered superblocks, mainly for shrinker */
 	struct list_head list;
@@ -108,8 +114,6 @@ struct erofs_sb_info {
 	u8 volume_name[16];             /* volume name */
 	u32 feature_compat;
 	u32 feature_incompat;
-
-	struct erofs_fs_context ctx;	/* options */
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -121,9 +125,9 @@ struct erofs_sb_info {
 #define EROFS_MOUNT_DAX_ALWAYS		0x00000040
 #define EROFS_MOUNT_DAX_NEVER		0x00000080
 
-#define clear_opt(ctx, option)	((ctx)->mount_opt &= ~EROFS_MOUNT_##option)
-#define set_opt(ctx, option)	((ctx)->mount_opt |= EROFS_MOUNT_##option)
-#define test_opt(ctx, option)	((ctx)->mount_opt & EROFS_MOUNT_##option)
+#define clear_opt(opt, option)	((opt)->mount_opt &= ~EROFS_MOUNT_##option)
+#define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
+#define test_opt(opt, option)	((opt)->mount_opt & EROFS_MOUNT_##option)
 
 enum {
 	EROFS_ZIP_CACHE_DISABLED,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 11b88559f8bf..25f6b8b37f28 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -340,15 +340,15 @@ static int erofs_read_superblock(struct super_block *sb)
 static void erofs_default_options(struct erofs_fs_context *ctx)
 {
 #ifdef CONFIG_EROFS_FS_ZIP
-	ctx->cache_strategy = EROFS_ZIP_CACHE_READAROUND;
-	ctx->max_sync_decompress_pages = 3;
-	ctx->readahead_sync_decompress = false;
+	ctx->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
+	ctx->opt.max_sync_decompress_pages = 3;
+	ctx->opt.readahead_sync_decompress = false;
 #endif
 #ifdef CONFIG_EROFS_FS_XATTR
-	set_opt(ctx, XATTR_USER);
+	set_opt(&ctx->opt, XATTR_USER);
 #endif
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-	set_opt(ctx, POSIX_ACL);
+	set_opt(&ctx->opt, POSIX_ACL);
 #endif
 }
 
@@ -392,12 +392,12 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 	switch (mode) {
 	case EROFS_MOUNT_DAX_ALWAYS:
 		warnfc(fc, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
-		set_opt(ctx, DAX_ALWAYS);
-		clear_opt(ctx, DAX_NEVER);
+		set_opt(&ctx->opt, DAX_ALWAYS);
+		clear_opt(&ctx->opt, DAX_NEVER);
 		return true;
 	case EROFS_MOUNT_DAX_NEVER:
-		set_opt(ctx, DAX_NEVER);
-		clear_opt(ctx, DAX_ALWAYS);
+		set_opt(&ctx->opt, DAX_NEVER);
+		clear_opt(&ctx->opt, DAX_ALWAYS);
 		return true;
 	default:
 		DBG_BUGON(1);
@@ -424,9 +424,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	case Opt_user_xattr:
 #ifdef CONFIG_EROFS_FS_XATTR
 		if (result.boolean)
-			set_opt(ctx, XATTR_USER);
+			set_opt(&ctx->opt, XATTR_USER);
 		else
-			clear_opt(ctx, XATTR_USER);
+			clear_opt(&ctx->opt, XATTR_USER);
 #else
 		errorfc(fc, "{,no}user_xattr options not supported");
 #endif
@@ -434,16 +434,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 	case Opt_acl:
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
 		if (result.boolean)
-			set_opt(ctx, POSIX_ACL);
+			set_opt(&ctx->opt, POSIX_ACL);
 		else
-			clear_opt(ctx, POSIX_ACL);
+			clear_opt(&ctx->opt, POSIX_ACL);
 #else
 		errorfc(fc, "{,no}acl options not supported");
 #endif
 		break;
 	case Opt_cache_strategy:
 #ifdef CONFIG_EROFS_FS_ZIP
-		ctx->cache_strategy = result.uint_32;
+		ctx->opt.cache_strategy = result.uint_32;
 #else
 		errorfc(fc, "compression not supported, cache_strategy ignored");
 #endif
@@ -540,15 +540,16 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		return -ENOMEM;
 
 	sb->s_fs_info = sbi;
+	sbi->opt = ctx->opt;
 	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
 	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
 
-	if (test_opt(ctx, DAX_ALWAYS) &&
+	if (test_opt(&sbi->opt, DAX_ALWAYS) &&
 	    !dax_supported(sbi->dax_dev, sb->s_bdev, EROFS_BLKSIZ, 0, bdev_nr_sectors(sb->s_bdev))) {
 		errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
-		clear_opt(ctx, DAX_ALWAYS);
+		clear_opt(&sbi->opt, DAX_ALWAYS);
 	}
 	sb->s_flags |= SB_RDONLY | SB_NOATIME;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
@@ -557,13 +558,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &erofs_sops;
 	sb->s_xattr = erofs_xattr_handlers;
 
-	if (test_opt(ctx, POSIX_ACL))
+	if (test_opt(&sbi->opt, POSIX_ACL))
 		sb->s_flags |= SB_POSIXACL;
 	else
 		sb->s_flags &= ~SB_POSIXACL;
 
-	sbi->ctx = *ctx;
-
 #ifdef CONFIG_EROFS_FS_ZIP
 	xa_init(&sbi->managed_pslots);
 #endif
@@ -607,12 +606,12 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
 
 	DBG_BUGON(!sb_rdonly(sb));
 
-	if (test_opt(ctx, POSIX_ACL))
+	if (test_opt(&ctx->opt, POSIX_ACL))
 		fc->sb_flags |= SB_POSIXACL;
 	else
 		fc->sb_flags &= ~SB_POSIXACL;
 
-	sbi->ctx = *ctx;
+	sbi->opt = ctx->opt;
 
 	fc->sb_flags |= SB_RDONLY;
 	return 0;
@@ -640,7 +639,6 @@ static int erofs_init_fs_context(struct fs_context *fc)
 	erofs_default_options(fc->fs_private);
 
 	fc->ops = &erofs_context_ops;
-
 	return 0;
 }
 
@@ -763,31 +761,31 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(root->d_sb);
-	struct erofs_fs_context *ctx = &sbi->ctx;
+	struct erofs_mount_opts *opt = &sbi->opt;
 
 #ifdef CONFIG_EROFS_FS_XATTR
-	if (test_opt(ctx, XATTR_USER))
+	if (test_opt(opt, XATTR_USER))
 		seq_puts(seq, ",user_xattr");
 	else
 		seq_puts(seq, ",nouser_xattr");
 #endif
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-	if (test_opt(ctx, POSIX_ACL))
+	if (test_opt(opt, POSIX_ACL))
 		seq_puts(seq, ",acl");
 	else
 		seq_puts(seq, ",noacl");
 #endif
 #ifdef CONFIG_EROFS_FS_ZIP
-	if (ctx->cache_strategy == EROFS_ZIP_CACHE_DISABLED)
+	if (opt->cache_strategy == EROFS_ZIP_CACHE_DISABLED)
 		seq_puts(seq, ",cache_strategy=disabled");
-	else if (ctx->cache_strategy == EROFS_ZIP_CACHE_READAHEAD)
+	else if (opt->cache_strategy == EROFS_ZIP_CACHE_READAHEAD)
 		seq_puts(seq, ",cache_strategy=readahead");
-	else if (ctx->cache_strategy == EROFS_ZIP_CACHE_READAROUND)
+	else if (opt->cache_strategy == EROFS_ZIP_CACHE_READAROUND)
 		seq_puts(seq, ",cache_strategy=readaround");
 #endif
-	if (test_opt(ctx, DAX_ALWAYS))
+	if (test_opt(opt, DAX_ALWAYS))
 		seq_puts(seq, ",dax=always");
-	if (test_opt(ctx, DAX_NEVER))
+	if (test_opt(opt, DAX_NEVER))
 		seq_puts(seq, ",dax=never");
 	return 0;
 }
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 778f2c52295d..01c581e93c5f 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -429,7 +429,7 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
 
 static bool erofs_xattr_user_list(struct dentry *dentry)
 {
-	return test_opt(&EROFS_SB(dentry->d_sb)->ctx, XATTR_USER);
+	return test_opt(&EROFS_SB(dentry->d_sb)->opt, XATTR_USER);
 }
 
 static bool erofs_xattr_trusted_list(struct dentry *dentry)
@@ -476,7 +476,7 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
 
 	switch (handler->flags) {
 	case EROFS_XATTR_INDEX_USER:
-		if (!test_opt(&sbi->ctx, XATTR_USER))
+		if (!test_opt(&sbi->opt, XATTR_USER))
 			return -EOPNOTSUPP;
 		break;
 	case EROFS_XATTR_INDEX_TRUSTED:
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 11c7a1aaebad..e59e22852c78 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -695,7 +695,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto err_out;
 
 	/* preload all compressed pages (maybe downgrade role if necessary) */
-	if (should_alloc_managed_pages(fe, sbi->ctx.cache_strategy, map->m_la))
+	if (should_alloc_managed_pages(fe, sbi->opt.cache_strategy, map->m_la))
 		cache_strategy = TRYALLOC;
 	else
 		cache_strategy = DONTALLOC;
@@ -796,7 +796,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 	/* Use workqueue and sync decompression for atomic contexts only */
 	if (in_atomic() || irqs_disabled()) {
 		queue_work(z_erofs_workqueue, &io->u.work);
-		sbi->ctx.readahead_sync_decompress = true;
+		sbi->opt.readahead_sync_decompress = true;
 		return;
 	}
 	z_erofs_decompressqueue_work(&io->u.work);
@@ -1411,8 +1411,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 
 	unsigned int nr_pages = readahead_count(rac);
-	bool sync = (sbi->ctx.readahead_sync_decompress &&
-			nr_pages <= sbi->ctx.max_sync_decompress_pages);
+	bool sync = (sbi->opt.readahead_sync_decompress &&
+			nr_pages <= sbi->opt.max_sync_decompress_pages);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *page, *head = NULL;
 	LIST_HEAD(pagepool);
-- 
2.24.4

