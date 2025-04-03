Return-Path: <linux-erofs+bounces-141-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C5282A79DBF
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Apr 2025 10:14:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZSvf44Dcqz2ySP;
	Thu,  3 Apr 2025 19:14:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743668060;
	cv=none; b=ab3ihm6w0tGagph7AqSXqBCKqVSWHRdZbsG8Bc0i6ZidXFloGa3WF6oRurgU0rDLZVqu8EXEhtgauoWgHwEihtF34QT14vR5GTWtv8vgVIHkuxE0ZyGCOz9mmeISQPGseSQgP179IGJcNDKkTT5UPuxWD/xPYdiUloaAj9jqFBwUg/MXny7GNJNtiTAgRfhCo3qrhATHLeu7Dgohm3IjtO/yAWOGoyQB78j2ECZOZ83fTlxBYe1rONPZU73mQ71/BxlxuizTlkc2cr77A7XHgBYxeRW+DfwpvNUT3eEx4TBiL2guc+e+cTQ917qJAZWuYRJeVOaGYNZ938VTBQbn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743668060; c=relaxed/relaxed;
	bh=Mr3CXZ47+cSUjhEsXZ8/5zr6uTrsdXxf0X32wKnZht8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nru6a7ddUJ1bxojJZechpR9Hwrf4VPtTiOpvgQWRBy7eHvdZ2sLCabqOVY+zZpk0+XL9fpPaaOAMlUyeWjefii42f2Ysbmigys6QuCozfLEwTy7P4qTSBZQ1PauQcoo7J80OAL5kb5WhJUJOzs0Er9jCVonzoKjdzW9+ZSRIIJOrnJ/UzGto7Cq+ALjupd13zyhi5HuHkN3bWWpgWMjo7SbjfxLyraNXFPRFKTWCVy2d3nOwjSXBK32FPoX1/YPpome/LAUgzx5J+rXXJCLlf4C4Lh1+v/WGiPu9V/UsYa7MRlR0F5x5dQQZK8nBKlt9ivDSGj+vR9tTW0YjyjhYKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dO1PYKTp; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dO1PYKTp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZSvf041K3z304x
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Apr 2025 19:14:15 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743668050; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Mr3CXZ47+cSUjhEsXZ8/5zr6uTrsdXxf0X32wKnZht8=;
	b=dO1PYKTpRAsO9jgntoMJuArOSJKAlMwNJR55jrEHA6P11B24rCDh2gvFVL3o22fjVkJPeAlYhm0vchRI0v8nHvZshjXsYjHw+b3/bUkSq7xIiqGI/Nyd8LSURkj+XbkDw1zqc5ngEtDk5i4fJ5gfMZmbQ+nspzA7BAZDNkTw9yw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WUcFcLX_1743668044 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 03 Apr 2025 16:14:08 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/3] erofs-utils: lib: use compressed offsets in `struct z_erofs_inmem_extent`
Date: Thu,  3 Apr 2025 16:14:01 +0800
Message-ID: <20250403081403.2671077-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

... to prepare for the new on-disk encoded extents.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/dedupe.h |   4 +-
 lib/compress.c         | 164 +++++++++++++++++++++--------------------
 lib/dedupe.c           |  12 +--
 3 files changed, 91 insertions(+), 89 deletions(-)

diff --git a/include/erofs/dedupe.h b/include/erofs/dedupe.h
index 4cbfb2c..1af08e3 100644
--- a/include/erofs/dedupe.h
+++ b/include/erofs/dedupe.h
@@ -13,8 +13,8 @@ extern "C"
 #include "internal.h"
 
 struct z_erofs_inmem_extent {
-	erofs_blk_t blkaddr;
-	unsigned int compressedblks;
+	erofs_off_t pstart;
+	unsigned int plen;
 	unsigned int length;
 	bool raw, partial, inlined;
 };
