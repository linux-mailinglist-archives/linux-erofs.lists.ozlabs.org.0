Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 458E9A019ED
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Jan 2025 16:12:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YR1573gZFz30WS
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Jan 2025 02:12:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736089943;
	cv=none; b=hUlC0+IbrgnsVH8CKACoORX19Dy7SJtA4XtU6AuhewkfstmgatY0z3t6DK3rk3qQJwUVL8uw2slnWu1RHnGICKgv6VRFnEKbq990hS9MlvQDV3ZWcYFcnNuheiNIl0m28CalyHD+LWR/OZddrP7SYL/Joc0bRKBf5k+a34I1UkT6Iy7M8ipZQeiDPJxfU6YrDI/+Wnp8F75KGhSs4X0bMweL8593BHpntepg3ejpvXyn4FyX/I9a27PJdhXDrTdhKQKOm0Z/kx3bspxzOI8kMuPSCOXBmr/S3UaldeceYezORupfj5KvstrB989+MeRUp0lvUa10TayKX2Y0SxZ1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736089943; c=relaxed/relaxed;
	bh=xzy4wpwrY2Ed3xF90C4MLp1BMlntC8ejaDV8Ez8/VfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8PvJYyuQAxeMGESE1+C8cY9tuZcuFo5YNGAUiScoJwf8cTgS5ETST53uqKeLong2FCtZMkdsPkc89ugRLWu1uidLUlxAkHS9saq9Fkb6Q40re7L2vzZgnvd+NTRoK+S7SuPgZLzcaTADa3s+7OK3jbIUMjCqrXM2BoJXalV3g6BdjTVTfTqrC0usanvS7J38DLTjLSj0ABi96zmBo1asfOhGtxqjGf/UHEkvn9PkN/ijuF2f6D+CXowk2lH0m+BJv5kOVMpkxJaRq0nx4SMEaQehmIuztkBEP5Mt1ReYcPuPuM9UHJ/6GKIso22RBYqK8JW4Z/KwlgK+DD1KxlYPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w6IIykNK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w6IIykNK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YR1503SGKz2ymQ
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Jan 2025 02:12:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736089934; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=xzy4wpwrY2Ed3xF90C4MLp1BMlntC8ejaDV8Ez8/VfM=;
	b=w6IIykNK/oWRZ8VmNvAFFxa/TLAMd6H5IMDqFS9moIKkAIulVbnK4FZr1EZTGt3S3iinHtHECI3RGhyCB61Bg1Vapxs0ticwjLQfe/N1JDVR2Mog1MWjRKDycjkrfm4DrqXp4lDX/iAD1wv45G4RI04/YsPZh0LfwpgorpBOVQo=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WMynS4e_1736089931 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 05 Jan 2025 23:12:12 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v5 2/4] erofs: introduce the page cache share feature
Date: Sun,  5 Jan 2025 23:12:06 +0800
Message-ID: <20250105151208.3797385-3-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250105151208.3797385-1-hongzhen@linux.alibaba.com>
References: <20250105151208.3797385-1-hongzhen@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

Currently, reading files with different paths (or names) but the same
content will consume multiple copies of the page cache, even if the
content of these page caches is the same. For example, reading identical
files (e.g., *.so files) from two different minor versions of container
images will cost multiple copies of the same page cache, since different
containers have different mount points. Therefore, sharing the page cache
for files with the same content can save memory.

