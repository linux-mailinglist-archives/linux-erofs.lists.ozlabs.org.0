Return-Path: <linux-erofs+bounces-518-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB84AF89DF
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Jul 2025 09:46:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYQfs2JMfz30Pn;
	Fri,  4 Jul 2025 17:45:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751615157;
	cv=none; b=G57ooseGv6iRPkEV2by6AP442q+Ye+KGBvMSj07g/owNEY0HXeDcKpOgSjJjzl1pXvMg0rcAmjpjR54CLdaz56Z0AIdH9G0824Pr6/YJIe1maMkyWMqkCVYWI90of+rIG3DUi3Yny0y4ULOlSY57fEQeENTyBK9EF45wkcHCxyyEO8c+JvYMqOmnfGp8xmTgrLqK9ARhv6Q+Hn957cr3B1dZk57IU8sBrPj88yu6BBIn1u6yEg7d9S2QvGShlypFrFpBTjjfaEJV1RNJ7HKjyKFHKw+pGSEu35ap1DLy7VNSCFmDf3+CVHAlP0Dw7oeQhPPo4pNVcM3tnOUY5V+Huw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751615157; c=relaxed/relaxed;
	bh=rtFOwHsgKYjqiK1Q7QaEWnbS8t6o1y+THbw72B36sfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEkytLoQmbM05ZCDGpWpFSnAj9X0X+zN182dZu8DinK9aYqOKI1SvjYJ8cvKY/fQ6WTATrQ80MnW9jnB7WmEDSVDI6OA6/KyvScr+qln4yjNcVUHtwehnVMzyNsLLRKtxX+MLJ3MdX4cuFb5xMXjeKlJctpRMep/YSNa76XLPp/4TvmERtVaVsG2o7/KGWK4NumR0FrgJzXKtBOUKkyqDT4dNMxQupE/CQK7L6ANt1r89E+7K7bxSyEBTQqq1GJfn0QJG7d0zVt301/S0k1gXOmi2Wra2bKjD16ZwNLOoUm132jJUkTjrK4W1Q4wxYXPlHJGjy6eZtGCCHbE2GfdJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PYPc++7e; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PYPc++7e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYQfq6NcZz30VF
	for <linux-erofs@lists.ozlabs.org>; Fri,  4 Jul 2025 17:45:55 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751615151; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rtFOwHsgKYjqiK1Q7QaEWnbS8t6o1y+THbw72B36sfU=;
	b=PYPc++7eDTcwLeNIfi0/o7AkjRjffWr0xmfsKGwKAWVnyr0tiFMgEzfqfTjJrTJuTucJM+YgRwX5bV+pvcD3Oj5e1bsuzXBXxaNGY2mgzuaawDQ9BampOj6sDDjdrOSQF8l7Co6l5nkcczGMHSCoOa334K/o2lA5Vs3zHuvHQUA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WhDC7Do_1751615148 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Jul 2025 15:45:49 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 for-merge 9/9] erofs-utils: support encoded extents
