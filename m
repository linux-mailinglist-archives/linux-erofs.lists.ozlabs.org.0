Return-Path: <linux-erofs+bounces-71-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77119A63378
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Mar 2025 04:37:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZFkLL4JhWz2ydm;
	Sun, 16 Mar 2025 14:36:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742096218;
	cv=none; b=RIhCdIXijDgDEjOMLeDLbB3/ebz0eNgd6BUR1LrBi+s6ooRviPURd5ltysoj2AuJFNwLgtZ8e9cGwsEtyZpWjfhMZap8lcLsynbfNCHLeCwti6v1bL+dld570L6YjR4h0jUPhVlNhX+hOIl0Qe6EO2lo1WwftxsrOew+DfMgqsji83DW43raMPXukaHICTZfSfWm9PZ9HBLPRZ/ASQpbLlpzglFHeG+KmkivB2RM3q2nGjoeHzRqqNmyTofJugY1kCbHJR/SuAeaKjAtGnDArWo2QiRJ6W8j1iGmD0ofBenn+W2u7ZMBzaJz8S1AG8U8hKGCn5VljMN/KZO9B5xIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742096218; c=relaxed/relaxed;
	bh=w36PkVd4v5EtfVmJLjNN5edoGhIPQFY1GQduyFWdl8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htQAn82r2DC46A2daRhLzKL6tPgQQ666wjUoEXAKsbD179gntBLcrFDQ/bABuplEJhlZmh4EXZ1/G9Jj2ABkLlPeVDfdxImDW70bZYLi4IBeZNLL3RJ5l96vmtUJIiUX8o2Fb1G6SNctTe9i31/pS6sIjivW265/XKKPffAwIZX60X4VJMshErEQF99NcYv8p8T6EH+ReZKDEHIOAhc6KLnPWcn489GG3PQ/Ad3a4LG/Y0dKaTuAlpT2PXu+bRZk1BQF0VhzA3/4BcmfUa4h+us3cZjZ5OZUnVO7sruKJjvjm1HwHmEtp1xTSKyt0gJ3Jd3YQzsbQwSpCTv4LIMoLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Iqk9OwLB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Iqk9OwLB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZFkLH1p2jz2ySZ
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Mar 2025 14:36:54 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742096211; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=w36PkVd4v5EtfVmJLjNN5edoGhIPQFY1GQduyFWdl8s=;
	b=Iqk9OwLBT5uLss2hToLuPDz/VDUgKi/f64XHoWO8qt0a1bSc/7TzsH0sho4jY27lDfjJRTXG536T+nb1QLX6iISx9yhqwpVqIFadVq+FmGTl8OcaLtMm8XsASX65g06l7OWISRnEtWd6V5IY/Xsl6ja9pQiJEGzZgF6w4tcdrYE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRSkS6Z_1742096210 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Mar 2025 11:36:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 8/8] erofs-utils: support encoded extents
Date: Sun, 16 Mar 2025 11:36:39 +0800
Message-ID: <20250316033639.1050759-8-hsiangkao@linux.alibaba.com>
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

Use encoded extents if 48bit is set and metadata is smaller for big
pclusters.

For Zstd, since it doesn't natively support fixed-sized output
compression, switch to use fixed-sized input compression if
`--max-extent-bytes=` is specified and no more than `-C`. Later we
might introduce a simpilified option for users too.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
no change.

 include/erofs/internal.h |   1 +
 include/erofs_fs.h       |   3 +-
 lib/compress.c           | 257 ++++++++++++++++++++++++++++++---------
 lib/compressor.c         |  11 ++
 lib/compressor.h         |   6 +
 lib/compressor_libzstd.c |  17 +++
 6 files changed, 235 insertions(+), 60 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 227e830..7a21044 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -269,6 +269,7 @@ struct erofs_inode {
 				unsigned int z_idataoff;
 				erofs_off_t fragmentoff;
 			};
+			unsigned int z_extents;
 #define z_idata_size	idata_size
 		};
 	};
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index ce319d7..77af967 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -413,8 +413,9 @@ struct z_erofs_lcluster_index {
 	} di_u;
 };
 
