Return-Path: <linux-erofs+bounces-505-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9EBAF73D3
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Jul 2025 14:23:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bXwsm0QkBz2yhX;
	Thu,  3 Jul 2025 22:23:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751545420;
	cv=none; b=BsSauL13WvBCpI3TkCFQAwxpiRSd8IQxMTZykAUoIJnuK1fX6DF4aE6O+oukuLvDjPLUWFPwfJ26VzNy7wIkQPEx564+DPXVu0SfPxHj7mX0YpvHUpMU5XJLQeH6mVyDuto4bxH8WN4oC/3vm2gvEqodaHhWDI6CUYzpM0KF/qHYe45/zhCKY3bTEYV7ScSZgbG5HittaVkbDHjvT8SlR3DjEaqPUbTcVhM6r9jwyg2IBCx8jwIwiHF30VmWYr2tqc1+B7RkdBFCQuw6+4uGdQWYGUVZoWKfaNwGFixopscrP9LFddbRyKAzIoXbcC0uO3MP5TDIEMwrGE0aWtC1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751545420; c=relaxed/relaxed;
	bh=gGX2eSp3noGOiHSK/Y7Bb874ytPJ5wLSEp258XA+7DM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SI5qS02YYIr5gAs8nfn948yN/K3zSjGDn90UQoAybSwAKz+gFro334FjpwkkubL/A9u0EDkCYVgJMOJztcIajpCMjcxp5cpDgX7kd0BNb0X5QEHqgDfrk54y8Pd/Xu+vn3Ik3toIss13c71aLuu23XYwERv3y/W5aZKks82qWiHFwLeiiOzLeRoUHFTEXU9KXdDUcv7+aypxBfRNd2IZvwf3dwoK70XDTT24+8LrFzSIGZPvEsNtnunC+00uuLSFy5UydhewCJURqpfBlzdVOfnc8hw1SN1YtcpzbOIZHprVuLkOrk2x7PJ7QGaoPaD2QnTTnl27oVWlmqas9spBFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oUQhOBKh; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oUQhOBKh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bXwsl110vz2xgQ
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Jul 2025 22:23:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1888FA53812;
	Thu,  3 Jul 2025 12:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372E6C4CEE3;
	Thu,  3 Jul 2025 12:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751545416;
	bh=Cusw8930KUPg28Ezjji3qWM6B1ybXsAQzl/8OF+yWM4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oUQhOBKhAOhFyS6C0iaOTcDEDnr6DmbGnCw1QTohUxgWBkdNtAVXRJIfUudemCRXK
	 VGl8m+WZhULrytfY/p+VHFoc23Y8AKZeNHzFmHJhT8cOQw2Bn3eN6iXyyZonme2/+w
	 YmFQQGPDmFzmHxpl2lzSOEYkHag01OGtTQeCXYX+MzzW+drtgClX5FGqL+diX8H7g+
	 rbJOTfZajSY3Z7FAtppYHs3ivyBsvLF/t4Ni08xcNdo+nl1hWdISPJtCpN0zKLH3tf
	 3SgGJAnRi0eXU14VY/RB7EpNBEY8H823f4g2rPDdWT0YmfB4mgYyYq1n5PO2ltHeuH
	 dyxhg0bv+K4bQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 03 Jul 2025 14:23:11 +0200
Subject: [PATCH RFC 2/4] erofs: introduce page cache share feature
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-work-erofs-pcs-v1-2-0ce1f6be28ee@kernel.org>
References: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
In-Reply-To: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
To: Gao Xiang <xiang@kernel.org>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Hongzhen Luo <hongzhen@linux.alibaba.com>, 
 Matthew Wilcox <willy@infradead.org>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=13723; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ig4xJQvREPJZ0YdDnBYL31AgHqGLWLxXZQz3uImp154=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSkldnfuX3nVrOoRqQZ0+W13Vzbw9s3zOdK+xmYPjtsr
 9+sgr9fO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy5jfD/0DTj7ayijkvDXXd
 y35K/hAqEZlWKpQy54DYNr4d04J+ZTMy7DT6/Td4vdy7Zr8Hq1s1SjYEMzHEvORZskZy0ubUo+K
 /eAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

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

Below is the memory usage for reading all files in two different minor
versions of container images:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     241     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     872     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |     630     |      28%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     2771    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  1.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     926     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     390     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     924     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |     474     |      49%      |
+-------------------+------------------+-------------+---------------+

