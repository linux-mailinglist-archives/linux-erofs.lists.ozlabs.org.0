Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5D68C98EC
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 08:11:37 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XrfIycxL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjRnm5zqcz3cWt
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 16:03:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XrfIycxL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjRng0L11z3cWF
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 16:03:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716184990; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5RIh213dzr3JrKX5g9NS5HH5tcV/TQCqrshxuwmOhU8=;
	b=XrfIycxL6PJ0wcupOnjwjHv2J7+aGfO7QYiymi1sTyVFmUndh9CC77fnZPSow7EYY0ApdSo5k/b+tAgGZilxw7I/jRb3F7cXzjxqiVnKq7FxgnfhPBj480UcQXS/E9xMJowWADN5l1AXUHpMEQklXFdJfpwmh64pAeihWn9IMiM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W6ldUdx_1716184982;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6ldUdx_1716184982)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 14:03:08 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: unify the tree traversal for the rebuild mode
Date: Mon, 20 May 2024 14:03:01 +0800
Message-Id: <20240520060301.2642650-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240515084156.4191479-1-hsiangkao@linux.alibaba.com>
References: <20240515084156.4191479-1-hsiangkao@linux.alibaba.com>
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

Let's drop the legacy approach and `tarerofs` will be applied too.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
change since v1:
 - fix incorrect unencoded data reported by:
   https://github.com/erofs/erofsnightly/actions/runs/9153196829

 include/erofs/internal.h |   7 +-
 lib/diskbuf.c            |  14 +-
 lib/inode.c              | 383 ++++++++++++++++++++++-----------------
 3 files changed, 231 insertions(+), 173 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index ecbbdf6..46345e0 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -290,7 +290,12 @@ static inline unsigned int erofs_inode_datalayout(unsigned int value)
 			      EROFS_I_DATALAYOUT_BITS);
 }
 
-#define IS_ROOT(x)	((x) == (x)->i_parent)
+static inline struct erofs_inode *erofs_parent_inode(struct erofs_inode *inode)
+{
+	return (void *)((unsigned long)inode->i_parent & ~1UL);
+}
+
+#define IS_ROOT(x)	((x) == erofs_parent_inode(x))
 
 struct erofs_dentry {
 	struct list_head d_child;	/* child of parent list */
diff --git a/lib/diskbuf.c b/lib/diskbuf.c
index 8205ba5..e5889df 100644
--- a/lib/diskbuf.c
+++ b/lib/diskbuf.c
@@ -10,7 +10,7 @@
 
 /* A simple approach to avoid creating too many temporary files */
 static struct erofs_diskbufstrm {
-	u64 count;
+	erofs_atomic_t count;
 	u64 tailoffset, devpos;
 	int fd;
 	unsigned int alignsize;
@@ -25,8 +25,6 @@ int erofs_diskbuf_getfd(struct erofs_diskbuf *db, u64 *fpos)
 	if (!strm)
 		return -1;
 	offset = db->offset + strm->devpos;
-	if (lseek(strm->fd, offset, SEEK_SET) != offset)
-		return -E2BIG;
 	if (fpos)
 		*fpos = offset;
 	return strm->fd;
@@ -46,7 +44,7 @@ int erofs_diskbuf_reserve(struct erofs_diskbuf *db, int sid, u64 *off)
 	if (off)
 		*off = db->offset + strm->devpos;
 	db->sp = strm;
-	++strm->count;
+	(void)erofs_atomic_inc_return(&strm->count);
 	strm->locked = true;	/* TODO: need a real lock for MT */
 	return strm->fd;
 }
@@ -66,8 +64,8 @@ void erofs_diskbuf_close(struct erofs_diskbuf *db)
 	struct erofs_diskbufstrm *strm = db->sp;
 
 	DBG_BUGON(!strm);
-	DBG_BUGON(strm->count <= 1);
-	--strm->count;
+	DBG_BUGON(erofs_atomic_read(&strm->count) <= 1);
+	(void)erofs_atomic_dec_return(&strm->count);
 	db->sp = NULL;
 }
 
@@ -122,7 +120,7 @@ int erofs_diskbuf_init(unsigned int nstrms)
 			return -ENOSPC;
 setupone:
 		strm->tailoffset = 0;
-		strm->count = 1;
+		erofs_atomic_set(&strm->count, 1);
 		if (fstat(strm->fd, &st))
 			return -errno;
 		strm->alignsize = max_t(u32, st.st_blksize, getpagesize());
