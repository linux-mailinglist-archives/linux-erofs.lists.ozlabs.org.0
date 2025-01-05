Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A47BA019EF
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Jan 2025 16:12:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YR1576XLxz3bSd
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Jan 2025 02:12:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736089943;
	cv=none; b=FgDyQMf5SeSVDPw16k/EKyKUf1NVrD4qWlVqKM22/ux2GHxYKcU+BNijQ+Ax9FjL+tCAmIzcVqzvc0WSzdz5Jc7i+f7fb0OYngK5O7CSaRodmq3xa0X6pl9S+lfXriHYSerq2wltmAnT6uylpUpzU0l8nUppECiDtbPJXlHFi1fzlFf4mHyBJsnoeX9AuXh/hClREVKM/Ko2nZbJPw5UmEEXZhVhmOuTY+JsyJOWR6Z1M9lDCnfQHIVCRU99QJ0BRVdn+z7ONJSUoRf7XBg3TfTfxrkAOa8Rtyy/8u5F+L15PoJxnAwd8i1IboUj4UW6Jw78afKGczx3HO2Jqu9j/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736089943; c=relaxed/relaxed;
	bh=irKsjukeB8am87/9XUlU8GqkONSxlLOSB/FtU9kbpzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBwsVPUni0ujkagdfDzJc8TUd1IaeHt8ODfficcBT9ZMnvwiBBpjjrBt+c7kVLjvcwe8DFZwx/8GHwfqaSCErwQ9VnaG2DhAc3+VW3eYLve6fIQSoIsv3vwVLUDq30lOpv504k8/evp0owQttwlvTxrOoeYVzZ3Np0bPDQGyZtL+my+wiuZAv/AwRflCoHuaKVtEVkBoZ7RTwJEH9GRTZod6OlamuPmsXwDG87S9Z3Qpu1l6s79esDuusKVR/g6Pd251qtezoNOFLR8ontPc6bORxr1D2hmNie8YmUjFTYAljdtZfAZjsMVmwYwiUfaTIF9ZybOHdQwheJmq6AWIUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Dg1T55vR; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Dg1T55vR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YR1505sRSz30Ty
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Jan 2025 02:12:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736089936; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=irKsjukeB8am87/9XUlU8GqkONSxlLOSB/FtU9kbpzU=;
	b=Dg1T55vRI1VUDF7FSM/6zgpjqEdOIPqI0jCgWL3QoDZFevvVhNtng8ZS46gqKJ6f2QthLsUrmW0a+wL1W8gMhtigHwKr1MkEQ/ySvx9ZY1OMsO/9/3BDNYv1R7xM629FpoWMBHVA+Re8+qApMxRceCdM28bNjTH81dCMVZt+rQk=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WMyjv2C_1736089934 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 05 Jan 2025 23:12:14 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v5 4/4] erofs: introduce .fadvise for page cache share
Date: Sun,  5 Jan 2025 23:12:08 +0800
Message-ID: <20250105151208.3797385-5-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250105151208.3797385-1-hongzhen@linux.alibaba.com>
References: <20250105151208.3797385-1-hongzhen@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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

