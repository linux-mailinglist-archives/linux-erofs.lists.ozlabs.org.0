Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444CD81745D
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Dec 2023 15:57:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sv2x65rbDz3bsj
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Dec 2023 01:57:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sv2x05mwLz30YN
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Dec 2023 01:57:22 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vynf.pl_1702911437;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vynf.pl_1702911437)
          by smtp.aliyun-inc.com;
          Mon, 18 Dec 2023 22:57:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 3/3] erofs-utils: lib: generate compression indexes in memory first
Date: Mon, 18 Dec 2023 22:57:10 +0800
Message-Id: <20231218145710.132164-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231218145710.132164-1-hsiangkao@linux.alibaba.com>
References: <20231107092343.200359-1-zhaoyifan@sjtu.edu.cn>
 <20231218145710.132164-1-hsiangkao@linux.alibaba.com>
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

From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>

Currently, mkfs generates the on-disk indexes of each compressed extent
on the fly during compressing, which is inflexible if we'd like to merge
sub-indexes of a file later for the multi-threaded scenarios.

Let's generate on-disk indexes after the compression is completed.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 185 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 121 insertions(+), 64 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index eafbad1..8f61f92 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -28,9 +28,15 @@ struct erofs_compress_cfg {
 	bool enable;
 } erofs_ccfg[EROFS_MAX_COMPR_CFGS];
 
+struct z_erofs_extent_item {
+	struct list_head list;
+	struct z_erofs_inmem_extent e;
+};
+
 struct z_erofs_vle_compress_ctx {
 	u8 queue[EROFS_CONFIG_COMPR_MAX_SZ * 2];
-	struct z_erofs_inmem_extent e;	/* (lookahead) extent */
+	struct list_head extents;
+	struct z_erofs_extent_item *pivot;
 
 	struct erofs_inode *inode;
 	struct erofs_compress_cfg *ccfg;
@@ -65,20 +71,18 @@ static void z_erofs_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
 	ctx->metacur += sizeof(di);
 }
 
-static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
+static void z_erofs_write_extent(struct z_erofs_vle_compress_ctx *ctx,
+				 struct z_erofs_inmem_extent *e)
 {
 	struct erofs_inode *inode = ctx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
 	unsigned int clusterofs = ctx->clusterofs;
-	unsigned int count = ctx->e.length;
+	unsigned int count = e->length;
 	unsigned int d0 = 0, d1 = (clusterofs + count) / erofs_blksiz(sbi);
 	struct z_erofs_lcluster_index di;
 	unsigned int type, advise;
 
-	if (!count)
-		return;
-
-	ctx->e.length = 0;	/* mark as written first */
+	DBG_BUGON(!count);
 	di.di_clusterofs = cpu_to_le16(ctx->clusterofs);
 
 	/* whether the tail-end (un)compressed block or not */
@@ -87,18 +91,18 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
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
+		    !e->compressedblks)
 			di.di_u.blkaddr = cpu_to_le32(inode->fragmentoff >> 32);
 		else
-			di.di_u.blkaddr = cpu_to_le32(ctx->e.blkaddr);
+			di.di_u.blkaddr = cpu_to_le32(e->blkaddr);
 		memcpy(ctx->metacur, &di, sizeof(di));
 		ctx->metacur += sizeof(di);
 
@@ -112,7 +116,7 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 		/* XXX: big pcluster feature should be per-inode */
 		if (d0 == 1 && erofs_sb_has_big_pcluster(sbi)) {
 			type = Z_EROFS_LCLUSTER_TYPE_NONHEAD;
-			di.di_u.delta[0] = cpu_to_le16(ctx->e.compressedblks |
+			di.di_u.delta[0] = cpu_to_le16(e->compressedblks |
 						       Z_EROFS_LI_D0_CBLKCNT);
 			di.di_u.delta[1] = cpu_to_le16(d1);
 		} else if (d0) {
@@ -136,17 +140,17 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 				di.di_u.delta[0] = cpu_to_le16(d0);
 			di.di_u.delta[1] = cpu_to_le16(d1);
 		} else {
-			type = ctx->e.raw ? Z_EROFS_LCLUSTER_TYPE_PLAIN :
+			type = e->raw ? Z_EROFS_LCLUSTER_TYPE_PLAIN :
 				Z_EROFS_LCLUSTER_TYPE_HEAD1;
 
 			if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL &&
-			    !ctx->e.compressedblks)
+			    !e->compressedblks)
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
@@ -166,6 +170,20 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 	ctx->clusterofs = clusterofs + count;
 }
 
