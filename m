Return-Path: <linux-erofs+bounces-176-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D31D0A82C7B
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Apr 2025 18:33:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZXpR450xRz30Vl;
	Thu, 10 Apr 2025 02:33:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744216400;
	cv=none; b=HupjotyQF9ysjvKm9WiFx+r7cobVsBhl8BYx+k62yXOaiF+yW4RAfopLpCppneiVoI0yxZB7i0qZFaHB+RygNv8JpWl6DBwFk3/6Vvst3047iBNSerhm6ixNhPHkD1OAAgVRSIGipa4/NjMn10JTc7tr0GD8RPLNjbk5ffD7SXSgUxNib1UzP16HRLVeUfoGMbR/5Ca3a4B8bjat2QpVmKhwzDJyVwO7bTSDMS6XbgYSiDw9X+6DAYE5gkdqH4RYqUU7lAbOh6dlUbTNEAdD0q+76Z9d4ypbT1wCBozglKItrKE916SgQKS9jJk/ytO7vcnHYO8lnMKT1YwkZQ21SA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744216400; c=relaxed/relaxed;
	bh=G/fQYb7RWcQqUI+TTKUJDIUhihMdZVnPTkWKqwG+L2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fb3y0xPzIa9akkLSBZA6SLm6AaorkT03xGZGB58KVzkYaBpjDYaREu+cRG5FBOQUaQUT526NJQ2LJF1zYDbBGabziV1FZISYryDbtkmZ0KHfQZytqXKgJKYzEw4sdkeDta/ex8cWZndIJIlLT3x3r+/oIX/lJSubDlsLYDMb2t01s60tTOAcbbsaSIQtcX6b5my+EvxMzxcLnk/hBc2MpRnWuqRr4LQ1c/WMWI5FEdfTKv4L9C0oSE88GmZpVBw0xR9Mnboqih182wwIC0Q3RBKcGtbDRZRyQcpdF8f5gk6bAReSPYT9WYrGL9xorUZZ2cCsNmCkl220/k5W8P0EXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QV1rLJAR; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QV1rLJAR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZXpR15Zy1z30VZ
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Apr 2025 02:33:17 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744216394; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=G/fQYb7RWcQqUI+TTKUJDIUhihMdZVnPTkWKqwG+L2Q=;
	b=QV1rLJARmsqp9ikvQtIcx2d16vrWfwI+aS7GZZy7rdtcsN4z9hyYsrN57kIbvjoRZpxAWCw2NU1/t2jKMIURYLsbnNHDaNgxUykXrGud08ZBwFkPfDPLBlTGtbAiIJdDqe2L6bNqIhhPt7y1oMlNqRpp81fRYEtJeldkpfQRZRw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WWKsZWu_1744216392 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Apr 2025 00:33:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 10/10] erofs-utils: support encoded extents
Date: Thu, 10 Apr 2025 00:32:59 +0800
Message-ID: <20250409163259.2077865-10-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250409163259.2077865-1-hsiangkao@linux.alibaba.com>
References: <20250409163259.2077865-1-hsiangkao@linux.alibaba.com>
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

