Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F13235B153
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 05:49:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FHyXk40kkz3bsD
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 13:49:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ox1heshQ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Ox1heshQ; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FHyXh5Rvsz3bV8
 for <linux-erofs@lists.ozlabs.org>; Sun, 11 Apr 2021 13:49:08 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0ACA1610E9;
 Sun, 11 Apr 2021 03:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618112946;
 bh=zrmayBrKjqWCEZhhteKt0SnJtJn046NaM+HsjOT2rWk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ox1heshQ9Xuu/KeLX/vSXHPb4oFHv6cK9E8xLqriQPTpscm+ljXrJktFBOSsSubuw
 spwFdMk9u1G+Z2aPIL9XJ7vzYSBJ8gn2Vc0rTM8/inrIzH2HzZXfEUT52F4gB7fPfp
 lPx0AcBCMFhdO4Jszc24NnOHH1Tjrd+FaAJoFgIc65rtaPETeDwkx2AkDL+TQgG7Nm
 z6WMg+qawJ9ttbfJR4UL6ezo+RPJtDrlAcckoxNTkSleaLE5DZqM8hm8/gnaFVYyiQ
 uPw0GBR1KnCTALqWr/NEgT4SEyarGP8Z+pbzyobkFmN2YGT8LVXbeK18ljglJkkx0W
 w0Hfx4EWVs90g==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 6/8] erofs-utils: mkfs: support multiple block compression
Date: Sun, 11 Apr 2021 11:48:42 +0800
Message-Id: <20210411034844.12673-7-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210411034844.12673-1-xiang@kernel.org>
References: <20210411034844.12673-1-xiang@kernel.org>
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
Cc: Gao Xiang <xiang@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Store compressed block count to the compressed index so that EROFS
can compress from variable-sized input to variable-sized compressed
blocks and make the in-place decompression possible as well.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 lib/compress.c | 77 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 24 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index c991c13dfd1a..c8b627db5bec 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -29,8 +29,8 @@ struct z_erofs_vle_compress_ctx {
 
 	u8 queue[EROFS_CONFIG_COMPR_MAX_SZ * 2];
 	unsigned int head, tail;
-
-	erofs_blk_t blkaddr;	/* pointing to the next blkaddr */
+	unsigned int compressedblks;
+	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
 	u16 clusterofs;
 };
 
