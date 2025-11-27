Return-Path: <linux-erofs+bounces-1436-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5197AC8D1AB
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Nov 2025 08:31:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dH7R04k0pz302V;
	Thu, 27 Nov 2025 18:31:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764228700;
	cv=none; b=O8yVYvRo5HKJiUNdH3CrIrL/cHDBNkowAWM4v0IVhME+fs62Sa9FImMmSUi+DlyvQ1iObzGUJ0o8EfW6yVihcOjGirHoE1GtHqqBo+UzF05r9NRRt4WRWaQYMC7ORo+rjUDfrKuomgcSFe55fxAXjXzoNf/WCqX9KXgdq9WD0+dacYrTu/UDmsnhkQnMWlpse6pU1ClRcWNldOrkNGHf+Mpf7YhBsEPy4orNmOkHz+oZ05EHR6N7qmntqLNWV3//9cQItuLCqDAGPMdDthfjR6r4b1ng2OMZTtB4yiQkhVi/XOWLVJGksPRey3WZ9+TMrHdMnUbdHRS1FS81VqrBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764228700; c=relaxed/relaxed;
	bh=JU+ZuoMMBdU8Gtj0MTJWgkFuagf7KhgmVgnm1XSAkXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zvb78rTQl46ZhTSI70bkxIil8bSUNPoCFkDCNpoOkuHEeaEUBFu3/H/NvXtX9GcFVC6//7i+dRzuVKqoAjIPLrYxs1LkWTREz+J+SembTurNF6MyVhHkyFyVxdevZSKJC/9sd4MUNWSV4Rw/AM2rRKNRghg+C/zSQYjZpUaJaWhlo75lcO6AyOVHxGon/NvXEcMjzIyqoT2URezfAlXaSuGwyt/M0+DWUZ9GDv3rCu5+itPzhzDHGuaRl/jzj7j+N6UW3R/DJaMM/kw+Oqxap8r2f/XZNwET/PC2dr0YsX994n0nmKfqYlnA1JMtxEa6NGMpwT7Ws3ZrAQaC2H5f+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=f5lT1FHb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=f5lT1FHb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dH7Qx6TYTz2yvZ
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Nov 2025 18:31:36 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764228691; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JU+ZuoMMBdU8Gtj0MTJWgkFuagf7KhgmVgnm1XSAkXo=;
	b=f5lT1FHbjPHQzseQz10aE4iw02xuHgcGMSP48RYg6X0cUPHNFxLw0Ep3AnkGkS+UsFPRoyRxNwqNfz1hDSVRxzHAMYrgwCHsJi3Ltf2LnO9kTSBgqSwGwCoht8huGJBu6L44fu8cdokTC2Hf4eSU2izF6KhnfpSs9l/IlevfP0E=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtWGgCX_1764228683 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Nov 2025 15:31:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/4] erofs: improve decompression error reporting
Date: Thu, 27 Nov 2025 15:31:19 +0800
Message-ID: <20251127073122.2542542-1-hsiangkao@linux.alibaba.com>
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

Change the return type of decompress() from `int` to `const char *` to
provide more informative error diagnostics:

 - A NULL return indicates successful decompression;

 - If IS_ERR(ptr) is true, the return value encodes a standard negative
   errno (e.g., -ENOMEM, -EOPNOTSUPP) identifying the specific error;

 - Otherwise, a non-NULL return points to a human-readable error string,
   and the corresponding error code should be treated as -EFSCORRUPTED.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/compress.h             |  4 ++--
 fs/erofs/decompressor.c         | 20 +++++++++-----------
 fs/erofs/decompressor_deflate.c | 10 ++++------
 fs/erofs/decompressor_lzma.c    | 10 ++++------
 fs/erofs/decompressor_zstd.c    | 12 ++++--------
 fs/erofs/zdata.c                | 21 +++++++++++++++++----
 6 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 510e922c5193..1ee4ad934c1f 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -23,8 +23,8 @@ struct z_erofs_decompress_req {
 struct z_erofs_decompressor {
 	int (*config)(struct super_block *sb, struct erofs_super_block *dsb,
 		      void *data, int size);
-	int (*decompress)(struct z_erofs_decompress_req *rq,
-			  struct page **pagepool);
+	const char *(*decompress)(struct z_erofs_decompress_req *rq,
+				  struct page **pagepool);
 	int (*init)(void);
 	void (*exit)(void);
 	char *name;
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 2f4cef67cf64..f9d29f43666f 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -235,8 +235,6 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq, u8 *dst
 					  rq->inputsize, rq->outputsize);
 
 	if (ret != rq->outputsize) {
-		erofs_err(rq->sb, "failed to decompress %d in[%u, %u] out[%u]",
-			  ret, rq->inputsize, inputmargin, rq->outputsize);
 		if (ret >= 0)
 			memset(out + ret, 0, rq->outputsize - ret);
 		ret = -EFSCORRUPTED;
@@ -257,8 +255,8 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq, u8 *dst
 	return ret;
 }
 
-static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
-				  struct page **pagepool)
+static const char *z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
+					  struct page **pagepool)
 {
 	unsigned int dst_maptype;
 	void *dst;
@@ -273,14 +271,14 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 		/* general decoding path which can be used for all cases */
 		ret = z_erofs_lz4_prepare_dstpages(rq, pagepool);
 		if (ret < 0)
-			return ret;
+			return ERR_PTR(ret);
 		if (ret > 0) {
 			dst = page_address(*rq->out);
 			dst_maptype = 1;
 		} else {
 			dst = erofs_vm_map_ram(rq->out, rq->outpages);
 			if (!dst)
-				return -ENOMEM;
+				return ERR_PTR(-ENOMEM);
 			dst_maptype = 2;
 		}
 	}
