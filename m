Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8006D9DA4C1
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Nov 2024 10:29:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XyvK02Vbsz2ysd
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Nov 2024 20:29:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732699746;
	cv=none; b=WMGaAXG3ylL3tziX7E7KIV3Emz77PoLwEVEEgCF+++6FCITxpyuPuY0EP9e1RzgsNZYP5YsZbwmRX796/vhvVcLcCvoqMzsoXazZzQg6iCvvI8TesPVnAY4WrHlI3lci4QkTnQO+yV6GMkBtiiYTLVMvJeeQ1oSAaMKUS3JuKBK2Asobg0rhurbBghpWXGhgODlKocUiVvWo07c9Va/+0SxkJ/ycOIYz6GxvOn0HV5UISMcK0d1H4rc3lkduGiRVibMwXFjcp2i25hu4H+HbIse3204baZ+tTAjydZoSWwiuBcTNOffJwExMewgC7ndxcllhQ5tC+F6bXQ9TZe7ikA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732699746; c=relaxed/relaxed;
	bh=zJnFZawhpcZnJMqZNkDFsZjCF8wXRQQR4Uv8vJTDHk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d0szEfruJzdVDgsMKRBM3wXXiF8NB2P0eWn5Tik7ywULcEq440SX/lf22O4v8ZQUxATOl2UiyjfGgpIwnp2XX8aUMUE2EoMXT5arBG4OdtB0eu6MMwGz56ZJsPiD9b7RLYavC8jAMYwaA7ouKd7Z3OBWh3WPYzRaGA4gkchgNnzyqC3pwQQ76lDqmr4C5csy8q+o7tU4+TA1bS7F9jgKh0kyNwTkrLkRKNO13lIFnp2YeEoK+Nvmb80S2dfq9v1DCr0QqK6yOn+9bDDlPI5g3nxMgVCmMFcx7UqcXE/k37di2x3usBg2pamG2xLer1atNU3jDIvdVUoBOmSAfkDrCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bEL888uz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bEL888uz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XyvJx2XXjz2xjd
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 Nov 2024 20:29:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732699741; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zJnFZawhpcZnJMqZNkDFsZjCF8wXRQQR4Uv8vJTDHk0=;
	b=bEL888uzzYeLlwxgQd6rvwYebBEFY/xFNwHV0/rxlzA8krJAC6S4ZJTHhB3EWbKROHm+med70G5V2xLgUbC/yQWTflSe5mka8QZubkraBt5P+DzYVoppRvsjso2jIYQOJGxN/vG+yC02u8DNwpprYz5syDe/ZYmMUnDnV1W+dj0=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WKM0rJg_1732699738 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Nov 2024 17:28:59 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: introduce `struct erofs_rebuild_getdentry_ctx`
Date: Wed, 27 Nov 2024 17:28:55 +0800
Message-ID: <20241127092856.4106149-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

There are so many parameters in erofs_rebuild_get_dentry(), let's
wrap these parameters into `struct erofs_rebuild_getdentry_ctx`.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 include/erofs/rebuild.h | 12 +++++++--
 lib/rebuild.c           | 59 ++++++++++++++++++++++++-----------------
 lib/tar.c               | 17 +++++++++---
 3 files changed, 59 insertions(+), 29 deletions(-)

diff --git a/include/erofs/rebuild.h b/include/erofs/rebuild.h
index 59b2f6f57005..b37bc80e8a3c 100644
--- a/include/erofs/rebuild.h
+++ b/include/erofs/rebuild.h
@@ -15,8 +15,16 @@ enum erofs_rebuild_datamode {
 	EROFS_REBUILD_DATA_FULL,
 };
 
-struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
-		char *path, bool aufs, bool *whout, bool *opq, bool to_head);
+struct erofs_rebuild_getdentry_ctx {
+	struct erofs_inode *pwd;
+	char *path;
+	bool aufs;
+	bool *whout;
+	bool *opq;
+	bool to_head;
+};
+
+struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_rebuild_getdentry_ctx *ctx);
 
 int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
 			    enum erofs_rebuild_datamode mode);
diff --git a/lib/rebuild.c b/lib/rebuild.c
index b37823e48858..58f1701b3721 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -16,6 +16,7 @@
 #include "erofs/blobchunk.h"
 #include "erofs/internal.h"
 #include "liberofs_uuid.h"
+#include "erofs/rebuild.h"
 
 #ifdef HAVE_LINUX_AUFS_TYPE_H
 #include <linux/aufs_type.h>
@@ -58,18 +59,17 @@ static struct erofs_dentry *erofs_rebuild_mkdir(struct erofs_inode *dir,
 	return d;
 }
 
-struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
-		char *path, bool aufs, bool *whout, bool *opq, bool to_head)
+struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_rebuild_getdentry_ctx *ctx)
 {
 	struct erofs_dentry *d = NULL;
-	unsigned int len = strlen(path);
-	char *s = path;
+	unsigned int len = strlen(ctx->path);
+	char *s = ctx->path;
 
-	*whout = false;
-	*opq = false;
+	*ctx->whout = false;
+	*ctx->opq = false;
 
-	while (s < path + len) {
-		char *slash = memchr(s, '/', path + len - s);
+	while (s < ctx->path + len) {
+		char *slash = memchr(s, '/', ctx->path + len - s);
 
 		if (slash) {
 			if (s == slash) {
@@ -82,22 +82,22 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 		if (!memcmp(s, ".", 2)) {
 			/* null */
 		} else if (!memcmp(s, "..", 3)) {
-			pwd = pwd->i_parent;
+			ctx->pwd = ctx->pwd->i_parent;
 		} else {
 			struct erofs_inode *inode = NULL;
 
-			if (aufs && !slash) {
+			if (ctx->aufs && !slash) {
 				if (!memcmp(s, AUFS_WH_DIROPQ, sizeof(AUFS_WH_DIROPQ))) {
-					*opq = true;
+					*ctx->opq = true;
 					break;
 				}
 				if (!memcmp(s, AUFS_WH_PFX, sizeof(AUFS_WH_PFX) - 1)) {
 					s += sizeof(AUFS_WH_PFX) - 1;
-					*whout = true;
+					*ctx->whout = true;
 				}
 			}
 
-			list_for_each_entry(d, &pwd->i_subdirs, d_child) {
+			list_for_each_entry(d, &ctx->pwd->i_subdirs, d_child) {
 				if (!strcmp(d->name, s)) {
 					if (d->type != EROFS_FT_DIR && slash)
 						return ERR_PTR(-EIO);
@@ -107,22 +107,22 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 			}
 
 			if (inode) {
-				if (to_head) {
+				if (ctx->to_head) {
 					list_del(&d->d_child);
-					list_add(&d->d_child, &pwd->i_subdirs);
+					list_add(&d->d_child, &ctx->pwd->i_subdirs);
 				}
-				pwd = inode;
+				ctx->pwd = inode;
 			} else if (!slash) {
-				d = erofs_d_alloc(pwd, s);
+				d = erofs_d_alloc(ctx->pwd, s);
 				if (IS_ERR(d))
 					return d;
 				d->type = EROFS_FT_UNKNOWN;
-				d->inode = pwd;
+				d->inode = ctx->pwd;
 			} else {
-				d = erofs_rebuild_mkdir(pwd, s);
+				d = erofs_rebuild_mkdir(ctx->pwd, s);
 				if (IS_ERR(d))
 					return d;
-				pwd = d->inode;
+				ctx->pwd = d->inode;
 			}
 		}
 		if (slash) {
@@ -267,6 +267,7 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 {
 	struct erofs_rebuild_dir_context *rctx = (void *)ctx;
 	struct erofs_inode *mergedir = rctx->mergedir;
+	struct erofs_rebuild_getdentry_ctx dctx;
 	struct erofs_inode *dir = ctx->dir;
 	struct erofs_inode *inode, *candidate;
 	struct erofs_inode src;
@@ -286,8 +287,12 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 	erofs_dbg("parsing %s", path);
 	dname = path + strlen(mergedir->i_srcpath) + 1;
 
-	d = erofs_rebuild_get_dentry(mergedir, dname, false,
-				     &dumb, &dumb, false);
+	dctx.pwd = mergedir;
+	dctx.path = dname;
+	dctx.aufs = false;
+	dctx.whout = dctx.opq = &dumb;
+	dctx.to_head = false;
+	d = erofs_rebuild_get_dentry(&dctx);
 	if (IS_ERR(d)) {
 		ret = PTR_ERR(d);
 		goto out;
@@ -435,6 +440,7 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
 static int erofs_rebuild_basedir_dirent_iter(struct erofs_dir_context *ctx)
 {
 	struct erofs_rebuild_dir_context *rctx = (void *)ctx;
+	struct erofs_rebuild_getdentry_ctx dctx;
 	struct erofs_inode *dir = ctx->dir;
 	struct erofs_inode *mergedir = rctx->mergedir;
 	struct erofs_dentry *d;
@@ -448,8 +454,13 @@ static int erofs_rebuild_basedir_dirent_iter(struct erofs_dir_context *ctx)
 	dname = strndup(ctx->dname, ctx->de_namelen);
 	if (!dname)
 		return -ENOMEM;
-	d = erofs_rebuild_get_dentry(mergedir, dname, false,
-				     &dumb, &dumb, false);
+
+	dctx.pwd = mergedir;
+	dctx.path = dname;
+	dctx.aufs = false;
+	dctx.whout = dctx.opq = &dumb;
+	dctx.to_head = false;
+	d = erofs_rebuild_get_dentry(&dctx);
 	if (IS_ERR(d)) {
 		ret = PTR_ERR(d);
 		goto out;
diff --git a/lib/tar.c b/lib/tar.c
index 990c6cb1b372..60f12cc539c9 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -657,6 +657,7 @@ int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar)
 	char path[PATH_MAX];
 	struct erofs_pax_header eh = tar->global;
 	struct erofs_sb_info *sbi = root->sbi;
+	struct erofs_rebuild_getdentry_ctx dctx;
 	bool whout, opq, e = false;
 	struct stat st;
 	erofs_off_t tar_offset, dataoff;
@@ -907,7 +908,13 @@ out_eot:
 
 	erofs_dbg("parsing %s (mode %05o)", eh.path, st.st_mode);
 
-	d = erofs_rebuild_get_dentry(root, eh.path, tar->aufs, &whout, &opq, true);
+	dctx.pwd = root;
+	dctx.path = eh.path;
+	dctx.aufs = tar->aufs;
+	dctx.whout = &whout;
+	dctx.opq = &opq;
+	dctx.to_head = true;
+	d = erofs_rebuild_get_dentry(&dctx);
 	if (IS_ERR(d)) {
 		ret = PTR_ERR(d);
 		goto out;
@@ -945,8 +952,12 @@ out_eot:
 		}
 		d->inode = NULL;
 
-		d2 = erofs_rebuild_get_dentry(root, eh.link, tar->aufs,
-					      &dumb, &dumb, false);
+		dctx.pwd = root;
+		dctx.path = eh.link;
+		dctx.aufs = tar->aufs;
+		dctx.whout = dctx.opq = &dumb;
+		dctx.to_head = false;
+		d2 = erofs_rebuild_get_dentry(&dctx);
 		if (IS_ERR(d2)) {
 			ret = PTR_ERR(d2);
 			goto out;
-- 
2.43.5

