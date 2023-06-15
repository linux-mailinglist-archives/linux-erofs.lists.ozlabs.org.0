Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CB147731513
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 12:18:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1686824292;
	bh=h/37lTqv8lTq42XP/fM6Ka3+wNPs8LiZVWvGYRifjsE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=LsXx8eW8yWbBgwEmkiF5Fcnx1EFSxt8BZ6PMCIKL87jqQQ9AdYgX78JKLMDLSXdO5
	 hMTSWdTw0fF8kcOnB6xkg8cJVDLsNTeqAYQ4xVUUus9XijzaKdPlwZ5r/7O3eTRfH8
	 m/Yh0c2PmQmDz5ZrFq3pALlrMMeJl86kJQ2M31XFPsvmA2Aw7NLWc+uu0UZn33NgmY
	 e5loW7u2NPyQ/ozLS/6KqCbAuX+30Qpz7S7Lgu5r6kLyTBzAWgopci3/81y/8ozqxs
	 JWZYqJkOtF+45G+CfxtvnCHlvZJTe7YUqTDnVX35md96re6AeCo9jAwiWNiU/312Pe
	 rK2CHdTSMGP5g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QhdXh52yMz30hG
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 20:18:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.23; helo=frasgout11.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QhdXH3Mymz30g1
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 20:17:50 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QhdHy67WTz9xGgf
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 18:07:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
	by APP2 (Coremail) with SMTP id BqC_BwDXvYc55YpkT63TCA--.7908S5;
	Thu, 15 Jun 2023 10:17:40 +0000 (GMT)
To: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/4] erofs-utils: simplify erofs compressor init and exit
Date: Thu, 15 Jun 2023 18:17:26 +0800
Message-Id: <20230615101727.946446-4-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230615101727.946446-1-guoxuenan@huawei.com>
References: <20230615101727.946446-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BqC_BwDXvYc55YpkT63TCA--.7908S5
X-Coremail-Antispam: 1UD129KBjvAXoW3uFWkAw1UXFy8WFy8CrWDCFg_yoW8GFyDto
	WUJa15Gr45GrWUJF1kCr10qw43Zw4Uu3WxAF4DJws093ZrXr1Ykry7Gw1YgFyfXr4Ygryk
	Ka4kAa4kJr4qqw18n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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
compessor code to make adding a new algothrim easier.

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
---
 dump/main.c              |  2 +
 fsck/main.c              |  2 +
 include/erofs/compress.h |  4 +-
 lib/compress.c           | 87 +++++++++++++++++-----------------------
 lib/compressor.c         | 76 +++++++++++++++++------------------
 lib/compressor.h         | 13 ++----
 lib/compressor_liblzma.c |  4 --
 lib/compressor_lz4.c     |  2 -
 lib/compressor_lz4hc.c   |  3 --
 mkfs/main.c              |  3 +-
 10 files changed, 83 insertions(+), 113 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index ae1ffa0..758e14a 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -633,6 +633,7 @@ int main(int argc, char **argv)
 	int err;
 
 	erofs_init_configure();
+	erofs_register_compressors();
 	err = erofsdump_parse_options_cfg(argc, argv);
 	if (err) {
 		if (err == -EINVAL)
@@ -677,5 +678,6 @@ exit_dev_close:
 exit:
 	blob_closeall();
 	erofs_exit_configure();
+	erofs_unregister_compressors();
 	return err;
 }
diff --git a/fsck/main.c b/fsck/main.c
index e559050..03f26a1 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -790,6 +790,7 @@ int main(int argc, char *argv[])
 	int err;
 
 	erofs_init_configure();
+	erofs_register_compressors();
 
 	fsckcfg.physical_blocks = 0;
 	fsckcfg.logical_blocks = 0;
@@ -870,6 +871,7 @@ exit_dev_close:
 exit:
 	blob_closeall();
 	erofs_exit_configure();
+	erofs_unregister_compressors();
 	return err ? 1 : 0;
 }
 
diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index f1b9bbd..9e0f5ed 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -20,10 +20,10 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
 int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
 
 int z_erofs_compress_init(struct erofs_buffer_head *bh);
-int z_erofs_compress_exit(void);
-
 void erofs_print_available_compressors(FILE *f);
 void erofs_print_supported_compressors(FILE *f, unsigned int mask);
