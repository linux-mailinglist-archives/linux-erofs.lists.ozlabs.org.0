Return-Path: <linux-erofs+bounces-8-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 23625A4FEF8
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Mar 2025 13:47:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z7C502l2yz3bxL;
	Wed,  5 Mar 2025 23:47:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741178423;
	cv=none; b=Xy/rLOmew30Ie7Ua3GYHnZAIqUOnMkQGisA2k3mS8rLF8UsPbW0D+hQOnxii1x5Wx4pe239S/YOZ4lu1gOtOTo37zCR0EHzZ4Eyl8ZstXYJqv74idolLBy6k7o1u6F6/cDLBjKO9dm9Rx3v83c3Hrn3bnqQYcBLd9F8XhI5Oq3GI2m1/CtV68n5mwJbCQBtBiDM4RrrxKqBHZ1pGNOZPFQzrP82WtjkqYrgKBHUlEV8Q/mJY0lB3lMMleQCPjQXdwfJ9ch6+6u8J3MXiTiVQdenflHwLJlHRv3pMLqof4f1kNqHtAuoALPR+aJWXCvl6dK7r2W7ic/ogNFD73aVQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741178423; c=relaxed/relaxed;
	bh=cVfb0T8HwHzTaiLekCt8v37S7VbF2szx4FWIxEZYak0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLv5gxSwLbPMut5U9H5WeC0zaMWf8Y/DAmqiNSapRkhHvHNO9SqBIAttftromp3qw7DDnkRqHRb1X+JM2nkrJkDafzI0uLnqiztCp1Z6uD2G7bNsJ+oSyAdGii5maVjbON6MqDFQGlnLZnv4RWWqzZdWFgtBLaSg8mG4uPLqwXNN0NQ06TzGbMdWVVbl3vXYlQVribvbDGJLzU2QC5+lKG4ACzs5z9EhuUC1TqmMp3Yde8S4Tpw/61YmcOAvloXedklalB183wpnlOZ6zVZX4tOOxmIksd6spFxzD0nu23GSdkK4grLd7J7/XIhmTrhmHZkyrt/ObfEtgZyUl0E4eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wLzqcrsh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wLzqcrsh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z7BwN2V2Yz3btc
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Mar 2025 23:40:18 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741178414; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cVfb0T8HwHzTaiLekCt8v37S7VbF2szx4FWIxEZYak0=;
	b=wLzqcrshSDMZA1KahFYU29vBGzXs2DZYv9nq0VomP336+DYsKBH9OpVE+X1Bp1huQdPB3amwJeALOdvsR6+KVSB4FgjrU2uKnQeJETqzIymVDG/z+w3IV0iz9LY2sxUivWiqWnX6zxyjjXt2wZJ7ot17CdnlMGj/6uTZxEiKyUg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQlT3Jv_1741178409 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Mar 2025 20:40:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: move {in,out}pages into struct z_erofs_decompress_req
Date: Wed,  5 Mar 2025 20:40:07 +0800
Message-ID: <20250305124007.1810731-1-hsiangkao@linux.alibaba.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

It seems that all compressors need those two values, so just move
them into the common structure.

