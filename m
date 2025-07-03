Return-Path: <linux-erofs+bounces-507-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F02AF73D7
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Jul 2025 14:23:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bXwst1KGCz30RJ;
	Thu,  3 Jul 2025 22:23:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751545426;
	cv=none; b=P+7eFm+4TYye4WS2qkbjYXKpbx5y6ZhXWmkBMLjzOSQBTgfstvtCAWpLAoR6XmZzNQirHUyAFWZfAU2fCO6sPJXlgAdcnGf4TozAaDJHCLE2qzZnJ9qdcaloLLMS1UcD5b1MTvG74dmfCkXUSPrcj0ZzSdTkgL1dejH80AKTmz5IMwVK4aWqkIGNjgUegbL1jFBZM1mnJLF+b0mMXoEHNZI2xhan3ASQ4aPLgxajY98G4P47PNgRyoVl0GMNXnHTEg18blUgzhR2Yw2Kuj5lepT6qhfUPrUjViWnijZte1DFUgwl+KTobbOfeSyvu1kN2FQqepVdMH6P5zhKSAmQJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751545426; c=relaxed/relaxed;
	bh=s6X3NdAnlP0i8JnBZ/azgHwOENShqTXkJiDBYD6MsTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SCcmFJq6pIk5isYAtWkbhwy1ZqnNU0BZDSKdtATOxQI+O5xfFwLNeXbm6678FeC8bKoXNYsmxwMKRq1lPcWEzYWefUGw09DWvBRD2K0S3zx2xtuG8+KBCk6nuo/ozbB5Sc59le8AsPtWwGkgHVRO2E0ObW1EP2n2G793AQEikEkwDz4LWUZQRIg8kpEmP+lV9oWTEI8xFi3LHRO5jTstNTdHn39WYWSfE28CFMFN9dCZDo86DzgoPIQUmk60mRN40ayu8GcMl4D6nyCIlNiYkJCRXfLqNR9n9LC0E8VBJtbNYiIituh/JNeyvGdfx4+QHzOPRs1rh4v6OZSl3/8nJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lwgcZtp1; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lwgcZtp1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bXwss2j4vz2xgQ
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Jul 2025 22:23:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 575F4A53824;
	Thu,  3 Jul 2025 12:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5131EC4CEE3;
	Thu,  3 Jul 2025 12:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751545423;
	bh=TqPofe0gs94IMfoZoT6dBy9tWxrXoBhUquzVk8Cg1zI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lwgcZtp1dBLpQFiUoQOWfsTVz6lcq6NVvESyBHSWCUraxx0i56LOHe6RihXUV0O9S
	 r4khulFGL7MncursvEjXjW+UWJOn2eCWoS+tkCTJVobkLFvl8qXLV+35juaVA8XDH4
	 +XXfG6OcnyIfeMlLXkb0+9FUcMvp/2V48Phrytqkrd6BaPqnIQbUD+8owwHTANRJ9m
	 M8Z8klt/d6esnxtjtXpQQA/y0dtgU38zNDsSZfN8UYduBywIaHdrdpGbmMwjuHr7fR
	 VV8wXJ0tRSNq21vPDpd87xij4b19oDNyBN1/I8Zpw7tANIR2Ek+1AMJsWSUO4D1ca9
	 KUuPnPEN0tMsQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 03 Jul 2025 14:23:13 +0200
Subject: [PATCH RFC 4/4] erofs: introduce .fadvise for page cache share
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
Message-Id: <20250703-work-erofs-pcs-v1-4-0ce1f6be28ee@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9666; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Zm1POdxJ/I6fDA3qqJQAfLffPvBHqIx/I185HszRIf8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSkldm/e11t8eDdw45dx7epuzFEbJPtmNy56cn7PwrbH
 345w/7XvaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiyWqMDH8Zw39IBKx0k9LJ
 6ODmU3GqymKvjD2n3/LlTGWFamJFNcNfcW19ky1/prfwrynsPPlk7f3KY8zfgo5du3BL6fPcJ0u
 fcgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

