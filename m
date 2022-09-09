Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEC95B2DEA
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 07:04:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MP3mz67YMz3bST
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 15:04:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.15; helo=out199-15.us.a.mail.aliyun.com; envelope-from=ziyangzhang@linux.alibaba.com; receiver=<UNKNOWN>)
X-Greylist: delayed 306 seconds by postgrey-1.36 at boromir; Fri, 09 Sep 2022 15:04:00 AEST
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MP3mw5ycgz2yS0
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Sep 2022 15:04:00 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VP7r43i_1662699518;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VP7r43i_1662699518)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 12:58:43 +0800
From: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V2 1/4] erofs-utils: introduce z_erofs_inmem_extent
Date: Fri,  9 Sep 2022 12:58:18 +0800
Message-Id: <20220909045821.104499-1-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

In order to introduce deduplicatation for compressed pclusters.
A lookahead extent is recorded so that the following deduplication
process can adjust the previous extent on demand.

Also, in the future, it can be used for parallel compression
as well.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
---
 lib/compress.c | 87 ++++++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index fd02053..3c1d9db 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -22,12 +22,19 @@
 static struct erofs_compress compresshandle;
 static unsigned int algorithmtype[2];
 
-struct z_erofs_vle_compress_ctx {
-	u8 *metacur;
+struct z_erofs_inmem_extent {
+	erofs_blk_t blkaddr;
+	unsigned int compressedblks;
+	unsigned int length;
+	bool raw;
+};
 
+struct z_erofs_vle_compress_ctx {
 	u8 queue[EROFS_CONFIG_COMPR_MAX_SZ * 2];
+	struct z_erofs_inmem_extent e;	/* (lookahead) extent */
+
+	u8 *metacur;
 	unsigned int head, tail;
-	unsigned int compressedblks;
 	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
 	u16 clusterofs;
 };
@@ -43,7 +50,7 @@ static unsigned int vle_compressmeta_capacity(erofs_off_t filesize)
 	return Z_EROFS_LEGACY_MAP_HEADER_SIZE + indexsize;
 }
 
-static void vle_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
+static void z_erofs_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
 {
 	const unsigned int type = Z_EROFS_VLE_CLUSTER_TYPE_PLAIN;
 	struct z_erofs_vle_decompressed_index di;
@@ -59,10 +66,10 @@ static void vle_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
 	ctx->metacur += sizeof(di);
 }
 