@@ -138,7 +136,7 @@ void erofs_diskbuf_exit(void)
 		return;
 
 	for (strm = dbufstrm; strm->fd >= 0; ++strm) {
-		DBG_BUGON(strm->count != 1);
+		DBG_BUGON(erofs_atomic_read(&strm->count) != 1);
 
 		close(strm->fd);
 		strm->fd = -1;
diff --git a/lib/inode.c b/lib/inode.c
index fda98a4..cbe0810 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -264,7 +264,7 @@ int erofs_init_empty_dir(struct erofs_inode *dir)
 	d = erofs_d_alloc(dir, "..");
 	if (IS_ERR(d))
 		return PTR_ERR(d);
-	d->inode = erofs_igrab(dir->i_parent);
+	d->inode = erofs_igrab(erofs_parent_inode(dir));
 	d->type = EROFS_FT_DIR;
 
 	dir->i_nlink = 2;
@@ -494,29 +494,6 @@ int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
 	return write_uncompressed_file_from_fd(inode, fd);
 }
 
-int erofs_write_file(struct erofs_inode *inode, int fd, u64 fpos)
-{
-	DBG_BUGON(!inode->i_size);
-
-	if (cfg.c_compr_opts[0].alg && erofs_file_is_compressible(inode)) {
-		void *ictx;
-		int ret;
-
-		ictx = erofs_begin_compressed_file(inode, fd, fpos);
-		if (IS_ERR(ictx))
-			return PTR_ERR(ictx);
-
-		ret = erofs_write_compressed_file(ictx);
-		if (ret != -ENOSPC)
-			return ret;
-
-		if (lseek(fd, fpos, SEEK_SET) < 0)
-			return -errno;
-	}
-	/* fallback to all data uncompressed */
-	return erofs_write_unencoded_file(inode, fd, fpos);
-}
-
 static int erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 {
 	struct erofs_inode *const inode = bh->fsprivate;
@@ -1113,6 +1090,7 @@ struct erofs_mkfs_job_ndir_ctx {
 	struct erofs_inode *inode;
 	void *ictx;
 	int fd;
+	u64 fpos;
 };
 
 static int erofs_mkfs_job_write_file(struct erofs_mkfs_job_ndir_ctx *ctx)
@@ -1120,19 +1098,31 @@ static int erofs_mkfs_job_write_file(struct erofs_mkfs_job_ndir_ctx *ctx)
 	struct erofs_inode *inode = ctx->inode;
 	int ret;
 
+	if (inode->with_diskbuf && lseek(ctx->fd, ctx->fpos, SEEK_SET) < 0) {
+		ret = -errno;
+		goto out;
+	}
+
 	if (ctx->ictx) {
 		ret = erofs_write_compressed_file(ctx->ictx);
 		if (ret != -ENOSPC)
 			goto out;
-		if (lseek(ctx->fd, 0, SEEK_SET) < 0) {
+		if (lseek(ctx->fd, ctx->fpos, SEEK_SET) < 0) {
 			ret = -errno;
 			goto out;
 		}
 	}
 	/* fallback to all data uncompressed */
-	ret = erofs_write_unencoded_file(inode, ctx->fd, 0);
+	ret = erofs_write_unencoded_file(inode, ctx->fd, ctx->fpos);
 out:
-	close(ctx->fd);
+	if (inode->with_diskbuf) {
+		erofs_diskbuf_close(inode->i_diskbuf);
+		free(inode->i_diskbuf);
+		inode->i_diskbuf = NULL;
+		inode->with_diskbuf = false;
+	} else {
+		close(ctx->fd);
+	}
 	return ret;
 }
 
@@ -1142,17 +1132,21 @@ static int erofs_mkfs_handle_nondirectory(struct erofs_mkfs_job_ndir_ctx *ctx)
 	int ret = 0;
 
 	if (S_ISLNK(inode->i_mode)) {
-		char *const symlink = malloc(inode->i_size);
-
-		if (!symlink)
-			return -ENOMEM;
-		ret = readlink(inode->i_srcpath, symlink, inode->i_size);
-		if (ret < 0) {
-			free(symlink);
-			return -errno;
+		char *symlink = inode->i_link;
+
+		if (!symlink) {
+			symlink = malloc(inode->i_size);
+			if (!symlink)
+				return -ENOMEM;
+			ret = readlink(inode->i_srcpath, symlink, inode->i_size);
+			if (ret < 0) {
+				free(symlink);
+				return -errno;
+			}
 		}
 		ret = erofs_write_file_from_buffer(inode, symlink);
 		free(symlink);
+		inode->i_link = NULL;
 	} else if (inode->i_size) {
 		ret = erofs_mkfs_job_write_file(ctx);
 	}
@@ -1371,6 +1365,43 @@ err_closedir:
 	return ret;
 }
 
+static int erofs_rebuild_handle_directory(struct erofs_inode *dir)
+{
+	struct erofs_dentry *d, *n;
+	unsigned int nr_subdirs, i_nlink;
+	int ret;
+
+	nr_subdirs = 0;
+	i_nlink = 2;
+	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
+		if (cfg.c_ovlfs_strip && erofs_inode_is_whiteout(d->inode)) {
+			erofs_dbg("remove whiteout %s", d->inode->i_srcpath);
+			list_del(&d->d_child);
+			erofs_d_invalidate(d);
+			free(d);
+			continue;
+		}
+		i_nlink += S_ISDIR(d->inode->i_mode);
+		++nr_subdirs;
+	}
+
+	ret = erofs_prepare_dir_layout(dir, nr_subdirs);
+	if (ret)
+		return ret;
+
+	/*
+	 * if there're too many subdirs as compact form, set nlink=1
+	 * rather than upgrade to use extented form instead.
+	 */
+	if (i_nlink > USHRT_MAX &&
+	    dir->inode_isize == sizeof(struct erofs_inode_compact))
+		dir->i_nlink = 1;
+	else
+		dir->i_nlink = i_nlink;
+
+	return erofs_mkfs_go(dir->sbi, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
+}
+
 static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
 {
 	const char *relpath = erofs_fspath(inode->i_srcpath);
@@ -1415,27 +1446,89 @@ static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
 	return ret;
 }
 
-#ifndef EROFS_MT_ENABLED
-#define __erofs_mkfs_build_tree_from_path erofs_mkfs_build_tree_from_path
-#endif
+static int erofs_rebuild_handle_inode(struct erofs_inode *inode)
+{
+	char *trimmed;
+	int ret;
+
+	trimmed = erofs_trim_for_progressinfo(erofs_fspath(inode->i_srcpath),
+					      sizeof("Processing  ...") - 1);
+	erofs_update_progressinfo("Processing %s ...", trimmed);
+	free(trimmed);
+
+	if (erofs_should_use_inode_extended(inode)) {
+		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
+			erofs_err("file %s cannot be in compact form",
+				  inode->i_srcpath);
+			return -EINVAL;
+		}
+		inode->inode_isize = sizeof(struct erofs_inode_extended);
+	} else {
+		inode->inode_isize = sizeof(struct erofs_inode_compact);
+	}
+
+	/* strip all unnecessary overlayfs xattrs when ovlfs_strip is enabled */
+	if (cfg.c_ovlfs_strip)
+		erofs_clear_opaque_xattr(inode);
+	else if (inode->whiteouts)
+		erofs_set_origin_xattr(inode);
 
-struct erofs_inode *__erofs_mkfs_build_tree_from_path(const char *path)
+	ret = erofs_prepare_xattr_ibody(inode);
+	if (ret < 0)
+		return ret;
+
+	if (!S_ISDIR(inode->i_mode)) {
+		struct erofs_mkfs_job_ndir_ctx ctx = { .inode = inode };
+
+		if (!S_ISLNK(inode->i_mode) && inode->i_size) {
+			DBG_BUGON(!inode->with_diskbuf);
+			ctx.fd = erofs_diskbuf_getfd(inode->i_diskbuf, &ctx.fpos);
+			if (ctx.fd < 0)
+				return ret;
+
+			if (cfg.c_compr_opts[0].alg &&
+			    erofs_file_is_compressible(inode)) {
+				ctx.ictx = erofs_begin_compressed_file(inode,
+							ctx.fd, ctx.fpos);
+				if (IS_ERR(ctx.ictx))
+					return PTR_ERR(ctx.ictx);
+			}
+		}
+		ret = erofs_mkfs_go(inode->sbi, EROFS_MKFS_JOB_NDIR,
+				    &ctx, sizeof(ctx));
+	} else {
+		ret = erofs_rebuild_handle_directory(inode);
+	}
+	erofs_info("file %s dumped (mode %05o)", erofs_fspath(inode->i_srcpath),
+		   inode->i_mode);
+	return ret;
+}
+
+static bool erofs_inode_visited(struct erofs_inode *inode)
 {
-	struct erofs_inode *root, *dumpdir;
-	int err;
+	return (unsigned long)inode->i_parent & 1UL;
+}
 
