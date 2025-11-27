Return-Path: <linux-erofs+bounces-1437-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E6BC8D1AE
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Nov 2025 08:31:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dH7R05tTzz2yvZ;
	Thu, 27 Nov 2025 18:31:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764228700;
	cv=none; b=MWShSRRjgNLZC809pP+M69MWo9VTFlZAE5zATDcoLAZBliDA3rZvzTM3YQDws7Vg4hlDUR6NLw2+U9HRlWM9H99n8msCZsVV7ivw5R2LV3uKuJp6rp+NNO4m13NJtFsCx2TPCQyFRlFWYFk3iAi7LLn5S0vIWarXoGgphqtM4IDYCIR/QGkQp32UKHMIQGHuFkgWeaswik/1ayUoXzXl2PubaJFGHmsXTf4GmpZ2tz/Iwg1SLFSHq2eV8kzUQMxUCtNdkZKhrwTiVmh1TnB0JTEo2PpvkxuxpUF0biPhrG7XZPv2PwaARQ1SINV16NLll+NjifvYd0iDLWEV2LIpJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764228700; c=relaxed/relaxed;
	bh=eYP4A0tNr6M86hgR5CuLY8WGPXlEqWoCSWZffEWbsOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5KSkly9D11b7T0hcJnO7uyccKuKTEmLr3KdJvEbc/HNYA0RJrjtTaNJVFPTeZ1pv//v/giSfDD+Fkulyf6gUy/6qcB25Kkty7WGC01WCwZki5/Uuu8ntatqe+n8P5U4/5DwYQc4QUwmsWd7NdN3bOWIzviJabCr4RwBMEufd6f/EuAdWCWbb5L4F47QvlOGSDdNjlk8wrLDltTm20IdZWHivWIOQv72o0SeVUDdXnHSlobTEffdVi8j2x2HpLjLQ6Sof29lFKTD4EG5DgW5/V8CcZ1F2fvgd8XUES9bbcNDtnicfYiFc3HIJGQotIKagmKP3va/yJHRkOrOhdEtdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=o5W1sjMa; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=o5W1sjMa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dH7Qy0LCKz2yxk
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Nov 2025 18:31:36 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764228691; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=eYP4A0tNr6M86hgR5CuLY8WGPXlEqWoCSWZffEWbsOo=;
	b=o5W1sjMaGb6USuO0OKttkEwaAgLQUGTKPL653/9PxaoAnEKk0sbq7VgikJetj2NDRdkPRh8jwNMrdjZedxzTrawbgqu4hd7shHooPWC1wDRxZYX4N9wWK5hKOoLlyrWeJq5EGcKbVtaIRkhdYU5inPCbUWUjZhkVfQCilUJu9fY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtWGgH4_1764228690 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Nov 2025 15:31:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4/4] erofs: enable error reporting for z_erofs_fixup_insize()
Date: Thu, 27 Nov 2025 15:31:22 +0800
Message-ID: <20251127073122.2542542-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251127073122.2542542-1-hsiangkao@linux.alibaba.com>
References: <20251127073122.2542542-1-hsiangkao@linux.alibaba.com>
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

Enable propagation of detailed errors to callers.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/compress.h             |  4 ++--
 fs/erofs/decompressor.c         | 19 ++++++++++---------
 fs/erofs/decompressor_crypto.c  |  7 ++++---
 fs/erofs/decompressor_deflate.c | 19 +++++++++----------
 fs/erofs/decompressor_lzma.c    | 11 +++++------
 fs/erofs/decompressor_zstd.c    | 14 +++++++-------
 6 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 91dbc8bb5ddf..84c8e52581f4 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -72,8 +72,8 @@ struct z_erofs_stream_dctx {
 
 const char *z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx,
 				void **dst, void **src, struct page **pgpl);
-int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
-			 unsigned int padbufsize);
+const char *z_erofs_fixup_insize(struct z_erofs_decompress_req *rq,
+				 const char *padbuf, unsigned int padbufsize);
 int __init z_erofs_init_decompressor(void);
 void z_erofs_exit_decompressor(void);
 int z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 638b5f87bd0c..eb20b4a30430 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -178,18 +178,18 @@ static void *z_erofs_lz4_handle_overlap(const struct z_erofs_decompress_req *rq,
 }
 
 /*
- * Get the exact inputsize with zero_padding feature.
- *  - For LZ4, it should work if zero_padding feature is on (5.3+);
- *  - For MicroLZMA, it'd be enabled all the time.
+ * Get the exact on-disk size of the compressed data:
+ *  - For LZ4, it should apply if the zero_padding feature is on (5.3+);
+ *  - For others, zero_padding is enabled all the time.
  */
