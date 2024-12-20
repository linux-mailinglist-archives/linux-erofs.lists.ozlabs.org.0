Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2BD9F8F27
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Dec 2024 10:39:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YF2SL09w9z30YL
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Dec 2024 20:39:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734687568;
	cv=none; b=EBgVCQ+gLO+aToO7bgINu3ZM6noxfMuQknFzjDaZ+dT2FDAbQY5rP+46eYNElRcXYEfaHJFGZWC1wOGzDyiQ9szwu/sa8twCJjFn+RhLOmydMYm/r2UtE3kZLGuznRDF2raNqXY43SKSFLW16a11FiBJRWEn7g7RvGQbRo5rSQF1m8WGKLF+h7b7E2fVIkFsVkbM/12UtB2nhwYS7+kinvXTizoKkGY0XDCDaEejbtOEE1j5K6NP5l2kuud7t6j5caot0ylhIZakC5kbSybSDdo+UDdNNl81RUHw3ChBCdH0ktleaefS9j+7HGZGH1iOBrwxvc+RvoH/HlDUl/7n5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734687568; c=relaxed/relaxed;
	bh=zKKaqQFhJL25A5W7EFH4CL1yEDAcHBmtBmHJbVD/LpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIujvc7KDuu9da/yIrwqyEEPEN67IHG8cHIWObZpGc/2uGBnqedEG9nrKGvCW0moi6fY3y0rI/TfnoLox5qmdw4OXqFq+9QSCXAgvvhngHHRdzBwoCPox49zGmcm6eg5xO4TVF3tIfW4KkwCt7RrGe5kXetA+u6vRRLPOH48z83E0BnSxBrKB3LAXiiKcKTlKM8E0SjQ6l+RzxvljIcfKQh7pyg3TxC3FXrrBxYE6oko5Yq6ldEd7NQVPu0BRADDXYrlsvPc9jTQG7CvT8MaEspbyfxYuu4rDYI1wbg8k/DLGK1+epEW0J4MDeUDDWUaWzR4wohnOni7rzQlOFMICg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WiODRdxD; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WiODRdxD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YF2SF6BxKz30Vq
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Dec 2024 20:39:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734687558; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zKKaqQFhJL25A5W7EFH4CL1yEDAcHBmtBmHJbVD/LpA=;
	b=WiODRdxDn++WYWzpYvw6mPebJww45Mw1z54dRvyjF6nrSC97jawtgkNlPNJ07utt5ZfMB5r9Hp4MyFKVsApfKyB/wCkJE87rcPZ1JqA1MQp6nikQDC7BEKlW73cfWpxqLTyki/u/ycukkMf9WJpRLA//JhZ48PWBUFfJXffSa64=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLtTKu5_1734687552 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Dec 2024 17:39:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: speed up uncompressed data handling
Date: Fri, 20 Dec 2024 17:39:11 +0800
Message-ID: <20241220093911.213122-1-hsiangkao@linux.alibaba.com>
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

Currently, it only writes one uncompressed block (typically 4 KiB) and
then tries to recompress the remaining part if the entire data was
compressed and proven to be incompressible.

This is wasteful of CPU resources and slow, as such incompressible data
could be skipped entirely.

The LZMA build time for large pclusters (e.g., 512K, 1M) can be greatly
reduced if there is a significant amount of uncompressed data.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 53 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 65edd00..d298b8f 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -378,8 +378,8 @@ out:
 	return 0;
 }
 
-static int write_uncompressed_extent(struct z_erofs_compress_sctx *ctx,
-				     unsigned int len, char *dst)
+static int write_uncompressed_block(struct z_erofs_compress_sctx *ctx,
+				    unsigned int len, char *dst)
 {
 	struct erofs_inode *inode = ctx->ictx->inode;
 	struct erofs_sb_info *sbi = inode->sbi;
@@ -414,6 +414,44 @@ static int write_uncompressed_extent(struct z_erofs_compress_sctx *ctx,
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
@@ -536,6 +574,7 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	unsigned int compressedsize;
 	int ret;
 
+	DBG_BUGON(ctx->pivot);
 	*e = (struct z_erofs_inmem_extent){};
 	if (len <= ctx->pclustersize) {
 		if (!final || !len)
@@ -579,7 +618,8 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 			may_packing = false;
 nocompression:
 			/* TODO: reset clusterofs to 0 if permitted */
-			ret = write_uncompressed_extent(ctx, len, dst);
+			ret = write_uncompressed_extents(ctx, len,
+					min_t(u32, e->length, ret), dst);
 			if (ret < 0)
 				return ret;
 		}
@@ -706,17 +746,16 @@ static int z_erofs_compress_one(struct z_erofs_compress_sctx *ctx)
 	while (len) {
 		int ret = z_erofs_compress_dedupe(ctx, &len);
 
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

