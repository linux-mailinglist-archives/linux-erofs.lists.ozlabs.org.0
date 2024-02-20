Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935D985B44A
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 08:57:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TfBZg45GRz3cG0
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 18:57:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TfBZc6Vpmz3cGD
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Feb 2024 18:57:12 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 86316100888C1;
	Tue, 20 Feb 2024 15:55:44 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id E45F737C98B;
	Tue, 20 Feb 2024 15:55:42 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH v2 7/7] erofs-utils: mkfs: use per-worker tmpfile for multi-threaded mkfs
Date: Tue, 20 Feb 2024 15:55:25 +0800
Message-ID: <20240220075525.684205-8-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220075525.684205-7-zhaoyifan@sjtu.edu.cn>
References: <20240220075525.684205-1-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-2-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-3-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-4-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-5-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-6-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-7-zhaoyifan@sjtu.edu.cn>
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

Currently, multi-threaded mkfs.erofs creates tmpfiles for each segment
to store the intermediate compression result, reaching the limit of open
files when the number of segments is large.

This patch uses per-worker tmpfiles to avoid this problem if possible,
i.e., the environment supports the fallocate() syscall and
FALLOC_FL_PUNCH_HOLE flag.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
 lib/compress.c | 68 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 14 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index d5a5f16..3fae260 100644
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
@@ -1214,6 +1238,9 @@ void z_erofs_mt_private_fini(void *private)
 		free(priv->ccfg);
 		free(priv->destbuf);
 		free(priv->queue);
+#ifdef USE_PER_WORKER_TMPFILE
+		fclose(priv->tmpfile);
+#endif
 		priv->init = false;
 	}
 }
@@ -1237,24 +1264,30 @@ void z_erofs_mt_work(struct erofs_work *work)
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
 	ctx->tmpfile = tmpfile();
 #endif
-
 	if (!ctx->tmpfile) {
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
 
@@ -1274,6 +1307,7 @@ int z_erofs_mt_merge(struct erofs_compress_file *cfile, erofs_blk_t blkaddr,
 	struct erofs_sb_info *sbi = cur->ctx.inode->sbi;
 	struct z_erofs_write_index_ctx *ictx = cfile->ictx;
 	char *memblock = NULL;
+	size_t size = 0;
 	int ret = 0, lret;
 
 	while (cur != NULL) {
@@ -1290,28 +1324,32 @@ int z_erofs_mt_merge(struct erofs_compress_file *cfile, erofs_blk_t blkaddr,
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
@@ -1323,7 +1361,9 @@ int z_erofs_mt_merge(struct erofs_compress_file *cfile, erofs_blk_t blkaddr,
 		*compressed_blocks += ctx->compressed_blocks;
 
 out:
+#ifndef USE_PER_WORKER_TMPFILE
 		fclose(ctx->tmpfile);
+#endif
 
 		tmp = cur->next;
 		pthread_mutex_lock(&work_mutex);
-- 
2.43.2