+static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
+{
+	struct z_erofs_extent_item *ei, *n;
+
+	ctx->clusterofs = 0;
+	list_for_each_entry_safe(ei, n, &ctx->extents, list) {
+		z_erofs_write_extent(ctx, &ei->e);
+
+		list_del(&ei->list);
+		free(ei);
+	}
+	z_erofs_write_indexes_final(ctx);
+}
+
 static bool z_erofs_need_refill(struct z_erofs_vle_compress_ctx *ctx)
 {
 	const bool final = !ctx->remaining;
@@ -182,13 +200,25 @@ static bool z_erofs_need_refill(struct z_erofs_vle_compress_ctx *ctx)
 	return true;
 }
 
+static void z_erofs_commit_extent(struct z_erofs_vle_compress_ctx *ctx,
+				  struct z_erofs_extent_item *ei)
+{
+	list_add_tail(&ei->list, &ctx->extents);
+	ctx->clusterofs = (ctx->clusterofs + ei->e.length) &
+			(erofs_blksiz(ctx->inode->sbi) - 1);
+
+}
+
 static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 				   unsigned int *len)
 {
 	struct erofs_inode *inode = ctx->inode;
 	const unsigned int lclustermask = (1 << inode->z_logical_clusterbits) - 1;
 	struct erofs_sb_info *sbi = inode->sbi;
-	int ret = 0;
+	struct z_erofs_extent_item *ei = ctx->pivot;
+
+	if (!ei)
+		return 0;
 
 	/*
 	 * No need dedupe for packed inode since it is composed of
@@ -200,12 +230,12 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 	do {
 		struct z_erofs_dedupe_ctx dctx = {
 			.start = ctx->queue + ctx->head - ({ int rc;
-				if (ctx->e.length <= erofs_blksiz(sbi))
+				if (ei->e.length <= erofs_blksiz(sbi))
 					rc = 0;
-				else if (ctx->e.length - erofs_blksiz(sbi) >= ctx->head)
+				else if (ei->e.length - erofs_blksiz(sbi) >= ctx->head)
 					rc = ctx->head;
 				else
-					rc = ctx->e.length - erofs_blksiz(sbi);
+					rc = ei->e.length - erofs_blksiz(sbi);
 				rc; }),
 			.end = ctx->queue + ctx->head + *len,
 			.cur = ctx->queue + ctx->head,
@@ -222,25 +252,31 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 		 * decompresssion could be done as another try in practice.
 		 */
 		if (dctx.e.compressedblks > 1 &&
-		    ((ctx->clusterofs + ctx->e.length - delta) & lclustermask) +
+		    ((ctx->clusterofs + ei->e.length - delta) & lclustermask) +
 			dctx.e.length < 2 * (lclustermask + 1))
 			break;
 
+		ctx->pivot = malloc(sizeof(struct z_erofs_extent_item));
+		if (!ctx->pivot) {
+			z_erofs_commit_extent(ctx, ei);
+			return -ENOMEM;
+		}
+
 		if (delta) {
 			DBG_BUGON(delta < 0);
-			DBG_BUGON(!ctx->e.length);
+			DBG_BUGON(!ei->e.length);
 
 			/*
 			 * For big pcluster dedupe, if we decide to shorten the
 			 * previous big pcluster, make sure that the previous
 			 * CBLKCNT is still kept.
 			 */
-			if (ctx->e.compressedblks > 1 &&
-			    (ctx->clusterofs & lclustermask) + ctx->e.length
+			if (ei->e.compressedblks > 1 &&
+			    (ctx->clusterofs & lclustermask) + ei->e.length
 				- delta < 2 * (lclustermask + 1))
 				break;
-			ctx->e.partial = true;
-			ctx->e.length -= delta;
+			ei->e.partial = true;
+			ei->e.length -= delta;
 		}
 
 		/* fall back to noncompact indexes for deduplication */
@@ -253,39 +289,32 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 		erofs_dbg("Dedupe %u %scompressed data (delta %d) to %u of %u blocks",
 			  dctx.e.length, dctx.e.raw ? "un" : "",
 			  delta, dctx.e.blkaddr, dctx.e.compressedblks);
-		z_erofs_write_indexes(ctx);
-		ctx->e = dctx.e;
+
+		z_erofs_commit_extent(ctx, ei);
+		ei = ctx->pivot;
+		init_list_head(&ei->list);
+		ei->e = dctx.e;
+
 		ctx->head += dctx.e.length - delta;
 		DBG_BUGON(*len < dctx.e.length - delta);
 		*len -= dctx.e.length - delta;
 
-		if (z_erofs_need_refill(ctx)) {
-			ret = -EAGAIN;
-			break;
-		}
+		if (z_erofs_need_refill(ctx))
+			return 1;
 	} while (*len);
-
 out:
-	z_erofs_write_indexes(ctx);
-	return ret;
+	z_erofs_commit_extent(ctx, ei);
+	ctx->pivot = NULL;
+	return 0;
 }
 
 static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