+#define Z_EROFS_MAP_HEADER_START(end)	round_up(end, 8)
 #define Z_EROFS_MAP_HEADER_END(end)	\
-	(round_up(end, 8) + sizeof(struct z_erofs_map_header))
+	(Z_EROFS_MAP_HEADER_START(end) + sizeof(struct z_erofs_map_header))
 #define Z_EROFS_FULL_INDEX_START(end)	(Z_EROFS_MAP_HEADER_END(end) + 8)
 
 #define Z_EROFS_EXTENT_PLEN_PARTIAL	BIT(27)
diff --git a/lib/compress.c b/lib/compress.c
index 98288d4..0a8f893 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -49,6 +49,8 @@ struct z_erofs_compress_ictx {		/* inode context */
 	u32 tof_chksum;
 	bool fix_dedupedfrag;
 	bool fragemitted;
+	bool dedupe;
+	bool data_unaligned;
 
 	/* fields for write indexes */
 	u8 *metacur;
@@ -78,13 +80,12 @@ struct z_erofs_compress_sctx {		/* segment context */
 	unsigned int head, tail;
 
 	unsigned int pclustersize;
-	erofs_off_t pstart;
+	erofs_off_t pstart, poff;
 	u16 clusterofs;
 
 	int seg_idx;
 
 	void *membuf;
-	erofs_off_t memoff;
 };
 
 #ifdef EROFS_MT_ENABLED
@@ -336,10 +337,7 @@ static int z_erofs_compress_dedupe(struct z_erofs_compress_sctx *ctx)
 			ei->e.partial = true;
 			ei->e.length -= delta;
 		}
-
-		/* fall back to noncompact indexes for deduplication */
-		inode->z_advise &= ~Z_EROFS_ADVISE_COMPACTED_2B;
-		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
+		ctx->ictx->dedupe = true;
 		erofs_sb_set_dedupe(sbi);
 
 		sbi->saved_by_deduplication += dctx.e.plen;
@@ -389,8 +387,7 @@ static int write_uncompressed_block(struct z_erofs_compress_sctx *ctx,
 	if (ctx->membuf) {
 		erofs_dbg("Writing %u uncompressed data of %s", count,
 			  inode->i_srcpath);
-		memcpy(ctx->membuf + ctx->memoff, dst, erofs_blksiz(sbi));
-		ctx->memoff += erofs_blksiz(sbi);
+		memcpy(ctx->membuf + ctx->poff, dst, erofs_blksiz(sbi));
 	} else {
 		erofs_dbg("Writing %u uncompressed data to %llu", count,
 			  ctx->pstart | 0ULL);
@@ -398,6 +395,7 @@ static int write_uncompressed_block(struct z_erofs_compress_sctx *ctx,
 		if (ret)
 			return ret;
 	}
+	ctx->poff += erofs_blksiz(sbi);
 	return count;
 }
 
@@ -555,7 +553,9 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	bool is_packed_inode = erofs_is_packed_inode(inode);
 	bool tsg = (ctx->seg_idx + 1 >= ictx->seg_num), final = !ctx->remaining;
 	bool may_packing = (cfg.c_fragments && tsg && final && !is_packed_inode);
-	bool may_inline = (cfg.c_ztailpacking && tsg && final && !may_packing);
+	bool data_unaligned = ictx->data_unaligned;
+	bool may_inline = (cfg.c_ztailpacking && !data_unaligned && tsg &&
+			   final && !may_packing);
 	unsigned int compressedsize;
 	int ret;
 
@@ -579,21 +579,32 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	}
 
 	e->length = min(len, cfg.c_max_decompressed_extent_bytes);
-	ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
-				      &e->length, dst, ctx->pclustersize);
-	if (ret <= 0) {
+	if (data_unaligned) {
+		ret = erofs_compress(h, ctx->queue + ctx->head, e->length,
+				     dst, ctx->pclustersize);
+		if (ret == -EOPNOTSUPP) {
+			data_unaligned = false;
+			goto retry_aligned;
+		}
+	} else {
+retry_aligned:
+		ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
+					      &e->length, dst, ctx->pclustersize);
+	}
+
+	if (ret > 0) {
+		compressedsize = ret;
+		/* even compressed size is smaller, there is no real gain */
+		if (!data_unaligned && !(may_inline && e->length == len && ret < blksz))
+			ret = roundup(ret, blksz);
+	} else if (ret != -ENOSPC) {
 		erofs_err("failed to compress %s: %s", inode->i_srcpath,
 			  erofs_strerror(ret));
 		return ret;
 	}
 
