Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19EF7D8F30
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Oct 2023 09:06:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SGtxb0ycmz3c3x
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Oct 2023 18:06:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SGtxT3ypCz2yVh
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Oct 2023 18:06:19 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vv-6fPJ_1698390367;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vv-6fPJ_1698390367)
          by smtp.aliyun-inc.com;
          Fri, 27 Oct 2023 15:06:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: tidy up erofs_compress_destsize()
Date: Fri, 27 Oct 2023 15:06:06 +0800
Message-Id: <20231027070606.1558363-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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

Drop the old workaround logic to prepare for the following development.

(I've checked the Linux 6.1.53 source code and an AOSP rootfs without
 any image size change and strange behavior.)

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c   | 71 +++++++++++++++++++++++++++---------------------
 lib/compressor.c | 33 +++-------------------
 lib/compressor.h |  7 +----
 3 files changed, 45 insertions(+), 66 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 5900233..c2f6e90 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -338,7 +338,7 @@ static int z_erofs_fill_inline_data(struct erofs_inode *inode, void *data,
 static void tryrecompress_trailing(struct z_erofs_vle_compress_ctx *ctx,
 				   struct erofs_compress *ec,
 				   void *in, unsigned int *insize,
-				   void *out, int *compressedsize)
+				   void *out, unsigned int *compressedsize)
 {
 	struct erofs_sb_info *sbi = ctx->inode->sbi;
 	static char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
@@ -351,7 +351,7 @@ static void tryrecompress_trailing(struct z_erofs_vle_compress_ctx *ctx,
 
 	count = *insize;
 	ret = erofs_compress_destsize(ec, in, &count, (void *)tmp,
-				      rounddown(ret, erofs_blksiz(sbi)), false);
+				      rounddown(ret, erofs_blksiz(sbi)));
 	if (ret <= 0 || ret + (*insize - count) >=
 			roundup(*compressedsize, erofs_blksiz(sbi)))
 		return;
@@ -397,7 +397,8 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_MAX_BLOCK_SIZE];
 	struct erofs_inode *inode = ctx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
-	char *const dst = dstbuf + erofs_blksiz(sbi);
+	unsigned int blksz = erofs_blksiz(sbi);
+	char *const dst = dstbuf + blksz;
 	struct erofs_compress *const h = &ctx->ccfg->handle;
 	unsigned int len = ctx->tail - ctx->head;
 	bool is_packed_inode = erofs_is_packed_inode(inode);
@@ -410,6 +411,7 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 		bool may_inline = (cfg.c_ztailpacking && final &&
 				  !may_packing);
 		bool fix_dedupedfrag = ctx->fix_dedupedfrag;
+		unsigned int compressedsize;
 
 		if (z_erofs_compress_dedupe(ctx, &len) && !final)
 			break;
@@ -419,30 +421,35 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 				break;
 			if (may_packing) {
 				if (inode->fragment_size && !fix_dedupedfrag) {
-					ctx->pclustersize =
-						roundup(len, erofs_blksiz(sbi));
+					ctx->pclustersize = roundup(len, blksz);
 					goto fix_dedupedfrag;
 				}
 				ctx->e.length = len;
 				goto frag_packing;
 			}
-			if (!may_inline && len <= erofs_blksiz(sbi))
+			if (!may_inline && len <= blksz)
 				goto nocompression;
 		}
 
 		ctx->e.length = min(len,
 				cfg.c_max_decompressed_extent_bytes);
+
 		ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
-				&ctx->e.length, dst, ctx->pclustersize,
-				!(final && len == ctx->e.length));
+				&ctx->e.length, dst, ctx->pclustersize);
 		if (ret <= 0) {
-			if (ret != -EAGAIN) {
-				erofs_err("failed to compress %s: %s",
-					  inode->i_srcpath,
-					  erofs_strerror(ret));
-			}
+			erofs_err("failed to compress %s: %s", inode->i_srcpath,
+				  erofs_strerror(ret));
+			return ret;
+		}
+
+		compressedsize = ret;
+		/* even compressed size is smaller, there is no real gain */
+		if (!(may_inline && ctx->e.length == len && ret < blksz))
+			ret = roundup(ret, blksz);
 
