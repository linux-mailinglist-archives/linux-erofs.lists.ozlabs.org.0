Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736BA85B443
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 08:55:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TfBY730KLz3cQm
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 18:55:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TfBY21FJlz3cCx
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Feb 2024 18:55:48 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 7DFBC1008D997;
	Tue, 20 Feb 2024 15:55:36 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id DCEAF37C943;
	Tue, 20 Feb 2024 15:55:26 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH v2 0/7] erofs-utils: mkfs: introduce multi-threaded compression
Date: Tue, 20 Feb 2024 15:55:18 +0800
Message-ID: <20240220075525.684205-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.43.2
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

Change log since v1:
- Re-implement workqueue API instead of using xfsprogs' workqueue
- Use per-worker tmpfile for multi-threaded mkfs

Gao Xiang (1):
  erofs-utils: add a helper to get available processors

Yifan Zhao (6):
  erofs-utils: introduce multi-threading framework
  erofs-utils: mkfs: add --worker=# parameter
  erofs-utils: mkfs: optionally print warning in erofs_compressor_init
  erofs-utils: mkfs: introduce inner-file multi-threaded compression
  erofs-utils: mkfs: introduce inter-file multi-threaded compression
  erofs-utils: mkfs: use per-worker tmpfile for multi-threaded mkfs

 configure.ac                |  17 +
 include/erofs/compress.h    |  18 +
 include/erofs/config.h      |   5 +
 include/erofs/internal.h    |   6 +
 include/erofs/list.h        |   8 +
 include/erofs/queue.h       |  22 +
 include/erofs/workqueue.h   |  38 ++
 lib/Makefile.am             |   4 +
 lib/compress.c              | 836 ++++++++++++++++++++++++++++++------
 lib/compressor.c            |   7 +-
 lib/compressor.h            |   5 +-
 lib/compressor_deflate.c    |   4 +-
 lib/compressor_libdeflate.c |   4 +-
 lib/compressor_liblzma.c    |   5 +-
 lib/compressor_lz4.c        |   2 +-
 lib/compressor_lz4hc.c      |   2 +-
 lib/config.c                |  16 +
 lib/inode.c                 | 302 ++++++++++---
 lib/queue.c                 |  64 +++
 lib/workqueue.c             | 132 ++++++
 mkfs/main.c                 |  38 ++
 21 files changed, 1342 insertions(+), 193 deletions(-)
 create mode 100644 include/erofs/queue.h
 create mode 100644 include/erofs/workqueue.h
 create mode 100644 lib/queue.c
 create mode 100644 lib/workqueue.c

Interdiff against v1:
diff --git a/include/erofs/workqueue.h b/include/erofs/workqueue.h
index a11a8fc..857947b 100644
--- a/include/erofs/workqueue.h
+++ b/include/erofs/workqueue.h
@@ -1,48 +1,38 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2017 Oracle.  All Rights Reserved.
- * Author: Darrick J. Wong <darrick.wong@oracle.com>
- */
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
 #ifndef __EROFS_WORKQUEUE_H
 #define __EROFS_WORKQUEUE_H
 
 #include "internal.h"
 
-struct erofs_workqueue;
 struct erofs_work;
 
-typedef void erofs_workqueue_func_t(struct erofs_workqueue *wq,
-				    struct erofs_work *work);
+typedef void erofs_wq_func_t(struct erofs_work *);
 typedef void erofs_wq_priv_fini_t(void *);
 
 struct erofs_work {
-	struct erofs_workqueue	*queue;
+	void (*func)(struct erofs_work *work);
 	struct erofs_work *next;
-	erofs_workqueue_func_t	*function;
-	void 			*private;
+	void *priv;
 };
 
 struct erofs_workqueue {
-	pthread_t		*threads;
-	struct erofs_work	*next_item;
-	struct erofs_work	*last_item;
+	struct erofs_work *head;
+	struct erofs_work *tail;
 	pthread_mutex_t lock;
-	pthread_cond_t		wakeup;
-	unsigned int		item_count;
-	unsigned int		thread_count;
-	bool			terminate;
-	bool			terminated;
-	int			max_queued;
-	pthread_cond_t		queue_full;
-	size_t			private_size;
-	erofs_wq_priv_fini_t	*private_fini;
+	pthread_cond_t cond_empty;
+	pthread_cond_t cond_full;
+	pthread_t *workers;
+	unsigned int nworker;
+	unsigned int max_jobs;
+	unsigned int job_count;
+	bool shutdown;
+	size_t priv_size;
+	erofs_wq_priv_fini_t *priv_fini;
 };
 
