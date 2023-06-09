Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AA77293AF
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jun 2023 10:51:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QcvvL1BWHz3f8p
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jun 2023 18:51:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1686300686;
	bh=iUuNwmuTupTUrzMj+4jnQ98KDbcug2J00LKpP5EnQio=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=NmRMH0D50/4XARk693QoAea0rGu5SJCvbvZgUBFbZvc82dcuTzoevoGFaUUillm8Q
	 dWLcfMOD0qYwAJlntPrqLcgHYQayHAsTjb0oY8wmAh4vZy0J/b0tJtO2j2NxzHMLuF
	 XCq9+xYAtnVg3ztGTXeq9YwFsJPz16nNeTQ6nqJmv1iRYN5jW58DrNGYHQPrCewZIC
	 RWVUrBXmhzwMEKkx0dGPYAtRx5GtFwgvqiFXtunaYjIv7NSpYrYX9pvopgdMBjfiy0
	 Q0YEGFw9ZLOaQRnsnQNJm7hoSDl1ufMCcoBJIZouR4Za/QJpIkMZ5p6yl6/t+Ggc03
	 MNe06ES1r4O7Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.46; helo=frasgout13.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=<UNKNOWN>)
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qcvtx5J7Bz3f0H
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Jun 2023 18:51:05 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Qcvfn6ynYz9y8JS
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Jun 2023 16:40:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
	by APP2 (Coremail) with SMTP id BqC_BwD3GnXj54Jk9pqGCA--.24524S5;
	Fri, 09 Jun 2023 08:50:54 +0000 (GMT)
To: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/4] erofs-utils: simplify erofs compressor init and exit
Date: Fri,  9 Jun 2023 16:50:40 +0800
Message-Id: <20230609085041.14987-4-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230609085041.14987-1-guoxuenan@huawei.com>
References: <20230609085041.14987-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BqC_BwD3GnXj54Jk9pqGCA--.24524S5
X-Coremail-Antispam: 1UD129KBjvAXoW3Cw17Cr4rCFy7tFW8Ar48Xrb_yoW8XrWfGo
	WUJan8Gw45GrWUJFWkGr10qw43Zw4Uu3WxCFWDJws093ZFqr1Ykry7Gw1YgFyfXr4Ygryk
	Ka4kAa4kJr4DXw18n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYJ7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	Wl82xGYIkIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07
	x20xyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2miiDUUUU
X-CM-SenderInfo: xjxr53hhqd0q5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
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
From: Guo Xuenan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Guo Xuenan <guoxuenan@huawei.com>
Cc: jack.qiu@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

since the compressor is independent in erofs-utils, rework the
compessor code using destructor and constructor, to make adding
a new algothrim easier.

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
---
 include/erofs/compress.h |   1 -
 lib/compress.c           |  81 +++++++++++------------------
 lib/compressor.c         | 109 +++++++++++++++++++++++----------------
 lib/compressor.h         |   9 +---
 lib/compressor_liblzma.c |   3 +-
 lib/compressor_lz4.c     |   3 +-
 lib/compressor_lz4hc.c   |   4 +-
 mkfs/main.c              |   1 -
 8 files changed, 99 insertions(+), 112 deletions(-)

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 714f304..81015b2 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -20,7 +20,6 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
 int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
 
 int z_erofs_compress_init(struct erofs_buffer_head *bh);
-int z_erofs_compress_exit(void);
 
 void zerofs_print_available_compressors(FILE *f);
 void zerofs_print_supported_compressors(FILE *f, unsigned int mask);
diff --git a/lib/compress.c b/lib/compress.c
index 14d228f..567f11e 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -21,19 +21,12 @@
 #include "erofs/compress_hints.h"
 #include "erofs/fragments.h"
 
-/* compressing configuration specified by users */
-struct erofs_compress_cfg {
-	struct erofs_compress handle;
-	unsigned int algorithmtype;
-	bool enable;
-} erofs_ccfg[EROFS_MAX_COMPR_CFGS];
-
 struct z_erofs_vle_compress_ctx {
 	u8 queue[EROFS_CONFIG_COMPR_MAX_SZ * 2];
 	struct z_erofs_inmem_extent e;	/* (lookahead) extent */
 
 	struct erofs_inode *inode;
-	struct erofs_compress_cfg *ccfg;
+	struct compressor *compressor;
 
 	u8 *metacur;
 	unsigned int head, tail;
@@ -382,7 +375,7 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_MAX_BLOCK_SIZE];
 	struct erofs_inode *inode = ctx->inode;
 	char *const dst = dstbuf + erofs_blksiz();
