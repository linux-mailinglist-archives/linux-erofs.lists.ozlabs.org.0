Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0C986B48F
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Feb 2024 17:18:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TlKJz371gz3d24
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 03:18:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TlKJw2St3z3bsQ
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Feb 2024 03:18:08 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 229191008EE00;
	Thu, 29 Feb 2024 00:17:06 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 4A6A937C969;
	Thu, 29 Feb 2024 00:17:04 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH v4 5/5] erofs-utils: mkfs: introduce inner-file multi-threaded compression
Date: Thu, 29 Feb 2024 00:16:52 +0800
Message-ID: <20240228161652.1010997-6-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240228161652.1010997-1-zhaoyifan@sjtu.edu.cn>
References: <20240228161652.1010997-1-zhaoyifan@sjtu.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

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
---
 include/erofs/compress.h |   1 +
 lib/compress.c           | 703 ++++++++++++++++++++++++++++++++-------
 lib/compressor.c         |   2 +
 3 files changed, 580 insertions(+), 126 deletions(-)

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 046640b..2699334 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -15,6 +15,7 @@ extern "C"
 #include "internal.h"
 
 #define EROFS_CONFIG_COMPR_MAX_SZ           (4000 * 1024)
+#define EROFS_COMPR_QUEUE_SZ (EROFS_CONFIG_COMPR_MAX_SZ * 2)
 
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
 int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
diff --git a/lib/compress.c b/lib/compress.c
index 9611102..f586117 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -8,6 +8,9 @@
 #ifndef _LARGEFILE64_SOURCE
 #define _LARGEFILE64_SOURCE
 #endif
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -20,6 +23,12 @@
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
 #include "erofs/fragments.h"
