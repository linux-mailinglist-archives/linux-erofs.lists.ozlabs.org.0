Return-Path: <linux-erofs+bounces-1371-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 385F9C5C731
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Nov 2025 11:07:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d7CVN6Tfxz2yxl;
	Fri, 14 Nov 2025 21:07:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763114828;
	cv=none; b=Bc2Vutd60TeFkhU1vWXHzR0AGedMRZBFeyqmffsR1uZxWyzZyN9Mi8WcpOA7Uo6hbW5kKOSFZY1j83VluHMkxNfFuhyVLeoUa4I0m/1pSfuDbPTCUX/f53jHZ6wmR/5ItGsScWZEZnrh6BtUf1xtEEEIVPYCewuVvPSZGtEc/yT3exSqV0no1n6qonOvR/9+gcX0gOQ8PQ2cj2ZN2u8+5vf1PgJdqZb8V0l0LVgKXFFkrNkO5lfqPbjvRIKX9RvyUYGsP2SG3h2gsahvheICdeO4y84AoTFbNKos40Kilc4/GcHdi9NYGwWVRepPLEPACmwGR+ItVC3ylKW6kuDlGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763114828; c=relaxed/relaxed;
	bh=B8DEAHKpK8WFmqiYDgExYub+7n82n1eSz+k73lgwcIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e934q5mya0anRmg1atHU/CS5RIqr/E76AP9H94PepF0sEnDAQ/DWAwf9FUqcZLswUdNw0bu/8XYQMlLPI7YfKb7K0xHruEZPx/b/EkiCj25P1j33RlbxAdwgahWPXm0/h1SbjU+VmiKu66coJ5w9/APLavWZjJz4gHoXD7st0eZWR+WsWCBN6pt2EP7yJ9o04aifttG8fZwAPnegQ0jRGG8L7YfZ83ZYcSmyx82dBDY//Ux8UXVRs4cQmGXM396unEval2Mqwk8Pwx79o67uORAJayAk2dqiu4fFxX3f7T27dEpp2DGJc+GO3QVG+5nzp8z0zeZ6gioDiUcAyTGPdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=rXhUHCQ0; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=rXhUHCQ0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d7CVF4fTbz302V
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Nov 2025 21:07:01 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=B8DEAHKpK8WFmqiYDgExYub+7n82n1eSz+k73lgwcIA=;
	b=rXhUHCQ0OCNMaLxGqkoD0iVLr0a0GLdR8MKCrc+ucPKFRlxh8tiBC6xH7AZwLRXVImaq0h/Xy
	+zDAmvRsIYs6zluNdSzF98zCG2ueK6o1AWnIuTvhKkDpljnjfgtjBkggsnNpLpw5/SUdAIJi8Zu
	CjNp7t8ooG1xFuRch4lk340=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d7CS04CMBzcZxm;
	Fri, 14 Nov 2025 18:05:04 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id B7E83180494;
	Fri, 14 Nov 2025 18:06:57 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 14 Nov
 2025 18:06:57 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 6/9] erofs: introduce the page cache share feature
Date: Fri, 14 Nov 2025 09:55:13 +0000
Message-ID: <20251114095516.207555-7-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251114095516.207555-1-lihongbo22@huawei.com>
References: <20251114095516.207555-1-lihongbo22@huawei.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

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
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/Makefile   |   1 +
 fs/erofs/internal.h |  32 +++++-
 fs/erofs/ishare.c   | 236 ++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/ishare.h   |  28 ++++++
 fs/erofs/super.c    |  30 +++++-
 5 files changed, 324 insertions(+), 3 deletions(-)
 create mode 100644 fs/erofs/ishare.c
 create mode 100644 fs/erofs/ishare.h

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 549abc424763..102a23bf5dec 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -10,3 +10,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
+erofs-$(CONFIG_EROFS_FS_INODE_SHARE) += ishare.o
\ No newline at end of file
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3ebbb7c5d085..26772458fda7 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -193,7 +193,7 @@ static inline bool erofs_is_fileio_mode(struct erofs_sb_info *sbi)
 	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->dif0.file;
 }
 
-#if defined(CONFIG_EROFS_FS_ONDEMAND)
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_INODE_SHARE)
 extern struct file_system_type erofs_anon_fs_type;
 #endif
 
@@ -203,6 +203,19 @@ static inline bool erofs_is_fscache_mode(struct super_block *sb)
 			!erofs_is_fileio_mode(EROFS_SB(sb)) && !sb->s_bdev;
 }
 