-	struct erofs_compress *const h = &ctx->ccfg->handle;
+	struct erofs_compress *const h = &ctx->compressor->handle;
 	unsigned int len = ctx->tail - ctx->head;
 	bool is_packed_inode = erofs_is_packed_inode(inode);
 	bool final = !ctx->remaining;
@@ -842,6 +835,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	static struct z_erofs_vle_compress_ctx ctx;
 	erofs_blk_t blkaddr, compressed_blocks;
 	unsigned int legacymetasize;
+	int ccfg_idx;
 	int ret;
 	u8 *compressmeta = malloc(vle_compressmeta_capacity(inode->i_size));
 
@@ -874,18 +868,18 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	if (cfg.c_fragments && !cfg.c_dedupe)
 		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 
+	ccfg_idx = erofs_get_compressor_by_name(cfg.c_compr_alg[0]);
 #ifndef NDEBUG
 	if (cfg.c_random_algorithms) {
 		while (1) {
-			inode->z_algorithmtype[0] =
-				rand() % EROFS_MAX_COMPR_CFGS;
-			if (erofs_ccfg[inode->z_algorithmtype[0]].enable)
+			ccfg_idx = rand() % erofs_compressor_num();
+			if (erofs_ccfg.compressors[ccfg_idx].enable)
 				break;
 		}
 	}
 #endif
-	ctx.ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
-	inode->z_algorithmtype[0] = ctx.ccfg[0].algorithmtype;
+	ctx.compressor = &erofs_ccfg.compressors[ccfg_idx];
+	inode->z_algorithmtype[0] = ctx.compressor->algorithmtype;
 	inode->z_algorithmtype[1] = 0;
 
 	inode->idata_size = 0;
@@ -1020,15 +1014,6 @@ err_free_meta:
 	return ret;
 }
 
-static int erofs_get_compress_algorithm_id(const char *name)
-{
-	if (!strcmp(name, "lz4") || !strcmp(name, "lz4hc"))
-		return Z_EROFS_COMPRESSION_LZ4;
-	if (!strcmp(name, "lzma"))
-		return Z_EROFS_COMPRESSION_LZMA;
-	return -ENOTSUP;
-}
-
 int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 {
 	struct erofs_buffer_head *bh = sb_bh;
@@ -1085,26 +1070,33 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 
 int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 {
-	int i, ret;
+	int i, k, ret;
 
 	for (i = 0; cfg.c_compr_alg[i]; ++i) {
-		ret = erofs_compressor_init(&erofs_ccfg[i].handle,
-					     cfg.c_compr_alg[i]);
-		if (ret)
-			return ret;
+		struct compressor *compressor = NULL;
 
-		ret = erofs_compressor_setlevel(&erofs_ccfg[i].handle,
-						cfg.c_compr_level[i]);
-		if (ret)
-			return ret;
+		k = erofs_get_compressor_by_name(cfg.c_compr_alg[i]);
+		if (k < 0) {
+			erofs_warn("Cannot find valid compressor for %s!", cfg.c_compr_alg[i]);
+			continue;
+		}
 
-		ret = erofs_get_compress_algorithm_id(cfg.c_compr_alg[i]);
-		if (ret < 0)
+		if (!erofs_ccfg.compressors[k].handle.alg) {
+			erofs_err("compressor %s not available!", cfg.c_compr_alg[i]);
+			return -EINVAL;
+		}
+
+		compressor = &erofs_ccfg.compressors[k];
+		ret = erofs_compressor_setlevel(&compressor->handle, cfg.c_compr_level[i]);
+		if (ret) {
+			erofs_err("compressor %s invalid compress level %d!",
+				cfg.c_compr_alg[i], cfg.c_compr_level[i]);
 			return ret;
-		erofs_ccfg[i].algorithmtype = ret;
-		erofs_ccfg[i].enable = true;
-		sbi.available_compr_algs |= 1 << ret;
-		if (ret != Z_EROFS_COMPRESSION_LZ4)
+		}
+
+		erofs_ccfg.compressors[k].enable = true;
+		sbi.available_compr_algs |= 1 << erofs_ccfg.compressors[k].algorithmtype;
+		if (erofs_ccfg.compressors[k].algorithmtype != Z_EROFS_COMPRESSION_LZ4)
 			erofs_sb_set_compr_cfgs();
 	}
 
@@ -1138,20 +1130,7 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 	}
 
 	if (erofs_sb_has_compr_cfgs()) {
-		sbi.available_compr_algs |= 1 << ret;
 		return z_erofs_build_compr_cfgs(sb_bh);
 	}
 	return 0;
 }
