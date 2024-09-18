Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C0097BEA0
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Sep 2024 17:30:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X82fM6ymbz2yFP
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Sep 2024 01:30:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726673432;
	cv=none; b=eSUs1U1Fisk+ipYowZt2QEBhMx2i1fOiVnkPNfjCu2nzK3TCmDYFrfJ9kODPosa+a5mus6GvnER2h2y2R1gyOZInndFUV6OeI2Px1LHwIUevhA7eE9ExePcU8dClREIkp8ZTd94w0L8jjGh4OfjDAa/sQFQx4hN1R7okyieyDwBO8aUW0nfEt77+E0XK+f/CTBUNlxQPzI8ltro4IledU8iFjBCAyuP1ne7hA+DB6uckHkEF8sBs/tTEsC+nKCyNQ1b1INJ0PYqfpGzki1hZiAYYTClwyGp+Rmu+u/+mslFhVdBgeGmYXM2oSfomz+bz4HDWGP7oF1VIX5UUjcQGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726673432; c=relaxed/relaxed;
	bh=qPJF3fy5L/ZtJT8Mmjyuiord3Dg41JCGk1OFhANmIbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ra77JiZRRPew6E+Y4l61yANNWYm7n7Dk8T7v3qpfkBjiT4NksiIbkmhIZlTWQw6vlVTJjqQ3T0IO0IpVS22uXaTbKYHzXI6WpTvBRFgPKrjkmXTchGMPZ/Ot6MV9kQedJeOQaHoY9zD3r7W09Hwq9CjwytH2C9aIfDB6CckdDfMgW3G4EY9qUN4NCGhI0nCDIipv1eiFz1NXZJ5sqI8R9/37+Y5nrNmnS3YkuAfjLph3UQyzaa3hcvihsj/cYYrEhxFU51m8xMWoV7ATkhECe4bc+G5QfYIkyx8qaw9tgSJsNCeo5R3XTjkBnM5Yh2/Chzvjazvd85yD4t14AUPUsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SuIHUO9G; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SuIHUO9G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X82fG67r8z2xJJ
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Sep 2024 01:30:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726673423; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qPJF3fy5L/ZtJT8Mmjyuiord3Dg41JCGk1OFhANmIbI=;
	b=SuIHUO9GYYx8HU4GkO6oNg/ehkQnBPX9WBuQKC+IfFEl1UIhXI3QUUlmlDvOs2K+HxLMWAEGak5o6uaSwiYZFQcXYWrWwz3W9zUq301ZVW03g/osxo/YdqBdbckfj9jivNQ0fylj7f7+Pwmk4T2tdf6daVBqrWs5kcINmWRrihE=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WFEltrQ_1726673421)
          by smtp.aliyun-inc.com;
          Wed, 18 Sep 2024 23:30:21 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: rename `cfg` to `g_cfg`
Date: Wed, 18 Sep 2024 23:30:11 +0800
Message-ID: <20240918153012.3559343-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Rename the global variable `cfg` to `g_cfg` in preparation for
the per-superblock configuration.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 dump/main.c              |   8 +-
 fsck/main.c              |  12 +--
 fuse/main.c              |  10 +-
 include/erofs/config.h   |   2 +-
 include/erofs/print.h    |   8 +-
 lib/blobchunk.c          |   2 +-
 lib/block_list.c         |   8 +-
 lib/compress.c           |  82 +++++++-------
 lib/compress_hints.c     |  16 +--
 lib/compressor_liblzma.c |   2 +-
 lib/compressor_libzstd.c |   2 +-
 lib/config.c             |  54 +++++-----
 lib/inode.c              |  62 +++++------
 lib/io.c                 |  12 +--
 lib/xattr.c              |  20 ++--
 mkfs/main.c              | 228 +++++++++++++++++++--------------------
 16 files changed, 264 insertions(+), 264 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 372162e..e85b853 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -131,7 +131,7 @@ static void usage(int argc, char **argv)
 
 static void erofsdump_print_version(void)
 {
-	printf("dump.erofs (erofs-utils) %s\n", cfg.c_version);
+	printf("dump.erofs (erofs-utils) %s\n", g_cfg.c_version);
 }
 
 static int erofsdump_parse_options_cfg(int argc, char **argv)
@@ -196,8 +196,8 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 		return -EINVAL;
 	}
 
-	cfg.c_img_path = strdup(argv[optind++]);
-	if (!cfg.c_img_path)
+	g_cfg.c_img_path = strdup(argv[optind++]);
+	if (!g_cfg.c_img_path)
 		return -ENOMEM;
 
 	if (optind < argc) {
@@ -684,7 +684,7 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDONLY | O_TRUNC);
+	err = erofs_dev_open(&g_sbi, g_cfg.c_img_path, O_RDONLY | O_TRUNC);
 	if (err) {
 		erofs_err("failed to open image file");
 		goto exit;
diff --git a/fsck/main.c b/fsck/main.c
index f20b767..6096683 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -124,7 +124,7 @@ static void usage(int argc, char **argv)
 static void erofsfsck_print_version(void)
 {
 	printf("fsck.erofs (erofs-utils) %s\navailable decompressors: ",
-	       cfg.c_version);
+	       g_cfg.c_version);
 	print_available_decompressors(stdout, ", ");
 }
 
@@ -146,7 +146,7 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 				erofs_err("invalid debug level %d", ret);
 				return -EINVAL;
 			}
-			cfg.c_dbg_lvl = ret;
+			g_cfg.c_dbg_lvl = ret;
 			break;
 		case 'p':
 			fsckcfg.print_comp_ratio = true;
@@ -267,8 +267,8 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 		return -EINVAL;
 	}
 
-	cfg.c_img_path = strdup(argv[optind++]);
-	if (!cfg.c_img_path)
+	g_cfg.c_img_path = strdup(argv[optind++]);
+	if (!g_cfg.c_img_path)
 		return -ENOMEM;
 
 	if (optind < argc) {
@@ -1074,10 +1074,10 @@ int main(int argc, char *argv[])
 	}
 
 #ifdef FUZZING
-	cfg.c_dbg_lvl = -1;
+	g_cfg.c_dbg_lvl = -1;
 #endif
 
