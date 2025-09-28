Return-Path: <linux-erofs+bounces-1125-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BC4BA6909
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Sep 2025 08:32:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cZDym6pZZz2yrW;
	Sun, 28 Sep 2025 16:32:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759041168;
	cv=none; b=ZbPL4IqaFvauZKKFEHI/z1wRjZiefLlluglhHpvWWUD/JXA5VeIbxWipHVhsjkatFVAU2ZcsY4btYwS2TqoUAjt7D4U6y8tbXKZq0y34H/Hgg3GCavhX74SQzmzYVqtISwViTTyHwu8WTIJ+/3pL3FWZzGN3rR5XlMcygR0Adj9UWlgbKF0b6Ide/EPtrCNu+0YL5H3pqQ+IPfRA0aKTv8g7ltU0maAj/KW1TRf5H/noQxSaUW4d9BMX0WmKBfr8LYNCR/QnpR1g3/v0nGYbKevIC5UoUNKtKnxA9EdiXZm+RF2KVS0v4/neHcraVvdksghMK/89g0JTrus8CQtayg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759041168; c=relaxed/relaxed;
	bh=ByYujNwFl5LlKwMfv5xXnNXFDoqhDYujyK6qeqLIlko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNXs6ZijjDKsqxjdZgTPevP0rVWXxkfzVmGm0w0fiP23/XuGVxAORUd3d00vkZLaEtl07U19ip4A7HQiaLATzmn0x63A/i9i8NcKR9736kk8Po3olNNDnGBnsWsl/LK6McwqpY5wJUqRKGMp8Yu0TnY9W8NyHt3ZDEHXu7CiUHGn/bahSSAfWEzgnc3fVs5zz8zlACCa9i7JfHxrsZD2C3lMXtNVDrwHQj36JLBKaZj3MNyYPi6hNKwZ+cx3SvzvTC3b+U2pTsl1ICwcfLI9ET78H3laBAU0kn8Vflb/xeouWMQu4lt2juvOJsKtAjHKZ7DD4eJ7B5Ai7piyIarH3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=i6gA6tWQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=i6gA6tWQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cZDyk1pf1z3cYN
	for <linux-erofs@lists.ozlabs.org>; Sun, 28 Sep 2025 16:32:44 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759041161; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ByYujNwFl5LlKwMfv5xXnNXFDoqhDYujyK6qeqLIlko=;
	b=i6gA6tWQV8Db6d0MHQlqFXRjNUdWtzgIUhynn4fddpH3yMz8pSMuJFRuZ2MI56QHKuxGSu/ezE8MF9xazzZIG2eSHqAh0LLxnRDdvkxjYjR3oyICzm3mqQymEJreo/+Q4XZy/f13H48p/B/QFThO4OAvYR8VYqVHeHUBVls6G7U=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Woy6mLW_1759041159 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 28 Sep 2025 14:32:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/3] erofs-utils: mkfs: enable incremental builds for local files
Date: Sun, 28 Sep 2025 14:32:32 +0800
Message-ID: <20250928063232.2613721-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928063232.2613721-1-hsiangkao@linux.alibaba.com>
References: <20250928063232.2613721-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

EROFS supports incremental-style builds without rewriting the entire
filesystem metadata, since it does not have classic centralized inode
tables or SquashFS-style directory tables.

This commit adds incremental build support for local files:
 $ mkfs.erofs foo.erofs layer0/
 $ mkfs.erofs --incremental=data foo.erofs layer1/
 ...

