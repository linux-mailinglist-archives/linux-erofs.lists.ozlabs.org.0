Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2462869FBC9
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Feb 2023 20:12:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PMQkq75Lsz3cFT
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Feb 2023 06:12:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PMQkm4YRHz3cKj
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Feb 2023 06:12:00 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VcHhJJY_1677093111;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VcHhJJY_1677093111)
          by smtp.aliyun-inc.com;
          Thu, 23 Feb 2023 03:11:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/3] erofs-utils: support multiple algorithms in a single image
Date: Thu, 23 Feb 2023 03:11:47 +0800
Message-Id: <20230222191148.112677-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230222191148.112677-1-hsiangkao@linux.alibaba.com>
References: <20230222191148.112677-1-hsiangkao@linux.alibaba.com>
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

Some binaries in an image may be just for archival purposes only
so that the runtime performance is not the top priority at all.

Therefore, it'd better to use another algorithm with higher
compression ratios and (even) pack the whole file into the packed
inode entirely (will enable this way later.)

In order to use alternative algorithms, just specify two or more
compressing configurations together separated by ':' like below:
   -zlzma:lz4hc,12:lzma,9 -C32768

Although mkfs still choose the first one by default, you could try
to write a compress-hints file like below:
   4096  1 .*\.so$
   32768 2 .*\.txt$
   4096    sbin/.*$
   16384 0 .*

So that ".so" files will use "lz4hc,12" compression with 4k pclusters,
".txt" files will use "lzma,9" compression with 32k pclusters, files
under "/sbin" will use the default "lzma" compression with 4k plusters
and other files will use "lzma" compression with 16k pclusters.

Note that the largest pcluster size should be specified with the "-C"
option, otherwise all larger pclusters will be limited.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - move `enable` field into the next patch;
 - refine commit message.

 include/erofs/compress_hints.h |  1 +
 include/erofs/config.h         |  6 ++-
 lib/compress.c                 | 80 ++++++++++++++++++++--------------
 lib/compress_hints.c           | 57 ++++++++++++++++--------
 lib/config.c                   |  1 -
 lib/inode.c                    |  2 +-
 mkfs/main.c                    | 43 +++++++++++++-----
 7 files changed, 123 insertions(+), 67 deletions(-)

diff --git a/include/erofs/compress_hints.h b/include/erofs/compress_hints.h
index 659c5b6..d836f22 100644
--- a/include/erofs/compress_hints.h
+++ b/include/erofs/compress_hints.h
@@ -20,6 +20,7 @@ struct erofs_compress_hints {
 
 	regex_t reg;
 	unsigned int physical_clusterblks;
+	unsigned char algorithmtype;
 };
 
 bool z_erofs_apply_compress_hints(struct erofs_inode *inode);
diff --git a/include/erofs/config.h b/include/erofs/config.h
index a93ab25..aee2815 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -32,6 +32,8 @@ enum {
 	TIMESTAMP_CLAMPING,
 };
 