When using .fadvise to release a file's page cache, it frees page cache
pages that were first read by this file. To achieve this, an interval
tree is added in the inode of that file to track the segments first
read by that inode.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Link: https://lore.kernel.org/20240902110620.2202586-5-hongzhen@linux.alibaba.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/erofs/data.c            | 38 ++++++++++++++++++++--
 fs/erofs/internal.h        |  5 +++
 fs/erofs/pagecache_share.c | 81 ++++++++++++++++++++++++++++++++++++++++++++--
 fs/erofs/pagecache_share.h |  2 ++
 fs/erofs/super.c           |  9 ++++++
 5 files changed, 131 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fb54162f4c54..61a42a95d26b 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -7,6 +7,7 @@
 #include "internal.h"
 #include <linux/sched/mm.h>
 #include <trace/events/erofs.h>
+#include "pagecache_share.h"
 
 void erofs_unmap_metabuf(struct erofs_buf *buf)
 {
@@ -353,6 +354,7 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
 {
 #ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
 	struct erofs_inode *vi = NULL;
+	struct interval_tree_node *seg;
 	int ret;
 
 	if (file && file->private_data) {
@@ -363,8 +365,22 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
 			vi = NULL;
 	}
 	ret = iomap_read_folio(folio, &erofs_iomap_ops);
-	if (vi)
+	if (vi) {
 		folio->mapping->host = file_inode(file);
+		seg = erofs_pcs_alloc_seg();
+		if (!seg)
+			return -ENOMEM;
+		seg->start = folio->index;
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
@@ -376,6 +392,8 @@ static void erofs_readahead(struct readahead_control *rac)
 #ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
 	struct erofs_inode *vi = NULL;
 	struct file *file = rac->file;
+	struct interval_tree_node *seg;
+	erofs_off_t start, end;
 
 	if (file && file->private_data) {
 		vi = file->private_data;
@@ -383,10 +401,26 @@ static void erofs_readahead(struct readahead_control *rac)
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
index 47136894d17d..5aa1215ce734 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -18,6 +18,8 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/iomap.h>
+#include <linux/interval_tree.h>
+#include <linux/mutex.h>
 #include "erofs_fs.h"
 
 __printf(2, 3) void _erofs_printk(struct super_block *sb, const char *fmt, ...);
@@ -275,6 +277,9 @@ struct erofs_inode {
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
index 309b33cc6c30..84713c0f20c8 100644
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
@@ -15,10 +18,12 @@
 static DEFINE_MUTEX(pseudo_mnt_lock);
 static refcount_t pseudo_mnt_count;
 static struct vfsmount *erofs_pcs_mnt;
+struct kmem_cache *erofs_pcs_segsp;
 
 int erofs_pcs_init_mnt(void)
 {
 	struct vfsmount *mnt;
+	struct kmem_cache *cache;
 
 	if (refcount_inc_not_zero(&pseudo_mnt_count))
 		return 0;
@@ -29,12 +34,21 @@ int erofs_pcs_init_mnt(void)
 		return 0;
 	}
 
+	cache = kmem_cache_create("erofs_pcs_segs",
+				  sizeof(struct interval_tree_node), 0,
+				  SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT, NULL);
+	if (!cache)
+		return -ENOMEM;
+
 	mnt = kern_mount(&erofs_anon_fs_type);
-	if (IS_ERR(mnt))
+	if (IS_ERR(mnt)) {
+		kmem_cache_destroy(cache);
 		return PTR_ERR(mnt);
+	}
 
 	rcu_read_lock();
 	rcu_assign_pointer(erofs_pcs_mnt, mnt);
+	rcu_assign_pointer(erofs_pcs_segsp, cache);
 	rcu_read_unlock();
 	refcount_set_release(&pseudo_mnt_count, 1);
 	return 0;
@@ -43,18 +57,34 @@ int erofs_pcs_init_mnt(void)
 void erofs_pcs_free_mnt(void)
 {
 	struct vfsmount *mnt = NULL;
+	struct kmem_cache *cache = NULL;
 
 	if (refcount_dec_not_one(&pseudo_mnt_count))
 		return;
 
 	scoped_guard(mutex, &pseudo_mnt_lock) {
 		rcu_read_lock();
-		if (refcount_dec_and_test(&pseudo_mnt_count))
+		if (refcount_dec_and_test(&pseudo_mnt_count)) {
 			mnt = rcu_replace_pointer(erofs_pcs_mnt, NULL, true);
+			cache = rcu_replace_pointer(erofs_pcs_segsp, NULL, true);
+		}
 		rcu_read_unlock();
 	}
+
 	if (mnt)
 		kern_unmount(mnt);
+	if (cache)
+		kmem_cache_destroy(cache);
+}
+
+struct interval_tree_node *erofs_pcs_alloc_seg(void)
+{
+	return kmem_cache_alloc(erofs_pcs_segsp, GFP_KERNEL);
+}
+
+void erofs_pcs_free_seg(struct interval_tree_node *seg)
+{
+	kmem_cache_free(erofs_pcs_segsp, seg);
 }
 
 static int erofs_pcs_eq(struct inode *inode, void *data)
@@ -90,6 +120,8 @@ void erofs_pcs_fill_inode(struct inode *inode)
 					 erofs_pcs_eq, erofs_pcs_set_fprt,
 					 fprt);
 		vi->ano_inode = ano_inode;
+		vi->segs = RB_ROOT_CACHED;
+		mutex_init(&vi->segs_mutex);
 		if (ano_inode->i_state & I_NEW) {
 			if (erofs_inode_is_data_compressed(vi->datalayout))
 				ano_inode->i_mapping->a_ops = &z_erofs_aops;
@@ -189,6 +221,50 @@ static int erofs_pcs_mmap(struct file *file, struct vm_area_struct *vma)
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
 	/*
@@ -201,4 +277,5 @@ const struct file_operations erofs_pcs_file_fops = {
 	.release	= erofs_pcs_file_release,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
+	.fadvise	= erofs_pcs_fadvise,
 };
diff --git a/fs/erofs/pagecache_share.h b/fs/erofs/pagecache_share.h
index b8111291cf79..eb5869070d4b 100644
--- a/fs/erofs/pagecache_share.h
+++ b/fs/erofs/pagecache_share.h
@@ -14,6 +14,8 @@
 int erofs_pcs_init_mnt(void);
 void erofs_pcs_free_mnt(void);
 void erofs_pcs_fill_inode(struct inode *inode);
+struct interval_tree_node *erofs_pcs_alloc_seg(void);
+void erofs_pcs_free_seg(struct interval_tree_node *seg);
 
 extern const struct vm_operations_struct generic_file_vm_ops;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index b9a71840cc45..607dc94a45a0 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -83,10 +83,19 @@ static void erofs_free_inode(struct inode *inode)
 	struct erofs_inode *vi = EROFS_I(inode);
 
 #ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+	struct interval_tree_node *seg, *next_seg;
+
 	if (S_ISREG(inode->i_mode) &&  vi->ano_inode) {
 		iput(vi->ano_inode);
 		vi->ano_inode = NULL;
 	}
+	seg = interval_tree_iter_first(&vi->segs, 0, ULONG_MAX);
+	while (seg) {
+		next_seg = interval_tree_iter_next(seg, 0, ULONG_MAX);
+		interval_tree_remove(seg, &vi->segs);
+		erofs_pcs_free_seg(seg);
+		seg = next_seg;
+	}
 #endif
 	if (inode->i_op == &erofs_fast_symlink_iops)
 		kfree(inode->i_link);

-- 
2.47.2


