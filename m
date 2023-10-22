Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9667A7D2325
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Oct 2023 15:11:08 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Te4siXS7;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SCzGd3nCQz3c9c
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Oct 2023 00:11:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Te4siXS7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SCzGV0lYjz3bTn
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Oct 2023 00:10:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id D47EDB80AD8;
	Sun, 22 Oct 2023 13:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5C2C433C7;
	Sun, 22 Oct 2023 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697980252;
	bh=MseKFTvWxBdl33bP3TtcNv14Z39R56Zq5yw9XRJ81y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Te4siXS7b/lROy51j9yaE2CqhlGMvoFfU9RwmQ3R92GU20aNYeNPWHOKhXKdd3SiJ
	 y2THUE4RK+A0jPmU+Q4qHu77EAiWv5t7rmPHMCDf3yCaE5qmrQlaO3eXO5DrtzZSb8
	 iF+DxzX/kUM229kzsC/RtE6P5lNM8Fu+5pxRiW0v/2CG0zCFRt59bWF13NCqGHAMF1
	 nbkBJhmZpcplFPX0fDwC/MsYRzo/nHZIi+yLgV0z3L883E86C50Fz9H7fyoFBvPLpo
	 86eChHrTdO6hreWJ5i06YsfaLCCr0iStAKQJjYWFYK297iSU3423yjiw+oqXq1ibfB
	 Lzd4aPt1GfnEA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: simplify compression configuration parser
Date: Sun, 22 Oct 2023 21:09:57 +0800
Message-Id: <20231022130957.11398-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231021020109.1646299-1-hsiangkao@linux.alibaba.com>
References: <20231021020109.1646299-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Move erofs_load_compr_cfgs() into decompressor.c as well as introduce
a callback instead of a hard-coded switch for each algorithm for
simplicity.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - fix build warning of `-Wmissing-declarations`
   https://lore.kernel.org/r/202310221347.8YPc9FUC-lkp@intel.com

 fs/erofs/compress.h             |  6 +++
 fs/erofs/decompressor.c         | 62 ++++++++++++++++++++++++++--
 fs/erofs/decompressor_deflate.c |  5 ++-
 fs/erofs/decompressor_lzma.c    |  4 +-
 fs/erofs/internal.h             | 38 +----------------
 fs/erofs/super.c                | 72 ++++-----------------------------
 6 files changed, 79 insertions(+), 108 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 349c3316ae6b..279933e007d2 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -21,6 +21,8 @@ struct z_erofs_decompress_req {
 };
 
 struct z_erofs_decompressor {
+	int (*config)(struct super_block *sb, struct erofs_super_block *dsb,
+		      void *data, int size);
 	int (*decompress)(struct z_erofs_decompress_req *rq,
 			  struct page **pagepool);
 	char *name;
@@ -92,6 +94,10 @@ int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
 extern const struct z_erofs_decompressor erofs_decompressors[];
 
 /* prototypes for specific algorithms */
+int z_erofs_load_lzma_config(struct super_block *sb,
+			struct erofs_super_block *dsb, void *data, int size);
+int z_erofs_load_deflate_config(struct super_block *sb,
+			struct erofs_super_block *dsb, void *data, int size);
 int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 			    struct page **pagepool);
 int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 332ec5f74002..e75edc8f1753 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -24,11 +24,11 @@ struct z_erofs_lz4_decompress_ctx {
 	unsigned int oend;
 };
 
-int z_erofs_load_lz4_config(struct super_block *sb,
-			    struct erofs_super_block *dsb,
-			    struct z_erofs_lz4_cfgs *lz4, int size)
+static int z_erofs_load_lz4_config(struct super_block *sb,
+			    struct erofs_super_block *dsb, void *data, int size)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct z_erofs_lz4_cfgs *lz4 = data;
 	u16 distance;
 
 	if (lz4) {
@@ -370,19 +370,75 @@ const struct z_erofs_decompressor erofs_decompressors[] = {
 		.name = "interlaced"
 	},
 	[Z_EROFS_COMPRESSION_LZ4] = {
+		.config = z_erofs_load_lz4_config,
 		.decompress = z_erofs_lz4_decompress,
 		.name = "lz4"
 	},
 #ifdef CONFIG_EROFS_FS_ZIP_LZMA
 	[Z_EROFS_COMPRESSION_LZMA] = {
+		.config = z_erofs_load_lzma_config,
 		.decompress = z_erofs_lzma_decompress,
 		.name = "lzma"
 	},
 #endif
 #ifdef CONFIG_EROFS_FS_ZIP_DEFLATE
 	[Z_EROFS_COMPRESSION_DEFLATE] = {
+		.config = z_erofs_load_deflate_config,
 		.decompress = z_erofs_deflate_decompress,
 		.name = "deflate"
 	},
 #endif
 };
