Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 848C174008E
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jun 2023 18:13:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qr8rn3JNLz30J1
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 02:13:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qr8rc03zLz2xLS
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jun 2023 02:13:02 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vm6X2zo_1687882363;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vm6X2zo_1687882363)
          by smtp.aliyun-inc.com;
          Wed, 28 Jun 2023 00:12:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs: get rid of the remaining kmap_atomic()
Date: Wed, 28 Jun 2023 00:12:39 +0800
Message-Id: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It's unnecessary to use kmap_atomic() compared with kmap_local_page().
In addition, kmap_atomic() is deprecated now.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
preliminary tested with silesia dataset.

 fs/erofs/decompressor.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 2a29943fa5cc..ad53cf52d899 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -148,7 +148,7 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
 		*maptype = 0;
 		return inpage;
 	}
-	kunmap_atomic(inpage);
+	kunmap_local(inpage);
 	might_sleep();
 	src = erofs_vm_map_ram(rq->in, ctx->inpages);
 	if (!src)
@@ -162,7 +162,7 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
 	src = erofs_get_pcpubuf(ctx->inpages);
 	if (!src) {
 		DBG_BUGON(1);
-		kunmap_atomic(inpage);
+		kunmap_local(inpage);
 		return ERR_PTR(-EFAULT);
 	}
 
@@ -173,9 +173,9 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
 			min_t(unsigned int, total, PAGE_SIZE - *inputmargin);
 
 		if (!inpage)
-			inpage = kmap_atomic(*in);
+			inpage = kmap_local_page(*in);
 		memcpy(tmp, inpage + *inputmargin, page_copycnt);
-		kunmap_atomic(inpage);
+		kunmap_local(inpage);
 		inpage = NULL;
 		tmp += page_copycnt;
 		total -= page_copycnt;
@@ -214,7 +214,7 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 	int ret, maptype;
 
 	DBG_BUGON(*rq->in == NULL);
-	headpage = kmap_atomic(*rq->in);
+	headpage = kmap_local_page(*rq->in);
 
 	/* LZ4 decompression inplace is only safe if zero_padding is enabled */
 	if (erofs_sb_has_zero_padding(EROFS_SB(rq->sb))) {
@@ -223,7 +223,7 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 				min_t(unsigned int, rq->inputsize,
 				      rq->sb->s_blocksize - rq->pageofs_in));
 		if (ret) {
-			kunmap_atomic(headpage);
+			kunmap_local(headpage);
 			return ret;
 		}
 		may_inplace = !((rq->pageofs_in + rq->inputsize) &
@@ -261,7 +261,7 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 	}
 
 	if (maptype == 0) {
-		kunmap_atomic(headpage);
+		kunmap_local(headpage);
 	} else if (maptype == 1) {
 		vm_unmap_ram(src, ctx->inpages);
 	} else if (maptype == 2) {
@@ -289,7 +289,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 	/* one optimized fast path only for non bigpcluster cases yet */
 	if (ctx.inpages == 1 && ctx.outpages == 1 && !rq->inplace_io) {
 		DBG_BUGON(!*rq->out);
-		dst = kmap_atomic(*rq->out);
+		dst = kmap_local_page(*rq->out);
 		dst_maptype = 0;
 		goto dstmap_out;
 	}
@@ -311,7 +311,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 dstmap_out:
 	ret = z_erofs_lz4_decompress_mem(&ctx, dst + rq->pageofs_out);
 	if (!dst_maptype)
-		kunmap_atomic(dst);
+		kunmap_local(dst);
 	else if (dst_maptype == 2)
 		vm_unmap_ram(dst, ctx.outpages);
 	return ret;
-- 
2.24.4

