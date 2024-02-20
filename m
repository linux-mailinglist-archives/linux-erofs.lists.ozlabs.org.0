Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCB185B449
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 08:57:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TfBZS2RvQz3cQm
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 18:57:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TfBZN6R57z3bv3
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Feb 2024 18:57:00 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id E65331008AEC0;
	Tue, 20 Feb 2024 15:55:42 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 4ABF837C943;
	Tue, 20 Feb 2024 15:55:40 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH v2 6/7] erofs-utils: mkfs: introduce inter-file multi-threaded compression
Date: Tue, 20 Feb 2024 15:55:24 +0800
Message-ID: <20240220075525.684205-7-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220075525.684205-6-zhaoyifan@sjtu.edu.cn>
References: <20240220075525.684205-1-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-2-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-3-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-4-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-5-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-6-zhaoyifan@sjtu.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch allows parallelizing the compression process of different
files in mkfs. Specifically, a traverser thread traverses the files and
produces the compression task. Then, the main thread consumes them and
writes the compressed data to the device.

To this end, the logic of erofs_write_compressed_file() has been
modified to split the creation and completion logic of the compression
task.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Co-authored-by: Tong Xin <xin_tong@sjtu.edu.cn>
---
 include/erofs/compress.h |  17 ++
 include/erofs/internal.h |   3 +
 include/erofs/list.h     |   8 +
 include/erofs/queue.h    |  22 ++
 lib/Makefile.am          |   2 +-
 lib/compress.c           | 430 ++++++++++++++++++++++++---------------
 lib/inode.c              | 302 ++++++++++++++++++++++-----
 lib/queue.c              |  64 ++++++
 8 files changed, 636 insertions(+), 212 deletions(-)
 create mode 100644 include/erofs/queue.h
 create mode 100644 lib/queue.c

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 2699334..36a3fba 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -17,6 +17,23 @@ extern "C"
 #define EROFS_CONFIG_COMPR_MAX_SZ           (4000 * 1024)
 #define EROFS_COMPR_QUEUE_SZ (EROFS_CONFIG_COMPR_MAX_SZ * 2)
 
+#ifdef EROFS_MT_ENABLED
+struct erofs_compress_file {
+	pthread_mutex_t mutex;
+	pthread_cond_t cond;
+	int total;
+	int nfini;
+
+	struct z_erofs_write_index_ctx *ictx;
+	struct erofs_compress_work *head;
+	int fd;
+
+	struct erofs_compress_file *next;
+};
+
+int z_erofs_mt_reap(struct erofs_compress_file *cfile);
+#endif
+
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
 int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 954aef4..edfa187 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -250,6 +250,9 @@ struct erofs_inode {
 #ifdef WITH_ANDROID
 	uint64_t capabilities;
 #endif
+#ifdef EROFS_MT_ENABLED
+	struct erofs_compress_file* cfile;
+#endif
 };
 
 static inline erofs_off_t erofs_iloc(struct erofs_inode *inode)
diff --git a/include/erofs/list.h b/include/erofs/list.h
index d7a9fee..55383ac 100644
--- a/include/erofs/list.h
+++ b/include/erofs/list.h
@@ -90,6 +90,14 @@ static inline void list_splice_tail(struct list_head *list,
 		__list_splice(list, head->prev, head);
 }
 
+static inline void list_replace(struct list_head *old, struct list_head *new)
+{
+	new->next = old->next;
+	new->next->prev = new;
+	new->prev = old->prev;
+	new->prev->next = new;
+}
+
 #define list_entry(ptr, type, member) container_of(ptr, type, member)
 
 #define list_first_entry(ptr, type, member)                                    \
diff --git a/include/erofs/queue.h b/include/erofs/queue.h
new file mode 100644
index 0000000..ddc45ff
--- /dev/null
+++ b/include/erofs/queue.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __EROFS_QUEUE_H
+#define __EROFS_QUEUE_H
+
+#include "internal.h"
+
+struct erofs_queue {
+    pthread_mutex_t lock;
+    pthread_cond_t full, empty;
+
+    void *buf;
+
+    size_t size, elem_size;
+    size_t head, tail;
+};
+
+struct erofs_queue* erofs_queue_create(size_t size, size_t elem_size);
+void erofs_queue_push(struct erofs_queue *q, void *elem);
+void *erofs_queue_pop(struct erofs_queue *q);
+void erofs_queue_destroy(struct erofs_queue *q);
+
+#endif
\ No newline at end of file
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 7307f7b..777330b 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -55,5 +55,5 @@ liberofs_la_SOURCES += compressor_libdeflate.c
 endif
 if ENABLE_EROFS_MT
 liberofs_la_CFLAGS += -lpthread
-liberofs_la_SOURCES += workqueue.c
+liberofs_la_SOURCES += workqueue.c queue.c
 endif
