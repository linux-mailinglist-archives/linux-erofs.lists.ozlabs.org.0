Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908A39685B1
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 13:06:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy5YJ4XYfz2yNf
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 21:06:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725275203;
	cv=none; b=ihv2WAKTThHBRR9KoW0dNZH/PCe0oOy7Xc4IYUCG6MzxOmCbYGx0MJVgq62OPfj7QcQDXHHnLQrGRStuFyBG0SyR/97NE5lY8xkApPlKuToi27dmHd5NYr2YRww7q6jArIM/Bbue7aLHn1yHQRem0iFg5QLQrnzcDfhwrggwXfVsu9VmxFJlaIxJ79s/ffWTnpQ77KodjGCO2CjdiyuDloe+14pE9kaA8bVeS3DDxX31gUzpOJj5UczZxo0rbr37TYWwaBG2SYpWToNEpcyeVX2YaiRqLCeM9fP41IwWJDy3o9MgghekOlH6mmGEdtVRDF72JUXDZL6SYT09ssD/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725275203; c=relaxed/relaxed;
	bh=HmnuGVS/tsuwLc1eMgnltdcvukWN1aa5ke3kJ2BOAww=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version; b=oeXx3d3OI8oEYaNf3VzPDQfAzWifK21PZ1U98FCKe7MvRW3npx5iRJvz/7Vk4JRjiMQjgGOeYTohqz16Sg1mlKJi1ikvryWv3rDjr+GP/qXkh0Q37e0bKkiT1Nz9oLmo6wX/g7d3JmAoIwdl7g6iZwu7RrjPCcdRZflSj6G+1IoPD3zQhcM4NtxhABxhEN9N12QaYtYx+XLFuAUP+e9hOknagO5pn5vin1Kb0XEF0mp5gXDHVYtXaP9+dgggdw1xLwvVPt8tJiD5nWjFIP/+0N+aKXsLP8i5+slmsEFyi6bsgZ+yJ1weIbLFuwiulIuVaHuztKn+1TZRGJSvfb/gMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Wjw/gC4e; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Wjw/gC4e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy5YG5rwvz2xHW
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 21:06:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725275199; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HmnuGVS/tsuwLc1eMgnltdcvukWN1aa5ke3kJ2BOAww=;
	b=Wjw/gC4eSgBP6oMwKKEO5kRNBMwha+u+nzxgbhm0XCavojeiZADS0W/+DvIzS+9GbRIhe13/CAq9cIhXmuI5tntAKMrQGY3jmBBSET1bfLlCeRflMwuOQAj33Qbqq4KceKvMrCV5JBp/2rn9UAiC+9IJKvg3yBtvRwIWAwbE7Ug=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WE7X3AN_1725275197)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 19:06:38 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH RFC v4 2/4] erofs: introduce page cache share feature
Date: Mon,  2 Sep 2024 19:06:18 +0800
Message-ID: <20240902110620.2202586-3-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240902110620.2202586-1-hongzhen@linux.alibaba.com>
References: <20240902110620.2202586-1-hongzhen@linux.alibaba.com>
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
---
v4: There are no changes compared to v3.
v3: https://lore.kernel.org/all/20240828111959.3677011-3-hongzhen@linux.alibaba.com/
v2: https://lore.kernel.org/all/20240731080704.678259-2-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240722065355.1396365-4-hongzhen@linux.alibaba.com/
---
 fs/erofs/Kconfig           |  10 +++
 fs/erofs/Makefile          |   1 +
 fs/erofs/internal.h        |   4 +
 fs/erofs/pagecache_share.c | 171 +++++++++++++++++++++++++++++++++++++
 fs/erofs/pagecache_share.h |  20 +++++
 5 files changed, 206 insertions(+)
 create mode 100644 fs/erofs/pagecache_share.c
 create mode 100644 fs/erofs/pagecache_share.h

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 7dcdce660cac..756a74de623c 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -158,3 +158,13 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
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
index 097d672e6b14..f14a2ac0e561 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -8,3 +8,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
 erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
+erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += pagecache_share.o
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3d6bb1b36378..358377825927 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -288,6 +288,9 @@ struct erofs_inode {
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	struct inode *ano_inode;
+#endif
 	/* the corresponding vfs inode */
 	struct inode vfs_inode;
 };
@@ -384,6 +387,7 @@ extern const struct inode_operations erofs_dir_iops;
 
 extern const struct file_operations erofs_file_fops;
 extern const struct file_operations erofs_dir_fops;
+extern const struct file_operations erofs_pcs_file_fops;
 
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
diff --git a/fs/erofs/pagecache_share.c b/fs/erofs/pagecache_share.c
new file mode 100644
index 000000000000..2d2a74547b67
--- /dev/null
+++ b/fs/erofs/pagecache_share.c
@@ -0,0 +1,171 @@
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
+	mutex_lock(&pseudo_mnt_lock);
+	if (!erofs_pcs_mnt) {
+		struct vfsmount *tmp = kern_mount(&erofs_anon_fs_type);
+		if (IS_ERR(tmp))
+			return PTR_ERR(tmp);
+		erofs_pcs_mnt = tmp;
+		refcount_set(&pseudo_mnt_count, 1);
+	} else
+		refcount_add(1, &pseudo_mnt_count);
+	mutex_unlock(&pseudo_mnt_lock);
+	return 0;
+}
+
+void erofs_pcs_free_mnt(void)
+{
+	mutex_lock(&pseudo_mnt_lock);
+	if (refcount_dec_and_test(&pseudo_mnt_count)) {
+		kern_unmount(erofs_pcs_mnt);
+		erofs_pcs_mnt = NULL;
+	}
+	mutex_unlock(&pseudo_mnt_lock);
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
+			fprt + sizeof(size_t), PCS_FPRT_MAXLEN);
+	if (fprt_len > 0 && fprt_len <= PCS_FPRT_MAXLEN) {
+		*(size_t *)fprt = fprt_len;
+		fprt_hash = xxh32(fprt + sizeof(size_t), fprt_len, 0);
+		ano_inode = iget5_locked(erofs_pcs_mnt->mnt_sb, fprt_hash,
+				erofs_pcs_eq, erofs_pcs_set_fprt, fprt);
+		vi->ano_inode = ano_inode;
+		if (ano_inode->i_state & I_NEW) {
+			if (erofs_inode_is_data_compressed(vi->datalayout))
+				ano_inode->i_mapping->a_ops = &z_erofs_aops;
+			else
+				ano_inode->i_mapping->a_ops =
+						&erofs_raw_access_aops;
+			ano_inode->i_size = inode->i_size;
+			unlock_new_inode(ano_inode);
+		}
+	}
+}
+
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
+	ano_file = erofs_pcs_alloc_file(file, ano_inode);
+	ihold(ano_inode);
+	file->private_data = (void *)ano_file;
+	return 0;
+}
+
+static int erofs_pcs_file_release(struct inode *inode, struct file *file)
+{
+	if (!file->private_data)
+		return -EINVAL;
+	fput((struct file *)file->private_data);
+	file->private_data = NULL;
+	return 0;
+}
+
+static ssize_t erofs_pcs_file_read_iter(struct kiocb *iocb,
+					struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
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
2.43.5

