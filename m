Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BC387C6F9
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 02:11:04 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=t8xrxUUL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TwmQt57Lfz3dfy
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 12:11:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=t8xrxUUL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TwmQL0t8kz3cy9
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Mar 2024 12:10:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710465030; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UWCV9bE4u830xfY39JTY1k1PN51RPufS5XBd3pJ4crQ=;
	b=t8xrxUULrerT4V8WQF1Csd97tRST4tmqSMG/GtTz6arTvWgjOUmyRABsjJilNNWIPZxXMEB2JLUlznUf4HP4aRP33abFj/eEEWtU+cF4djPPAcp4S18TpCz2H+vdo603JszPVmGbQ/bWg5nmc/m47NKgI3T8HC1mLSATbqYtrT8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W2UFdJA_1710465028;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2UFdJA_1710465028)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 09:10:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 5/5] erofs-utils: mkfs: introduce inner-file multi-threaded compression
Date: Fri, 15 Mar 2024 09:10:19 +0800
Message-Id: <20240315011019.610442-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240315011019.610442-1-hsiangkao@linux.alibaba.com>
References: <20240315011019.610442-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yifan Zhao <zhaoyifan@sjtu.edu.cn>, Tong Xin <xin_tong@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>

Currently, the creation of EROFS compressed image creation is
single-threaded, which suffers from performance issues. This patch
attempts to address it by compressing the large file in parallel.

Specifically, each input file larger than 16MB is splited into segments,
and each worker thread compresses a segment as if it were a separate
file. Finally, the main thread merges all the compressed segments.

Multi-threaded compression is not compatible with -Ededupe,
-E(all-)fragments and -Eztailpacking for now.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Co-authored-by: Tong Xin <xin_tong@sjtu.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v7:
 - support -Eztailpacking;
 - wq_private -> wq_tls;
 - minor updates.

 include/erofs/compress.h |   3 +-
 lib/compress.c           | 548 ++++++++++++++++++++++++++++++++-------
 lib/compressor.c         |   2 +
 mkfs/main.c              |   8 +-
 4 files changed, 464 insertions(+), 97 deletions(-)

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index b3272f7..3253611 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -14,7 +14,8 @@ extern "C"
 
 #include "internal.h"
 
-#define EROFS_CONFIG_COMPR_MAX_SZ           (4000 * 1024)
+#define EROFS_CONFIG_COMPR_MAX_SZ	(4000 * 1024)
+#define Z_EROFS_COMPR_QUEUE_SZ		(EROFS_CONFIG_COMPR_MAX_SZ * 2)
 
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
 int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
diff --git a/lib/compress.c b/lib/compress.c
index 4101009..0d796c8 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -20,6 +20,9 @@
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
 #include "erofs/fragments.h"
