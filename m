Return-Path: <linux-erofs+bounces-501-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D922AAF69C9
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Jul 2025 07:35:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bXlpG5kH0z30TG;
	Thu,  3 Jul 2025 15:35:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751520902;
	cv=none; b=Rk8B0ZofPTV2HU3zgP31C8aaFKX77MEedlojMPkEjt5sHrWcs/I7XzgRtDnom7yEqQYXr5kqYxd4d7D68NIIY/CwIsM0fAWLNBRbY4XmNC6r9isTo1Zusk86FdzT5/fj+twMkR8leyxP2OfbkpN07rSqOiXLwT7fVSlIc3GVmSHIPX0PxNUEMXNAycxu4SZH2239UsbRugOTcfwTqxCOEq8nj00Wi+ZPIqJ8V5aZOywyFIk+Vf6t3sFlC0mjt/tQVPvFi7lSo2WQ3Hy62xx41ZU/ynp++ju5LkePlJPiQeYwHwau4QhqRPQLJqdDFDfU7ckUPnUiO1wL8XL9LQPK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751520902; c=relaxed/relaxed;
	bh=TlrWTjKs0tEy7wi5FG6aoWabdB4YmlHYSTav2XY6Mg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=otHuR+C4Ixilvzp5hh4Hqq/4Oee+jDsaf6/02f7/KwlMaDtE91R37uDstHJLw+3pSbdb5EJlTdpnWWwMSv8CIR1jj+7FZOXegYB4PtXjz7CF1lpSLDB2kmytCgCantfCTUxDg0Ja3VMpRs9MpLm97Vx/NfyQyEbPlOIlCuscfpaWaKE5wH1tQ59eQqYy061bcPHDIwYn7EVNBD1nHtyTjlOQuuBd6NmHYI+wmKzyRvz5P38P9XWGAuWZPGe35ws8il7ykUCWy58Iw7tlZXT4FpGz2SxxnDhdk7GQRS8PjoTWstQw81hyenITUQiq1Uk6bVJxQjUC87S6XN/R5JUp6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BGRvyOUi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BGRvyOUi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bXlpD0FgTz2yhX
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Jul 2025 15:34:58 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751520894; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TlrWTjKs0tEy7wi5FG6aoWabdB4YmlHYSTav2XY6Mg4=;
	b=BGRvyOUiUhy/9VlmZMoxAijz0iqBlNfiq6NnI/gNFnfU+AAdwy4nhK5Xg1xoPFwvUMKfn/G/LjjjslGqQ09Upxh4SSjxq3uy30Eg4w7uNrmHaKyqX/N+mAFXbfDNf1uRl28aaUdROTJSuTRsC7k9GE6f7SHmRfNwvyZcqW4vens=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wgta-dT_1751520888 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 03 Jul 2025 13:34:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: lib: switch to on-heap fitblk_buffer for libzstd
Date: Thu,  3 Jul 2025 13:34:45 +0800
Message-ID: <20250703053446.201941-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

 - Allocating VLAs on the stack (or using alloca()) for large sizes
   could exceed the stack limit;

 - It's easier to isolate these buffers on the heap for code sanitizers
   to detect potential bugs.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compressor_libzstd.c | 83 +++++++++++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 23 deletions(-)

diff --git a/lib/compressor_libzstd.c b/lib/compressor_libzstd.c
index e53b1a63..3233d723 100644
--- a/lib/compressor_libzstd.c
+++ b/lib/compressor_libzstd.c
@@ -4,18 +4,24 @@
 #include "erofs/config.h"
 #include <zstd.h>
 #include <zstd_errors.h>
-#include <alloca.h>
+#include <stdlib.h>
 #include "compressor.h"
 #include "erofs/atomic.h"
 
