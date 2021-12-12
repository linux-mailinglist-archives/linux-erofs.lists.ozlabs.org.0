Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AEF471996
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Dec 2021 11:33:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JBgwG15QGz2y7Q
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Dec 2021 21:33:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=yulong.com (client-ip=59.36.132.85; helo=qq.com;
 envelope-from=huyue2@yulong.com; receiver=<UNKNOWN>)
Received: from qq.com (smtpbg476.qq.com [59.36.132.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JBgwB2XQbz3c5Z
 for <linux-erofs@lists.ozlabs.org>; Sun, 12 Dec 2021 21:33:29 +1100 (AEDT)
X-QQ-mid: bizesmtp38t1639305140ta91mpux
Received: from localhost.localdomain (unknown [49.65.247.231])
 by esmtp6.qq.com (ESMTP) with 
 id ; Sun, 12 Dec 2021 18:32:19 +0800 (CST)
X-QQ-SSF: 01400000002000Z0Z000B00A0000000
X-QQ-FEAT: NZu7wKqSQ9S/Pl2E75D1DNaCq3f8VW2vb9wjKsaqYw0iG9fSBzDDQGAGbaF3D
 r38nPdPfNcFZ8g+PM6zmQjXrASLPoe5c0nO7pO310xUKoMk4BnPdBlrTUxkBC84qLFFXieE
 /N9IN0gOfQU/wl3EGpPCsiAUZcL7TkwfAhfp1HaWUY6lVI5UdPYKakeZwifzW7zqRPzf4Zz
 v2wb2tZhrG0/w93eG8VwLt4ZfjC769T9mnGbYnfhmpQEIUOb9xyNnrphtjB9/YWFuh4qHuY
 /NvLON+x0gL42Rc0aINTIeP4aKrhA97P4bn9/TWBYXHDoKEwckigs7z1Vt+j5J5OzAWFx9t
 q5tvkE1r7lSQVm4BTf35TGLm3hsKXaapNJQQ1ZUQ18gC2gPa2RUlC2/8M4pDA==
X-QQ-GoodBg: 2
From: Yue Hu <huyue2@yulong.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	bluce.lee@aliyun.com
Subject: [RFC PATCH v4 2/2] erofs-utils: support tail-packing inline
 compressed data
Date: Sun, 12 Dec 2021 18:31:29 +0800
Message-Id: <2547af6ba77dd8541cd298abcea225e5b0bda70b.1639303144.git.huyue2@yulong.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <4333936bf0811f2ecb1ad89d72911d7f1f638c90.1639303144.git.huyue2@yulong.com>
References: <4333936bf0811f2ecb1ad89d72911d7f1f638c90.1639303144.git.huyue2@yulong.com>
In-Reply-To: <cover.1639303144.git.huyue2@yulong.com>
References: <cover.1639303144.git.huyue2@yulong.com>
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

The idea is from Xiang.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v4:
- improve messy if-else logic in vle_compress_one() suggested by Xiang.
- remove on-disk feature since it's moved to fuse part.

v3:
- based on commit 9fe440d0ac03 ("erofs-utils: mkfs: introduce --quiet option").
- move h_idata_size ahead of h_advise for compatibility.
- rename feature/update messages which i think they are more exact.

v2:
- add 2 bytes to record compressed size of tail-pcluster suggested from
  Xiang and update related code.

 lib/compress.c   | 84 ++++++++++++++++++++++++++++++++++--------------
 lib/compressor.c |  9 +++---
 lib/decompress.c |  4 +++
 lib/inode.c      | 42 ++++++++++++------------
 mkfs/main.c      |  7 ++++
 5 files changed, 97 insertions(+), 49 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 6ca5bed..ff7e97f 100644
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
@@ -162,6 +161,17 @@ static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode)
 	return cfg.c_pclusterblks_def;
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
@@ -172,16 +182,22 @@ static int vle_compress_one(struct erofs_inode *inode,
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
@@ -196,13 +212,28 @@ static int vle_compress_one(struct erofs_inode *inode,
 					  inode->i_srcpath,
 					  erofs_strerror(ret));
 			}
+			if (trailing && len < EROFS_BLKSIZ) {
+				ret = z_erofs_fill_inline_data(inode,
+					(char *)(ctx->queue + ctx->head), len);
+				if (ret)
+					return ret;
+				count = len;
+				ctx->compressedblks = 0;
+			} else {
 nocompression:
-			ret = write_uncompressed_extent(ctx, &len, dst);
-			if (ret < 0)
-				return ret;
-			count = ret;
-			ctx->compressedblks = 1;
+				ret = write_uncompressed_extent(ctx, &len, dst);
+				if (ret < 0)
+					return ret;
+				count = ret;
+				ctx->compressedblks = 1;
+			}
 			raw = true;
+		} else if (trailing && ret < EROFS_BLKSIZ && len == count) {
+			ret = z_erofs_fill_inline_data(inode, dst, ret);
+			if (ret)
+				return ret;
+			ctx->compressedblks = 0;
+			raw = false;
 		} else {
 			const unsigned int tailused = ret & (EROFS_BLKSIZ - 1);
 			const unsigned int padding =
@@ -449,6 +480,7 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
 {
 	struct z_erofs_map_header h = {
 		.h_advise = cpu_to_le16(inode->z_advise),
+		.h_idata_size = cpu_to_le16(inode->idata_size),
 		.h_algorithmtype = inode->z_algorithmtype[1] << 4 |
 				   inode->z_algorithmtype[0],
 		/* lclustersize */
@@ -476,7 +508,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
 	if (fd < 0) {
 		ret = -errno;
-		goto err_free;
+		goto err_free_meta;
 	}
 
 	/* allocate main data buffer */
@@ -504,8 +536,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	inode->z_algorithmtype[1] = algorithmtype[1];
 	inode->z_logical_clusterbits = LOG_BLOCK_SIZE;
 
-	z_erofs_write_mapheader(inode, compressmeta);
-
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.blkaddr = blkaddr;
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
@@ -531,19 +561,23 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
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
@@ -554,12 +588,11 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
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
@@ -575,11 +608,14 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
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
index 89c1be1..9b9d2ff 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -23,7 +23,7 @@ int erofs_compress_destsize(struct erofs_compress *c,
 			    void *src, unsigned int *srcsize,
 			    void *dst, unsigned int dstsize)
 {
-	unsigned int uncompressed_size;
+	unsigned int compressed_size;
 	int ret;
 
 	DBG_BUGON(!c->alg);
@@ -35,9 +35,10 @@ int erofs_compress_destsize(struct erofs_compress *c,
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
index 9b90d18..f5afb10 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -7,6 +7,7 @@
 
 #include "erofs/decompress.h"
 #include "erofs/err.h"
+#include "erofs/print.h"
 
 #ifdef LZ4_ENABLED
 #include <lz4.h>
@@ -48,6 +49,9 @@ static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
 					  rq->decodedlength);
 
 	if (ret != (int)rq->decodedlength) {
+		erofs_err("failed to %s decompress %d in[%u, %u] out[%u]",
+			  rq->partial_decoding ? "partial" : "full",
+			  ret, rq->inputsize, inputmargin, rq->decodedlength);
 		ret = -EIO;
 		goto out;
 	}
diff --git a/lib/inode.c b/lib/inode.c
index 6597a26..b9dcb08 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -549,9 +549,6 @@ static int erofs_prepare_tail_block(struct erofs_inode *inode)
 	struct erofs_buffer_head *bh;
 	int ret;
 
-	if (!inode->idata_size)
-		return 0;
-
 	bh = inode->bh_data;
 	if (!bh) {
 		bh = erofs_balloc(DATA, EROFS_BLKSIZ, 0, 0);
@@ -585,8 +582,9 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 		inodesize = Z_EROFS_VLE_EXTENT_ALIGN(inodesize) +
 			    inode->extent_isize;
 
-	if (is_inode_layout_compression(inode))
+	if (!inode->idata_size)
 		goto noinline;
+
 	if (inode->datalayout == EROFS_INODE_CHUNK_BASED)
 		goto noinline;
 
@@ -595,23 +593,18 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
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
@@ -619,7 +612,15 @@ noinline:
 	} else if (IS_ERR(bh)) {
 		return PTR_ERR(bh);
 	} else if (inode->idata_size) {
-		inode->datalayout = EROFS_INODE_FLAT_INLINE;
+		if (is_inode_layout_compression(inode)) {
+			struct z_erofs_map_header *h = inode->compressmeta;
+
+			h->h_advise |= Z_EROFS_ADVISE_INLINE_DATA;
+			erofs_dbg("%s: inline data (%u bytes)",
+				  inode->i_srcpath, inode->idata_size);
+		} else {
+			inode->datalayout = EROFS_INODE_FLAT_INLINE;
+		}
 
 		/* allocate inline buffer */
 		ibh = erofs_battach(bh, META, inode->idata_size);
@@ -684,13 +685,12 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
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
index 055d077..59442ac 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -47,6 +47,7 @@ static struct option long_options[] = {
 	{"compress-hints", required_argument, NULL, 10},
 	{"chunksize", required_argument, NULL, 11},
 	{"quiet", no_argument, 0, 12},
+	{"inline-data", no_argument, NULL, 13},
 #ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 512},
 	{"product-out", required_argument, NULL, 513},
@@ -95,6 +96,7 @@ static void usage(void)
 	      " --help                display this help and exit\n"
 	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
 	      " --quiet               quiet execution (do not write anything to standard output.)\n"
+	      " --inline-data         tail-packing inline compressed data\n"
 #ifndef NDEBUG
 	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
 #endif
@@ -349,6 +351,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 12:
 			quiet = true;
 			break;
+		case 13:
+			erofs_sb_set_ztailpacking();
+			break;
 		case 1:
 			usage();
 			exit(0);
@@ -607,6 +612,8 @@ int main(int argc, char **argv)
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