+void erofs_register_compressors(void);
+void erofs_unregister_compressors(void);
 
 static inline bool erofs_is_packed_inode(struct erofs_inode *inode)
 {
diff --git a/lib/compress.c b/lib/compress.c
index 14d228f..60dc3e4 100644
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
+			ccfg_idx = rand() % erofs_ccfg.erofs_ccfg_num;
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
@@ -1085,29 +1070,42 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 
 int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 {
-	int i, ret;
+	int i, k, ret;
 
+	/* enable all compressors for mkfs.erofs */
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
 
+	if (sbi.available_compr_algs & 1 << Z_EROFS_COMPRESSION_LZMA) {
+		erofs_warn("EXPERIMENTAL MicroLZMA feature in use. Use at your own risk!");
+		erofs_warn("Note that it may take more time since the compressor is still single-threaded for now.");
+	}
+
 	/*
 	 * if primary algorithm is empty (e.g. compression off),
 	 * clear 0PADDING feature for old kernel compatibility.
@@ -1138,20 +1136,7 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
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
index da8d1b9..c0e8c51 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -20,8 +20,13 @@ static struct erofs_supported_algothrim {
 	{ Z_EROFS_COMPRESSION_LZMA, "lzma"},
 };
 
+/* list of compression algorithms */
+extern const struct erofs_compressor erofs_compressor_lz4;
+extern const struct erofs_compressor erofs_compressor_lz4hc;
+extern const struct erofs_compressor erofs_compressor_lzma;
+
 /* global compressors configuration */
-static struct erofs_compressors_cfg erofs_ccfg;
+struct erofs_compressors_cfg erofs_ccfg;
 
 static void erofs_init_compressor(struct compressor *compressor,
 	const struct erofs_compressor *alg)
@@ -78,6 +83,36 @@ void erofs_register_compressors(void)
 #endif
 }
 
+int erofs_get_compressor_by_name(const char *name)
+{
+	int i;
+
+	for (i = 0; i < erofs_ccfg.erofs_ccfg_num; i++) {
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
+void erofs_unregister_compressors(void)
+{
+	int i;
+
+	for (i = 0; i < erofs_ccfg.erofs_ccfg_num; ++i) {
+		erofs_compressor_unregister(&erofs_ccfg.compressors[i].handle);
+	}
+}
+
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize, bool inblocks)
@@ -152,42 +187,3 @@ int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level)
 	c->compression_level = 0;
 	return 0;
 }
-
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
-	for (i = 0; i < erofs_ccfg.erofs_ccfg_num; ++i) {
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
diff --git a/lib/compressor.h b/lib/compressor.h
index 1e760b6..b7d052c 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -13,8 +13,6 @@
 struct erofs_compress;
 
 struct erofs_compressor {
-	const char *name;
-
 	int default_level;
 	int best_level;
 
@@ -52,19 +50,14 @@ struct erofs_compressors_cfg {
 	struct compressor compressors[EROFS_MAX_COMPR_CFGS];
 	int erofs_ccfg_num;
 };
-
-/* list of compression algorithms */
-extern const struct erofs_compressor erofs_compressor_lz4;
-extern const struct erofs_compressor erofs_compressor_lz4hc;
-extern const struct erofs_compressor erofs_compressor_lzma;
+/* global compressors config */
+extern struct erofs_compressors_cfg erofs_ccfg;
 
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize, bool inblocks);
 
 int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level);
-int erofs_compressor_init(struct erofs_compress *c, char *alg_name);
-int erofs_compressor_exit(struct erofs_compress *c);
-void erofs_register_compressors(void);
+int erofs_get_compressor_by_name(const char *name);
 
 #endif
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index f274dce..5b4e83e 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -88,19 +88,15 @@ static int erofs_compressor_liblzma_init(struct erofs_compress *c)
 {
 	struct erofs_liblzma_context *ctx;
 
-	c->alg = &erofs_compressor_lzma;
 	ctx = malloc(sizeof(*ctx));
 	if (!ctx)
 		return -ENOMEM;
 	ctx->strm = (lzma_stream)LZMA_STREAM_INIT;
 	c->private_data = ctx;
-	erofs_warn("EXPERIMENTAL MicroLZMA feature in use. Use at your own risk!");
-	erofs_warn("Note that it may take more time since the compressor is still single-threaded for now.");
 	return 0;
 }
 
 const struct erofs_compressor erofs_compressor_lzma = {
-	.name = "lzma",
 	.default_level = LZMA_PRESET_DEFAULT,
 	.best_level = 109,
 	.init = erofs_compressor_liblzma_init,
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index b6f6e7e..1182869 100644
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
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index eec1c84..81b91d6 100644
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
index 9433a75..5f8c720 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -717,6 +717,7 @@ int main(int argc, char **argv)
 
 	erofs_init_configure();
 	erofs_mkfs_default_options();
+	erofs_register_compressors();
 
 	err = mkfs_parse_options_cfg(argc, argv);
 	erofs_show_progs(argc, argv);
@@ -916,7 +917,7 @@ int main(int argc, char **argv)
 	if (!err && erofs_sb_has_sb_chksum())
 		err = erofs_mkfs_superblock_csum_set();
 exit:
-	z_erofs_compress_exit();
+	erofs_unregister_compressors();
 	z_erofs_dedupe_exit();
 #ifdef WITH_ANDROID
 	erofs_droid_blocklist_fclose();
-- 
2.31.1