+struct erofs_libzstd_context {
+	ZSTD_CCtx *cctx;
+	u8 *fitblk_buffer;
+	unsigned int fitblk_bufsiz;
+};
+
 static int libzstd_compress(const struct erofs_compress *c,
 			    const void *src, unsigned int srcsize,
 			    void *dst, unsigned int dstcapacity)
 {
-	ZSTD_CCtx *cctx = c->private_data;
+	struct erofs_libzstd_context *ctx = c->private_data;
 	size_t csize;
 
-	csize = ZSTD_compress2(cctx, dst, dstcapacity, src, srcsize);
+	csize = ZSTD_compress2(ctx->cctx, dst, dstcapacity, src, srcsize);
 	if (ZSTD_isError(csize)) {
 		if (ZSTD_getErrorCode(csize) == ZSTD_error_dstSize_tooSmall)
 			return -ENOSPC;
@@ -29,12 +35,20 @@ static int libzstd_compress_destsize(const struct erofs_compress *c,
 				     const void *src, unsigned int *srcsize,
 				     void *dst, unsigned int dstsize)
 {
-	ZSTD_CCtx *cctx = c->private_data;
+	struct erofs_libzstd_context *ctx = c->private_data;
 	size_t l = 0;		/* largest input that fits so far */
 	size_t l_csize = 0;
 	size_t r = *srcsize + 1; /* smallest input that doesn't fit so far */
 	size_t m;
-	u8 *fitblk_buffer = alloca(dstsize + 32);
+
+	if (dstsize + 32 > ctx->fitblk_bufsiz) {
+		u8 *buf = realloc(ctx->fitblk_buffer, dstsize + 32);
+
+		if (!buf)
+			return -ENOMEM;
+		ctx->fitblk_bufsiz = dstsize + 32;
+		ctx->fitblk_buffer = buf;
+	}
 
 	m = dstsize * 4;
 	for (;;) {
@@ -43,7 +57,7 @@ static int libzstd_compress_destsize(const struct erofs_compress *c,
 		m = max(m, l + 1);
 		m = min(m, r - 1);
 
-		csize = ZSTD_compress2(cctx, fitblk_buffer,
+		csize = ZSTD_compress2(ctx->cctx, ctx->fitblk_buffer,
 				       dstsize + 32, src, m);
 		if (ZSTD_isError(csize)) {
 			if (ZSTD_getErrorCode(csize) == ZSTD_error_dstSize_tooSmall)
@@ -53,7 +67,7 @@ static int libzstd_compress_destsize(const struct erofs_compress *c,
 
 		if (csize > 0 && csize <= dstsize) {
 			/* Fits */
-			memcpy(dst, fitblk_buffer, csize);
+			memcpy(dst, ctx->fitblk_buffer, csize);
 			l = m;
 			l_csize = csize;
 			if (r <= l + 1 || csize + 1 >= dstsize)
@@ -78,9 +92,14 @@ doesnt_fit:
 
 static int compressor_libzstd_exit(struct erofs_compress *c)
 {
-	if (!c->private_data)
+	struct erofs_libzstd_context *ctx = c->private_data;
+
+	if (!ctx)
 		return -EINVAL;
-	ZSTD_freeCCtx(c->private_data);
+
+	free(ctx->fitblk_buffer);
+	ZSTD_freeCCtx(ctx->cctx);
+	free(ctx);
 	return 0;
 }
 
@@ -118,27 +137,41 @@ static int erofs_compressor_libzstd_setdictsize(struct erofs_compress *c,
 
 static int compressor_libzstd_init(struct erofs_compress *c)
 {
+	struct erofs_libzstd_context *ctx = c->private_data;
 	static erofs_atomic_bool_t __warnonce;
-	ZSTD_CCtx *cctx = c->private_data;
-	size_t err;
+	ZSTD_CCtx *cctx;
+	size_t errcode;
+	int err;
 
-	ZSTD_freeCCtx(cctx);
+	if (ctx) {
+		ZSTD_freeCCtx(ctx->cctx);
+		ctx->cctx = NULL;
+		c->private_data = NULL;
+	} else {
+		ctx = calloc(1, sizeof(*ctx));
+		if (!ctx)
+			return -ENOMEM;
+	}
 	cctx = ZSTD_createCCtx();
-	if (!cctx)
-		return -ENOMEM;
+	if (!cctx) {
+		err = -ENOMEM;
+		goto out_err;
+	}
 
-	err = ZSTD_CCtx_setParameter(cctx, ZSTD_c_compressionLevel, c->compression_level);
-	if (ZSTD_isError(err)) {
+	err = -EINVAL;
+	errcode = ZSTD_CCtx_setParameter(cctx, ZSTD_c_compressionLevel, c->compression_level);
+	if (ZSTD_isError(errcode)) {
 		erofs_err("failed to set compression level: %s",
-			  ZSTD_getErrorName(err));
-		return -EINVAL;
+			  ZSTD_getErrorName(errcode));
+		goto out_err;
 	}
-	err = ZSTD_CCtx_setParameter(cctx, ZSTD_c_windowLog, ilog2(c->dict_size));
-	if (ZSTD_isError(err)) {
-		erofs_err("failed to set window log: %s", ZSTD_getErrorName(err));
-		return -EINVAL;
+	errcode = ZSTD_CCtx_setParameter(cctx, ZSTD_c_windowLog, ilog2(c->dict_size));
+	if (ZSTD_isError(errcode)) {
+		erofs_err("failed to set window log: %s", ZSTD_getErrorName(errcode));
+		goto out_err;
 	}
-	c->private_data = cctx;
+	ctx->cctx = cctx;
+	c->private_data = ctx;
 
 	if (!erofs_atomic_test_and_set(&__warnonce)) {
 		erofs_warn("EXPERIMENTAL libzstd compressor in use. Note that `fitblk` isn't supported by upstream zstd for now.");
@@ -146,6 +179,10 @@ static int compressor_libzstd_init(struct erofs_compress *c)
 		erofs_info("You could clarify further needs in zstd repository <https://github.com/facebook/zstd/issues> for reference too.");
 	}
 	return 0;
+out_err:
+	ZSTD_freeCCtx(cctx);
+	free(ctx);
+	return err;
 }
 
 const struct erofs_compressor erofs_compressor_libzstd = {
-- 
2.43.5


