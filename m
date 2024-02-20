Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1879D85B447
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 08:56:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TfBYz0Sqmz3cR4
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 18:56:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TfBYx1QP3z3bv3
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Feb 2024 18:56:37 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id E2B9010090E04;
	Tue, 20 Feb 2024 15:55:38 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 00D1E37C943;
	Tue, 20 Feb 2024 15:55:37 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: hsiangkao@linux.alibaba.com
Subject: [PATCH v2 4/7] erofs-utils: mkfs: optionally print warning in erofs_compressor_init
Date: Tue, 20 Feb 2024 15:55:22 +0800
Message-ID: <20240220075525.684205-5-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220075525.684205-4-zhaoyifan@sjtu.edu.cn>
References: <20240220075525.684205-1-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-2-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-3-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-4-zhaoyifan@sjtu.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In the incoming multi-threaded compression support, compressor may be
initialized more than once in different worker threads, resulting in
noisy warning output. This patch make sure that each warning message is
printed only once by adding a print_warning option to the
erofs_compressor_init() interface.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
 lib/compress.c              | 3 ++-
 lib/compressor.c            | 5 +++--
 lib/compressor.h            | 5 +++--
 lib/compressor_deflate.c    | 4 +++-
 lib/compressor_libdeflate.c | 4 +++-
 lib/compressor_liblzma.c    | 5 ++++-
 lib/compressor_lz4.c        | 2 +-
 lib/compressor_lz4hc.c      | 2 +-
 8 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 9611102..41cb6e5 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1213,7 +1213,8 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 
 		ret = erofs_compressor_init(sbi, c, cfg.c_compr_opts[i].alg,
 					    cfg.c_compr_opts[i].level,
-					    cfg.c_compr_opts[i].dict_size);
+					    cfg.c_compr_opts[i].dict_size,
+					    true);
 		if (ret)
 			return ret;
 
diff --git a/lib/compressor.c b/lib/compressor.c
index 4720e72..9b3794b 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -78,7 +78,8 @@ int erofs_compress_destsize(const struct erofs_compress *c,
 }
 
 int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
-			  char *alg_name, int compression_level, u32 dict_size)
+			  char *alg_name, int compression_level, u32 dict_size,
+			  bool print_warning)
 {
 	int ret, i;
 
@@ -126,7 +127,7 @@ int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
 			return -EINVAL;
 		}
 
-		ret = erofs_algs[i].c->init(c);
+		ret = erofs_algs[i].c->init(c, print_warning);
 		if (ret)
 			return ret;
 
diff --git a/lib/compressor.h b/lib/compressor.h
index d8ccf2e..522fde0 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -17,7 +17,7 @@ struct erofs_compressor {
 	u32 default_dictsize;
 	u32 max_dictsize;
 
-	int (*init)(struct erofs_compress *c);
+	int (*init)(struct erofs_compress *c, bool print_warning);
 	int (*exit)(struct erofs_compress *c);
 	int (*setlevel)(struct erofs_compress *c, int compression_level);
 	int (*setdictsize)(struct erofs_compress *c, u32 dict_size);
@@ -60,7 +60,8 @@ int erofs_compress_destsize(const struct erofs_compress *c,
 			    void *dst, unsigned int dstsize);
 
 int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
-			  char *alg_name, int compression_level, u32 dict_size);
+			  char *alg_name, int compression_level, u32 dict_size,
+			  bool print_warning);
 int erofs_compressor_exit(struct erofs_compress *c);
 
 #endif
diff --git a/lib/compressor_deflate.c b/lib/compressor_deflate.c
index 8629415..9fe067f 100644
--- a/lib/compressor_deflate.c
+++ b/lib/compressor_deflate.c
@@ -34,7 +34,7 @@ static int compressor_deflate_exit(struct erofs_compress *c)
 	return 0;
 }
 
-static int compressor_deflate_init(struct erofs_compress *c)
+static int compressor_deflate_init(struct erofs_compress *c, bool print_warning)
 {
 	if (c->private_data) {
 		kite_deflate_end(c->private_data);
@@ -44,9 +44,11 @@ static int compressor_deflate_init(struct erofs_compress *c)
 	if (IS_ERR_VALUE(c->private_data))
 		return PTR_ERR(c->private_data);
 
+	if (print_warning) {
 		erofs_warn("EXPERIMENTAL DEFLATE algorithm in use. Use at your own risk!");
 		erofs_warn("*Carefully* check filesystem data correctness to avoid corruption!");
 		erofs_warn("Please send a report to <linux-erofs@lists.ozlabs.org> if something is wrong.");
+	}
 	return 0;
 }
 
diff --git a/lib/compressor_libdeflate.c b/lib/compressor_libdeflate.c
index 62d93f7..0583868 100644
--- a/lib/compressor_libdeflate.c
+++ b/lib/compressor_libdeflate.c
@@ -80,13 +80,15 @@ static int compressor_libdeflate_exit(struct erofs_compress *c)
 	return 0;
 }
 
-static int compressor_libdeflate_init(struct erofs_compress *c)
+static int compressor_libdeflate_init(struct erofs_compress *c,
+				      bool print_warning)
 {
 	libdeflate_free_compressor(c->private_data);
 	c->private_data = libdeflate_alloc_compressor(c->compression_level);
 	if (!c->private_data)
 		return -ENOMEM;
 
+	if (print_warning)
 		erofs_warn("EXPERIMENTAL libdeflate compressor in use. Use at your own risk!");
 	return 0;
 }
diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index 7183b0b..b048e57 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -81,7 +81,8 @@ static int erofs_compressor_liblzma_setdictsize(struct erofs_compress *c,
 	return 0;
 }
 
-static int erofs_compressor_liblzma_init(struct erofs_compress *c)
+static int erofs_compressor_liblzma_init(struct erofs_compress *c,
+					 bool print_warning)
 {
 	struct erofs_liblzma_context *ctx;
 	u32 preset;
@@ -103,8 +104,10 @@ static int erofs_compressor_liblzma_init(struct erofs_compress *c)
 	ctx->opt.dict_size = c->dict_size;
 
 	c->private_data = ctx;
+	if (print_warning) {
 		erofs_warn("EXPERIMENTAL MicroLZMA feature in use. Use at your own risk!");
 		erofs_warn("Note that it may take more time since the compressor is still single-threaded for now.");
+	}
 	return 0;
 }
 
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index f4e72c3..6aed213 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -30,7 +30,7 @@ static int compressor_lz4_exit(struct erofs_compress *c)
 	return 0;
 }
 
-static int compressor_lz4_init(struct erofs_compress *c)
+static int compressor_lz4_init(struct erofs_compress *c, bool print_warning)
 {
 	c->sbi->lz4_max_distance = LZ4_DISTANCE_MAX;
 	return 0;
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index 6fc8847..3d10aa8 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -37,7 +37,7 @@ static int compressor_lz4hc_exit(struct erofs_compress *c)
 	return 0;
 }
 
-static int compressor_lz4hc_init(struct erofs_compress *c)
+static int compressor_lz4hc_init(struct erofs_compress *c, bool print_warning)
 {
 	c->private_data = LZ4_createStreamHC();
 	if (!c->private_data)
-- 
2.43.2

