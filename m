Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8934773951
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Aug 2023 11:23:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RKnn94YBRz2xFm
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Aug 2023 19:23:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RKnn13Lfsz2xLN
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Aug 2023 19:23:47 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VpKuzHs_1691486616;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VpKuzHs_1691486616)
          by smtp.aliyun-inc.com;
          Tue, 08 Aug 2023 17:23:40 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/2] erofs-utils: lib: add a way to request supported algorithms
Date: Tue,  8 Aug 2023 17:23:34 +0800
Message-Id: <20230808092335.111834-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

dump.erofs needs to print supported algorithms instead of available
compressors.

In addition, clean up erofs_get_compress_algorithm_id() too.

Cc: Guo Xuenan <guoxuenan@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - fix `available compressors` print.

 fsck/main.c                 |  8 ++--
 include/erofs/compress.h    |  3 +-
 lib/compress.c              | 33 ++++----------
 lib/compressor.c            | 90 ++++++++++++++++++++++++++++---------
 lib/compressor.h            |  7 +--
 lib/compressor_deflate.c    |  2 -
 lib/compressor_libdeflate.c |  2 -
 lib/compressor_liblzma.c    |  2 -
 lib/compressor_lz4.c        |  2 -
 lib/compressor_lz4hc.c      |  3 --
 mkfs/main.c                 |  8 ++--
 11 files changed, 94 insertions(+), 66 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 39a5534..7f78513 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -61,13 +61,15 @@ static struct list_head erofsfsck_link_hashtable[NR_HARDLINK_HASHTABLE];
 
 static void print_available_decompressors(FILE *f, const char *delim)
 {
-	unsigned int i = 0;
+	int i = 0;
+	bool comma = false;
 	const char *s;
 
-	while ((s = z_erofs_list_available_compressors(i)) != NULL) {
-		if (i++)
+	while ((s = z_erofs_list_available_compressors(&i)) != NULL) {
+		if (comma)
 			fputs(delim, f);
 		fputs(s, f);
+		comma = true;
 	}
 	fputc('\n', f);
 }
diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index f1ad84a..46cff03 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -23,7 +23,8 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi,
 			  struct erofs_buffer_head *bh);
 int z_erofs_compress_exit(void);
 
-const char *z_erofs_list_available_compressors(unsigned int i);
+const char *z_erofs_list_supported_algorithms(int i, unsigned int *mask);
+const char *z_erofs_list_available_compressors(int *i);
 
 static inline bool erofs_is_packed_inode(struct erofs_inode *inode)
 {
diff --git a/lib/compress.c b/lib/compress.c
index b43b077..e5d310f 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1030,17 +1030,6 @@ err_free_meta:
 	return ret;
 }
 
-static int erofs_get_compress_algorithm_id(const char *name)
-{
-	if (!strcmp(name, "lz4") || !strcmp(name, "lz4hc"))
-		return Z_EROFS_COMPRESSION_LZ4;
-	if (!strcmp(name, "lzma"))
-		return Z_EROFS_COMPRESSION_LZMA;
-	if (!strcmp(name, "deflate") || !strcmp(name, "libdeflate"))
-		return Z_EROFS_COMPRESSION_DEFLATE;
-	return -ENOTSUP;
-}
-
 static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 				    struct erofs_buffer_head *sb_bh)
 {
@@ -1123,23 +1112,21 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	int i, ret;
 
 	for (i = 0; cfg.c_compr_alg[i]; ++i) {
-		ret = erofs_compressor_init(sbi, &erofs_ccfg[i].handle,
-					     cfg.c_compr_alg[i]);
+		struct erofs_compress *c = &erofs_ccfg[i].handle;
+
+		ret = erofs_compressor_init(sbi, c, cfg.c_compr_alg[i]);
 		if (ret)
 			return ret;
 
-		ret = erofs_compressor_setlevel(&erofs_ccfg[i].handle,
-						cfg.c_compr_level[i]);
+		ret = erofs_compressor_setlevel(c, cfg.c_compr_level[i]);
 		if (ret)
 			return ret;
 
-		ret = erofs_get_compress_algorithm_id(cfg.c_compr_alg[i]);
-		if (ret < 0)
-			return ret;
-		erofs_ccfg[i].algorithmtype = ret;
+		erofs_ccfg[i].algorithmtype =
+			z_erofs_get_compress_algorithm_id(c);
 		erofs_ccfg[i].enable = true;
-		sbi->available_compr_algs |= 1 << ret;
-		if (ret != Z_EROFS_COMPRESSION_LZ4)
+		sbi->available_compr_algs |= 1 << erofs_ccfg[i].algorithmtype;
+		if (erofs_ccfg[i].algorithmtype != Z_EROFS_COMPRESSION_LZ4)
 			erofs_sb_set_compr_cfgs(sbi);
 	}
 
@@ -1172,10 +1159,8 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 		return -EINVAL;
 	}
 
