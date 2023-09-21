Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 723B47A9149
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Sep 2023 05:24:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RrgkB2slLz3c5c
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Sep 2023 13:24:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rrgk63xKpz2ytV
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Sep 2023 13:24:29 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VsWxrGY_1695266658;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VsWxrGY_1695266658)
          by smtp.aliyun-inc.com;
          Thu, 21 Sep 2023 11:24:23 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix the previous pcluster CBLKCNT missing for big pcluster dedupe
Date: Thu, 21 Sep 2023 11:24:17 +0800
Message-Id: <20230921032417.82739-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Similar to 876bec09e48a ("erofs-utils: lib: fix missing CBLKCNT for
big pcluster dedupe"), the previous CBLKCNT cannot be dropped due to
the extent shortening process.

It may cause data corruption on specific data patterns only if both
big pcluster and dedupe features are enabled.

Fixes: f3f9a2ce3137 ("erofs-utils: mkfs: introduce global compressed data deduplication")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 81f277a..f6dc12a 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -170,6 +170,7 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 				   unsigned int *len)
 {
 	struct erofs_inode *inode = ctx->inode;
+	const unsigned int lclustermask = (1 << inode->z_logical_clusterbits) - 1;
 	struct erofs_sb_info *sbi = inode->sbi;
 	int ret = 0;
 
@@ -205,22 +206,32 @@ static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 		 * decompresssion could be done as another try in practice.
 		 */
 		if (dctx.e.compressedblks > 1 &&
-		    (ctx->clusterofs + ctx->e.length - delta) % erofs_blksiz(sbi) +
-			dctx.e.length < 2 * erofs_blksiz(sbi))
+		    ((ctx->clusterofs + ctx->e.length - delta) & lclustermask) +
+			dctx.e.length < 2 * (lclustermask + 1))
 			break;
 
-		/* fall back to noncompact indexes for deduplication */
-		inode->z_advise &= ~Z_EROFS_ADVISE_COMPACTED_2B;
-		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
-		erofs_sb_set_dedupe(sbi);
-
 		if (delta) {
 			DBG_BUGON(delta < 0);
 			DBG_BUGON(!ctx->e.length);
+
+			/*
+			 * For big pcluster dedupe, if we decide to shorten the
+			 * previous big pcluster, make sure that the previous
+			 * CBLKCNT is still kept.
+			 */
+			if (ctx->e.compressedblks > 1 &&
+			    (ctx->clusterofs & lclustermask) + ctx->e.length
+				- delta < 2 * (lclustermask + 1))
+				break;
 			ctx->e.partial = true;
 			ctx->e.length -= delta;
 		}
 
+		/* fall back to noncompact indexes for deduplication */
+		inode->z_advise &= ~Z_EROFS_ADVISE_COMPACTED_2B;
+		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
+		erofs_sb_set_dedupe(sbi);
+
 		sbi->saved_by_deduplication +=
 			dctx.e.compressedblks * erofs_blksiz(sbi);
 		erofs_dbg("Dedupe %u %scompressed data (delta %d) to %u of %u blocks",
-- 
2.24.4