diff --git a/lib/compress.c b/lib/compress.c
index 41de8b9..d5a5f16 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -63,7 +63,7 @@ struct z_erofs_vle_compress_ctx {
 
 struct z_erofs_write_index_ctx {
 	struct erofs_inode *inode;
-	struct list_head *extents;
+	struct list_head extents;
 	u16 clusterofs;
 	erofs_blk_t blkaddr, blkoff;
 	u8 *metacur;
@@ -81,6 +81,7 @@ struct erofs_compress_work {
 	/* Note: struct erofs_work must be the first member */
 	struct erofs_work work;
 	struct z_erofs_vle_compress_ctx ctx;
+	struct erofs_compress_file *file;
 
 	unsigned int alg_id;
 	char *alg_name;
@@ -93,13 +94,15 @@ struct erofs_compress_work {
 };
 
 static struct erofs_workqueue wq;
-static struct erofs_compress_work *idle;
-static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
-static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
-static int nfini;
+
+static struct erofs_compress_work *work_idle;
+static pthread_mutex_t work_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+static struct erofs_compress_file *cfile_idle;
+static pthread_mutex_t cfile_mutex = PTHREAD_MUTEX_INITIALIZER;
 #endif
 
-static bool mt_enabled;
+bool mt_enabled;
 static u8 *queue;
 
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	Z_EROFS_FULL_INDEX_ALIGN(0)
@@ -234,7 +237,7 @@ static void z_erofs_write_indexes(struct z_erofs_write_index_ctx *ctx)
 	struct z_erofs_extent_item *ei, *n;
 
 	ctx->clusterofs = 0;
-	list_for_each_entry_safe(ei, n, ctx->extents, list) {
+	list_for_each_entry_safe(ei, n, &ctx->extents, list) {
 		z_erofs_write_extent(ctx, &ei->e);
 
 		list_del(&ei->list);
@@ -1056,6 +1059,107 @@ int z_erofs_handle_fragments(struct z_erofs_vle_compress_ctx *ctx)
 	return 0;
 }
 
+void z_erofs_init_ctx(struct z_erofs_vle_compress_ctx *ctx,
+		      struct erofs_inode *inode, erofs_blk_t blkaddr,
+		      u32 tof_chksum, int fd)
+{
+	ctx->inode = inode;
+	ctx->pclustersize = z_erofs_get_max_pclustersize(inode);
+	ctx->blkaddr = blkaddr;
+	ctx->head = ctx->tail = 0;
+	ctx->clusterofs = 0;
+	ctx->fix_dedupedfrag = false;
+	ctx->fragemitted = false;
+	ctx->tof_chksum = tof_chksum;
+	ctx->fd = fd;
+	ctx->tmpfile = NULL;
+	init_list_head(&ctx->extents);
+}
+
+int z_erofs_finish_compress(struct z_erofs_write_index_ctx *ictx,
+			    struct erofs_buffer_head *bh,
+			    erofs_blk_t compressed_blocks, erofs_blk_t blkaddr,
+			    bool fragemitted)
+{
+	struct erofs_inode *inode = ictx->inode;
+	struct erofs_sb_info *sbi = inode->sbi;
+	u8 *compressmeta = ictx->metacur - Z_EROFS_LEGACY_MAP_HEADER_SIZE;
+	unsigned int legacymetasize;
+	int ret = 0;
+
+	ictx->blkaddr = blkaddr;
+	z_erofs_write_indexes(ictx);
+	legacymetasize = ictx->metacur - compressmeta;
+	/* estimate if data compression saves space or not */
+	if (!inode->fragment_size &&
+	    compressed_blocks * erofs_blksiz(sbi) + inode->idata_size +
+	    legacymetasize >= inode->i_size) {
+		z_erofs_dedupe_commit(true);
+
+		if (inode->idata) {
+			free(inode->idata);
+			inode->idata = NULL;
+		}
+		erofs_bdrop(bh, true); /* revoke buffer */
+		free(ictx);
+		free(compressmeta);
+		inode->compressmeta = NULL;
+
+		return -ENOSPC;
+	}
+	z_erofs_dedupe_commit(false);
+	z_erofs_write_mapheader(inode, compressmeta);
+
+	if (!fragemitted)
+		sbi->saved_by_deduplication += inode->fragment_size;
+
+	/* if the entire file is a fragment, a simplified form is used. */
+	if (inode->i_size <= inode->fragment_size) {
+		DBG_BUGON(inode->i_size < inode->fragment_size);
+		DBG_BUGON(inode->fragmentoff >> 63);
+		*(__le64 *)compressmeta =
+			cpu_to_le64(inode->fragmentoff | 1ULL << 63);
+		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
+		legacymetasize = Z_EROFS_LEGACY_MAP_HEADER_SIZE;
+	}
+
+	if (compressed_blocks) {
+		ret = erofs_bh_balloon(bh, erofs_pos(sbi, compressed_blocks));
+		DBG_BUGON(ret != erofs_blksiz(sbi));
+	} else {
+		if (!cfg.c_fragments && !cfg.c_dedupe)
+			DBG_BUGON(!inode->idata_size);
+	}
+
+	erofs_info("compressed %s (%llu bytes) into %u blocks",
+		   inode->i_srcpath, (unsigned long long)inode->i_size,
+		   compressed_blocks);
+
+	if (inode->idata_size) {
+		bh->op = &erofs_skip_write_bhops;
+		inode->bh_data = bh;
+	} else {
+		erofs_bdrop(bh, false);
+	}
+
+	inode->u.i_blocks = compressed_blocks;
+
+	if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL) {
+		inode->extent_isize = legacymetasize;
+	} else {
+		ret = z_erofs_convert_to_compacted_format(inode, blkaddr,
+							  legacymetasize,
+							  compressmeta);
+		DBG_BUGON(ret);
+	}
+	inode->compressmeta = compressmeta;
+	if (!erofs_is_packed_inode(inode))
+		erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
+
+	free(ictx);
+	return 0;
+}
+
 #ifdef EROFS_MT_ENABLED
 int z_erofs_mt_private_init(struct erofs_sb_info *sbi,
 			    struct erofs_compress_wq_private *priv,
@@ -1119,6 +1223,7 @@ void z_erofs_mt_work(struct erofs_work *work)
 	struct erofs_compress_work *cwork = (struct erofs_compress_work *)work;
 	struct z_erofs_vle_compress_ctx *ctx = &cwork->ctx;
 	struct erofs_compress_wq_private *priv = work->priv;
+	struct erofs_compress_file *cfile = cwork->file;
 	erofs_blk_t blkaddr = ctx->blkaddr;
 	u64 offset = ctx->seg_idx * cfg.c_mt_segment_size;
 	int ret = 0;
@@ -1139,6 +1244,11 @@ void z_erofs_mt_work(struct erofs_work *work)
 	ctx->tmpfile = tmpfile();
 #endif
 
+	if (!ctx->tmpfile) {
+		ret = -errno;
+		goto out;
+	}
+
 	ret = z_erofs_compress_file(ctx, offset, blkaddr);
 	if (ret)
 		goto out;
@@ -1150,28 +1260,29 @@ void z_erofs_mt_work(struct erofs_work *work)
 
 out:
 	cwork->ret = ret;
-	pthread_mutex_lock(&mutex);
-	++nfini;
-	pthread_cond_signal(&cond);
-	pthread_mutex_unlock(&mutex);
+	pthread_mutex_lock(&cfile->mutex);
+	++cfile->nfini;
+	pthread_cond_signal(&cfile->cond);
+	pthread_mutex_unlock(&cfile->mutex);
 }
 
-int z_erofs_mt_merge(struct erofs_compress_work *cur, erofs_blk_t blkaddr,
+int z_erofs_mt_merge(struct erofs_compress_file *cfile, erofs_blk_t blkaddr,
 		     erofs_blk_t *compressed_blocks)
 {
-	struct z_erofs_vle_compress_ctx *ctx, *listhead = NULL;
+	struct z_erofs_vle_compress_ctx *ctx;
+	struct erofs_compress_work *cur = cfile->head, *tmp;
 	struct erofs_sb_info *sbi = cur->ctx.inode->sbi;
-	struct erofs_compress_work *tmp;
+	struct z_erofs_write_index_ctx *ictx = cfile->ictx;
 	char *memblock = NULL;
 	int ret = 0, lret;
 
 	while (cur != NULL) {
 		ctx = &cur->ctx;
 
-		if (!listhead)
-			listhead = ctx;
+		if (cur == cfile->head)
+			list_replace(&ctx->extents, &ictx->extents);
 		else
-			list_splice_tail(&ctx->extents, &listhead->extents);
+			list_splice_tail(&ctx->extents, &ictx->extents);
 
 		if (cur->ret != 0) {
 			if (!ret)
@@ -1215,8 +1326,10 @@ out:
 		fclose(ctx->tmpfile);
 
 		tmp = cur->next;
-		cur->next = idle;
-		idle = cur;
+		pthread_mutex_lock(&work_mutex);
+		cur->next = work_idle;
+		work_idle = cur;
+		pthread_mutex_unlock(&work_mutex);
 		cur = tmp;
 	}
 
@@ -1224,60 +1337,59 @@ out:
 
 	return ret;
 }
-#endif
 
-void z_erofs_init_ctx(struct z_erofs_vle_compress_ctx *ctx,
-		      struct erofs_inode *inode, erofs_blk_t blkaddr,
-		      u32 tof_chksum, int fd)
+struct erofs_compress_file *z_erofs_mt_do_compress(
+	struct erofs_inode *inode, int fd, u32 tof_chksum, erofs_blk_t blkaddr,
+	struct z_erofs_write_index_ctx *ictx, struct erofs_compress_cfg *ccfg)
 {
-	ctx->inode = inode;
-	ctx->pclustersize = z_erofs_get_max_pclustersize(inode);
-	ctx->blkaddr = blkaddr;
-	ctx->head = ctx->tail = 0;
-	ctx->clusterofs = 0;
-	ctx->fix_dedupedfrag = false;
-	ctx->fragemitted = false;
-	ctx->tof_chksum = tof_chksum;
-	ctx->fd = fd;
-	ctx->tmpfile = NULL;
-	init_list_head(&ctx->extents);
-}
-
-int z_erofs_do_compress(struct z_erofs_vle_compress_ctx *ctx,
-			struct z_erofs_write_index_ctx *ictx,
-			struct erofs_compress_cfg *ccfg,
-			erofs_blk_t *compressed_blocks)
-{
-#ifdef EROFS_MT_ENABLED
 	struct erofs_compress_work *work, *head = NULL, **last = &head;
-#endif
-	struct erofs_inode *inode = ctx->inode;
-	erofs_blk_t blkaddr = ctx->blkaddr;
-	int ret = 0;
-
-	if (mt_enabled) {
-#ifdef EROFS_MT_ENABLED
-		if (inode->i_size <= cfg.c_mt_segment_size)
-			goto single_thread;
+	struct erofs_compress_file *cfile;
 
 	int nsegs = DIV_ROUND_UP(inode->i_size, cfg.c_mt_segment_size);
-		nfini = 0;
+
+	pthread_mutex_lock(&cfile_mutex);
+	if (cfile_idle) {
+		cfile = cfile_idle;
+		cfile_idle = cfile->next;
+		cfile->next = NULL;
+		pthread_mutex_unlock(&cfile_mutex);
+	} else {
+		pthread_mutex_unlock(&cfile_mutex);
+		cfile = calloc(1, sizeof(*cfile));
+		if (!cfile)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	inode->cfile = cfile;
+
+	cfile->ictx = ictx;
+	cfile->total = nsegs;
+	cfile->nfini = 0;
+	cfile->fd = fd;
+	pthread_mutex_init(&cfile->mutex, NULL);
+	pthread_cond_init(&cfile->cond, NULL);
 
 	for (int i = 0; i < nsegs; i++) {
-			if (idle) {
-				work = idle;
-				idle = work->next;
+		pthread_mutex_lock(&work_mutex);
+		if (work_idle) {
+			work = work_idle;
+			work_idle = work->next;
 			work->next = NULL;
+			pthread_mutex_unlock(&work_mutex);
 		} else {
+			pthread_mutex_unlock(&work_mutex);
 			work = calloc(1, sizeof(*work));
-				if (!work)
-					return -ENOMEM;
+			if (!work) {
+				free(cfile);
+				return ERR_PTR(-ENOMEM);
+			}
 		}
+		if (i == 0)
+			cfile->head = work;
 		*last = work;
 		last = &work->next;
 
-			z_erofs_init_ctx(&work->ctx, inode, blkaddr,
-					 ctx->tof_chksum, ctx->fd);
+		z_erofs_init_ctx(&work->ctx, inode, blkaddr, tof_chksum, fd);
 		if (i == nsegs - 1)
 			work->ctx.remaining = inode->i_size -
 					      inode->fragment_size -
@@ -1292,71 +1404,81 @@ int z_erofs_do_compress(struct z_erofs_vle_compress_ctx *ctx,
 		work->comp_level = ccfg->handle.compression_level;
 		work->dict_size = ccfg->handle.dict_size;
 
+		work->file = cfile;
 		work->work.func = z_erofs_mt_work;
 
 		erofs_workqueue_add(&wq, &work->work);
 	}
 
-		pthread_mutex_lock(&mutex);
-		while (nfini != nsegs)
-			pthread_cond_wait(&cond, &mutex);
-		pthread_mutex_unlock(&mutex);
+	return cfile;
+}
 
-		ictx->extents = &head->ctx.extents;
+int z_erofs_mt_reap(struct erofs_compress_file *cfile)
+{
+	struct erofs_buffer_head *bh = NULL;
+	erofs_blk_t blkaddr, compressed_blocks = 0;
+	int ret = 0;
 
-		ret = z_erofs_mt_merge(head, blkaddr, compressed_blocks);
-		if (ret)
-			return ret;
-#endif
-	} else {
-#ifdef EROFS_MT_ENABLED
-single_thread:
-#endif
-		ctx->queue = queue;
-		ctx->destbuf = NULL;
-		ctx->chandle = &ccfg->handle;
-		ctx->remaining = inode->i_size - inode->fragment_size;
-		ctx->seg_num = 1;
-		ctx->seg_idx = 0;
-
-		ret = z_erofs_compress_file(ctx, 0, blkaddr);
-		if (ret)
-			return ret;
+	bh = erofs_balloc(DATA, 0, 0, 0);
+	if (IS_ERR(bh)) {
+		ret = PTR_ERR(bh);
+		goto out;
+	}
+	blkaddr = erofs_mapbh(bh->block);
 
-		ret = z_erofs_handle_fragments(ctx);
+	ret = z_erofs_mt_merge(cfile, blkaddr, &compressed_blocks);
 	if (ret)
-			return ret;
+		goto out;
 
-		*compressed_blocks = ctx->compressed_blocks;
-		ictx->extents = &ctx->extents;
-	}
+	// multi-threaded compression doesn't support fragments for now
+	ret = z_erofs_finish_compress(cfile->ictx, bh, compressed_blocks,
+				      blkaddr, false);
 
-	return 0;
+out:
+	pthread_mutex_lock(&cfile_mutex);
+	cfile->next = cfile_idle;
+	cfile_idle = cfile;
+	pthread_mutex_unlock(&cfile_mutex);
+
+	return ret;
 }
+#endif
 
 int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 {
 	struct erofs_buffer_head *bh;
-	static struct z_erofs_vle_compress_ctx ctx;
-	static struct z_erofs_write_index_ctx ictx;
 	struct erofs_compress_cfg *ccfg;
-	erofs_blk_t blkaddr, compressed_blocks = 0;
-	unsigned int legacymetasize;
+	erofs_blk_t blkaddr;
 	u32 tof_chksum = 0;
 	int ret;
 	struct erofs_sb_info *sbi = inode->sbi;
-	u8 *compressmeta = malloc(BLK_ROUND_UP(sbi, inode->i_size) *
+	u8 *compressmeta;
+	struct z_erofs_write_index_ctx *ictx;
+	static struct z_erofs_vle_compress_ctx ctx;
+
+	compressmeta = malloc(BLK_ROUND_UP(sbi, inode->i_size) *
 				      sizeof(struct z_erofs_lcluster_index) +
 			      Z_EROFS_LEGACY_MAP_HEADER_SIZE);
-
 	if (!compressmeta)
 		return -ENOMEM;
 
+	ictx = malloc(sizeof(*ictx));
+	if (!ictx) {
+		ret = -ENOMEM;
+		goto err_free_meta;
+	}
+
+	if (!mt_enabled) {
 		/* allocate main data buffer */
 		bh = erofs_balloc(DATA, 0, 0, 0);
 		if (IS_ERR(bh)) {
 			ret = PTR_ERR(bh);
-		goto err_free_meta;
+			goto err_free_ictx;
+		}
+		blkaddr = erofs_mapbh(bh->block);
+	} else {
+		bh = NULL;
+		blkaddr = 0;
 	}
 
 	/* initialize per-file compression setting */
@@ -1405,10 +1527,19 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 			goto err_bdrop;
 	}
 
-	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
-	z_erofs_init_ctx(&ctx, inode, blkaddr, tof_chksum, fd);
+	ictx->inode = inode;
+	ictx->blkoff = 0;
+	ictx->clusterofs = 0;
+	ictx->metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
+	init_list_head(&ictx->extents);
+
 	if (cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
 	    !inode->fragment_size) {
+		// TODO: support multi-threaded compression for fragments
+		DBG_BUGON(mt_enabled);
+
+		z_erofs_init_ctx(&ctx, inode, blkaddr, tof_chksum, fd);
+
 		ret = z_erofs_pack_file_from_fd(inode, fd, tof_chksum);
 		if (ret)
 			goto err_free_idata;
@@ -1417,78 +1548,43 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 		if (ret)
 			goto err_free_idata;
 
-		ictx.extents = &ctx.extents;
-	} else {
-			ret = z_erofs_do_compress(&ctx, &ictx, ccfg,
-						  &compressed_blocks);
+		list_replace(&ctx.extents, &ictx->extents);
+
+		return z_erofs_finish_compress(ictx, bh, 0, blkaddr, false);
+	} else if (!mt_enabled) {
+		z_erofs_init_ctx(&ctx, inode, blkaddr, tof_chksum, fd);
+		ctx.queue = queue;
+		ctx.destbuf = NULL;
+		ctx.chandle = &ccfg->handle;
+		ctx.remaining = inode->i_size - inode->fragment_size;
+		ctx.seg_num = 1;
+		ctx.seg_idx = 0;
+
+		ret = z_erofs_compress_file(&ctx, 0, blkaddr);
 		if (ret)
 			goto err_free_idata;
-	}
-
-	ictx.inode = inode;
-	ictx.blkaddr = blkaddr;
-	ictx.blkoff = 0;
-	ictx.clusterofs = 0;
-	ictx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 
-	z_erofs_write_indexes(&ictx);
-	legacymetasize = ictx.metacur - compressmeta;
-	/* estimate if data compression saves space or not */
-	if (!inode->fragment_size &&
-	    compressed_blocks * erofs_blksiz(sbi) + inode->idata_size +
-	    legacymetasize >= inode->i_size) {
-		z_erofs_dedupe_commit(true);
-		ret = -ENOSPC;
+		ret = z_erofs_handle_fragments(&ctx);
+		if (ret)
 			goto err_free_idata;
-	}
-	z_erofs_dedupe_commit(false);
-	z_erofs_write_mapheader(inode, compressmeta);
 
-	if (!ctx.fragemitted)
-		sbi->saved_by_deduplication += inode->fragment_size;
+		list_replace(&ctx.extents, &ictx->extents);
 
-	/* if the entire file is a fragment, a simplified form is used. */
-	if (inode->i_size <= inode->fragment_size) {
-		DBG_BUGON(inode->i_size < inode->fragment_size);
-		DBG_BUGON(inode->fragmentoff >> 63);
-		*(__le64 *)compressmeta =
-			cpu_to_le64(inode->fragmentoff | 1ULL << 63);
-		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
-		legacymetasize = Z_EROFS_LEGACY_MAP_HEADER_SIZE;
-	}
-
-	if (compressed_blocks) {
-		ret = erofs_bh_balloon(bh, erofs_pos(sbi, compressed_blocks));
-		DBG_BUGON(ret != erofs_blksiz(sbi));
+		return z_erofs_finish_compress(ictx, bh, ctx.compressed_blocks,
+					       blkaddr, ctx.fragemitted);
 	} else {
-		if (!cfg.c_fragments && !cfg.c_dedupe)
-			DBG_BUGON(!inode->idata_size);
-	}
-
-	erofs_info("compressed %s (%llu bytes) into %u blocks",
-		   inode->i_srcpath, (unsigned long long)inode->i_size,
-		   compressed_blocks);
+#ifdef EROFS_MT_ENABLED
+		struct erofs_compress_file *cfile;
 
-	if (inode->idata_size) {
-		bh->op = &erofs_skip_write_bhops;
-		inode->bh_data = bh;
-	} else {
-		erofs_bdrop(bh, false);
+		cfile = z_erofs_mt_do_compress(inode, fd, tof_chksum, blkaddr,
+					       ictx, ccfg);
+		if (IS_ERR(cfile)) {
+			ret = PTR_ERR(cfile);
+			goto err_free_idata;
 		}
-
-	inode->u.i_blocks = compressed_blocks;
-
-	if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL) {
-		inode->extent_isize = legacymetasize;
-	} else {
-		ret = z_erofs_convert_to_compacted_format(inode, blkaddr,
-							  legacymetasize,
-							  compressmeta);
-		DBG_BUGON(ret);
+#endif
 	}
-	inode->compressmeta = compressmeta;
-	if (!erofs_is_packed_inode(inode))
-		erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
+
 	return 0;
 
 err_free_idata:
@@ -1497,7 +1593,10 @@ err_free_idata:
 		inode->idata = NULL;
 	}
 err_bdrop:
+	if (bh)
 		erofs_bdrop(bh, true);	/* revoke buffer */
+err_free_ictx:
+	free(ictx);
 err_free_meta:
 	free(compressmeta);
 	inode->compressmeta = NULL;
@@ -1681,10 +1780,15 @@ int z_erofs_compress_exit(void)
 		ret = erofs_workqueue_shutdown(&wq);
 		if (ret)
 			return ret;
-		while (idle) {
-			struct erofs_compress_work *tmp = idle->next;
-			free(idle);
-			idle = tmp;
+		while (work_idle) {
+			struct erofs_compress_work *tmp = work_idle->next;
+			free(work_idle);
+			work_idle = tmp;
+		}
+		while (cfile_idle) {
+			struct erofs_compress_file *tmp = cfile_idle->next;
+			free(cfile_idle);
+			cfile_idle = tmp;
 		}
 #endif
 	}
diff --git a/lib/inode.c b/lib/inode.c
index c6424c0..43ee23c 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -27,8 +27,13 @@
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
 #include "erofs/fragments.h"
+#ifdef EROFS_MT_ENABLED
+#include "erofs/queue.h"
+#endif
 #include "liberofs_private.h"
 
+extern bool mt_enabled;
+
 #define S_SHIFT                 12
 static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
 	[S_IFREG >> S_SHIFT]  = EROFS_FT_REG_FILE,
@@ -477,13 +482,8 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 	return 0;
 }
 
-int erofs_write_file(struct erofs_inode *inode, int fd, u64 fpos)
+static int erofs_write_chunked_file(struct erofs_inode *inode, int fd, u64 fpos)
 {
-	int ret;
-
-	DBG_BUGON(!inode->i_size);
-
-	if (cfg.c_chunkbits) {
 	inode->u.chunkbits = cfg.c_chunkbits;
 	/* chunk indexes when explicitly specified */
 	inode->u.chunkformat = 0;
@@ -492,6 +492,15 @@ int erofs_write_file(struct erofs_inode *inode, int fd, u64 fpos)
 	return erofs_blob_write_chunked_file(inode, fd, fpos);
 }
 
+int erofs_write_file(struct erofs_inode *inode, int fd, u64 fpos)
+{
+	int ret;
+
+	DBG_BUGON(!inode->i_size);
+
+	if (cfg.c_chunkbits)
+		return erofs_write_chunked_file(inode, fd, fpos);
+
 	if (cfg.c_compr_opts[0].alg && erofs_file_is_compressible(inode)) {
 		ret = erofs_write_compressed_file(inode, fd);
 		if (!ret || ret != -ENOSPC)
@@ -1032,6 +1041,9 @@ struct erofs_inode *erofs_new_inode(void)
 	inode->i_ino[0] = sbi.inos++;	/* inode serial number */
 	inode->i_count = 1;
 	inode->datalayout = EROFS_INODE_FLAT_PLAIN;
+#ifdef EROFS_MT_ENABLED
+	inode->cfile = NULL;
+#endif
 
 	init_list_head(&inode->i_hash);
 	init_list_head(&inode->i_subdirs);
@@ -1096,41 +1108,56 @@ static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 	rootdir->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
 }
 
-static int erofs_mkfs_build_tree(struct erofs_inode *dir, struct list_head *dirs)
-{
-	int ret;
-	DIR *_dir;
-	struct dirent *dp;
-	struct erofs_dentry *d;
-	unsigned int nr_subdirs, i_nlink;
-
-	ret = erofs_scan_file_xattrs(dir);
-	if (ret < 0)
-		return ret;
-
-	ret = erofs_prepare_xattr_ibody(dir);
-	if (ret < 0)
-		return ret;
+#ifdef EROFS_MT_ENABLED
+#define EROFS_MT_QUEUE_SIZE 256
+struct erofs_queue *erofs_mt_queue;
+#endif
 
-	if (!S_ISDIR(dir->i_mode)) {
-		if (S_ISLNK(dir->i_mode)) {
-			char *const symlink = malloc(dir->i_size);
+static int erofs_mkfs_handle_symlink(struct erofs_inode *inode)
+{
+	int ret = 0;
+	char *const symlink = malloc(inode->i_size);
 
 	if (!symlink)
 		return -ENOMEM;
-			ret = readlink(dir->i_srcpath, symlink, dir->i_size);
+	ret = readlink(inode->i_srcpath, symlink, inode->i_size);
 	if (ret < 0) {
 		free(symlink);
 		return -errno;
 	}
-			ret = erofs_write_file_from_buffer(dir, symlink);
+	ret = erofs_write_file_from_buffer(inode, symlink);
 	free(symlink);
-		} else if (dir->i_size) {
-			int fd = open(dir->i_srcpath, O_RDONLY | O_BINARY);
+
+	return ret;
+}
+
+static int erofs_mkfs_handle_file(struct erofs_inode *inode, bool alloc_buf)
+{
+	int ret = 0;
+
+	if (!alloc_buf) {
+		if (!inode->i_size)
+			return 0;
+
+		if (!S_ISLNK(inode->i_mode) && cfg.c_compr_opts[0].alg &&
+		    erofs_file_is_compressible(inode)) {
+			int fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
+			if (fd < 0)
+				return -errno;
+			ret = erofs_write_compressed_file(inode, fd);
+		}
+
+		return ret;
+	}
+
+	if (S_ISLNK(inode->i_mode)) {
+		ret = erofs_mkfs_handle_symlink(inode);
+	} else if (inode->i_size) {
+		int fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
 		if (fd < 0)
 			return -errno;
 
-			ret = erofs_write_file(dir, fd, 0);
+		ret = erofs_write_file(inode, fd, 0);
 		close(fd);
 	} else {
 		ret = 0;
@@ -1138,11 +1165,21 @@ static int erofs_mkfs_build_tree(struct erofs_inode *dir, struct list_head *dirs
 	if (ret)
 		return ret;
 
-		erofs_prepare_inode_buffer(dir);
-		erofs_write_tail_end(dir);
+	erofs_prepare_inode_buffer(inode);
+	erofs_write_tail_end(inode);
 	return 0;
 }
 
+static int erofs_mkfs_handle_dir(struct erofs_inode *dir,
+				 struct list_head *dirs,
+				 bool alloc_buf)
+{
+	int ret;
+	DIR *_dir;
+	struct dirent *dp;
+	struct erofs_dentry *d;
+	unsigned int nr_subdirs = 0, i_nlink;
+
 	_dir = opendir(dir->i_srcpath);
 	if (!_dir) {
 		erofs_err("failed to opendir at %s: %s",
@@ -1186,6 +1223,7 @@ static int erofs_mkfs_build_tree(struct erofs_inode *dir, struct list_head *dirs
 	if (ret)
 		return ret;
 
+	if (alloc_buf) {
 		ret = erofs_prepare_inode_buffer(dir);
 		if (ret)
 			return ret;
@@ -1193,6 +1231,7 @@ static int erofs_mkfs_build_tree(struct erofs_inode *dir, struct list_head *dirs
 
 		if (IS_ROOT(dir))
 			erofs_fixup_meta_blkaddr(dir);
+	}
 
 	i_nlink = 0;
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
@@ -1205,8 +1244,7 @@ static int erofs_mkfs_build_tree(struct erofs_inode *dir, struct list_head *dirs
 			continue;
 		}
 
-		ret = snprintf(buf, PATH_MAX, "%s/%s",
-			       dir->i_srcpath, d->name);
+		ret = snprintf(buf, PATH_MAX, "%s/%s", dir->i_srcpath, d->name);
 		if (ret < 0 || ret >= PATH_MAX) {
 			/* ignore the too long path */
 			goto fail;
@@ -1253,10 +1291,52 @@ err_closedir:
 	return ret;
 }
 
-struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
+static void erofs_mkfs_print_progessinfo(struct erofs_inode *inode)
+{
+	char *trimmed;
+	trimmed = erofs_trim_for_progressinfo(erofs_fspath(inode->i_srcpath),
+					      sizeof("Processing  ...") - 1);
+	erofs_update_progressinfo("Processing %s ...", trimmed);
+	free(trimmed);
+}
+
+static void erofs_mkfs_dumpdir(struct erofs_inode *dumpdir)
+{
+	struct erofs_inode *inode;
+	while (dumpdir) {
+		inode = dumpdir;
+		erofs_write_dir_file(inode);
+		erofs_write_tail_end(inode);
+		inode->bh->op = &erofs_write_inode_bhops;
+		dumpdir = inode->next_dirwrite;
+		erofs_iput(inode);
+	}	
+}
+
+static int erofs_mkfs_build_tree(struct erofs_inode *dir,
+				 struct list_head *dirs, bool alloc_buf)
+{
+	int ret;
+
+	ret = erofs_scan_file_xattrs(dir);
+	if (ret < 0)
+		return ret;
+
+	ret = erofs_prepare_xattr_ibody(dir);
+	if (ret < 0)
+		return ret;
+
+	if (!S_ISDIR(dir->i_mode))
+		return erofs_mkfs_handle_file(dir, alloc_buf);
+
+	return erofs_mkfs_handle_dir(dir, dirs, alloc_buf);
+}
+
+struct erofs_inode *__erofs_mkfs_build_tree_from_path(const char *path,
+						      bool mt_enabled)
 {
 	LIST_HEAD(dirs);
-	struct erofs_inode *inode, *root, *dumpdir;
+	struct erofs_inode *inode, *root, *dumpdir = NULL;
 
 	root = erofs_iget_from_path(path, true);
 	if (IS_ERR(root))
@@ -1266,43 +1346,169 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
 	root->i_parent = root;	/* rootdir mark */
 	list_add(&root->i_subdirs, &dirs);
 
-	dumpdir = NULL;
 	do {
 		int err;
-		char *trimmed;
 
 		inode = list_first_entry(&dirs, struct erofs_inode, i_subdirs);
 		list_del(&inode->i_subdirs);
 		init_list_head(&inode->i_subdirs);
 
-		trimmed = erofs_trim_for_progressinfo(
-				erofs_fspath(inode->i_srcpath),
-				sizeof("Processing  ...") - 1);
-		erofs_update_progressinfo("Processing %s ...", trimmed);
-		free(trimmed);
+		if (!mt_enabled)
+			erofs_mkfs_print_progessinfo(inode);
 
-		err = erofs_mkfs_build_tree(inode, &dirs);
+		err = erofs_mkfs_build_tree(inode, &dirs, !mt_enabled);
 		if (err) {
 			root = ERR_PTR(err);
 			break;
 		}
 
+		if (!mt_enabled) {
 			if (S_ISDIR(inode->i_mode)) {
 				inode->next_dirwrite = dumpdir;
 				dumpdir = inode;
 			} else {
 				erofs_iput(inode);
 			}
+		} else {
+#ifdef EROFS_MT_ENABLED
+			erofs_queue_push(erofs_mt_queue, &inode);
+#endif
+		}
 	} while (!list_empty(&dirs));
 
-	while (dumpdir) {
-		inode = dumpdir;
-		erofs_write_dir_file(inode);
+	if (!mt_enabled)
+		erofs_mkfs_dumpdir(dumpdir);
+#ifdef EROFS_MT_ENABLED
+	else
+		erofs_queue_push(erofs_mt_queue, &dumpdir);
+#endif
+	return root;
+}
+
+#ifdef EROFS_MT_ENABLED
+pthread_t erofs_mt_traverser;
+
+void *erofs_mkfs_mt_traverse_task(void *path)
+{
+	pthread_exit((void *)__erofs_mkfs_build_tree_from_path(path, true));
+}
+
+static int erofs_mkfs_reap_compressed_file(struct erofs_inode *inode)
+{
+	struct erofs_compress_file *cfile = inode->cfile;
+	int fd = cfile->fd;
+	int ret = 0;
+
+	pthread_mutex_lock(&cfile->mutex);
+	while (cfile->nfini != cfile->total)
+		pthread_cond_wait(&cfile->cond, &cfile->mutex);
+	pthread_mutex_unlock(&cfile->mutex);
+
+	ret = z_erofs_mt_reap(cfile);
+	if (ret == -ENOSPC) {
+		ret = lseek(fd, 0, SEEK_SET);
+		if (ret < 0)
+			return -errno;
+
+		ret = write_uncompressed_file_from_fd(inode, fd);
+	}
+
+	close(fd);
+	return ret;
+}
+
+static int erofs_mkfs_reap_inodes()
+{
+	struct erofs_inode *inode, *dumpdir;
+	int ret = 0;
+
+	dumpdir = NULL;
+	while (true) {
+		inode = *(struct erofs_inode **)erofs_queue_pop(erofs_mt_queue);
+		if (!inode)
+			break;
+
+		erofs_mkfs_print_progessinfo(inode);
+
+		if (S_ISDIR(inode->i_mode)) {
+			ret = erofs_prepare_inode_buffer(inode);
+			if (ret)
+				goto out;
+			inode->bh->op = &erofs_skip_write_bhops;
+
+			if (IS_ROOT(inode))
+				erofs_fixup_meta_blkaddr(inode);
+
+			inode->next_dirwrite = dumpdir;
+			dumpdir = inode;
+			continue;
+		}
+
+		if (inode->cfile) {
+			ret = erofs_mkfs_reap_compressed_file(inode);
+		} else if (S_ISLNK(inode->i_mode)) {
+			ret = erofs_mkfs_handle_symlink(inode);
+		} else if (!inode->i_size) {
+			ret = 0;
+		} else {
+			int fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
+			if (fd < 0)
+				return -errno;
+
+			if (cfg.c_chunkbits)
+				ret = erofs_write_chunked_file(inode, fd, 0);
+			else
+				ret = write_uncompressed_file_from_fd(inode,
+								      fd);
+			close(fd);
+		}
+		if (ret)
+			goto out;
+
+		erofs_prepare_inode_buffer(inode);
 		erofs_write_tail_end(inode);
-		inode->bh->op = &erofs_write_inode_bhops;
-		dumpdir = inode->next_dirwrite;
 		erofs_iput(inode);
 	}
+
+	erofs_mkfs_dumpdir(dumpdir);
+
+out:
+	return ret;
+}
+#endif
+
+struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
+{
+#ifdef EROFS_MT_ENABLED
+	int err;
+#endif
+	struct erofs_inode *root = NULL;
+
+	if (!mt_enabled)
+		return __erofs_mkfs_build_tree_from_path(path, false);
+
+#ifdef EROFS_MT_ENABLED
+	erofs_mt_queue = erofs_queue_create(EROFS_MT_QUEUE_SIZE,
+					    sizeof(struct erofs_inode *));
+	if (IS_ERR(erofs_mt_queue))
+		return ERR_CAST(erofs_mt_queue);
+
+	err = pthread_create(&erofs_mt_traverser, NULL,
+			     erofs_mkfs_mt_traverse_task, (void *)path);
+	if (err)
+		return ERR_PTR(err);
+
+	err = erofs_mkfs_reap_inodes();
+	if (err)
+		return ERR_PTR(err);
+
+	err = pthread_join(erofs_mt_traverser, (void *)&root);
+	if (err)
+		return ERR_PTR(err);
+
+	erofs_queue_destroy(erofs_mt_queue);
+#endif
+
 	return root;
 }
 
diff --git a/lib/queue.c b/lib/queue.c
new file mode 100644
index 0000000..b69ac26
--- /dev/null
+++ b/lib/queue.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include "erofs/err.h"
+#include <stdlib.h>
+#include "erofs/queue.h"
+
+struct erofs_queue *erofs_queue_create(size_t size, size_t elem_size)
+{
+	struct erofs_queue *q = malloc(sizeof(*q));
+
+	pthread_mutex_init(&q->lock, NULL);
+	pthread_cond_init(&q->empty, NULL);
+	pthread_cond_init(&q->full, NULL);
+
+	q->size = size;
+	q->elem_size = elem_size;
+	q->head = 0;
+	q->tail = 0;
+	q->buf = calloc(size, elem_size);
+	if (!q->buf)
+		return ERR_PTR(-ENOMEM);
+
+	return q;
+}
+
+void erofs_queue_push(struct erofs_queue *q, void *elem)
+{
+	pthread_mutex_lock(&q->lock);
+
+	while ((q->tail + 1) % q->size == q->head)
+		pthread_cond_wait(&q->full, &q->lock);
+
+	memcpy(q->buf + q->tail * q->elem_size, elem, q->elem_size);
+	q->tail = (q->tail + 1) % q->size;
+
+	pthread_cond_signal(&q->empty);
+	pthread_mutex_unlock(&q->lock);
+}
+
+void *erofs_queue_pop(struct erofs_queue *q)
+{
+    void *elem;
+
+    pthread_mutex_lock(&q->lock);
+
+    while (q->head == q->tail)
+        pthread_cond_wait(&q->empty, &q->lock);
+
+    elem = q->buf + q->head * q->elem_size;
+    q->head = (q->head + 1) % q->size;
+
+    pthread_cond_signal(&q->full);
+    pthread_mutex_unlock(&q->lock);
+
+    return elem;
+}
+
+void erofs_queue_destroy(struct erofs_queue *q)
+{
+	pthread_mutex_destroy(&q->lock);
+	pthread_cond_destroy(&q->empty);
+	pthread_cond_destroy(&q->full);
+	free(q->buf);
+	free(q);
+}
\ No newline at end of file
-- 
2.43.2