+
+int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	unsigned int algs, alg;
+	erofs_off_t offset;
+	int size, ret = 0;
+
+	if (!erofs_sb_has_compr_cfgs(sbi)) {
+		sbi->available_compr_algs = Z_EROFS_COMPRESSION_LZ4;
+		return z_erofs_load_lz4_config(sb, dsb, NULL, 0);
+	}
+
+	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
+	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
+		erofs_err(sb, "unidentified algorithms %x, please upgrade kernel",
+			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
+		return -EOPNOTSUPP;
+	}
+
+	erofs_init_metabuf(&buf, sb);
+	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
+	alg = 0;
+	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
+		void *data;
+
+		if (!(algs & 1))
+			continue;
+
+		data = erofs_read_metadata(sb, &buf, &offset, &size);
+		if (IS_ERR(data)) {
+			ret = PTR_ERR(data);
+			break;
+		}
+
+		if (alg >= ARRAY_SIZE(erofs_decompressors) ||
+		    !erofs_decompressors[alg].config) {
+			erofs_err(sb, "algorithm %d isn't enabled on this kernel",
+				  alg);
+			ret = -EOPNOTSUPP;
+		} else {
+			ret = erofs_decompressors[alg].config(sb,
+					dsb, data, size);
+		}
+
+		kfree(data);
+		if (ret)
+			break;
+	}
+	erofs_put_metabuf(&buf);
+	return ret;
+}
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 19e5bdeb30b6..0e1946a6bda5 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -77,9 +77,10 @@ int __init z_erofs_deflate_init(void)
 }
 
 int z_erofs_load_deflate_config(struct super_block *sb,
-				struct erofs_super_block *dsb,
-				struct z_erofs_deflate_cfgs *dfl, int size)
+			struct erofs_super_block *dsb, void *data, int size)
 {
+	struct z_erofs_deflate_cfgs *dfl = data;
+
 	if (!dfl || size < sizeof(struct z_erofs_deflate_cfgs)) {
 		erofs_err(sb, "invalid deflate cfgs, size=%u", size);
 		return -EINVAL;
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 5f413f19a064..852dd8eac5df 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -72,10 +72,10 @@ int __init z_erofs_lzma_init(void)
 }
 
 int z_erofs_load_lzma_config(struct super_block *sb,
-			     struct erofs_super_block *dsb,
-			     struct z_erofs_lzma_cfgs *lzma, int size)
+			struct erofs_super_block *dsb, void *data, int size)
 {
 	static DEFINE_MUTEX(lzma_resize_mutex);
+	struct z_erofs_lzma_cfgs *lzma = data;
 	unsigned int dict_size, i;
 	struct z_erofs_lzma *strm, *head = NULL;
 	int err;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ff88d0dd980..d8de61350dc0 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -469,9 +469,6 @@ int __init z_erofs_init_zip_subsystem(void);
 void z_erofs_exit_zip_subsystem(void);
 int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 				       struct erofs_workgroup *egrp);
-int z_erofs_load_lz4_config(struct super_block *sb,
-			    struct erofs_super_block *dsb,
-			    struct z_erofs_lz4_cfgs *lz4, int len);
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags);
 void *erofs_get_pcpubuf(unsigned int requiredpages);
@@ -480,6 +477,7 @@ int erofs_pcpubuf_growsize(unsigned int nrpages);
 void __init erofs_pcpubuf_init(void);
 void erofs_pcpubuf_exit(void);
 int erofs_init_managed_cache(struct super_block *sb);
+int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
 static inline void erofs_shrinker_unregister(struct super_block *sb) {}
@@ -487,16 +485,6 @@ static inline int erofs_init_shrinker(void) { return 0; }
 static inline void erofs_exit_shrinker(void) {}
 static inline int z_erofs_init_zip_subsystem(void) { return 0; }
 static inline void z_erofs_exit_zip_subsystem(void) {}
-static inline int z_erofs_load_lz4_config(struct super_block *sb,
-				  struct erofs_super_block *dsb,
-				  struct z_erofs_lz4_cfgs *lz4, int len)
-{
-	if (lz4 || dsb->u1.lz4_max_distance) {
-		erofs_err(sb, "lz4 algorithm isn't enabled");
-		return -EINVAL;
-	}
-	return 0;
-}
 static inline void erofs_pcpubuf_init(void) {}
 static inline void erofs_pcpubuf_exit(void) {}
 static inline int erofs_init_managed_cache(struct super_block *sb) { return 0; }
