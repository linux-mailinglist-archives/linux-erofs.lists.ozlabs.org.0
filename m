Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90404406DC
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Oct 2021 04:01:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hh2bV5RS1z3bXR
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Oct 2021 13:01:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Wub9UPAB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Wub9UPAB; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hh2bR5FHhz304y
 for <linux-erofs@lists.ozlabs.org>; Sat, 30 Oct 2021 13:01:39 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BE146115B;
 Sat, 30 Oct 2021 02:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635559297;
 bh=brrCMlV0dR2WbgTUVmdEjDVsdq0pLovzPciahRjf4+0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Wub9UPABKVVrZ9XF3EKMBpB5koAL/cITBG6FziHJiah5EqHuRdohPXy/hym+goN3c
 vZHFgEF1yT9mEpcBvKB7az30JdlgjT0YPgiLyKQ8rKkQiG1bFvfyZrXNH62ixdiRZw
 D+LFLSlJrXCdeT7N5RtSRMdtFuTGQK0idstpNICLFB2KWnMF1lGjQt9jmxuTec+eBY
 6mOz/UxwTNf4opDq+CYviJsWfE5fJ/8sFPw0g5PLHR5C9ClfYNElFuREPX5MoCB+Ed
 u/p7ad55nOWTNtnpKCgDHw0hi2TgUAr6EwbpZx0OhuSaCNbuxPqDRivPE8XdNIDsa8
 mkvG5Se99L7jw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs-utils: mkfs: add LZMA algorithm support
Date: Sat, 30 Oct 2021 10:01:18 +0800
Message-Id: <20211030020118.13898-3-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211030020118.13898-1-xiang@kernel.org>
References: <20211030020118.13898-1-xiang@kernel.org>
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
Cc: Lasse Collin <lasse.collin@tukaani.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch adds LZMA compression algorithm support to erofs-utils
compression framework with upstream liblzma.

Cc: Lasse Collin <lasse.collin@tukaani.org>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 include/erofs/config.h   |   1 +
 include/erofs_fs.h       |   6 +++
 lib/Makefile.am          |   3 ++
 lib/compress.c           |  37 ++++++++++++--
 lib/compressor.c         |   3 ++
 lib/compressor.h         |   1 +
 lib/compressor_liblzma.c | 105 +++++++++++++++++++++++++++++++++++++++
 mkfs/main.c              |   1 -
 8 files changed, 152 insertions(+), 5 deletions(-)
 create mode 100644 lib/compressor_liblzma.c

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 574dd52be12d..a18c88301279 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -60,6 +60,7 @@ struct erofs_configure {
 
 	u32 c_pclusterblks_max, c_pclusterblks_def;
 	u32 c_max_decompressed_extent_bytes;
+	u32 c_dict_size;
 	u64 c_unix_timestamp;
 	u32 c_uid, c_gid;
 #ifdef WITH_ANDROID
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 86ad6f5fd86c..4291970753a8 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -261,6 +261,12 @@ struct z_erofs_lz4_cfgs {
 	u8 reserved[10];
 } __packed;
 
+/* 14 bytes (+ length field = 16 bytes) */
+struct z_erofs_lzma_cfgs {
+	__le32 dict_size;
+	__le16 format;
+	u8 reserved[8];
+} __packed;
 #define Z_EROFS_LZMA_MAX_DICT_SIZE	(8 * Z_EROFS_PCLUSTER_MAX_SIZE)
 
 /*
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 370de844146f..58ad192c51b3 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -31,4 +31,7 @@ if ENABLE_LZ4HC
 liberofs_la_SOURCES += compressor_lz4hc.c
 endif
 endif
+if ENABLE_LIBLZMA
 liberofs_la_CFLAGS += ${liblzma_CFLAGS}
+liberofs_la_SOURCES += compressor_liblzma.c
+endif
diff --git a/lib/compress.c b/lib/compress.c
index 6ca5bedaf596..98be7a26383b 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -588,6 +588,8 @@ static int erofs_get_compress_algorithm_id(const char *name)
 {
 	if (!strcmp(name, "lz4") || !strcmp(name, "lz4hc"))
 		return Z_EROFS_COMPRESSION_LZ4;
+	if (!strcmp(name, "lzma"))
+		return Z_EROFS_COMPRESSION_LZMA;
 	return -ENOTSUP;
 }
 
@@ -619,6 +621,29 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 				sizeof(lz4alg));
 		bh->op = &erofs_drop_directly_bhops;
 	}
+#ifdef HAVE_LIBLZMA
+	if (sbi.available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZMA)) {
+		struct {
+			__le16 size;
+			struct z_erofs_lzma_cfgs lzma;
+		} __packed lzmaalg = {
+			.size = cpu_to_le16(sizeof(struct z_erofs_lzma_cfgs)),
+			.lzma = {
+				.dict_size = cpu_to_le32(cfg.c_dict_size),
+			}
+		};
+
+		bh = erofs_battach(bh, META, sizeof(lzmaalg));
+		if (IS_ERR(bh)) {
+			DBG_BUGON(1);
+			return PTR_ERR(bh);
+		}
+		erofs_mapbh(bh->block);
+		ret = dev_write(&lzmaalg, erofs_btell(bh, false),
+				sizeof(lzmaalg));
+		bh->op = &erofs_drop_directly_bhops;
+	}
+#endif
 	return ret;
 }
 
@@ -632,17 +657,18 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 		return ret;
 
 	/*
-	 * if primary algorithm is not lz4* (e.g. compression off),
-	 * clear LZ4_0PADDING feature for old kernel compatibility.
+	 * if primary algorithm is empty (e.g. compression off),
+	 * clear 0PADDING feature for old kernel compatibility.
 	 */
 	if (!cfg.c_compr_alg_master ||
-	    strncmp(cfg.c_compr_alg_master, "lz4", 3))
+	    (cfg.c_legacy_compress && !strcmp(cfg.c_compr_alg_master, "lz4")))
 		erofs_sb_clear_lz4_0padding();
 
 	if (!cfg.c_compr_alg_master)
 		return 0;
 
