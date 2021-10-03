Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8729E42000B
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Oct 2021 06:47:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HMWXr1lLnz2yQB
	for <lists+linux-erofs@lfdr.de>; Sun,  3 Oct 2021 15:47:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dC3nb+km;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dC3nb+km; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HMWXn260qz2yMg
 for <linux-erofs@lists.ozlabs.org>; Sun,  3 Oct 2021 15:47:05 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA7D361352;
 Sun,  3 Oct 2021 04:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633236423;
 bh=pmjQEK3CejdjwYd2fj7jwIswUlmfIESPVIAIGQlKOxY=;
 h=From:To:Cc:Subject:Date:From;
 b=dC3nb+kmeZgwjm3ly3i8XxeiAYxTu1+DsXSQEUmAgPXmKiIW6Qw2a6kHy4aJ6GCX5
 jxIdQEhSoeYdOMVI8iqEGM4J4Kx9NWYbTrvcWo1jN+noECkikjo0qxnkrpAd/o0YrR
 DrIZ+LEU+5wl4/hGvWp7tWCjga0l88W3tKIBh31zSw9hr+bYPOwT1ckezYXOt7IDtu
 xxIG2+BgfXwp5uLFJ1IGGZCc3WKqw2ZcsXplRU2a8nvrPdOELsqAmnteQsSoC1VHn9
 OAL+YLVSqiFvsDr3Q9b0vEfMoPC6H2zEv10Iyp17ULYGjUTFE2KwL5VKmkkw5UPFH1
 H9MIlNyESvBbw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: clevel set up as an individual function
Date: Sun,  3 Oct 2021 12:46:55 +0800
Message-Id: <20211003044655.9991-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Compression level passed in can be verified then. Also, in order for
preparation of upcoming LZMA fixed-sized output compression.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
A preparing patch for LZMA and range LZ4 dictionary I'd like to merge
in advance.

 lib/compress.c         | 11 ++++-------
 lib/compressor.c       | 22 +++++++++++++++-------
 lib/compressor.h       |  6 ++++--
 lib/compressor_lz4.c   |  1 -
 lib/compressor_lz4hc.c | 21 +++++++++++++++------
 5 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 36c6a28ad0f6..6ca5bedaf596 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -20,8 +20,6 @@
 #include "erofs/compress_hints.h"
 
 static struct erofs_compress compresshandle;
