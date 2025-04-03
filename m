Return-Path: <linux-erofs+bounces-140-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EB871A79DBE
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Apr 2025 10:14:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZSvf3027mz305D;
	Thu,  3 Apr 2025 19:14:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743668058;
	cv=none; b=lBipt0h/jCOygCQi582ZQDSpkhobTFddazFiEP9bSvt799jNVj2D2ovg9xJ1q1zKXBmjOa+IZtH1PetYNDvIzBhkfdrXAxqXHlmzXIf6aoGciBT+G6Xn1WUA/qWCAMdI8fJhRs/Bb6FED4nzZ/PqdAQKHpoM/AjttVYZrukva50Ac0gM4fRfPSYrYD34cTHDphfAyoCQg/ern94Dri1REx3GRUw9zEPWyNXHdzhd8NQApcKu/RK4PlUF7jTep5nM2mKHMFasnupVDhbzc+7xFrGL3ikE28+rbTtvmT1SkKEF6VvDCm07vzG/h+XJy9Lfj35EP5WPSfiwvifFDWUkIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743668058; c=relaxed/relaxed;
	bh=13guzda1ND+EFhsRAOXgn6zlq3GU2NBgioC9uYcZ9GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S74Z9uTeMkUftQt/8tgV4La1WNCYboCZ3X7pWaRhcZIdK1P8CH21ddZLcC9p16H/i+0hrifJl6UI5qJxlzJerOxpAcTJOJLz/27g7Sr8JkG3gGqCj8GXHciluF70+2w5hpgfwthrTyRzwArDKbPPspu7vxRXpIIPJQdBnVRRmcSDFjlQ0RVOKeIksQfzsNoVcp/lmSdn9R64dTCUfkyBmpzHORcnBJA/W5tI5IvBk/UWDK9YsixjYEYgh3dxdHTxYakELqXZWjni3pqkCTrglimOe61THFZTQYioGYNNFv9UnynQ85d1YLlrbPRrWcmtmrJ6rFbWu+sRxMtwOvX8ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=B7L+r5Yv; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=B7L+r5Yv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZSvf03zDDz2ySP
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Apr 2025 19:14:14 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743668051; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=13guzda1ND+EFhsRAOXgn6zlq3GU2NBgioC9uYcZ9GE=;
	b=B7L+r5Yv8cFqyhStmyVYXWGrXR2hHy9Trzen5ZKjBKKegNYSn+avYPXc2AkS9w0fAkGyfS6xtOsGOrXoqS7XR60kY8Jr5mDTnqgA6AMK3WnGXvoTTHSB5E2bB2j2sGr/knRNg9t6PAdlWG0qn/UG6D1ONKnWFtLUlDtDtwb2mZ4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WUcFcNq_1743668048 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 03 Apr 2025 16:14:10 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/3] erofs-utils: lib: move buffer allocation into z_erofs_write_indexes()
Date: Thu,  3 Apr 2025 16:14:02 +0800
Message-ID: <20250403081403.2671077-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250403081403.2671077-1-hsiangkao@linux.alibaba.com>
References: <20250403081403.2671077-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Just used to prepare for extent-based metadata.  No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 52 ++++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index eaca4d3..50d155e 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -121,7 +121,7 @@ static bool z_erofs_mt_enabled;
 
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	Z_EROFS_FULL_INDEX_ALIGN(0)
 
-static void z_erofs_write_indexes_final(struct z_erofs_compress_ictx *ctx)
+static void z_erofs_fini_full_indexes(struct z_erofs_compress_ictx *ctx)
 {
 	const unsigned int type = Z_EROFS_LCLUSTER_TYPE_PLAIN;
 	struct z_erofs_lcluster_index di;
@@ -137,8 +137,8 @@ static void z_erofs_write_indexes_final(struct z_erofs_compress_ictx *ctx)
 	ctx->metacur += sizeof(di);
 }
 
-static void z_erofs_write_extent(struct z_erofs_compress_ictx *ctx,
-				 struct z_erofs_inmem_extent *e)
+static void z_erofs_write_full_indexes(struct z_erofs_compress_ictx *ctx,
+				       struct z_erofs_inmem_extent *e)
 {
 	struct erofs_inode *inode = ctx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
@@ -236,20 +236,6 @@ static void z_erofs_write_extent(struct z_erofs_compress_ictx *ctx,
 	ctx->clusterofs = clusterofs + count;
 }
 
-static void z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
-{
-	struct z_erofs_extent_item *ei, *n;
-
-	ctx->clusterofs = 0;
-	list_for_each_entry_safe(ei, n, &ctx->extents, list) {
-		z_erofs_write_extent(ctx, &ei->e);
-
-		list_del(&ei->list);
-		free(ei);
-	}
-	z_erofs_write_indexes_final(ctx);
-}
-
 static bool z_erofs_need_refill(struct z_erofs_compress_sctx *ctx)
 {
 	const bool final = !ctx->remaining;
@@ -1012,6 +998,31 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
 	memcpy(compressmeta, &h, sizeof(struct z_erofs_map_header));
 }
 
+static void *z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
+{
+	struct erofs_inode *inode = ctx->inode;
+	struct z_erofs_extent_item *ei, *n;
+	void *metabuf;
+
+	metabuf = malloc(BLK_ROUND_UP(inode->sbi, inode->i_size) *
+			 sizeof(struct z_erofs_lcluster_index) +
+			 Z_EROFS_LEGACY_MAP_HEADER_SIZE);
+	if (!metabuf)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->metacur = metabuf + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
+	ctx->clusterofs = 0;
+	list_for_each_entry_safe(ei, n, &ctx->extents, list) {
+		z_erofs_write_full_indexes(ctx, &ei->e);
+
+		list_del(&ei->list);
+		free(ei);
+	}
+	z_erofs_fini_full_indexes(ctx);
+	z_erofs_write_mapheader(inode, metabuf);
+	return metabuf;
+}
+
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
@@ -1145,15 +1156,11 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 	DBG_BUGON(pstart < (!!inode->idata_size) << bbits);
 	ptotal -= (!!inode->idata_size) << bbits;
 
-	compressmeta = malloc(BLK_ROUND_UP(sbi, inode->i_size) *
-			      sizeof(struct z_erofs_lcluster_index) +
-			      Z_EROFS_LEGACY_MAP_HEADER_SIZE);
+	compressmeta = z_erofs_write_indexes(ictx);
 	if (!compressmeta) {
 		ret = -ENOMEM;
 		goto err_free_idata;
 	}
-	ictx->metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
-	z_erofs_write_indexes(ictx);
 
 	legacymetasize = ictx->metacur - compressmeta;
 	/* estimate if data compression saves space or not */
@@ -1164,7 +1171,6 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 		goto err_free_meta;
 	}
 	z_erofs_dedupe_commit(false);
-	z_erofs_write_mapheader(inode, compressmeta);
 
 	if (!ictx->fragemitted)
 		sbi->saved_by_deduplication += inode->fragment_size;
-- 
2.43.5