-	root = erofs_iget_from_path(path, true);
-	if (IS_ERR(root))
-		return root;
+static void erofs_mark_parent_inode(struct erofs_inode *inode,
+				    struct erofs_inode *dir)
+{
+	inode->i_parent = (void *)((unsigned long)dir | 1);
+}
 
-	root->i_parent = root;	/* rootdir mark */
+static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild)
+{
+	struct erofs_inode *dumpdir;
+	int err;
+
+	erofs_mark_parent_inode(root, root);	/* rootdir mark */
 	root->next_dirwrite = NULL;
 	(void)erofs_igrab(root);
 	dumpdir = root;
 
-	err = erofs_mkfs_handle_inode(root);
+	err = !rebuild ? erofs_mkfs_handle_inode(root) :
+			erofs_rebuild_handle_inode(root);
 	if (err)
-		return ERR_PTR(err);
+		return err;
 
 	do {
 		int err;
@@ -1450,21 +1543,25 @@ struct erofs_inode *__erofs_mkfs_build_tree_from_path(const char *path)
 
 			if (is_dot_dotdot(d->name))
 				continue;
-			if (inode->i_parent) {
-				++inode->i_nlink;
-			} else {
-				inode->i_parent = dir;
 
-				err = erofs_mkfs_handle_inode(inode);
-				if (err) {
-					root = ERR_PTR(err);
+			if (!erofs_inode_visited(inode)) {
+				DBG_BUGON(rebuild &&
+					  erofs_parent_inode(inode) != dir);
+				erofs_mark_parent_inode(inode, dir);
+
+				if (!rebuild)
+					err = erofs_mkfs_handle_inode(inode);
+				else
+					err = erofs_rebuild_handle_inode(inode);
+				if (err)
 					break;
-				}
 				if (S_ISDIR(inode->i_mode)) {
 					*last = inode;
 					last = &inode->next_dirwrite;
 					(void)erofs_igrab(inode);
 				}
+			} else if (!rebuild) {
+				++inode->i_nlink;
 			}
 		}
 		*last = dumpdir;	/* fixup the last (or the only) one */
@@ -1472,28 +1569,61 @@ struct erofs_inode *__erofs_mkfs_build_tree_from_path(const char *path)
 		err = erofs_mkfs_go(dir->sbi, EROFS_MKFS_JOB_DIR_BH,
 				    &dir, sizeof(dir));
 		if (err)
-			return ERR_PTR(err);
+			return err;
 	} while (dumpdir);
 
-	return root;
+	return err;
 }
 
