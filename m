Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC33781ABE
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Aug 2023 20:07:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RSmsW5kqJz308W
	for <lists+linux-erofs@lfdr.de>; Sun, 20 Aug 2023 04:06:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 322 seconds by postgrey-1.37 at boromir; Sun, 20 Aug 2023 04:06:48 AEST
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RSmsN0gt9z2xFk
	for <linux-erofs@lists.ozlabs.org>; Sun, 20 Aug 2023 04:06:45 +1000 (AEST)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 38426100C899C
	for <linux-erofs@lists.ozlabs.org>; Sun, 20 Aug 2023 02:01:09 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 6B11437C944;
	Sun, 20 Aug 2023 02:01:05 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH] erofs-utils: mkfs: introduce multi-thread compression
Date: Sun, 20 Aug 2023 02:01:04 +0800
Message-ID: <20230819180104.4824-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.41.0
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
Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch introduce multi-thread compression to accelerate image
packaging.
---
Hi all:

This is a very imperfect patch not ready for merging, and any suggestions would be appreciated!
If it's on track, I'd like to follow up on that.

The inefficiency of EROFS compressed image creation is a much criticized problem,
and this patch attempts to address by creating multiple threads
to run the compression algorithm in parallel.

Specifically, each input file over 16MB is split into segments,
and each thread compresses a segment as if it were a separate file.
Finally, the main thread merges all the compressed segments into one file.
This process does not involve any data contention. 

Current issues:
1.	For each large file, we create and destroy a batch of worker threads, causing unnecessary overhead.
	Moreover, each worker thread's context is a global variable, making the binary bigger.
	In the future, we can pre-create worker threads when the program starts running.
	Worker threads serve as consumers and the main thread that makes the compression request is the producer.
2.	Fragment/Dedupe together with other advanced features are not fully tested
	due to my poor knowledge of the compression process. Not sure if they work well with multithreading.
3.	There is a lot of code redundancy between the
	erofs_write_compressed_file() and erofs_write_compressed_file_single() functions.
	I don't want to break the original single-threaded execution logic,
	but erofs_write_compressed_file() has a high complexity and
	my failed attempt to merge the two functions makes the matter worse.
	I'm not sure if we should merge them together or keep two different function entries for single and multi-threaded compression.

Performance:
	Despite the naive patch, we still see performance gain due to the poor baseline performance especially for lz4hc.
	1. Packing time of an Arch linux container image [1] provided by @wszqkzqk [2].
		lz4  : 8s(multi-thread) v.s. 10s(single-thread)
		lz4hc: 48s(multi-thread) v.s. 54s(single-thread)
	2. Packint time of Linux v6.4 git repository (with several ~GB git object files).
		lz4  : 14s(multi-thread) v.s. 23s(single-thread)
		lz4hc: 49s(multi-thread) v.s. 212s(single-thread)

BTW, is there any format file (e.g., .clang-format) available for me to format erofs-utils project?

