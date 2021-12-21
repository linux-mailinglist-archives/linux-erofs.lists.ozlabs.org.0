Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A115647BD15
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Dec 2021 10:44:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JJBNv1XMtz2yp9
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Dec 2021 20:43:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JJBNj3VBVz2x99
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Dec 2021 20:43:46 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R441e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V.K7m0l_1640079804; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V.K7m0l_1640079804) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 21 Dec 2021 17:43:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 2/2] erofs-utils: mkfs: support tail-packing inline
 compressed data
Date: Tue, 21 Dec 2021 17:43:21 +0800
Message-Id: <20211221094321.108367-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211221094321.108367-1-hsiangkao@linux.alibaba.com>
References: <20211221094321.108367-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

Currently, we only support tail-end inline data for uncompressed
files, let's support it as well for compressed files.

Signed-off-by: Yue Hu <huyue2@yulong.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h   |   1 +
 include/erofs/internal.h |   1 +
 lib/compress.c           | 122 ++++++++++++++++++++++++++++++---------
 lib/compressor.c         |  14 +++--
 lib/compressor.h         |   2 +-
 lib/inode.c              |  55 +++++++++++++-----
 mkfs/main.c              |   8 +++
 7 files changed, 155 insertions(+), 48 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index e41c079..a3f9bac 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -43,6 +43,7 @@ struct erofs_configure {
 	char c_timeinherit;
 	char c_chunkbits;
 	bool c_noinline_data;
+	bool c_ztailpacking;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 9b75754..108ad01 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -175,6 +175,7 @@ struct erofs_inode {
 	unsigned char inode_isize;
 	/* inline tail-end packing size */
 	unsigned short idata_size;
+	bool compressed_idata;
 
 	unsigned int xattr_isize;
 	unsigned int extent_isize;
diff --git a/lib/compress.c b/lib/compress.c
index 6f16e0c..adb98b2 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -72,7 +72,10 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 
 	/* whether the tail-end uncompressed block or not */
 	if (!d1) {
-		/* TODO: tail-packing inline compressed data */
+		/*
+		 * A lcluster cannot have there parts with the middle one which
+		 * is well-compressed. Such tail pcluster cannot be inlined.
+		 */
 		DBG_BUGON(!raw);
 		type = Z_EROFS_VLE_CLUSTER_TYPE_PLAIN;
 		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
@@ -162,6 +165,21 @@ static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode)
 	return cfg.c_pclusterblks_def;
 }
 
+static int z_erofs_fill_inline_data(struct erofs_inode *inode, void *data,
+				    unsigned int len, bool raw)
+{
+	inode->idata_size = len;
+	inode->compressed_idata = !raw;
+
+	inode->idata = malloc(inode->idata_size);
+	if (!inode->idata)
+		return -ENOMEM;
+	erofs_dbg("Recording %u %scompressed inline data",
+		  inode->idata_size, raw ? "un" : "");
+	memcpy(inode->idata, data, inode->idata_size);
+	return len;
+}
+
 static int vle_compress_one(struct erofs_inode *inode,
 			    struct z_erofs_vle_compress_ctx *ctx,
 			    bool final)
@@ -172,16 +190,23 @@ static int vle_compress_one(struct erofs_inode *inode,
 	int ret;
 	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
 	char *const dst = dstbuf + EROFS_BLKSIZ;
+	bool trailing = false, tailpcluster = false;
 
 	while (len) {
-		const unsigned int pclustersize =
+		unsigned int pclustersize =
 			z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
 		bool raw;
 
+		DBG_BUGON(tailpcluster);
 		if (len <= pclustersize) {
 			if (final) {
-				if (len <= EROFS_BLKSIZ)
+				/* TODO: compress with 2 pclusters instead */
+				if (cfg.c_ztailpacking) {
+					trailing = true;
+					pclustersize = EROFS_BLKSIZ;
+				} else if (len <= EROFS_BLKSIZ) {
 					goto nocompression;
+				}
 			} else {
 				break;
 			}
@@ -189,20 +214,54 @@ static int vle_compress_one(struct erofs_inode *inode,
 
 		count = min(len, cfg.c_max_decompressed_extent_bytes);
 		ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
-					      &count, dst, pclustersize);
-		if (ret <= 0) {
-			if (ret != -EAGAIN) {
+				&count, dst, pclustersize,
+				!(trailing && len == count));
+
+		/* XXX: need to be polished, yet do it correctly first. */
+		if (cfg.c_ztailpacking && final) {
+			if (ret <= 0 && len < EROFS_BLKSIZ) {
+				DBG_BUGON(!trailing);
+				tailpcluster = true;
+			} else if (ret > 0 && len == count &&
+				   /* less than 1 compressed block */
+				   ret < EROFS_BLKSIZ - 10) {
+				tailpcluster = true;
+			}
+		}
+
+		if (ret <= 0 || (tailpcluster &&
+				 ctx->clusterofs + len < EROFS_BLKSIZ)) {
+			if (ret <= 0 && ret != -EAGAIN) {
 				erofs_err("failed to compress %s: %s",
 					  inode->i_srcpath,
 					  erofs_strerror(ret));
 			}
+
+			if (tailpcluster && len < EROFS_BLKSIZ)
+				ret = z_erofs_fill_inline_data(inode,
+						ctx->queue + ctx->head,
+						len, true);
+			else
 nocompression:
-			ret = write_uncompressed_extent(ctx, &len, dst);
+				ret = write_uncompressed_extent(ctx, &len, dst);
+
 			if (ret < 0)
 				return ret;
 			count = ret;
+
+			/*
+			 * XXX: For now, we have to leave `ctx->compressedblks
+			 * = 1' since there is no way to generate compressed
+			 * indexes after the time that ztailpacking is decided.
+			 */
 			ctx->compressedblks = 1;
 			raw = true;
+		} else if (tailpcluster && ret < EROFS_BLKSIZ) {
+			ret = z_erofs_fill_inline_data(inode, dst, ret, false);
+			if (ret < 0)
+				return ret;
+			ctx->compressedblks = 1;
+			raw = false;
 		} else {
 			const unsigned int tailused = ret & (EROFS_BLKSIZ - 1);
 			const unsigned int padding =
@@ -449,6 +508,7 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
 {
 	struct z_erofs_map_header h = {
 		.h_advise = cpu_to_le16(inode->z_advise),
+		.h_idata_size = cpu_to_le16(inode->idata_size),
 		.h_algorithmtype = inode->z_algorithmtype[1] << 4 |
 				   inode->z_algorithmtype[0],
 		/* lclustersize */
@@ -476,7 +536,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
 	if (fd < 0) {
 		ret = -errno;
-		goto err_free;
+		goto err_free_meta;
 	}
 
 	/* allocate main data buffer */
@@ -504,8 +564,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	inode->z_algorithmtype[1] = algorithmtype[1];
 	inode->z_logical_clusterbits = LOG_BLOCK_SIZE;
 
-	z_erofs_write_mapheader(inode, compressmeta);
-
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.blkaddr = blkaddr;
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
@@ -534,35 +592,42 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	/* do the final round */
 	ret = vle_compress_one(inode, &ctx, true);
 	if (ret)
-		goto err_bdrop;
+		goto err_free_idata;
 
 	/* fall back to no compression mode */
 	compressed_blocks = ctx.blkaddr - blkaddr;
-	if (compressed_blocks >= BLK_ROUND_UP(inode->i_size)) {
-		ret = -ENOSPC;
-		goto err_bdrop;
-	}
+	DBG_BUGON(compressed_blocks < !!inode->idata_size);
+	compressed_blocks -= !!inode->idata_size;
 
 	vle_write_indexes_final(&ctx);
+	legacymetasize = ctx.metacur - compressmeta;
+	/* estimate if data compression is space saving */
+	if (compressed_blocks * EROFS_BLKSIZ + inode->idata_size +
+	    legacymetasize >= inode->i_size) {
+		ret = -ENOSPC;
+		goto err_free_idata;
+	}
+	z_erofs_write_mapheader(inode, compressmeta);
 
 	close(fd);
-	DBG_BUGON(!compressed_blocks);
-	ret = erofs_bh_balloon(bh, blknr_to_addr(compressed_blocks));
-	DBG_BUGON(ret != EROFS_BLKSIZ);
+	if (compressed_blocks) {
+		ret = erofs_bh_balloon(bh, blknr_to_addr(compressed_blocks));
+		DBG_BUGON(ret != EROFS_BLKSIZ);
+	} else {
+		DBG_BUGON(!inode->idata_size);
+	}
 
 	erofs_info("compressed %s (%llu bytes) into %u blocks",
 		   inode->i_srcpath, (unsigned long long)inode->i_size,
 		   compressed_blocks);
 
-	/*
-	 * TODO: need to move erofs_bdrop to erofs_write_tail_end
-	 *       when both mkfs & kernel support compression inline.
-	 */
-	erofs_bdrop(bh, false);
-	inode->idata_size = 0;
+	if (inode->idata_size)
+		inode->bh_data = bh;
+	else
+		erofs_bdrop(bh, false);
+
 	inode->u.i_blocks = compressed_blocks;
 
-	legacymetasize = ctx.metacur - compressmeta;
 	if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		inode->extent_isize = legacymetasize;
 	} else {
@@ -575,11 +640,16 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
 	return 0;
 
+err_free_idata:
+	if (inode->idata) {
+		free(inode->idata);
+		inode->idata = NULL;
+	}
 err_bdrop:
 	erofs_bdrop(bh, true);	/* revoke buffer */
 err_close:
 	close(fd);
-err_free:
+err_free_meta:
 	free(compressmeta);
 	return ret;
 }
diff --git a/lib/compressor.c b/lib/compressor.c
index 3e04a3a..67b8060 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -24,23 +24,27 @@ static const struct erofs_compressor *compressors[] = {
 
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
-			    void *dst, unsigned int dstsize)
+			    void *dst, unsigned int dstsize, bool inblocks)
 {
-	unsigned int uncompressed_size;
+	unsigned int uncompressed_capacity, compressed_size;
 	int ret;
 
 	DBG_BUGON(!c->alg);
 	if (!c->alg->compress_destsize)
 		return -ENOTSUP;
 
+	uncompressed_capacity = *srcsize;
 	ret = c->alg->compress_destsize(c, src, srcsize, dst, dstsize);
 	if (ret < 0)
 		return ret;
 
+	if (inblocks || uncompressed_capacity != *srcsize)
+		compressed_size = roundup(ret, EROFS_BLKSIZ);
+	else
+		compressed_size = ret;
+	DBG_BUGON(c->compress_threshold < 100);
 	/* check if there is enough gains to compress */
-	uncompressed_size = *srcsize;
-	if (roundup(ret, EROFS_BLKSIZ) >= uncompressed_size *
-	    c->compress_threshold / 100)
+	if (*srcsize <= compressed_size * c->compress_threshold / 100)
 		return -EAGAIN;
 	return ret;
 }
diff --git a/lib/compressor.h b/lib/compressor.h
index 728dd0b..cf063f1 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -47,7 +47,7 @@ extern const struct erofs_compressor erofs_compressor_lzma;
 
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
-			    void *dst, unsigned int dstsize);
+			    void *dst, unsigned int dstsize, bool inblocks);
 
 int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level);
 int erofs_compressor_init(struct erofs_compress *c, char *alg_name);
diff --git a/lib/inode.c b/lib/inode.c
index b6d3092..e4cbf30 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -593,28 +593,29 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 		inodesize = Z_EROFS_VLE_EXTENT_ALIGN(inodesize) +
 			    inode->extent_isize;
 
-	if (is_inode_layout_compression(inode))
-		goto noinline;
+	/* TODO: tailpacking inline of chunk-based format isn't finalized */
 	if (inode->datalayout == EROFS_INODE_CHUNK_BASED)
 		goto noinline;
 
-	if (cfg.c_noinline_data && S_ISREG(inode->i_mode)) {
-		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
-		goto noinline;
+	if (!is_inode_layout_compression(inode)) {
+		if (cfg.c_noinline_data && S_ISREG(inode->i_mode)) {
+			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
+			goto noinline;
+		}
+		/*
+		 * If the file sizes of uncompressed files are block-aligned,
+		 * should use the EROFS_INODE_FLAT_PLAIN data layout.
+		 */
+		if (!inode->idata_size)
+			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 	}
 
-	/*
-	 * if the file size is block-aligned for uncompressed files,
-	 * should use EROFS_INODE_FLAT_PLAIN data mapping mode.
-	 */
-	if (!inode->idata_size)
-		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
-
 	bh = erofs_balloc(INODE, inodesize, 0, inode->idata_size);
 	if (bh == ERR_PTR(-ENOSPC)) {
 		int ret;
 
-		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
+		if (!is_inode_layout_compression(inode))
+			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 noinline:
 		/* expend an extra block for tail-end data */
 		ret = erofs_prepare_tail_block(inode);
@@ -627,7 +628,18 @@ noinline:
 	} else if (IS_ERR(bh)) {
 		return PTR_ERR(bh);
 	} else if (inode->idata_size) {
-		inode->datalayout = EROFS_INODE_FLAT_INLINE;
+		if (is_inode_layout_compression(inode)) {
+			struct z_erofs_map_header *h = inode->compressmeta;
+
+			DBG_BUGON(!cfg.c_ztailpacking);
+			h->h_advise |= Z_EROFS_ADVISE_INLINE_PCLUSTER;
+			erofs_dbg("Inline %scompressed data (%u bytes) to %s",
+				  inode->compressed_idata ? "" : "un",
+				  inode->idata_size, inode->i_srcpath);
+			erofs_sb_set_ztailpacking();
+		} else {
+			inode->datalayout = EROFS_INODE_FLAT_INLINE;
+		}
 
 		/* allocate inline buffer */
 		ibh = erofs_battach(bh, META, inode->idata_size);
@@ -685,15 +697,26 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		erofs_droid_blocklist_write_tail_end(inode, NULL_ADDR);
 	} else {
 		int ret;
-		erofs_off_t pos;
+		erofs_off_t pos, zero_pos;
 
 		erofs_mapbh(bh->block);
 		pos = erofs_btell(bh, true) - EROFS_BLKSIZ;
+
+		/* 0'ed data should be padded at head for 0padding conversion */
+		if (erofs_sb_has_lz4_0padding() && inode->compressed_idata) {
+			zero_pos = pos;
+			pos += EROFS_BLKSIZ - inode->idata_size;
+		} else {
+			/* pad 0'ed data for the other cases */
+			zero_pos = pos + inode->idata_size;
+		}
 		ret = dev_write(inode->idata, pos, inode->idata_size);
 		if (ret)
 			return ret;
+
+		DBG_BUGON(inode->idata_size > EROFS_BLKSIZ);
 		if (inode->idata_size < EROFS_BLKSIZ) {
-			ret = dev_fillzero(pos + inode->idata_size,
+			ret = dev_fillzero(zero_pos,
 					   EROFS_BLKSIZ - inode->idata_size,
 					   false);
 			if (ret)
diff --git a/mkfs/main.c b/mkfs/main.c
index 90cedde..9eb696a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -187,6 +187,12 @@ static int parse_extended_opts(const char *opts)
 				return -EINVAL;
 			cfg.c_force_chunkformat = FORCE_INODE_CHUNK_INDEXES;
 		}
+
+		if (MATCH_EXTENTED_OPT("ztailpacking", token, keylen)) {
+			if (vallen)
+				return -EINVAL;
+			cfg.c_ztailpacking = true;
+		}
 	}
 	return 0;
 }
@@ -625,6 +631,8 @@ int main(int argc, char **argv)
 	erofs_show_config();
 	if (erofs_sb_has_chunked_file())
 		erofs_warn("EXPERIMENTAL chunked file feature in use. Use at your own risk!");
+	if (cfg.c_ztailpacking)
+		erofs_warn("EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
 	erofs_set_fs_root(cfg.c_src_path);
 #ifndef NDEBUG
 	if (cfg.c_random_pclusterblks)
-- 
2.24.4