@@ -289,11 +287,11 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 		kunmap_local(dst);
 	else if (dst_maptype == 2)
 		vm_unmap_ram(dst, rq->outpages);
-	return ret;
+	return ERR_PTR(ret);
 }
 
-static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
-				   struct page **pagepool)
+static const char *z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
+					   struct page **pagepool)
 {
 	const unsigned int nrpages_in = rq->inpages, nrpages_out = rq->outpages;
 	const unsigned int bs = rq->sb->s_blocksize;
@@ -301,7 +299,7 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	u8 *kin;
 
 	if (rq->outputsize > rq->inputsize)
-		return -EOPNOTSUPP;
+		return ERR_PTR(-EOPNOTSUPP);
 	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
 		cur = bs - (rq->pageofs_out & (bs - 1));
 		pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;
@@ -341,7 +339,7 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 		kunmap_local(kin);
 	}
 	DBG_BUGON(ni > nrpages_in);
-	return 0;
+	return NULL;
 }
 
 int z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx, void **dst,
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 6909b2d529c7..e9c4b740ef89 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -157,8 +157,6 @@ static int __z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 				break;
 			if (zerr == Z_STREAM_END && !rq->outputsize)
 				break;
-			erofs_err(sb, "failed to decompress %d in[%u] out[%u]",
-				  zerr, rq->inputsize, rq->outputsize);
 			err = -EFSCORRUPTED;
 			break;
 		}
@@ -178,8 +176,8 @@ static int __z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 	return err;
 }
 
-static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
-				      struct page **pgpl)
+static const char *z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
+					      struct page **pgpl)
 {
 #ifdef CONFIG_EROFS_FS_ZIP_ACCEL
 	int err;
@@ -187,11 +185,11 @@ static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 	if (!rq->partial_decoding) {
 		err = z_erofs_crypto_decompress(rq, pgpl);
 		if (err != -EOPNOTSUPP)
-			return err;
+			return ERR_PTR(err);
 
 	}
 #endif
-	return __z_erofs_deflate_decompress(rq, pgpl);
+	return ERR_PTR(__z_erofs_deflate_decompress(rq, pgpl));
 }
 
 const struct z_erofs_decompressor z_erofs_deflate_decomp = {
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 832cffb83a66..7784ced90145 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -146,8 +146,8 @@ static int z_erofs_load_lzma_config(struct super_block *sb,
 	return err;
 }
 
-static int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
-				   struct page **pgpl)
+static const char *z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
+					   struct page **pgpl)
 {
 	struct super_block *sb = rq->sb;
 	struct z_erofs_stream_dctx dctx = { .rq = rq, .no = -1, .ni = 0 };
@@ -162,7 +162,7 @@ static int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 			min(rq->inputsize, sb->s_blocksize - rq->pageofs_in));
 	if (err) {
 		kunmap_local(dctx.kin);
-		return err;
+		return ERR_PTR(err);
 	}
 
 	/* 2. get an available lzma context */
@@ -207,8 +207,6 @@ static int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 		if (xz_err != XZ_OK) {
 			if (xz_err == XZ_STREAM_END && !rq->outputsize)
 				break;
-			erofs_err(sb, "failed to decompress %d in[%u] out[%u]",
-				  xz_err, rq->inputsize, rq->outputsize);
 			err = -EFSCORRUPTED;
 			break;
 		}