-	ret = erofs_compressor_setlevel(&compresshandle, cfg.c_compr_level_master);
+	ret = erofs_compressor_setlevel(&compresshandle,
+					cfg.c_compr_level_master);
 	if (ret)
 		return ret;
 
@@ -668,6 +694,9 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 		erofs_warn("EXPERIMENTAL big pcluster feature in use. Use at your own risk!");
 	}
 
+	if (ret != Z_EROFS_COMPRESSION_LZ4)
+		erofs_sb_set_compr_cfgs();
+
 	if (erofs_sb_has_compr_cfgs()) {
 		sbi.available_compr_algs |= 1 << ret;
 		return z_erofs_build_compr_cfgs(sb_bh);
diff --git a/lib/compressor.c b/lib/compressor.c
index 89c1be10dd0c..ad12cdf2ceed 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -17,6 +17,9 @@ static struct erofs_compressor *compressors[] = {
 #endif
 		&erofs_compressor_lz4,
 #endif
+#if HAVE_LIBLZMA
+		&erofs_compressor_lzma,
+#endif
 };
 
 int erofs_compress_destsize(struct erofs_compress *c,
diff --git a/lib/compressor.h b/lib/compressor.h
index d1b43c87291f..aa85ae0bdc2f 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -43,6 +43,7 @@ struct erofs_compress {
 /* list of compression algorithms */
 extern struct erofs_compressor erofs_compressor_lz4;
 extern struct erofs_compressor erofs_compressor_lz4hc;
+extern struct erofs_compressor erofs_compressor_lzma;
 
 int erofs_compress_destsize(struct erofs_compress *c,
 			    void *src, unsigned int *srcsize,
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
new file mode 100644
index 000000000000..e9bfcc556c54
--- /dev/null
+++ b/lib/compressor_liblzma.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/compressor_liblzma.c
+ *
+ * Copyright (C) 2021 Gao Xiang <xiang@kernel.org>
+ */
+#include <stdlib.h>
+#include <lzma.h>
+#include "erofs/config.h"
+#include "erofs/print.h"
+#include "erofs/internal.h"
+#include "compressor.h"
+
+struct erofs_liblzma_context {
+	lzma_options_lzma opt;
+	lzma_stream strm;
+};
+
+static int erofs_liblzma_compress_destsize(struct erofs_compress *c,
+					   void *src, unsigned int *srcsize,
+					   void *dst, unsigned int dstsize)
+{
+	struct erofs_liblzma_context *ctx = c->private_data;
+	lzma_stream *strm = &ctx->strm;
+
+	lzma_ret ret = lzma_microlzma_encoder(strm, &ctx->opt);
+	if (ret != LZMA_OK)
+		return -EFAULT;
+
+	strm->next_in = src;
+	strm->avail_in = *srcsize;
+	strm->next_out = dst;
+	strm->avail_out = dstsize;
+
+	ret = lzma_code(strm, LZMA_FINISH);
+	if (ret != LZMA_STREAM_END)
+		return -EBADMSG;
+
+	*srcsize = strm->total_in;
+	return strm->total_out;
+}
+
+static int erofs_compressor_liblzma_exit(struct erofs_compress *c)
+{
+	struct erofs_liblzma_context *ctx = c->private_data;
+
+	if (!ctx)
+		return -EINVAL;
+
+	lzma_end(&ctx->strm);
+	free(ctx);
+	return 0;
+}
+
+static int erofs_compressor_liblzma_setlevel(struct erofs_compress *c,
+					     int compression_level)
+{
+	struct erofs_liblzma_context *ctx = c->private_data;
+
+	if (compression_level < 0)
+		compression_level = LZMA_PRESET_DEFAULT;
+
+	if (lzma_lzma_preset(&ctx->opt, compression_level))
+		return -EINVAL;
+
+	/* XXX: temporary hack */
+	if (cfg.c_dict_size) {
+		if (cfg.c_dict_size > Z_EROFS_LZMA_MAX_DICT_SIZE) {
+			erofs_err("dict size %u is too large", cfg.c_dict_size);
+			return -EINVAL;
+		}
+		ctx->opt.dict_size = cfg.c_dict_size;
+	} else {
+		if (ctx->opt.dict_size > Z_EROFS_LZMA_MAX_DICT_SIZE)
+			ctx->opt.dict_size = Z_EROFS_LZMA_MAX_DICT_SIZE;
+		cfg.c_dict_size = ctx->opt.dict_size;
+	}
+	c->compression_level = compression_level;
+	return 0;
+}
+
+static int erofs_compressor_liblzma_init(struct erofs_compress *c)
+{
+	struct erofs_liblzma_context *ctx;
+
+	c->alg = &erofs_compressor_lzma;
+	ctx = malloc(sizeof(*ctx));
+	if (!ctx)
+		return -ENOMEM;
+	ctx->strm = (lzma_stream)LZMA_STREAM_INIT;
+	c->private_data = ctx;
+	erofs_warn("EXPERIMENTAL MicroLZMA feature in use. Use at your own risk!");
+	erofs_warn("Note that it may take more time since the compressor is still single-threaded for now.");
+	return 0;
+}
+
+struct erofs_compressor erofs_compressor_lzma = {
+	.name = "lzma",
+	.default_level = LZMA_PRESET_DEFAULT,
+	.best_level = LZMA_PRESET_EXTREME,
+	.init = erofs_compressor_liblzma_init,
+	.exit = erofs_compressor_liblzma_exit,
+	.setlevel = erofs_compressor_liblzma_setlevel,
+	.compress_destsize = erofs_liblzma_compress_destsize,
+};
diff --git a/mkfs/main.c b/mkfs/main.c
index 055d077988e9..028cf5a8911c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -147,7 +147,6 @@ static int parse_extended_opts(const char *opts)
 				return -EINVAL;
 			/* disable compacted indexes and 0padding */
 			cfg.c_legacy_compress = true;
-			erofs_sb_clear_lz4_0padding();
 		}
 
 		if (MATCH_EXTENTED_OPT("force-inode-compact", token, keylen)) {
-- 
2.20.1

