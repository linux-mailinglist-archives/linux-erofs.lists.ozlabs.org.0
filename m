Return-Path: <linux-erofs+bounces-70-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE25A63377
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Mar 2025 04:37:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZFkLL3GPhz2ydq;
	Sun, 16 Mar 2025 14:36:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742096218;
	cv=none; b=eWyhNv5K4Z2JuN8W01FXF/hJsno4JF3gh6CD1RD5I2/ZAIDeeL+7s3vpoQ4dHiB5ID441E+hSKMNq44M/AChDXBlHD0gy0ICFS10UqxHO6om03CZ++nurejItQS4X9bfQf3vmGwDJLpYUuPhlq3oKnR/EB3AmkAGOOvBlcy45gcJHYJCovPAL0c/frXR1XI64T5p/2maxQSjMAoMxAoXwDlU8wepAJiWkPL/nnGU/nfW32CnuNeyOz5Cpom6jv2uoZXYJFxxMZKegQFRPFoRB6q3pmqvArRG1DK/Al96l88s9c3pm73RR4Nme/28q4PKjE7W8ADa14PiXx4UjPIhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742096218; c=relaxed/relaxed;
	bh=nP3E+a1wMqUECOy0s87IecckJnu2VpGJyuYqEZMELok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3rJvC9zazOBOSZaeWp01gmHIr9kLwUkKx5ElTXlU+27s0mmF3J3654UOm42Yu9NpQJ1Q2rUfOALrd0kQjkY3XRaVdOSoM4bo5+4TNW/Gj76FtTVTMNMf5gYYP2vPrm6QXvbXT4EeZ1wZnL8e3NRYScFE+MxhfzDupx9LJKpK6yp4KpIOkUlcQyz2RzC3JZdnbbFF9lBjbfuKBkEMhCH5Wi8HE3Qk5buY6ZE6pDmWInnq/Sj6Zmy5ZRDSzeumr1hq5/C/SoZXQoDGNqii5b3bY6OEhG4mtlriRExvaZsSrrsYE8+ap7Mtt4EUYjLYj0LC3fe+sFqiB0WKNdZVD1sIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eYDb2qWJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eYDb2qWJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZFkLH2k4Jz2ydm
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Mar 2025 14:36:54 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742096211; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nP3E+a1wMqUECOy0s87IecckJnu2VpGJyuYqEZMELok=;
	b=eYDb2qWJc5yD43yUi+5iwelopDOQfBG21wBI2QvzT1ZcCixvwdi9aqKLsqrPo0tCiuSdfOTAlAdK5JLVm7m1ESPBNk38B5ByW9jd0yGBbFrWNWeeWKOzivD7W9RCra8y8xTganpTkzbbCgzkpfkbRkgHZl5SUBEoZ04CyWd6sv0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRSkS6M_1742096209 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Mar 2025 11:36:49 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 7/8] erofs-utils: lib: use compressed offsets in `struct z_erofs_inmem_extent`
Date: Sun, 16 Mar 2025 11:36:38 +0800
Message-ID: <20250316033639.1050759-7-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250316033639.1050759-1-hsiangkao@linux.alibaba.com>
References: <20250316033639.1050759-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