-#ifdef EROFS_MT_ENABLED
-struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
+struct erofs_mkfs_buildtree_ctx {
+	union {
+		const char *path;
+		struct erofs_inode *root;
+	} u;
+	bool from_path;
+};
+#ifndef EROFS_MT_ENABLED
+#define __erofs_mkfs_build_tree erofs_mkfs_build_tree
+#endif
+
+static int __erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 {
-	struct erofs_mkfs_dfops *q;
 	struct erofs_inode *root;
 	int err;
 
+	if (ctx->from_path) {
+		root = erofs_iget_from_path(ctx->u.path, true);
+		if (IS_ERR(root))
+			return PTR_ERR(root);
+	} else {
+		root = ctx->u.root;
+	}
+
+	err = erofs_mkfs_dump_tree(root, !ctx->from_path);
+	if (err) {
+		if (ctx->from_path)
+			erofs_iput(root);
+		return err;
+	}
+	ctx->u.root = root;
+	return 0;
+}
+
+#ifdef EROFS_MT_ENABLED
+static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
+{
+	struct erofs_mkfs_dfops *q;
+	int err, err2;
+
 	q = malloc(sizeof(*q));
 	if (!q)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	q->entries = EROFS_MT_QUEUE_SIZE;
 	q->queue = malloc(q->entries * sizeof(*q->queue));
 	if (!q->queue) {
 		free(q);
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	}
 	pthread_mutex_init(&q->lock, NULL);
 	pthread_cond_init(&q->empty, NULL);
@@ -1506,10 +1636,12 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
 			     z_erofs_mt_dfops_worker, &sbi);
 	if (err)
 		goto fail;
-	root = __erofs_mkfs_build_tree_from_path(path);
 
+	err = __erofs_mkfs_build_tree(ctx);
 	erofs_mkfs_go(&sbi, ~0, NULL, 0);
-	err = pthread_join(sbi.dfops_worker, NULL);
+	err2 = pthread_join(sbi.dfops_worker, NULL);
+	if (!err)
+		err = err2;
 
 fail:
 	pthread_cond_destroy(&q->empty);
