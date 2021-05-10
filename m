Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C891377D0B
	for <lists+linux-erofs@lfdr.de>; Mon, 10 May 2021 09:23:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fdswb6vqSz2yx4
	for <lists+linux-erofs@lfdr.de>; Mon, 10 May 2021 17:23:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pYhsZGN9;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=pYhsZGN9; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FdswY3sTVz302H
 for <linux-erofs@lists.ozlabs.org>; Mon, 10 May 2021 17:23:25 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08F7A6143C;
 Mon, 10 May 2021 07:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620631403;
 bh=Dk4FRy8kmPfe88BVoRYmV8eYfnmnGdjmHQifOg0VRQk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pYhsZGN9ZB+kzrnwq3ldeDKVt1bDyBhcz7DWvbhZ9XtEa3bqTvlqPWBXoWlRPfV/g
 v2AfTsRvl8azj0yG3Xh5U0fjRnGX92Iq+aoI3viTrMt50BHZpVpq9wBqWmaShQSUxJ
 pihibdMYD47nczfUv1fKJMW0ejhtTPWuR8AeTuFvTxSWrOrudiW7XzAiMgP4yUL6gn
 ghPb6Ve9xnjJI2e1ypEJZZPYmjifm5wwkrNOS9Y96QcJdqPPVdH0OBzcdlEQha3X/S
 BOrJj3rcG3gjUF7+56y4ZttJkRQw/FO40ZyhlXyqoi/+zaLqkXSBFv3mZJMA8zVofh
 GfCG7KEdfm7Mw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Li Guifu <bluce.liguifu@huawei.com>
Subject: [PATCH 3/4] erofs-utils: prepare for per-(sub)file compress strategies
Date: Mon, 10 May 2021 15:23:02 +0800
Message-Id: <20210510072303.4628-4-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510072303.4628-1-xiang@kernel.org>
References: <20210510072303.4628-1-xiang@kernel.org>
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
Cc: Gao Xiang <xiang@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In order to adjust pclustersize on the per-(sub)file basis,
generating per-file map headers are needed instead.

In addition to that, we could use COMPACT_4B on the per-file
basis as well after this patch.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 lib/compress.c | 80 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 27 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index e146416890f0..89f87dc4096c 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -22,7 +22,7 @@
 static struct erofs_compress compresshandle;
 static int compressionlevel;
 
-static struct z_erofs_map_header mapheader;
+static unsigned int algorithmtype[2];
 
 struct z_erofs_vle_compress_ctx {
 	u8 *metacur;
@@ -149,12 +149,17 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 	return count;
 }
 
+/* TODO: apply per-(sub)file strategies here */
+static unsigned int z_erofs_get_max_pclustersize(struct erofs_inode *inode)
+{
+	return cfg.c_physical_clusterblks * EROFS_BLKSIZ;
+}
+
 static int vle_compress_one(struct erofs_inode *inode,
 			    struct z_erofs_vle_compress_ctx *ctx,
 			    bool final)
 {
-	const unsigned int pclusterblks = cfg.c_physical_clusterblks;
-	const unsigned int pclustersize = pclusterblks * EROFS_BLKSIZ;
+	const unsigned int pclustersize = z_erofs_get_max_pclustersize(inode);
 	struct erofs_compress *const h = &compresshandle;
 	unsigned int len = ctx->tail - ctx->head;
 	unsigned int count;
@@ -342,13 +347,14 @@ static void *write_compacted_indexes(u8 *out,
 int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 					erofs_blk_t blkaddr,
 					unsigned int legacymetasize,
-					unsigned int logical_clusterbits)
+					void *compressmeta)
 {
 	const unsigned int mpos = Z_EROFS_VLE_EXTENT_ALIGN(inode->inode_isize +
 							   inode->xattr_isize) +
 				  sizeof(struct z_erofs_map_header);
 	const unsigned int totalidx = (legacymetasize -
 				       Z_EROFS_LEGACY_MAP_HEADER_SIZE) / 8;
+	const unsigned int logical_clusterbits = inode->z_logical_clusterbits;
 	u8 *out, *in;
 	struct z_erofs_compressindex_vec cv[16];
 	/* # of 8-byte units so that it can be aligned with 32 bytes */
@@ -379,9 +385,9 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 		compacted_4b_end = totalidx;
 	}
 
-	out = in = inode->compressmeta;
+	out = in = compressmeta;
 
-	out += sizeof(mapheader);
+	out += sizeof(struct z_erofs_map_header);
 	in += Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 
 	dummy_head = false;
