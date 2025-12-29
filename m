Return-Path: <linux-erofs+bounces-1643-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EB5CE7CB5
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Dec 2025 19:07:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dg41N6TNqz2xpg;
	Tue, 30 Dec 2025 05:07:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767031624;
	cv=none; b=UWKoHEhWdgAOEamZeVVMvGhLiRGvAFW8Bg4sbZyUb+jWd/GgMBZMoLIGO9+ovyFZbRIS5y18n7puV/TO6tPpW2CNQW61w/Zxp5DXd+wEhdi0r7q0TBKFbL3sOXycj4JsbvzbFkOPgCYXVI7VmUQt/+KeYMP15TlqaI/B1c3V4a0gCW/xFQjY3090NVpFTt+fOkZRSSouMJn7ZA5bQLQ7r+5AsMM8AwKlGl8o1+xEY13tBsI/+PJ6qObnFI92350Hk3oO9xZFinwM00JcODH13Ib7R1+tsOA3Cn2SHt0p/qpLNjLsa7xddoMWFZ9b1z67oRgQoeqBLzYKIfxFzbKpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767031624; c=relaxed/relaxed;
	bh=c2JFqKWh/yPkJVWEgtv0wQoE72ibKqK4+H15bvZxnSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMuxfc4JgP2eP2uGCfCYRqtbBVv6jJfDV9dqnNLibjUE10iJ9UV8PbsqjmVlwyaMFlssINqDsD7Qj8bnOxJQkQDKt/9Ol1i1IN6il3B6UGavEB88bngkFfo91F9LyMQBMPTQHJF9BTJvbLmCwjRY1hMjKVzFuthASPXOX0XLat8BCMiiNlIiSja40Nx/GRuNnw7yA94JJqOsvJbzjDpcOGXsjT5Mop9MP5luCZF4QKeDBBfkN/tiTesDCVwvFukMgm52WWzxcGkX6f47C5K1J6EXy6TT6so/GdMbAuOEUmWx7OiWguK+M/1RjKMNC8C0YbkGt0zhoAC9YbICvKRd6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YCwSiZNQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YCwSiZNQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dg41K63MSz2x9M
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 05:06:59 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767031614; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=c2JFqKWh/yPkJVWEgtv0wQoE72ibKqK4+H15bvZxnSY=;
	b=YCwSiZNQGRQkCNhZNYkbAvkuEbywQE0p4NAbDGC1VPQ4byBNBczX2Jlf2h9EE85S+TZDOQ3ygrX5i28JE9nyO3ZQ34bEVRCFVd9P1WadF488IAOQ7kjWWwC4ri0Lvk9scJqi0gtzAXQiEE/FUiqWbwmClBUELqs4CQTcx7jEBDE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvwyKue_1767031612 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 02:06:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 2/4] erofs-utils: lib: switch to use `struct erofs_mkfs_btctx`
Date: Tue, 30 Dec 2025 02:06:44 +0800
Message-ID: <20251229180646.3017326-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251229180646.3017326-1-hsiangkao@linux.alibaba.com>
References: <20251229180646.3017326-1-hsiangkao@linux.alibaba.com>
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

Sometimes, it's necessary to know whether it's an incremental build
or not.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 102 +++++++++++++++++++++++++++-------------------------
 1 file changed, 53 insertions(+), 49 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 1d08e39317c0..dc3d82749405 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1450,7 +1450,12 @@ out:
 	return ret;
 }
 
-static int erofs_mkfs_handle_nondirectory(struct erofs_importer *im,
+struct erofs_mkfs_btctx {
+	struct erofs_importer *im;
+	bool rebuild, incremental;
+};
+
+static int erofs_mkfs_handle_nondirectory(const struct erofs_mkfs_btctx *btctx,
 					  struct erofs_mkfs_job_ndir_ctx *ctx)
 {
 	struct erofs_inode *inode = ctx->inode;
@@ -1480,7 +1485,7 @@ static int erofs_mkfs_handle_nondirectory(struct erofs_importer *im,
 	}
 	if (ret)
 		return ret;
-	erofs_prepare_inode_buffer(im, inode);
+	erofs_prepare_inode_buffer(btctx->im, inode);
 	erofs_write_tail_end(inode);
 	return 0;
 }
@@ -1501,7 +1506,7 @@ struct erofs_mkfs_jobitem {
 	} u;
 };
 