-				     unsigned int *len, char *dst)
+				     unsigned int len, char *dst)
 {
-	int ret;
 	struct erofs_sb_info *sbi = ctx->inode->sbi;
-	unsigned int count, interlaced_offset, rightpart;
-
-	/* reset clusterofs to 0 if permitted */
-	if (!erofs_sb_has_lz4_0padding(sbi) && ctx->clusterofs &&
-	    ctx->head >= ctx->clusterofs) {
-		ctx->head -= ctx->clusterofs;
-		*len += ctx->clusterofs;
-		ctx->clusterofs = 0;
-	}
-
-	count = min(erofs_blksiz(sbi), *len);
+	unsigned int count = min(erofs_blksiz(sbi), len);
+	unsigned int interlaced_offset, rightpart;
+	int ret;
 
 	/* write interlaced uncompressed data if needed */
 	if (ctx->inode->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
@@ -455,7 +484,8 @@ static int __z_erofs_compress_one(struct z_erofs_vle_compress_ctx *ctx,
 			may_inline = false;
 			may_packing = false;
 nocompression:
-			ret = write_uncompressed_extent(ctx, &len, dst);
+			/* TODO: reset clusterofs to 0 if permitted */
+			ret = write_uncompressed_extent(ctx, len, dst);
 		}
 
 		if (ret < 0)
@@ -554,7 +584,6 @@ frag_packing:
 fix_dedupedfrag:
 	DBG_BUGON(!inode->fragment_size);
 	ctx->remaining += inode->fragment_size;
-	e->length = 0;
 	ctx->fix_dedupedfrag = true;
 	return 1;
 }
@@ -562,20 +591,32 @@ fix_dedupedfrag:
 static int z_erofs_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 {
 	unsigned int len = ctx->tail - ctx->head;
-	int ret;
+	struct z_erofs_extent_item *ei;
 
 	while (len) {
-		if (z_erofs_compress_dedupe(ctx, &len))
+		int ret = z_erofs_compress_dedupe(ctx, &len);
+
+		if (ret > 0)
 			break;
+		else if (ret < 0)
+			return ret;
 
-		ret = __z_erofs_compress_one(ctx, &ctx->e);
+		DBG_BUGON(ctx->pivot);
+		ei = malloc(sizeof(*ei));
+		if (!ei)
+			return -ENOMEM;
+
+		init_list_head(&ei->list);
+		ret = __z_erofs_compress_one(ctx, &ei->e);
 		if (ret) {
+			free(ei);
 			if (ret > 0)
 				break;		/* need more data */
 			return ret;
 		}
 
-		len -= ctx->e.length;
+		len -= ei->e.length;
+		ctx->pivot = ei;
 		if (ctx->fix_dedupedfrag && !ctx->fragemitted &&
 		    z_erofs_fixup_deduped_fragment(ctx, len))
 			break;
@@ -939,7 +980,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	ctx.head = ctx.tail = 0;
 	ctx.clusterofs = 0;
-	ctx.e.length = 0;
+	ctx.pivot = NULL;
+	init_list_head(&ctx.extents);
 	ctx.remaining = inode->i_size - inode->fragment_size;
 	ctx.fix_dedupedfrag = false;
 	ctx.fragemitted = false;
@@ -973,19 +1015,34 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	DBG_BUGON(compressed_blocks < !!inode->idata_size);
 	compressed_blocks -= !!inode->idata_size;
 
+	if (ctx.pivot) {
+		z_erofs_commit_extent(&ctx, ctx.pivot);
+		ctx.pivot = NULL;
+	}
+
 	/* generate an extent for the deduplicated fragment */
 	if (inode->fragment_size && !ctx.fragemitted) {
-		z_erofs_write_indexes(&ctx);
-		ctx.e.length = inode->fragment_size;
-		ctx.e.compressedblks = 0;
-		ctx.e.raw = false;
-		ctx.e.partial = false;
-		ctx.e.blkaddr = ctx.blkaddr;
+		struct z_erofs_extent_item *ei;
+
+		ei = malloc(sizeof(*ei));
+		if (!ei) {
+			ret = -ENOMEM;
+			goto err_free_idata;
+		}
+
+		ei->e = (struct z_erofs_inmem_extent) {
+			.length = inode->fragment_size,
+			.compressedblks = 0,
+			.raw = false,
+			.partial = false,
+			.blkaddr = ctx.blkaddr,
+		};
+		init_list_head(&ei->list);
+		z_erofs_commit_extent(&ctx, ei);
 	}
 	z_erofs_fragments_commit(inode);
 
 	z_erofs_write_indexes(&ctx);
-	z_erofs_write_indexes_final(&ctx);
 	legacymetasize = ctx.metacur - compressmeta;
 	/* estimate if data compression saves space or not */
 	if (!inode->fragment_size &&
-- 
2.39.3

