Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0433648069B
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 06:46:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JNNnr707hz3062
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 16:46:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JNNnm26SDz3064
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Dec 2021 16:46:35 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V0240kf_1640670365; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V0240kf_1640670365) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 28 Dec 2021 13:46:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v4 1/5] erofs: tidy up z_erofs_lz4_decompress
Date: Tue, 28 Dec 2021 13:46:00 +0800
Message-Id: <20211228054604.114518-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
References: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

To prepare for the upcoming ztailpacking feature and further
cleanups, introduce a unique z_erofs_lz4_decompress_ctx to keep
the context, including inpages, outpages and oend, which are
frequently used by the lz4 decompressor.

No logic changes.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor.c | 83 ++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 39 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index c373a199c407..1d137fd42306 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -16,6 +16,14 @@
 #define LZ4_DECOMPRESS_INPLACE_MARGIN(srcsize)  (((srcsize) >> 8) + 32)
 #endif
 
+struct z_erofs_lz4_decompress_ctx {
+	struct z_erofs_decompress_req *rq;
+	/* # of encoded, decoded pages */
+	unsigned int inpages, outpages;
+	/* decoded block total length (used for in-place decompression) */
+	unsigned int oend;
+};
+
 int z_erofs_load_lz4_config(struct super_block *sb,
 			    struct erofs_super_block *dsb,
 			    struct z_erofs_lz4_cfgs *lz4, int size)
@@ -56,11 +64,10 @@ int z_erofs_load_lz4_config(struct super_block *sb,
  * Fill all gaps with bounce pages if it's a sparse page list. Also check if
  * all physical pages are consecutive, which can be seen for moderate CR.
  */
-static int z_erofs_lz4_prepare_dstpages(struct z_erofs_decompress_req *rq,
+static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
 					struct page **pagepool)
 {
-	const unsigned int nr =
-		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
+	struct z_erofs_decompress_req *rq = ctx->rq;
 	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
 	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
 					   BITS_PER_LONG)] = { 0 };
@@ -70,7 +77,7 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_decompress_req *rq,
 	unsigned int i, j, top;
 
 	top = 0;