This introduces the page cache share feature in erofs. During the mkfs
phase, the file content is hashed and the hash value is stored in the
`trusted.erofs.fingerprint` extended attribute. Inodes of files with the
same `trusted.erofs.fingerprint` are mapped to the same anonymous inode
(indicated by the `ano_inode` field). When a read request occurs, the
anonymous inode serves as a "container" whose page cache is shared. The
actual operations involving the iomap are carried out by the original
inode which is mapped to the anonymous inode.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/Kconfig           |  10 ++
 fs/erofs/Makefile          |   1 +
 fs/erofs/internal.h        |   4 +
 fs/erofs/pagecache_share.c | 228 +++++++++++++++++++++++++++++++++++++
 fs/erofs/pagecache_share.h |  26 +++++
 fs/erofs/super.c           |  24 +++-
 6 files changed, 292 insertions(+), 1 deletion(-)
 create mode 100644 fs/erofs/pagecache_share.c
 create mode 100644 fs/erofs/pagecache_share.h

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 6ea60661fa55..3aa5f946b5f1 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -178,3 +178,13 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
 	  at higher priority.
 
 	  If unsure, say N.
+
+config EROFS_FS_PAGE_CACHE_SHARE
+       bool "EROFS page cache share support"
+       depends on EROFS_FS
+       default n
+	help
+	  This permits EROFS to share page cache for files with same
+	  fingerprints.
+
+	  If unsure, say N.
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 4331d53c7109..d035c9063ef8 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -9,3 +9,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
+erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += pagecache_share.o
\ No newline at end of file
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 47004eb89838..6c87621d86ba 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -280,6 +280,9 @@ struct erofs_inode {
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	struct inode *ano_inode;
+#endif
 	/* the corresponding vfs inode */
 	struct inode vfs_inode;
 };
@@ -376,6 +379,7 @@ extern const struct inode_operations erofs_dir_iops;
 
 extern const struct file_operations erofs_file_fops;
 extern const struct file_operations erofs_dir_fops;
