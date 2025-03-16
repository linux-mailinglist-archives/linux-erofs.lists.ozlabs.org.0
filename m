Return-Path: <linux-erofs+bounces-67-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5730A63374
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Mar 2025 04:36:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZFkLH6Y91z2ydw;
	Sun, 16 Mar 2025 14:36:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742096215;
	cv=none; b=XgWL3d3xj2vT1LjnpvPZzGW21CTV14RNBqRENtD+ZCzVCpVFAvvT1SzBpftL6keflalOIUwYDrzGWiV3R+tr9z9x13xOVVy2YxFDpUpMNpbTn/eU6gckAFUURsKaA4lkEGm4KeY0QK3+Fjv7hFQ6G8atj6KVf4rbH5bt+CLOnvL8IZIQ1exXZxey0mqv4stadxilqjVlq00FC/p/HaAODC7Dl9xCQ7AkascLyFeFc+ijjsmEokbkbKv62TZ2AmMwhJZmFtkASyIeZJ3cSh+cDkLpIaLRBlAaeOAGCgKVomDzUHhgrJyH2PnNt7lq2iXnXarZJCOsheafhdqWlDGTXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742096215; c=relaxed/relaxed;
	bh=/xs7zmzn6J/Vb39A7gO2+vZgMH6yFaPkhU+YZINtQWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LNw5Jl2/5j/9VGyOcecFOfiJe7WqcQvdF4K1tBtB3Qe+IMLjueFoWnIMxa9hXjBfuh55dCiqxG/Q3gmIIFzsIOo8KbBr9QvDs4mlW95CppYeAvsYFLPvUZwXiHrvyltxIrM/NEeuIaJR6JbKJaxLy3q/AbGJ317S5ajQ6aSVowxf6sjP3VgDtTIHgbniZpzp98bt3IdJFrloo+8FzxTYpfOxyoVXnMJfwcRxYKp4fzoPH+pvfqpdu7aAOr7zec3nb5xlHHOQD8HjUpAmw/JjLh1AbuoRJlhn89XswldgjnZ3m/zoAbTU7PNwt9z7MKye2gh3lerNQxSmySUJCqCU9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=a+9r6QxT; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=a+9r6QxT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZFkLC3qmyz2ydQ
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Mar 2025 14:36:50 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742096206; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/xs7zmzn6J/Vb39A7gO2+vZgMH6yFaPkhU+YZINtQWo=;
	b=a+9r6QxTjxkubLBE3KfDMr47NWNBc8SuBhByZli5aVGTcsUs8dfz0RVwh6XlaO4E0F2B2zPatCNwb0xYsCtP/RzkusHH/JnIQFnBiqKFALaqQF9zOB9a4uJ0P4a63zL59jfu8+RdNXFxVwvEIj4RbS2YKSPT4eO5ZbARSZK3LBo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRSkS3E_1742096200 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Mar 2025 11:36:44 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 1/8] erofs-utils: lib: move buffer allocation into z_erofs_write_indexes()
Date: Sun, 16 Mar 2025 11:36:32 +0800
Message-ID: <20250316033639.1050759-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Just used to prepare for extent-based metadata.  No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
no change.

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


