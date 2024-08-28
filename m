Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A659625DB
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 13:20:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wv25C6WvPz30RK
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 21:20:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724844010;
	cv=none; b=km7xrMwhUuYS5hjVoFKlgdbIm+jsbxowH6bJl37PEdNWMJtrdqCNStkioiNayTm5Uf5FOA/efnLQES9tROi25rUT4JcjE2LcVoGcdpCjuTz1y5je+2XxSpfQW7qXzGVjocXS2nGhdRfP3dK9KuyKRSmjsphkfdb8gBjdnqndFFZ5HOhB4kA98ZaieggZV1iLSaw7xoPmTtoELFWsksRDqX5ZCKcLnKY8d7GrjPbfrd64YzYcZFvy8A5v+wz/AzBE06KVAv797TGO1RcUA2iGOIAV7N1W93W0RDcDwzdCKc16nEBs18uWofdacX0YzkHichBcm5Q1tfGjyn79KXWXQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724844010; c=relaxed/relaxed;
	bh=9t26X20wOk6RC/v/5buWxmWBy5+YEGCpdhBhX53OLoo=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=Pomx978I0aHML+uYGvA3n4WvpF+2+f5MhELjk2zObXa1xEA8h1TAufBvrreqlij6ZOJ/MJEvtDj3c4/ct5sCq8i0Byn+mUgc/ZtYaCONeRbtsr+JRBjf5S83HdU/YIdAGBrk/gjbBV7bWuNqWpwp9u3qnMWOraPNsqNq00mweS6mEMtRbdkDpfcrN6fTHqdi3zWqdChtMbo4L/+RwK3FciRSWfvGD/D5pCFGfrsciWLrISoeOHF1r+M5RwqEIrs8wT7To3tAfwCjl8VX6wfIW8In7GXLYakZHq8nzUHUJ8LQLl0VTspRHZloOW4lcWxPe0zyCQ25/v1dLoDKL/LnhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wstjfw6T; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wstjfw6T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wv2561gqMz2xy3
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 21:20:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724844006; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9t26X20wOk6RC/v/5buWxmWBy5+YEGCpdhBhX53OLoo=;
	b=wstjfw6TvPHsYeX1Uz69gPMf1pSogUsRkCsYRb/xJ7UzKleuG/srJJCAmsmfKoSLDpJVdiHVRfJKSZ2daVX6W8dDuTF4cya+cD6pRFFrsSQPInR62Z7rhwopjjTs5JToFuaNriaWQUpZP1M644zeBY02vVasZ7WZmFcM/ONzL3o=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WDpbUPx_1724844004)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 19:20:05 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	lihongbo22@huawei.com
Subject: [PATCH RFC v3 3/3] erofs: apply the page cache share feature
Date: Wed, 28 Aug 2024 19:19:59 +0800
Message-ID: <20240828111959.3677011-4-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240828111959.3677011-1-hongzhen@linux.alibaba.com>
References: <20240828111959.3677011-1-hongzhen@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This modifies relevant functions to apply the page cache
share feature.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v3: Reimplement and add support for compressed files.
v2: https://lore.kernel.org/all/20240731080704.678259-3-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240722065355.1396365-5-hongzhen@linux.alibaba.com/
---
 fs/erofs/data.c  | 34 +++++++++++++++++++++++++++++++++-
 fs/erofs/inode.c | 12 ++++++++++++
 fs/erofs/super.c | 29 +++++++++++++++++++++++++++++
 fs/erofs/zdata.c | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 1b7eba38ba1e..ef27b934115f 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -347,12 +347,44 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	struct erofs_inode *vi = NULL;
+	int ret;
+
+	if (file && file->private_data) {
+		vi = file->private_data;
+		if (vi->ano_inode == file_inode(file))
+			folio->mapping->host = &vi->vfs_inode;
+		else
+			vi = NULL;
+	}
+	ret = iomap_read_folio(folio, &erofs_iomap_ops);
+	if (vi)
+		folio->mapping->host = file_inode(file);
+	return ret;
+#else
 	return iomap_read_folio(folio, &erofs_iomap_ops);
+#endif
 }