-			if (may_inline && len < erofs_blksiz(sbi)) {
+		/* check if there is enough gain to keep the compressed data */
+		if (ret * h->compress_threshold / 100 >= ctx->e.length) {
+			if (may_inline && len < blksz) {
 				ret = z_erofs_fill_inline_data(inode,
 						ctx->queue + ctx->head,
 						len, true);
@@ -465,7 +472,7 @@ nocompression:
 			ctx->e.compressedblks = 1;
 			ctx->e.raw = true;
 		} else if (may_packing && len == ctx->e.length &&
-			   ret < ctx->pclustersize &&
+			   compressedsize < ctx->pclustersize &&
 			   (!inode->fragment_size || fix_dedupedfrag)) {
 frag_packing:
 			ret = z_erofs_pack_fragments(inode,
@@ -479,8 +486,8 @@ frag_packing:
 			fix_dedupedfrag = false;
 		/* tailpcluster should be less than 1 block */
 		} else if (may_inline && len == ctx->e.length &&
-			   ret < erofs_blksiz(sbi)) {
-			if (ctx->clusterofs + len <= erofs_blksiz(sbi)) {
+			   compressedsize < blksz) {
+			if (ctx->clusterofs + len <= blksz) {
 				inode->eof_tailraw = malloc(len);
 				if (!inode->eof_tailraw)
 					return -ENOMEM;
@@ -490,7 +497,8 @@ frag_packing:
 				inode->eof_tailrawsize = len;
 			}
 
-			ret = z_erofs_fill_inline_data(inode, dst, ret, false);
+			ret = z_erofs_fill_inline_data(inode, dst,
+					compressedsize, false);
 			if (ret < 0)
 				return ret;
 			ctx->e.compressedblks = 1;
@@ -506,30 +514,31 @@ frag_packing:
 			 * Otherwise, just drop it and go to packing.
 			 */
 			if (may_packing && len == ctx->e.length &&
-			    (ret & (erofs_blksiz(sbi) - 1)) &&
+			    (compressedsize & (blksz - 1)) &&
 			    ctx->tail < sizeof(ctx->queue)) {
-				ctx->pclustersize = BLK_ROUND_UP(sbi, ret) *
-						erofs_blksiz(sbi);
+				ctx->pclustersize =
+					roundup(compressedsize, blksz);
 				goto fix_dedupedfrag;
 			}
 
 			if (may_inline && len == ctx->e.length)
 				tryrecompress_trailing(ctx, h,
 						ctx->queue + ctx->head,
-						&ctx->e.length, dst, &ret);
+						&ctx->e.length, dst,
+						&compressedsize);
 
-			tailused = ret & (erofs_blksiz(sbi) - 1);
-			padding = 0;
-			ctx->e.compressedblks = BLK_ROUND_UP(sbi, ret);
-			DBG_BUGON(ctx->e.compressedblks * erofs_blksiz(sbi) >=
+			ctx->e.compressedblks = BLK_ROUND_UP(sbi, compressedsize);
+			DBG_BUGON(ctx->e.compressedblks * blksz >=
 				  ctx->e.length);
 
+			padding = 0;
+			tailused = compressedsize & (blksz - 1);
+			if (tailused)
+				padding = blksz - tailused;
+
 			/* zero out garbage trailing data for non-0padding */
 			if (!erofs_sb_has_lz4_0padding(sbi))
-				memset(dst + ret, 0,
-				       roundup(ret, erofs_blksiz(sbi)) - ret);
-			else if (tailused)
-				padding = erofs_blksiz(sbi) - tailused;
+				memset(dst + compressedsize, 0, padding);
 
 			/* write compressed data */
 			erofs_dbg("Writing %u compressed data to %u of %u blocks",
@@ -559,7 +568,7 @@ frag_packing:
 
 		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
 			const unsigned int qh_aligned =
-				round_down(ctx->head, erofs_blksiz(sbi));
+				round_down(ctx->head, blksz);
 			const unsigned int qh_after = ctx->head - qh_aligned;
 
 			memmove(ctx->queue, ctx->queue + qh_aligned,
diff --git a/lib/compressor.c b/lib/compressor.c
index 93f5617..9128ae9 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -8,8 +8,6 @@
 #include "compressor.h"
 #include "erofs/print.h"
 
-#define EROFS_CONFIG_COMPR_DEF_BOUNDARY		(128)
-
 static const struct erofs_algorithm {
 	char *name;
 	const struct erofs_compressor *c;
@@ -77,31 +75,13 @@ const char *z_erofs_list_available_compressors(int *i)
 
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
-			    void *dst, unsigned int dstsize, bool inblocks)
+			    void *dst, unsigned int dstsize)
 {
-	unsigned int uncompressed_capacity, compressed_size;
-	int ret;
-
 	DBG_BUGON(!c->alg);
 	if (!c->alg->c->compress_destsize)
-		return -ENOTSUP;
-
-	uncompressed_capacity = *srcsize;
-	ret = c->alg->c->compress_destsize(c, src, srcsize, dst, dstsize);
-	if (ret < 0)
-		return ret;
-
-	/* XXX: ret >= destsize_alignsize is a temporary hack for ztailpacking */
-	if (inblocks || ret >= c->destsize_alignsize ||
-	    uncompressed_capacity != *srcsize)
-		compressed_size = roundup(ret, c->destsize_alignsize);
-	else
-		compressed_size = ret;
-	DBG_BUGON(c->compress_threshold < 100);
-	/* check if there is enough gains to compress */
-	if (*srcsize <= compressed_size * c->compress_threshold / 100)
-		return -EAGAIN;
-	return ret;
+		return -EOPNOTSUPP;
+
+	return c->alg->c->compress_destsize(c, src, srcsize, dst, dstsize);
 }
 
 int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level)
@@ -126,11 +106,6 @@ int erofs_compressor_init(struct erofs_sb_info *sbi,
 	/* should be written in "minimum compression ratio * 100" */
 	c->compress_threshold = 100;
 
-	/* optimize for 4k size page */
-	c->destsize_alignsize = erofs_blksiz(sbi);
-	c->destsize_redzone_begin = erofs_blksiz(sbi) - 16;
-	c->destsize_redzone_end = EROFS_CONFIG_COMPR_DEF_BOUNDARY;
-
 	if (!alg_name) {
 		c->alg = NULL;
 		return 0;
diff --git a/lib/compressor.h b/lib/compressor.h
index 9fa01d1..9e6a085 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -33,11 +33,6 @@ struct erofs_compress {
 	unsigned int compress_threshold;
 	unsigned int compression_level;
 
-	/* *_destsize specific */
-	unsigned int destsize_alignsize;
-	unsigned int destsize_redzone_begin;
-	unsigned int destsize_redzone_end;
-
 	void *private_data;
 };
 
@@ -51,7 +46,7 @@ extern const struct erofs_compressor erofs_compressor_libdeflate;
 int z_erofs_get_compress_algorithm_id(const struct erofs_compress *c);
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
-			    void *dst, unsigned int dstsize, bool inblocks);
+			    void *dst, unsigned int dstsize);
 
 int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level);
 int erofs_compressor_init(struct erofs_sb_info *sbi,
-- 
2.39.3

