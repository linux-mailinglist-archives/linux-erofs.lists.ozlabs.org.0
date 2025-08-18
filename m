Return-Path: <linux-erofs+bounces-823-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC19B2AB64
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Aug 2025 16:47:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c5Fv02bzcz3cZy;
	Tue, 19 Aug 2025 00:47:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755528476;
	cv=none; b=jF0Qpj+VMQ0pxU6pYLtNbGnUGdS/dKdP0VH0867DcCc0vCf3Npm+DCyDrKJ5x9Zu94ZSHVa4kh0QQ9X7M3B17Ef7oNE4BIxI8vC6967uucS0yFnbWnFhvoydNouKEtl8V5FIOYcRTPa/V3DeFjQ8zCyw7gTycyefgJRlnGna27FQNdIn/8hTO4c1nr58hgb3pzXB0n2vLmtJ9Jis8qknjii6yZGbFZ+knfExkzEC5+6pckMUaCoNC3Z5qQr94nAmWgqHfHRDKIsy7yIeQW/BqxcjyAM9WHuCWN4reeF2six2kxirrQ1CBg8LM7Z4Bf/OV6WMHdJ6Lq00TX3RezUmJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755528476; c=relaxed/relaxed;
	bh=cI/crzWpLkoo+5fKuz88P117NwtHOOIqR0EvsIso42M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btBfbUWPtLg7lnT78ghvr1zXhWgiEigTMa7CTdyP/agVWxHgB0eXH6yeqeyQLWoQ7gwnpksf1vM1o2X5QFUITviRmWqRY3w9U52sp5Yl3aRB3sHgE1oOTimHu5vgmkExPTcv/3GafpHXUeud9wR+xV0dKYDyH9vhkkbeYlczZXSK8zxOSvaxi4AvOOUzAlGkcvNVLoaLECuf0Vd6RfqryqsLoz/5dj/MaTBM3t8ZMKbv3O8Bi6GRgcFUJo7vMIImXepLHWCiVcye+eVoodwCz+jbv9rL/olz3tP1LcKqFbMiIOvzB9UOTsDiy3h8OtKrcJ25aa0Pe33GKW6L4Ri51w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=S1gYVbnn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=S1gYVbnn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c5Fty334nz3cZn
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Aug 2025 00:47:53 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755528470; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cI/crzWpLkoo+5fKuz88P117NwtHOOIqR0EvsIso42M=;
	b=S1gYVbnn2hJmzH+OmYc8hJUgPXmvuCTs7e4eIUbXWvo5cSsOEfA5o5veOxNOXZBiYGUtCjaes4nMCGLacGGQLX6gGHYZCT0cAQsSELIkLU/a6JGzksYSTRozVG9Pbn8tHqVPlkyb16Rida86KK0fwz+zRFSKCocgGByO4a/Chx0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wm0YYdb_1755528468 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 Aug 2025 22:47:49 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/7] erofs-utils: lib: adapt importer for filesystem tree dumping
Date: Mon, 18 Aug 2025 22:47:37 +0800
Message-ID: <20250818144741.2586329-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250818144741.2586329-1-hsiangkao@linux.alibaba.com>
References: <20250818144741.2586329-1-hsiangkao@linux.alibaba.com>
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

Convert erofs_mkfs_build_tree_from_path() and erofs_rebuild_dump_tree()
to erofs_importer_load_tree().

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/importer.h |  2 ++
 include/erofs/inode.h    |  7 ++--
 lib/inode.c              | 76 ++++++++++++++--------------------------
 mkfs/main.c              | 16 +++++----
 4 files changed, 43 insertions(+), 58 deletions(-)

diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index 7c29e03..541a86d 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -13,11 +13,13 @@ extern "C"
 #include "internal.h"
 
 struct erofs_importer_params {
+	char *source;
 };
 
 struct erofs_importer {
 	struct erofs_importer_params *params;
 	struct erofs_sb_info *sbi;
+	struct erofs_inode *root;
 };
 
 void erofs_importer_preset(struct erofs_importer_params *params);
diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index ce86f59..9d05aaa 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -23,6 +23,8 @@ static inline struct erofs_inode *erofs_igrab(struct erofs_inode *inode)
 	return inode;
 }
 
+struct erofs_importer;
+
 u32 erofs_new_encode_dev(dev_t dev);
 unsigned char erofs_mode_to_ftype(umode_t mode);
 umode_t erofs_ftype_to_mode(unsigned int ftype, unsigned int perm);
@@ -38,12 +40,11 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 				   const char *name);
 int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks);
 bool erofs_dentry_is_wht(struct erofs_sb_info *sbi, struct erofs_dentry *d);
-int erofs_rebuild_dump_tree(struct erofs_inode *dir, bool incremental);
 int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 		       const char *path);
 struct erofs_inode *erofs_new_inode(struct erofs_sb_info *sbi);
-struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_sb_info *sbi,
-						    const char *path);
+int erofs_importer_load_tree(struct erofs_importer *im, bool rebuild,
+			     bool incremental);
 struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
 						     int fd, const char *name);
 int erofs_fixup_root_inode(struct erofs_inode *root);
diff --git a/lib/inode.c b/lib/inode.c
index 3d64dcb..2599772 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -27,6 +27,7 @@
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
 #include "erofs/fragments.h"
+#include "erofs/importer.h"
 #include "liberofs_private.h"
 #include "liberofs_metabox.h"
 
@@ -1275,9 +1276,8 @@ struct erofs_inode *erofs_new_inode(struct erofs_sb_info *sbi)
 	return inode;
 }
 