-static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
-			      unsigned int count, bool raw)
+static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 {
 	unsigned int clusterofs = ctx->clusterofs;
+	unsigned int count = ctx->e.length;
 	unsigned int d0 = 0, d1 = (clusterofs + count) / EROFS_BLKSIZ;
 	struct z_erofs_vle_decompressed_index di;
 	unsigned int type;
@@ -76,13 +83,13 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 		 * A lcluster cannot have three parts with the middle one which
 		 * is well-compressed for !ztailpacking cases.
 		 */
-		DBG_BUGON(!raw && !cfg.c_ztailpacking);
-		type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
+		DBG_BUGON(!ctx->e.raw && !cfg.c_ztailpacking);
+		type = ctx->e.raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
 			Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
 		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
 
 		di.di_advise = advise;
-		di.di_u.blkaddr = cpu_to_le32(ctx->blkaddr);
+		di.di_u.blkaddr = cpu_to_le32(ctx->e.blkaddr);
 		memcpy(ctx->metacur, &di, sizeof(di));
 		ctx->metacur += sizeof(di);
 
@@ -95,7 +102,7 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 		/* XXX: big pcluster feature should be per-inode */
 		if (d0 == 1 && erofs_sb_has_big_pcluster()) {
 			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
-			di.di_u.delta[0] = cpu_to_le16(ctx->compressedblks |
+			di.di_u.delta[0] = cpu_to_le16(ctx->e.compressedblks |
 					Z_EROFS_VLE_DI_D0_CBLKCNT);
 			di.di_u.delta[1] = cpu_to_le16(d1);
 		} else if (d0) {
@@ -119,9 +126,9 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 				di.di_u.delta[0] = cpu_to_le16(d0);
 			di.di_u.delta[1] = cpu_to_le16(d1);
 		} else {
-			type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
+			type = ctx->e.raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
 				Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
-			di.di_u.blkaddr = cpu_to_le32(ctx->blkaddr);
+			di.di_u.blkaddr = cpu_to_le32(ctx->e.blkaddr);
 		}
 		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
 		di.di_advise = advise;
@@ -226,18 +233,16 @@ static int vle_compress_one(struct erofs_inode *inode,
 			    struct z_erofs_vle_compress_ctx *ctx,
 			    bool final)
 {
+	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
+	char *const dst = dstbuf + EROFS_BLKSIZ;
 	struct erofs_compress *const h = &compresshandle;
 	unsigned int len = ctx->tail - ctx->head;
-	unsigned int count;
 	int ret;
-	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
-	char *const dst = dstbuf + EROFS_BLKSIZ;
 
 	while (len) {
 		unsigned int pclustersize =
 			z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
 		bool may_inline = (cfg.c_ztailpacking && final);
-		bool raw;
 
 		if (len <= pclustersize) {
 			if (!final)
@@ -246,10 +251,11 @@ static int vle_compress_one(struct erofs_inode *inode,
 				goto nocompression;
 		}
 
-		count = min(len, cfg.c_max_decompressed_extent_bytes);
+		ctx->e.length = min(len,
+				cfg.c_max_decompressed_extent_bytes);
 		ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
-					      &count, dst, pclustersize,
-					      !(final && len == count));
+				&ctx->e.length, dst, pclustersize,
+				!(final && len == ctx->e.length));
 		if (ret <= 0) {
 			if (ret != -EAGAIN) {
 				erofs_err("failed to compress %s: %s",
@@ -267,17 +273,17 @@ nocompression:
 
 			if (ret < 0)
 				return ret;
-			count = ret;
+			ctx->e.length = ret;
 
 			/*
 			 * XXX: For now, we have to leave `ctx->compressedblks
 			 * = 1' since there is no way to generate compressed
 			 * indexes after the time that ztailpacking is decided.
 			 */
-			ctx->compressedblks = 1;
-			raw = true;
+			ctx->e.compressedblks = 1;
+			ctx->e.raw = true;
 		/* tailpcluster should be less than 1 block */
-		} else if (may_inline && len == count &&
+		} else if (may_inline && len == ctx->e.length &&
 			   ret < EROFS_BLKSIZ) {
 			if (ctx->clusterofs + len <= EROFS_BLKSIZ) {
 				inode->eof_tailraw = malloc(len);
@@ -292,19 +298,20 @@ nocompression:
 			ret = z_erofs_fill_inline_data(inode, dst, ret, false);
 			if (ret < 0)
 				return ret;
-			ctx->compressedblks = 1;
-			raw = false;
+			ctx->e.compressedblks = 1;
+			ctx->e.raw = false;
 		} else {
 			unsigned int tailused, padding;
 
-			if (may_inline && len == count)
+			if (may_inline && len == ctx->e.length)
 				tryrecompress_trailing(ctx->queue + ctx->head,
-						       &count, dst, &ret);
+						&ctx->e.length, dst, &ret);
 
 			tailused = ret & (EROFS_BLKSIZ - 1);
 			padding = 0;
-			ctx->compressedblks = BLK_ROUND_UP(ret);
-			DBG_BUGON(ctx->compressedblks * EROFS_BLKSIZ >= count);
+			ctx->e.compressedblks = BLK_ROUND_UP(ret);
+			DBG_BUGON(ctx->e.compressedblks * EROFS_BLKSIZ >=
+				  ctx->e.length);
 
 			/* zero out garbage trailing data for non-0padding */
 			if (!erofs_sb_has_lz4_0padding())
@@ -315,21 +322,22 @@ nocompression:
 
 			/* write compressed data */
 			erofs_dbg("Writing %u compressed data to %u of %u blocks",
-				  count, ctx->blkaddr, ctx->compressedblks);
+				  ctx->e.length, ctx->blkaddr,
+				  ctx->e.compressedblks);
 
 			ret = blk_write(dst - padding, ctx->blkaddr,
-					ctx->compressedblks);
+					ctx->e.compressedblks);
 			if (ret)
 				return ret;
-			raw = false;
+			ctx->e.raw = false;
 		}
+		/* write indexes for this pcluster */
+		ctx->e.blkaddr = ctx->blkaddr;
+		z_erofs_write_indexes(ctx);
 
-		ctx->head += count;
-		/* write compression indexes for this pcluster */
-		vle_write_indexes(ctx, count, raw);
-
-		ctx->blkaddr += ctx->compressedblks;
-		len -= count;
+		ctx->blkaddr += ctx->e.compressedblks;
+		ctx->head += ctx->e.length;
+		len -= ctx->e.length;
 
 		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
 			const unsigned int qh_aligned =
@@ -654,6 +662,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	ctx.head = ctx.tail = 0;
 	ctx.clusterofs = 0;
+	ctx.e.length = 0;
 	remaining = inode->i_size;
 
 	while (remaining) {
@@ -679,7 +688,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	DBG_BUGON(compressed_blocks < !!inode->idata_size);
 	compressed_blocks -= !!inode->idata_size;
 
-	vle_write_indexes_final(&ctx);
+	z_erofs_write_indexes_final(&ctx);
 	legacymetasize = ctx.metacur - compressmeta;
 	/* estimate if data compression saves space or not */
 	if (compressed_blocks * EROFS_BLKSIZ + inode->idata_size +
-- 
2.27.0