@@ -1517,10 +1649,32 @@ fail:
 	pthread_mutex_destroy(&q->lock);
 	free(q->queue);
 	free(q);
-	return err ? ERR_PTR(err) : root;
+	return err;
 }
 #endif
 
+struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
+{
+	struct erofs_mkfs_buildtree_ctx ctx = {
+		.from_path = true,
+		.u.path = path,
+	};
+	int err;
+
+	err = erofs_mkfs_build_tree(&ctx);
+	if (err)
+		return ERR_PTR(err);
+	return ctx.u.root;
+}
+
+int erofs_rebuild_dump_tree(struct erofs_inode *root)
+{
+	return erofs_mkfs_build_tree(&((struct erofs_mkfs_buildtree_ctx) {
+		.from_path = false,
+		.u.root = root,
+	}));
+}
+
 struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 {
 	struct stat st;
@@ -1578,102 +1732,3 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 	erofs_write_tail_end(inode);
 	return inode;
 }
-
-int erofs_rebuild_dump_tree(struct erofs_inode *dir)
-{
-	struct erofs_dentry *d, *n;
-	unsigned int nr_subdirs;
-	int ret;
-
-	if (erofs_should_use_inode_extended(dir)) {
-		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
-			erofs_err("file %s cannot be in compact form",
-				  dir->i_srcpath);
-			return -EINVAL;
-		}
-		dir->inode_isize = sizeof(struct erofs_inode_extended);
-	} else {
-		dir->inode_isize = sizeof(struct erofs_inode_compact);
-	}
-
-	/* strip all unnecessary overlayfs xattrs when ovlfs_strip is enabled */
-	if (cfg.c_ovlfs_strip)
-		erofs_clear_opaque_xattr(dir);
-	else if (dir->whiteouts)
-		erofs_set_origin_xattr(dir);
-
-	ret = erofs_prepare_xattr_ibody(dir);
-	if (ret < 0)
-		return ret;
-
-	if (!S_ISDIR(dir->i_mode)) {
-		if (dir->bh)
-			return 0;
-		if (S_ISLNK(dir->i_mode)) {
-			ret = erofs_write_file_from_buffer(dir, dir->i_link);
-			free(dir->i_link);
-			dir->i_link = NULL;
-		} else if (dir->with_diskbuf) {
-			u64 fpos;
-
-			ret = erofs_diskbuf_getfd(dir->i_diskbuf, &fpos);
-			if (ret >= 0)
-				ret = erofs_write_file(dir, ret, fpos);
-			erofs_diskbuf_close(dir->i_diskbuf);
-			free(dir->i_diskbuf);
-			dir->i_diskbuf = NULL;
-			dir->with_diskbuf = false;
-		} else {
-			ret = 0;
-		}
-		if (ret)
-			return ret;
-		ret = erofs_prepare_inode_buffer(dir);
-		if (ret)
-			return ret;
-		erofs_write_tail_end(dir);
-		return 0;
-	}
-
-	nr_subdirs = 0;
-	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
-		if (cfg.c_ovlfs_strip && erofs_inode_is_whiteout(d->inode)) {
-			erofs_dbg("remove whiteout %s", d->inode->i_srcpath);
-			list_del(&d->d_child);
-			erofs_d_invalidate(d);
-			free(d);
-			continue;
-		}
-		++nr_subdirs;
-	}
-
-	ret = erofs_prepare_dir_layout(dir, nr_subdirs);
-	if (ret)
-		return ret;
-
-	ret = erofs_prepare_inode_buffer(dir);
-	if (ret)
-		return ret;
-	dir->bh->op = &erofs_skip_write_bhops;
-
-	if (IS_ROOT(dir))
-		erofs_fixup_meta_blkaddr(dir);
-
-	list_for_each_entry(d, &dir->i_subdirs, d_child) {
-		struct erofs_inode *inode;
-
-		if (is_dot_dotdot(d->name))
-			continue;
-
-		inode = erofs_igrab(d->inode);
-		ret = erofs_rebuild_dump_tree(inode);
-		dir->i_nlink += (erofs_mode_to_ftype(inode->i_mode) == EROFS_FT_DIR);
-		erofs_iput(inode);
-		if (ret)
-			return ret;
-	}
-	erofs_write_dir_file(dir);
-	erofs_write_tail_end(dir);
-	dir->bh->op = &erofs_write_inode_bhops;
-	return 0;
-}
-- 
2.39.3

