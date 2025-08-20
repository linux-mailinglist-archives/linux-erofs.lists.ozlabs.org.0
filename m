Return-Path: <linux-erofs+bounces-843-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A3BB2D3A4
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Aug 2025 07:38:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6Fc86HhTz30Qb;
	Wed, 20 Aug 2025 15:38:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755668312;
	cv=none; b=Pe7hwZkQavj+Qbi9SeuvvwyaSrfURko4m5B0shzkxFcfx0sdTi0QWerRcLx4DkgZoqvxVrgSbQKljX/XrO+SfbW5UZfNb4drrx4wdNkmPe7aj/OYo034i/mC6d2E6oTfo/2rSiGgoYUNkscISu3D3SRvFStNpiec/Wl3PvU7bG4veV5FShgPqWGmKlZ6flujHyQcMlOTCcG1/Lq4l1noWKCaGlo1X1Ev06HK9RwGnBgeJAiFKu4h1lsQ/eauyi6WV56Kri2wNaMevjdcDgao7QqQOeSSFxIGioB8DSb1gikmH3uwTOvmrSQDu236nwon/qXtWNTadiH1eoVuEG3dQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755668312; c=relaxed/relaxed;
	bh=9jV+FHZPEg/97Oo+F7Qs9+IC55YwTcU7JjPH+VU/tkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtYWURhCl4EFMGB/WQYXXW0TQ2NlDiNtEUpnYc1tSfrExyO8ZrI4dKmvM2Q1zuwNKBuDxBlHkKKADEznTEVbwODefRk533UV79c9WULSblf+rs9gh/kYufStyMRrYWltqaxN4kIT/DBAM+IEWna6WFE9oOGNh9thz6KiUqBVOl6mVdE0FIcsKuQEhSzQ7hCC5KS2ZFnMNbTuh0bhD2d6sZL8jiorDCBPLoYv1uLdggoQv55AdRNpumGp/deRodgw3ut3WiR9WNSzQNcvR8d6x4qWDj6WSPgPF8FObezIbvYR8WICI4KbRcLF7x1iZDF+ePmBW1q40lxQlTtyRC3GwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HqztWN8G; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HqztWN8G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6Fc56mNrz3069
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Aug 2025 15:38:28 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755668302; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9jV+FHZPEg/97Oo+F7Qs9+IC55YwTcU7JjPH+VU/tkw=;
	b=HqztWN8Ga4HJMa69dVSPggT1gCd3E/zOj4BFIzFJoGz2ib8tuG6XmXfU/TiMkg9uYcQvFWNo5wBSg7rWXnubT/JdjbVw3PamJ5fxbV2RPEHPSx3k7tSyK6jTXW/DmglfS1XJihs6ApB0IQadPoY7Uipk1aU4N6P6mbD4xNjtzbg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmAOfRz_1755668297 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 13:38:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/3] erofs-utils: lib: introduce API helpers to prepare mkfs context
Date: Wed, 20 Aug 2025 13:38:05 +0800
Message-ID: <20250820053806.1441397-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250820053806.1441397-1-hsiangkao@linux.alibaba.com>
References: <20250820053806.1441397-1-hsiangkao@linux.alibaba.com>
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
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

 - erofs_mkfs_format_fs  Create a new filesystem

 - erofs_mkfs_load_fs    Load an existing filesystem, especially for
                         incremental builds;

Unlike importer APIs (designed for multiple data sources), this can
only be executed once.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/compress.h |  3 +-
 include/erofs/internal.h |  6 ++-
 lib/cache.c              |  1 +
 lib/compress.c           |  5 +-
 lib/importer.c           |  4 ++
 lib/super.c              | 55 +++++++++++++++++++++-
 mkfs/main.c              | 99 ++++++++++++----------------------------
 7 files changed, 98 insertions(+), 75 deletions(-)

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index d5b2519..00e7715 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -23,8 +23,7 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
 void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos);
 int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx);
 
