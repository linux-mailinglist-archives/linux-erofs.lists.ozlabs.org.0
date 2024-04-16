Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEE68A65A5
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 10:05:08 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dIlBtZ75;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJc5t1khtz3dVX
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 18:05:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dIlBtZ75;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJc5R0CVYz3cGY
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Apr 2024 18:04:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5CE31610E8;
	Tue, 16 Apr 2024 08:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FB7C32783;
	Tue, 16 Apr 2024 08:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713254681;
	bh=ILVMlztyR0xvC6wvQjCTTxwnzfgZvBLb/xnuKrg9KY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dIlBtZ75Slkm8TV6d7o7k/V12H3+/+Pczc6I1R5BAdUgYnOjIHlfddAdl/lU4Dnnb
	 2tWpYhVFP9d+OD59M2wyM3qvufgwp6ynmSSZ4jGl+/J82kEKn4ya3ghpeiOlahyf7t
	 2ryTakR1wP7jEp1d7GYhoEx9AflbNmnRfSkqBfaE1TRuyOxzJZVn3rF51TlZsXpuwo
	 qY3PqKuNQVCCY+gwUSjNg/dT8NXqk9XOFLa0Jt5nnTlQnmTgZuUt4i37Go/ZDF09HU
	 ofWnrnyyUM6NDd23vgOF1Fk5alHatwd0lGtmARkM+OndhUlNxsVsjE7pblqu0bsg+6
	 +L6xeOe+/qlWA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 5/8] erofs-utils: lib: split up z_erofs_mt_compress()
Date: Tue, 16 Apr 2024 16:04:16 +0800
Message-Id: <20240416080419.32491-5-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240416080419.32491-1-xiang@kernel.org>
References: <20240416080419.32491-1-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

The on-disk compressed data write will be moved into a new function
erofs_mt_write_compressed_file().

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 172 ++++++++++++++++++++++++++++---------------------
 1 file changed, 99 insertions(+), 73 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 72f33d2..3fd3874 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -57,6 +57,8 @@ struct z_erofs_compress_ictx {		/* inode context */
 	pthread_mutex_t mutex;
 	pthread_cond_t cond;
 	int nfini;
+
+	struct erofs_compress_work *mtworks;
 #endif
 };
 
@@ -1030,6 +1032,26 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 		z_erofs_commit_extent(ctx, ctx->pivot);
 		ctx->pivot = NULL;
 	}
+
+	/* generate an extra extent for the deduplicated fragment */
+	if (ctx->seg_idx >= ictx->seg_num - 1 &&
+	    ictx->inode->fragment_size && !ictx->fragemitted) {
+		struct z_erofs_extent_item *ei;
+
+		ei = malloc(sizeof(*ei));
+		if (!ei)
+			return -ENOMEM;
+
+		ei->e = (struct z_erofs_inmem_extent) {
+			.length = ictx->inode->fragment_size,
+			.compressedblks = 0,
+			.raw = false,
+			.partial = false,
+			.blkaddr = ctx->blkaddr,
+		};
+		init_list_head(&ei->list);
+		z_erofs_commit_extent(ctx, ei);
+	}
 	return 0;
 }
 
@@ -1044,6 +1066,8 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 	u8 *compressmeta;
 	int ret;
 
+	z_erofs_fragments_commit(inode);
+
 	/* fall back to no compression mode */
 	DBG_BUGON(compressed_blocks < !!inode->idata_size);
 	compressed_blocks -= !!inode->idata_size;
@@ -1121,11 +1145,11 @@ err_free_meta:
 	free(compressmeta);
 	inode->compressmeta = NULL;
 err_free_idata:
+	erofs_bdrop(bh, true);	/* revoke buffer */
 	if (inode->idata) {
 		free(inode->idata);
 		inode->idata = NULL;
 	}
-	erofs_bdrop(bh, true);	/* revoke buffer */
 	return ret;
 }
 
@@ -1267,15 +1291,13 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
 	return ret;
 }
 