-
-int z_erofs_compress_exit(void)
-{
-	int i, ret;
-
-	for (i = 0; cfg.c_compr_alg[i]; ++i) {
-		ret = erofs_compressor_exit(&erofs_ccfg[i].handle);
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
diff --git a/lib/compressor.c b/lib/compressor.c
index 5aee4e0..4ba2d53 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -10,6 +10,11 @@
 
 #define EROFS_CONFIG_COMPR_DEF_BOUNDARY		(128)
 
+/* for enable compressor constructor */
+extern bool enable_constructor_lz4;
+extern bool enable_constructor_lz4hc;
+extern bool enable_constructor_lzma;
+
 /* compressing configuration specified by users */
 static struct erofs_supported_algothrim {
 	int algtype;
@@ -20,7 +25,25 @@ static struct erofs_supported_algothrim {
 	{ Z_EROFS_COMPRESSION_LZMA, "lzma"},
 };
 
-static struct erofs_compressors_cfg erofs_ccfg;
+struct erofs_compressors_cfg erofs_ccfg;
+
+static void erofs_init_compressor(struct compressor *compressor,
+	const struct erofs_compressor *alg)
+{
+
+	compressor->handle.alg = alg;
+
+	/* should be written in "minimum compression ratio * 100" */
+	compressor->handle.compress_threshold = 100;
+
+	/* optimize for 4k size page */
+	compressor->handle.destsize_alignsize = erofs_blksiz();
+	compressor->handle.destsize_redzone_begin = erofs_blksiz() - 16;
+	compressor->handle.destsize_redzone_end = EROFS_CONFIG_COMPR_DEF_BOUNDARY;
+
+	if (alg && alg->init)
+		alg->init(&compressor->handle);
+}
 
 int erofs_compressor_num(void)
 {
@@ -33,17 +56,38 @@ void erofs_compressor_register(const char *name, const struct erofs_compressor *
 
 	for (i = 0; i < erofs_compressor_num(); i++) {
 		if (!strcmp(erofs_ccfg.compressors[i].name, name)) {
-			erofs_ccfg.compressors[i].handle.alg = alg;
+			erofs_init_compressor(&erofs_ccfg.compressors[i], alg);
 			return;
 		}
 	}
 
 	erofs_ccfg.compressors[i].name = name;
-	erofs_ccfg.compressors[i].handle.alg = alg;
 	erofs_ccfg.compressors[i].algorithmtype = erofs_supported_algothrims[i].algtype;
+	erofs_init_compressor(&erofs_ccfg.compressors[i], alg);
 	erofs_ccfg.erofs_ccfg_num = ++i;
 }
 
+int erofs_get_compressor_by_name(const char *name)
+{
+	int i;
+
+	for (i = 0; i < erofs_compressor_num(); i++) {
+		if (!strcmp(erofs_ccfg.compressors[i].name, name)) {
+			return i;
+		}
+	}
+	return -EINVAL;
+}
+
+static void erofs_compressor_unregister(struct erofs_compress *c)
+{
+	const struct erofs_compressor *alg = c->alg;
+
+	if (alg && alg->exit)
+		alg->exit(c);
+	c->alg = NULL;
+}
+
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize, bool inblocks)
@@ -119,46 +163,7 @@ int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level)
 	return 0;
 }
 
-int erofs_compressor_init(struct erofs_compress *c, char *alg_name)
-{
-	int ret, i;
-
-	/* should be written in "minimum compression ratio * 100" */
-	c->compress_threshold = 100;
-
-	/* optimize for 4k size page */
-	c->destsize_alignsize = erofs_blksiz();
-	c->destsize_redzone_begin = erofs_blksiz() - 16;
-	c->destsize_redzone_end = EROFS_CONFIG_COMPR_DEF_BOUNDARY;
-
-	if (!alg_name) {
-		c->alg = NULL;
-		return 0;
-	}
-
-	ret = -EINVAL;
-	for (i = 0; i < erofs_compressor_num(); ++i) {
-		if (alg_name && strcmp(alg_name, erofs_ccfg.compressors[i].name))
-			continue;
-
-		ret = erofs_ccfg.compressors[i].handle.alg->init(c);
-		if (!ret) {
-			DBG_BUGON(!c->alg);
-			return 0;
-		}
-	}
-	erofs_err("Cannot find a valid compressor %s", alg_name);
-	return ret;
-}
-
-int erofs_compressor_exit(struct erofs_compress *c)
-{
-	if (c->alg && c->alg->exit)
-		return c->alg->exit(c);
-	return 0;
-}
-
-void __attribute__((constructor(101))) __erofs_compressor_init(void)
+void __attribute__((constructor(101))) erofs_compressor_init(void)
 {
 	int i;
 
@@ -166,9 +171,23 @@ void __attribute__((constructor(101))) __erofs_compressor_init(void)
 	for (i = 0; i < ARRAY_SIZE(erofs_supported_algothrims); i++) {
 		erofs_compressor_register(erofs_supported_algothrims[i].name, NULL);
 	}
+
+#if LZ4_ENABLED
+	enable_constructor_lz4 = true;
+#endif
+#if LZ4HC_ENABLED
+	enable_constructor_lz4hc = true;
+#endif
+#if HAVE_LIBLZMA
+	enable_constructor_lzma = true;
+#endif
 }
 
-void __attribute__((destructor)) __erofs_compressor_exit(void)
+void __attribute__((destructor)) erofs_compressor_exit(void)
 {
-	erofs_err("__erofs_compressor_exit");
+	int i;
+
+	for (i = 0; i < erofs_compressor_num(); ++i) {
+		erofs_compressor_unregister(&erofs_ccfg.compressors[i].handle);
+	}
 }
diff --git a/lib/compressor.h b/lib/compressor.h
index 3c1b328..00f4264 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -13,8 +13,6 @@
 struct erofs_compress;
 
 struct erofs_compressor {
-	const char *name;
-
 	int default_level;
 	int best_level;
 
@@ -54,18 +52,15 @@ struct erofs_compressors_cfg {
 };
 
 /* list of compression algorithms */
-extern const struct erofs_compressor erofs_compressor_lz4;
-extern const struct erofs_compressor erofs_compressor_lz4hc;
-extern const struct erofs_compressor erofs_compressor_lzma;
+extern struct erofs_compressors_cfg erofs_ccfg;
 
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize, bool inblocks);
 
 int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level);