-/* get the inode from the source path */
-static struct erofs_inode *erofs_iget_from_srcpath(struct erofs_sb_info *sbi,
-						   const char *path)
+static struct erofs_inode *erofs_iget_from_local(struct erofs_sb_info *sbi,
+						 const char *path)
 {
 	struct stat st;
 	struct erofs_inode *inode;
@@ -1644,7 +1644,7 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
 		if (ret < 0 || ret >= PATH_MAX)
 			goto err_closedir;
 
-		inode = erofs_iget_from_srcpath(sbi, buf);
+		inode = erofs_iget_from_local(sbi, buf);
 		if (IS_ERR(inode)) {
 			ret = PTR_ERR(inode);
 			goto err_closedir;
@@ -1880,9 +1880,10 @@ static void erofs_mark_parent_inode(struct erofs_inode *inode,
 	inode->i_parent = (void *)((unsigned long)dir | 1);
 }
 
-static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
+static int erofs_mkfs_dump_tree(struct erofs_importer *im, bool rebuild,
 				bool incremental)
 {
+	struct erofs_inode *root = im->root;
 	struct erofs_sb_info *sbi = root->sbi;
 	struct erofs_inode *dumpdir = erofs_igrab(root);
 	int err, err2;
@@ -1964,12 +1965,8 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
 }
 
 struct erofs_mkfs_buildtree_ctx {
-	struct erofs_sb_info *sbi;
-	union {
-		const char *path;
-		struct erofs_inode *root;
-	} u;
-	bool incremental;
+	struct erofs_importer *im;
+	bool rebuild, incremental;
 };
 #ifndef EROFS_MT_ENABLED
 #define __erofs_mkfs_build_tree erofs_mkfs_build_tree
@@ -1977,26 +1974,22 @@ struct erofs_mkfs_buildtree_ctx {
 
 static int __erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 {
-	bool from_path = !!ctx->sbi;
-	struct erofs_inode *root;
-	int err;
+	struct erofs_importer *im = ctx->im;
 
-	if (from_path) {
-		root = erofs_iget_from_srcpath(ctx->sbi, ctx->u.path);
-		if (IS_ERR(root))
-			return PTR_ERR(root);
-	} else {
-		root = ctx->u.root;
-	}
+	if (!ctx->rebuild) {
+		struct erofs_importer_params *params = im->params;
+		struct stat st;
+		int err;
 
-	err = erofs_mkfs_dump_tree(root, !from_path, ctx->incremental);
-	if (err) {
-		if (from_path)
-			erofs_iput(root);
-		return err;
+		err = lstat(params->source, &st);
+		if (err)
+			return -errno;
+
+		err = erofs_fill_inode(im->root, &st, params->source);
+		if (err)
+			return err;
 	}
-	ctx->u.root = root;
-	return 0;
+	return erofs_mkfs_dump_tree(im, ctx->rebuild, ctx->incremental);
 }
 
 #ifdef EROFS_MT_ENABLED
@@ -2024,7 +2017,8 @@ static int erofs_get_fdlimit(void)
 
 static int erofs_mkfs_build_tree(struct erofs_mkfs_buildtree_ctx *ctx)
 {
-	struct erofs_sb_info *sbi = ctx->sbi ? ctx->sbi : ctx->u.root->sbi;
+	struct erofs_importer *im = ctx->im;
+	struct erofs_sb_info *sbi = im->sbi;
 	struct erofs_mkfs_dfops *q;
 	int err, err2;
 	void *retval;
@@ -2078,28 +2072,12 @@ fail:
 }
 #endif
 
-struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_sb_info *sbi,
-						    const char *path)
-{
-	struct erofs_mkfs_buildtree_ctx ctx = {
-		.sbi = sbi,
-		.u.path = path,
-	};
-	int err;
-
-	if (!sbi)
-		return ERR_PTR(-EINVAL);
-	err = erofs_mkfs_build_tree(&ctx);
-	if (err)
-		return ERR_PTR(err);
-	return ctx.u.root;
-}
-
-int erofs_rebuild_dump_tree(struct erofs_inode *root, bool incremental)
+int erofs_importer_load_tree(struct erofs_importer *im, bool rebuild,
+			     bool incremental)
 {
 	return erofs_mkfs_build_tree(&((struct erofs_mkfs_buildtree_ctx) {
-		.sbi = NULL,
-		.u.root = root,
+		.im = im,
+		.rebuild = rebuild,
 		.incremental = incremental,
 	}));
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index 8b18b35..9039710 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1542,6 +1542,7 @@ int main(int argc, char **argv)
 #endif
 	erofs_show_config();
 
+	importer_params.source = cfg.c_src_path;
 	err = erofs_importer_init(&importer);
 	if (err)
 		goto exit;
@@ -1694,12 +1695,12 @@ int main(int argc, char **argv)
 		if (cfg.c_extra_ea_name_prefixes)
 			erofs_xattr_flush_name_prefixes(&g_sbi);
 
-		root = erofs_mkfs_build_tree_from_path(&g_sbi, cfg.c_src_path);
+		root = erofs_new_inode(&g_sbi);
 		if (IS_ERR(root)) {
 			err = PTR_ERR(root);
-			root = NULL;
 			goto exit;
 		}
+		incremental_mode = false;
 	} else {
 		root = erofs_rebuild_make_root(&g_sbi);
 		if (IS_ERR(root)) {
@@ -1740,12 +1741,15 @@ int main(int argc, char **argv)
 				goto exit;
 #endif
 		}
-
-		err = erofs_rebuild_dump_tree(root, incremental_mode);
-		if (err)
-			goto exit;
 	}
 
+	importer.root = root;
+	err = erofs_importer_load_tree(&importer,
+				       source_mode != EROFS_MKFS_SOURCE_LOCALDIR,
+				       incremental_mode);
+	if (err)
+		goto exit;
+
 	if (tar_index_512b) {
 		if (!g_sbi.extra_devices) {
 			DBG_BUGON(1);
-- 
2.43.5


