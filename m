Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8388329A7
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jan 2024 13:47:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TGfWm6FBBz3bsd
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jan 2024 23:47:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TGfWc1pdBz3bYc
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jan 2024 23:46:50 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 38AF4100ABF39
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jan 2024 20:46:42 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 1BC22380CE6
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jan 2024 20:46:40 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 0/3] erofs-utils: mkfs: allow to specify dictionary size for compression algorithms
Date: Fri, 19 Jan 2024 20:46:40 +0800
Message-ID: <20240119124640.62685-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106181040.228922-1-zhaoyifan@sjtu.edu.cn>
References: <20240106181040.228922-1-zhaoyifan@sjtu.edu.cn>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patchset allows to specify dictionary size for compression algorithms.

change since v2:
 - does not touch kite_deflate.c
 - does not add unneeded macro definitions unrelated to on-disk format
 - modify the hacky way to get max_dict_size in z_erofs_build_compr_cfgs()
 - some rename, reorganize and code style fix

Yifan Zhao (3):
  erofs-utils: mkfs: merge erofs_compressor_setlevel() into
    erofs_compressor_init()
  erofs-utils: mkfs: allow to specify dictionary size for compression
    algorithms
  erofs-utils: mkfs: reorganize logic in erofs_compressor_init()

 include/erofs/config.h      |  10 ++--
 lib/compress.c              |  37 +++++++------
 lib/compress_hints.c        |   2 +-
 lib/compressor.c            |  45 +++++++++++-----
 lib/compressor.h            |   9 ++--
 lib/compressor_deflate.c    |  40 ++++++++++----
 lib/compressor_libdeflate.c |  14 +++--
 lib/compressor_liblzma.c    |  54 ++++++++++++-------
 lib/compressor_lz4.c        |   2 -
 lib/compressor_lz4hc.c      |   5 +-
 lib/config.c                |   4 +-
 lib/inode.c                 |   2 +-
 mkfs/main.c                 | 104 ++++++++++++++++++++++++++++--------
 13 files changed, 229 insertions(+), 99 deletions(-)

