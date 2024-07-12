Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 146BC92F816
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jul 2024 11:38:39 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=At8SN6z5;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WL63b4tNvz3bX3
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jul 2024 19:38:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=At8SN6z5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WL63M6fbZz30Wn
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jul 2024 19:38:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720777096; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/SYIKDo1xUyrKFXwyEHeGF1JOr02lSWrchxLv7jIEdo=;
	b=At8SN6z5yWXc68NZp/Qeku5ichOSuVcq+iXefHOsyiWNd1pUWzPWCv7OyuXalPgTUTRgUDESk5Ov0EwoMjuOcN3SRP6stJXDsN7qCp5/flppCAK3SXsJODIEz1049EFIS+aZfPyOvz/Qr/vO6ygKVWXNi8BCYxHHfT6ThjMewiQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WANvAgj_1720777089;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WANvAgj_1720777089)
          by smtp.aliyun-inc.com;
          Fri, 12 Jul 2024 17:38:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: fix reproducible builds for multi-threaded libdeflate
Date: Fri, 12 Jul 2024 17:38:07 +0800
Message-ID: <20240712093808.2986196-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

`last_uncompressed_size` should be reset on the basis of segments.

Fixes: 830b27bc2334 ("erofs-utils: mkfs: introduce inner-file multi-threaded compression")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c              |  2 +-
 lib/compressor.c            |  6 +++++
 lib/compressor.h            |  2 ++
 lib/compressor_libdeflate.c | 46 +++++++++++++++++++++++++++----------
 4 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index b473587..b61907a 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1245,7 +1245,7 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 	sctx->queue = tls->queue;
 	sctx->destbuf = tls->destbuf;
 	sctx->chandle = &tls->ccfg[cwork->alg_id].handle;
-
+	erofs_compressor_reset(sctx->chandle);
 	sctx->membuf = malloc(round_up(sctx->remaining, erofs_blksiz(sbi)));
 	if (!sctx->membuf) {
 		ret = -ENOMEM;
diff --git a/lib/compressor.c b/lib/compressor.c
index 24c99ac..41f49ff 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -155,3 +155,9 @@ int erofs_compressor_exit(struct erofs_compress *c)
 		return c->alg->c->exit(c);
 	return 0;
 }
+
+void erofs_compressor_reset(struct erofs_compress *c)
+{
+	if (c->alg && c->alg->c->reset)
+		c->alg->c->reset(c);
+}
diff --git a/lib/compressor.h b/lib/compressor.h
index 59d525d..8d322d5 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -19,6 +19,7 @@ struct erofs_compressor {
 
 	int (*init)(struct erofs_compress *c);
 	int (*exit)(struct erofs_compress *c);
+	void (*reset)(struct erofs_compress *c);
 	int (*setlevel)(struct erofs_compress *c, int compression_level);
 	int (*setdictsize)(struct erofs_compress *c, u32 dict_size);
 
@@ -63,5 +64,6 @@ int erofs_compress_destsize(const struct erofs_compress *c,
 int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
 			  char *alg_name, int compression_level, u32 dict_size);
 int erofs_compressor_exit(struct erofs_compress *c);
+void erofs_compressor_reset(struct erofs_compress *c);
 
 #endif
diff --git a/lib/compressor_libdeflate.c b/lib/compressor_libdeflate.c
index 14cbce4..32e8ff9 100644
--- a/lib/compressor_libdeflate.c
+++ b/lib/compressor_libdeflate.c
@@ -3,22 +3,28 @@
 #include "erofs/print.h"
 #include "erofs/config.h"
 #include <libdeflate.h>
+#include <stdlib.h>
 #include "compressor.h"
 #include "erofs/atomic.h"
 
+struct erofs_libdeflate_context {
+	struct libdeflate_compressor *strm;
+	size_t last_uncompressed_size;
+};
+
 static int libdeflate_compress_destsize(const struct erofs_compress *c,
 				        const void *src, unsigned int *srcsize,
 				        void *dst, unsigned int dstsize)
 {
-	static size_t last_uncompressed_size = 0;
+	struct erofs_libdeflate_context *ctx = c->private_data;
 	size_t l = 0; /* largest input that fits so far */
 	size_t l_csize = 0;
 	size_t r = *srcsize + 1; /* smallest input that doesn't fit so far */
 	size_t m;
 	u8 tmpbuf[dstsize + 9];
 
-	if (last_uncompressed_size)
-		m = last_uncompressed_size * 15 / 16;
+	if (ctx->last_uncompressed_size)
+		m = ctx->last_uncompressed_size * 15 / 16;
 	else
 		m = dstsize * 4;
 	for (;;) {
@@ -27,7 +33,7 @@ static int libdeflate_compress_destsize(const struct erofs_compress *c,
 		m = max(m, l + 1);
 		m = min(m, r - 1);
 
-		csize = libdeflate_deflate_compress(c->private_data, src, m,
+		csize = libdeflate_deflate_compress(ctx->strm, src, m,
 						    tmpbuf, dstsize + 9);
 		/*printf("Tried %zu => %zu\n", m, csize);*/
 		if (csize > 0 && csize <= dstsize) {
@@ -68,33 +74,48 @@ static int libdeflate_compress_destsize(const struct erofs_compress *c,
 
 	/*printf("Choosing %zu => %zu\n", l, l_csize);*/
 	*srcsize = l;
-	last_uncompressed_size = l;
+	ctx->last_uncompressed_size = l;
 	return l_csize;
 }
 
 static int compressor_libdeflate_exit(struct erofs_compress *c)
 {
-	if (!c->private_data)
-		return -EINVAL;
+	struct erofs_libdeflate_context *ctx = c->private_data;
 
-	libdeflate_free_compressor(c->private_data);
+	if (!ctx)
+		return -EINVAL;
+	libdeflate_free_compressor(ctx->strm);
+	free(ctx);
 	return 0;
 }
 
 static int compressor_libdeflate_init(struct erofs_compress *c)
 {
 	static erofs_atomic_bool_t __warnonce;
+	struct erofs_libdeflate_context *ctx;
 
-	libdeflate_free_compressor(c->private_data);
-	c->private_data = libdeflate_alloc_compressor(c->compression_level);
-	if (!c->private_data)
+	DBG_BUGON(c->private_data);
+	ctx = calloc(1, sizeof(struct erofs_libdeflate_context));
+	if (!ctx)
 		return -ENOMEM;
-
+	ctx->strm = libdeflate_alloc_compressor(c->compression_level);
+	if (!ctx->strm) {
+		free(ctx);
+		return -ENOMEM;
+	}
+	c->private_data = ctx;
 	if (!erofs_atomic_test_and_set(&__warnonce))
 		erofs_warn("EXPERIMENTAL libdeflate compressor in use. Use at your own risk!");
 	return 0;
 }
 
+static void compressor_libdeflate_reset(struct erofs_compress *c)
+{
+	struct erofs_libdeflate_context *ctx = c->private_data;
+
+	ctx->last_uncompressed_size = 0;
+}
+
 static int erofs_compressor_libdeflate_setlevel(struct erofs_compress *c,
 						int compression_level)
 {
@@ -114,6 +135,7 @@ const struct erofs_compressor erofs_compressor_libdeflate = {
 	.best_level = 12,
 	.init = compressor_libdeflate_init,
 	.exit = compressor_libdeflate_exit,
+	.reset = compressor_libdeflate_reset,
 	.setlevel = erofs_compressor_libdeflate_setlevel,
 	.compress_destsize = libdeflate_compress_destsize,
 };
-- 
2.43.5

