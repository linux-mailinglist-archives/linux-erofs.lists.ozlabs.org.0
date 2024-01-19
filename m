Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 146068329A9
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jan 2024 13:47:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TGfX708Yzz3btc
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jan 2024 23:47:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TGfX42mVfz2yk5
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jan 2024 23:47:16 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 94E151009ACD3
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jan 2024 20:46:57 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id C7E9C380CF4
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jan 2024 20:46:56 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 2/3] erofs-utils: mkfs: allow to specify dictionary size for compression algorithms
Date: Fri, 19 Jan 2024 20:46:55 +0800
Message-ID: <20240119124655.62850-1-zhaoyifan@sjtu.edu.cn>
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

Currently, the dictionary size for compression algorithms is fixed. This
patch allows to specify different ones with new -zX,dictsize=<dictsize>
options.

This patch also changes the way to specify compression levels. Now, the
compression level is specified with -zX,level=<level> options and could
be specified together with dictsize. The old -zX,<level> form is still
supported for compatibility.

Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
 include/erofs/config.h   |  10 ++--
 lib/compress.c           |  33 ++++++++-----
 lib/compress_hints.c     |   2 +-
 lib/compressor.c         |  16 +++++-
 lib/compressor.h         |   6 ++-
 lib/compressor_deflate.c |  26 ++++++++--
 lib/compressor_liblzma.c |  32 +++++++-----
 lib/config.c             |   4 +-
 lib/inode.c              |   2 +-
 mkfs/main.c              | 104 +++++++++++++++++++++++++++++++--------
 10 files changed, 179 insertions(+), 56 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 89fe522..eecf575 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -34,6 +34,12 @@ enum {
 
 #define EROFS_MAX_COMPR_CFGS		64
 
+struct erofs_compr_opts {
+	char *alg;
+	int level;
+	u32 dict_size;
+};
+
 struct erofs_configure {
 	const char *c_version;
 	int c_dbg_lvl;
@@ -64,8 +70,7 @@ struct erofs_configure {
 	char *c_src_path;
 	char *c_blobdev_path;
 	char *c_compress_hints_file;
-	char *c_compr_alg[EROFS_MAX_COMPR_CFGS];
-	int c_compr_level[EROFS_MAX_COMPR_CFGS];
+	struct erofs_compr_opts c_compr_opts[EROFS_MAX_COMPR_CFGS];
 	char c_force_inodeversion;
 	char c_force_chunkformat;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
@@ -73,7 +78,6 @@ struct erofs_configure {
 
 	u32 c_pclusterblks_max, c_pclusterblks_def, c_pclusterblks_packed;
 	u32 c_max_decompressed_extent_bytes;
-	u32 c_dict_size;
 	u64 c_unix_timestamp;
 	u32 c_uid, c_gid;
 	const char *mount_point;
diff --git a/lib/compress.c b/lib/compress.c
index 3ea735c..ea9d00d 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1123,7 +1123,8 @@ err_free_meta:
 }
 
 static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
-				    struct erofs_buffer_head *sb_bh)
+				    struct erofs_buffer_head *sb_bh,
+				    u32 *max_dict_size)
 {
 	struct erofs_buffer_head *bh = sb_bh;
 	int ret = 0;
@@ -1159,7 +1160,9 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 		} __packed lzmaalg = {
 			.size = cpu_to_le16(sizeof(struct z_erofs_lzma_cfgs)),
 			.lzma = {
-				.dict_size = cpu_to_le32(cfg.c_dict_size),
+				.dict_size = cpu_to_le32(
+					max_dict_size
+						[Z_EROFS_COMPRESSION_LZMA]),
 			}
 		};
 
@@ -1181,8 +1184,9 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 		} __packed zalg = {
 			.size = cpu_to_le16(sizeof(struct z_erofs_deflate_cfgs)),
 			.z = {
-				.windowbits =
-					cpu_to_le32(ilog2(cfg.c_dict_size)),
+				.windowbits = cpu_to_le32(ilog2(
+					max_dict_size
+						[Z_EROFS_COMPRESSION_DEFLATE])),
 			}
 		};
 