+#define EROFS_MAX_COMPR_CFGS		64
+
 struct erofs_configure {
 	const char *c_version;
 	int c_dbg_lvl;
@@ -57,8 +59,8 @@ struct erofs_configure {
 	char *c_src_path;
 	char *c_blobdev_path;
 	char *c_compress_hints_file;
-	char *c_compr_alg_master;
-	int c_compr_level_master;
+	char *c_compr_alg[EROFS_MAX_COMPR_CFGS];
+	int c_compr_level[EROFS_MAX_COMPR_CFGS];
 	char c_force_inodeversion;
 	char c_force_chunkformat;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
diff --git a/lib/compress.c b/lib/compress.c
index 2987b10..b1185bd 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -21,14 +21,19 @@
 #include "erofs/compress_hints.h"
 #include "erofs/fragments.h"
 
-static struct erofs_compress compresshandle;
-static unsigned int algorithmtype[2];
+/* compressing configuration specified by users */
+struct erofs_compress_cfg {
+	struct erofs_compress handle;
+	unsigned int algorithmtype;
+} erofs_ccfg[EROFS_MAX_COMPR_CFGS];
 
 struct z_erofs_vle_compress_ctx {
 	u8 queue[EROFS_CONFIG_COMPR_MAX_SZ * 2];
 	struct z_erofs_inmem_extent e;	/* (lookahead) extent */
 
 	struct erofs_inode *inode;
+	struct erofs_compress_cfg *ccfg;
+
 	u8 *metacur;
 	unsigned int head, tail;
 	erofs_off_t remaining;
@@ -318,7 +323,8 @@ static int z_erofs_fill_inline_data(struct erofs_inode *inode, void *data,
 	return len;
 }
 
-static void tryrecompress_trailing(void *in, unsigned int *insize,
+static void tryrecompress_trailing(struct erofs_compress *ec,
+				   void *in, unsigned int *insize,
 				   void *out, int *compressedsize)
 {
 	static char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
@@ -330,8 +336,7 @@ static void tryrecompress_trailing(void *in, unsigned int *insize,
 		return;
 
 	count = *insize;
-	ret = erofs_compress_destsize(&compresshandle,
-				      in, &count, (void *)tmp,
+	ret = erofs_compress_destsize(ec, in, &count, (void *)tmp,
 				      rounddown(ret, EROFS_BLKSIZ), false);
 	if (ret <= 0 || ret + (*insize - count) >=
 			roundup(*compressedsize, EROFS_BLKSIZ))
@@ -375,7 +380,7 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
 	struct erofs_inode *inode = ctx->inode;
 	char *const dst = dstbuf + EROFS_BLKSIZ;
-	struct erofs_compress *const h = &compresshandle;
+	struct erofs_compress *const h = &ctx->ccfg->handle;
 	unsigned int len = ctx->tail - ctx->head;
 	bool is_packed_inode = erofs_is_packed_inode(inode);
 	bool final = !ctx->remaining;
@@ -491,7 +496,7 @@ frag_packing:
 			}
 
 			if (may_inline && len == ctx->e.length)
-				tryrecompress_trailing(ctx->queue + ctx->head,
+				tryrecompress_trailing(h, ctx->queue + ctx->head,
 						&ctx->e.length, dst, &ret);
 
 			tailused = ret & (EROFS_BLKSIZ - 1);
@@ -853,8 +858,10 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	}
 	if (cfg.c_fragments && !cfg.c_dedupe)
 		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
-	inode->z_algorithmtype[0] = algorithmtype[0];
-	inode->z_algorithmtype[1] = algorithmtype[1];
+
+	ctx.ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
+	inode->z_algorithmtype[0] = ctx.ccfg[0].algorithmtype;
+	inode->z_algorithmtype[1] = 0;
 	inode->z_logical_clusterbits = LOG_BLOCK_SIZE;
 
 	inode->idata_size = 0;
@@ -1050,36 +1057,39 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 
 int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 {
-	/* initialize for primary compression algorithm */
-	int ret = erofs_compressor_init(&compresshandle,
-					cfg.c_compr_alg_master);
+	int i, ret;
 
-	if (ret)
-		return ret;
+	for (i = 0; cfg.c_compr_alg[i]; ++i) {
+		ret = erofs_compressor_init(&erofs_ccfg[i].handle,
+					     cfg.c_compr_alg[i]);
+		if (ret)
+			return ret;
+
+		ret = erofs_compressor_setlevel(&erofs_ccfg[i].handle,
+						cfg.c_compr_level[i]);
+		if (ret)
+			return ret;
+
+		ret = erofs_get_compress_algorithm_id(cfg.c_compr_alg[i]);
+		if (ret < 0)
+			return ret;
+		erofs_ccfg[i].algorithmtype = ret;
+		sbi.available_compr_algs |= 1 << ret;
+		if (ret != Z_EROFS_COMPRESSION_LZ4)
+			erofs_sb_set_compr_cfgs();
+	}
 
 	/*
 	 * if primary algorithm is empty (e.g. compression off),
 	 * clear 0PADDING feature for old kernel compatibility.
 	 */
-	if (!cfg.c_compr_alg_master ||
-	    (cfg.c_legacy_compress && !strcmp(cfg.c_compr_alg_master, "lz4")))
+	if (!cfg.c_compr_alg[0] ||
+	    (cfg.c_legacy_compress && !strncmp(cfg.c_compr_alg[0], "lz4", 3)))
 		erofs_sb_clear_lz4_0padding();
 
-	if (!cfg.c_compr_alg_master)
+	if (!cfg.c_compr_alg[0])
 		return 0;
 
-	ret = erofs_compressor_setlevel(&compresshandle,
-					cfg.c_compr_level_master);
-	if (ret)
-		return ret;
-
-	/* figure out primary algorithm */
-	ret = erofs_get_compress_algorithm_id(cfg.c_compr_alg_master);
-	if (ret < 0)
-		return ret;
-
-	algorithmtype[0] = ret;	/* primary algorithm (head 0) */
-	algorithmtype[1] = 0;	/* secondary algorithm (head 1) */
 	/*
 	 * if big pcluster is enabled, an extra CBLKCNT lcluster index needs
 	 * to be loaded in order to get those compressed block counts.
@@ -1098,9 +1108,6 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 		return -EINVAL;
 	}
 
-	if (ret != Z_EROFS_COMPRESSION_LZ4)
-		erofs_sb_set_compr_cfgs();
-
 	if (erofs_sb_has_compr_cfgs()) {
 		sbi.available_compr_algs |= 1 << ret;
 		return z_erofs_build_compr_cfgs(sb_bh);
@@ -1110,5 +1117,12 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 
 int z_erofs_compress_exit(void)
 {
-	return erofs_compressor_exit(&compresshandle);
+	int i, ret;
+
+	for (i = 0; cfg.c_compr_alg[i]; ++i) {
+		ret = erofs_compressor_exit(&erofs_ccfg[i].handle);
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
diff --git a/lib/compress_hints.c b/lib/compress_hints.c
index 3e5c8c8..1e9e05d 100644
--- a/lib/compress_hints.c
+++ b/lib/compress_hints.c
@@ -20,57 +20,60 @@ static void dump_regerror(int errcode, const char *s, const regex_t *preg)
 	erofs_err("invalid regex %s (%s)\n", s, str);
 }
 
-static int erofs_insert_compress_hints(const char *s, unsigned int blks)
+/* algorithmtype is actually ccfg # here */
+static int erofs_insert_compress_hints(const char *s, unsigned int blks,
+				       unsigned int algorithmtype)
 {
-	struct erofs_compress_hints *r;
+	struct erofs_compress_hints *ch;
 	int ret;
 
-	r = malloc(sizeof(struct erofs_compress_hints));
-	if (!r)
+	ch = malloc(sizeof(struct erofs_compress_hints));
+	if (!ch)
 		return -ENOMEM;
 
-	ret = regcomp(&r->reg, s, REG_EXTENDED|REG_NOSUB);
+	ret = regcomp(&ch->reg, s, REG_EXTENDED|REG_NOSUB);
 	if (ret) {
-		dump_regerror(ret, s, &r->reg);
-		goto err_out;
+		dump_regerror(ret, s, &ch->reg);
+		free(ch);
+		return ret;
 	}
-	r->physical_clusterblks = blks;
+	ch->physical_clusterblks = blks;
+	ch->algorithmtype = algorithmtype;
 
-	list_add_tail(&r->list, &compress_hints_head);
+	list_add_tail(&ch->list, &compress_hints_head);
 	erofs_info("compress hint %s (%u) is inserted", s, blks);
 	return ret;
-
-err_out:
-	free(r);
-	return ret;
 }
 
 bool z_erofs_apply_compress_hints(struct erofs_inode *inode)
 {
 	const char *s;
 	struct erofs_compress_hints *r;
-	unsigned int pclusterblks;
+	unsigned int pclusterblks, algorithmtype;
 
 	if (inode->z_physical_clusterblks)
 		return true;
 
 	s = erofs_fspath(inode->i_srcpath);
 	pclusterblks = cfg.c_pclusterblks_def;
+	algorithmtype = 0;
 
 	list_for_each_entry(r, &compress_hints_head, list) {
 		int ret = regexec(&r->reg, s, (size_t)0, NULL, 0);
 
 		if (!ret) {
 			pclusterblks = r->physical_clusterblks;
+			algorithmtype = r->algorithmtype;
 			break;
 		}
 		if (ret != REG_NOMATCH)
 			dump_regerror(ret, s, &r->reg);
 	}
 	inode->z_physical_clusterblks = pclusterblks;
+	inode->z_algorithmtype[0] = algorithmtype;
 
 	/* pclusterblks is 0 means this file shouldn't be compressed */
-	return !!pclusterblks;
+	return pclusterblks != 0;
 }
 
 void erofs_cleanup_compress_hints(void)
@@ -98,20 +101,38 @@ int erofs_load_compress_hints(void)
 		return -errno;
 
 	for (line = 1; fgets(buf, sizeof(buf), f); ++line) {
-		unsigned int pclustersize;
-		char *pattern;
+		unsigned int pclustersize, ccfg;
+		char *alg, *pattern;
 
 		if (*buf == '#' || *buf == '\n')
 			continue;
 
 		pclustersize = atoi(strtok(buf, "\t "));
+		alg = strtok(NULL, "\n\t ");
 		pattern = strtok(NULL, "\n");
+		if (!pattern) {
+			pattern = alg;
+			alg = NULL;
+		}
 		if (!pattern || *pattern == '\0') {
 			erofs_err("cannot find a match pattern at line %u",
 				  line);
 			ret = -EINVAL;
 			goto out;
 		}
+		if (!alg || *alg == '\0') {
+			ccfg = 0;
+		} else {
+			ccfg = atoi(alg);
+			if (ccfg >= EROFS_MAX_COMPR_CFGS ||
+			    !cfg.c_compr_alg[ccfg]) {
+				erofs_err("invalid compressing configuration \"%s\" at line %u",
+					  alg, line);
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+
 		if (pclustersize % EROFS_BLKSIZ) {
 			erofs_warn("invalid physical clustersize %u, "
 				   "use default pclusterblks %u",
@@ -119,7 +140,7 @@ int erofs_load_compress_hints(void)
 			continue;
 		}
 		erofs_insert_compress_hints(pattern,
-					    pclustersize / EROFS_BLKSIZ);
+					    pclustersize / EROFS_BLKSIZ, ccfg);
 
 		if (pclustersize > max_pclustersize)
 			max_pclustersize = pclustersize;
diff --git a/lib/config.c b/lib/config.c
index 20200be..a3235c8 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -25,7 +25,6 @@ void erofs_init_configure(void)
 	cfg.c_version  = PACKAGE_VERSION;
 	cfg.c_dry_run  = false;
 	cfg.c_ignore_mtime = false;
-	cfg.c_compr_level_master = -1;
 	cfg.c_force_inodeversion = 0;
 	cfg.c_inline_xattr_tolerance = 2;
 	cfg.c_unix_timestamp = -1;
diff --git a/lib/inode.c b/lib/inode.c
index 6fd28a2..8364451 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -424,7 +424,7 @@ static int erofs_write_file(struct erofs_inode *inode)
 		return erofs_blob_write_chunked_file(inode);
 	}
 
-	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
+	if (cfg.c_compr_alg[0] && erofs_file_is_compressible(inode)) {
 		fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
 		if (fd < 0)
 			return -errno;
diff --git a/mkfs/main.c b/mkfs/main.c
index 979b763..2c3a3b7 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -232,6 +232,31 @@ static int parse_extended_opts(const char *opts)
 	return 0;
 }
 
+static int mkfs_parse_compress_algs(char *algs)
+{
+	unsigned int i;
+	char *s;
+
+	for (s = strtok(algs, ":"), i = 0; s; s = strtok(NULL, ":"), ++i) {
+		const char *lv;
+
+		if (i >= EROFS_MAX_COMPR_CFGS - 1) {
+			erofs_err("too many algorithm types");
+			return -EINVAL;
+		}
+
+		lv = strchr(s, ',');
+		if (lv) {
+			cfg.c_compr_level[i] = atoi(lv + 1);
+			cfg.c_compr_alg[i] = strndup(s, lv - s);
+		} else {
+			cfg.c_compr_level[i] = -1;
+			cfg.c_compr_alg[i] = strdup(s);
+		}
+	}
+	return 0;
+}
+
 static int mkfs_parse_options_cfg(int argc, char *argv[])
 {
 	char *endptr;
@@ -243,19 +268,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		switch (opt) {
 		case 'z':
 			if (!optarg) {
-				cfg.c_compr_alg_master = "(default)";
+				cfg.c_compr_alg[0] = "(default)";
+				cfg.c_compr_level[0] = -1;
 				break;
 			}
-			/* get specified compression level */
-			for (i = 0; optarg[i] != '\0'; ++i) {
-				if (optarg[i] == ',') {
-					cfg.c_compr_level_master =
-						atoi(optarg + i + 1);
-					optarg[i] = '\0';
-					break;
-				}
-			}
-			cfg.c_compr_alg_master = strndup(optarg, i);
+			i = mkfs_parse_compress_algs(optarg);
+			if (i)
+				return i;
 			break;
 
 		case 'd':
@@ -749,7 +768,7 @@ int main(int argc, char **argv)
 	}
 
 	if (cfg.c_dedupe) {
-		if (!cfg.c_compr_alg_master) {
+		if (!cfg.c_compr_alg[0]) {
 			erofs_err("Compression is not enabled.  Turn on chunk-based data deduplication instead.");
 			cfg.c_chunkbits = LOG_BLOCK_SIZE;
 		} else {
-- 
2.24.4

