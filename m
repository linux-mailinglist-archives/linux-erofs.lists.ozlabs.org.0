Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967A890C3FD
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 08:49:54 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XzOW22uz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3HRw0BRsz30Th
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 16:49:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XzOW22uz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W3HRG50YMz3bZ3
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2024 16:49:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718693349; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hkQ1Gf8zwg0b9ZhQiF1JzG0Eva+zHFqpuXwcPVuw+/c=;
	b=XzOW22uzjcZDZJY2lBJlQJKoHNbfzyqrExS70CieKpT/eyokjy695N2n1rF9MsndGUY1eOLPbND4hQbH4IsUL/azDdZzAar6wu8ybVbqX6lNLcmFSfpblFxrHRXPxC9tjFIbFKTBo1Hc3Oj7AhF+wsz4rEpgOwDUMKtD2lX8Mro=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8jEqzp_1718693347;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8jEqzp_1718693347)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 14:49:08 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/9] erofs-utils: introduce incremental builds
Date: Tue, 18 Jun 2024 14:48:54 +0800
Message-Id: <20240618064859.4117858-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240618064859.4117858-1-hsiangkao@linux.alibaba.com>
References: <20240618064859.4117858-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This introduces incremental build support for mkfs, where new on-disk
(meta)data will be appended in a log-structured manner, except for the
root inode (due to current on-disk limitations), as illustrated below:

 ___________________________________________
| base | delta 0 | delta 1 | .. | delta n-1 |
|______|_________|_________|____|___________|
                                   ---> image/data growth direction

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/inode.h    |  1 +
 include/erofs/internal.h |  6 +--
 lib/inode.c              | 72 +++++++++++++++++++++++++++-----
 lib/rebuild.c            | 89 ++++++++++++++++++++++++++++++++++------
 4 files changed, 143 insertions(+), 25 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 0fc9b80..2af8e6c 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -34,6 +34,7 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
 int erofs_iflush(struct erofs_inode *inode);
 struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 				   const char *name);
+bool erofs_dentry_is_wht(struct erofs_sb_info *sbi, struct erofs_dentry *d);
 int erofs_rebuild_dump_tree(struct erofs_inode *dir, bool incremental);
 int erofs_init_empty_dir(struct erofs_inode *dir);
 int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index f8a01ce..39cf066 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -303,13 +303,13 @@ static inline struct erofs_inode *erofs_parent_inode(struct erofs_inode *inode)
 
 struct erofs_dentry {
 	struct list_head d_child;	/* child of parent list */
-
-	unsigned int type;
-	char name[EROFS_NAME_LEN];
 	union {
 		struct erofs_inode *inode;
 		erofs_nid_t nid;
 	};
+	char name[EROFS_NAME_LEN];
+	u8 type;
+	bool validnid;
 };
 
 static inline bool is_dot_dotdot_len(const char *name, unsigned int len)
diff --git a/lib/inode.c b/lib/inode.c
index a4f61ab..4fdb689 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -330,7 +330,10 @@ static void erofs_d_invalidate(struct erofs_dentry *d)
 {
 	struct erofs_inode *const inode = d->inode;
 
+	if (d->validnid)
+		return;
 	d->nid = erofs_lookupnid(inode);
+	d->validnid = true;
 	erofs_iput(inode);
 }
 
@@ -666,6 +669,9 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 	if (inode->extent_isize)
 		inodesize = roundup(inodesize, 8) + inode->extent_isize;
 
+	if (inode->datalayout == EROFS_INODE_FLAT_PLAIN)
+		goto noinline;
+
 	/* TODO: tailpacking inline of chunk-based format isn't finalized */
 	if (inode->datalayout == EROFS_INODE_CHUNK_BASED)
 		goto noinline;
@@ -761,6 +767,7 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 	if (!inode->idata_size)
 		goto out;
 
