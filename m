Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C208B851F
	for <lists+linux-erofs@lfdr.de>; Wed,  1 May 2024 06:54:40 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bMA34WZV;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VTl953BFvz3cQX
	for <lists+linux-erofs@lfdr.de>; Wed,  1 May 2024 14:54:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bMA34WZV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VTl8w2zc0z2yt0
	for <linux-erofs@lists.ozlabs.org>; Wed,  1 May 2024 14:54:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714539258; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=t1sKz0Hb1aT79v3La0cNX2uqdffEFvzeGWScUiqZq6U=;
	b=bMA34WZVGHFmbSXLpMVHIbERosX7cQ37njgxtwOmENJGBNqlxVtiUqovi/iwCChMmkWQO7W8q4FQygMbqk/s1kj+Tp7DCnEBcz0isFRbYYgm0AFSo5Sf7hJLAdbvlDseKAh/mjh6+W58fAw2Q5i3tWRcq1DoG9oh7moykY745EE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W5e..b9_1714539251;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5e..b9_1714539251)
          by smtp.aliyun-inc.com;
          Wed, 01 May 2024 12:54:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/2] erofs-utils: record pclustersize in bytes instead of blocks
Date: Wed,  1 May 2024 12:54:10 +0800
Message-Id: <20240501045410.1808086-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240430063730.599937-1-hsiangkao@linux.alibaba.com>
References: <20240430063730.599937-1-hsiangkao@linux.alibaba.com>
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