For Zstd and libdeflate, since they don't natively support fixed-size
output compression, switch to use fixed-size input compression if
`--max-extent-bytes=` is specified and no more than `-C`. Later we will
introduce a simpilified option for users too.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h    |   2 +-
 include/erofs_fs.h          |   3 +-
 lib/compress.c              | 224 +++++++++++++++++++++++++++++-------
 lib/compressor.c            |  11 ++
 lib/compressor.h            |   6 +
 lib/compressor_libdeflate.c |  18 +++
 lib/compressor_libzstd.c    |  18 +++
 7 files changed, 237 insertions(+), 45 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 676f63d..1c199c8 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -267,12 +267,12 @@ struct erofs_inode {
 			union {
 				uint64_t z_tailextent_headlcn;
 				erofs_off_t fragment_size;
-				u64		z_extents;
 			};
 			union {
 				erofs_off_t	fragmentoff;
 				erofs_off_t	z_fragmentoff;
 			};
+			u64	z_extents;
 #define z_idata_size	idata_size
 		};
 	};
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 41a398c..e180c5d 100644
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
index f81539a..54dc2bf 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -50,6 +50,7 @@ struct z_erofs_compress_ictx {		/* inode context */
 	bool fix_dedupedfrag;
 	bool fragemitted;
 	bool dedupe;
+	bool data_unaligned;
 
 	/* fields for write indexes */
 	u8 *metacur;
@@ -79,13 +80,12 @@ struct z_erofs_compress_sctx {		/* segment context */
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
@@ -388,8 +388,7 @@ static int write_uncompressed_block(struct z_erofs_compress_sctx *ctx,
 	if (ctx->membuf) {
 		erofs_dbg("Writing %u uncompressed data of %s", count,
 			  inode->i_srcpath);
-		memcpy(ctx->membuf + ctx->memoff, dst, erofs_blksiz(sbi));
-		ctx->memoff += erofs_blksiz(sbi);
+		memcpy(ctx->membuf + ctx->poff, dst, erofs_blksiz(sbi));
 	} else {
 		erofs_dbg("Writing %u uncompressed data to %llu", count,
 			  ctx->pstart | 0ULL);
@@ -397,6 +396,7 @@ static int write_uncompressed_block(struct z_erofs_compress_sctx *ctx,
 		if (ret)
 			return ret;
 	}
+	ctx->poff += erofs_blksiz(sbi);
 	return count;
 }
 
@@ -554,7 +554,9 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	bool is_packed_inode = erofs_is_packed_inode(inode);
 	bool tsg = (ctx->seg_idx + 1 >= ictx->seg_num), final = !ctx->remaining;
 	bool may_packing = (cfg.c_fragments && tsg && final && !is_packed_inode);
-	bool may_inline = (cfg.c_ztailpacking && tsg && final && !may_packing);
+	bool data_unaligned = ictx->data_unaligned;
+	bool may_inline = (cfg.c_ztailpacking && !data_unaligned && tsg &&
+			   final && !may_packing);
 	unsigned int compressedsize;
 	int ret;
 
@@ -578,21 +580,32 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
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
@@ -651,7 +664,7 @@ frag_packing:
 		e->plen = blksz;
 		e->raw = false;
 	} else {
-		unsigned int tailused, padding;
+		unsigned int padding;
 
 		/*
 		 * If there's space left for the last round when deduping
@@ -659,7 +672,7 @@ frag_packing:
 		 * more to check whether it can be filled up.  Fix the fragment
 		 * if succeeds.  Otherwise, just drop it and go on packing.
 		 */
-		if (may_packing && len == e->length &&
+		if (!data_unaligned && may_packing && len == e->length &&
 		    (compressedsize & (blksz - 1)) &&
 		    ctx->tail < Z_EROFS_COMPR_QUEUE_SZ) {
 			ctx->pclustersize = roundup(compressedsize, blksz);
@@ -675,13 +688,12 @@ frag_packing:
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
@@ -694,9 +706,7 @@ frag_packing:
 			erofs_dbg("Writing %u compressed data of %u bytes of %s",
 				  e->length, e->plen, inode->i_srcpath);
 
-			memcpy(ctx->membuf + ctx->memoff,
-			       dst - padding, e->plen);
-			ctx->memoff += e->plen;
+			memcpy(ctx->membuf + ctx->poff, dst - padding, e->plen);
 		} else {
 			erofs_dbg("Writing %u compressed data to %llu of %u bytes",
 				  e->length, ctx->pstart, e->plen);
@@ -706,6 +716,7 @@ frag_packing:
 			if (ret)
 				return ret;
 		}
+		ctx->poff += e->plen;
 		e->raw = false;
 		may_inline = false;
 		may_packing = false;
@@ -979,24 +990,140 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
 				    void *compressmeta)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
-	struct z_erofs_map_header h = {
-		.h_advise = cpu_to_le16(inode->z_advise),
-		.h_algorithmtype = inode->z_algorithmtype[1] << 4 |
-				   inode->z_algorithmtype[0],
-		/* lclustersize */
-		.h_clusterbits = inode->z_lclusterbits - sbi->blkszbits,
-	};
+	struct z_erofs_map_header h;
 
-	if (inode->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
-		h.h_fragmentoff = cpu_to_le32(inode->fragmentoff);
-	else
-		h.h_idata_size = cpu_to_le16(inode->idata_size);
+	if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL &&
+	    (inode->z_advise & Z_EROFS_ADVISE_EXTENTS)) {
+		int recsz = z_erofs_extent_recsize(inode->z_advise);
 
-	memset(compressmeta, 0, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
+		if (recsz > offsetof(struct z_erofs_extent, pstart_hi)) {
+			h = (struct z_erofs_map_header) {
+				.h_advise = cpu_to_le16(inode->z_advise),
+				.h_extents_lo = cpu_to_le32(inode->z_extents),
+			};
+		} else {
+			DBG_BUGON(inode->z_lclusterbits < sbi->blkszbits);
+			h = (struct z_erofs_map_header) {
+				.h_advise = cpu_to_le16(inode->z_advise),
+				.h_clusterbits = inode->z_lclusterbits - sbi->blkszbits,
+			};
+		}
+	} else {
+		h = (struct z_erofs_map_header) {
+			.h_advise = cpu_to_le16(inode->z_advise),
+			.h_algorithmtype = inode->z_algorithmtype[1] << 4 |
+					   inode->z_algorithmtype[0],
+			/* lclustersize */
+			.h_clusterbits = inode->z_lclusterbits - sbi->blkszbits,
+		};
+		if (inode->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
+			h.h_fragmentoff = cpu_to_le32(inode->fragmentoff);
+		else
+			h.h_idata_size = cpu_to_le16(inode->idata_size);
+
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
+	inode->z_lclusterbits = lclusterbits;
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
@@ -1004,6 +1131,15 @@ static void *z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
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
 	/*
 	 * If the packed inode is larger than 4GiB, the full fragmentoff
 	 * will be recorded by switching to the noncompact layout anyway.
@@ -1011,7 +1147,7 @@ static void *z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
 	if (inode->fragment_size && inode->fragmentoff >> 32) {
 		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
 	} else if (!cfg.c_legacy_compress && !ctx->dedupe &&
-	    inode->z_lclusterbits <= 14) {
+		   inode->z_lclusterbits <= 14) {
 		if (inode->z_lclusterbits <= 12)
 			inode->z_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
 		inode->datalayout = EROFS_INODE_COMPRESSED_COMPACT;
@@ -1040,6 +1176,7 @@ static void *z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
 		free(ei);
 	}
 	z_erofs_fini_full_indexes(ctx);
+out:
 	z_erofs_write_mapheader(inode, metabuf);
 	return metabuf;
 }
@@ -1112,6 +1249,7 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 	}
 
 	ctx->pstart = pstart;
+	ctx->poff = 0;
 	while (ctx->remaining) {
 		const u64 rx = min_t(u64, ctx->remaining,
 				     Z_EROFS_COMPR_QUEUE_SZ - ctx->tail);
@@ -1349,8 +1487,6 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 		ret = -ENOMEM;
 		goto out;
 	}
-	sctx->memoff = 0;
-
 	ret = z_erofs_compress_segment(sctx, sctx->seg_idx * cfg.c_mkfs_segment_size,
 				       EROFS_NULL_ADDR);
 
@@ -1585,9 +1721,6 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	/* initialize per-file compression setting */
 	inode->z_advise = 0;
 	inode->z_lclusterbits = sbi->blkszbits;
-	if (cfg.c_fragments && !cfg.c_dedupe)
-		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
-
 #ifndef NDEBUG
 	if (cfg.c_random_algorithms) {
 		while (1) {
@@ -1621,6 +1754,11 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
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
index 8d322d5..5f86f15 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -26,6 +26,9 @@ struct erofs_compressor {
 	int (*compress_destsize)(const struct erofs_compress *c,
 				 const void *src, unsigned int *srcsize,
 				 void *dst, unsigned int dstsize);
+	int (*compress)(const struct erofs_compress *c,
+			const void *src, unsigned int srcsize,
+			void *dst, unsigned int dstcapacity);
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
diff --git a/lib/compressor_libdeflate.c b/lib/compressor_libdeflate.c
index aaf4684..f6a7de9 100644
--- a/lib/compressor_libdeflate.c
+++ b/lib/compressor_libdeflate.c
@@ -12,6 +12,23 @@ struct erofs_libdeflate_context {
 	size_t last_uncompressed_size;
 };
 
+static int libdeflate_compress(const struct erofs_compress *c,
+			       const void *src, unsigned int srcsize,
+			       void *dst, unsigned int dstcapacity)
+{
+	struct erofs_libdeflate_context *ctx = c->private_data;
+	size_t csize;
+
+	csize = libdeflate_deflate_compress(ctx->strm, src, srcsize,
+					    dst, dstcapacity);
+	if (!csize)
+		return -ENOSPC;
+	/* See the comment in libdeflate_compress_destsize() */
+	if (!((u8 *)dst)[0])
+		((u8 *)dst)[0] = 1 << (2 + 1);
+	return csize;
+}
+
 static int libdeflate_compress_destsize(const struct erofs_compress *c,
 				        const void *src, unsigned int *srcsize,
 				        void *dst, unsigned int dstsize)
@@ -137,5 +154,6 @@ const struct erofs_compressor erofs_compressor_libdeflate = {
 	.exit = compressor_libdeflate_exit,
 	.reset = compressor_libdeflate_reset,
 	.setlevel = erofs_compressor_libdeflate_setlevel,
+	.compress = libdeflate_compress,
 	.compress_destsize = libdeflate_compress_destsize,
 };
diff --git a/lib/compressor_libzstd.c b/lib/compressor_libzstd.c
index 223806e..e53b1a6 100644
--- a/lib/compressor_libzstd.c
+++ b/lib/compressor_libzstd.c
@@ -8,6 +8,23 @@
 #include "compressor.h"
 #include "erofs/atomic.h"
 
+static int libzstd_compress(const struct erofs_compress *c,
+			    const void *src, unsigned int srcsize,
+			    void *dst, unsigned int dstcapacity)
+{
+	ZSTD_CCtx *cctx = c->private_data;
+	size_t csize;
+
+	csize = ZSTD_compress2(cctx, dst, dstcapacity, src, srcsize);
+	if (ZSTD_isError(csize)) {
+		if (ZSTD_getErrorCode(csize) == ZSTD_error_dstSize_tooSmall)
+			return -ENOSPC;
+		erofs_err("Zstd compress failed: %s", ZSTD_getErrorName(csize));
+		return -EFAULT;
+	}
+	return csize;
+}
+
 static int libzstd_compress_destsize(const struct erofs_compress *c,
 				     const void *src, unsigned int *srcsize,
 				     void *dst, unsigned int dstsize)
@@ -139,5 +156,6 @@ const struct erofs_compressor erofs_compressor_libzstd = {
 	.exit = compressor_libzstd_exit,
 	.setlevel = erofs_compressor_libzstd_setlevel,
 	.setdictsize = erofs_compressor_libzstd_setdictsize,
+	.compress = libzstd_compress,
 	.compress_destsize = libzstd_compress_destsize,
 };
-- 
2.43.5