Additionally, the table below shows the runtime memory usage of the
container:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      35     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     149     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |      95     |      37%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     1028    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  1.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     155     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      25     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     186     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |      98     |      48%      |
+-------------------+------------------+-------------+---------------+

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Link: https://lore.kernel.org/20240902110620.2202586-3-hongzhen@linux.alibaba.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/erofs/Kconfig           |  10 +++
 fs/erofs/Makefile          |   1 +
 fs/erofs/internal.h        |   4 +
 fs/erofs/pagecache_share.c | 204 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/pagecache_share.h |  20 +++++
 5 files changed, 239 insertions(+)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 6beeb7063871..553770068fee 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -192,3 +192,13 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
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
index 549abc424763..f4141fdfcb0b 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -10,3 +10,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
+erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += pagecache_share.o
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 30380f7baf5e..47136894d17d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -273,6 +273,9 @@ struct erofs_inode {
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	struct inode *ano_inode;
+#endif
 	/* the corresponding vfs inode */
 	struct inode vfs_inode;
 };
@@ -369,6 +372,7 @@ extern const struct inode_operations erofs_dir_iops;
 
 extern const struct file_operations erofs_file_fops;
 extern const struct file_operations erofs_dir_fops;
+extern const struct file_operations erofs_pcs_file_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
diff --git a/fs/erofs/pagecache_share.c b/fs/erofs/pagecache_share.c
new file mode 100644
index 000000000000..309b33cc6c30
--- /dev/null
+++ b/fs/erofs/pagecache_share.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024, Alibaba Cloud
+ */
+#include <linux/xxhash.h>
+#include <linux/refcount.h>
+#include "pagecache_share.h"
+#include "internal.h"
+#include "xattr.h"
+
+#define PCS_FPRT_IDX	4
+#define PCS_FPRT_NAME	"erofs.fingerprint"
+#define PCS_FPRT_MAXLEN (sizeof(size_t) + 1024)
+
+static DEFINE_MUTEX(pseudo_mnt_lock);
+static refcount_t pseudo_mnt_count;
+static struct vfsmount *erofs_pcs_mnt;
+
+int erofs_pcs_init_mnt(void)
+{
+	struct vfsmount *mnt;
+
+	if (refcount_inc_not_zero(&pseudo_mnt_count))
+		return 0;
+
+	guard(mutex)(&pseudo_mnt_lock);
+	if (erofs_pcs_mnt) {
+		refcount_inc(&pseudo_mnt_count);
+		return 0;
+	}
+
+	mnt = kern_mount(&erofs_anon_fs_type);
+	if (IS_ERR(mnt))
+		return PTR_ERR(mnt);
+
+	rcu_read_lock();
+	rcu_assign_pointer(erofs_pcs_mnt, mnt);
+	rcu_read_unlock();
+	refcount_set_release(&pseudo_mnt_count, 1);
+	return 0;
+}
+
+void erofs_pcs_free_mnt(void)
+{
+	struct vfsmount *mnt = NULL;
+
+	if (refcount_dec_not_one(&pseudo_mnt_count))
+		return;
+
+	scoped_guard(mutex, &pseudo_mnt_lock) {
+		rcu_read_lock();
+		if (refcount_dec_and_test(&pseudo_mnt_count))
+			mnt = rcu_replace_pointer(erofs_pcs_mnt, NULL, true);
+		rcu_read_unlock();
+	}
+	if (mnt)
+		kern_unmount(mnt);
+}
+
+static int erofs_pcs_eq(struct inode *inode, void *data)
+{
+	return inode->i_private && memcmp(inode->i_private, data,
+			sizeof(size_t) + *(size_t *)data) == 0 ? 1 : 0;
+}
+
+static int erofs_pcs_set_fprt(struct inode *inode, void *data)
+{
+	/* fprt length and content */
+	inode->i_private = kmalloc(*(size_t *)data + sizeof(size_t),
+				   GFP_KERNEL);
+	memcpy(inode->i_private, data, sizeof(size_t) + *(size_t *)data);
+	return 0;
+}
+
+void erofs_pcs_fill_inode(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	char fprt[PCS_FPRT_MAXLEN];
+	struct inode *ano_inode;
+	unsigned long fprt_hash;
+	size_t fprt_len;
+
+	vi->ano_inode = NULL;
+	fprt_len = erofs_getxattr(inode, PCS_FPRT_IDX, PCS_FPRT_NAME,
+				  fprt + sizeof(size_t), PCS_FPRT_MAXLEN);
+	if (fprt_len > 0 && fprt_len <= PCS_FPRT_MAXLEN) {
+		*(size_t *)fprt = fprt_len;
+		fprt_hash = xxh32(fprt + sizeof(size_t), fprt_len, 0);
+		ano_inode = iget5_locked(erofs_pcs_mnt->mnt_sb, fprt_hash,
+					 erofs_pcs_eq, erofs_pcs_set_fprt,
+					 fprt);
+		vi->ano_inode = ano_inode;
+		if (ano_inode->i_state & I_NEW) {
+			if (erofs_inode_is_data_compressed(vi->datalayout))
+				ano_inode->i_mapping->a_ops = &z_erofs_aops;
+			else
+				ano_inode->i_mapping->a_ops = &erofs_aops;
+			ano_inode->i_size = inode->i_size;
+			unlock_new_inode(ano_inode);
+		}
+	}
+}
+
+/*
+ * TODO: Hm, could we leverage our fancy new backing file infrastructure
+ * as for overlayfs and fuse?
+ */
+static struct file *erofs_pcs_alloc_file(struct file *file,
+					 struct inode *ano_inode)
+{
+	struct file *ano_file;
+
+	ano_file = alloc_file_pseudo(ano_inode, erofs_pcs_mnt, "[erofs_pcs_f]",
+				     O_RDONLY, &erofs_file_fops);
+	file_ra_state_init(&ano_file->f_ra, file->f_mapping);
+	ano_file->private_data = EROFS_I(file_inode(file));
+	return ano_file;
+}
+
+static int erofs_pcs_file_open(struct inode *inode, struct file *file)
+{
+	struct file *ano_file;
+	struct inode *ano_inode;
+	struct erofs_inode *vi = EROFS_I(inode);
+
+	ano_inode = vi->ano_inode;
+	if (!ano_inode)
+		return -EINVAL;
+
+	ano_file = erofs_pcs_alloc_file(file, ano_inode);
+	if (IS_ERR(ano_file))
+		return PTR_ERR(ano_file);
+
+	file->private_data = ano_file;
+	return 0;
+}
+
+static int erofs_pcs_file_release(struct inode *inode, struct file *file)
+{
+	struct file *ano_file __free(fput) = NULL;
+
+	if (WARN_ON_ONCE(!file->private_data))
+		return -EINVAL;
+
+	swap(file->private_data, ano_file);
+	return 0;
+}
+
+static ssize_t erofs_pcs_file_read_iter(struct kiocb *iocb,
+					struct iov_iter *to)
+{
+	struct file *file, *ano_file;
+	struct kiocb ano_iocb;
+	ssize_t res;
+
+	if (!iov_iter_count(to))
+		return 0;
+
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(inode))
+		return iocb->ki_filp->f_op->read_iter(iocb, to);
+#endif
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return iocb->ki_filp->f_op->read_iter(iocb, to);
+
+	memcpy(&ano_iocb, iocb, sizeof(struct kiocb));
+	file = iocb->ki_filp;
+	ano_file = file->private_data;
+	if (WARN_ON_ONCE(!ano_file))
+		return -EINVAL;
+	ano_iocb.ki_filp = ano_file;
+	res = filemap_read(&ano_iocb, to, 0);
+	memcpy(iocb, &ano_iocb, sizeof(struct kiocb));
+	iocb->ki_filp = file;
+	file_accessed(file);
+	return res;
+}
+
+/*
+ * TODO: Amir, you've got some experience in this area due to overlayfs
+ * and fuse. Does that work?
+ */
+static int erofs_pcs_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct file *ano_file = file->private_data;
+
+	vma_set_file(vma, ano_file);
+	vma->vm_ops = &generic_file_vm_ops;
+	return 0;
+}
+
+const struct file_operations erofs_pcs_file_fops = {
+	.open		= erofs_pcs_file_open,
+	/*
+	 * TODO: Why doesn't .llseek require similar treatment as
+	 * .read_iter?
+	 */
+	.llseek		= generic_file_llseek,
+	.read_iter	= erofs_pcs_file_read_iter,
+	.mmap		= erofs_pcs_mmap,
+	.release	= erofs_pcs_file_release,
+	.get_unmapped_area = thp_get_unmapped_area,
+	.splice_read	= filemap_splice_read,
+};
diff --git a/fs/erofs/pagecache_share.h b/fs/erofs/pagecache_share.h
new file mode 100644
index 000000000000..b8111291cf79
--- /dev/null
+++ b/fs/erofs/pagecache_share.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024, Alibaba Cloud
+ */
+#ifndef __EROFS_PAGECACHE_SHARE_H
+#define __EROFS_PAGECACHE_SHARE_H
+
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/rwlock.h>
+#include <linux/mutex.h>
+#include "internal.h"
+
+int erofs_pcs_init_mnt(void);
+void erofs_pcs_free_mnt(void);
+void erofs_pcs_fill_inode(struct inode *inode);
+
+extern const struct vm_operations_struct generic_file_vm_ops;
+
+#endif

-- 
2.47.2