[1] https://disk.pku.edu.cn/link/9ACE0EF8342B25336C67DC49D381D904
[2] https://github.com/erofs/erofs-openbenchmark/issues/1

 include/erofs/compress.h |   1 +
 include/erofs/config.h   |   1 +
 lib/compress.c           | 486 ++++++++++++++++++++++++++++++++++++---
 lib/compressor.h         |   2 +
 mkfs/main.c              |   5 +
 5 files changed, 463 insertions(+), 32 deletions(-)

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 46cff03..fcda92a 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -17,6 +17,7 @@ extern "C"
 #define EROFS_CONFIG_COMPR_MAX_SZ           (4000 * 1024)
 
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
+int erofs_write_compressed_file_single(struct erofs_inode *inode, int fd);
 int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
 
 int z_erofs_compress_init(struct erofs_sb_info *sbi,
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 8f52d2c..ecc07a2 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -53,6 +53,7 @@ struct erofs_configure {
 	bool c_ignore_mtime;
 	bool c_showprogress;
 	bool c_extra_ea_name_prefixes;
+	bool c_multithread;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/lib/compress.c b/lib/compress.c
index e5d310f..ca48817 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -8,6 +8,7 @@
 #ifndef _LARGEFILE64_SOURCE
 #define _LARGEFILE64_SOURCE
 #endif
+#include <pthread.h>
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -23,11 +24,21 @@
 
 /* compressing configuration specified by users */
 struct erofs_compress_cfg {
-	struct erofs_compress handle;
+	struct erofs_compress handle[Z_EROFS_MULTICOMPRESS_MAX_NTHREADS];
 	unsigned int algorithmtype;
 	bool enable;
 } erofs_ccfg[EROFS_MAX_COMPR_CFGS];
 
+struct z_erofs_multicompress {
+	int fd;
+	int thread_idx, thread_num;
+	int seg_idx, seg_num;
+	FILE *tmpfile;
+	struct z_erofs_multicompress_ret *segs_ret;
+	u64 last_seg_size;
+	u8 *compressmeta;
+};
+
 struct z_erofs_vle_compress_ctx {
 	u8 queue[EROFS_CONFIG_COMPR_MAX_SZ * 2];
 	struct z_erofs_inmem_extent e;	/* (lookahead) extent */
@@ -45,6 +56,8 @@ struct z_erofs_vle_compress_ctx {
 	u32 tof_chksum;
 	bool fix_dedupedfrag;
 	bool fragemitted;
+
+	struct z_erofs_multicompress mctx;
 };
 
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	Z_EROFS_FULL_INDEX_ALIGN(0)
@@ -250,7 +263,7 @@ out:
 }
 
 static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
-				     unsigned int *len, char *dst)
+				     unsigned int *len, char *dst, bool is_multithread)
 {
 	int ret;
 	struct erofs_sb_info *sbi = ctx->inode->sbi;
@@ -280,9 +293,15 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 
 	erofs_dbg("Writing %u uncompressed data to block %u",
 		  count, ctx->blkaddr);
-	ret = blk_write(sbi, dst, ctx->blkaddr, 1);
-	if (ret)
-		return ret;
+	if (!is_multithread) {
+		ret = blk_write(sbi, dst, ctx->blkaddr, 1);
+		if (ret)
+			return ret;
+	} else {
+		ret = fwrite(dst, erofs_blksiz(sbi), 1, ctx->mctx.tmpfile);
+		if (ret != 1)
+			return -EIO;
+	}
 	return count;
 }
 
@@ -328,7 +347,7 @@ static void tryrecompress_trailing(struct z_erofs_vle_compress_ctx *ctx,
 				   void *out, int *compressedsize)
 {
 	struct erofs_sb_info *sbi = ctx->inode->sbi;
-	static char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
+	char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
 	unsigned int count;
 	int ret = *compressedsize;
 
@@ -381,21 +400,23 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
 
 static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 {
-	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_MAX_BLOCK_SIZE];
+	char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_MAX_BLOCK_SIZE];
 	struct erofs_inode *inode = ctx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
 	char *const dst = dstbuf + erofs_blksiz(sbi);
-	struct erofs_compress *const h = &ctx->ccfg->handle;
+	struct erofs_compress *const h = &ctx->ccfg->handle[ctx->mctx.thread_idx];
 	unsigned int len = ctx->tail - ctx->head;
 	bool is_packed_inode = erofs_is_packed_inode(inode);
 	bool final = !ctx->remaining;
+	bool last_seg = ctx->mctx.seg_idx == ctx->mctx.seg_num - 1;
+	bool is_multithread = ctx->mctx.thread_num > 1;
 	int ret;
 
 	while (len) {
 		bool may_packing = (cfg.c_fragments && final &&
 				   !is_packed_inode);
 		bool may_inline = (cfg.c_ztailpacking && final &&
-				  !may_packing);
+				  !may_packing && last_seg);
 		bool fix_dedupedfrag = ctx->fix_dedupedfrag;
 
 		if (z_erofs_compress_dedupe(ctx, &len) && !final)
