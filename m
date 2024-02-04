Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FD6848CE3
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Feb 2024 11:34:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TSQqr5D9lz3bsw
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Feb 2024 21:34:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TSQqp0BMkz2ydW
	for <linux-erofs@lists.ozlabs.org>; Sun,  4 Feb 2024 21:34:46 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 4E99710082701;
	Sun,  4 Feb 2024 18:34:33 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id CED33381F4B;
	Sun,  4 Feb 2024 18:34:30 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 6/7] erofs-utils: mkfs: introduce inner-file multi-threaded compression
Date: Sun,  4 Feb 2024 18:34:28 +0800
Message-ID: <20240204103428.141732-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
Cc: hsiangkao@linux.alibaba.com, Yifan Zhao <zhaoyifan@sjtu.edu.cn>, xin_tong@sjtu.edu.cn
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
 lib/compress.c           | 608 +++++++++++++++++++++++++++++++++------
 lib/compressor.c         |   2 +
 3 files changed, 517 insertions(+), 94 deletions(-)

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
index 41cb6e5..6a9eb85 100644
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
@@ -34,28 +37,74 @@ struct z_erofs_extent_item {
 };
 
 struct z_erofs_vle_compress_ctx {
-	u8 queue[EROFS_CONFIG_COMPR_MAX_SZ * 2];
+	u8 *queue;
 	struct list_head extents;
 	struct z_erofs_extent_item *pivot;
 
 	struct erofs_inode *inode;
-	struct erofs_compress_cfg *ccfg;
+	struct erofs_compress *chandle;
+	char *destbuf;
 
-	u8 *metacur;
+	int fd;
 	unsigned int head, tail;
 	erofs_off_t remaining;
 	unsigned int pclustersize;
 	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
+	erofs_blk_t compressed_blocks;
 	u16 clusterofs;
 
 	u32 tof_chksum;
 	bool fix_dedupedfrag;
 	bool fragemitted;
+
+	int seg_num, seg_idx;
+	FILE *tmpfile;
+};
+
+struct z_erofs_write_index_ctx {
+	struct erofs_inode *inode;
+	struct list_head *extents;
+	u16 clusterofs;
+	erofs_blk_t blkaddr, blkoff;
+	u8 *metacur;
+};
+
+#ifdef EROFS_MT_ENABLED
+struct erofs_compress_wq_private {
+	bool init;
+	u8 *queue;
+	char *destbuf;
+	struct erofs_compress_cfg *ccfg;
+};
+
+struct erofs_compress_work {
+	/* Note: struct erofs_work must be the first member */
+	struct erofs_work work;
+	struct z_erofs_vle_compress_ctx ctx;
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
 
+static struct erofs_workqueue wq;
+static struct erofs_compress_work *idle;
+static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
+static int nfini;
+#endif
+
+static bool mt_enabled;
+static u8 *queue;
+
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	Z_EROFS_FULL_INDEX_ALIGN(0)
 
-static void z_erofs_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
+static void z_erofs_write_indexes_final(struct z_erofs_write_index_ctx *ctx)
 {
 	const unsigned int type = Z_EROFS_LCLUSTER_TYPE_PLAIN;
 	struct z_erofs_lcluster_index di;
@@ -71,7 +120,7 @@ static void z_erofs_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
 	ctx->metacur += sizeof(di);
 }
 
-static void z_erofs_write_extent(struct z_erofs_vle_compress_ctx *ctx,
+static void z_erofs_write_extent(struct z_erofs_write_index_ctx *ctx,
 				 struct z_erofs_inmem_extent *e)
 {
 	struct erofs_inode *inode = ctx->inode;
@@ -99,10 +148,15 @@ static void z_erofs_write_extent(struct z_erofs_vle_compress_ctx *ctx,
 		di.di_advise = cpu_to_le16(advise);
 
 		if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL &&
-		    !e->compressedblks)
+		    !e->compressedblks) {
 			di.di_u.blkaddr = cpu_to_le32(inode->fragmentoff >> 32);
-		else
+		} else if (mt_enabled) {
+			di.di_u.blkaddr =
+				cpu_to_le32(ctx->blkaddr + ctx->blkoff);
+			ctx->blkoff += e->compressedblks;
+		} else {
 			di.di_u.blkaddr = cpu_to_le32(e->blkaddr);
+		}
 		memcpy(ctx->metacur, &di, sizeof(di));
 		ctx->metacur += sizeof(di);
 
@@ -144,10 +198,15 @@ static void z_erofs_write_extent(struct z_erofs_vle_compress_ctx *ctx,
 				Z_EROFS_LCLUSTER_TYPE_HEAD1;
 
 			if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL &&
-			    !e->compressedblks)
+			    !e->compressedblks) {
 				di.di_u.blkaddr = cpu_to_le32(inode->fragmentoff >> 32);
-			else
+			} else if (mt_enabled) {
+				di.di_u.blkaddr =
+					cpu_to_le32(ctx->blkaddr + ctx->blkoff);
+				ctx->blkoff += e->compressedblks;
+			} else {
 				di.di_u.blkaddr = cpu_to_le32(e->blkaddr);
+			}
 
 			if (e->partial) {
 				DBG_BUGON(e->raw);
@@ -170,12 +229,12 @@ static void z_erofs_write_extent(struct z_erofs_vle_compress_ctx *ctx,
 	ctx->clusterofs = clusterofs + count;
 }
 
-static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
+static void z_erofs_write_indexes(struct z_erofs_write_index_ctx *ctx)
 {
 	struct z_erofs_extent_item *ei, *n;
 
 	ctx->clusterofs = 0;
-	list_for_each_entry_safe(ei, n, &ctx->extents, list) {
+	list_for_each_entry_safe(ei, n, ctx->extents, list) {
 		z_erofs_write_extent(ctx, &ei->e);
 
 		list_del(&ei->list);
@@ -335,11 +394,18 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
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
+	} else {
+		erofs_dbg("Writing %u uncompressed data to block %u", count,
+			  ctx->blkaddr);
+		ret = blk_write(sbi, dst, ctx->blkaddr, 1);
+		if (ret)
+			return ret;
+	}
 	return count;
 }
 
@@ -385,7 +451,7 @@ static void tryrecompress_trailing(struct z_erofs_vle_compress_ctx *ctx,
 				   void *out, unsigned int *compressedsize)
 {
 	struct erofs_sb_info *sbi = ctx->inode->sbi;
-	static char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
+	char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
 	unsigned int count;
 	int ret = *compressedsize;
 
@@ -439,17 +505,22 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
 static int __z_erofs_compress_one(struct z_erofs_vle_compress_ctx *ctx,
 				  struct z_erofs_inmem_extent *e)
 {
-	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_MAX_BLOCK_SIZE];
+	static char
+		global_dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_MAX_BLOCK_SIZE];
+	char *dstbuf = ctx->destbuf ? ctx->destbuf : global_dstbuf;
 	struct erofs_inode *inode = ctx->inode;
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
+	bool is_last_seg = (ctx->seg_idx == ctx->seg_num - 1);
+	bool may_packing =
+		(cfg.c_fragments && final && !is_packed_inode && is_last_seg);
+	bool may_inline =
+		(cfg.c_ztailpacking && final && !may_packing && is_last_seg);
 	unsigned int compressedsize;
 	int ret;
 
@@ -545,7 +616,7 @@ frag_packing:
 		 */
 		if (may_packing && len == e->length &&
 		    (compressedsize & (blksz - 1)) &&
-		    ctx->tail < sizeof(ctx->queue)) {
+		    ctx->tail < EROFS_COMPR_QUEUE_SZ) {
 			ctx->pclustersize = roundup(compressedsize, blksz);
 			goto fix_dedupedfrag;
 		}
@@ -569,13 +640,24 @@ frag_packing:
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
@@ -912,12 +994,355 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 	inode->eof_tailraw = NULL;
 }
 
+int z_erofs_compress_file(struct z_erofs_vle_compress_ctx *ctx, u64 offset,
+			  erofs_blk_t blkaddr)
+{
+	struct erofs_inode *inode = ctx->inode;
+	int ret = 0;
+
+	while (ctx->remaining) {
+		const u64 rx = min_t(u64, ctx->remaining,
+				     EROFS_COMPR_QUEUE_SZ - ctx->tail);
+
+		ret = pread(ctx->fd, ctx->queue + ctx->tail, rx, offset);
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
+int z_erofs_handle_fragments(struct z_erofs_vle_compress_ctx *ctx)
+{
+	struct erofs_inode *inode = ctx->inode;
+
+	/* generate an extent for the deduplicated fragment */
+	if (inode->fragment_size && !ctx->fragemitted) {
+		struct z_erofs_extent_item *ei;
+
+		ei = malloc(sizeof(*ei));
+		if (!ei)
+			return -ENOMEM;
+
+		ei->e = (struct z_erofs_inmem_extent) {
+			.length = inode->fragment_size,
+			.compressedblks = 0,
+			.raw = false,
+			.partial = false,
+			.blkaddr = ctx->blkaddr,
+		};
+		init_list_head(&ei->list);
+		z_erofs_commit_extent(ctx, ei);
+	}
+	z_erofs_fragments_commit(inode);
+
+	return 0;
+}
+
+#ifdef EROFS_MT_ENABLED
+int z_erofs_mt_private_init(struct erofs_sb_info *sbi,
+			    struct erofs_compress_wq_private *priv,
+			    unsigned int alg_id, char *alg_name,
+			    unsigned int comp_level, unsigned int dict_size)
+{
+	struct erofs_compress_cfg *lc;
+	int ret;
+
+	if (!priv->init) {
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
+	}
+
+	lc = &priv->ccfg[alg_id];
+	if (!lc->enable) {
+		lc->enable = true;
+		lc->algorithmtype = alg_id;
+
+		ret = erofs_compressor_init(sbi, &lc->handle, alg_name,
+					    comp_level, dict_size, false);
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
+		priv->init = false;
+	}
+}
+
+void z_erofs_mt_work(struct erofs_workqueue *wq, struct erofs_work *work)
+{
+	struct erofs_compress_work *cwork = (struct erofs_compress_work *)work;
+	struct z_erofs_vle_compress_ctx *ctx = &cwork->ctx;
+	struct erofs_compress_wq_private *priv = work->private;
+	erofs_blk_t blkaddr = ctx->blkaddr;
+	u64 offset = ctx->seg_idx * cfg.c_mt_segment_size;
+	int ret = 0;
+
+	ret = z_erofs_mt_private_init(ctx->inode->sbi, priv, cwork->alg_id,
+				      cwork->alg_name, cwork->comp_level,
+				      cwork->dict_size);
+	if (ret)
+		goto out;
+
+	ctx->queue = priv->queue;
+	ctx->destbuf = priv->destbuf;
+	ctx->chandle = &priv->ccfg[cwork->alg_id].handle;
+
+#ifdef HAVE_TMPFILE64
+	ctx->tmpfile = tmpfile64();
+#else
+	ctx->tmpfile = tmpfile();
+#endif
+
+	ret = z_erofs_compress_file(ctx, offset, blkaddr);
+	if (ret)
+		goto out;
+
+	fflush(ctx->tmpfile);
+
+	if (ctx->seg_idx == ctx->seg_num - 1)
+		ret = z_erofs_handle_fragments(ctx);
+
+out:
+	cwork->ret = ret;
+	pthread_mutex_lock(&mutex);
+	++nfini;
+	pthread_cond_signal(&cond);
+	pthread_mutex_unlock(&mutex);
+}
+
+int z_erofs_mt_merge(struct erofs_compress_work *cur, erofs_blk_t blkaddr,
+		     erofs_blk_t *compressed_blocks)
+{
+	struct z_erofs_vle_compress_ctx *ctx, *listhead = NULL;
+	struct erofs_sb_info *sbi = cur->ctx.inode->sbi;
+	struct erofs_compress_work *tmp;
+	char *memblock = NULL;
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
+		memblock = realloc(memblock,
+				   ctx->compressed_blocks * erofs_blksiz(sbi));
+		if (!memblock) {
+			if (!ret)
+				ret = -ENOMEM;
+			goto out;
+		}
+
+		lret = fseek(ctx->tmpfile, 0, SEEK_SET);
+		if (lret) {
+			if (!ret)
+				ret = lret;
+			goto out;
+		}
+
+		lret = fread(memblock, erofs_blksiz(sbi),
+			     ctx->compressed_blocks, ctx->tmpfile);
+		if (lret != ctx->compressed_blocks) {
+			if (!ret)
+				ret = -EIO;
+			goto out;
+		}
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
+		fclose(ctx->tmpfile);
+
+		tmp = cur->next;
+		cur->next = idle;
+		idle = cur;
+		cur = tmp;
+	}
+
+	free(memblock);
+
+	return ret;
+}
+#endif
+
+void z_erofs_init_ctx(struct z_erofs_vle_compress_ctx *ctx,
+		      struct erofs_inode *inode, erofs_blk_t blkaddr,
+		      u32 tof_chksum, int fd)
+{
+	ctx->inode = inode;
+	ctx->pclustersize = z_erofs_get_max_pclustersize(inode);
+	ctx->blkaddr = blkaddr;
+	ctx->head = ctx->tail = 0;
+	ctx->clusterofs = 0;
+	ctx->fix_dedupedfrag = false;
+	ctx->fragemitted = false;
+	ctx->tof_chksum = tof_chksum;
+	ctx->fd = fd;
+	ctx->tmpfile = NULL;
+	init_list_head(&ctx->extents);
+}
+
+int z_erofs_do_compress(struct z_erofs_vle_compress_ctx *ctx,
+			struct z_erofs_write_index_ctx *ictx,
+			struct erofs_compress_cfg *ccfg,
+			erofs_blk_t *compressed_blocks)
+{
+#ifdef EROFS_MT_ENABLED
+	struct erofs_compress_work *work, *head = NULL, **last = &head;
+#endif
+	struct erofs_inode *inode = ctx->inode;
+	erofs_blk_t blkaddr = ctx->blkaddr;
+	int ret = 0;
+
+	if (mt_enabled) {
+#ifdef EROFS_MT_ENABLED
+		if (inode->i_size <= cfg.c_mt_segment_size)
+			goto single_thread;
+
+		int nsegs = DIV_ROUND_UP(inode->i_size, cfg.c_mt_segment_size);
+		nfini = 0;
+
+		for (int i = 0; i < nsegs; i++) {
+			if (idle) {
+				work = idle;
+				idle = work->next;
+				work->next = NULL;
+			} else {
+				work = calloc(1, sizeof(*work));
+				if (!work)
+					return -ENOMEM;
+			}
+			*last = work;
+			last = &work->next;
+
+			z_erofs_init_ctx(&work->ctx, inode, blkaddr,
+					 ctx->tof_chksum, ctx->fd);
+			if (i == nsegs - 1)
+				work->ctx.remaining = inode->i_size -
+						      inode->fragment_size -
+						      i * cfg.c_mt_segment_size;
+			else
+			 	work->ctx.remaining = cfg.c_mt_segment_size;
+			work->ctx.seg_num = nsegs;
+			work->ctx.seg_idx = i;
+
+			work->alg_id = ccfg->handle.alg->id;
+			work->alg_name = ccfg->handle.alg->name;
+			work->comp_level = ccfg->handle.compression_level;
+			work->dict_size = ccfg->handle.dict_size;
+
+			work->work.function = z_erofs_mt_work;
+
+			erofs_workqueue_add(&wq, &work->work);
+		}
+
+		pthread_mutex_lock(&mutex);
+		while (nfini != nsegs)
+			pthread_cond_wait(&cond, &mutex);
+		pthread_mutex_unlock(&mutex);
+
+		ictx->extents = &head->ctx.extents;
+
+		ret = z_erofs_mt_merge(head, blkaddr, compressed_blocks);
+		if (ret)
+			return ret;
+#endif
+	} else {
+#ifdef EROFS_MT_ENABLED
+single_thread:
+#endif
+		ctx->queue = queue;
+		ctx->destbuf = NULL;
+		ctx->chandle = &ccfg->handle;
+		ctx->remaining = inode->i_size - inode->fragment_size;
+		ctx->seg_num = 1;
+		ctx->seg_idx = 0;
+
+		ret = z_erofs_compress_file(ctx, 0, blkaddr);
+		if (ret)
+			return ret;
+
+		ret = z_erofs_handle_fragments(ctx);
+		if (ret)
+			return ret;
+
+		*compressed_blocks = ctx->compressed_blocks;
+		ictx->extents = &ctx->extents;
+	}
+
+	return 0;
+}
+
 int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 {
 	struct erofs_buffer_head *bh;
 	static struct z_erofs_vle_compress_ctx ctx;
-	erofs_blk_t blkaddr, compressed_blocks;
+	static struct z_erofs_write_index_ctx ictx;
+	struct erofs_compress_cfg *ccfg;
+	erofs_blk_t blkaddr, compressed_blocks = 0;
 	unsigned int legacymetasize;
+	u32 tof_chksum = 0;
 	int ret;
 	struct erofs_sb_info *sbi = inode->sbi;
 	u8 *compressmeta = malloc(BLK_ROUND_UP(sbi, inode->i_size) *
@@ -963,8 +1388,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 		}
 	}
 #endif
-	ctx.ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
-	inode->z_algorithmtype[0] = ctx.ccfg[0].algorithmtype;
+	ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
+	inode->z_algorithmtype[0] = ccfg[0].algorithmtype;
 	inode->z_algorithmtype[1] = 0;
 
 	inode->idata_size = 0;
@@ -975,82 +1400,39 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	 * parts into the packed inode.
 	 */
 	if (cfg.c_fragments && !erofs_is_packed_inode(inode)) {
-		ret = z_erofs_fragments_dedupe(inode, fd, &ctx.tof_chksum);
+		ret = z_erofs_fragments_dedupe(inode, fd, &tof_chksum);
 		if (ret < 0)
 			goto err_bdrop;
 	}
 
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
-	ctx.inode = inode;
-	ctx.pclustersize = z_erofs_get_max_pclustersize(inode);
-	ctx.blkaddr = blkaddr;
-	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
-	ctx.head = ctx.tail = 0;
-	ctx.clusterofs = 0;
-	ctx.pivot = &dummy_pivot;
-	init_list_head(&ctx.extents);
-	ctx.remaining = inode->i_size - inode->fragment_size;
-	ctx.fix_dedupedfrag = false;
-	ctx.fragemitted = false;
+	z_erofs_init_ctx(&ctx, inode, blkaddr, tof_chksum, fd);
 	if (cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
 	    !inode->fragment_size) {
-		ret = z_erofs_pack_file_from_fd(inode, fd, ctx.tof_chksum);
+		ret = z_erofs_pack_file_from_fd(inode, fd, tof_chksum);
 		if (ret)
 			goto err_free_idata;
-	} else {
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
 
-			ret = z_erofs_compress_one(&ctx);
+		ret = z_erofs_handle_fragments(&ctx);
+		if (ret)
+			goto err_free_idata;
+
+		ictx.extents = &ctx.extents;
+	} else {
+			ret = z_erofs_do_compress(&ctx, &ictx, ccfg,
+						  &compressed_blocks);
 			if (ret)
 				goto err_free_idata;
-		}
 	}
-	DBG_BUGON(ctx.head != ctx.tail);
-
-	/* fall back to no compression mode */
-	compressed_blocks = ctx.blkaddr - blkaddr;
-	DBG_BUGON(compressed_blocks < !!inode->idata_size);
-	compressed_blocks -= !!inode->idata_size;
-
-	if (ctx.pivot) {
-		z_erofs_commit_extent(&ctx, ctx.pivot);
-		ctx.pivot = NULL;
-	}
-
-	/* generate an extent for the deduplicated fragment */
-	if (inode->fragment_size && !ctx.fragemitted) {
-		struct z_erofs_extent_item *ei;
-
-		ei = malloc(sizeof(*ei));
-		if (!ei) {
-			ret = -ENOMEM;
-			goto err_free_idata;
-		}
 
-		ei->e = (struct z_erofs_inmem_extent) {
-			.length = inode->fragment_size,
-			.compressedblks = 0,
-			.raw = false,
-			.partial = false,
-			.blkaddr = ctx.blkaddr,
-		};
-		init_list_head(&ei->list);
-		z_erofs_commit_extent(&ctx, ei);
-	}
-	z_erofs_fragments_commit(inode);
+	ictx.inode = inode;
+	ictx.blkaddr = blkaddr;
+	ictx.blkoff = 0;
+	ictx.clusterofs = 0;
+	ictx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 
-	z_erofs_write_indexes(&ctx);
-	legacymetasize = ctx.metacur - compressmeta;
+	z_erofs_write_indexes(&ictx);
+	legacymetasize = ictx.metacur - compressmeta;
 	/* estimate if data compression saves space or not */
 	if (!inode->fragment_size &&
 	    compressed_blocks * erofs_blksiz(sbi) + inode->idata_size +
@@ -1258,8 +1640,29 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
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
+	if (cfg.c_mt_worker_num == 1) {
+		mt_enabled = false;
+	} else {
+		ret = erofs_workqueue_create(
+			&wq, sizeof(struct erofs_compress_wq_private),
+			z_erofs_mt_private_fini, cfg.c_mt_worker_num,
+			cfg.c_mt_worker_num << 2);
+		mt_enabled = !ret;
+	}
+#else
+	mt_enabled = false;
+#endif
+	queue = malloc(EROFS_COMPR_QUEUE_SZ);
+	if (!queue)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -1272,5 +1675,22 @@ int z_erofs_compress_exit(void)
 		if (ret)
 			return ret;
 	}
+
+	if (mt_enabled) {
+#ifdef EROFS_MT_ENABLED
+		ret = erofs_workqueue_terminate(&wq);
+		if (ret)
+			return ret;
+		erofs_workqueue_destroy(&wq);
+		while (idle) {
+			struct erofs_compress_work *tmp = idle->next;
+			free(idle);
+			idle = tmp;
+		}
+#endif
+	}
+
+	free(queue);
+
 	return 0;
 }
diff --git a/lib/compressor.c b/lib/compressor.c
index 9b3794b..d59e00d 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -87,6 +87,8 @@ int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
 
 	/* should be written in "minimum compression ratio * 100" */
 	c->compress_threshold = 100;
+	c->compression_level = -1;
+	c->dict_size = 0;
 
 	if (!alg_name) {
 		c->alg = NULL;
-- 
2.43.0