@@ -428,11 +434,26 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 					      4, logical_clusterbits, true,
 					      &dummy_head);
 	}
-	inode->extent_isize = out - (u8 *)inode->compressmeta;
-	inode->datalayout = EROFS_INODE_FLAT_COMPRESSION;
+	inode->extent_isize = out - (u8 *)compressmeta;
 	return 0;
 }
 
+static void z_erofs_write_mapheader(struct erofs_inode *inode,
+				    void *compressmeta)
+{
+	struct z_erofs_map_header h = {
+		.h_advise = cpu_to_le16(inode->z_advise),
+		.h_algorithmtype = inode->z_algorithmtype[1] << 4 |
+				   inode->z_algorithmtype[0],
+		/* lclustersize */
+		.h_clusterbits = inode->z_logical_clusterbits - 12,
+	};
+
+	memset(compressmeta, 0, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
+	/* write out map header */
+	memcpy(compressmeta, &h, sizeof(struct z_erofs_map_header));
+}
+
 int erofs_write_compressed_file(struct erofs_inode *inode)
 {
 	struct erofs_buffer_head *bh;
@@ -459,9 +480,25 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 		goto err_close;
 	}
 
-	memset(compressmeta, 0, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
-	/* write out compressed header */
-	memcpy(compressmeta, &mapheader, sizeof(mapheader));
+	/* initialize per-file compression setting */
+	inode->z_advise = 0;
+	if (!cfg.c_legacy_compress) {
+		inode->z_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
+		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION;
+	} else {
+		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+	}
+
+	if (cfg.c_physical_clusterblks > 1) {
+		inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
+		if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION)
+			inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
+	}
+	inode->z_algorithmtype[0] = algorithmtype[0];
+	inode->z_algorithmtype[1] = algorithmtype[1];
+	inode->z_logical_clusterbits = LOG_BLOCK_SIZE;
+
+	z_erofs_write_mapheader(inode, compressmeta);
 
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.blkaddr = blkaddr;
@@ -516,19 +553,19 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	 *       when both mkfs & kernel support compression inline.
 	 */
 	erofs_bdrop(bh, false);
-	inode->compressmeta = compressmeta;
 	inode->idata_size = 0;
 	inode->u.i_blocks = compressed_blocks;
 
 	legacymetasize = ctx.metacur - compressmeta;
-	if (cfg.c_legacy_compress) {
+	if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		inode->extent_isize = legacymetasize;
-		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
 	} else {
 		ret = z_erofs_convert_to_compacted_format(inode, blkaddr,
-							  legacymetasize, 12);
+							  legacymetasize,
+							  compressmeta);
 		DBG_BUGON(ret);
 	}
+	inode->compressmeta = compressmeta;
 	return 0;
 
 err_bdrop:
@@ -580,7 +617,6 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
 
 int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 {
-	unsigned int algorithmtype[2];
 	/* initialize for primary compression algorithm */
 	int ret = erofs_compressor_init(&compresshandle,
 					cfg.c_compr_alg_master);
@@ -603,16 +639,13 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 		compresshandle.alg->default_level :
 		cfg.c_compr_level_master;
 
-	/* figure out mapheader */
+	/* figure out primary algorithm */
 	ret = erofs_get_compress_algorithm_id(cfg.c_compr_alg_master);
 	if (ret < 0)
 		return ret;
 
 	algorithmtype[0] = ret;	/* primary algorithm (head 0) */
 	algorithmtype[1] = 0;	/* secondary algorithm (head 1) */
-	mapheader.h_advise = 0;
-	if (!cfg.c_legacy_compress)
-		mapheader.h_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
 	/*
 	 * if big pcluster is enabled, an extra CBLKCNT lcluster index needs
 	 * to be loaded in order to get those compressed block counts.
@@ -625,15 +658,8 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 			return -EINVAL;
 		}
 		erofs_sb_set_big_pcluster();
-		mapheader.h_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
-		if (!cfg.c_legacy_compress)
-			mapheader.h_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
-
 		erofs_warn("EXPERIMENTAL big pcluster feature in use. Use at your own risk!");
 	}
-	mapheader.h_algorithmtype = algorithmtype[1] << 4 |
-					  algorithmtype[0];
-	mapheader.h_clusterbits = LOG_BLOCK_SIZE - 12;
 
 	if (erofs_sb_has_compr_cfgs()) {
 		sbi.available_compr_algs |= 1 << ret;
-- 
2.20.1