-int z_erofs_compress_init(struct erofs_sb_info *sbi,
-			  struct erofs_buffer_head *bh);
+int z_erofs_compress_init(struct erofs_sb_info *sbi);
 int z_erofs_compress_exit(struct erofs_sb_info *sbi);
 
 const char *z_erofs_list_supported_algorithms(int i, unsigned int *mask);
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 92e83fd..a609fbd 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -150,6 +150,7 @@ struct erofs_sb_info {
 	struct z_erofs_mgr *zmgr;
 	struct erofs_metaboxmgr *m2gr;
 	struct erofs_packed_inode *packedinode;
+	struct erofs_buffer_head *bh_sb;
 	struct erofs_buffer_head *bh_devt;
 	bool useqpl;
 };
@@ -432,12 +433,15 @@ void liberofs_global_exit(void);
 /* super.c */
 int erofs_read_superblock(struct erofs_sb_info *sbi);
 void erofs_put_super(struct erofs_sb_info *sbi);
-int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh);
+int erofs_writesb(struct erofs_sb_info *sbi);
 struct erofs_buffer_head *erofs_reserve_sb(struct erofs_bufmgr *bmgr);
 int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int devices);
 int erofs_write_device_table(struct erofs_sb_info *sbi);
 int erofs_enable_sb_chksum(struct erofs_sb_info *sbi, u32 *crc);
 int erofs_superblock_csum_verify(struct erofs_sb_info *sbi);
+int erofs_mkfs_format_fs(struct erofs_sb_info *sbi,
+			 unsigned int blkszbits, unsigned int dsunit);
+int erofs_mkfs_load_fs(struct erofs_sb_info *sbi, unsigned int dsunit);
 
 /* namei.c */
 int erofs_read_inode_from_disk(struct erofs_inode *vi);
diff --git a/lib/cache.c b/lib/cache.c
index 079465e..cd11737 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -533,5 +533,6 @@ erofs_blk_t erofs_total_metablocks(struct erofs_bufmgr *bmgr)
 
 void erofs_buffer_exit(struct erofs_bufmgr *bmgr)
 {
+	DBG_BUGON(!list_empty(&bmgr->blkh.list));
 	free(bmgr);
 }
diff --git a/lib/compress.c b/lib/compress.c
index 0bfad3f..0049199 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -2035,11 +2035,12 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 	return ret;
 }
 
-int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh)
+int z_erofs_compress_init(struct erofs_sb_info *sbi)
 {
-	int i, ret, id;
+	struct erofs_buffer_head *sb_bh = sbi->bh_sb;
 	u32 max_dict_size[Z_EROFS_COMPRESSION_MAX] = {};
 	u32 available_compr_algs = 0;
+	int i, ret, id;
 
 	if (!sbi->zmgr) {
 		sbi->zmgr = calloc(1, sizeof(*sbi->zmgr));
diff --git a/lib/importer.c b/lib/importer.c
index a65fa39..95f006d 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -39,6 +39,7 @@ void erofs_importer_global_init(void)
 int erofs_importer_init(struct erofs_importer *im)
 {
 	struct erofs_sb_info *sbi = im->sbi;
+	struct erofs_importer_params *params = im->params;
 	const char *subsys = NULL;
 	int err;
 
@@ -67,6 +68,9 @@ int erofs_importer_init(struct erofs_importer *im)
 		if (err)
 			goto out_err;
 	}
+
+	if (params->dot_omitted)
+		erofs_sb_set_48bit(sbi);
 	return 0;
 
 out_err:
diff --git a/lib/super.c b/lib/super.c
index 57849fb..97d955f 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -172,8 +172,9 @@ void erofs_put_super(struct erofs_sb_info *sbi)
 	}
 }
 
