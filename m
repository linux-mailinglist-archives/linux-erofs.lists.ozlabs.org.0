Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F35854A9CAB
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Feb 2022 17:10:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jr0qh59m3z3bZT
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Feb 2022 03:10:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jr0qZ4SCvz30Lt
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Feb 2022 03:10:01 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R721e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V3ZWJQW_1643990992; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V3ZWJQW_1643990992) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 05 Feb 2022 00:09:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: lib: refine tailpcluster compression approach
Date: Sat,  5 Feb 2022 00:09:44 +0800
Message-Id: <20220204160944.120151-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220204160944.120151-1-hsiangkao@linux.alibaba.com>
References: <20220204160944.120151-1-hsiangkao@linux.alibaba.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As my previous comment [1] mentioned, currently, in order to inline
a tail pcluster right after its inode metadata, tail data is split,
compressed with many 4KiB pclusters and then the last pcluster is
chosen.

However, it can have some impacts to overall compression ratios if big
pclusters are enabled. So instead, let's implement another approach:
compressing with two pclusters by trying recompressing.

It also enables EOF lcluster inlining for small compressed data, so
please make sure the kernel is already fixed up [2].

[1] https://lore.kernel.org/r/YXkBIpcCG12Y8qMN@B-P7TQMD6M-0146.local
[2] https://lore.kernel.org/r/20220203190203.30794-1-xiang@kernel.org
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 89 ++++++++++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 39 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 7db666a..9566681 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -70,14 +70,15 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 
 	di.di_clusterofs = cpu_to_le16(ctx->clusterofs);
 
-	/* whether the tail-end uncompressed block or not */
+	/* whether the tail-end (un)compressed block or not */
 	if (!d1) {
 		/*
-		 * A lcluster cannot have there parts with the middle one which
-		 * is well-compressed. Such tail pcluster cannot be inlined.
+		 * A lcluster cannot have three parts with the middle one which
+		 * is well-compressed for !ztailpacking cases.
 		 */
-		DBG_BUGON(!raw);
-		type = Z_EROFS_VLE_CLUSTER_TYPE_PLAIN;
+		DBG_BUGON(!raw && !cfg.c_ztailpacking);
+		type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
+			Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
 		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
 
 		di.di_advise = advise;
@@ -180,6 +181,31 @@ static int z_erofs_fill_inline_data(struct erofs_inode *inode, void *data,
 	return len;
 }
 
+static void tryrecompress_trailing(void *in, unsigned int *insize,
+				   void *out, int *compressedsize)
+{
+	static char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
+	unsigned int count, ret;
+
+	ret = *compressedsize;
+	/* no need to recompress */
+	if (!(ret & (EROFS_BLKSIZ - 1)))
+		return;
+
+	count = *insize;
+	ret = erofs_compress_destsize(&compresshandle,
+				      in, &count, (void *)tmp,
+				      rounddown(ret, EROFS_BLKSIZ), false);
+	if (ret <= 0 || ret + (*insize - count) >=
+			roundup(*compressedsize, EROFS_BLKSIZ))
+		return;
+
+	/* replace the original compressed data if any gain */
+	memcpy(out, tmp, ret);
+	*insize = count;
+	*compressedsize = ret;
+}
+
 static int vle_compress_one(struct erofs_inode *inode,
 			    struct z_erofs_vle_compress_ctx *ctx,
 			    bool final)
@@ -190,54 +216,32 @@ static int vle_compress_one(struct erofs_inode *inode,
 	int ret;
 	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
 	char *const dst = dstbuf + EROFS_BLKSIZ;
-	bool trailing = false, tailpcluster = false;
 
 	while (len) {
 		unsigned int pclustersize =
 			z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
+		bool may_inline = (cfg.c_ztailpacking && final);
 		bool raw;
 
-		DBG_BUGON(tailpcluster);
 		if (len <= pclustersize) {
-			if (final) {
-				/* TODO: compress with 2 pclusters instead */
-				if (cfg.c_ztailpacking) {
-					trailing = true;
-					pclustersize = EROFS_BLKSIZ;
-				} else if (len <= EROFS_BLKSIZ) {
-					goto nocompression;
-				}
-			} else {
+			if (!final)
 				break;
-			}
+			if (!may_inline && len <= EROFS_BLKSIZ)
+				goto nocompression;
 		}
 
 		count = min(len, cfg.c_max_decompressed_extent_bytes);
 		ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
 					      &count, dst, pclustersize,
 					      !(final && len == count));
-
-		/* XXX: need to be polished, yet do it correctly first. */
-		if (cfg.c_ztailpacking && final) {
-			if (ret <= 0 && len < EROFS_BLKSIZ) {
-				DBG_BUGON(!trailing);
-				tailpcluster = true;
-			} else if (ret > 0 && len == count &&
-				   /* less than 1 compressed block */
-				   ret < EROFS_BLKSIZ) {
-				tailpcluster = true;
-			}
-		}
-
-		if (ret <= 0 || (tailpcluster &&
-				 ctx->clusterofs + len < EROFS_BLKSIZ)) {
-			if (ret <= 0 && ret != -EAGAIN) {
+		if (ret <= 0) {
+			if (ret != -EAGAIN) {
 				erofs_err("failed to compress %s: %s",
 					  inode->i_srcpath,
 					  erofs_strerror(ret));
 			}
 
-			if (tailpcluster && len < EROFS_BLKSIZ)
+			if (may_inline && len < EROFS_BLKSIZ)
 				ret = z_erofs_fill_inline_data(inode,
 						ctx->queue + ctx->head,
 						len, true);
@@ -256,18 +260,23 @@ nocompression:
 			 */
 			ctx->compressedblks = 1;
 			raw = true;
-		} else if (tailpcluster && ret < EROFS_BLKSIZ) {
+		/* tailpcluster should be less than 1 block */
+		} else if (may_inline && len == count &&
+			   ret < EROFS_BLKSIZ) {
 			ret = z_erofs_fill_inline_data(inode, dst, ret, false);
 			if (ret < 0)
 				return ret;
 			ctx->compressedblks = 1;
 			raw = false;
 		} else {
-			const unsigned int tailused = ret & (EROFS_BLKSIZ - 1);
-			const unsigned int padding =
-				erofs_sb_has_lz4_0padding() && tailused ?
-					EROFS_BLKSIZ - tailused : 0;
+			unsigned int tailused, padding;
+
+			if (may_inline && len == count)
+				tryrecompress_trailing(ctx->queue + ctx->head,
+						       &count, dst, &ret);
 
+			tailused = ret & (EROFS_BLKSIZ - 1);
+			padding = 0;
 			ctx->compressedblks = DIV_ROUND_UP(ret, EROFS_BLKSIZ);
 			DBG_BUGON(ctx->compressedblks * EROFS_BLKSIZ >= count);
 
@@ -275,6 +284,8 @@ nocompression:
 			if (!erofs_sb_has_lz4_0padding())
 				memset(dst + ret, 0,
 				       roundup(ret, EROFS_BLKSIZ) - ret);
+			else if (tailused)
+				padding = EROFS_BLKSIZ - tailused;
 
 			/* write compressed data */
 			erofs_dbg("Writing %u compressed data to %u of %u blocks",
-- 
2.24.4

