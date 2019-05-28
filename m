Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8652BD40
	for <lists+linux-erofs@lfdr.de>; Tue, 28 May 2019 04:32:51 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45CdDJ6bt9zDqHg
	for <lists+linux-erofs@lfdr.de>; Tue, 28 May 2019 12:32:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45CdD84vvtzDqHL
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 May 2019 12:32:39 +1000 (AEST)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 8EADA6FD8AA61A335DF6;
 Tue, 28 May 2019 10:32:34 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 28 May
 2019 10:32:27 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>
Subject: [PATCH 1/2] staging: erofs: support statx
Date: Tue, 28 May 2019 10:31:46 +0800
Message-ID: <20190528023147.94117-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

statx() has already been supported in commit a528d35e8bfc
("statx: Add a system call to make enhanced file info available"),
user programs can get more useful attributes.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/inode.c    | 18 ++++++++++++++++++
 drivers/staging/erofs/internal.h |  2 ++
 drivers/staging/erofs/namei.c    |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index c7d3b815a798..8da144943ed6 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -285,7 +285,23 @@ struct inode *erofs_iget(struct super_block *sb,
 	return inode;
 }
 
+int erofs_getattr(const struct path *path, struct kstat *stat,
+		  u32 request_mask, unsigned int query_flags)
+{
+	struct inode *const inode = d_inode(path->dentry);
+	struct erofs_vnode *const vi = EROFS_V(inode);
+
+	if (vi->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
+		stat->attributes |= STATX_ATTR_COMPRESSED;
+
+	stat->attributes |= STATX_ATTR_IMMUTABLE;
+
+	generic_fillattr(inode, stat);
+	return 0;
+}
+
 const struct inode_operations erofs_generic_iops = {
+	.getattr = erofs_getattr,
 #ifdef CONFIG_EROFS_FS_XATTR
 	.listxattr = erofs_listxattr,
 #endif
@@ -294,6 +310,7 @@ const struct inode_operations erofs_generic_iops = {
 
 const struct inode_operations erofs_symlink_iops = {
 	.get_link = page_get_link,
+	.getattr = erofs_getattr,
 #ifdef CONFIG_EROFS_FS_XATTR
 	.listxattr = erofs_listxattr,
 #endif
@@ -302,6 +319,7 @@ const struct inode_operations erofs_symlink_iops = {
 
 const struct inode_operations erofs_fast_symlink_iops = {
 	.get_link = simple_get_link,
+	.getattr = erofs_getattr,
 #ifdef CONFIG_EROFS_FS_XATTR
 	.listxattr = erofs_listxattr,
 #endif
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index c47778b3fabd..911333cdeef4 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -556,6 +556,8 @@ static inline bool is_inode_fast_symlink(struct inode *inode)
 }
 
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid, bool dir);
+int erofs_getattr(const struct path *path, struct kstat *stat,
+		  u32 request_mask, unsigned int query_flags);
 
 /* namei.c */
 extern const struct inode_operations erofs_dir_iops;
diff --git a/drivers/staging/erofs/namei.c b/drivers/staging/erofs/namei.c
index d8d9dc9dab43..fd3ae78d0ba5 100644
--- a/drivers/staging/erofs/namei.c
+++ b/drivers/staging/erofs/namei.c
@@ -247,6 +247,7 @@ static struct dentry *erofs_lookup(struct inode *dir,
 
 const struct inode_operations erofs_dir_iops = {
 	.lookup = erofs_lookup,
+	.getattr = erofs_getattr,
 #ifdef CONFIG_EROFS_FS_XATTR
 	.listxattr = erofs_listxattr,
 #endif
-- 
2.17.1

