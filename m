Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3401775DD2A
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 17:21:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690039269;
	bh=1HAR5WURll2KrctUQLqMQAZKai+BPh46aDKCgIb82Fc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=PPYVSiOAteoEpbXFUI8xVYVH2P6v/bEGqfUP0q4XgUmmk28CLM3QImLIXv2JJXo9r
	 XHS7ApQECr2PragKZjaG3IsDd0JtdP1MqrPwMyZXa47gbAnp29zTxoP+isfdKKyIu4
	 ezIWcU+9TwdMDI2TqY9JmVROpeG090Bg/3oVm39tBJtRrFF0QszhxpNrgruhvRqCrx
	 X1TFFZdrcBg1fydW1tXiHjmzWpryirzqjOagXkWwjzgoQn68Ak5xrBjZJHS8eteh6i
	 ilXHf2BeUDrwp7ChZPmguayFpNgNuVKvJraeAtt4AkWS7gqYStJmI+XnlaaP+D8TmA
	 Xxww49AWJq7FQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R7VW92BtPz3bnB
	for <lists+linux-erofs@lfdr.de>; Sun, 23 Jul 2023 01:21:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.154; helo=frasgout12.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R7VVv5Tlpz2ynD
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Jul 2023 01:20:53 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4R7TsC5tN8z9yFhp
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Jul 2023 22:51:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
	by APP2 (Coremail) with SMTP id BqC_BwCXnVcE8LtkMMq2Cg--.24810S5;
	Sat, 22 Jul 2023 15:04:47 +0000 (GMT)
To: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/4] erofs-utils: simplify erofs compressor init and exit
Date: Sat, 22 Jul 2023 23:04:33 +0800
Message-Id: <20230722150434.2921381-4-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230722150434.2921381-1-guoxuenan@huawei.com>
References: <20230722150434.2921381-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BqC_BwCXnVcE8LtkMMq2Cg--.24810S5
X-Coremail-Antispam: 1UD129KBjvAXoWfZrWxuw4rGw4rCFWxKr1ftFb_yoW8tr1fWo
	W8Ja15Gr4rGryUJFykKr10gw43ZF1Uu3W7Cr4DGwn093ZFqr1YkrW7Gw1Y9FyfXr4YgrWk
	Ka4kAa4kJr4DXw1xn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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
 dump/main.c                 |   2 +
 fsck/main.c                 |   2 +
 include/erofs/compress.h    |   3 +-
 lib/compress.c              | 114 ++++++++++++------------
 lib/compressor.c            | 171 ++++++++++++++----------------------
 lib/compressor.h            |  21 +++--
 lib/compressor_deflate.c    |   7 +-
 lib/compressor_libdeflate.c |   2 -
 lib/compressor_liblzma.c    |   4 -
 lib/compressor_lz4.c        |   1 -
 lib/compressor_lz4hc.c      |   3 -
 mkfs/main.c                 |   3 +-
 12 files changed, 137 insertions(+), 196 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 409c851..0bbb57d 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -629,6 +629,7 @@ int main(int argc, char **argv)
 	int err;
 
 	erofs_init_configure();
+	erofs_register_compressors();
 	err = erofsdump_parse_options_cfg(argc, argv);
 	if (err) {
 		if (err == -EINVAL)
@@ -673,5 +674,6 @@ exit_dev_close:
 exit:
 	blob_closeall(&sbi);
 	erofs_exit_configure();
+	erofs_unregister_compressors();
 	return err;
 }
diff --git a/fsck/main.c b/fsck/main.c
index 6e0dcb5..dcf9420 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -883,6 +883,7 @@ int main(int argc, char *argv[])
 	int err;
 
 	erofs_init_configure();
+	erofs_register_compressors();
 
 	fsckcfg.physical_blocks = 0;
 	fsckcfg.logical_blocks = 0;
@@ -969,6 +970,7 @@ exit_dev_close:
 exit:
 	blob_closeall(&sbi);
 	erofs_exit_configure();
+	erofs_unregister_compressors();
 	return err ? 1 : 0;
 }
 
diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 67bedf2..d98b8dd 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -21,10 +21,11 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
 
 int z_erofs_compress_init(struct erofs_sb_info *sbi,
 			  struct erofs_buffer_head *bh);
-int z_erofs_compress_exit(void);
 
 void erofs_print_available_compressors(FILE *f);
 void erofs_print_supported_compressors(FILE *f, unsigned int mask);