OverlayFS whiteouts are supported for replacing specific directory
entries. Additionally, these extra whiteouts can be dropped from the
final image using `--ovlfs-strip`

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c            | 54 +++++++++++++++++++++++++++---------------
 lib/liberofs_rebuild.h |  4 ++--
 lib/rebuild.c          | 26 +++++++++++++-------
 mkfs/main.c            |  1 -
 4 files changed, 54 insertions(+), 31 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 810ffc2..74c9645 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1294,6 +1294,7 @@ struct erofs_inode *erofs_new_inode(struct erofs_sb_info *sbi)
 static struct erofs_inode *erofs_iget_from_local(struct erofs_importer *im,
 						 const char *path)
 {
+	const struct erofs_importer_params *params = im->params;
 	struct erofs_sb_info *sbi = im->sbi;
 	struct erofs_inode *inode;
 	struct stat st;
@@ -1308,7 +1309,7 @@ static struct erofs_inode *erofs_iget_from_local(struct erofs_importer *im,
 	 * hard-link, just return it. Also don't lookup for directories
 	 * since hard-link directory isn't allowed.
 	 */
-	if (!S_ISDIR(st.st_mode) && !im->params->hard_dereference) {
+	if (!S_ISDIR(st.st_mode) && !params->hard_dereference) {
 		inode = erofs_iget(st.st_dev, st.st_ino);
 		if (inode)
 			return inode;
@@ -1669,6 +1670,8 @@ static int erofs_mkfs_import_localdir(struct erofs_importer *im, struct erofs_in
 			ret = PTR_ERR(inode);
 			goto err_closedir;
 		}
+		if (!dir->whiteouts && erofs_inode_is_whiteout(inode))
+			dir->whiteouts = true;
 		d->inode = inode;
 		d->type = erofs_mode_to_ftype(inode->i_mode);
 		__nlink += S_ISDIR(inode->i_mode);
@@ -1712,16 +1715,15 @@ static void erofs_dentry_kill(struct erofs_dentry *d)
 	free(d);
 }
 
-static int erofs_mkfs_handle_directory(struct erofs_importer *im,
-				       struct erofs_inode *dir,
-				       bool rebuild,
-				       bool incremental)
+static int erofs_prepare_dir_inode(struct erofs_importer *im,
+				   struct erofs_inode *dir,
+				   bool rebuild,
+				   bool incremental)
 {
 	struct erofs_sb_info *sbi = im->sbi;
 	struct erofs_dentry *d, *n;
 	unsigned int i_nlink;
 	u64 nr_subdirs;
-	bool delwht = im->params->ovlfs_strip && dir->whiteouts;
 	int ret;
 
 	nr_subdirs = 0;
@@ -1733,11 +1735,6 @@ static int erofs_mkfs_handle_directory(struct erofs_importer *im,
 			erofs_dentry_kill(d);
 			continue;
 		}
-		if (delwht && erofs_dentry_is_wht(sbi, d)) {
-			erofs_dbg("remove whiteout %s", d->inode->i_srcpath);
-			erofs_dentry_kill(d);
-			continue;
-		}
 		i_nlink += (d->type == EROFS_FT_DIR);
 		++nr_subdirs;
 	}
@@ -1749,6 +1746,22 @@ static int erofs_mkfs_handle_directory(struct erofs_importer *im,
 			return ret;
 	}
 
+	if (incremental && dir->dev == sbi->dev && !dir->opaque) {
+		ret = erofs_rebuild_load_basedir(dir, &nr_subdirs, &i_nlink);
+		if (ret)
+			return ret;
+	}
+	if (im->params->ovlfs_strip && dir->whiteouts) {
+		list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
+			if (erofs_dentry_is_wht(sbi, d)) {
+				erofs_dbg("remove whiteout %s",
+					  d->inode->i_srcpath);
+				erofs_dentry_kill(d);
+				--nr_subdirs;
+				continue;
+			}
+		}
+	}
 	DBG_BUGON(nr_subdirs + 2 < i_nlink);
 	ret = erofs_prepare_dir_file(im, dir, nr_subdirs);
 	if (ret)
@@ -1769,8 +1782,7 @@ static int erofs_mkfs_handle_directory(struct erofs_importer *im,
 		else
 			dir->i_nlink = 1;
 	}
-
-	return erofs_mkfs_go(im, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
+	return 0;
 }
 
 static int erofs_mkfs_begin_nondirectory(struct erofs_importer *im,
@@ -1830,10 +1842,9 @@ static int erofs_mkfs_handle_inode(struct erofs_importer *im,
 		inode->inode_isize = sizeof(struct erofs_inode_compact);
 	}
 
-	if (incremental && S_ISDIR(inode->i_mode) &&
-	    inode->dev == inode->sbi->dev && !inode->opaque) {
-		ret = erofs_rebuild_load_basedir(inode);
-		if (ret)
+	if (S_ISDIR(inode->i_mode)) {
+		ret = erofs_prepare_dir_inode(im, inode, rebuild, incremental);
+		if (ret < 0)
 			return ret;
 	}
 
@@ -1856,8 +1867,8 @@ static int erofs_mkfs_handle_inode(struct erofs_importer *im,
 	if (!S_ISDIR(inode->i_mode)) {
 		ret = erofs_mkfs_begin_nondirectory(im, inode);
 	} else {
-		ret = erofs_mkfs_handle_directory(im, inode,
-						  rebuild, incremental);
+		ret = erofs_mkfs_go(im, EROFS_MKFS_JOB_DIR, &inode,
+				    sizeof(inode));
 	}
 	erofs_info("file %s dumped (mode %05o)", *relpath ? relpath : "/",
 		   inode->i_mode);
@@ -2071,6 +2082,11 @@ fail:
 int erofs_importer_load_tree(struct erofs_importer *im, bool rebuild,
 			     bool incremental)
 {
+	if (__erofs_unlikely(incremental && erofs_sb_has_metabox(im->sbi))) {
+		erofs_err("Metadata-compressed filesystems don't support incremental builds for now");
+		return -EOPNOTSUPP;
+	}
+
 	return erofs_mkfs_build_tree(&((struct erofs_mkfs_buildtree_ctx) {
 		.im = im,
 		.rebuild = rebuild,
diff --git a/lib/liberofs_rebuild.h b/lib/liberofs_rebuild.h
index 1eb79cf..69802fb 100644
--- a/lib/liberofs_rebuild.h
+++ b/lib/liberofs_rebuild.h
@@ -16,6 +16,6 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
 			    enum erofs_rebuild_datamode mode);
 
-int erofs_rebuild_load_basedir(struct erofs_inode *dir);
-
+int erofs_rebuild_load_basedir(struct erofs_inode *dir, u64 *nr_subdirs,
+			       unsigned int *i_nlink);
 #endif
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 83e30fd..c5b44d5 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -274,15 +274,18 @@ static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
 	return err;
 }
 
-/*
- * @mergedir: parent directory in the merged tree
- * @ctx.dir:  parent directory when itering erofs_iterate_dir()
- * @datamode: indicate how to import inode data
- */
 struct erofs_rebuild_dir_context {
+	/* @ctx.dir:  parent directory when itering erofs_iterate_dir() */
 	struct erofs_dir_context ctx;
-	struct erofs_inode *mergedir;
-	enum erofs_rebuild_datamode datamode;
+	struct erofs_inode *mergedir;	/* parent directory in the merged tree */
+	union {
+		/* indicate how to import inode data */
+		enum erofs_rebuild_datamode datamode;
+		struct {
+			u64 *nr_subdirs;
+			unsigned int *i_nlink;
+		};
+	};
 };
 
 static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
@@ -458,8 +461,8 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
 static int erofs_rebuild_basedir_dirent_iter(struct erofs_dir_context *ctx)
 {
 	struct erofs_rebuild_dir_context *rctx = (void *)ctx;
-	struct erofs_inode *dir = ctx->dir;
 	struct erofs_inode *mergedir = rctx->mergedir;
+	struct erofs_inode *dir = ctx->dir;
 	struct erofs_dentry *d;
 	char *dname;
 	bool dumb;
@@ -484,6 +487,8 @@ static int erofs_rebuild_basedir_dirent_iter(struct erofs_dir_context *ctx)
 		d->validnid = true;
 		if (!mergedir->whiteouts && erofs_dentry_is_wht(dir->sbi, d))
 			mergedir->whiteouts = true;
+		*rctx->i_nlink += (ctx->de_ftype == EROFS_FT_DIR);
+		++*rctx->nr_subdirs;
 	} else if (__erofs_unlikely(d->validnid)) {
 		/* The base image appears to be corrupted */
 		DBG_BUGON(1);
@@ -508,7 +513,8 @@ out:
 	return ret;
 }
 
-int erofs_rebuild_load_basedir(struct erofs_inode *dir)
+int erofs_rebuild_load_basedir(struct erofs_inode *dir, u64 *nr_subdirs,
+			       unsigned int *i_nlink)
 {
 	struct erofs_inode fakeinode = {
 		.sbi = dir->sbi,
@@ -540,6 +546,8 @@ int erofs_rebuild_load_basedir(struct erofs_inode *dir)
 		.ctx.dir = &fakeinode,
 		.ctx.cb = erofs_rebuild_basedir_dirent_iter,
 		.mergedir = dir,
+		.nr_subdirs = nr_subdirs,
+		.i_nlink = i_nlink,
 	};
 	return erofs_iterate_dir(&ctx.ctx, false);
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index 7a538bd..f3cf24e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1835,7 +1835,6 @@ int main(int argc, char **argv)
 			err = PTR_ERR(root);
 			goto exit;
 		}
-		incremental_mode = false;
 	} else {
 		root = erofs_rebuild_make_root(&g_sbi);
 		if (IS_ERR(root)) {
-- 
2.43.5


