Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C983F874647
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 03:45:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1709779516;
	bh=roXAKIyD1Es5HHbfbabufI3pRvjacQcWDWOoQ3TxeS4=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=IPoFFmgJxECxCxLlXITDGM8AgAhnDh0wQe/NITcaaeSnwA5cKWU5ewmWJJCnXge0c
	 mXJjiL1lq18EJU48e/Us0+ZkBjohqXDtP8zeYstoQreOrhb1e3gZOKdSwTymrqQILS
	 p8xkZs5/b1NCtl5noZ0PNfp4uUAVTSzszjp6pO7++puBm1dl6MEM0PGQ8lXIlOB5wg
	 0mlhUPDtlv7vLp6ULh0q/L5dVLw5lHGDuqlPE+bjA7LynkZ7qnsNvWf/3pH0XJwVDK
	 CQbsrSssBRNXJ7gCTWHzHIPN34UvK9/8Q/SbyemQhtvsBB3J6YB79kw9AADcdc3xLk
	 WK1fPq9zK+Jxg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TqtvJ4rv3z3d2d
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 13:45:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=libaokun1@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TqtsJ3sBtz3vbZ
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Mar 2024 13:43:31 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TqtrM0mvxzbcpg;
	Thu,  7 Mar 2024 10:42:43 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id C8B4418001D;
	Thu,  7 Mar 2024 10:43:25 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 10:43:25 +0800
To: <linux-erofs@lists.ozlabs.org>
Subject: [PATCH] erofs: fix lockdep false positives on initializing erofs_pseudo_mnt
Date: Thu, 7 Mar 2024 10:44:59 +0800
Message-ID: <20240307024459.883044-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
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
From: Baokun Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Baokun Li <libaokun1@huawei.com>
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, yukuai3@huawei.com, chengzhihao1@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Lockdep reported the following issue when mounting erofs with a domain_id:

============================================
WARNING: possible recursive locking detected
6.8.0-rc7-xfstests #521 Not tainted
--------------------------------------------
mount/396 is trying to acquire lock:
ffff907a8aaaa0e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
						at: alloc_super+0xe3/0x3d0