+extern const struct file_operations erofs_pcshr_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
diff --git a/fs/erofs/pagecache_share.c b/fs/erofs/pagecache_share.c
new file mode 100644
index 000000000000..703fd17c002c
--- /dev/null
+++ b/fs/erofs/pagecache_share.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024, Alibaba Cloud
+ */
+#include <linux/xxhash.h>
+#include <linux/refcount.h>
+#include <linux/mount.h>
+#include <linux/mutex.h>
+#include "pagecache_share.h"
+#include "internal.h"
+#include "xattr.h"
+
+#define PCSHR_FPRT_IDX	4
+#define PCSHR_FPRT_NAME	"erofs.fingerprint"
+#define PCSHR_FPRT_MAXLEN (sizeof(size_t) + 1024)
+
+struct erofs_pcshr_counter {
+	struct mutex mutex;
+	struct kref ref;
+	struct vfsmount *mnt;
+};
+
+struct erofs_pcshr_private {
+	char fprt[PCSHR_FPRT_MAXLEN];
+};
+
+static struct erofs_pcshr_counter mnt_counter = {
+	.mutex = __MUTEX_INITIALIZER(mnt_counter.mutex),
+	.mnt = NULL,
+};
+
+static void erofs_pcshr_counter_release(struct kref *ref)
+{
+	struct erofs_pcshr_counter *counter = container_of(ref,
+			struct erofs_pcshr_counter, ref);
+
+	DBG_BUGON(!counter->mnt);
+	kern_unmount(counter->mnt);
+	counter->mnt = NULL;
+}
+
+int erofs_pcshr_init_mnt(void)
+{
+	int ret;
+	struct vfsmount *tmp;
+
+	mutex_lock(&mnt_counter.mutex);
+	if (!mnt_counter.mnt) {
+		tmp = kern_mount(&erofs_anon_fs_type);
+		if (IS_ERR(tmp)) {
+			ret = PTR_ERR(tmp);
+			goto out;
+		}
+		mnt_counter.mnt = tmp;
+		kref_init(&mnt_counter.ref);
+	} else
+		kref_get(&mnt_counter.ref);
+	ret = 0;
+out:
+	mutex_unlock(&mnt_counter.mutex);
+	return ret;
+}
+
+void erofs_pcshr_free_mnt(void)
+{
+	mutex_lock(&mnt_counter.mutex);
+	kref_put(&mnt_counter.ref, erofs_pcshr_counter_release);
+	mutex_unlock(&mnt_counter.mutex);
+}
+
+static int erofs_fprt_eq(struct inode *inode, void *data)
+{
+	struct erofs_pcshr_private *ano_private = inode->i_private;
+
+	return ano_private && memcmp(ano_private->fprt, data,
+			sizeof(size_t) + *(size_t *)data) == 0 ? 1 : 0;
+}
+
+static int erofs_fprt_set(struct inode *inode, void *data)
+{
+	struct erofs_pcshr_private *ano_private;
+
+	ano_private = kmalloc(sizeof(struct erofs_pcshr_private), GFP_KERNEL);
+	if (!ano_private)
+		return -ENOMEM;
+	memcpy(ano_private, data, sizeof(size_t) + *(size_t *)data);
+	inode->i_private = ano_private;
+	return 0;
+}
+
+int erofs_pcshr_fill_inode(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	/* | fingerprint length | fingerprint content | */
+	char fprt[PCSHR_FPRT_MAXLEN];
+	struct inode *ano_inode;
+	unsigned long fprt_hash;
+	size_t fprt_len;
+	int ret = -1;
+
+	vi->ano_inode = NULL;
+	memset(fprt, 0, sizeof(fprt));
+	fprt_len = erofs_getxattr(inode, PCSHR_FPRT_IDX, PCSHR_FPRT_NAME,
+			fprt + sizeof(size_t), PCSHR_FPRT_MAXLEN);
+	if (fprt_len > 0 && fprt_len <= PCSHR_FPRT_MAXLEN) {
+		*(size_t *)fprt = fprt_len;
+		fprt_hash = xxh32(fprt + sizeof(size_t), fprt_len, 0);
+		ano_inode = iget5_locked(mnt_counter.mnt->mnt_sb, fprt_hash,
+					 erofs_fprt_eq, erofs_fprt_set, fprt);
+		DBG_BUGON(!ano_inode);
+		vi->ano_inode = ano_inode;
+		if (ano_inode->i_state & I_NEW) {
+			if (erofs_inode_is_data_compressed(vi->datalayout))
+				ano_inode->i_mapping->a_ops = &z_erofs_aops;
+			else
+				ano_inode->i_mapping->a_ops = &erofs_aops;
+			ano_inode->i_size = inode->i_size;
+			unlock_new_inode(ano_inode);
+		}
+		ret = 0;
+	}
+	return ret;
+}
+
+void erofs_pcshr_free_inode(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+
+	if (S_ISREG(inode->i_mode) &&  vi->ano_inode) {
+		iput(vi->ano_inode);
+		vi->ano_inode = NULL;
+	}
+}
+
+static struct file *erofs_pcshr_alloc_file(struct file *file,
+					   struct inode *ano_inode)
+{
+	struct file *ano_file;
+
+	ano_file = alloc_file_pseudo(ano_inode, mnt_counter.mnt,
+			"[erofs_pcssh_f]", O_RDONLY, &erofs_file_fops);
+	if (IS_ERR(ano_file))
+		return ano_file;
+
+	file_ra_state_init(&ano_file->f_ra, file->f_mapping);
+	ano_file->private_data = EROFS_I(file_inode(file));
+	return ano_file;
+}
+
+static int erofs_pcshr_file_open(struct inode *inode, struct file *file)
+{
+	struct file *ano_file;
+	struct inode *ano_inode;
+	struct erofs_inode *vi = EROFS_I(inode);
+
+	ano_inode = vi->ano_inode;
+	if (!ano_inode)
+		return -EINVAL;
+
+	ano_file = erofs_pcshr_alloc_file(file, ano_inode);
+	if (IS_ERR(ano_file))
+		return PTR_ERR(ano_file);
+
+	ihold(ano_inode);
+	file->private_data = (void *)ano_file;
+	return 0;
+}
+
+static int erofs_pcshr_file_release(struct inode *inode, struct file *file)
+{
+	if (!file->private_data)
+		return -EINVAL;
+
+	fput((struct file *)file->private_data);
+	file->private_data = NULL;
+	return 0;
+}
+
+static ssize_t erofs_pcshr_file_read_iter(struct kiocb *iocb,
+					struct iov_iter *to)
+{
+	struct inode __maybe_unused *inode = file_inode(iocb->ki_filp);
+	struct file *file, *ano_file;
+	struct kiocb ano_iocb;
+	ssize_t res;
+
+	if (!iov_iter_count(to))
+		return 0;
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return erofs_file_fops.read_iter(iocb, to);
+#endif
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return erofs_file_fops.read_iter(iocb, to);
+
+	memcpy(&ano_iocb, iocb, sizeof(struct kiocb));
+	file = iocb->ki_filp;
+	ano_file = file->private_data;
+	if (!ano_file)
+		return -EINVAL;
+	ano_iocb.ki_filp = ano_file;
+	res = filemap_read(&ano_iocb, to, 0);
+	memcpy(iocb, &ano_iocb, sizeof(struct kiocb));
+	iocb->ki_filp = file;
+	file_accessed(file);
+	return res;
+}
+
+extern const struct vm_operations_struct generic_file_vm_ops;
+
+static int erofs_pcshr_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct file *ano_file = file->private_data;
+
+	vma_set_file(vma, ano_file);
+	vma->vm_ops = &generic_file_vm_ops;
+	return 0;
+}
+
+const struct file_operations erofs_pcshr_fops = {
+	.open		= erofs_pcshr_file_open,
+	.llseek		= generic_file_llseek,
+	.read_iter	= erofs_pcshr_file_read_iter,
+	.mmap		= erofs_pcshr_mmap,
+	.release	= erofs_pcshr_file_release,
+	.get_unmapped_area = thp_get_unmapped_area,
+	.splice_read	= filemap_splice_read,
+};
diff --git a/fs/erofs/pagecache_share.h b/fs/erofs/pagecache_share.h
new file mode 100644
index 000000000000..f3889d6889e5
--- /dev/null
+++ b/fs/erofs/pagecache_share.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024, Alibaba Cloud
+ */
+#ifndef __EROFS_PAGECACHE_SHARE_H
+#define __EROFS_PAGECACHE_SHARE_H
+
+#include <linux/fs.h>
+
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+
+int erofs_pcshr_init_mnt(void);
+void erofs_pcshr_free_mnt(void);
+int erofs_pcshr_fill_inode(struct inode *inode);
+void erofs_pcshr_free_inode(struct inode *inode);
+
+#else
+
+static inline int erofs_pcshr_init_mnt(void) { return 0; }
+static inline void erofs_pcshr_free_mnt(void) {}
+static inline int erofs_pcshr_fill_inode(struct inode *inode) { return -1; }
+static inline void erofs_pcshr_free_inode(struct inode *inode) {}
+
+#endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+
+#endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 25d2c2b44d0a..b4ce07dc931c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -853,9 +853,31 @@ static struct file_system_type erofs_fs_type = {
 };
 MODULE_ALIAS_FS("erofs");
 
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+static void erofs_free_anon_inode(struct inode *inode)
+{
+	kfree(inode->i_private);
+	inode->i_private = NULL;
+}
+#else
+#define erofs_free_anon_inode NULL
+#endif
+
+static const struct super_operations erofs_anon_sops = {
+	.statfs = simple_statfs,
+	.free_inode = erofs_free_anon_inode,
+};
+
+
 static int erofs_anon_init_fs_context(struct fs_context *fc)
 {
-	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
+	struct pseudo_fs_context *ctx;
+
+	ctx = init_pseudo(fc, EROFS_SUPER_MAGIC);
+	if (ctx)
+		ctx->ops = &erofs_anon_sops;
+
+	return ctx ? 0 : -ENOMEM;
 }
 
 struct file_system_type erofs_anon_fs_type = {
-- 
2.43.5

