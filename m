Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5925A4AC62
	for <lists+linux-erofs@lfdr.de>; Sat,  1 Mar 2025 15:50:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4p0N0xhSz3cB1
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Mar 2025 01:50:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740840624;
	cv=none; b=BIMzeT0SZBxHr64NZbFgaGomd+w06EM4afgdaMJqX2fOyenhh5jCLxmm5J3KsxNHBLaVzRYH+eqWvufMaT15gY8Dq1RLNHBBz3nbHNroHkl93LUXChgs347lZvBrkKd+fAalSoTP8xqrBNA8BnKCOWV75sCo52uIIMg3TOEQeGFkoL/wF0VdzUBMiqYCVFsxvcKRC22CmrnPQFQqLEB7xKpmaaVwLCDLdKepQRv0BEl6+k6GrYb78CuujuqxMFwR/DDJVrldXrM8OLnsGZwMmYqgLNneM/kpBbYz8bk/P7JR7iHdziB8ros68WwmTDyYyRWsR9zMXwAHcCAjS+7HkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740840624; c=relaxed/relaxed;
	bh=wz9frzctN1J75p3iB2EhAvBmgsu+2wgIZcjjMDkmW/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5geiPFEkBrjZu6GPp8JoN/W2e5GNtyz6c3Ph9YOXQi2iuYWG9d5KZo6vQ20lsMAAPpU1pVA9y54uW3Gh5d2AZLxU1RBE5AzE0KA3gRQ4+5jvtF7ax+flHTCGwV6tE+6kAm5Q8sespJoUEdu/B+ip/vx/sBveLKa9eM1aboKacs0UGJoqikDVLx59R5gn5hkWgX1Xmm6vhWsQkxpECsEd7+1UNaF1i+rOrDdyYgfIx0OfpdGdEhypRYsdVtfuOG1tVkzkWb3x5s9s5GBl6wgdFmG4AXSdAiSKCegokhH/Zrm8nqbRO0ifp6c9Hu30dGnsXe34OD+ANbQKD8jXZu9Ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fl4G5tdu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fl4G5tdu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z4p0F17Dsz2xCW
	for <linux-erofs@lists.ozlabs.org>; Sun,  2 Mar 2025 01:50:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740840616; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wz9frzctN1J75p3iB2EhAvBmgsu+2wgIZcjjMDkmW/o=;
	b=fl4G5tduyYpplGZuyDIpuq0CEuzBMg1get/fGRjDFXQzOgboeTgKdw7AWVZuDXcRGtoAfLMzDMRlVPwQa4hwEFQBuddMeJ94TgP9EapOsnO9RTMuUpH9CJIwN77hw3QoMJCPrDQSRXg0UATVtbz9L95F6NDwHCD7HmJswNpzw0E=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WQSgWR0_1740840615 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 01 Mar 2025 22:50:15 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v6 4/7] erofs: introduce the page cache share feature
Date: Sat,  1 Mar 2025 22:49:41 +0800
Message-ID: <20250301145002.2420830-5-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
References: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
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
content of these page caches is the same. For example, reading
identical files (e.g., *.so files) from two different minor versions of
container images will cost multiple copies of the same page cache,
since different containers have different mount points. Therefore,
sharing the page cache for files with the same content can save memory.

This introduces the page cache share feature in erofs. It allocate a
deduplicated inode and use its page cache as shared. Reads for files
with identical content will ultimately be routed to the page cache of
the deduplicated inode. In this way, a single page cache satisfies
multiple read requests for different files with the same contents.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/Makefile   |   1 +
 fs/erofs/internal.h |  17 ++++
 fs/erofs/ishare.c   | 238 ++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/ishare.h   |  28 ++++++
 fs/erofs/super.c    |  28 +++++-
 5 files changed, 311 insertions(+), 1 deletion(-)
 create mode 100644 fs/erofs/ishare.c
 create mode 100644 fs/erofs/ishare.h

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 4331d53c7109..2eb35bec8472 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -9,3 +9,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
+erofs-$(CONFIG_EROFS_FS_INODE_SHARE) += ishare.o
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 21bf9b694048..49613b257a6a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -286,6 +286,22 @@ struct erofs_inode {
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+	union {
+		/* internal dedup inode */
+		struct {
+			char *fingerprint;
+			spinlock_t lock;
+			/* all backing inodes */
+			struct list_head backing_head;
+		};
+
+		struct {
+			struct inode *ishare;
+			struct list_head backing_link;
+		};
+	};
+#endif
 	/* the corresponding vfs inode */
 	struct inode vfs_inode;
 };
@@ -382,6 +398,7 @@ extern const struct inode_operations erofs_dir_iops;
 
 extern const struct file_operations erofs_file_fops;
 extern const struct file_operations erofs_dir_fops;
