Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E991948689
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2024 02:09:31 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QxhWUt4a;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WdDFN6dxjz3cY5
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2024 10:09:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QxhWUt4a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WdDFL11qjz30V2
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Aug 2024 10:09:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 377FACE0C50;
	Tue,  6 Aug 2024 00:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B4EC4AF0B;
	Tue,  6 Aug 2024 00:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722902961;
	bh=rV942ZIIQS9kLLyvXeqrURlRV9cJ6wUo4lbyrY7+IL0=;
	h=From:To:Cc:Subject:Date:From;
	b=QxhWUt4anMissSrEm6gMtL6KczVVLl4ro8aBR3cPUNH+qa1XQCdZqvuBOIgcPVoCP
	 /0/ImQ/xKvF9BdQOMZiuWmIb6MlXAa9erYYGVIZjyn2Hi4T6hFTu0VCG0jcOR7dkNW
	 1kNzLRKyCpOnIJb83nBB5oDrH/RaL1i7s/4SXlx+PHOb/96jwHwmYXidSZrQ/YGqXu
	 FCJKRFQ6+f6bdGRhEoq3l7Zo8t9qb+54ieTQAhqvukL29tGgHv9CvIuF2V3KNpEpK1
	 9nI5Swv6EN070pQdkeHYeF1UxcDHPevflA4/ZKQRZSN1zS6flNAbb5AEq8ajhZGsU4
	 W6QgWk0OsfYrg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: disallow new algorithms on incremental builds
Date: Tue,  6 Aug 2024 08:08:59 +0800
Message-Id: <20240806000859.66658-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
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

From: Gao Xiang <hsiangkao@linux.alibaba.com>

On-disk compression configurations are not rewritten on incremental
builds, therefore there is no way to add new algorithms in this mode.

Clean builds should be used instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 dump/main.c              |  2 +-
 include/erofs/internal.h | 12 +++++++++---
 lib/compress.c           | 33 ++++++++++++++++++++++++++-------
 lib/compressor_lz4.c     |  3 ++-
 lib/compressor_lz4hc.c   |  3 ++-
 lib/decompress.c         | 34 +++++++++++++++++++++++++++++-----
 lib/super.c              |  2 +-
 7 files changed, 70 insertions(+), 19 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 06ca4d3..372162e 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -651,7 +651,7 @@ static void erofsdump_show_superblock(void)
 			g_sbi.available_compr_algs);
 	} else {
 		fprintf(stdout, "Filesystem lz4_max_distance:                  %u\n",
-			g_sbi.lz4_max_distance | 0U);
+			g_sbi.lz4.max_distance | 0U);
 	}
 	fprintf(stdout, "Filesystem sb_size:                           %u\n",
 			g_sbi.sb_size | 0U);
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 708e51e..2edc1b4 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -66,6 +66,13 @@ struct erofs_device_info {
 	u32 mapped_blkaddr;
 };
 