When using .fadvice to release a file's page cache, it frees
those page caches that were firstly read by this file. To achieve
this, an interval tree is added in the inode of that file to track
the segments firstly read by that inode.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/data.c            |   5 +-
 fs/erofs/internal.h        |   3 +
 fs/erofs/pagecache_share.c | 151 +++++++++++++++++++++++++++++++++++--
 fs/erofs/pagecache_share.h |  10 ++-
 fs/erofs/zdata.c           |   5 +-
 5 files changed, 160 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fb08acbeaab6..ebb9a79e5f0e 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -382,10 +382,11 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
 static void erofs_readahead(struct readahead_control *rac)
 {
 	int pcshr;
+	unsigned long start;
 
-	pcshr = erofs_pcshr_readahead_begin(rac);
+	pcshr = erofs_pcshr_readahead_begin(rac, &start);
 	iomap_readahead(rac, &erofs_iomap_ops);
-	erofs_pcshr_readahead_end(rac, pcshr);
+	erofs_pcshr_readahead_end(rac, pcshr, start);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 6c87621d86ba..593c79abfb79 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -282,6 +282,9 @@ struct erofs_inode {
 	};
 #ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
 	struct inode *ano_inode;
+	/* first-read segments */
+	struct rb_root_cached segs;
+	struct mutex segs_mutex;
 #endif
 	/* the corresponding vfs inode */
 	struct inode vfs_inode;
diff --git a/fs/erofs/pagecache_share.c b/fs/erofs/pagecache_share.c
index 22172b5e21c7..46b022de5f17 100644
--- a/fs/erofs/pagecache_share.c
+++ b/fs/erofs/pagecache_share.c
@@ -6,6 +6,9 @@
 #include <linux/refcount.h>
 #include <linux/mount.h>
 #include <linux/mutex.h>
+#include <uapi/linux/fadvise.h>
+#include <linux/slab.h>
+#include <linux/pagemap.h>
 #include "pagecache_share.h"
 #include "internal.h"
 #include "xattr.h"
@@ -18,6 +21,8 @@ struct erofs_pcshr_counter {
 	struct mutex mutex;
 	struct kref ref;
 	struct vfsmount *mnt;
+	/* kmem cache for each inode's first-read segments */
+	struct kmem_cache *segsp;
 };
 
 struct erofs_pcshr_private {
@@ -38,6 +43,8 @@ static void erofs_pcshr_counter_release(struct kref *ref)
 	DBG_BUGON(!counter->mnt);
 	kern_unmount(counter->mnt);
 	counter->mnt = NULL;
+	kmem_cache_destroy(counter->segsp);
+	counter->segsp = NULL;
 }
 
 int erofs_pcshr_init_mnt(void)
@@ -54,6 +61,14 @@ int erofs_pcshr_init_mnt(void)
 		}
 		mnt_counter.mnt = tmp;
 		kref_init(&mnt_counter.ref);
+
+		mnt_counter.segsp = kmem_cache_create("erofs_segs",
+			sizeof(struct interval_tree_node), 0,
+			SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT, NULL);
+		if (!mnt_counter.segsp) {
+			ret = -ENOMEM;
+			goto out;
+		}
 	} else
 		kref_get(&mnt_counter.ref);
 	ret = 0;
@@ -69,6 +84,16 @@ void erofs_pcshr_free_mnt(void)
 	mutex_unlock(&mnt_counter.mutex);
 }
 
+static struct interval_tree_node *erofs_pcshr_alloc_seg(void)
+{
+	return kmem_cache_alloc(mnt_counter.segsp, GFP_KERNEL);
+}
+
+static void erofs_pcshr_free_seg(struct interval_tree_node *seg)
+{
+	kmem_cache_free(mnt_counter.segsp, seg);
+}
+
 static int erofs_fprt_eq(struct inode *inode, void *data)
 {
 	struct erofs_pcshr_private *ano_private = inode->i_private;
@@ -111,6 +136,8 @@ int erofs_pcshr_fill_inode(struct inode *inode)
 					 erofs_fprt_eq, erofs_fprt_set, fprt);
 		DBG_BUGON(!ano_inode);
 		vi->ano_inode = ano_inode;