-
 static void erofs_readahead(struct readahead_control *rac)
 {
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	struct erofs_inode *vi = NULL;
+	struct file *file = rac->file;
+
+	if (file && file->private_data) {
+		vi = file->private_data;
+		if (vi->ano_inode == file_inode(file))
+			rac->mapping->host = &vi->vfs_inode;
+		else
+			vi = NULL;
+	}
+	iomap_readahead(rac, &erofs_iomap_ops);
+	if (vi)
+		rac->mapping->host = file_inode(file);
+#else
 	return iomap_readahead(rac, &erofs_iomap_ops);
+#endif
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 43c09aae2afc..1811f73478b4 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "xattr.h"
+#include "pagecache_share.h"
 
 #include <trace/events/erofs.h>
 
@@ -229,10 +230,21 @@ static int erofs_fill_inode(struct inode *inode)
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+		erofs_pcs_fill_inode(inode);
+		if (vi->ano_inode)
+			inode->i_fop = &erofs_pcs_file_fops;
+		else if (erofs_inode_is_data_compressed(vi->datalayout))
+			inode->i_fop = &generic_ro_fops;
+		else
+			inode->i_fop = &erofs_file_fops;
+#else
 		if (erofs_inode_is_data_compressed(vi->datalayout))
 			inode->i_fop = &generic_ro_fops;
 		else
 			inode->i_fop = &erofs_file_fops;
+#endif
+
 		break;
 	case S_IFDIR:
 		inode->i_op = &erofs_dir_iops;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 36291feaa5f6..c61779fe2e3a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -12,6 +12,7 @@
 #include <linux/exportfs.h>
 #include <linux/pseudo_fs.h>
 #include "xattr.h"
+#include "pagecache_share.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/erofs.h>
@@ -103,6 +104,12 @@ static void erofs_free_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	if (S_ISREG(inode->i_mode) &&  vi->ano_inode) {
+		iput(vi->ano_inode);
+		vi->ano_inode = NULL;
+	}
+#endif
 	if (inode->i_op == &erofs_fast_symlink_iops)
 		kfree(inode->i_link);
 	kfree(vi->xattr_shared_xattrs);
@@ -701,6 +708,12 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	err = erofs_pcs_init_mnt();
+	if (err)
+		return err;
+#endif
+
 	erofs_info(sb, "mounted with root inode @ nid %llu.", sbi->root_nid);
 	return 0;
 }
@@ -811,6 +824,9 @@ static void erofs_kill_sb(struct super_block *sb)
 	else
 		kill_block_super(sb);
 
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	erofs_pcs_free_mnt();
+#endif
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
@@ -849,8 +865,21 @@ static struct file_system_type erofs_fs_type = {
 };
 MODULE_ALIAS_FS("erofs");
 
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+static void erofs_free_anon_inode(struct inode *inode)
+{
+	if (inode->i_private) {
+		kfree(inode->i_private);
+		inode->i_private = NULL;
+	}
+}
+#endif
+
 static const struct super_operations erofs_anon_sops = {
 	.statfs	= simple_statfs,
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	.free_inode = erofs_free_anon_inode,
+#endif
 };
 
 static int erofs_anon_init_fs_context(struct fs_context *fc)
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 424f656cd765..cd3cabfef462 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1802,6 +1802,17 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 
 static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	struct erofs_inode *vi = NULL;
+
+	if (file && file->private_data) {
+		vi = file->private_data;
+		if (vi->ano_inode == file_inode(file))
+			folio->mapping->host = &vi->vfs_inode;
+		else
+			vi = NULL;
+	}
+#endif
 	struct inode *const inode = folio->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
@@ -1824,11 +1835,27 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
+
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	if (vi)
+		folio->mapping->host = file_inode(file);
+#endif
 	return err;
 }
 
 static void z_erofs_readahead(struct readahead_control *rac)
 {
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	struct erofs_inode *vi = NULL;
+
+	if (rac->file && rac->file->private_data) {
+		vi = rac->file->private_data;
+		if (vi->ano_inode == file_inode(rac->file))
+			rac->mapping->host = &vi->vfs_inode;
+		else
+			vi = NULL;
+	}
+#endif
 	struct inode *const inode = rac->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
@@ -1863,6 +1890,11 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, nr_folios), true);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
+
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	if (vi)
+		rac->mapping->host = file_inode(rac->file);
+#endif
 }
 
 const struct address_space_operations z_erofs_aops = {
-- 
2.43.5