-int erofs_workqueue_create(struct erofs_workqueue *wq, size_t private_size,
-			   erofs_wq_priv_fini_t *private_fini,
-			   unsigned int nr_workers, unsigned int max_queue);
-int erofs_workqueue_add(struct erofs_workqueue *wq, struct erofs_work *wi);
-int erofs_workqueue_terminate(struct erofs_workqueue *wq);
-void erofs_workqueue_destroy(struct erofs_workqueue *wq);
-
+int erofs_workqueue_init(struct erofs_workqueue *wq, unsigned int nworker,
+			 unsigned int max_jobs, size_t priv_size,
+			 erofs_wq_priv_fini_t *priv_fini);
+int erofs_workqueue_add(struct erofs_workqueue *wq, struct erofs_work *work);
+int erofs_workqueue_shutdown(struct erofs_workqueue *wq);
 #endif
\ No newline at end of file
diff --git a/lib/compress.c b/lib/compress.c
index d6c59b0..3fae260 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -8,6 +8,9 @@
 #ifndef _LARGEFILE64_SOURCE
 #define _LARGEFILE64_SOURCE
 #endif
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -23,6 +26,13 @@
 #ifdef EROFS_MT_ENABLED
 #include "erofs/workqueue.h"
 #endif
+#ifdef HAVE_LINUX_FALLOC_H
+#include <linux/falloc.h>
+#endif
+
+#if defined(HAVE_FALLOCATE) && defined(FALLOC_FL_PUNCH_HOLE)
+#define USE_PER_WORKER_TMPFILE 1
+#endif
 
 /* compressing configuration specified by users */
 struct erofs_compress_cfg {
@@ -59,6 +69,7 @@ struct z_erofs_vle_compress_ctx {
 
 	int seg_num, seg_idx;
 	FILE *tmpfile;
+	off_t tmpfile_off;
 };
 
 struct z_erofs_write_index_ctx {
@@ -75,6 +86,7 @@ struct erofs_compress_wq_private {
 	u8 *queue;
 	char *destbuf;
 	struct erofs_compress_cfg *ccfg;
+	FILE* tmpfile;
 };
 
 struct erofs_compress_work {
@@ -402,6 +414,7 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 		ret = fwrite(dst, erofs_blksiz(sbi), 1, ctx->tmpfile);
 		if (ret != 1)
 			return -EIO;
+		fflush(ctx->tmpfile);
 	} else {
 		erofs_dbg("Writing %u uncompressed data to block %u", count,
 			  ctx->blkaddr);
@@ -1073,6 +1086,7 @@ void z_erofs_init_ctx(struct z_erofs_vle_compress_ctx *ctx,
 	ctx->tof_chksum = tof_chksum;
 	ctx->fd = fd;
 	ctx->tmpfile = NULL;
+	ctx->tmpfile_off = 0;
 	init_list_head(&ctx->extents);
 }
 
@@ -1169,7 +1183,7 @@ int z_erofs_mt_private_init(struct erofs_sb_info *sbi,
 	struct erofs_compress_cfg *lc;
 	int ret;
 
-	if (!priv->init) {
+	if (unlikely(!priv->init)) {
 		priv->init = true;
 
 		priv->queue = malloc(EROFS_COMPR_QUEUE_SZ);
@@ -1185,6 +1199,16 @@ int z_erofs_mt_private_init(struct erofs_sb_info *sbi,
 				    sizeof(struct erofs_compress_cfg));
 		if (!priv->ccfg)
 			return -ENOMEM;
+
+#ifdef USE_PER_WORKER_TMPFILE
+#ifndef HAVE_TMPFILE64
+		priv->tmpfile = tmpfile();
+#else
+		priv->tmpfile = tmpfile64();
+#endif
+		if (!priv->tmpfile)
+			return -errno;
+#endif
 	}
 
 	lc = &priv->ccfg[alg_id];
@@ -1214,15 +1238,18 @@ void z_erofs_mt_private_fini(void *private)
 		free(priv->ccfg);
 		free(priv->destbuf);
 		free(priv->queue);
+#ifdef USE_PER_WORKER_TMPFILE
+		fclose(priv->tmpfile);
+#endif
 		priv->init = false;
 	}
 }
 
-void z_erofs_mt_work(struct erofs_workqueue *wq, struct erofs_work *work)
+void z_erofs_mt_work(struct erofs_work *work)
 {
 	struct erofs_compress_work *cwork = (struct erofs_compress_work *)work;
 	struct z_erofs_vle_compress_ctx *ctx = &cwork->ctx;
-	struct erofs_compress_wq_private *priv = work->private;
+	struct erofs_compress_wq_private *priv = work->priv;
 	struct erofs_compress_file *cfile = cwork->file;
 	erofs_blk_t blkaddr = ctx->blkaddr;
 	u64 offset = ctx->seg_idx * cfg.c_mt_segment_size;
@@ -1237,7 +1264,14 @@ void z_erofs_mt_work(struct erofs_workqueue *wq, struct erofs_work *work)
 	ctx->queue = priv->queue;
 	ctx->destbuf = priv->destbuf;
 	ctx->chandle = &priv->ccfg[cwork->alg_id].handle;
-
+#ifdef USE_PER_WORKER_TMPFILE
+	ctx->tmpfile = priv->tmpfile;
+	ctx->tmpfile_off = ftell(ctx->tmpfile);
+	if (ctx->tmpfile_off == -1) {
+		ret = -errno;
+		goto out;
+	}
+#else
 #ifdef HAVE_TMPFILE64
 	ctx->tmpfile = tmpfile64();
 #else
@@ -1247,13 +1281,13 @@ void z_erofs_mt_work(struct erofs_workqueue *wq, struct erofs_work *work)
 		ret = -errno;
 		goto out;
 	}
+	ctx->tmpfile_off = 0;
+#endif
 
 	ret = z_erofs_compress_file(ctx, offset, blkaddr);
 	if (ret)
 		goto out;
 
-	fflush(ctx->tmpfile);
-
 	if (ctx->seg_idx == ctx->seg_num - 1)
 		ret = z_erofs_handle_fragments(ctx);
 
@@ -1273,6 +1307,7 @@ int z_erofs_mt_merge(struct erofs_compress_file *cfile, erofs_blk_t blkaddr,
 	struct erofs_sb_info *sbi = cur->ctx.inode->sbi;
 	struct z_erofs_write_index_ctx *ictx = cfile->ictx;
 	char *memblock = NULL;
+	size_t size = 0;
 	int ret = 0, lret;
 
 	while (cur != NULL) {
@@ -1289,28 +1324,32 @@ int z_erofs_mt_merge(struct erofs_compress_file *cfile, erofs_blk_t blkaddr,
 			goto out;
 		}
 
-		memblock = realloc(memblock,
-				   ctx->compressed_blocks * erofs_blksiz(sbi));
+		size = ctx->compressed_blocks * erofs_blksiz(sbi);
+		memblock = realloc(memblock, size);
 		if (!memblock) {
 			if (!ret)
 				ret = -ENOMEM;
 			goto out;
 		}
 
-		lret = fseek(ctx->tmpfile, 0, SEEK_SET);
-		if (lret) {
+		lret = pread(fileno(ctx->tmpfile), memblock, size,
+			     ctx->tmpfile_off);
+		if (lret != size) {
 			if (!ret)
-				ret = lret;
+				ret = -errno;
 			goto out;
 		}
 
-		lret = fread(memblock, erofs_blksiz(sbi),
-			     ctx->compressed_blocks, ctx->tmpfile);
-		if (lret != ctx->compressed_blocks) {
+#ifdef USE_PER_WORKER_TMPFILE
+		lret = fallocate(fileno(ctx->tmpfile),
+				 FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				 ctx->tmpfile_off, size);
+		if (lret) {
 			if (!ret)
-				ret = -EIO;
+				ret = -errno;
 			goto out;
 		}
+#endif
 
 		lret = blk_write(sbi, memblock, blkaddr + *compressed_blocks,
 				 ctx->compressed_blocks);
@@ -1322,8 +1361,9 @@ int z_erofs_mt_merge(struct erofs_compress_file *cfile, erofs_blk_t blkaddr,
 		*compressed_blocks += ctx->compressed_blocks;
 
 out:
-		if (ctx->tmpfile)
+#ifndef USE_PER_WORKER_TMPFILE
 		fclose(ctx->tmpfile);
+#endif
 
 		tmp = cur->next;
 		pthread_mutex_lock(&work_mutex);
@@ -1405,7 +1445,7 @@ struct erofs_compress_file *z_erofs_mt_do_compress(
 		work->dict_size = ccfg->handle.dict_size;
 
 		work->file = cfile;
-		work->work.function = z_erofs_mt_work;
+		work->work.func = z_erofs_mt_work;
 
 		erofs_workqueue_add(&wq, &work->work);
 	}
@@ -1749,10 +1789,10 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	if (cfg.c_mt_worker_num == 1) {
 		mt_enabled = false;
 	} else {
-		ret = erofs_workqueue_create(
-			&wq, sizeof(struct erofs_compress_wq_private),
-			z_erofs_mt_private_fini, cfg.c_mt_worker_num,
-			cfg.c_mt_worker_num << 2);
+		ret = erofs_workqueue_init(
+			&wq, cfg.c_mt_worker_num, cfg.c_mt_worker_num << 2,
+			sizeof(struct erofs_compress_wq_private),
+			z_erofs_mt_private_fini);
 		mt_enabled = !ret;
 	}
 #else
@@ -1777,10 +1817,9 @@ int z_erofs_compress_exit(void)
 
 	if (mt_enabled) {
 #ifdef EROFS_MT_ENABLED
-		ret = erofs_workqueue_terminate(&wq);
+		ret = erofs_workqueue_shutdown(&wq);
 		if (ret)
 			return ret;
-		erofs_workqueue_destroy(&wq);
 		while (work_idle) {
 			struct erofs_compress_work *tmp = work_idle->next;
 			free(work_idle);
diff --git a/lib/workqueue.c b/lib/workqueue.c
index 01d12d9..3ec6142 100644
--- a/lib/workqueue.c
+++ b/lib/workqueue.c
@@ -1,222 +1,132 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017 Oracle.  All Rights Reserved.
- * Author: Darrick J. Wong <darrick.wong@oracle.com>
- */
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 #include <pthread.h>
-#include <signal.h>
 #include <stdlib.h>
-#include <string.h>
-#include <stdint.h>
-#include <stdbool.h>
-#include <errno.h>
-#include <assert.h>
 #include "erofs/workqueue.h"
 
-/* Main processing thread */
-static void *workqueue_thread(void *arg)
+static void *worker_thread(void *arg)
 {
 	struct erofs_workqueue *wq = arg;
-	struct erofs_work		*wi;
-	void				*private = NULL;
+	struct erofs_work *work;
+	void *priv = NULL;
 
-	if (wq->private_size) {
-		private = calloc(1, wq->private_size);
-		assert(private);
+	if (wq->priv_size) {
+		priv = calloc(wq->priv_size, 1);
+		assert(priv);
 	}
 
-	/*
-	 * Loop pulling work from the passed in work queue.
-	 * Check for notification to exit after every chunk of work.
-	 */
-	while (1) {
+	while (true) {
 		pthread_mutex_lock(&wq->lock);
 
-		/*
-		 * Wait for work.
-		 */
-		while (wq->next_item == NULL && !wq->terminate) {
-			assert(wq->item_count == 0);
-			pthread_cond_wait(&wq->wakeup, &wq->lock);
-		}
-		if (wq->next_item == NULL && wq->terminate) {
+		while (wq->job_count == 0 && !wq->shutdown)
+			pthread_cond_wait(&wq->cond_empty, &wq->lock);
+		if (wq->job_count == 0 && wq->shutdown) {
 			pthread_mutex_unlock(&wq->lock);
 			break;
 		}
 
-		/*
-		 *  Dequeue work from the head of the list. If the queue was
-		 *  full then send a wakeup if we're configured to do so.
-		 */
-		assert(wq->item_count > 0);
-		if (wq->max_queued)
-			pthread_cond_broadcast(&wq->queue_full);
-
-		wi = wq->next_item;
-		wq->next_item = wi->next;
-		wq->item_count--;
-
-		if (wq->max_queued && wq->next_item) {
-			/* more work, wake up another worker */
-			pthread_cond_signal(&wq->wakeup);
-		}
+		work = wq->head;
+		wq->head = work->next;
+		if (!wq->head)
+			wq->tail = NULL;
+		wq->job_count--;
+
+		if (wq->job_count == wq->max_jobs - 1)
+			pthread_cond_broadcast(&wq->cond_full);
+
 		pthread_mutex_unlock(&wq->lock);
 
-		wi->private = private;
-		(wi->function)(wq, wi);
+		work->priv = priv;
+		work->func(work);
 	}
 
-	if (private) {
-		assert(wq->private_fini);
-		(wq->private_fini)(private);
-		free(private);
+	if (priv) {
+		assert(wq->priv_fini);
+		(wq->priv_fini)(priv);
+		free(priv);
 	}
 
 	return NULL;
 }
 
-/* Allocate a work queue and threads.  Returns zero or negative error code. */
-int erofs_workqueue_create(struct erofs_workqueue *wq, size_t private_size,
-			   erofs_wq_priv_fini_t *priv_fini,
-			   unsigned int nr_workers, unsigned int max_queue)
+int erofs_workqueue_init(struct erofs_workqueue *wq, unsigned int nworker,
+			 unsigned int max_jobs, size_t priv_size,
+			 erofs_wq_priv_fini_t *priv_fini)
 {
 	unsigned int i;
-	int			err = 0;
-
-	memset(wq, 0, sizeof(*wq));
-	err = -pthread_cond_init(&wq->wakeup, NULL);
-	if (err)
-		return err;
-	err = -pthread_cond_init(&wq->queue_full, NULL);
-	if (err)
-		goto out_wake;
-	err = -pthread_mutex_init(&wq->lock, NULL);
-	if (err)
-		goto out_cond;
-
-	wq->private_size = private_size;
-	wq->private_fini = priv_fini;
-	wq->thread_count = nr_workers;
-	wq->max_queued = max_queue;
-	wq->threads = malloc(nr_workers * sizeof(pthread_t));
-	if (!wq->threads) {
-		err = -errno;
-		goto out_mutex;
-	}
-	wq->terminate = false;
-	wq->terminated = false;
 
-	for (i = 0; i < nr_workers; i++) {
-		err = -pthread_create(&wq->threads[i], NULL, workqueue_thread,
-				wq);
-		if (err)
-			break;
-	}
+	if (!wq || nworker <= 0 || max_jobs <= 0)
+		return -EINVAL;
 
-	/*
-	 * If we encounter errors here, we have to signal and then wait for all
-	 * the threads that may have been started running before we can destroy
-	 * the workqueue.
-	 */
-	if (err)
-		erofs_workqueue_destroy(wq);
-	return err;
-out_mutex:
-	pthread_mutex_destroy(&wq->lock);
-out_cond:
-	pthread_cond_destroy(&wq->queue_full);
-out_wake:
-	pthread_cond_destroy(&wq->wakeup);
-	return err;
-}
+	wq->head = wq->tail = NULL;
+	wq->nworker = nworker;
+	wq->max_jobs = max_jobs;
+	wq->job_count = 0;
+	wq->shutdown = false;
+	wq->priv_size = priv_size;
+	wq->priv_fini = priv_fini;
+	pthread_mutex_init(&wq->lock, NULL);
+	pthread_cond_init(&wq->cond_empty, NULL);
+	pthread_cond_init(&wq->cond_full, NULL);
 
-/*
- * Create a work item consisting of a function and some arguments and schedule
- * the work item to be run via the thread pool.  Returns zero or a negative
- * error code.
- */
-int erofs_workqueue_add(struct erofs_workqueue	*wq,
-			struct erofs_work *wi)
-{
-	int	ret;
+	wq->workers = malloc(nworker * sizeof(pthread_t));
+	if (!wq->workers)
+		return -ENOMEM;
 
-	assert(!wq->terminated);
+	for (i = 0; i < nworker; i++) {
+		if (pthread_create(&wq->workers[i], NULL, worker_thread, wq)) {
+			while (i--)
+				pthread_cancel(wq->workers[i]);
+			free(wq->workers);
+			return -ENOMEM;
+		}
+	}
 
-	if (wq->thread_count == 0) {
-		(wi->function)(wq, wi);
 	return 0;
 }
 
-	wi->queue = wq;
-	wi->next = NULL;
+int erofs_workqueue_add(struct erofs_workqueue *wq, struct erofs_work *work)
+{
+	if (!wq || !work)
+		return -EINVAL;
 
-	/* Now queue the new work structure to the work queue. */
 	pthread_mutex_lock(&wq->lock);
-restart:
-	if (wq->next_item == NULL) {
-		assert(wq->item_count == 0);
-		ret = -pthread_cond_signal(&wq->wakeup);
-		if (ret) {
-			pthread_mutex_unlock(&wq->lock);
-			return ret;
-		}
-		wq->next_item = wi;
-	} else {
-		/* throttle on a full queue if configured */
-		if (wq->max_queued && wq->item_count == wq->max_queued) {
-			pthread_cond_wait(&wq->queue_full, &wq->lock);
-			/*
-			 * Queue might be empty or even still full by the time
-			 * we get the lock back, so restart the lookup so we do
-			 * the right thing with the current state of the queue.
-			 */
-			goto restart;
-		}
-		wq->last_item->next = wi;
-	}
-	wq->last_item = wi;
-	wq->item_count++;
+
+	while (wq->job_count == wq->max_jobs)
+		pthread_cond_wait(&wq->cond_full, &wq->lock);
+
+	work->next = NULL;
+	if (!wq->head)
+		wq->head = work;
+	else
+		wq->tail->next = work;
+	wq->tail = work;
+	wq->job_count++;
+
+	pthread_cond_signal(&wq->cond_empty);
 	pthread_mutex_unlock(&wq->lock);
+
 	return 0;
 }
 
-/*
- * Wait for all pending work items to be processed and tear down the
- * workqueue thread pool.  Returns zero or a negative error code.
- */
-int erofs_workqueue_terminate(struct erofs_workqueue *wq)
+int erofs_workqueue_shutdown(struct erofs_workqueue *wq)
 {
 	unsigned int i;
-	int			ret;
-
-	pthread_mutex_lock(&wq->lock);
-	wq->terminate = true;
-	pthread_mutex_unlock(&wq->lock);
 
-	ret = -pthread_cond_broadcast(&wq->wakeup);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < wq->thread_count; i++) {
-		ret = -pthread_join(wq->threads[i], NULL);
-		if (ret)
-			return ret;
-	}
+	if (!wq)
+		return -EINVAL;
 
 	pthread_mutex_lock(&wq->lock);
-	wq->terminated = true;
+	wq->shutdown = true;
+	pthread_cond_broadcast(&wq->cond_empty);
 	pthread_mutex_unlock(&wq->lock);
-	return 0;
-}
 
-/* Tear down the workqueue. */
-void erofs_workqueue_destroy(struct erofs_workqueue *wq)
-{
-	assert(wq->terminated);
+	for (i = 0; i < wq->nworker; i++)
+		pthread_join(wq->workers[i], NULL);
 
-	free(wq->threads);
+	free(wq->workers);
 	pthread_mutex_destroy(&wq->lock);
-	pthread_cond_destroy(&wq->wakeup);
-	pthread_cond_destroy(&wq->queue_full);
-	memset(wq, 0, sizeof(*wq));
+	pthread_cond_destroy(&wq->cond_empty);
+	pthread_cond_destroy(&wq->cond_full);
+
+	return 0;
 }
\ No newline at end of file
-- 
2.43.2