-	for (i = j = 0; i < nr; ++i, ++j) {
+	for (i = j = 0; i < ctx->outpages; ++i, ++j) {
 		struct page *const page = rq->out[i];
 		struct page *victim;
 
@@ -112,41 +119,36 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_decompress_req *rq,
 	return kaddr ? 1 : 0;
 }
 
-static void *z_erofs_lz4_handle_inplace_io(struct z_erofs_decompress_req *rq,
+static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
 			void *inpage, unsigned int *inputmargin, int *maptype,
 			bool support_0padding)
 {
-	unsigned int nrpages_in, nrpages_out;
-	unsigned int ofull, oend, inputsize, total, i, j;
+	struct z_erofs_decompress_req *rq = ctx->rq;
+	unsigned int omargin, total, i, j;
 	struct page **in;
 	void *src, *tmp;
 
-	inputsize = rq->inputsize;
-	nrpages_in = PAGE_ALIGN(inputsize) >> PAGE_SHIFT;
-	oend = rq->pageofs_out + rq->outputsize;
-	ofull = PAGE_ALIGN(oend);
-	nrpages_out = ofull >> PAGE_SHIFT;
-
 	if (rq->inplace_io) {
+		omargin = PAGE_ALIGN(ctx->oend) - ctx->oend;
 		if (rq->partial_decoding || !support_0padding ||
-		    ofull - oend < LZ4_DECOMPRESS_INPLACE_MARGIN(inputsize))
+		    omargin < LZ4_DECOMPRESS_INPLACE_MARGIN(rq->inputsize))
 			goto docopy;
 
-		for (i = 0; i < nrpages_in; ++i) {
+		for (i = 0; i < ctx->inpages; ++i) {
 			DBG_BUGON(rq->in[i] == NULL);
-			for (j = 0; j < nrpages_out - nrpages_in + i; ++j)
+			for (j = 0; j < ctx->outpages - ctx->inpages + i; ++j)
 				if (rq->out[j] == rq->in[i])
 					goto docopy;
 		}
 	}
 
-	if (nrpages_in <= 1) {
+	if (ctx->inpages <= 1) {
 		*maptype = 0;
 		return inpage;
 	}
 	kunmap_atomic(inpage);
 	might_sleep();
-	src = erofs_vm_map_ram(rq->in, nrpages_in);
+	src = erofs_vm_map_ram(rq->in, ctx->inpages);
 	if (!src)
 		return ERR_PTR(-ENOMEM);
 	*maptype = 1;
@@ -155,7 +157,7 @@ static void *z_erofs_lz4_handle_inplace_io(struct z_erofs_decompress_req *rq,
 docopy:
 	/* Or copy compressed data which can be overlapped to per-CPU buffer */
 	in = rq->in;
-	src = erofs_get_pcpubuf(nrpages_in);
+	src = erofs_get_pcpubuf(ctx->inpages);
 	if (!src) {
 		DBG_BUGON(1);
 		kunmap_atomic(inpage);
@@ -182,9 +184,10 @@ static void *z_erofs_lz4_handle_inplace_io(struct z_erofs_decompress_req *rq,
 	return src;
 }
 
-static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq,
+static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 				      u8 *out)
 {
+	struct z_erofs_decompress_req *rq = ctx->rq;
 	unsigned int inputmargin;
 	u8 *headpage, *src;
 	bool support_0padding;
@@ -210,8 +213,8 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq,
 	}
 
 	rq->inputsize -= inputmargin;
-	src = z_erofs_lz4_handle_inplace_io(rq, headpage, &inputmargin,
-					    &maptype, support_0padding);
+	src = z_erofs_lz4_handle_overlap(ctx, headpage, &inputmargin,
+					 &maptype, support_0padding);
 	if (IS_ERR(src))
 		return PTR_ERR(src);
 
@@ -240,9 +243,9 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq,
 	}
 
 	if (maptype == 0) {
-		kunmap_atomic(src);
+		kunmap_atomic(headpage);
 	} else if (maptype == 1) {
-		vm_unmap_ram(src, PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT);
+		vm_unmap_ram(src, ctx->inpages);
 	} else if (maptype == 2) {
 		erofs_put_pcpubuf(src);
 	} else {
@@ -255,14 +258,18 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_decompress_req *rq,
 static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 				  struct page **pagepool)
 {
-	const unsigned int nrpages_out =
-		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
+	struct z_erofs_lz4_decompress_ctx ctx;
 	unsigned int dst_maptype;
 	void *dst;
 	int ret;
 
+	ctx.rq = rq;
+	ctx.oend = rq->pageofs_out + rq->outputsize;
+	ctx.outpages = PAGE_ALIGN(ctx.oend) >> PAGE_SHIFT;
+	ctx.inpages = PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT;
+
 	/* one optimized fast path only for non bigpcluster cases yet */
-	if (rq->inputsize <= PAGE_SIZE && nrpages_out == 1 && !rq->inplace_io) {
+	if (ctx.inpages == 1 && ctx.outpages == 1 && !rq->inplace_io) {
 		DBG_BUGON(!*rq->out);
 		dst = kmap_atomic(*rq->out);
 		dst_maptype = 0;
@@ -270,27 +277,25 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 	}
 
 	/* general decoding path which can be used for all cases */
-	ret = z_erofs_lz4_prepare_dstpages(rq, pagepool);
-	if (ret < 0)
+	ret = z_erofs_lz4_prepare_dstpages(&ctx, pagepool);
+	if (ret < 0) {
 		return ret;
-	if (ret) {
+	} else if (ret > 0) {
 		dst = page_address(*rq->out);
 		dst_maptype = 1;
-		goto dstmap_out;
+	} else {
+		dst = erofs_vm_map_ram(rq->out, ctx.outpages);
+		if (!dst)
+			return -ENOMEM;
+		dst_maptype = 2;
 	}
 
-	dst = erofs_vm_map_ram(rq->out, nrpages_out);
-	if (!dst)
-		return -ENOMEM;
-	dst_maptype = 2;
-
 dstmap_out:
-	ret = z_erofs_lz4_decompress_mem(rq, dst + rq->pageofs_out);
-
+	ret = z_erofs_lz4_decompress_mem(&ctx, dst + rq->pageofs_out);
 	if (!dst_maptype)
 		kunmap_atomic(dst);
 	else if (dst_maptype == 2)
-		vm_unmap_ram(dst, nrpages_out);
+		vm_unmap_ram(dst, ctx.outpages);
 	return ret;
 }
 
-- 
2.24.4