-	if (erofs_sb_has_compr_cfgs(sbi)) {
-		sbi->available_compr_algs |= 1 << ret;
+	if (erofs_sb_has_compr_cfgs(sbi))
 		return z_erofs_build_compr_cfgs(sbi, sb_bh);
-	}
 	return 0;
 }
 
diff --git a/lib/compressor.c b/lib/compressor.c
index 4333f26..7230f01 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -10,22 +10,72 @@
 
 #define EROFS_CONFIG_COMPR_DEF_BOUNDARY		(128)
 
-static const struct erofs_compressor *compressors[] = {
+static const struct erofs_algorithm {
+	char *name;
+	const struct erofs_compressor *c;
+	unsigned int id;
+
+	/* its name won't be shown as a supported algorithm */
+	bool optimisor;
+} erofs_algs[] = {
+	{ "lz4",
 #if LZ4_ENABLED
-#if LZ4HC_ENABLED
-		&erofs_compressor_lz4hc,
-#endif
 		&erofs_compressor_lz4,
+#else
+		NULL,
 #endif
+	  Z_EROFS_COMPRESSION_LZ4, false },
+
+#if LZ4HC_ENABLED
+	{ "lz4hc", &erofs_compressor_lz4hc,
+	  Z_EROFS_COMPRESSION_LZ4, true },
+#endif
+
+	{ "lzma",
 #if HAVE_LIBLZMA
 		&erofs_compressor_lzma,
+#else
+		NULL,
 #endif
-		&erofs_compressor_deflate,
+	  Z_EROFS_COMPRESSION_LZMA, false },
+
+	{ "deflate", &erofs_compressor_deflate,
+	  Z_EROFS_COMPRESSION_DEFLATE, false },
+
 #if HAVE_LIBDEFLATE
-		&erofs_compressor_libdeflate,
+	{ "libdeflate", &erofs_compressor_libdeflate,
+	  Z_EROFS_COMPRESSION_DEFLATE, true },
 #endif
 };
 
+int z_erofs_get_compress_algorithm_id(const struct erofs_compress *c)
+{
+	DBG_BUGON(!c->alg);
+	return c->alg->id;
+}
+
+const char *z_erofs_list_supported_algorithms(int i, unsigned int *mask)
+{
+	if (i >= ARRAY_SIZE(erofs_algs))
+		return NULL;
+	if (!erofs_algs[i].optimisor && (*mask & (1 << erofs_algs[i].id))) {
+		*mask ^= 1 << erofs_algs[i].id;
+		return erofs_algs[i].name;
+	}
+	return "";
+}
+
+const char *z_erofs_list_available_compressors(int *i)
+{
+	for (;*i < ARRAY_SIZE(erofs_algs); ++*i) {
+		if (!erofs_algs[*i].c)
+			continue;
+		return erofs_algs[(*i)++].name;
+	}
+
+	return NULL;
+}
+
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize, bool inblocks)
@@ -34,11 +84,11 @@ int erofs_compress_destsize(const struct erofs_compress *c,
 	int ret;
 
 	DBG_BUGON(!c->alg);
-	if (!c->alg->compress_destsize)
+	if (!c->alg->c->compress_destsize)
 		return -ENOTSUP;
 
 	uncompressed_capacity = *srcsize;
-	ret = c->alg->compress_destsize(c, src, srcsize, dst, dstsize);
+	ret = c->alg->c->compress_destsize(c, src, srcsize, dst, dstsize);
 	if (ret < 0)
 		return ret;
 
@@ -55,16 +105,11 @@ int erofs_compress_destsize(const struct erofs_compress *c,
 	return ret;
 }
 
-const char *z_erofs_list_available_compressors(unsigned int i)
-{
-	return i >= ARRAY_SIZE(compressors) ? NULL : compressors[i]->name;
-}
-
 int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level)
 {
 	DBG_BUGON(!c->alg);
-	if (c->alg->setlevel)
-		return c->alg->setlevel(c, compression_level);
+	if (c->alg->c->setlevel)
+		return c->alg->c->setlevel(c, compression_level);
 
 	if (compression_level >= 0)
 		return -EINVAL;
@@ -93,13 +138,16 @@ int erofs_compressor_init(struct erofs_sb_info *sbi,
 	}
 
 	ret = -EINVAL;
-	for (i = 0; i < ARRAY_SIZE(compressors); ++i) {
-		if (alg_name && strcmp(alg_name, compressors[i]->name))
+	for (i = 0; i < ARRAY_SIZE(erofs_algs); ++i) {
+		if (alg_name && strcmp(alg_name, erofs_algs[i].name))
+			continue;
+
+		if (!erofs_algs[i].c)
 			continue;
 
-		ret = compressors[i]->init(c);
+		ret = erofs_algs[i].c->init(c);
 		if (!ret) {
-			DBG_BUGON(!c->alg);
+			c->alg = &erofs_algs[i];
 			return 0;
 		}
 	}
@@ -109,7 +157,7 @@ int erofs_compressor_init(struct erofs_sb_info *sbi,
 
 int erofs_compressor_exit(struct erofs_compress *c)
 {
-	if (c->alg && c->alg->exit)
-		return c->alg->exit(c);
+	if (c->alg && c->alg->c->exit)
+		return c->alg->c->exit(c);
 	return 0;
 }
diff --git a/lib/compressor.h b/lib/compressor.h
index 08a3988..9fa01d1 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -12,8 +12,6 @@
 struct erofs_compress;
 
 struct erofs_compressor {
-	const char *name;
-
 	int default_level;
 	int best_level;
 
@@ -26,9 +24,11 @@ struct erofs_compressor {
 				 void *dst, unsigned int dstsize);
 };
 
+struct erofs_algorithm;
+
 struct erofs_compress {
 	struct erofs_sb_info *sbi;
-	const struct erofs_compressor *alg;
+	const struct erofs_algorithm *alg;
 
 	unsigned int compress_threshold;
 	unsigned int compression_level;
@@ -48,6 +48,7 @@ extern const struct erofs_compressor erofs_compressor_lzma;
 extern const struct erofs_compressor erofs_compressor_deflate;
 extern const struct erofs_compressor erofs_compressor_libdeflate;
 
+int z_erofs_get_compress_algorithm_id(const struct erofs_compress *c);
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize, bool inblocks);
diff --git a/lib/compressor_deflate.c b/lib/compressor_deflate.c
index 5a7a657..4e5902e 100644
--- a/lib/compressor_deflate.c
+++ b/lib/compressor_deflate.c
@@ -36,7 +36,6 @@ static int compressor_deflate_exit(struct erofs_compress *c)
 
 static int compressor_deflate_init(struct erofs_compress *c)
 {
-	c->alg = &erofs_compressor_deflate;
 	c->private_data = NULL;
 
 	erofs_warn("EXPERIMENTAL DEFLATE algorithm in use. Use at your own risk!");
@@ -68,7 +67,6 @@ static int erofs_compressor_deflate_setlevel(struct erofs_compress *c,
 }
 
 const struct erofs_compressor erofs_compressor_deflate = {
-	.name = "deflate",
 	.default_level = 1,
 	.best_level = 9,
 	.init = compressor_deflate_init,
diff --git a/lib/compressor_libdeflate.c b/lib/compressor_libdeflate.c
index 2756dd8..c0b019a 100644
--- a/lib/compressor_libdeflate.c
+++ b/lib/compressor_libdeflate.c
@@ -82,7 +82,6 @@ static int compressor_libdeflate_exit(struct erofs_compress *c)
 
 static int compressor_libdeflate_init(struct erofs_compress *c)
 {
-	c->alg = &erofs_compressor_libdeflate;
 	c->private_data = NULL;
 
 	erofs_warn("EXPERIMENTAL libdeflate compressor in use. Use at your own risk!");
@@ -104,7 +103,6 @@ static int erofs_compressor_libdeflate_setlevel(struct erofs_compress *c,
 }
 
 const struct erofs_compressor erofs_compressor_libdeflate = {
-	.name = "libdeflate",
 	.default_level = 1,
 	.best_level = 12,
 	.init = compressor_libdeflate_init,
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index f274dce..0ed6f23 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -88,7 +88,6 @@ static int erofs_compressor_liblzma_init(struct erofs_compress *c)
 {
 	struct erofs_liblzma_context *ctx;
 
-	c->alg = &erofs_compressor_lzma;
 	ctx = malloc(sizeof(*ctx));
 	if (!ctx)
 		return -ENOMEM;
@@ -100,7 +99,6 @@ static int erofs_compressor_liblzma_init(struct erofs_compress *c)
 }
 
 const struct erofs_compressor erofs_compressor_lzma = {
-	.name = "lzma",
 	.default_level = LZMA_PRESET_DEFAULT,
 	.best_level = 109,
 	.init = erofs_compressor_liblzma_init,
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index e507b70..6677693 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -32,13 +32,11 @@ static int compressor_lz4_exit(struct erofs_compress *c)
 
 static int compressor_lz4_init(struct erofs_compress *c)
 {
-	c->alg = &erofs_compressor_lz4;
 	c->sbi->lz4_max_distance = LZ4_DISTANCE_MAX;
 	return 0;
 }
 
 const struct erofs_compressor erofs_compressor_lz4 = {
-	.name = "lz4",
 	.default_level = 0,
 	.best_level = 0,
 	.init = compressor_lz4_init,
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index f2120d8..b410e15 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -38,8 +38,6 @@ static int compressor_lz4hc_exit(struct erofs_compress *c)
 
 static int compressor_lz4hc_init(struct erofs_compress *c)
 {
-	c->alg = &erofs_compressor_lz4hc;
-
 	c->private_data = LZ4_createStreamHC();
 	if (!c->private_data)
 		return -ENOMEM;
@@ -60,7 +58,6 @@ static int compressor_lz4hc_setlevel(struct erofs_compress *c,
 }
 
 const struct erofs_compressor erofs_compressor_lz4hc = {
-	.name = "lz4hc",
 	.default_level = LZ4HC_CLEVEL_DEFAULT,
 	.best_level = LZ4HC_CLEVEL_MAX,
 	.init = compressor_lz4hc_init,
diff --git a/mkfs/main.c b/mkfs/main.c
index 3809c71..9c2397c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -68,13 +68,15 @@ static struct option long_options[] = {
 
 static void print_available_compressors(FILE *f, const char *delim)
 {
-	unsigned int i = 0;
+	int i = 0;
+	bool comma = false;
 	const char *s;
 
-	while ((s = z_erofs_list_available_compressors(i)) != NULL) {
-		if (i++)
+	while ((s = z_erofs_list_available_compressors(&i)) != NULL) {
+		if (comma)
 			fputs(delim, f);
 		fputs(s, f);
+		comma = true;
 	}
 	fputc('\n', f);
 }
-- 
2.24.4

