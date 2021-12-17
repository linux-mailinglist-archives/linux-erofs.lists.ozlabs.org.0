Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ECF4783B3
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Dec 2021 04:38:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JFZSc5B7vz2ynk
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Dec 2021 14:38:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=yulong.com (client-ip=203.205.195.102; helo=smtpproxy21.qq.com;
 envelope-from=huyue2@yulong.com; receiver=<UNKNOWN>)
Received: from smtpproxy21.qq.com (smtpbg702.qq.com [203.205.195.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JFZSS4RRSz2xtM
 for <linux-erofs@lists.ozlabs.org>; Fri, 17 Dec 2021 14:37:30 +1100 (AEDT)
X-QQ-mid: bizesmtp37t1639712230tjohzic2
Received: from localhost.localdomain (unknown [114.221.228.108])
 by esmtp6.qq.com (ESMTP) with 
 id ; Fri, 17 Dec 2021 11:36:23 +0800 (CST)
X-QQ-SSF: 01400000002000Z0Z000B00A0000000
X-QQ-FEAT: BdZir0TL0TMoF1Eh6BvCFfxv5MN6lsYXC4aYIk1b6Q3Lh0miv8fuKGo9gCCYn
 dLTH7fO0SpA9+3zy8sDKDQhr+IlH7q8JfO9WLA54sPdJ9CUPBy/XTQtwWEUFzEB+pAuODuL
 OM76hvyJgqD0XNW3Bk8F9CqerFFY8kLjbWt1dfTw4c2n0P8Y2Qhyu5hT0gXXF4zAkx1VGhD
 rSccaxh1pONroFC+CTV7IDIqcplyf3XE/mFEvOpZqw5NuQCZ2OpvM3H1JPzRPkKU4SlA3p4
 fgt0HTLt7hvpOK3jyI8XGE3hR72L6JDU9yMlyrnn+j568/0e3GS707RSuDJ1iXpt/0ZC+MS
 G2RWt7Rh8F9Omu+cy+k02DeAmGvs4qGnKHqrh8+s/M9bjX1dYfGqG5MG0+rJA==
X-QQ-GoodBg: 2
From: Yue Hu <huyue2@yulong.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	bluce.lee@aliyun.com
Subject: [RFC PATCH v6 2/2] erofs-utils: support tail-packing inline
 compressed data
Date: Fri, 17 Dec 2021 11:36:21 +0800
Message-Id: <dc8cbdb7a03e839dd244702bdef3b620408aaa93.1639645434.git.huyue2@yulong.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <7189219558e9190cb807b0084233bafbd3fdd9de.1639645434.git.huyue2@yulong.com>
References: <7189219558e9190cb807b0084233bafbd3fdd9de.1639645434.git.huyue2@yulong.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:yulong.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
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
Cc: geshifei@coolpad.com, zhangwen@coolpad.com, Yue Hu <huyue2@yulong.com>,
 shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, we only support tail-end inline data for uncompressed
files, let's support it as well for compressed files.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
changes since v5:
- fix index compressedblks

changes since v4:
- rebase on latest experimental-ztailpacking branch
- add zero-padding for compressed tail-end since fuse logic

changes since v3:
- improve messy if-else logic in vle_compress_one() suggested by Xiang.
- remove on-disk feature since it's moved to fuse part.

changes since v2:
- based on commit 9fe440d0ac03 ("erofs-utils: mkfs: introduce --quiet option").
- move h_idata_size ahead of h_advise for compatibility.
- rename feature/update messages which i think they are more exact.

changes since v1:
- add 2 bytes to record compressed size of tail-pcluster suggested by
  Xiang and update related code.

 include/erofs/internal.h |  2 +
 lib/compress.c           | 88 +++++++++++++++++++++++++++++-----------
 lib/compressor.c         |  9 ++--
 lib/decompress.c         |  3 ++
 lib/inode.c              | 53 +++++++++++++-----------
 mkfs/main.c              |  7 ++++
 6 files changed, 110 insertions(+), 52 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 773f668..e4e92c6 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -175,6 +175,8 @@ struct erofs_inode {
 	unsigned char inode_isize;
 	/* inline tail-end packing size */
 	unsigned short idata_size;
+	/* for compression inline */
+	bool idata_zipped;
 
 	unsigned int xattr_isize;
 	unsigned int extent_isize;
diff --git a/lib/compress.c b/lib/compress.c
index 6f16e0c..e686ebf 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -70,11 +70,10 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 
 	di.di_clusterofs = cpu_to_le16(ctx->clusterofs);
 
-	/* whether the tail-end uncompressed block or not */
+	/* whether the tail-end (un)compressed block or not */
 	if (!d1) {
-		/* TODO: tail-packing inline compressed data */
-		DBG_BUGON(!raw);
-		type = Z_EROFS_VLE_CLUSTER_TYPE_PLAIN;
+		type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
+			Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
 		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
 
 		di.di_advise = advise;
@@ -162,6 +161,19 @@ static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode)
 	return cfg.c_pclusterblks_def;
 }
 
+static int z_erofs_fill_inline_data(struct erofs_inode *inode, char *data,
+				    unsigned int len, bool raw)
+{
+	inode->idata_size = len;
+	inode->idata_zipped = !raw;
+
+	inode->idata = malloc(inode->idata_size);
+	if (!inode->idata)
+		return -ENOMEM;
+	memcpy(inode->idata, data, inode->idata_size);
+	return 0;
+}
+
 static int vle_compress_one(struct erofs_inode *inode,
 			    struct z_erofs_vle_compress_ctx *ctx,
 			    bool final)
@@ -172,16 +184,22 @@ static int vle_compress_one(struct erofs_inode *inode,
 	int ret;
 	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
 	char *const dst = dstbuf + EROFS_BLKSIZ;
+	bool trailing = false;
 
 	while (len) {
-		const unsigned int pclustersize =
+		unsigned int pclustersize =
 			z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
 		bool raw;
 
 		if (len <= pclustersize) {
 			if (final) {
-				if (len <= EROFS_BLKSIZ)
+				/* TODO: compress with 2 pclusters */
+				if (erofs_sb_has_ztailpacking()) {
+					trailing = true;
+					pclustersize = EROFS_BLKSIZ;
+				} else if (len <= EROFS_BLKSIZ) {
 					goto nocompression;
+				}
 			} else {
 				break;
 			}
@@ -196,13 +214,29 @@ static int vle_compress_one(struct erofs_inode *inode,
 					  inode->i_srcpath,
 					  erofs_strerror(ret));
 			}
+			if (trailing && len < EROFS_BLKSIZ) {
+				ret = z_erofs_fill_inline_data(inode,
+					(char *)(ctx->queue + ctx->head), len,
+					true);
+				if (ret)
+					return ret;
+				count = len;
+				ctx->compressedblks = 1;
+			} else {
 nocompression:
-			ret = write_uncompressed_extent(ctx, &len, dst);
-			if (ret < 0)
+				ret = write_uncompressed_extent(ctx, &len, dst);
+				if (ret < 0)
+					return ret;
+				count = ret;
+				ctx->compressedblks = 1;
+			}
+			raw = true;
+		} else if (trailing && ret < EROFS_BLKSIZ && len == count) {
+			ret = z_erofs_fill_inline_data(inode, dst, ret, false);
+			if (ret)
 				return ret;
-			count = ret;
 			ctx->compressedblks = 1;
-			raw = true;
+			raw = false;
 		} else {
 			const unsigned int tailused = ret & (EROFS_BLKSIZ - 1);
 			const unsigned int padding =
@@ -232,7 +266,8 @@ nocompression:
 		/* write compression indexes for this pcluster */
 		vle_write_indexes(ctx, count, raw);
 
-		ctx->blkaddr += ctx->compressedblks;
+		if (!inode->idata_size)
+			ctx->blkaddr += ctx->compressedblks;
 		len -= count;
 
 		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
@@ -449,6 +484,7 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
 {
 	struct z_erofs_map_header h = {
 		.h_advise = cpu_to_le16(inode->z_advise),
+		.h_idata_size = cpu_to_le16(inode->idata_size),
 		.h_algorithmtype = inode->z_algorithmtype[1] << 4 |
 				   inode->z_algorithmtype[0],
 		/* lclustersize */
@@ -476,7 +512,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
 	if (fd < 0) {
 		ret = -errno;
-		goto err_free;
+		goto err_free_meta;
 	}
 
 	/* allocate main data buffer */
@@ -504,8 +540,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	inode->z_algorithmtype[1] = algorithmtype[1];
 	inode->z_logical_clusterbits = LOG_BLOCK_SIZE;
 
-	z_erofs_write_mapheader(inode, compressmeta);
-
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.blkaddr = blkaddr;
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
@@ -531,19 +565,23 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 			goto err_bdrop;
 	}
 
+	inode->idata_size = 0;
+
 	/* do the final round */
 	ret = vle_compress_one(inode, &ctx, true);
 	if (ret)
-		goto err_bdrop;
+		goto err_free_id;
 
 	/* fall back to no compression mode */
 	compressed_blocks = ctx.blkaddr - blkaddr;
-	if (compressed_blocks >= BLK_ROUND_UP(inode->i_size)) {
+	if (compressed_blocks >= BLK_ROUND_UP(inode->i_size) -
+	    (inode->idata_size ? 1 : 0)) {
 		ret = -ENOSPC;
-		goto err_bdrop;
+		goto err_free_id;
 	}
 
 	vle_write_indexes_final(&ctx);
+	z_erofs_write_mapheader(inode, compressmeta);
 
 	close(fd);
 	DBG_BUGON(!compressed_blocks);
@@ -554,12 +592,11 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
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
 
 	legacymetasize = ctx.metacur - compressmeta;
@@ -575,11 +612,14 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
 	return 0;
 
+err_free_id:
+	if (inode->idata)
+		free(inode->idata);
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
index a4d696e..15d7417 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -26,7 +26,7 @@ int erofs_compress_destsize(struct erofs_compress *c,
 			    void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize)
 {
-	unsigned int uncompressed_size;
+	unsigned int compressed_size;
 	int ret;
 
 	DBG_BUGON(!c->alg);
@@ -38,9 +38,10 @@ int erofs_compress_destsize(struct erofs_compress *c,
 		return ret;
 
 	/* check if there is enough gains to compress */
-	uncompressed_size = *srcsize;
-	if (roundup(ret, EROFS_BLKSIZ) >= uncompressed_size *
-	    c->compress_threshold / 100)
+	compressed_size = *srcsize <= EROFS_BLKSIZ ? ret :
+			  roundup(ret, EROFS_BLKSIZ);
+
+	if (*srcsize <= compressed_size * c->compress_threshold / 100)
 		return -EAGAIN;
 	return ret;
 }
diff --git a/lib/decompress.c b/lib/decompress.c
index 97cb5ef..1661f91 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -110,6 +110,9 @@ static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
 					  rq->decodedlength);
 
 	if (ret != (int)rq->decodedlength) {
+		erofs_err("failed to %s decompress %d in[%u, %u] out[%u]",
+			  rq->partial_decoding ? "partial" : "full",
+			  ret, rq->inputsize, inputmargin, rq->decodedlength);
 		ret = -EIO;
 		goto out;
 	}
diff --git a/lib/inode.c b/lib/inode.c
index b6d3092..bfcb672 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -557,9 +557,6 @@ static int erofs_prepare_tail_block(struct erofs_inode *inode)
 	struct erofs_buffer_head *bh;
 	int ret;
 
-	if (!inode->idata_size)
-		return 0;
-
 	bh = inode->bh_data;
 	if (!bh) {
 		bh = erofs_balloc(DATA, EROFS_BLKSIZ, 0, 0);
@@ -593,9 +590,7 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 		inodesize = Z_EROFS_VLE_EXTENT_ALIGN(inodesize) +
 			    inode->extent_isize;
 
-	if (is_inode_layout_compression(inode))
-		goto noinline;
-	if (inode->datalayout == EROFS_INODE_CHUNK_BASED)
+	if (!inode->idata_size || inode->datalayout == EROFS_INODE_CHUNK_BASED)
 		goto noinline;
 
 	if (cfg.c_noinline_data && S_ISREG(inode->i_mode)) {
@@ -603,23 +598,18 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 		goto noinline;
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
-noinline:
 		/* expend an extra block for tail-end data */
 		ret = erofs_prepare_tail_block(inode);
 		if (ret)
 			return ret;
+noinline:
+		if (!is_inode_layout_compression(inode))
+			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
+
 		bh = erofs_balloc(INODE, inodesize, 0, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
@@ -627,7 +617,17 @@ noinline:
 	} else if (IS_ERR(bh)) {
 		return PTR_ERR(bh);
 	} else if (inode->idata_size) {
-		inode->datalayout = EROFS_INODE_FLAT_INLINE;
+		if (is_inode_layout_compression(inode)) {
+			struct z_erofs_map_header *h = inode->compressmeta;
+
+			h->h_advise |= Z_EROFS_ADVISE_INLINE_PCLUSTER;
+			erofs_dbg("%s: inline %scompressed data (%u bytes)",
+				  inode->i_srcpath,
+				  inode->idata_zipped ? "" : "un",
+				  inode->idata_size);
+		} else {
+			inode->datalayout = EROFS_INODE_FLAT_INLINE;
+		}
 
 		/* allocate inline buffer */
 		ibh = erofs_battach(bh, META, inode->idata_size);
@@ -685,20 +685,25 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		erofs_droid_blocklist_write_tail_end(inode, NULL_ADDR);
 	} else {
 		int ret;
-		erofs_off_t pos;
+		erofs_off_t pos, zero_pos;
 
 		erofs_mapbh(bh->block);
 		pos = erofs_btell(bh, true) - EROFS_BLKSIZ;
+		zero_pos = pos + inode->idata_size;
+
+		if (erofs_sb_has_lz4_0padding() && inode->idata_zipped) {
+			zero_pos = pos;
+			pos += EROFS_BLKSIZ - inode->idata_size;
+		}
+
 		ret = dev_write(inode->idata, pos, inode->idata_size);
 		if (ret)
 			return ret;
-		if (inode->idata_size < EROFS_BLKSIZ) {
-			ret = dev_fillzero(pos + inode->idata_size,
-					   EROFS_BLKSIZ - inode->idata_size,
-					   false);
-			if (ret)
-				return ret;
-		}
+		ret = dev_fillzero(zero_pos,
+				   EROFS_BLKSIZ - inode->idata_size,
+				   false);
+		if (ret)
+			return ret;
 		inode->idata_size = 0;
 		free(inode->idata);
 		inode->idata = NULL;
diff --git a/mkfs/main.c b/mkfs/main.c
index 90cedde..89fcb18 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -49,6 +49,7 @@ static struct option long_options[] = {
 	{"chunksize", required_argument, NULL, 11},
 	{"quiet", no_argument, 0, 12},
 	{"blobdev", required_argument, NULL, 13},
+	{"inline-data", no_argument, NULL, 14},
 #ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 512},
 	{"product-out", required_argument, NULL, 513},
@@ -98,6 +99,7 @@ static void usage(void)
 	      " --help                display this help and exit\n"
 	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
 	      " --quiet               quiet execution (do not write anything to standard output.)\n"
+	      " --inline-data         tail-packing inline compressed data\n"
 #ifndef NDEBUG
 	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
 #endif
@@ -366,6 +368,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 13:
 			cfg.c_blobdev_path = optarg;
 			break;
+		case 14:
+			erofs_sb_set_ztailpacking();
+			break;
 		case 1:
 			usage();
 			exit(0);
@@ -625,6 +630,8 @@ int main(int argc, char **argv)
 	erofs_show_config();
 	if (erofs_sb_has_chunked_file())
 		erofs_warn("EXPERIMENTAL chunked file feature in use. Use at your own risk!");
+	if (erofs_sb_has_ztailpacking())
+		erofs_warn("EXPERIMENTAL compression inline data feature in use. Use at your own risk!");
 	erofs_set_fs_root(cfg.c_src_path);
 #ifndef NDEBUG
 	if (cfg.c_random_pclusterblks)
-- 
2.17.1



