Return-Path: <linux-erofs+bounces-502-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93746AF69C8
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Jul 2025 07:35:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bXlpG5DXHz30T9;
	Thu,  3 Jul 2025 15:35:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751520902;
	cv=none; b=ixAR6RpUziKVEijk5gqkm2uRH3t4ibT0RTgcgjrsMG7f1x4nZpZAR8abkl4+v6KAQ4NPH+3jRibJQ4f3jYyoCOe6nxOzNmEp9y7Ck50kPvopBfF0qi3X9fOUsdwhohZvRDRH1+2qcepCWvJ9w9WUr7Jeb153lm5rp0NJk+QEeaJQerA3uSFLIObPS/HZhytgz1u/LrHfj1ed49/fOQk6QpOyOcS/7jY18WyXS7fYDYyZZ4GUowqge2bmdzxGoD9fOpcUBhx3VJcohDvnGstLy037v6RKatUi/07b7A8BpJaiL0NrzhhRIBEmR8S0r8Nv6NVP9QHmMvrnqcFNKdwfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751520902; c=relaxed/relaxed;
	bh=QVhNTiU+vllsEtOXfRMD+7scuWVZ7OTmshcdKQrU+js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jK932L6ykUedAiwRI6OSzwOyqH62SwXrWzYQ0cG49qlN+57MKPIGqDPQ+xzF/jMdLp1DMtmehFJAgTKaTM+Ix3CRsk5FxzuTpx0ieAFwipfnb3mY9kF9LmVnLfFVel86fauznCoOythfYEZPeomGA/LH9gADAwgOBHU4pABNmFA/ZrH99LrYXXNgvt5Ek+oi1+oUWAIO0zH7J6HjItcgpQkYxO21m/8bKzOozR8Jf7xKKwkhvGOKTCNrzSJGzFTeatFI5R0QodFnQlxxy0Er1CchcRzeNI7GHbmIW6s7KRpGV4zvnVnscF8R27Y81QVIunjl3oh+Y+ujtz820xE20Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iAu4pxiv; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iAu4pxiv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bXlpD17S7z2yhb
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Jul 2025 15:34:58 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751520895; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QVhNTiU+vllsEtOXfRMD+7scuWVZ7OTmshcdKQrU+js=;
	b=iAu4pxiv88ZCHkttZF6qi2nDhIpJA9eT2lqMMrAjkQLku1h2IzBi/iyA0NND3OajMESozNFOrVzl1S5dxEDKJXwlzdhSUeVhtuvrwkCDVBshA8dUrNAb22aF6fgza7iF0d1JvRUjkpnR1TC7CPhxLCWnyoXvxbEcrpxaGchnKMM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wgta-es_1751520892 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 03 Jul 2025 13:34:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs-utils: lib: switch to on-heap fitblk_buffer for libdeflate
Date: Thu,  3 Jul 2025 13:34:46 +0800
Message-ID: <20250703053446.201941-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250703053446.201941-1-hsiangkao@linux.alibaba.com>
References: <20250703053446.201941-1-hsiangkao@linux.alibaba.com>
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
 lib/compressor_libdeflate.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/lib/compressor_libdeflate.c b/lib/compressor_libdeflate.c
index f6a7de9d..186da87c 100644
--- a/lib/compressor_libdeflate.c
+++ b/lib/compressor_libdeflate.c
@@ -9,6 +9,8 @@
 
 struct erofs_libdeflate_context {
 	struct libdeflate_compressor *strm;
+	u8 *fitblk_buffer;
+	unsigned int fitblk_bufsiz;
 	size_t last_uncompressed_size;
 };
 
@@ -38,7 +40,15 @@ static int libdeflate_compress_destsize(const struct erofs_compress *c,
 	size_t l_csize = 0;
 	size_t r = *srcsize + 1; /* smallest input that doesn't fit so far */
 	size_t m;
-	u8 tmpbuf[dstsize + 9];
+
+	if (dstsize + 9 > ctx->fitblk_bufsiz) {
+		u8 *buf = realloc(ctx->fitblk_buffer, dstsize + 9);
+
+		if (!buf)
+			return -ENOMEM;
+		ctx->fitblk_bufsiz = dstsize + 9;
+		ctx->fitblk_buffer = buf;
+	}
 
 	if (ctx->last_uncompressed_size)
 		m = ctx->last_uncompressed_size * 15 / 16;
@@ -51,11 +61,12 @@ static int libdeflate_compress_destsize(const struct erofs_compress *c,
 		m = min(m, r - 1);
 
 		csize = libdeflate_deflate_compress(ctx->strm, src, m,
-						    tmpbuf, dstsize + 9);
+						    ctx->fitblk_buffer,
+						    dstsize + 9);
 		/*printf("Tried %zu => %zu\n", m, csize);*/
 		if (csize > 0 && csize <= dstsize) {
 			/* Fits */
-			memcpy(dst, tmpbuf, csize);
+			memcpy(dst, ctx->fitblk_buffer, csize);
 			l = m;
 			l_csize = csize;
 			if (r <= l + 1 || csize +
@@ -102,6 +113,7 @@ static int compressor_libdeflate_exit(struct erofs_compress *c)
 	if (!ctx)
 		return -EINVAL;
 	libdeflate_free_compressor(ctx->strm);
+	free(ctx->fitblk_buffer);
 	free(ctx);
 	return 0;
 }
-- 
2.43.5


