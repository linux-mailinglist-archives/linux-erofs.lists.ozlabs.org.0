Return-Path: <linux-erofs+bounces-1077-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 373F8B948E5
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 08:29:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW96n13CCz2yqq;
	Tue, 23 Sep 2025 16:29:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758608945;
	cv=none; b=aqlQWlQICGTnbtu6pccriUDgyGeofgJb7YqWXrfNfRT0HT+Sbdrl7dKi87eqEQY+0iwEAOlywcEQDi0kfqCVrF61Zbwa+Rt8rZzpRRNcuNVJirXMKYO3P75DJOUHhouyZL/m2ZJM9uxc6dPkcAVILlwdXkEQyfy23ncpF7TSekFdDx0pyiuz/DL/FY8L3Zf0LECtJ8ELY/D3zMp32veWHtZodCwO4GYItnJe3gwEvb0igVkU98l8/IuD2cGzwkITgPgWA0X/28nEGhmLcUPE8ZClNQ5jFJ4e9VhxfkL9cxv96KNaVkh6b2VCoYgU1ufh4GHGGk3MOr7Oh79/8h4GYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758608945; c=relaxed/relaxed;
	bh=WMOgG+uxrA/Hb/n+Gku0qYjcP75Ja0Ds+9zP6jBOzag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coDj7Qb0yv362ic5RUv0CuQb9du8kQBdsknAg0VwAJhzQ8I9HR3pLy+5+R3zS8yGoBDliRRQ/SL1yQ8DID1y4pBfUuvlygNv4r2jZ+HK6w69YpZsPTzVZpoJxDyEJSALUAMpw4HVRhJ+/6A5wxH94sEGOc/cHP2Byu6XqqmXNVGyXYidnwq8tUHLLoAI7aeiRlKZEq7AJlayOzRzxXRDIDKevuMMY7lkrSJNVAkW9B2nAGn51KNjNADPVkIUvKK7QipFfezgI8I6h2K6UdfbO7HE6oq7eCWaBHhysvLPWLEVPHQXNnHlvTyT2a+hQEV40qETigORcE+SoJP8KqUxhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DLV6Scs3; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DLV6Scs3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cW96k3KRFz3cYP
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 16:29:01 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758608938; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WMOgG+uxrA/Hb/n+Gku0qYjcP75Ja0Ds+9zP6jBOzag=;
	b=DLV6Scs3MQN9ONjBaELltQf05bBdBSKcQooGQpFFYAZyE/hAW93rBXM+oDoeFlLOrl8csoAKC6CwxSupKdBYfFQVxtEn0Tn79RGYLAVgNHpLBZCl7fnMCyQRohXuAR0pAGGe5UHYZUNvsNnQzYQfl1is6fpAGs0dZR7NKYEi+YA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wodx0P-_1758608936 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 14:28:57 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/4] erofs-utils: lib: migrate pclustersize configurations
Date: Tue, 23 Sep 2025 14:28:47 +0800
Message-ID: <20250923062848.1712858-3-hsiangkao@linux.alibaba.com>
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

Also convert their units from bytes to blocks.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/compress_hints.h |   8 +-
 include/erofs/config.h         |   4 -
 include/erofs/importer.h       |   4 +
 lib/compress.c                 | 129 ++++++++++++++++-----------------
 lib/compress_hints.c           |  39 +++++-----
 lib/compressor.c               |   6 +-
 lib/compressor.h               |   6 +-
 lib/compressor_liblzma.c       |   4 +-
 lib/compressor_libzstd.c       |   4 +-
 lib/config.c                   |   1 -
 lib/importer.c                 |   4 +-
 lib/inode.c                    |  21 +++---
 lib/liberofs_compress.h        |   3 +-
 mkfs/main.c                    |  18 ++---
 14 files changed, 127 insertions(+), 124 deletions(-)