but task is already holding lock:
ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
						at: alloc_super+0xe3/0x3d0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&type->s_umount_key#50/1);
  lock(&type->s_umount_key#50/1);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by mount/396:
 #0: ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
			at: alloc_super+0xe3/0x3d0
 #1: ffffffffc00e6f28 (erofs_domain_list_lock){+.+.}-{3:3},
			at: erofs_fscache_register_fs+0x3d/0x270 [erofs]

stack backtrace:
CPU: 1 PID: 396 Comm: mount Not tainted 6.8.0-rc7-xfstests #521
Call Trace:
 <TASK>
 dump_stack_lvl+0x64/0xb0
 validate_chain+0x5c4/0xa00
 __lock_acquire+0x6a9/0xd50
 lock_acquire+0xcd/0x2b0
 down_write_nested+0x45/0xd0
 alloc_super+0xe3/0x3d0
 sget_fc+0x62/0x2f0
 vfs_get_super+0x21/0x90
 vfs_get_tree+0x2c/0xf0
 fc_mount+0x12/0x40
 vfs_kern_mount.part.0+0x75/0x90
 kern_mount+0x24/0x40
 erofs_fscache_register_fs+0x1ef/0x270 [erofs]
 erofs_fc_fill_super+0x213/0x380 [erofs]

This is because the file_system_type of both erofs and the pseudo-mount
point of domain_id is erofs_fs_type, so two successive calls to
alloc_super() are considered to be using the same lock and trigger the
warning above.

Therefore add a nodev file_system_type named erofs_anon_fs_type to
silence this complaint. In addition, to reduce code coupling, refactor
out the erofs_anon_init_fs_context() and erofs_kill_pseudo_sb() functions
and move the erofs_pseudo_mnt related code to fscache.c.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/erofs/fscache.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/erofs/internal.h | 10 +++++++++-
 fs/erofs/super.c    | 37 ++++++++--------------------------
 3 files changed, 64 insertions(+), 31 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 89a7c2453aae..a346884a2c00 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2022, Bytedance Inc. All rights reserved.
  */
 #include <linux/fscache.h>
+#include <linux/fs_context.h>
 #include "internal.h"
 
 static DEFINE_MUTEX(erofs_domain_list_lock);
@@ -12,6 +13,51 @@ static LIST_HEAD(erofs_domain_list);
 static LIST_HEAD(erofs_domain_cookies_list);
 static struct vfsmount *erofs_pseudo_mnt;
 
+static int
+erofs_fc_fill_pseudo_super(struct super_block *sb, struct fs_context *fc)
+{
+	static const struct tree_descr empty_descr = {""};
+
+	return simple_fill_super(sb, EROFS_SUPER_MAGIC, &empty_descr);
+}
+
+static int erofs_fc_anon_get_tree(struct fs_context *fc)
+{
+	return get_tree_nodev(fc, erofs_fc_fill_pseudo_super);
+}
+
+static const struct fs_context_operations erofs_anon_context_ops = {
+	.get_tree	= erofs_fc_anon_get_tree,
+};
+
+static int erofs_anon_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &erofs_anon_context_ops;
+	return 0;
+}
+
+static void erofs_kill_pseudo_sb(struct super_block *sb)
+{
+	kill_anon_super(sb);
+}
+
+static struct file_system_type erofs_anon_fs_type = {
+	.owner		= THIS_MODULE,
+	.name           = "pseudo_erofs",
+	.init_fs_context = erofs_anon_init_fs_context,
+	.kill_sb        = erofs_kill_pseudo_sb,
+};
+
+int erofs_anon_register_fs(void)
+{
+	return register_filesystem(&erofs_anon_fs_type);
+}
+
+void erofs_anon_unregister_fs(void)
+{
+	unregister_filesystem(&erofs_anon_fs_type);
+}
+
 struct erofs_fscache_request {
 	struct erofs_fscache_request *primary;
 	struct netfs_cache_resources cache_resources;
@@ -381,7 +427,7 @@ static int erofs_fscache_init_domain(struct super_block *sb)
 		goto out;
 
 	if (!erofs_pseudo_mnt) {
-		struct vfsmount *mnt = kern_mount(&erofs_fs_type);
+		struct vfsmount *mnt = kern_mount(&erofs_anon_fs_type);
 		if (IS_ERR(mnt)) {
 			err = PTR_ERR(mnt);
 			goto out;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0f0706325b7b..d9e30ccceb39 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -385,7 +385,6 @@ struct erofs_map_dev {
 	unsigned int m_deviceid;
 };
 
-extern struct file_system_type erofs_fs_type;
 extern const struct super_operations erofs_sops;
 
 extern const struct address_space_operations erofs_raw_access_aops;
@@ -507,6 +506,9 @@ static inline int z_erofs_deflate_exit(void) { return 0; }
 #endif	/* !CONFIG_EROFS_FS_ZIP_DEFLATE */
 
 #ifdef CONFIG_EROFS_FS_ONDEMAND
+int erofs_anon_register_fs(void);
+void erofs_anon_unregister_fs(void);
+
 int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
 
@@ -514,6 +516,12 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 					char *name, unsigned int flags);
 void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
 #else
+static inline int erofs_anon_register_fs(void)
+{
+	return 0;
+}
+static inline void erofs_anon_unregister_fs(void) {}
+
 static inline int erofs_fscache_register_fs(struct super_block *sb)
 {
 	return -EOPNOTSUPP;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9b4b66dcdd4f..a745010e9fe6 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -579,13 +579,6 @@ static const struct export_operations erofs_export_ops = {
 	.get_parent = erofs_get_parent,
 };
 
-static int erofs_fc_fill_pseudo_super(struct super_block *sb, struct fs_context *fc)
-{
-	static const struct tree_descr empty_descr = {""};
-
-	return simple_fill_super(sb, EROFS_SUPER_MAGIC, &empty_descr);
-}
-
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
@@ -712,11 +705,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	return 0;
 }
 
-static int erofs_fc_anon_get_tree(struct fs_context *fc)
-{
-	return get_tree_nodev(fc, erofs_fc_fill_pseudo_super);
-}
-
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
 	struct erofs_fs_context *ctx = fc->fs_private;
@@ -789,20 +777,10 @@ static const struct fs_context_operations erofs_context_ops = {
 	.free		= erofs_fc_free,
 };
 
-static const struct fs_context_operations erofs_anon_context_ops = {
-	.get_tree       = erofs_fc_anon_get_tree,
-};
-
 static int erofs_init_fs_context(struct fs_context *fc)
 {
 	struct erofs_fs_context *ctx;
 
-	/* pseudo mount for anon inodes */
-	if (fc->sb_flags & SB_KERNMOUNT) {
-		fc->ops = &erofs_anon_context_ops;
-		return 0;
-	}
-
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
@@ -824,12 +802,6 @@ static void erofs_kill_sb(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi;
 
-	/* pseudo mount for anon inodes */
-	if (sb->s_flags & SB_KERNMOUNT) {
-		kill_anon_super(sb);
-		return;
-	}
-
 	if (erofs_is_fscache_mode(sb))
 		kill_anon_super(sb);
 	else
@@ -868,7 +840,7 @@ static void erofs_put_super(struct super_block *sb)
 	erofs_fscache_unregister_fs(sb);
 }
 
-struct file_system_type erofs_fs_type = {
+static struct file_system_type erofs_fs_type = {
 	.owner          = THIS_MODULE,
 	.name           = "erofs",
 	.init_fs_context = erofs_init_fs_context,
@@ -911,6 +883,10 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto sysfs_err;
 
+	err = erofs_anon_register_fs();
+	if (err)
+		goto anon_err;
+
 	err = register_filesystem(&erofs_fs_type);
 	if (err)
 		goto fs_err;
@@ -918,6 +894,8 @@ static int __init erofs_module_init(void)
 	return 0;
 
 fs_err:
+	erofs_anon_unregister_fs();
+anon_err:
 	erofs_exit_sysfs();
 sysfs_err:
 	z_erofs_exit_zip_subsystem();
@@ -935,6 +913,7 @@ static int __init erofs_module_init(void)
 static void __exit erofs_module_exit(void)
 {
 	unregister_filesystem(&erofs_fs_type);
+	erofs_anon_unregister_fs();
 
 	/* Ensure all RCU free inodes / pclusters are safe to be destroyed. */
 	rcu_barrier();
-- 
2.31.1

