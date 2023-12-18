Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5410A81745E
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Dec 2023 15:57:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sv2xB3PDzz3c5q
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Dec 2023 01:57:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sv2x10YkSz3bYR
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Dec 2023 01:57:22 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vynf.pQ_1702911436;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vynf.pQ_1702911436)
          by smtp.aliyun-inc.com;
          Mon, 18 Dec 2023 22:57:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 2/3] erofs-utils: lib: split vle_compress_one()
Date: Mon, 18 Dec 2023 22:57:09 +0800
Message-Id: <20231218145710.132164-2-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Split compression for each extent into a new helper for later reworking.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 297 ++++++++++++++++++++++++-------------------------
 1 file changed, 147 insertions(+), 150 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index a5ef6e4..eafbad1 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -400,7 +400,8 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
 	return true;
 }
 
-static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
+static int __z_erofs_compress_one(struct z_erofs_vle_compress_ctx *ctx,
+				  struct z_erofs_inmem_extent *e)
 {
 	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_MAX_BLOCK_SIZE];
 	struct erofs_inode *inode = ctx->inode;
@@ -411,181 +412,177 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 	unsigned int len = ctx->tail - ctx->head;
 	bool is_packed_inode = erofs_is_packed_inode(inode);
 	bool final = !ctx->remaining;
+	bool may_packing = (cfg.c_fragments && final && !is_packed_inode);
+	bool may_inline = (cfg.c_ztailpacking && final && !may_packing);
+	unsigned int compressedsize;
 	int ret;
 
