Return-Path: <linux-erofs+bounces-1079-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E2AB948ED
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 08:29:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW96n6h4Jz2ysc;
	Tue, 23 Sep 2025 16:29:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758608945;
	cv=none; b=XHQ41XYKOtbLsxzgMZHZ905nuV//LqlOpnLB/nGbhXf5GbybBVqPy4C4eFGoB5DpBWzqwg1pl8mXtUhekyp62+3O1slUfDhRLwPBmcoXML/QIp9jSQXXxuP9J48cbgB9hiMdMf0NSscqEj6JzKErobaBRWYJtVEoZKrYABGBC8kVcn9BYXvIWUNjUoFN4pGyqEBtQ3iE8WI9UL2KwfDYcVK0RVLa5K35k+ZBg+J9NGiGMTnGBn2hLXJ/ZAfaUuhLNhMYZSLDstMk5b604oDBVn6c+4+X4Vo5yQCKxLrhJSUjAZ4y2QwGy03nWOk+r/jHnB6FN00M22UGiu1vWYMxkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758608945; c=relaxed/relaxed;
	bh=gtbM746Eu9wjc2dEwpXEW23ajU5SEHksUDObsiam7xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oz4X8XHzeYitnbk6Kz0ERx90IwIUQEohEpW/eoZgA+yll3ulhzfNRwx310dWh9goudDVeJMVo8yoSq/aK/sjOlG8YqpEr1rSBpYZKNTy9WT0pol2AzSVXU3wQwrSLgSrI8egrrAtxtD1jOmfthvHo7F/jjUOcd/IxXQ2oellB8HhKJmdnCsi8PgVgNRz/87q000yUoa+l6+BikniIf5agkb5xUvnp1IM7P2D1/GRds+Rx0u+R0YCfp05S1cJNbPDAnOujAPy0Fw0W7UfLqFbrdVqM7E7O+aC8q97LZFFrZcd+EAPisuXxh7m6Xn76x9hiOHc4+4o6L7QxifJpPAz1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=N1/77IQQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=N1/77IQQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cW96l00jpz3cYR
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 16:29:02 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758608939; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gtbM746Eu9wjc2dEwpXEW23ajU5SEHksUDObsiam7xw=;
	b=N1/77IQQPvm2pkFPL2zg9R5xulDXwYDRXhDsBPcXsSBRscb/8kU9dGA5UjFAFaAI+znSOolvAo2WWuN0NViNDfCqMk1KzpgRwxbzOrwBk9u+Q58hiT90nYlsylggUi7BjylYhqPXl7qv4S9F2hhc552EUTjbTOLTN04xi+WJ214=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wodx0PF_1758608937 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 14:28:57 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4/4] erofs-utils: lib: migrate advance compression configurations
Date: Tue, 23 Sep 2025 14:28:48 +0800
Message-ID: <20250923062848.1712858-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250923062848.1712858-1-hsiangkao@linux.alibaba.com>
References: <20250923062848.1712858-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h   | 11 --------
 include/erofs/importer.h | 11 ++++++++
 include/erofs/xattr.h    |  4 ++-
 lib/compress.c           | 47 ++++++++++++++++++-------------
 lib/compressor_deflate.c |  3 +-
 lib/importer.c           |  9 +++---
 lib/inode.c              |  4 +--
 lib/xattr.c              |  7 +++--
 mkfs/main.c              | 61 ++++++++++++++++++++++++----------------
 9 files changed, 93 insertions(+), 64 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 59cf4f2..3b1438f 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -27,12 +27,6 @@ enum {
 	TIMESTAMP_CLAMPING,
 };
 
