Return-Path: <linux-erofs+bounces-506-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9DAAF73D5
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Jul 2025 14:23:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bXwsq38Gvz2yhb;
	Thu,  3 Jul 2025 22:23:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751545423;
	cv=none; b=VKxb5eJK09/CUdEY4H/gMY0pBs8wwl45TScwpDPWxgHnxgZNLdw+L6iQdbNE7JTLV2pBC9vV19KOXGe2jetd+XHRV5A/UzWo6OTN0JfB/AKzEATI1JeB/2aSPs25+Q1z9B5OGPVD4thBKJtN3sT4ficryyVsz0eCdK9LK0F2TQ3GKEs4uiWsLfX4V+0uSv+6MuClYnHDgm0QzKf2z6rW+je8Le1pRC8Y+Q7VjpTUGOZB9C1DaIZsuJkcVY4vk3Eg/Tt03lWux0+oluisBQXdSRksR5SCq7NyMdMzN7lXL16OKmU8DJ6O8azXZwPyEzLlk90s4NXd80R3y29Ow7CdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751545423; c=relaxed/relaxed;
	bh=0bn2mjT1h//gwjI6NeWdV8qv3EgNDgj9P+GdJ1nVOPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cg8tZt8mod1qYO+jCcdg0kjLvfGD4Drokh3/FJe8V+KZzLoDmAWxV+NxmbSGz0aUvFa4qREYKWYLY116gF1C58WnZYu6rXSdJ9Jr2TzUltEomD50MvqtD8ZklAbKX0VaOKIzIEY/0PhU+8d0sby1a7Ovg8EUdlcDw06Cu571ij01ztOvZBVkVnmqbkUOhjCCpDVxJtQND9UFf0qYGBAB2unwK1SMqDoEBi/kEi566vTkN2Zhfyys0PsRsCaZHHQcgQq2SaiuwjkcX4nUV8VbJfLbfLDJCGYbqVexWqNU4l0+SbLuFYaxln+ABs5OdOyTJZE5dINjk0S+yYOmVsE+UA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mSFd3IPB; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mSFd3IPB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bXwsp2TJZz2xgQ
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Jul 2025 22:23:42 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0542343E3B;
	Thu,  3 Jul 2025 12:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370A8C4CEF0;
	Thu,  3 Jul 2025 12:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751545419;
	bh=6lSWugtn79F1e+QrCVPPLzdjgjeNyv3MfeZp+73qdNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mSFd3IPBwgyKtoZT4OChW+IsLfpPXtpIDC+qLRqcb+2fy/F9s3lxfUktMkTMNHO+d
	 FIJaR8CgtVFCvX9O8+sV7LCZS51cW2XMd11fy+udFJKyFJYTwDXuZNojxm8n5QzvTV
	 0SvChNV3ZVoMEBEaww8YKkQfMHb2aTRexd0oNbKV+6FhA6vMCq0I1JbpDY3MfFOpyR
	 +2kKNi2DibUyBaHXMtyrOssd3BzoDOQRz420jvpfwu9kCp8DHuqQks+C2CWN52Nmet
	 NVoauRYgEN4vcsJid82pvFPfVaIVq3Q+FGRvx1ib9jWkvyq3GMDslSkToSSLYwLg3W
	 pWOQh9n7ZAcdQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 03 Jul 2025 14:23:12 +0200
Subject: [PATCH RFC 3/4] erofs: apply the page cache share feature
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-work-erofs-pcs-v1-3-0ce1f6be28ee@kernel.org>
References: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
In-Reply-To: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
To: Gao Xiang <xiang@kernel.org>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Hongzhen Luo <hongzhen@linux.alibaba.com>, 
 Matthew Wilcox <willy@infradead.org>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=6928; i=brauner@kernel.org;
 h=from:subject:message-id; bh=B4UXyNdlL/a1mk4hOrpY8zoTPva0vaFTxvkA5x7CgTI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSkldnbmjL5JW/X8WcKE7E0CEm71TxrwangQxfUqq6ee
 lU2w0u+o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKiLxn+Gar5qSc5ez6MET7i
 VjtJwGpq0Fv5LxPO2dwrCOK/EV+4gpFhgqDF2kRDkWW8b5NO1AZ8PN20pejnPiV1C6mD+/5s28H
 FDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

This modifies relevant functions to apply the page cache
share feature.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Link: https://lore.kernel.org/20240902110620.2202586-4-hongzhen@linux.alibaba.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/erofs/data.c  | 33 +++++++++++++++++++++++++++++++++
 fs/erofs/inode.c | 15 ++++++++++++++-
 fs/erofs/super.c | 29 +++++++++++++++++++++++++++++
 fs/erofs/zdata.c | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6a329c329f43..fb54162f4c54 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -351,12 +351,45 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
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
index a0ae0b4f7b01..57a23bd9d196 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -4,9 +4,11 @@
  *             https://www.huawei.com/
  * Copyright (C) 2021, Alibaba Cloud
  */
-#include "xattr.h"
 #include <trace/events/erofs.h>
 
+#include "xattr.h"
+#include "pagecache_share.h"
+
 static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 			      unsigned int m_pofs)
 {
@@ -212,10 +214,21 @@ static int erofs_fill_inode(struct inode *inode)
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
index 8fb14df2a343..b9a71840cc45 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -13,6 +13,7 @@
 #include <linux/backing-dev.h>
 #include <linux/pseudo_fs.h>
 #include "xattr.h"
+#include "pagecache_share.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/erofs.h>
@@ -81,6 +82,12 @@ static void erofs_free_inode(struct inode *inode)
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
@@ -716,6 +723,12 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -863,6 +876,9 @@ static void erofs_kill_sb(struct super_block *sb)
 		kill_block_super(sb);
 	erofs_drop_internal_inodes(sbi);
 	fs_put_dax(sbi->dif0.dax_dev, NULL);
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	erofs_pcs_free_mnt();
+#endif
 	erofs_fscache_unregister_fs(sb);
 	erofs_sb_free(sbi);
 	sb->s_fs_info = NULL;
@@ -890,8 +906,21 @@ static struct file_system_type erofs_fs_type = {
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
index fe8071844724..346d34aa6a6c 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1862,6 +1862,17 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 
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
 	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
 	int err;
@@ -1880,11 +1891,27 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 
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
 	Z_EROFS_DEFINE_FRONTEND(f, inode, readahead_pos(rac));
 	unsigned int nrpages = readahead_count(rac);
@@ -1914,6 +1941,11 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	(void)z_erofs_runqueue(&f, nrpages);
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
2.47.2