-static int compressionlevel;
-
 static unsigned int algorithmtype[2];
 
 struct z_erofs_vle_compress_ctx {
@@ -190,8 +188,7 @@ static int vle_compress_one(struct erofs_inode *inode,
 		}
 
 		count = min(len, cfg.c_max_decompressed_extent_bytes);
-		ret = erofs_compress_destsize(h, compressionlevel,
-					      ctx->queue + ctx->head,
+		ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
 					      &count, dst, pclustersize);
 		if (ret <= 0) {
 			if (ret != -EAGAIN) {
@@ -645,9 +642,9 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 	if (!cfg.c_compr_alg_master)
 		return 0;
 
-	compressionlevel = cfg.c_compr_level_master < 0 ?
-		compresshandle.alg->default_level :
-		cfg.c_compr_level_master;
+	ret = erofs_compressor_setlevel(&compresshandle, cfg.c_compr_level_master);
+	if (ret)
+		return ret;
 
 	/* figure out primary algorithm */
 	ret = erofs_get_compress_algorithm_id(cfg.c_compr_alg_master);
diff --git a/lib/compressor.c b/lib/compressor.c
index 1f1a33d099ba..89c1be10dd0c 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -20,11 +20,8 @@ static struct erofs_compressor *compressors[] = {
 };
 
 int erofs_compress_destsize(struct erofs_compress *c,
-			    int compression_level,
-			    void *src,
-			    unsigned int *srcsize,
-			    void *dst,
-			    unsigned int dstsize)
+			    void *src, unsigned int *srcsize,
+			    void *dst, unsigned int dstsize)
 {
 	unsigned int uncompressed_size;
 	int ret;
@@ -33,8 +30,7 @@ int erofs_compress_destsize(struct erofs_compress *c,
 	if (!c->alg->compress_destsize)
 		return -ENOTSUP;
 
-	ret = c->alg->compress_destsize(c, compression_level,
-					src, srcsize, dst, dstsize);
+	ret = c->alg->compress_destsize(c, src, srcsize, dst, dstsize);
 	if (ret < 0)
 		return ret;
 
@@ -51,6 +47,18 @@ const char *z_erofs_list_available_compressors(unsigned int i)
 	return i >= ARRAY_SIZE(compressors) ? NULL : compressors[i]->name;
 }
 
+int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level)
+{
+	DBG_BUGON(!c->alg);
+	if (c->alg->setlevel)
+		return c->alg->setlevel(c, compression_level);
+
+	if (compression_level >= 0)
+		return -EINVAL;
+	c->compression_level = 0;
+	return 0;
+}
+
 int erofs_compressor_init(struct erofs_compress *c, char *alg_name)
 {
 	int ret, i;
diff --git a/lib/compressor.h b/lib/compressor.h
index 151c43d607db..d1b43c87291f 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -19,9 +19,9 @@ struct erofs_compressor {
 
 	int (*init)(struct erofs_compress *c);
 	int (*exit)(struct erofs_compress *c);
+	int (*setlevel)(struct erofs_compress *c, int compression_level);
 
 	int (*compress_destsize)(struct erofs_compress *c,
-				 int compress_level,
 				 void *src, unsigned int *srcsize,
 				 void *dst, unsigned int dstsize);
 };
@@ -30,6 +30,7 @@ struct erofs_compress {
 	struct erofs_compressor *alg;
 
 	unsigned int compress_threshold;
+	unsigned int compression_level;
 
 	/* *_destsize specific */
 	unsigned int destsize_alignsize;
@@ -43,10 +44,11 @@ struct erofs_compress {
 extern struct erofs_compressor erofs_compressor_lz4;
 extern struct erofs_compressor erofs_compressor_lz4hc;
 
-int erofs_compress_destsize(struct erofs_compress *c, int compression_level,
+int erofs_compress_destsize(struct erofs_compress *c,
 			    void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize);
 
+int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level);
 int erofs_compressor_init(struct erofs_compress *c, char *alg_name);
 int erofs_compressor_exit(struct erofs_compress *c);
 
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index f71252ed6dca..f6832be251b2 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -13,7 +13,6 @@
 #endif
 
 static int lz4_compress_destsize(struct erofs_compress *c,
-				 int compression_level,
 				 void *src, unsigned int *srcsize,
 				 void *dst, unsigned int dstsize)
 {
diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
index 0c912fb0ea1e..fd801ab16f37 100644
--- a/lib/compressor_lz4hc.c
+++ b/lib/compressor_lz4hc.c
@@ -14,16 +14,13 @@
 #endif
 
 static int lz4hc_compress_destsize(struct erofs_compress *c,
-				   int compression_level,
-				   void *src,
-				   unsigned int *srcsize,
-				   void *dst,
-				   unsigned int dstsize)
+				   void *src, unsigned int *srcsize,
+				   void *dst, unsigned int dstsize)
 {
 	int srcSize = (int)*srcsize;
 	int rc = LZ4_compress_HC_destSize(c->private_data, src, dst,
 					  &srcSize, (int)dstsize,
-					  compression_level);
+					  c->compression_level);
 	if (!rc)
 		return -EFAULT;
 	*srcsize = srcSize;
@@ -51,11 +48,23 @@ static int compressor_lz4hc_init(struct erofs_compress *c)
 	return 0;
 }
 
+static int compressor_lz4hc_setlevel(struct erofs_compress *c,
+				     int compression_level)
+{
+	if (compression_level > LZ4HC_CLEVEL_MAX)
+		return -EINVAL;
+
+	c->compression_level = compression_level < 0 ?
+		LZ4HC_CLEVEL_DEFAULT : compression_level;
+	return 0;
+}
+
 struct erofs_compressor erofs_compressor_lz4hc = {
 	.name = "lz4hc",
 	.default_level = LZ4HC_CLEVEL_DEFAULT,
 	.best_level = LZ4HC_CLEVEL_MAX,
 	.init = compressor_lz4hc_init,
 	.exit = compressor_lz4hc_exit,
+	.setlevel = compressor_lz4hc_setlevel,
 	.compress_destsize = lz4hc_compress_destsize,
 };
-- 
2.20.1