-enum {
-	FRAGDEDUPE_FULL,
-	FRAGDEDUPE_INODE,
-	FRAGDEDUPE_OFF,
-};
-
 #define EROFS_MAX_COMPR_CFGS		64
 
 struct erofs_compr_opts {
@@ -48,11 +42,6 @@ struct erofs_configure {
 	bool c_legacy_compress;
 	char c_timeinherit;
 	char c_chunkbits;
-	bool c_ztailpacking;
-	bool c_fragments;
-	bool c_all_fragments;
-	bool c_dedupe;
-	char c_fragdedupe;
 	bool c_showprogress;
 	bool c_extra_ea_name_prefixes;
 	bool c_xattr_name_filter;
diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index 6033e68..3153732 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -17,6 +17,12 @@ enum {
 	EROFS_FORCE_INODE_EXTENDED,
 };
 
+enum {
+	EROFS_FRAGDEDUPE_FULL,
+	EROFS_FRAGDEDUPE_INODE,
+	EROFS_FRAGDEDUPE_OFF,
+};
+
 struct erofs_importer_params {
 	char *source;
 	u32 mt_async_queue_limit;
@@ -35,6 +41,11 @@ struct erofs_importer_params {
 	bool hard_dereference;
 	bool ovlfs_strip;
 	bool dot_omitted;
+	bool ztailpacking;
+	bool dedupe;
+	bool fragments;
+	bool all_fragments;
+	char fragdedupe;
 };
 
 struct erofs_importer {
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 769791a..3a82ad7 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -43,6 +43,8 @@ static inline unsigned int xattrblock_offset(struct erofs_inode *vi,
 	(_size - sizeof(struct erofs_xattr_ibody_header)) / \
 	sizeof(struct erofs_xattr_entry) + 1; })
 
+struct erofs_importer;
+
 int erofs_scan_file_xattrs(struct erofs_inode *inode);
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode, bool noroom);
 char *erofs_export_xattr_ibody(struct erofs_inode *inode);
@@ -50,7 +52,7 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 
 int erofs_xattr_insert_name_prefix(const char *prefix);
 void erofs_xattr_cleanup_name_prefixes(void);
-int erofs_xattr_flush_name_prefixes(struct erofs_sb_info *sbi, bool plain);
+int erofs_xattr_flush_name_prefixes(struct erofs_importer *im, bool plain);
 void erofs_xattr_prefixes_cleanup(struct erofs_sb_info *sbi);
 int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi);
 
diff --git a/lib/compress.c b/lib/compress.c
index 988c444..0d179e7 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -159,6 +159,7 @@ static void z_erofs_fini_full_indexes(struct z_erofs_compress_ictx *ctx)
 static void z_erofs_write_full_indexes(struct z_erofs_compress_ictx *ctx,
 				       struct z_erofs_inmem_extent *e)
 {
+	const struct erofs_importer_params *params = ctx->im->params;
 	struct erofs_inode *inode = ctx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
 	unsigned int clusterofs = ctx->clusterofs;
@@ -179,7 +180,7 @@ static void z_erofs_write_full_indexes(struct z_erofs_compress_ictx *ctx,
 		 * A lcluster cannot have three parts with the middle one which
 		 * is well-compressed for !ztailpacking cases.
 		 */
-		DBG_BUGON(!e->raw && !cfg.c_ztailpacking && !cfg.c_fragments);
+		DBG_BUGON(!e->raw && !params->ztailpacking && !params->fragments);
 		DBG_BUGON(e->partial);
 		type = e->raw ? Z_EROFS_LCLUSTER_TYPE_PLAIN :
 			Z_EROFS_LCLUSTER_TYPE_HEAD1;
@@ -563,6 +564,7 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	static char g_dstbuf[Z_EROFS_DESTBUF_SZ];
 	char *dstbuf = ctx->destbuf ?: g_dstbuf;
 	struct z_erofs_compress_ictx *ictx = ctx->ictx;
+	const struct erofs_importer_params *params = ictx->im->params;
 	struct erofs_inode *inode = ictx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
 	unsigned int blksz = erofs_blksiz(sbi);
@@ -571,10 +573,10 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	unsigned int len = ctx->tail - ctx->head;
 	bool is_packed_inode = erofs_is_packed_inode(inode);
 	bool tsg = (ctx->seg_idx + 1 >= ictx->seg_num), final = !ctx->remaining;
-	bool may_packing = (cfg.c_fragments && tsg && final && !is_packed_inode &&
+	bool may_packing = (params->fragments && tsg && final && !is_packed_inode &&
 			    !erofs_is_metabox_inode(inode));
 	bool data_unaligned = ictx->data_unaligned;
-	bool may_inline = (cfg.c_ztailpacking && !data_unaligned && tsg &&
+	bool may_inline = (params->ztailpacking && !data_unaligned && tsg &&
 			   final && !may_packing);
 	unsigned int compressedsize;
 	int ret;
@@ -633,7 +635,7 @@ retry_aligned:
 			may_packing = false;
 			e->length = min_t(u32, e->length, ctx->pclustersize);
 nocompression:
-			if (cfg.c_dedupe)
+			if (params->dedupe)
 				ret = write_uncompressed_block(ctx, len, dst);
 			else
 				ret = write_uncompressed_extents(ctx, len,
@@ -1250,8 +1252,9 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 			     u64 offset, erofs_off_t pstart)
 {
 	struct z_erofs_compress_ictx *ictx = ctx->ictx;
+	const struct erofs_importer_params *params = ictx->im->params;
 	struct erofs_inode *inode = ictx->inode;
-	bool frag = cfg.c_fragments && !erofs_is_packed_inode(inode) &&
+	bool frag = params->fragments && !erofs_is_packed_inode(inode) &&
 		!erofs_is_metabox_inode(inode) &&
 		ctx->seg_idx >= ictx->seg_num - 1;
 	int fd = ictx->fd;
@@ -1259,7 +1262,7 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 
 	DBG_BUGON(offset != -1 && frag && inode->fragment_size);
 	if (offset != -1 && frag && !inode->fragment_size &&
-	    cfg.c_fragdedupe != FRAGDEDUPE_OFF) {
+	    params->fragdedupe != EROFS_FRAGDEDUPE_OFF) {
 		ret = erofs_fragment_findmatch(inode, fd, ictx->tofh);
 		if (ret < 0)
 			return ret;
@@ -1324,6 +1327,7 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 				 erofs_off_t pstart, erofs_off_t ptotal)
 {
 	struct erofs_inode *inode = ictx->inode;
+	const struct erofs_importer_params *params = ictx->im->params;
 	struct erofs_sb_info *sbi = inode->sbi;
 	unsigned int legacymetasize, bbits = sbi->blkszbits;
 	u8 *compressmeta;
@@ -1374,7 +1378,7 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 
 	if (ptotal)
 		(void)erofs_bh_balloon(bh, ptotal);
-	else if (!cfg.c_fragments && !cfg.c_dedupe)
+	else if (!params->fragments && !params->dedupe)
 		DBG_BUGON(!inode->idata_size);
 
 	erofs_info("compressed %s (%llu bytes) into %llu bytes",
@@ -1537,8 +1541,9 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
 			  struct z_erofs_compress_sctx *sctx)
 {
 	struct z_erofs_extent_item *ei, *n;
+	const struct erofs_importer_params *params = ictx->im->params;
 	struct erofs_sb_info *sbi = ictx->inode->sbi;
-	bool dedupe_ext = cfg.c_fragments;
+	bool dedupe_ext = params->fragments;
 	erofs_off_t off = 0;
 	int ret = 0, ret2;
 	erofs_off_t dpo;
@@ -1721,9 +1726,10 @@ out:
 	return ret;
 }
 
-static int z_erofs_mt_global_init(void)
+static int z_erofs_mt_global_init(struct erofs_importer *im)
 {
 	static erofs_atomic_bool_t __initonce;
+	struct erofs_importer_params *params = im->params;
 	unsigned int workers = cfg.c_mt_workers;
 	int ret;
 
@@ -1733,7 +1739,8 @@ static int z_erofs_mt_global_init(void)
 	z_erofs_mt_enabled = false;
 	if (workers < 1)
 		return 0;
-	if (workers >= 1 && cfg.c_dedupe) {
+	/* XXX: `dedupe` is actually not a global option here. */
+	if (workers >= 1 && params->dedupe) {
 		erofs_warn("multi-threaded dedupe is NOT implemented for now");
 		cfg.c_mt_workers = 0;
 	} else {
@@ -1771,7 +1778,7 @@ int z_erofs_mt_global_exit(void)
 	return 0;
 }
 #else
-static int z_erofs_mt_global_init(void)
+static int z_erofs_mt_global_init(struct erofs_importer *im)
 {
 	z_erofs_mt_enabled = false;
 	return 0;
@@ -1786,11 +1793,12 @@ int z_erofs_mt_global_exit(void)
 void *erofs_begin_compressed_file(struct erofs_importer *im,
 				  struct erofs_inode *inode, int fd, u64 fpos)
 {
+	const struct erofs_importer_params *params = im->params;
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct z_erofs_compress_ictx *ictx;
-	bool frag = cfg.c_fragments && !erofs_is_packed_inode(inode) &&
+	bool frag = params->fragments && !erofs_is_packed_inode(inode) &&
 		!erofs_is_metabox_inode(inode);
-	bool all_fragments = cfg.c_all_fragments && frag;
+	bool all_fragments = params->all_fragments && frag;
 	int ret;
 
 	/* initialize per-file compression setting */
@@ -1835,12 +1843,13 @@ void *erofs_begin_compressed_file(struct erofs_importer *im,
 	ictx->data_unaligned = erofs_sb_has_48bit(sbi) &&
 		cfg.c_max_decompressed_extent_bytes <=
 			z_erofs_get_pclustersize(ictx);
-	if (cfg.c_fragments && !cfg.c_dedupe && !ictx->data_unaligned)
+	if (params->fragments && !params->dedupe && !ictx->data_unaligned)
 		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 
 	if (frag) {
 		ictx->tofh = z_erofs_fragments_tofh(inode, fd, fpos);
-		if (ictx == &g_ictx && cfg.c_fragdedupe != FRAGDEDUPE_OFF) {
+		if (ictx == &g_ictx &&
+		    params->fragdedupe != EROFS_FRAGDEDUPE_OFF) {
 			/*
 			 * Handle tails in advance to avoid writing duplicated
 			 * parts into the packed inode.
@@ -1849,7 +1858,7 @@ void *erofs_begin_compressed_file(struct erofs_importer *im,
 			if (ret < 0)
 				goto err_free_ictx;
 
-			if (cfg.c_fragdedupe == FRAGDEDUPE_INODE &&
+			if (params->fragdedupe == EROFS_FRAGDEDUPE_INODE &&
 			    inode->fragment_size < inode->i_size) {
 				erofs_dbg("Discard the sub-inode tail fragment of %s",
 					  inode->i_srcpath);
@@ -1863,7 +1872,7 @@ void *erofs_begin_compressed_file(struct erofs_importer *im,
 	ictx->fragemitted = false;
 	ictx->dedupe = false;
 
-	if (all_fragments && !inode->fragment_size) {
+	if (params->all_fragments && !inode->fragment_size) {
 		ret = erofs_pack_file_from_fd(inode, fd, ictx->tofh);
 		if (ret)
 			goto err_free_idata;
@@ -2148,12 +2157,12 @@ int z_erofs_compress_init(struct erofs_importer *im)
 			return ret;
 	}
 
-	ret = z_erofs_mt_global_init();
+	ret = z_erofs_mt_global_init(im);
 	if (ret)
 		return ret;
 
 #ifdef EROFS_MT_ENABLED
-	if (cfg.c_fragments && cfg.c_mt_workers > 1 && newzmgr) {
+	if (params->fragments && cfg.c_mt_workers > 1 && newzmgr) {
 		for (i = 0; i < ARRAY_SIZE(sbi->zmgr->fslot); ++i) {
 			init_list_head(&sbi->zmgr->fslot[i].pending);
 			pthread_mutex_init(&sbi->zmgr->fslot[i].lock, NULL);
diff --git a/lib/compressor_deflate.c b/lib/compressor_deflate.c
index e482224..704a8bb 100644
--- a/lib/compressor_deflate.c
+++ b/lib/compressor_deflate.c
@@ -70,7 +70,8 @@ static int erofs_compressor_deflate_setlevel(struct erofs_compress *c,
 }
 
 static int erofs_compressor_deflate_setdictsize(struct erofs_compress *c,
-						u32 dict_size)
+						u32 dict_size,
+						u32 pclustersize_max)
 {
 	if (!dict_size)
 		dict_size = erofs_compressor_deflate.default_dictsize;
diff --git a/lib/importer.c b/lib/importer.c
index e0ab505..c855d34 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -51,12 +51,12 @@ int erofs_importer_init(struct erofs_importer *im)
 	if (err)
 		goto out_err;
 
-	if (cfg.c_fragments || cfg.c_extra_ea_name_prefixes) {
+	if (params->fragments || cfg.c_extra_ea_name_prefixes) {
 		subsys = "packedfile";
 		if (!params->pclusterblks_packed)
 			params->pclusterblks_packed = params->pclusterblks_def;
 
-		err = erofs_packedfile_init(sbi, cfg.c_fragments);
+		err = erofs_packedfile_init(sbi, params->fragments);
 		if (err)
 			goto out_err;
 	}
@@ -66,7 +66,7 @@ int erofs_importer_init(struct erofs_importer *im)
 	if (err)
 		goto out_err;
 
-	if (cfg.c_fragments) {
+	if (params->fragments) {
 		subsys = "dedupe_ext";
 		err = z_erofs_dedupe_ext_init();
 		if (err)
@@ -84,6 +84,7 @@ out_err:
 
 int erofs_importer_flush_all(struct erofs_importer *im)
 {
+	const struct erofs_importer_params *params = im->params;
 	struct erofs_sb_info *sbi = im->sbi;
 	unsigned int fsalignblks;
 	int err;
@@ -95,7 +96,7 @@ int erofs_importer_flush_all(struct erofs_importer *im)
 			return err;
 	}
 
-	if ((cfg.c_fragments || cfg.c_extra_ea_name_prefixes) &&
+	if ((params->fragments || cfg.c_extra_ea_name_prefixes) &&
 	    erofs_sb_has_fragments(sbi)) {
 		erofs_update_progressinfo("Handling packed data ...");
 		err = erofs_flush_packed_inode(im);
diff --git a/lib/inode.c b/lib/inode.c
index 102cc64..e57a0db 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -874,7 +874,7 @@ static bool erofs_inode_need_48bit(struct erofs_inode *inode)
 static int erofs_prepare_inode_buffer(struct erofs_importer *im,
 				      struct erofs_inode *inode)
 {
-	struct erofs_importer_params *params = im->params;
+	const struct erofs_importer_params *params = im->params;
 	struct erofs_sb_info *sbi = im->sbi;
 	struct erofs_bufmgr *bmgr = sbi->bmgr;
 	struct erofs_bufmgr *ibmgr = bmgr;
@@ -942,7 +942,7 @@ noinline:
 		return PTR_ERR(bh);
 	} else if (inode->idata_size) {
 		if (is_inode_layout_compression(inode)) {
-			DBG_BUGON(!cfg.c_ztailpacking);
+			DBG_BUGON(!params->ztailpacking);
 			erofs_dbg("Inline %scompressed data (%u bytes) to %s",
 				  inode->compressed_idata ? "" : "un",
 				  inode->idata_size, inode->i_srcpath);
diff --git a/lib/xattr.c b/lib/xattr.c
index 8d86c1b..2e109dc 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -16,6 +16,7 @@
 #include "erofs/hashtable.h"
 #include "erofs/xattr.h"
 #include "erofs/fragments.h"
+#include "erofs/importer.h"
 #include "liberofs_cache.h"
 #include "liberofs_metabox.h"
 #include "liberofs_xxhash.h"
@@ -805,9 +806,11 @@ static int comp_shared_xattr_item(const void *a, const void *b)
 	return la > lb;
 }
 
-int erofs_xattr_flush_name_prefixes(struct erofs_sb_info *sbi, bool plain)
+int erofs_xattr_flush_name_prefixes(struct erofs_importer *im, bool plain)
 {
-	bool may_fragments = cfg.c_fragments || erofs_sb_has_fragments(sbi);
+	const struct erofs_importer_params *params = im->params;
+	struct erofs_sb_info *sbi = im->sbi;
+	bool may_fragments = params->fragments || erofs_sb_has_fragments(sbi);
 	struct erofs_vfile *vf = &sbi->bdev;
 	struct erofs_bufmgr *bmgr = sbi->bmgr;
 	struct erofs_buffer_head *bh = NULL;
diff --git a/mkfs/main.c b/mkfs/main.c
index a738907..819faaf 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -304,7 +304,8 @@ static int tarerofs_decoder;
 static FILE *vmdk_dcf;
 static char *mkfs_aws_zinfo_file;
 
-static int erofs_mkfs_feat_set_legacy_compress(bool en, const char *val,
+static int erofs_mkfs_feat_set_legacy_compress(struct erofs_importer_params *params,
+					       bool en, const char *val,
 					       unsigned int vallen)
 {
 	if (vallen)
@@ -314,22 +315,25 @@ static int erofs_mkfs_feat_set_legacy_compress(bool en, const char *val,
 	return 0;
 }
 
-static int erofs_mkfs_feat_set_ztailpacking(bool en, const char *val,
+static int erofs_mkfs_feat_set_ztailpacking(struct erofs_importer_params *params,
+					    bool en, const char *val,
 					    unsigned int vallen)
 {
 	if (vallen)
 		return -EINVAL;
-	cfg.c_ztailpacking = en;
+
+	params->ztailpacking = en;
 	return 0;
 }
 
-static int erofs_mkfs_feat_set_fragments(bool en, const char *val,
+static int erofs_mkfs_feat_set_fragments(struct erofs_importer_params *params,
+					 bool en, const char *val,
 					 unsigned int vallen)
 {
 	if (!en) {
 		if (vallen)
 			return -EINVAL;
-		cfg.c_fragments = false;
+		params->fragments = false;
 		return 0;
 	}
 
@@ -343,43 +347,47 @@ static int erofs_mkfs_feat_set_fragments(bool en, const char *val,
 		}
 		pclustersize_packed = i;
 	}
-	cfg.c_fragments = true;
+	params->fragments = true;
 	return 0;
 }
 
-static int erofs_mkfs_feat_set_all_fragments(bool en, const char *val,
+static int erofs_mkfs_feat_set_all_fragments(struct erofs_importer_params *params,
+					     bool en, const char *val,
 					     unsigned int vallen)
 {
-	cfg.c_all_fragments = en;
-	return erofs_mkfs_feat_set_fragments(en, val, vallen);
+	params->all_fragments = en;
+	return erofs_mkfs_feat_set_fragments(params, en, val, vallen);
 }
 
-static int erofs_mkfs_feat_set_dedupe(bool en, const char *val,
+static int erofs_mkfs_feat_set_dedupe(struct erofs_importer_params *params,
+				      bool en, const char *val,
 				      unsigned int vallen)
 {
 	if (vallen)
 		return -EINVAL;
-	cfg.c_dedupe = en;
+	params->dedupe = en;
 	return 0;
 }
 
-static int erofs_mkfs_feat_set_fragdedupe(bool en, const char *val,
+static int erofs_mkfs_feat_set_fragdedupe(struct erofs_importer_params *params,
+					  bool en, const char *val,
 					  unsigned int vallen)
 {
 	if (!en) {
 		if (vallen)
 			return -EINVAL;
-		cfg.c_fragdedupe = FRAGDEDUPE_OFF;
+		params->fragdedupe = EROFS_FRAGDEDUPE_OFF;
 	} else if (vallen == sizeof("inode") - 1 &&
 		   !memcmp(val, "inode", vallen)) {
-		cfg.c_fragdedupe = FRAGDEDUPE_INODE;
+		params->fragdedupe = EROFS_FRAGDEDUPE_INODE;
 	} else {
-		cfg.c_fragdedupe = FRAGDEDUPE_FULL;
+		params->fragdedupe = EROFS_FRAGDEDUPE_FULL;
 	}
 	return 0;
 }
 
-static int erofs_mkfs_feat_set_48bit(bool en, const char *val,
+static int erofs_mkfs_feat_set_48bit(struct erofs_importer_params *params,
+				     bool en, const char *val,
 				     unsigned int vallen)
 {
 	if (vallen)
@@ -394,7 +402,8 @@ static int erofs_mkfs_feat_set_48bit(bool en, const char *val,
 static bool mkfs_dot_omitted;
 static unsigned char mkfs_blkszbits;
 
-static int erofs_mkfs_feat_set_dot_omitted(bool en, const char *val,
+static int erofs_mkfs_feat_set_dot_omitted(struct erofs_importer_params *params,
+					   bool en, const char *val,
 					   unsigned int vallen)
 {
 	if (vallen)
@@ -406,7 +415,8 @@ static int erofs_mkfs_feat_set_dot_omitted(bool en, const char *val,
 
 static struct {
 	char *feat;
-	int (*set)(bool en, const char *val, unsigned int len);
+	int (*set)(struct erofs_importer_params *params, bool en,
+		   const char *val, unsigned int len);
 } z_erofs_mkfs_features[] = {
 	{"legacy-compress", erofs_mkfs_feat_set_legacy_compress},
 	{"ztailpacking", erofs_mkfs_feat_set_ztailpacking},
@@ -509,7 +519,8 @@ static int parse_extended_opts(struct erofs_importer_params *params,
 				if (!MATCH_EXTENTED_OPT(z_erofs_mkfs_features[i].feat,
 							token, keylen))
 					continue;
-				err = z_erofs_mkfs_features[i].set(!clear, value, vallen);
+				err = z_erofs_mkfs_features[i].set(params,
+						!clear, value, vallen);
 				if (err)
 					return err;
 				break;
@@ -525,7 +536,8 @@ static int parse_extended_opts(struct erofs_importer_params *params,
 	return 0;
 }
 
-static int mkfs_apply_zfeature_bits(uintmax_t bits)
+static int mkfs_apply_zfeature_bits(struct erofs_importer_params *params,
+				    uintmax_t bits)
 {
 	int i;
 
@@ -536,7 +548,7 @@ static int mkfs_apply_zfeature_bits(uintmax_t bits)
 			erofs_err("unsupported zfeature bit %u", i);
 			return -EINVAL;
 		}
-		err = z_erofs_mkfs_features[i].set(bits & 1, NULL, 0);
+		err = z_erofs_mkfs_features[i].set(params, bits & 1, NULL, 0);
 		if (err) {
 			erofs_err("failed to apply zfeature %s",
 				  z_erofs_mkfs_features[i].feat);
@@ -1258,7 +1270,7 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 				erofs_err("invalid zfeature bits %s", optarg);
 				return -EINVAL;
 			}
-			err = mkfs_apply_zfeature_bits(i);
+			err = mkfs_apply_zfeature_bits(params, i);
 			if (err)
 				return err;
 			break;
@@ -1759,7 +1771,7 @@ int main(int argc, char **argv)
 	if (err)
 		goto exit;
 
-	if (cfg.c_dedupe) {
+	if (importer_params.dedupe) {
 		if (!cfg.c_compr_opts[0].alg) {
 			erofs_err("Compression is not enabled.  Turn on chunk-based data deduplication instead.");
 			cfg.c_chunkbits = g_sbi.blkszbits;
@@ -1797,7 +1809,8 @@ int main(int argc, char **argv)
 		}
 
 		if (cfg.c_extra_ea_name_prefixes)
-			erofs_xattr_flush_name_prefixes(&g_sbi, mkfs_plain_xattr_pfx);
+			erofs_xattr_flush_name_prefixes(&importer,
+							mkfs_plain_xattr_pfx);
 
 		root = erofs_new_inode(&g_sbi);
 		if (IS_ERR(root)) {
-- 
2.43.5