+void erofs_register_compressors(void);
+void erofs_unregister_compressors(void);
 
 static inline bool erofs_is_packed_inode(struct erofs_inode *inode)
 {
diff --git a/lib/compress.c b/lib/compress.c
index b43b077..9ce5aeb 100644
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
+	struct erofs_compress *handle;
 
 	u8 *metacur;
 	unsigned int head, tail;
@@ -385,7 +378,7 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 	struct erofs_inode *inode = ctx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
 	char *const dst = dstbuf + erofs_blksiz(sbi);
-	struct erofs_compress *const h = &ctx->ccfg->handle;
+	struct erofs_compress *const h = ctx->handle;
 	unsigned int len = ctx->tail - ctx->head;
 	bool is_packed_inode = erofs_is_packed_inode(inode);
 	bool final = !ctx->remaining;
@@ -849,6 +842,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	static struct z_erofs_vle_compress_ctx ctx;
 	erofs_blk_t blkaddr, compressed_blocks;
 	unsigned int legacymetasize;
+	struct erofs_supported_algorithm *curalg;
 	int ret;
 	struct erofs_sb_info *sbi = inode->sbi;
 	u8 *compressmeta = malloc(BLK_ROUND_UP(sbi, inode->i_size) *
@@ -884,18 +878,9 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	if (cfg.c_fragments && !cfg.c_dedupe)
 		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 
-#ifndef NDEBUG
-	if (cfg.c_random_algorithms) {
-		while (1) {
-			inode->z_algorithmtype[0] =
-				rand() % EROFS_MAX_COMPR_CFGS;
-			if (erofs_ccfg[inode->z_algorithmtype[0]].enable)
-				break;
-		}
-	}
-#endif
-	ctx.ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
-	inode->z_algorithmtype[0] = ctx.ccfg[0].algorithmtype;
+	curalg = erofs_get_compress_algorithm(cfg.c_compr_alg[0], true);
+	ctx.handle = &curalg->handle;
+	inode->z_algorithmtype[0] = curalg->algtype;
 	inode->z_algorithmtype[1] = 0;
 
 	inode->idata_size = 0;
@@ -1030,17 +1015,6 @@ err_free_meta:
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
@@ -1122,27 +1096,60 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 {
 	int i, ret;
 
+	/* enable all compressors for mkfs.erofs */
 	for (i = 0; cfg.c_compr_alg[i]; ++i) {
-		ret = erofs_compressor_init(sbi, &erofs_ccfg[i].handle,
-					     cfg.c_compr_alg[i]);
-		if (ret)
-			return ret;
+		struct erofs_supported_algorithm *curalg;
+		int compression_level = cfg.c_compr_level[i];
 
-		ret = erofs_compressor_setlevel(&erofs_ccfg[i].handle,
-						cfg.c_compr_level[i]);
-		if (ret)
-			return ret;
+		ret = 0;
+		curalg = erofs_get_compress_algorithm(cfg.c_compr_alg[i], false);
 
-		ret = erofs_get_compress_algorithm_id(cfg.c_compr_alg[i]);
-		if (ret < 0)
-			return ret;
-		erofs_ccfg[i].algorithmtype = ret;
-		erofs_ccfg[i].enable = true;
-		sbi->available_compr_algs |= 1 << ret;
-		if (ret != Z_EROFS_COMPRESSION_LZ4)
+		if (!curalg || !curalg->handle.alg) {
+			erofs_err("compressor %s not available!", cfg.c_compr_alg[i]);
+			return -EINVAL;
+		}
+
+		/* erofs compressor set level */
+		if (curalg->handle.alg->setlevel)
+			ret = curalg->handle.alg->setlevel(&curalg->handle, compression_level);
+		else if (compression_level >= 0)
+			ret = -EINVAL;
+		curalg->handle.compression_level = 0;
+		if (ret) {
+			erofs_err("compressor %s invalid compress level %d!",
+					cfg.c_compr_alg[i], cfg.c_compr_level[i]);
+			return -EINVAL;
+		}
+
+		/* should be written in "minimum compression ratio * 100" */
+		curalg->handle.compress_threshold = 100;
+
+		/* optimize for 4k size page */
+		curalg->handle.destsize_alignsize = erofs_blksiz(sbi);
+		curalg->handle.destsize_redzone_begin = erofs_blksiz(sbi) - 16;
+		curalg->handle.destsize_redzone_end = EROFS_CONFIG_COMPR_DEF_BOUNDARY;
+
+		/* now enable current compressor */
+		curalg->enable = true;
+		sbi->available_compr_algs |= 1 << curalg->algtype;
+		if (curalg->algtype != Z_EROFS_COMPRESSION_LZ4) {
 			erofs_sb_set_compr_cfgs(sbi);
+		}
+
+	}
+
+	if (sbi->available_compr_algs & 1 << Z_EROFS_COMPRESSION_LZMA) {
+        erofs_warn("EXPERIMENTAL MicroLZMA feature in use. Use at your own risk!");
+        erofs_warn("Note that it may take more time since the compressor is still single-threaded for now.");
+	}
+
+	if (sbi->available_compr_algs & 1 << Z_EROFS_COMPRESSION_DEFLATE) {
+		erofs_warn("EXPERIMENTAL DEFLATE algorithm in use. Use at your own risk!");
+		erofs_warn("*Carefully* check filesystem data correctness to avoid corruption!");
+		erofs_warn("Please send a report to <linux-erofs@lists.ozlabs.org> if something is wrong.");
 	}
 
+
 	/*
 	 * if primary algorithm is empty (e.g. compression off),
 	 * clear 0PADDING feature for old kernel compatibility.
@@ -1173,20 +1180,7 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	}
 
 	if (erofs_sb_has_compr_cfgs(sbi)) {
-		sbi->available_compr_algs |= 1 << ret;
 		return z_erofs_build_compr_cfgs(sbi, sb_bh);
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
index 2cc2464..03b55a6 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -4,34 +4,19 @@
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
+#include <stdlib.h>
 #include "erofs/internal.h"
 #include "compressor.h"
 #include "erofs/print.h"
 
-#define EROFS_CONFIG_COMPR_DEF_BOUNDARY		(128)
+/* list of compression algorithms */
+extern const struct erofs_compressor erofs_compressor_lz4;
+extern const struct erofs_compressor erofs_compressor_lz4hc;
+extern const struct erofs_compressor erofs_compressor_lzma;
+extern const struct erofs_compressor erofs_compressor_libdeflate;
+extern const struct erofs_compressor erofs_compressor_deflate;
 
-static const struct erofs_compressor *compressors[] = {
-#if LZ4_ENABLED
-#if LZ4HC_ENABLED
-		&erofs_compressor_lz4hc,
-#endif
-		&erofs_compressor_lz4,
-#endif
-#if HAVE_LIBLZMA
-		&erofs_compressor_lzma,
-#endif
-		&erofs_compressor_deflate,
-#if HAVE_LIBDEFLATE
-		&erofs_compressor_libdeflate,
-#endif
-};
-
-static struct erofs_supported_algorithm {
-	bool enable;
-	unsigned int algtype;
-	const char *name;
-	struct erofs_compress handle;
-} erofs_supported_algorithms[] = {
+static struct erofs_supported_algorithm  erofs_supported_algs[] = {
 	{ .algtype = Z_EROFS_COMPRESSION_LZ4, .name = "lz4" },
 	{ .algtype = Z_EROFS_COMPRESSION_LZ4, .name = "lz4hc" },
 	{ .algtype = Z_EROFS_COMPRESSION_LZMA, .name = "lzma" },
@@ -39,56 +24,82 @@ static struct erofs_supported_algorithm {
 	{ .algtype = Z_EROFS_COMPRESSION_DEFLATE, .name = "libdeflate" },
 };
 
-static void erofs_init_compressor(struct erofs_sb_info *sbi,
-		struct erofs_compress *handle, const struct erofs_compressor *alg)
+static void erofs_init_compressor(struct erofs_compress *handle,
+	const struct erofs_compressor *alg)
 {
-
-	handle->alg = alg;
-
-	/* should be written in "minimum compression ratio * 100" */
-	handle->compress_threshold = 100;
-
-	/* optimize for 4k size page */
-	handle->destsize_alignsize = erofs_blksiz(sbi);
-	handle->destsize_redzone_begin = erofs_blksiz(sbi) - 16;
-	handle->destsize_redzone_end = EROFS_CONFIG_COMPR_DEF_BOUNDARY;
-
 	if (alg && alg->init)
 		alg->init(handle);
 }
 
-static void erofs_compressor_register(struct erofs_sb_info *sbi,
-		const char *name, const struct erofs_compressor *alg)
+static void erofs_compressor_register(const char *name,
+	const struct erofs_compressor *alg)
 {
 	struct erofs_supported_algorithm *cur;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(erofs_supported_algorithms); i++) {
-		cur = &erofs_supported_algorithms[i];
+	for (i = 0; i < ARRAY_SIZE(erofs_supported_algs); i++) {
+		cur = &erofs_supported_algs[i];
 		if (!strcmp(cur->name, name)) {
-			erofs_init_compressor(sbi, &cur->handle, alg);
+			erofs_init_compressor(&cur->handle, alg);
 			return;
 		}
 	}
 }
 
-void erofs_register_compressors(struct erofs_sb_info *sbi)
+struct erofs_supported_algorithm
+*erofs_get_compress_algorithm(const char *name, bool random)
+{
+	unsigned int algnum = ARRAY_SIZE(erofs_supported_algs);
+	int i;
+
+#ifndef NDEBUG
+	if (cfg.c_random_algorithms && random) {
+		while (1) {
+			i = rand() % algnum;
+			if (erofs_supported_algs[i].enable)
+				return &erofs_supported_algs[i];
+		}
+	}
+#endif
+
+	for (i = 0; i < algnum; i++) {
+		if (!strcmp(erofs_supported_algs[i].name, name))
+			return &erofs_supported_algs[i];
+	}
+	return NULL;
+}
+
+void erofs_register_compressors(void)
 {
 #if LZ4_ENABLED
-	erofs_compressor_register(sbi, "lz4", &erofs_compressor_lz4);
+	erofs_compressor_register("lz4", &erofs_compressor_lz4);
 #if LZ4HC_ENABLED
-	erofs_compressor_register(sbi, "lz4hc", &erofs_compressor_lz4hc);
+	erofs_compressor_register("lz4hc", &erofs_compressor_lz4hc);
 #endif
 #endif
 #if HAVE_LIBLZMA
-	erofs_compressor_register(sbi, "lzma", &erofs_compressor_lzma);
+	erofs_compressor_register("lzma", &erofs_compressor_lzma);
 #endif
-	erofs_compressor_register(sbi, "deflate", &erofs_compressor_deflate);
+	erofs_compressor_register("deflate", &erofs_compressor_deflate);
 #if HAVE_LIBDEFLATE
-	erofs_compressor_register(sbi, "libdeflate", &erofs_compressor_libdeflate);
+	erofs_compressor_register("libdeflate", &erofs_compressor_libdeflate);
 #endif
 }
 
+void erofs_unregister_compressors(void)
+{
+	struct erofs_compress *handle;
+	unsigned int algnum = ARRAY_SIZE(erofs_supported_algs);
+	int i;
+
+	for (i = 0; i < algnum; ++i) {
+		handle = &erofs_supported_algs[i].handle;
+		if (handle->alg && handle->alg->exit)
+			handle->alg->exit(handle);
+		handle->alg = NULL;
+	}
+}
+
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize, bool inblocks)
@@ -120,14 +131,14 @@ int erofs_compress_destsize(const struct erofs_compress *c,
 
 void erofs_print_supported_compressors(FILE *f, unsigned int mask)
 {
-	unsigned int algnum = ARRAY_SIZE(erofs_supported_algorithms);
+	unsigned int algnum = ARRAY_SIZE(erofs_supported_algs);
 	unsigned int i = 0;
 	int comma = false;
 	const char *s;
 
 	while (i < algnum) {
-		s = erofs_supported_algorithms[i].name;
-		if (s && (mask & (1 << erofs_supported_algorithms[i++].algtype))) {
+		s = erofs_supported_algs[i].name;
+		if (s && (mask & (1 << erofs_supported_algs[i++].algtype))) {
 			if (comma)
 				fputs(", ", f);
 			else
@@ -140,70 +151,16 @@ void erofs_print_supported_compressors(FILE *f, unsigned int mask)
 
 void erofs_print_available_compressors(FILE *f)
 {
-	unsigned int algnum = ARRAY_SIZE(erofs_supported_algorithms);
+	unsigned int algnum = ARRAY_SIZE(erofs_supported_algs);
 	unsigned int i = 0;
 	const char *s;
 
 	while (i < algnum &&
-			erofs_supported_algorithms[i].handle.alg &&
-			(s = erofs_supported_algorithms[i].name)) {
+			erofs_supported_algs[i].handle.alg &&
+			(s = erofs_supported_algs[i].name)) {
 		if (i++)
 			fputs(", ", f);
 		fputs(s, f);
 	}
 	fputc('\n', f);
 }
-
-int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level)
-{
-	DBG_BUGON(!c->alg);
-	if (c->alg->setlevel)
-		return c->alg->setlevel(c, compression_level);
-
-	if (compression_level >= 0)
-		return -EINVAL;
-	c->compression_level = 0;
-	return 0;
-}
-
-int erofs_compressor_init(struct erofs_sb_info *sbi,
-			  struct erofs_compress *c, char *alg_name)
-{
-	int ret, i;
-
-	c->sbi = sbi;
-
-	/* should be written in "minimum compression ratio * 100" */
-	c->compress_threshold = 100;
-
-	/* optimize for 4k size page */
-	c->destsize_alignsize = erofs_blksiz(sbi);
-	c->destsize_redzone_begin = erofs_blksiz(sbi) - 16;
-	c->destsize_redzone_end = EROFS_CONFIG_COMPR_DEF_BOUNDARY;
-
-	if (!alg_name) {
-		c->alg = NULL;
-		return 0;
-	}
-
-	ret = -EINVAL;
-	for (i = 0; i < ARRAY_SIZE(compressors); ++i) {
-		if (alg_name && strcmp(alg_name, compressors[i]->name))
-			continue;
-
-		ret = compressors[i]->init(c);
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
index 66ea933..943fba6 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -10,6 +10,8 @@
 #include "erofs/defs.h"
 #include "erofs/config.h"
 
+#define EROFS_CONFIG_COMPR_DEF_BOUNDARY		(128)
+
 struct erofs_compress;
 
 struct erofs_compressor {
@@ -42,21 +44,18 @@ struct erofs_compress {
 	void *private_data;
 };
 
-/* list of compression algorithms */
-extern const struct erofs_compressor erofs_compressor_lz4;
-extern const struct erofs_compressor erofs_compressor_lz4hc;
-extern const struct erofs_compressor erofs_compressor_lzma;
-extern const struct erofs_compressor erofs_compressor_deflate;
-extern const struct erofs_compressor erofs_compressor_libdeflate;
+struct erofs_supported_algorithm {
+	bool enable;
+	unsigned int algtype;
+	const char *name;
+	struct erofs_compress handle;
+};
 
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize, bool inblocks);
-
 int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level);
-int erofs_compressor_init(struct erofs_sb_info *sbi,
-		struct erofs_compress *c, char *alg_name);
-int erofs_compressor_exit(struct erofs_compress *c);
-void erofs_register_compressors(struct erofs_sb_info *sbi);
+struct erofs_supported_algorithm
+*erofs_get_compress_algorithm(const char *name, bool random);
 
 #endif
diff --git a/lib/compressor_deflate.c b/lib/compressor_deflate.c
index 5a7a657..9bfd17c 100644
--- a/lib/compressor_deflate.c
+++ b/lib/compressor_deflate.c
@@ -36,12 +36,8 @@ static int compressor_deflate_exit(struct erofs_compress *c)
 
 static int compressor_deflate_init(struct erofs_compress *c)
 {
-	c->alg = &erofs_compressor_deflate;
 	c->private_data = NULL;
 
-	erofs_warn("EXPERIMENTAL DEFLATE algorithm in use. Use at your own risk!");
-	erofs_warn("*Carefully* check filesystem data correctness to avoid corruption!");
-	erofs_warn("Please send a report to <linux-erofs@lists.ozlabs.org> if something is wrong.");
 	return 0;
 }
 
@@ -56,7 +52,7 @@ static int erofs_compressor_deflate_setlevel(struct erofs_compress *c,
 	}
 
 	if (compression_level < 0)
-		compression_level = erofs_compressor_deflate.default_level;
+		compression_level = c->alg->default_level;
 
 	s = kite_deflate_init(compression_level, cfg.c_dict_size);
 	if (IS_ERR(s))
@@ -68,7 +64,6 @@ static int erofs_compressor_deflate_setlevel(struct erofs_compress *c,
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
index e507b70..e9d6f71 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -32,7 +32,6 @@ static int compressor_lz4_exit(struct erofs_compress *c)
 
 static int compressor_lz4_init(struct erofs_compress *c)
 {
-	c->alg = &erofs_compressor_lz4;
 	c->sbi->lz4_max_distance = LZ4_DISTANCE_MAX;
 	return 0;
 }
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
index 54e7d99..acefb1d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -726,6 +726,7 @@ int main(int argc, char **argv)
 
 	erofs_init_configure();
 	erofs_mkfs_default_options();
+	erofs_register_compressors();
 
 	err = mkfs_parse_options_cfg(argc, argv);
 	erofs_show_progs(argc, argv);
@@ -965,7 +966,7 @@ int main(int argc, char **argv)
 	if (!err && erofs_sb_has_sb_chksum(&sbi))
 		err = erofs_mkfs_superblock_csum_set();
 exit:
-	z_erofs_compress_exit();
+	erofs_unregister_compressors();
 	z_erofs_dedupe_exit();
 #ifdef WITH_ANDROID
 	erofs_droid_blocklist_fclose();
-- 
2.34.3

