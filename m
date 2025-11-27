Return-Path: <linux-erofs+bounces-1438-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968D5C8D1B1
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Nov 2025 08:31:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dH7R13vphz2yxk;
	Thu, 27 Nov 2025 18:31:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764228701;
	cv=none; b=h1z9rjYEMCRbdkWfh6g7wg18CJI4EILa4jFwr8FWty3Jp/k3Kj/PM+oITWnd2VpvU7Mcy3O9eZ5A9xqZ7WqATpldo50gnyGOd+k8/dLkaEezR+TnnJXLuQRc9kpW9bhlTByCqtCbxefixXDpNacuVOqQVC73MuytjbuWXreRwVdml2EoSfXrxDFZFRbf1mKNIalDHijZP5ZHRTKIMJBYK6k8PH2mnGT37Hle5yoqU4eTGE1z/T1nEC39r0tqqLCvrJIMS4HEPfDZj4EPKOL0hQm8QnUXQ0D4URbivWVKE7OQ0PmmnkvK+oyhDlhxPohUoA5BArv4Z1l5mP1Xf5mzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764228701; c=relaxed/relaxed;
	bh=PiKulZPrQ+M7JuXQdU84bUWaRfmbV/6y+O/0x/7h4mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ya4IT+sw6p0Ou0TKSqhD+2fp9THGAkyqSayjJE0enV3a5YGZxIYZ1D/Swog8x5BNnVDy2RoK1niy2Xt+TQoSRCrpvYlgLuBd7hpyTCSalImPJhkbOLVn2syd0shSmplqeKlK/uvLWhsY1ZFBVTTvMUI4Sjf5IlE4LGbk1rqDCTOkmrfnQZK2dkkhVhsd1P7YOFND1LRxJZjNvuDWkPUQZLUKkOH5Ee0ZgjN6nO6hqbpLFWl12FpqKwnNGP/ILZpUMndN5CXEPw31DXDV+1U+ubU7jAIn+fltvnDdUxENrjGwtdpD9jF4QLCqxlLmt9BASrz77WKDDlCfJbVzxFH+Vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=USgcHJDW; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=USgcHJDW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dH7Qx6Wfzz2yx7
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Nov 2025 18:31:36 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764228691; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=PiKulZPrQ+M7JuXQdU84bUWaRfmbV/6y+O/0x/7h4mg=;
	b=USgcHJDWrzHKaFOVg5FImWQQXcGUmfM/ZUuullnfSA3Jz0p5JOsaR0OuqkSaF/4DK7QYX5DVrXcgGAZ+hXm4wEKGJa5jsMyDfCnCvI4MyAFEJ96oKgPZ8tTWZAzQuXkrwJz2ZxLhWfSYplyCgamsvOZePmwds38geWh1Kolw6uo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtWGgFg_1764228688 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Nov 2025 15:31:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/4] erofs: improve Zstd, LZMA and DEFLATE error strings
Date: Thu, 27 Nov 2025 15:31:20 +0800
Message-ID: <20251127073122.2542542-2-hsiangkao@linux.alibaba.com>
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

Enable better, more detailed, and unique error reporting.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor_deflate.c | 16 ++++++++++------
 fs/erofs/decompressor_lzma.c    |  7 +++++--
 fs/erofs/decompressor_zstd.c    |  8 +++++---
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index e9c4b740ef89..46cc1fd19bce 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -97,12 +97,13 @@ static int z_erofs_load_deflate_config(struct super_block *sb,
 	return -ENOMEM;
 }
 
-static int __z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
-					struct page **pgpl)
+static const char *__z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
+						struct page **pgpl)
 {
 	struct super_block *sb = rq->sb;
 	struct z_erofs_stream_dctx dctx = { .rq = rq, .no = -1, .ni = 0 };
 	struct z_erofs_deflate *strm;
+	const char *reason = NULL;
 	int zerr, err;
 
 	/* 1. get the exact DEFLATE compressed size */
@@ -111,7 +112,7 @@ static int __z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 			min(rq->inputsize, sb->s_blocksize - rq->pageofs_in));
 	if (err) {
 		kunmap_local(dctx.kin);
-		return err;
+		return ERR_PTR(err);
 	}
 
 	/* 2. get an available DEFLATE context */