-	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDONLY);
+	err = erofs_dev_open(&g_sbi, g_cfg.c_img_path, O_RDONLY);
 	if (err) {
 		erofs_err("failed to open image file");
 		goto exit;
diff --git a/fuse/main.c b/fuse/main.c
index f6c04e8..bb92a7b 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -643,8 +643,8 @@ int main(int argc, char *argv[])
 #endif
 
 	erofs_init_configure();
-	fusecfg.debug_lvl = cfg.c_dbg_lvl;
-	printf("erofsfuse %s\n", cfg.c_version);
+	fusecfg.debug_lvl = g_cfg.c_dbg_lvl;
+	printf("erofsfuse %s\n", g_cfg.c_version);
 
 #if defined(HAVE_EXECINFO_H) && defined(HAVE_BACKTRACE)
 	if (signal(SIGSEGV, signal_handle_sigsegv) == SIG_ERR) {
@@ -670,10 +670,10 @@ int main(int argc, char *argv[])
 
 	if (fusecfg.show_help || fusecfg.show_version || !opts.mountpoint)
 		usage();
-	cfg.c_dbg_lvl = fusecfg.debug_lvl;
+	g_cfg.c_dbg_lvl = fusecfg.debug_lvl;
 
-	if (fusecfg.odebug && cfg.c_dbg_lvl < EROFS_DBG)
-		cfg.c_dbg_lvl = EROFS_DBG;
+	if (fusecfg.odebug && g_cfg.c_dbg_lvl < EROFS_DBG)
+		g_cfg.c_dbg_lvl = EROFS_DBG;
 
 	g_sbi.bdev.offset = fusecfg.offset;
 	ret = erofs_dev_open(&g_sbi, fusecfg.disk, O_RDONLY);
diff --git a/include/erofs/config.h b/include/erofs/config.h
index ae366c1..41d6c54 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -96,7 +96,7 @@ struct erofs_configure {
 #endif
 };
 
-extern struct erofs_configure cfg;
+extern struct erofs_configure g_cfg;
 
 void erofs_init_configure(void);
 void erofs_show_config(void);
diff --git a/include/erofs/print.h b/include/erofs/print.h
index a896d75..c42cdf2 100644
--- a/include/erofs/print.h
+++ b/include/erofs/print.h
@@ -44,7 +44,7 @@ enum {
 void erofs_msg(int dbglv, const char *fmt, ...);
 
 #define erofs_dbg(fmt, ...) do {			\
-	if (cfg.c_dbg_lvl >= EROFS_DBG) {		\
+	if (g_cfg.c_dbg_lvl >= EROFS_DBG) {		\
 		erofs_msg(EROFS_DBG,			\
 			  "<D> " PR_FMT_FUNC_LINE(fmt),	\
 			  ##__VA_ARGS__);		\
@@ -52,7 +52,7 @@ void erofs_msg(int dbglv, const char *fmt, ...);
 } while (0)
 
 #define erofs_info(fmt, ...) do {			\
-	if (cfg.c_dbg_lvl >= EROFS_INFO) {		\
+	if (g_cfg.c_dbg_lvl >= EROFS_INFO) {		\
 		erofs_msg(EROFS_INFO,			\
 			  "<I> " PR_FMT_FUNC_LINE(fmt),	\
 			  ##__VA_ARGS__);		\
@@ -61,7 +61,7 @@ void erofs_msg(int dbglv, const char *fmt, ...);
 } while (0)
 
 #define erofs_warn(fmt, ...) do {			\
-	if (cfg.c_dbg_lvl >= EROFS_WARN) {		\
+	if (g_cfg.c_dbg_lvl >= EROFS_WARN) {		\
 		erofs_msg(EROFS_WARN,			\
 			  "<W> " PR_FMT_FUNC_LINE(fmt),	\
 			  ##__VA_ARGS__);		\
@@ -70,7 +70,7 @@ void erofs_msg(int dbglv, const char *fmt, ...);
 } while (0)
 
 #define erofs_err(fmt, ...) do {			\
-	if (cfg.c_dbg_lvl >= EROFS_ERR) {		\
+	if (g_cfg.c_dbg_lvl >= EROFS_ERR) {		\
 		erofs_msg(EROFS_ERR,			\
 			  "<E> " PR_FMT_FUNC_LINE(fmt),	\
 			  ##__VA_ARGS__);		\
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 6c2ea0e..90e3b28 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -261,7 +261,7 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 				  erofs_off_t startoff)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
-	unsigned int chunkbits = cfg.c_chunkbits;
+	unsigned int chunkbits = g_cfg.c_chunkbits;
 	unsigned int count, unit;
 	struct erofs_blobchunk *chunk, *lastch;
 	struct erofs_inode_chunk_index *idx;
diff --git a/lib/block_list.c b/lib/block_list.c
index 261e9ff..d745ea2 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -49,7 +49,7 @@ static void blocklist_write(const char *path, erofs_blk_t blk_start,
 	const char *fspath = erofs_fspath(path);
 
 	if (first_extent) {
-		fprintf(block_list_fp, "/%s", cfg.mount_point);
+		fprintf(block_list_fp, "/%s", g_cfg.mount_point);
 
 		if (fspath[0] != '/')
 			fprintf(block_list_fp, "/");
@@ -72,7 +72,7 @@ void erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
 					erofs_blk_t nblocks, bool first_extent,
 					bool last_extent)
 {
-	if (!block_list_fp || !cfg.mount_point)
+	if (!block_list_fp || !g_cfg.mount_point)
 		return;
 
 	if (!nblocks) {
@@ -88,7 +88,7 @@ void erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
 void erofs_droid_blocklist_write(struct erofs_inode *inode,
 				 erofs_blk_t blk_start, erofs_blk_t nblocks)
 {
-	if (!block_list_fp || !cfg.mount_point || !nblocks)
+	if (!block_list_fp || !g_cfg.mount_point || !nblocks)
 		return;
 
 	blocklist_write(inode->i_srcpath, blk_start, nblocks,
@@ -98,7 +98,7 @@ void erofs_droid_blocklist_write(struct erofs_inode *inode,
 void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
 					  erofs_blk_t blkaddr)
 {
-	if (!block_list_fp || !cfg.mount_point)
+	if (!block_list_fp || !g_cfg.mount_point)
 		return;
 
 	/* XXX: a bit hacky.. may need a better approach */
diff --git a/lib/compress.c b/lib/compress.c
index 17e7112..ea47927 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -152,7 +152,7 @@ static void z_erofs_write_extent(struct z_erofs_compress_ictx *ctx,
 		 * A lcluster cannot have three parts with the middle one which
 		 * is well-compressed for !ztailpacking cases.
 		 */
-		DBG_BUGON(!e->raw && !cfg.c_ztailpacking && !cfg.c_fragments);
+		DBG_BUGON(!e->raw && !g_cfg.c_ztailpacking && !g_cfg.c_fragments);
 		DBG_BUGON(e->partial);
 		type = e->raw ? Z_EROFS_LCLUSTER_TYPE_PLAIN :
 			Z_EROFS_LCLUSTER_TYPE_HEAD1;
@@ -416,20 +416,20 @@ static int write_uncompressed_extent(struct z_erofs_compress_sctx *ctx,
 static unsigned int z_erofs_get_max_pclustersize(struct erofs_inode *inode)
 {
 	if (erofs_is_packed_inode(inode)) {
-		return cfg.c_mkfs_pclustersize_packed;
+		return g_cfg.c_mkfs_pclustersize_packed;
 #ifndef NDEBUG
-	} else if (cfg.c_random_pclusterblks) {
+	} else if (g_cfg.c_random_pclusterblks) {
 		unsigned int pclusterblks =
-			cfg.c_mkfs_pclustersize_max >> inode->sbi->blkszbits;
+			g_cfg.c_mkfs_pclustersize_max >> inode->sbi->blkszbits;
 
 		return (1 + rand() % pclusterblks) << inode->sbi->blkszbits;
 #endif
-	} else if (cfg.c_compress_hints_file) {
+	} else if (g_cfg.c_compress_hints_file) {
 		z_erofs_apply_compress_hints(inode);
 		DBG_BUGON(!inode->z_physical_clusterblks);
 		return inode->z_physical_clusterblks << inode->sbi->blkszbits;
 	}
-	return cfg.c_mkfs_pclustersize_def;
+	return g_cfg.c_mkfs_pclustersize_def;
 }
 
 static int z_erofs_fill_inline_data(struct erofs_inode *inode, void *data,
@@ -521,9 +521,9 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	unsigned int len = ctx->tail - ctx->head;
 	bool is_packed_inode = erofs_is_packed_inode(inode);
 	bool tsg = (ctx->seg_idx + 1 >= ictx->seg_num), final = !ctx->remaining;
-	bool may_packing = (cfg.c_fragments && tsg && final &&
+	bool may_packing = (g_cfg.c_fragments && tsg && final &&
 			    !is_packed_inode && !z_erofs_mt_enabled);
-	bool may_inline = (cfg.c_ztailpacking && tsg && final && !may_packing);
+	bool may_inline = (g_cfg.c_ztailpacking && tsg && final && !may_packing);
 	unsigned int compressedsize;
 	int ret;
 
@@ -543,7 +543,7 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 			goto nocompression;
 	}
 
-	e->length = min(len, cfg.c_max_decompressed_extent_bytes);
+	e->length = min(len, g_cfg.c_max_decompressed_extent_bytes);
 	ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
 				      &e->length, dst, ctx->pclustersize);
 	if (ret <= 0) {
@@ -1114,7 +1114,7 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 		ret = erofs_bh_balloon(bh, erofs_pos(sbi, compressed_blocks));
 		DBG_BUGON(ret != erofs_blksiz(sbi));
 	} else {
-		if (!cfg.c_fragments && !cfg.c_dedupe)
+		if (!g_cfg.c_fragments && !g_cfg.c_dedupe)
 			DBG_BUGON(!inode->idata_size);
 	}
 
@@ -1253,7 +1253,7 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 	}
 	sctx->memoff = 0;
 
-	ret = z_erofs_compress_segment(sctx, sctx->seg_idx * cfg.c_mkfs_segment_size,
+	ret = z_erofs_compress_segment(sctx, sctx->seg_idx * g_cfg.c_mkfs_segment_size,
 				       EROFS_NULL_ADDR);
 
 out:
@@ -1304,7 +1304,7 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 	struct erofs_compress_work *cur, *head = NULL, **last = &head;
 	struct erofs_compress_cfg *ccfg = ictx->ccfg;
 	struct erofs_inode *inode = ictx->inode;
-	int nsegs = DIV_ROUND_UP(inode->i_size, cfg.c_mkfs_segment_size);
+	int nsegs = DIV_ROUND_UP(inode->i_size, g_cfg.c_mkfs_segment_size);
 	int i;
 
 	ictx->seg_num = nsegs;
@@ -1338,9 +1338,9 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 		if (i == nsegs - 1)
 			cur->ctx.remaining = inode->i_size -
 					      inode->fragment_size -
-					      i * cfg.c_mkfs_segment_size;
+					      i * g_cfg.c_mkfs_segment_size;
 		else
-			cur->ctx.remaining = cfg.c_mkfs_segment_size;
+			cur->ctx.remaining = g_cfg.c_mkfs_segment_size;
 
 		cur->alg_id = ccfg->handle.alg->id;
 		cur->alg_name = ccfg->handle.alg->name;
@@ -1424,7 +1424,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	/* initialize per-file compression setting */
 	inode->z_advise = 0;
 	inode->z_logical_clusterbits = sbi->blkszbits;
-	if (!cfg.c_legacy_compress && inode->z_logical_clusterbits <= 14) {
+	if (!g_cfg.c_legacy_compress && inode->z_logical_clusterbits <= 14) {
 		if (inode->z_logical_clusterbits <= 12)
 			inode->z_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
 		inode->datalayout = EROFS_INODE_COMPRESSED_COMPACT;
@@ -1437,11 +1437,11 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 		if (inode->datalayout == EROFS_INODE_COMPRESSED_COMPACT)
 			inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
 	}
-	if (cfg.c_fragments && !cfg.c_dedupe)
+	if (g_cfg.c_fragments && !g_cfg.c_dedupe)
 		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 
 #ifndef NDEBUG
-	if (cfg.c_random_algorithms) {
+	if (g_cfg.c_random_algorithms) {
 		while (1) {
 			inode->z_algorithmtype[0] =
 				rand() % EROFS_MAX_COMPR_CFGS;
@@ -1478,7 +1478,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	 * Handle tails in advance to avoid writing duplicated
 	 * parts into the packed inode.
 	 */
-	if (cfg.c_fragments && !erofs_is_packed_inode(inode)) {
+	if (g_cfg.c_fragments && !erofs_is_packed_inode(inode)) {
 		ret = z_erofs_fragments_dedupe(inode, fd, &ictx->tof_chksum);
 		if (ret < 0)
 			goto err_free_ictx;
@@ -1490,7 +1490,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	ictx->fix_dedupedfrag = false;
 	ictx->fragemitted = false;
 
-	if (cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
+	if (g_cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
 	    !inode->fragment_size) {
 		ret = z_erofs_pack_file_from_fd(inode, fd, ictx->tof_chksum);
 		if (ret)
@@ -1593,7 +1593,7 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 				.max_distance =
 					cpu_to_le16(sbi->lz4.max_distance),
 				.max_pclusterblks =
-					cfg.c_mkfs_pclustersize_max >> sbi->blkszbits,
+					g_cfg.c_mkfs_pclustersize_max >> sbi->blkszbits,
 			}
 		};
 
@@ -1688,12 +1688,12 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	u32 max_dict_size[Z_EROFS_COMPRESSION_MAX] = {};
 	u32 available_compr_algs = 0;
 
-	for (i = 0; cfg.c_compr_opts[i].alg; ++i) {
+	for (i = 0; g_cfg.c_compr_opts[i].alg; ++i) {
 		struct erofs_compress *c = &erofs_ccfg[i].handle;
 
-		ret = erofs_compressor_init(sbi, c, cfg.c_compr_opts[i].alg,
-					    cfg.c_compr_opts[i].level,
-					    cfg.c_compr_opts[i].dict_size);
+		ret = erofs_compressor_init(sbi, c, g_cfg.c_compr_opts[i].alg,
+					    g_cfg.c_compr_opts[i].level,
+					    g_cfg.c_compr_opts[i].dict_size);
 		if (ret)
 			return ret;
 
@@ -1712,7 +1712,7 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	 * clear 0PADDING feature for old kernel compatibility.
 	 */
 	if (!available_compr_algs ||
-	    (cfg.c_legacy_compress && available_compr_algs == 1))
+	    (g_cfg.c_legacy_compress && available_compr_algs == 1))
 		erofs_sb_clear_lz4_0padding(sbi);
 
 	if (!available_compr_algs)
@@ -1728,9 +1728,9 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 		}
 		if (available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZ4) &&
 		    sbi->lz4.max_pclusterblks << sbi->blkszbits <
-			cfg.c_mkfs_pclustersize_max) {
+			g_cfg.c_mkfs_pclustersize_max) {
 			erofs_err("pclustersize %u is too large on incremental builds",
-				  cfg.c_mkfs_pclustersize_max);
+				  g_cfg.c_mkfs_pclustersize_max);
 			return -EOPNOTSUPP;
 		}
 	} else {
@@ -1741,17 +1741,17 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	 * if big pcluster is enabled, an extra CBLKCNT lcluster index needs
 	 * to be loaded in order to get those compressed block counts.
 	 */
-	if (cfg.c_mkfs_pclustersize_max > erofs_blksiz(sbi)) {
-		if (cfg.c_mkfs_pclustersize_max > Z_EROFS_PCLUSTER_MAX_SIZE) {
+	if (g_cfg.c_mkfs_pclustersize_max > erofs_blksiz(sbi)) {
+		if (g_cfg.c_mkfs_pclustersize_max > Z_EROFS_PCLUSTER_MAX_SIZE) {
 			erofs_err("unsupported pclustersize %u (too large)",
-				  cfg.c_mkfs_pclustersize_max);
+				  g_cfg.c_mkfs_pclustersize_max);
 			return -EINVAL;
 		}
 		erofs_sb_set_big_pcluster(sbi);
 	}
-	if (cfg.c_mkfs_pclustersize_packed > cfg.c_mkfs_pclustersize_max) {
+	if (g_cfg.c_mkfs_pclustersize_packed > g_cfg.c_mkfs_pclustersize_max) {
 		erofs_err("invalid pclustersize for the packed file %u",
-			  cfg.c_mkfs_pclustersize_packed);
+			  g_cfg.c_mkfs_pclustersize_packed);
 		return -EINVAL;
 	}
 
@@ -1763,19 +1763,19 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 
 	z_erofs_mt_enabled = false;
 #ifdef EROFS_MT_ENABLED
-	if (cfg.c_mt_workers >= 1 && (cfg.c_dedupe ||
-				      (cfg.c_fragments && !cfg.c_all_fragments))) {
-		if (cfg.c_dedupe)
+	if (g_cfg.c_mt_workers >= 1 && (g_cfg.c_dedupe ||
+				      (g_cfg.c_fragments && !g_cfg.c_all_fragments))) {
+		if (g_cfg.c_dedupe)
 			erofs_warn("multi-threaded dedupe is NOT implemented for now");
-		if (cfg.c_fragments)
+		if (g_cfg.c_fragments)
 			erofs_warn("multi-threaded fragments is NOT implemented for now");
-		cfg.c_mt_workers = 0;
+		g_cfg.c_mt_workers = 0;
 	}
 
-	if (cfg.c_mt_workers >= 1) {
+	if (g_cfg.c_mt_workers >= 1) {
 		ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq,
-					    cfg.c_mt_workers,
-					    cfg.c_mt_workers << 2,
+					    g_cfg.c_mt_workers,
+					    g_cfg.c_mt_workers << 2,
 					    z_erofs_mt_wq_tls_alloc,
 					    z_erofs_mt_wq_tls_free);
 		z_erofs_mt_enabled = !ret;
@@ -1790,7 +1790,7 @@ int z_erofs_compress_exit(void)
 {
 	int i, ret;
 
-	for (i = 0; cfg.c_compr_opts[i].alg; ++i) {
+	for (i = 0; g_cfg.c_compr_opts[i].alg; ++i) {
 		ret = erofs_compressor_exit(&erofs_ccfg[i].handle);
 		if (ret)
 			return ret;
diff --git a/lib/compress_hints.c b/lib/compress_hints.c
index e79bd48..ae7c231 100644
--- a/lib/compress_hints.c
+++ b/lib/compress_hints.c
@@ -55,7 +55,7 @@ bool z_erofs_apply_compress_hints(struct erofs_inode *inode)
 		return true;
 
 	s = erofs_fspath(inode->i_srcpath);
-	pclusterblks = cfg.c_mkfs_pclustersize_def >> inode->sbi->blkszbits;
+	pclusterblks = g_cfg.c_mkfs_pclustersize_def >> inode->sbi->blkszbits;
 	algorithmtype = 0;
 
 	list_for_each_entry(r, &compress_hints_head, list) {
@@ -93,10 +93,10 @@ int erofs_load_compress_hints(struct erofs_sb_info *sbi)
 	unsigned int line, max_pclustersize = 0;
 	int ret = 0;
 
-	if (!cfg.c_compress_hints_file)
+	if (!g_cfg.c_compress_hints_file)
 		return 0;
 
-	f = fopen(cfg.c_compress_hints_file, "r");
+	f = fopen(g_cfg.c_compress_hints_file, "r");
 	if (!f)
 		return -errno;
 
@@ -125,7 +125,7 @@ int erofs_load_compress_hints(struct erofs_sb_info *sbi)
 		} else {
 			ccfg = atoi(alg);
 			if (ccfg >= EROFS_MAX_COMPR_CFGS ||
-			    !cfg.c_compr_opts[ccfg].alg) {
+			    !g_cfg.c_compr_opts[ccfg].alg) {
 				erofs_err("invalid compressing configuration \"%s\" at line %u",
 					  alg, line);
 				ret = -EINVAL;
@@ -136,7 +136,7 @@ int erofs_load_compress_hints(struct erofs_sb_info *sbi)
 		if (pclustersize % erofs_blksiz(sbi)) {
 			erofs_warn("invalid physical clustersize %u, "
 				   "use default pclusterblks %u",
-				   pclustersize, cfg.c_mkfs_pclustersize_def);
+				   pclustersize, g_cfg.c_mkfs_pclustersize_def);
 			continue;
 		}
 		erofs_insert_compress_hints(pattern,
@@ -146,10 +146,10 @@ int erofs_load_compress_hints(struct erofs_sb_info *sbi)
 			max_pclustersize = pclustersize;
 	}
 
-	if (cfg.c_mkfs_pclustersize_max < max_pclustersize) {
-		cfg.c_mkfs_pclustersize_max = max_pclustersize;
+	if (g_cfg.c_mkfs_pclustersize_max < max_pclustersize) {
+		g_cfg.c_mkfs_pclustersize_max = max_pclustersize;
 		erofs_warn("update max pclustersize to %u",
-			   cfg.c_mkfs_pclustersize_max);
+			   g_cfg.c_mkfs_pclustersize_max);
 	}
 out:
 	fclose(f);
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index d609a28..4b0b069 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -75,7 +75,7 @@ static int erofs_compressor_liblzma_setdictsize(struct erofs_compress *c,
 			dict_size = erofs_compressor_lzma.default_dictsize;
 		} else {
 			dict_size = min_t(u32, Z_EROFS_LZMA_MAX_DICT_SIZE,
-					  cfg.c_mkfs_pclustersize_max << 3);
+					  g_cfg.c_mkfs_pclustersize_max << 3);
 			if (dict_size < 32768)
 				dict_size = 32768;
 		}
diff --git a/lib/compressor_libzstd.c b/lib/compressor_libzstd.c
index 223806e..dfdb728 100644
--- a/lib/compressor_libzstd.c
+++ b/lib/compressor_libzstd.c
@@ -86,7 +86,7 @@ static int erofs_compressor_libzstd_setdictsize(struct erofs_compress *c,
 			dict_size = erofs_compressor_libzstd.default_dictsize;
 		} else {
 			dict_size = min_t(u32, Z_EROFS_ZSTD_MAX_DICT_SIZE,
-					  cfg.c_mkfs_pclustersize_max << 3);
+					  g_cfg.c_mkfs_pclustersize_max << 3);
 			dict_size = 1 << ilog2(dict_size);
 		}
 	}
diff --git a/lib/config.c b/lib/config.c
index 848bc59..353411a 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -18,30 +18,30 @@
 #include <unistd.h>
 #endif
 
-struct erofs_configure cfg;
+struct erofs_configure g_cfg;
 struct erofs_sb_info g_sbi;
 bool erofs_stdout_tty;
 
 void erofs_init_configure(void)
 {
-	memset(&cfg, 0, sizeof(cfg));
-
-	cfg.c_dbg_lvl  = EROFS_WARN;
-	cfg.c_version  = PACKAGE_VERSION;
-	cfg.c_dry_run  = false;
-	cfg.c_ignore_mtime = false;
-	cfg.c_force_inodeversion = 0;
-	cfg.c_inline_xattr_tolerance = 2;
-	cfg.c_unix_timestamp = -1;
-	cfg.c_uid = -1;
-	cfg.c_gid = -1;
-	cfg.c_max_decompressed_extent_bytes = -1;
+	memset(&g_cfg, 0, sizeof(g_cfg));
+
+	g_cfg.c_dbg_lvl  = EROFS_WARN;
+	g_cfg.c_version  = PACKAGE_VERSION;
+	g_cfg.c_dry_run  = false;
+	g_cfg.c_ignore_mtime = false;
+	g_cfg.c_force_inodeversion = 0;
+	g_cfg.c_inline_xattr_tolerance = 2;
+	g_cfg.c_unix_timestamp = -1;
+	g_cfg.c_uid = -1;
+	g_cfg.c_gid = -1;
+	g_cfg.c_max_decompressed_extent_bytes = -1;
 	erofs_stdout_tty = isatty(STDOUT_FILENO);
 }
 
 void erofs_show_config(void)
 {
-	const struct erofs_configure *c = &cfg;
+	const struct erofs_configure *c = &g_cfg;
 
 	if (c->c_dbg_lvl < EROFS_INFO)
 		return;
@@ -55,20 +55,20 @@ void erofs_exit_configure(void)
 	int i;
 
 #ifdef HAVE_LIBSELINUX
-	if (cfg.sehnd)
-		selabel_close(cfg.sehnd);
+	if (g_cfg.sehnd)
+		selabel_close(g_cfg.sehnd);
 #endif
-	if (cfg.c_img_path)
-		free(cfg.c_img_path);
-	if (cfg.c_src_path)
-		free(cfg.c_src_path);
-	for (i = 0; i < EROFS_MAX_COMPR_CFGS && cfg.c_compr_opts[i].alg; i++)
-		free(cfg.c_compr_opts[i].alg);
+	if (g_cfg.c_img_path)
+		free(g_cfg.c_img_path);
+	if (g_cfg.c_src_path)
+		free(g_cfg.c_src_path);
+	for (i = 0; i < EROFS_MAX_COMPR_CFGS && g_cfg.c_compr_opts[i].alg; i++)
+		free(g_cfg.c_compr_opts[i].alg);
 }
 
 struct erofs_configure *erofs_get_configure()
 {
-	return &cfg;
+	return &g_cfg;
 }
 
 static unsigned int fullpath_prefix;	/* root directory prefix length */
@@ -94,14 +94,14 @@ int erofs_selabel_open(const char *file_contexts)
 		{ .type = SELABEL_OPT_PATH, .value = file_contexts }
 	};
 
-	if (cfg.sehnd) {
+	if (g_cfg.sehnd) {
 		erofs_info("ignore duplicated file contexts \"%s\"",
 			   file_contexts);
 		return -EBUSY;
 	}
 
-	cfg.sehnd = selabel_open(SELABEL_CTX_FILE, seopts, 1);
-	if (!cfg.sehnd) {
+	g_cfg.sehnd = selabel_open(SELABEL_CTX_FILE, seopts, 1);
+	if (!g_cfg.sehnd) {
 		erofs_err("failed to open file contexts \"%s\"",
 			  file_contexts);
 		return -EINVAL;
@@ -166,7 +166,7 @@ void erofs_update_progressinfo(const char *fmt, ...)
 	char msg[8192];
 	va_list ap;
 
-	if (cfg.c_dbg_lvl >= EROFS_INFO || !cfg.c_showprogress)
+	if (g_cfg.c_dbg_lvl >= EROFS_INFO || !g_cfg.c_showprogress)
 		return;
 
 	va_start(ap, fmt);
diff --git a/lib/inode.c b/lib/inode.c
index bc3cb76..c3d2edb 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -507,7 +507,7 @@ int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 /* rules to decide whether a file could be compressed or not */
 static bool erofs_file_is_compressible(struct erofs_inode *inode)
 {
-	if (cfg.c_compress_hints_file)
+	if (g_cfg.c_compress_hints_file)
 		return z_erofs_apply_compress_hints(inode);
 	return true;
 }
@@ -557,11 +557,11 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 
 int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
 {
-	if (cfg.c_chunkbits) {
-		inode->u.chunkbits = cfg.c_chunkbits;
+	if (g_cfg.c_chunkbits) {
+		inode->u.chunkbits = g_cfg.c_chunkbits;
 		/* chunk indexes when explicitly specified */
 		inode->u.chunkformat = 0;
-		if (cfg.c_force_chunkformat == FORCE_INODE_CHUNK_INDEXES)
+		if (g_cfg.c_force_chunkformat == FORCE_INODE_CHUNK_INDEXES)
 			inode->u.chunkformat = EROFS_CHUNK_FORMAT_INDEXES;
 		return erofs_blob_write_chunked_file(inode, fd, fpos);
 	}
@@ -763,7 +763,7 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 		goto noinline;
 
 	if (!is_inode_layout_compression(inode)) {
-		if (!cfg.c_inline_data && S_ISREG(inode->i_mode)) {
+		if (!g_cfg.c_inline_data && S_ISREG(inode->i_mode)) {
 			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 			goto noinline;
 		}
@@ -796,7 +796,7 @@ noinline:
 		return PTR_ERR(bh);
 	} else if (inode->idata_size) {
 		if (is_inode_layout_compression(inode)) {
-			DBG_BUGON(!cfg.c_ztailpacking);
+			DBG_BUGON(!g_cfg.c_ztailpacking);
 			erofs_dbg("Inline %scompressed data (%u bytes) to %s",
 				  inode->compressed_idata ? "" : "un",
 				  inode->idata_size, inode->i_srcpath);
@@ -933,7 +933,7 @@ out:
 
 static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
 {
-	if (cfg.c_force_inodeversion == FORCE_INODE_EXTENDED)
+	if (g_cfg.c_force_inodeversion == FORCE_INODE_EXTENDED)
 		return true;
 	if (inode->i_size > UINT_MAX)
 		return true;
@@ -947,7 +947,7 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
 		return true;
 	if ((inode->i_mtime != inode->sbi->build_time ||
 	     inode->i_mtime_nsec != inode->sbi->build_time_nsec) &&
-	    !cfg.c_ignore_mtime)
+	    !g_cfg.c_ignore_mtime)
 		return true;
 	return false;
 }
@@ -972,30 +972,30 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 	char *decorated = NULL;
 
 	inode->capabilities = 0;
-	if (!cfg.fs_config_file && !cfg.mount_point)
+	if (!g_cfg.fs_config_file && !g_cfg.mount_point)
 		return 0;
 	/* avoid loading special inodes */
 	if (path == EROFS_PACKED_INODE)
 		return 0;
 
-	if (!cfg.mount_point ||
+	if (!g_cfg.mount_point ||
 	/* have to drop the mountpoint for rootdir of canned fsconfig */
-	    (cfg.fs_config_file && erofs_fspath(path)[0] == '\0')) {
+	    (g_cfg.fs_config_file && erofs_fspath(path)[0] == '\0')) {
 		fspath = erofs_fspath(path);
 	} else {
-		if (asprintf(&decorated, "%s/%s", cfg.mount_point,
+		if (asprintf(&decorated, "%s/%s", g_cfg.mount_point,
 			     erofs_fspath(path)) <= 0)
 			return -ENOMEM;
 		fspath = decorated;
 	}
 
-	if (cfg.fs_config_file)
+	if (g_cfg.fs_config_file)
 		canned_fs_config(fspath, S_ISDIR(st->st_mode),
-				 cfg.target_out_path,
+				 g_cfg.target_out_path,
 				 &uid, &gid, &mode, &inode->capabilities);
 	else
 		fs_config(fspath, S_ISDIR(st->st_mode),
-			  cfg.target_out_path,
+			  g_cfg.target_out_path,
 			  &uid, &gid, &mode, &inode->capabilities);
 
 	erofs_dbg("/%s -> mode = 0x%x, uid = 0x%x, gid = 0x%x, capabilities = 0x%" PRIx64,
@@ -1026,21 +1026,21 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 	if (err)
 		return err;
 
-	inode->i_uid = cfg.c_uid == -1 ? st->st_uid : cfg.c_uid;
-	inode->i_gid = cfg.c_gid == -1 ? st->st_gid : cfg.c_gid;
+	inode->i_uid = g_cfg.c_uid == -1 ? st->st_uid : g_cfg.c_uid;
+	inode->i_gid = g_cfg.c_gid == -1 ? st->st_gid : g_cfg.c_gid;
 
-	if (inode->i_uid + cfg.c_uid_offset < 0)
+	if (inode->i_uid + g_cfg.c_uid_offset < 0)
 		erofs_err("uid overflow @ %s", path);
-	inode->i_uid += cfg.c_uid_offset;
+	inode->i_uid += g_cfg.c_uid_offset;
 
-	if (inode->i_gid + cfg.c_gid_offset < 0)
+	if (inode->i_gid + g_cfg.c_gid_offset < 0)
 		erofs_err("gid overflow @ %s", path);
-	inode->i_gid += cfg.c_gid_offset;
+	inode->i_gid += g_cfg.c_gid_offset;
 
 	inode->i_mtime = st->st_mtime;
 	inode->i_mtime_nsec = ST_MTIM_NSEC(st);
 
-	switch (cfg.c_timeinherit) {
+	switch (g_cfg.c_timeinherit) {
 	case TIMESTAMP_CLAMPING:
 		if (inode->i_mtime < sbi->build_time)
 			break;
@@ -1087,7 +1087,7 @@ static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 		return -ENOMEM;
 
 	if (erofs_should_use_inode_extended(inode)) {
-		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
+		if (g_cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
 			erofs_err("file %s cannot be in compact form",
 				  inode->i_srcpath);
 			return -EINVAL;
@@ -1536,7 +1536,7 @@ static int erofs_rebuild_handle_directory(struct erofs_inode *dir,
 	struct erofs_sb_info *sbi = dir->sbi;
 	struct erofs_dentry *d, *n;
 	unsigned int nr_subdirs, i_nlink;
-	bool delwht = cfg.c_ovlfs_strip && dir->whiteouts;
+	bool delwht = g_cfg.c_ovlfs_strip && dir->whiteouts;
 	int ret;
 
 	nr_subdirs = 0;
@@ -1603,7 +1603,7 @@ static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
 			if (ctx.fd < 0)
 				return -errno;
 
-			if (cfg.c_compr_opts[0].alg &&
+			if (g_cfg.c_compr_opts[0].alg &&
 			    erofs_file_is_compressible(inode)) {
 				ctx.ictx = erofs_begin_compressed_file(inode,
 								ctx.fd, 0);
@@ -1632,7 +1632,7 @@ static int erofs_rebuild_handle_inode(struct erofs_inode *inode,
 	free(trimmed);
 
 	if (erofs_should_use_inode_extended(inode)) {
-		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
+		if (g_cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
 			erofs_err("file %s cannot be in compact form",
 				  inode->i_srcpath);
 			return -EINVAL;
@@ -1650,7 +1650,7 @@ static int erofs_rebuild_handle_inode(struct erofs_inode *inode,
 	}
 
 	/* strip all unnecessary overlayfs xattrs when ovlfs_strip is enabled */
-	if (cfg.c_ovlfs_strip)
+	if (g_cfg.c_ovlfs_strip)
 		erofs_clear_opaque_xattr(inode);
 	else if (inode->whiteouts)
 		erofs_set_origin_xattr(inode);
@@ -1669,7 +1669,7 @@ static int erofs_rebuild_handle_inode(struct erofs_inode *inode,
 			if (ctx.fd < 0)
 				return ret;
 
-			if (cfg.c_compr_opts[0].alg &&
+			if (g_cfg.c_compr_opts[0].alg &&
 			    erofs_file_is_compressible(inode)) {
 				ctx.ictx = erofs_begin_compressed_file(inode,
 							ctx.fd, ctx.fpos);
@@ -1713,8 +1713,8 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
 		root->i_ino[1] = sbi->root_nid;
 		list_del(&root->i_hash);
 		erofs_insert_ihash(root);
-	} else if (cfg.c_root_xattr_isize) {
-		root->xattr_isize = cfg.c_root_xattr_isize;
+	} else if (g_cfg.c_root_xattr_isize) {
+		root->xattr_isize = g_cfg.c_root_xattr_isize;
 	}
 
 	err = !rebuild ? erofs_mkfs_handle_inode(root) :
@@ -1919,7 +1919,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
 		inode->nid = inode->sbi->packed_nid;
 	}
 
-	if (cfg.c_compr_opts[0].alg &&
+	if (g_cfg.c_compr_opts[0].alg &&
 	    erofs_file_is_compressible(inode)) {
 		ictx = erofs_begin_compressed_file(inode, fd, 0);
 		if (IS_ERR(ictx))
diff --git a/lib/io.c b/lib/io.c
index dacf8dc..6d2c708 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -28,7 +28,7 @@
 
 int erofs_io_fstat(struct erofs_vfile *vf, struct stat *buf)
 {
-	if (__erofs_unlikely(cfg.c_dry_run)) {
+	if (__erofs_unlikely(g_cfg.c_dry_run)) {
 		buf->st_size = 0;
 		buf->st_mode = S_IFREG | 0777;
 		return 0;
@@ -44,7 +44,7 @@ ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
 {
 	ssize_t ret, written = 0;
 
-	if (__erofs_unlikely(cfg.c_dry_run))
+	if (__erofs_unlikely(g_cfg.c_dry_run))
 		return 0;
 
 	if (vf->ops)
@@ -78,7 +78,7 @@ int erofs_io_fsync(struct erofs_vfile *vf)
 {
 	int ret;
 
-	if (__erofs_unlikely(cfg.c_dry_run))
+	if (__erofs_unlikely(g_cfg.c_dry_run))
 		return 0;
 
 	if (vf->ops)
@@ -98,7 +98,7 @@ ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
 	static const char zero[EROFS_MAX_BLOCK_SIZE] = {0};
 	ssize_t ret;
 
-	if (__erofs_unlikely(cfg.c_dry_run))
+	if (__erofs_unlikely(g_cfg.c_dry_run))
 		return 0;
 
 	if (vf->ops)
@@ -124,7 +124,7 @@ int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
 	int ret;
 	struct stat st;
 
-	if (__erofs_unlikely(cfg.c_dry_run))
+	if (__erofs_unlikely(g_cfg.c_dry_run))
 		return 0;
 
 	if (vf->ops)
@@ -145,7 +145,7 @@ ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
 {
 	ssize_t ret, read = 0;
 
-	if (__erofs_unlikely(cfg.c_dry_run))
+	if (__erofs_unlikely(g_cfg.c_dry_run))
 		return 0;
 
 	if (vf->ops)
diff --git a/lib/xattr.c b/lib/xattr.c
index 7fbd24b..b22a76f 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -297,22 +297,22 @@ static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
 						  mode_t mode)
 {
 #ifdef HAVE_LIBSELINUX
-	if (cfg.sehnd) {
+	if (g_cfg.sehnd) {
 		char *secontext;
 		int ret;
 		unsigned int len[2];
 		char *kvbuf, *fspath;
 		struct xattr_item *item;
 
-		if (cfg.mount_point)
-			ret = asprintf(&fspath, "/%s/%s", cfg.mount_point,
+		if (g_cfg.mount_point)
+			ret = asprintf(&fspath, "/%s/%s", g_cfg.mount_point,
 				       erofs_fspath(srcpath));
 		else
 			ret = asprintf(&fspath, "/%s", erofs_fspath(srcpath));
 		if (ret <= 0)
 			return ERR_PTR(-ENOMEM);
 
-		ret = selabel_lookup(cfg.sehnd, &secontext, fspath, mode);
+		ret = selabel_lookup(g_cfg.sehnd, &secontext, fspath, mode);
 		free(fspath);
 
 		if (ret) {
@@ -369,7 +369,7 @@ static int erofs_xattr_add(struct list_head *ixattrs, struct xattr_item *item)
 	if (ixattrs)
 		return inode_xattr_add(ixattrs, item);
 
-	if (item->count == cfg.c_inline_xattr_tolerance + 1) {
+	if (item->count == g_cfg.c_inline_xattr_tolerance + 1) {
 		int ret = shared_xattr_add(item);
 
 		if (ret < 0)
@@ -382,7 +382,7 @@ static bool erofs_is_skipped_xattr(const char *key)
 {
 #ifdef HAVE_LIBSELINUX
 	/* if sehnd is valid, selabels will be overridden */
-	if (cfg.sehnd && !strcmp(key, XATTR_SECURITY_PREFIX "selinux"))
+	if (g_cfg.sehnd && !strcmp(key, XATTR_SECURITY_PREFIX "selinux"))
 		return true;
 #endif
 	return false;
@@ -577,7 +577,7 @@ int erofs_scan_file_xattrs(struct erofs_inode *inode)
 	struct list_head *ixattrs = &inode->i_xattrs;
 
 	/* check if xattr is disabled */
-	if (cfg.c_inline_xattr_tolerance < 0)
+	if (g_cfg.c_inline_xattr_tolerance < 0)
 		return 0;
 
 	ret = read_xattrs_from_file(inode->i_srcpath, inode->i_mode, ixattrs);
@@ -885,8 +885,8 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 	erofs_off_t shared_xattrs_size = 0;
 
 	/* check if xattr or shared xattr is disabled */
-	if (cfg.c_inline_xattr_tolerance < 0 ||
-	    cfg.c_inline_xattr_tolerance == INT_MAX)
+	if (g_cfg.c_inline_xattr_tolerance < 0 ||
+	    g_cfg.c_inline_xattr_tolerance == INT_MAX)
 		return 0;
 
 	if (shared_xattrs_count) {
@@ -972,7 +972,7 @@ char *erofs_export_xattr_ibody(struct erofs_inode *inode)
 	header = (struct erofs_xattr_ibody_header *)buf;
 	header->h_shared_count = 0;
 
-	if (cfg.c_xattr_name_filter) {
+	if (g_cfg.c_xattr_name_filter) {
 		u32 name_filter = 0;
 		int hashbit;
 		unsigned int base_len;
diff --git a/mkfs/main.c b/mkfs/main.c
index 5c8b5e4..8ca1050 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -218,7 +218,7 @@ static void usage(int argc, char **argv)
 static void version(void)
 {
 	printf("mkfs.erofs (erofs-utils) %s\navailable compressors: ",
-	       cfg.c_version);
+	       g_cfg.c_version);
 	print_available_compressors(stdout, ", ");
 }
 
@@ -246,7 +246,7 @@ static int erofs_mkfs_feat_set_legacy_compress(bool en, const char *val,
 	if (vallen)
 		return -EINVAL;
 	/* disable compacted indexes and 0padding */
-	cfg.c_legacy_compress = en;
+	g_cfg.c_legacy_compress = en;
 	return 0;
 }
 
@@ -255,7 +255,7 @@ static int erofs_mkfs_feat_set_ztailpacking(bool en, const char *val,
 {
 	if (vallen)
 		return -EINVAL;
-	cfg.c_ztailpacking = en;
+	g_cfg.c_ztailpacking = en;
 	return 0;
 }
 
@@ -265,7 +265,7 @@ static int erofs_mkfs_feat_set_fragments(bool en, const char *val,
 	if (!en) {
 		if (vallen)
 			return -EINVAL;
-		cfg.c_fragments = false;
+		g_cfg.c_fragments = false;
 		return 0;
 	}
 
@@ -279,14 +279,14 @@ static int erofs_mkfs_feat_set_fragments(bool en, const char *val,
 		}
 		pclustersize_packed = i;
 	}
-	cfg.c_fragments = true;
+	g_cfg.c_fragments = true;
 	return 0;
 }
 
 static int erofs_mkfs_feat_set_all_fragments(bool en, const char *val,
 					     unsigned int vallen)
 {
-	cfg.c_all_fragments = en;
+	g_cfg.c_all_fragments = en;
 	return erofs_mkfs_feat_set_fragments(en, val, vallen);
 }
 
@@ -295,7 +295,7 @@ static int erofs_mkfs_feat_set_dedupe(bool en, const char *val,
 {
 	if (vallen)
 		return -EINVAL;
-	cfg.c_dedupe = en;
+	g_cfg.c_dedupe = en;
 	return 0;
 }
 
@@ -356,12 +356,12 @@ static int parse_extended_opts(const char *opts)
 		if (MATCH_EXTENTED_OPT("force-inode-compact", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			cfg.c_force_inodeversion = FORCE_INODE_COMPACT;
-			cfg.c_ignore_mtime = true;
+			g_cfg.c_force_inodeversion = FORCE_INODE_COMPACT;
+			g_cfg.c_ignore_mtime = true;
 		} else if (MATCH_EXTENTED_OPT("force-inode-extended", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
+			g_cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
 		} else if (MATCH_EXTENTED_OPT("nosbcrc", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
@@ -369,23 +369,23 @@ static int parse_extended_opts(const char *opts)
 		} else if (MATCH_EXTENTED_OPT("noinline_data", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			cfg.c_inline_data = false;
+			g_cfg.c_inline_data = false;
 		} else if (MATCH_EXTENTED_OPT("inline_data", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			cfg.c_inline_data = !clear;
+			g_cfg.c_inline_data = !clear;
 		} else if (MATCH_EXTENTED_OPT("force-inode-blockmap", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			cfg.c_force_chunkformat = FORCE_INODE_BLOCK_MAP;
+			g_cfg.c_force_chunkformat = FORCE_INODE_BLOCK_MAP;
 		} else if (MATCH_EXTENTED_OPT("force-chunk-indexes", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			cfg.c_force_chunkformat = FORCE_INODE_CHUNK_INDEXES;
+			g_cfg.c_force_chunkformat = FORCE_INODE_CHUNK_INDEXES;
 		} else if (MATCH_EXTENTED_OPT("xattr-name-filter", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			cfg.c_xattr_name_filter = !clear;
+			g_cfg.c_xattr_name_filter = !clear;
 		} else {
 			int i, err;
 
@@ -526,7 +526,7 @@ static int mkfs_parse_compress_algs(char *algs)
 			return -EINVAL;
 		}
 
-		ret = mkfs_parse_one_compress_alg(s, &cfg.c_compr_opts[i]);
+		ret = mkfs_parse_one_compress_alg(s, &g_cfg.c_compr_opts[i]);
 		if (ret)
 			return ret;
 	}
@@ -578,7 +578,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				erofs_err("invalid debug level %d", i);
 				return -EINVAL;
 			}
-			cfg.c_dbg_lvl = i;
+			g_cfg.c_dbg_lvl = i;
 			break;
 
 		case 'x':
@@ -587,7 +587,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				erofs_err("invalid xattr tolerance %s", optarg);
 				return -EINVAL;
 			}
-			cfg.c_inline_xattr_tolerance = i;
+			g_cfg.c_inline_xattr_tolerance = i;
 			break;
 
 		case 'E':
@@ -607,8 +607,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			break;
 
 		case 'T':
-			cfg.c_unix_timestamp = strtoull(optarg, &endptr, 0);
-			if (cfg.c_unix_timestamp == -1 || *endptr != '\0') {
+			g_cfg.c_unix_timestamp = strtoull(optarg, &endptr, 0);
+			if (g_cfg.c_unix_timestamp == -1 || *endptr != '\0') {
 				erofs_err("invalid UNIX timestamp %s", optarg);
 				return -EINVAL;
 			}
@@ -644,32 +644,32 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return opt;
 			break;
 		case 5:
-			cfg.c_uid = strtoul(optarg, &endptr, 0);
-			if (cfg.c_uid == -1 || *endptr != '\0') {
+			g_cfg.c_uid = strtoul(optarg, &endptr, 0);
+			if (g_cfg.c_uid == -1 || *endptr != '\0') {
 				erofs_err("invalid uid %s", optarg);
 				return -EINVAL;
 			}
 			break;
 		case 6:
-			cfg.c_gid = strtoul(optarg, &endptr, 0);
-			if (cfg.c_gid == -1 || *endptr != '\0') {
+			g_cfg.c_gid = strtoul(optarg, &endptr, 0);
+			if (g_cfg.c_gid == -1 || *endptr != '\0') {
 				erofs_err("invalid gid %s", optarg);
 				return -EINVAL;
 			}
 			break;
 		case 7:
-			cfg.c_uid = cfg.c_gid = 0;
+			g_cfg.c_uid = g_cfg.c_gid = 0;
 			break;
 #ifndef NDEBUG
 		case 8:
-			cfg.c_random_pclusterblks = true;
+			g_cfg.c_random_pclusterblks = true;
 			break;
 		case 18:
-			cfg.c_random_algorithms = true;
+			g_cfg.c_random_algorithms = true;
 			break;
 #endif
 		case 9:
-			cfg.c_max_decompressed_extent_bytes =
+			g_cfg.c_max_decompressed_extent_bytes =
 				strtoul(optarg, &endptr, 0);
 			if (*endptr != '\0') {
 				erofs_err("invalid maximum uncompressed extent size %s",
@@ -678,24 +678,24 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			break;
 		case 10:
-			cfg.c_compress_hints_file = optarg;
+			g_cfg.c_compress_hints_file = optarg;
 			break;
 		case 512:
-			cfg.mount_point = optarg;
+			g_cfg.mount_point = optarg;
 			/* all trailing '/' should be deleted */
-			opt = strlen(cfg.mount_point);
+			opt = strlen(g_cfg.mount_point);
 			if (opt && optarg[opt - 1] == '/')
 				optarg[opt - 1] = '\0';
 			break;
 #ifdef WITH_ANDROID
 		case 513:
-			cfg.target_out_path = optarg;
+			g_cfg.target_out_path = optarg;
 			break;
 		case 514:
-			cfg.fs_config_file = optarg;
+			g_cfg.fs_config_file = optarg;
 			break;
 		case 515:
-			cfg.block_list_file = optarg;
+			g_cfg.block_list_file = optarg;
 			break;
 #endif
 		case 'C':
@@ -713,8 +713,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				erofs_err("invalid chunksize %s", optarg);
 				return -EINVAL;
 			}
-			cfg.c_chunkbits = ilog2(i);
-			if ((1 << cfg.c_chunkbits) != i) {
+			g_cfg.c_chunkbits = ilog2(i);
+			if ((1 << g_cfg.c_chunkbits) != i) {
 				erofs_err("chunksize %s must be a power of two",
 					  optarg);
 				return -EINVAL;
@@ -725,17 +725,17 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			quiet = true;
 			break;
 		case 13:
-			cfg.c_blobdev_path = optarg;
+			g_cfg.c_blobdev_path = optarg;
 			break;
 		case 14:
-			cfg.c_ignore_mtime = true;
+			g_cfg.c_ignore_mtime = true;
 			break;
 		case 15:
-			cfg.c_ignore_mtime = false;
+			g_cfg.c_ignore_mtime = false;
 			break;
 		case 16:
 			errno = 0;
-			cfg.c_uid_offset = strtoll(optarg, &endptr, 0);
+			g_cfg.c_uid_offset = strtoll(optarg, &endptr, 0);
 			if (errno || *endptr != '\0') {
 				erofs_err("invalid uid offset %s", optarg);
 				return -EINVAL;
@@ -743,7 +743,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			break;
 		case 17:
 			errno = 0;
-			cfg.c_gid_offset = strtoll(optarg, &endptr, 0);
+			g_cfg.c_gid_offset = strtoll(optarg, &endptr, 0);
 			if (errno || *endptr != '\0') {
 				erofs_err("invalid gid offset %s", optarg);
 				return -EINVAL;
@@ -757,7 +757,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 					  erofs_strerror(opt));
 				return opt;
 			}
-			cfg.c_extra_ea_name_prefixes = true;
+			g_cfg.c_extra_ea_name_prefixes = true;
 			break;
 		case 20:
 			mkfs_parse_tar_cfg(optarg);
@@ -767,9 +767,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			break;
 		case 516:
 			if (!optarg || !strcmp(optarg, "1"))
-				cfg.c_ovlfs_strip = true;
+				g_cfg.c_ovlfs_strip = true;
 			else
-				cfg.c_ovlfs_strip = false;
+				g_cfg.c_ovlfs_strip = false;
 			break;
 		case 517:
 			g_sbi.bdev.offset = strtoull(optarg, &endptr, 0);
@@ -788,16 +788,16 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 520: {
 			unsigned int processors;
 
-			cfg.c_mt_workers = strtoul(optarg, &endptr, 0);
+			g_cfg.c_mt_workers = strtoul(optarg, &endptr, 0);
 			if (errno || *endptr != '\0') {
 				erofs_err("invalid worker number %s", optarg);
 				return -EINVAL;
 			}
 
 			processors = erofs_get_available_processors();
-			if (cfg.c_mt_workers > processors)
+			if (g_cfg.c_mt_workers > processors)
 				erofs_warn("%d workers exceed %d processors, potentially impacting performance.",
-					   cfg.c_mt_workers, processors);
+					   g_cfg.c_mt_workers, processors);
 			break;
 		}
 #endif
@@ -828,17 +828,17 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			incremental_mode = (opt == 523);
 			break;
 		case 524:
-			cfg.c_root_xattr_isize = strtoull(optarg, &endptr, 0);
+			g_cfg.c_root_xattr_isize = strtoull(optarg, &endptr, 0);
 			if (*endptr != '\0') {
 				erofs_err("invalid the minimum inline xattr size %s", optarg);
 				return -EINVAL;
 			}
 			break;
 		case 525:
-			cfg.c_timeinherit = TIMESTAMP_NONE;
+			g_cfg.c_timeinherit = TIMESTAMP_NONE;
 			break;
 		case 526:
-			cfg.c_timeinherit = TIMESTAMP_FIXED;
+			g_cfg.c_timeinherit = TIMESTAMP_FIXED;
 			break;
 		case 'V':
 			version();
@@ -852,14 +852,14 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		}
 	}
 
-	if (cfg.c_blobdev_path && cfg.c_chunkbits < g_sbi.blkszbits) {
+	if (g_cfg.c_blobdev_path && g_cfg.c_chunkbits < g_sbi.blkszbits) {
 		erofs_err("--blobdev must be used together with --chunksize");
 		return -EINVAL;
 	}
 
 	/* TODO: can be implemented with (deviceslot) mapped_blkaddr */
-	if (cfg.c_blobdev_path &&
-	    cfg.c_force_chunkformat == FORCE_INODE_BLOCK_MAP) {
+	if (g_cfg.c_blobdev_path &&
+	    g_cfg.c_force_chunkformat == FORCE_INODE_BLOCK_MAP) {
 		erofs_err("--blobdev cannot work with block map currently");
 		return -EINVAL;
 	}
@@ -869,8 +869,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		return -EINVAL;
 	}
 
-	cfg.c_img_path = strdup(argv[optind++]);
-	if (!cfg.c_img_path)
+	g_cfg.c_img_path = strdup(argv[optind++]);
+	if (!g_cfg.c_img_path)
 		return -ENOMEM;
 
 	if (optind >= argc) {
@@ -894,18 +894,18 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	} else {
 		struct stat st;
 
-		cfg.c_src_path = realpath(argv[optind++], NULL);
-		if (!cfg.c_src_path) {
+		g_cfg.c_src_path = realpath(argv[optind++], NULL);
+		if (!g_cfg.c_src_path) {
 			erofs_err("failed to parse source directory: %s",
 				  erofs_strerror(-errno));
 			return -ENOENT;
 		}
 
 		if (tar_mode) {
-			int fd = open(cfg.c_src_path, O_RDONLY);
+			int fd = open(g_cfg.c_src_path, O_RDONLY);
 
 			if (fd < 0) {
-				erofs_err("failed to open file: %s", cfg.c_src_path);
+				erofs_err("failed to open file: %s", g_cfg.c_src_path);
 				return -errno;
 			}
 			err = erofs_iostream_open(&erofstar.ios, fd,
@@ -924,17 +924,17 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				erofstar.ios.dumpfd = fd;
 			}
 		} else {
-			err = lstat(cfg.c_src_path, &st);
+			err = lstat(g_cfg.c_src_path, &st);
 			if (err)
 				return -errno;
 			if (S_ISDIR(st.st_mode))
-				erofs_set_fs_root(cfg.c_src_path);
+				erofs_set_fs_root(g_cfg.c_src_path);
 			else
 				rebuild_mode = true;
 		}
 
 		if (rebuild_mode) {
-			char *srcpath = cfg.c_src_path;
+			char *srcpath = g_cfg.c_src_path;
 			struct erofs_sb_info *src;
 
 			do {
@@ -961,11 +961,11 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		}
 	}
 	if (quiet) {
-		cfg.c_dbg_lvl = EROFS_ERR;
-		cfg.c_showprogress = false;
+		g_cfg.c_dbg_lvl = EROFS_ERR;
+		g_cfg.c_showprogress = false;
 	}
 
-	if (cfg.c_compr_opts[0].alg && erofs_blksiz(&g_sbi) != getpagesize())
+	if (g_cfg.c_compr_opts[0].alg && erofs_blksiz(&g_sbi) != getpagesize())
 		erofs_warn("Please note that subpage blocksize with compression isn't yet supported in kernel. "
 			   "This compressed image will only work with bs = ps = %u bytes",
 			   erofs_blksiz(&g_sbi));
@@ -977,12 +977,12 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				  pclustersize_max);
 			return -EINVAL;
 		}
-		cfg.c_mkfs_pclustersize_max = pclustersize_max;
-		cfg.c_mkfs_pclustersize_def = cfg.c_mkfs_pclustersize_max;
+		g_cfg.c_mkfs_pclustersize_max = pclustersize_max;
+		g_cfg.c_mkfs_pclustersize_def = g_cfg.c_mkfs_pclustersize_max;
 	}
-	if (cfg.c_chunkbits && cfg.c_chunkbits < g_sbi.blkszbits) {
+	if (g_cfg.c_chunkbits && g_cfg.c_chunkbits < g_sbi.blkszbits) {
 		erofs_err("chunksize %u must be larger than block size",
-			  1u << cfg.c_chunkbits);
+			  1u << g_cfg.c_chunkbits);
 		return -EINVAL;
 	}
 
@@ -993,27 +993,27 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				  pclustersize_packed);
 			return -EINVAL;
 		}
-		cfg.c_mkfs_pclustersize_packed = pclustersize_packed;
+		g_cfg.c_mkfs_pclustersize_packed = pclustersize_packed;
 	}
 
-	if (has_timestamp && cfg.c_timeinherit == TIMESTAMP_UNSPECIFIED)
-		cfg.c_timeinherit = TIMESTAMP_FIXED;
+	if (has_timestamp && g_cfg.c_timeinherit == TIMESTAMP_UNSPECIFIED)
+		g_cfg.c_timeinherit = TIMESTAMP_FIXED;
 	return 0;
 }
 
 static void erofs_mkfs_default_options(void)
 {
-	cfg.c_showprogress = true;
-	cfg.c_legacy_compress = false;
-	cfg.c_inline_data = true;
-	cfg.c_xattr_name_filter = true;
+	g_cfg.c_showprogress = true;
+	g_cfg.c_legacy_compress = false;
+	g_cfg.c_inline_data = true;
+	g_cfg.c_xattr_name_filter = true;
 #ifdef EROFS_MT_ENABLED
-	cfg.c_mt_workers = erofs_get_available_processors();
-	cfg.c_mkfs_segment_size = 16ULL * 1024 * 1024;
+	g_cfg.c_mt_workers = erofs_get_available_processors();
+	g_cfg.c_mkfs_segment_size = 16ULL * 1024 * 1024;
 #endif
 	g_sbi.blkszbits = ilog2(min_t(u32, getpagesize(), EROFS_MAX_BLOCK_SIZE));
-	cfg.c_mkfs_pclustersize_max = erofs_blksiz(&g_sbi);
-	cfg.c_mkfs_pclustersize_def = cfg.c_mkfs_pclustersize_max;
+	g_cfg.c_mkfs_pclustersize_max = erofs_blksiz(&g_sbi);
+	g_cfg.c_mkfs_pclustersize_def = g_cfg.c_mkfs_pclustersize_max;
 	g_sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_ZERO_PADDING;
 	g_sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
 			     EROFS_FEATURE_COMPAT_MTIME;
@@ -1037,19 +1037,19 @@ int parse_source_date_epoch(void)
 		return -EINVAL;
 	}
 
-	if (cfg.c_force_inodeversion != FORCE_INODE_EXTENDED)
+	if (g_cfg.c_force_inodeversion != FORCE_INODE_EXTENDED)
 		erofs_info("SOURCE_DATE_EPOCH is set, forcely generate extended inodes instead");
 
-	cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
-	cfg.c_unix_timestamp = epoch;
-	cfg.c_timeinherit = TIMESTAMP_CLAMPING;
+	g_cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
+	g_cfg.c_unix_timestamp = epoch;
+	g_cfg.c_timeinherit = TIMESTAMP_CLAMPING;
 	return 0;
 }
 
 void erofs_show_progs(int argc, char *argv[])
 {
-	if (cfg.c_dbg_lvl >= EROFS_WARN)
-		printf("%s %s\n", basename(argv[0]), cfg.c_version);
+	if (g_cfg.c_dbg_lvl >= EROFS_WARN)
+		printf("%s %s\n", basename(argv[0]), g_cfg.c_version);
 }
 
 static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
@@ -1136,7 +1136,7 @@ static void erofs_mkfs_showsummaries(erofs_blk_t nblocks)
 	char uuid_str[37] = {};
 	char *incr = incremental_mode ? "new" : "total";
 
-	if (!(cfg.c_dbg_lvl > EROFS_ERR && cfg.c_showprogress))
+	if (!(g_cfg.c_dbg_lvl > EROFS_ERR && g_cfg.c_showprogress))
 		return;
 
 	erofs_uuid_unparse_lower(g_sbi.uuid, uuid_str);
@@ -1179,15 +1179,15 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	if (cfg.c_unix_timestamp != -1) {
-		g_sbi.build_time      = cfg.c_unix_timestamp;
+	if (g_cfg.c_unix_timestamp != -1) {
+		g_sbi.build_time      = g_cfg.c_unix_timestamp;
 		g_sbi.build_time_nsec = 0;
 	} else if (!gettimeofday(&t, NULL)) {
 		g_sbi.build_time      = t.tv_sec;
 		g_sbi.build_time_nsec = t.tv_usec;
 	}
 
-	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDWR |
+	err = erofs_dev_open(&g_sbi, g_cfg.c_img_path, O_RDWR |
 				(incremental_mode ? 0 : O_TRUNC));
 	if (err) {
 		fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
@@ -1195,24 +1195,24 @@ int main(int argc, char **argv)
 	}
 
 #ifdef WITH_ANDROID
-	if (cfg.fs_config_file &&
-	    load_canned_fs_config(cfg.fs_config_file) < 0) {
-		erofs_err("failed to load fs config %s", cfg.fs_config_file);
+	if (g_cfg.fs_config_file &&
+	    load_canned_fs_config(g_cfg.fs_config_file) < 0) {
+		erofs_err("failed to load fs config %s", g_cfg.fs_config_file);
 		return 1;
 	}
 
-	if (cfg.block_list_file) {
-		blklst = fopen(cfg.block_list_file, "w");
+	if (g_cfg.block_list_file) {
+		blklst = fopen(g_cfg.block_list_file, "w");
 		if (!blklst || erofs_blocklist_open(blklst, false)) {
-			erofs_err("failed to open %s", cfg.block_list_file);
+			erofs_err("failed to open %s", g_cfg.block_list_file);
 			return 1;
 		}
 	}
 #endif
 	erofs_show_config();
-	if (cfg.c_fragments || cfg.c_extra_ea_name_prefixes) {
-		if (!cfg.c_mkfs_pclustersize_packed)
-			cfg.c_mkfs_pclustersize_packed = cfg.c_mkfs_pclustersize_def;
+	if (g_cfg.c_fragments || g_cfg.c_extra_ea_name_prefixes) {
+		if (!g_cfg.c_mkfs_pclustersize_packed)
+			g_cfg.c_mkfs_pclustersize_packed = g_cfg.c_mkfs_pclustersize_def;
 
 		packedfile = erofs_packedfile_init();
 		if (IS_ERR(packedfile)) {
@@ -1221,7 +1221,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (cfg.c_fragments) {
+	if (g_cfg.c_fragments) {
 		err = z_erofs_fragments_init();
 		if (err) {
 			erofs_err("failed to initialize fragments");
@@ -1230,7 +1230,7 @@ int main(int argc, char **argv)
 	}
 
 #ifndef NDEBUG
-	if (cfg.c_random_pclusterblks)
+	if (g_cfg.c_random_pclusterblks)
 		srand(time(NULL));
 #endif
 	if (tar_mode) {
@@ -1325,7 +1325,7 @@ int main(int argc, char **argv)
 	err = erofs_load_compress_hints(&g_sbi);
 	if (err) {
 		erofs_err("failed to load compress hints %s",
-			  cfg.c_compress_hints_file);
+			  g_cfg.c_compress_hints_file);
 		goto exit;
 	}
 
@@ -1336,10 +1336,10 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	if (cfg.c_dedupe) {
-		if (!cfg.c_compr_opts[0].alg) {
+	if (g_cfg.c_dedupe) {
+		if (!g_cfg.c_compr_opts[0].alg) {
 			erofs_err("Compression is not enabled.  Turn on chunk-based data deduplication instead.");
-			cfg.c_chunkbits = g_sbi.blkszbits;
+			g_cfg.c_chunkbits = g_sbi.blkszbits;
 		} else {
 			err = z_erofs_dedupe_init(erofs_blksiz(&g_sbi));
 			if (err) {
@@ -1350,14 +1350,14 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (cfg.c_chunkbits) {
-		err = erofs_blob_init(cfg.c_blobdev_path, 1 << cfg.c_chunkbits);
+	if (g_cfg.c_chunkbits) {
+		err = erofs_blob_init(g_cfg.c_blobdev_path, 1 << g_cfg.c_chunkbits);
 		if (err)
 			return 1;
 	}
 
 	if (((erofstar.index_mode && !erofstar.headeronly_mode) &&
-	    !erofstar.mapfile) || cfg.c_blobdev_path) {
+	    !erofstar.mapfile) || g_cfg.c_blobdev_path) {
 		err = erofs_mkfs_init_devices(&g_sbi, 1);
 		if (err) {
 			erofs_err("failed to generate device table: %s",
@@ -1397,17 +1397,17 @@ int main(int argc, char **argv)
 		if (err)
 			goto exit;
 	} else {
-		err = erofs_build_shared_xattrs_from_path(&g_sbi, cfg.c_src_path);
+		err = erofs_build_shared_xattrs_from_path(&g_sbi, g_cfg.c_src_path);
 		if (err) {
 			erofs_err("failed to build shared xattrs: %s",
 				  erofs_strerror(err));
 			goto exit;
 		}
 
-		if (cfg.c_extra_ea_name_prefixes)
+		if (g_cfg.c_extra_ea_name_prefixes)
 			erofs_xattr_write_name_prefixes(&g_sbi, packedfile);
 
-		root = erofs_mkfs_build_tree_from_path(&g_sbi, cfg.c_src_path);
+		root = erofs_mkfs_build_tree_from_path(&g_sbi, g_cfg.c_src_path);
 		if (IS_ERR(root)) {
 			err = PTR_ERR(root);
 			goto exit;
@@ -1424,7 +1424,7 @@ int main(int argc, char **argv)
 			goto exit;
 	}
 
-	if (erofstar.index_mode || cfg.c_chunkbits || g_sbi.extra_devices) {
+	if (erofstar.index_mode || g_cfg.c_chunkbits || g_sbi.extra_devices) {
 		err = erofs_mkfs_dump_blobs(&g_sbi);
 		if (err)
 			goto exit;
@@ -1466,9 +1466,9 @@ exit:
 	erofs_dev_close(&g_sbi);
 	erofs_cleanup_compress_hints();
 	erofs_cleanup_exclude_rules();
-	if (cfg.c_chunkbits)
+	if (g_cfg.c_chunkbits)
 		erofs_blob_exit();
-	if (cfg.c_fragments)
+	if (g_cfg.c_fragments)
 		z_erofs_fragments_exit();
 	erofs_packedfile_exit();
 	erofs_xattr_cleanup_name_prefixes();
-- 
2.43.5

