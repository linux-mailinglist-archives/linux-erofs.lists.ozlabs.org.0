Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ADF97BEA1
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Sep 2024 17:30:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X82fP43svz2yXd
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Sep 2024 01:30:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726673432;
	cv=none; b=Gcs+y1qQqGoIgipKGXJtbwtZyEFVQnJ22jgljP9dMQ3xkf7Ez9SDCldn696VViZBCQ6etGH5fMgb8rTyuwY0cZbckxpIMl3TPU0kLYszxMqbf5r2zR0tk1xwTIbuvlfJpgDhhChMZ9QmPvTBM0nuR2mUI7iyS7y1Lp0nMVJoEXXOXM4bEA4OP2hJ62j+LN/uz34jqJBP/BUOVTF5KdfUsTvwSMoJ9CswovDDE49ZVg2u9ZlgS+fLZLNtAxMsqqyLhH/gRc4l/ppd1q534SVwV/uAcHhA1vqQLUAGyIgbCqZEiS23pPhq6+PdxDILZ3qhblsDVe/yM0YnkckrFDDpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726673432; c=relaxed/relaxed;
	bh=iczWj2BCUpkCYumt+r9RevNQCE2cbfAulk7AjbHRS3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jgjktktn46HQ1MGJ5skKkSdLoSbLNm/gpcpBuAcxfMOm0Ufhk6B9ZwnMoNuu1by7xjlkR3gD1aace9rpYMRsdUCa2021+KHhUJu66zw/LHzSUYwRYedngdJB74rErxE8afl9Ylp0Qy2txy6zqEXOcZhVdRLWFJg9sLglSPpUND9GD+o9J2rwabekyQrRc9jaY79MzLSBiVVlz89pPIiY5sIRF2LGlGeAzYyPi70M7HR4f+2E/q1wNOvBb0IXV711SiVqHihRJS9pkIOFxfRiAsZ19oy49lPiTxlNO1pYAgaFRol8FjcTY467aw9lowoVEI8sZML7Xbwe9RMYfIRhEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bni+cWuq; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bni+cWuq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X82fH1n4rz2xJV
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Sep 2024 01:30:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726673424; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=iczWj2BCUpkCYumt+r9RevNQCE2cbfAulk7AjbHRS3A=;
	b=bni+cWuqoEegFA8+ei3DlFaD/I6WujC6gmh6n9gaY/14eRWrnPWfymkUyLnh5mXyA9M6qnxJWpSRh13yoLCV6iIbaLprdN7X53HjUElAC0xBgN4SAQwAkHjwwQGFRqxXHpjYdquBz3ilLnAtTWQfPzG3u5KTd4lFasPvDi/jucQ=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WFEl9Fg_1726673422)
          by smtp.aliyun-inc.com;
          Wed, 18 Sep 2024 23:30:22 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: get rid of the global `g_cfg`
Date: Wed, 18 Sep 2024 23:30:12 +0800
Message-ID: <20240918153012.3559343-2-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240918153012.3559343-1-hongzhen@linux.alibaba.com>
References: <20240918153012.3559343-1-hongzhen@linux.alibaba.com>
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

This patch introduces the per-superblock configuration
`bt_args` to get rid of the global `g_cfg`.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 dump/main.c              |   4 +-
 fsck/main.c              |   4 +-
 fuse/main.c              |   4 +-
 include/erofs/compress.h |   2 +-
 include/erofs/config.h   |  22 ++-
 include/erofs/internal.h |   2 +
 lib/blobchunk.c          |   3 +-
 lib/block_list.c         |  25 +--
 lib/compress.c           |  95 +++++++-----
 lib/compress_hints.c     |  18 ++-
 lib/compressor_liblzma.c |   4 +-
 lib/compressor_libzstd.c |   4 +-
 lib/config.c             |  82 ++++++----
 lib/inode.c              |  82 ++++++----
 lib/io.c                 |  31 +++-
 lib/xattr.c              |  64 ++++----
 mkfs/main.c              | 328 +++++++++++++++++++++------------------
 17 files changed, 456 insertions(+), 318 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index e85b853..29ddc3b 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -676,7 +676,7 @@ int main(int argc, char **argv)
 {
 	int err;
 
-	erofs_init_configure();
+	erofs_init_configure(&g_cfg);
 	err = erofsdump_parse_options_cfg(argc, argv);
 	if (err) {
 		if (err == -EINVAL)
@@ -720,6 +720,6 @@ exit_dev_close:
 	erofs_dev_close(&g_sbi);
 exit:
 	erofs_blob_closeall(&g_sbi);
-	erofs_exit_configure();
+	erofs_exit_configure(&g_cfg);
 	return err;
 }
diff --git a/fsck/main.c b/fsck/main.c
index 6096683..718051e 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -1049,7 +1049,7 @@ int main(int argc, char *argv[])
 {
 	int err;
 
-	erofs_init_configure();
+	erofs_init_configure(&g_cfg);
 
 	fsckcfg.physical_blocks = 0;
 	fsckcfg.logical_blocks = 0;
@@ -1136,7 +1136,7 @@ exit_dev_close:
 	erofs_dev_close(&g_sbi);
 exit:
 	erofs_blob_closeall(&g_sbi);
-	erofs_exit_configure();
+	erofs_exit_configure(&g_cfg);
 	return err ? 1 : 0;
 }
 
diff --git a/fuse/main.c b/fuse/main.c
index bb92a7b..4d0cdae 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -642,7 +642,7 @@ int main(int argc, char *argv[])
 	} opts = {};
 #endif
 
-	erofs_init_configure();
+	erofs_init_configure(&g_cfg);
 	fusecfg.debug_lvl = g_cfg.c_dbg_lvl;
 	printf("erofsfuse %s\n", g_cfg.c_version);
 
@@ -752,6 +752,6 @@ err_fuse_free_args:
 	free(opts.mountpoint);
 	fuse_opt_free_args(&args);
 err:
-	erofs_exit_configure();
+	erofs_exit_configure(&g_cfg);
 	return ret ? EXIT_FAILURE : EXIT_SUCCESS;
 }
diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index c9831a7..4731a8b 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -25,7 +25,7 @@ int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx);
 
 int z_erofs_compress_init(struct erofs_sb_info *sbi,
 			  struct erofs_buffer_head *bh);
-int z_erofs_compress_exit(void);
+int z_erofs_compress_exit(struct erofs_sb_info *sbi);
 
 const char *z_erofs_list_supported_algorithms(int i, unsigned int *mask);
 const struct erofs_algorithm *z_erofs_list_available_compressors(int *i);
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 41d6c54..46f1111 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -98,9 +98,18 @@ struct erofs_configure {
 
 extern struct erofs_configure g_cfg;
 
-void erofs_init_configure(void);
-void erofs_show_config(void);
-void erofs_exit_configure(void);
+struct erofs_mkfs_buildtree_args {
+	struct erofs_configure *cfg;
+};
+
+struct erofs_sb_info;
+
+void erofs_init_configure(struct erofs_configure *cfg);
+void erofs_show_config(struct erofs_configure *cfg);
+void erofs_exit_configure(struct erofs_configure *cfg);
+void erofs_init_buildtree_cfg(struct erofs_sb_info *sbi,
+			      struct erofs_configure *cfg);
+void erofs_exit_buildtree_cfg(struct erofs_sb_info *sbi);
 
 /* (will be deprecated) temporary helper for updating global the cfg */
 struct erofs_configure *erofs_get_configure();
@@ -109,15 +118,16 @@ void erofs_set_fs_root(const char *rootdir);
 const char *erofs_fspath(const char *fullpath);
 
 #ifdef HAVE_LIBSELINUX
-int erofs_selabel_open(const char *file_contexts);
+int erofs_selabel_open(struct erofs_sb_info *sbi, const char *file_contexts);
 #else
-static inline int erofs_selabel_open(const char *file_contexts)
+static inline int erofs_selabel_open(struct erofs_sb_info *sbi,
+				     const char *file_contexts)
 {
 	return -EINVAL;
 }
 #endif
 
-void erofs_update_progressinfo(const char *fmt, ...);
+void erofs_update_progressinfo(struct erofs_sb_info *sbi, const char *fmt, ...);
 char *erofs_trim_for_progressinfo(const char *str, int placeholder);
 unsigned int erofs_get_available_processors(void);
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 2edc1b4..71e1cb1 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -27,6 +27,7 @@ typedef unsigned short umode_t;
 #endif
 #include "atomic.h"
 #include "io.h"
+#include "config.h"
 
 #ifndef PATH_MAX
 #define PATH_MAX        4096    /* # chars in a path name including nul */
@@ -140,6 +141,7 @@ struct erofs_sb_info {
 #endif
 	struct erofs_bufmgr *bmgr;
 	bool useqpl;
+	struct erofs_mkfs_buildtree_args *bt_args;
 };
 
 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 90e3b28..e6b278c 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -261,7 +261,8 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 				  erofs_off_t startoff)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
-	unsigned int chunkbits = g_cfg.c_chunkbits;
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
+	unsigned int chunkbits = cfg->c_chunkbits;
 	unsigned int count, unit;
 	struct erofs_blobchunk *chunk, *lastch;
 	struct erofs_inode_chunk_index *idx;
diff --git a/lib/block_list.c b/lib/block_list.c
index d745ea2..74365f3 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -42,14 +42,15 @@ void tarerofs_blocklist_write(erofs_blk_t blkaddr, erofs_blk_t nblocks,
 }
 
 #ifdef WITH_ANDROID
