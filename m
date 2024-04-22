Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 002688AC26F
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 02:36:09 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SUZPlyqJ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VN5s34Z1rz3cSg
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 10:36:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SUZPlyqJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VN5rz4Xg7z2yk7
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Apr 2024 10:36:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8F05ACE0A07;
	Mon, 22 Apr 2024 00:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B86C2BD10;
	Mon, 22 Apr 2024 00:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713746160;
	bh=jni9YULPdAuKklcG0bCZJRL00YyKW/Xc9HF98sBxnq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUZPlyqJR5YgLfIpwarAU1n7pvVD5TDO1zos1gqw4Kow+Md/FSUfsEF7bu32ulcV+
	 DY/yRvNlJwh6DNaoFbYpRE3n9mpMX4OcxAPDVej0r9KoViEs9fFkC4EY1v4qYrPHvd
	 i5AuYILNWyRAN2teRj7C2ZLHwAk5ocmDGdKg9EDdQDA28pyW8EUDAaXWxIXze10XXy
	 rUuMa7vjTBSLMGOM8vYWlkUqNpB2CqZJOe2yi37hNndwTqPT4yj0SdBSWPz4VkQbD8
	 NtGfsEahtEdkyeOdSNBW4NPtbfrnynbkoRwi6Ag3Y2+OQegqtRhdSQxUt55nYvco5T
	 3on9bd/tfpIyA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/8] erofs-utils: lib: split out erofs_commit_compressed_file()
Date: Mon, 22 Apr 2024 08:34:45 +0800
Message-Id: <20240422003450.19132-3-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240422003450.19132-1-xiang@kernel.org>
References: <20240422003450.19132-1-xiang@kernel.org>
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Just split out on-disk compressed metadata commit logic.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 191 +++++++++++++++++++++++++++----------------------
 1 file changed, 105 insertions(+), 86 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index b084446..8ca4033 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1031,6 +1031,102 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 	return 0;
 }
 