@@ -505,41 +493,17 @@ static inline int erofs_init_managed_cache(struct super_block *sb) { return 0; }
 #ifdef CONFIG_EROFS_FS_ZIP_LZMA
 int __init z_erofs_lzma_init(void);
 void z_erofs_lzma_exit(void);
-int z_erofs_load_lzma_config(struct super_block *sb,
-			     struct erofs_super_block *dsb,
-			     struct z_erofs_lzma_cfgs *lzma, int size);
 #else
 static inline int z_erofs_lzma_init(void) { return 0; }
 static inline int z_erofs_lzma_exit(void) { return 0; }
-static inline int z_erofs_load_lzma_config(struct super_block *sb,
-			     struct erofs_super_block *dsb,
-			     struct z_erofs_lzma_cfgs *lzma, int size) {
-	if (lzma) {
-		erofs_err(sb, "lzma algorithm isn't enabled");
-		return -EINVAL;
-	}
-	return 0;
-}
 #endif	/* !CONFIG_EROFS_FS_ZIP_LZMA */
 
 #ifdef CONFIG_EROFS_FS_ZIP_DEFLATE
 int __init z_erofs_deflate_init(void);
 void z_erofs_deflate_exit(void);
-int z_erofs_load_deflate_config(struct super_block *sb,
-				struct erofs_super_block *dsb,
-				struct z_erofs_deflate_cfgs *dfl, int size);
 #else
 static inline int z_erofs_deflate_init(void) { return 0; }
 static inline int z_erofs_deflate_exit(void) { return 0; }
-static inline int z_erofs_load_deflate_config(struct super_block *sb,
-			struct erofs_super_block *dsb,
-			struct z_erofs_deflate_cfgs *dfl, int size) {
-	if (dfl) {
-		erofs_err(sb, "deflate algorithm isn't enabled");
-		return -EINVAL;
-	}
-	return 0;
-}
 #endif	/* !CONFIG_EROFS_FS_ZIP_DEFLATE */
 
 #ifdef CONFIG_EROFS_FS_ONDEMAND
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3700af9ee173..cc44fb2e001e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -156,68 +156,15 @@ void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 	return buffer;
 }
 
-#ifdef CONFIG_EROFS_FS_ZIP
-static int erofs_load_compr_cfgs(struct super_block *sb,
-				 struct erofs_super_block *dsb)
+#ifndef CONFIG_EROFS_FS_ZIP
+static int z_erofs_parse_cfgs(struct super_block *sb,
+			      struct erofs_super_block *dsb)
 {
-	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-	unsigned int algs, alg;
-	erofs_off_t offset;
-	int size, ret = 0;
-
-	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
-	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
-		erofs_err(sb, "try to load compressed fs with unsupported algorithms %x",
-			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
-		return -EINVAL;
-	}
-
-	erofs_init_metabuf(&buf, sb);
-	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
-	alg = 0;
-	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
-		void *data;
-
-		if (!(algs & 1))
-			continue;
-
-		data = erofs_read_metadata(sb, &buf, &offset, &size);
-		if (IS_ERR(data)) {
-			ret = PTR_ERR(data);
-			break;
-		}
+	if (!dsb->u1.available_compr_algs)
+		return 0;
 
-		switch (alg) {
-		case Z_EROFS_COMPRESSION_LZ4:
-			ret = z_erofs_load_lz4_config(sb, dsb, data, size);
-			break;
-		case Z_EROFS_COMPRESSION_LZMA:
-			ret = z_erofs_load_lzma_config(sb, dsb, data, size);
-			break;
-		case Z_EROFS_COMPRESSION_DEFLATE:
-			ret = z_erofs_load_deflate_config(sb, dsb, data, size);
-			break;
-		default:
-			DBG_BUGON(1);
-			ret = -EFAULT;
-		}
-		kfree(data);
-		if (ret)
-			break;
-	}
-	erofs_put_metabuf(&buf);
-	return ret;
-}
-#else
-static int erofs_load_compr_cfgs(struct super_block *sb,
-				 struct erofs_super_block *dsb)
-{
-	if (dsb->u1.available_compr_algs) {
-		erofs_err(sb, "try to load compressed fs when compression is disabled");
-		return -EINVAL;
-	}
-	return 0;
+	erofs_err(sb, "compression disabled, unable to mount compressed EROFS");
+	return -EOPNOTSUPP;
 }
 #endif
 
@@ -406,10 +353,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	}
 
 	/* parse on-disk compression configurations */
-	if (erofs_sb_has_compr_cfgs(sbi))
-		ret = erofs_load_compr_cfgs(sb, dsb);
-	else
-		ret = z_erofs_load_lz4_config(sb, dsb, NULL, 0);
+	ret = z_erofs_parse_cfgs(sb, dsb);
 	if (ret < 0)
 		goto out;
 
-- 
2.30.2

