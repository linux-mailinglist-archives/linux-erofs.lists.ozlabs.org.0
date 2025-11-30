Return-Path: <linux-erofs+bounces-1456-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBD1C951FD
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Nov 2025 16:54:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dKBRr4fsjz2yvL;
	Mon, 01 Dec 2025 02:54:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764518072;
	cv=none; b=ArpU3BkDbO7KlBdlMBEchOCJWHZgu3Qm6rexkOShmRP0DfxelXoJZWjFCDXjMDPaqb5p9t3OVgWmvfRv+dRaM3tUkalKkH384L27ag5ygDJL+t4n+wCTXBn+b2UU8ddIGm20ZYieWmioOPFd5FQeiNcuydCjOqlXjDHui+rOg+6raZCIO/cYV6MPY1Qju4eUC7XH6btZjaOBbmsaQhsDU5pWiRp0fFz4sn1l+PIvGOjHSDng/oxozU2+6M++tS+u6mao1Ap9Jmx55O8ye91GlKMqBI9cJ6Fakpjhs+eyRD1r1LaD7c+obrbisVgCH0MJQB61GqWHjarLJSFkdeBSfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764518072; c=relaxed/relaxed;
	bh=ethj5625gCPyVpGqCOwfmpElVhC6VJwiLvqgUHKBeRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PInBgzv2+ZzdUg3x6+9UYg1uJLPz2WNstt5UmUmGKdmVZASHII1Cq0FQmpMeAsxOVdV9wfhM2JyufBCg9b5Z7pOFMjWgUIRHj4IVOOoYoDrVRbI5MyBZlch0I9eXUpBeHaeKsVsjz3lvXXOzRlftwNoPb0Mcb/NKI8zwU9qL4JdUOLTMf9mK6dDqdpwDKQC96ckIWurOs9D1rrRwsAb2NuevIMTCVhhMNiZtUtecgBgCMVs+//+hUwuz3lvilj6PE4WxFLGBx+CiMN2x+0L/Phz19jG9kQ+1LhMrxa3it7lg1NRpKwPiUN84nYRGR6l5KYoKIKiGWLqc1FvNJBIslg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U/HcV24u; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U/HcV24u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dKBRq34lMz2ynW
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Dec 2025 02:54:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F29F560007;
	Sun, 30 Nov 2025 15:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBA8C4CEF8;
	Sun, 30 Nov 2025 15:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764518068;
	bh=GrluOcWGm5wmpX2Dc8MkVir3inWL74EVxKHLm8x77Uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/HcV24uZVZ/y8lcsJW+6u1xS3NmWV0idKQ2bCeu8nNTPlpWObVanlQIcdbh2pNx+
	 3TMmRB7LxynzAArau6NJKJotDkbPPPH4ggdR++LP1pcxdwV22VVMkrYtFJe3z+n3vr
	 ZGoq1N7eeMPnbx4Qctu1psNw3UWQdjnEImLB5jXrtkAe1sFEezUTeObgsDLT79GwVb
	 H+NRE7MYw/AUZmeYbHZvteUxN2OHHVbAd8uy6iwjM9CERDwZxppOHxmxzpURi4xOZO
	 R5MXG6mPLQRNGOeu7VFx/RsoL6DpbXEMk+AQKKAdHhl3i57Sl/6TOajVjAlVOS5Ylu
	 XaGmnhcyjLcNw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 4/4] erofs: enable error reporting for z_erofs_fixup_insize()
Date: Sun, 30 Nov 2025 23:53:42 +0800
Message-Id: <20251130155342.1416-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20251127073122.2542542-4-hsiangkao@linux.alibaba.com>
References: <20251127073122.2542542-4-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Enable propagation of detailed errors to callers.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - fix sparse warning:
    "Using plain integer as NULL pointer"

 fs/erofs/compress.h             |  4 ++--
 fs/erofs/decompressor.c         | 21 +++++++++++----------
 fs/erofs/decompressor_crypto.c  |  7 ++++---
 fs/erofs/decompressor_deflate.c | 19 +++++++++----------
 fs/erofs/decompressor_lzma.c    | 11 +++++------
 fs/erofs/decompressor_zstd.c    | 14 +++++++-------
 6 files changed, 38 insertions(+), 38 deletions(-)

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
index 638b5f87bd0c..d5d090276391 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -178,21 +178,21 @@ static void *z_erofs_lz4_handle_overlap(const struct z_erofs_decompress_req *rq,
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
-	return 0;
+	return NULL;
 }
 
 static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq, u8 *dst)
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
2.30.2


