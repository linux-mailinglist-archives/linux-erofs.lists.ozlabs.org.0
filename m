Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC60489A92F
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Apr 2024 07:37:46 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wnlCg1QS;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VBPJS4Zgtz3vZp
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Apr 2024 16:37:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wnlCg1QS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VBPJF19dqz3dVq
	for <linux-erofs@lists.ozlabs.org>; Sat,  6 Apr 2024 16:37:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712381847; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=APdiy595Z7HY64YyZXBdfHqiYzyeWihbWRAjqSYa7ao=;
	b=wnlCg1QS2VfmGEZS5t1W33rm8mkj3aMnSvW8oHVgLmrz3le7rIl9zEqnp6v9tfHNz1Y0trjL5at7X7iJ/Yq5PPlHaGvrgX9i6blTwR4rzGwnRn8mRxC5OiUhZ5BN5YI/G61CT68XGzRNNDlza7hmR2NKzglrD5F2/yBNL6HMx9Y=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W3ykLgS_1712381845;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W3ykLgS_1712381845)
          by smtp.aliyun-inc.com;
          Sat, 06 Apr 2024 13:37:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: lib: refine on-disk meta arrangement again
Date: Sat,  6 Apr 2024 13:37:17 +0800
Message-Id: <20240406053717.565119-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240406053717.565119-1-hsiangkao@linux.alibaba.com>
References: <20240406053717.565119-1-hsiangkao@linux.alibaba.com>
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

Most workloads like `ls -R` and `tar -c` traverse in depth-first mode.
However, it still arranges sub-directory inodes more closely so that
it isn't a simple reversion compared to pre-BFS old versions.

Also the build performance out of linux-6.1.53 source code is greatly
improved by 91.2% (33.040s->2.861s) as well as the new image size is
decreased by 0.0094% (120 KiB), which is minor.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 192 +++++++++++++++++++++++++---------------------------
 1 file changed, 91 insertions(+), 101 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index f419f3c..79626ab 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -162,7 +162,8 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 
 	strncpy(d->name, name, EROFS_NAME_LEN - 1);
 	d->name[EROFS_NAME_LEN - 1] = '\0';
-
+	d->inode = NULL;
+	d->type = EROFS_FT_UNKNOWN;
 	list_add_tail(&d->d_child, &parent->i_subdirs);
 	return d;
 }
@@ -1131,7 +1132,7 @@ static int erofs_mkfs_handle_nondirectory(struct erofs_inode *inode)
 	return 0;
 }
 
-static int erofs_mkfs_handle_directory(struct erofs_inode *dir, struct list_head *dirs)
+static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 {
 	DIR *_dir;
 	struct dirent *dp;
@@ -1147,18 +1148,28 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir, struct list_head
 	}
 
 	nr_subdirs = 0;
+	i_nlink = 0;
 	while (1) {
+		char buf[PATH_MAX];
+		struct erofs_inode *inode;
+
 		/*
 		 * set errno to 0 before calling readdir() in order to
 		 * distinguish end of stream and from an error.
 		 */
 		errno = 0;
 		dp = readdir(_dir);
-		if (!dp)
-			break;
+		if (!dp) {
+			if (!errno)
+				break;
+			ret = -errno;
+			goto err_closedir;
+		}
 
-		if (is_dot_dotdot(dp->d_name))
+		if (is_dot_dotdot(dp->d_name)) {
+			++i_nlink;
 			continue;
+		}
 
 		/* skip if it's a exclude file */
 		if (erofs_is_exclude_path(dir->i_srcpath, dp->d_name))
@@ -1169,70 +1180,28 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir, struct list_head
 			ret = PTR_ERR(d);
 			goto err_closedir;
 		}
-		nr_subdirs++;
-	}
-
-	if (errno) {
-		ret = -errno;
-		goto err_closedir;
-	}
-	closedir(_dir);
-
-	ret = erofs_prepare_dir_file(dir, nr_subdirs);
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
-	i_nlink = 0;
-	list_for_each_entry(d, &dir->i_subdirs, d_child) {
-		char buf[PATH_MAX];
-		unsigned char ftype;
-		struct erofs_inode *inode;
-
-		if (is_dot_dotdot(d->name)) {
-			++i_nlink;
-			continue;
-		}
 
-		ret = snprintf(buf, PATH_MAX, "%s/%s",
-			       dir->i_srcpath, d->name);
-		if (ret < 0 || ret >= PATH_MAX) {
-			/* ignore the too long path */
-			goto fail;
-		}
+		ret = snprintf(buf, PATH_MAX, "%s/%s", dir->i_srcpath, d->name);
+		if (ret < 0 || ret >= PATH_MAX)
+			goto err_closedir;
 
 		inode = erofs_iget_from_path(buf, true);
-
 		if (IS_ERR(inode)) {
 			ret = PTR_ERR(inode);
-fail:
-			d->inode = NULL;
-			d->type = EROFS_FT_UNKNOWN;
-			return ret;
-		}
-
-		/* a hardlink to the existed inode */
-		if (inode->i_parent) {
-			++inode->i_nlink;
-		} else {
-			inode->i_parent = dir;
-			erofs_igrab(inode);
-			list_add_tail(&inode->i_subdirs, dirs);
+			goto err_closedir;
 		}
-		ftype = erofs_mode_to_ftype(inode->i_mode);
-		i_nlink += (ftype == EROFS_FT_DIR);
 		d->inode = inode;
-		d->type = ftype;
-		erofs_info("file %s/%s dumped (type %u)",
-			   dir->i_srcpath, d->name, d->type);
+		d->type = erofs_mode_to_ftype(inode->i_mode);
+		i_nlink += S_ISDIR(inode->i_mode);
+		erofs_dbg("file %s added (type %u)", buf, d->type);
+		nr_subdirs++;
 	}