-int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
-			 unsigned int padbufsize)
+const char *z_erofs_fixup_insize(struct z_erofs_decompress_req *rq,
+				 const char *padbuf, unsigned int padbufsize)
 {
 	const char *padend;
 
 	padend = memchr_inv(padbuf, 0, padbufsize);
 	if (!padend)
-		return -EFSCORRUPTED;
+		return "compressed data start not found";
 	rq->inputsize -= padend - padbuf;
 	rq->pageofs_in += padend - padbuf;
 	return 0;
@@ -200,6 +200,7 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq, u8 *dst
 	bool support_0padding = false, may_inplace = false;
 	unsigned int inputmargin;
 	u8 *out, *headpage, *src;
+	const char *reason;
 	int ret, maptype;
 
 	DBG_BUGON(*rq->in == NULL);
@@ -208,12 +209,12 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq, u8 *dst
 	/* LZ4 decompression inplace is only safe if zero_padding is enabled */
 	if (erofs_sb_has_zero_padding(EROFS_SB(rq->sb))) {
 		support_0padding = true;
-		ret = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
+		reason = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
 				min_t(unsigned int, rq->inputsize,
 				      rq->sb->s_blocksize - rq->pageofs_in));
-		if (ret) {
+		if (reason) {
 			kunmap_local(headpage);
-			return ret;
+			return IS_ERR(reason) ? PTR_ERR(reason) : -EFSCORRUPTED;
 		}
 		may_inplace = !((rq->pageofs_in + rq->inputsize) &
 				(rq->sb->s_blocksize - 1));
diff --git a/fs/erofs/decompressor_crypto.c b/fs/erofs/decompressor_crypto.c
index 97b77ab64432..5ef6f71d3b7f 100644
--- a/fs/erofs/decompressor_crypto.c
+++ b/fs/erofs/decompressor_crypto.c
@@ -9,16 +9,17 @@ static int __z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
 	struct sg_table st_src, st_dst;
 	struct acomp_req *req;
 	struct crypto_wait wait;
+	const char *reason;
 	u8 *headpage;
 	int ret;
 
 	headpage = kmap_local_page(*rq->in);
-	ret = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
+	reason = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
 				min_t(unsigned int, rq->inputsize,
 				      rq->sb->s_blocksize - rq->pageofs_in));
 	kunmap_local(headpage);
-	if (ret)
-		return ret;
+	if (reason)
+		return IS_ERR(reason) ? PTR_ERR(reason) : -EFSCORRUPTED;
 
 	req = acomp_request_alloc(tfm);
 	if (!req)
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index afc73abd8db5..3fb73000ed27 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -103,16 +103,16 @@ static const char *__z_erofs_deflate_decompress(struct z_erofs_decompress_req *r
 	struct super_block *sb = rq->sb;
 	struct z_erofs_stream_dctx dctx = { .rq = rq, .no = -1, .ni = 0 };
 	struct z_erofs_deflate *strm;
-	const char *reason = NULL;
-	int zerr, err;
+	const char *reason;
+	int zerr;
 
 	/* 1. get the exact DEFLATE compressed size */
 	dctx.kin = kmap_local_page(*rq->in);
-	err = z_erofs_fixup_insize(rq, dctx.kin + rq->pageofs_in,
+	reason = z_erofs_fixup_insize(rq, dctx.kin + rq->pageofs_in,
 			min(rq->inputsize, sb->s_blocksize - rq->pageofs_in));
-	if (err) {
+	if (reason) {
 		kunmap_local(dctx.kin);
-		return ERR_PTR(err);
+		return reason;
 	}
 
 	/* 2. get an available DEFLATE context */
@@ -130,7 +130,7 @@ static const char *__z_erofs_deflate_decompress(struct z_erofs_decompress_req *r
 	/* 3. multi-call decompress */
 	zerr = zlib_inflateInit2(&strm->z, -MAX_WBITS);
 	if (zerr != Z_OK) {
-		err = -EINVAL;
+		reason = ERR_PTR(-EINVAL);
 		goto failed_zinit;
 	}
 
@@ -161,12 +161,11 @@ static const char *__z_erofs_deflate_decompress(struct z_erofs_decompress_req *r
 			reason = (zerr == Z_DATA_ERROR ?
 				"corrupted compressed data" :
 				"unexpected end of stream");
-			err = -EFSCORRUPTED;
 			break;
 		}
 	}
-	if (zlib_inflateEnd(&strm->z) != Z_OK && !err)
-		err = -EIO;
+	if (zlib_inflateEnd(&strm->z) != Z_OK && !reason)
+		reason = ERR_PTR(-EIO);
 	if (dctx.kout)
 		kunmap_local(dctx.kout);
 failed_zinit:
@@ -177,7 +176,7 @@ static const char *__z_erofs_deflate_decompress(struct z_erofs_decompress_req *r
 	z_erofs_deflate_head = strm;
 	spin_unlock(&z_erofs_deflate_lock);
 	wake_up(&z_erofs_deflate_wq);
-	return reason ?: ERR_PTR(err);
+	return reason;
 }
 
 static const char *z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 0161f3375efd..b4ea6978faae 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -154,16 +154,15 @@ static const char *z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 	struct xz_buf buf = {};
 	struct z_erofs_lzma *strm;
 	enum xz_ret xz_err;
-	const char *reason = NULL;
-	int err;
+	const char *reason;
 
 	/* 1. get the exact LZMA compressed size */
 	dctx.kin = kmap_local_page(*rq->in);
-	err = z_erofs_fixup_insize(rq, dctx.kin + rq->pageofs_in,
+	reason = z_erofs_fixup_insize(rq, dctx.kin + rq->pageofs_in,
 			min(rq->inputsize, sb->s_blocksize - rq->pageofs_in));
-	if (err) {
+	if (reason) {
 		kunmap_local(dctx.kin);
-		return ERR_PTR(err);
+		return reason;
 	}
 
 	/* 2. get an available lzma context */
@@ -224,7 +223,7 @@ static const char *z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 	z_erofs_lzma_head = strm;
 	spin_unlock(&z_erofs_lzma_lock);
 	wake_up(&z_erofs_lzma_wq);
-	return reason ?: ERR_PTR(err);
+	return reason;
 }
 
 const struct z_erofs_decompressor z_erofs_lzma_decomp = {
diff --git a/fs/erofs/decompressor_zstd.c b/fs/erofs/decompressor_zstd.c
index ae51faeb504d..beae49165c69 100644
--- a/fs/erofs/decompressor_zstd.c
+++ b/fs/erofs/decompressor_zstd.c
@@ -143,17 +143,17 @@ static const char *z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 	zstd_in_buffer in_buf = { NULL, 0, 0 };
 	zstd_out_buffer out_buf = { NULL, 0, 0 };
 	struct z_erofs_zstd *strm;
-	const char *reason = NULL;
 	zstd_dstream *stream;
-	int zerr, err;
+	const char *reason;
+	int zerr;
 
 	/* 1. get the exact compressed size */
 	dctx.kin = kmap_local_page(*rq->in);
-	err = z_erofs_fixup_insize(rq, dctx.kin + rq->pageofs_in,
+	reason = z_erofs_fixup_insize(rq, dctx.kin + rq->pageofs_in,
 			min(rq->inputsize, sb->s_blocksize - rq->pageofs_in));
-	if (err) {
+	if (reason) {
 		kunmap_local(dctx.kin);
-		return ERR_PTR(err);
+		return reason;
 	}
 
 	/* 2. get an available ZSTD context */
@@ -162,7 +162,7 @@ static const char *z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 	/* 3. multi-call decompress */
 	stream = zstd_init_dstream(z_erofs_zstd_max_dictsize, strm->wksp, strm->wkspsz);
 	if (!stream) {
-		err = -ENOMEM;
+		reason = ERR_PTR(-ENOMEM);
 		goto failed_zinit;
 	}
 
@@ -208,7 +208,7 @@ static const char *z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 	z_erofs_zstd_head = strm;
 	spin_unlock(&z_erofs_zstd_lock);
 	wake_up(&z_erofs_zstd_wq);
-	return reason ?: ERR_PTR(err);
+	return reason;
 }
 
 const struct z_erofs_decompressor z_erofs_zstd_decomp = {
-- 
2.43.5