+		vi->segs = RB_ROOT_CACHED;
+		mutex_init(&vi->segs_mutex);
 		if (ano_inode->i_state & I_NEW) {
 			if (erofs_inode_is_data_compressed(vi->datalayout))
 				ano_inode->i_mapping->a_ops = &z_erofs_aops;
@@ -126,12 +153,20 @@ int erofs_pcshr_fill_inode(struct inode *inode)
 
 void erofs_pcshr_free_inode(struct inode *inode)
 {
+	struct interval_tree_node *seg, *next_seg;
 	struct erofs_inode *vi = EROFS_I(inode);
 
 	if (S_ISREG(inode->i_mode) &&  vi->ano_inode) {
 		iput(vi->ano_inode);
 		vi->ano_inode = NULL;
 	}
+	seg = interval_tree_iter_first(&vi->segs, 0, LLONG_MAX);
+	while (seg) {
+		next_seg = interval_tree_iter_next(seg, 0, LLONG_MAX);
+		interval_tree_remove(seg, &vi->segs);
+		erofs_pcshr_free_seg(seg);
+		seg = next_seg;
+	}
 }
 
 static struct file *erofs_pcshr_alloc_file(struct file *file,
@@ -219,6 +254,65 @@ static int erofs_pcshr_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int erofs_pcshr_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
+{
+	struct erofs_inode *vi = EROFS_I(file_inode(file));
+	struct interval_tree_node *seg, *next_seg, *new_seg;
+	struct file *ano_file = file->private_data;
+	struct erofs_pcshr_private *ano_private;
+	erofs_off_t start, end, l, r;
+	int err = 0;
+
+	if (advice != POSIX_FADV_DONTNEED)
+		return generic_fadvise(ano_file, offset, len, advice);
+
+	ano_private = file_inode(ano_file)->i_private;
+
+	start = offset >> PAGE_SHIFT;
+	/* len = 0 means EOF */
+	end = ((!len ? LLONG_MAX : offset + len) >> PAGE_SHIFT) + 1;
+
+	mutex_lock(&vi->segs_mutex);
+	seg = interval_tree_iter_first(&vi->segs, start, end);
+	while (seg) {
+		next_seg = interval_tree_iter_next(seg, start, end);
+		/*
+		 * calculate the overlap between [start, end)
+		 * and [seg->start, seg->last)
+		 */
+		l = max_t(u64, seg->start | 0ULL, start);
+		r = min_t(u64, seg->last | 0ULL, end);
+		if (l >= r)
+			continue;
+
+		/* a new smaller interval on the left side */
+		if (seg->start < l) {
+			new_seg = erofs_pcshr_alloc_seg();
+			new_seg->start = seg->start;
+			new_seg->last = l;
+			interval_tree_insert(new_seg, &vi->segs);
+		}
+
+		/* a new smaller interval on the right side */
+		if (r < seg->last) {
+			new_seg = erofs_pcshr_alloc_seg();
+			new_seg->start = r;
+			new_seg->last = seg->last;
+			interval_tree_insert(new_seg, &vi->segs);
+		}
+		mutex_lock(&ano_private->mutex);
+		truncate_inode_pages_range(file_inode(ano_file)->i_mapping,
+					   l << PAGE_SHIFT,
+					   (r - 1) << PAGE_SHIFT);
+		mutex_unlock(&ano_private->mutex);
+		interval_tree_remove(seg, &vi->segs);
+		erofs_pcshr_free_seg(seg);
+		seg = next_seg;
+	}
+	mutex_unlock(&vi->segs_mutex);
+	return err;
+}
+
 const struct file_operations erofs_pcshr_fops = {
 	.open		= erofs_pcshr_file_open,
 	.llseek		= generic_file_llseek,
@@ -227,6 +321,7 @@ const struct file_operations erofs_pcshr_fops = {
 	.release	= erofs_pcshr_file_release,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
+	.fadvise	= erofs_pcshr_fadvise,
 };
 
 int erofs_pcshr_read_begin(struct file *file, struct folio *folio)
@@ -240,9 +335,11 @@ int erofs_pcshr_read_begin(struct file *file, struct folio *folio)
 	vi = file->private_data;
 	if (vi->ano_inode != file_inode(file))
 		return 0;
-
 	ano_private = vi->ano_inode->i_private;
+
+	mutex_lock(&vi->segs_mutex);
 	mutex_lock(&ano_private->mutex);
+
 	folio->mapping->host = &vi->vfs_inode;
 	return 1;
 }
@@ -250,16 +347,36 @@ int erofs_pcshr_read_begin(struct file *file, struct folio *folio)
 void erofs_pcshr_read_end(struct file *file, struct folio *folio, int pcshr)
 {
 	struct erofs_pcshr_private *ano_private;
+	struct interval_tree_node *seg;
+	struct erofs_inode *vi;
 
 	if (pcshr == 0)
 		return;
-
+	vi = file->private_data;
 	ano_private = file_inode(file)->i_private;
+
+	/* switch host inode */
 	folio->mapping->host = file_inode(file);
+
+	/* record first-read segment */
+	seg = erofs_pcshr_alloc_seg();
+	if (!seg) {
+		DBG_BUGON(1);
+		goto unlock;
+	}
+	seg->start = folio_index(folio);
+	seg->last = seg->start + (folio_size(folio) >> PAGE_SHIFT);
+	if (seg->last > (vi->vfs_inode.i_size >> PAGE_SHIFT))
+		seg->last = vi->vfs_inode.i_size >> PAGE_SHIFT;
+	DBG_BUGON(seg->last < seg->start);
+	interval_tree_insert(seg, &vi->segs);
+unlock:
 	mutex_unlock(&ano_private->mutex);
+	mutex_unlock(&vi->segs_mutex);
 }
 
-int erofs_pcshr_readahead_begin(struct readahead_control *rac)
+int erofs_pcshr_readahead_begin(struct readahead_control *rac,
+				unsigned long *start)
 {
 	struct erofs_inode *vi;
 	struct file *file = rac->file;
@@ -271,21 +388,43 @@ int erofs_pcshr_readahead_begin(struct readahead_control *rac)
 	vi = file->private_data;
 	if (vi->ano_inode != file_inode(file))
 		return 0;
-
 	ano_private = file_inode(file)->i_private;
+
+	mutex_lock(&vi->segs_mutex);
 	mutex_lock(&ano_private->mutex);
+
 	rac->mapping->host = &vi->vfs_inode;
+	*start = readahead_pos(rac) >> PAGE_SHIFT;
 	return 1;
 }
 
-void erofs_pcshr_readahead_end(struct readahead_control *rac, int pcshr)
+void erofs_pcshr_readahead_end(struct readahead_control *rac, int pcshr,
+			       unsigned long start)
 {
 	struct erofs_pcshr_private *ano_private;
+	struct interval_tree_node *seg;
+	struct erofs_inode *vi;
 
 	if (pcshr == 0)
 		return;
-
+	vi = rac->file->private_data;
 	ano_private = file_inode(rac->file)->i_private;
+
+	/* switch host inode */
 	rac->mapping->host = file_inode(rac->file);
+
+	/* record first-read segments */
+	seg = erofs_pcshr_alloc_seg();
+	if (!seg) {
+		DBG_BUGON(1);
+		goto unlock;
+	}
+	seg->start = start;
+	seg->last = readahead_pos(rac) >> PAGE_SHIFT;
+	if (seg->last > (vi->vfs_inode.i_size >> PAGE_SHIFT))
+		seg->last = vi->vfs_inode.i_size >> PAGE_SHIFT;
+	interval_tree_insert(seg, &vi->segs);
+unlock:
 	mutex_unlock(&ano_private->mutex);
+	mutex_unlock(&vi->segs_mutex);
 }
diff --git a/fs/erofs/pagecache_share.h b/fs/erofs/pagecache_share.h
index abda2a60278b..2c4ac7e45227 100644
--- a/fs/erofs/pagecache_share.h
+++ b/fs/erofs/pagecache_share.h
@@ -17,8 +17,10 @@ void erofs_pcshr_free_inode(struct inode *inode);
 /* switch between the anonymous inode and the real inode */
 int erofs_pcshr_read_begin(struct file *file, struct folio *folio);
 void erofs_pcshr_read_end(struct file *file, struct folio *folio, int pcshr);
-int erofs_pcshr_readahead_begin(struct readahead_control *rac);
-void erofs_pcshr_readahead_end(struct readahead_control *rac, int pcshr);
+int erofs_pcshr_readahead_begin(struct readahead_control *rac,
+                                unsigned long *start);
+void erofs_pcshr_readahead_end(struct readahead_control *rac, int pcshr,
+                               unsigned long start);
 
 #else
 
@@ -29,8 +31,8 @@ static inline void erofs_pcshr_free_inode(struct inode *inode) {}
 
 static inline int erofs_pcshr_read_begin(struct file *file, struct folio *folio) { return 0; }
 static inline void erofs_pcshr_read_end(struct file *file, struct folio *folio, int pcshr) {}
-static inline int erofs_pcshr_readahead_begin(struct readahead_control *rac) { return 0; }
-static inline void erofs_pcshr_readahead_end(struct readahead_control *rac, int pcshr) {}
+static inline int erofs_pcshr_readahead_begin(struct readahead_control *rac, unsigned long *start) { return 0; }
+static inline void erofs_pcshr_readahead_end(struct readahead_control *rac, int pcshr, unsigned long start) {}
 
 #endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index fc2ed01eaabe..f646ec70cd7a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1921,9 +1921,10 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct folio *head = NULL, *folio;
 	unsigned int nr_folios;
+	unsigned long start;
 	int err, pcshr;
 
-	pcshr = erofs_pcshr_readahead_begin(rac);
+	pcshr = erofs_pcshr_readahead_begin(rac, &start);
 	f.headoffset = readahead_pos(rac);
 
 	z_erofs_pcluster_readmore(&f, rac, true);
@@ -1951,7 +1952,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	(void)z_erofs_runqueue(&f, nr_folios);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
-	erofs_pcshr_readahead_end(rac, pcshr);
+	erofs_pcshr_readahead_end(rac, pcshr, start);
 }
 
 const struct address_space_operations z_erofs_aops = {
-- 
2.43.5

