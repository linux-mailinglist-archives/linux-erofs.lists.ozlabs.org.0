Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A43E8329A8
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jan 2024 13:47:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TGfWs6nnyz3bw2
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jan 2024 23:47:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TGfWq6NRYz3bYx
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jan 2024 23:47:03 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id E30271009ACE0
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jan 2024 20:46:51 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 37799380CEF
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jan 2024 20:46:49 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 1/3] erofs-utils: mkfs: merge erofs_compressor_setlevel() into erofs_compressor_init()
Date: Fri, 19 Jan 2024 20:46:49 +0800
Message-ID: <20240119124649.62759-1-zhaoyifan@sjtu.edu.cn>
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

Currently erofs_compressor_setlevel() is only called once just after
erofs_compressor_init() while initializing compressors. Let's just hide
this interface and set the compression level in erofs_compressor_init().

Besides, we do not need to assign the {default,best}_level for an
algorithm which does not support the compression level in its
erofs_compressor struct.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
 lib/compress.c       |  6 +-----
 lib/compressor.c     | 31 +++++++++++++++++--------------
 lib/compressor.h     |  5 ++---
 lib/compressor_lz4.c |  2 --
 4 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 22782cb..3ea735c 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1206,11 +1206,7 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	for (i = 0; cfg.c_compr_alg[i]; ++i) {
 		struct erofs_compress *c = &erofs_ccfg[i].handle;
 
-		ret = erofs_compressor_init(sbi, c, cfg.c_compr_alg[i]);
-		if (ret)
-			return ret;
-
-		ret = erofs_compressor_setlevel(c, cfg.c_compr_level[i]);
+		ret = erofs_compressor_init(sbi, c, cfg.c_compr_alg[i], cfg.c_compr_level[i]);
 		if (ret)
 			return ret;
 
diff --git a/lib/compressor.c b/lib/compressor.c
index a71436a..295aa47 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -77,20 +77,8 @@ int erofs_compress_destsize(const struct erofs_compress *c,
 	return c->alg->c->compress_destsize(c, src, srcsize, dst, dstsize);
 }
 
-int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level)
-{
-	DBG_BUGON(!c->alg);
-	if (c->alg->c->setlevel)
-		return c->alg->c->setlevel(c, compression_level);
-
-	if (compression_level >= 0)
-		return -EINVAL;
-	c->compression_level = 0;
-	return 0;
-}
-
-int erofs_compressor_init(struct erofs_sb_info *sbi,
-			  struct erofs_compress *c, char *alg_name)
+int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
+			  char *alg_name, int compression_level)
 {
 	int ret, i;
 
@@ -113,6 +101,21 @@ int erofs_compressor_init(struct erofs_sb_info *sbi,
 			continue;
 
 		ret = erofs_algs[i].c->init(c);
+		if (ret)
+			return ret;
+
+		if (erofs_algs[i].c->setlevel) {
+			ret = erofs_algs[i].c->setlevel(c, compression_level);
+			if (ret) {
+				erofs_err("failed to set compression level %d for %s",
+					  compression_level, alg_name);
+				return ret;
+			}
+		} else if (compression_level >= 0) {
+			erofs_err("compression level is not supported for %s",
+				  alg_name);
+			return -EINVAL;
+		}
 		if (!ret) {
 			c->alg = &erofs_algs[i];
 			return 0;
diff --git a/lib/compressor.h b/lib/compressor.h
index 6875cf1..ec5485d 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -55,9 +55,8 @@ int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize);
 
-int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level);
-int erofs_compressor_init(struct erofs_sb_info *sbi,
-		struct erofs_compress *c, char *alg_name);
+int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
+			  char *alg_name, int compression_level);
 int erofs_compressor_exit(struct erofs_compress *c);
 
 #endif
diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
index 6677693..f4e72c3 100644
--- a/lib/compressor_lz4.c
+++ b/lib/compressor_lz4.c
@@ -37,8 +37,6 @@ static int compressor_lz4_init(struct erofs_compress *c)
 }
 
 const struct erofs_compressor erofs_compressor_lz4 = {
-	.default_level = 0,
-	.best_level = 0,
 	.init = compressor_lz4_init,
 	.exit = compressor_lz4_exit,
 	.compress_destsize = lz4_compress_destsize,
-- 
2.43.0

