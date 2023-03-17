Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D00856BE448
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Mar 2023 09:50:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PdHsT6L9bz3cg0
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Mar 2023 19:50:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PdHsQ5g44z3bsK
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Mar 2023 19:50:50 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Ve2QyQs_1679043046;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ve2QyQs_1679043046)
          by smtp.aliyun-inc.com;
          Fri, 17 Mar 2023 16:50:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: rearrange on-disk metadata
Date: Fri, 17 Mar 2023 16:50:44 +0800
Message-Id: <20230317085045.16263-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

 - Use BFS instead of DFS;

 - Regular data is separated from metadata and dir data.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/inode.h    |   3 +-
 include/erofs/internal.h |   2 +
 lib/cache.c              |   5 +-
 lib/inode.c              | 234 ++++++++++++++++++++++-----------------
 mkfs/main.c              |   2 +-
 5 files changed, 141 insertions(+), 105 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index bf20cd3..058a235 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -20,8 +20,7 @@ unsigned char erofs_ftype_to_dtype(unsigned int filetype);
 void erofs_inode_manager_init(void);
 unsigned int erofs_iput(struct erofs_inode *inode);
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
-struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
-						    const char *path);
+struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path);
 struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name);
 
 #ifdef __cplusplus
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index a727312..1f1e730 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -147,6 +147,8 @@ struct erofs_inode {
 		unsigned int flags;
 		/* (mkfs.erofs) device ID containing source file */
 		u32 dev;
+		/* (mkfs.erofs) queued sub-directories blocking dump */
+		u32 subdirs_queued;
 	};
 	unsigned int i_count;
 	struct erofs_inode *i_parent;
diff --git a/lib/cache.c b/lib/cache.c
index 3ada3eb..9eb0394 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -288,7 +288,10 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 		bb->blkaddr = NULL_ADDR;
 		bb->buffers.off = 0;
 		init_list_head(&bb->buffers.list);
-		list_add_tail(&bb->list, &blkh.list);
+		if (type == DATA)
+			list_add(&bb->list, &last_mapped_block->list);
+		else
+			list_add_tail(&bb->list, &blkh.list);
 		init_list_head(&bb->mapped_list);
 
 		bh = malloc(sizeof(struct erofs_buffer_head));