-static int erofs_mkfs_jobfn(struct erofs_importer *im,
+static int erofs_mkfs_jobfn(const struct erofs_mkfs_btctx *ctx,
 			    struct erofs_mkfs_jobitem *item)
 {
 	struct erofs_inode *inode = item->u.inode;
@@ -1511,7 +1516,7 @@ static int erofs_mkfs_jobfn(struct erofs_importer *im,
 		return 1;
 
 	if (item->type == EROFS_MKFS_JOB_NDIR)
-		return erofs_mkfs_handle_nondirectory(im, &item->u.ndir);
+		return erofs_mkfs_handle_nondirectory(ctx, &item->u.ndir);
 
 	if (item->type == EROFS_MKFS_JOB_DIR) {
 		unsigned int bsz = erofs_blksiz(inode->sbi);
@@ -1519,7 +1524,7 @@ static int erofs_mkfs_jobfn(struct erofs_importer *im,
 		if (inode->datalayout == EROFS_INODE_DATALAYOUT_MAX) {
 			inode->datalayout = EROFS_INODE_FLAT_INLINE;
 
-			ret = erofs_begin_compress_dir(im, inode);
+			ret = erofs_begin_compress_dir(ctx->im, inode);
 			if (ret && ret != -ENOSPC)
 				return ret;
 		} else {
@@ -1535,7 +1540,7 @@ static int erofs_mkfs_jobfn(struct erofs_importer *im,
 		 * in the parent directory since parent directories should
 		 * generally be prioritized.
 		 */
-		ret = erofs_prepare_inode_buffer(im, inode);
+		ret = erofs_prepare_inode_buffer(ctx->im, inode);
 		if (ret)
 			return ret;
 		inode->bh->op = &erofs_skip_write_bhops;
@@ -1603,8 +1608,8 @@ static void erofs_mkfs_pop_jobitem(struct erofs_mkfs_dfops *q)
 
 static void *z_erofs_mt_dfops_worker(void *arg)
 {
-	struct erofs_importer *im = arg;
-	struct erofs_sb_info *sbi = im->sbi;
+	const struct erofs_mkfs_btctx *ctx = arg;
+	struct erofs_sb_info *sbi = ctx->im->sbi;
 	struct erofs_mkfs_dfops *dfops = sbi->mkfs_dfops;
 	int ret;
 
@@ -1612,7 +1617,7 @@ static void *z_erofs_mt_dfops_worker(void *arg)
 		struct erofs_mkfs_jobitem *item;
 
 		item = erofs_mkfs_top_jobitem(dfops);
-		ret = erofs_mkfs_jobfn(im, item);
+		ret = erofs_mkfs_jobfn(ctx, item);
 		erofs_mkfs_pop_jobitem(dfops);
 	} while (!ret);
 
@@ -1622,10 +1627,10 @@ static void *z_erofs_mt_dfops_worker(void *arg)
 	pthread_exit((void *)(uintptr_t)(ret < 0 ? ret : 0));
 }
 
-static int erofs_mkfs_go(struct erofs_importer *im,
+static int erofs_mkfs_go(const struct erofs_mkfs_btctx *ctx,
 			 enum erofs_mkfs_jobtype type, void *elem, int size)
 {
-	struct erofs_mkfs_dfops *q = im->sbi->mkfs_dfops;
+	struct erofs_mkfs_dfops *q = ctx->im->sbi->mkfs_dfops;
 	struct erofs_mkfs_jobitem *item;
 
 	pthread_mutex_lock(&q->lock);
@@ -1649,14 +1654,14 @@ static int erofs_mkfs_go(struct erofs_importer *im,
 	return 0;
 }
 #else
-static int erofs_mkfs_go(struct erofs_importer *im,
+static int erofs_mkfs_go(const struct erofs_mkfs_btctx *ctx,
 			 enum erofs_mkfs_jobtype type, void *elem, int size)
 {
 	struct erofs_mkfs_jobitem item;
 
 	item.type = type;
 	memcpy(&item.u, elem, size);
-	return erofs_mkfs_jobfn(im, &item);
+	return erofs_mkfs_jobfn(ctx, &item);
 }
 static void erofs_mkfs_flushjobs(struct erofs_sb_info *sbi)
 {
@@ -1686,7 +1691,7 @@ int erofs_mkfs_push_pending_job(struct list_head *pending,
 	return 0;
 }
 
-int erofs_mkfs_flush_pending_jobs(struct erofs_importer *im,
+int erofs_mkfs_flush_pending_jobs(const struct erofs_mkfs_btctx *ctx,
 				  struct list_head *q)
 {
 	struct erofs_mkfs_pending_jobitem *pji, *n;
@@ -1696,7 +1701,7 @@ int erofs_mkfs_flush_pending_jobs(struct erofs_importer *im,
 	list_for_each_entry_safe(pji, n, q, list) {
 		list_del(&pji->list);
 
-		err2 = erofs_mkfs_go(im, pji->item.type, &pji->item.u,
+		err2 = erofs_mkfs_go(ctx, pji->item.type, &pji->item.u,
 				     pji->item._usize);
 		free(pji);
 		if (!err)
@@ -1809,11 +1814,10 @@ static void erofs_dentry_kill(struct erofs_dentry *d)
 	free(d);
 }
 
-static int erofs_prepare_dir_inode(struct erofs_importer *im,
-				   struct erofs_inode *dir,
-				   bool rebuild,
-				   bool incremental)
+static int erofs_prepare_dir_inode(const struct erofs_mkfs_btctx *ctx,
+				   struct erofs_inode *dir)
 {
+	struct erofs_importer *im = ctx->im;
 	struct erofs_sb_info *sbi = im->sbi;
 	struct erofs_dentry *d, *n;
 	unsigned int i_nlink;
@@ -1833,14 +1837,14 @@ static int erofs_prepare_dir_inode(struct erofs_importer *im,
 		++nr_subdirs;
 	}
 
-	if (!rebuild) {
+	if (!ctx->rebuild) {
 		ret = erofs_mkfs_import_localdir(im, dir,
 						 &nr_subdirs, &i_nlink);
 		if (ret)
 			return ret;
 	}
 
-	if (incremental && dir->dev == sbi->dev && !dir->opaque) {
+	if (ctx->incremental && dir->dev == sbi->dev && !dir->opaque) {
 		ret = erofs_rebuild_load_basedir(dir, &nr_subdirs, &i_nlink);
 		if (ret)
 			return ret;
@@ -1861,7 +1865,7 @@ static int erofs_prepare_dir_inode(struct erofs_importer *im,
 	if (ret)
 		return ret;
 
-	if (IS_ROOT(dir) && incremental && !erofs_sb_has_48bit(sbi))
+	if (IS_ROOT(dir) && ctx->incremental && !erofs_sb_has_48bit(sbi))
 		dir->datalayout = EROFS_INODE_FLAT_PLAIN;
 
 	dir->i_nlink = i_nlink;
@@ -1879,9 +1883,10 @@ static int erofs_prepare_dir_inode(struct erofs_importer *im,
 	return 0;
 }
 
-static int erofs_mkfs_begin_nondirectory(struct erofs_importer *im,
+static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
 					 struct erofs_inode *inode)
 {
+	struct erofs_importer *im = btctx->im;
 	struct erofs_mkfs_job_ndir_ctx ctx =
 		{ .inode = inode, .fd = -1 };
 	int ret;
@@ -1913,14 +1918,14 @@ static int erofs_mkfs_begin_nondirectory(struct erofs_importer *im,
 				return ret;
 		}
 	}
-	return erofs_mkfs_go(im, EROFS_MKFS_JOB_NDIR, &ctx, sizeof(ctx));
+	return erofs_mkfs_go(btctx, EROFS_MKFS_JOB_NDIR, &ctx, sizeof(ctx));
 }
 
-static int erofs_mkfs_handle_inode(struct erofs_importer *im,
-				   struct erofs_inode *inode,
-				   bool rebuild, bool incremental)
+static int erofs_mkfs_handle_inode(const struct erofs_mkfs_btctx *ctx,
+				   struct erofs_inode *inode)
 {
 	const char *relpath = erofs_fspath(inode->i_srcpath);
+	struct erofs_importer *im = ctx->im;
 	const struct erofs_importer_params *params = im->params;
 	char *trimmed;
 	int ret;
@@ -1942,12 +1947,12 @@ static int erofs_mkfs_handle_inode(struct erofs_importer *im,
 	}
 
 	if (S_ISDIR(inode->i_mode)) {
-		ret = erofs_prepare_dir_inode(im, inode, rebuild, incremental);
+		ret = erofs_prepare_dir_inode(ctx, inode);
 		if (ret < 0)
 			return ret;
 	}
 
-	if (!rebuild && !params->no_xattrs) {
+	if (!ctx->rebuild && !params->no_xattrs) {
 		ret = erofs_scan_file_xattrs(inode);
 		if (ret < 0)
 			return ret;
@@ -1959,14 +1964,14 @@ static int erofs_mkfs_handle_inode(struct erofs_importer *im,
 	else if (inode->whiteouts)
 		erofs_set_origin_xattr(inode);
 
-	ret = erofs_prepare_xattr_ibody(inode, incremental && IS_ROOT(inode));
+	ret = erofs_prepare_xattr_ibody(inode, ctx->incremental && IS_ROOT(inode));
 	if (ret < 0)
 		return ret;
 
 	if (!S_ISDIR(inode->i_mode)) {
-		ret = erofs_mkfs_begin_nondirectory(im, inode);
+		ret = erofs_mkfs_begin_nondirectory(ctx, inode);
 	} else {
-		ret = erofs_mkfs_go(im, EROFS_MKFS_JOB_DIR, &inode,
+		ret = erofs_mkfs_go(ctx, EROFS_MKFS_JOB_DIR, &inode,
 				    sizeof(inode));
 	}
 	erofs_info("file %s dumped (mode %05o)", *relpath ? relpath : "/",
@@ -1985,9 +1990,9 @@ static void erofs_mark_parent_inode(struct erofs_inode *inode,
 	inode->i_parent = (void *)((unsigned long)dir | 1);
 }
 
-static int erofs_mkfs_dump_tree(struct erofs_importer *im, bool rebuild,
-				bool incremental)
+static int erofs_mkfs_dump_tree(const struct erofs_mkfs_btctx *ctx)
 {
+	struct erofs_importer *im = ctx->im;
 	struct erofs_inode *root = im->root;
 	struct erofs_sb_info *sbi = root->sbi;
 	struct erofs_inode *dumpdir = erofs_igrab(root);
@@ -1998,7 +2003,7 @@ static int erofs_mkfs_dump_tree(struct erofs_importer *im, bool rebuild,
 	erofs_mark_parent_inode(root, root);	/* rootdir mark */
 	root->next_dirwrite = NULL;
 	/* update dev/i_ino[1] to keep track of the base image */
-	if (incremental) {
+	if (ctx->incremental) {
 		root->dev = root->sbi->dev;
 		root->i_ino[1] = sbi->root_nid;
 		erofs_remove_ihash(root);
@@ -2013,12 +2018,12 @@ static int erofs_mkfs_dump_tree(struct erofs_importer *im, bool rebuild,
 		root->xattr_isize = cfg.c_root_xattr_isize;
 	}
 
-	err = erofs_mkfs_handle_inode(im, root, rebuild, incremental);
+	err = erofs_mkfs_handle_inode(ctx, root);
 	if (err)
 		return err;
 
 	/* assign root NID immediately for non-incremental builds */
-	if (!incremental) {
+	if (!ctx->incremental) {
 		erofs_mkfs_flushjobs(sbi);
 		erofs_fixup_meta_blkaddr(root);
 		sbi->root_nid = root->nid;
@@ -2039,13 +2044,12 @@ static int erofs_mkfs_dump_tree(struct erofs_importer *im, bool rebuild,
 				continue;
 
 			if (!erofs_inode_visited(inode)) {
-				DBG_BUGON(rebuild && (inode->i_nlink == 1 ||
+				DBG_BUGON(ctx->rebuild && (inode->i_nlink == 1 ||
 					  S_ISDIR(inode->i_mode)) &&
 					  erofs_parent_inode(inode) != dir);
 				erofs_mark_parent_inode(inode, dir);
 
-				err = erofs_mkfs_handle_inode(im, inode,
-							rebuild, incremental);
+				err = erofs_mkfs_handle_inode(ctx, inode);
 				if (err)
 					break;
 				if (S_ISDIR(inode->i_mode)) {
@@ -2053,7 +2057,7 @@ static int erofs_mkfs_dump_tree(struct erofs_importer *im, bool rebuild,
 					last = &inode->next_dirwrite;
 					(void)erofs_igrab(inode);
 				}
-			} else if (!rebuild) {
+			} else if (!ctx->rebuild) {
 				++inode->i_nlink;
 			}
 		}
@@ -2062,7 +2066,7 @@ static int erofs_mkfs_dump_tree(struct erofs_importer *im, bool rebuild,
 		err2 = grouped_dirdata ?
 			erofs_mkfs_push_pending_job(&pending_dirs,
 				EROFS_MKFS_JOB_DIR_BH, &dir, sizeof(dir)) :
-			erofs_mkfs_go(im, EROFS_MKFS_JOB_DIR_BH,
+			erofs_mkfs_go(ctx, EROFS_MKFS_JOB_DIR_BH,
 				      &dir, sizeof(dir));
 		if (err || err2) {
 			if (!err)
@@ -2070,7 +2074,7 @@ static int erofs_mkfs_dump_tree(struct erofs_importer *im, bool rebuild,
 			break;
 		}
 	} while (dumpdir);
-	err2 = erofs_mkfs_flush_pending_jobs(im, &pending_dirs);
+	err2 = erofs_mkfs_flush_pending_jobs(ctx, &pending_dirs);
 	return err ? err : err2;
 }
 
@@ -2082,7 +2086,7 @@ struct erofs_mkfs_buildtree_ctx {
 #define __erofs_mkfs_build_tree erofs_mkfs_build_tree
 #endif
 
-static int __erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
+static int __erofs_mkfs_build_tree(const struct erofs_mkfs_btctx *ctx)
 {
 	struct erofs_importer *im = ctx->im;
 
@@ -2099,7 +2103,7 @@ static int __erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 		if (err)
 			return err;
 	}
-	return erofs_mkfs_dump_tree(im, ctx->rebuild, ctx->incremental);
+	return erofs_mkfs_dump_tree(ctx);
 }
 
 #ifdef EROFS_MT_ENABLED
@@ -2125,7 +2129,7 @@ static int erofs_get_fdlimit(void)
 #endif
 }
 
-static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
+static int erofs_mkfs_build_tree(struct erofs_mkfs_btctx *ctx)
 {
 	struct erofs_importer *im = ctx->im;
 	struct erofs_importer_params *params = im->params;
@@ -2162,12 +2166,12 @@ static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 
 	sbi->mkfs_dfops = q;
 	err = pthread_create(&sbi->dfops_worker, NULL,
-			     z_erofs_mt_dfops_worker, im);
+			     z_erofs_mt_dfops_worker, ctx);
 	if (err)
 		goto fail;
 
 	err = __erofs_mkfs_build_tree(ctx);
-	erofs_mkfs_go(im, ~0, NULL, 0);
+	erofs_mkfs_go(ctx, ~0, NULL, 0);
 	err2 = pthread_join(sbi->dfops_worker, &retval);
 	DBG_BUGON(!q->exited);
 	if (!err || err == -ECHILD) {
@@ -2195,7 +2199,7 @@ int erofs_importer_load_tree(struct erofs_importer *im, bool rebuild,
 		return -EOPNOTSUPP;
 	}
 
-	return erofs_mkfs_build_tree(&((struct erofs_mkfs_buildtree_ctx) {
+	return erofs_mkfs_build_tree(&((struct erofs_mkfs_btctx) {
 		.im = im,
 		.rebuild = rebuild,
 		.incremental = incremental,
-- 
2.43.5