@@ -223,7 +221,7 @@ static int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 	z_erofs_lzma_head = strm;
 	spin_unlock(&z_erofs_lzma_lock);
 	wake_up(&z_erofs_lzma_wq);
-	return err;
+	return ERR_PTR(err);
 }
 
 const struct z_erofs_decompressor z_erofs_lzma_decomp = {
diff --git a/fs/erofs/decompressor_zstd.c b/fs/erofs/decompressor_zstd.c
index e38d93bb2104..50fadff89cbc 100644
--- a/fs/erofs/decompressor_zstd.c
+++ b/fs/erofs/decompressor_zstd.c
@@ -135,8 +135,8 @@ static int z_erofs_load_zstd_config(struct super_block *sb,
 	return strm ? -ENOMEM : 0;
 }
 
-static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
-				   struct page **pgpl)
+static const char *z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
+					   struct page **pgpl)
 {
 	struct super_block *sb = rq->sb;
 	struct z_erofs_stream_dctx dctx = { .rq = rq, .no = -1, .ni = 0 };
@@ -152,7 +152,7 @@ static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 			min(rq->inputsize, sb->s_blocksize - rq->pageofs_in));
 	if (err) {
 		kunmap_local(dctx.kin);
-		return err;
+		return ERR_PTR(err);
 	}
 
 	/* 2. get an available ZSTD context */
@@ -191,10 +191,6 @@ static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 		if (zstd_is_error(zerr) ||
 		    ((rq->outputsize + dctx.avail_out) && (!zerr || (zerr > 0 &&
 				!(rq->inputsize + in_buf.size - in_buf.pos))))) {
-			erofs_err(sb, "failed to decompress in[%u] out[%u]: %s",
-				  rq->inputsize, rq->outputsize,
-				  zstd_is_error(zerr) ? zstd_get_error_name(zerr) :
-					"unexpected end of stream");
 			err = -EFSCORRUPTED;
 			break;
 		}
@@ -210,7 +206,7 @@ static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 	z_erofs_zstd_head = strm;
 	spin_unlock(&z_erofs_zstd_lock);
 	wake_up(&z_erofs_zstd_wq);
-	return err;
+	return ERR_PTR(err);
 }
 
 const struct z_erofs_decompressor z_erofs_zstd_decomp = {
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bc80cfe482f7..461a929e0825 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1267,12 +1267,13 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
-	const struct z_erofs_decompressor *decomp =
+	const struct z_erofs_decompressor *alg =
 				z_erofs_decomp[pcl->algorithmformat];
+	bool try_free = true;
 	int i, j, jtop, err2;
 	struct page *page;
 	bool overlapped;
-	bool try_free = true;
+	const char *reason;
 
 	mutex_lock(&pcl->lock);
 	be->nr_pages = PAGE_ALIGN(pcl->length + pcl->pageofs_out) >> PAGE_SHIFT;
@@ -1304,8 +1305,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 	err2 = z_erofs_parse_in_bvecs(be, &overlapped);
 	if (err2)
 		err = err2;
-	if (!err)
-		err = decomp->decompress(&(struct z_erofs_decompress_req) {
+	if (!err) {
+		reason = alg->decompress(&(struct z_erofs_decompress_req) {
 					.sb = be->sb,
 					.in = be->compressed_pages,
 					.out = be->decompressed_pages,
@@ -1322,6 +1323,18 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 					.gfp = pcl->besteffort ? GFP_KERNEL :
 						GFP_NOWAIT | __GFP_NORETRY
 				 }, be->pagepool);
+		if (IS_ERR(reason)) {
+			erofs_err(be->sb, "failed to decompress (%s) %ld @ pa %llu size %u => %u",
+				  alg->name, PTR_ERR(reason), pcl->pos,
+				  pcl->pclustersize, pcl->length);
+			err = PTR_ERR(reason);
+		} else if (unlikely(reason)) {
+			erofs_err(be->sb, "failed to decompress (%s) %s @ pa %llu size %u => %u",
+				  alg->name, reason, pcl->pos,
+				  pcl->pclustersize, pcl->length);
+			err = -EFSCORRUPTED;
+		}
+	}
 
 	/* must handle all compressed pages before actual file pages */
 	if (pcl->from_meta) {
-- 
2.43.5