`struct z_erofs_lz4_decompress_ctx` can be dropped too.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/compress.h             |  2 +-
 fs/erofs/decompressor.c         | 93 +++++++++++++--------------------
 fs/erofs/decompressor_deflate.c |  8 +--
 fs/erofs/decompressor_lzma.c    |  8 +--
 fs/erofs/decompressor_zstd.c    |  8 +--
 fs/erofs/zdata.c                |  2 +
 6 files changed, 41 insertions(+), 80 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 65ff39401020..2704d7a592a5 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -11,6 +11,7 @@
 struct z_erofs_decompress_req {
 	struct super_block *sb;
 	struct page **in, **out;
+	unsigned int inpages, outpages;
 	unsigned short pageofs_in, pageofs_out;
 	unsigned int inputsize, outputsize;
 
@@ -59,7 +60,6 @@ extern const struct z_erofs_decompressor *z_erofs_decomp[];
 
 struct z_erofs_stream_dctx {
 	struct z_erofs_decompress_req *rq;
-	unsigned int inpages, outpages;	/* # of {en,de}coded pages */
 	int no, ni;			/* the current {en,de}coded page # */
 
 	unsigned int avail_out;		/* remaining bytes in the decoded buffer */
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 2b123b070a42..50e350b10f89 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -9,14 +9,6 @@
 
 #define LZ4_MAX_DISTANCE_PAGES	(DIV_ROUND_UP(LZ4_DISTANCE_MAX, PAGE_SIZE) + 1)
 
-struct z_erofs_lz4_decompress_ctx {
-	struct z_erofs_decompress_req *rq;
-	/* # of encoded, decoded pages */
-	unsigned int inpages, outpages;
-	/* decoded block total length (used for in-place decompression) */
-	unsigned int oend;
-};
-
 static int z_erofs_load_lz4_config(struct super_block *sb,
 			    struct erofs_super_block *dsb, void *data, int size)
 {
@@ -55,10 +47,9 @@ static int z_erofs_load_lz4_config(struct super_block *sb,
  * Fill all gaps with bounce pages if it's a sparse page list. Also check if
  * all physical pages are consecutive, which can be seen for moderate CR.
  */
-static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
+static int z_erofs_lz4_prepare_dstpages(struct z_erofs_decompress_req *rq,
 					struct page **pagepool)
 {
-	struct z_erofs_decompress_req *rq = ctx->rq;
 	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
 	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
 					   BITS_PER_LONG)] = { 0 };
@@ -68,7 +59,7 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
 	unsigned int i, j, top;
 
 	top = 0;
-	for (i = j = 0; i < ctx->outpages; ++i, ++j) {
+	for (i = j = 0; i < rq->outpages; ++i, ++j) {
 		struct page *const page = rq->out[i];
 		struct page *victim;
 
@@ -114,36 +105,36 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
 	return kaddr ? 1 : 0;
 }
 
-static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
+static void *z_erofs_lz4_handle_overlap(struct z_erofs_decompress_req *rq,
 			void *inpage, void *out, unsigned int *inputmargin,
 			int *maptype, bool may_inplace)
 {
-	struct z_erofs_decompress_req *rq = ctx->rq;
-	unsigned int omargin, total, i;
+	unsigned int oend, omargin, total, i;
 	struct page **in;
 	void *src, *tmp;
 
 	if (rq->inplace_io) {
-		omargin = PAGE_ALIGN(ctx->oend) - ctx->oend;
+		oend = rq->pageofs_out + rq->outputsize;
+		omargin = PAGE_ALIGN(oend) - oend;
 		if (rq->partial_decoding || !may_inplace ||
 		    omargin < LZ4_DECOMPRESS_INPLACE_MARGIN(rq->inputsize))
 			goto docopy;
 
-		for (i = 0; i < ctx->inpages; ++i)
-			if (rq->out[ctx->outpages - ctx->inpages + i] !=
+		for (i = 0; i < rq->inpages; ++i)
+			if (rq->out[rq->outpages - rq->inpages + i] !=
 			    rq->in[i])
 				goto docopy;
 		kunmap_local(inpage);
 		*maptype = 3;
-		return out + ((ctx->outpages - ctx->inpages) << PAGE_SHIFT);
+		return out + ((rq->outpages - rq->inpages) << PAGE_SHIFT);
 	}
 
-	if (ctx->inpages <= 1) {
+	if (rq->inpages <= 1) {
 		*maptype = 0;
 		return inpage;
 	}
 	kunmap_local(inpage);
-	src = erofs_vm_map_ram(rq->in, ctx->inpages);
+	src = erofs_vm_map_ram(rq->in, rq->inpages);
 	if (!src)
 		return ERR_PTR(-ENOMEM);
 	*maptype = 1;
@@ -152,7 +143,7 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
 docopy:
 	/* Or copy compressed data which can be overlapped to per-CPU buffer */
 	in = rq->in;
-	src = z_erofs_get_gbuf(ctx->inpages);
+	src = z_erofs_get_gbuf(rq->inpages);
 	if (!src) {
 		DBG_BUGON(1);
 		kunmap_local(inpage);
@@ -197,10 +188,8 @@ int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
 	return 0;
 }
 
-static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
-				      u8 *dst)
+static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq, u8 *dst)
 {
-	struct z_erofs_decompress_req *rq = ctx->rq;
 	bool support_0padding = false, may_inplace = false;
 	unsigned int inputmargin;
 	u8 *out, *headpage, *src;
@@ -224,7 +213,7 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 	}
 
 	inputmargin = rq->pageofs_in;
-	src = z_erofs_lz4_handle_overlap(ctx, headpage, dst, &inputmargin,
+	src = z_erofs_lz4_handle_overlap(rq, headpage, dst, &inputmargin,
 					 &maptype, may_inplace);
 	if (IS_ERR(src))
 		return PTR_ERR(src);
@@ -251,7 +240,7 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 	if (maptype == 0) {
 		kunmap_local(headpage);
 	} else if (maptype == 1) {
-		vm_unmap_ram(src, ctx->inpages);
+		vm_unmap_ram(src, rq->inpages);
 	} else if (maptype == 2) {
 		z_erofs_put_gbuf(src);
 	} else if (maptype != 3) {
@@ -264,54 +253,42 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 				  struct page **pagepool)
 {
-	struct z_erofs_lz4_decompress_ctx ctx;
 	unsigned int dst_maptype;
 	void *dst;
 	int ret;
 
-	ctx.rq = rq;
-	ctx.oend = rq->pageofs_out + rq->outputsize;
-	ctx.outpages = PAGE_ALIGN(ctx.oend) >> PAGE_SHIFT;
-	ctx.inpages = PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT;
-
 	/* one optimized fast path only for non bigpcluster cases yet */
-	if (ctx.inpages == 1 && ctx.outpages == 1 && !rq->inplace_io) {
+	if (rq->inpages == 1 && rq->outpages == 1 && !rq->inplace_io) {
 		DBG_BUGON(!*rq->out);
 		dst = kmap_local_page(*rq->out);
 		dst_maptype = 0;
-		goto dstmap_out;
-	}
-
-	/* general decoding path which can be used for all cases */
-	ret = z_erofs_lz4_prepare_dstpages(&ctx, pagepool);
-	if (ret < 0) {
-		return ret;
-	} else if (ret > 0) {
-		dst = page_address(*rq->out);
-		dst_maptype = 1;
 	} else {
-		dst = erofs_vm_map_ram(rq->out, ctx.outpages);
-		if (!dst)
-			return -ENOMEM;
-		dst_maptype = 2;
+		/* general decoding path which can be used for all cases */
+		ret = z_erofs_lz4_prepare_dstpages(rq, pagepool);
+		if (ret < 0)
+			return ret;
+		if (ret > 0) {
+			dst = page_address(*rq->out);
+			dst_maptype = 1;
+		} else {
+			dst = erofs_vm_map_ram(rq->out, rq->outpages);
+			if (!dst)
+				return -ENOMEM;
+			dst_maptype = 2;
+		}
 	}
-
-dstmap_out:
-	ret = z_erofs_lz4_decompress_mem(&ctx, dst);
+	ret = z_erofs_lz4_decompress_mem(rq, dst);
 	if (!dst_maptype)
 		kunmap_local(dst);
 	else if (dst_maptype == 2)
-		vm_unmap_ram(dst, ctx.outpages);
+		vm_unmap_ram(dst, rq->outpages);
 	return ret;
 }
 
 static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 				   struct page **pagepool)
 {
-	const unsigned int nrpages_in =
-		PAGE_ALIGN(rq->pageofs_in + rq->inputsize) >> PAGE_SHIFT;
-	const unsigned int nrpages_out =
-		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
+	const unsigned int nrpages_in = rq->inpages, nrpages_out = rq->outpages;
 	const unsigned int bs = rq->sb->s_blocksize;
 	unsigned int cur = 0, ni = 0, no, pi, po, insz, cnt;
 	u8 *kin;
@@ -373,7 +350,7 @@ int z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx, void **dst,
 	unsigned int j;
 
 	if (!dctx->avail_out) {
-		if (++dctx->no >= dctx->outpages || !rq->outputsize) {
+		if (++dctx->no >= rq->outpages || !rq->outputsize) {
 			erofs_err(sb, "insufficient space for decompressed data");
 			return -EFSCORRUPTED;
 		}
@@ -401,7 +378,7 @@ int z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx, void **dst,
 	}
 
 	if (dctx->inbuf_pos == dctx->inbuf_sz && rq->inputsize) {
-		if (++dctx->ni >= dctx->inpages) {
+		if (++dctx->ni >= rq->inpages) {
 			erofs_err(sb, "invalid compressed data");
 			return -EFSCORRUPTED;
 		}
@@ -434,7 +411,7 @@ int z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx, void **dst,
 		dctx->bounced = true;
 	}
 
-	for (j = dctx->ni + 1; j < dctx->inpages; ++j) {
+	for (j = dctx->ni + 1; j < rq->inpages; ++j) {
 		if (rq->out[dctx->no] != rq->in[j])
 			continue;
 		tmppage = erofs_allocpage(pgpl, rq->gfp);
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
index 5070d2fcc737..c6908a487054 100644
--- a/fs/erofs/decompressor_deflate.c
+++ b/fs/erofs/decompressor_deflate.c
@@ -101,13 +101,7 @@ static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 				      struct page **pgpl)
 {
 	struct super_block *sb = rq->sb;
-	struct z_erofs_stream_dctx dctx = {
-		.rq = rq,
-		.inpages = PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT,
-		.outpages = PAGE_ALIGN(rq->pageofs_out + rq->outputsize)
-				>> PAGE_SHIFT,
-		.no = -1, .ni = 0,
-	};
+	struct z_erofs_stream_dctx dctx = { .rq = rq, .no = -1, .ni = 0 };
 	struct z_erofs_deflate *strm;
 	int zerr, err;
 
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
index 40666815046f..832cffb83a66 100644
--- a/fs/erofs/decompressor_lzma.c
+++ b/fs/erofs/decompressor_lzma.c
@@ -150,13 +150,7 @@ static int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 				   struct page **pgpl)
 {
 	struct super_block *sb = rq->sb;
-	struct z_erofs_stream_dctx dctx = {
-		.rq = rq,
-		.inpages = PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT,
-		.outpages = PAGE_ALIGN(rq->pageofs_out + rq->outputsize)
-				>> PAGE_SHIFT,
-		.no = -1, .ni = 0,
-	};
+	struct z_erofs_stream_dctx dctx = { .rq = rq, .no = -1, .ni = 0 };
 	struct xz_buf buf = {};
 	struct z_erofs_lzma *strm;
 	enum xz_ret xz_err;
diff --git a/fs/erofs/decompressor_zstd.c b/fs/erofs/decompressor_zstd.c
index 7e177304967e..b4bfe14229f9 100644
--- a/fs/erofs/decompressor_zstd.c
+++ b/fs/erofs/decompressor_zstd.c
@@ -139,13 +139,7 @@ static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 				   struct page **pgpl)
 {
 	struct super_block *sb = rq->sb;
-	struct z_erofs_stream_dctx dctx = {
-		.rq = rq,
-		.inpages = PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT,
-		.outpages = PAGE_ALIGN(rq->pageofs_out + rq->outputsize)
-				>> PAGE_SHIFT,
-		.no = -1, .ni = 0,
-	};
+	struct z_erofs_stream_dctx dctx = { .rq = rq, .no = -1, .ni = 0 };
 	zstd_in_buffer in_buf = { NULL, 0, 0 };
 	zstd_out_buffer out_buf = { NULL, 0, 0 };
 	struct z_erofs_zstd *strm;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ad674eee400a..5e4b65070b86 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1284,6 +1284,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 					.sb = be->sb,
 					.in = be->compressed_pages,
 					.out = be->decompressed_pages,
+					.inpages = pclusterpages,
+					.outpages = be->nr_pages,
 					.pageofs_in = pcl->pageofs_in,
 					.pageofs_out = pcl->pageofs_out,
 					.inputsize = pcl->pclustersize,
-- 
2.43.5


