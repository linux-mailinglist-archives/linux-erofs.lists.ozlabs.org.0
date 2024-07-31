Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089969428D8
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2024 10:07:57 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=t/RxFkd0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WYl8B6qpLz3dDT
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2024 18:07:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=t/RxFkd0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WYl7p0tGrz2yPq
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 Jul 2024 18:07:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722413248; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DSxArOXpMYYo5QvLWFHxWEb/Rcp06yq06zBpX4yplY0=;
	b=t/RxFkd03KWda9R0qUqgPt4yADXslPTVVdoZOFPnK0cTaZbbLP34T5qevcybkov1b7wCYAvXMfgpMUkFfy6aeJ5/hrzgasw/R8bLq5Va0LfveAXUYeNht4uLC0vJTAxjAFuxDLMhMa9DFrsLzLojNyM+KFwrgQCg0jgqxliuY44=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0WBikPVL_1722413247;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WBikPVL_1722413247)
          by smtp.aliyun-inc.com;
          Wed, 31 Jul 2024 16:07:28 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	lihongbo22@huawei.com
Subject: [PATCH RFC v2 2/2] erofs: apply the page cache share feature
Date: Wed, 31 Jul 2024 16:07:04 +0800
Message-ID: <20240731080704.678259-3-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240731080704.678259-1-hongzhen@linux.alibaba.com>
References: <20240731080704.678259-1-hongzhen@linux.alibaba.com>
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
v2: Make adjustments based on the latest implementation.
v1: https://lore.kernel.org/all/20240722065355.1396365-5-hongzhen@linux.alibaba.com/
---
 fs/erofs/inode.c | 23 +++++++++++++++++++++++
 fs/erofs/super.c | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 5f6439a63af7..9f1e7332cff9 100644
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
@@ -325,6 +338,16 @@ struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid)
 			return ERR_PTR(err);
 		}
 		unlock_new_inode(inode);
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+		if ((inode->i_mode & S_IFMT) == S_IFREG &&
+		    EROFS_I(inode)->fprt_len > 0) {
+			err = erofs_pcs_add(inode);
+			if (err) {
+				iget_failed(inode);
+				return ERR_PTR(err);
+			}
+		}
+#endif
 	}
 	return inode;
 }
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 35268263aaed..a42e65ef7fc7 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -11,6 +11,7 @@
 #include <linux/fs_parser.h>
 #include <linux/exportfs.h>
 #include "xattr.h"
+#include "pagecache_share.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/erofs.h>
@@ -95,6 +96,10 @@ static struct inode *erofs_alloc_inode(struct super_block *sb)
 
 	/* zero out everything except vfs_inode */
 	memset(vi, 0, offsetof(struct erofs_inode, vfs_inode));
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	INIT_LIST_HEAD(&vi->pcs_list);
+	init_rwsem(&vi->pcs_rwsem);
+#endif
 	return &vi->vfs_inode;
 }
 
@@ -108,6 +113,21 @@ static void erofs_free_inode(struct inode *inode)
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
+		kfree(vi->fprt);
+		vi->fprt = NULL;
+	}
+}
+#endif
+
 static bool check_layout_compatibility(struct super_block *sb,
 				       struct erofs_super_block *dsb)
 {
@@ -937,6 +957,9 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 const struct super_operations erofs_sops = {
 	.put_super = erofs_put_super,
 	.alloc_inode = erofs_alloc_inode,
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	.destroy_inode = erofs_destroy_inode,
+#endif
 	.free_inode = erofs_free_inode,
 	.statfs = erofs_statfs,
 	.show_options = erofs_show_options,
-- 
2.43.5