-int erofs_compressor_init(struct erofs_compress *c, char *alg_name);
-int erofs_compressor_exit(struct erofs_compress *c);
 
 void erofs_compressor_register(const char *name, const struct erofs_compressor *alg);
 int erofs_compressor_num(void);
+int erofs_get_compressor_by_name(const char *name);
 #endif
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index b24139c..23ab630 100644
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
@@ -109,6 +107,7 @@ const struct erofs_compressor erofs_compressor_lzma = {
 	.compress_destsize = erofs_liblzma_compress_destsize,
 };
 
+bool enable_constructor_lzma;
 static void __attribute__((constructor)) register_lzma_compressor(void)
 {
 	erofs_compressor_register("lzma", &erofs_compressor_lzma);
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index a8adffe..ef4d986 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -32,13 +32,11 @@ static int compressor_lz4_exit(struct erofs_compress *c)
 
 static int compressor_lz4_init(struct erofs_compress *c)
 {
-	c->alg = &erofs_compressor_lz4;
 	sbi.lz4_max_distance = LZ4_DISTANCE_MAX;
 	return 0;
 }
 
 const struct erofs_compressor erofs_compressor_lz4 = {
-	.name = "lz4",
 	.default_level = 0,
 	.best_level = 0,
 	.init = compressor_lz4_init,
@@ -46,6 +44,7 @@ const struct erofs_compressor erofs_compressor_lz4 = {
 	.compress_destsize = lz4_compress_destsize,
 };
 
+bool enable_constructor_lz4;
 static void __attribute__((constructor)) register_lz4_compressor(void)
 {
 	erofs_compressor_register("lz4", &erofs_compressor_lz4);
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index 2b7e900..c5ce1a3 100644
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
@@ -69,6 +66,7 @@ const struct erofs_compressor erofs_compressor_lz4hc = {
 	.compress_destsize = lz4hc_compress_destsize,
 };
 
+bool enable_constructor_lz4hc;
 static void __attribute__((constructor)) register_lz4hc_compressor(void)
 {
 	erofs_compressor_register("lz4hc", &erofs_compressor_lz4hc);
diff --git a/mkfs/main.c b/mkfs/main.c
index dbd168e..6bf0472 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -916,7 +916,6 @@ int main(int argc, char **argv)
 	if (!err && erofs_sb_has_sb_chksum())
 		err = erofs_mkfs_superblock_csum_set();
 exit:
-	z_erofs_compress_exit();
 	z_erofs_dedupe_exit();
 #ifdef WITH_ANDROID
 	erofs_droid_blocklist_fclose();
-- 
2.31.1