diff --git a/include/erofs/compress_hints.h b/include/erofs/compress_hints.h
index 9f0d8ae..6ccc03d 100644
--- a/include/erofs/compress_hints.h
+++ b/include/erofs/compress_hints.h
@@ -11,9 +11,9 @@ extern "C"
 {
 #endif
 
-#include "erofs/internal.h"
 #include <sys/types.h>
 #include <regex.h>
+#include "erofs/importer.h"
 
 struct erofs_compress_hints {
 	struct list_head list;
@@ -23,9 +23,11 @@ struct erofs_compress_hints {
 	unsigned char algorithmtype;
 };
 
-bool z_erofs_apply_compress_hints(struct erofs_inode *inode);
+bool z_erofs_apply_compress_hints(struct erofs_importer *im,
+				  struct erofs_inode *inode);
 void erofs_cleanup_compress_hints(void);
-int erofs_load_compress_hints(struct erofs_sb_info *sbi);
+int erofs_load_compress_hints(struct erofs_importer *im,
+			      struct erofs_sb_info *sbi);
 
 #ifdef __cplusplus
 }
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 67f5aa3..59cf4f2 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -70,10 +70,6 @@ struct erofs_configure {
 	u8 c_mkfs_metabox_algid;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
-	u32 c_mkfs_pclustersize_max;
-	u32 c_mkfs_pclustersize_def;
-	u32 c_mkfs_pclustersize_packed;
-	s32 c_mkfs_pclustersize_metabox;
 	u32 c_max_decompressed_extent_bytes;
 	u64 c_unix_timestamp;
 	const char *mount_point;
diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index a5a4c8c..6033e68 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -25,6 +25,10 @@ struct erofs_importer_params {
 	u32 uid_offset;
 	u32 gid_offset;
 	u32 fsalignblks;
+	u32 pclusterblks_max;
+	u32 pclusterblks_def;
+	u32 pclusterblks_packed;
+	s32 pclusterblks_metabox;
 	char force_inodeversion;
 	bool ignore_mtime;
 	bool no_datainline;
diff --git a/lib/compress.c b/lib/compress.c
index 6820042..988c444 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -35,6 +35,7 @@ struct z_erofs_extent_item {
 };
 
 struct z_erofs_compress_ictx {		/* inode context */
+	struct erofs_importer *im;
 	struct erofs_inode *inode;
 	struct erofs_compress_cfg *ccfg;
 	int fd;
@@ -455,25 +456,26 @@ static int write_uncompressed_extents(struct z_erofs_compress_sctx *ctx,
 	return count;
 }
 
-static unsigned int z_erofs_get_max_pclustersize(struct erofs_inode *inode)
+static unsigned int z_erofs_get_pclustersize(struct z_erofs_compress_ictx *ictx)
 {
-	if (erofs_is_packed_inode(inode)) {
-		return cfg.c_mkfs_pclustersize_packed;
-	} else if (erofs_is_metabox_inode(inode)) {
-		return cfg.c_mkfs_pclustersize_metabox;
-#ifndef NDEBUG
-	} else if (cfg.c_random_pclusterblks) {
-		unsigned int pclusterblks =
-			cfg.c_mkfs_pclustersize_max >> inode->sbi->blkszbits;
+	struct erofs_importer_params *params = ictx->im->params;
+	struct erofs_inode *inode = ictx->inode;
+	unsigned int blkszbits = inode->sbi->blkszbits;
 
-		return (1 + rand() % pclusterblks) << inode->sbi->blkszbits;
+	if (erofs_is_packed_inode(inode))
+		return params->pclusterblks_packed << blkszbits;
+	if (erofs_is_metabox_inode(inode))
+		return params->pclusterblks_metabox << blkszbits;
+#ifndef NDEBUG
+	if (cfg.c_random_pclusterblks)
+		return (1 + rand() % params->pclusterblks_max) << blkszbits;
 #endif
-	} else if (cfg.c_compress_hints_file) {
-		z_erofs_apply_compress_hints(inode);
+	if (cfg.c_compress_hints_file) {
+		z_erofs_apply_compress_hints(ictx->im, inode);
 		DBG_BUGON(!inode->z_physical_clusterblks);
-		return inode->z_physical_clusterblks << inode->sbi->blkszbits;
+		return inode->z_physical_clusterblks << blkszbits;
 	}
-	return cfg.c_mkfs_pclustersize_def;
+	return params->pclusterblks_def << blkszbits;
 }
 
 static int z_erofs_fill_inline_data(struct erofs_inode *inode, void *data,
@@ -539,7 +541,7 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_compress_sctx *ctx)
 	/* try to fix again if it gets larger (should be rare) */
 	if (inode->fragment_size < newsize) {
 		ctx->pclustersize = min_t(erofs_off_t,
-				z_erofs_get_max_pclustersize(inode),
+				z_erofs_get_pclustersize(ictx),
 				roundup(newsize - inode->fragment_size,
 					erofs_blksiz(sbi)));
 		return false;
@@ -1443,27 +1445,6 @@ err_free_priv:
 	return NULL;
 }
 
-int z_erofs_mt_wq_tls_init_compr(struct erofs_sb_info *sbi,
-				 struct erofs_compress_wq_tls *tls,
-				 unsigned int alg_id, char *alg_name,
-				 unsigned int comp_level,
-				 unsigned int dict_size)
-{
-	struct erofs_compress_cfg *lc = &tls->ccfg[alg_id];
-	int ret;
-
-	if (__erofs_likely(lc->enable))
-		return 0;
-
-	ret = erofs_compressor_init(sbi, &lc->handle, alg_name,
-				    comp_level, dict_size);
-	if (ret)
-		return ret;
-	lc->algorithmtype = alg_id;
-	lc->enable = true;
-	return 0;
-}
-
 void *z_erofs_mt_wq_tls_free(struct erofs_workqueue *wq, void *priv)
 {
 	struct erofs_compress_wq_tls *tls = priv;
@@ -1488,15 +1469,23 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 	struct z_erofs_compress_ictx *ictx = sctx->ictx;
 	struct erofs_inode *inode = ictx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
-	int ret = 0;
+	struct erofs_compress_cfg *lc = &tls->ccfg[cwork->alg_id];
+	int ret;
 
-	ret = z_erofs_mt_wq_tls_init_compr(sbi, tls, cwork->alg_id,
-					   cwork->alg_name, cwork->comp_level,
-					   cwork->dict_size);
-	if (ret)
-		goto out;
+	if (__erofs_unlikely(!lc->enable)) {
+		unsigned int pclustersize_max =
+			ictx->im->params->pclusterblks_max << sbi->blkszbits;
 
-	sctx->pclustersize = z_erofs_get_max_pclustersize(inode);
+		ret = erofs_compressor_init(sbi, &lc->handle,
+					    cwork->alg_name, cwork->comp_level,
+					    cwork->dict_size, pclustersize_max);
+		if (ret)
+			goto out;
+		lc->algorithmtype = cwork->alg_id;
+		lc->enable = true;
+	}
+
+	sctx->pclustersize = z_erofs_get_pclustersize(ictx);
 	DBG_BUGON(sctx->pclustersize > Z_EROFS_PCLUSTER_MAX_SIZE);
 	sctx->queue = tls->queue;
 	sctx->destbuf = tls->destbuf;
@@ -1794,7 +1783,8 @@ int z_erofs_mt_global_exit(void)
 }
 #endif
 
-void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
+void *erofs_begin_compressed_file(struct erofs_importer *im,
+				  struct erofs_inode *inode, int fd, u64 fpos)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct z_erofs_compress_ictx *ictx;
@@ -1833,6 +1823,8 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 		if (!ictx)
 			return ERR_PTR(-ENOMEM);
 	}
+	ictx->im = im;
+	ictx->inode = inode;
 	ictx->fd = fd;
 	if (erofs_is_metabox_inode(inode))
 		ictx->ccfg = &sbi->zmgr->ccfg[cfg.c_mkfs_metabox_algid];
@@ -1842,7 +1834,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	inode->z_algorithmtype[1] = 0;
 	ictx->data_unaligned = erofs_sb_has_48bit(sbi) &&
 		cfg.c_max_decompressed_extent_bytes <=
-			z_erofs_get_max_pclustersize(inode);
+			z_erofs_get_pclustersize(ictx);
 	if (cfg.c_fragments && !cfg.c_dedupe && !ictx->data_unaligned)
 		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 
@@ -1865,7 +1857,6 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 			}
 		}
 	}
-	ictx->inode = inode;
 	ictx->fpos = fpos;
 	init_list_head(&ictx->extents);
 	ictx->fix_dedupedfrag = false;
@@ -1929,7 +1920,7 @@ int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 		.remaining = inode->i_size - inode->fragment_size,
 		.seg_idx = 0,
 		.pivot = &dummy_pivot,
-		.pclustersize = z_erofs_get_max_pclustersize(inode),
+		.pclustersize = z_erofs_get_pclustersize(ictx),
 	};
 	init_list_head(&sctx.extents);
 
