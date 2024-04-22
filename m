Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D088AC270
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 02:36:15 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FH6CsCzV;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VN5s94Dz4z3cPW
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 10:36:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FH6CsCzV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VN5s53PF5z3cXm
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Apr 2024 10:36:09 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9603DCE0A07;
	Mon, 22 Apr 2024 00:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B08C113CE;
	Mon, 22 Apr 2024 00:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713746166;
	bh=NvFMywj3P4xV2vEb5RipJ5Dq1KnuvDfc93XlUiSVZSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FH6CsCzVPlz7AB4gCZPAlXfO/lg2BljoCuJIOzyeTxiKOkL7mYdejb3KC+DW5GQGX
	 Q8h9JPnh9FoY2pb/2P1XNlVXKeRJ5/XosxrRHxyVvN5MGHl1ZaK67dscBEK73dFgyT
	 3DyxbUKrH7zawfaGSPA9LrKrF+ryntRL9Pv7RLgTqR4zAISjHkBPisD144Vduvm/lJ
	 JykK+82712hT4Pg3Jq4Xe9siD5zVdT2ur8KZ5xLx3hkibqYNKgSV6eccH9t7WFedVr
	 4FNc3gaeg06F3gpL52fHBqH8LqTvye/mThkFTNWNt0varME/ECMg7YA3X8mE8bm1dv
	 HRQrWVpWOoXMQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 4/8] erofs-utils: rearrange several fields for multi-threaded mkfs
Date: Mon, 22 Apr 2024 08:34:46 +0800
Message-Id: <20240422003450.19132-4-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240422003450.19132-1-xiang@kernel.org>
References: <20240422003450.19132-1-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

