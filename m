Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA9B8A99B2
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 14:23:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dLG8ULSz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKxlD03gRz3cTZ
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 22:23:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dLG8ULSz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKxl55lj3z2xqq
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 22:23:29 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4947BCE1814;
	Thu, 18 Apr 2024 12:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9A1C113CC;
	Thu, 18 Apr 2024 12:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713443004;
	bh=09HCCYBGXjhljy/86wM4VxKFXqQxH/NcS1SeI0z2J7s=;
	h=From:To:Cc:Subject:Date:From;
	b=dLG8ULSzxLBFoDnLwoiOjzh20WomcZ03V1f9wZD/icc6VGh7PMuUI5exIDuvjvbyy
	 Bc469iAxmW00c4Z/ylSvlp+w6AsoCyhnl53saURbw91Qn+4bbkUAmETYfQBMK0wJhu
	 P74ekbKhtVWHTLnI0GduNwMWrvnfs3RLlieCKaUrj6MolSI77MxrLhClTq8FIraE/A
	 Wij2dxBA8QdkDICAKwnKT6LJsXW72FF9Y6xlmcfDL1d8dDFiAFPKWXT6Rlx6w7ICf5
	 zOP6e+MiJ6oC0ntSN0HfJrC3L/xK3s1kuXVjbciAT2fJvCNvxPTsjY33U0VRw0dTxd
	 a6ODwsM6tzoGA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: mkfs: skip the redundant write for ztailpacking block
Date: Thu, 18 Apr 2024 20:23:12 +0800
Message-Id: <20240418122312.99282-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yifan Zhao <zhaoyifan@sjtu.edu.cn>, 20240417144251.1845355-1-zhaoyifan@sjtu.edu.cn
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>

z_erofs_merge_segment() doesn't consider the ztailpacking block in the
extent list and unnecessarily writes it back to the disk. This patch
fixes this issue by introducing a new `inlined` field in the struct
`z_erofs_inmem_extent`.

Fixes: 830b27bc2334 ("erofs-utils: mkfs: introduce inner-file multi-threaded compression")
Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
[ Gao Xiang: simplify a bit. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
  Yifan's patch is almost correct, it just has minor changes.
 include/erofs/dedupe.h |  2 +-
 lib/compress.c         | 14 +++++++++++---
 lib/dedupe.c           |  1 +
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/erofs/dedupe.h b/include/erofs/dedupe.h
index 153bd4c..4cbfb2c 100644
--- a/include/erofs/dedupe.h
+++ b/include/erofs/dedupe.h
@@ -16,7 +16,7 @@ struct z_erofs_inmem_extent {
 	erofs_blk_t blkaddr;
 	unsigned int compressedblks;
 	unsigned int length;
-	bool raw, partial;
+	bool raw, partial, inlined;
 };
 
 struct z_erofs_dedupe_ctx {
diff --git a/lib/compress.c b/lib/compress.c
index 74c5707..b084446 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -305,6 +305,7 @@ static int z_erofs_compress_dedupe(struct z_erofs_compress_sctx *ctx,
 		if (z_erofs_dedupe_match(&dctx))
 			break;
 
+		DBG_BUGON(dctx.e.inlined);
 		delta = ctx->queue + ctx->head - dctx.cur;
 		/*
 		 * For big pcluster dedupe, leave two indices at least to store
@@ -519,6 +520,7 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	unsigned int compressedsize;
 	int ret;
 
+	*e = (struct z_erofs_inmem_extent){};
 	if (len <= ctx->pclustersize) {
 		if (!final || !len)
 			return 1;
@@ -553,16 +555,18 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 		if (may_inline && len < blksz) {
 			ret = z_erofs_fill_inline_data(inode,
 					ctx->queue + ctx->head, len, true);
+			if (ret < 0)
+				return ret;
+			e->inlined = true;
 		} else {
 			may_inline = false;
 			may_packing = false;
 nocompression:
 			/* TODO: reset clusterofs to 0 if permitted */
 			ret = write_uncompressed_extent(ctx, len, dst);
+			if (ret < 0)
+				return ret;
 		}
-
-		if (ret < 0)
-			return ret;
 		e->length = ret;
 
 		/*
@@ -598,6 +602,7 @@ frag_packing:
 				compressedsize, false);
 		if (ret < 0)
 			return ret;
+		e->inlined = true;
 		e->compressedblks = 1;
 		e->raw = false;
 	} else {
@@ -1151,6 +1156,9 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
 		ei->e.blkaddr = sctx->blkaddr;
 		sctx->blkaddr += ei->e.compressedblks;
 
+		/* skip write data but leave blkaddr for inline fallback */
+		if (ei->e.inlined)
+			continue;
 		ret2 = blk_write(sbi, sctx->membuf + blkoff * erofs_blksiz(sbi),
 				 ei->e.blkaddr, ei->e.compressedblks);
 		blkoff += ei->e.compressedblks;
diff --git a/lib/dedupe.c b/lib/dedupe.c
index 19a1c8d..aaaccb5 100644
--- a/lib/dedupe.c
+++ b/lib/dedupe.c
@@ -138,6 +138,7 @@ int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
 		ctx->e.partial = e->partial ||
 			(window_size + extra < e->original_length);
 		ctx->e.raw = e->raw;
+		ctx->e.inlined = false;
 		ctx->e.blkaddr = e->compressed_blkaddr;
 		ctx->e.compressedblks = e->compressed_blks;
 		return 0;
-- 
2.30.2

