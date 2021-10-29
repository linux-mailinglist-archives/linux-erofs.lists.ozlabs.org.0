Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D80643F6CF
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 07:51:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HgWlR1XXCz2yb5
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 16:51:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=yulong.com (client-ip=59.36.132.92; helo=qq.com;
 envelope-from=huyue2@yulong.com; receiver=<UNKNOWN>)
Received: from qq.com (smtpbg478.qq.com [59.36.132.92])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HgWlG2xrqz2y7V
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Oct 2021 16:51:37 +1100 (AEDT)
X-QQ-mid: bizesmtp32t1635486641ta8gkf76
Received: from tj.ccdomain.com (unknown [218.94.48.178])
 by esmtp6.qq.com (ESMTP) with 
 id ; Fri, 29 Oct 2021 13:50:40 +0800 (CST)
X-QQ-SSF: 01400000000000Z0Z000B00A0000000
X-QQ-FEAT: eTtJes0duVs65hYXJHGROboqwt/tGlotCk+3DOOLuW2YBXVU/BPvVMsVRCc/x
 g/J+CyBs1CPWBdB1FQlCb68JcI1jO3SZz+d/GsIWY5TE2I1mODa3502V4z6L72x69ihG5bp
 5Dq0gXl09ClPMkEpODgwi462j96fLZDSJ9Os3QtlOo+dubEjNyLNNMaEKGrn20Opxrfqka2
 f2e2VCPoYvmLZ62iqUnyMqEgYxtzG+fE7xEJ/nDsO4EMOnuxOPa18hpk5SOX++aSzPd3PYo
 IulfWfwU+v7ZREyqo1vsSjm1HAIOnXcCRxnsgX6dD2Jr6Ts1XcKtC5wcZ94IMeJcd+7qTqm
 l07Apo11yGsH8wB0aj+k33lYp9n+mYKbhS0R4go8A1cPHvNsr5GfUHF1Z2AiwUiyM7zUDvW
X-QQ-GoodBg: 2
From: Yue Hu <huyue2@yulong.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v2 1/2] erofs-utils: support tail-packing inline
 compressed data
Date: Fri, 29 Oct 2021 13:49:30 +0800
Message-Id: <81934a7dfa7769bb8252798c71c54cb8b2231f53.1635485195.git.huyue2@yulong.com>
X-Mailer: git-send-email 2.29.2.windows.3
In-Reply-To: <cover.1635485195.git.huyue2@yulong.com>
References: <cover.1635485195.git.huyue2@yulong.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:yulong.com:qybgforeign:qybgforeign7
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
Cc: zhangwen@yulong.com, Yue Hu <huyue2@yulong.com>, geshifei@yulong.com,
 shaojunjun@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, we only support tail-end inline data for uncompressed
files, let's support it as well for compressed files.

The idea is from Xiang.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
changes since v1:
- add 2 bytes to record compressed size of tail-pcluster suggested from
  Xiang and update related code.

 include/erofs/internal.h |  1 +
 include/erofs_fs.h       | 10 ++++--
 lib/compress.c           | 76 +++++++++++++++++++++++++++++++---------
 lib/compressor.c         |  9 ++---
 lib/decompress.c         |  4 +++
 lib/inode.c              | 40 ++++++++++-----------
 mkfs/main.c              |  6 ++++
 7 files changed, 102 insertions(+), 44 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index da7be56..3769c27 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -109,6 +109,7 @@ static inline void erofs_sb_clear_##name(void) \
 EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
 EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
 EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
+EROFS_FEATURE_FUNCS(tailpacking, incompat, INCOMPAT_TAILPACKING)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 #define EROFS_I_EA_INITED	(1 << 0)
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 18fc182..5a363e2 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -22,10 +22,12 @@
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
 #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
 #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