@@ -404,7 +425,7 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 		if (len <= ctx->pclustersize) {
 			if (!final || !len)
 				break;
-			if (may_packing) {
+			if (may_packing && last_seg) {
 				if (inode->fragment_size && !fix_dedupedfrag) {
 					ctx->pclustersize =
 						roundup(len, erofs_blksiz(sbi));
@@ -437,7 +458,7 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 				may_inline = false;
 				may_packing = false;
 nocompression:
-				ret = write_uncompressed_extent(ctx, &len, dst);
+				ret = write_uncompressed_extent(ctx, &len, dst, is_multithread);
 			}
 
 			if (ret < 0)
@@ -453,7 +474,7 @@ nocompression:
 			ctx->e.raw = true;
 		} else if (may_packing && len == ctx->e.length &&
 			   ret < ctx->pclustersize &&
-			   (!inode->fragment_size || fix_dedupedfrag)) {
+			   (!inode->fragment_size || fix_dedupedfrag) && last_seg) {
 frag_packing:
 			ret = z_erofs_pack_fragments(inode,
 						     ctx->queue + ctx->head,
@@ -494,7 +515,7 @@ frag_packing:
 			 */
 			if (may_packing && len == ctx->e.length &&
 			    (ret & (erofs_blksiz(sbi) - 1)) &&
-			    ctx->tail < sizeof(ctx->queue)) {
+			    ctx->tail < sizeof(ctx->queue) && last_seg) {
 				ctx->pclustersize = BLK_ROUND_UP(sbi, ret) *
 						erofs_blksiz(sbi);
 				goto fix_dedupedfrag;
@@ -523,10 +544,19 @@ frag_packing:
 				  ctx->e.length, ctx->blkaddr,
 				  ctx->e.compressedblks);
 
-			ret = blk_write(sbi, dst - padding, ctx->blkaddr,
-					ctx->e.compressedblks);
-			if (ret)
-				return ret;
+			if (!is_multithread) {
+				ret = blk_write(sbi, dst - padding, ctx->blkaddr,
+						ctx->e.compressedblks);
+				if (ret)
+					return ret;
+			} else {
+			 	ret = fwrite(dst - padding, erofs_blksiz(sbi), ctx->e.compressedblks, ctx->mctx.tmpfile);
+				if (ret != ctx->e.compressedblks) {
+					ret = -EIO;
+					return ret;
+				}
+				fflush(ctx->mctx.tmpfile);
+			}
 			ctx->e.raw = false;
 			may_inline = false;
 			may_packing = false;
@@ -614,8 +644,9 @@ static void *write_compacted_indexes(u8 *out,
 		vcnt = 2;
 	else if (destsize == 2 && logical_clusterbits == 12)
 		vcnt = 16;
-	else
+	else {
 		return ERR_PTR(-EINVAL);
+	}
 	encodebits = (vcnt * destsize * 8 - 32) / vcnt;
 	blkaddr = *blkaddr_ret;
 
@@ -843,10 +874,396 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 	inode->eof_tailraw = NULL;
 }
 
+struct z_erofs_multicompress_ret {
+	int ret;
+	erofs_blk_t compressed_blocks;
+	FILE *tmpfile;
+};
+
+#define Z_EROFS_MULTICOMPRESS_SEGSIZE (16 * 1024 * 1024)
+static struct z_erofs_vle_compress_ctx ctxs[Z_EROFS_MULTICOMPRESS_MAX_NTHREADS];
+
+void *erofs_multicompress_worker(void *arg)
+{
+	struct z_erofs_vle_compress_ctx *ctx = arg;
+	struct erofs_inode *inode = ctx->inode;
+	struct z_erofs_multicompress *mctx = &ctx->mctx;
+	struct erofs_sb_info *sbi = inode->sbi;
+	erofs_blk_t blkaddr = ctx->blkaddr, compressed_blocks = 0;
+	int ret = 0;
+	struct z_erofs_multicompress_ret *seg_ret;
+
+	for (int i = mctx->thread_idx; i < mctx->seg_num;
+	     i += mctx->thread_num) {
+		seg_ret = mctx->segs_ret + i;
+
+		mctx->seg_idx = i;
+		ctx->blkaddr = blkaddr;
+		ctx->head = ctx->tail = 0;
+		ctx->clusterofs = 0;
+		ctx->e.length = 0;
+		ctx->remaining = (i == mctx->seg_num - 1) ?
+					 mctx->last_seg_size :
+					 Z_EROFS_MULTICOMPRESS_SEGSIZE;
+		ctx->metacur =
+			mctx->compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE +
+			i * BLK_ROUND_UP(sbi, Z_EROFS_MULTICOMPRESS_SEGSIZE) *
+				sizeof(struct z_erofs_lcluster_index);
+		ctx->fix_dedupedfrag = false;
+		ctx->fragemitted = false;
+
+#ifdef HAVE_TMPFILE64
+		mctx->tmpfile = tmpfile64();
+#else
+		mctx->tmpfile = tmpfile();
+#endif
+		if (!mctx->tmpfile) {
+			ret = -ENOSPC;
+			goto err;
+		}
+
+		u64 offset = (u64)i * Z_EROFS_MULTICOMPRESS_SEGSIZE;
+		while (ctx->remaining) {
+			const u64 rx = min_t(u64, ctx->remaining,
+					     sizeof(ctx->queue) - ctx->tail);
+
+			ret = pread(mctx->fd, ctx->queue + ctx->tail, rx,
+				    offset);
+			if (ret != rx) {
+				ret = -errno;
+				goto err;
+			}
+			ctx->remaining -= rx;
+			ctx->tail += rx;
+			offset += rx;
+
+			ret = vle_compress_one(ctx);
+			if (ret)
+				goto err;
+		}
+
+		/* fall back to no compression mode */
+		compressed_blocks = ctx->blkaddr - blkaddr;
+		DBG_BUGON(compressed_blocks < !!inode->idata_size);
+		compressed_blocks -= !!inode->idata_size;
+
+		/* generate an extent for the deduplicated fragment */
+		if (inode->fragment_size && !ctx->fragemitted) {
+			z_erofs_write_indexes(ctx);
+			ctx->e.length = inode->fragment_size;
+			ctx->e.compressedblks = 0;
+			ctx->e.raw = false;
+			ctx->e.partial = false;
+			ctx->e.blkaddr = ctx->blkaddr;
+		}
+		z_erofs_fragments_commit(inode);
+
+		z_erofs_write_indexes(ctx);
+		z_erofs_write_indexes_final(ctx);
+
+err:
+		seg_ret->ret = ret;
+		seg_ret->tmpfile = mctx->tmpfile;
+		seg_ret->compressed_blocks = compressed_blocks;
+		mctx->tmpfile = NULL;
+	}
+
+	pthread_exit(NULL);
+}
+
+static int z_erofs_multicompress_merge(struct erofs_sb_info *sbi, int nsegs,
+			       erofs_blk_t blkaddr,
+			       erofs_blk_t *compressed_blocks_total,
+			       erofs_blk_t *compressed_blocks,
+			       struct z_erofs_multicompress_ret *segs_ret)
+{
+	int ret = 0;
+	for (int i = 0; i < nsegs; i++) {
+		char *memblock;
+		struct z_erofs_multicompress_ret *r = &segs_ret[i];
+
+		if (r->ret) {
+			ret = r->ret;
+			goto err_free_tmpfile;
+		}
+
+		memblock = malloc(r->compressed_blocks * erofs_blksiz(sbi));
+		if (!memblock) {
+			ret = -ENOMEM;
+			goto err_free_memblock;
+		}
+		ret = fseek(r->tmpfile, 0, SEEK_SET);
+		if (ret < 0)
+			goto err_free_memblock;
+
+		ret = fread(memblock, erofs_blksiz(sbi), r->compressed_blocks,
+			    r->tmpfile);
+		if (ret != r->compressed_blocks) {
+			ret = -EIO;
+			goto err_free_memblock;
+		}
+
+		ret = blk_write(sbi, memblock, blkaddr + *compressed_blocks,
+				r->compressed_blocks);
+		if (ret)
+			goto err_free_memblock;
+
+		compressed_blocks_total[i] = *compressed_blocks;
+		*compressed_blocks += r->compressed_blocks;
+
+err_free_memblock:
+		free(memblock);
+err_free_tmpfile:
+		fclose(r->tmpfile);
+	}
+	return ret;
+}
+
+static void z_erofs_multicompress_fix_index(struct erofs_inode *inode, u8 *compressmeta,
+				    unsigned int legacymetasize,
+				    erofs_blk_t *compressed_blocks_total)
+{
+	struct erofs_sb_info *sbi = inode->sbi;
+	struct z_erofs_lcluster_index *di;
+	unsigned int i, nr = (legacymetasize - Z_EROFS_LEGACY_MAP_HEADER_SIZE) /
+			     sizeof(struct z_erofs_lcluster_index);
+	unsigned int advise;
+	erofs_blk_t blkaddr;
+
+	for (i = 0; i < nr; ++i) {
+		di = (struct z_erofs_lcluster_index
+			      *)(compressmeta +
+				 Z_EROFS_LEGACY_MAP_HEADER_SIZE) +
+		     i;
+		blkaddr = le32_to_cpu(di->di_u.blkaddr);
+		advise = le16_to_cpu(di->di_advise);
+		u8 cluster_type = (advise >> Z_EROFS_LI_LCLUSTER_TYPE_BIT) &
+				  ((1 << Z_EROFS_LI_LCLUSTER_TYPE_BITS) - 1);
+		int seg_idx =
+			i / BLK_ROUND_UP(sbi, Z_EROFS_MULTICOMPRESS_SEGSIZE);
+
+		if (i == nr - 1 && blkaddr == 0) {
+			continue;
+		}
+
+		if (cluster_type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+			di->di_u.blkaddr =
+				cpu_to_le32(le32_to_cpu(di->di_u.blkaddr) +
+					    compressed_blocks_total[seg_idx]);
+		}
+	}
+}
+
 int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
+{
+	struct erofs_buffer_head *bh;
+	erofs_blk_t blkaddr, compressed_blocks = 0;
+	unsigned int legacymetasize;
+	int ret;
+	struct erofs_sb_info *sbi = inode->sbi;
+	u32 tof_chksum;
+	u64 last_seg_size = (inode->i_size - inode->fragment_size) %
+			    Z_EROFS_MULTICOMPRESS_SEGSIZE;
+	if (!cfg.c_multithread ||
+	    inode->i_size <= Z_EROFS_MULTICOMPRESS_SEGSIZE) {
+		return erofs_write_compressed_file_single(inode, fd);
+	}
+
+	int nsegs = DIV_ROUND_UP(inode->i_size, Z_EROFS_MULTICOMPRESS_SEGSIZE);
+	int nthread = min_t(int, nsegs, Z_EROFS_MULTICOMPRESS_MAX_NTHREADS);
+	pthread_t threads[Z_EROFS_MULTICOMPRESS_MAX_NTHREADS];
+	struct z_erofs_multicompress_ret *segs_ret;
+	u8 *compressmeta;
+	erofs_blk_t *compressed_blocks_total;
+
+	compressed_blocks_total = malloc(sizeof(erofs_blk_t) * nsegs);
+	if (!compressed_blocks_total)
+		return -ENOMEM;
+
+	segs_ret = malloc(sizeof(struct z_erofs_multicompress_ret) * nsegs);
+	if (!segs_ret) {
+		ret = -ENOMEM;
+		goto err_free_compressed_blks_total;
+	}
+
+	compressmeta = malloc(BLK_ROUND_UP(sbi, inode->i_size) *
+				      sizeof(struct z_erofs_lcluster_index) +
+			      Z_EROFS_LEGACY_MAP_HEADER_SIZE);
+	if (!compressmeta) {
+		ret = -ENOMEM;
+		goto err_free_segs_ret;
+	}
+
+	/* allocate main data buffer */
+	bh = erofs_balloc(DATA, 0, 0, 0);
+	if (IS_ERR(bh)) {
+		ret = PTR_ERR(bh);
+		goto err_free_meta;
+	}
+
+	/* initialize per-file compression setting */
+	inode->z_advise = 0;
+	inode->z_logical_clusterbits = sbi->blkszbits;
+	if (!cfg.c_legacy_compress && inode->z_logical_clusterbits <= 14) {
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
+	if (cfg.c_fragments && !cfg.c_dedupe)
+		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
+
+#ifndef NDEBUG
+	if (cfg.c_random_algorithms) {
+		while (1) {
+			inode->z_algorithmtype[0] =
+				rand() % EROFS_MAX_COMPR_CFGS;
+			if (erofs_ccfg[inode->z_algorithmtype[0]].enable)
+				break;
+		}
+	}
+#endif
+	inode->z_algorithmtype[0] =
+		(&erofs_ccfg[inode->z_algorithmtype[0]])[0].algorithmtype;
+	inode->z_algorithmtype[1] = 0;
+
+	inode->idata_size = 0;
+	inode->fragment_size = 0;
+
+	/*
+	 * Handle tails in advance to avoid writing duplicated
+	 * parts into the packed inode.
+	 */
+	if (cfg.c_fragments && !erofs_is_packed_inode(inode)) {
+		ret = z_erofs_fragments_dedupe(inode, fd, &tof_chksum);
+		if (ret < 0)
+			goto err_bdrop;
+	}
+
+	blkaddr = erofs_mapbh(bh->block); /* start_blkaddr */
+
+	if (cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
+	    !inode->fragment_size) {
+		ret = z_erofs_pack_file_from_fd(inode, fd, tof_chksum);
+	} else {
+		for (int i = 0; i < nthread; i++) {
+			struct z_erofs_vle_compress_ctx *ctx = ctxs + i;
+			struct z_erofs_multicompress *mctx = &ctx->mctx;
+
+			ctx->inode = inode;
+			ctx->pclustersize = z_erofs_get_max_pclustersize(inode);
+			ctx->blkaddr = blkaddr;
+			ctx->ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
+			ctx->tof_chksum = tof_chksum;
+
+			mctx->fd = fd;
+			mctx->thread_idx = i;
+			mctx->thread_num = nthread;
+			mctx->seg_num = nsegs;
+			mctx->segs_ret = segs_ret;
+			mctx->last_seg_size = last_seg_size;
+			mctx->compressmeta = compressmeta;
+
+			pthread_create(&threads[i], NULL,
+				       erofs_multicompress_worker, ctx);
+		}
+		for (int i = 0; i < nthread; i++) {
+			pthread_join(threads[i], NULL);
+		}
+
+		ret = z_erofs_multicompress_merge(sbi, nsegs, blkaddr,
+					  compressed_blocks_total,
+					  &compressed_blocks, segs_ret);
+		if (ret)
+			goto err_bdrop;
+	}
+
+	legacymetasize = ctxs[(nsegs - 1) % nthread].metacur - compressmeta;
+	/* estimate if data compression saves space or not */
+	if (!inode->fragment_size && compressed_blocks * erofs_blksiz(sbi) +
+						     inode->idata_size +
+						     legacymetasize >=
+					     inode->i_size) {
+		z_erofs_dedupe_commit(true);
+		ret = -ENOSPC;
+		goto err_free_idata;
+	}
+	z_erofs_dedupe_commit(false);
+	z_erofs_write_mapheader(inode, compressmeta);
+
+	z_erofs_multicompress_fix_index(inode, compressmeta, legacymetasize,
+				compressed_blocks_total);
+
+	/* if the entire file is a fragment, a simplified form is used. */
+	if (inode->i_size == inode->fragment_size) {
+		DBG_BUGON(inode->fragmentoff >> 63);
+		*(__le64 *)compressmeta =
+			cpu_to_le64(inode->fragmentoff | 1ULL << 63);
+		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
+		legacymetasize = Z_EROFS_LEGACY_MAP_HEADER_SIZE;
+	}
+
+	if (compressed_blocks) {
+		ret = erofs_bh_balloon(bh, erofs_pos(sbi, compressed_blocks));
+		DBG_BUGON(ret != erofs_blksiz(sbi));
+	} else {
+		if (!cfg.c_fragments && !cfg.c_dedupe)
+			DBG_BUGON(!inode->idata_size);
+	}
+
+	erofs_info("compressed %s (%llu bytes) into %u blocks",
+		   inode->i_srcpath, (unsigned long long)inode->i_size,
+		   compressed_blocks);
+
+	if (inode->idata_size) {
+		bh->op = &erofs_skip_write_bhops;
+		inode->bh_data = bh;
+	} else {
+		erofs_bdrop(bh, false);
+	}
+
+	inode->u.i_blocks = compressed_blocks;
+
+	if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL) {
+		inode->extent_isize = legacymetasize;
+	} else {
+		ret = z_erofs_convert_to_compacted_format(
+			inode, blkaddr, legacymetasize, compressmeta);
+		DBG_BUGON(ret);
+	}
+	inode->compressmeta = compressmeta;
+	if (!erofs_is_packed_inode(inode))
+		erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
+	return 0;
+
+err_free_idata:
+	if (inode->idata) {
+		free(inode->idata);
+		inode->idata = NULL;
+	}
+err_bdrop:
+	erofs_bdrop(bh, true); /* revoke buffer */
+err_free_meta:
+	free(compressmeta);
+err_free_segs_ret:
+	free(segs_ret);
+err_free_compressed_blks_total:
+	free(compressed_blocks_total);
+	return ret;
+}
+
+int erofs_write_compressed_file_single(struct erofs_inode *inode, int fd)
 {
 	struct erofs_buffer_head *bh;
 	static struct z_erofs_vle_compress_ctx ctx;
+	struct z_erofs_multicompress *mctx = &ctx.mctx;
 	erofs_blk_t blkaddr, compressed_blocks;
 	unsigned int legacymetasize;
 	int ret;
@@ -922,6 +1339,9 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	ctx.remaining = inode->i_size - inode->fragment_size;
 	ctx.fix_dedupedfrag = false;
 	ctx.fragemitted = false;
+	mctx->fd = fd;
+	mctx->thread_idx = mctx->seg_idx = 0;
+	mctx->thread_num = mctx->seg_num = 1;
 	if (cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
 	    !inode->fragment_size) {
 		ret = z_erofs_pack_file_from_fd(inode, fd, ctx.tof_chksum);
@@ -1109,21 +1529,23 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 
 int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh)
 {
-	int i, ret;
+	int i, j, ret;
 
 	for (i = 0; cfg.c_compr_alg[i]; ++i) {
-		struct erofs_compress *c = &erofs_ccfg[i].handle;
+		for (j = 0; j < Z_EROFS_MULTICOMPRESS_MAX_NTHREADS; j++) {
+			struct erofs_compress *c = &erofs_ccfg[i].handle[j];
 
-		ret = erofs_compressor_init(sbi, c, cfg.c_compr_alg[i]);
-		if (ret)
-			return ret;
+			ret = erofs_compressor_init(sbi, c, cfg.c_compr_alg[i]);
+			if (ret)
+				return ret;
 
-		ret = erofs_compressor_setlevel(c, cfg.c_compr_level[i]);
-		if (ret)
-			return ret;
+			ret = erofs_compressor_setlevel(c, cfg.c_compr_level[i]);
+			if (ret)
+				return ret;
+		}
 
 		erofs_ccfg[i].algorithmtype =
-			z_erofs_get_compress_algorithm_id(c);
+			z_erofs_get_compress_algorithm_id(&erofs_ccfg[i].handle[0]);
 		erofs_ccfg[i].enable = true;
 		sbi->available_compr_algs |= 1 << erofs_ccfg[i].algorithmtype;
 		if (erofs_ccfg[i].algorithmtype != Z_EROFS_COMPRESSION_LZ4)
@@ -1148,8 +1570,6 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	if (cfg.c_pclusterblks_max > 1) {
 		if (cfg.c_pclusterblks_max >
 		    Z_EROFS_PCLUSTER_MAX_SIZE / erofs_blksiz(sbi)) {
-			erofs_err("unsupported clusterblks %u (too large)",
-				  cfg.c_pclusterblks_max);
 			return -EINVAL;
 		}
 		erofs_sb_set_big_pcluster(sbi);
@@ -1169,9 +1589,11 @@ int z_erofs_compress_exit(void)
 	int i, ret;
 
 	for (i = 0; cfg.c_compr_alg[i]; ++i) {
-		ret = erofs_compressor_exit(&erofs_ccfg[i].handle);
-		if (ret)
-			return ret;
+		for (int j = 0; j < Z_EROFS_MULTICOMPRESS_MAX_NTHREADS; j++) {
+			ret = erofs_compressor_exit(&erofs_ccfg[i].handle[j]);
+			if (ret)
+				return ret;
+		}
 	}
 	return 0;
 }
diff --git a/lib/compressor.h b/lib/compressor.h
index 9fa01d1..d99f451 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -9,6 +9,8 @@
 
 #include "erofs/defs.h"
 
+#define Z_EROFS_MULTICOMPRESS_MAX_NTHREADS (8)
+
 struct erofs_compress;
 
 struct erofs_compressor {
diff --git a/mkfs/main.c b/mkfs/main.c
index c03a7a8..01d7da5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -58,6 +58,7 @@ static struct option long_options[] = {
 	{"aufs", no_argument, NULL, 21},
 	{"mount-point", required_argument, NULL, 512},
 	{"xattr-prefix", required_argument, NULL, 19},
+	{"multithread", no_argument, NULL, 22},
 #ifdef WITH_ANDROID
 	{"product-out", required_argument, NULL, 513},
 	{"fs-config-file", required_argument, NULL, 514},
@@ -121,6 +122,7 @@ static void usage(void)
 #endif
 	      " --xattr-prefix=X      X=extra xattr name prefix\n"
 	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
+	      " --multithread         enable multithread compression\n"
 #ifdef WITH_ANDROID
 	      "\nwith following android-specific options:\n"
 	      " --product-out=X       X=product_out directory\n"
@@ -496,6 +498,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 21:
 			erofstar.aufs = true;
 			break;
+		case 22:
+			cfg.c_multithread = true;
+			break;
 		case 1:
 			usage();
 			exit(0);
-- 
2.41.0