@@ -1958,11 +1949,11 @@ out:
 	return ret;
 }
 
-static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
-				    struct erofs_buffer_head *sb_bh,
+static int z_erofs_build_compr_cfgs(struct erofs_importer *im,
 				    u32 *max_dict_size)
 {
-	struct erofs_buffer_head *bh = sb_bh;
+	struct erofs_sb_info *sbi = im->sbi;
+	struct erofs_buffer_head *bh = sbi->bh_sb;
 	int ret = 0;
 
 	if (sbi->available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZ4)) {
@@ -1974,8 +1965,7 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 			.lz4 = {
 				.max_distance =
 					cpu_to_le16(sbi->lz4.max_distance),
-				.max_pclusterblks =
-					cfg.c_mkfs_pclustersize_max >> sbi->blkszbits,
+				.max_pclusterblks = im->params->pclusterblks_max,
 			}
 		};
 
@@ -2066,7 +2056,9 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 
 int z_erofs_compress_init(struct erofs_importer *im)
 {
+	const struct erofs_importer_params *params = im->params;
 	struct erofs_sb_info *sbi = im->sbi;
+	unsigned int pclustersize_max = params->pclusterblks_max << sbi->blkszbits;
 	u32 max_dict_size[Z_EROFS_COMPRESSION_MAX] = {};
 	u32 available_compr_algs = 0;
 	bool newzmgr = false;
@@ -2085,7 +2077,8 @@ int z_erofs_compress_init(struct erofs_importer *im)
 
 		ret = erofs_compressor_init(sbi, c, cfg.c_compr_opts[i].alg,
 					    cfg.c_compr_opts[i].level,
-					    cfg.c_compr_opts[i].dict_size);
+					    cfg.c_compr_opts[i].dict_size,
+					    pclustersize_max);
 		if (ret)
 			return ret;
 