-static void blocklist_write(const char *path, erofs_blk_t blk_start,
+static void blocklist_write(struct erofs_sb_info *sbi, const char *path, erofs_blk_t blk_start,
 			    erofs_blk_t nblocks, bool first_extent,
 			    bool last_extent)
 {
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 	const char *fspath = erofs_fspath(path);
 
 	if (first_extent) {
-		fprintf(block_list_fp, "/%s", g_cfg.mount_point);
+		fprintf(block_list_fp, "/%s", cfg->mount_point);
 
 		if (fspath[0] != '/')
 			fprintf(block_list_fp, "/");
@@ -72,7 +73,9 @@ void erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
 					erofs_blk_t nblocks, bool first_extent,
 					bool last_extent)
 {
-	if (!block_list_fp || !g_cfg.mount_point)
+	struct erofs_configure *cfg = inode->sbi->bt_args->cfg;
+
+	if (!block_list_fp || !cfg->mount_point)
 		return;
 
 	if (!nblocks) {
@@ -81,24 +84,28 @@ void erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
 		return;
 	}
 
-	blocklist_write(inode->i_srcpath, blk_start, nblocks, first_extent,
-			last_extent);
+	blocklist_write(inode->sbi, inode->i_srcpath, blk_start, nblocks,
+			first_extent, last_extent);
 }
 
 void erofs_droid_blocklist_write(struct erofs_inode *inode,
 				 erofs_blk_t blk_start, erofs_blk_t nblocks)
 {
-	if (!block_list_fp || !g_cfg.mount_point || !nblocks)
+	struct erofs_configure *cfg = inode->sbi->bt_args->cfg;
+
+	if (!block_list_fp || !cfg->mount_point || !nblocks)
 		return;
 
-	blocklist_write(inode->i_srcpath, blk_start, nblocks,
+	blocklist_write(inode->sbi, inode->i_srcpath, blk_start, nblocks,
 			true, !inode->idata_size);
 }
 
 void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
 					  erofs_blk_t blkaddr)
 {
-	if (!block_list_fp || !g_cfg.mount_point)
+	struct erofs_configure *cfg = inode->sbi->bt_args->cfg;
+
+	if (!block_list_fp || !cfg->mount_point)
 		return;
 
 	/* XXX: a bit hacky.. may need a better approach */
@@ -114,6 +121,6 @@ void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
 		return;
 	}
 	if (blkaddr != NULL_ADDR)
-		blocklist_write(inode->i_srcpath, blkaddr, 1, true, true);
+		blocklist_write(inode->sbi, inode->i_srcpath, blkaddr, 1, true, true);
 }
 #endif
diff --git a/lib/compress.c b/lib/compress.c
index ea47927..d3fe50b 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -142,6 +142,7 @@ static void z_erofs_write_extent(struct z_erofs_compress_ictx *ctx,
 	unsigned int d0 = 0, d1 = (clusterofs + count) / erofs_blksiz(sbi);
 	struct z_erofs_lcluster_index di;
 	unsigned int type, advise;
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 
 	DBG_BUGON(!count);
 	di.di_clusterofs = cpu_to_le16(ctx->clusterofs);
@@ -152,7 +153,7 @@ static void z_erofs_write_extent(struct z_erofs_compress_ictx *ctx,
 		 * A lcluster cannot have three parts with the middle one which
 		 * is well-compressed for !ztailpacking cases.
 		 */
-		DBG_BUGON(!e->raw && !g_cfg.c_ztailpacking && !g_cfg.c_fragments);
+		DBG_BUGON(!e->raw && !cfg->c_ztailpacking && !cfg->c_fragments);
 		DBG_BUGON(e->partial);
 		type = e->raw ? Z_EROFS_LCLUSTER_TYPE_PLAIN :
 			Z_EROFS_LCLUSTER_TYPE_HEAD1;
@@ -415,21 +416,23 @@ static int write_uncompressed_extent(struct z_erofs_compress_sctx *ctx,
 
 static unsigned int z_erofs_get_max_pclustersize(struct erofs_inode *inode)
 {
+	struct erofs_configure *cfg = inode->sbi->bt_args->cfg;
+
 	if (erofs_is_packed_inode(inode)) {
-		return g_cfg.c_mkfs_pclustersize_packed;
+		return cfg->c_mkfs_pclustersize_packed;
 #ifndef NDEBUG
-	} else if (g_cfg.c_random_pclusterblks) {
+	} else if (cfg->c_random_pclusterblks) {
 		unsigned int pclusterblks =
-			g_cfg.c_mkfs_pclustersize_max >> inode->sbi->blkszbits;
+			cfg->c_mkfs_pclustersize_max >> inode->sbi->blkszbits;
 
 		return (1 + rand() % pclusterblks) << inode->sbi->blkszbits;
 #endif
-	} else if (g_cfg.c_compress_hints_file) {
+	} else if (cfg->c_compress_hints_file) {
 		z_erofs_apply_compress_hints(inode);
 		DBG_BUGON(!inode->z_physical_clusterblks);
 		return inode->z_physical_clusterblks << inode->sbi->blkszbits;
 	}
-	return g_cfg.c_mkfs_pclustersize_def;
+	return cfg->c_mkfs_pclustersize_def;
 }
 
 static int z_erofs_fill_inline_data(struct erofs_inode *inode, void *data,
@@ -515,15 +518,16 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	struct z_erofs_compress_ictx *ictx = ctx->ictx;
 	struct erofs_inode *inode = ictx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 	unsigned int blksz = erofs_blksiz(sbi);
 	char *const dst = dstbuf + blksz;
 	struct erofs_compress *const h = ctx->chandle;
 	unsigned int len = ctx->tail - ctx->head;
 	bool is_packed_inode = erofs_is_packed_inode(inode);
 	bool tsg = (ctx->seg_idx + 1 >= ictx->seg_num), final = !ctx->remaining;
-	bool may_packing = (g_cfg.c_fragments && tsg && final &&
+	bool may_packing = (cfg->c_fragments && tsg && final &&
 			    !is_packed_inode && !z_erofs_mt_enabled);
-	bool may_inline = (g_cfg.c_ztailpacking && tsg && final && !may_packing);
+	bool may_inline = (cfg->c_ztailpacking && tsg && final && !may_packing);
 	unsigned int compressedsize;
 	int ret;
 
@@ -543,7 +547,7 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 			goto nocompression;
 	}
 
-	e->length = min(len, g_cfg.c_max_decompressed_extent_bytes);
+	e->length = min(len, cfg->c_max_decompressed_extent_bytes);
 	ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
 				      &e->length, dst, ctx->pclustersize);
 	if (ret <= 0) {
@@ -1065,6 +1069,7 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 {
 	struct erofs_inode *inode = ictx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 	unsigned int legacymetasize;
 	u8 *compressmeta;
 	int ret;
@@ -1114,7 +1119,7 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 		ret = erofs_bh_balloon(bh, erofs_pos(sbi, compressed_blocks));
 		DBG_BUGON(ret != erofs_blksiz(sbi));
 	} else {
-		if (!g_cfg.c_fragments && !g_cfg.c_dedupe)
+		if (!cfg->c_fragments && !cfg->c_dedupe)
 			DBG_BUGON(!inode->idata_size);
 	}
 
@@ -1233,6 +1238,7 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 	struct z_erofs_compress_ictx *ictx = sctx->ictx;
 	struct erofs_inode *inode = ictx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 	int ret = 0;
 
 	ret = z_erofs_mt_wq_tls_init_compr(sbi, tls, cwork->alg_id,
@@ -1253,7 +1259,7 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 	}
 	sctx->memoff = 0;
 
-	ret = z_erofs_compress_segment(sctx, sctx->seg_idx * g_cfg.c_mkfs_segment_size,
+	ret = z_erofs_compress_segment(sctx, sctx->seg_idx * cfg->c_mkfs_segment_size,
 				       EROFS_NULL_ADDR);
 
 out:
@@ -1304,7 +1310,8 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 	struct erofs_compress_work *cur, *head = NULL, **last = &head;
 	struct erofs_compress_cfg *ccfg = ictx->ccfg;
 	struct erofs_inode *inode = ictx->inode;
-	int nsegs = DIV_ROUND_UP(inode->i_size, g_cfg.c_mkfs_segment_size);
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
+	int nsegs = DIV_ROUND_UP(inode->i_size, cfg->c_mkfs_segment_size);
 	int i;
 
 	ictx->seg_num = nsegs;
@@ -1338,9 +1345,9 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 		if (i == nsegs - 1)
 			cur->ctx.remaining = inode->i_size -
 					      inode->fragment_size -
-					      i * g_cfg.c_mkfs_segment_size;
+					      i * cfg->c_mkfs_segment_size;
 		else
-			cur->ctx.remaining = g_cfg.c_mkfs_segment_size;
+			cur->ctx.remaining = cfg->c_mkfs_segment_size;
 
 		cur->alg_id = ccfg->handle.alg->id;
 		cur->alg_name = ccfg->handle.alg->name;
@@ -1418,13 +1425,14 @@ static struct z_erofs_compress_ictx g_ictx;
 void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 	struct z_erofs_compress_ictx *ictx;
 	int ret;
 
 	/* initialize per-file compression setting */
 	inode->z_advise = 0;
 	inode->z_logical_clusterbits = sbi->blkszbits;
-	if (!g_cfg.c_legacy_compress && inode->z_logical_clusterbits <= 14) {
+	if (!cfg->c_legacy_compress && inode->z_logical_clusterbits <= 14) {
 		if (inode->z_logical_clusterbits <= 12)
 			inode->z_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
 		inode->datalayout = EROFS_INODE_COMPRESSED_COMPACT;
@@ -1437,11 +1445,11 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 		if (inode->datalayout == EROFS_INODE_COMPRESSED_COMPACT)
 			inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
 	}
-	if (g_cfg.c_fragments && !g_cfg.c_dedupe)
+	if (cfg->c_fragments && !cfg->c_dedupe)
 		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 
 #ifndef NDEBUG
-	if (g_cfg.c_random_algorithms) {
+	if (cfg->c_random_algorithms) {
 		while (1) {
 			inode->z_algorithmtype[0] =
 				rand() % EROFS_MAX_COMPR_CFGS;
@@ -1478,7 +1486,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	 * Handle tails in advance to avoid writing duplicated
 	 * parts into the packed inode.
 	 */
-	if (g_cfg.c_fragments && !erofs_is_packed_inode(inode)) {
+	if (cfg->c_fragments && !erofs_is_packed_inode(inode)) {
 		ret = z_erofs_fragments_dedupe(inode, fd, &ictx->tof_chksum);
 		if (ret < 0)
 			goto err_free_ictx;
@@ -1490,7 +1498,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	ictx->fix_dedupedfrag = false;
 	ictx->fragemitted = false;
 
-	if (g_cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
+	if (cfg->c_all_fragments && !erofs_is_packed_inode(inode) &&
 	    !inode->fragment_size) {
 		ret = z_erofs_pack_file_from_fd(inode, fd, ictx->tof_chksum);
 		if (ret)
@@ -1580,6 +1588,7 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 				    struct erofs_buffer_head *sb_bh,
 				    u32 *max_dict_size)
 {
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 	struct erofs_buffer_head *bh = sb_bh;
 	int ret = 0;
 
@@ -1593,7 +1602,7 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 				.max_distance =
 					cpu_to_le16(sbi->lz4.max_distance),
 				.max_pclusterblks =
-					g_cfg.c_mkfs_pclustersize_max >> sbi->blkszbits,
+					cfg->c_mkfs_pclustersize_max >> sbi->blkszbits,
 			}
 		};
 
@@ -1687,13 +1696,14 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	int i, ret, id;
 	u32 max_dict_size[Z_EROFS_COMPRESSION_MAX] = {};
 	u32 available_compr_algs = 0;
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 
-	for (i = 0; g_cfg.c_compr_opts[i].alg; ++i) {
+	for (i = 0; cfg->c_compr_opts[i].alg; ++i) {
 		struct erofs_compress *c = &erofs_ccfg[i].handle;
 
-		ret = erofs_compressor_init(sbi, c, g_cfg.c_compr_opts[i].alg,
-					    g_cfg.c_compr_opts[i].level,
-					    g_cfg.c_compr_opts[i].dict_size);
+		ret = erofs_compressor_init(sbi, c, cfg->c_compr_opts[i].alg,
+					    cfg->c_compr_opts[i].level,
+					    cfg->c_compr_opts[i].dict_size);
 		if (ret)
 			return ret;
 
@@ -1712,7 +1722,7 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	 * clear 0PADDING feature for old kernel compatibility.
 	 */
 	if (!available_compr_algs ||
-	    (g_cfg.c_legacy_compress && available_compr_algs == 1))
+	    (cfg->c_legacy_compress && available_compr_algs == 1))
 		erofs_sb_clear_lz4_0padding(sbi);
 
 	if (!available_compr_algs)
@@ -1728,9 +1738,9 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 		}
 		if (available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZ4) &&
 		    sbi->lz4.max_pclusterblks << sbi->blkszbits <
-			g_cfg.c_mkfs_pclustersize_max) {
+			cfg->c_mkfs_pclustersize_max) {
 			erofs_err("pclustersize %u is too large on incremental builds",
-				  g_cfg.c_mkfs_pclustersize_max);
+				  cfg->c_mkfs_pclustersize_max);
 			return -EOPNOTSUPP;
 		}
 	} else {
@@ -1741,17 +1751,17 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	 * if big pcluster is enabled, an extra CBLKCNT lcluster index needs
 	 * to be loaded in order to get those compressed block counts.
 	 */
-	if (g_cfg.c_mkfs_pclustersize_max > erofs_blksiz(sbi)) {
-		if (g_cfg.c_mkfs_pclustersize_max > Z_EROFS_PCLUSTER_MAX_SIZE) {
+	if (cfg->c_mkfs_pclustersize_max > erofs_blksiz(sbi)) {
+		if (cfg->c_mkfs_pclustersize_max > Z_EROFS_PCLUSTER_MAX_SIZE) {
 			erofs_err("unsupported pclustersize %u (too large)",
-				  g_cfg.c_mkfs_pclustersize_max);
+				  cfg->c_mkfs_pclustersize_max);
 			return -EINVAL;
 		}
 		erofs_sb_set_big_pcluster(sbi);
 	}
-	if (g_cfg.c_mkfs_pclustersize_packed > g_cfg.c_mkfs_pclustersize_max) {
+	if (cfg->c_mkfs_pclustersize_packed > cfg->c_mkfs_pclustersize_max) {
 		erofs_err("invalid pclustersize for the packed file %u",
-			  g_cfg.c_mkfs_pclustersize_packed);
+			  cfg->c_mkfs_pclustersize_packed);
 		return -EINVAL;
 	}
 
@@ -1763,19 +1773,19 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 
 	z_erofs_mt_enabled = false;
 #ifdef EROFS_MT_ENABLED
-	if (g_cfg.c_mt_workers >= 1 && (g_cfg.c_dedupe ||
-				      (g_cfg.c_fragments && !g_cfg.c_all_fragments))) {
-		if (g_cfg.c_dedupe)
+	if (cfg->c_mt_workers >= 1 && (cfg->c_dedupe ||
+				      (cfg->c_fragments && !cfg->c_all_fragments))) {
+		if (cfg->c_dedupe)
 			erofs_warn("multi-threaded dedupe is NOT implemented for now");
-		if (g_cfg.c_fragments)
+		if (cfg->c_fragments)
 			erofs_warn("multi-threaded fragments is NOT implemented for now");
-		g_cfg.c_mt_workers = 0;
+		cfg->c_mt_workers = 0;
 	}
 
-	if (g_cfg.c_mt_workers >= 1) {
+	if (cfg->c_mt_workers >= 1) {
 		ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq,
-					    g_cfg.c_mt_workers,
-					    g_cfg.c_mt_workers << 2,
+					    cfg->c_mt_workers,
+					    cfg->c_mt_workers << 2,
 					    z_erofs_mt_wq_tls_alloc,
 					    z_erofs_mt_wq_tls_free);
 		z_erofs_mt_enabled = !ret;
@@ -1786,11 +1796,12 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	return 0;
 }
 
-int z_erofs_compress_exit(void)
+int z_erofs_compress_exit(struct erofs_sb_info *sbi)
 {
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 	int i, ret;
 
-	for (i = 0; g_cfg.c_compr_opts[i].alg; ++i) {
+	for (i = 0; cfg->c_compr_opts[i].alg; ++i) {
 		ret = erofs_compressor_exit(&erofs_ccfg[i].handle);
 		if (ret)
 			return ret;
diff --git a/lib/compress_hints.c b/lib/compress_hints.c
index ae7c231..d0928f0 100644
--- a/lib/compress_hints.c
+++ b/lib/compress_hints.c
@@ -50,12 +50,13 @@ bool z_erofs_apply_compress_hints(struct erofs_inode *inode)
 	const char *s;
 	struct erofs_compress_hints *r;
 	unsigned int pclusterblks, algorithmtype;
+	struct erofs_configure *cfg = inode->sbi->bt_args->cfg;
 
 	if (inode->z_physical_clusterblks)
 		return true;
 
 	s = erofs_fspath(inode->i_srcpath);
-	pclusterblks = g_cfg.c_mkfs_pclustersize_def >> inode->sbi->blkszbits;
+	pclusterblks = cfg->c_mkfs_pclustersize_def >> inode->sbi->blkszbits;
 	algorithmtype = 0;
 
 	list_for_each_entry(r, &compress_hints_head, list) {
@@ -92,11 +93,12 @@ int erofs_load_compress_hints(struct erofs_sb_info *sbi)
 	FILE *f;
 	unsigned int line, max_pclustersize = 0;
 	int ret = 0;
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 
-	if (!g_cfg.c_compress_hints_file)
+	if (!cfg->c_compress_hints_file)
 		return 0;
 
-	f = fopen(g_cfg.c_compress_hints_file, "r");
+	f = fopen(cfg->c_compress_hints_file, "r");
 	if (!f)
 		return -errno;
 
@@ -125,7 +127,7 @@ int erofs_load_compress_hints(struct erofs_sb_info *sbi)
 		} else {
 			ccfg = atoi(alg);
 			if (ccfg >= EROFS_MAX_COMPR_CFGS ||
-			    !g_cfg.c_compr_opts[ccfg].alg) {
+			    !cfg->c_compr_opts[ccfg].alg) {
 				erofs_err("invalid compressing configuration \"%s\" at line %u",
 					  alg, line);
 				ret = -EINVAL;
@@ -136,7 +138,7 @@ int erofs_load_compress_hints(struct erofs_sb_info *sbi)
 		if (pclustersize % erofs_blksiz(sbi)) {
 			erofs_warn("invalid physical clustersize %u, "
 				   "use default pclusterblks %u",
-				   pclustersize, g_cfg.c_mkfs_pclustersize_def);
+				   pclustersize, cfg->c_mkfs_pclustersize_def);
 			continue;
 		}
 		erofs_insert_compress_hints(pattern,
@@ -146,10 +148,10 @@ int erofs_load_compress_hints(struct erofs_sb_info *sbi)
 			max_pclustersize = pclustersize;
 	}
 
-	if (g_cfg.c_mkfs_pclustersize_max < max_pclustersize) {
-		g_cfg.c_mkfs_pclustersize_max = max_pclustersize;
+	if (cfg->c_mkfs_pclustersize_max < max_pclustersize) {
+		cfg->c_mkfs_pclustersize_max = max_pclustersize;
 		erofs_warn("update max pclustersize to %u",
-			   g_cfg.c_mkfs_pclustersize_max);
+			   cfg->c_mkfs_pclustersize_max);
 	}
 out:
 	fclose(f);
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index 4b0b069..7282fcd 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -70,12 +70,14 @@ static int erofs_compressor_liblzma_setlevel(struct erofs_compress *c,
 static int erofs_compressor_liblzma_setdictsize(struct erofs_compress *c,
 						u32 dict_size)
 {
+	struct erofs_configure *cfg = c->sbi->bt_args->cfg;
+
 	if (!dict_size) {
 		if (erofs_compressor_lzma.default_dictsize) {
 			dict_size = erofs_compressor_lzma.default_dictsize;
 		} else {
 			dict_size = min_t(u32, Z_EROFS_LZMA_MAX_DICT_SIZE,
-					  g_cfg.c_mkfs_pclustersize_max << 3);
+					  cfg->c_mkfs_pclustersize_max << 3);
 			if (dict_size < 32768)
 				dict_size = 32768;
 		}
diff --git a/lib/compressor_libzstd.c b/lib/compressor_libzstd.c
index dfdb728..92bfc82 100644
--- a/lib/compressor_libzstd.c
+++ b/lib/compressor_libzstd.c
@@ -81,12 +81,14 @@ static int erofs_compressor_libzstd_setlevel(struct erofs_compress *c,
 static int erofs_compressor_libzstd_setdictsize(struct erofs_compress *c,
 						u32 dict_size)
 {
+	struct erofs_configure *cfg = c->sbi->bt_args->cfg;
+
 	if (!dict_size) {
 		if (erofs_compressor_libzstd.default_dictsize) {
 			dict_size = erofs_compressor_libzstd.default_dictsize;
 		} else {
 			dict_size = min_t(u32, Z_EROFS_ZSTD_MAX_DICT_SIZE,
-					  g_cfg.c_mkfs_pclustersize_max << 3);
+					  cfg->c_mkfs_pclustersize_max << 3);
 			dict_size = 1 << ilog2(dict_size);
 		}
 	}
diff --git a/lib/config.c b/lib/config.c
index 353411a..25447d5 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -22,26 +22,26 @@ struct erofs_configure g_cfg;
 struct erofs_sb_info g_sbi;
 bool erofs_stdout_tty;
 
-void erofs_init_configure(void)
+void erofs_init_configure(struct erofs_configure *cfg)
 {
-	memset(&g_cfg, 0, sizeof(g_cfg));
-
-	g_cfg.c_dbg_lvl  = EROFS_WARN;
-	g_cfg.c_version  = PACKAGE_VERSION;
-	g_cfg.c_dry_run  = false;
-	g_cfg.c_ignore_mtime = false;
-	g_cfg.c_force_inodeversion = 0;
-	g_cfg.c_inline_xattr_tolerance = 2;
-	g_cfg.c_unix_timestamp = -1;
-	g_cfg.c_uid = -1;
-	g_cfg.c_gid = -1;
-	g_cfg.c_max_decompressed_extent_bytes = -1;
+	memset(cfg, 0, sizeof(*cfg));
+
+	cfg->c_dbg_lvl  = EROFS_WARN;
+	cfg->c_version  = PACKAGE_VERSION;
+	cfg->c_dry_run  = false;
+	cfg->c_ignore_mtime = false;
+	cfg->c_force_inodeversion = 0;
+	cfg->c_inline_xattr_tolerance = 2;
+	cfg->c_unix_timestamp = -1;
+	cfg->c_uid = -1;
+	cfg->c_gid = -1;
+	cfg->c_max_decompressed_extent_bytes = -1;
 	erofs_stdout_tty = isatty(STDOUT_FILENO);
 }
 
-void erofs_show_config(void)
+void erofs_show_config(struct erofs_configure *cfg)
 {
-	const struct erofs_configure *c = &g_cfg;
+	const struct erofs_configure *c = cfg;
 
 	if (c->c_dbg_lvl < EROFS_INFO)
 		return;
@@ -50,20 +50,20 @@ void erofs_show_config(void)
 	erofs_dump("\tc_dry_run:           [%8d]\n", c->c_dry_run);
 }
 
-void erofs_exit_configure(void)
+void erofs_exit_configure(struct erofs_configure *cfg)
 {
 	int i;
 
 #ifdef HAVE_LIBSELINUX
-	if (g_cfg.sehnd)
-		selabel_close(g_cfg.sehnd);
+	if (cfg->sehnd)
+		selabel_close(cfg->sehnd);
 #endif
-	if (g_cfg.c_img_path)
-		free(g_cfg.c_img_path);
-	if (g_cfg.c_src_path)
-		free(g_cfg.c_src_path);
-	for (i = 0; i < EROFS_MAX_COMPR_CFGS && g_cfg.c_compr_opts[i].alg; i++)
-		free(g_cfg.c_compr_opts[i].alg);
+	if (cfg->c_img_path)
+		free(cfg->c_img_path);
+	if (cfg->c_src_path)
+		free(cfg->c_src_path);
+	for (i = 0; i < EROFS_MAX_COMPR_CFGS && cfg->c_compr_opts[i].alg; i++)
+		free(cfg->c_compr_opts[i].alg);
 }
 
 struct erofs_configure *erofs_get_configure()
@@ -88,20 +88,22 @@ const char *erofs_fspath(const char *fullpath)
 }
 
 #ifdef HAVE_LIBSELINUX
-int erofs_selabel_open(const char *file_contexts)
+int erofs_selabel_open(struct erofs_sb_info *sbi, const char *file_contexts)
 {
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
+
 	struct selinux_opt seopts[] = {
 		{ .type = SELABEL_OPT_PATH, .value = file_contexts }
 	};
 
-	if (g_cfg.sehnd) {
+	if (cfg->sehnd) {
 		erofs_info("ignore duplicated file contexts \"%s\"",
 			   file_contexts);
 		return -EBUSY;
 	}
 
-	g_cfg.sehnd = selabel_open(SELABEL_CTX_FILE, seopts, 1);
-	if (!g_cfg.sehnd) {
+	cfg->sehnd = selabel_open(SELABEL_CTX_FILE, seopts, 1);
+	if (!cfg->sehnd) {
 		erofs_err("failed to open file contexts \"%s\"",
 			  file_contexts);
 		return -EINVAL;
@@ -161,12 +163,13 @@ void erofs_msg(int dbglv, const char *fmt, ...)
 	va_end(ap);
 }
 
-void erofs_update_progressinfo(const char *fmt, ...)
+void erofs_update_progressinfo(struct erofs_sb_info *sbi, const char *fmt, ...)
 {
 	char msg[8192];
 	va_list ap;
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 
-	if (g_cfg.c_dbg_lvl >= EROFS_INFO || !g_cfg.c_showprogress)
+	if (cfg->c_dbg_lvl >= EROFS_INFO || !cfg->c_showprogress)
 		return;
 
 	va_start(ap, fmt);
@@ -191,3 +194,22 @@ unsigned int erofs_get_available_processors(void)
 	return 0;
 #endif
 }
+
+void erofs_init_buildtree_cfg(struct erofs_sb_info *sbi,
+			      struct erofs_configure *cfg)
+{
+	sbi->bt_args = malloc(sizeof(struct erofs_mkfs_buildtree_args));
+	if (!sbi->bt_args) {
+		erofs_err("fail to prepare for erofs_mkfs_buildtree_args");
+		return;
+	}
+	sbi->bt_args->cfg = cfg;
+	erofs_init_configure(sbi->bt_args->cfg);
+}
+
+void erofs_exit_buildtree_cfg(struct erofs_sb_info *sbi)
+{
+	erofs_exit_configure(sbi->bt_args->cfg);
+	sbi->bt_args->cfg = NULL;
+	free(sbi->bt_args);
+}
diff --git a/lib/inode.c b/lib/inode.c
index c3d2edb..2f6e3a5 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -507,7 +507,9 @@ int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 /* rules to decide whether a file could be compressed or not */
 static bool erofs_file_is_compressible(struct erofs_inode *inode)
 {
-	if (g_cfg.c_compress_hints_file)
+	struct erofs_configure *cfg = inode->sbi->bt_args->cfg;
+
+	if (cfg->c_compress_hints_file)
 		return z_erofs_apply_compress_hints(inode);
 	return true;
 }
@@ -557,11 +559,13 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 
 int erofs_write_unencoded_file(struct erofs_inode *inode, int fd, u64 fpos)
 {
-	if (g_cfg.c_chunkbits) {
-		inode->u.chunkbits = g_cfg.c_chunkbits;
+	struct erofs_configure *cfg = inode->sbi->bt_args->cfg;
+
+	if (cfg->c_chunkbits) {
+		inode->u.chunkbits = cfg->c_chunkbits;
 		/* chunk indexes when explicitly specified */
 		inode->u.chunkformat = 0;
-		if (g_cfg.c_force_chunkformat == FORCE_INODE_CHUNK_INDEXES)
+		if (cfg->c_force_chunkformat == FORCE_INODE_CHUNK_INDEXES)
 			inode->u.chunkformat = EROFS_CHUNK_FORMAT_INDEXES;
 		return erofs_blob_write_chunked_file(inode, fd, fpos);
 	}
@@ -748,6 +752,7 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 	struct erofs_bufmgr *bmgr = inode->sbi->bmgr;
 	unsigned int inodesize;
 	struct erofs_buffer_head *bh, *ibh;
+	struct erofs_configure *cfg = inode->sbi->bt_args->cfg;
 
 	DBG_BUGON(inode->bh || inode->bh_inline);
 
@@ -763,7 +768,7 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 		goto noinline;
 
 	if (!is_inode_layout_compression(inode)) {
-		if (!g_cfg.c_inline_data && S_ISREG(inode->i_mode)) {
+		if (!cfg->c_inline_data && S_ISREG(inode->i_mode)) {
 			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 			goto noinline;
 		}
@@ -796,7 +801,7 @@ noinline:
 		return PTR_ERR(bh);
 	} else if (inode->idata_size) {
 		if (is_inode_layout_compression(inode)) {
-			DBG_BUGON(!g_cfg.c_ztailpacking);
+			DBG_BUGON(!cfg->c_ztailpacking);
 			erofs_dbg("Inline %scompressed data (%u bytes) to %s",
 				  inode->compressed_idata ? "" : "un",
 				  inode->idata_size, inode->i_srcpath);
@@ -933,7 +938,9 @@ out:
 
 static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
 {
-	if (g_cfg.c_force_inodeversion == FORCE_INODE_EXTENDED)
+	struct erofs_configure *cfg = inode->sbi->bt_args->cfg;
+
+	if (cfg->c_force_inodeversion == FORCE_INODE_EXTENDED)
 		return true;
 	if (inode->i_size > UINT_MAX)
 		return true;
@@ -947,7 +954,7 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
 		return true;
 	if ((inode->i_mtime != inode->sbi->build_time ||
 	     inode->i_mtime_nsec != inode->sbi->build_time_nsec) &&
-	    !g_cfg.c_ignore_mtime)
+	    !cfg->c_ignore_mtime)
 		return true;
 	return false;
 }
@@ -965,6 +972,7 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 			       struct stat *st,
 			       const char *path)
 {
+	struct erofs_configure *cfg = inode->sbi->bt_args->cfg;
 	/* filesystem_config does not preserve file type bits */
 	mode_t stat_file_type_mask = st->st_mode & S_IFMT;
 	unsigned int uid = 0, gid = 0, mode = 0;
@@ -972,30 +980,30 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 	char *decorated = NULL;
 
 	inode->capabilities = 0;
-	if (!g_cfg.fs_config_file && !g_cfg.mount_point)
+	if (!cfg->fs_config_file && !cfg->mount_point)
 		return 0;
 	/* avoid loading special inodes */
 	if (path == EROFS_PACKED_INODE)
 		return 0;
 
-	if (!g_cfg.mount_point ||
+	if (!cfg->mount_point ||
 	/* have to drop the mountpoint for rootdir of canned fsconfig */
-	    (g_cfg.fs_config_file && erofs_fspath(path)[0] == '\0')) {
+	    (cfg->fs_config_file && erofs_fspath(path)[0] == '\0')) {
 		fspath = erofs_fspath(path);
 	} else {
-		if (asprintf(&decorated, "%s/%s", g_cfg.mount_point,
+		if (asprintf(&decorated, "%s/%s", cfg->mount_point,
 			     erofs_fspath(path)) <= 0)
 			return -ENOMEM;
 		fspath = decorated;
 	}
 
-	if (g_cfg.fs_config_file)
+	if (cfg->fs_config_file)
 		canned_fs_config(fspath, S_ISDIR(st->st_mode),
-				 g_cfg.target_out_path,
+				 cfg->target_out_path,
 				 &uid, &gid, &mode, &inode->capabilities);
 	else
 		fs_config(fspath, S_ISDIR(st->st_mode),
-			  g_cfg.target_out_path,
+			  cfg->target_out_path,
 			  &uid, &gid, &mode, &inode->capabilities);
 
 	erofs_dbg("/%s -> mode = 0x%x, uid = 0x%x, gid = 0x%x, capabilities = 0x%" PRIx64,
@@ -1022,25 +1030,26 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 {
 	int err = erofs_droid_inode_fsconfig(inode, st, path);
 	struct erofs_sb_info *sbi = inode->sbi;
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 
 	if (err)
 		return err;
 
-	inode->i_uid = g_cfg.c_uid == -1 ? st->st_uid : g_cfg.c_uid;
-	inode->i_gid = g_cfg.c_gid == -1 ? st->st_gid : g_cfg.c_gid;
+	inode->i_uid = cfg->c_uid == -1 ? st->st_uid : cfg->c_uid;
+	inode->i_gid = cfg->c_gid == -1 ? st->st_gid : cfg->c_gid;
 
-	if (inode->i_uid + g_cfg.c_uid_offset < 0)
+	if (inode->i_uid + cfg->c_uid_offset < 0)
 		erofs_err("uid overflow @ %s", path);
-	inode->i_uid += g_cfg.c_uid_offset;
+	inode->i_uid += cfg->c_uid_offset;
 
-	if (inode->i_gid + g_cfg.c_gid_offset < 0)
+	if (inode->i_gid + cfg->c_gid_offset < 0)
 		erofs_err("gid overflow @ %s", path);
-	inode->i_gid += g_cfg.c_gid_offset;
+	inode->i_gid += cfg->c_gid_offset;
 
 	inode->i_mtime = st->st_mtime;
 	inode->i_mtime_nsec = ST_MTIM_NSEC(st);
 
-	switch (g_cfg.c_timeinherit) {
+	switch (cfg->c_timeinherit) {
 	case TIMESTAMP_CLAMPING:
 		if (inode->i_mtime < sbi->build_time)
 			break;
@@ -1057,6 +1066,8 @@ int __erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 			    const char *path)
 {
+	struct erofs_configure *cfg = inode->sbi->bt_args->cfg;
+
 	int err = __erofs_fill_inode(inode, st, path);
 
 	if (err)
@@ -1087,7 +1098,7 @@ static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 		return -ENOMEM;
 
 	if (erofs_should_use_inode_extended(inode)) {
-		if (g_cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
+		if (cfg->c_force_inodeversion == FORCE_INODE_COMPACT) {
 			erofs_err("file %s cannot be in compact form",
 				  inode->i_srcpath);
 			return -EINVAL;
@@ -1534,9 +1545,10 @@ static int erofs_rebuild_handle_directory(struct erofs_inode *dir,
 					  bool incremental)
 {
 	struct erofs_sb_info *sbi = dir->sbi;
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 	struct erofs_dentry *d, *n;
 	unsigned int nr_subdirs, i_nlink;
-	bool delwht = g_cfg.c_ovlfs_strip && dir->whiteouts;
+	bool delwht = cfg->c_ovlfs_strip && dir->whiteouts;
 	int ret;
 
 	nr_subdirs = 0;
@@ -1578,13 +1590,14 @@ static int erofs_rebuild_handle_directory(struct erofs_inode *dir,
 
 static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
 {
+	struct erofs_configure *cfg = inode->sbi->bt_args->cfg;
 	const char *relpath = erofs_fspath(inode->i_srcpath);
 	char *trimmed;
 	int ret;
 
 	trimmed = erofs_trim_for_progressinfo(relpath[0] ? relpath : "/",
 					      sizeof("Processing  ...") - 1);
-	erofs_update_progressinfo("Processing %s ...", trimmed);
+	erofs_update_progressinfo(inode->sbi, "Processing %s ...", trimmed);
 	free(trimmed);
 
 	ret = erofs_scan_file_xattrs(inode);
@@ -1603,7 +1616,7 @@ static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
 			if (ctx.fd < 0)
 				return -errno;
 
-			if (g_cfg.c_compr_opts[0].alg &&
+			if (cfg->c_compr_opts[0].alg &&
 			    erofs_file_is_compressible(inode)) {
 				ctx.ictx = erofs_begin_compressed_file(inode,
 								ctx.fd, 0);
@@ -1623,16 +1636,17 @@ static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
 static int erofs_rebuild_handle_inode(struct erofs_inode *inode,
 				      bool incremental)
 {
+	struct erofs_configure *cfg = inode->sbi->bt_args->cfg;
 	char *trimmed;
 	int ret;
 
 	trimmed = erofs_trim_for_progressinfo(erofs_fspath(inode->i_srcpath),
 					      sizeof("Processing  ...") - 1);
-	erofs_update_progressinfo("Processing %s ...", trimmed);
+	erofs_update_progressinfo(inode->sbi, "Processing %s ...", trimmed);
 	free(trimmed);
 
 	if (erofs_should_use_inode_extended(inode)) {
-		if (g_cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
+		if (cfg->c_force_inodeversion == FORCE_INODE_COMPACT) {
 			erofs_err("file %s cannot be in compact form",
 				  inode->i_srcpath);
 			return -EINVAL;
@@ -1650,7 +1664,7 @@ static int erofs_rebuild_handle_inode(struct erofs_inode *inode,
 	}
 
 	/* strip all unnecessary overlayfs xattrs when ovlfs_strip is enabled */
-	if (g_cfg.c_ovlfs_strip)
+	if (cfg->c_ovlfs_strip)
 		erofs_clear_opaque_xattr(inode);
 	else if (inode->whiteouts)
 		erofs_set_origin_xattr(inode);
@@ -1669,7 +1683,7 @@ static int erofs_rebuild_handle_inode(struct erofs_inode *inode,
 			if (ctx.fd < 0)
 				return ret;
 
-			if (g_cfg.c_compr_opts[0].alg &&
+			if (cfg->c_compr_opts[0].alg &&
 			    erofs_file_is_compressible(inode)) {
 				ctx.ictx = erofs_begin_compressed_file(inode,
 							ctx.fd, ctx.fpos);
@@ -1702,6 +1716,7 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
 				bool incremental)
 {
 	struct erofs_sb_info *sbi = root->sbi;
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 	struct erofs_inode *dumpdir = erofs_igrab(root);
 	int err;
 
@@ -1713,8 +1728,8 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
 		root->i_ino[1] = sbi->root_nid;
 		list_del(&root->i_hash);
 		erofs_insert_ihash(root);
-	} else if (g_cfg.c_root_xattr_isize) {
-		root->xattr_isize = g_cfg.c_root_xattr_isize;
+	} else if (cfg->c_root_xattr_isize) {
+		root->xattr_isize = cfg->c_root_xattr_isize;
 	}
 
 	err = !rebuild ? erofs_mkfs_handle_inode(root) :
@@ -1886,6 +1901,7 @@ int erofs_rebuild_dump_tree(struct erofs_inode *root, bool incremental)
 struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
 						     int fd, const char *name)
 {
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 	struct stat st;
 	struct erofs_inode *inode;
 	void *ictx;
@@ -1919,7 +1935,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
 		inode->nid = inode->sbi->packed_nid;
 	}
 
-	if (g_cfg.c_compr_opts[0].alg &&
+	if (cfg->c_compr_opts[0].alg &&
 	    erofs_file_is_compressible(inode)) {
 		ictx = erofs_begin_compressed_file(inode, fd, 0);
 		if (IS_ERR(ictx))
diff --git a/lib/io.c b/lib/io.c
index 6d2c708..f284a35 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -28,7 +28,11 @@
 
 int erofs_io_fstat(struct erofs_vfile *vf, struct stat *buf)
 {
-	if (__erofs_unlikely(g_cfg.c_dry_run)) {
+	struct erofs_sb_info *sbi = container_of(vf, struct erofs_sb_info,
+						 bdev);
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
+
+	if (__erofs_unlikely(cfg->c_dry_run)) {
 		buf->st_size = 0;
 		buf->st_mode = S_IFREG | 0777;
 		return 0;
@@ -42,9 +46,12 @@ int erofs_io_fstat(struct erofs_vfile *vf, struct stat *buf)
 ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
 			u64 pos, size_t len)
 {
+	struct erofs_sb_info *sbi = container_of(vf, struct erofs_sb_info,
+						 bdev);
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 	ssize_t ret, written = 0;
 
-	if (__erofs_unlikely(g_cfg.c_dry_run))
+	if (__erofs_unlikely(cfg->c_dry_run))
 		return 0;
 
 	if (vf->ops)
@@ -76,9 +83,12 @@ ssize_t erofs_io_pwrite(struct erofs_vfile *vf, const void *buf,
 
 int erofs_io_fsync(struct erofs_vfile *vf)
 {
+	struct erofs_sb_info *sbi = container_of(vf, struct erofs_sb_info,
+						 bdev);
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 	int ret;
 
-	if (__erofs_unlikely(g_cfg.c_dry_run))
+	if (__erofs_unlikely(cfg->c_dry_run))
 		return 0;
 
 	if (vf->ops)
@@ -95,10 +105,13 @@ int erofs_io_fsync(struct erofs_vfile *vf)
 ssize_t erofs_io_fallocate(struct erofs_vfile *vf, u64 offset,
 			   size_t len, bool zeroout)
 {
+	struct erofs_sb_info *sbi = container_of(vf, struct erofs_sb_info,
+						 bdev);
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 	static const char zero[EROFS_MAX_BLOCK_SIZE] = {0};
 	ssize_t ret;
 
-	if (__erofs_unlikely(g_cfg.c_dry_run))
+	if (__erofs_unlikely(cfg->c_dry_run))
 		return 0;
 
 	if (vf->ops)
@@ -123,8 +136,11 @@ int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
 {
 	int ret;
 	struct stat st;
+	struct erofs_sb_info *sbi = container_of(vf, struct erofs_sb_info,
+						 bdev);
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 
-	if (__erofs_unlikely(g_cfg.c_dry_run))
+	if (__erofs_unlikely(cfg->c_dry_run))
 		return 0;
 
 	if (vf->ops)
@@ -143,9 +159,12 @@ int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
 
 ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
 {
+	struct erofs_sb_info *sbi = container_of(vf, struct erofs_sb_info,
+						 bdev);
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 	ssize_t ret, read = 0;
 
-	if (__erofs_unlikely(g_cfg.c_dry_run))
+	if (__erofs_unlikely(cfg->c_dry_run))
 		return 0;
 
 	if (vf->ops)
diff --git a/lib/xattr.c b/lib/xattr.c
index b22a76f..b932426 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -293,26 +293,29 @@ out:
 	return ERR_PTR(ret);
 }
 
-static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
+static struct xattr_item *erofs_get_selabel_xattr(struct erofs_sb_info *sbi,
+						  const char *srcpath,
 						  mode_t mode)
 {
 #ifdef HAVE_LIBSELINUX
-	if (g_cfg.sehnd) {
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
+
+	if (cfg->sehnd) {
 		char *secontext;
 		int ret;
 		unsigned int len[2];
 		char *kvbuf, *fspath;
 		struct xattr_item *item;
 
-		if (g_cfg.mount_point)
-			ret = asprintf(&fspath, "/%s/%s", g_cfg.mount_point,
+		if (cfg->mount_point)
+			ret = asprintf(&fspath, "/%s/%s", cfg->mount_point,
 				       erofs_fspath(srcpath));
 		else
 			ret = asprintf(&fspath, "/%s", erofs_fspath(srcpath));
 		if (ret <= 0)
 			return ERR_PTR(-ENOMEM);
 
-		ret = selabel_lookup(g_cfg.sehnd, &secontext, fspath, mode);
+		ret = selabel_lookup(cfg->sehnd, &secontext, fspath, mode);
 		free(fspath);
 
 		if (ret) {
@@ -364,12 +367,15 @@ static int shared_xattr_add(struct xattr_item *item)
 	return ++shared_xattrs_count;
 }
 
-static int erofs_xattr_add(struct list_head *ixattrs, struct xattr_item *item)
+static int erofs_xattr_add(struct erofs_sb_info *sbi, struct list_head *ixattrs,
+			   struct xattr_item *item)
 {
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
+
 	if (ixattrs)
 		return inode_xattr_add(ixattrs, item);
 
-	if (item->count == g_cfg.c_inline_xattr_tolerance + 1) {
+	if (item->count == cfg->c_inline_xattr_tolerance + 1) {
 		int ret = shared_xattr_add(item);
 
 		if (ret < 0)
@@ -378,18 +384,20 @@ static int erofs_xattr_add(struct list_head *ixattrs, struct xattr_item *item)
 	return 0;
 }
 
-static bool erofs_is_skipped_xattr(const char *key)
+static bool erofs_is_skipped_xattr(struct erofs_sb_info *sbi, const char *key)
 {
 #ifdef HAVE_LIBSELINUX
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
+
 	/* if sehnd is valid, selabels will be overridden */
-	if (g_cfg.sehnd && !strcmp(key, XATTR_SECURITY_PREFIX "selinux"))
+	if (cfg->sehnd && !strcmp(key, XATTR_SECURITY_PREFIX "selinux"))
 		return true;
 #endif
 	return false;
 }
 
-static int read_xattrs_from_file(const char *path, mode_t mode,
-				 struct list_head *ixattrs)
+static int read_xattrs_from_file(struct erofs_sb_info *sbi, const char *path,
+				 mode_t mode, struct list_head *ixattrs)
 {
 #ifdef HAVE_LLISTXATTR
 	ssize_t kllen = llistxattr(path, NULL, 0);
@@ -441,7 +449,7 @@ static int read_xattrs_from_file(const char *path, mode_t mode,
 
 	for (key = keylst; key != klend; key += keylen + 1) {
 		keylen = strlen(key);
-		if (erofs_is_skipped_xattr(key))
+		if (erofs_is_skipped_xattr(sbi, key))
 			continue;
 
 		item = parse_one_xattr(path, key, keylen);
@@ -453,7 +461,7 @@ static int read_xattrs_from_file(const char *path, mode_t mode,
 		if (!item)
 			continue;
 
-		ret = erofs_xattr_add(ixattrs, item);
+		ret = erofs_xattr_add(sbi, ixattrs, item);
 		if (ret < 0)
 			goto err;
 	}
@@ -461,11 +469,11 @@ static int read_xattrs_from_file(const char *path, mode_t mode,
 
 out:
 	/* if some selabel is avilable, need to add right now */
-	item = erofs_get_selabel_xattr(path, mode);
+	item = erofs_get_selabel_xattr(sbi, path, mode);
 	if (IS_ERR(item))
 		return PTR_ERR(item);
 	if (item)
-		ret = erofs_xattr_add(ixattrs, item);
+		ret = erofs_xattr_add(sbi, ixattrs, item);
 	return ret;
 
 err:
@@ -497,7 +505,7 @@ int erofs_setxattr(struct erofs_inode *inode, char *key,
 	}
 	DBG_BUGON(!item);
 
-	return erofs_xattr_add(&inode->i_xattrs, item);
+	return erofs_xattr_add(inode->sbi, &inode->i_xattrs, item);
 }
 
 static void erofs_removexattr(struct erofs_inode *inode, const char *key)
@@ -562,7 +570,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 	}
 	DBG_BUGON(!item);
 
-	return erofs_xattr_add(&inode->i_xattrs, item);
+	return erofs_xattr_add(inode->sbi, &inode->i_xattrs, item);
 }
 #else
 static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
@@ -575,12 +583,14 @@ int erofs_scan_file_xattrs(struct erofs_inode *inode)
 {
 	int ret;
 	struct list_head *ixattrs = &inode->i_xattrs;
+	struct erofs_configure *cfg = inode->sbi->bt_args->cfg;
 
 	/* check if xattr is disabled */
-	if (g_cfg.c_inline_xattr_tolerance < 0)
+	if (cfg->c_inline_xattr_tolerance < 0)
 		return 0;
 
-	ret = read_xattrs_from_file(inode->i_srcpath, inode->i_mode, ixattrs);
+	ret = read_xattrs_from_file(inode->sbi, inode->i_srcpath,
+				    inode->i_mode, ixattrs);
 	if (ret < 0)
 		return ret;
 
@@ -705,7 +715,7 @@ out:
 	return ret;
 }
 
-static int erofs_count_all_xattrs_from_path(const char *path)
+static int erofs_count_all_xattrs_from_path(struct erofs_sb_info *sbi, const char *path)
 {
 	int ret;
 	DIR *_dir;
@@ -750,14 +760,14 @@ static int erofs_count_all_xattrs_from_path(const char *path)
 			goto fail;
 		}
 
-		ret = read_xattrs_from_file(buf, st.st_mode, NULL);
+		ret = read_xattrs_from_file(sbi, buf, st.st_mode, NULL);
 		if (ret)
 			goto fail;
 
 		if (!S_ISDIR(st.st_mode))
 			continue;
 
-		ret = erofs_count_all_xattrs_from_path(buf);
+		ret = erofs_count_all_xattrs_from_path(sbi, buf);
 		if (ret)
 			goto fail;
 	}
@@ -883,10 +893,11 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 	unsigned int p, i;
 	erofs_off_t off;
 	erofs_off_t shared_xattrs_size = 0;
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 
 	/* check if xattr or shared xattr is disabled */
-	if (g_cfg.c_inline_xattr_tolerance < 0 ||
-	    g_cfg.c_inline_xattr_tolerance == INT_MAX)
+	if (cfg->c_inline_xattr_tolerance < 0 ||
+	    cfg->c_inline_xattr_tolerance == INT_MAX)
 		return 0;
 
 	if (shared_xattrs_count) {
@@ -894,7 +905,7 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 		return -EINVAL;
 	}
 
-	ret = erofs_count_all_xattrs_from_path(path);
+	ret = erofs_count_all_xattrs_from_path(sbi, path);
 	if (ret)
 		return ret;
 
@@ -957,6 +968,7 @@ out:
 
 char *erofs_export_xattr_ibody(struct erofs_inode *inode)
 {
+	struct erofs_configure *cfg = inode->sbi->bt_args->cfg;
 	struct list_head *ixattrs = &inode->i_xattrs;
 	unsigned int size = inode->xattr_isize;
 	struct inode_xattr_node *node, *n;
@@ -972,7 +984,7 @@ char *erofs_export_xattr_ibody(struct erofs_inode *inode)
 	header = (struct erofs_xattr_ibody_header *)buf;
 	header->h_shared_count = 0;
 
-	if (g_cfg.c_xattr_name_filter) {
+	if (cfg->c_xattr_name_filter) {
 		u32 name_filter = 0;
 		int hashbit;
 		unsigned int base_len;
diff --git a/mkfs/main.c b/mkfs/main.c
index 8ca1050..edfb4c2 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -215,10 +215,12 @@ static void usage(int argc, char **argv)
 	);
 }
 
-static void version(void)
+static void version(struct erofs_sb_info *sbi)
 {
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
+
 	printf("mkfs.erofs (erofs-utils) %s\navailable compressors: ",
-	       g_cfg.c_version);
+	       cfg->c_version);
 	print_available_compressors(stdout, ", ");
 }
 
@@ -240,32 +242,41 @@ static LIST_HEAD(rebuild_src_list);
 static u8 fixeduuid[16];
 static bool valid_fixeduuid;
 
-static int erofs_mkfs_feat_set_legacy_compress(bool en, const char *val,
+static int erofs_mkfs_feat_set_legacy_compress(struct erofs_sb_info *sbi,
+					       bool en, const char *val,
 					       unsigned int vallen)
 {
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
+
 	if (vallen)
 		return -EINVAL;
 	/* disable compacted indexes and 0padding */
-	g_cfg.c_legacy_compress = en;
+	cfg->c_legacy_compress = en;
 	return 0;
 }
 
-static int erofs_mkfs_feat_set_ztailpacking(bool en, const char *val,
+static int erofs_mkfs_feat_set_ztailpacking(struct erofs_sb_info *sbi,
+					    bool en, const char *val,
 					    unsigned int vallen)
 {
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
+
 	if (vallen)
 		return -EINVAL;
-	g_cfg.c_ztailpacking = en;
+	cfg->c_ztailpacking = en;
 	return 0;
 }
 
-static int erofs_mkfs_feat_set_fragments(bool en, const char *val,
+static int erofs_mkfs_feat_set_fragments(struct erofs_sb_info *sbi,
+					 bool en, const char *val,
 					 unsigned int vallen)
 {
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
+
 	if (!en) {
 		if (vallen)
 			return -EINVAL;
-		g_cfg.c_fragments = false;
+		cfg->c_fragments = false;
 		return 0;
 	}
 
@@ -279,29 +290,36 @@ static int erofs_mkfs_feat_set_fragments(bool en, const char *val,
 		}
 		pclustersize_packed = i;
 	}
-	g_cfg.c_fragments = true;
+	cfg->c_fragments = true;
 	return 0;
 }
 
-static int erofs_mkfs_feat_set_all_fragments(bool en, const char *val,
+static int erofs_mkfs_feat_set_all_fragments(struct erofs_sb_info *sbi,
+					     bool en, const char *val,
 					     unsigned int vallen)
 {
-	g_cfg.c_all_fragments = en;
-	return erofs_mkfs_feat_set_fragments(en, val, vallen);
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
+
+	cfg->c_all_fragments = en;
+	return erofs_mkfs_feat_set_fragments(sbi, en, val, vallen);
 }
 
-static int erofs_mkfs_feat_set_dedupe(bool en, const char *val,
+static int erofs_mkfs_feat_set_dedupe(struct erofs_sb_info *sbi,
+				      bool en, const char *val,
 				      unsigned int vallen)
 {
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
+
 	if (vallen)
 		return -EINVAL;
-	g_cfg.c_dedupe = en;
+	cfg->c_dedupe = en;
 	return 0;
 }
 
 static struct {
 	char *feat;
-	int (*set)(bool en, const char *val, unsigned int len);
+	int (*set)(struct erofs_sb_info *sbi, bool en, const char *val,
+		   unsigned int len);
 } z_erofs_mkfs_features[] = {
 	{"legacy-compress", erofs_mkfs_feat_set_legacy_compress},
 	{"ztailpacking", erofs_mkfs_feat_set_ztailpacking},
@@ -311,8 +329,10 @@ static struct {
 	{NULL, NULL},
 };
 
-static int parse_extended_opts(const char *opts)
+static int parse_extended_opts(struct erofs_sb_info *sbi, const char *opts)
 {
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
+
 #define MATCH_EXTENTED_OPT(opt, token, keylen) \
 	(keylen == strlen(opt) && !memcmp(token, opt, keylen))
 
@@ -356,12 +376,12 @@ static int parse_extended_opts(const char *opts)
 		if (MATCH_EXTENTED_OPT("force-inode-compact", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			g_cfg.c_force_inodeversion = FORCE_INODE_COMPACT;
-			g_cfg.c_ignore_mtime = true;
+			cfg->c_force_inodeversion = FORCE_INODE_COMPACT;
+			cfg->c_ignore_mtime = true;
 		} else if (MATCH_EXTENTED_OPT("force-inode-extended", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			g_cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
+			cfg->c_force_inodeversion = FORCE_INODE_EXTENDED;
 		} else if (MATCH_EXTENTED_OPT("nosbcrc", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
@@ -369,23 +389,23 @@ static int parse_extended_opts(const char *opts)
 		} else if (MATCH_EXTENTED_OPT("noinline_data", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			g_cfg.c_inline_data = false;
+			cfg->c_inline_data = false;
 		} else if (MATCH_EXTENTED_OPT("inline_data", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			g_cfg.c_inline_data = !clear;
+			cfg->c_inline_data = !clear;
 		} else if (MATCH_EXTENTED_OPT("force-inode-blockmap", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			g_cfg.c_force_chunkformat = FORCE_INODE_BLOCK_MAP;
+			cfg->c_force_chunkformat = FORCE_INODE_BLOCK_MAP;
 		} else if (MATCH_EXTENTED_OPT("force-chunk-indexes", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			g_cfg.c_force_chunkformat = FORCE_INODE_CHUNK_INDEXES;
+			cfg->c_force_chunkformat = FORCE_INODE_CHUNK_INDEXES;
 		} else if (MATCH_EXTENTED_OPT("xattr-name-filter", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			g_cfg.c_xattr_name_filter = !clear;
+			cfg->c_xattr_name_filter = !clear;
 		} else {
 			int i, err;
 
@@ -393,7 +413,7 @@ static int parse_extended_opts(const char *opts)
 				if (!MATCH_EXTENTED_OPT(z_erofs_mkfs_features[i].feat,
 							token, keylen))
 					continue;
-				err = z_erofs_mkfs_features[i].set(!clear, value, vallen);
+				err = z_erofs_mkfs_features[i].set(sbi, !clear, value, vallen);
 				if (err)
 					return err;
 				break;
@@ -409,7 +429,7 @@ static int parse_extended_opts(const char *opts)
 	return 0;
 }
 
-static int mkfs_apply_zfeature_bits(uintmax_t bits)
+static int mkfs_apply_zfeature_bits(struct erofs_sb_info *sbi, uintmax_t bits)
 {
 	int i;
 
@@ -420,7 +440,7 @@ static int mkfs_apply_zfeature_bits(uintmax_t bits)
 			erofs_err("unsupported zfeature bit %u", i);
 			return -EINVAL;
 		}
-		err = z_erofs_mkfs_features[i].set(bits & 1, NULL, 0);
+		err = z_erofs_mkfs_features[i].set(sbi, bits & 1, NULL, 0);
 		if (err) {
 			erofs_err("failed to apply zfeature %s",
 				  z_erofs_mkfs_features[i].feat);
@@ -514,8 +534,9 @@ static int mkfs_parse_one_compress_alg(char *alg,
 	return 0;
 }
 
-static int mkfs_parse_compress_algs(char *algs)
+static int mkfs_parse_compress_algs(struct erofs_sb_info *sbi, char *algs)
 {
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 	unsigned int i;
 	char *s;
 	int ret;
@@ -526,7 +547,7 @@ static int mkfs_parse_compress_algs(char *algs)
 			return -EINVAL;
 		}
 
-		ret = mkfs_parse_one_compress_alg(s, &g_cfg.c_compr_opts[i]);
+		ret = mkfs_parse_one_compress_alg(s, &cfg->c_compr_opts[i]);
 		if (ret)
 			return ret;
 	}
@@ -546,19 +567,21 @@ static void erofs_rebuild_cleanup(void)
 	rebuild_src_count = 0;
 }
 
-static int mkfs_parse_options_cfg(int argc, char *argv[])
+static int mkfs_parse_options_cfg(struct erofs_sb_info *sbi, int argc,
+				  char *argv[])
 {
 	char *endptr;
 	int opt, i, err;
 	bool quiet = false;
 	int tarerofs_decoder = 0;
 	bool has_timestamp = false;
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 
 	while ((opt = getopt_long(argc, argv, "C:E:L:T:U:b:d:x:z:Vh",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
-			i = mkfs_parse_compress_algs(optarg);
+			i = mkfs_parse_compress_algs(sbi, optarg);
 			if (i)
 				return i;
 			break;
@@ -578,7 +601,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				erofs_err("invalid debug level %d", i);
 				return -EINVAL;
 			}
-			g_cfg.c_dbg_lvl = i;
+			cfg->c_dbg_lvl = i;
 			break;
 
 		case 'x':
@@ -587,11 +610,11 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				erofs_err("invalid xattr tolerance %s", optarg);
 				return -EINVAL;
 			}
-			g_cfg.c_inline_xattr_tolerance = i;
+			cfg->c_inline_xattr_tolerance = i;
 			break;
 
 		case 'E':
-			opt = parse_extended_opts(optarg);
+			opt = parse_extended_opts(sbi, optarg);
 			if (opt)
 				return opt;
 			break;
@@ -607,8 +630,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			break;
 
 		case 'T':
-			g_cfg.c_unix_timestamp = strtoull(optarg, &endptr, 0);
-			if (g_cfg.c_unix_timestamp == -1 || *endptr != '\0') {
+			cfg->c_unix_timestamp = strtoull(optarg, &endptr, 0);
+			if (cfg->c_unix_timestamp == -1 || *endptr != '\0') {
 				erofs_err("invalid UNIX timestamp %s", optarg);
 				return -EINVAL;
 			}
@@ -639,37 +662,37 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			break;
 
 		case 4:
-			opt = erofs_selabel_open(optarg);
+			opt = erofs_selabel_open(sbi, optarg);
 			if (opt && opt != -EBUSY)
 				return opt;
 			break;
 		case 5:
-			g_cfg.c_uid = strtoul(optarg, &endptr, 0);
-			if (g_cfg.c_uid == -1 || *endptr != '\0') {
+			cfg->c_uid = strtoul(optarg, &endptr, 0);
+			if (cfg->c_uid == -1 || *endptr != '\0') {
 				erofs_err("invalid uid %s", optarg);
 				return -EINVAL;
 			}
 			break;
 		case 6:
-			g_cfg.c_gid = strtoul(optarg, &endptr, 0);
-			if (g_cfg.c_gid == -1 || *endptr != '\0') {
+			cfg->c_gid = strtoul(optarg, &endptr, 0);
+			if (cfg->c_gid == -1 || *endptr != '\0') {
 				erofs_err("invalid gid %s", optarg);
 				return -EINVAL;
 			}
 			break;
 		case 7:
-			g_cfg.c_uid = g_cfg.c_gid = 0;
+			cfg->c_uid = cfg->c_gid = 0;
 			break;
 #ifndef NDEBUG
 		case 8:
-			g_cfg.c_random_pclusterblks = true;
+			cfg->c_random_pclusterblks = true;
 			break;
 		case 18:
-			g_cfg.c_random_algorithms = true;
+			cfg->c_random_algorithms = true;
 			break;
 #endif
 		case 9:
-			g_cfg.c_max_decompressed_extent_bytes =
+			cfg->c_max_decompressed_extent_bytes =
 				strtoul(optarg, &endptr, 0);
 			if (*endptr != '\0') {
 				erofs_err("invalid maximum uncompressed extent size %s",
@@ -678,24 +701,24 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			break;
 		case 10:
-			g_cfg.c_compress_hints_file = optarg;
+			cfg->c_compress_hints_file = optarg;
 			break;
 		case 512:
-			g_cfg.mount_point = optarg;
+			cfg->mount_point = optarg;
 			/* all trailing '/' should be deleted */
-			opt = strlen(g_cfg.mount_point);
+			opt = strlen(cfg->mount_point);
 			if (opt && optarg[opt - 1] == '/')
 				optarg[opt - 1] = '\0';
 			break;
 #ifdef WITH_ANDROID
 		case 513:
-			g_cfg.target_out_path = optarg;
+			cfg->target_out_path = optarg;
 			break;
 		case 514:
-			g_cfg.fs_config_file = optarg;
+			cfg->fs_config_file = optarg;
 			break;
 		case 515:
-			g_cfg.block_list_file = optarg;
+			cfg->block_list_file = optarg;
 			break;
 #endif
 		case 'C':
@@ -713,8 +736,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				erofs_err("invalid chunksize %s", optarg);
 				return -EINVAL;
 			}
-			g_cfg.c_chunkbits = ilog2(i);
-			if ((1 << g_cfg.c_chunkbits) != i) {
+			cfg->c_chunkbits = ilog2(i);
+			if ((1 << cfg->c_chunkbits) != i) {
 				erofs_err("chunksize %s must be a power of two",
 					  optarg);
 				return -EINVAL;
@@ -725,17 +748,17 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			quiet = true;
 			break;
 		case 13:
-			g_cfg.c_blobdev_path = optarg;
+			cfg->c_blobdev_path = optarg;
 			break;
 		case 14:
-			g_cfg.c_ignore_mtime = true;
+			cfg->c_ignore_mtime = true;
 			break;
 		case 15:
-			g_cfg.c_ignore_mtime = false;
+			cfg->c_ignore_mtime = false;
 			break;
 		case 16:
 			errno = 0;
-			g_cfg.c_uid_offset = strtoll(optarg, &endptr, 0);
+			cfg->c_uid_offset = strtoll(optarg, &endptr, 0);
 			if (errno || *endptr != '\0') {
 				erofs_err("invalid uid offset %s", optarg);
 				return -EINVAL;
@@ -743,7 +766,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			break;
 		case 17:
 			errno = 0;
-			g_cfg.c_gid_offset = strtoll(optarg, &endptr, 0);
+			cfg->c_gid_offset = strtoll(optarg, &endptr, 0);
 			if (errno || *endptr != '\0') {
 				erofs_err("invalid gid offset %s", optarg);
 				return -EINVAL;
@@ -757,7 +780,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 					  erofs_strerror(opt));
 				return opt;
 			}
-			g_cfg.c_extra_ea_name_prefixes = true;
+			cfg->c_extra_ea_name_prefixes = true;
 			break;
 		case 20:
 			mkfs_parse_tar_cfg(optarg);
@@ -767,9 +790,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			break;
 		case 516:
 			if (!optarg || !strcmp(optarg, "1"))
-				g_cfg.c_ovlfs_strip = true;
+				cfg->c_ovlfs_strip = true;
 			else
-				g_cfg.c_ovlfs_strip = false;
+				cfg->c_ovlfs_strip = false;
 			break;
 		case 517:
 			g_sbi.bdev.offset = strtoull(optarg, &endptr, 0);
@@ -788,16 +811,16 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 520: {
 			unsigned int processors;
 
-			g_cfg.c_mt_workers = strtoul(optarg, &endptr, 0);
+			cfg->c_mt_workers = strtoul(optarg, &endptr, 0);
 			if (errno || *endptr != '\0') {
 				erofs_err("invalid worker number %s", optarg);
 				return -EINVAL;
 			}
 
 			processors = erofs_get_available_processors();
-			if (g_cfg.c_mt_workers > processors)
+			if (cfg->c_mt_workers > processors)
 				erofs_warn("%d workers exceed %d processors, potentially impacting performance.",
-					   g_cfg.c_mt_workers, processors);
+					   cfg->c_mt_workers, processors);
 			break;
 		}
 #endif
@@ -807,7 +830,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				erofs_err("invalid zfeature bits %s", optarg);
 				return -EINVAL;
 			}
-			err = mkfs_apply_zfeature_bits(i);
+			err = mkfs_apply_zfeature_bits(sbi, i);
 			if (err)
 				return err;
 			break;
@@ -828,20 +851,20 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			incremental_mode = (opt == 523);
 			break;
 		case 524:
-			g_cfg.c_root_xattr_isize = strtoull(optarg, &endptr, 0);
+			cfg->c_root_xattr_isize = strtoull(optarg, &endptr, 0);
 			if (*endptr != '\0') {
 				erofs_err("invalid the minimum inline xattr size %s", optarg);
 				return -EINVAL;
 			}
 			break;
 		case 525:
-			g_cfg.c_timeinherit = TIMESTAMP_NONE;
+			cfg->c_timeinherit = TIMESTAMP_NONE;
 			break;
 		case 526:
-			g_cfg.c_timeinherit = TIMESTAMP_FIXED;
+			cfg->c_timeinherit = TIMESTAMP_FIXED;
 			break;
 		case 'V':
-			version();
+			version(sbi);
 			exit(0);
 		case 'h':
 			usage(argc, argv);
@@ -852,14 +875,14 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		}
 	}
 
-	if (g_cfg.c_blobdev_path && g_cfg.c_chunkbits < g_sbi.blkszbits) {
+	if (cfg->c_blobdev_path && cfg->c_chunkbits < g_sbi.blkszbits) {
 		erofs_err("--blobdev must be used together with --chunksize");
 		return -EINVAL;
 	}
 
 	/* TODO: can be implemented with (deviceslot) mapped_blkaddr */
-	if (g_cfg.c_blobdev_path &&
-	    g_cfg.c_force_chunkformat == FORCE_INODE_BLOCK_MAP) {
+	if (cfg->c_blobdev_path &&
+	    cfg->c_force_chunkformat == FORCE_INODE_BLOCK_MAP) {
 		erofs_err("--blobdev cannot work with block map currently");
 		return -EINVAL;
 	}
@@ -869,8 +892,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		return -EINVAL;
 	}
 
-	g_cfg.c_img_path = strdup(argv[optind++]);
-	if (!g_cfg.c_img_path)
+	cfg->c_img_path = strdup(argv[optind++]);
+	if (!cfg->c_img_path)
 		return -ENOMEM;
 
 	if (optind >= argc) {
@@ -894,18 +917,18 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	} else {
 		struct stat st;
 
-		g_cfg.c_src_path = realpath(argv[optind++], NULL);
-		if (!g_cfg.c_src_path) {
+		cfg->c_src_path = realpath(argv[optind++], NULL);
+		if (!cfg->c_src_path) {
 			erofs_err("failed to parse source directory: %s",
 				  erofs_strerror(-errno));
 			return -ENOENT;
 		}
 
 		if (tar_mode) {
-			int fd = open(g_cfg.c_src_path, O_RDONLY);
+			int fd = open(cfg->c_src_path, O_RDONLY);
 
 			if (fd < 0) {
-				erofs_err("failed to open file: %s", g_cfg.c_src_path);
+				erofs_err("failed to open file: %s", cfg->c_src_path);
 				return -errno;
 			}
 			err = erofs_iostream_open(&erofstar.ios, fd,
@@ -924,17 +947,17 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				erofstar.ios.dumpfd = fd;
 			}
 		} else {
-			err = lstat(g_cfg.c_src_path, &st);
+			err = lstat(cfg->c_src_path, &st);
 			if (err)
 				return -errno;
 			if (S_ISDIR(st.st_mode))
-				erofs_set_fs_root(g_cfg.c_src_path);
+				erofs_set_fs_root(cfg->c_src_path);
 			else
 				rebuild_mode = true;
 		}
 
 		if (rebuild_mode) {
-			char *srcpath = g_cfg.c_src_path;
+			char *srcpath = cfg->c_src_path;
 			struct erofs_sb_info *src;
 
 			do {
@@ -961,11 +984,11 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		}
 	}
 	if (quiet) {
-		g_cfg.c_dbg_lvl = EROFS_ERR;
-		g_cfg.c_showprogress = false;
+		cfg->c_dbg_lvl = EROFS_ERR;
+		cfg->c_showprogress = false;
 	}
 
-	if (g_cfg.c_compr_opts[0].alg && erofs_blksiz(&g_sbi) != getpagesize())
+	if (cfg->c_compr_opts[0].alg && erofs_blksiz(&g_sbi) != getpagesize())
 		erofs_warn("Please note that subpage blocksize with compression isn't yet supported in kernel. "
 			   "This compressed image will only work with bs = ps = %u bytes",
 			   erofs_blksiz(&g_sbi));
@@ -977,12 +1000,12 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				  pclustersize_max);
 			return -EINVAL;
 		}
-		g_cfg.c_mkfs_pclustersize_max = pclustersize_max;
-		g_cfg.c_mkfs_pclustersize_def = g_cfg.c_mkfs_pclustersize_max;
+		cfg->c_mkfs_pclustersize_max = pclustersize_max;
+		cfg->c_mkfs_pclustersize_def = cfg->c_mkfs_pclustersize_max;
 	}
-	if (g_cfg.c_chunkbits && g_cfg.c_chunkbits < g_sbi.blkszbits) {
+	if (cfg->c_chunkbits && cfg->c_chunkbits < g_sbi.blkszbits) {
 		erofs_err("chunksize %u must be larger than block size",
-			  1u << g_cfg.c_chunkbits);
+			  1u << cfg->c_chunkbits);
 		return -EINVAL;
 	}
 
@@ -993,35 +1016,38 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				  pclustersize_packed);
 			return -EINVAL;
 		}
-		g_cfg.c_mkfs_pclustersize_packed = pclustersize_packed;
+		cfg->c_mkfs_pclustersize_packed = pclustersize_packed;
 	}
 
-	if (has_timestamp && g_cfg.c_timeinherit == TIMESTAMP_UNSPECIFIED)
-		g_cfg.c_timeinherit = TIMESTAMP_FIXED;
+	if (has_timestamp && cfg->c_timeinherit == TIMESTAMP_UNSPECIFIED)
+		cfg->c_timeinherit = TIMESTAMP_FIXED;
 	return 0;
 }
 
-static void erofs_mkfs_default_options(void)
+static void erofs_mkfs_default_options(struct erofs_sb_info *sbi)
 {
-	g_cfg.c_showprogress = true;
-	g_cfg.c_legacy_compress = false;
-	g_cfg.c_inline_data = true;
-	g_cfg.c_xattr_name_filter = true;
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
+
+	cfg->c_showprogress = true;
+	cfg->c_legacy_compress = false;
+	cfg->c_inline_data = true;
+	cfg->c_xattr_name_filter = true;
 #ifdef EROFS_MT_ENABLED
-	g_cfg.c_mt_workers = erofs_get_available_processors();
-	g_cfg.c_mkfs_segment_size = 16ULL * 1024 * 1024;
+	cfg->c_mt_workers = erofs_get_available_processors();
+	cfg->c_mkfs_segment_size = 16ULL * 1024 * 1024;
 #endif
 	g_sbi.blkszbits = ilog2(min_t(u32, getpagesize(), EROFS_MAX_BLOCK_SIZE));
-	g_cfg.c_mkfs_pclustersize_max = erofs_blksiz(&g_sbi);
-	g_cfg.c_mkfs_pclustersize_def = g_cfg.c_mkfs_pclustersize_max;
+	cfg->c_mkfs_pclustersize_max = erofs_blksiz(&g_sbi);
+	cfg->c_mkfs_pclustersize_def = cfg->c_mkfs_pclustersize_max;
 	g_sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_ZERO_PADDING;
 	g_sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
 			     EROFS_FEATURE_COMPAT_MTIME;
 }
 
 /* https://reproducible-builds.org/specs/source-date-epoch/ for more details */
-int parse_source_date_epoch(void)
+int parse_source_date_epoch(struct erofs_sb_info *sbi)
 {
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 	char *source_date_epoch;
 	unsigned long long epoch = -1ULL;
 	char *endptr;
@@ -1037,19 +1063,21 @@ int parse_source_date_epoch(void)
 		return -EINVAL;
 	}
 
-	if (g_cfg.c_force_inodeversion != FORCE_INODE_EXTENDED)
+	if (cfg->c_force_inodeversion != FORCE_INODE_EXTENDED)
 		erofs_info("SOURCE_DATE_EPOCH is set, forcely generate extended inodes instead");
 
-	g_cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
-	g_cfg.c_unix_timestamp = epoch;
-	g_cfg.c_timeinherit = TIMESTAMP_CLAMPING;
+	cfg->c_force_inodeversion = FORCE_INODE_EXTENDED;
+	cfg->c_unix_timestamp = epoch;
+	cfg->c_timeinherit = TIMESTAMP_CLAMPING;
 	return 0;
 }
 
-void erofs_show_progs(int argc, char *argv[])
+void erofs_show_progs(struct erofs_sb_info *sbi, int argc, char *argv[])
 {
-	if (g_cfg.c_dbg_lvl >= EROFS_WARN)
-		printf("%s %s\n", basename(argv[0]), g_cfg.c_version);
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
+
+	if (cfg->c_dbg_lvl >= EROFS_WARN)
+		printf("%s %s\n", basename(argv[0]), cfg->c_version);
 }
 
 static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
@@ -1131,12 +1159,13 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 	return 0;
 }
 
-static void erofs_mkfs_showsummaries(erofs_blk_t nblocks)
+static void erofs_mkfs_showsummaries(struct erofs_sb_info *sbi, erofs_blk_t nblocks)
 {
+	struct erofs_configure *cfg = sbi->bt_args->cfg;
 	char uuid_str[37] = {};
 	char *incr = incremental_mode ? "new" : "total";
 
-	if (!(g_cfg.c_dbg_lvl > EROFS_ERR && g_cfg.c_showprogress))
+	if (!(cfg->c_dbg_lvl > EROFS_ERR && cfg->c_showprogress))
 		return;
 
 	erofs_uuid_unparse_lower(g_sbi.uuid, uuid_str);
@@ -1161,33 +1190,36 @@ int main(int argc, char **argv)
 	FILE *packedfile = NULL;
 	FILE *blklst = NULL;
 	u32 crc;
+	struct erofs_configure *cfg = NULL;
 
-	erofs_init_configure();
-	erofs_mkfs_default_options();
+	erofs_init_buildtree_cfg(&g_sbi, &g_cfg);
+	erofs_mkfs_default_options(&g_sbi);
 
-	err = mkfs_parse_options_cfg(argc, argv);
-	erofs_show_progs(argc, argv);
+	cfg = g_sbi.bt_args->cfg;
+	BUG_ON(!cfg);
+	err = mkfs_parse_options_cfg(&g_sbi, argc, argv);
+	erofs_show_progs(&g_sbi, argc, argv);
 	if (err) {
 		if (err == -EINVAL)
 			fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
 		return 1;
 	}
 
-	err = parse_source_date_epoch();
+	err = parse_source_date_epoch(&g_sbi);
 	if (err) {
 		fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
 		return 1;
 	}
 
-	if (g_cfg.c_unix_timestamp != -1) {
-		g_sbi.build_time      = g_cfg.c_unix_timestamp;
+	if (cfg->c_unix_timestamp != -1) {
+		g_sbi.build_time      = cfg->c_unix_timestamp;
 		g_sbi.build_time_nsec = 0;
 	} else if (!gettimeofday(&t, NULL)) {
 		g_sbi.build_time      = t.tv_sec;
 		g_sbi.build_time_nsec = t.tv_usec;
 	}
 
-	err = erofs_dev_open(&g_sbi, g_cfg.c_img_path, O_RDWR |
+	err = erofs_dev_open(&g_sbi, cfg->c_img_path, O_RDWR |
 				(incremental_mode ? 0 : O_TRUNC));
 	if (err) {
 		fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
@@ -1195,24 +1227,24 @@ int main(int argc, char **argv)
 	}
 
 #ifdef WITH_ANDROID
-	if (g_cfg.fs_config_file &&
-	    load_canned_fs_config(g_cfg.fs_config_file) < 0) {
-		erofs_err("failed to load fs config %s", g_cfg.fs_config_file);
+	if (cfg->fs_config_file &&
+	    load_canned_fs_config(cfg->fs_config_file) < 0) {
+		erofs_err("failed to load fs config %s", cfg->fs_config_file);
 		return 1;
 	}
 
-	if (g_cfg.block_list_file) {
-		blklst = fopen(g_cfg.block_list_file, "w");
+	if (cfg->block_list_file) {
+		blklst = fopen(cfg->block_list_file, "w");
 		if (!blklst || erofs_blocklist_open(blklst, false)) {
-			erofs_err("failed to open %s", g_cfg.block_list_file);
+			erofs_err("failed to open %s", cfg->block_list_file);
 			return 1;
 		}
 	}
 #endif
-	erofs_show_config();
-	if (g_cfg.c_fragments || g_cfg.c_extra_ea_name_prefixes) {
-		if (!g_cfg.c_mkfs_pclustersize_packed)
-			g_cfg.c_mkfs_pclustersize_packed = g_cfg.c_mkfs_pclustersize_def;
+	erofs_show_config(cfg);
+	if (cfg->c_fragments || cfg->c_extra_ea_name_prefixes) {
+		if (!cfg->c_mkfs_pclustersize_packed)
+			cfg->c_mkfs_pclustersize_packed = cfg->c_mkfs_pclustersize_def;
 
 		packedfile = erofs_packedfile_init();
 		if (IS_ERR(packedfile)) {
@@ -1221,7 +1253,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (g_cfg.c_fragments) {
+	if (cfg->c_fragments) {
 		err = z_erofs_fragments_init();
 		if (err) {
 			erofs_err("failed to initialize fragments");
@@ -1230,7 +1262,7 @@ int main(int argc, char **argv)
 	}
 
 #ifndef NDEBUG
-	if (g_cfg.c_random_pclusterblks)
+	if (cfg->c_random_pclusterblks)
 		srand(time(NULL));
 #endif
 	if (tar_mode) {
@@ -1325,7 +1357,7 @@ int main(int argc, char **argv)
 	err = erofs_load_compress_hints(&g_sbi);
 	if (err) {
 		erofs_err("failed to load compress hints %s",
-			  g_cfg.c_compress_hints_file);
+			  cfg->c_compress_hints_file);
 		goto exit;
 	}
 
@@ -1336,10 +1368,10 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	if (g_cfg.c_dedupe) {
-		if (!g_cfg.c_compr_opts[0].alg) {
+	if (cfg->c_dedupe) {
+		if (!cfg->c_compr_opts[0].alg) {
 			erofs_err("Compression is not enabled.  Turn on chunk-based data deduplication instead.");
-			g_cfg.c_chunkbits = g_sbi.blkszbits;
+			cfg->c_chunkbits = g_sbi.blkszbits;
 		} else {
 			err = z_erofs_dedupe_init(erofs_blksiz(&g_sbi));
 			if (err) {
@@ -1350,14 +1382,14 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (g_cfg.c_chunkbits) {
-		err = erofs_blob_init(g_cfg.c_blobdev_path, 1 << g_cfg.c_chunkbits);
+	if (cfg->c_chunkbits) {
+		err = erofs_blob_init(cfg->c_blobdev_path, 1 << cfg->c_chunkbits);
 		if (err)
 			return 1;
 	}
 
 	if (((erofstar.index_mode && !erofstar.headeronly_mode) &&
-	    !erofstar.mapfile) || g_cfg.c_blobdev_path) {
+	    !erofstar.mapfile) || cfg->c_blobdev_path) {
 		err = erofs_mkfs_init_devices(&g_sbi, 1);
 		if (err) {
 			erofs_err("failed to generate device table: %s",
@@ -1397,17 +1429,17 @@ int main(int argc, char **argv)
 		if (err)
 			goto exit;
 	} else {
-		err = erofs_build_shared_xattrs_from_path(&g_sbi, g_cfg.c_src_path);
+		err = erofs_build_shared_xattrs_from_path(&g_sbi, cfg->c_src_path);
 		if (err) {
 			erofs_err("failed to build shared xattrs: %s",
 				  erofs_strerror(err));
 			goto exit;
 		}
 
-		if (g_cfg.c_extra_ea_name_prefixes)
+		if (cfg->c_extra_ea_name_prefixes)
 			erofs_xattr_write_name_prefixes(&g_sbi, packedfile);
 
-		root = erofs_mkfs_build_tree_from_path(&g_sbi, g_cfg.c_src_path);
+		root = erofs_mkfs_build_tree_from_path(&g_sbi, cfg->c_src_path);
 		if (IS_ERR(root)) {
 			err = PTR_ERR(root);
 			goto exit;
@@ -1418,13 +1450,13 @@ int main(int argc, char **argv)
 		g_sbi.devs[0].blocks = BLK_ROUND_UP(&g_sbi, erofstar.offset);
 
 	if (erofs_sb_has_fragments(&g_sbi)) {
-		erofs_update_progressinfo("Handling packed data ...");
+		erofs_update_progressinfo(&g_sbi, "Handling packed data ...");
 		err = erofs_flush_packed_inode(&g_sbi);
 		if (err)
 			goto exit;
 	}
 
-	if (erofstar.index_mode || g_cfg.c_chunkbits || g_sbi.extra_devices) {
+	if (erofstar.index_mode || cfg->c_chunkbits || g_sbi.extra_devices) {
 		err = erofs_mkfs_dump_blobs(&g_sbi);
 		if (err)
 			goto exit;
@@ -1458,7 +1490,7 @@ int main(int argc, char **argv)
 exit:
 	if (root)
 		erofs_iput(root);
-	z_erofs_compress_exit();
+	z_erofs_compress_exit(&g_sbi);
 	z_erofs_dedupe_exit();
 	blklst = erofs_blocklist_close();
 	if (blklst)
@@ -1466,15 +1498,14 @@ exit:
 	erofs_dev_close(&g_sbi);
 	erofs_cleanup_compress_hints();
 	erofs_cleanup_exclude_rules();
-	if (g_cfg.c_chunkbits)
+	if (cfg->c_chunkbits)
 		erofs_blob_exit();
-	if (g_cfg.c_fragments)
+	if (cfg->c_fragments)
 		z_erofs_fragments_exit();
 	erofs_packedfile_exit();
 	erofs_xattr_cleanup_name_prefixes();
 	erofs_rebuild_cleanup();
 	erofs_diskbuf_exit();
-	erofs_exit_configure();
 	if (tar_mode) {
 		erofs_iostream_close(&erofstar.ios);
 		if (erofstar.ios.dumpfd >= 0)
@@ -1486,8 +1517,9 @@ exit:
 			  erofs_strerror(err));
 		return 1;
 	}
-	erofs_update_progressinfo("Build completed.\n");
-	erofs_mkfs_showsummaries(nblocks);
+	erofs_update_progressinfo(&g_sbi, "Build completed.\n");
+	erofs_mkfs_showsummaries(&g_sbi, nblocks);
+	erofs_exit_buildtree_cfg(&g_sbi);
 	erofs_put_super(&g_sbi);
 	return 0;
 }
-- 
2.43.5