+#ifdef EROFS_MT_ENABLED
+#include "erofs/workqueue.h"
+#endif
 
 /* compressing configuration specified by users */
 struct erofs_compress_cfg {
@@ -33,29 +36,77 @@ struct z_erofs_extent_item {
 	struct z_erofs_inmem_extent e;
 };
 
-struct z_erofs_vle_compress_ctx {
-	u8 queue[EROFS_CONFIG_COMPR_MAX_SZ * 2];
+struct z_erofs_compress_ictx {
+	struct erofs_inode *inode;
+	int fd;
+	unsigned int pclustersize;
+
+	u32 tof_chksum;
+	bool fix_dedupedfrag;
+	bool fragemitted;
+
+	/* fields for write indexes */
+	u8 *metacur;
+	struct list_head extents;
+	u16 clusterofs;
+};
+
+struct z_erofs_compress_sctx {		/* segment context */
+	struct z_erofs_compress_ictx *ictx;
+
+	u8 *queue;
 	struct list_head extents;
 	struct z_erofs_extent_item *pivot;
 
-	struct erofs_inode *inode;
-	struct erofs_compress_cfg *ccfg;
+	struct erofs_compress *chandle;
+	char *destbuf;
 
-	u8 *metacur;
 	unsigned int head, tail;
 	erofs_off_t remaining;
-	unsigned int pclustersize;
 	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
 	u16 clusterofs;
 
-	u32 tof_chksum;
-	bool fix_dedupedfrag;
-	bool fragemitted;
+	int seg_num, seg_idx;
+
+	void *membuf;
+	erofs_off_t memoff;
+};
+
+#ifdef EROFS_MT_ENABLED
+struct erofs_compress_wq_tls {
+	u8 *queue;
+	char *destbuf;
+	struct erofs_compress_cfg *ccfg;
 };
 
+struct erofs_compress_work {
+	/* Note: struct erofs_work must be the first member */
+	struct erofs_work work;
+	struct z_erofs_compress_sctx ctx;
+	struct erofs_compress_work *next;
+
+	unsigned int alg_id;
+	char *alg_name;
+	unsigned int comp_level;
+	unsigned int dict_size;
+
+	int errcode;
+};
+
+static struct {
+	struct erofs_workqueue wq;
+	struct erofs_compress_work *idle;
+	pthread_mutex_t mutex;
+	pthread_cond_t cond;
+	int nfini;
+} z_erofs_mt_ctrl;
+#endif
+
+static bool z_erofs_mt_enabled;
+
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	Z_EROFS_FULL_INDEX_ALIGN(0)
 
-static void z_erofs_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
+static void z_erofs_write_indexes_final(struct z_erofs_compress_ictx *ctx)
 {
 	const unsigned int type = Z_EROFS_LCLUSTER_TYPE_PLAIN;
 	struct z_erofs_lcluster_index di;
@@ -71,7 +122,7 @@ static void z_erofs_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
 	ctx->metacur += sizeof(di);
 }
 
-static void z_erofs_write_extent(struct z_erofs_vle_compress_ctx *ctx,
+static void z_erofs_write_extent(struct z_erofs_compress_ictx *ctx,
 				 struct z_erofs_inmem_extent *e)
 {
 	struct erofs_inode *inode = ctx->inode;
@@ -170,7 +221,7 @@ static void z_erofs_write_extent(struct z_erofs_vle_compress_ctx *ctx,
 	ctx->clusterofs = clusterofs + count;
 }
 
-static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
+static void z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
 {
 	struct z_erofs_extent_item *ei, *n;
 
@@ -184,15 +235,16 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 	z_erofs_write_indexes_final(ctx);
 }
 
-static bool z_erofs_need_refill(struct z_erofs_vle_compress_ctx *ctx)
+static bool z_erofs_need_refill(struct z_erofs_compress_sctx *ctx)
 {
 	const bool final = !ctx->remaining;
 	unsigned int qh_aligned, qh_after;
+	struct erofs_inode *inode = ctx->ictx->inode;
 
 	if (final || ctx->head < EROFS_CONFIG_COMPR_MAX_SZ)
 		return false;
 
-	qh_aligned = round_down(ctx->head, erofs_blksiz(ctx->inode->sbi));
+	qh_aligned = round_down(ctx->head, erofs_blksiz(inode->sbi));
 	qh_after = ctx->head - qh_aligned;
 	memmove(ctx->queue, ctx->queue + qh_aligned, ctx->tail - qh_aligned);
 	ctx->tail -= qh_aligned;
@@ -204,7 +256,7 @@ static struct z_erofs_extent_item dummy_pivot = {
 	.e.length = 0
 };
 
-static void z_erofs_commit_extent(struct z_erofs_vle_compress_ctx *ctx,
+static void z_erofs_commit_extent(struct z_erofs_compress_sctx *ctx,
 				  struct z_erofs_extent_item *ei)
 {
 	if (ei == &dummy_pivot)
@@ -212,14 +264,13 @@ static void z_erofs_commit_extent(struct z_erofs_vle_compress_ctx *ctx,
 
 	list_add_tail(&ei->list, &ctx->extents);
 	ctx->clusterofs = (ctx->clusterofs + ei->e.length) &
-			(erofs_blksiz(ctx->inode->sbi) - 1);
-
+			  (erofs_blksiz(ctx->ictx->inode->sbi) - 1);
 }
 
-static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
+static int z_erofs_compress_dedupe(struct z_erofs_compress_sctx *ctx,
 				   unsigned int *len)
 {
-	struct erofs_inode *inode = ctx->inode;
+	struct erofs_inode *inode = ctx->ictx->inode;
 	const unsigned int lclustermask = (1 << inode->z_logical_clusterbits) - 1;
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct z_erofs_extent_item *ei = ctx->pivot;
@@ -315,16 +366,17 @@ out:
 	return 0;
 }
 
-static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
+static int write_uncompressed_extent(struct z_erofs_compress_sctx *ctx,
 				     unsigned int len, char *dst)
 {
-	struct erofs_sb_info *sbi = ctx->inode->sbi;
+	struct erofs_inode *inode = ctx->ictx->inode;
+	struct erofs_sb_info *sbi = inode->sbi;
 	unsigned int count = min(erofs_blksiz(sbi), len);
 	unsigned int interlaced_offset, rightpart;
 	int ret;
 
 	/* write interlaced uncompressed data if needed */
-	if (ctx->inode->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
+	if (inode->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
 		interlaced_offset = ctx->clusterofs;
 	else
 		interlaced_offset = 0;
@@ -335,11 +387,17 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 	memcpy(dst + interlaced_offset, ctx->queue + ctx->head, rightpart);
 	memcpy(dst, ctx->queue + ctx->head + rightpart, count - rightpart);
 
-	erofs_dbg("Writing %u uncompressed data to block %u",
-		  count, ctx->blkaddr);
-	ret = blk_write(sbi, dst, ctx->blkaddr, 1);
-	if (ret)
-		return ret;
+	if (ctx->membuf) {
+		erofs_dbg("Writing %u uncompressed data to membuf", count);
+		memcpy(ctx->membuf + ctx->memoff, dst, erofs_blksiz(sbi));
+		ctx->memoff += erofs_blksiz(sbi);
+	} else {
+		erofs_dbg("Writing %u uncompressed data to block %u", count,
+			  ctx->blkaddr);
+		ret = blk_write(sbi, dst, ctx->blkaddr, 1);
+		if (ret)
+			return ret;
+	}
 	return count;
 }
 
@@ -379,12 +437,12 @@ static int z_erofs_fill_inline_data(struct erofs_inode *inode, void *data,
 	return len;
 }
 
-static void tryrecompress_trailing(struct z_erofs_vle_compress_ctx *ctx,
+static void tryrecompress_trailing(struct z_erofs_compress_sctx *ctx,
 				   struct erofs_compress *ec,
 				   void *in, unsigned int *insize,
 				   void *out, unsigned int *compressedsize)
 {
-	struct erofs_sb_info *sbi = ctx->inode->sbi;
+	struct erofs_sb_info *sbi = ctx->ictx->inode->sbi;
 	static char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
 	unsigned int count;
 	int ret = *compressedsize;
@@ -406,10 +464,11 @@ static void tryrecompress_trailing(struct z_erofs_vle_compress_ctx *ctx,
 	*compressedsize = ret;
 }
 
-static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
+static bool z_erofs_fixup_deduped_fragment(struct z_erofs_compress_sctx *ctx,
 					   unsigned int len)
 {
-	struct erofs_inode *inode = ctx->inode;
+	struct z_erofs_compress_ictx *ictx = ctx->ictx;
+	struct erofs_inode *inode = ictx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
 	const unsigned int newsize = ctx->remaining + len;
 
@@ -417,9 +476,10 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
 
 	/* try to fix again if it gets larger (should be rare) */
 	if (inode->fragment_size < newsize) {
-		ctx->pclustersize = min_t(erofs_off_t, z_erofs_get_max_pclustersize(inode),
-					  roundup(newsize - inode->fragment_size,
-						  erofs_blksiz(sbi)));
+		ictx->pclustersize = min_t(erofs_off_t,
+				z_erofs_get_max_pclustersize(inode),
+				roundup(newsize - inode->fragment_size,
+					erofs_blksiz(sbi)));
 		return false;
 	}
 
@@ -436,29 +496,32 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
 	return true;
 }
 
-static int __z_erofs_compress_one(struct z_erofs_vle_compress_ctx *ctx,
+static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 				  struct z_erofs_inmem_extent *e)
 {
-	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_MAX_BLOCK_SIZE];
-	struct erofs_inode *inode = ctx->inode;
+	static char g_dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_MAX_BLOCK_SIZE];
+	char *dstbuf = ctx->destbuf ?: g_dstbuf;
+	struct z_erofs_compress_ictx *ictx = ctx->ictx;
+	struct erofs_inode *inode = ictx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
 	unsigned int blksz = erofs_blksiz(sbi);
 	char *const dst = dstbuf + blksz;
-	struct erofs_compress *const h = &ctx->ccfg->handle;
+	struct erofs_compress *const h = ctx->chandle;
 	unsigned int len = ctx->tail - ctx->head;
 	bool is_packed_inode = erofs_is_packed_inode(inode);
 	bool final = !ctx->remaining;
-	bool may_packing = (cfg.c_fragments && final && !is_packed_inode);
+	bool may_packing = (cfg.c_fragments && final && !is_packed_inode &&
+			    !z_erofs_mt_enabled);
 	bool may_inline = (cfg.c_ztailpacking && final && !may_packing);
 	unsigned int compressedsize;
 	int ret;
 
-	if (len <= ctx->pclustersize) {
+	if (len <= ictx->pclustersize) {
 		if (!final || !len)
 			return 1;
 		if (may_packing) {
-			if (inode->fragment_size && !ctx->fix_dedupedfrag) {
-				ctx->pclustersize = roundup(len, blksz);
+			if (inode->fragment_size && !ictx->fix_dedupedfrag) {
+				ictx->pclustersize = roundup(len, blksz);
 				goto fix_dedupedfrag;
 			}
 			e->length = len;
@@ -470,7 +533,7 @@ static int __z_erofs_compress_one(struct z_erofs_vle_compress_ctx *ctx,
 
 	e->length = min(len, cfg.c_max_decompressed_extent_bytes);
 	ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
-				      &e->length, dst, ctx->pclustersize);
+				      &e->length, dst, ictx->pclustersize);
 	if (ret <= 0) {
 		erofs_err("failed to compress %s: %s", inode->i_srcpath,
 			  erofs_strerror(ret));
@@ -507,16 +570,16 @@ nocompression:
 		e->compressedblks = 1;
 		e->raw = true;
 	} else if (may_packing && len == e->length &&
-		   compressedsize < ctx->pclustersize &&
-		   (!inode->fragment_size || ctx->fix_dedupedfrag)) {
+		   compressedsize < ictx->pclustersize &&
+		   (!inode->fragment_size || ictx->fix_dedupedfrag)) {
 frag_packing:
 		ret = z_erofs_pack_fragments(inode, ctx->queue + ctx->head,
-					     len, ctx->tof_chksum);
+					     len, ictx->tof_chksum);
 		if (ret < 0)
 			return ret;
 		e->compressedblks = 0; /* indicate a fragment */
 		e->raw = false;
-		ctx->fragemitted = true;
+		ictx->fragemitted = true;
 	/* tailpcluster should be less than 1 block */
 	} else if (may_inline && len == e->length && compressedsize < blksz) {
 		if (ctx->clusterofs + len <= blksz) {
@@ -545,8 +608,8 @@ frag_packing:
 		 */
 		if (may_packing && len == e->length &&
 		    (compressedsize & (blksz - 1)) &&
-		    ctx->tail < sizeof(ctx->queue)) {
-			ctx->pclustersize = roundup(compressedsize, blksz);
+		    ctx->tail < Z_EROFS_COMPR_QUEUE_SZ) {
+			ictx->pclustersize = roundup(compressedsize, blksz);
 			goto fix_dedupedfrag;
 		}
 
@@ -569,34 +632,45 @@ frag_packing:
 		}
 
 		/* write compressed data */
-		erofs_dbg("Writing %u compressed data to %u of %u blocks",
-			  e->length, ctx->blkaddr, e->compressedblks);
+		if (ctx->membuf) {
+			erofs_off_t sz = e->compressedblks * blksz;
+			erofs_dbg("Writing %u compressed data to membuf of %u blocks",
+				  e->length, e->compressedblks);
 
-		ret = blk_write(sbi, dst - padding, ctx->blkaddr,
-				e->compressedblks);
-		if (ret)
-			return ret;
+			memcpy(ctx->membuf + ctx->memoff, dst - padding, sz);
+			ctx->memoff += sz;
+		} else {
+			erofs_dbg("Writing %u compressed data to %u of %u blocks",
+				  e->length, ctx->blkaddr, e->compressedblks);
+
+			ret = blk_write(sbi, dst - padding, ctx->blkaddr,
+					e->compressedblks);
+			if (ret)
+				return ret;
+		}
 		e->raw = false;
 		may_inline = false;
 		may_packing = false;
 	}
 	e->partial = false;
 	e->blkaddr = ctx->blkaddr;
+	if (ctx->blkaddr != EROFS_NULL_ADDR)
+		ctx->blkaddr += e->compressedblks;
 	if (!may_inline && !may_packing && !is_packed_inode)
 		(void)z_erofs_dedupe_insert(e, ctx->queue + ctx->head);
-	ctx->blkaddr += e->compressedblks;
 	ctx->head += e->length;
 	return 0;
 
 fix_dedupedfrag:
 	DBG_BUGON(!inode->fragment_size);
 	ctx->remaining += inode->fragment_size;
-	ctx->fix_dedupedfrag = true;
+	ictx->fix_dedupedfrag = true;
 	return 1;
 }
 
-static int z_erofs_compress_one(struct z_erofs_vle_compress_ctx *ctx)
+static int z_erofs_compress_one(struct z_erofs_compress_sctx *ctx)
 {
+	struct z_erofs_compress_ictx *ictx = ctx->ictx;
 	unsigned int len = ctx->tail - ctx->head;
 	struct z_erofs_extent_item *ei;
 
@@ -624,7 +698,7 @@ static int z_erofs_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 
 		len -= ei->e.length;
 		ctx->pivot = ei;
-		if (ctx->fix_dedupedfrag && !ctx->fragemitted &&
+		if (ictx->fix_dedupedfrag && !ictx->fragemitted &&
 		    z_erofs_fixup_deduped_fragment(ctx, len))
 			break;
 
@@ -912,13 +986,268 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 	inode->eof_tailraw = NULL;
 }
 
+int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
+			     u64 offset, erofs_blk_t blkaddr)
+{
+	int fd = ctx->ictx->fd;
+
+	ctx->blkaddr = blkaddr;
+	while (ctx->remaining) {
+		const u64 rx = min_t(u64, ctx->remaining,
+				     Z_EROFS_COMPR_QUEUE_SZ - ctx->tail);
+		int ret;
+
+		ret = (offset == -1 ?
+			read(fd, ctx->queue + ctx->tail, rx) :
+			pread(fd, ctx->queue + ctx->tail, rx, offset));
+		if (ret != rx)
+			return -errno;
+
+		ctx->remaining -= rx;
+		ctx->tail += rx;
+		if (offset != -1)
+			offset += rx;
+
+		ret = z_erofs_compress_one(ctx);
+		if (ret)
+			return ret;
+	}
+	DBG_BUGON(ctx->head != ctx->tail);
+
+	if (ctx->pivot) {
+		z_erofs_commit_extent(ctx, ctx->pivot);
+		ctx->pivot = NULL;
+	}
+	return 0;
+}
+
+#ifdef EROFS_MT_ENABLED
+void *z_erofs_mt_wq_tls_alloc(struct erofs_workqueue *wq, void *ptr)
+{
+	struct erofs_compress_wq_tls *tls;
+
+	tls = calloc(1, sizeof(*tls));
+	if (!tls)
+		return NULL;
+
+	tls->queue = malloc(Z_EROFS_COMPR_QUEUE_SZ);
+	if (!tls->queue)
+		goto err_free_priv;
+
+	tls->destbuf = calloc(1, EROFS_CONFIG_COMPR_MAX_SZ +
+			      EROFS_MAX_BLOCK_SIZE);
+	if (!tls->destbuf)
+		goto err_free_queue;
+
+	tls->ccfg = calloc(EROFS_MAX_COMPR_CFGS, sizeof(*tls->ccfg));
+	if (!tls->ccfg)
+		goto err_free_destbuf;
+	return tls;
+
+err_free_destbuf:
+	free(tls->destbuf);
+err_free_queue:
+	free(tls->queue);
+err_free_priv:
+	free(tls);
+	return NULL;
+}
+
+int z_erofs_mt_wq_tls_init_compr(struct erofs_sb_info *sbi,
+				 struct erofs_compress_wq_tls *tls,
+				 unsigned int alg_id, char *alg_name,
+				 unsigned int comp_level,
+				 unsigned int dict_size)
+{
+	struct erofs_compress_cfg *lc = &tls->ccfg[alg_id];
+	int ret;
+
+	if (likely(lc->enable))
+		return 0;
+
+	ret = erofs_compressor_init(sbi, &lc->handle, alg_name,
+				    comp_level, dict_size);
+	if (ret)
+		return ret;
+	lc->algorithmtype = alg_id;
+	lc->enable = true;
+	return 0;
+}
+
+void *z_erofs_mt_wq_tls_free(struct erofs_workqueue *wq, void *priv)
+{
+	struct erofs_compress_wq_tls *tls = priv;
+	int i;
+
+	for (i = 0; i < EROFS_MAX_COMPR_CFGS; i++)
+		if (tls->ccfg[i].enable)
+			erofs_compressor_exit(&tls->ccfg[i].handle);
+
+	free(tls->ccfg);
+	free(tls->destbuf);
+	free(tls->queue);
+	free(tls);
+	return NULL;
+}
+
+void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
+{
+	struct erofs_compress_work *cwork = (struct erofs_compress_work *)work;
+	struct erofs_compress_wq_tls *tls = tlsp;
+	struct z_erofs_compress_sctx *ctx = &cwork->ctx;
+	u64 offset = ctx->seg_idx * cfg.c_segment_size;
+	int ret = 0;
+
+	ret = z_erofs_mt_wq_tls_init_compr(ctx->ictx->inode->sbi, tls,
+					   cwork->alg_id, cwork->alg_name,
+					   cwork->comp_level,
+					   cwork->dict_size);
+	if (ret)
+		goto out;
+
+	ctx->queue = tls->queue;
+	ctx->destbuf = tls->destbuf;
+	ctx->chandle = &tls->ccfg[cwork->alg_id].handle;
+
+	ctx->membuf = malloc(ctx->remaining);
+	if (!ctx->membuf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	ctx->memoff = 0;
+
+	ret = z_erofs_compress_segment(ctx, offset, EROFS_NULL_ADDR);
+
+out:
+	cwork->errcode = ret;
+	pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
+	++z_erofs_mt_ctrl.nfini;
+	pthread_cond_signal(&z_erofs_mt_ctrl.cond);
+	pthread_mutex_unlock(&z_erofs_mt_ctrl.mutex);
+}
+
+int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
+			  struct z_erofs_compress_sctx *ctx)
+{
+	struct z_erofs_extent_item *ei, *n;
+	struct erofs_sb_info *sbi = ictx->inode->sbi;
+	erofs_blk_t blkoff = 0;
+	int ret = 0, ret2;
+
+	list_for_each_entry_safe(ei, n, &ctx->extents, list) {
+		list_del(&ei->list);
+		list_add_tail(&ei->list, &ictx->extents);
+
+		if (ei->e.blkaddr != EROFS_NULL_ADDR)	/* deduped extents */
+			continue;
+
+		ei->e.blkaddr = ctx->blkaddr;
+		ctx->blkaddr += ei->e.compressedblks;
+
+		ret2 = blk_write(sbi, ctx->membuf + blkoff * erofs_blksiz(sbi),
+				 ei->e.blkaddr, ei->e.compressedblks);
+		blkoff += ei->e.compressedblks;
+		if (ret2) {
+			ret = ret2;
+			continue;
+		}
+	}
+	free(ctx->membuf);
+	return ret;
+}
+
+int z_erofs_mt_compress(struct z_erofs_compress_ictx *ctx,
+			struct erofs_compress_cfg *ccfg,
+			erofs_blk_t blkaddr,
+			erofs_blk_t *compressed_blocks)
+{
+	struct erofs_compress_work *cur, *head = NULL, **last = &head;
+	struct erofs_inode *inode = ctx->inode;
+	int nsegs = DIV_ROUND_UP(inode->i_size, cfg.c_segment_size);
+	int ret, i;
+
+	z_erofs_mt_ctrl.nfini = 0;
+
+	for (i = 0; i < nsegs; i++) {
+		if (z_erofs_mt_ctrl.idle) {
+			cur = z_erofs_mt_ctrl.idle;
+			z_erofs_mt_ctrl.idle = cur->next;
+			cur->next = NULL;
+		} else {
+			cur = calloc(1, sizeof(*cur));
+			if (!cur)
+				return -ENOMEM;
+		}
+		*last = cur;
+		last = &cur->next;
+
+		cur->ctx = (struct z_erofs_compress_sctx) {
+			.ictx = ctx,
+			.seg_num = nsegs,
+			.seg_idx = i,
+			.pivot = &dummy_pivot,
+		};
+		init_list_head(&cur->ctx.extents);
+
+		if (i == nsegs - 1)
+			cur->ctx.remaining = inode->i_size -
+					      inode->fragment_size -
+					      i * cfg.c_segment_size;
+		else
+			cur->ctx.remaining = cfg.c_segment_size;
+
+		cur->alg_id = ccfg->handle.alg->id;
+		cur->alg_name = ccfg->handle.alg->name;
+		cur->comp_level = ccfg->handle.compression_level;
+		cur->dict_size = ccfg->handle.dict_size;
+
+		cur->work.fn = z_erofs_mt_workfn;
+		erofs_queue_work(&z_erofs_mt_ctrl.wq, &cur->work);
+	}
+
+	pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
+	while (z_erofs_mt_ctrl.nfini != nsegs)
+		pthread_cond_wait(&z_erofs_mt_ctrl.cond,
+				  &z_erofs_mt_ctrl.mutex);
+	pthread_mutex_unlock(&z_erofs_mt_ctrl.mutex);
+
+	ret = 0;
+	while (head) {
+		cur = head;
+		head = cur->next;
+
+		if (cur->errcode) {
+			ret = cur->errcode;
+		} else {
+			int ret2;
+
+			cur->ctx.blkaddr = blkaddr;
+			ret2 = z_erofs_merge_segment(ctx, &cur->ctx);
+			if (ret2)
+				ret = ret2;
+
+			*compressed_blocks += cur->ctx.blkaddr - blkaddr;
+			blkaddr = cur->ctx.blkaddr;
+		}
+
+		cur->next = z_erofs_mt_ctrl.idle;
+		z_erofs_mt_ctrl.idle = cur;
+	}
+	return ret;
+}
+#endif
+
 int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 {
+	static u8 g_queue[Z_EROFS_COMPR_QUEUE_SZ];
 	struct erofs_buffer_head *bh;
-	static struct z_erofs_vle_compress_ctx ctx;
-	erofs_blk_t blkaddr, compressed_blocks;
+	static struct z_erofs_compress_ictx ctx;
+	static struct z_erofs_compress_sctx sctx;
+	struct erofs_compress_cfg *ccfg;
+	erofs_blk_t blkaddr, compressed_blocks = 0;
 	unsigned int legacymetasize;
 	int ret;
+	bool ismt = false;
 	struct erofs_sb_info *sbi = inode->sbi;
 	u8 *compressmeta = malloc(BLK_ROUND_UP(sbi, inode->i_size) *
 				  sizeof(struct z_erofs_lcluster_index) +
@@ -963,8 +1292,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 		}
 	}
 #endif
-	ctx.ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
-	inode->z_algorithmtype[0] = ctx.ccfg[0].algorithmtype;
+	ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
+	inode->z_algorithmtype[0] = ccfg[0].algorithmtype;
 	inode->z_algorithmtype[1] = 0;
 
 	inode->idata_size = 0;
@@ -983,50 +1312,45 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.inode = inode;
 	ctx.pclustersize = z_erofs_get_max_pclustersize(inode);
-	ctx.blkaddr = blkaddr;
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
-	ctx.head = ctx.tail = 0;
-	ctx.clusterofs = 0;
-	ctx.pivot = &dummy_pivot;
 	init_list_head(&ctx.extents);
-	ctx.remaining = inode->i_size - inode->fragment_size;
+	ctx.fd = fd;
 	ctx.fix_dedupedfrag = false;
 	ctx.fragemitted = false;
+	sctx = (struct z_erofs_compress_sctx) { .ictx = &ctx, };
+	init_list_head(&sctx.extents);
+
 	if (cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
 	    !inode->fragment_size) {
 		ret = z_erofs_pack_file_from_fd(inode, fd, ctx.tof_chksum);
 		if (ret)
 			goto err_free_idata;
+#ifdef EROFS_MT_ENABLED
+	} else if (z_erofs_mt_enabled && inode->i_size > cfg.c_segment_size) {
+		ismt = true;
+		ret = z_erofs_mt_compress(&ctx, ccfg, blkaddr, &compressed_blocks);
+		if (ret)
+			goto err_free_idata;
+#endif
 	} else {
-		while (ctx.remaining) {
-			const u64 rx = min_t(u64, ctx.remaining,
-					     sizeof(ctx.queue) - ctx.tail);
-
-			ret = read(fd, ctx.queue + ctx.tail, rx);
-			if (ret != rx) {
-				ret = -errno;
-				goto err_bdrop;
-			}
-			ctx.remaining -= rx;
-			ctx.tail += rx;
-
-			ret = z_erofs_compress_one(&ctx);
-			if (ret)
-				goto err_free_idata;
-		}
+		sctx.queue = g_queue;
+		sctx.destbuf = NULL;
+		sctx.chandle = &ccfg->handle;
+		sctx.remaining = inode->i_size - inode->fragment_size;
+		sctx.seg_num = 1;
+		sctx.seg_idx = 0;
+		sctx.pivot = &dummy_pivot;
+
+		ret = z_erofs_compress_segment(&sctx, -1, blkaddr);
+		if (ret)
+			goto err_free_idata;
+		compressed_blocks = sctx.blkaddr - blkaddr;
 	}
-	DBG_BUGON(ctx.head != ctx.tail);
 
 	/* fall back to no compression mode */
-	compressed_blocks = ctx.blkaddr - blkaddr;
 	DBG_BUGON(compressed_blocks < !!inode->idata_size);
 	compressed_blocks -= !!inode->idata_size;
 
-	if (ctx.pivot) {
-		z_erofs_commit_extent(&ctx, ctx.pivot);
-		ctx.pivot = NULL;
-	}
-
 	/* generate an extent for the deduplicated fragment */
 	if (inode->fragment_size && !ctx.fragemitted) {
 		struct z_erofs_extent_item *ei;
@@ -1042,13 +1366,16 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 			.compressedblks = 0,
 			.raw = false,
 			.partial = false,
-			.blkaddr = ctx.blkaddr,
+			.blkaddr = sctx.blkaddr,
 		};
 		init_list_head(&ei->list);
-		z_erofs_commit_extent(&ctx, ei);
+		z_erofs_commit_extent(&sctx, ei);
 	}
 	z_erofs_fragments_commit(inode);
 
+	if (!ismt)
+		list_splice_tail(&sctx.extents, &ctx.extents);
+
 	z_erofs_write_indexes(&ctx);
 	legacymetasize = ctx.metacur - compressmeta;
 	/* estimate if data compression saves space or not */
@@ -1257,8 +1584,25 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 		return -EINVAL;
 	}
 
-	if (erofs_sb_has_compr_cfgs(sbi))
-		return z_erofs_build_compr_cfgs(sbi, sb_bh, max_dict_size);
+	if (erofs_sb_has_compr_cfgs(sbi)) {
+		ret = z_erofs_build_compr_cfgs(sbi, sb_bh, max_dict_size);
+		if (ret)
+			return ret;
+	}
+
+	z_erofs_mt_enabled = false;
+#ifdef EROFS_MT_ENABLED
+	if (cfg.c_mt_workers > 1) {
+		pthread_mutex_init(&z_erofs_mt_ctrl.mutex, NULL);
+		pthread_cond_init(&z_erofs_mt_ctrl.cond, NULL);
+		ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq,
+					    cfg.c_mt_workers,
+					    cfg.c_mt_workers << 2,
+					    z_erofs_mt_wq_tls_alloc,
+					    z_erofs_mt_wq_tls_free);
+		z_erofs_mt_enabled = !ret;
+	}
+#endif
 	return 0;
 }
 
@@ -1271,5 +1615,19 @@ int z_erofs_compress_exit(void)
 		if (ret)
 			return ret;
 	}
+
+	if (z_erofs_mt_enabled) {
+#ifdef EROFS_MT_ENABLED
+		ret = erofs_destroy_workqueue(&z_erofs_mt_ctrl.wq);
+		if (ret)
+			return ret;
+		while (z_erofs_mt_ctrl.idle) {
+			struct erofs_compress_work *tmp =
+				z_erofs_mt_ctrl.idle->next;
+			free(z_erofs_mt_ctrl.idle);
+			z_erofs_mt_ctrl.idle = tmp;
+		}
+#endif
+	}
 	return 0;
 }
diff --git a/lib/compressor.c b/lib/compressor.c
index 58eae2a..175259e 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -86,6 +86,8 @@ int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
 
 	/* should be written in "minimum compression ratio * 100" */
 	c->compress_threshold = 100;
+	c->compression_level = -1;
+	c->dict_size = 0;
 
 	if (!alg_name) {
 		c->alg = NULL;
diff --git a/mkfs/main.c b/mkfs/main.c
index 126a049..5dbaf9f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -678,7 +678,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 
 			processors = erofs_get_available_processors();
 			if (cfg.c_mt_workers > processors)
-				erofs_warn("the number of workers %d is more than the number of processors %d, performance may be impacted.",
+				erofs_warn("%d workers exceed %d processors, potentially impacting performance.",
 					   cfg.c_mt_workers, processors);
 			break;
 		}
@@ -838,6 +838,12 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		}
 		cfg.c_pclusterblks_packed = pclustersize_packed >> sbi.blkszbits;
 	}
+#ifdef EROFS_MT_ENABLED
+	if (cfg.c_mt_workers > 1 && (cfg.c_dedupe || cfg.c_fragments)) {
+		erofs_warn("Note that dedupe/fragments are NOT supported in multi-threaded mode for now, reseting --workers=1.");
+		cfg.c_mt_workers = 1;
+	}
+#endif
 	return 0;
 }
 
-- 
2.39.3