@@ -2110,10 +2103,9 @@ int z_erofs_compress_init(struct erofs_importer *im)
 			return -EOPNOTSUPP;
 		}
 		if ((available_compr_algs & BIT(Z_EROFS_COMPRESSION_LZ4)) &&
-		    (sbi->lz4.max_pclusterblks << sbi->blkszbits) <
-			cfg.c_mkfs_pclustersize_max) {
-			erofs_err("pclustersize %u is too large on incremental builds",
-				  cfg.c_mkfs_pclustersize_max);
+		    sbi->lz4.max_pclusterblks < params->pclusterblks_max) {
+			erofs_err("pcluster size (%u blocks) cannot increase on incremental builds",
+				  params->pclusterblks_max);
 			return -EOPNOTSUPP;
 		}
 	} else {
@@ -2129,28 +2121,29 @@ int z_erofs_compress_init(struct erofs_importer *im)
 	 * if big pcluster is enabled, an extra CBLKCNT lcluster index needs
 	 * to be loaded in order to get those compressed block counts.
 	 */
-	if (cfg.c_mkfs_pclustersize_max > erofs_blksiz(sbi)) {
-		if (cfg.c_mkfs_pclustersize_max > Z_EROFS_PCLUSTER_MAX_SIZE) {
-			erofs_err("unsupported pclustersize %u (too large)",
-				  cfg.c_mkfs_pclustersize_max);
+	if (params->pclusterblks_max) {
+		if (pclustersize_max > Z_EROFS_PCLUSTER_MAX_SIZE) {
+			erofs_err("pcluster size (%u blocks) is too large",
+				  params->pclusterblks_max);
 			return -EINVAL;
 		}
 		erofs_sb_set_big_pcluster(sbi);
 	}
-	if (cfg.c_mkfs_pclustersize_packed > cfg.c_mkfs_pclustersize_max) {
-		erofs_err("invalid pclustersize for the packed file %u",
-			  cfg.c_mkfs_pclustersize_packed);
+
+	if (params->pclusterblks_packed > params->pclusterblks_max) {
+		erofs_err("pcluster size (%u blocks) for packed inode exceeds maximum",
+			  params->pclusterblks_packed);
 		return -EINVAL;
 	}
 
-	if (cfg.c_mkfs_pclustersize_metabox > (s32)cfg.c_mkfs_pclustersize_max) {
-		erofs_err("invalid pclustersize for the metabox file %u",
-			  cfg.c_mkfs_pclustersize_metabox);
+	if (params->pclusterblks_metabox > (s32)params->pclusterblks_max) {
+		erofs_err("pcluster size (%u blocks) for metabox inode exceeds maximum",
+			  params->pclusterblks_metabox, params->pclusterblks_max);
 		return -EINVAL;
 	}
 
 	if (sbi->bh_sb && erofs_sb_has_compr_cfgs(sbi)) {
-		ret = z_erofs_build_compr_cfgs(sbi, sbi->bh_sb, max_dict_size);
+		ret = z_erofs_build_compr_cfgs(im, max_dict_size);
 		if (ret)
 			return ret;
 	}
diff --git a/lib/compress_hints.c b/lib/compress_hints.c
index e79bd48..15f3e54 100644
--- a/lib/compress_hints.c
+++ b/lib/compress_hints.c
@@ -45,17 +45,19 @@ static int erofs_insert_compress_hints(const char *s, unsigned int blks,
 	return ret;
 }
 
-bool z_erofs_apply_compress_hints(struct erofs_inode *inode)
+bool z_erofs_apply_compress_hints(struct erofs_importer *im,
+				  struct erofs_inode *inode)
 {
-	const char *s;
+	const struct erofs_importer_params *params = im->params;
+	unsigned int pclusterblks = params->pclusterblks_def;
+	unsigned int algorithmtype;
 	struct erofs_compress_hints *r;
-	unsigned int pclusterblks, algorithmtype;
+	const char *s;
 
 	if (inode->z_physical_clusterblks)
 		return true;
 
 	s = erofs_fspath(inode->i_srcpath);
-	pclusterblks = cfg.c_mkfs_pclustersize_def >> inode->sbi->blkszbits;
 	algorithmtype = 0;
 
 	list_for_each_entry(r, &compress_hints_head, list) {
@@ -86,11 +88,13 @@ void erofs_cleanup_compress_hints(void)
 	}
 }
 
-int erofs_load_compress_hints(struct erofs_sb_info *sbi)
+int erofs_load_compress_hints(struct erofs_importer *im,
+			      struct erofs_sb_info *sbi)
 {
+	struct erofs_importer_params *params = im->params;
 	char buf[PATH_MAX + 100];
 	FILE *f;
-	unsigned int line, max_pclustersize = 0;
+	unsigned int line, max_pclusterblks = 0;
 	int ret = 0;
 
 	if (!cfg.c_compress_hints_file)
@@ -101,7 +105,7 @@ int erofs_load_compress_hints(struct erofs_sb_info *sbi)
 		return -errno;
 
 	for (line = 1; fgets(buf, sizeof(buf), f); ++line) {
-		unsigned int pclustersize, ccfg;
+		unsigned int pclustersize, pclusterblks, ccfg;
 		char *alg, *pattern;
 
 		if (*buf == '#' || *buf == '\n')
@@ -134,22 +138,21 @@ int erofs_load_compress_hints(struct erofs_sb_info *sbi)
 		}
 
 		if (pclustersize % erofs_blksiz(sbi)) {
-			erofs_warn("invalid physical clustersize %u, "
-				   "use default pclusterblks %u",
-				   pclustersize, cfg.c_mkfs_pclustersize_def);
+			erofs_warn("invalid physical clustersize %u, use default pclustersize (%u blocks)",
+				   pclustersize, params->pclusterblks_max);
 			continue;
 		}
-		erofs_insert_compress_hints(pattern,
-				pclustersize / erofs_blksiz(sbi), ccfg);
+		pclusterblks = pclustersize >> sbi->blkszbits;
+		erofs_insert_compress_hints(pattern, pclusterblks, ccfg);
 
-		if (pclustersize > max_pclustersize)
-			max_pclustersize = pclustersize;
+		if (pclusterblks > max_pclusterblks)
+			max_pclusterblks = pclusterblks;
 	}
 
-	if (cfg.c_mkfs_pclustersize_max < max_pclustersize) {
-		cfg.c_mkfs_pclustersize_max = max_pclustersize;
-		erofs_warn("update max pclustersize to %u",
-			   cfg.c_mkfs_pclustersize_max);
+	if (params->pclusterblks_max < max_pclusterblks) {
+		erofs_warn("update max pclustersize to %u blocks",
+			   max_pclusterblks);
+		params->pclusterblks_max = max_pclusterblks;
 	}
 out:
 	fclose(f);
diff --git a/lib/compressor.c b/lib/compressor.c
index 6d8c1c2..efcead1 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -97,7 +97,8 @@ int erofs_compress(const struct erofs_compress *c,
 }
 
 int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
-			  char *alg_name, int compression_level, u32 dict_size)
+			  char *alg_name, int compression_level,
+			  u32 dict_size, u32 pclustersize_max)
 {
 	int ret, i;
 
@@ -135,7 +136,8 @@ int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
 		}
 
 		if (erofs_algs[i].c->setdictsize) {
-			ret = erofs_algs[i].c->setdictsize(c, dict_size);
+			ret = erofs_algs[i].c->setdictsize(c, dict_size,
+							   pclustersize_max);
 			if (ret) {
 				erofs_err("failed to set dict size %u for %s",
 					  dict_size, alg_name);
diff --git a/lib/compressor.h b/lib/compressor.h
index 5f86f15..c008206 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -21,7 +21,8 @@ struct erofs_compressor {
 	int (*exit)(struct erofs_compress *c);
 	void (*reset)(struct erofs_compress *c);
 	int (*setlevel)(struct erofs_compress *c, int compression_level);
-	int (*setdictsize)(struct erofs_compress *c, u32 dict_size);
+	int (*setdictsize)(struct erofs_compress *c, u32 dict_size,
+			   u32 pclustersize_max);
 
 	int (*compress_destsize)(const struct erofs_compress *c,
 				 const void *src, unsigned int *srcsize,
@@ -68,7 +69,8 @@ int erofs_compress(const struct erofs_compress *c,
 		   void *dst, unsigned int dstcapacity);
 
 int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
-			  char *alg_name, int compression_level, u32 dict_size);
+			  char *alg_name, int compression_level, u32 dict_size,
+			  u32 pclustersize_max);
 int erofs_compressor_exit(struct erofs_compress *c);
 void erofs_compressor_reset(struct erofs_compress *c);
 
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index c4ba585..e6026b2 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -68,14 +68,14 @@ static int erofs_compressor_liblzma_setlevel(struct erofs_compress *c,
 }
 
 static int erofs_compressor_liblzma_setdictsize(struct erofs_compress *c,
-						u32 dict_size)
+						u32 dict_size, u32 pclustersize_max)
 {
 	if (!dict_size) {
 		if (erofs_compressor_lzma.default_dictsize) {
 			dict_size = erofs_compressor_lzma.default_dictsize;
 		} else {
 			dict_size = min_t(u32, Z_EROFS_LZMA_MAX_DICT_SIZE,
-					  cfg.c_mkfs_pclustersize_max << 2);
+					  pclustersize_max << 2);
 			if (dict_size < 32768)
 				dict_size = 32768;
 		}
diff --git a/lib/compressor_libzstd.c b/lib/compressor_libzstd.c
index 3233d72..feef409 100644
--- a/lib/compressor_libzstd.c
+++ b/lib/compressor_libzstd.c
@@ -115,14 +115,14 @@ static int erofs_compressor_libzstd_setlevel(struct erofs_compress *c,
 }
 
 static int erofs_compressor_libzstd_setdictsize(struct erofs_compress *c,
-						u32 dict_size)
+						u32 dict_size, u32 pclustersize_max)
 {
 	if (!dict_size) {
 		if (erofs_compressor_libzstd.default_dictsize) {
 			dict_size = erofs_compressor_libzstd.default_dictsize;
 		} else {
 			dict_size = min_t(u32, Z_EROFS_ZSTD_MAX_DICT_SIZE,
-					  cfg.c_mkfs_pclustersize_max << 3);
+					  pclustersize_max << 3);
 			dict_size = 1 << ilog2(dict_size);
 		}
 	}
diff --git a/lib/config.c b/lib/config.c
index b1d076d..1da5354 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -32,7 +32,6 @@ void erofs_init_configure(void)
 	cfg.c_inline_xattr_tolerance = 2;
 	cfg.c_unix_timestamp = -1;
 	cfg.c_max_decompressed_extent_bytes = -1;
-	cfg.c_mkfs_pclustersize_metabox = -1;
 	erofs_stdout_tty = isatty(STDOUT_FILENO);
 }
 
diff --git a/lib/importer.c b/lib/importer.c
index 7c3d147..e0ab505 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -53,8 +53,8 @@ int erofs_importer_init(struct erofs_importer *im)
 
 	if (cfg.c_fragments || cfg.c_extra_ea_name_prefixes) {
 		subsys = "packedfile";
-		if (!cfg.c_mkfs_pclustersize_packed)
-			cfg.c_mkfs_pclustersize_packed = cfg.c_mkfs_pclustersize_def;
+		if (!params->pclusterblks_packed)
+			params->pclusterblks_packed = params->pclusterblks_def;
 
 		err = erofs_packedfile_init(sbi, cfg.c_fragments);
 		if (err)
diff --git a/lib/inode.c b/lib/inode.c
index fef7128..102cc64 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -600,13 +600,14 @@ int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 }
 
 /* rules to decide whether a file could be compressed or not */
-static bool erofs_file_is_compressible(struct erofs_inode *inode)
+static bool erofs_file_is_compressible(struct erofs_importer *im,
+				       struct erofs_inode *inode)
 {
 	if (erofs_is_metabox_inode(inode) &&
-	    cfg.c_mkfs_pclustersize_metabox < 0)
+	    !im->params->pclusterblks_metabox)
 		return false;
 	if (cfg.c_compress_hints_file)
-		return z_erofs_apply_compress_hints(inode);
+		return z_erofs_apply_compress_hints(im, inode);
 	return true;
 }
 
@@ -1804,9 +1805,9 @@ static int erofs_mkfs_handle_inode(struct erofs_importer *im,
 				return -errno;
 
 			if (cfg.c_compr_opts[0].alg &&
-			    erofs_file_is_compressible(inode)) {
-				ctx.ictx = erofs_begin_compressed_file(inode,
-								ctx.fd, 0);
+			    erofs_file_is_compressible(im, inode)) {
+				ctx.ictx = erofs_begin_compressed_file(im,
+							inode, ctx.fd, 0);
 				if (IS_ERR(ctx.ictx))
 					return PTR_ERR(ctx.ictx);
 			}
@@ -1870,8 +1871,8 @@ static int erofs_rebuild_handle_inode(struct erofs_importer *im,
 				return ret;
 
 			if (cfg.c_compr_opts[0].alg &&
-			    erofs_file_is_compressible(inode)) {
-				ctx.ictx = erofs_begin_compressed_file(inode,
+			    erofs_file_is_compressible(im, inode)) {
+				ctx.ictx = erofs_begin_compressed_file(im, inode,
 							ctx.fd, ctx.fpos);
 				if (IS_ERR(ctx.ictx))
 					return PTR_ERR(ctx.ictx);
@@ -2137,8 +2138,8 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_importer *im,
 	}
 
 	if (cfg.c_compr_opts[0].alg &&
-	    erofs_file_is_compressible(inode)) {
-		ictx = erofs_begin_compressed_file(inode, fd, 0);
+	    erofs_file_is_compressible(im, inode)) {
+		ictx = erofs_begin_compressed_file(im, inode, fd, 0);
 		if (IS_ERR(ictx))
 			return ERR_CAST(ictx);
 
diff --git a/lib/liberofs_compress.h b/lib/liberofs_compress.h
index 7f49e5d..e0f4d24 100644
--- a/lib/liberofs_compress.h
+++ b/lib/liberofs_compress.h
@@ -15,7 +15,8 @@
 struct z_erofs_compress_ictx;
 
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
-void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos);
+void *erofs_begin_compressed_file(struct erofs_importer *im,
+				  struct erofs_inode *inode, int fd, u64 fpos);
 int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx);
 
 int z_erofs_compress_init(struct erofs_importer *im);
diff --git a/mkfs/main.c b/mkfs/main.c
index 13c4761..a738907 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1416,8 +1416,8 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 				  pclustersize_max);
 			return -EINVAL;
 		}
-		cfg.c_mkfs_pclustersize_max = pclustersize_max;
-		cfg.c_mkfs_pclustersize_def = cfg.c_mkfs_pclustersize_max;
+		params->pclusterblks_max = pclustersize_max >> mkfs_blkszbits;
+		params->pclusterblks_def = params->pclusterblks_max;
 	}
 	if (cfg.c_chunkbits && cfg.c_chunkbits < mkfs_blkszbits) {
 		erofs_err("chunksize %u must be larger than block size",
@@ -1447,7 +1447,7 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 				  pclustersize_packed);
 			return -EINVAL;
 		}
-		cfg.c_mkfs_pclustersize_packed = pclustersize_packed;
+		params->pclusterblks_packed = pclustersize_packed >> mkfs_blkszbits;
 	}
 
 	if (pclustersize_metabox >= 0) {
@@ -1458,7 +1458,7 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 				  pclustersize_metabox);
 			return -EINVAL;
 		}