+	DBG_BUGON(!inode->idata);
 	/* have enough room to inline data */
 	if (inode->bh_inline) {
 		ibh = inode->bh_inline;
@@ -1378,23 +1385,49 @@ err_closedir:
 	return ret;
 }
 
-static int erofs_rebuild_handle_directory(struct erofs_inode *dir)
+int erofs_rebuild_load_basedir(struct erofs_inode *dir);
+
+bool erofs_dentry_is_wht(struct erofs_sb_info *sbi, struct erofs_dentry *d)
 {
+	if (!d->validnid)
+		return erofs_inode_is_whiteout(d->inode);
+	if (d->type == EROFS_FT_CHRDEV) {
+		struct erofs_inode ei = { .sbi = sbi, .nid = d->nid };
+		int ret;
+
+		ret = erofs_read_inode_from_disk(&ei);
+		if (ret) {
+			erofs_err("failed to check DT_WHT: %s",
+				  erofs_strerror(ret));
+			DBG_BUGON(1);
+			return false;
+		}
+		return erofs_inode_is_whiteout(&ei);
+	}
+	return false;
+}
+
+static int erofs_rebuild_handle_directory(struct erofs_inode *dir,
+					  bool incremental)
+{
+	struct erofs_sb_info *sbi = dir->sbi;
 	struct erofs_dentry *d, *n;
 	unsigned int nr_subdirs, i_nlink;
+	bool delwht = cfg.c_ovlfs_strip && dir->whiteouts;
 	int ret;
 
 	nr_subdirs = 0;
 	i_nlink = 0;
+
 	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
-		if (cfg.c_ovlfs_strip && erofs_inode_is_whiteout(d->inode)) {
+		if (delwht && erofs_dentry_is_wht(sbi, d)) {
 			erofs_dbg("remove whiteout %s", d->inode->i_srcpath);
 			list_del(&d->d_child);
 			erofs_d_invalidate(d);
 			free(d);
 			continue;
 		}
-		i_nlink += S_ISDIR(d->inode->i_mode);
+		i_nlink += (d->type == EROFS_FT_DIR);
 		++nr_subdirs;
 	}
 
@@ -1404,6 +1437,9 @@ static int erofs_rebuild_handle_directory(struct erofs_inode *dir)
 	if (ret)
 		return ret;
 
+	if (IS_ROOT(dir) && incremental)
+		dir->datalayout = EROFS_INODE_FLAT_PLAIN;
+
 	/*
 	 * if there're too many subdirs as compact form, set nlink=1
 	 * rather than upgrade to use extented form instead.
@@ -1414,7 +1450,7 @@ static int erofs_rebuild_handle_directory(struct erofs_inode *dir)
 	else
 		dir->i_nlink = i_nlink;
 
-	return erofs_mkfs_go(dir->sbi, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
+	return erofs_mkfs_go(sbi, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
 }
 
 static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
@@ -1461,7 +1497,8 @@ static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
 	return ret;
 }
 
-static int erofs_rebuild_handle_inode(struct erofs_inode *inode)
+static int erofs_rebuild_handle_inode(struct erofs_inode *inode,
+				      bool incremental)
 {
 	char *trimmed;
 	int ret;
@@ -1482,6 +1519,13 @@ static int erofs_rebuild_handle_inode(struct erofs_inode *inode)
 		inode->inode_isize = sizeof(struct erofs_inode_compact);
 	}
 
+	if (incremental && S_ISDIR(inode->i_mode) &&
+	    inode->dev == inode->sbi->dev && !inode->opaque) {
+		ret = erofs_rebuild_load_basedir(inode);
+		if (ret)
+			return ret;
+	}
+
 	/* strip all unnecessary overlayfs xattrs when ovlfs_strip is enabled */
 	if (cfg.c_ovlfs_strip)
 		erofs_clear_opaque_xattr(inode);
@@ -1513,7 +1557,7 @@ static int erofs_rebuild_handle_inode(struct erofs_inode *inode)
 		ret = erofs_mkfs_go(inode->sbi, EROFS_MKFS_JOB_NDIR,
 				    &ctx, sizeof(ctx));
 	} else {
-		ret = erofs_rebuild_handle_directory(inode);
+		ret = erofs_rebuild_handle_directory(inode, incremental);
 	}
 	erofs_info("file %s dumped (mode %05o)", erofs_fspath(inode->i_srcpath),
 		   inode->i_mode);