+extern const struct file_operations erofs_ishare_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
new file mode 100644
index 000000000000..77786ec6834e
--- /dev/null
+++ b/fs/erofs/ishare.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024, Alibaba Cloud
+ */
+#include <linux/xxhash.h>
+#include <linux/refcount.h>
+#include <linux/mount.h>
+#include <linux/mutex.h>
+#include <linux/ramfs.h>
+#include "ishare.h"
+#include "internal.h"
+#include "xattr.h"
+
+static DEFINE_MUTEX(erofs_ishare_lock);
+static struct vfsmount *erofs_ishare_mnt;
+static refcount_t erofs_ishare_supers;
+
+int erofs_ishare_init(struct super_block *sb)
+{
+	struct vfsmount *mnt = NULL;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	if (!sbi->ishare_key)
+		return 0;
+
+	mutex_lock(&erofs_ishare_lock);
+	if (erofs_ishare_mnt) {
+		refcount_inc(&erofs_ishare_supers);
+	} else {
+		mnt = kern_mount(&erofs_anon_fs_type);
+		if (!IS_ERR(mnt)) {
+			erofs_ishare_mnt = mnt;
+			refcount_set(&erofs_ishare_supers, 1);
+		}
+	}
+	mutex_unlock(&erofs_ishare_lock);
+	return IS_ERR(mnt) ? PTR_ERR(mnt) : 0;
+}
+
+void erofs_ishare_exit(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct vfsmount *tmp;
+
+	if (!sbi->ishare_key || !erofs_ishare_mnt)
+		return;
+
+	kfree(sbi->ishare_key);
+
+	mutex_lock(&erofs_ishare_lock);
+	if (refcount_dec_and_test(&erofs_ishare_supers)) {
+		tmp = erofs_ishare_mnt;
+		erofs_ishare_mnt = NULL;
+		mutex_unlock(&erofs_ishare_lock);
+		kern_unmount(tmp);
+		mutex_lock(&erofs_ishare_lock);
+	}
+	mutex_unlock(&erofs_ishare_lock);
+}
+
+static int erofs_ishare_iget5_eq(struct inode *inode, void *data)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+
+	return vi->fingerprint && memcmp(vi->fingerprint, data,
+			sizeof(size_t) + *(size_t *)data) == 0;
+}
+
+static int erofs_ishare_iget5_set(struct inode *inode, void *data)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+
+	vi->fingerprint = data;
+	INIT_LIST_HEAD(&vi->backing_head);
+	spin_lock_init(&vi->lock);
+	return 0;
+}
+
+bool erofs_ishare_fill_inode(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
+	struct inode *idedup;
+	/*
+	 * fingerprint layout:
+	 * fingerprint length + fingerprint content (xattr_value + domain_id)
+	 */
+	char *ishare_key = sbi->ishare_key, *fingerprint;
+	ssize_t ishare_vlen;
+	unsigned long hash;
+	int key_idx;
+
+	if (!sbi->domain_id || !ishare_key)
+		return false;
+
+	key_idx = sbi->ishare_key_idx;
+	ishare_vlen = erofs_getxattr(inode, key_idx, ishare_key, NULL, 0);
+	if (ishare_vlen <= 0 || ishare_vlen > (1 << sbi->blkszbits))
+		return false;
+
+	fingerprint = kmalloc(sizeof(ssize_t) + ishare_vlen +
+			      strlen(sbi->domain_id), GFP_KERNEL);
+	if (!fingerprint)
+		return false;
+
+	*(ssize_t *)fingerprint = ishare_vlen + strlen(sbi->domain_id);
+	if (ishare_vlen != erofs_getxattr(inode, key_idx, ishare_key,
+					  fingerprint + sizeof(ssize_t),
+					  ishare_vlen)) {
+		kfree(fingerprint);
+		return false;
+	}
+
+	memcpy(fingerprint + sizeof(ssize_t) + ishare_vlen,
+	       sbi->domain_id, strlen(sbi->domain_id));
+	hash = xxh32(fingerprint + sizeof(ssize_t),
+		     ishare_vlen + strlen(sbi->domain_id), hash);
+	idedup = iget5_locked(erofs_ishare_mnt->mnt_sb, hash,
+			      erofs_ishare_iget5_eq, erofs_ishare_iget5_set,
+			      fingerprint);
+	if (!idedup) {
+		kfree(fingerprint);
+		return false;
+	}
+
+	INIT_LIST_HEAD(&vi->backing_link);
+	vi->ishare = idedup;
+	spin_lock(&EROFS_I(idedup)->lock);
+	list_add(&vi->backing_link, &EROFS_I(idedup)->backing_head);
+	spin_unlock(&EROFS_I(idedup)->lock);
+
+	if (!(idedup->i_state & I_NEW)) {
+		kfree(fingerprint);
+		return true;
+	}
+
+	if (erofs_inode_is_data_compressed(vi->datalayout))
+		idedup->i_mapping->a_ops = &z_erofs_aops;
+	else
+		idedup->i_mapping->a_ops = &erofs_aops;
+	idedup->i_mode = vi->vfs_inode.i_mode;
+	i_size_write(idedup, vi->vfs_inode.i_size);
+	unlock_new_inode(idedup);
+	return true;
+}
+
+void erofs_ishare_free_inode(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct inode *idedup = vi->ishare;
+
+	if (!idedup)
+		return;
+
+	spin_lock(&EROFS_I(idedup)->lock);
+	list_del(&vi->backing_link);
+	spin_unlock(&EROFS_I(idedup)->lock);
+	iput(idedup);
+	vi->ishare = NULL;
+}
+
+static int erofs_ishare_file_open(struct inode *realinode,
+				  struct file *realfile)
+{
+	struct file *file;
+	struct inode *inode;
+
+	inode = EROFS_I(realinode)->ishare;
+	if (!inode)
+		return -EINVAL;
+
+	file = alloc_file_pseudo(inode, erofs_ishare_mnt, "erofs_ishare_file",
+				 O_RDONLY, &erofs_file_fops);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	file_ra_state_init(&file->f_ra, realfile->f_mapping);
+	file->private_data = EROFS_I(realinode);
+	ihold(inode);
+
+	realfile->private_data = file;
+	return 0;
+}
+
+static int erofs_ishare_file_release(struct inode *inode, struct file *file)
+{
+	if (!file->private_data)
+		return -EINVAL;
+
+	fput((struct file *)file->private_data);
+	file->private_data = NULL;
+	return 0;
+}
+
+static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
+					   struct iov_iter *to)
+{
+	struct file *backing_file = iocb->ki_filp->private_data;
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct kiocb dedup_iocb;
+	ssize_t nread;
+
+	if (!iov_iter_count(to))
+		return 0;
+
+	/* fallback to the original file in DAX or DIRECT mode */
+	if (IS_DAX(inode) || (iocb->ki_flags & IOCB_DIRECT))
+		backing_file = iocb->ki_filp;
+
+	kiocb_clone(&dedup_iocb, iocb, backing_file);
+	nread = filemap_read(&dedup_iocb, to, 0);
+	iocb->ki_pos = dedup_iocb.ki_pos;
+	touch_atime(&iocb->ki_filp->f_path);
+
+	return nread;
+}
+
+static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct file *backing_file = file->private_data;
+
+	if (!backing_file)
+		return -EINVAL;
+
+	vma_set_file(vma, backing_file);
+	vma->vm_ops = &generic_file_vm_ops;
+	return 0;
+}
+
+const struct file_operations erofs_ishare_fops = {
+	.open		= erofs_ishare_file_open,
+	.llseek		= generic_file_llseek,
+	.read_iter	= erofs_ishare_file_read_iter,
+	.mmap		= erofs_ishare_mmap,
+	.release	= erofs_ishare_file_release,
+	.get_unmapped_area = thp_get_unmapped_area,
+	.splice_read	= filemap_splice_read,
+};
diff --git a/fs/erofs/ishare.h b/fs/erofs/ishare.h
new file mode 100644
index 000000000000..54f2251c8179
--- /dev/null
+++ b/fs/erofs/ishare.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024, Alibaba Cloud
+ */
+#ifndef __EROFS_ISHARE_H
+#define __EROFS_ISHARE_H
+
+#include <linux/fs.h>
+#include <linux/spinlock.h>
+#include "internal.h"
+
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+
+int erofs_ishare_init(struct super_block *sb);
+void erofs_ishare_exit(struct super_block *sb);
+bool erofs_ishare_fill_inode(struct inode *inode);
+void erofs_ishare_free_inode(struct inode *inode);
+
+#else
+
+static inline int erofs_ishare_init(struct super_block *sb) { return 0; }
+static inline void erofs_ishare_exit(struct super_block *sb) {}
+static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
+static inline void erofs_ishare_free_inode(struct inode *inode) {}
+
+#endif // CONFIG_EROFS_FS_INODE_SHARE
+
+#endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index ceab0c29b061..98d8b58afe5e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -13,6 +13,7 @@
 #include <linux/backing-dev.h>
 #include <linux/pseudo_fs.h>
 #include "xattr.h"
+#include "ishare.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/erofs.h>
@@ -857,9 +858,34 @@ static struct file_system_type erofs_fs_type = {
 };
 MODULE_ALIAS_FS("erofs");
 
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+static void erofs_free_dedup_inode(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+
+	kfree(vi->fingerprint);
+	kmem_cache_free(erofs_inode_cachep, vi);
+};
+#else
+#define erofs_free_dedup_inode NULL
+#endif
+
+static const struct super_operations erofs_anon_sops = {
+	.statfs = simple_statfs,
+	.alloc_inode = erofs_alloc_inode,
+	.free_inode = erofs_free_dedup_inode,
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

