Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A622587DD73
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Mar 2024 15:41:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TyLKC38jkz3dKG
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Mar 2024 01:41:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TyLK85Q0Cz3cM5
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 Mar 2024 01:41:32 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 84F8910091C1F
	for <linux-erofs@lists.ozlabs.org>; Sun, 17 Mar 2024 22:41:14 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 7D80037C921
	for <linux-erofs@lists.ozlabs.org>; Sun, 17 Mar 2024 22:41:13 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: lib: split function logic in inode.c
Date: Sun, 17 Mar 2024 22:41:11 +0800
Message-ID: <20240317144112.1445017-2-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317144112.1445017-1-zhaoyifan@sjtu.edu.cn>
References: <20240317144112.1445017-1-zhaoyifan@sjtu.edu.cn>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch splits part of the logic in function erofs_mkfs_build_tree()
and erofs_mkfs_build_tree_from_path() into several new functions. This
is in preparation for the upcoming inter-file multi-threaded compression
feature.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
 lib/inode.c | 161 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 100 insertions(+), 61 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index ac00228..8460344 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -477,20 +477,24 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 	return 0;
 }
 
+static int erofs_write_chunked_file(struct erofs_inode *inode, int fd, u64 fpos)
+{
+	inode->u.chunkbits = cfg.c_chunkbits;
+	/* chunk indexes when explicitly specified */
+	inode->u.chunkformat = 0;
+	if (cfg.c_force_chunkformat == FORCE_INODE_CHUNK_INDEXES)
+		inode->u.chunkformat = EROFS_CHUNK_FORMAT_INDEXES;
+	return erofs_blob_write_chunked_file(inode, fd, fpos);
+}
+
 int erofs_write_file(struct erofs_inode *inode, int fd, u64 fpos)
 {
 	int ret;
 
 	DBG_BUGON(!inode->i_size);
 
-	if (cfg.c_chunkbits) {
-		inode->u.chunkbits = cfg.c_chunkbits;
-		/* chunk indexes when explicitly specified */
-		inode->u.chunkformat = 0;
-		if (cfg.c_force_chunkformat == FORCE_INODE_CHUNK_INDEXES)
-			inode->u.chunkformat = EROFS_CHUNK_FORMAT_INDEXES;
-		return erofs_blob_write_chunked_file(inode, fd, fpos);
-	}
+	if (cfg.c_chunkbits)
+		return erofs_write_chunked_file(inode, fd, fpos);
 
 	if (cfg.c_compr_opts[0].alg && erofs_file_is_compressible(inode)) {
 		ret = erofs_write_compressed_file(inode, fd);
@@ -1096,52 +1100,57 @@ static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 	rootdir->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
 }
 
-static int erofs_mkfs_build_tree(struct erofs_inode *dir, struct list_head *dirs)
-{
-	int ret;
-	DIR *_dir;
-	struct dirent *dp;
-	struct erofs_dentry *d;
-	unsigned int nr_subdirs, i_nlink;
 
-	ret = erofs_scan_file_xattrs(dir);
-	if (ret < 0)
-		return ret;
+static int erofs_mkfs_handle_symlink(struct erofs_inode *inode)
+{
+	int ret = 0;
+	char *const symlink = malloc(inode->i_size);
 
-	ret = erofs_prepare_xattr_ibody(dir);
-	if (ret < 0)
-		return ret;
+	if (!symlink)
+		return -ENOMEM;
+	ret = readlink(inode->i_srcpath, symlink, inode->i_size);
+	if (ret < 0) {
+		free(symlink);
+		return -errno;
+	}
+	ret = erofs_write_file_from_buffer(inode, symlink);
+	free(symlink);
 
-	if (!S_ISDIR(dir->i_mode)) {
-		if (S_ISLNK(dir->i_mode)) {
-			char *const symlink = malloc(dir->i_size);
+	return ret;
+}
 
-			if (!symlink)
-				return -ENOMEM;
-			ret = readlink(dir->i_srcpath, symlink, dir->i_size);
-			if (ret < 0) {
-				free(symlink);
-				return -errno;
-			}
-			ret = erofs_write_file_from_buffer(dir, symlink);
-			free(symlink);
-		} else if (dir->i_size) {
-			int fd = open(dir->i_srcpath, O_RDONLY | O_BINARY);
-			if (fd < 0)
-				return -errno;
+static int erofs_mkfs_handle_file(struct erofs_inode *inode)
+{
+	int ret = 0;
 
-			ret = erofs_write_file(dir, fd, 0);
-			close(fd);
-		} else {
-			ret = 0;
-		}
-		if (ret)
-			return ret;
+	if (S_ISLNK(inode->i_mode)) {
+		ret = erofs_mkfs_handle_symlink(inode);
+	} else if (inode->i_size) {
+		int fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
+		if (fd < 0)
+			return -errno;
 
-		erofs_prepare_inode_buffer(dir);
-		erofs_write_tail_end(dir);
-		return 0;
+		ret = erofs_write_file(inode, fd, 0);
+		close(fd);
+	} else {
+		ret = 0;
 	}
+	if (ret)
+		return ret;
+
+	erofs_prepare_inode_buffer(inode);
+	erofs_write_tail_end(inode);
+	return 0;
+}
+
+static int erofs_mkfs_handle_dir(struct erofs_inode *dir,
+				 struct list_head *dirs)
+{
+	int ret;
+	DIR *_dir;
+	struct dirent *dp;
+	struct erofs_dentry *d;
+	unsigned int nr_subdirs = 0, i_nlink;
 
 	_dir = opendir(dir->i_srcpath);
 	if (!_dir) {
@@ -1253,6 +1262,48 @@ err_closedir:
 	return ret;
 }
 
+static void erofs_mkfs_print_progressinfo(struct erofs_inode *inode)
+{
+	char *trimmed;
+
+	trimmed = erofs_trim_for_progressinfo(erofs_fspath(inode->i_srcpath),
+					      sizeof("Processing  ...") - 1);
+	erofs_update_progressinfo("Processing %s ...", trimmed);
+	free(trimmed);
+}
+
+static void erofs_mkfs_dumpdir(struct erofs_inode *dumpdir)
+{
+	struct erofs_inode *inode;
+	while (dumpdir) {
+		inode = dumpdir;
+		erofs_write_dir_file(inode);
+		erofs_write_tail_end(inode);
+		inode->bh->op = &erofs_write_inode_bhops;
+		dumpdir = inode->next_dirwrite;
+		erofs_iput(inode);
+	}
+}
+
+static int erofs_mkfs_build_tree(struct erofs_inode *dir,
+				 struct list_head *dirs)
+{
+	int ret;
+
+	ret = erofs_scan_file_xattrs(dir);
+	if (ret < 0)
+		return ret;
+
+	ret = erofs_prepare_xattr_ibody(dir);
+	if (ret < 0)
+		return ret;
+
+	if (S_ISDIR(dir->i_mode))
+		return erofs_mkfs_handle_dir(dir, dirs);
+	else
+		return erofs_mkfs_handle_file(dir);
+}
+
 struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
 {
 	LIST_HEAD(dirs);
@@ -1269,17 +1320,12 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
 	dumpdir = NULL;
 	do {
 		int err;
-		char *trimmed;
 
 		inode = list_first_entry(&dirs, struct erofs_inode, i_subdirs);
 		list_del(&inode->i_subdirs);
 		init_list_head(&inode->i_subdirs);
 
-		trimmed = erofs_trim_for_progressinfo(
-				erofs_fspath(inode->i_srcpath),
-				sizeof("Processing  ...") - 1);
-		erofs_update_progressinfo("Processing %s ...", trimmed);
-		free(trimmed);
+		erofs_mkfs_print_progressinfo(inode);
 
 		err = erofs_mkfs_build_tree(inode, &dirs);
 		if (err) {
@@ -1295,14 +1341,7 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
 		}
 	} while (!list_empty(&dirs));
 
-	while (dumpdir) {
-		inode = dumpdir;
-		erofs_write_dir_file(inode);
-		erofs_write_tail_end(inode);
-		inode->bh->op = &erofs_write_inode_bhops;
-		dumpdir = inode->next_dirwrite;
-		erofs_iput(inode);
-	}
+	erofs_mkfs_dumpdir(dumpdir);
 	return root;
 }
 
-- 
2.44.0

