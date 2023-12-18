Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3CB81745F
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Dec 2023 15:57:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sv2xG0GH6z3bYR
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Dec 2023 01:57:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sv2x118hCz3bhD
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Dec 2023 01:57:22 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vynf.o3_1702911431;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vynf.o3_1702911431)
          by smtp.aliyun-inc.com;
          Mon, 18 Dec 2023 22:57:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 1/3] erofs-utils: lib: add z_erofs_need_refill()
Date: Mon, 18 Dec 2023 22:57:08 +0800
Message-Id: <20231218145710.132164-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231107092343.200359-1-zhaoyifan@sjtu.edu.cn>
References: <20231107092343.200359-1-zhaoyifan@sjtu.edu.cn>
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

Let's remove redundant logic.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 61328ed..a5ef6e4 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -166,6 +166,22 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 	ctx->clusterofs = clusterofs + count;
 }
 
+static bool z_erofs_need_refill(struct z_erofs_vle_compress_ctx *ctx)
+{
+	const bool final = !ctx->remaining;
+	unsigned int qh_aligned, qh_after;
+
+	if (final || ctx->head < EROFS_CONFIG_COMPR_MAX_SZ)
+		return false;
+
+	qh_aligned = round_down(ctx->head, erofs_blksiz(ctx->inode->sbi));
+	qh_after = ctx->head - qh_aligned;
+	memmove(ctx->queue, ctx->queue + qh_aligned, ctx->tail - qh_aligned);
+	ctx->tail -= qh_aligned;
+	ctx->head = qh_after;
+	return true;
+}
+
 static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 				   unsigned int *len)
 {
@@ -243,15 +259,7 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 		DBG_BUGON(*len < dctx.e.length - delta);
 		*len -= dctx.e.length - delta;
 
-		if (ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
-			const unsigned int qh_aligned =
-				round_down(ctx->head, erofs_blksiz(sbi));
-			const unsigned int qh_after = ctx->head - qh_aligned;
-
-			memmove(ctx->queue, ctx->queue + qh_aligned,
-				*len + qh_after);
-			ctx->head = qh_after;
-			ctx->tail = qh_after + *len;
+		if (z_erofs_need_refill(ctx)) {
 			ret = -EAGAIN;
 			break;
 		}
@@ -413,7 +421,7 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 		bool fix_dedupedfrag = ctx->fix_dedupedfrag;
 		unsigned int compressedsize;
 
-		if (z_erofs_compress_dedupe(ctx, &len) && !final)
+		if (z_erofs_compress_dedupe(ctx, &len))
 			break;
 
 		if (len <= ctx->pclustersize) {
@@ -568,17 +576,8 @@ frag_packing:
 		    z_erofs_fixup_deduped_fragment(ctx, len))
 			break;
 
-		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
-			const unsigned int qh_aligned =
-				round_down(ctx->head, blksz);
-			const unsigned int qh_after = ctx->head - qh_aligned;
-
-			memmove(ctx->queue, ctx->queue + qh_aligned,
-				len + qh_after);
-			ctx->head = qh_after;
-			ctx->tail = qh_after + len;
+		if (z_erofs_need_refill(ctx))
 			break;
-		}
 	}
 	return 0;
 
-- 
2.39.3