+#if defined(CONFIG_EROFS_FS_INODE_SHARE)
+static inline bool erofs_is_ishare_inode(struct inode *inode)
+{
+	/* we have assumed FS_ONDEMAND is excluded with FS_INODE_SHARE feature */
+	return inode->i_sb->s_type == &erofs_anon_fs_type;
+}
+#else
+static inline bool erofs_is_ishare_inode(struct inode *inode)
+{
+	return false;
+}
+#endif
+
 enum {
 	EROFS_ZIP_CACHE_DISABLED,
 	EROFS_ZIP_CACHE_READAHEAD,
@@ -310,6 +323,22 @@ struct erofs_inode {
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
@@ -416,6 +445,7 @@ extern const struct inode_operations erofs_dir_iops;
 
 extern const struct file_operations erofs_file_fops;
 extern const struct file_operations erofs_dir_fops;
+extern const struct file_operations erofs_ishare_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
new file mode 100644
index 000000000000..910b732bf8e7
--- /dev/null
+++ b/fs/erofs/ishare.c
@@ -0,0 +1,236 @@
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
+	mutex_lock(&erofs_ishare_lock);
+	if (refcount_dec_and_test(&erofs_ishare_supers)) {
+		tmp = erofs_ishare_mnt;
+		erofs_ishare_mnt = NULL;
+		mutex_unlock(&erofs_ishare_lock);
+		kern_unmount(tmp);
+		mutex_lock(&erofs_ishare_lock);
+	}
+	mutex_unlock(&erofs_ishare_lock);
+	kfree(sbi->ishare_key);
+	sbi->ishare_key = NULL;
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
+static int erofs_ishare_file_open(struct inode *inode, struct file *file)
+{
+	struct file *realfile;
+	struct inode *dedup;
+
+	dedup = EROFS_I(inode)->ishare;
+	if (!dedup)
+		return -EINVAL;
+
+	realfile = alloc_file_pseudo(dedup, erofs_ishare_mnt, "erofs_ishare_file",
+				     O_RDONLY, &erofs_file_fops);
+	if (IS_ERR(realfile))
+		return PTR_ERR(realfile);
+
+	file_ra_state_init(&realfile->f_ra, file->f_mapping);
+	realfile->private_data = EROFS_I(inode);
+	file->private_data = realfile;
+	return 0;
+}
+
+static int erofs_ishare_file_release(struct inode *inode, struct file *file)
+{
+	struct file *realfile = file->private_data;
+
+	if (!realfile)
+		return -EINVAL;
+	fput(realfile);
+	realfile->private_data = NULL;
+	return 0;
+}
+
+static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
+						    struct iov_iter *to)
+{
+	struct file *realfile = iocb->ki_filp->private_data;
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct kiocb dedup_iocb;
+	ssize_t nread;
+
+	if (!realfile)
+		return -EINVAL;
+	if (!iov_iter_count(to))
+		return 0;
+
+	/* fallback to the original file in DAX or DIRECT mode */
+	if (IS_DAX(inode) || (iocb->ki_flags & IOCB_DIRECT))
+		realfile = iocb->ki_filp;
+
+	kiocb_clone(&dedup_iocb, iocb, realfile);
+	nread = filemap_read(&dedup_iocb, to, 0);
+	iocb->ki_pos = dedup_iocb.ki_pos;
+	touch_atime(&iocb->ki_filp->f_path);
+	return nread;
+}
+
+static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct file *realfile = file->private_data;
+
+	if (!realfile)
+		return -EINVAL;
+
+	vma_set_file(vma, realfile);
+	return generic_file_readonly_mmap(file, vma);
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
index ce95454c9ee7..613dfbe988de 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -13,6 +13,7 @@
 #include <linux/backing-dev.h>
 #include <linux/pseudo_fs.h>
 #include "xattr.h"
+#include "ishare.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/erofs.h>
@@ -81,6 +82,10 @@ static void erofs_free_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 
+	if (erofs_is_ishare_inode(inode)) {
+		erofs_free_dedup_inode(vi);
+		return;
+	}
 	if (inode->i_op == &erofs_fast_symlink_iops)
 		kfree(inode->i_link);
 	kfree(vi->xattr_shared_xattrs);
@@ -926,10 +931,31 @@ static struct file_system_type erofs_fs_type = {
 };
 MODULE_ALIAS_FS("erofs");
 
-#if defined(CONFIG_EROFS_FS_ONDEMAND)
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_INODE_SHARE)
+static void erofs_free_anon_inode(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+	kfree(vi->fingerprint);
+#endif
+	kmem_cache_free(erofs_inode_cachep, vi);
+}
+
+static const struct super_operations erofs_anon_sops = {
+	.alloc_inode = erofs_alloc_inode,
+	.free_inode = erofs_free_anon_inode,
+};
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
2.22.0