-int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh)
+int erofs_writesb(struct erofs_sb_info *sbi)
 {
+	struct erofs_buffer_head *sb_bh = sbi->bh_sb;
 	struct erofs_super_block sb = {
 		.magic     = cpu_to_le32(EROFS_SUPER_MAGIC_V1),
 		.blkszbits = sbi->blkszbits,
@@ -408,3 +409,55 @@ out:
 	sbi->total_blocks = nblocks;
 	return 0;
 }
+
+int erofs_mkfs_format_fs(struct erofs_sb_info *sbi,
+			 unsigned int blkszbits, unsigned int dsunit)
+{
+	struct erofs_buffer_head *bh;
+	struct erofs_bufmgr *bmgr;
+
+	sbi->blkszbits = blkszbits;
+	bmgr = erofs_buffer_init(sbi, 0, NULL);
+	if (!bmgr)
+		return -ENOMEM;
+	sbi->bmgr = bmgr;
+	bmgr->dsunit = dsunit;
+
+	bh = erofs_reserve_sb(bmgr);
+	if (IS_ERR(bh))
+		return PTR_ERR(bh);
+	sbi->bh_sb = bh;
+	return 0;
+}
+
+int erofs_mkfs_load_fs(struct erofs_sb_info *sbi, unsigned int dsunit)
+{
+	union {
+		struct stat st;
+		erofs_blk_t startblk;
+	} u;
+	struct erofs_bufmgr *bmgr;
+	int err;
+
+	sbi->bh_sb = NULL;
+	erofs_warn("EXPERIMENTAL incremental build in use. Use at your own risk!");
+	err = erofs_read_superblock(sbi);
+	if (err) {
+		erofs_err("failed to read superblock of %s: %s", sbi->devname,
+			  erofs_strerror(err));
+		return err;
+	}
+
+	err = erofs_io_fstat(&sbi->bdev, &u.st);
+	if (!err && S_ISREG(u.st.st_mode))
+		u.startblk = DIV_ROUND_UP(u.st.st_size, erofs_blksiz(sbi));
+	else
+		u.startblk = sbi->primarydevice_blocks;
+
+	bmgr = erofs_buffer_init(sbi, u.startblk, NULL);
+	if (!bmgr)
+		return -ENOMEM;
+	sbi->bmgr = bmgr;
+	bmgr->dsunit = dsunit;
+	return 0;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index 0a8f477..d2950b7 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -372,6 +372,7 @@ static int erofs_mkfs_feat_set_48bit(bool en, const char *val,
 }
 
 static bool mkfs_dot_omitted;
+static unsigned char mkfs_blkszbits;
 
 static int erofs_mkfs_feat_set_dot_omitted(bool en, const char *val,
 					   unsigned int vallen)
@@ -884,7 +885,7 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 				erofs_err("invalid block size %s", optarg);
 				return -EINVAL;
 			}
-			g_sbi.blkszbits = ilog2(i);
+			mkfs_blkszbits = ilog2(i);
 			break;
 
 		case 'd':
@@ -1234,7 +1235,7 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 		}
 	}
 
