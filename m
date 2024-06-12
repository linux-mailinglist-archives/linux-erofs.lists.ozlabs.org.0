Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216DF90586B
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jun 2024 18:19:10 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cAuz5Zqn;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VzrMZ5vg2z3dWV
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jun 2024 02:19:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cAuz5Zqn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VzrM6424Sz3dDy
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jun 2024 02:18:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718209118; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=y1thwRwhu51K5Z79cl5oiMx4S9EoZyoSGL6xdYniVI8=;
	b=cAuz5ZqnRd6vNoMWGbxpD/UxbnaN1p1rQIKnGa/VaerqVIGVu8EGsdf5GwkaB8bvIYR5bMAWcLSlAkVOWxpM6TrR2U9ehSIQ913BvbnaDs2B3C2kOuwfuNf8LmNhabcfbloe4q34S0oSYjMFsXwmvCPHsdbutMgZ+jmpsBE0zSI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8LOtUw_1718209117;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8LOtUw_1718209117)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 00:18:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 5/5] erofs-utils: lib: get rid of global sbi in lib/inode.c
Date: Thu, 13 Jun 2024 00:18:26 +0800
Message-Id: <20240612161826.711279-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240612161826.711279-1-hsiangkao@linux.alibaba.com>
References: <20240612161826.711279-1-hsiangkao@linux.alibaba.com>
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

In order to prepare for incremental builds.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/inode.h |  8 +++++---
 lib/fragments.c       |  2 +-
 lib/inode.c           | 47 +++++++++++++++++++++++--------------------
 lib/rebuild.c         |  4 ++--
 lib/tar.c             |  2 +-
 mkfs/main.c           | 37 +++++++++++++++++-----------------
 6 files changed, 53 insertions(+), 47 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 46d989c..3bdc2b4 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -38,9 +38,11 @@ int erofs_rebuild_dump_tree(struct erofs_inode *dir);
 int erofs_init_empty_dir(struct erofs_inode *dir);
 int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 		       const char *path);
-struct erofs_inode *erofs_new_inode(void);
-struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path);
-struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name);
+struct erofs_inode *erofs_new_inode(struct erofs_sb_info *sbi);
+struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_sb_info *sbi,
+						    const char *path);
+struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
+						     int fd, const char *name);
 
 #ifdef __cplusplus
 }
diff --git a/lib/fragments.c b/lib/fragments.c
index f4c9bd7..4d5478f 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -330,7 +330,7 @@ struct erofs_inode *erofs_mkfs_build_packedfile(void)
 {
 	fflush(packedfile);
 
-	return erofs_mkfs_build_special_from_fd(fileno(packedfile),
+	return erofs_mkfs_build_special_from_fd(&sbi, fileno(packedfile),
 						EROFS_PACKED_INODE);
 }
 
diff --git a/lib/inode.c b/lib/inode.c
index 069484d..40ded5c 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1011,7 +1011,7 @@ static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 	return 0;
 }
 
-struct erofs_inode *erofs_new_inode(void)
+struct erofs_inode *erofs_new_inode(struct erofs_sb_info *sbi)
 {
 	struct erofs_inode *inode;
 
@@ -1019,8 +1019,8 @@ struct erofs_inode *erofs_new_inode(void)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	inode->sbi = &sbi;
-	inode->i_ino[0] = sbi.inos++;	/* inode serial number */
+	inode->sbi = sbi;
+	inode->i_ino[0] = sbi->inos++;	/* inode serial number */
 	inode->i_count = 1;
 	inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 
@@ -1030,17 +1030,14 @@ struct erofs_inode *erofs_new_inode(void)
 	return inode;
 }
 
-/* get the inode from the (source) path */
-static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
+/* get the inode from the source path */
+static struct erofs_inode *erofs_iget_from_srcpath(struct erofs_sb_info *sbi,
+						   const char *path)
 {
 	struct stat st;
 	struct erofs_inode *inode;
 	int ret;
 
-	/* currently, only source path is supported */
-	if (!is_src)
-		return ERR_PTR(-EINVAL);
-
 	ret = lstat(path, &st);
 	if (ret)
 		return ERR_PTR(-errno);
@@ -1057,7 +1054,7 @@ static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
 	}
 
 	/* cannot find in the inode cache */
