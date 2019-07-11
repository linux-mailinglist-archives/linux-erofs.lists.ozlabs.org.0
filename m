Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E2465A11
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Jul 2019 17:09:18 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45kzwq5sVTzDqS1
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jul 2019 01:09:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45kzhn2lSvzDqLx
 for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jul 2019 00:58:48 +1000 (AEST)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 7FD6047C2CCEE4E66394;
 Thu, 11 Jul 2019 22:58:43 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 11 Jul
 2019 22:58:34 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Theodore Ts'o <tytso@mit.edu>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 14/24] erofs: introduce superblock registration
Date: Thu, 11 Jul 2019 22:57:45 +0800
Message-ID: <20190711145755.33908-15-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711145755.33908-1-gaoxiang25@huawei.com>
References: <20190711145755.33908-1-gaoxiang25@huawei.com>
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
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In order to introducing shrinker solution for erofs,
let's manage all mounted erofs instances at first.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/Makefile   |  2 +-
 fs/erofs/internal.h | 13 +++++++++++++
 fs/erofs/super.c    |  4 ++++
 fs/erofs/utils.c    | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 fs/erofs/utils.c

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 9ab4ccc9328e..6a63c5998980 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -5,7 +5,7 @@ EROFS_VERSION = "1.0"
 ccflags-y += -DEROFS_VERSION=\"$(EROFS_VERSION)\"
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-erofs-objs := super.o inode.o data.o namei.o dir.o
+erofs-objs := super.o inode.o data.o namei.o dir.o utils.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += zmap.o
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f0a5fd316e09..87287cd9c146 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -60,6 +60,10 @@ typedef u64 erofs_off_t;
 typedef u32 erofs_blk_t;
 
 struct erofs_sb_info {
+#ifdef CONFIG_EROFS_FS_ZIP
+	/* list for all registered superblocks, mainly for shrinker */
+	struct list_head list;
+#endif
 	u32 blocks;
 	u32 meta_blkaddr;
 #ifdef CONFIG_EROFS_FS_XATTR
@@ -404,5 +408,14 @@ int erofs_namei(struct inode *dir, struct qstr *name,
 /* dir.c */
 extern const struct file_operations erofs_dir_fops;
 
+/* utils.c */
+#ifdef CONFIG_EROFS_FS_ZIP
+void erofs_shrinker_register(struct super_block *sb);
+void erofs_shrinker_unregister(struct super_block *sb);
+#else
+static inline void erofs_shrinker_register(struct super_block *sb) {}
+static inline void erofs_shrinker_unregister(struct super_block *sb) {}
+#endif
+
 #endif
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index bb1ae1f416e6..60058d3c50d4 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -374,6 +374,8 @@ static int erofs_read_super(struct super_block *sb,
 	snprintf(sbi->dev_name, PATH_MAX, "%s", dev_name);
 	sbi->dev_name[PATH_MAX - 1] = '\0';
 
+	erofs_shrinker_register(sb);
+
 	if (!silent)
 		infoln("mounted on %s with opts: %s.", dev_name,
 		       (char *)data);
@@ -412,6 +414,8 @@ static void erofs_put_super(struct super_block *sb)
 	infoln("unmounted for %s", sbi->dev_name);
 	__putname(sbi->dev_name);
 
+	erofs_shrinker_unregister(sb);
+
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
new file mode 100644
index 000000000000..08c8752895bc
--- /dev/null
+++ b/fs/erofs/utils.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * linux/fs/erofs/utils.c
+ *
+ * Copyright (C) 2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#include "internal.h"
+
+#ifdef CONFIG_EROFS_FS_ZIP
+/* protects the mounted 'erofs_sb_list' */
+static DEFINE_SPINLOCK(erofs_sb_list_lock);
+static LIST_HEAD(erofs_sb_list);
+
+void erofs_shrinker_register(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	spin_lock(&erofs_sb_list_lock);
+	list_add(&sbi->list, &erofs_sb_list);
+	spin_unlock(&erofs_sb_list_lock);
+}
+
+void erofs_shrinker_unregister(struct super_block *sb)
+{
+	spin_lock(&erofs_sb_list_lock);
+	list_del(&EROFS_SB(sb)->list);
+	spin_unlock(&erofs_sb_list_lock);
+}
+#endif
+
-- 
2.17.1

