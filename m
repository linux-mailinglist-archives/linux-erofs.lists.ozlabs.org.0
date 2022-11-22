Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F96633573
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Nov 2022 07:45:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NGZX85VNnz3cMf
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Nov 2022 17:45:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NGZX40F0gz2xl0
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Nov 2022 17:45:38 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VVR..ZS_1669099528;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VVR..ZS_1669099528)
          by smtp.aliyun-inc.com;
          Tue, 22 Nov 2022 14:45:33 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: fix missing CBLKCNT for big pcluster dedupe
Date: Tue, 22 Nov 2022 14:45:27 +0800
Message-Id: <20221122064527.26563-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

CBLKCNT needs to be stored for big pcluster dedupe.  Otherwise,
the decompression could fail due to incomplete compressed data.

Reported-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 17b3213..50fea0c 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -186,11 +186,6 @@ static int z_erofs_compress_dedupe(struct erofs_inode *inode,
 		if (z_erofs_dedupe_match(&dctx))
 			break;

-		/* fall back to noncompact indexes for deduplication */
-		inode->z_advise &= ~Z_EROFS_ADVISE_COMPACTED_2B;
-		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
-		erofs_sb_set_dedupe();
-
 		delta = ctx->queue + ctx->head - dctx.cur;
 		if (delta) {
 			DBG_BUGON(delta < 0);
@@ -199,10 +194,24 @@ static int z_erofs_compress_dedupe(struct erofs_inode *inode,
 			ctx->e.length -= delta;
 		}

+		/*
+		 * For big pcluster dedupe, leave two indices at least to store
+		 * CBLKCNT as the first step.  Even laterly, an one-block
+		 * decompresssion could be done as another try in practice.
+		 */
+		z_erofs_write_indexes(ctx);
+		if (dctx.e.compressedblks > 1 &&
+		    ctx->clusterofs + dctx.e.length < 2*EROFS_BLKSIZ)
+			return ret;
+
+		/* fall back to noncompact indexes for deduplication */
+		inode->z_advise &= ~Z_EROFS_ADVISE_COMPACTED_2B;
+		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+		erofs_sb_set_dedupe();
+
 		erofs_dbg("Dedupe %u %scompressed data (delta %d) to %u of %u blocks",
 			  dctx.e.length, dctx.e.raw ? "un" : "",
 			  delta, dctx.e.blkaddr, dctx.e.compressedblks);
-		z_erofs_write_indexes(ctx);
 		ctx->e = dctx.e;
 		ctx->head += dctx.e.length - delta;
 		DBG_BUGON(*len < dctx.e.length - delta);
--
2.30.2