@@ -89,7 +89,13 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 	}
 
 	do {
-		if (d0) {
+		/* XXX: big pcluster feature should be per-inode */
+		if (d0 == 1 && cfg.c_physical_clusterblks > 1) {
+			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
+			di.di_u.delta[0] = cpu_to_le16(ctx->compressedblks |
+					Z_EROFS_VLE_DI_D0_CBLKCNT);
+			di.di_u.delta[1] = cpu_to_le16(d1);
+		} else if (d0) {
 			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
 
 			di.di_u.delta[0] = cpu_to_le16(d0);
@@ -115,9 +121,8 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 	ctx->clusterofs = clusterofs + count;
 }
 
-static int write_uncompressed_block(struct z_erofs_vle_compress_ctx *ctx,
-				    unsigned int *len,
-				    char *dst)
+static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
+				     unsigned int *len, char *dst)
 {
 	int ret;
 	unsigned int count;
@@ -148,17 +153,19 @@ static int vle_compress_one(struct erofs_inode *inode,
 			    struct z_erofs_vle_compress_ctx *ctx,
 			    bool final)
 {
+	const unsigned int pclusterblks = cfg.c_physical_clusterblks;
+	const unsigned int pclustersize = pclusterblks * EROFS_BLKSIZ;
 	struct erofs_compress *const h = &compresshandle;
 	unsigned int len = ctx->tail - ctx->head;
 	unsigned int count;
 	int ret;
-	static char dstbuf[EROFS_BLKSIZ * 2];
+	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
 	char *const dst = dstbuf + EROFS_BLKSIZ;
 
 	while (len) {
 		bool raw;
 
-		if (len <= EROFS_BLKSIZ) {
+		if (len <= pclustersize) {
 			if (final)
 				goto nocompression;
 			break;
@@ -167,7 +174,7 @@ static int vle_compress_one(struct erofs_inode *inode,
 		count = len;
 		ret = erofs_compress_destsize(h, compressionlevel,
 					      ctx->queue + ctx->head,
-					      &count, dst, EROFS_BLKSIZ);
+					      &count, dst, pclustersize);
 		if (ret <= 0) {
 			if (ret != -EAGAIN) {
 				erofs_err("failed to compress %s: %s",
@@ -175,32 +182,36 @@ static int vle_compress_one(struct erofs_inode *inode,
 					  erofs_strerror(ret));
 			}
 nocompression:
-			ret = write_uncompressed_block(ctx, &len, dst);
+			ret = write_uncompressed_extent(ctx, &len, dst);
 			if (ret < 0)
 				return ret;
 			count = ret;
+			ctx->compressedblks = 1;
 			raw = true;
 		} else {
-			/* write compressed data */
-			erofs_dbg("Writing %u compressed data to block %u",
-				  count, ctx->blkaddr);
+			const unsigned int used = ret & (EROFS_BLKSIZ - 1);
+			const unsigned int margin =
+				erofs_sb_has_lz4_0padding() && used ?
+					EROFS_BLKSIZ - used : 0;
 
-			if (erofs_sb_has_lz4_0padding())
-				ret = blk_write(dst - (EROFS_BLKSIZ - ret),
-						ctx->blkaddr, 1);
-			else
-				ret = blk_write(dst, ctx->blkaddr, 1);
+			ctx->compressedblks = DIV_ROUND_UP(ret, EROFS_BLKSIZ);
 
+			/* write compressed data */
+			erofs_dbg("Writing %u compressed data to %u of %u blocks",
+				  count, ctx->blkaddr, ctx->compressedblks);
+
+			ret = blk_write(dst - margin, ctx->blkaddr,
+					ctx->compressedblks);
 			if (ret)
 				return ret;
 			raw = false;
 		}
 
 		ctx->head += count;
-		/* write compression indexes for this blkaddr */
+		/* write compression indexes for this pcluster */
 		vle_write_indexes(ctx, count, raw);
 
-		++ctx->blkaddr;
+		ctx->blkaddr += ctx->compressedblks;
 		len -= count;
 
 		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
@@ -345,8 +356,6 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 
 	out = in = inode->compressmeta;
 
-	/* write out compacted header */
-	memcpy(out, &mapheader, sizeof(mapheader));
 	out += sizeof(mapheader);
 	in += Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 
@@ -415,6 +424,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	}
 
 	memset(compressmeta, 0, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
+	/* write out compressed header */
+	memcpy(compressmeta, &mapheader, sizeof(mapheader));
 
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.blkaddr = blkaddr;
@@ -474,7 +485,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	inode->u.i_blocks = compressed_blocks;
 
 	legacymetasize = ctx.metacur - compressmeta;
-	if (cfg.c_legacy_compress) {
+	/* XXX: temporarily use legacy index instead for mbpcluster */
+	if (cfg.c_legacy_compress || cfg.c_physical_clusterblks > 1) {
 		inode->extent_isize = legacymetasize;
 		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
 	} else {
@@ -514,6 +526,7 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 			.lz4 = {
 				.max_distance =
 					cpu_to_le16(sbi.lz4_max_distance),
+				.max_pclusterblks = cfg.c_physical_clusterblks,
 			}
 		};
 
@@ -562,7 +575,23 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 
 	algorithmtype[0] = ret;	/* primary algorithm (head 0) */
 	algorithmtype[1] = 0;	/* secondary algorithm (head 1) */
-	mapheader.h_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
+	mapheader.h_advise = 0;
+	if (!cfg.c_legacy_compress)
+		mapheader.h_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
+	/*
+	 * if big pcluster is enabled, an extra CBLKCNT lcluster index needs
+	 * to be loaded in order to get those compressed block counts.
+	 */
+	if (cfg.c_physical_clusterblks > 1) {
+		if (cfg.c_physical_clusterblks >
+		    Z_EROFS_PCLUSTER_MAX_SIZE / EROFS_BLKSIZ) {
+			erofs_err("unsupported clusterblks %u (too large)",
+				  cfg.c_physical_clusterblks);
+			return -EINVAL;
+		}
+		erofs_sb_set_big_pcluster();
+		mapheader.h_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
+	}
 	mapheader.h_algorithmtype = algorithmtype[1] << 4 |
 					  algorithmtype[0];
 	mapheader.h_clusterbits = LOG_BLOCK_SIZE - 12;
-- 
2.20.1