They should be located in `struct z_erofs_compress_ictx`.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 57 +++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 8ca4033..0bc5426 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -38,6 +38,7 @@ struct z_erofs_extent_item {
 
 struct z_erofs_compress_ictx {		/* inode context */
 	struct erofs_inode *inode;
+	struct erofs_compress_cfg *ccfg;
 	int fd;
 	u64 fpos;
 
@@ -49,6 +50,14 @@ struct z_erofs_compress_ictx {		/* inode context */
 	u8 *metacur;
 	struct list_head extents;
 	u16 clusterofs;
+
+	int seg_num;
+
+#if EROFS_MT_ENABLED
+	pthread_mutex_t mutex;
+	pthread_cond_t cond;
+	int nfini;
+#endif
 };
 
 struct z_erofs_compress_sctx {		/* segment context */
@@ -68,7 +77,7 @@ struct z_erofs_compress_sctx {		/* segment context */
 	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
 	u16 clusterofs;
 
-	int seg_num, seg_idx;
+	int seg_idx;
 
 	void *membuf;
 	erofs_off_t memoff;
@@ -98,9 +107,6 @@ struct erofs_compress_work {
 static struct {
 	struct erofs_workqueue wq;
 	struct erofs_compress_work *idle;
-	pthread_mutex_t mutex;
-	pthread_cond_t cond;
-	int nfini;
 } z_erofs_mt_ctrl;
 #endif
 
@@ -513,7 +519,7 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	struct erofs_compress *const h = ctx->chandle;
 	unsigned int len = ctx->tail - ctx->head;
 	bool is_packed_inode = erofs_is_packed_inode(inode);
-	bool tsg = (ctx->seg_idx + 1 >= ctx->seg_num), final = !ctx->remaining;
+	bool tsg = (ctx->seg_idx + 1 >= ictx->seg_num), final = !ctx->remaining;
 	bool may_packing = (cfg.c_fragments && tsg && final &&
 			    !is_packed_inode && !z_erofs_mt_enabled);
 	bool may_inline = (cfg.c_ztailpacking && tsg && final && !may_packing);
@@ -1201,7 +1207,8 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 	struct erofs_compress_work *cwork = (struct erofs_compress_work *)work;
 	struct erofs_compress_wq_tls *tls = tlsp;
 	struct z_erofs_compress_sctx *sctx = &cwork->ctx;
-	struct erofs_inode *inode = sctx->ictx->inode;
+	struct z_erofs_compress_ictx *ictx = sctx->ictx;
+	struct erofs_inode *inode = ictx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
 	int ret = 0;
 
@@ -1228,10 +1235,10 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 
 out:
 	cwork->errcode = ret;
-	pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
-	++z_erofs_mt_ctrl.nfini;
-	pthread_cond_signal(&z_erofs_mt_ctrl.cond);
-	pthread_mutex_unlock(&z_erofs_mt_ctrl.mutex);
+	pthread_mutex_lock(&ictx->mutex);
+	++ictx->nfini;
+	pthread_cond_signal(&ictx->cond);
+	pthread_mutex_unlock(&ictx->mutex);
 }
 
 int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
@@ -1268,16 +1275,19 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
 }
 
 int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
-			struct erofs_compress_cfg *ccfg,
 			erofs_blk_t blkaddr,
 			erofs_blk_t *compressed_blocks)
 {
 	struct erofs_compress_work *cur, *head = NULL, **last = &head;
+	struct erofs_compress_cfg *ccfg = ictx->ccfg;
 	struct erofs_inode *inode = ictx->inode;
 	int nsegs = DIV_ROUND_UP(inode->i_size, cfg.c_segment_size);
 	int ret, i;
 
-	z_erofs_mt_ctrl.nfini = 0;
+	ictx->seg_num = nsegs;
+	ictx->nfini = 0;
+	pthread_mutex_init(&ictx->mutex, NULL);
+	pthread_cond_init(&ictx->cond, NULL);
 
 	for (i = 0; i < nsegs; i++) {
 		if (z_erofs_mt_ctrl.idle) {
@@ -1294,7 +1304,6 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
 
 		cur->ctx = (struct z_erofs_compress_sctx) {
 			.ictx = ictx,
-			.seg_num = nsegs,
 			.seg_idx = i,
 			.pivot = &dummy_pivot,
 		};
@@ -1316,11 +1325,10 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
 		erofs_queue_work(&z_erofs_mt_ctrl.wq, &cur->work);
 	}
 
-	pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
-	while (z_erofs_mt_ctrl.nfini != nsegs)
-		pthread_cond_wait(&z_erofs_mt_ctrl.cond,
-				  &z_erofs_mt_ctrl.mutex);
-	pthread_mutex_unlock(&z_erofs_mt_ctrl.mutex);
+	pthread_mutex_lock(&ictx->mutex);
+	while (ictx->nfini < ictx->seg_num)
+		pthread_cond_wait(&ictx->cond, &ictx->mutex);
+	pthread_mutex_unlock(&ictx->mutex);
 
 	ret = 0;
 	while (head) {
@@ -1354,7 +1362,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	struct erofs_buffer_head *bh;
 	static struct z_erofs_compress_ictx ctx;
 	static struct z_erofs_compress_sctx sctx;
-	struct erofs_compress_cfg *ccfg;
 	erofs_blk_t blkaddr, compressed_blocks = 0;
 	int ret;
 	bool ismt = false;
@@ -1389,8 +1396,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 		}
 	}
 #endif
-	ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
-	inode->z_algorithmtype[0] = ccfg[0].algorithmtype;
+	ctx.ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
+	inode->z_algorithmtype[0] = ctx.ccfg->algorithmtype;
 	inode->z_algorithmtype[1] = 0;
 
 	inode->idata_size = 0;
@@ -1429,16 +1436,16 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 #ifdef EROFS_MT_ENABLED
 	} else if (z_erofs_mt_enabled && inode->i_size > cfg.c_segment_size) {
 		ismt = true;
-		ret = z_erofs_mt_compress(&ctx, ccfg, blkaddr, &compressed_blocks);
+		ret = z_erofs_mt_compress(&ctx, blkaddr, &compressed_blocks);
 		if (ret)
 			goto err_free_idata;
 #endif
 	} else {
+		ctx.seg_num = 1;
 		sctx.queue = g_queue;
 		sctx.destbuf = NULL;
-		sctx.chandle = &ccfg->handle;
+		sctx.chandle = &ctx.ccfg->handle;
 		sctx.remaining = inode->i_size - inode->fragment_size;
-		sctx.seg_num = 1;
 		sctx.seg_idx = 0;
 		sctx.pivot = &dummy_pivot;
 		sctx.pclustersize = z_erofs_get_max_pclustersize(inode);
@@ -1628,8 +1635,6 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	z_erofs_mt_enabled = false;
 #ifdef EROFS_MT_ENABLED
 	if (cfg.c_mt_workers > 1) {
-		pthread_mutex_init(&z_erofs_mt_ctrl.mutex, NULL);
-		pthread_cond_init(&z_erofs_mt_ctrl.cond, NULL);
 		ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq,
 					    cfg.c_mt_workers,
 					    cfg.c_mt_workers << 2,
-- 
2.30.2