+	closedir(_dir);
+
+	ret = erofs_prepare_dir_file(dir, nr_subdirs);
+	if (ret)
+		return ret;
+
 	/*
 	 * if there're too many subdirs as compact form, set nlink=1
 	 * rather than upgrade to use extented form instead.
@@ -1242,6 +1211,11 @@ fail:
 		dir->i_nlink = 1;
 	else
 		dir->i_nlink = i_nlink;
+
+	ret = erofs_prepare_inode_buffer(dir);
+	if (ret)
+		return ret;
+	dir->bh->op = &erofs_skip_write_bhops;
 	return 0;
 
 err_closedir:
@@ -1249,10 +1223,16 @@ err_closedir:
 	return ret;
 }
 
-static int erofs_mkfs_build_tree(struct erofs_inode *inode, struct list_head *dirs)
+static int erofs_mkfs_build_tree(struct erofs_inode *inode)
 {
+	char *trimmed;
 	int ret;
 
+	trimmed = erofs_trim_for_progressinfo(erofs_fspath(inode->i_srcpath),
+					      sizeof("Processing  ...") - 1);
+	erofs_update_progressinfo("Processing %s ...", trimmed);
+	free(trimmed);
+
 	ret = erofs_scan_file_xattrs(inode);
 	if (ret < 0)
 		return ret;
@@ -1262,60 +1242,70 @@ static int erofs_mkfs_build_tree(struct erofs_inode *inode, struct list_head *di
 		return ret;
 
 	if (!S_ISDIR(inode->i_mode))
-		return erofs_mkfs_handle_nondirectory(inode);
-	return erofs_mkfs_handle_directory(inode, dirs);
+		ret = erofs_mkfs_handle_nondirectory(inode);
+	else
+		ret = erofs_mkfs_handle_directory(inode);
+	erofs_info("file %s dumped", erofs_fspath(inode->i_srcpath));
+	return ret;
 }
 
 struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
 {
-	LIST_HEAD(dirs);
-	struct erofs_inode *inode, *root, *dumpdir;
+	struct erofs_inode *root, *dumpdir;
+	int err;
 
 	root = erofs_iget_from_path(path, true);
 	if (IS_ERR(root))
 		return root;
 
-	(void)erofs_igrab(root);
 	root->i_parent = root;	/* rootdir mark */
-	list_add(&root->i_subdirs, &dirs);
+	root->next_dirwrite = NULL;
+	(void)erofs_igrab(root);
+	dumpdir = root;
+
+	err = erofs_mkfs_build_tree(root);
+	if (err)
+		return ERR_PTR(err);
+	erofs_fixup_meta_blkaddr(root);
 
-	dumpdir = NULL;
 	do {
 		int err;
-		char *trimmed;
-
-		inode = list_first_entry(&dirs, struct erofs_inode, i_subdirs);
-		list_del(&inode->i_subdirs);
-		init_list_head(&inode->i_subdirs);
-
-		trimmed = erofs_trim_for_progressinfo(
-				erofs_fspath(inode->i_srcpath),
-				sizeof("Processing  ...") - 1);
-		erofs_update_progressinfo("Processing %s ...", trimmed);
-		free(trimmed);
-
-		err = erofs_mkfs_build_tree(inode, &dirs);
-		if (err) {
-			root = ERR_PTR(err);
-			break;
+		struct erofs_inode *dir = dumpdir;
+		/* used for adding sub-directories in reverse order due to FIFO */
+		struct erofs_inode *head, **last = &head;
+		struct erofs_dentry *d;
+
+		dumpdir = dir->next_dirwrite;
+		list_for_each_entry(d, &dir->i_subdirs, d_child) {
+			struct erofs_inode *inode = d->inode;
+
+			if (is_dot_dotdot(d->name))
+				continue;
+			if (inode->i_parent) {
+				++inode->i_nlink;
+			} else {
+				inode->i_parent = dir;
+
+				err = erofs_mkfs_build_tree(inode);
+				if (err) {
+					root = ERR_PTR(err);
+					break;
+				}
+				if (S_ISDIR(inode->i_mode)) {
+					*last = inode;
+					last = &inode->next_dirwrite;
+					(void)erofs_igrab(inode);
+				}
+			}
 		}
+		*last = dumpdir;	/* fixup the last (or the only) one */
+		dumpdir = head;
+		erofs_write_dir_file(dir);
+		erofs_write_tail_end(dir);
+		dir->bh->op = &erofs_write_inode_bhops;
+		erofs_iput(dir);
+	} while (dumpdir);
 
-		if (S_ISDIR(inode->i_mode)) {
-			inode->next_dirwrite = dumpdir;
-			dumpdir = inode;
-		} else {
-			erofs_iput(inode);
-		}
-	} while (!list_empty(&dirs));
-
-	while (dumpdir) {
-		inode = dumpdir;
-		erofs_write_dir_file(inode);
-		erofs_write_tail_end(inode);
-		inode->bh->op = &erofs_write_inode_bhops;
-		dumpdir = inode->next_dirwrite;
-		erofs_iput(inode);
-	}
 	return root;
 }
 
-- 
2.39.3