... to prepare for the new on-disk encoded extents.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
no change.

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
index 97eb776..98288d4 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -78,7 +78,7 @@ struct z_erofs_compress_sctx {		/* segment context */
 	unsigned int head, tail;
 
 	unsigned int pclustersize;
-	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
+	erofs_off_t pstart;
 	u16 clusterofs;
 
 	int seg_idx;
@@ -143,11 +143,14 @@ static void z_erofs_write_full_indexes(struct z_erofs_compress_ictx *ctx,
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
@@ -162,11 +165,10 @@ static void z_erofs_write_full_indexes(struct z_erofs_compress_ictx *ctx,
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
 
@@ -180,7 +182,7 @@ static void z_erofs_write_full_indexes(struct z_erofs_compress_ictx *ctx,
 		/* XXX: big pcluster feature should be per-inode */
 		if (d0 == 1 && erofs_sb_has_big_pcluster(sbi)) {
 			type = Z_EROFS_LCLUSTER_TYPE_NONHEAD;
-			di.di_u.delta[0] = cpu_to_le16(e->compressedblks |
+			di.di_u.delta[0] = cpu_to_le16((e->plen >> bbits) |
 						       Z_EROFS_LI_D0_CBLKCNT);
 			di.di_u.delta[1] = cpu_to_le16(d1);
 		} else if (d0) {
@@ -208,10 +210,10 @@ static void z_erofs_write_full_indexes(struct z_erofs_compress_ictx *ctx,
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
@@ -223,12 +225,12 @@ static void z_erofs_write_full_indexes(struct z_erofs_compress_ictx *ctx,
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
@@ -307,7 +309,7 @@ static int z_erofs_compress_dedupe(struct z_erofs_compress_sctx *ctx)
 		 * CBLKCNT as the first step.  Even laterly, an one-block
 		 * decompresssion could be done as another try in practice.
 		 */
-		if (dctx.e.compressedblks > 1 &&
+		if (dctx.e.plen > erofs_blksiz(sbi) &&
 		    ((ctx->clusterofs + ei->e.length - delta) & lclustermask) +
 			dctx.e.length < 2 * (lclustermask + 1))
 			break;
@@ -327,7 +329,7 @@ static int z_erofs_compress_dedupe(struct z_erofs_compress_sctx *ctx)
 			 * previous big pcluster, make sure that the previous
 			 * CBLKCNT is still kept.
 			 */
-			if (ei->e.compressedblks > 1 &&
+			if (ei->e.plen > erofs_blksiz(sbi) &&
 			    (ctx->clusterofs & lclustermask) + ei->e.length
 				- delta < 2 * (lclustermask + 1))
 				break;
@@ -340,11 +342,10 @@ static int z_erofs_compress_dedupe(struct z_erofs_compress_sctx *ctx)
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
@@ -391,9 +392,9 @@ static int write_uncompressed_block(struct z_erofs_compress_sctx *ctx,
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
@@ -426,12 +427,12 @@ static int write_uncompressed_extents(struct z_erofs_compress_sctx *ctx,
 
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
@@ -619,7 +620,7 @@ nocompression:
 		 * since there is no way to generate compressed indexes after
 		 * the time that ztailpacking is decided.
 		 */
-		e->compressedblks = 1;
+		e->plen = blksz;
 		e->raw = true;
 	} else if (may_packing && len == e->length &&
 		   compressedsize < ctx->pclustersize &&
@@ -629,7 +630,7 @@ frag_packing:
 					     len, ictx->tof_chksum);
 		if (ret < 0)
 			return ret;
-		e->compressedblks = 0; /* indicate a fragment */
+		e->plen = 0;	/* indicate a fragment */
 		e->raw = false;
 		ictx->fragemitted = true;
 	/* tailpcluster should be less than 1 block */
@@ -648,7 +649,7 @@ frag_packing:
 		if (ret < 0)
 			return ret;
 		e->inlined = true;
-		e->compressedblks = 1;
+		e->plen = blksz;
 		e->raw = false;
 	} else {
 		unsigned int tailused, padding;
@@ -675,8 +676,8 @@ frag_packing:
 				return ret;
 		}
 
-		e->compressedblks = BLK_ROUND_UP(sbi, compressedsize);
-		DBG_BUGON(e->compressedblks * blksz >= e->length);
+		e->plen = round_up(compressedsize, blksz);
+		DBG_BUGON(e->plen >= e->length);
 
 		padding = 0;
 		tailused = compressedsize & (blksz - 1);
@@ -691,18 +692,18 @@ frag_packing:
 
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
@@ -711,9 +712,9 @@ frag_packing:
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
@@ -864,7 +865,7 @@ static void *write_compacted_indexes(u8 *out,
 }
 
 int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
-					erofs_blk_t blkaddr,
+					erofs_off_t pstart,
 					unsigned int legacymetasize,
 					void *compressmeta)
 {
@@ -883,15 +884,19 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
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
@@ -1064,12 +1069,12 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 }
 
 int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
-			     u64 offset, erofs_blk_t blkaddr)
+			     u64 offset, erofs_off_t pstart)
 {
 	struct z_erofs_compress_ictx *ictx = ctx->ictx;
 	int fd = ictx->fd;
 
-	ctx->blkaddr = blkaddr;
+	ctx->pstart = pstart;
 	while (ctx->remaining) {
 		const u64 rx = min_t(u64, ctx->remaining,
 				     Z_EROFS_COMPR_QUEUE_SZ - ctx->tail);
@@ -1109,10 +1114,10 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 
 		ei->e = (struct z_erofs_inmem_extent) {
 			.length = ictx->inode->fragment_size,
-			.compressedblks = 0,
+			.plen = 0,
 			.raw = false,
 			.partial = false,
-			.blkaddr = ctx->blkaddr,
+			.pstart = ctx->pstart,
 		};
 		init_list_head(&ei->list);
 		z_erofs_commit_extent(ctx, ei);
@@ -1122,20 +1127,19 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 
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
 
 	compressmeta = z_erofs_write_indexes(ictx);
 	if (!compressmeta) {
@@ -1145,8 +1149,7 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 
 	legacymetasize = ictx->metacur - compressmeta;
 	/* estimate if data compression saves space or not */
-	if (!inode->fragment_size &&
-	    compressed_blocks * erofs_blksiz(sbi) + inode->idata_size +
+	if (!inode->fragment_size && ptotal + inode->idata_size +
 	    legacymetasize >= inode->i_size) {
 		z_erofs_dedupe_commit(true);
 		ret = -ENOSPC;
@@ -1167,17 +1170,15 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
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
@@ -1186,19 +1187,20 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
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
@@ -1326,25 +1328,25 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
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
@@ -1416,7 +1418,7 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 	struct erofs_sb_info *sbi = ictx->inode->sbi;
 	struct erofs_buffer_head *bh = NULL;
 	struct erofs_compress_work *head = ictx->mtworks, *cur;
-	erofs_blk_t blkaddr, compressed_blocks = 0;
+	erofs_off_t pstart, ptotal = 0;
 	int ret;
 
 	bh = erofs_balloc(sbi->bmgr, DATA, 0, 0);
@@ -1426,7 +1428,7 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 	}
 
 	DBG_BUGON(!head);
-	blkaddr = erofs_mapbh(NULL, bh->block);
+	pstart = erofs_pos(sbi, erofs_mapbh(NULL, bh->block));
 
 	ret = 0;
 	do {
@@ -1441,13 +1443,13 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
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
@@ -1458,8 +1460,7 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 
 	if (ret)
 		goto out;
-	ret = erofs_commit_compressed_file(ictx, bh,
-			blkaddr - compressed_blocks, compressed_blocks);
+	ret = erofs_commit_compressed_file(ictx, bh, pstart - ptotal, ptotal);
 
 out:
 	close(ictx->fd);
@@ -1586,7 +1587,8 @@ int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 	static struct z_erofs_compress_sctx sctx;
 	struct erofs_compress_cfg *ccfg = ictx->ccfg;
 	struct erofs_inode *inode = ictx->inode;
-	erofs_blk_t blkaddr;
+	struct erofs_sb_info *sbi = inode->sbi;
+	erofs_off_t pstart;
 	int ret;
 
 #ifdef EROFS_MT_ENABLED
@@ -1600,7 +1602,7 @@ int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 		ret = PTR_ERR(bh);
 		goto err_free_idata;
 	}
-	blkaddr = erofs_mapbh(NULL, bh->block); /* start_blkaddr */
+	pstart = erofs_mapbh(NULL, bh->block) << sbi->blkszbits;
 
 	ictx->seg_num = 1;
 	sctx = (struct z_erofs_compress_sctx) {
@@ -1614,13 +1616,13 @@ int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx)
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
index bc62841..5bfb566 100644
--- a/lib/dedupe.c
+++ b/lib/dedupe.c
@@ -71,8 +71,8 @@ struct z_erofs_dedupe_item {
 	long long	hash;
 	u64		prefix_xxh64;
 
-	erofs_blk_t	compressed_blkaddr;
-	unsigned int	compressed_blks;
+	erofs_off_t	pstart;
+	unsigned int	plen;
 
 	int		original_length;
 	bool		partial, raw;
@@ -139,8 +139,8 @@ int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
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
@@ -165,8 +165,8 @@ int z_erofs_dedupe_insert(struct z_erofs_inmem_extent *e,
 	di->hash = erofs_rolling_hash_init(original_data,
 			window_size, true);
 	memcpy(di->payload, original_data, e->length);
-	di->compressed_blkaddr = e->blkaddr;
-	di->compressed_blks = e->compressedblks;
+	di->pstart = e->pstart;
+	di->plen = e->plen;
 	di->partial = e->partial;
 	di->raw = e->raw;
 
-- 
2.43.5