+#ifdef EROFS_MT_ENABLED
+#include "erofs/workqueue.h"
+#endif
+#ifdef HAVE_LINUX_FALLOC_H
+#include <linux/falloc.h>
+#endif
 
 /* compressing configuration specified by users */
 struct erofs_compress_cfg {
@@ -33,29 +42,81 @@ struct z_erofs_extent_item {
 	struct z_erofs_inmem_extent e;
 };
 
-struct z_erofs_vle_compress_ctx {
-	u8 queue[EROFS_CONFIG_COMPR_MAX_SZ * 2];
+struct z_erofs_compressed_inode_ctx {
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
+	struct list_head *extents;
+	u16 clusterofs;
+};
+
+struct z_erofs_compressed_segment_ctx {
+	struct z_erofs_compressed_inode_ctx *ictx;
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
+	erofs_blk_t compressed_blocks;
 	u16 clusterofs;
 
-	u32 tof_chksum;
-	bool fix_dedupedfrag;
-	bool fragemitted;
+	int seg_num, seg_idx;
+	FILE *tmpfile;
+	off_t tmpfile_off;
+};
+
+#ifdef EROFS_MT_ENABLED
+struct erofs_compress_wq_private {
+	bool init;
+	u8 *queue;
+	char *destbuf;
+	struct erofs_compress_cfg *ccfg;
+	FILE* tmpfile;
+};
+
+struct erofs_compress_work {
+	/* Note: struct erofs_work must be the first member */
+	struct erofs_work work;
+	struct z_erofs_compressed_segment_ctx ctx;
+
+	unsigned int alg_id;
+	char *alg_name;
+	unsigned int comp_level;
+	unsigned int dict_size;
+
+	int ret;
+
+	struct erofs_compress_work *next;
 };
 
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
+static u8 *z_erofs_global_queue;
+
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	Z_EROFS_FULL_INDEX_ALIGN(0)
 
-static void z_erofs_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
+static void z_erofs_write_indexes_final(struct z_erofs_compressed_inode_ctx *ctx)
 {
 	const unsigned int type = Z_EROFS_LCLUSTER_TYPE_PLAIN;
 	struct z_erofs_lcluster_index di;
@@ -71,7 +132,7 @@ static void z_erofs_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
 	ctx->metacur += sizeof(di);
 }
 
-static void z_erofs_write_extent(struct z_erofs_vle_compress_ctx *ctx,
+static void z_erofs_write_extent(struct z_erofs_compressed_inode_ctx *ctx,
 				 struct z_erofs_inmem_extent *e)
 {
 	struct erofs_inode *inode = ctx->inode;
@@ -170,12 +231,12 @@ static void z_erofs_write_extent(struct z_erofs_vle_compress_ctx *ctx,
 	ctx->clusterofs = clusterofs + count;
 }
 
-static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
+static void z_erofs_write_indexes(struct z_erofs_compressed_inode_ctx *ctx)
 {
 	struct z_erofs_extent_item *ei, *n;
 
 	ctx->clusterofs = 0;
-	list_for_each_entry_safe(ei, n, &ctx->extents, list) {
+	list_for_each_entry_safe(ei, n, ctx->extents, list) {
 		z_erofs_write_extent(ctx, &ei->e);
 
 		list_del(&ei->list);
@@ -184,15 +245,16 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 	z_erofs_write_indexes_final(ctx);
 }
 
-static bool z_erofs_need_refill(struct z_erofs_vle_compress_ctx *ctx)
+static bool z_erofs_need_refill(struct z_erofs_compressed_segment_ctx *ctx)
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
@@ -204,7 +266,7 @@ static struct z_erofs_extent_item dummy_pivot = {
 	.e.length = 0
 };
 
-static void z_erofs_commit_extent(struct z_erofs_vle_compress_ctx *ctx,
+static void z_erofs_commit_extent(struct z_erofs_compressed_segment_ctx *ctx,
 				  struct z_erofs_extent_item *ei)
 {
 	if (ei == &dummy_pivot)
@@ -212,14 +274,13 @@ static void z_erofs_commit_extent(struct z_erofs_vle_compress_ctx *ctx,
 
 	list_add_tail(&ei->list, &ctx->extents);
 	ctx->clusterofs = (ctx->clusterofs + ei->e.length) &
-			(erofs_blksiz(ctx->inode->sbi) - 1);
-
+			  (erofs_blksiz(ctx->ictx->inode->sbi) - 1);
 }
 
-static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
+static int z_erofs_compress_dedupe(struct z_erofs_compressed_segment_ctx *ctx,
 				   unsigned int *len)
 {
-	struct erofs_inode *inode = ctx->inode;
+	struct erofs_inode *inode = ctx->ictx->inode;
 	const unsigned int lclustermask = (1 << inode->z_logical_clusterbits) - 1;
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct z_erofs_extent_item *ei = ctx->pivot;
@@ -315,16 +376,17 @@ out:
 	return 0;
 }
 
-static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
+static int write_uncompressed_extent(struct z_erofs_compressed_segment_ctx *ctx,
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
@@ -335,11 +397,19 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 	memcpy(dst + interlaced_offset, ctx->queue + ctx->head, rightpart);
 	memcpy(dst, ctx->queue + ctx->head + rightpart, count - rightpart);
 
-	erofs_dbg("Writing %u uncompressed data to block %u",
-		  count, ctx->blkaddr);
-	ret = blk_write(sbi, dst, ctx->blkaddr, 1);
-	if (ret)
-		return ret;
+	if (ctx->tmpfile) {
+		erofs_dbg("Writing %u uncompressed data to tmpfile", count);
+		ret = fwrite(dst, erofs_blksiz(sbi), 1, ctx->tmpfile);
+		if (ret != 1)
+			return -EIO;
+		fflush(ctx->tmpfile);
+	} else {
+		erofs_dbg("Writing %u uncompressed data to block %u", count,
+			  ctx->blkaddr);
+		ret = blk_write(sbi, dst, ctx->blkaddr, 1);
+		if (ret)
+			return ret;
+	}
 	return count;
 }
 
@@ -379,12 +449,12 @@ static int z_erofs_fill_inline_data(struct erofs_inode *inode, void *data,
 	return len;
 }
 
-static void tryrecompress_trailing(struct z_erofs_vle_compress_ctx *ctx,
-				   struct erofs_compress *ec,
-				   void *in, unsigned int *insize,
-				   void *out, unsigned int *compressedsize)
+static void tryrecompress_trailing(struct z_erofs_compressed_segment_ctx *ctx,
+				   struct erofs_compress *ec, void *in,
+				   unsigned int *insize, void *out,
+				   unsigned int *compressedsize)
 {
-	struct erofs_sb_info *sbi = ctx->inode->sbi;
+	struct erofs_sb_info *sbi = ctx->ictx->inode->sbi;
 	static char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
 	unsigned int count;
 	int ret = *compressedsize;
@@ -406,10 +476,10 @@ static void tryrecompress_trailing(struct z_erofs_vle_compress_ctx *ctx,
 	*compressedsize = ret;
 }
 
-static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
+static bool z_erofs_fixup_deduped_fragment(struct z_erofs_compressed_segment_ctx *ctx,
 					   unsigned int len)
 {
-	struct erofs_inode *inode = ctx->inode;
+	struct erofs_inode *inode = ctx->ictx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
 	const unsigned int newsize = ctx->remaining + len;
 
@@ -417,9 +487,10 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
 
 	/* try to fix again if it gets larger (should be rare) */
 	if (inode->fragment_size < newsize) {
-		ctx->pclustersize = min_t(erofs_off_t, z_erofs_get_max_pclustersize(inode),
-					  roundup(newsize - inode->fragment_size,
-						  erofs_blksiz(sbi)));
+		ctx->ictx->pclustersize =
+			min_t(erofs_off_t, z_erofs_get_max_pclustersize(inode),
+			      roundup(newsize - inode->fragment_size,
+				      erofs_blksiz(sbi)));
 		return false;
 	}
 
@@ -436,29 +507,34 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
 	return true;
 }
 
-static int __z_erofs_compress_one(struct z_erofs_vle_compress_ctx *ctx,
+static int __z_erofs_compress_one(struct z_erofs_compressed_segment_ctx *ctx,
 				  struct z_erofs_inmem_extent *e)
 {
-	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_MAX_BLOCK_SIZE];
-	struct erofs_inode *inode = ctx->inode;
+	static char
+		global_dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_MAX_BLOCK_SIZE];
+	char *dstbuf = ctx->destbuf ?: global_dstbuf;
+	struct z_erofs_compressed_inode_ctx *ictx = ctx->ictx;
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
-	bool may_inline = (cfg.c_ztailpacking && final && !may_packing);
+	bool may_packing = (cfg.c_fragments && final && !is_packed_inode &&
+			    !z_erofs_mt_enabled);
+	bool may_inline = (cfg.c_ztailpacking && final && !may_packing &&
+			   !z_erofs_mt_enabled);
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
@@ -470,7 +546,7 @@ static int __z_erofs_compress_one(struct z_erofs_vle_compress_ctx *ctx,
 
 	e->length = min(len, cfg.c_max_decompressed_extent_bytes);
 	ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
-				      &e->length, dst, ctx->pclustersize);
+				      &e->length, dst, ictx->pclustersize);
 	if (ret <= 0) {
 		erofs_err("failed to compress %s: %s", inode->i_srcpath,
 			  erofs_strerror(ret));
@@ -507,16 +583,16 @@ nocompression:
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
@@ -545,8 +621,8 @@ frag_packing:
 		 */
 		if (may_packing && len == e->length &&
 		    (compressedsize & (blksz - 1)) &&
-		    ctx->tail < sizeof(ctx->queue)) {
-			ctx->pclustersize = roundup(compressedsize, blksz);
+		    ctx->tail < EROFS_COMPR_QUEUE_SZ) {
+			ictx->pclustersize = roundup(compressedsize, blksz);
 			goto fix_dedupedfrag;
 		}
 
@@ -569,13 +645,24 @@ frag_packing:
 		}
 
 		/* write compressed data */
-		erofs_dbg("Writing %u compressed data to %u of %u blocks",
-			  e->length, ctx->blkaddr, e->compressedblks);
+		if (ctx->tmpfile) {
+			erofs_dbg("Writing %u compressed data to tmpfile of %u blocks",
+				  e->length, e->compressedblks);
+
+			ret = fwrite(dst - padding, erofs_blksiz(sbi),
+				     e->compressedblks, ctx->tmpfile);
+			if (ret != e->compressedblks)
+				return -EIO;
+			fflush(ctx->tmpfile);
+		} else {
+			erofs_dbg("Writing %u compressed data to %u of %u blocks",
+				  e->length, ctx->blkaddr, e->compressedblks);
 
-		ret = blk_write(sbi, dst - padding, ctx->blkaddr,
-				e->compressedblks);
-		if (ret)
-			return ret;
+			ret = blk_write(sbi, dst - padding, ctx->blkaddr,
+					e->compressedblks);
+			if (ret)
+				return ret;
+		}
 		e->raw = false;
 		may_inline = false;
 		may_packing = false;
@@ -591,14 +678,15 @@ frag_packing:
 fix_dedupedfrag:
 	DBG_BUGON(!inode->fragment_size);
 	ctx->remaining += inode->fragment_size;
-	ctx->fix_dedupedfrag = true;
+	ictx->fix_dedupedfrag = true;
 	return 1;
 }
 
-static int z_erofs_compress_one(struct z_erofs_vle_compress_ctx *ctx)
+static int z_erofs_compress_one(struct z_erofs_compressed_segment_ctx *ctx)
 {
 	unsigned int len = ctx->tail - ctx->head;
 	struct z_erofs_extent_item *ei;
+	struct z_erofs_compressed_inode_ctx *ictx = ctx->ictx;
 
 	while (len) {
 		int ret = z_erofs_compress_dedupe(ctx, &len);
@@ -624,7 +712,7 @@ static int z_erofs_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 
 		len -= ei->e.length;
 		ctx->pivot = ei;
-		if (ctx->fix_dedupedfrag && !ctx->fragemitted &&
+		if (ictx->fix_dedupedfrag && !ictx->fragemitted &&
 		    z_erofs_fixup_deduped_fragment(ctx, len))
 			break;
 
@@ -912,11 +1000,328 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 	inode->eof_tailraw = NULL;
 }
 
+int z_erofs_compress_file(struct z_erofs_compressed_segment_ctx *ctx,
+			  u64 offset, erofs_blk_t blkaddr)
+{
+	struct z_erofs_compressed_inode_ctx *ictx = ctx->ictx;
+	struct erofs_inode *inode = ictx->inode;
+	int ret = 0;
+
+	while (ctx->remaining) {
+		const u64 rx = min_t(u64, ctx->remaining,
+				     EROFS_COMPR_QUEUE_SZ - ctx->tail);
+
+		ret = pread(ictx->fd, ctx->queue + ctx->tail, rx, offset);
+		if (ret != rx)
+			return -errno;
+		ctx->remaining -= rx;
+		ctx->tail += rx;
+		offset += rx;
+
+		ret = z_erofs_compress_one(ctx);
+		if (ret)
+			return ret;
+	}
+	DBG_BUGON(ctx->head != ctx->tail);
+
+	ctx->compressed_blocks = ctx->blkaddr - blkaddr;
+	DBG_BUGON(ctx->compressed_blocks < !!inode->idata_size);
+	ctx->compressed_blocks -= !!inode->idata_size;
+
+	if (ctx->pivot) {
+		z_erofs_commit_extent(ctx, ctx->pivot);
+		ctx->pivot = NULL;
+	}
+
+	return 0;
+}
+
+#ifdef EROFS_MT_ENABLED
+#if defined(HAVE_FALLOCATE) && defined(FALLOC_FL_PUNCH_HOLE)
+#define USE_PER_WORKER_TMPFILE 1
+#endif
+
+int z_erofs_mt_private_init(struct erofs_sb_info *sbi,
+			    struct erofs_compress_wq_private *priv,
+			    unsigned int alg_id, char *alg_name,
+			    unsigned int comp_level, unsigned int dict_size)
+{
+	struct erofs_compress_cfg *lc;
+	int ret;
+
+	if (unlikely(!priv->init)) {
+		priv->init = true;
+
+		priv->queue = malloc(EROFS_COMPR_QUEUE_SZ);
+		if (!priv->queue)
+			return -ENOMEM;
+
+		priv->destbuf = calloc(1, EROFS_CONFIG_COMPR_MAX_SZ +
+						  EROFS_MAX_BLOCK_SIZE);
+		if (!priv->destbuf)
+			return -ENOMEM;
+
+		priv->ccfg = calloc(EROFS_MAX_COMPR_CFGS,
+				    sizeof(struct erofs_compress_cfg));
+		if (!priv->ccfg)
+			return -ENOMEM;
+#ifdef USE_PER_WORKER_TMPFILE
+#ifndef HAVE_TMPFILE64
+		priv->tmpfile = tmpfile();
+#else
+		priv->tmpfile = tmpfile64();
+#endif
+		if (!priv->tmpfile)
+			return -errno;
+#endif
+	}
+
+	lc = &priv->ccfg[alg_id];
+	if (!lc->enable) {
+		lc->enable = true;
+		lc->algorithmtype = alg_id;
+
+		ret = erofs_compressor_init(sbi, &lc->handle, alg_name,
+					    comp_level, dict_size);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+void z_erofs_mt_private_fini(void *private)
+{
+	struct erofs_compress_wq_private *priv = private;
+	int i;
+
+	if (priv->init) {
+		for (i = 0; i < EROFS_MAX_COMPR_CFGS; i++) {
+			if (priv->ccfg[i].enable)
+				erofs_compressor_exit(&priv->ccfg[i].handle);
+		}
+		free(priv->ccfg);
+		free(priv->destbuf);
+		free(priv->queue);
+#ifdef USE_PER_WORKER_TMPFILE
+		fclose(priv->tmpfile);
+#endif
+		priv->init = false;
+	}
+}
+
+void z_erofs_mt_work(struct erofs_work *work)
+{
+	struct erofs_compress_work *cwork = (struct erofs_compress_work *)work;
+	struct z_erofs_compressed_segment_ctx *ctx = &cwork->ctx;
+	struct erofs_compress_wq_private *priv = work->priv;
+	erofs_blk_t blkaddr = ctx->blkaddr;
+	u64 offset = ctx->seg_idx * cfg.c_segment_size;
+	int ret = 0;
+
+	ret = z_erofs_mt_private_init(ctx->ictx->inode->sbi, priv,
+				      cwork->alg_id, cwork->alg_name,
+				      cwork->comp_level, cwork->dict_size);
+	if (ret)
+		goto out;
+
+	ctx->queue = priv->queue;
+	ctx->destbuf = priv->destbuf;
+	ctx->chandle = &priv->ccfg[cwork->alg_id].handle;
+#ifdef USE_PER_WORKER_TMPFILE
+	ctx->tmpfile = priv->tmpfile;
+	ctx->tmpfile_off = ftell(ctx->tmpfile);
+	if (ctx->tmpfile_off == -1) {
+		ret = -errno;
+		goto out;
+	}
+#else
+#ifdef HAVE_TMPFILE64
+	ctx->tmpfile = tmpfile64();
+#else
+	ctx->tmpfile = tmpfile();
+#endif
+	if (!ctx->tmpfile) {
+		ret = -errno;
+		goto out;
+	}
+	ctx->tmpfile_off = 0;
+#endif
+
+	ret = z_erofs_compress_file(ctx, offset, blkaddr);
+	if (ret)
+		goto out;
+
+	fflush(ctx->tmpfile);
+
+out:
+	cwork->ret = ret;
+	pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
+	++z_erofs_mt_ctrl.nfini;
+	pthread_cond_signal(&z_erofs_mt_ctrl.cond);
+	pthread_mutex_unlock(&z_erofs_mt_ctrl.mutex);
+}
+
+int z_erofs_mt_merge(struct erofs_compress_work *cur, erofs_blk_t blkaddr,
+		     erofs_blk_t *compressed_blocks)
+{
+	struct z_erofs_compressed_segment_ctx *ctx, *listhead = NULL;
+	struct erofs_sb_info *sbi = cur->ctx.ictx->inode->sbi;
+	struct erofs_compress_work *tmp;
+	char *memblock = NULL;
+	size_t size = 0;
+	int ret = 0, lret;
+
+	while (cur != NULL) {
+		ctx = &cur->ctx;
+
+		if (!listhead)
+			listhead = ctx;
+		else
+			list_splice_tail(&ctx->extents, &listhead->extents);
+
+		if (cur->ret != 0) {
+			if (!ret)
+				ret = cur->ret;
+			goto out;
+		}
+
+		size = ctx->compressed_blocks * erofs_blksiz(sbi);
+		memblock = realloc(memblock, size);
+		if (!memblock) {
+			if (!ret)
+				ret = -ENOMEM;
+			goto out;
+		}
+
+		lret = pread(fileno(ctx->tmpfile), memblock, size,
+			     ctx->tmpfile_off);
+		if (lret != size) {
+			if (!ret)
+				ret = errno ? -errno : -EIO;
+			goto out;
+		}
+
+#ifdef USE_PER_WORKER_TMPFILE
+		lret = fallocate(fileno(ctx->tmpfile),
+				 FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				 ctx->tmpfile_off, size);
+		if (lret) {
+			if (!ret)
+				ret = -errno;
+			goto out;
+		}
+#endif
+
+		lret = blk_write(sbi, memblock, blkaddr + *compressed_blocks,
+				 ctx->compressed_blocks);
+		if (lret) {
+			if (!ret)
+				ret = lret;
+			goto out;
+		}
+		*compressed_blocks += ctx->compressed_blocks;
+
+out:
+#ifndef USE_PER_WORKER_TMPFILE
+		fclose(ctx->tmpfile);
+#endif
+		tmp = cur->next;
+		cur->next = z_erofs_mt_ctrl.idle;
+		z_erofs_mt_ctrl.idle = cur;
+		cur = tmp;
+	}
+
+	free(memblock);
+
+	return ret;
+}
+
+void z_erofs_mt_fix_index(struct z_erofs_compressed_inode_ctx *ctx,
+			  erofs_blk_t blkaddr)
+{
+	struct z_erofs_extent_item *ei;
+	erofs_blk_t blkoff = 0;
+
+	list_for_each_entry(ei, ctx->extents, list) {
+		ei->e.blkaddr = blkaddr + blkoff;
+		blkoff += ei->e.compressedblks;
+	}
+}
+
+int z_erofs_mt_compress(struct z_erofs_compressed_segment_ctx *ctx,
+			struct erofs_compress_cfg *ccfg,
+			erofs_blk_t *compressed_blocks)
+{
+	struct erofs_compress_work *work, *head = NULL, **last = &head;
+	struct z_erofs_compressed_inode_ctx *ictx = ctx->ictx;
+	struct erofs_inode *inode = ictx->inode;
+	erofs_blk_t blkaddr = ctx->blkaddr;
+	int nsegs = DIV_ROUND_UP(inode->i_size, cfg.c_segment_size);
+	int ret;
+
+	z_erofs_mt_ctrl.nfini = 0;
+
+	for (int i = 0; i < nsegs; i++) {
+		if (z_erofs_mt_ctrl.idle) {
+			work = z_erofs_mt_ctrl.idle;
+			z_erofs_mt_ctrl.idle = work->next;
+			work->next = NULL;
+		} else {
+			work = calloc(1, sizeof(*work));
+			if (!work)
+				return -ENOMEM;
+		}
+		*last = work;
+		last = &work->next;
+
+		memset(&work->ctx, 0, sizeof(work->ctx));
+		if (i == nsegs - 1)
+			work->ctx.remaining = inode->i_size -
+					      inode->fragment_size -
+					      i * cfg.c_segment_size;
+		else
+			work->ctx.remaining = cfg.c_segment_size;
+		work->ctx.seg_num = nsegs;
+		work->ctx.seg_idx = i;
+		work->ctx.blkaddr = blkaddr;
+		init_list_head(&work->ctx.extents);
+		work->ctx.ictx = ictx;
+
+		work->alg_id = ccfg->handle.alg->id;
+		work->alg_name = ccfg->handle.alg->name;
+		work->comp_level = ccfg->handle.compression_level;
+		work->dict_size = ccfg->handle.dict_size;
+
+		work->work.func = z_erofs_mt_work;
+
+		erofs_queue_work(&z_erofs_mt_ctrl.wq, &work->work);
+	}
+
+	pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
+	while (z_erofs_mt_ctrl.nfini != nsegs)
+		pthread_cond_wait(&z_erofs_mt_ctrl.cond,
+				  &z_erofs_mt_ctrl.mutex);
+	pthread_mutex_unlock(&z_erofs_mt_ctrl.mutex);
+
+	ictx->extents = &head->ctx.extents;
+
+	ret = z_erofs_mt_merge(head, blkaddr, compressed_blocks);
+	if (ret)
+		return ret;
+
+	z_erofs_mt_fix_index(ictx, blkaddr);
+	return 0;
+}
+#endif
+
 int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 {
 	struct erofs_buffer_head *bh;
-	static struct z_erofs_vle_compress_ctx ctx;
-	erofs_blk_t blkaddr, compressed_blocks;
+	static struct z_erofs_compressed_inode_ctx ictx;
+	static struct z_erofs_compressed_segment_ctx ctx;
+	struct erofs_compress_cfg *ccfg;
+	erofs_blk_t blkaddr, compressed_blocks = 0;
 	unsigned int legacymetasize;
 	int ret;
 	struct erofs_sb_info *sbi = inode->sbi;
@@ -963,8 +1368,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 		}
 	}
 #endif
-	ctx.ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
-	inode->z_algorithmtype[0] = ctx.ccfg[0].algorithmtype;
+	ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
+	inode->z_algorithmtype[0] = ccfg[0].algorithmtype;
 	inode->z_algorithmtype[1] = 0;
 
 	inode->idata_size = 0;
@@ -975,82 +1380,87 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	 * parts into the packed inode.
 	 */
 	if (cfg.c_fragments && !erofs_is_packed_inode(inode)) {
-		ret = z_erofs_fragments_dedupe(inode, fd, &ctx.tof_chksum);
+		ret = z_erofs_fragments_dedupe(inode, fd, &ictx.tof_chksum);
 		if (ret < 0)
 			goto err_bdrop;
 	}
 
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
-	ctx.inode = inode;
-	ctx.pclustersize = z_erofs_get_max_pclustersize(inode);
+
+	ictx.inode = inode;
+	ictx.fd = fd;
+	ictx.fix_dedupedfrag = false;
+	ictx.fragemitted = false;
+	ictx.pclustersize = z_erofs_get_max_pclustersize(inode);
+	ictx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
+
+	memset(&ctx, 0, sizeof(ctx));
+	ctx.ictx = &ictx;
 	ctx.blkaddr = blkaddr;
-	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
-	ctx.head = ctx.tail = 0;
-	ctx.clusterofs = 0;
-	ctx.pivot = &dummy_pivot;
 	init_list_head(&ctx.extents);
-	ctx.remaining = inode->i_size - inode->fragment_size;
-	ctx.fix_dedupedfrag = false;
-	ctx.fragemitted = false;
-	if (cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
-	    !inode->fragment_size) {
-		ret = z_erofs_pack_file_from_fd(inode, fd, ctx.tof_chksum);
+
+	if (z_erofs_mt_enabled) {
+#ifdef EROFS_MT_ENABLED
+		if (inode->i_size <= cfg.c_segment_size)
+			goto single_thread_comp;
+
+		ret = z_erofs_mt_compress(&ctx, ccfg, &compressed_blocks);
 		if (ret)
 			goto err_free_idata;
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
+		if (cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
+		    !inode->fragment_size) {
+			ret = z_erofs_pack_file_from_fd(inode, fd,
+							ictx.tof_chksum);
+			if (ret)
+				goto err_free_idata;
 
-			ret = z_erofs_compress_one(&ctx);
+			ictx.extents = &ctx.extents;
+		} else {
+#ifdef EROFS_MT_ENABLED
+single_thread_comp:
+#endif
+			ctx.queue = z_erofs_global_queue;
+			ctx.destbuf = NULL;
+			ctx.chandle = &ccfg->handle;
+			ctx.remaining = inode->i_size - inode->fragment_size;
+			ctx.seg_num = 1;
+			ctx.seg_idx = 0;
+
+			ret = z_erofs_compress_file(&ctx, 0, blkaddr);
 			if (ret)
 				goto err_free_idata;
+
+			compressed_blocks = ctx.compressed_blocks;
+			ictx.extents = &ctx.extents;
 		}
-	}
-	DBG_BUGON(ctx.head != ctx.tail);
 
-	/* fall back to no compression mode */
-	compressed_blocks = ctx.blkaddr - blkaddr;
-	DBG_BUGON(compressed_blocks < !!inode->idata_size);
-	compressed_blocks -= !!inode->idata_size;
+		/* generate an extent for the deduplicated fragment */
+		if (inode->fragment_size && !ictx.fragemitted) {
+			struct z_erofs_extent_item *ei;
 
-	if (ctx.pivot) {
-		z_erofs_commit_extent(&ctx, ctx.pivot);
-		ctx.pivot = NULL;
-	}
-
-	/* generate an extent for the deduplicated fragment */
-	if (inode->fragment_size && !ctx.fragemitted) {
-		struct z_erofs_extent_item *ei;
+			ei = malloc(sizeof(*ei));
+			if (!ei) {
+				ret = -ENOMEM;
+				goto err_free_idata;
+			}
 
-		ei = malloc(sizeof(*ei));
-		if (!ei) {
-			ret = -ENOMEM;
-			goto err_free_idata;
+			ei->e = (struct z_erofs_inmem_extent){
+				.length = inode->fragment_size,
+				.compressedblks = 0,
+				.raw = false,
+				.partial = false,
+				.blkaddr = ctx.blkaddr,
+			};
+			init_list_head(&ei->list);
+			z_erofs_commit_extent(&ctx, ei);
 		}
-
-		ei->e = (struct z_erofs_inmem_extent) {
-			.length = inode->fragment_size,
-			.compressedblks = 0,
-			.raw = false,
-			.partial = false,
-			.blkaddr = ctx.blkaddr,
-		};
-		init_list_head(&ei->list);
-		z_erofs_commit_extent(&ctx, ei);
+		z_erofs_fragments_commit(inode);
 	}
-	z_erofs_fragments_commit(inode);
 
-	z_erofs_write_indexes(&ctx);
-	legacymetasize = ctx.metacur - compressmeta;
+	z_erofs_write_indexes(&ictx);
+	legacymetasize = ictx.metacur - compressmeta;
 	/* estimate if data compression saves space or not */
 	if (!inode->fragment_size &&
 	    compressed_blocks * erofs_blksiz(sbi) + inode->idata_size +
@@ -1062,7 +1472,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	z_erofs_dedupe_commit(false);
 	z_erofs_write_mapheader(inode, compressmeta);
 
-	if (!ctx.fragemitted)
+	if (!ictx.fragemitted)
 		sbi->saved_by_deduplication += inode->fragment_size;
 
 	/* if the entire file is a fragment, a simplified form is used. */
@@ -1257,8 +1667,32 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
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
+#ifdef EROFS_MT_ENABLED
+	if (cfg.c_mt_workers == 1) {
+		z_erofs_mt_enabled = false;
+	} else {
+		pthread_mutex_init(&z_erofs_mt_ctrl.mutex, NULL);
+		pthread_cond_init(&z_erofs_mt_ctrl.cond, NULL);
+		ret = erofs_alloc_workqueue(
+			&z_erofs_mt_ctrl.wq, cfg.c_mt_workers,
+			cfg.c_mt_workers << 2,
+			sizeof(struct erofs_compress_wq_private),
+			z_erofs_mt_private_fini);
+		z_erofs_mt_enabled = !ret;
+	}
+#else
+	mt_enabled = false;
+#endif
+	z_erofs_global_queue = malloc(EROFS_COMPR_QUEUE_SZ);
+	if (!z_erofs_global_queue)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -1271,5 +1705,22 @@ int z_erofs_compress_exit(void)
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
+
+	free(z_erofs_global_queue);
+
 	return 0;
 }
diff --git a/lib/compressor.c b/lib/compressor.c
index 4720e72..97732d1 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -86,6 +86,8 @@ int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
 
 	/* should be written in "minimum compression ratio * 100" */
 	c->compress_threshold = 100;
+	c->compression_level = -1;
+	c->dict_size = 0;
 
 	if (!alg_name) {
 		c->alg = NULL;
-- 
2.44.0