+/* all filesystem-wide lz4 configurations */
+struct erofs_sb_lz4_info {
+	u16 max_distance;
+	/* maximum possible blocks for pclusters in the filesystem */
+	u16 max_pclusterblks;
+};
+
 struct erofs_xattr_prefix_item {
 	struct erofs_xattr_long_prefix *prefix;
 	u8 infix_len;
@@ -75,6 +82,7 @@ struct erofs_xattr_prefix_item {
 
 struct erofs_mkfs_dfops;
 struct erofs_sb_info {
+	struct erofs_sb_lz4_info lz4;
 	struct erofs_device_info *devs;
 	char *devname;
 
@@ -102,10 +110,8 @@ struct erofs_sb_info {
 	u8 uuid[16];
 	char volume_name[16];
 
-	u16 available_compr_algs;
-	u16 lz4_max_distance;
-
 	u32 checksum;
+	u16 available_compr_algs;
 	u16 extra_devices;
 	union {
 		u16 devt_slotoff;		/* used for mkfs */
diff --git a/lib/compress.c b/lib/compress.c
index 794f714..cea96f4 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1591,7 +1591,7 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 			.size = cpu_to_le16(sizeof(struct z_erofs_lz4_cfgs)),
 			.lz4 = {
 				.max_distance =
-					cpu_to_le16(sbi->lz4_max_distance),
+					cpu_to_le16(sbi->lz4.max_distance),
 				.max_pclusterblks =
 					cfg.c_mkfs_pclustersize_max >> sbi->blkszbits,
 			}
@@ -1686,6 +1686,7 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 {
 	int i, ret, id;
 	u32 max_dict_size[Z_EROFS_COMPRESSION_MAX] = {};
+	u32 available_compr_algs = 0;
 
 	for (i = 0; cfg.c_compr_opts[i].alg; ++i) {
 		struct erofs_compress *c = &erofs_ccfg[i].handle;
@@ -1699,7 +1700,7 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 		id = z_erofs_get_compress_algorithm_id(c);
 		erofs_ccfg[i].algorithmtype = id;
 		erofs_ccfg[i].enable = true;
-		sbi->available_compr_algs |= 1 << erofs_ccfg[i].algorithmtype;
+		available_compr_algs |= 1 << erofs_ccfg[i].algorithmtype;
 		if (erofs_ccfg[i].algorithmtype != Z_EROFS_COMPRESSION_LZ4)
 			erofs_sb_set_compr_cfgs(sbi);
 		if (c->dict_size > max_dict_size[id])
@@ -1710,14 +1711,32 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	 * if primary algorithm is empty (e.g. compression off),
 	 * clear 0PADDING feature for old kernel compatibility.
 	 */
-	if (!cfg.c_compr_opts[0].alg ||
-	    (cfg.c_legacy_compress &&
-	     !strncmp(cfg.c_compr_opts[0].alg, "lz4", 3)))
+	if (!available_compr_algs ||
+	    (cfg.c_legacy_compress && available_compr_algs == 1))
 		erofs_sb_clear_lz4_0padding(sbi);
 
-	if (!cfg.c_compr_opts[0].alg)
+	if (!available_compr_algs)
 		return 0;
 
+	if (!sb_bh) {
+		u32 dalg = available_compr_algs & (~sbi->available_compr_algs);
+
+		if (dalg) {
+			erofs_err("unavailable algorithms 0x%x on incremental builds",
+				  dalg);
+			return -EOPNOTSUPP;
+		}
+		if (available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZ4) &&
+		    sbi->lz4.max_pclusterblks << sbi->blkszbits <
+			cfg.c_mkfs_pclustersize_max) {
+			erofs_err("pclustersize %u is too large on incremental builds",
+				  cfg.c_mkfs_pclustersize_max);
+			return -EOPNOTSUPP;
+		}
+	} else {
+		sbi->available_compr_algs = available_compr_algs;
+	}
+
 	/*
 	 * if big pcluster is enabled, an extra CBLKCNT lcluster index needs
 	 * to be loaded in order to get those compressed block counts.
@@ -1736,7 +1755,7 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 		return -EINVAL;
 	}
 
-	if (erofs_sb_has_compr_cfgs(sbi)) {
+	if (sb_bh && erofs_sb_has_compr_cfgs(sbi)) {
 		ret = z_erofs_build_compr_cfgs(sbi, sb_bh, max_dict_size);
 		if (ret)
 			return ret;
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index 5ecfd3e..f3d88b0 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -32,7 +32,8 @@ static int compressor_lz4_exit(struct erofs_compress *c)
 
 static int compressor_lz4_init(struct erofs_compress *c)
 {
-	c->sbi->lz4_max_distance = LZ4_DISTANCE_MAX;
+	c->sbi->lz4.max_distance = max_t(u16, c->sbi->lz4.max_distance,
+					 LZ4_DISTANCE_MAX);
 	return 0;
 }
 
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index f354b84..1e1ccc7 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -43,7 +43,8 @@ static int compressor_lz4hc_init(struct erofs_compress *c)
 	if (!c->private_data)
 		return -ENOMEM;
 
-	c->sbi->lz4_max_distance = LZ4_DISTANCE_MAX;
+	c->sbi->lz4.max_distance = max_t(u16, c->sbi->lz4.max_distance,
+					 LZ4_DISTANCE_MAX);
 	return 0;
 }
 
diff --git a/lib/decompress.c b/lib/decompress.c
index 1e22f9f..1b44a18 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -545,6 +545,30 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 	return -EOPNOTSUPP;
 }
 
+static int z_erofs_load_lz4_config(struct erofs_sb_info *sbi,
+			    struct erofs_super_block *dsb, void *data, int size)
+{
+	struct z_erofs_lz4_cfgs *lz4 = data;
+	u16 distance;
+
+	if (lz4) {
+		if (size < sizeof(struct z_erofs_lz4_cfgs)) {
+			erofs_err("invalid lz4 cfgs, size=%u", size);
+			return -EINVAL;
+		}
+		distance = le16_to_cpu(lz4->max_distance);
+
+		sbi->lz4.max_pclusterblks = le16_to_cpu(lz4->max_pclusterblks);
+		if (!sbi->lz4.max_pclusterblks)
+			sbi->lz4.max_pclusterblks = 1;	/* reserved case */
+	} else {
+		distance = le16_to_cpu(dsb->u1.lz4_max_distance);
+		sbi->lz4.max_pclusterblks = 1;
+	}
+	sbi->lz4.max_distance = distance;
+	return 0;
+}
+
 int z_erofs_parse_cfgs(struct erofs_sb_info *sbi, struct erofs_super_block *dsb)
 {
 	unsigned int algs, alg;
@@ -553,8 +577,7 @@ int z_erofs_parse_cfgs(struct erofs_sb_info *sbi, struct erofs_super_block *dsb)
 
 	if (!erofs_sb_has_compr_cfgs(sbi)) {
 		sbi->available_compr_algs = 1 << Z_EROFS_COMPRESSION_LZ4;
-		sbi->lz4_max_distance = le16_to_cpu(dsb->u1.lz4_max_distance);
-		return 0;
+		return z_erofs_load_lz4_config(sbi, dsb, NULL, 0);
 	}
 
 	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
@@ -578,10 +601,11 @@ int z_erofs_parse_cfgs(struct erofs_sb_info *sbi, struct erofs_super_block *dsb)
 			break;
 		}
 
-		if (alg == Z_EROFS_COMPRESSION_DEFLATE)
+		ret = 0;
+		if (alg == Z_EROFS_COMPRESSION_LZ4)
+			ret = z_erofs_load_lz4_config(sbi, dsb, data, size);
+		else if (alg == Z_EROFS_COMPRESSION_DEFLATE)
 			ret = z_erofs_load_deflate_config(sbi, dsb, data, size);
-		else
-			ret = 0;
 		free(data);
 		if (ret)
 			break;
diff --git a/lib/super.c b/lib/super.c
index 45233c4..32e10cd 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -188,7 +188,7 @@ int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh,
 	if (erofs_sb_has_compr_cfgs(sbi))
 		sb.u1.available_compr_algs = cpu_to_le16(sbi->available_compr_algs);
 	else
-		sb.u1.lz4_max_distance = cpu_to_le16(sbi->lz4_max_distance);
+		sb.u1.lz4_max_distance = cpu_to_le16(sbi->lz4.max_distance);
 
 	buf = calloc(sb_blksize, 1);
 	if (!buf) {
-- 
2.30.2