-	compressedsize = ret;
-	/* even compressed size is smaller, there is no real gain */
-	if (!(may_inline && e->length == len && ret < blksz))
-		ret = roundup(ret, blksz);
-
 	/* check if there is enough gain to keep the compressed data */
-	if (ret * h->compress_threshold / 100 >= e->length) {
+	if (ret < 0 || ret * h->compress_threshold / 100 >= e->length) {
 		if (may_inline && len < blksz) {
 			ret = z_erofs_fill_inline_data(inode,
 					ctx->queue + ctx->head, len, true);
@@ -652,7 +663,7 @@ frag_packing:
 		e->plen = blksz;
 		e->raw = false;
 	} else {
-		unsigned int tailused, padding;
+		unsigned int padding;
 
 		/*
 		 * If there's space left for the last round when deduping
@@ -660,7 +671,7 @@ frag_packing:
 		 * more to check whether it can be filled up.  Fix the fragment
 		 * if succeeds.  Otherwise, just drop it and go on packing.
 		 */
-		if (may_packing && len == e->length &&
+		if (!data_unaligned && may_packing && len == e->length &&
 		    (compressedsize & (blksz - 1)) &&
 		    ctx->tail < Z_EROFS_COMPR_QUEUE_SZ) {
 			ctx->pclustersize = roundup(compressedsize, blksz);
@@ -676,13 +687,12 @@ frag_packing:
 				return ret;
 		}
 
-		e->plen = round_up(compressedsize, blksz);
+		if (data_unaligned)
+			e->plen = compressedsize;
+		else
+			e->plen = round_up(compressedsize, blksz);
 		DBG_BUGON(e->plen >= e->length);
-
-		padding = 0;
-		tailused = compressedsize & (blksz - 1);
-		if (tailused)
-			padding = blksz - tailused;
+		padding = e->plen - compressedsize;
 
 		/* zero out garbage trailing data for non-0padding */
 		if (!erofs_sb_has_lz4_0padding(sbi)) {
@@ -695,9 +705,7 @@ frag_packing:
 			erofs_dbg("Writing %u compressed data of %u bytes of %s",
 				  e->length, e->plen, inode->i_srcpath);
 
-			memcpy(ctx->membuf + ctx->memoff,
-			       dst - padding, e->plen);
-			ctx->memoff += e->plen;
+			memcpy(ctx->membuf + ctx->poff, dst - padding, e->plen);
 		} else {
 			erofs_dbg("Writing %u compressed data to %llu of %u bytes",
 				  e->length, ctx->pstart, e->plen);
@@ -707,6 +715,7 @@ frag_packing:
 			if (ret)
 				return ret;
 		}
+		ctx->poff += e->plen;
 		e->raw = false;
 		may_inline = false;
 		may_packing = false;
@@ -979,30 +988,171 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
 				    void *compressmeta)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
-	struct z_erofs_map_header h = {
-		.h_advise = cpu_to_le16(inode->z_advise),
-		.h_algorithmtype = inode->z_algorithmtype[1] << 4 |
-				   inode->z_algorithmtype[0],
-		/* lclustersize */
-		.h_clusterbits = inode->z_logical_clusterbits - sbi->blkszbits,
-	};
+	struct z_erofs_map_header h;
 
-	if (inode->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
-		h.h_fragmentoff = cpu_to_le32(inode->fragmentoff);
-	else
-		h.h_idata_size = cpu_to_le16(inode->idata_size);
+	if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL &&
+	    (inode->z_advise & Z_EROFS_ADVISE_EXTENTS)) {
+		int recsz = z_erofs_extent_recsize(inode->z_advise);
+
+		if (recsz > offsetof(struct z_erofs_extent, pstart_hi)) {
+			h = (struct z_erofs_map_header) {
+				.h_advise = cpu_to_le16(inode->z_advise),
+				.h_extents_lo = cpu_to_le32(inode->z_extents),
+			};
+		} else {
+			DBG_BUGON(inode->z_logical_clusterbits < sbi->blkszbits);
+			h = (struct z_erofs_map_header) {
+				.h_advise = cpu_to_le16(inode->z_advise),
+				.h_clusterbits = inode->z_logical_clusterbits - sbi->blkszbits,
+			};
+		}
+	} else {
+		h = (struct z_erofs_map_header) {
+			.h_advise = cpu_to_le16(inode->z_advise),
+			.h_algorithmtype = inode->z_algorithmtype[1] << 4 |
+					   inode->z_algorithmtype[0],
+			/* lclustersize */
+			.h_clusterbits = inode->z_logical_clusterbits - sbi->blkszbits,
+		};
+		if (inode->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
+			h.h_fragmentoff = cpu_to_le32(inode->fragmentoff);
+		else
+			h.h_idata_size = cpu_to_le16(inode->idata_size);
 
-	memset(compressmeta, 0, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
+		memset(compressmeta, 0, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
+	}
 	/* write out map header */
 	memcpy(compressmeta, &h, sizeof(struct z_erofs_map_header));
 }
 
+#define EROFS_FULL_INDEXES_SZ(inode)	\
+	(BLK_ROUND_UP(inode->sbi, inode->i_size) * \
+	 sizeof(struct z_erofs_lcluster_index) + Z_EROFS_LEGACY_MAP_HEADER_SIZE)
+
+static void *z_erofs_write_extents(struct z_erofs_compress_ictx *ctx)
+{
+	struct erofs_inode *inode = ctx->inode;
+	struct erofs_sb_info *sbi = inode->sbi;
+	struct z_erofs_extent_item *ei, *n;
+	unsigned int lclusterbits, nexts;
+	bool pstart_hi = false, unaligned_data = false;
+	erofs_off_t pstart, pend, lstart;
+	unsigned int recsz, metasz, moff;
+	void *metabuf;
+
+	ei = list_first_entry(&ctx->extents, struct z_erofs_extent_item,
+			      list);
+	lclusterbits = max_t(u8, ilog2(ei->e.length - 1) + 1, sbi->blkszbits);
+	pend = pstart = ei->e.pstart;
+	nexts = 0;
+	list_for_each_entry(ei, &ctx->extents, list) {
+		pstart_hi |= (ei->e.pstart > UINT32_MAX);
+		if ((ei->e.pstart | ei->e.plen) & ((1U << sbi->blkszbits) - 1))
+			unaligned_data = true;
+		if (pend != ei->e.pstart)
+			pend = EROFS_NULL_ADDR;
+		else
+			pend += ei->e.plen;
+		if (ei->e.length != 1 << lclusterbits) {
+			if (ei->list.next != &ctx->extents ||
+			    ei->e.length > 1 << lclusterbits)
+				lclusterbits = 0;
+		}
+		++nexts;
+	}
+
+	recsz = inode->i_size > UINT32_MAX ? 32 : 16;
+	if (lclusterbits) {
+		if (pend != EROFS_NULL_ADDR)
+			recsz = 4;
+		else if (recsz <= 16 && !pstart_hi)
+			recsz = 8;
+	}
+
+	moff = Z_EROFS_MAP_HEADER_END(inode->inode_isize + inode->xattr_isize);
+	moff = round_up(moff, recsz) -
+		Z_EROFS_MAP_HEADER_START(inode->inode_isize + inode->xattr_isize);
+	metasz = moff + recsz * nexts + 8 * (recsz <= 4);
+	if (!unaligned_data && metasz > EROFS_FULL_INDEXES_SZ(inode))
+		return ERR_PTR(-EAGAIN);
+
+	metabuf = malloc(metasz);
+	if (!metabuf)
+		return ERR_PTR(-ENOMEM);
+	inode->z_logical_clusterbits = lclusterbits;
+	inode->z_extents = nexts;
+	ctx->metacur = metabuf + moff;
+	if (recsz <= 4) {
+		*(__le64 *)ctx->metacur	= cpu_to_le64(pstart);
+		ctx->metacur += sizeof(__le64);
+	}
+
+	nexts = 0;
+	lstart = 0;
+	list_for_each_entry_safe(ei, n, &ctx->extents, list) {
+		struct z_erofs_extent de;
+		u32 fmt, plen;
+
+		plen = ei->e.plen;
+		if (!plen) {
+			plen = inode->fragmentoff;
+			ei->e.pstart = inode->fragmentoff >> 32;
+		} else {
+			fmt = ei->e.raw ? 0 : inode->z_algorithmtype[0] + 1;
+			plen |= fmt << Z_EROFS_EXTENT_PLEN_FMT_BIT;
+			if (ei->e.partial)
+				plen |= Z_EROFS_EXTENT_PLEN_PARTIAL;
+		}
+		de = (struct z_erofs_extent) {
+			.plen = cpu_to_le32(plen),
+			.pstart_lo = cpu_to_le32(ei->e.pstart),
+			.lstart_lo = cpu_to_le32(lstart),
+			.pstart_hi = cpu_to_le32(ei->e.pstart >> 32),
+			.lstart_hi = cpu_to_le32(lstart >> 32),
+		};
+		memcpy(ctx->metacur, &de, recsz);
+		ctx->metacur += recsz;
+		lstart += ei->e.length;
+		list_del(&ei->list);
+		free(ei);
+	}
+	inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
+	inode->z_advise |= Z_EROFS_ADVISE_EXTENTS |
+		((ilog2(recsz) - 2) << Z_EROFS_ADVISE_EXTRECSZ_BIT);
+	return metabuf;
+}
+
 static void *z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
 {
 	struct erofs_inode *inode = ctx->inode;
+	struct erofs_sb_info *sbi = inode->sbi;
 	struct z_erofs_extent_item *ei, *n;
 	void *metabuf;
 
+	if (erofs_sb_has_48bit(sbi)) {
+		metabuf = z_erofs_write_extents(ctx);
+		if (metabuf != ERR_PTR(-EAGAIN)) {
+			if (IS_ERR(metabuf))
+				return metabuf;
+			goto out;
+		}
+	}
+
+	if (!cfg.c_legacy_compress && !ctx->dedupe &&
+	    inode->z_logical_clusterbits <= 14) {
+		if (inode->z_logical_clusterbits <= 12)
+			inode->z_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
+		inode->datalayout = EROFS_INODE_COMPRESSED_COMPACT;
+	} else {
+		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
+	}
+
+	if (erofs_sb_has_big_pcluster(sbi)) {
+		inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
+		if (inode->datalayout == EROFS_INODE_COMPRESSED_COMPACT)
+			inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
+	}
+
 	metabuf = malloc(BLK_ROUND_UP(inode->sbi, inode->i_size) *
 			 sizeof(struct z_erofs_lcluster_index) +
 			 Z_EROFS_LEGACY_MAP_HEADER_SIZE);
@@ -1018,6 +1168,7 @@ static void *z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
 		free(ei);
 	}
 	z_erofs_fini_full_indexes(ctx);
+out:
 	z_erofs_write_mapheader(inode, metabuf);
 	return metabuf;
 }
@@ -1075,6 +1226,7 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 	int fd = ictx->fd;
 
 	ctx->pstart = pstart;
+	ctx->poff = 0;
 	while (ctx->remaining) {
 		const u64 rx = min_t(u64, ctx->remaining,
 				     Z_EROFS_COMPR_QUEUE_SZ - ctx->tail);
@@ -1310,8 +1462,6 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 		ret = -ENOMEM;
 		goto out;
 	}
-	sctx->memoff = 0;
-
 	ret = z_erofs_compress_segment(sctx, sctx->seg_idx * cfg.c_mkfs_segment_size,
 				       EROFS_NULL_ADDR);
 
@@ -1480,22 +1630,6 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	/* initialize per-file compression setting */
 	inode->z_advise = 0;
 	inode->z_logical_clusterbits = sbi->blkszbits;
-	if (!cfg.c_legacy_compress && inode->z_logical_clusterbits <= 14) {
-		if (inode->z_logical_clusterbits <= 12)
-			inode->z_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
-		inode->datalayout = EROFS_INODE_COMPRESSED_COMPACT;
-	} else {
-		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
-	}
-
-	if (erofs_sb_has_big_pcluster(sbi)) {
-		inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
-		if (inode->datalayout == EROFS_INODE_COMPRESSED_COMPACT)
-			inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
-	}
-	if (cfg.c_fragments && !cfg.c_dedupe)
-		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
-
 #ifndef NDEBUG
 	if (cfg.c_random_algorithms) {
 		while (1) {
@@ -1530,6 +1664,11 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	ictx->ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
 	inode->z_algorithmtype[0] = ictx->ccfg->algorithmtype;
 	inode->z_algorithmtype[1] = 0;
+	ictx->data_unaligned = erofs_sb_has_48bit(sbi) &&
+		cfg.c_max_decompressed_extent_bytes <=
+			z_erofs_get_max_pclustersize(inode);
+	if (cfg.c_fragments && !cfg.c_dedupe && !ictx->data_unaligned)
+		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 
 	/*
 	 * Handle tails in advance to avoid writing duplicated
diff --git a/lib/compressor.c b/lib/compressor.c
index 41f49ff..6d8c1c2 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -85,6 +85,17 @@ int erofs_compress_destsize(const struct erofs_compress *c,
 	return c->alg->c->compress_destsize(c, src, srcsize, dst, dstsize);
 }
 
+int erofs_compress(const struct erofs_compress *c,
+		   const void *src, unsigned int srcsize,
+		   void *dst, unsigned int dstcapacity)
+{
+	DBG_BUGON(!c->alg);
+	if (!c->alg->c->compress)
+		return -EOPNOTSUPP;
+
+	return c->alg->c->compress(c, src, srcsize, dst, dstcapacity);
+}
+
 int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
 			  char *alg_name, int compression_level, u32 dict_size)
 {
diff --git a/lib/compressor.h b/lib/compressor.h
index 8d322d5..ea2d03d 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -26,6 +26,9 @@ struct erofs_compressor {
 	int (*compress_destsize)(const struct erofs_compress *c,
 				 const void *src, unsigned int *srcsize,
 				 void *dst, unsigned int dstsize);
+	int (*compress)(const struct erofs_compress *c,
+			const void *src, unsigned int srcsize,
+			void *dst, unsigned dstcapacity);
 };
 
 struct erofs_algorithm {
@@ -60,6 +63,9 @@ int z_erofs_get_compress_algorithm_id(const struct erofs_compress *c);
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize);
+int erofs_compress(const struct erofs_compress *c,
+		   const void *src, unsigned int srcsize,
+		   void *dst, unsigned int dstcapacity);
 
 int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
 			  char *alg_name, int compression_level, u32 dict_size);
diff --git a/lib/compressor_libzstd.c b/lib/compressor_libzstd.c
index 223806e..feacb85 100644
--- a/lib/compressor_libzstd.c
+++ b/lib/compressor_libzstd.c
@@ -8,6 +8,22 @@
 #include "compressor.h"
 #include "erofs/atomic.h"
 
+static int libzstd_compress(const struct erofs_compress *c,
+			    const void *src, unsigned int srcsize,
+			    void *dst, unsigned dstcapacity)
+{
+	ZSTD_CCtx *cctx = c->private_data;
+	size_t csize;
+
+	csize = ZSTD_compress2(cctx, dst, dstcapacity, src, srcsize);
+	if (ZSTD_isError(csize)) {
+		if (ZSTD_getErrorCode(csize) == ZSTD_error_dstSize_tooSmall)
+			return -ENOSPC;
+		return -EFAULT;
+	}
+	return csize;
+}
+
 static int libzstd_compress_destsize(const struct erofs_compress *c,
 				     const void *src, unsigned int *srcsize,
 				     void *dst, unsigned int dstsize)
@@ -139,5 +155,6 @@ const struct erofs_compressor erofs_compressor_libzstd = {
 	.exit = compressor_libzstd_exit,
 	.setlevel = erofs_compressor_libzstd_setlevel,
 	.setdictsize = erofs_compressor_libzstd_setdictsize,
+	.compress = libzstd_compress,
 	.compress_destsize = libzstd_compress_destsize,
 };
-- 
2.43.5


