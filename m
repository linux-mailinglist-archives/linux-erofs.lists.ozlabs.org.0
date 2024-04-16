Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED7F8A65A6
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 10:05:14 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qllyT8+U;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJc600yv9z3dVr
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 18:05:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qllyT8+U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJc5R4hjMz3cGY
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Apr 2024 18:04:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3FDCCCE0F47;
	Tue, 16 Apr 2024 08:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6F7C113CE;
	Tue, 16 Apr 2024 08:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713254680;
	bh=9HeRFSdx4oNy2iO3NTrQgvV4QwgdqPBXZw6/rl1MQzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qllyT8+U9tIflwsTFk+n4ioTBpkD2tOzlzZnjhnWEuGf5IydjnOiH6+if30qHm/Hk
	 AT33HRAsX/gXXFKLmROh1PTKFO50X+xB3NWuclKnAKI44cceczp17eEoF6Gl4htUrB
	 3sqDI9YfUn7VhNvwgJlgc5N+ZibnNPu+oRKeEXpbJIkgQb6IAkZZw732pq5bGQbuu2
	 h6S8XaEA/RrFrhQ8UScL9iL5ffTrcO1xBtl1AH637FZpqHZSensDJ60kAW84IFEKbn
	 pJ4Wtgb6WsiUBs9c4Wj9SmHuIfjpBZuvxnXWSGa3aZUD7hCOf6ykxGLxoIREGSp0SQ
	 zsp3OlytcRBaw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/8] erofs-utils: rearrange several fields for multi-threaded mkfs
Date: Tue, 16 Apr 2024 16:04:15 +0800
Message-Id: <20240416080419.32491-4-xiang@kernel.org>
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

They should be located in `struct z_erofs_compress_ictx`.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 55 ++++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index a2e0d0f..72f33d2 100644
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
@@ -99,8 +108,6 @@ static struct {
 	struct erofs_workqueue wq;
 	struct erofs_compress_work *idle;
 	pthread_mutex_t mutex;
-	pthread_cond_t cond;
-	int nfini;
 } z_erofs_mt_ctrl;
 #endif
 
@@ -512,7 +519,7 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	struct erofs_compress *const h = ctx->chandle;
 	unsigned int len = ctx->tail - ctx->head;
 	bool is_packed_inode = erofs_is_packed_inode(inode);
-	bool tsg = (ctx->seg_idx + 1 >= ctx->seg_num), final = !ctx->remaining;
+	bool tsg = (ctx->seg_idx + 1 >= ictx->seg_num), final = !ctx->remaining;
 	bool may_packing = (cfg.c_fragments && tsg && final &&
 			    !is_packed_inode && !z_erofs_mt_enabled);
 	bool may_inline = (cfg.c_ztailpacking && tsg && final && !may_packing);
@@ -1196,7 +1203,8 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 	struct erofs_compress_work *cwork = (struct erofs_compress_work *)work;
 	struct erofs_compress_wq_tls *tls = tlsp;
 	struct z_erofs_compress_sctx *sctx = &cwork->ctx;
-	struct erofs_inode *inode = sctx->ictx->inode;
+	struct z_erofs_compress_ictx *ictx = sctx->ictx;
+	struct erofs_inode *inode = ictx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
 	int ret = 0;
 
@@ -1223,10 +1231,10 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 
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
@@ -1260,16 +1268,19 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
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
@@ -1286,7 +1297,6 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
 
 		cur->ctx = (struct z_erofs_compress_sctx) {
 			.ictx = ictx,
-			.seg_num = nsegs,
 			.seg_idx = i,
 			.pivot = &dummy_pivot,
 		};
@@ -1308,11 +1318,10 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
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
@@ -1346,7 +1355,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	struct erofs_buffer_head *bh;
 	static struct z_erofs_compress_ictx ctx;
 	static struct z_erofs_compress_sctx sctx;
-	struct erofs_compress_cfg *ccfg;
 	erofs_blk_t blkaddr, compressed_blocks = 0;
 	int ret;
 	bool ismt = false;
@@ -1381,8 +1389,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 		}
 	}
 #endif
-	ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
-	inode->z_algorithmtype[0] = ccfg[0].algorithmtype;
+	ctx.ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
+	inode->z_algorithmtype[0] = ctx.ccfg->algorithmtype;
 	inode->z_algorithmtype[1] = 0;
 
 	inode->idata_size = 0;
@@ -1421,16 +1429,16 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
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
@@ -1621,7 +1629,6 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 #ifdef EROFS_MT_ENABLED
 	if (cfg.c_mt_workers > 1) {
 		pthread_mutex_init(&z_erofs_mt_ctrl.mutex, NULL);
-		pthread_cond_init(&z_erofs_mt_ctrl.cond, NULL);
 		ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq,
 					    cfg.c_mt_workers,
 					    cfg.c_mt_workers << 2,
-- 
2.30.2