diff --git a/lib/inode.c b/lib/inode.c
index 39874a0..0f49f6e 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -183,7 +183,6 @@ int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
 {
 	struct erofs_dentry *d, *n, **sorted_d;
 	unsigned int d_size, i_nlink, i;
-	int ret;
 
 	/* dot is pointed to the current dir inode */
 	d = erofs_d_alloc(dir, ".");
@@ -241,11 +240,6 @@ int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
 	/* no compression for all dirs */
 	dir->datalayout = EROFS_INODE_FLAT_INLINE;
 
-	/* allocate dir main data */
-	ret = __allocate_inode_bh_data(dir, erofs_blknr(d_size));
-	if (ret)
-		return ret;
-
 	/* it will be used in erofs_prepare_inode_buffer */
 	dir->idata_size = d_size % erofs_blksiz();
 	return 0;
@@ -284,6 +278,33 @@ static int write_dirblock(unsigned int q, struct erofs_dentry *head,
 	return blk_write(buf, blkaddr, 1);
 }
 
+erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
+{
+	struct erofs_buffer_head *const bh = inode->bh;
+	erofs_off_t off, meta_offset;
+
+	if (!bh || inode->nid)
+		return inode->nid;
+
+	erofs_mapbh(bh->block);
+	off = erofs_btell(bh, false);
+
+	meta_offset = erofs_pos(sbi.meta_blkaddr);
+	DBG_BUGON(off < meta_offset);
+	inode->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
+	erofs_dbg("Assign nid %llu to file %s (mode %05o)",
+		  inode->nid, inode->i_srcpath, inode->i_mode);
+	return inode->nid;
+}
+
+static void erofs_d_invalidate(struct erofs_dentry *d)
+{
+	struct erofs_inode *const inode = d->inode;
+
+	d->nid = erofs_lookupnid(inode);
+	erofs_iput(inode);
+}
+
 static int erofs_write_dir_file(struct erofs_inode *dir)
 {
 	struct erofs_dentry *head = list_first_entry(&dir->i_subdirs,
@@ -295,10 +316,16 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 
 	q = used = blkno = 0;
 
+	/* allocate dir main data */
+	ret = __allocate_inode_bh_data(dir, erofs_blknr(dir->i_size));
+	if (ret)
+		return ret;
+
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
 		const unsigned int len = strlen(d->name) +
 			sizeof(struct erofs_dirent);
 
+		erofs_d_invalidate(d);
 		if (used + len > erofs_blksiz()) {
 			ret = write_dirblock(q, head, d,
 					     dir->u.i_blkaddr + blkno);
@@ -589,23 +616,11 @@ static int erofs_prepare_tail_block(struct erofs_inode *inode)
 		return 0;
 
 	bh = inode->bh_data;
-	if (!bh) {
-		bh = erofs_balloc(DATA, erofs_blksiz(), 0, 0);
-		if (IS_ERR(bh))
-			return PTR_ERR(bh);
-		bh->op = &erofs_skip_write_bhops;
-
-		/* get blkaddr of bh */
-		ret = erofs_mapbh(bh->block);
-		DBG_BUGON(ret < 0);
-		inode->u.i_blkaddr = bh->block->blkaddr;
-
-		inode->bh_data = bh;
-		return 0;
+	if (bh) {
+		/* expend a block as the tail block (should be successful) */
+		ret = erofs_bh_balloon(bh, erofs_blksiz());
+		DBG_BUGON(ret != erofs_blksiz());
 	}
-	/* expend a block as the tail block (should be successful) */
-	ret = erofs_bh_balloon(bh, erofs_blksiz());
-	DBG_BUGON(ret != erofs_blksiz());
 	return 0;
 }
 
@@ -728,7 +743,20 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		int ret;
 		erofs_off_t pos, zero_pos;
 
-		erofs_mapbh(bh->block);
+		if (!bh) {
+			bh = erofs_balloc(DATA, erofs_blksiz(), 0, 0);
+			if (IS_ERR(bh))
+				return PTR_ERR(bh);
+			bh->op = &erofs_skip_write_bhops;
+
+			/* get blkaddr of bh */
+			ret = erofs_mapbh(bh->block);
+			inode->u.i_blkaddr = bh->block->blkaddr;
+			inode->bh_data = bh;
+		} else {
+			ret = erofs_mapbh(bh->block);
+		}
+		DBG_BUGON(ret < 0);
 		pos = erofs_btell(bh, true) - erofs_blksiz();
 
 		/* 0'ed data should be padded at head for 0padding conversion */
@@ -911,8 +939,10 @@ static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 	if (!inode->i_srcpath)
 		return -ENOMEM;
 
-	inode->dev = st->st_dev;
-	inode->i_ino[1] = st->st_ino;
+	if (!S_ISDIR(inode->i_mode)) {
+		inode->dev = st->st_dev;
+		inode->i_ino[1] = st->st_ino;
+	}
 
 	if (erofs_should_use_inode_extended(inode)) {
 		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
@@ -1003,31 +1033,7 @@ static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 	rootdir->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
 }
 
-erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
-{
-	struct erofs_buffer_head *const bh = inode->bh;
-	erofs_off_t off, meta_offset;
-
-	if (!bh)
-		return inode->nid;
-
-	erofs_mapbh(bh->block);
-	off = erofs_btell(bh, false);
-
-	meta_offset = erofs_pos(sbi.meta_blkaddr);
-	DBG_BUGON(off < meta_offset);
-	return inode->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
-}
-
-static void erofs_d_invalidate(struct erofs_dentry *d)
-{
-	struct erofs_inode *const inode = d->inode;
-
-	d->nid = erofs_lookupnid(inode);
-	erofs_iput(inode);
-}
-
-static struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
+static int erofs_mkfs_build_tree(struct erofs_inode *dir, struct list_head *dirs)
 {
 	int ret;
 	DIR *_dir;
@@ -1037,40 +1043,37 @@ static struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 
 	ret = erofs_prepare_xattr_ibody(dir);
 	if (ret < 0)
-		return ERR_PTR(ret);
+		return ret;
 
 	if (!S_ISDIR(dir->i_mode)) {
 		if (S_ISLNK(dir->i_mode)) {
 			char *const symlink = malloc(dir->i_size);
 
 			if (!symlink)
-				return ERR_PTR(-ENOMEM);
+				return -ENOMEM;
 			ret = readlink(dir->i_srcpath, symlink, dir->i_size);
 			if (ret < 0) {
 				free(symlink);
-				return ERR_PTR(-errno);
+				return -errno;
 			}
-
 			ret = erofs_write_file_from_buffer(dir, symlink);
 			free(symlink);
-			if (ret)
-				return ERR_PTR(ret);
 		} else {
 			ret = erofs_write_file(dir);
-			if (ret)
-				return ERR_PTR(ret);
 		}
+		if (ret)
+			return ret;
 
 		erofs_prepare_inode_buffer(dir);
 		erofs_write_tail_end(dir);
-		return dir;
+		return 0;
 	}
 
 	_dir = opendir(dir->i_srcpath);
 	if (!_dir) {
 		erofs_err("failed to opendir at %s: %s",
 			  dir->i_srcpath, erofs_strerror(errno));
-		return ERR_PTR(-errno);
+		return -errno;
 	}
 
 	nr_subdirs = 0;
@@ -1111,23 +1114,23 @@ static struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 
 	ret = erofs_prepare_dir_file(dir, nr_subdirs);
 	if (ret)
-		goto err;
+		return ret;
 
 	ret = erofs_prepare_inode_buffer(dir);
 	if (ret)
-		goto err;
+		return ret;
+	dir->bh->op = &erofs_skip_write_bhops;
 
 	if (IS_ROOT(dir))
 		erofs_fixup_meta_blkaddr(dir);
 
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
-		char buf[PATH_MAX], *trimmed;
+		char buf[PATH_MAX];
 		unsigned char ftype;
+		struct erofs_inode *inode;
 
-		if (is_dot_dotdot(d->name)) {
-			erofs_d_invalidate(d);
+		if (is_dot_dotdot(d->name))
 			continue;
-		}
 
 		ret = snprintf(buf, PATH_MAX, "%s/%s",
 			       dir->i_srcpath, d->name);
@@ -1136,59 +1139,88 @@ static struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 			goto fail;
 		}
 
-		trimmed = erofs_trim_for_progressinfo(erofs_fspath(buf),
-					sizeof("Processing  ...") - 1);
-		erofs_update_progressinfo("Processing %s ...", trimmed);
-		free(trimmed);
-		d->inode = erofs_mkfs_build_tree_from_path(dir, buf);
-		if (IS_ERR(d->inode)) {
-			ret = PTR_ERR(d->inode);
+		inode = erofs_iget_from_path(buf, true);
+
+		if (IS_ERR(inode)) {
+			ret = PTR_ERR(inode);
 fail:
 			d->inode = NULL;
 			d->type = EROFS_FT_UNKNOWN;
-			goto err;
+			return ret;
 		}
 
-		ftype = erofs_mode_to_ftype(d->inode->i_mode);
+		/* a hardlink to the existed inode */
+		if (inode->i_parent) {
+			++inode->i_nlink;
+		} else {
+			inode->i_parent = dir;
+			erofs_igrab(inode);
+			list_add_tail(&inode->i_subdirs, dirs);
+			++dir->subdirs_queued;
+		}
+		ftype = erofs_mode_to_ftype(inode->i_mode);
 		DBG_BUGON(ftype == EROFS_FT_DIR && d->type != ftype);
+		d->inode = inode;
 		d->type = ftype;
-
-		erofs_d_invalidate(d);
-		erofs_info("add file %s/%s (nid %llu, type %u)",
-			   dir->i_srcpath, d->name, (unsigned long long)d->nid,
-			   d->type);
+		erofs_info("file %s/%s dumped (type %u)",
+			   dir->i_srcpath, d->name, d->type);
 	}
-	erofs_write_dir_file(dir);
-	erofs_write_tail_end(dir);
-	return dir;
+	return 0;
 
 err_closedir:
 	closedir(_dir);
-err:
-	return ERR_PTR(ret);
+	return ret;
 }
 
-struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
-						    const char *path)
+static void erofs_mkfs_dump_directory(struct erofs_inode *dir)
 {
-	struct erofs_inode *const inode = erofs_iget_from_path(path, true);
+	erofs_write_dir_file(dir);
+	erofs_write_tail_end(dir);
+	dir->bh->op = &erofs_write_inode_bhops;
+}
 
-	if (IS_ERR(inode))
-		return inode;
+struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
+{
+	LIST_HEAD(dirs);
+	struct erofs_inode *inode, *root, *parent;
 
-	/* a hardlink to the existed inode */
-	if (inode->i_parent) {
-		++inode->i_nlink;
-		return inode;
-	}
+	root = erofs_igrab(erofs_iget_from_path(path, true));
+	if (IS_ERR(root))
+		return root;
 
-	/* a completely new inode is found */
-	if (parent)
-		inode->i_parent = parent;
-	else
-		inode->i_parent = inode;	/* rootdir mark */
+	root->i_parent = root;	/* rootdir mark */
+	root->subdirs_queued = 1;
+	list_add(&root->i_subdirs, &dirs);
 
-	return erofs_mkfs_build_tree(inode);
+	do {
+		int err;
+		char *trimmed;
+
+		inode = list_first_entry(&dirs, struct erofs_inode, i_subdirs);
+		list_del(&inode->i_subdirs);
+		init_list_head(&inode->i_subdirs);
+
+		trimmed = erofs_trim_for_progressinfo(
+				erofs_fspath(inode->i_srcpath),
+				sizeof("Processing  ...") - 1);
+		erofs_update_progressinfo("Processing %s ...", trimmed);
+		free(trimmed);
+
+		err = erofs_mkfs_build_tree(inode, &dirs);
+		if (err) {
+			root = ERR_PTR(err);
+			break;
+		}
+		parent = inode->i_parent;
+
+		DBG_BUGON(!parent->subdirs_queued);
+		if (S_ISDIR(inode->i_mode) && !inode->subdirs_queued)
+			erofs_mkfs_dump_directory(inode);
+		if (!--parent->subdirs_queued)
+			erofs_mkfs_dump_directory(parent);
+		erofs_iput(inode);
+	} while (!list_empty(&dirs));
+	return root;
 }
 
 struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
diff --git a/mkfs/main.c b/mkfs/main.c
index f4d2330..a05d4f9 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -856,7 +856,7 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	root_inode = erofs_mkfs_build_tree_from_path(NULL, cfg.c_src_path);
+	root_inode = erofs_mkfs_build_tree_from_path(cfg.c_src_path);
 	if (IS_ERR(root_inode)) {
 		err = PTR_ERR(root_inode);
 		goto exit;
-- 
2.24.4