-		cfg.c_mkfs_pclustersize_metabox = pclustersize_metabox;
+		params->pclusterblks_metabox = pclustersize_metabox >> mkfs_blkszbits;
 		cfg.c_mkfs_metabox_algid = metabox_algorithmid;
 		erofs_sb_set_metabox(&g_sbi);
 	}
@@ -1468,7 +1468,7 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 	return 0;
 }
 
-static void erofs_mkfs_default_options(void)
+static void erofs_mkfs_default_options(struct erofs_importer_params *params)
 {
 	cfg.c_showprogress = true;
 	cfg.c_legacy_compress = false;
@@ -1478,8 +1478,8 @@ static void erofs_mkfs_default_options(void)
 	cfg.c_mkfs_segment_size = 16ULL * 1024 * 1024;
 #endif
 	mkfs_blkszbits = ilog2(min_t(u32, getpagesize(), EROFS_MAX_BLOCK_SIZE));
-	cfg.c_mkfs_pclustersize_max = 1U << mkfs_blkszbits;
-	cfg.c_mkfs_pclustersize_def = cfg.c_mkfs_pclustersize_max;
+	params->pclusterblks_max = 1U;
+	params->pclusterblks_def = 1U;
 	g_sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_ZERO_PADDING;
 	g_sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
 			     EROFS_FEATURE_COMPAT_MTIME;
@@ -1635,8 +1635,8 @@ int main(int argc, char **argv)
 	err = liberofs_global_init();
 	if (err)
 		return 1;
-	erofs_mkfs_default_options();
 	erofs_importer_preset(&importer_params);
+	erofs_mkfs_default_options(&importer_params);
 
 	err = mkfs_parse_options_cfg(&importer_params, argc, argv);
 	erofs_show_progs(argc, argv);
@@ -1745,7 +1745,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	err = erofs_load_compress_hints(&g_sbi);
+	err = erofs_load_compress_hints(&importer, &g_sbi);
 	if (err) {
 		erofs_err("failed to load compress hints %s",
 			  cfg.c_compress_hints_file);
-- 
2.43.5