So that we don't need to handle blocksizes everywhere.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1:
  fix CI failures:
    https://github.com/erofs/erofsnightly/actions/runs/8896341493/job/24428809079

 include/erofs/config.h |  4 +++-
 lib/compress.c         | 38 +++++++++++++++++++-------------------
 lib/compress_hints.c   | 11 ++++++-----
 lib/config.c           |  2 --
 mkfs/main.c            | 16 +++++++++-------
 5 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 16910ea..3ce8c59 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -79,7 +79,9 @@ struct erofs_configure {
 	u64 c_mkfs_segment_size;
 	u32 c_mt_workers;
 #endif
-	u32 c_pclusterblks_max, c_pclusterblks_def, c_pclusterblks_packed;
+	u32 c_mkfs_pclustersize_max;
+	u32 c_mkfs_pclustersize_def;
+	u32 c_mkfs_pclustersize_packed;
 	u32 c_max_decompressed_extent_bytes;
 	u64 c_unix_timestamp;
 	u32 c_uid, c_gid;
diff --git a/lib/compress.c b/lib/compress.c
index f918322..9772543 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -416,22 +416,21 @@ static int write_uncompressed_extent(struct z_erofs_compress_sctx *ctx,
 
 static unsigned int z_erofs_get_max_pclustersize(struct erofs_inode *inode)
 {
-	unsigned int pclusterblks;
-
-	if (erofs_is_packed_inode(inode))
-		pclusterblks = cfg.c_pclusterblks_packed;
+	if (erofs_is_packed_inode(inode)) {
+		return cfg.c_mkfs_pclustersize_packed;
 #ifndef NDEBUG
-	else if (cfg.c_random_pclusterblks)
-		pclusterblks = 1 + rand() % cfg.c_pclusterblks_max;
+	} else if (cfg.c_random_pclusterblks) {
+		unsigned int pclusterblks =
+			cfg.c_mkfs_pclustersize_max >> inode->sbi->blkszbits;
+
+		return (1 + rand() % pclusterblks) << inode->sbi->blkszbits;
 #endif
-	else if (cfg.c_compress_hints_file) {
+	} else if (cfg.c_compress_hints_file) {
 		z_erofs_apply_compress_hints(inode);
 		DBG_BUGON(!inode->z_physical_clusterblks);
-		pclusterblks = inode->z_physical_clusterblks;
-	} else {
-		pclusterblks = cfg.c_pclusterblks_def;
+		return inode->z_physical_clusterblks << inode->sbi->blkszbits;
 	}
-	return pclusterblks * erofs_blksiz(inode->sbi);
+	return cfg.c_mkfs_pclustersize_def;
 }
 
 static int z_erofs_fill_inline_data(struct erofs_inode *inode, void *data,
@@ -1591,7 +1590,8 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 			.lz4 = {
 				.max_distance =
 					cpu_to_le16(sbi->lz4_max_distance),
-				.max_pclusterblks = cfg.c_pclusterblks_max,
+				.max_pclusterblks =
+					cfg.c_mkfs_pclustersize_max >> sbi->blkszbits,
 			}
 		};
 
@@ -1696,17 +1696,17 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	 * if big pcluster is enabled, an extra CBLKCNT lcluster index needs
 	 * to be loaded in order to get those compressed block counts.
 	 */
-	if (cfg.c_pclusterblks_max > 1) {
-		if (cfg.c_pclusterblks_max >
-		    Z_EROFS_PCLUSTER_MAX_SIZE / erofs_blksiz(sbi)) {
-			erofs_err("unsupported clusterblks %u (too large)",
-				  cfg.c_pclusterblks_max);
+	if (cfg.c_mkfs_pclustersize_max > erofs_blksiz(sbi)) {
+		if (cfg.c_mkfs_pclustersize_max > Z_EROFS_PCLUSTER_MAX_SIZE) {
+			erofs_err("unsupported pclustersize %u (too large)",
+				  cfg.c_mkfs_pclustersize_max);
 			return -EINVAL;
 		}
 		erofs_sb_set_big_pcluster(sbi);
 	}
-	if (cfg.c_pclusterblks_packed > cfg.c_pclusterblks_max) {
-		erofs_err("invalid physical cluster size for the packed file");
+	if (cfg.c_mkfs_pclustersize_packed > cfg.c_mkfs_pclustersize_max) {
+		erofs_err("invalid pclustersize for the packed file %u",
+			  cfg.c_mkfs_pclustersize_packed);
 		return -EINVAL;
 	}
 
diff --git a/lib/compress_hints.c b/lib/compress_hints.c
index 8b78f80..e79bd48 100644
--- a/lib/compress_hints.c
+++ b/lib/compress_hints.c
@@ -55,7 +55,7 @@ bool z_erofs_apply_compress_hints(struct erofs_inode *inode)
 		return true;
 
 	s = erofs_fspath(inode->i_srcpath);
-	pclusterblks = cfg.c_pclusterblks_def;
+	pclusterblks = cfg.c_mkfs_pclustersize_def >> inode->sbi->blkszbits;
 	algorithmtype = 0;
 
 	list_for_each_entry(r, &compress_hints_head, list) {
@@ -136,7 +136,7 @@ int erofs_load_compress_hints(struct erofs_sb_info *sbi)
 		if (pclustersize % erofs_blksiz(sbi)) {
 			erofs_warn("invalid physical clustersize %u, "
 				   "use default pclusterblks %u",
-				   pclustersize, cfg.c_pclusterblks_def);
+				   pclustersize, cfg.c_mkfs_pclustersize_def);
 			continue;
 		}
 		erofs_insert_compress_hints(pattern,
@@ -146,9 +146,10 @@ int erofs_load_compress_hints(struct erofs_sb_info *sbi)
 			max_pclustersize = pclustersize;
 	}
 
-	if (cfg.c_pclusterblks_max * erofs_blksiz(sbi) < max_pclustersize) {
-		cfg.c_pclusterblks_max = max_pclustersize / erofs_blksiz(sbi);
-		erofs_warn("update max pclusterblks to %u", cfg.c_pclusterblks_max);
+	if (cfg.c_mkfs_pclustersize_max < max_pclustersize) {
+		cfg.c_mkfs_pclustersize_max = max_pclustersize;
+		erofs_warn("update max pclustersize to %u",
+			   cfg.c_mkfs_pclustersize_max);
 	}
 out:
 	fclose(f);
diff --git a/lib/config.c b/lib/config.c
index 98adaef..26f1c35 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -35,8 +35,6 @@ void erofs_init_configure(void)
 	cfg.c_unix_timestamp = -1;
 	cfg.c_uid = -1;
 	cfg.c_gid = -1;
-	cfg.c_pclusterblks_max = 1;
-	cfg.c_pclusterblks_def = 1;
 	cfg.c_max_decompressed_extent_bytes = -1;
 	erofs_stdout_tty = isatty(STDOUT_FILENO);
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index 9ad213b..a047dfa 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -820,8 +820,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				  pclustersize_max);
 			return -EINVAL;
 		}
-		cfg.c_pclusterblks_max = pclustersize_max >> sbi.blkszbits;
-		cfg.c_pclusterblks_def = cfg.c_pclusterblks_max;
+		cfg.c_mkfs_pclustersize_max = pclustersize_max;
+		cfg.c_mkfs_pclustersize_def = cfg.c_mkfs_pclustersize_max;
 	}
 	if (cfg.c_chunkbits && cfg.c_chunkbits < sbi.blkszbits) {
 		erofs_err("chunksize %u must be larger than block size",
@@ -830,13 +830,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	}
 
 	if (pclustersize_packed) {
-		if (pclustersize_max < erofs_blksiz(&sbi) ||
-		    pclustersize_max % erofs_blksiz(&sbi)) {
+		if (pclustersize_packed < erofs_blksiz(&sbi) ||
+		    pclustersize_packed % erofs_blksiz(&sbi)) {
 			erofs_err("invalid pcluster size for the packed file %u",
 				  pclustersize_packed);
 			return -EINVAL;
 		}
-		cfg.c_pclusterblks_packed = pclustersize_packed >> sbi.blkszbits;
+		cfg.c_mkfs_pclustersize_packed = pclustersize_packed;
 	}
 	return 0;
 }
@@ -953,6 +953,8 @@ static void erofs_mkfs_default_options(void)
 	cfg.c_mkfs_segment_size = 16ULL * 1024 * 1024;
 #endif
 	sbi.blkszbits = ilog2(min_t(u32, getpagesize(), EROFS_MAX_BLOCK_SIZE));
+	cfg.c_mkfs_pclustersize_max = erofs_blksiz(&sbi);
+	cfg.c_mkfs_pclustersize_def = cfg.c_mkfs_pclustersize_max;
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_ZERO_PADDING;
 	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
 			     EROFS_FEATURE_COMPAT_MTIME;
@@ -1153,8 +1155,8 @@ int main(int argc, char **argv)
 #endif
 	erofs_show_config();
 	if (cfg.c_fragments || cfg.c_extra_ea_name_prefixes) {
-		if (!cfg.c_pclusterblks_packed)
-			cfg.c_pclusterblks_packed = cfg.c_pclusterblks_def;
+		if (!cfg.c_mkfs_pclustersize_packed)
+			cfg.c_mkfs_pclustersize_packed = cfg.c_mkfs_pclustersize_def;
 
 		packedfile = erofs_packedfile_init();
 		if (IS_ERR(packedfile)) {
-- 
2.39.3

