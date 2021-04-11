Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B1735B155
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 05:49:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FHyXp5HS5z3br7
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 13:49:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gIEKPpTm;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=gIEKPpTm; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FHyXm49M6z3bxj
 for <linux-erofs@lists.ozlabs.org>; Sun, 11 Apr 2021 13:49:12 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53EA0611AF;
 Sun, 11 Apr 2021 03:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618112951;
 bh=UTCQhhHMgJEMgk6rYtR39hVT8GFpJAfxLbr4zmJrAPw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gIEKPpTmQa8eZoNGdzlSxicbmnZSZPzrQGbOLbkdHeMXlSrgj4e7+QnlV71Lzspqc
 QNKR9n20cfZFWY96bHGGPJyQ0YPc0Cuu4Hw8egkBbBaKlxQB0kne3WVXAL3g/Z4LFb
 ahQPfBxYQHX2vC7/BRA4P/XpH76Pb2b3aomWURQ6hbCFY0n6+em4B9xE8sIu6gS6V1
 H06+DC3qzYt4d5hD3qPxWw6HoOlGuzlSgkuvtNMLvM2rfS0+wZxj9o4azAGDaz1CW9
 m/WdAJqytiyawFivb+O31OfbNoRjt21QwrQ0Rz05Npug5uh73+Z1ToN64quU9a48ZX
 9aYhzd9xFMlvw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 8/8] erofs-utils: mkfs: support compact indexes for bigpcluster
Date: Sun, 11 Apr 2021 11:48:44 +0800
Message-Id: <20210411034844.12673-9-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210411034844.12673-1-xiang@kernel.org>
References: <20210411034844.12673-1-xiang@kernel.org>
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

This adds support to generate big pcluster compact indexes.

Different from non big pcluster, blkaddr recorded in each pack is
the 1st pcluster blkaddr with a valid CBLKCNT since we don't know
compressed block count of each pcluster when reading HEAD lcluster.

For more details, also see related kernel commits.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 lib/compress.c | 52 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index c8b627db5bec..654286d3f33e 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -267,9 +267,10 @@ static void *write_compacted_indexes(u8 *out,
 				     erofs_blk_t *blkaddr_ret,
 				     unsigned int destsize,
 				     unsigned int logical_clusterbits,
-				     bool final)
+				     bool final, bool *dummy_head)
 {
-	unsigned int vcnt, encodebits, pos, i;
+	unsigned int vcnt, encodebits, pos, i, cblks;
+	bool update_blkaddr;
 	erofs_blk_t blkaddr;
 
 	if (destsize == 4) {
@@ -281,6 +282,7 @@ static void *write_compacted_indexes(u8 *out,
 	}
 	encodebits = (vcnt * destsize * 8 - 32) / vcnt;
 	blkaddr = *blkaddr_ret;
+	update_blkaddr = erofs_sb_has_big_pcluster();
 
 	pos = 0;
 	for (i = 0; i < vcnt; ++i) {
@@ -288,13 +290,26 @@ static void *write_compacted_indexes(u8 *out,
 		u8 ch, rem;
 
 		if (cv[i].clustertype == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
-			if (i + 1 == vcnt)
+			if (cv[i].u.delta[0] & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+				cblks = cv[i].u.delta[0] & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+				offset = cv[i].u.delta[0];
+				blkaddr += cblks;
+				*dummy_head = false;
+			} else if (i + 1 == vcnt) {
 				offset = cv[i].u.delta[1];
-			else
+			} else {
 				offset = cv[i].u.delta[0];
+			}
 		} else {
 			offset = cv[i].clusterofs;
-			++blkaddr;
+			if (*dummy_head) {
+				++blkaddr;
+				if (update_blkaddr)
+					*blkaddr_ret = blkaddr;
+			}
+			*dummy_head = true;
+			update_blkaddr = false;
+
 			if (cv[i].u.blkaddr != blkaddr) {
 				if (i + 1 != vcnt)
 					DBG_BUGON(!final);
@@ -330,6 +345,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	/* # of 8-byte units so that it can be aligned with 32 bytes */
 	unsigned int compacted_4b_initial, compacted_4b_end;
 	unsigned int compacted_2b;
+	bool dummy_head;
 
 	if (logical_clusterbits < LOG_BLOCK_SIZE || LOG_BLOCK_SIZE < 12)
 		return -EINVAL;
@@ -359,11 +375,19 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	out += sizeof(mapheader);
 	in += Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 
+	dummy_head = false;
+	/* prior to bigpcluster, blkaddr was bumped up once coming into HEAD */
+	if (!erofs_sb_has_big_pcluster()) {
+		--blkaddr;
+		dummy_head = true;
+	}
+
 	/* generate compacted_4b_initial */
 	while (compacted_4b_initial) {
 		in = parse_legacy_indexes(cv, 2, in);
 		out = write_compacted_indexes(out, cv, &blkaddr,
-					      4, logical_clusterbits, false);
+					      4, logical_clusterbits, false,
+					      &dummy_head);
 		compacted_4b_initial -= 2;
 	}
 	DBG_BUGON(compacted_4b_initial);
@@ -372,7 +396,8 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	while (compacted_2b) {
 		in = parse_legacy_indexes(cv, 16, in);
 		out = write_compacted_indexes(out, cv, &blkaddr,
-					      2, logical_clusterbits, false);
+					      2, logical_clusterbits, false,
+					      &dummy_head);
 		compacted_2b -= 16;
 	}
 	DBG_BUGON(compacted_2b);
@@ -381,7 +406,8 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	while (compacted_4b_end > 1) {
 		in = parse_legacy_indexes(cv, 2, in);
 		out = write_compacted_indexes(out, cv, &blkaddr,
-					      4, logical_clusterbits, false);
+					      4, logical_clusterbits, false,
+					      &dummy_head);
 		compacted_4b_end -= 2;
 	}
 
@@ -390,7 +416,8 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 		memset(cv, 0, sizeof(cv));
 		in = parse_legacy_indexes(cv, 1, in);
 		out = write_compacted_indexes(out, cv, &blkaddr,
-					      4, logical_clusterbits, true);
+					      4, logical_clusterbits, true,
+					      &dummy_head);
 	}
 	inode->extent_isize = out - (u8 *)inode->compressmeta;
 	inode->datalayout = EROFS_INODE_FLAT_COMPRESSION;
@@ -485,12 +512,11 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	inode->u.i_blocks = compressed_blocks;
 
 	legacymetasize = ctx.metacur - compressmeta;
-	/* XXX: temporarily use legacy index instead for mbpcluster */
-	if (cfg.c_legacy_compress || cfg.c_physical_clusterblks > 1) {
+	if (cfg.c_legacy_compress) {
 		inode->extent_isize = legacymetasize;
 		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
 	} else {
-		ret = z_erofs_convert_to_compacted_format(inode, blkaddr - 1,
+		ret = z_erofs_convert_to_compacted_format(inode, blkaddr,
 							  legacymetasize, 12);
 		DBG_BUGON(ret);
 	}
@@ -591,6 +617,8 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 		}
 		erofs_sb_set_big_pcluster();
 		mapheader.h_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
+		if (!cfg.c_legacy_compress)
+			mapheader.h_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
 	}
 	mapheader.h_algorithmtype = algorithmtype[1] << 4 |
 					  algorithmtype[0];
-- 
2.20.1

