Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45928A864E
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Apr 2024 16:43:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKNv54Q18z3cNQ
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 00:43:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKNtz4Chbz3cGK
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 00:43:21 +1000 (AEST)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 6F08010087427
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Apr 2024 22:43:12 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 0E62637C91F;
	Wed, 17 Apr 2024 22:43:10 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: skip the redundant write for ztailpacking block
Date: Wed, 17 Apr 2024 22:42:51 +0800
Message-ID: <20240417144251.1845355-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.44.0
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
Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

z_erofs_merge_segment() doesn't consider the ztailpacking block in the
extent list and unnecessarily writes it back to the disk. This patch
fixes this issue by introducing a new `inlined` field in the struct
`z_erofs_inmem_extent`.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
 include/erofs/dedupe.h | 2 +-
 lib/compress.c         | 8 ++++++++
 lib/dedupe.c           | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

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
index 74c5707..41628e7 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -572,6 +572,7 @@ nocompression:
 		 */
 		e->compressedblks = 1;
 		e->raw = true;
+		e->inlined = false;
 	} else if (may_packing && len == e->length &&
 		   compressedsize < ctx->pclustersize &&
 		   (!inode->fragment_size || ictx->fix_dedupedfrag)) {
@@ -582,6 +583,7 @@ frag_packing:
 			return ret;
 		e->compressedblks = 0; /* indicate a fragment */
 		e->raw = false;
+		e->inlined = false;
 		ictx->fragemitted = true;
 	/* tailpcluster should be less than 1 block */
 	} else if (may_inline && len == e->length && compressedsize < blksz) {
@@ -600,6 +602,7 @@ frag_packing:
 			return ret;
 		e->compressedblks = 1;
 		e->raw = false;
+		e->inlined = true;
 	} else {
 		unsigned int tailused, padding;
 
@@ -652,6 +655,7 @@ frag_packing:
 				return ret;
 		}
 		e->raw = false;
+		e->inlined = false;
 		may_inline = false;
 		may_packing = false;
 	}
@@ -1151,6 +1155,9 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
 		ei->e.blkaddr = sctx->blkaddr;
 		sctx->blkaddr += ei->e.compressedblks;
 
+		if (ei->e.inlined)
+			continue;
+
 		ret2 = blk_write(sbi, sctx->membuf + blkoff * erofs_blksiz(sbi),
 				 ei->e.blkaddr, ei->e.compressedblks);
 		blkoff += ei->e.compressedblks;
@@ -1374,6 +1381,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 			.compressedblks = 0,
 			.raw = false,
 			.partial = false,
+			.inlined = false,
 			.blkaddr = sctx.blkaddr,
 		};
 		init_list_head(&ei->list);
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
2.44.0

