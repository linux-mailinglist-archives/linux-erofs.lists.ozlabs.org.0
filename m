Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0959F949E
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Dec 2024 15:39:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YF96J2nr2z30f8
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Dec 2024 01:39:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734705557;
	cv=none; b=gz6J6T11oczeUMN/sTPFu9Z0PtVcX6mGm34C8DBWweGyDJ30KQltcLZ514K/Llq+fx9+oEQnxxGyPbFxJ8BFt9VkcVoTVUktvP9Hupo55F1pG21zektRlTAnLnXKuCsBKXKcALS5Sg/qaH5ecG+jYNTOpLZv0rHbNliSBRQhFRqhL4CvfmPVazQY1oPxlmAWK5bdypBj1a3tO/IXKF5MvTXCFK8p6anhZ4/ykmfut7jTxEjR3F3vNPKmSIUO+5Z0LLD9DHg3rTByPArS0Evdj2+02em9AuTe1xjsgjwJXk6PQoRdMEZPfWpU9u18R7b+iL3d8ga84AhvIuhvhWxrgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734705557; c=relaxed/relaxed;
	bh=N+5RsIblrl0gb1IcQUmT2AZdBoNPcYSmX8Lo5nSO1jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDiWaNHRFgWnEOzTlJRzIh8VBpGyq0Q5dCpaPuRdyK2MROhZxs60XwAahBTRI9PXEqSixMArfez6FSByz10XDZhJAF3NhupAVy9bwSqcbOIlC7liM18Ecv85m9Z0IokU1hAjA7vfK/cYquPxYWVh+Malcby4lAzrU2K0gDPXx/zsO6gE632TGDVZc0lvL4EGxP3HUEnjrdj2UOnjD8+akYQC/1Uq3Qy+OV05SYmfTgdXNregG7ypSDIFK5p4T/AFcCJAQVGHlBXWoCjcrUCsuOKEnQb7tc2yxpzddVz5+As8tS78HFPWCh8g5DsHbNwKDKqNfY8YjPRLg7FHAI0PiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WQVY7KoJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WQVY7KoJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YF96B6w6Vz2xCW
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Dec 2024 01:39:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734705548; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=N+5RsIblrl0gb1IcQUmT2AZdBoNPcYSmX8Lo5nSO1jk=;
	b=WQVY7KoJsw5JQVS685NKiJmheLAaTQDN7RzksSbU8aYNytHekIinQfYlJv1uvpKKrI+e3bRL0xlAJCCXlOpLq2cJ4iPkaDJ3IgP2mtgUl2f+VB37lYX7qSP0bO+0d22IPVwAm3XFOrLI+Bbk44cfjNmBnNkT0Zy5Mtb9PMsEi9s=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLu36iC_1734705545 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Dec 2024 22:39:07 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs-utils: mkfs: speed up uncompressed data handling
Date: Fri, 20 Dec 2024 22:38:59 +0800
Message-ID: <20241220143859.643175-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241220143859.643175-1-hsiangkao@linux.alibaba.com>
References: <20241220143859.643175-1-hsiangkao@linux.alibaba.com>
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

Currently, it only writes one uncompressed block (typically 4 KiB) and
then tries to recompress the remaining part if the entire data was
compressed and proven to be incompressible.

This is wasteful of CPU resources and slow, as such incompressible data
could be skipped entirely.

The LZMA build time for large pclusters (e.g., 512K, 1M) can be greatly
reduced if there is a significant amount of uncompressed data.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 58 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 6a409de..07a6e57 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -376,8 +376,8 @@ out:
 	return 0;
 }
 
-static int write_uncompressed_extent(struct z_erofs_compress_sctx *ctx,
-				     unsigned int len, char *dst)
+static int write_uncompressed_block(struct z_erofs_compress_sctx *ctx,
+				    unsigned int len, char *dst)
 {
 	struct erofs_inode *inode = ctx->ictx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
@@ -412,6 +412,44 @@ static int write_uncompressed_extent(struct z_erofs_compress_sctx *ctx,
 	return count;
 }
 
+static int write_uncompressed_extents(struct z_erofs_compress_sctx *ctx,
+				      unsigned int size, unsigned int processed,
+				      char *dst)
+{
+	struct erofs_inode *inode = ctx->ictx->inode;
+	unsigned int lclustersize = 1 << inode->z_logical_clusterbits;
+	struct z_erofs_extent_item *ei;
+	int count;
+
+	while (1) {
+		count = write_uncompressed_block(ctx, size, dst);
+		if (count < 0)
+			return count;
+
+		size -= count;
+		if (processed < lclustersize + count)
+			break;
+		processed -= count;
+
+		ei = malloc(sizeof(*ei));
+		if (!ei)
+			return -ENOMEM;
+		init_list_head(&ei->list);
+
+		ei->e = (struct z_erofs_inmem_extent) {
+			.length = count,
+			.compressedblks = BLK_ROUND_UP(inode->sbi, count),
+			.raw = true,
+			.blkaddr = ctx->blkaddr,
+		};
+		if (ctx->blkaddr != EROFS_NULL_ADDR)
+			ctx->blkaddr += ei->e.compressedblks;
+		z_erofs_commit_extent(ctx, ei);
+		ctx->head += count;
+	}
+	return count;
+}
+
 static unsigned int z_erofs_get_max_pclustersize(struct erofs_inode *inode)
 {
 	if (erofs_is_packed_inode(inode)) {
@@ -533,6 +571,7 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	unsigned int compressedsize;
 	int ret;
 
+	DBG_BUGON(ctx->pivot);
 	*e = (struct z_erofs_inmem_extent){};
 	if (len <= ctx->pclustersize) {
 		if (!final || !len)
@@ -545,8 +584,10 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 			e->length = len;
 			goto frag_packing;
 		}
-		if (!may_inline && len <= blksz)
+		if (!may_inline && len <= blksz) {
+			e->length = len;
 			goto nocompression;
+		}
 	}
 
 	e->length = min(len, cfg.c_max_decompressed_extent_bytes);
@@ -574,9 +615,11 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 		} else {
 			may_inline = false;
 			may_packing = false;
+			e->length = min_t(u32, e->length, ret);
 nocompression:
 			/* TODO: reset clusterofs to 0 if permitted */
-			ret = write_uncompressed_extent(ctx, len, dst);
+			ret = write_uncompressed_extents(ctx, len,
+							 e->length, dst);
 			if (ret < 0)
 				return ret;
 		}
@@ -702,17 +745,16 @@ static int z_erofs_compress_one(struct z_erofs_compress_sctx *ctx)
 	while (ctx->tail > ctx->head) {
 		int ret = z_erofs_compress_dedupe(ctx);
 
+		if (ret < 0)
+			return ret;
 		if (ret > 0)
 			break;
-		else if (ret < 0)
-			return ret;
 
-		DBG_BUGON(ctx->pivot);
 		ei = malloc(sizeof(*ei));
 		if (!ei)
 			return -ENOMEM;
-
 		init_list_head(&ei->list);
+
 		ret = __z_erofs_compress_one(ctx, &ei->e);
 		if (ret) {
 			free(ei);
-- 
2.43.5