+#define EROFS_FEATURE_INCOMPAT_TAILPACKING	0x00000004
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
-	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER)
+	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
+	 EROFS_FEATURE_INCOMPAT_TAILPACKING)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -230,14 +232,18 @@ struct z_erofs_lz4_cfgs {
  *                                  (4B) + 2B + (4B) if compacted 2B is on.
  * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
  * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
+ * bit 3 : inline (un)compressed data
  */
 #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
+#define Z_EROFS_ADVISE_TAILPACKING		0x0008
 
 struct z_erofs_map_header {
-	__le32	h_reserved1;
+	__le16	h_reserved1;
 	__le16	h_advise;
+	/* record the compressed size of tail-packing pcluster */
+	__le16	h_idata_size;
 	/*
 	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
 	 * bit 4-7 : algorithm type of head 2 (logical cluster type 11).
diff --git a/lib/compress.c b/lib/compress.c
index 2093bfd..9491f9b 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -159,6 +159,17 @@ static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode)
 	return cfg.c_physical_clusterblks;
 }
 
+static int z_erofs_fill_inline_data(struct erofs_inode *inode, char *data,
+				    unsigned int len)
+{
+	inode->idata_size = len;
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
@@ -169,15 +180,20 @@ static int vle_compress_one(struct erofs_inode *inode,
 	int ret;
 	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
 	char *const dst = dstbuf + EROFS_BLKSIZ;
+	bool tail_pcluster = false;
 
 	while (len) {
-		const unsigned int pclustersize =
+		unsigned int pclustersize =
 			z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
 		bool raw;
 
-		if (len <= pclustersize) {
+		if (!tail_pcluster && len <= pclustersize) {
 			if (final) {
-				if (len <= EROFS_BLKSIZ)
+				/* TODO: compress with 2 pclusters */
+				if (erofs_sb_has_tailpacking()) {
+					tail_pcluster = true;
+					pclustersize = EROFS_BLKSIZ;
+				} else if (len <= EROFS_BLKSIZ)
 					goto nocompression;
 			} else {
 				break;
@@ -194,6 +210,16 @@ static int vle_compress_one(struct erofs_inode *inode,
 					  inode->i_srcpath,
 					  erofs_strerror(ret));
 			}
+			if (tail_pcluster && len < EROFS_BLKSIZ) {
+				ret = z_erofs_fill_inline_data(inode,
+					(char *)(ctx->queue + ctx->head), len);
+				if (ret)
+					return ret;
+				count = len;
+				raw = true;
+				ctx->compressedblks = 1;
+				goto add_head;
+			}
 nocompression:
 			ret = write_uncompressed_extent(ctx, &len, dst);
 			if (ret < 0)
@@ -202,6 +228,15 @@ nocompression:
 			ctx->compressedblks = 1;
 			raw = true;
 		} else {
+			if (tail_pcluster && ret < EROFS_BLKSIZ &&
+			    !(len - count)) {
+				ret = z_erofs_fill_inline_data(inode, dst, ret);
+				if (ret)
+					return ret;
+				raw = false;
+				ctx->compressedblks = 1;
+				goto add_head;
+			}
 			const unsigned int tailused = ret & (EROFS_BLKSIZ - 1);
 			const unsigned int padding =
 				erofs_sb_has_lz4_0padding() && tailused ?
@@ -226,11 +261,13 @@ nocompression:
 			raw = false;
 		}
 
+add_head:
 		ctx->head += count;
 		/* write compression indexes for this pcluster */
 		vle_write_indexes(ctx, count, raw);
 
-		ctx->blkaddr += ctx->compressedblks;
+		if (!inode->idata_size)
+			ctx->blkaddr += ctx->compressedblks;
 		len -= count;
 
 		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