-int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
-			erofs_blk_t blkaddr,
-			erofs_blk_t *compressed_blocks)
+int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 {
 	struct erofs_compress_work *cur, *head = NULL, **last = &head;
 	struct erofs_compress_cfg *ccfg = ictx->ccfg;
 	struct erofs_inode *inode = ictx->inode;
 	int nsegs = DIV_ROUND_UP(inode->i_size, cfg.c_segment_size);
-	int ret, i;
+	int i;
 
 	ictx->seg_num = nsegs;
 	ictx->nfini = 0;
@@ -1283,11 +1305,14 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
 	pthread_cond_init(&ictx->cond, NULL);
 
 	for (i = 0; i < nsegs; i++) {
-		if (z_erofs_mt_ctrl.idle) {
-			cur = z_erofs_mt_ctrl.idle;
+		pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
+		cur = z_erofs_mt_ctrl.idle;
+		if (cur) {
 			z_erofs_mt_ctrl.idle = cur->next;
 			cur->next = NULL;
-		} else {
+		}
+		pthread_mutex_unlock(&z_erofs_mt_ctrl.mutex);
+		if (!cur) {
 			cur = calloc(1, sizeof(*cur));
 			if (!cur)
 				return -ENOMEM;
@@ -1317,14 +1342,31 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
 		cur->work.fn = z_erofs_mt_workfn;
 		erofs_queue_work(&z_erofs_mt_ctrl.wq, &cur->work);
 	}
+	ictx->mtworks = head;
+	return 0;
+}
+
+int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
+{
+	struct erofs_buffer_head *bh = NULL;
+	struct erofs_compress_work *head = ictx->mtworks, *cur;
+	erofs_blk_t blkaddr, compressed_blocks = 0;
+	int ret;
 
 	pthread_mutex_lock(&ictx->mutex);
 	while (ictx->nfini < ictx->seg_num)
 		pthread_cond_wait(&ictx->cond, &ictx->mutex);
 	pthread_mutex_unlock(&ictx->mutex);
 
+	bh = erofs_balloc(DATA, 0, 0, 0);
+	if (IS_ERR(bh))
+		return PTR_ERR(bh);
+
+	DBG_BUGON(!head);
+	blkaddr = erofs_mapbh(bh->block);
+
 	ret = 0;
-	while (head) {
+	do {
 		cur = head;
 		head = cur->next;
 
@@ -1338,14 +1380,19 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
 			if (ret2)
 				ret = ret2;
 
-			*compressed_blocks += cur->ctx.blkaddr - blkaddr;
+			compressed_blocks += cur->ctx.blkaddr - blkaddr;
 			blkaddr = cur->ctx.blkaddr;
 		}
 
 		cur->next = z_erofs_mt_ctrl.idle;
 		z_erofs_mt_ctrl.idle = cur;
-	}
-	return ret;
+	} while(head);
+
+	if (ret)
+		return ret;
+
+	return erofs_commit_compressed_file(ictx, bh,
+			blkaddr - compressed_blocks, compressed_blocks);
 }
 #endif
 
@@ -1355,9 +1402,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	struct erofs_buffer_head *bh;
 	static struct z_erofs_compress_ictx ctx;
 	static struct z_erofs_compress_sctx sctx;
-	erofs_blk_t blkaddr, compressed_blocks = 0;
+	erofs_blk_t blkaddr;
 	int ret;
-	bool ismt = false;
 	struct erofs_sb_info *sbi = inode->sbi;
 
 	/* initialize per-file compression setting */
@@ -1412,75 +1458,57 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	init_list_head(&ctx.extents);
 	ctx.fix_dedupedfrag = false;
 	ctx.fragemitted = false;
-	sctx = (struct z_erofs_compress_sctx) { .ictx = &ctx, };
-	init_list_head(&sctx.extents);
-
-	/* allocate main data buffer */
-	bh = erofs_balloc(DATA, 0, 0, 0);
-	if (IS_ERR(bh))
-		return PTR_ERR(bh);
-	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 
 	if (cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
 	    !inode->fragment_size) {
 		ret = z_erofs_pack_file_from_fd(inode, fd, ctx.tof_chksum);
 		if (ret)
 			goto err_free_idata;
+	}
 #ifdef EROFS_MT_ENABLED
-	} else if (z_erofs_mt_enabled && inode->i_size > cfg.c_segment_size) {
-		ismt = true;
-		ret = z_erofs_mt_compress(&ctx, blkaddr, &compressed_blocks);
+	if (z_erofs_mt_enabled) {
+		ret = z_erofs_mt_compress(&ctx);
 		if (ret)
 			goto err_free_idata;
+		return erofs_mt_write_compressed_file(&ctx);
+
+	}
 #endif
-	} else {
-		ctx.seg_num = 1;
-		sctx.queue = g_queue;
-		sctx.destbuf = NULL;
-		sctx.chandle = &ctx.ccfg->handle;
-		sctx.remaining = inode->i_size - inode->fragment_size;
-		sctx.seg_idx = 0;
-		sctx.pivot = &dummy_pivot;
-		sctx.pclustersize = z_erofs_get_max_pclustersize(inode);
-
-		ret = z_erofs_compress_segment(&sctx, -1, blkaddr);
-		if (ret)
-			goto err_free_idata;
-		compressed_blocks = sctx.blkaddr - blkaddr;
+	/* allocate main data buffer */
+	bh = erofs_balloc(DATA, 0, 0, 0);
+	if (IS_ERR(bh)) {
+		ret = PTR_ERR(bh);
+		goto err_free_idata;
 	}
+	blkaddr = erofs_mapbh(bh->block); /* start_blkaddr */
+
+	ctx.seg_num = 1;
+	sctx = (struct z_erofs_compress_sctx) {
+		.ictx = &ctx,
+		.queue = g_queue,
+		.chandle = &ctx.ccfg->handle,
+		.remaining = inode->i_size - inode->fragment_size,
+		.seg_idx = 0,
+		.pivot = &dummy_pivot,
+		.pclustersize = z_erofs_get_max_pclustersize(inode),
+	};
+	init_list_head(&sctx.extents);
 
-	/* generate an extent for the deduplicated fragment */
-	if (inode->fragment_size && !ctx.fragemitted) {
-		struct z_erofs_extent_item *ei;
-
-		ei = malloc(sizeof(*ei));
-		if (!ei) {
-			ret = -ENOMEM;
-			goto err_free_idata;
-		}
-
-		ei->e = (struct z_erofs_inmem_extent) {
-			.length = inode->fragment_size,
-			.compressedblks = 0,
-			.raw = false,
-			.partial = false,
-			.blkaddr = sctx.blkaddr,
-		};
-		init_list_head(&ei->list);
-		z_erofs_commit_extent(&sctx, ei);
-	}
-	z_erofs_fragments_commit(inode);
-	if (!ismt)
-		list_splice_tail(&sctx.extents, &ctx.extents);
+	ret = z_erofs_compress_segment(&sctx, -1, blkaddr);
+	if (ret)
+		goto err_bdrop;
+	list_splice_tail(&sctx.extents, &ctx.extents);
 
 	return erofs_commit_compressed_file(&ctx, bh, blkaddr,
-					    compressed_blocks);
+					    sctx.blkaddr - blkaddr);
+
+err_bdrop:
+	erofs_bdrop(bh, true);	/* revoke buffer */
 err_free_idata:
 	if (inode->idata) {
 		free(inode->idata);
 		inode->idata = NULL;
 	}
-	erofs_bdrop(bh, true);	/* revoke buffer */
 	return ret;
 }
 
@@ -1627,15 +1655,13 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 
 	z_erofs_mt_enabled = false;
 #ifdef EROFS_MT_ENABLED
-	if (cfg.c_mt_workers > 1) {
-		pthread_mutex_init(&z_erofs_mt_ctrl.mutex, NULL);
-		ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq,
-					    cfg.c_mt_workers,
-					    cfg.c_mt_workers << 2,
-					    z_erofs_mt_wq_tls_alloc,
-					    z_erofs_mt_wq_tls_free);
-		z_erofs_mt_enabled = !ret;
-	}
+	pthread_mutex_init(&z_erofs_mt_ctrl.mutex, NULL);
+	ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq,
+				    cfg.c_mt_workers,
+				    cfg.c_mt_workers << 2,
+				    z_erofs_mt_wq_tls_alloc,
+				    z_erofs_mt_wq_tls_free);
+	z_erofs_mt_enabled = !ret;
 #endif
 	return 0;
 }
-- 
2.30.2

