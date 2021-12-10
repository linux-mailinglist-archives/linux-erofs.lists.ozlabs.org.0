Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CCF46FBFB
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 08:42:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J9NCZ5x97z3bmn
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Dec 2021 18:42:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J9NCW0Mkqz3bmn
 for <linux-erofs@lists.ozlabs.org>; Fri, 10 Dec 2021 18:42:14 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R711e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=jefflexu@linux.alibaba.com; NM=1; PH=DS; RN=12; SR=0;
 TI=SMTPD_---0V-8E0RI_1639121796; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V-8E0RI_1639121796) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 10 Dec 2021 15:36:37 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [RFC 14/19] erofs: introduce fscache support
Date: Fri, 10 Dec 2021 15:36:14 +0800
Message-Id: <20211210073619.21667-15-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
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
Cc: tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, eguan@linux.alibaba.com,
 gerry@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch only handles the volume cookie and data file cookie for
bootstrap. The corresponding IO path is remained to be implemented in
the following patch.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/Makefile   |  2 +-
 fs/erofs/fscache.c  | 37 +++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h |  8 ++++++++
 fs/erofs/super.c    |  5 +++++
 4 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 fs/erofs/fscache.c

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 756fe2d65272..f9a3609625aa 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o
+erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o fscache.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
new file mode 100644
index 000000000000..cf550fdedd1e
--- /dev/null
+++ b/fs/erofs/fscache.c
@@ -0,0 +1,37 @@
+#include "internal.h"
+
+int erofs_fscache_init(struct erofs_sb_info *sbi, char *bootstrap_path)
+{
+	sbi->volume = fscache_acquire_volume("erofs", NULL, 0);
+	if (!sbi->volume) {
+		printk("fscache_acquire_volume() failed\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * TODO: @object_size is 0 since erofs can not get size of bootstrap
+	 * file.
+	 */
+	sbi->bootstrap = fscache_acquire_cookie(sbi->volume, 0,
+			 bootstrap_path, strlen(bootstrap_path),
+			 NULL, 0,
+			 1 /*TODO: we don't want FSCACHE_COOKIE_NO_DATA_TO_READ set */
+			 );
+
+	if (!sbi->bootstrap) {
+		printk("fscache_acquire_cookie() for bootstrap failed\n");
+		/* cleanup for sbi->volume is delayed to erofs_fscache_cleanup() */
+		return -EINVAL;
+	}
+
+	fscache_use_cookie(sbi->bootstrap, false);
+
+	return 0;
+}
+
+void erofs_fscache_cleanup(struct erofs_sb_info *sbi)
+{
+	fscache_unuse_cookie(sbi->bootstrap, NULL, NULL);
+	fscache_relinquish_cookie(sbi->bootstrap, false);
+	fscache_relinquish_volume(sbi->volume, 0, false);
+}
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index cf69d9c9cbed..8136ec63a9de 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/iomap.h>
+#include <linux/fscache.h>
 #include "erofs_fs.h"
 
 /* redefine pr_fmt "erofs: " */
@@ -106,6 +107,9 @@ struct erofs_sb_info {
 	/* pseudo inode to manage cached pages */
 	struct inode *managed_cache;
 
+	struct fscache_volume *volume;
+	struct fscache_cookie *bootstrap;
+
 	struct erofs_sb_lz4_info lz4;
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	struct erofs_dev_context *devs;
@@ -569,6 +573,10 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
+/* fscache.c */
+int erofs_fscache_init(struct erofs_sb_info *sbi, char *bootstrap_path);
+void erofs_fscache_cleanup(struct erofs_sb_info *sbi);
+
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
 #endif	/* __EROFS_INTERNAL_H */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 51695f6d4449..f2a5f4cd53fd 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -665,6 +665,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	else
 		sbi->dax_dev = NULL;
 
+	err = erofs_fscache_init(sbi, ctx->opt.bootstrap_path);
+	if (err)
+		return err;
+
 	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
@@ -823,6 +827,7 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev);
+	erofs_fscache_cleanup(sbi);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
-- 
2.27.0