-	while (len) {
-		bool may_packing = (cfg.c_fragments && final &&
-				   !is_packed_inode);
-		bool may_inline = (cfg.c_ztailpacking && final &&
-				  !may_packing);
-		bool fix_dedupedfrag = ctx->fix_dedupedfrag;
-		unsigned int compressedsize;
-
-		if (z_erofs_compress_dedupe(ctx, &len))
-			break;
-
-		if (len <= ctx->pclustersize) {
-			if (!final || !len)
-				break;
-			if (may_packing) {
-				if (inode->fragment_size && !fix_dedupedfrag) {
-					ctx->pclustersize = roundup(len, blksz);
-					goto fix_dedupedfrag;
-				}
-				ctx->e.length = len;
-				goto frag_packing;
+	if (len <= ctx->pclustersize) {
+		if (!final || !len)
+			return 1;
+		if (may_packing) {
+			if (inode->fragment_size && !ctx->fix_dedupedfrag) {
+				ctx->pclustersize = roundup(len, blksz);
+				goto fix_dedupedfrag;
 			}
-			if (!may_inline && len <= blksz)
-				goto nocompression;
+			e->length = len;
+			goto frag_packing;
 		}
+		if (!may_inline && len <= blksz)
+			goto nocompression;
+	}
 
-		ctx->e.length = min(len,
-				cfg.c_max_decompressed_extent_bytes);
+	e->length = min(len, cfg.c_max_decompressed_extent_bytes);
+	ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
+				      &e->length, dst, ctx->pclustersize);
+	if (ret <= 0) {
+		erofs_err("failed to compress %s: %s", inode->i_srcpath,
+			  erofs_strerror(ret));
+		return ret;
+	}
 
-		ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
-				&ctx->e.length, dst, ctx->pclustersize);
-		if (ret <= 0) {
-			erofs_err("failed to compress %s: %s", inode->i_srcpath,
-				  erofs_strerror(ret));
-			return ret;
-		}
+	compressedsize = ret;
+	/* even compressed size is smaller, there is no real gain */
+	if (!(may_inline && e->length == len && ret < blksz))
+		ret = roundup(ret, blksz);
 
-		compressedsize = ret;
-		/* even compressed size is smaller, there is no real gain */
-		if (!(may_inline && ctx->e.length == len && ret < blksz))
-			ret = roundup(ret, blksz);
-
-		/* check if there is enough gain to keep the compressed data */
-		if (ret * h->compress_threshold / 100 >= ctx->e.length) {
-			if (may_inline && len < blksz) {
-				ret = z_erofs_fill_inline_data(inode,
-						ctx->queue + ctx->head,
-						len, true);
-			} else {
-				may_inline = false;
-				may_packing = false;
+	/* check if there is enough gain to keep the compressed data */
+	if (ret * h->compress_threshold / 100 >= e->length) {
+		if (may_inline && len < blksz) {
+			ret = z_erofs_fill_inline_data(inode,
+					ctx->queue + ctx->head, len, true);
+		} else {
+			may_inline = false;
+			may_packing = false;
 nocompression:
-				ret = write_uncompressed_extent(ctx, &len, dst);
-			}
+			ret = write_uncompressed_extent(ctx, &len, dst);
+		}
 
-			if (ret < 0)
-				return ret;
-			ctx->e.length = ret;
+		if (ret < 0)
+			return ret;
+		e->length = ret;
 
-			/*
-			 * XXX: For now, we have to leave `ctx->compressedblks
-			 * = 1' since there is no way to generate compressed
-			 * indexes after the time that ztailpacking is decided.
-			 */
-			ctx->e.compressedblks = 1;
-			ctx->e.raw = true;
-		} else if (may_packing && len == ctx->e.length &&
-			   compressedsize < ctx->pclustersize &&
-			   (!inode->fragment_size || fix_dedupedfrag)) {
+		/*
+		 * XXX: For now, we have to leave `ctx->compressedblk = 1'
+		 * since there is no way to generate compressed indexes after
+		 * the time that ztailpacking is decided.
+		 */
+		e->compressedblks = 1;
+		e->raw = true;
+	} else if (may_packing && len == e->length &&
+		   compressedsize < ctx->pclustersize &&
+		   (!inode->fragment_size || ctx->fix_dedupedfrag)) {
 frag_packing:
-			ret = z_erofs_pack_fragments(inode,
-						     ctx->queue + ctx->head,
-						     len, ctx->tof_chksum);
-			if (ret < 0)
-				return ret;
-			ctx->e.compressedblks = 0; /* indicate a fragment */
-			ctx->e.raw = false;
-			ctx->fragemitted = true;
-			fix_dedupedfrag = false;
-		/* tailpcluster should be less than 1 block */
-		} else if (may_inline && len == ctx->e.length &&
-			   compressedsize < blksz) {
-			if (ctx->clusterofs + len <= blksz) {
-				inode->eof_tailraw = malloc(len);
-				if (!inode->eof_tailraw)
-					return -ENOMEM;
-
-				memcpy(inode->eof_tailraw,
-				       ctx->queue + ctx->head, len);
-				inode->eof_tailrawsize = len;
-			}
-
-			ret = z_erofs_fill_inline_data(inode, dst,
-					compressedsize, false);
-			if (ret < 0)
-				return ret;
-			ctx->e.compressedblks = 1;
-			ctx->e.raw = false;
-		} else {
-			unsigned int tailused, padding;
+		ret = z_erofs_pack_fragments(inode, ctx->queue + ctx->head,
+					     len, ctx->tof_chksum);
+		if (ret < 0)
+			return ret;
+		e->compressedblks = 0; /* indicate a fragment */
+		e->raw = false;
+		ctx->fragemitted = true;
+	/* tailpcluster should be less than 1 block */
+	} else if (may_inline && len == e->length && compressedsize < blksz) {
+		if (ctx->clusterofs + len <= blksz) {
+			inode->eof_tailraw = malloc(len);
+			if (!inode->eof_tailraw)
+				return -ENOMEM;
+
+			memcpy(inode->eof_tailraw, ctx->queue + ctx->head, len);
+			inode->eof_tailrawsize = len;
+		}
 
-			/*
-			 * If there's space left for the last round when
-			 * deduping fragments, try to read the fragment and
-			 * recompress a little more to check whether it can be
-			 * filled up. Fix up the fragment if succeeds.
-			 * Otherwise, just drop it and go to packing.
-			 */
-			if (may_packing && len == ctx->e.length &&
-			    (compressedsize & (blksz - 1)) &&
-			    ctx->tail < sizeof(ctx->queue)) {
-				ctx->pclustersize =
-					roundup(compressedsize, blksz);
-				goto fix_dedupedfrag;
-			}
+		ret = z_erofs_fill_inline_data(inode, dst,
+				compressedsize, false);
+		if (ret < 0)
+			return ret;
+		e->compressedblks = 1;
+		e->raw = false;
+	} else {
+		unsigned int tailused, padding;
 
-			if (may_inline && len == ctx->e.length)
-				tryrecompress_trailing(ctx, h,
-						ctx->queue + ctx->head,
-						&ctx->e.length, dst,
-						&compressedsize);
+		/*
+		 * If there's space left for the last round when deduping
+		 * fragments, try to read the fragment and recompress a little
+		 * more to check whether it can be filled up.  Fix the fragment
+		 * if succeeds.  Otherwise, just drop it and go on packing.
+		 */
+		if (may_packing && len == e->length &&
+		    (compressedsize & (blksz - 1)) &&
+		    ctx->tail < sizeof(ctx->queue)) {
+			ctx->pclustersize = roundup(compressedsize, blksz);
+			goto fix_dedupedfrag;
+		}
 
-			ctx->e.compressedblks = BLK_ROUND_UP(sbi, compressedsize);
-			DBG_BUGON(ctx->e.compressedblks * blksz >=
-				  ctx->e.length);
+		if (may_inline && len == e->length)
+			tryrecompress_trailing(ctx, h, ctx->queue + ctx->head,
+					&e->length, dst, &compressedsize);
 
-			padding = 0;
-			tailused = compressedsize & (blksz - 1);
-			if (tailused)
-				padding = blksz - tailused;
-
-			/* zero out garbage trailing data for non-0padding */
-			if (!erofs_sb_has_lz4_0padding(sbi)) {
-				memset(dst + compressedsize, 0, padding);
-				padding = 0;
-			}
+		e->compressedblks = BLK_ROUND_UP(sbi, compressedsize);
+		DBG_BUGON(e->compressedblks * blksz >= e->length);
 
-			/* write compressed data */
-			erofs_dbg("Writing %u compressed data to %u of %u blocks",
-				  ctx->e.length, ctx->blkaddr,
-				  ctx->e.compressedblks);
+		padding = 0;
+		tailused = compressedsize & (blksz - 1);
+		if (tailused)
+			padding = blksz - tailused;
 
-			ret = blk_write(sbi, dst - padding, ctx->blkaddr,
-					ctx->e.compressedblks);
-			if (ret)
-				return ret;
-			ctx->e.raw = false;
-			may_inline = false;
-			may_packing = false;
+		/* zero out garbage trailing data for non-0padding */
+		if (!erofs_sb_has_lz4_0padding(sbi)) {
+			memset(dst + compressedsize, 0, padding);
+			padding = 0;
 		}
-		ctx->e.partial = false;
-		ctx->e.blkaddr = ctx->blkaddr;
-		if (!may_inline && !may_packing && !is_packed_inode)
-			(void)z_erofs_dedupe_insert(&ctx->e,
-						    ctx->queue + ctx->head);
-		ctx->blkaddr += ctx->e.compressedblks;
-		ctx->head += ctx->e.length;
-		len -= ctx->e.length;
 
-		if (fix_dedupedfrag &&
-		    z_erofs_fixup_deduped_fragment(ctx, len))
-			break;
+		/* write compressed data */
+		erofs_dbg("Writing %u compressed data to %u of %u blocks",
+			  e->length, ctx->blkaddr, e->compressedblks);
 
-		if (z_erofs_need_refill(ctx))
-			break;
+		ret = blk_write(sbi, dst - padding, ctx->blkaddr,
+				e->compressedblks);
+		if (ret)
+			return ret;
+		e->raw = false;
+		may_inline = false;
+		may_packing = false;
 	}
+	e->partial = false;
+	e->blkaddr = ctx->blkaddr;
+	if (!may_inline && !may_packing && !is_packed_inode)
+		(void)z_erofs_dedupe_insert(e, ctx->queue + ctx->head);
+	ctx->blkaddr += e->compressedblks;
+	ctx->head += e->length;
 	return 0;
 
 fix_dedupedfrag:
 	DBG_BUGON(!inode->fragment_size);
 	ctx->remaining += inode->fragment_size;
-	ctx->e.length = 0;
+	e->length = 0;
 	ctx->fix_dedupedfrag = true;
+	return 1;
+}
+
+static int z_erofs_compress_one(struct z_erofs_vle_compress_ctx *ctx)
+{
+	unsigned int len = ctx->tail - ctx->head;
+	int ret;
+
+	while (len) {
+		if (z_erofs_compress_dedupe(ctx, &len))
+			break;
+
+		ret = __z_erofs_compress_one(ctx, &ctx->e);
+		if (ret) {
+			if (ret > 0)
+				break;		/* need more data */
+			return ret;
+		}
+
+		len -= ctx->e.length;
+		if (ctx->fix_dedupedfrag && !ctx->fragemitted &&
+		    z_erofs_fixup_deduped_fragment(ctx, len))
+			break;
+
+		if (z_erofs_need_refill(ctx))
+			break;
+	}
 	return 0;
 }
 
@@ -964,7 +961,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 			ctx.remaining -= rx;
 			ctx.tail += rx;
 
-			ret = vle_compress_one(&ctx);
+			ret = z_erofs_compress_one(&ctx);
 			if (ret)
 				goto err_free_idata;
 		}
-- 
2.39.3