@@ -1202,11 +1206,14 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh)
 {
 	int i, ret;
+	u32 max_dict_size[Z_EROFS_COMPRESSION_MAX];
 
-	for (i = 0; cfg.c_compr_alg[i]; ++i) {
+	for (i = 0; cfg.c_compr_opts[i].alg; ++i) {
 		struct erofs_compress *c = &erofs_ccfg[i].handle;
 
-		ret = erofs_compressor_init(sbi, c, cfg.c_compr_alg[i], cfg.c_compr_level[i]);
+		ret = erofs_compressor_init(sbi, c, cfg.c_compr_opts[i].alg,
+					    cfg.c_compr_opts[i].level,
+					    cfg.c_compr_opts[i].dict_size);
 		if (ret)
 			return ret;
 
@@ -1216,17 +1223,21 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 		sbi->available_compr_algs |= 1 << erofs_ccfg[i].algorithmtype;
 		if (erofs_ccfg[i].algorithmtype != Z_EROFS_COMPRESSION_LZ4)
 			erofs_sb_set_compr_cfgs(sbi);
+		max_dict_size[erofs_ccfg[i].algorithmtype] =
+			max(max_dict_size[erofs_ccfg[i].algorithmtype],
+			    c->dict_size);
 	}
 
 	/*
 	 * if primary algorithm is empty (e.g. compression off),
 	 * clear 0PADDING feature for old kernel compatibility.
 	 */
-	if (!cfg.c_compr_alg[0] ||
-	    (cfg.c_legacy_compress && !strncmp(cfg.c_compr_alg[0], "lz4", 3)))
+	if (!cfg.c_compr_opts[0].alg ||
+	    (cfg.c_legacy_compress &&
+	     !strncmp(cfg.c_compr_opts[0].alg, "lz4", 3)))
 		erofs_sb_clear_lz4_0padding(sbi);
 
-	if (!cfg.c_compr_alg[0])
+	if (!cfg.c_compr_opts[0].alg)
 		return 0;
 
 	/*
@@ -1248,7 +1259,7 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	}
 
 	if (erofs_sb_has_compr_cfgs(sbi))
-		return z_erofs_build_compr_cfgs(sbi, sb_bh);
+		return z_erofs_build_compr_cfgs(sbi, sb_bh, max_dict_size);
 	return 0;
 }
 
@@ -1256,7 +1267,7 @@ int z_erofs_compress_exit(void)
 {
 	int i, ret;
 
-	for (i = 0; cfg.c_compr_alg[i]; ++i) {
+	for (i = 0; cfg.c_compr_opts[i].alg; ++i) {
 		ret = erofs_compressor_exit(&erofs_ccfg[i].handle);
 		if (ret)
 			return ret;
diff --git a/lib/compress_hints.c b/lib/compress_hints.c
index afc9f8f..8b78f80 100644
--- a/lib/compress_hints.c
+++ b/lib/compress_hints.c
@@ -125,7 +125,7 @@ int erofs_load_compress_hints(struct erofs_sb_info *sbi)
 		} else {
 			ccfg = atoi(alg);
 			if (ccfg >= EROFS_MAX_COMPR_CFGS ||
-			    !cfg.c_compr_alg[ccfg]) {
+			    !cfg.c_compr_opts[ccfg].alg) {
 				erofs_err("invalid compressing configuration \"%s\" at line %u",
 					  alg, line);
 				ret = -EINVAL;
diff --git a/lib/compressor.c b/lib/compressor.c
index 295aa47..9f8d220 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -78,7 +78,7 @@ int erofs_compress_destsize(const struct erofs_compress *c,
 }
 
 int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
-			  char *alg_name, int compression_level)
+			  char *alg_name, int compression_level, u32 dict_size)
 {
 	int ret, i;
 
@@ -116,6 +116,20 @@ int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
 				  alg_name);
 			return -EINVAL;
 		}
+
+		if (erofs_algs[i].c->setdictsize) {
+			ret = erofs_algs[i].c->setdictsize(c, dict_size);
+			if (ret) {
+				erofs_err("failed to set dict size %u for %s",
+					  dict_size, alg_name);
+				return ret;
+			}
+		} else if (dict_size) {
+			erofs_err("dict size is not supported for %s",
+				  alg_name);
+			return -EINVAL;
+		}
+
 		if (!ret) {
 			c->alg = &erofs_algs[i];
 			return 0;
diff --git a/lib/compressor.h b/lib/compressor.h
index ec5485d..d8ccf2e 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -14,10 +14,13 @@ struct erofs_compress;
 struct erofs_compressor {
 	int default_level;
 	int best_level;
+	u32 default_dictsize;
+	u32 max_dictsize;
 
 	int (*init)(struct erofs_compress *c);
 	int (*exit)(struct erofs_compress *c);
 	int (*setlevel)(struct erofs_compress *c, int compression_level);
+	int (*setdictsize)(struct erofs_compress *c, u32 dict_size);
 
 	int (*compress_destsize)(const struct erofs_compress *c,
 				 const void *src, unsigned int *srcsize,
@@ -39,6 +42,7 @@ struct erofs_compress {
 
 	unsigned int compress_threshold;
 	unsigned int compression_level;
+	unsigned int dict_size;
 
 	void *private_data;
 };
@@ -56,7 +60,7 @@ int erofs_compress_destsize(const struct erofs_compress *c,
 			    void *dst, unsigned int dstsize);
 
 int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
-			  char *alg_name, int compression_level);
+			  char *alg_name, int compression_level, u32 dict_size);
 int erofs_compressor_exit(struct erofs_compress *c);
 
 #endif
diff --git a/lib/compressor_deflate.c b/lib/compressor_deflate.c
index 4e5902e..aa2ff24 100644
--- a/lib/compressor_deflate.c
+++ b/lib/compressor_deflate.c
@@ -46,6 +46,16 @@ static int compressor_deflate_init(struct erofs_compress *c)
 
 static int erofs_compressor_deflate_setlevel(struct erofs_compress *c,
 					     int compression_level)
+{
+	if (compression_level < 0)
+		compression_level = erofs_compressor_deflate.default_level;
+
+	c->compression_level = compression_level;
+	return 0;
+}
+
+static int erofs_compressor_deflate_setdictsize(struct erofs_compress *c,
+						u32 dict_size)
 {
 	void *s;
 
@@ -54,23 +64,31 @@ static int erofs_compressor_deflate_setlevel(struct erofs_compress *c,
 		c->private_data = NULL;
 	}
 
-	if (compression_level < 0)
-		compression_level = erofs_compressor_deflate.default_level;
+	if (dict_size > erofs_compressor_deflate.max_dictsize) {
+		erofs_err("dict size %u is too large", dict_size);
+		return -EINVAL;
+	}
+
+	if (dict_size == 0)
+		dict_size = erofs_compressor_deflate.default_dictsize;
 
-	s = kite_deflate_init(compression_level, cfg.c_dict_size);
+	s = kite_deflate_init(c->compression_level, dict_size);
 	if (IS_ERR(s))
 		return PTR_ERR(s);
 
 	c->private_data = s;
-	c->compression_level = compression_level;
+	c->dict_size = dict_size;
 	return 0;
 }
 
 const struct erofs_compressor erofs_compressor_deflate = {
 	.default_level = 1,
 	.best_level = 9,
+	.default_dictsize = 1 << 15,
+	.max_dictsize = 1 << 15,
 	.init = compressor_deflate_init,
 	.exit = compressor_deflate_exit,
 	.setlevel = erofs_compressor_deflate_setlevel,
+	.setdictsize = erofs_compressor_deflate_setdictsize,
 	.compress_destsize = deflate_compress_destsize,
 };
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index 0ed6f23..a9551e2 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -68,19 +68,26 @@ static int erofs_compressor_liblzma_setlevel(struct erofs_compress *c,
 	if (lzma_lzma_preset(&ctx->opt, preset))
 		return -EINVAL;
 
-	/* XXX: temporary hack */
-	if (cfg.c_dict_size) {
-		if (cfg.c_dict_size > Z_EROFS_LZMA_MAX_DICT_SIZE) {
-			erofs_err("dict size %u is too large", cfg.c_dict_size);
-			return -EINVAL;
+	c->compression_level = compression_level;
+	return 0;
 }
-		ctx->opt.dict_size = cfg.c_dict_size;
-	} else {
-		if (ctx->opt.dict_size > Z_EROFS_LZMA_MAX_DICT_SIZE)
-			ctx->opt.dict_size = Z_EROFS_LZMA_MAX_DICT_SIZE;
-		cfg.c_dict_size = ctx->opt.dict_size;
+
+static int erofs_compressor_liblzma_setdictsize(struct erofs_compress *c,
+						u32 dict_size)
+{
+	struct erofs_liblzma_context *ctx = c->private_data;
+
+	if (dict_size > erofs_compressor_lzma.max_dictsize ||
+	    dict_size < 4096) {
+		erofs_err("invalid dict size %u", dict_size);
+		return -EINVAL;
 	}
-	c->compression_level = compression_level;
+
+	if (dict_size == 0)
+		dict_size = erofs_compressor_lzma.default_dictsize;
+
+	ctx->opt.dict_size = dict_size;
+	c->dict_size = dict_size;
 	return 0;
 }
 
@@ -101,9 +108,12 @@ static int erofs_compressor_liblzma_init(struct erofs_compress *c)
 const struct erofs_compressor erofs_compressor_lzma = {
 	.default_level = LZMA_PRESET_DEFAULT,
 	.best_level = 109,
+	.default_dictsize = 8 * Z_EROFS_PCLUSTER_MAX_SIZE,
+	.max_dictsize = Z_EROFS_LZMA_MAX_DICT_SIZE,
 	.init = erofs_compressor_liblzma_init,
 	.exit = erofs_compressor_liblzma_exit,
 	.setlevel = erofs_compressor_liblzma_setlevel,
+	.setdictsize = erofs_compressor_liblzma_setdictsize,
 	.compress_destsize = erofs_liblzma_compress_destsize,
 };
 #endif
diff --git a/lib/config.c b/lib/config.c
index aa3dd1f..1096cd1 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -62,8 +62,8 @@ void erofs_exit_configure(void)
 		free(cfg.c_img_path);
 	if (cfg.c_src_path)
 		free(cfg.c_src_path);
-	for (i = 0; i < EROFS_MAX_COMPR_CFGS && cfg.c_compr_alg[i]; i++)
-		free(cfg.c_compr_alg[i]);
+	for (i = 0; i < EROFS_MAX_COMPR_CFGS && cfg.c_compr_opts[i].alg; i++)
+		free(cfg.c_compr_opts[i].alg);
 }
 
 static unsigned int fullpath_prefix;	/* root directory prefix length */
diff --git a/lib/inode.c b/lib/inode.c
index bcdb4b8..c6424c0 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -492,7 +492,7 @@ int erofs_write_file(struct erofs_inode *inode, int fd, u64 fpos)
 		return erofs_blob_write_chunked_file(inode, fd, fpos);
 	}
 
-	if (cfg.c_compr_alg[0] && erofs_file_is_compressible(inode)) {
+	if (cfg.c_compr_opts[0].alg && erofs_file_is_compressible(inode)) {
 		ret = erofs_write_compressed_file(inode, fd);
 		if (!ret || ret != -ENOSPC)
 			return ret;
diff --git a/mkfs/main.c b/mkfs/main.c
index 13fea41..acb2108 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -5,6 +5,7 @@
  * Created by Li Guifu <bluce.liguifu@huawei.com>
  */
 #define _GNU_SOURCE
+#include <ctype.h>
 #include <time.h>
 #include <sys/time.h>
 #include <stdlib.h>
@@ -108,24 +109,29 @@ static void usage(int argc, char **argv)
 		" -b#                   set block size to # (# = page size by default)\n"
 		" -d<0-9>               set output verbosity; 0=quiet, 9=verbose (default=%i)\n"
 		" -x#                   set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
-		" -zX[,Y][:...]         X=compressor (Y=compression level, optional)\n"
-		"                       alternative compressors can be separated by colons(:)\n"
-		"                       supported compressors and their level ranges are:\n",
+		" -zX[,level=Y]         X=compressor (Y=compression level, Z=dictionary size, optional)\n"
+		"    [,dictsize=Z]      alternative compressors can be separated by colons(:)\n"
+		"    [:...]             supported compressors and their option ranges are:\n",
 		argv[0], EROFS_WARN);
 	while ((s = z_erofs_list_available_compressors(&i)) != NULL) {
-		printf("                           %s", s->name);
+		char * const spaces = "                         ";
+
+		printf("%s%s\n", spaces, s->name);
 		if (s->c->setlevel) {
 			if (!strcmp(s->name, "lzma"))
 				/* A little kludge to show the range as disjointed
 				 * "0-9,100-109" instead of a continuous "0-109", and to
 				 * state what those two subranges respectively mean.  */
-				printf("[<0-9,100-109>]\t0-9=normal, 100-109=extreme (default=%i)",
-				       s->c->default_level);
+				printf("%s  [,level=<0-9,100-109>]\t0-9=normal, 100-109=extreme (default=%i)\n",
+				       spaces, s->c->default_level);
 			else
-				printf("[,<0-%i>]\t(default=%i)",
-				       s->c->best_level, s->c->default_level);
+				printf("%s  [,level=<0-%i>]\t\t(default=%i)\n",
+				       spaces, s->c->best_level, s->c->default_level);
+		}
+		if (s->c->setdictsize) {
+			printf("%s  [,dictsize=<dictsize>]\t(default=%u, max=%u)\n",
+			       spaces, s->c->default_dictsize, s->c->max_dictsize);
 		}
-		putchar('\n');
 	}
 	printf(
 		" -C#                   specify the size of compress physical cluster in bytes\n"
@@ -304,27 +310,83 @@ handle_fragment:
 	return 0;
 }
 
+static int mkfs_parse_one_compress_alg(char *alg,
+				       struct erofs_compr_opts *copts)
+{
+	char *p, *q, *opt, *endptr;
+
+	copts->level = -1;
+	copts->dict_size = 0;
+
+	p = strchr(alg, ',');
+	if (p) {
+		copts->alg = strndup(alg, p - alg);
+
+		/* support old '-zlzma,9' form */
+		if (isdigit(*(p + 1))) {
+			copts->level = strtol(p + 1, &endptr, 10);
+			if (*endptr && *endptr != ',') {
+				erofs_err("invalid compression level %s",
+					  p + 1);
+				return -EINVAL;
+			}
+			return 0;
+		}
+	} else {
+		copts->alg = strdup(alg);
+		return 0;
+	}
+
+	opt = p + 1;
+	while (opt) {
+		q = strchr(opt, ',');
+		if (q)
+			*q = '\0';
+
+		if ((p = strstr(opt, "level="))) {
+			p += strlen("level=");
+			copts->level = strtol(p, &endptr, 10);
+			if ((endptr == p) || (*endptr && *endptr != ',')) {
+				erofs_err("invalid compression level %s", p);
+				return -EINVAL;
+			}
+		} else if ((p = strstr(opt, "dictsize="))) {
+			p += strlen("dictsize=");
+			copts->dict_size = strtoul(p, &endptr, 10);
+			if (*endptr == 'k' || *endptr == 'K')
+				copts->dict_size <<= 10;
+			else if (*endptr == 'm' || *endptr == 'M')
+				copts->dict_size <<= 20;
+			else if ((endptr == p) || (*endptr && *endptr != ',')) {
+				erofs_err("invalid compression dictsize %s", p);
+				return -EINVAL;
+			}
+		} else {
+			erofs_err("invalid compression option %s", opt);
+			return -EINVAL;
+		}
+
+		opt = q ? q + 1 : NULL;
+	}
+
+	return 0;
+}
+
 static int mkfs_parse_compress_algs(char *algs)
 {
 	unsigned int i;
 	char *s;
+	int ret;
 
 	for (s = strtok(algs, ":"), i = 0; s; s = strtok(NULL, ":"), ++i) {
-		const char *lv;
-
 		if (i >= EROFS_MAX_COMPR_CFGS - 1) {
 			erofs_err("too many algorithm types");
 			return -EINVAL;
 		}
 
-		lv = strchr(s, ',');
-		if (lv) {
-			cfg.c_compr_level[i] = atoi(lv + 1);
-			cfg.c_compr_alg[i] = strndup(s, lv - s);
-		} else {
-			cfg.c_compr_level[i] = -1;
-			cfg.c_compr_alg[i] = strdup(s);
-		}
+		ret = mkfs_parse_one_compress_alg(s, &cfg.c_compr_opts[i]);
+		if (ret)
+			return ret;
 	}
 	return 0;
 }
@@ -692,7 +754,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		cfg.c_showprogress = false;
 	}
 
-	if (cfg.c_compr_alg[0] && erofs_blksiz(&sbi) != getpagesize())
+	if (cfg.c_compr_opts[0].alg && erofs_blksiz(&sbi) != getpagesize())
 		erofs_warn("Please note that subpage blocksize with compression isn't yet supported in kernel. "
 			   "This compressed image will only work with bs = ps = %u bytes",
 			   erofs_blksiz(&sbi));
@@ -1119,7 +1181,7 @@ int main(int argc, char **argv)
 	}
 
 	if (cfg.c_dedupe) {
-		if (!cfg.c_compr_alg[0]) {
+		if (!cfg.c_compr_opts[0].alg) {
 			erofs_err("Compression is not enabled.  Turn on chunk-based data deduplication instead.");
 			cfg.c_chunkbits = sbi.blkszbits;
 		} else {
-- 
2.43.0

