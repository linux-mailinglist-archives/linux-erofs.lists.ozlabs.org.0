Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D50EF93893F
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2024 08:54:41 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cUGxlNOn;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WS9xq5cClz30VY
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2024 16:54:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cUGxlNOn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WS9xC3q53z3cRK
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jul 2024 16:54:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721631243; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Lv/VYRFWu4n6D9H1dnEG99ssOBBVdy0nuODllV0fKQY=;
	b=cUGxlNOn7shXt1bJa09VBIwXuWPf2DNG2DGVNC8ZGChHa0lc0IX8+AbLCGUwphdYFZu64wiL8QIM+SZR1naO586sdHhJ5xV/+wBV+7fN04cosNvwEqAOHu7vRVSji5aWFoEX7ZBWNJ/9tzEAuB8U9DE2UbUwZ9bmeihECKqi0eM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WB-Gf5K_1721631242;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WB-Gf5K_1721631242)
          by smtp.aliyun-inc.com;
          Mon, 22 Jul 2024 14:54:03 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH RFC 4/4] erofs: apply the page cache share feature
Date: Mon, 22 Jul 2024 14:53:54 +0800
Message-ID: <20240722065355.1396365-5-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240722065355.1396365-1-hongzhen@linux.alibaba.com>
References: <20240722065355.1396365-1-hongzhen@linux.alibaba.com>
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

This modifies relevant functions to apply the page cache
share feature.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/inode.c | 21 +++++++++++++++++++++
 fs/erofs/super.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 5f6439a63af7..a5c47f69c2db 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "xattr.h"
+#include "pagecache_share.h"
 
 #include <trace/events/erofs.h>
 
@@ -229,10 +230,22 @@ static int erofs_fill_inode(struct inode *inode)
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+		erofs_pcs_fill_inode(inode);
+#endif
 		if (erofs_inode_is_data_compressed(vi->datalayout))
 			inode->i_fop = &generic_ro_fops;
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+		else {
+			if (vi->fprt_len > 0)
+				inode->i_fop = &erofs_pcs_file_fops;
+			else
+				inode->i_fop = &erofs_file_fops;
+		}
+#else
 		else
 			inode->i_fop = &erofs_file_fops;
+#endif
 		break;
 	case S_IFDIR:
 		inode->i_op = &erofs_dir_iops;
@@ -325,6 +338,14 @@ struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid)
 			return ERR_PTR(err);
 		}
 		unlock_new_inode(inode);
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+		if ((inode->i_mode & S_IFMT) == S_IFREG &&
+		    EROFS_I(inode)->fprt_len > 0) {
+			err = erofs_pcs_add(inode);
+			if (err)
+				return ERR_PTR(err);
+		}
+#endif
 	}
 	return inode;
 }
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 5ae597c18e75..0377a032d1d7 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -12,6 +12,7 @@
 #include <linux/exportfs.h>
 #include <linux/pseudo_fs.h>
 #include "xattr.h"
+#include "pagecache_share.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/erofs.h>
@@ -96,6 +97,9 @@ static struct inode *erofs_alloc_inode(struct super_block *sb)
 
 	/* zero out everything except vfs_inode */
 	memset(vi, 0, offsetof(struct erofs_inode, vfs_inode));
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	INIT_LIST_HEAD(&vi->pcs_list);
+#endif
 	return &vi->vfs_inode;
 }
 
@@ -109,6 +113,23 @@ static void erofs_free_inode(struct inode *inode)
 	kmem_cache_free(erofs_inode_cachep, vi);
 }
 
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+static void erofs_destroy_inode(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+
+	if ((inode->i_mode & S_IFMT) == S_IFREG &&
+	    EROFS_I(inode)->fprt_len > 0) {
+		if (erofs_pcs_remove(inode))
+			erofs_err(inode->i_sb, "pcs: fail to remove inode.");
+		if (vi->fprt) {
+			kfree(vi->fprt);
+			vi->fprt = NULL;
+		}
+	}
+}
+#endif
+
 static bool check_layout_compatibility(struct super_block *sb,
 				       struct erofs_super_block *dsb)
 {
@@ -685,6 +706,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	err = erofs_pcs_init_mnt();
+	if (err)
+		return err;
+#endif
 	erofs_info(sb, "mounted with root inode @ nid %llu.", sbi->root_nid);
 	return 0;
 }
@@ -795,6 +821,9 @@ static void erofs_kill_sb(struct super_block *sb)
 	else
 		kill_block_super(sb);
 
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	(void)erofs_pcs_free_mnt();
+#endif
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
@@ -951,6 +980,9 @@ const struct super_operations erofs_sops = {
 	.put_super = erofs_put_super,
 	.alloc_inode = erofs_alloc_inode,
 	.free_inode = erofs_free_inode,
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	.destroy_inode = erofs_destroy_inode,
+#endif
 	.statfs = erofs_statfs,
 	.show_options = erofs_show_options,
 };
-- 
2.43.5