@@ -129,7 +130,7 @@ static int __z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 	/* 3. multi-call decompress */
 	zerr = zlib_inflateInit2(&strm->z, -MAX_WBITS);
 	if (zerr != Z_OK) {
-		err = -EIO;
+		err = -EINVAL;
 		goto failed_zinit;
 	}
 
@@ -157,6 +158,9 @@ static int __z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 				break;
 			if (zerr == Z_STREAM_END && !rq->outputsize)
 				break;
+			reason = (zerr == Z_DATA_ERROR ?
+				"corrupted compressed data" :
+				"unexpected end of stream");
 			err = -EFSCORRUPTED;
 			break;
 		}
@@ -173,7 +177,7 @@ static int __z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 	z_erofs_deflate_head = strm;
 	spin_unlock(&z_erofs_deflate_lock);
 	wake_up(&z_erofs_deflate_wq);
-	return err;
+	return reason ?: ERR_PTR(err);
 }
 
 static const char *z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
@@ -189,7 +193,7 @@ static const char *z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 
 	}
 #endif
-	return ERR_PTR(__z_erofs_deflate_decompress(rq, pgpl));
+	return __z_erofs_deflate_decompress(rq, pgpl);
 }
 
 const struct z_erofs_decompressor z_erofs_deflate_decomp = {
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 7784ced90145..98a8c22cdbde 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -154,6 +154,7 @@ static const char *z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 	struct xz_buf buf = {};
 	struct z_erofs_lzma *strm;
 	enum xz_ret xz_err;
+	const char *reason = NULL;
 	int err;
 
 	/* 1. get the exact LZMA compressed size */
@@ -207,7 +208,9 @@ static const char *z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 		if (xz_err != XZ_OK) {
 			if (xz_err == XZ_STREAM_END && !rq->outputsize)
 				break;
-			err = -EFSCORRUPTED;
+			reason = (xz_err == XZ_DATA_ERROR ?
+				"corrupted compressed data" :
+				"unexpected end of stream");
 			break;
 		}
 	} while (1);
@@ -221,7 +224,7 @@ static const char *z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 	z_erofs_lzma_head = strm;
 	spin_unlock(&z_erofs_lzma_lock);
 	wake_up(&z_erofs_lzma_wq);
-	return ERR_PTR(err);
+	return reason ?: ERR_PTR(err);
 }
 
 const struct z_erofs_decompressor z_erofs_lzma_decomp = {
diff --git a/fs/erofs/decompressor_zstd.c b/fs/erofs/decompressor_zstd.c
index 50fadff89cbc..aff6825cacde 100644
--- a/fs/erofs/decompressor_zstd.c
+++ b/fs/erofs/decompressor_zstd.c
@@ -143,6 +143,7 @@ static const char *z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 	zstd_in_buffer in_buf = { NULL, 0, 0 };
 	zstd_out_buffer out_buf = { NULL, 0, 0 };
 	struct z_erofs_zstd *strm;
+	const char *reason = NULL;
 	zstd_dstream *stream;
 	int zerr, err;
 
@@ -161,7 +162,7 @@ static const char *z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 	/* 3. multi-call decompress */
 	stream = zstd_init_dstream(z_erofs_zstd_max_dictsize, strm->wksp, strm->wkspsz);
 	if (!stream) {
-		err = -EIO;
+		err = -ENOMEM;
 		goto failed_zinit;
 	}
 
@@ -191,7 +192,8 @@ static const char *z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 		if (zstd_is_error(zerr) ||
 		    ((rq->outputsize + dctx.avail_out) && (!zerr || (zerr > 0 &&
 				!(rq->inputsize + in_buf.size - in_buf.pos))))) {
-			err = -EFSCORRUPTED;
+			reason = zstd_is_error(zerr) ? zstd_get_error_name(zerr) :
+					"unexpected end of stream";
 			break;
 		}
 	} while (rq->outputsize + dctx.avail_out);
@@ -206,7 +208,7 @@ static const char *z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 	z_erofs_zstd_head = strm;
 	spin_unlock(&z_erofs_zstd_lock);
 	wake_up(&z_erofs_zstd_wq);
-	return ERR_PTR(err);
+	return reason ?: ERR_PTR(err);
 }
 
 const struct z_erofs_decompressor z_erofs_zstd_decomp = {
-- 
2.43.5


