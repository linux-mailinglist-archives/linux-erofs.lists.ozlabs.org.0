Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 201DE7E37D4
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Nov 2023 10:24:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SPjV71Rpdz3c76
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Nov 2023 20:24:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (unknown [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SPjTy2t8vz3bWy
	for <linux-erofs@lists.ozlabs.org>; Tue,  7 Nov 2023 20:24:32 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 7305D100A6581
	for <linux-erofs@lists.ozlabs.org>; Tue,  7 Nov 2023 17:24:19 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 0147E37C975;
	Tue,  7 Nov 2023 17:24:17 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: mkfs: generate on-disk indexes after compression
Date: Tue,  7 Nov 2023 17:23:43 +0800
Message-ID: <20231107092343.200359-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231106125824.153563-1-zhaoyifan@sjtu.edu.cn>
References: <20231106125824.153563-1-zhaoyifan@sjtu.edu.cn>
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
Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, mkfs generates the on-disk indexes of each compressed extent
on the fly during compressing, which is inflexible if we'd like to merge
sub-indexes of a file later for the multi-threaded compression scenarios.

Let's generate on-disk indexes after the compression for the file is
completed.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
Change since v1:
1. Polish commit message.
2. Iterate the extent list in a wrapper function to avoid massive change
   of indentation.
3. Remove the redundant reset_clusterofs field in struct z_erofs_inmem_extent.
   Instead, we check that if an uncompressed lcluster is aligned to 4K boundary
   and reset clusterofs to 0 during on-disk indexes generation.
   Note that this modification requires the `ctx->head >= ctx->clusterofs`
   being always true (lib/compress.c:328). Please reconfirm it as I may miss
   some corner cases.

 include/erofs/dedupe.h |   1 +
 lib/compress.c         | 253 ++++++++++++++++++++++++++---------------
 2 files changed, 163 insertions(+), 91 deletions(-)

diff --git a/include/erofs/dedupe.h b/include/erofs/dedupe.h
index 153bd4c..3a413bf 100644
--- a/include/erofs/dedupe.h
+++ b/include/erofs/dedupe.h
@@ -17,6 +17,7 @@ struct z_erofs_inmem_extent {
 	unsigned int compressedblks;
 	unsigned int length;
 	bool raw, partial;
+	struct list_head list;
 };
 
 struct z_erofs_dedupe_ctx {
diff --git a/lib/compress.c b/lib/compress.c
index 4eac363..42aa5ed 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -30,7 +30,7 @@ struct erofs_compress_cfg {
 
 struct z_erofs_vle_compress_ctx {
 	u8 queue[EROFS_CONFIG_COMPR_MAX_SZ * 2];
-	struct z_erofs_inmem_extent e;	/* (lookahead) extent */
+	struct list_head elist;		/* (lookahead) extent list */
 
 	struct erofs_inode *inode;
 	struct erofs_compress_cfg *ccfg;
@@ -49,36 +49,36 @@ struct z_erofs_vle_compress_ctx {
 
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	Z_EROFS_FULL_INDEX_ALIGN(0)
 
-static void z_erofs_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
+static void z_erofs_update_clusterofs(struct z_erofs_vle_compress_ctx *ctx)
 {
-	const unsigned int type = Z_EROFS_LCLUSTER_TYPE_PLAIN;
-	struct z_erofs_lcluster_index di;
+	struct z_erofs_inmem_extent *e;
+	unsigned int blksz = erofs_blksiz(ctx->inode->sbi);
+	unsigned int offset;
 
-	if (!ctx->clusterofs)
+	if (list_empty(&ctx->elist))
 		return;
 
-	di.di_clusterofs = cpu_to_le16(ctx->clusterofs);
-	di.di_u.blkaddr = 0;
-	di.di_advise = cpu_to_le16(type << Z_EROFS_LI_LCLUSTER_TYPE_BIT);
+	e = list_last_entry(&ctx->elist, struct z_erofs_inmem_extent, list);
+	if (e->length == 0)
+		return;
 
-	memcpy(ctx->metacur, &di, sizeof(di));
-	ctx->metacur += sizeof(di);
+	offset = e->length + ctx->clusterofs;
+	ctx->clusterofs = (offset < blksz) ? 0 : offset % blksz;
 }
 
-static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
+static void z_erofs_write_index(struct z_erofs_vle_compress_ctx *ctx,
+				struct z_erofs_inmem_extent *e)
 {
 	struct erofs_inode *inode = ctx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
-	unsigned int clusterofs = ctx->clusterofs;
-	unsigned int count = ctx->e.length;
-	unsigned int d0 = 0, d1 = (clusterofs + count) / erofs_blksiz(sbi);
+	unsigned int count = e->length;
+	unsigned int d0 = 0, d1 = (ctx->clusterofs + count) / erofs_blksiz(sbi);
 	struct z_erofs_lcluster_index di;
 	unsigned int type, advise;
 
 	if (!count)
 		return;
 
-	ctx->e.length = 0;	/* mark as written first */
 	di.di_clusterofs = cpu_to_le16(ctx->clusterofs);
 
 	/* whether the tail-end (un)compressed block or not */
@@ -87,18 +87,18 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 		 * A lcluster cannot have three parts with the middle one which
 		 * is well-compressed for !ztailpacking cases.
 		 */
-		DBG_BUGON(!ctx->e.raw && !cfg.c_ztailpacking && !cfg.c_fragments);
-		DBG_BUGON(ctx->e.partial);
-		type = ctx->e.raw ? Z_EROFS_LCLUSTER_TYPE_PLAIN :
+		DBG_BUGON(!e->raw && !cfg.c_ztailpacking && !cfg.c_fragments);
+		DBG_BUGON(e->partial);
+		type = e->raw ? Z_EROFS_LCLUSTER_TYPE_PLAIN :
 			Z_EROFS_LCLUSTER_TYPE_HEAD1;
 		advise = type << Z_EROFS_LI_LCLUSTER_TYPE_BIT;
 		di.di_advise = cpu_to_le16(advise);
 
 		if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL &&
-		    !ctx->e.compressedblks)
+			!e->compressedblks)
 			di.di_u.blkaddr = cpu_to_le32(inode->fragmentoff >> 32);
 		else
-			di.di_u.blkaddr = cpu_to_le32(ctx->e.blkaddr);
+			di.di_u.blkaddr = cpu_to_le32(e->blkaddr);
 		memcpy(ctx->metacur, &di, sizeof(di));
 		ctx->metacur += sizeof(di);
 
@@ -112,7 +112,7 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 		/* XXX: big pcluster feature should be per-inode */
 		if (d0 == 1 && erofs_sb_has_big_pcluster(sbi)) {
 			type = Z_EROFS_LCLUSTER_TYPE_NONHEAD;
-			di.di_u.delta[0] = cpu_to_le16(ctx->e.compressedblks |
+			di.di_u.delta[0] = cpu_to_le16(e->compressedblks |
 						       Z_EROFS_LI_D0_CBLKCNT);
 			di.di_u.delta[1] = cpu_to_le16(d1);
 		} else if (d0) {
@@ -136,17 +136,17 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 				di.di_u.delta[0] = cpu_to_le16(d0);
 			di.di_u.delta[1] = cpu_to_le16(d1);
 		} else {
-			type = ctx->e.raw ? Z_EROFS_LCLUSTER_TYPE_PLAIN :
+			type = e->raw ? Z_EROFS_LCLUSTER_TYPE_PLAIN :
 				Z_EROFS_LCLUSTER_TYPE_HEAD1;
 
 			if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL &&
-			    !ctx->e.compressedblks)
+				!e->compressedblks)
 				di.di_u.blkaddr = cpu_to_le32(inode->fragmentoff >> 32);
 			else
-				di.di_u.blkaddr = cpu_to_le32(ctx->e.blkaddr);
+				di.di_u.blkaddr = cpu_to_le32(e->blkaddr);
 
-			if (ctx->e.partial) {
-				DBG_BUGON(ctx->e.raw);
+			if (e->partial) {
+				DBG_BUGON(e->raw);
 				advise |= Z_EROFS_LI_PARTIAL_REF;
 			}
 		}
@@ -156,14 +156,49 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 		memcpy(ctx->metacur, &di, sizeof(di));
 		ctx->metacur += sizeof(di);
 
-		count -= erofs_blksiz(sbi) - clusterofs;
-		clusterofs = 0;
+		count -= erofs_blksiz(sbi) - ctx->clusterofs;
+		ctx->clusterofs = 0;
 
 		++d0;
 		--d1;
-	} while (clusterofs + count >= erofs_blksiz(sbi));
+	} while (ctx->clusterofs + count >= erofs_blksiz(sbi));
+
+	ctx->clusterofs = count;
+}
+
+static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
+{
+	struct z_erofs_inmem_extent *e, *n;
+	struct z_erofs_lcluster_index di;
+
+	if (list_empty(&ctx->elist))
+		return;
+
+	ctx->clusterofs = 0;
+
+	list_for_each_entry_safe(e, n, &ctx->elist, list) {
+		/*  
+		 * Uncompressed lcluster is aligned to lcluster boundary if
+		 * 0padding is disabled. See write_uncompressed_extent().
+		 */
+		if (!erofs_sb_has_lz4_0padding(ctx->inode->sbi) && e->raw &&
+		    ctx->clusterofs)
+			ctx->clusterofs = 0;
+
+		z_erofs_write_index(ctx, e);
+
+		list_del(&e->list);
+		free(e);
+	}
 
-	ctx->clusterofs = clusterofs + count;
+	if (ctx->clusterofs) {
+		di.di_clusterofs = cpu_to_le16(ctx->clusterofs);
+		di.di_u.blkaddr = 0;
+		di.di_advise = cpu_to_le16(Z_EROFS_LCLUSTER_TYPE_PLAIN
+					   << Z_EROFS_LI_LCLUSTER_TYPE_BIT);
+		memcpy(ctx->metacur, &di, sizeof(di));
+		ctx->metacur += sizeof(di);
+	}
 }
 
 static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
@@ -172,8 +207,19 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 	struct erofs_inode *inode = ctx->inode;
 	const unsigned int lclustermask = (1 << inode->z_logical_clusterbits) - 1;
 	struct erofs_sb_info *sbi = inode->sbi;
+	struct z_erofs_inmem_extent *e, *newe;
+	int elen = 0;
 	int ret = 0;
 
+	if (list_empty(&ctx->elist)) {
+		e = NULL;
+		elen = 0;
+	} else {
+		e = list_last_entry(&ctx->elist, struct z_erofs_inmem_extent,
+				    list);
+		elen = e->length;
+	}
+
 	/*
 	 * No need dedupe for packed inode since it is composed of
 	 * fragments which have already been deduplicated.
@@ -184,12 +230,12 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 	do {
 		struct z_erofs_dedupe_ctx dctx = {
 			.start = ctx->queue + ctx->head - ({ int rc;
-				if (ctx->e.length <= erofs_blksiz(sbi))
+				if (elen <= erofs_blksiz(sbi))
 					rc = 0;
-				else if (ctx->e.length - erofs_blksiz(sbi) >= ctx->head)
+				else if (elen - erofs_blksiz(sbi) >= ctx->head)
 					rc = ctx->head;
 				else
-					rc = ctx->e.length - erofs_blksiz(sbi);
+					rc = elen - erofs_blksiz(sbi);
 				rc; }),
 			.end = ctx->queue + ctx->head + *len,
 			.cur = ctx->queue + ctx->head,
@@ -206,25 +252,25 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 		 * decompresssion could be done as another try in practice.
 		 */
 		if (dctx.e.compressedblks > 1 &&
-		    ((ctx->clusterofs + ctx->e.length - delta) & lclustermask) +
+		    ((ctx->clusterofs + elen - delta) & lclustermask) +
 			dctx.e.length < 2 * (lclustermask + 1))
 			break;
 
 		if (delta) {
 			DBG_BUGON(delta < 0);
-			DBG_BUGON(!ctx->e.length);
+			DBG_BUGON(!e);
 
 			/*
 			 * For big pcluster dedupe, if we decide to shorten the
 			 * previous big pcluster, make sure that the previous
 			 * CBLKCNT is still kept.
 			 */
-			if (ctx->e.compressedblks > 1 &&
-			    (ctx->clusterofs & lclustermask) + ctx->e.length
+			if (e->compressedblks > 1 &&
+			    (ctx->clusterofs & lclustermask) + e->length
 				- delta < 2 * (lclustermask + 1))
 				break;
-			ctx->e.partial = true;
-			ctx->e.length -= delta;
+			e->partial = true;
+			e->length -= delta;
 		}
 
 		/* fall back to noncompact indexes for deduplication */
@@ -237,8 +283,16 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 		erofs_dbg("Dedupe %u %scompressed data (delta %d) to %u of %u blocks",
 			  dctx.e.length, dctx.e.raw ? "un" : "",
 			  delta, dctx.e.blkaddr, dctx.e.compressedblks);
-		z_erofs_write_indexes(ctx);
-		ctx->e = dctx.e;
+		z_erofs_update_clusterofs(ctx);
+
+		newe = malloc(sizeof(*newe));
+		if (!newe) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		memcpy(newe, &dctx.e, sizeof(*newe));
+		list_add_tail(&newe->list, &ctx->elist);
+
 		ctx->head += dctx.e.length - delta;
 		DBG_BUGON(*len < dctx.e.length - delta);
 		*len -= dctx.e.length - delta;
@@ -258,7 +312,7 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 	} while (*len);
 
 out:
-	z_erofs_write_indexes(ctx);
+	z_erofs_update_clusterofs(ctx);
 	return ret;
 }
 
@@ -400,10 +454,11 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 	unsigned int blksz = erofs_blksiz(sbi);
 	char *const dst = dstbuf + blksz;
 	struct erofs_compress *const h = &ctx->ccfg->handle;
+	struct z_erofs_inmem_extent *e = NULL;
 	unsigned int len = ctx->tail - ctx->head;
 	bool is_packed_inode = erofs_is_packed_inode(inode);
 	bool final = !ctx->remaining;
-	int ret;
+	int ret = 0;
 
 	while (len) {
 		bool may_packing = (cfg.c_fragments && final &&
@@ -416,39 +471,43 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 		if (z_erofs_compress_dedupe(ctx, &len) && !final)
 			break;
 
+		e = malloc(sizeof(*e));
+		if (!e)
+			return -ENOMEM;
+
 		if (len <= ctx->pclustersize) {
 			if (!final || !len)
-				break;
+				goto free_extent;
 			if (may_packing) {
 				if (inode->fragment_size && !fix_dedupedfrag) {
 					ctx->pclustersize = roundup(len, blksz);
 					goto fix_dedupedfrag;
 				}
-				ctx->e.length = len;
+				e->length = len;
 				goto frag_packing;
 			}
 			if (!may_inline && len <= blksz)
 				goto nocompression;
 		}
 
-		ctx->e.length = min(len,
+		e->length = min(len,
 				cfg.c_max_decompressed_extent_bytes);
 
 		ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
-				&ctx->e.length, dst, ctx->pclustersize);
+				&e->length, dst, ctx->pclustersize);
 		if (ret <= 0) {
 			erofs_err("failed to compress %s: %s", inode->i_srcpath,
 				  erofs_strerror(ret));
-			return ret;
+			goto free_extent;
 		}
 
 		compressedsize = ret;
 		/* even compressed size is smaller, there is no real gain */
-		if (!(may_inline && ctx->e.length == len && ret < blksz))
+		if (!(may_inline && e->length == len && ret < blksz))
 			ret = roundup(ret, blksz);
 
 		/* check if there is enough gain to keep the compressed data */
-		if (ret * h->compress_threshold / 100 >= ctx->e.length) {
+		if (ret * h->compress_threshold / 100 >= e->length) {
 			if (may_inline && len < blksz) {
 				ret = z_erofs_fill_inline_data(inode,
 						ctx->queue + ctx->head,
@@ -461,17 +520,17 @@ nocompression:
 			}
 
 			if (ret < 0)
-				return ret;
-			ctx->e.length = ret;
+				goto free_extent;
+			e->length = ret;
 
 			/*
 			 * XXX: For now, we have to leave `ctx->compressedblks
 			 * = 1' since there is no way to generate compressed
 			 * indexes after the time that ztailpacking is decided.
 			 */
-			ctx->e.compressedblks = 1;
-			ctx->e.raw = true;
-		} else if (may_packing && len == ctx->e.length &&
+			e->compressedblks = 1;
+			e->raw = true;
+		} else if (may_packing && len == e->length &&
 			   compressedsize < ctx->pclustersize &&
 			   (!inode->fragment_size || fix_dedupedfrag)) {
 frag_packing:
@@ -479,18 +538,20 @@ frag_packing:
 						     ctx->queue + ctx->head,
 						     len, ctx->tof_chksum);
 			if (ret < 0)
-				return ret;
-			ctx->e.compressedblks = 0; /* indicate a fragment */
-			ctx->e.raw = false;
+				goto free_extent;
+			e->compressedblks = 0; /* indicate a fragment */
+			e->raw = false;
 			ctx->fragemitted = true;
 			fix_dedupedfrag = false;
 		/* tailpcluster should be less than 1 block */
-		} else if (may_inline && len == ctx->e.length &&
+		} else if (may_inline && len == e->length &&
 			   compressedsize < blksz) {
 			if (ctx->clusterofs + len <= blksz) {
 				inode->eof_tailraw = malloc(len);
-				if (!inode->eof_tailraw)
-					return -ENOMEM;
+				if (!inode->eof_tailraw) {
+					ret = -ENOMEM;
+					goto free_extent;
+				}
 
 				memcpy(inode->eof_tailraw,
 				       ctx->queue + ctx->head, len);
@@ -500,9 +561,9 @@ frag_packing:
 			ret = z_erofs_fill_inline_data(inode, dst,
 					compressedsize, false);
 			if (ret < 0)
-				return ret;
-			ctx->e.compressedblks = 1;
-			ctx->e.raw = false;
+				goto free_extent;
+			e->compressedblks = 1;
+			e->raw = false;
 		} else {
 			unsigned int tailused, padding;
 
@@ -513,7 +574,7 @@ frag_packing:
 			 * filled up. Fix up the fragment if succeeds.
 			 * Otherwise, just drop it and go to packing.
 			 */
-			if (may_packing && len == ctx->e.length &&
+			if (may_packing && len == e->length &&
 			    (compressedsize & (blksz - 1)) &&
 			    ctx->tail < sizeof(ctx->queue)) {
 				ctx->pclustersize =
@@ -521,15 +582,14 @@ frag_packing:
 				goto fix_dedupedfrag;
 			}
 
-			if (may_inline && len == ctx->e.length)
+			if (may_inline && len == e->length)
 				tryrecompress_trailing(ctx, h,
 						ctx->queue + ctx->head,
-						&ctx->e.length, dst,
+						&e->length, dst,
 						&compressedsize);
 
-			ctx->e.compressedblks = BLK_ROUND_UP(sbi, compressedsize);
-			DBG_BUGON(ctx->e.compressedblks * blksz >=
-				  ctx->e.length);
+			e->compressedblks = BLK_ROUND_UP(sbi, compressedsize);
+			DBG_BUGON(e->compressedblks * blksz >= e->length);
 
 			padding = 0;
 			tailused = compressedsize & (blksz - 1);
@@ -544,25 +604,26 @@ frag_packing:
 
 			/* write compressed data */
 			erofs_dbg("Writing %u compressed data to %u of %u blocks",
-				  ctx->e.length, ctx->blkaddr,
-				  ctx->e.compressedblks);
+				  e->length, ctx->blkaddr,
+				  e->compressedblks);
 
 			ret = blk_write(sbi, dst - padding, ctx->blkaddr,
-					ctx->e.compressedblks);
+					e->compressedblks);
 			if (ret)
-				return ret;
-			ctx->e.raw = false;
+				goto free_extent;
+			e->raw = false;
 			may_inline = false;
 			may_packing = false;
 		}
-		ctx->e.partial = false;
-		ctx->e.blkaddr = ctx->blkaddr;
+		e->partial = false;
+		e->blkaddr = ctx->blkaddr;
 		if (!may_inline && !may_packing && !is_packed_inode)
-			(void)z_erofs_dedupe_insert(&ctx->e,
-						    ctx->queue + ctx->head);
-		ctx->blkaddr += ctx->e.compressedblks;
-		ctx->head += ctx->e.length;
-		len -= ctx->e.length;
+			(void)z_erofs_dedupe_insert(e, ctx->queue + ctx->head);
+		ctx->blkaddr += e->compressedblks;
+		ctx->head += e->length;
+		len -= e->length;
+
+		list_add_tail(&e->list, &ctx->elist);
 
 		if (fix_dedupedfrag &&
 		    z_erofs_fixup_deduped_fragment(ctx, len))
@@ -585,9 +646,14 @@ frag_packing:
 fix_dedupedfrag:
 	DBG_BUGON(!inode->fragment_size);
 	ctx->remaining += inode->fragment_size;
-	ctx->e.length = 0;
 	ctx->fix_dedupedfrag = true;
+	e->length = 0;
+	list_add_tail(&e->list, &ctx->elist);
 	return 0;
+
+free_extent:
+	free(e);
+	return ret;
 }
 
 struct z_erofs_compressindex_vec {
@@ -942,10 +1008,10 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	ctx.head = ctx.tail = 0;
 	ctx.clusterofs = 0;
-	ctx.e.length = 0;
 	ctx.remaining = inode->i_size - inode->fragment_size;
 	ctx.fix_dedupedfrag = false;
 	ctx.fragemitted = false;
+	init_list_head(&ctx.elist);
 	if (cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
 	    !inode->fragment_size) {
 		ret = z_erofs_pack_file_from_fd(inode, fd, ctx.tof_chksum);
@@ -978,17 +1044,22 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 
 	/* generate an extent for the deduplicated fragment */
 	if (inode->fragment_size && !ctx.fragemitted) {
-		z_erofs_write_indexes(&ctx);
-		ctx.e.length = inode->fragment_size;
-		ctx.e.compressedblks = 0;
-		ctx.e.raw = false;
-		ctx.e.partial = false;
-		ctx.e.blkaddr = ctx.blkaddr;
+		struct z_erofs_inmem_extent *e = malloc(sizeof(*e));
+		if (!e) {
+			ret = -ENOMEM;
+			goto err_free_idata;
+		}
+		z_erofs_update_clusterofs(&ctx);
+		e->length = inode->fragment_size;
+		e->compressedblks = 0;
+		e->raw = false;
+		e->partial = false;
+		e->blkaddr = ctx.blkaddr;
+		list_add_tail(&e->list, &ctx.elist);
 	}
 	z_erofs_fragments_commit(inode);
 
 	z_erofs_write_indexes(&ctx);
-	z_erofs_write_indexes_final(&ctx);
 	legacymetasize = ctx.metacur - compressmeta;
 	/* estimate if data compression saves space or not */
 	if (!inode->fragment_size &&
-- 
2.42.1