+int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
+				 struct erofs_buffer_head *bh,
+				 erofs_blk_t blkaddr,
+				 erofs_blk_t compressed_blocks)
+{
+	struct erofs_inode *inode = ictx->inode;
+	struct erofs_sb_info *sbi = inode->sbi;
+	unsigned int legacymetasize;
+	u8 *compressmeta;
+	int ret;
+
+	/* fall back to no compression mode */
+	DBG_BUGON(compressed_blocks < !!inode->idata_size);
+	compressed_blocks -= !!inode->idata_size;
+
+	compressmeta = malloc(BLK_ROUND_UP(sbi, inode->i_size) *
+			      sizeof(struct z_erofs_lcluster_index) +
+			      Z_EROFS_LEGACY_MAP_HEADER_SIZE);
+	if (!compressmeta) {
+		ret = -ENOMEM;
+		goto err_free_idata;
+	}
+	ictx->metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
+	z_erofs_write_indexes(ictx);
+
+	legacymetasize = ictx->metacur - compressmeta;
+	/* estimate if data compression saves space or not */
+	if (!inode->fragment_size &&
+	    compressed_blocks * erofs_blksiz(sbi) + inode->idata_size +
+	    legacymetasize >= inode->i_size) {
+		z_erofs_dedupe_commit(true);
+		ret = -ENOSPC;
+		goto err_free_meta;
+	}
+	z_erofs_dedupe_commit(false);
+	z_erofs_write_mapheader(inode, compressmeta);
+
+	if (!ictx->fragemitted)
+		sbi->saved_by_deduplication += inode->fragment_size;
+
+	/* if the entire file is a fragment, a simplified form is used. */
+	if (inode->i_size <= inode->fragment_size) {
+		DBG_BUGON(inode->i_size < inode->fragment_size);
+		DBG_BUGON(inode->fragmentoff >> 63);
+		*(__le64 *)compressmeta =
+			cpu_to_le64(inode->fragmentoff | 1ULL << 63);
+		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
+		legacymetasize = Z_EROFS_LEGACY_MAP_HEADER_SIZE;
+	}
+
+	if (compressed_blocks) {
+		ret = erofs_bh_balloon(bh, erofs_pos(sbi, compressed_blocks));
+		DBG_BUGON(ret != erofs_blksiz(sbi));
+	} else {
+		if (!cfg.c_fragments && !cfg.c_dedupe)
+			DBG_BUGON(!inode->idata_size);
+	}
+
+	erofs_info("compressed %s (%llu bytes) into %u blocks",
+		   inode->i_srcpath, (unsigned long long)inode->i_size,
+		   compressed_blocks);
+
+	if (inode->idata_size) {
+		bh->op = &erofs_skip_write_bhops;
+		inode->bh_data = bh;
+	} else {
+		erofs_bdrop(bh, false);
+	}
+
+	inode->u.i_blocks = compressed_blocks;
+
+	if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL) {
+		inode->extent_isize = legacymetasize;
+	} else {
+		ret = z_erofs_convert_to_compacted_format(inode, blkaddr,
+							  legacymetasize,
+							  compressmeta);
+		DBG_BUGON(ret);
+	}
+	inode->compressmeta = compressmeta;
+	if (!erofs_is_packed_inode(inode))
+		erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
+	return 0;
+
+err_free_meta:
+	free(compressmeta);
+	inode->compressmeta = NULL;
+err_free_idata:
+	if (inode->idata) {
+		free(inode->idata);
+		inode->idata = NULL;
+	}
+	erofs_bdrop(bh, true);	/* revoke buffer */
+	return ret;
+}
+
 #ifdef EROFS_MT_ENABLED
 void *z_erofs_mt_wq_tls_alloc(struct erofs_workqueue *wq, void *ptr)
 {
@@ -1260,23 +1356,9 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	static struct z_erofs_compress_sctx sctx;
 	struct erofs_compress_cfg *ccfg;
 	erofs_blk_t blkaddr, compressed_blocks = 0;
-	unsigned int legacymetasize;
 	int ret;
 	bool ismt = false;
 	struct erofs_sb_info *sbi = inode->sbi;
-	u8 *compressmeta = malloc(BLK_ROUND_UP(sbi, inode->i_size) *
-				  sizeof(struct z_erofs_lcluster_index) +
-				  Z_EROFS_LEGACY_MAP_HEADER_SIZE);
-
-	if (!compressmeta)
-		return -ENOMEM;
-
-	/* allocate main data buffer */
-	bh = erofs_balloc(DATA, 0, 0, 0);
-	if (IS_ERR(bh)) {
-		ret = PTR_ERR(bh);
-		goto err_free_meta;
-	}
 
 	/* initialize per-file compression setting */
 	inode->z_advise = 0;
@@ -1321,20 +1403,24 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	if (cfg.c_fragments && !erofs_is_packed_inode(inode)) {
 		ret = z_erofs_fragments_dedupe(inode, fd, &ctx.tof_chksum);
 		if (ret < 0)
-			goto err_bdrop;
+			return ret;
 	}
 
-	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.inode = inode;
 	ctx.fd = fd;
 	ctx.fpos = fpos;
-	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	init_list_head(&ctx.extents);
 	ctx.fix_dedupedfrag = false;
 	ctx.fragemitted = false;
 	sctx = (struct z_erofs_compress_sctx) { .ictx = &ctx, };
 	init_list_head(&sctx.extents);
 
+	/* allocate main data buffer */
+	bh = erofs_balloc(DATA, 0, 0, 0);
+	if (IS_ERR(bh))
+		return PTR_ERR(bh);
+	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
+
 	if (cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
 	    !inode->fragment_size) {
 		ret = z_erofs_pack_file_from_fd(inode, fd, ctx.tof_chksum);
@@ -1363,10 +1449,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 		compressed_blocks = sctx.blkaddr - blkaddr;
 	}
 
-	/* fall back to no compression mode */
-	DBG_BUGON(compressed_blocks < !!inode->idata_size);
-	compressed_blocks -= !!inode->idata_size;
-
 	/* generate an extent for the deduplicated fragment */
 	if (inode->fragment_size && !ctx.fragemitted) {
 		struct z_erofs_extent_item *ei;
@@ -1388,80 +1470,17 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 		z_erofs_commit_extent(&sctx, ei);
 	}
 	z_erofs_fragments_commit(inode);
-
 	if (!ismt)
 		list_splice_tail(&sctx.extents, &ctx.extents);
 
-	z_erofs_write_indexes(&ctx);
-	legacymetasize = ctx.metacur - compressmeta;
-	/* estimate if data compression saves space or not */
-	if (!inode->fragment_size &&
-	    compressed_blocks * erofs_blksiz(sbi) + inode->idata_size +
-	    legacymetasize >= inode->i_size) {
-		z_erofs_dedupe_commit(true);
-		ret = -ENOSPC;
-		goto err_free_idata;
-	}
-	z_erofs_dedupe_commit(false);
-	z_erofs_write_mapheader(inode, compressmeta);
-
-	if (!ctx.fragemitted)
-		sbi->saved_by_deduplication += inode->fragment_size;
-
-	/* if the entire file is a fragment, a simplified form is used. */
-	if (inode->i_size <= inode->fragment_size) {
-		DBG_BUGON(inode->i_size < inode->fragment_size);
-		DBG_BUGON(inode->fragmentoff >> 63);
-		*(__le64 *)compressmeta =
-			cpu_to_le64(inode->fragmentoff | 1ULL << 63);
-		inode->datalayout = EROFS_INODE_COMPRESSED_FULL;
-		legacymetasize = Z_EROFS_LEGACY_MAP_HEADER_SIZE;
-	}
-
-	if (compressed_blocks) {
-		ret = erofs_bh_balloon(bh, erofs_pos(sbi, compressed_blocks));
-		DBG_BUGON(ret != erofs_blksiz(sbi));
-	} else {
-		if (!cfg.c_fragments && !cfg.c_dedupe)
-			DBG_BUGON(!inode->idata_size);
-	}
-
-	erofs_info("compressed %s (%llu bytes) into %u blocks",
-		   inode->i_srcpath, (unsigned long long)inode->i_size,
-		   compressed_blocks);
-
-	if (inode->idata_size) {
-		bh->op = &erofs_skip_write_bhops;
-		inode->bh_data = bh;
-	} else {
-		erofs_bdrop(bh, false);
-	}
-
-	inode->u.i_blocks = compressed_blocks;
-
-	if (inode->datalayout == EROFS_INODE_COMPRESSED_FULL) {
-		inode->extent_isize = legacymetasize;
-	} else {
-		ret = z_erofs_convert_to_compacted_format(inode, blkaddr,
-							  legacymetasize,
-							  compressmeta);
-		DBG_BUGON(ret);
-	}
-	inode->compressmeta = compressmeta;
-	if (!erofs_is_packed_inode(inode))
-		erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
-	return 0;
-
+	return erofs_commit_compressed_file(&ctx, bh, blkaddr,
+					    compressed_blocks);
 err_free_idata:
 	if (inode->idata) {
 		free(inode->idata);
 		inode->idata = NULL;
 	}
-err_bdrop:
 	erofs_bdrop(bh, true);	/* revoke buffer */
-err_free_meta:
-	free(compressmeta);
-	inode->compressmeta = NULL;
 	return ret;
 }
 
-- 
2.30.2

