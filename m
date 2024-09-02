Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE699685B6
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 13:06:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy5YV2Zdkz2yN8
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 21:06:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725275212;
	cv=none; b=knDWsBmvPJPQe2kM+fFbw+f7pJ96ds4K4Ylh9YDnsJQ4n+StTL9B97CjeRY16p9H+b7hDYwaI9goGALVa4TPg34AmN8oZoTXZPuop3hhzqFg5A5dLPfTyNaK2lQG3gf9t0KHQqd+qn0imgzzgBkX/CxcuqBBspbxqp6NnndD81rLb7khCQ/GLC6TV+ovq0+p8ylBZKqn550iwhivVzQyG5ArJ06UVZbBi5j+jQAkC0pI9Y82xCZPoZ9ccxiVkjEURbas0SqLX4d6CwMc7fDpQSPmvq9flGrZs1SW/ww/a6eGq9oGCrfGdsAfnFZuNiLW98mpQlEQMJUYJasV0+aYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725275212; c=relaxed/relaxed;
	bh=8F/K6gXuWQR15VccFVhsO1O0QRvNL2x4hMbfePUdpfk=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version; b=gDNrxnyHFnIlxZownX6Iex4GauuWYb0Oku0/Lfg2lXvr29pzQAVpvJgbeTRWnFl7CKXfivaEtI/AjjzZduCVhqjAWcc02RK48NvVgpE3FYIQdF6hPQXVDY2KFc8/MopgMRTpRE9LSJ4mBFxfBpRG+0m03yjeqpmm7tEb5cTT0Bs+9WXTqIrKtOqiQAESm2vpHKfbRYZPRQ2ea4pph/uLasdNO2IH8ButKs1GBz55AqwHEqCuFOgM77CXd5SWPqGD5uLyoYSQTNWbxMiV4uWV7cW8Wy9Q8k3VFYettQFP0jYKVLT/LepGVRI/IU1ED/LpZ9fKjyZbFa7FYLIySKaDBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dMTx/KnC; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dMTx/KnC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy5YS08KSz2xfq
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 21:06:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725275208; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8F/K6gXuWQR15VccFVhsO1O0QRvNL2x4hMbfePUdpfk=;
	b=dMTx/KnCnAfWkiFktEsr9jY6aSLbJ0FhyQCffT0Bt4QjmZamHf8NoHE2PjfuKtZ3PL16jEy03BgI+luCsjQuqZXjM55qzX4/D3hxguR02hJBsPr3Ei7okkADXW2NPWh/U/5xbnJozOX+8zCf5bqXAfDosbtTLP2jVTxJYbxTEfc=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WE8BYL5_1725275206)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 19:06:47 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH RFC v4 4/4] erofs: introduce .fadvise for page cache share
Date: Mon,  2 Sep 2024 19:06:20 +0800
Message-ID: <20240902110620.2202586-5-hongzhen@linux.alibaba.com>
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

When using .fadvice to release a file's page cache, it frees
those page caches that were firstly read by this file. To achieve
this, an interval tree is added in the inode of that file to track
the segments firstly read by that inode.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/data.c            | 38 +++++++++++++++++++--
 fs/erofs/internal.h        |  5 +++
 fs/erofs/pagecache_share.c | 68 ++++++++++++++++++++++++++++++++++++++
 fs/erofs/pagecache_share.h |  3 +-
 fs/erofs/super.c           |  9 +++++
 5 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index ef27b934115f..e4fcc8a6ce6d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -7,6 +7,7 @@
 #include "internal.h"
 #include <linux/sched/mm.h>
 #include <trace/events/erofs.h>