-	inode = erofs_new_inode();
+	inode = erofs_new_inode(sbi);
 	if (IS_ERR(inode))
 		return inode;
 
@@ -1293,6 +1290,7 @@ static void erofs_mkfs_flushjobs(struct erofs_sb_info *sbi)
 
 static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 {
+	struct erofs_sb_info *sbi = dir->sbi;
 	DIR *_dir;
 	struct dirent *dp;
 	struct erofs_dentry *d;
@@ -1344,7 +1342,7 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 		if (ret < 0 || ret >= PATH_MAX)
 			goto err_closedir;
 
-		inode = erofs_iget_from_path(buf, true);
+		inode = erofs_iget_from_srcpath(sbi, buf);
 		if (IS_ERR(inode)) {
 			ret = PTR_ERR(inode);
 			goto err_closedir;
@@ -1375,7 +1373,7 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 	else
 		dir->i_nlink = i_nlink;
 
-	return erofs_mkfs_go(dir->sbi, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
+	return erofs_mkfs_go(sbi, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
 
 err_closedir:
 	closedir(_dir);
@@ -1597,11 +1595,11 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild)
 }
 
 struct erofs_mkfs_buildtree_ctx {
+	struct erofs_sb_info *sbi;
 	union {
 		const char *path;
 		struct erofs_inode *root;
 	} u;
-	bool from_path;
 };
 #ifndef EROFS_MT_ENABLED
 #define __erofs_mkfs_build_tree erofs_mkfs_build_tree
@@ -1609,20 +1607,21 @@ struct erofs_mkfs_buildtree_ctx {
 
 static int __erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 {
+	bool from_path = !!ctx->sbi;
 	struct erofs_inode *root;
 	int err;
 
-	if (ctx->from_path) {
-		root = erofs_iget_from_path(ctx->u.path, true);
+	if (from_path) {
+		root = erofs_iget_from_srcpath(ctx->sbi, ctx->u.path);
 		if (IS_ERR(root))
 			return PTR_ERR(root);
 	} else {
 		root = ctx->u.root;
 	}
 
-	err = erofs_mkfs_dump_tree(root, !ctx->from_path);
+	err = erofs_mkfs_dump_tree(root, !from_path);
 	if (err) {
-		if (ctx->from_path)
+		if (from_path)
 			erofs_iput(root);
 		return err;
 	}
@@ -1676,14 +1675,17 @@ fail:
 }
 #endif
 
-struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
+struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_sb_info *sbi,
+						    const char *path)
 {
 	struct erofs_mkfs_buildtree_ctx ctx = {
-		.from_path = true,
+		.sbi = sbi,
 		.u.path = path,
 	};
 	int err;
 
+	if (!sbi)
+		return ERR_PTR(-EINVAL);
 	err = erofs_mkfs_build_tree(&ctx);
 	if (err)
 		return ERR_PTR(err);
@@ -1693,12 +1695,13 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
 int erofs_rebuild_dump_tree(struct erofs_inode *root)
 {
 	return erofs_mkfs_build_tree(&((struct erofs_mkfs_buildtree_ctx) {
-		.from_path = false,
+		.sbi = NULL,
 		.u.root = root,
 	}));
 }
 
-struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
+struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
+						     int fd, const char *name)
 {
 	struct stat st;
 	struct erofs_inode *inode;
@@ -1713,7 +1716,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 	if (ret)
 		return ERR_PTR(-errno);
 
-	inode = erofs_new_inode();
+	inode = erofs_new_inode(sbi);
 	if (IS_ERR(inode))
 		return inode;
 
diff --git a/lib/rebuild.c b/lib/rebuild.c
index c25d222..806d8b2 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -31,7 +31,7 @@ static struct erofs_dentry *erofs_rebuild_mkdir(struct erofs_inode *dir,
 	struct erofs_inode *inode;
 	struct erofs_dentry *d;
 
-	inode = erofs_new_inode();
+	inode = erofs_new_inode(dir->sbi);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
@@ -296,7 +296,7 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 		u64 nid;
 
 		DBG_BUGON(parent != d->inode);
-		inode = erofs_new_inode();
+		inode = erofs_new_inode(dir->sbi);
 		if (IS_ERR(inode)) {
 			ret = PTR_ERR(inode);
 			goto out;
diff --git a/lib/tar.c b/lib/tar.c
index 6202d35..3a5d484 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -937,7 +937,7 @@ restart:
 		inode = d->inode;
 	} else {
 new_inode:
-		inode = erofs_new_inode();
+		inode = erofs_new_inode(sbi);
 		if (IS_ERR(inode)) {
 			ret = PTR_ERR(inode);
 			goto out;
diff --git a/mkfs/main.c b/mkfs/main.c
index 1e8ca3c..1b15bc5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1035,11 +1035,12 @@ void erofs_show_progs(int argc, char *argv[])
 	if (cfg.c_dbg_lvl >= EROFS_WARN)
 		printf("%s %s\n", basename(argv[0]), cfg.c_version);
 }
-static struct erofs_inode *erofs_alloc_root_inode(void)
+
+static struct erofs_inode *erofs_mkfs_alloc_root(struct erofs_sb_info *sbi)
 {
 	struct erofs_inode *root;
 
-	root = erofs_new_inode();
+	root = erofs_new_inode(sbi);
 	if (IS_ERR(root))
 		return root;
 	root->i_srcpath = strdup("/");
@@ -1135,7 +1136,7 @@ int main(int argc, char **argv)
 {
 	int err = 0;
 	struct erofs_buffer_head *sb_bh;
-	struct erofs_inode *root_inode, *packed_inode;
+	struct erofs_inode *root, *packed_inode;
 	erofs_blk_t nblocks;
 	struct timeval t;
 	FILE *packedfile = NULL;
@@ -1297,31 +1298,31 @@ int main(int argc, char **argv)
 	erofs_inode_manager_init();
 
 	if (tar_mode) {
-		root_inode = erofs_alloc_root_inode();
-		if (IS_ERR(root_inode)) {
-			err = PTR_ERR(root_inode);
+		root = erofs_mkfs_alloc_root(&sbi);
+		if (IS_ERR(root)) {
+			err = PTR_ERR(root);
 			goto exit;
 		}
 
-		while (!(err = tarerofs_parse_tar(root_inode, &erofstar)));
+		while (!(err = tarerofs_parse_tar(root, &erofstar)));
 
 		if (err < 0)
 			goto exit;
 
-		err = erofs_rebuild_dump_tree(root_inode);
+		err = erofs_rebuild_dump_tree(root);
 		if (err < 0)
 			goto exit;
 	} else if (rebuild_mode) {
-		root_inode = erofs_alloc_root_inode();
-		if (IS_ERR(root_inode)) {
-			err = PTR_ERR(root_inode);
+		root = erofs_mkfs_alloc_root(&sbi);
+		if (IS_ERR(root)) {
+			err = PTR_ERR(root);
 			goto exit;
 		}
 
-		err = erofs_rebuild_load_trees(root_inode);
+		err = erofs_rebuild_load_trees(root);
 		if (err)
 			goto exit;
-		err = erofs_rebuild_dump_tree(root_inode);
+		err = erofs_rebuild_dump_tree(root);
 		if (err)
 			goto exit;
 	} else {
@@ -1335,14 +1336,14 @@ int main(int argc, char **argv)
 		if (cfg.c_extra_ea_name_prefixes)
 			erofs_xattr_write_name_prefixes(&sbi, packedfile);
 
-		root_inode = erofs_mkfs_build_tree_from_path(cfg.c_src_path);
-		if (IS_ERR(root_inode)) {
-			err = PTR_ERR(root_inode);
+		root = erofs_mkfs_build_tree_from_path(&sbi, cfg.c_src_path);
+		if (IS_ERR(root)) {
+			err = PTR_ERR(root);
 			goto exit;
 		}
 	}
-	sbi.root_nid = erofs_lookupnid(root_inode);
-	erofs_iput(root_inode);
+	sbi.root_nid = erofs_lookupnid(root);
+	erofs_iput(root);
 
 	if (erofstar.index_mode && sbi.extra_devices && !erofstar.mapfile)
 		sbi.devs[0].blocks = BLK_ROUND_UP(&sbi, erofstar.offset);
-- 
2.39.3

