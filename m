Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24554926B7
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jan 2022 14:13:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JdTjG3bS8z30QR
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Jan 2022 00:13:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JdThj2pn9z30Lp
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Jan 2022 00:12:36 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R411e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V2C1Qxj_1642511548; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V2C1Qxj_1642511548) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 18 Jan 2022 21:12:29 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 10/20] erofs: register global fscache volume
Date: Tue, 18 Jan 2022 21:12:06 +0800
Message-Id: <20220118131216.85338-11-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
References: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

All erofs instances will share one global fscache volume.

In this using scenario, one erofs instance could be mounted from one (or
multiple) blob files instead of blkdev. The number of blob files that
each erofs instance could correspond to is limited, since these blob
files are quite large in size. For example, when used for container
image distribution, one erofs instance used for container image for
node.js will correspond to ~20 blob files in total. Thus in densely
employed environment, there could be as many as hundreds of containers
and thus thousands of fscache cookies under one fscache volume.

Then as for cachefiles backend, the hash table managing all cookies
under one volume contains 32K slots. Thus the hashing functionality shall
scale well in this case. Besides, cachefiles backend will scatter
backing files under 256 fan sub-directoris, and thus the scalability of
looking up backing files shall also not be an issue.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/Makefile   |  3 ++-
 fs/erofs/fscache.c  | 21 +++++++++++++++++++++
 fs/erofs/internal.h |  5 +++++
 fs/erofs/super.c    |  7 +++++++
 4 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 fs/erofs/fscache.c

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 8a3317e38e5a..21999e8a4728 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o sysfs.o
+erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o sysfs.o \
+	      fscache.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
new file mode 100644
index 000000000000..9c32f42e1056
--- /dev/null
+++ b/fs/erofs/fscache.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021, Alibaba Cloud
+ */
+#include "internal.h"
+
+static struct fscache_volume *volume;
+
+int __init erofs_init_fscache(void)
+{
+	volume = fscache_acquire_volume("erofs", NULL, NULL, 0);
+	if (!volume)
+		return -EINVAL;
+
+	return 0;
+}
+
+void erofs_exit_fscache(void)
+{
+	fscache_relinquish_volume(volume, NULL, false);
+}
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 2b9337d385ce..c2608a469107 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/iomap.h>
+#include <linux/fscache.h>
 #include "erofs_fs.h"
 
 /* redefine pr_fmt "erofs: " */
@@ -616,6 +617,10 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
+/* fscache.c */
+int erofs_init_fscache(void);
+void erofs_exit_fscache(void);
+
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
 #endif	/* __EROFS_INTERNAL_H */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 12755217631f..798f0c379e35 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -814,6 +814,10 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto sysfs_err;
 
+	err = erofs_init_fscache();
+	if (err)
+		goto fscache_err;
+
 	err = register_filesystem(&erofs_fs_type);
 	if (err)
 		goto fs_err;
@@ -821,6 +825,8 @@ static int __init erofs_module_init(void)
 	return 0;
 
 fs_err:
+	erofs_exit_fscache();
+fscache_err:
 	erofs_exit_sysfs();
 sysfs_err:
 	z_erofs_exit_zip_subsystem();
@@ -841,6 +847,7 @@ static void __exit erofs_module_exit(void)
 	/* Ensure all RCU free inodes / pclusters are safe to be destroyed. */
 	rcu_barrier();
 
+	erofs_exit_fscache();
 	erofs_exit_sysfs();
 	z_erofs_exit_zip_subsystem();
 	z_erofs_lzma_exit();
-- 
2.27.0

