Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B494F9F949D
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Dec 2024 15:39:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YF96J4qmdz3bbC
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Dec 2024 01:39:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734705558;
	cv=none; b=V3n9mGXM7u1KL96r0ayWQRch5zJk/s3grh0o9r2/h4fsyMywl0gamcKPXG2heJGr76yOXMPkQHE+DHnHTU7zBQYHG30Ndd0mnZP702cjeUzvLGJp97KqgOtIj62fJNnVoA387sodRTwRtoXZMxO2AV4wtT/C4LIg9vC3aramCkc6ajM11TZrJeJK9ogfnRNN2+25n2h/XNPy+Rmv8CLzvS+Fmd3976zc1HsnX70mw1D64DsYlKybmIbJA22PrHucxxbMil8AwnD7+Vhp2RtJrYx5/jfF5NvjvvhBp30O3Qjz9un8uBfJIB0HkU1YQmCUtqcHWmXTUtIiJyi8YBnQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734705558; c=relaxed/relaxed;
	bh=vk10WbeqX6fFIWgxYiMNQCHc0sk9Jbu9QFpImj2RmeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EFba/K7A/KLj9s1HHPVtYVo52BB/DuSDZTiWZ3ZdQgIX/oR8pPYvoNmI3EMPwAmLUHfNAOV1HVOdIr8gtCdbuWVSA/anVbpscOW9TQU6nkiCePm294bsw9T3xQlrjjCLZEzxSY8dWEQT0XSb4KG9EFEBIwgs/UbVJjJPDn8OnaHFOm28MlEb4kKbyNQWp1m5cEtiR/VY4aEtBLqw4yqWi4qLQ0MlII/kKnKYdnQYuDi6DKnAskfL63ksDon0BsGm6V1GsADcvUtu3dxOMuCdPlqGURS41dH7YLJin98tXsqmpNqDBugse45zn4Rg1IzwLJVIyA0ARPQk6KAQydowjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XUYUZPPq; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XUYUZPPq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YF96C1cP8z2xbP
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Dec 2024 01:39:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734705546; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vk10WbeqX6fFIWgxYiMNQCHc0sk9Jbu9QFpImj2RmeQ=;
	b=XUYUZPPqcEXtzGiWfMpOkNOrwnIrf+aqtgq6iCdXWunQPuubGImpasMQkUVb8Tcfc9Z9FfiGH50rwvzi/+9FxmRKKabQ0t0TFtYeDafJgVjoeWS38x2wdrgWnvpbMFiYssmE91srBMYBJ3Bx9fNjM+VYiW1cxtoOGXdbamlDXV8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLu36hA_1734705540 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Dec 2024 22:39:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/2] erofs-utils: lib: get rid of `len` in z_erofs_compress_one()
Date: Fri, 20 Dec 2024 22:38:58 +0800
Message-ID: <20241220143859.643175-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

More than one extent could be emitted in __z_erofs_compress_one()
later.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 65edd00..6a409de 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -278,8 +278,7 @@ static void z_erofs_commit_extent(struct z_erofs_compress_sctx *ctx,
 			  (erofs_blksiz(ctx->ictx->inode->sbi) - 1);
 }
 
-static int z_erofs_compress_dedupe(struct z_erofs_compress_sctx *ctx,
-				   unsigned int *len)
+static int z_erofs_compress_dedupe(struct z_erofs_compress_sctx *ctx)
 {
 	struct erofs_inode *inode = ctx->ictx->inode;
 	const unsigned int lclustermask = (1 << inode->z_logical_clusterbits) - 1;
@@ -306,7 +305,7 @@ static int z_erofs_compress_dedupe(struct z_erofs_compress_sctx *ctx,
 				else
 					rc = ei->e.length - erofs_blksiz(sbi);
 				rc; }),
-			.end = ctx->queue + ctx->head + *len,
+			.end = ctx->queue + ctx->tail,
 			.cur = ctx->queue + ctx->head,
 		};
 		int delta;
@@ -366,12 +365,11 @@ static int z_erofs_compress_dedupe(struct z_erofs_compress_sctx *ctx,
 		ei->e = dctx.e;
 
 		ctx->head += dctx.e.length - delta;
-		DBG_BUGON(*len < dctx.e.length - delta);
-		*len -= dctx.e.length - delta;
+		DBG_BUGON(ctx->head > ctx->tail);
 
 		if (z_erofs_need_refill(ctx))
 			return 1;
-	} while (*len);
+	} while (ctx->tail > ctx->head);
 out:
 	z_erofs_commit_extent(ctx, ei);
 	ctx->pivot = NULL;
@@ -484,13 +482,12 @@ out:
 	return 0;
 }
 
-static bool z_erofs_fixup_deduped_fragment(struct z_erofs_compress_sctx *ctx,
-					   unsigned int len)
+static bool z_erofs_fixup_deduped_fragment(struct z_erofs_compress_sctx *ctx)
 {
 	struct z_erofs_compress_ictx *ictx = ctx->ictx;
 	struct erofs_inode *inode = ictx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
-	const unsigned int newsize = ctx->remaining + len;
+	const unsigned int newsize = ctx->remaining + ctx->tail - ctx->head;
 
 	DBG_BUGON(!inode->fragment_size);
 
@@ -700,11 +697,10 @@ fix_dedupedfrag:
 static int z_erofs_compress_one(struct z_erofs_compress_sctx *ctx)
 {
 	struct z_erofs_compress_ictx *ictx = ctx->ictx;
-	unsigned int len = ctx->tail - ctx->head;
 	struct z_erofs_extent_item *ei;
 
-	while (len) {
-		int ret = z_erofs_compress_dedupe(ctx, &len);
+	while (ctx->tail > ctx->head) {
+		int ret = z_erofs_compress_dedupe(ctx);
 
 		if (ret > 0)
 			break;
@@ -725,10 +721,9 @@ static int z_erofs_compress_one(struct z_erofs_compress_sctx *ctx)
 			return ret;
 		}
 
-		len -= ei->e.length;
 		ctx->pivot = ei;
 		if (ictx->fix_dedupedfrag && !ictx->fragemitted &&
-		    z_erofs_fixup_deduped_fragment(ctx, len))
+		    z_erofs_fixup_deduped_fragment(ctx))
 			break;
 
 		if (z_erofs_need_refill(ctx))
-- 
2.43.5