Date: Fri,  4 Jul 2025 15:45:35 +0800
Message-ID: <20250704074535.2308212-10-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250704074535.2308212-1-hsiangkao@linux.alibaba.com>
References: <20250704074535.2308212-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
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
index 14a8e30d..d380c45e 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -271,13 +271,13 @@ struct erofs_inode {
 			union {
 				uint64_t z_tailextent_headlcn;
 				erofs_off_t fragment_size;
-				u64		z_extents;
 			};
 			union {
 				erofs_off_t	fragmentoff;
 				erofs_off_t	z_fragmentoff;
 				void *fragment;
 			};
+			u64	z_extents;
 #define z_idata_size	idata_size
 		};
 	};
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 41a398cb..e180c5d4 100644
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
index 5d4d47f9..8999b2c7 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -43,6 +43,7 @@ struct z_erofs_compress_ictx {		/* inode context */
 	bool fix_dedupedfrag;
 	bool fragemitted;
 	bool dedupe;
+	bool data_unaligned;
 
 	/* fields for write indexes */
 	u8 *metacur;
@@ -75,13 +76,12 @@ struct z_erofs_compress_sctx {		/* segment context */
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
@@ -405,8 +405,7 @@ static int write_uncompressed_block(struct z_erofs_compress_sctx *ctx,
 	if (ctx->membuf) {
 		erofs_dbg("Writing %u uncompressed data of %s", count,
 			  inode->i_srcpath);
-		memcpy(ctx->membuf + ctx->memoff, dst, erofs_blksiz(sbi));
-		ctx->memoff += erofs_blksiz(sbi);
+		memcpy(ctx->membuf + ctx->poff, dst, erofs_blksiz(sbi));
 	} else {
 		erofs_dbg("Writing %u uncompressed data to %llu", count,
 			  ctx->pstart | 0ULL);
@@ -414,6 +413,7 @@ static int write_uncompressed_block(struct z_erofs_compress_sctx *ctx,
 		if (ret)
 			return ret;
 	}
+	ctx->poff += erofs_blksiz(sbi);
 	return count;
 }
 
@@ -568,7 +568,9 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	bool is_packed_inode = erofs_is_packed_inode(inode);
 	bool tsg = (ctx->seg_idx + 1 >= ictx->seg_num), final = !ctx->remaining;
 	bool may_packing = (cfg.c_fragments && tsg && final && !is_packed_inode);
-	bool may_inline = (cfg.c_ztailpacking && tsg && final && !may_packing);
+	bool data_unaligned = ictx->data_unaligned;
+	bool may_inline = (cfg.c_ztailpacking && !data_unaligned && tsg &&
+			   final && !may_packing);
 	unsigned int compressedsize;
 	int ret;
 
@@ -592,21 +594,32 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
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
@@ -665,7 +678,7 @@ frag_packing:
 		e->plen = blksz;
 		e->raw = false;
 	} else {
-		unsigned int tailused, padding;
+		unsigned int padding;
 
 		/*
 		 * If there's space left for the last round when deduping
@@ -673,7 +686,7 @@ frag_packing:
 		 * more to check whether it can be filled up.  Fix the fragment
 		 * if succeeds.  Otherwise, just drop it and go on packing.
 		 */
-		if (may_packing && len == e->length &&
+		if (!data_unaligned && may_packing && len == e->length &&
 		    (compressedsize & (blksz - 1)) &&
 		    ctx->tail < Z_EROFS_COMPR_QUEUE_SZ) {
 			ctx->pclustersize = roundup(compressedsize, blksz);
@@ -689,13 +702,12 @@ frag_packing:
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
@@ -708,9 +720,7 @@ frag_packing:
 			erofs_dbg("Writing %u compressed data of %u bytes of %s",
 				  e->length, e->plen, inode->i_srcpath);
 
-			memcpy(ctx->membuf + ctx->memoff,
-			       dst - padding, e->plen);
-			ctx->memoff += e->plen;
+			memcpy(ctx->membuf + ctx->poff, dst - padding, e->plen);
 		} else {
 			erofs_dbg("Writing %u compressed data to %llu of %u bytes",
 				  e->length, ctx->pstart, e->plen);
@@ -720,6 +730,7 @@ frag_packing:
 			if (ret)
 				return ret;
 		}
+		ctx->poff += e->plen;
 		e->raw = false;
 		may_inline = false;
 		may_packing = false;
@@ -993,24 +1004,140 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
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
@@ -1018,6 +1145,15 @@ static void *z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
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
@@ -1025,7 +1161,7 @@ static void *z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
 	if (inode->fragment_size && inode->fragmentoff >> 32) {
 		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
 	} else if (!cfg.c_legacy_compress && !ctx->dedupe &&
-	    inode->z_lclusterbits <= 14) {
+		   inode->z_lclusterbits <= 14) {
 		if (inode->z_lclusterbits <= 12)
 			inode->z_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
 		inode->datalayout = EROFS_INODE_COMPRESSED_COMPACT;
@@ -1054,6 +1190,7 @@ static void *z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
 		free(ei);
 	}
 	z_erofs_fini_full_indexes(ctx);
+out:
 	z_erofs_write_mapheader(inode, metabuf);
 	return metabuf;
 }
@@ -1126,6 +1263,7 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 	}
 
 	ctx->pstart = pstart;
+	ctx->poff = 0;
 	while (ctx->remaining) {
 		const u64 rx = min_t(u64, ctx->remaining,
 				     Z_EROFS_COMPR_QUEUE_SZ - ctx->tail);
@@ -1364,8 +1502,6 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 		ret = -ENOMEM;
 		goto out;
 	}
-	sctx->memoff = 0;
-
 	ret = z_erofs_compress_segment(sctx, sctx->seg_idx * cfg.c_mkfs_segment_size,
 				       EROFS_NULL_ADDR);
 
@@ -1632,9 +1768,6 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	/* initialize per-file compression setting */
 	inode->z_advise = 0;
 	inode->z_lclusterbits = sbi->blkszbits;
-	if (cfg.c_fragments && !cfg.c_dedupe)
-		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
-
 #ifndef NDEBUG
 	if (cfg.c_random_algorithms) {
 		while (1) {
@@ -1667,6 +1800,11 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	ictx->ccfg = &sbi->zmgr->ccfg[inode->z_algorithmtype[0]];
 	inode->z_algorithmtype[0] = ictx->ccfg->algorithmtype;
 	inode->z_algorithmtype[1] = 0;
+	ictx->data_unaligned = erofs_sb_has_48bit(sbi) &&
+		cfg.c_max_decompressed_extent_bytes <=
+			z_erofs_get_max_pclustersize(inode);
+	if (cfg.c_fragments && !cfg.c_dedupe && !ictx->data_unaligned)
+		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 
 	if (cfg.c_fragments && !erofs_is_packed_inode(inode)) {
 		ictx->tofh = z_erofs_fragments_tofh(inode, fd, fpos);
diff --git a/lib/compressor.c b/lib/compressor.c
index 41f49fff..6d8c1c23 100644
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
index 8d322d59..5f86f155 100644
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
index 65531de8..186da87c 100644
--- a/lib/compressor_libdeflate.c
+++ b/lib/compressor_libdeflate.c
@@ -14,6 +14,23 @@ struct erofs_libdeflate_context {
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
@@ -149,5 +166,6 @@ const struct erofs_compressor erofs_compressor_libdeflate = {
 	.exit = compressor_libdeflate_exit,
 	.reset = compressor_libdeflate_reset,
 	.setlevel = erofs_compressor_libdeflate_setlevel,
+	.compress = libdeflate_compress,
 	.compress_destsize = libdeflate_compress_destsize,
 };
diff --git a/lib/compressor_libzstd.c b/lib/compressor_libzstd.c
index de04c58d..3233d723 100644
--- a/lib/compressor_libzstd.c
+++ b/lib/compressor_libzstd.c
@@ -14,6 +14,23 @@ struct erofs_libzstd_context {
 	unsigned int fitblk_bufsiz;
 };
 
+static int libzstd_compress(const struct erofs_compress *c,
+			    const void *src, unsigned int srcsize,
+			    void *dst, unsigned int dstcapacity)
+{
+	struct erofs_libzstd_context *ctx = c->private_data;
+	size_t csize;
+
+	csize = ZSTD_compress2(ctx->cctx, dst, dstcapacity, src, srcsize);
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
@@ -176,5 +193,6 @@ const struct erofs_compressor erofs_compressor_libzstd = {
 	.exit = compressor_libzstd_exit,
 	.setlevel = erofs_compressor_libzstd_setlevel,
 	.setdictsize = erofs_compressor_libzstd_setdictsize,
+	.compress = libzstd_compress,
 	.compress_destsize = libzstd_compress_destsize,
 };
-- 
2.43.5