diff --git a/lib/compress.c b/lib/compress.c
index 32f58b5..eaca4d3 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -78,7 +78,7 @@ struct z_erofs_compress_sctx {		/* segment context */
 	unsigned int head, tail;
 
 	unsigned int pclustersize;
-	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
+	erofs_off_t pstart;
 	u16 clusterofs;
 
 	int seg_idx;
@@ -144,11 +144,14 @@ static void z_erofs_write_extent(struct z_erofs_compress_ictx *ctx,
 	struct erofs_sb_info *sbi = inode->sbi;
 	unsigned int clusterofs = ctx->clusterofs;
 	unsigned int count = e->length;
-	unsigned int d0 = 0, d1 = (clusterofs + count) / erofs_blksiz(sbi);
+	unsigned int bbits = sbi->blkszbits;
+	unsigned int d0 = 0, d1 = (clusterofs + count) >> bbits;
 	struct z_erofs_lcluster_index di;
 	unsigned int type, advise;
 
 	DBG_BUGON(!count);
+	DBG_BUGON(e->pstart & (BIT(bbits) - 1));
+
 	di.di_clusterofs = cpu_to_le16(ctx->clusterofs);
 
 	/* whether the tail-end (un)compressed block or not */
@@ -163,11 +166,10 @@ static void z_erofs_write_extent(struct z_erofs_compress_ictx *ctx,
 			Z_EROFS_LCLUSTER_TYPE_HEAD1;
 		di.di_advise = cpu_to_le16(type);
 
-		if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL &&
-		    !e->compressedblks)
+		if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL && !e->plen)
 			di.di_u.blkaddr = cpu_to_le32(inode->fragmentoff >> 32);
 		else
-			di.di_u.blkaddr = cpu_to_le32(e->blkaddr);
+			di.di_u.blkaddr = cpu_to_le32(e->pstart >> bbits);
 		memcpy(ctx->metacur, &di, sizeof(di));
 		ctx->metacur += sizeof(di);
 
@@ -181,7 +183,7 @@ static void z_erofs_write_extent(struct z_erofs_compress_ictx *ctx,
 		/* XXX: big pcluster feature should be per-inode */
 		if (d0 == 1 && erofs_sb_has_big_pcluster(sbi)) {
 			type = Z_EROFS_LCLUSTER_TYPE_NONHEAD;
-			di.di_u.delta[0] = cpu_to_le16(e->compressedblks |
+			di.di_u.delta[0] = cpu_to_le16((e->plen >> bbits) |
 						       Z_EROFS_LI_D0_CBLKCNT);
 			di.di_u.delta[1] = cpu_to_le16(d1);
 		} else if (d0) {
@@ -209,10 +211,10 @@ static void z_erofs_write_extent(struct z_erofs_compress_ictx *ctx,
 				Z_EROFS_LCLUSTER_TYPE_HEAD1;
 
 			if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL &&
-			    !e->compressedblks)
+			    !e->plen)
 				di.di_u.blkaddr = cpu_to_le32(inode->fragmentoff >> 32);
 			else
-				di.di_u.blkaddr = cpu_to_le32(e->blkaddr);
+				di.di_u.blkaddr = cpu_to_le32(e->pstart >> bbits);
 
 			if (e->partial) {
 				DBG_BUGON(e->raw);
@@ -224,12 +226,12 @@ static void z_erofs_write_extent(struct z_erofs_compress_ictx *ctx,
 		memcpy(ctx->metacur, &di, sizeof(di));
 		ctx->metacur += sizeof(di);
 
-		count -= erofs_blksiz(sbi) - clusterofs;
+		count -= (1 << bbits) - clusterofs;
 		clusterofs = 0;
 
 		++d0;
 		--d1;
-	} while (clusterofs + count >= erofs_blksiz(sbi));
+	} while (clusterofs + count >= 1 << bbits);
 
 	ctx->clusterofs = clusterofs + count;
 }
@@ -322,7 +324,7 @@ static int z_erofs_compress_dedupe(struct z_erofs_compress_sctx *ctx)
 		 * CBLKCNT as the first step.  Even laterly, an one-block
 		 * decompresssion could be done as another try in practice.
 		 */
-		if (dctx.e.compressedblks > 1 &&
+		if (dctx.e.plen > erofs_blksiz(sbi) &&
 		    ((ctx->clusterofs + ei->e.length - delta) & lclustermask) +
 			dctx.e.length < 2 * (lclustermask + 1))
 			break;
@@ -342,7 +344,7 @@ static int z_erofs_compress_dedupe(struct z_erofs_compress_sctx *ctx)
 			 * previous big pcluster, make sure that the previous
 			 * CBLKCNT is still kept.
 			 */
-			if (ei->e.compressedblks > 1 &&
+			if (ei->e.plen > erofs_blksiz(sbi) &&
 			    (ctx->clusterofs & lclustermask) + ei->e.length
 				- delta < 2 * (lclustermask + 1))
 				break;
@@ -355,11 +357,10 @@ static int z_erofs_compress_dedupe(struct z_erofs_compress_sctx *ctx)
 		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
 		erofs_sb_set_dedupe(sbi);
 
-		sbi->saved_by_deduplication +=
-			dctx.e.compressedblks * erofs_blksiz(sbi);
-		erofs_dbg("Dedupe %u %scompressed data (delta %d) to %u of %u blocks",
+		sbi->saved_by_deduplication += dctx.e.plen;
+		erofs_dbg("Dedupe %u %scompressed data (delta %d) to %llu of %u bytes",
 			  dctx.e.length, dctx.e.raw ? "un" : "",
-			  delta, dctx.e.blkaddr, dctx.e.compressedblks);
+			  delta, dctx.e.pstart | 0ULL, dctx.e.plen);
 
 		z_erofs_commit_extent(ctx, ei);
 		ei = ctx->pivot;
@@ -406,9 +407,9 @@ static int write_uncompressed_block(struct z_erofs_compress_sctx *ctx,
 		memcpy(ctx->membuf + ctx->memoff, dst, erofs_blksiz(sbi));
 		ctx->memoff += erofs_blksiz(sbi);
 	} else {
-		erofs_dbg("Writing %u uncompressed data to block %u", count,
-			  ctx->blkaddr);
-		ret = erofs_blk_write(sbi, dst, ctx->blkaddr, 1);
+		erofs_dbg("Writing %u uncompressed data to %llu", count,
+			  ctx->pstart | 0ULL);
+		ret = erofs_dev_write(sbi, dst, ctx->pstart, erofs_blksiz(sbi));
 		if (ret)
 			return ret;
 	}
@@ -441,12 +442,12 @@ static int write_uncompressed_extents(struct z_erofs_compress_sctx *ctx,
 
 		ei->e = (struct z_erofs_inmem_extent) {
 			.length = count,
-			.compressedblks = BLK_ROUND_UP(inode->sbi, count),
+			.plen = round_up(count, erofs_blksiz(inode->sbi)),
 			.raw = true,
-			.blkaddr = ctx->blkaddr,
+			.pstart = ctx->pstart,
 		};
-		if (ctx->blkaddr != EROFS_NULL_ADDR)
-			ctx->blkaddr += ei->e.compressedblks;
+		if (ctx->pstart != EROFS_NULL_ADDR)
+			ctx->pstart += ei->e.plen;
 		z_erofs_commit_extent(ctx, ei);
 		ctx->head += count;
 	}
@@ -634,7 +635,7 @@ nocompression:
 		 * since there is no way to generate compressed indexes after
 		 * the time that ztailpacking is decided.
 		 */
-		e->compressedblks = 1;
+		e->plen = blksz;
 		e->raw = true;
 	} else if (may_packing && len == e->length &&
 		   compressedsize < ctx->pclustersize &&
@@ -644,7 +645,7 @@ frag_packing:
 					     len, ictx->tof_chksum);
 		if (ret < 0)
 			return ret;
-		e->compressedblks = 0; /* indicate a fragment */
+		e->plen = 0;	/* indicate a fragment */
 		e->raw = false;
 		ictx->fragemitted = true;
 	/* tailpcluster should be less than 1 block */
@@ -663,7 +664,7 @@ frag_packing:
 		if (ret < 0)
 			return ret;
 		e->inlined = true;
-		e->compressedblks = 1;
+		e->plen = blksz;
 		e->raw = false;
 	} else {
 		unsigned int tailused, padding;
@@ -690,8 +691,8 @@ frag_packing:
 				return ret;
 		}
 
-		e->compressedblks = BLK_ROUND_UP(sbi, compressedsize);
-		DBG_BUGON(e->compressedblks * blksz >= e->length);
+		e->plen = round_up(compressedsize, blksz);
+		DBG_BUGON(e->plen >= e->length);
 
 		padding = 0;
 		tailused = compressedsize & (blksz - 1);
@@ -706,18 +707,18 @@ frag_packing:
 
 		/* write compressed data */
 		if (ctx->membuf) {
-			erofs_dbg("Writing %u compressed data of %u blocks of %s",
-				  e->length, e->compressedblks, inode->i_srcpath);
+			erofs_dbg("Writing %u compressed data of %u bytes of %s",
+				  e->length, e->plen, inode->i_srcpath);
 
-			memcpy(ctx->membuf + ctx->memoff, dst - padding,
-			       e->compressedblks * blksz);
-			ctx->memoff += e->compressedblks * blksz;
+			memcpy(ctx->membuf + ctx->memoff,
+			       dst - padding, e->plen);
+			ctx->memoff += e->plen;
 		} else {
-			erofs_dbg("Writing %u compressed data to %u of %u blocks",
-				  e->length, ctx->blkaddr, e->compressedblks);
+			erofs_dbg("Writing %u compressed data to %llu of %u bytes",
+				  e->length, ctx->pstart, e->plen);
 
-			ret = erofs_blk_write(sbi, dst - padding, ctx->blkaddr,
-					      e->compressedblks);
+			ret = erofs_dev_write(sbi, dst - padding, ctx->pstart,
+					      e->plen);
 			if (ret)
 				return ret;
 		}
@@ -726,9 +727,9 @@ frag_packing:
 		may_packing = false;
 	}
 	e->partial = false;
-	e->blkaddr = ctx->blkaddr;
-	if (ctx->blkaddr != EROFS_NULL_ADDR)
-		ctx->blkaddr += e->compressedblks;
+	e->pstart = ctx->pstart;
+	if (ctx->pstart != EROFS_NULL_ADDR)
+		ctx->pstart += e->plen;
 	if (!may_inline && !may_packing && !is_packed_inode)
 		(void)z_erofs_dedupe_insert(e, ctx->queue + ctx->head);
 	ctx->head += e->length;
@@ -879,7 +880,7 @@ static void *write_compacted_indexes(u8 *out,
 }
 
 int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
-					erofs_blk_t blkaddr,
+					erofs_off_t pstart,
 					unsigned int legacymetasize,
 					void *compressmeta)
 {
@@ -898,15 +899,19 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	unsigned int compacted_2b;
 	bool dummy_head;
 	bool big_pcluster = erofs_sb_has_big_pcluster(sbi);
+	erofs_blk_t blkaddr;
 
 	if (logical_clusterbits < sbi->blkszbits)
 		return -EINVAL;
+	if (pstart & (erofs_blksiz(sbi) - 1))
+		return -EINVAL;
 	if (logical_clusterbits > 14) {
 		erofs_err("compact format is unsupported for lcluster size %u",
 			  1 << logical_clusterbits);
 		return -EOPNOTSUPP;
 	}
 
+	blkaddr = pstart >> sbi->blkszbits;
 	if (inode->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) {
 		if (logical_clusterbits > 12) {
 			erofs_err("compact 2B is unsupported for lcluster size %u",
@@ -1054,7 +1059,7 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 }
 
 int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
-			     u64 offset, erofs_blk_t blkaddr)
+			     u64 offset, erofs_off_t pstart)
 {
 	struct z_erofs_compress_ictx *ictx = ctx->ictx;
 	struct erofs_inode *inode = ictx->inode;
@@ -1074,7 +1079,7 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 		ctx->remaining -= inode->fragment_size;
 	}
 
-	ctx->blkaddr = blkaddr;
+	ctx->pstart = pstart;
 	while (ctx->remaining) {
 		const u64 rx = min_t(u64, ctx->remaining,
 				     Z_EROFS_COMPR_QUEUE_SZ - ctx->tail);
@@ -1113,10 +1118,10 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 
 		ei->e = (struct z_erofs_inmem_extent) {
 			.length = inode->fragment_size,
-			.compressedblks = 0,
+			.plen = 0,
 			.raw = false,
 			.partial = false,
-			.blkaddr = ctx->blkaddr,
+			.pstart = ctx->pstart,
 		};
 		init_list_head(&ei->list);
 		z_erofs_commit_extent(ctx, ei);
@@ -1126,20 +1131,19 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 
 int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 				 struct erofs_buffer_head *bh,
-				 erofs_blk_t blkaddr,
-				 erofs_blk_t compressed_blocks)
+				 erofs_off_t pstart, erofs_off_t ptotal)
 {
 	struct erofs_inode *inode = ictx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
-	unsigned int legacymetasize;
+	unsigned int legacymetasize, bbits = sbi->blkszbits;
 	u8 *compressmeta;
 	int ret;
 
 	z_erofs_fragments_commit(inode);
 
 	/* fall back to no compression mode */
-	DBG_BUGON(compressed_blocks < !!inode->idata_size);
-	compressed_blocks -= !!inode->idata_size;
+	DBG_BUGON(pstart < (!!inode->idata_size) << bbits);
+	ptotal -= (!!inode->idata_size) << bbits;
 
 	compressmeta = malloc(BLK_ROUND_UP(sbi, inode->i_size) *
 			      sizeof(struct z_erofs_lcluster_index) +
@@ -1153,8 +1157,7 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 
 	legacymetasize = ictx->metacur - compressmeta;
 	/* estimate if data compression saves space or not */
-	if (!inode->fragment_size &&
-	    compressed_blocks * erofs_blksiz(sbi) + inode->idata_size +
+	if (!inode->fragment_size && ptotal + inode->idata_size +
 	    legacymetasize >= inode->i_size) {
 		z_erofs_dedupe_commit(true);
 		ret = -ENOSPC;
@@ -1176,17 +1179,15 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 		legacymetasize = Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	}
 
-	if (compressed_blocks) {
-		ret = erofs_bh_balloon(bh, erofs_pos(sbi, compressed_blocks));
-		DBG_BUGON(ret != erofs_blksiz(sbi));
+	if (ptotal) {
+		ret = erofs_bh_balloon(bh, ptotal);
 	} else {
 		if (!cfg.c_fragments && !cfg.c_dedupe)
 			DBG_BUGON(!inode->idata_size);
 	}
 
-	erofs_info("compressed %s (%llu bytes) into %u blocks",
-		   inode->i_srcpath, (unsigned long long)inode->i_size,
-		   compressed_blocks);
+	erofs_info("compressed %s (%llu bytes) into %u bytes",
+		   inode->i_srcpath, inode->i_size | 0ULL, ptotal);
 
 	if (inode->idata_size) {
 		bh->op = &erofs_skip_write_bhops;
@@ -1195,19 +1196,20 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 		erofs_bdrop(bh, false);
 	}
 
-	inode->u.i_blocks = compressed_blocks;
+	inode->u.i_blocks = BLK_ROUND_UP(sbi, ptotal);
 
 	if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL) {
 		inode->extent_isize = legacymetasize;
 	} else {
-		ret = z_erofs_convert_to_compacted_format(inode, blkaddr,
+		ret = z_erofs_convert_to_compacted_format(inode, pstart,
 							  legacymetasize,
 							  compressmeta);
 		DBG_BUGON(ret);
 	}
 	inode->compressmeta = compressmeta;
 	if (!erofs_is_packed_inode(inode))
-		erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
+		erofs_droid_blocklist_write(inode, pstart >> bbits,
+					    inode->u.i_blocks);
 	return 0;
 
 err_free_meta:
@@ -1337,25 +1339,25 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
 {
 	struct z_erofs_extent_item *ei, *n;
 	struct erofs_sb_info *sbi = ictx->inode->sbi;
-	erofs_blk_t blkoff = 0;
+	erofs_off_t off = 0;
 	int ret = 0, ret2;
 
 	list_for_each_entry_safe(ei, n, &sctx->extents, list) {
 		list_del(&ei->list);
 		list_add_tail(&ei->list, &ictx->extents);
 
-		if (ei->e.blkaddr != EROFS_NULL_ADDR)	/* deduped extents */
+		if (ei->e.pstart != EROFS_NULL_ADDR)	/* deduped extents */
 			continue;
 
-		ei->e.blkaddr = sctx->blkaddr;
-		sctx->blkaddr += ei->e.compressedblks;
+		ei->e.pstart = sctx->pstart;
+		sctx->pstart += ei->e.plen;
 
 		/* skip write data but leave blkaddr for inline fallback */
-		if (ei->e.inlined || !ei->e.compressedblks)
+		if (ei->e.inlined || !ei->e.plen)
 			continue;
-		ret2 = erofs_blk_write(sbi, sctx->membuf + blkoff * erofs_blksiz(sbi),
-				       ei->e.blkaddr, ei->e.compressedblks);
-		blkoff += ei->e.compressedblks;
+		ret2 = erofs_dev_write(sbi, sctx->membuf + off, ei->e.pstart,
+				       ei->e.plen);
+		off += ei->e.plen;
 		if (ret2) {
 			ret = ret2;
 			continue;
@@ -1434,7 +1436,7 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 	struct erofs_sb_info *sbi = ictx->inode->sbi;
 	struct erofs_buffer_head *bh = NULL;
 	struct erofs_compress_work *head = ictx->mtworks, *cur;
-	erofs_blk_t blkaddr, compressed_blocks = 0;
+	erofs_off_t pstart, ptotal = 0;
 	int ret;
 
 	bh = erofs_balloc(sbi->bmgr, DATA, 0, 0, 0);
@@ -1444,7 +1446,7 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 	}
 
 	DBG_BUGON(!head);
-	blkaddr = erofs_mapbh(NULL, bh->block);
+	pstart = erofs_pos(sbi, erofs_mapbh(NULL, bh->block));
 
 	ret = 0;
 	do {
@@ -1459,13 +1461,13 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 		if (!ret) {
 			int ret2;
 
-			cur->ctx.blkaddr = blkaddr;
+			cur->ctx.pstart = pstart;
 			ret2 = z_erofs_merge_segment(ictx, &cur->ctx);
 			if (ret2)
 				ret = ret2;
 
-			compressed_blocks += cur->ctx.blkaddr - blkaddr;
-			blkaddr = cur->ctx.blkaddr;
+			ptotal += cur->ctx.pstart - pstart;
+			pstart = cur->ctx.pstart;
 		}
 
 		pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
@@ -1476,8 +1478,7 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 
 	if (ret)
 		goto out;
-	ret = erofs_commit_compressed_file(ictx, bh,
-			blkaddr - compressed_blocks, compressed_blocks);
+	ret = erofs_commit_compressed_file(ictx, bh, pstart - ptotal, ptotal);
 
 out:
 	close(ictx->fd);
@@ -1641,7 +1642,8 @@ int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 	static struct z_erofs_compress_sctx sctx;
 	struct erofs_compress_cfg *ccfg = ictx->ccfg;
 	struct erofs_inode *inode = ictx->inode;
-	erofs_blk_t blkaddr;
+	struct erofs_sb_info *sbi = inode->sbi;
+	erofs_off_t pstart;
 	int ret;
 
 #ifdef EROFS_MT_ENABLED
@@ -1655,7 +1657,7 @@ int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 		ret = PTR_ERR(bh);
 		goto err_free_idata;
 	}
-	blkaddr = erofs_mapbh(NULL, bh->block); /* start_blkaddr */
+	pstart = erofs_mapbh(NULL, bh->block) << sbi->blkszbits;
 
 	ictx->seg_num = 1;
 	sctx = (struct z_erofs_compress_sctx) {
@@ -1669,13 +1671,13 @@ int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 	};
 	init_list_head(&sctx.extents);
 
-	ret = z_erofs_compress_segment(&sctx, -1, blkaddr);
+	ret = z_erofs_compress_segment(&sctx, -1, pstart);
 	if (ret)
 		goto err_free_idata;
 
 	list_splice_tail(&sctx.extents, &ictx->extents);
-	ret = erofs_commit_compressed_file(ictx, bh, blkaddr,
-					   sctx.blkaddr - blkaddr);
+	ret = erofs_commit_compressed_file(ictx, bh, pstart,
+					   sctx.pstart - pstart);
 	goto out;
 
 err_free_idata:
diff --git a/lib/dedupe.c b/lib/dedupe.c
index 85ff3c9..074cae3 100644
--- a/lib/dedupe.c
+++ b/lib/dedupe.c
@@ -72,8 +72,8 @@ struct z_erofs_dedupe_item {
 	u8		prefix_sha256[32];
 	u64		prefix_xxh64;
 
-	erofs_blk_t	compressed_blkaddr;
-	unsigned int	compressed_blks;
+	erofs_off_t	pstart;
+	unsigned int	plen;
 
 	int		original_length;
 	bool		partial, raw;
@@ -142,8 +142,8 @@ int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
 			(window_size + extra < e->original_length);
 		ctx->e.raw = e->raw;
 		ctx->e.inlined = false;
-		ctx->e.blkaddr = e->compressed_blkaddr;
-		ctx->e.compressedblks = e->compressed_blks;
+		ctx->e.pstart = e->pstart;
+		ctx->e.plen = e->plen;
 		return 0;
 	}
 	return -ENOENT;
@@ -170,8 +170,8 @@ int z_erofs_dedupe_insert(struct z_erofs_inmem_extent *e,
 			window_size, true);
 	memcpy(di->extra_data, original_data + window_size,
 	       e->length - window_size);
-	di->compressed_blkaddr = e->blkaddr;
-	di->compressed_blks = e->compressedblks;
+	di->pstart = e->pstart;
+	di->plen = e->plen;
 	di->partial = e->partial;
 	di->raw = e->raw;
 
-- 
2.43.5