Interdiff against v2:
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 7dbfd1e..eecf575 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -34,7 +34,7 @@ enum {
 
 #define EROFS_MAX_COMPR_CFGS		64
 
-struct erofs_compr_cfg {
+struct erofs_compr_opts {
 	char *alg;
 	int level;
 	u32 dict_size;
@@ -70,7 +70,7 @@ struct erofs_configure {
 	char *c_src_path;
 	char *c_blobdev_path;
 	char *c_compress_hints_file;
-	struct erofs_compr_cfg c_compr_opts[EROFS_MAX_COMPR_CFGS];
+	struct erofs_compr_opts c_compr_opts[EROFS_MAX_COMPR_CFGS];
 	char c_force_inodeversion;
 	char c_force_chunkformat;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 72f0ca6..eba6c26 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -322,7 +322,6 @@ struct z_erofs_lzma_cfgs {
 	u8 reserved[8];
 } __packed;
 
-#define Z_EROFS_LZMA_DEFAULT_DICT_SIZE	(8 * Z_EROFS_PCLUSTER_MAX_SIZE)
 #define Z_EROFS_LZMA_MAX_DICT_SIZE	(8 * Z_EROFS_PCLUSTER_MAX_SIZE)
 
 /* 6 bytes (+ length field = 8 bytes) */
@@ -331,9 +330,6 @@ struct z_erofs_deflate_cfgs {
 	u8 reserved[5];
 } __packed;
 
-#define Z_EROFS_DEFLATE_DEFULT_DICT_SIZE	(1U << 15)
-#define Z_EROFS_DEFLATE_MAX_DICT_SIZE		(1U << 15)
-
 /*
  * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
  *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
diff --git a/lib/compress.c b/lib/compress.c
index b7ee9ec..ea9d00d 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1124,11 +1124,10 @@ err_free_meta:
 
 static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 				    struct erofs_buffer_head *sb_bh,
-				    struct erofs_compress_cfg *ccfg)
+				    u32 *max_dict_size)
 {
 	struct erofs_buffer_head *bh = sb_bh;
-	int i, ret = 0;
-	u32 dict_size = 0;
+	int ret = 0;
 
 	if (sbi->available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZ4)) {
 		struct {
@@ -1155,22 +1154,15 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 	}
 #ifdef HAVE_LIBLZMA
 	if (sbi->available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZMA)) {
-		for (i = 0; i < EROFS_MAX_COMPR_CFGS; i++) {
-			if (ccfg[i].enable &&
-			    ccfg[i].algorithmtype == Z_EROFS_COMPRESSION_LZMA) {
-				dict_size = ccfg[i].handle.dict_size;
-				break;
-			}
-		}
-		DBG_BUGON(!dict_size);
-
 		struct {
 			__le16 size;
 			struct z_erofs_lzma_cfgs lzma;
 		} __packed lzmaalg = {
 			.size = cpu_to_le16(sizeof(struct z_erofs_lzma_cfgs)),
 			.lzma = {
-				.dict_size = cpu_to_le32(dict_size),
+				.dict_size = cpu_to_le32(
+					max_dict_size
+						[Z_EROFS_COMPRESSION_LZMA]),
 			}
 		};
 
@@ -1186,23 +1178,15 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 	}
 #endif
 	if (sbi->available_compr_algs & (1 << Z_EROFS_COMPRESSION_DEFLATE)) {
-		for (i = 0; i < EROFS_MAX_COMPR_CFGS; i++) {
-			if (ccfg[i].enable &&
-			    ccfg[i].algorithmtype == Z_EROFS_COMPRESSION_DEFLATE) {
-				dict_size = ccfg[i].handle.dict_size;
-				break;
-			}
-		}
-		DBG_BUGON(!dict_size);
-
 		struct {
 			__le16 size;
 			struct z_erofs_deflate_cfgs z;
 		} __packed zalg = {
 			.size = cpu_to_le16(sizeof(struct z_erofs_deflate_cfgs)),
 			.z = {
-				.windowbits =
-					cpu_to_le32(ilog2(dict_size)),
+				.windowbits = cpu_to_le32(ilog2(
+					max_dict_size
+						[Z_EROFS_COMPRESSION_DEFLATE])),
 			}
 		};
 
@@ -1222,6 +1206,7 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh)
 {
 	int i, ret;
+	u32 max_dict_size[Z_EROFS_COMPRESSION_MAX];
 
 	for (i = 0; cfg.c_compr_opts[i].alg; ++i) {
 		struct erofs_compress *c = &erofs_ccfg[i].handle;
@@ -1238,6 +1223,9 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 		sbi->available_compr_algs |= 1 << erofs_ccfg[i].algorithmtype;
 		if (erofs_ccfg[i].algorithmtype != Z_EROFS_COMPRESSION_LZ4)
 			erofs_sb_set_compr_cfgs(sbi);
+		max_dict_size[erofs_ccfg[i].algorithmtype] =
+			max(max_dict_size[erofs_ccfg[i].algorithmtype],
+			    c->dict_size);
 	}
 
 	/*
@@ -1271,7 +1259,7 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	}
 
 	if (erofs_sb_has_compr_cfgs(sbi))
-		return z_erofs_build_compr_cfgs(sbi, sb_bh, erofs_ccfg);
+		return z_erofs_build_compr_cfgs(sbi, sb_bh, max_dict_size);
 	return 0;
 }
 
diff --git a/lib/compressor.c b/lib/compressor.c
index 27b4077..290746e 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -102,26 +102,28 @@ int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
 
 		if (erofs_algs[i].c->setlevel) {
 			ret = erofs_algs[i].c->setlevel(c, compression_level);
-			if (ret)
-				return ret;
-		} else {
-			if (compression_level >= 0)
-				erofs_warn(
-					"compression level %d is ignored for %s",
+			if (ret) {
+				erofs_err("failed to set compression level %d for %s",
 					  compression_level, alg_name);
-			c->compression_level = 0;
+				return ret;
+			}
+		} else if (compression_level >= 0) {
+			erofs_err("compression level is not supported for %s",
+				  alg_name);
+			return -EINVAL;
 		}
 
 		if (erofs_algs[i].c->setdictsize) {
 			ret = erofs_algs[i].c->setdictsize(c, dict_size);
-			if (ret)
-				return ret;
-		} else {
-			if (dict_size)
-				erofs_warn(
-					"dictionary size %u is ignored for %s",
+			if (ret) {
+				erofs_err("failed to set dict size %u for %s",
 					  dict_size, alg_name);
-			c->dict_size = 0;
+				return ret;
+			}
+		} else if (dict_size) {
+			erofs_err("dict size is not supported for %s",
+				  alg_name);
+			return -EINVAL;
 		}
 
 		ret = erofs_algs[i].c->init(c);
diff --git a/lib/compressor_deflate.c b/lib/compressor_deflate.c
index d9f8a91..479ad56 100644
--- a/lib/compressor_deflate.c
+++ b/lib/compressor_deflate.c
@@ -84,8 +84,8 @@ static int erofs_compressor_deflate_setdictsize(struct erofs_compress *c,
 const struct erofs_compressor erofs_compressor_deflate = {
 	.default_level = 1,
 	.best_level = 9,
-	.default_dictsize = Z_EROFS_DEFLATE_DEFULT_DICT_SIZE,
-	.max_dictsize = Z_EROFS_DEFLATE_MAX_DICT_SIZE,
+	.default_dictsize = 1 << 15,
+	.max_dictsize = 1 << 15,
 	.init = compressor_deflate_init,
 	.exit = compressor_deflate_exit,
 	.setlevel = erofs_compressor_deflate_setlevel,
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index 0203a5c..b8ae29c 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -73,7 +73,8 @@ static int erofs_compressor_liblzma_setdictsize(struct erofs_compress *c,
 	if (dict_size == 0)
 		dict_size = erofs_compressor_lzma.default_dictsize;
 
-	if (dict_size > erofs_compressor_lzma.max_dictsize) {
+	if (dict_size > erofs_compressor_lzma.max_dictsize ||
+	    dict_size < 4096) {
 		erofs_err("invalid dict size %u", dict_size);
 		return -EINVAL;
 	}
@@ -111,7 +112,7 @@ static int erofs_compressor_liblzma_init(struct erofs_compress *c)
 const struct erofs_compressor erofs_compressor_lzma = {
 	.default_level = LZMA_PRESET_DEFAULT,
 	.best_level = 109,
-	.default_dictsize = Z_EROFS_LZMA_DEFAULT_DICT_SIZE,
+	.default_dictsize = 8 * Z_EROFS_PCLUSTER_MAX_SIZE,
 	.max_dictsize = Z_EROFS_LZMA_MAX_DICT_SIZE,
 	.init = erofs_compressor_liblzma_init,
 	.exit = erofs_compressor_liblzma_exit,
diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
index 2357f76..8667954 100644
--- a/lib/kite_deflate.c
+++ b/lib/kite_deflate.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2023, Alibaba Cloud
  * Copyright (C) 2023, Gao Xiang <xiang@kernel.org>
  */
-#include "erofs/internal.h"
 #include "erofs/defs.h"
 #include "erofs/print.h"
 #include <errno.h>
@@ -23,7 +22,7 @@ unsigned long erofs_memcmp2(const u8 *s1, const u8 *s2,
 #define kite_dbg(x, ...)
 #endif
 
-#define kHistorySize32		Z_EROFS_DEFLATE_DEFULT_DICT_SIZE
+#define kHistorySize32		(1U << 15)
 
 #define kNumLenSymbols32	256
 #define kNumLenSymbolsMax	kNumLenSymbols32
diff --git a/mkfs/main.c b/mkfs/main.c
index 8a9c3cc..acb2108 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -310,43 +310,31 @@ handle_fragment:
 	return 0;
 }
 
-static int mkfs_parse_compress_algs(char *algs)
+static int mkfs_parse_one_compress_alg(char *alg,
+				       struct erofs_compr_opts *copts)
 {
-	unsigned int i;
-	char *s;
-
-	for (s = strtok(algs, ":"), i = 0; s; s = strtok(NULL, ":"), ++i) {
 	char *p, *q, *opt, *endptr;
-		struct erofs_compr_cfg *ccfg;
 
-		if (i >= EROFS_MAX_COMPR_CFGS - 1) {
-			erofs_err("too many algorithm types");
-			return -EINVAL;
-		}
+	copts->level = -1;
+	copts->dict_size = 0;
 
-		ccfg = cfg.c_compr_opts + i;
-
-		ccfg->level = -1;
-		ccfg->dict_size = 0;
-
-		p = strchr(s, ',');
+	p = strchr(alg, ',');
 	if (p) {
-			ccfg->alg = strndup(s, p - s);
+		copts->alg = strndup(alg, p - alg);
 
-			/* backward compatibility */
+		/* support old '-zlzma,9' form */
 		if (isdigit(*(p + 1))) {
-				ccfg->level = strtol(p + 1, &endptr, 10);
+			copts->level = strtol(p + 1, &endptr, 10);
 			if (*endptr && *endptr != ',') {
-					erofs_err(
-						"invalid compression level %s",
+				erofs_err("invalid compression level %s",
 					  p + 1);
 				return -EINVAL;
 			}
-				continue;
+			return 0;
 		}
 	} else {
-			ccfg->alg = strdup(s);
-			continue;
+		copts->alg = strdup(alg);
+		return 0;
 	}
 
 	opt = p + 1;
@@ -357,26 +345,20 @@ static int mkfs_parse_compress_algs(char *algs)
 
 		if ((p = strstr(opt, "level="))) {
 			p += strlen("level=");
-				ccfg->level = strtol(p, &endptr, 10);
-				if ((endptr == p) ||
-				    (*endptr && *endptr != ',')) {
-					erofs_err(
-						"invalid compression level %s",
-						p);
+			copts->level = strtol(p, &endptr, 10);
+			if ((endptr == p) || (*endptr && *endptr != ',')) {
+				erofs_err("invalid compression level %s", p);
 				return -EINVAL;
 			}
 		} else if ((p = strstr(opt, "dictsize="))) {
 			p += strlen("dictsize=");
-				ccfg->dict_size = strtoul(p, &endptr, 10);
+			copts->dict_size = strtoul(p, &endptr, 10);
 			if (*endptr == 'k' || *endptr == 'K')
-					ccfg->dict_size <<= 10;
+				copts->dict_size <<= 10;
 			else if (*endptr == 'm' || *endptr == 'M')
-					ccfg->dict_size <<= 20;
-				else if ((endptr == p) ||
-					 (*endptr && *endptr != ',')) {
-					erofs_err(
-						"invalid compression dictsize %s",
-						p);
+				copts->dict_size <<= 20;
+			else if ((endptr == p) || (*endptr && *endptr != ',')) {
+				erofs_err("invalid compression dictsize %s", p);
 				return -EINVAL;
 			}
 		} else {
@@ -384,11 +366,27 @@ static int mkfs_parse_compress_algs(char *algs)
 			return -EINVAL;
 		}
 
-			if (q)
-				opt = q + 1;
-			else
-				opt = NULL;
+		opt = q ? q + 1 : NULL;
 	}
+
+	return 0;
+}
+
+static int mkfs_parse_compress_algs(char *algs)
+{
+	unsigned int i;
+	char *s;
+	int ret;
+
+	for (s = strtok(algs, ":"), i = 0; s; s = strtok(NULL, ":"), ++i) {
+		if (i >= EROFS_MAX_COMPR_CFGS - 1) {
+			erofs_err("too many algorithm types");
+			return -EINVAL;
+		}
+
+		ret = mkfs_parse_one_compress_alg(s, &cfg.c_compr_opts[i]);
+		if (ret)
+			return ret;
 	}
 	return 0;
 }
-- 
2.43.0