-	if (cfg.c_blobdev_path && cfg.c_chunkbits < g_sbi.blkszbits) {
+	if (cfg.c_blobdev_path && cfg.c_chunkbits < mkfs_blkszbits) {
 		erofs_err("--blobdev must be used together with --chunksize");
 		return -EINVAL;
 	}
@@ -1283,8 +1284,8 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 	}
 
 	if (pclustersize_max) {
-		if (pclustersize_max < erofs_blksiz(&g_sbi) ||
-		    pclustersize_max % erofs_blksiz(&g_sbi)) {
+		if (pclustersize_max < (1U << mkfs_blkszbits) ||
+		    pclustersize_max % (1U << mkfs_blkszbits)) {
 			erofs_err("invalid physical clustersize %u",
 				  pclustersize_max);
 			return -EINVAL;
@@ -1292,15 +1293,15 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 		cfg.c_mkfs_pclustersize_max = pclustersize_max;
 		cfg.c_mkfs_pclustersize_def = cfg.c_mkfs_pclustersize_max;
 	}
-	if (cfg.c_chunkbits && cfg.c_chunkbits < g_sbi.blkszbits) {
+	if (cfg.c_chunkbits && cfg.c_chunkbits < mkfs_blkszbits) {
 		erofs_err("chunksize %u must be larger than block size",
 			  1u << cfg.c_chunkbits);
 		return -EINVAL;
 	}
 
 	if (pclustersize_packed) {
-		if (pclustersize_packed < erofs_blksiz(&g_sbi) ||
-		    pclustersize_packed % erofs_blksiz(&g_sbi)) {
+		if (pclustersize_packed < (1U << mkfs_blkszbits) ||
+		    pclustersize_packed % (1U << mkfs_blkszbits)) {
 			erofs_err("invalid pcluster size for the packed file %u",
 				  pclustersize_packed);
 			return -EINVAL;
@@ -1310,8 +1311,8 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 
 	if (pclustersize_metabox >= 0) {
 		if (pclustersize_metabox &&
-		    (pclustersize_metabox < erofs_blksiz(&g_sbi) ||
-		     pclustersize_metabox % erofs_blksiz(&g_sbi))) {
+		    (pclustersize_metabox < (1U << mkfs_blkszbits) ||
+		     pclustersize_metabox % (1U << mkfs_blkszbits))) {
 			erofs_err("invalid pcluster size %u for the metabox inode",
 				  pclustersize_metabox);
 			return -EINVAL;
@@ -1334,8 +1335,8 @@ static void erofs_mkfs_default_options(void)
 	cfg.c_mt_workers = erofs_get_available_processors();
 	cfg.c_mkfs_segment_size = 16ULL * 1024 * 1024;
 #endif
-	g_sbi.blkszbits = ilog2(min_t(u32, getpagesize(), EROFS_MAX_BLOCK_SIZE));
-	cfg.c_mkfs_pclustersize_max = erofs_blksiz(&g_sbi);
+	mkfs_blkszbits = ilog2(min_t(u32, getpagesize(), EROFS_MAX_BLOCK_SIZE));
+	cfg.c_mkfs_pclustersize_max = 1U << mkfs_blkszbits;
 	cfg.c_mkfs_pclustersize_def = cfg.c_mkfs_pclustersize_max;
 	g_sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_ZERO_PADDING;
 	g_sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
@@ -1468,7 +1469,7 @@ static void erofs_mkfs_showsummaries(void)
 		"Filesystem total inodes: %llu\n"
 		"Filesystem %s metadata blocks: %llu\n"
 		"Filesystem %s deduplicated bytes (of source files): %llu\n",
-		uuid_str, g_sbi.total_blocks | 0ULL, 1U << g_sbi.blkszbits,
+		uuid_str, g_sbi.total_blocks | 0ULL, 1U << mkfs_blkszbits,
 		g_sbi.inos | 0ULL,
 		incr, erofs_total_metablocks(g_sbi.bmgr) | 0ULL,
 		incr, g_sbi.saved_by_deduplication | 0ULL);
@@ -1481,7 +1482,6 @@ int main(int argc, char **argv)
 		.params = &importer_params,
 		.sbi = &g_sbi,
 	};
-	struct erofs_buffer_head *sb_bh;
 	struct erofs_inode *root = NULL;
 	bool tar_index_512b = false;
 	struct timeval t;
@@ -1539,16 +1539,6 @@ int main(int argc, char **argv)
 #endif
 	erofs_show_config();
 
-	importer_params.source = cfg.c_src_path;
-	importer_params.no_datainline = mkfs_no_datainline;
-	importer_params.dot_omitted = mkfs_dot_omitted;
-	if (importer_params.dot_omitted)
-		erofs_sb_set_48bit(&g_sbi);
-
-	err = erofs_importer_init(&importer);
-	if (err)
-		goto exit;
-
 #ifndef NDEBUG
 	if (cfg.c_random_pclusterblks)
 		srand(time(NULL));
@@ -1570,7 +1560,7 @@ int main(int argc, char **argv)
 			 * If mapfile is unspecified for tarfs index mode,
 			 * 512-byte block size is enforced here.
 			 */
-			g_sbi.blkszbits = 9;
+			mkfs_blkszbits = 9;
 			tar_index_512b = true;
 		}
 	} else if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
@@ -1586,46 +1576,15 @@ int main(int argc, char **argv)
 			erofs_err("failed to read superblock of %s", src->devname);
 			goto exit;
 		}
-		g_sbi.blkszbits = src->blkszbits;
+		mkfs_blkszbits = src->blkszbits;
 	}
 
-	if (!incremental_mode) {
-		g_sbi.bmgr = erofs_buffer_init(&g_sbi, 0, NULL);
-		if (!g_sbi.bmgr) {
-			err = -ENOMEM;
-			goto exit;
-		}
-		sb_bh = erofs_reserve_sb(g_sbi.bmgr);
-		if (IS_ERR(sb_bh)) {
-			err = PTR_ERR(sb_bh);
-			goto exit;
-		}
-	} else {
-		union {
-			struct stat st;
-			erofs_blk_t startblk;
-		} u;
-
-		erofs_warn("EXPERIMENTAL incremental build in use. Use at your own risk!");
-		err = erofs_read_superblock(&g_sbi);
-		if (err) {
-			erofs_err("failed to read superblock of %s", g_sbi.devname);
-			goto exit;
-		}
-
-		err = erofs_io_fstat(&g_sbi.bdev, &u.st);
-		if (!err && S_ISREG(u.st.st_mode))
-			u.startblk = DIV_ROUND_UP(u.st.st_size, erofs_blksiz(&g_sbi));
-		else
-			u.startblk = g_sbi.primarydevice_blocks;
-		g_sbi.bmgr = erofs_buffer_init(&g_sbi, u.startblk, NULL);
-		if (!g_sbi.bmgr) {
-			err = -ENOMEM;
-			goto exit;
-		}
-		sb_bh = NULL;
-	}
-	g_sbi.bmgr->dsunit = dsunit;
+	if (!incremental_mode)
+		err = erofs_mkfs_format_fs(&g_sbi, mkfs_blkszbits, dsunit);
+	else
+		err = erofs_mkfs_load_fs(&g_sbi, dsunit);
+	if (err)
+		goto exit;
 
 	/* Use the user-defined UUID or generate one for clean builds */
 	if (valid_fixeduuid)
@@ -1650,13 +1609,20 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	err = z_erofs_compress_init(&g_sbi, sb_bh);
+	err = z_erofs_compress_init(&g_sbi);
 	if (err) {
 		erofs_err("failed to initialize compressor: %s",
 			  erofs_strerror(err));
 		goto exit;
 	}
 
+	importer_params.source = cfg.c_src_path;
+	importer_params.no_datainline = mkfs_no_datainline;
+	importer_params.dot_omitted = mkfs_dot_omitted;
+	err = erofs_importer_init(&importer);
+	if (err)
+		goto exit;
+
 	if (cfg.c_dedupe) {
 		if (!cfg.c_compr_opts[0].alg) {
 			erofs_err("Compression is not enabled.  Turn on chunk-based data deduplication instead.");
@@ -1771,12 +1737,7 @@ int main(int argc, char **argv)
 	erofs_iput(root);
 	root = NULL;
 
-	err = erofs_writesb(&g_sbi, sb_bh);
-	if (err)
-		goto exit;
-
-	/* flush all remaining buffers */
-	err = erofs_bflush(g_sbi.bmgr, NULL);
+	err = erofs_writesb(&g_sbi);
 	if (err)
 		goto exit;
 
-- 
2.43.5


