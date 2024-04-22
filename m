Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065118AC271
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 02:36:22 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ocaLKcN/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VN5sH4Kd4z3cgf
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 10:36:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ocaLKcN/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VN5s63RGkz3cSg
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Apr 2024 10:36:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6C431CE09FA;
	Mon, 22 Apr 2024 00:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99A5C2BD10;
	Mon, 22 Apr 2024 00:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713746168;
	bh=njkMVeIT/rDxK7cEFFrtdDqpQpFoWuktZqgTz5XF16A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ocaLKcN/IHrDu60F71A7Dz7rYGG6po8CDhzsLFMbX1abir9Qlj77HWcvM/YLA3hpJ
	 t9E8QGVcAz0+iw4V2vz+pqW2mbKFTu9H72kQut5MrDG7q9tw5NaoobUZaBp4Ha5KwT
	 aMp4+9DHJHOZFFAJ4AodL6EXn+AKz59f3S230khLGHZC5nVulYU6ChD7x1jNKYeDdl
	 Ph5V9G4pQURv9WVnb4LPIF5UicS1pwHeIm5PdlbjH5qef4CUqldkF5GwI1piSqEspv
	 HuYX/Zjn2tZ3sDUoPvRlJiivGM7Y8UBY7IVlcKxFPJRiTpRry0y8sCyBg/neww1kNr
	 95kuNIdbf5HwQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 5/8] erofs-utils: lib: split up z_erofs_mt_compress()
Date: Mon, 22 Apr 2024 08:34:47 +0800
Message-Id: <20240422003450.19132-5-xiang@kernel.org>
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

The on-disk compressed data write will be moved into a new function
erofs_mt_write_compressed_file().

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 162 ++++++++++++++++++++++++++++---------------------
 1 file changed, 93 insertions(+), 69 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 0bc5426..4ac4760 100644
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
 
@@ -530,11 +532,11 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	if (len <= ctx->pclustersize) {
 		if (!final || !len)
 			return 1;
+		if (inode->fragment_size && !ictx->fix_dedupedfrag) {
+			ctx->pclustersize = roundup(len, blksz);
+			goto fix_dedupedfrag;
+		}
 		if (may_packing) {
-			if (inode->fragment_size && !ictx->fix_dedupedfrag) {
-				ctx->pclustersize = roundup(len, blksz);
-				goto fix_dedupedfrag;
-			}
 			e->length = len;
 			goto frag_packing;
 		}
@@ -1034,6 +1036,26 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
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
 
@@ -1048,6 +1070,8 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 	u8 *compressmeta;
 	int ret;
 
+	z_erofs_fragments_commit(inode);
+
 	/* fall back to no compression mode */
 	DBG_BUGON(compressed_blocks < !!inode->idata_size);
 	compressed_blocks -= !!inode->idata_size;
@@ -1125,11 +1149,11 @@ err_free_meta:
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
 
@@ -1260,7 +1284,7 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
 		sctx->blkaddr += ei->e.compressedblks;
 
 		/* skip write data but leave blkaddr for inline fallback */
-		if (ei->e.inlined)
+		if (ei->e.inlined || !ei->e.compressedblks)
 			continue;
 		ret2 = blk_write(sbi, sctx->membuf + blkoff * erofs_blksiz(sbi),
 				 ei->e.blkaddr, ei->e.compressedblks);
@@ -1274,15 +1298,13 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
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
@@ -1290,11 +1312,12 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
 	pthread_cond_init(&ictx->cond, NULL);
 
 	for (i = 0; i < nsegs; i++) {
-		if (z_erofs_mt_ctrl.idle) {
-			cur = z_erofs_mt_ctrl.idle;
+		cur = z_erofs_mt_ctrl.idle;
+		if (cur) {
 			z_erofs_mt_ctrl.idle = cur->next;
 			cur->next = NULL;
-		} else {
+		}
+		if (!cur) {
 			cur = calloc(1, sizeof(*cur));
 			if (!cur)
 				return -ENOMEM;
@@ -1324,14 +1347,31 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
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
 
@@ -1345,14 +1385,19 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx,
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
 
@@ -1362,9 +1407,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	struct erofs_buffer_head *bh;
 	static struct z_erofs_compress_ictx ctx;
 	static struct z_erofs_compress_sctx sctx;
-	erofs_blk_t blkaddr, compressed_blocks = 0;
+	erofs_blk_t blkaddr;
 	int ret;
-	bool ismt = false;
 	struct erofs_sb_info *sbi = inode->sbi;
 
 	/* initialize per-file compression setting */
@@ -1419,14 +1463,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
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
@@ -1434,60 +1470,48 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 		if (ret)
 			goto err_free_idata;
 #ifdef EROFS_MT_ENABLED
-	} else if (z_erofs_mt_enabled && inode->i_size > cfg.c_segment_size) {
-		ismt = true;
-		ret = z_erofs_mt_compress(&ctx, blkaddr, &compressed_blocks);
+	} else if (z_erofs_mt_enabled) {
+		ret = z_erofs_mt_compress(&ctx);
 		if (ret)
 			goto err_free_idata;
+		return erofs_mt_write_compressed_file(&ctx);
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
 	}
-
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
+	/* allocate main data buffer */
+	bh = erofs_balloc(DATA, 0, 0, 0);
+	if (IS_ERR(bh)) {
+		ret = PTR_ERR(bh);
+		goto err_free_idata;
 	}
-	z_erofs_fragments_commit(inode);
-	if (!ismt)
-		list_splice_tail(&sctx.extents, &ctx.extents);
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
+
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
 
-- 
2.30.2