@@ -448,6 +485,7 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
 {
 	struct z_erofs_map_header h = {
 		.h_advise = cpu_to_le16(inode->z_advise),
+		.h_idata_size = cpu_to_le16(inode->idata_size),
 		.h_algorithmtype = inode->z_algorithmtype[1] << 4 |
 				   inode->z_algorithmtype[0],
 		/* lclustersize */
@@ -475,7 +513,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
 	if (fd < 0) {
 		ret = -errno;
-		goto err_free;
+		goto err_free_meta;
 	}
 
 	/* allocate main data buffer */
@@ -503,8 +541,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	inode->z_algorithmtype[1] = algorithmtype[1];
 	inode->z_logical_clusterbits = LOG_BLOCK_SIZE;
 
-	z_erofs_write_mapheader(inode, compressmeta);
-
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.blkaddr = blkaddr;
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
@@ -530,19 +566,23 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
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
+	    (inode->idata_size ? 1 : 0) ) {
 		ret = -ENOSPC;
-		goto err_bdrop;
+		goto err_free_id;
 	}
 
 	vle_write_indexes_final(&ctx);
+	z_erofs_write_mapheader(inode, compressmeta);
 
 	close(fd);
 	DBG_BUGON(!compressed_blocks);
@@ -553,12 +593,11 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
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
@@ -573,11 +612,14 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	inode->compressmeta = compressmeta;
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
index 8836e0c..26189b6 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -28,7 +28,7 @@ int erofs_compress_destsize(struct erofs_compress *c,
 			    void *dst,
 			    unsigned int dstsize)
 {
-	unsigned uncompressed_size;
+	unsigned compressed_size;
 	int ret;
 
 	DBG_BUGON(!c->alg);
@@ -41,9 +41,10 @@ int erofs_compress_destsize(struct erofs_compress *c,
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
index 490c4bc..0b6678d 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -9,6 +9,7 @@
 
 #include "erofs/decompress.h"
 #include "erofs/err.h"
+#include "erofs/print.h"
 
 #ifdef LZ4_ENABLED
 #include <lz4.h>
@@ -50,6 +51,9 @@ static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
 					  rq->decodedlength);
 
 	if (ret != (int)rq->decodedlength) {
+		erofs_err("failed to %s decompress %d in[%u, %u] out[%u]",
+			  rq->partial_decoding ? "partial" : "full",
+			  ret, rq->inputsize, inputmargin, rq->decodedlength);
 		ret = -EIO;
 		goto out;
 	}
diff --git a/lib/inode.c b/lib/inode.c
index 787e5b4..6d5c9f3 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -521,9 +521,6 @@ int erofs_prepare_tail_block(struct erofs_inode *inode)
 	struct erofs_buffer_head *bh;
 	int ret;
 
-	if (!inode->idata_size)
-		return 0;
-
 	bh = inode->bh_data;
 	if (!bh) {
 		bh = erofs_balloc(DATA, EROFS_BLKSIZ, 0, 0);
@@ -557,26 +554,21 @@ int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 		inodesize = Z_EROFS_VLE_EXTENT_ALIGN(inodesize) +
 			    inode->extent_isize;
 
-	if (is_inode_layout_compression(inode))
-		goto noinline;
-
-	/*
-	 * if the file size is block-aligned for uncompressed files,
-	 * should use EROFS_INODE_FLAT_PLAIN data mapping mode.
-	 */
 	if (!inode->idata_size)
-		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
+		goto noinline;
 
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
@@ -584,7 +576,14 @@ noinline:
 	} else if (IS_ERR(bh)) {
 		return PTR_ERR(bh);
 	} else if (inode->idata_size) {
-		inode->datalayout = EROFS_INODE_FLAT_INLINE;
+		if (is_inode_layout_compression(inode)) {
+			struct z_erofs_map_header *h = inode->compressmeta;
+			h->h_advise |= Z_EROFS_ADVISE_TAILPACKING;
+			erofs_dbg("%s: inline data (%u bytes)",
+				  inode->i_srcpath, inode->idata_size);
+		} else {
+			inode->datalayout = EROFS_INODE_FLAT_INLINE;
+		}
 
 		/* allocate inline buffer */
 		ibh = erofs_battach(bh, META, inode->idata_size);
@@ -647,13 +646,12 @@ int erofs_write_tail_end(struct erofs_inode *inode)
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
+		ret = dev_fillzero(pos + inode->idata_size,
+				   EROFS_BLKSIZ - inode->idata_size,
+				   false);
+		if (ret)
+			return ret;
+
 		inode->idata_size = 0;
 		free(inode->idata);
 		inode->idata = NULL;
diff --git a/mkfs/main.c b/mkfs/main.c
index e476189..7dd29df 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -48,6 +48,7 @@ static struct option long_options[] = {
 	{"product-out", required_argument, NULL, 11},
 	{"fs-config-file", required_argument, NULL, 12},
 #endif
+	{"inline", no_argument, NULL, 13},
 	{0, 0, 0, 0},
 };
 
@@ -87,6 +88,7 @@ static void usage(void)
 	      " --all-root            make all files owned by root\n"
 	      " --help                display this help and exit\n"
 	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
+	      " --inline              tail-packing inline compressed data\n"
 #ifndef NDEBUG
 	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
 #endif
@@ -304,6 +306,10 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			cfg.c_physical_clusterblks = i / EROFS_BLKSIZ;
 			break;
+		case 13:
+			erofs_sb_set_tailpacking();
+			erofs_warn("EXPERIMENTAL compression inline feature in use. Use at your own risk!");
+			break;
 
 		case 1:
 			usage();
-- 
2.29.0



