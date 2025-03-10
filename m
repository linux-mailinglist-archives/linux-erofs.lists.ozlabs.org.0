Return-Path: <linux-erofs+bounces-26-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F24A58F87
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Mar 2025 10:25:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBBM52PTsz30Tf;
	Mon, 10 Mar 2025 20:25:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741598721;
	cv=none; b=dNni4tEPXQzZ/4Zuy2rM5f643ixE2dN0OhGrudGk5rGdlei90D62Lt/c4hGT92fMrf+YVnMzgn2B4AyCwh8/28ZDVtNRZlKp5doFwTZJc0dz5auPVqAgiiZ3abYIt0wv0b6WYk7r4c7DAsVvx7r7dXvluDW7FwBjobVNidXT7IvQg5eaX85EjQF3ATqIaqvTUypQ748F9WtvJaT0l58NEHiNk1YgcJwFuQkGmoPjAYMFAondDbc/g4jTMkBp87aaw/ovbah6r+qMj0YsmbSHtuC5myZ+VWncpIDnY1ZQ/T0NNAnQwPG7Y6/K2lqLiq3PrdhUn5yn3iexzBwlDRxRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741598721; c=relaxed/relaxed;
	bh=ngQbfSWhKpNWxInUOuxQrrAb/Fkvy3Kpj5jwPom4Xdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GToTE6uuHR4yd7PJvRFmFzi+pUkoXrVmgJsTkNB88aSKHUXUVwJDTV+nnQdLGpclTbNrVxY5ASmhkD3TcAqfzj8qjn8jw9PV5VkBLplPDCyQgbsGkB+BzCduOj1TckrskNMq6ISYMjTZP5sF4CefXU6iWHPN/an93uXrXPgAwcvlPyHqoQWn5OGDim0q/WpbyvJzMsdFHz33ebi8xf5RtwZ9X63zRCBY03X1HKuNSZDVtRJyiryZr3abQ7IkpVAcNNdI6Ua5b0/4fevoNvAUiOT7krnKhHeO88gcAE73pL1eMdLvIVDC5GvKC6HEUF+mT4NbVXt1PJJKIYWYLQH7Rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ISpQMLCX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ISpQMLCX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBBM32cdWz2y8p
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Mar 2025 20:25:17 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741598713; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ngQbfSWhKpNWxInUOuxQrrAb/Fkvy3Kpj5jwPom4Xdo=;
	b=ISpQMLCX3iE/gPI4TQ3I3AqJi41EYPom95Vlg3XKLS0mO3fIk6wfHgqmm4lL/5D8v5MfQv+uWsix5rFQ5OmGGGMrtj7mIM1IvtJa6ArLiVfYTrzAwJTJMLb7809ETjdvCtKGh5DYdOA9+LVc0yUZuCQy7NQpqMGDMtVPPsmXESg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR0RN8s_1741598711 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:25:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/7] erofs-utils: lib: move buffer allocation into z_erofs_write_indexes()
Date: Mon, 10 Mar 2025 17:25:02 +0800
Message-ID: <20250310092508.2573532-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

Just used to prepare for extent-based metadata.  No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 52 ++++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index da3fded..1072451 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -120,7 +120,7 @@ static bool z_erofs_mt_enabled;
 
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	Z_EROFS_FULL_INDEX_ALIGN(0)
 
-static void z_erofs_write_indexes_final(struct z_erofs_compress_ictx *ctx)
+static void z_erofs_fini_full_indexes(struct z_erofs_compress_ictx *ctx)
 {
 	const unsigned int type = Z_EROFS_LCLUSTER_TYPE_PLAIN;
 	struct z_erofs_lcluster_index di;
@@ -136,8 +136,8 @@ static void z_erofs_write_indexes_final(struct z_erofs_compress_ictx *ctx)
 	ctx->metacur += sizeof(di);
 }
 
-static void z_erofs_write_extent(struct z_erofs_compress_ictx *ctx,
-				 struct z_erofs_inmem_extent *e)
+static void z_erofs_write_full_indexes(struct z_erofs_compress_ictx *ctx,
+				       struct z_erofs_inmem_extent *e)
 {
 	struct erofs_inode *inode = ctx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
@@ -233,20 +233,6 @@ static void z_erofs_write_extent(struct z_erofs_compress_ictx *ctx,
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
@@ -1006,6 +992,31 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
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
@@ -1126,15 +1137,11 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 	DBG_BUGON(compressed_blocks < !!inode->idata_size);
 	compressed_blocks -= !!inode->idata_size;
 
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
@@ -1146,7 +1153,6 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 		goto err_free_meta;
 	}
 	z_erofs_dedupe_commit(false);
-	z_erofs_write_mapheader(inode, compressmeta);
 
 	if (!ictx->fragemitted)
 		sbi->saved_by_deduplication += inode->fragment_size;
-- 
2.43.5