@@ -1540,9 +1584,16 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
 
 	erofs_mark_parent_inode(root, root);	/* rootdir mark */
 	root->next_dirwrite = NULL;
+	/* update dev/i_ino[1] to keep track of the base image */
+	if (incremental) {
+		root->dev = root->sbi->dev;
+		root->i_ino[1] = sbi->root_nid;
+		list_del(&root->i_hash);
+		erofs_insert_ihash(root);
+	}
 
 	err = !rebuild ? erofs_mkfs_handle_inode(root) :
-			erofs_rebuild_handle_inode(root);
+			erofs_rebuild_handle_inode(root, incremental);
 	if (err)
 		return err;
 
@@ -1564,7 +1615,7 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
 		list_for_each_entry(d, &dir->i_subdirs, d_child) {
 			struct erofs_inode *inode = d->inode;
 
-			if (is_dot_dotdot(d->name))
+			if (is_dot_dotdot(d->name) || d->validnid)
 				continue;
 
 			if (!erofs_inode_visited(inode)) {
@@ -1575,7 +1626,8 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
 				if (!rebuild)
 					err = erofs_mkfs_handle_inode(inode);
 				else
-					err = erofs_rebuild_handle_inode(inode);
+					err = erofs_rebuild_handle_inode(inode,
+								incremental);
 				if (err)
 					break;
 				if (S_ISDIR(inode->i_mode)) {
@@ -1773,7 +1825,7 @@ int erofs_fixup_root_inode(struct erofs_inode *root)
 	char *ibuf;
 	int err;
 
-	if (sbi->root_nid == root->nid)
+	if (sbi->root_nid == root->nid)		/* for most mkfs cases */
 		return 0;
 
 	if (root->nid <= 0xffff) {
diff --git a/lib/rebuild.c b/lib/rebuild.c
index b9bced2..6f2e301 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -235,18 +235,18 @@ static int erofs_rebuild_fill_inode(struct erofs_inode *inode)
 }
 
 /*
- * @parent:  parent directory in inode tree
- * @ctx.dir: parent directory when itering erofs_iterate_dir()
+ * @mergedir: parent directory in the merged tree
+ * @ctx.dir:  parent directory when itering erofs_iterate_dir()
  */
 struct erofs_rebuild_dir_context {
 	struct erofs_dir_context ctx;
-	struct erofs_inode *parent;
+	struct erofs_inode *mergedir;
 };
 
 static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 {
 	struct erofs_rebuild_dir_context *rctx = (void *)ctx;
-	struct erofs_inode *parent = rctx->parent;
+	struct erofs_inode *mergedir = rctx->mergedir;
 	struct erofs_inode *dir = ctx->dir;
 	struct erofs_inode *inode, *candidate;
 	struct erofs_inode src;
@@ -258,15 +258,15 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 	if (ctx->dot_dotdot)
 		return 0;
 
-	ret = asprintf(&path, "%s/%.*s", rctx->parent->i_srcpath,
+	ret = asprintf(&path, "%s/%.*s", rctx->mergedir->i_srcpath,
 		       ctx->de_namelen, ctx->dname);
 	if (ret < 0)
 		return ret;
 
 	erofs_dbg("parsing %s", path);
-	dname = path + strlen(parent->i_srcpath) + 1;
+	dname = path + strlen(mergedir->i_srcpath) + 1;
 
-	d = erofs_rebuild_get_dentry(parent, dname, false,
+	d = erofs_rebuild_get_dentry(mergedir, dname, false,
 				     &dumb, &dumb, false);
 	if (IS_ERR(d)) {
 		ret = PTR_ERR(d);
@@ -290,12 +290,12 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 		ret = erofs_read_inode_from_disk(&src);
 		if (ret || !S_ISDIR(src.i_mode))
 			goto out;
-		parent = d->inode;
+		mergedir = d->inode;
 		inode = dir = &src;
 	} else {
 		u64 nid;
 
-		DBG_BUGON(parent != d->inode);
+		DBG_BUGON(mergedir != d->inode);
 		inode = erofs_new_inode(dir->sbi);
 		if (IS_ERR(inode)) {
 			ret = PTR_ERR(inode);
@@ -347,7 +347,7 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 			}
 
 			erofs_insert_ihash(inode);
-			parent = dir = inode;
+			mergedir = dir = inode;
 		}
 
 		d->inode = inode;
@@ -357,7 +357,7 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 	if (S_ISDIR(inode->i_mode)) {
 		struct erofs_rebuild_dir_context nctx = *rctx;
 
-		nctx.parent = parent;
+		nctx.mergedir = mergedir;
 		nctx.ctx.dir = dir;
 		ret = erofs_iterate_dir(&nctx.ctx, false);
 		if (ret)
@@ -402,9 +402,74 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi)
 	ctx = (struct erofs_rebuild_dir_context) {
 		.ctx.dir = &inode,
 		.ctx.cb = erofs_rebuild_dirent_iter,
-		.parent = root,
+		.mergedir = root,
 	};
 	ret = erofs_iterate_dir(&ctx.ctx, false);
 	free(inode.i_srcpath);
 	return ret;
 }
+
+static int erofs_rebuild_basedir_dirent_iter(struct erofs_dir_context *ctx)
+{
+	struct erofs_rebuild_dir_context *rctx = (void *)ctx;
+	struct erofs_inode *dir = ctx->dir;
+	struct erofs_inode *mergedir = rctx->mergedir;
+	struct erofs_dentry *d;
+	char *dname;
+	bool dumb;
+	int ret;
+
+	if (ctx->dot_dotdot)
+		return 0;
+
+	dname = strndup(ctx->dname, ctx->de_namelen);
+	if (!dname)
+		return -ENOMEM;
+	d = erofs_rebuild_get_dentry(mergedir, dname, false,
+				     &dumb, &dumb, false);
+	if (IS_ERR(d)) {
+		ret = PTR_ERR(d);
+		goto out;
+	}
+
+	if (d->type == EROFS_FT_UNKNOWN) {
+		d->nid = ctx->de_nid;
+		d->type = ctx->de_ftype;
+		d->validnid = true;
+		if (!mergedir->whiteouts && erofs_dentry_is_wht(dir->sbi, d))
+			mergedir->whiteouts = true;
+	} else {
+		struct erofs_inode *inode = d->inode;
+
+		list_del(&inode->i_hash);
+		inode->dev = dir->sbi->dev;
+		inode->i_ino[1] = ctx->de_nid;
+		erofs_insert_ihash(inode);
+	}
+	ret = 0;
+out:
+	free(dname);
+	return ret;
+}
+
+int erofs_rebuild_load_basedir(struct erofs_inode *dir)
+{
+	struct erofs_inode fakeinode = {
+		.sbi = dir->sbi,
+		.nid = dir->i_ino[1],
+	};
+	struct erofs_rebuild_dir_context ctx;
+	int ret;
+
+	ret = erofs_read_inode_from_disk(&fakeinode);
+	if (ret) {
+		erofs_err("failed to read inode @ %llu", fakeinode.nid);
+		return ret;
+	}
+	ctx = (struct erofs_rebuild_dir_context) {
+		.ctx.dir = &fakeinode,
+		.ctx.cb = erofs_rebuild_basedir_dirent_iter,
+		.mergedir = dir,
+	};
+	return erofs_iterate_dir(&ctx.ctx, false);
+}
-- 
2.39.3

