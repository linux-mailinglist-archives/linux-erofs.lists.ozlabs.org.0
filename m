Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A329685B5
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 13:06:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy5YR0KNLz2yHL
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 21:06:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725275208;
	cv=none; b=kiJdUyLQer6Gf8QT8x0ATfgQgnPM+Rp+diKURU5yg0w3hm7s6sndA6Lw1Dsk+icK/j1tHYWh9q1UDRPTAMjnTJTZc0Cdqh/27w7rMEyR4E/P8B2euyf/0DTnmx7Ngebd0ts73PoeUkbArKTpZCLKrPkr7M4YZ1onIdK6Sfy36YQFQ2QnIQbkB279i3jO8Kxq2FdnM0EP0gmXxfeooxsCENU40Kkd354jp9U76jOKbvN+4Vf+BWpUAUgCNlrJWClhY3F8ReyI63BL60pysdlgM6UTupdzYFirqybqo0jBACEpz9VVrBvyx3emtsHlJvMgvhPFOJBnnN2uPZlde3Vg+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725275208; c=relaxed/relaxed;
	bh=wILK9eGhOkbD2R7HF62DI0YCU9LxevSyER3gqj7sMMA=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version; b=iZHBbHWPGMXQIIVHMeES0cwJ1Pxr4jNtWtW45NQyAvkywWTVsFn4hI/BtZs7qMZynuxzoElDLIw0itqwuWE4fndY4srh0OtjJ4o4XyOA5+dEWio4b8XHY4sFdTML2b/7OvI5+k6XQQ8VDmhWLVhdqC9Ke6m/r2K7C2JG6KjN9s+cVHaGHhKJ5xaXtgALpbYhkaq4U56yqzdV77+/iF+oah1xO3cN0F/2PCLu/f4jAyOOfkdXWXqhiN58UmnjWZUsloonXPErxUIwYS6A48IaODkCVOD2YUQpYuOyq5Y0YbSkibrxDKaimRAUrBODYLYw/zM7wUwJTlT2WPp7gU5ivw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nn2MGH1P; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nn2MGH1P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy5YN2Wrpz2xPb
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 21:06:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725275204; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wILK9eGhOkbD2R7HF62DI0YCU9LxevSyER3gqj7sMMA=;
	b=nn2MGH1PxGTRElOlDlg/wwAyyqyuqmB4/w3nw/+JOl3OVw/jMQQm+I7uN2NKj4iwHhgtcM/jgrvbxZLTo+DWgTE2qQFP24wKZY0NeHfJVu6ycIiX6mUb+tIgytKPJzNYFnYm2tXYflnvrBeO7fy7hPgL3xaQDr3XMtdmYBFOoPs=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WE8BYKE_1725275202)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 19:06:43 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH RFC v4 3/4] erofs: apply the page cache share feature
Date: Mon,  2 Sep 2024 19:06:19 +0800
Message-ID: <20240902110620.2202586-4-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240902110620.2202586-1-hongzhen@linux.alibaba.com>
References: <20240902110620.2202586-1-hongzhen@linux.alibaba.com>
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
v4: There are no changes compared to v3.
v3: https://lore.kernel.org/all/20240828111959.3677011-4-hongzhen@linux.alibaba.com/
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
index 419432be3223..3f2db0ad7959 100644
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
index afca576144ca..113e305080fa 100644
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
@@ -687,6 +694,12 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -797,6 +810,9 @@ static void erofs_kill_sb(struct super_block *sb)
 	else
 		kill_block_super(sb);
 
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	erofs_pcs_free_mnt();
+#endif
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
@@ -835,8 +851,21 @@ static struct file_system_type erofs_fs_type = {
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