+#include "pagecache_share.h"
 
 void erofs_unmap_metabuf(struct erofs_buf *buf)
 {
@@ -349,6 +350,7 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
 {
 #ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
 	struct erofs_inode *vi = NULL;
+	struct interval_tree_node *seg;
 	int ret;
 
 	if (file && file->private_data) {
@@ -359,8 +361,22 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
 			vi = NULL;
 	}
 	ret = iomap_read_folio(folio, &erofs_iomap_ops);
-	if (vi)
+	if (vi) {
 		folio->mapping->host = file_inode(file);
+		seg = erofs_pcs_alloc_seg();
+		if (!seg)
+			return -ENOMEM;
+		seg->start = folio_index(folio);
+		seg->last = seg->start + (folio_size(folio) >> PAGE_SHIFT);
+		if (seg->last > (vi->vfs_inode.i_size >> PAGE_SHIFT))
+			seg->last = vi->vfs_inode.i_size >> PAGE_SHIFT;
+		if (seg->last >= seg->start) {
+			mutex_lock(&vi->segs_mutex);
+			interval_tree_insert(seg, &vi->segs);
+			mutex_unlock(&vi->segs_mutex);
+		} else
+			erofs_pcs_free_seg(seg);
+	}
 	return ret;
 #else
 	return iomap_read_folio(folio, &erofs_iomap_ops);
@@ -371,6 +387,8 @@ static void erofs_readahead(struct readahead_control *rac)
 #ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
 	struct erofs_inode *vi = NULL;
 	struct file *file = rac->file;
+	struct interval_tree_node *seg;
+	erofs_off_t start, end;
 
 	if (file && file->private_data) {
 		vi = file->private_data;
@@ -378,10 +396,26 @@ static void erofs_readahead(struct readahead_control *rac)
 			rac->mapping->host = &vi->vfs_inode;
 		else
 			vi = NULL;
+		start = readahead_pos(rac);
+		end = start + readahead_length(rac);
+		if (end > vi->vfs_inode.i_size)
+			end = vi->vfs_inode.i_size;
 	}
 	iomap_readahead(rac, &erofs_iomap_ops);
-	if (vi)
+	if (vi) {
 		rac->mapping->host = file_inode(file);
+		seg = erofs_pcs_alloc_seg();
+		if (!seg)
+			return;
+		seg->start = start >> PAGE_SHIFT;
+		seg->last = end >> PAGE_SHIFT;
+		if (seg->last >= seg->start) {
+			mutex_lock(&vi->segs_mutex);
+			interval_tree_insert(seg, &vi->segs);
+			mutex_unlock(&vi->segs_mutex);
+		} else
+			erofs_pcs_free_seg(seg);
+	}
 #else
 	return iomap_readahead(rac, &erofs_iomap_ops);
 #endif
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 358377825927..59af8768fab8 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -18,6 +18,8 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/iomap.h>
+#include <linux/interval_tree.h>
+#include <linux/mutex.h>
 #include "erofs_fs.h"
 
 /* redefine pr_fmt "erofs: " */
@@ -290,6 +292,9 @@ struct erofs_inode {
 	};
 #ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
 	struct inode *ano_inode;
+	/* segments attributed by this inode */
+	struct rb_root_cached segs;
+	struct mutex segs_mutex;
 #endif
 	/* the corresponding vfs inode */
 	struct inode vfs_inode;
diff --git a/fs/erofs/pagecache_share.c b/fs/erofs/pagecache_share.c
index 2d2a74547b67..a97024904019 100644
--- a/fs/erofs/pagecache_share.c
+++ b/fs/erofs/pagecache_share.c
@@ -4,6 +4,9 @@
  */
 #include <linux/xxhash.h>
 #include <linux/refcount.h>
+#include <uapi/linux/fadvise.h>
+#include <linux/slab.h>
+#include <linux/pagemap.h>
 #include "pagecache_share.h"
 #include "internal.h"
 #include "xattr.h"
@@ -15,6 +18,7 @@
 static DEFINE_MUTEX(pseudo_mnt_lock);
 static refcount_t pseudo_mnt_count;
 static struct vfsmount *erofs_pcs_mnt;
+struct kmem_cache *erofs_pcs_segsp;
 
 int erofs_pcs_init_mnt(void)
 {
@@ -25,6 +29,11 @@ int erofs_pcs_init_mnt(void)
 			return PTR_ERR(tmp);
 		erofs_pcs_mnt = tmp;
 		refcount_set(&pseudo_mnt_count, 1);
+		erofs_pcs_segsp = kmem_cache_create("erofs_pcs_segs",
+				sizeof(struct interval_tree_node), 0,
+				SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT, NULL);
+		if (!erofs_pcs_segsp)
+			return -ENOMEM;
 	} else
 		refcount_add(1, &pseudo_mnt_count);
 	mutex_unlock(&pseudo_mnt_lock);
@@ -37,10 +46,22 @@ void erofs_pcs_free_mnt(void)
 	if (refcount_dec_and_test(&pseudo_mnt_count)) {
 		kern_unmount(erofs_pcs_mnt);
 		erofs_pcs_mnt = NULL;
+		kmem_cache_destroy(erofs_pcs_segsp);
+		erofs_pcs_segsp = NULL;
 	}
 	mutex_unlock(&pseudo_mnt_lock);
 }
 
+struct interval_tree_node *erofs_pcs_alloc_seg(void)
+{
+	return kmem_cache_alloc(erofs_pcs_segsp, GFP_KERNEL);
+}
+
+void erofs_pcs_free_seg(struct interval_tree_node *seg)
+{
+	kmem_cache_free(erofs_pcs_segsp, seg);
+}
+
 static int erofs_pcs_eq(struct inode *inode, void *data)
 {
 	return inode->i_private && memcmp(inode->i_private, data,
@@ -73,6 +94,8 @@ void erofs_pcs_fill_inode(struct inode *inode)
 		ano_inode = iget5_locked(erofs_pcs_mnt->mnt_sb, fprt_hash,
 				erofs_pcs_eq, erofs_pcs_set_fprt, fprt);
 		vi->ano_inode = ano_inode;
+		vi->segs = RB_ROOT_CACHED;
+		mutex_init(&vi->segs_mutex);
 		if (ano_inode->i_state & I_NEW) {
 			if (erofs_inode_is_data_compressed(vi->datalayout))
 				ano_inode->i_mapping->a_ops = &z_erofs_aops;
@@ -160,6 +183,50 @@ static int erofs_pcs_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int erofs_pcs_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
+{
+	struct erofs_inode *vi = EROFS_I(file_inode(file));
+	struct interval_tree_node *seg, *next_seg, *new_seg;
+	struct file *ano_file = file->private_data;
+	erofs_off_t start, end;
+	int err = 0;
+	u64 l, r;
+
+	if (advice != POSIX_FADV_DONTNEED)
+		return generic_fadvise(ano_file, offset, len, advice);
+
+	start = offset >> PAGE_SHIFT;
+	/* len = 0 means EOF */
+	end = (!len ? LLONG_MAX : offset + len) >> PAGE_SHIFT;
+
+	mutex_lock(&vi->segs_mutex);
+	seg = interval_tree_iter_first(&vi->segs, start, end);
+	while (seg) {
+		next_seg = interval_tree_iter_next(seg, start, end);
+		l = max_t(u64, seg->start | 0ULL, start);
+		r = min_t(u64, seg->last | 0ULL, end);
+		if (l > r)
+			continue;
+		(void)invalidate_mapping_pages(ano_file->f_mapping, l, r);
+		if (seg->start < l) {
+			new_seg = erofs_pcs_alloc_seg();
+			new_seg->start = seg->start;
+			new_seg->last = l;
+			interval_tree_insert(new_seg, &vi->segs);
+		}
+		if (r < seg->last) {
+			new_seg = erofs_pcs_alloc_seg();
+			new_seg->start = r;
+			new_seg->last = seg->last;
+			interval_tree_insert(new_seg, &vi->segs);
+		}
+		interval_tree_remove(seg, &vi->segs);
+		seg = next_seg;
+	}
+	mutex_unlock(&vi->segs_mutex);
+	return err;
+}
+
 const struct file_operations erofs_pcs_file_fops = {
 	.open		= erofs_pcs_file_open,
 	.llseek		= generic_file_llseek,
@@ -168,4 +235,5 @@ const struct file_operations erofs_pcs_file_fops = {
 	.release	= erofs_pcs_file_release,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
+	.fadvise	= erofs_pcs_fadvise,
 };
diff --git a/fs/erofs/pagecache_share.h b/fs/erofs/pagecache_share.h
index b8111291cf79..e0aba20a6a0e 100644
--- a/fs/erofs/pagecache_share.h
+++ b/fs/erofs/pagecache_share.h
@@ -14,7 +14,8 @@
 int erofs_pcs_init_mnt(void);
 void erofs_pcs_free_mnt(void);
 void erofs_pcs_fill_inode(struct inode *inode);
+struct interval_tree_node *erofs_pcs_alloc_seg(void);
+void erofs_pcs_free_seg(struct interval_tree_node *seg);
 
 extern const struct vm_operations_struct generic_file_vm_ops;
-
 #endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 113e305080fa..da595e608702 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -105,10 +105,19 @@ static void erofs_free_inode(struct inode *inode)
 	struct erofs_inode *vi = EROFS_I(inode);
 
 #ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	struct interval_tree_node *seg, *next_seg;
+
 	if (S_ISREG(inode->i_mode) &&  vi->ano_inode) {
 		iput(vi->ano_inode);
 		vi->ano_inode = NULL;
 	}
+	seg = interval_tree_iter_first(&vi->segs, 0, LLONG_MAX);
+	while (seg) {
+		next_seg = interval_tree_iter_next(seg, 0, LLONG_MAX);
+		interval_tree_remove(seg, &vi->segs);
+		erofs_pcs_free_seg(seg);
+		seg = next_seg;
+	}
 #endif
 	if (inode->i_op == &erofs_fast_symlink_iops)
 		kfree(inode->i_link);
-- 
2.43.5

