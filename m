Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 07655FC16A
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2019 09:20:08 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47DDtY2zrzzF6gg
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2019 19:20:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47DDtN3lk4zF6gJ
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2019 19:19:53 +1100 (AEDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 58E1BBA865E573AD3D1B
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2019 16:19:44 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 14 Nov
 2019 16:19:37 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 <linux-erofs@lists.ozlabs.org>
Subject: [RFC PATCH] erofs-utils: add XZ algorithm support
Date: Thu, 14 Nov 2019 16:22:07 +0800
Message-ID: <20191114082207.77360-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It's silly but roughtly usable *_destsize implementation
for XZ by using liblzma stream API and fitblk-like approach,
whose generated data can be directly decompressed by kernel.

I can investigate it deeply by hacking lzma2/XZ internals
if I have more extra time to do, that is another story
for now.

Currently, MT compression support would be a higher priority
stuff and even for fixed-sized output compression it can be
multi-threaded by fixed-sized input segments:
 _________________________________________________________
|  thread 0  |  thread 1   |  thread 0  |  thread 1  | ...
|____x MB____|____x MB_____|____x MB____|____x MB____|____

MT compression can also be implemented on per-file
basis of course.

Cc: Chao Yu <yuchao0@huawei.com>
Cc: Li Guifu <bluce.liguifu@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

A brief fitblk-like XZ approach compression ratio comparsion:
 459382784 enwik9_4k.xz.squashfs.img
 401649664 enwik9_8k.xz.squashfs.img
 378892288 enwik9_4k.xz.erofs.img (bisect is forcely true)
 360972288 enwik9_16k.xz.squashfs.img

 configure.ac        |  12 ++
 include/erofs_fs.h  |   1 +
 lib/Makefile.am     |   4 +
 lib/compress.c      |  32 +++--
 lib/compressor.c    |   3 +
 lib/compressor.h    |   2 +
 lib/compressor_xz.c | 277 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 320 insertions(+), 11 deletions(-)
 create mode 100644 lib/compressor_xz.c

diff --git a/configure.ac b/configure.ac
index a5adf172cc43..f8cc8efebf2f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -154,9 +154,17 @@ if test "x$enable_lz4" = "xyes"; then
   CPPFLAGS=${saved_CPPFLAGS}
 fi
 
+AC_CHECK_HEADERS(lzma.h,
+  AC_CHECK_LIB(lzma, lzma_code,[
+      have_liblzma="yes"
+      LZMA_LIBS="-llzma"
+      AC_DEFINE([XZ_ENABLED], [1], [Define to 1 if xz is enabled.])
+    ], [have_liblzma="no"]))
+
 # Set up needed symbols, conditionals and compiler/linker flags
 AM_CONDITIONAL([ENABLE_LZ4], [test "x${have_lz4}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
+AM_CONDITIONAL([ENABLE_XZ], [test "x${have_liblzma}" = "xyes"])
 
 if test "x${have_lz4}" = "xyes"; then
   AC_DEFINE([LZ4_ENABLED], [1], [Define to 1 if lz4 is enabled.])
@@ -173,6 +181,10 @@ if test "x${have_lz4}" = "xyes"; then
   LIBS="$LZ4_LIBS $LIBS"
 fi
 
+if test "x${have_liblzma}" = "xyes"; then
+LIBS="$LZMA_LIBS $LIBS"
+fi
+
 AC_CONFIG_FILES([Makefile
 		 man/Makefile
 		 lib/Makefile
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index bcc4f0c630ad..0310f1d07f1c 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -194,6 +194,7 @@ static inline unsigned int erofs_xattr_entry_size(struct erofs_xattr_entry *e)
 /* available compression algorithm types (for h_algorithmtype) */
 enum {
 	Z_EROFS_COMPRESSION_LZ4	= 0,
+	Z_EROFS_COMPRESSION_XZ = 1,
 	Z_EROFS_COMPRESSION_MAX
 };
 
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 1ff81f9eebfe..b978b361fb72 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -12,4 +12,8 @@ if ENABLE_LZ4HC
 liberofs_la_SOURCES += compressor_lz4hc.c
 endif
 endif
+if ENABLE_XZ
+liberofs_la_CFLAGS += ${LZMA_CFLAGS}
+liberofs_la_SOURCES += compressor_xz.c
+endif
 
diff --git a/lib/compress.c b/lib/compress.c
index 99fd527ead50..b7106c081712 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -23,7 +23,7 @@ static int compressionlevel;
 static struct z_erofs_map_header mapheader;
 
 struct z_erofs_vle_compress_ctx {
-	u8 *metacur;
+	u8 *metacur, *dstbuf;
 
 	u8 queue[EROFS_CONFIG_COMPR_MAX_SZ * 2];
 	unsigned int head, tail;
@@ -114,8 +114,7 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 }
 
 static int write_uncompressed_block(struct z_erofs_vle_compress_ctx *ctx,
-				    unsigned int *len,
-				    char *dst)
+				    unsigned int *len, u8 *dst)
 {
 	int ret;
 	unsigned int count;
@@ -148,11 +147,10 @@ static int vle_compress_one(struct erofs_inode *inode,
 			    bool final)
 {
 	struct erofs_compress *const h = &compresshandle;
+	u8 *const dst = ctx->dstbuf;
 	unsigned int len = ctx->tail - ctx->head;
 	unsigned int count;
 	int ret;
-	static char dstbuf[EROFS_BLKSIZ * 2];
-	char *const dst = dstbuf + EROFS_BLKSIZ;
 
 	while (len) {
 		bool raw;
@@ -389,21 +387,28 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 
 int erofs_write_compressed_file(struct erofs_inode *inode)
 {
-	struct erofs_buffer_head *bh;
 	struct z_erofs_vle_compress_ctx ctx;
+	u8 *compressmeta, *dstbuf;
+	int ret, fd;
+	struct erofs_buffer_head *bh;
 	erofs_off_t remaining;
 	erofs_blk_t blkaddr, compressed_blocks;
 	unsigned int legacymetasize;
-	int ret, fd;
 
-	u8 *compressmeta = malloc(vle_compressmeta_capacity(inode->i_size));
-	if (!compressmeta)
+	dstbuf = malloc((EROFS_BLKSIZ + compresshandle.paddingdstsz) * 2);
+	if (!dstbuf)
 		return -ENOMEM;
 
+	compressmeta = malloc(vle_compressmeta_capacity(inode->i_size));
+	if (!compressmeta) {
+		ret = -ENOMEM;
+		goto err_freedstbuf;
+	}
+
 	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
 	if (fd < 0) {
 		ret = -errno;
-		goto err_free;
+		goto err_freemeta;
 	}
 
 	/* allocate main data buffer */
@@ -418,6 +423,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	blkaddr = erofs_mapbh(bh->block, true);	/* start_blkaddr */
 	ctx.blkaddr = blkaddr;
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
+	ctx.dstbuf = dstbuf + EROFS_BLKSIZ + compresshandle.paddingdstsz;
 	ctx.head = ctx.tail = 0;
 	ctx.clusterofs = 0;
 	remaining = inode->i_size;
@@ -486,8 +492,10 @@ err_bdrop:
 	erofs_bdrop(bh, true);	/* revoke buffer */
 err_close:
 	close(fd);
-err_free:
+err_freemeta:
 	free(compressmeta);
+err_freedstbuf:
+	free(dstbuf);
 	return ret;
 }
 
@@ -495,6 +503,8 @@ static int erofs_get_compress_algorithm_id(const char *name)
 {
 	if (!strcmp(name, "lz4") || !strcmp(name, "lz4hc"))
 		return Z_EROFS_COMPRESSION_LZ4;
+	if (!strcmp(name, "xz"))
+		return Z_EROFS_COMPRESSION_XZ;
 	return -ENOTSUP;
 }
 
diff --git a/lib/compressor.c b/lib/compressor.c
index b2434e0e5418..daf413bf9a6c 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -19,6 +19,9 @@ static struct erofs_compressor *compressors[] = {
 #endif
 		&erofs_compressor_lz4,
 #endif
+#if XZ_ENABLED
+		&erofs_compressor_xz,
+#endif
 };
 
 int erofs_compress_destsize(struct erofs_compress *c,
diff --git a/lib/compressor.h b/lib/compressor.h
index b2471c41ca4e..6be4210caf8a 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -38,12 +38,14 @@ struct erofs_compress {
 	unsigned int destsize_redzone_begin;
 	unsigned int destsize_redzone_end;
 
+	unsigned int paddingdstsz;
 	void *private_data;
 };
 
 /* list of compression algorithms */
 extern struct erofs_compressor erofs_compressor_lz4;
 extern struct erofs_compressor erofs_compressor_lz4hc;
+extern struct erofs_compressor erofs_compressor_xz;
 
 int erofs_compress_destsize(struct erofs_compress *c, int compression_level,
 			    void *src, unsigned int *srcsize,
diff --git a/lib/compressor_xz.c b/lib/compressor_xz.c
new file mode 100644
index 000000000000..08bc779b0c16
--- /dev/null
+++ b/lib/compressor_xz.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/compressor_xz.c
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#include <lzma.h>
+#include "erofs/internal.h"
+#include "compressor.h"
+
+/* #define XZDEBUG */
+#define TRYSCALE	5
+#define EXCESS		128
+#define RAWLEN		8192
+static u8 trash[RAWLEN];
+
+struct __xz_fitblk_compress {
+	lzma_stream *def;
+	lzma_filter *filters;
+};
+
+static int xz_fitblkprecompress(void *ctx,
+				void *in, unsigned int insize,
+				void *out, unsigned int *outsize)
+{
+	struct __xz_fitblk_compress *xc = ctx;
+	lzma_stream *def = xc->def;
+	lzma_filter *filters = xc->filters;
+	lzma_ret ret;
+	unsigned int tryinsize;
+
+	/* Initialize the encoder using the custom filter chain. */
+	ret = lzma_stream_encoder(def, filters, LZMA_CHECK_NONE);
+	if (ret != LZMA_OK)
+		return -EFAULT;
+
+	def->next_out = out;
+	def->avail_out = *outsize;
+	def->next_in = in;
+
+	tryinsize = min_t(unsigned int, *outsize * TRYSCALE, insize);
+	def->avail_in = tryinsize;
+
+	ret = lzma_code(def, LZMA_FULL_BARRIER);
+
+	/* all data can be fitted in, feed more then */
+	if (ret == LZMA_STREAM_END && tryinsize != insize) {
+		def->avail_in = insize - tryinsize;
+		ret = lzma_code(def, LZMA_FINISH);
+	}
+
+	switch (ret) {
+	case LZMA_MEM_ERROR:
+		return -ENOMEM;
+	case LZMA_DATA_ERROR:
+		return -EUCLEAN;
+	case LZMA_OK:
+	case LZMA_STREAM_END:
+		break;
+	default:
+		return -EFAULT;
+	}
+	*outsize -= def->avail_out;
+	lzma_end(def);
+	return tryinsize != insize;
+}
+
+static int xz_decompressall(lzma_stream *inf,
+			    void *src, unsigned int srcsize,
+			    void *dst, unsigned int *dstsize)
+{
+	lzma_ret ret = lzma_stream_decoder(inf, UINT64_MAX, LZMA_CONCATENATED);
+
+	if (ret != LZMA_OK)
+		return -EFAULT;
+
+	inf->next_out = dst;
+	inf->avail_out = *dstsize;
+	inf->next_in = src;
+	inf->avail_in = srcsize;
+
+	ret = lzma_code(inf, LZMA_FINISH);
+	*dstsize -= inf->avail_out;
+	lzma_end(inf);
+	return 0;
+}
+
+static int xz_fitblkcompress(void *ctx,
+			     void *in, unsigned int insize,
+			     void *out, unsigned int *outsize)
+{
+	struct __xz_fitblk_compress *xc = ctx;
+	lzma_stream *def = xc->def;
+	lzma_filter *filters = xc->filters;
+	lzma_ret ret;
+	unsigned int databeyond;
+
+	/* Initialize the encoder using the custom filter chain. */
+	ret = lzma_stream_encoder(def, filters, LZMA_CHECK_CRC32);
+	/* ret = lzma_stream_encoder(def, filters, LZMA_CHECK_NONE); */
+	if (ret != LZMA_OK)
+		return -EFAULT;
+
+	def->next_out = out;
+	def->avail_out = *outsize;
+	def->next_in = in;
+	def->avail_in = insize;
+
+	ret = lzma_code(def, LZMA_FINISH);
+	*outsize -= def->avail_out;
+
+	/* all data can be fitted in */
+	if (ret == LZMA_STREAM_END) {
+		lzma_end(def);
+		return 0;
+	}
+
+	databeyond = 0;
+	while (ret == LZMA_OK) {
+		def->next_out = trash;
+		def->avail_out = RAWLEN;
+		ret = lzma_code(def, LZMA_FINISH);
+		databeyond += RAWLEN - def->avail_out;
+	}
+
+	if (ret != LZMA_STREAM_END) {
+		switch (ret) {
+		case LZMA_MEM_ERROR:
+			return -ENOMEM;
+		case LZMA_DATA_ERROR:
+			return -EUCLEAN;
+		default:
+			return -EFAULT;
+		}
+	}
+	lzma_end(def);
+	return databeyond;
+}
+
+static int xz_decompress(lzma_stream *inf,
+			 void *src, unsigned int srcsize,
+			 void *dst, unsigned int *dstsize)
+{
+	lzma_ret ret = lzma_stream_decoder(inf, UINT64_MAX, 0);
+
+	if (ret != LZMA_OK)
+		return -EFAULT;
+
+	inf->next_out = dst;
+	inf->avail_out = *dstsize;
+	inf->next_in = src;
+	inf->avail_in = srcsize;
+
+	ret = lzma_code(inf, LZMA_FINISH);
+	*dstsize -= inf->avail_out;
+	lzma_end(inf);
+	return 0;
+}
+
+#ifdef XZDEBUG
+static char tmp[2*1024*1024];
+#endif
+
+static int xz_compress_destsize(struct erofs_compress *c,
+				int compression_level,
+				void *in, unsigned int *inlen,
+				void *out, unsigned int outlen)
+{
+	lzma_stream defstrm = LZMA_STREAM_INIT;
+	lzma_stream infstrm = LZMA_STREAM_INIT;
+	lzma_options_lzma opt_lzma2;
+	lzma_filter filters[] = {
+		{ .id = LZMA_FILTER_X86, .options = NULL },
+		{ .id = LZMA_FILTER_LZMA2, .options = &opt_lzma2 },
+		{ .id = LZMA_VLI_UNKNOWN, .options = NULL },
+	};
+	struct __xz_fitblk_compress xc = {
+		.def = &defstrm, .filters = filters,
+	};
+	/* which will greatly affect compression time */
+	//bool bisect = true;
+	bool bisect = (compression_level == c->alg->best_level);
+	int err;
+#ifndef XZDEBUG
+	char *tmp = in;
+#endif
+	unsigned int dstsize, left, cur, right, grade;
+
+	if (lzma_lzma_preset(&opt_lzma2,
+			     compression_level & LZMA_PRESET_LEVEL_MASK))
+		return -EINVAL;
+
+	opt_lzma2.dict_size = 512 * 1024;
+	dstsize = outlen + c->paddingdstsz;
+
+	err = xz_fitblkprecompress(&xc, in, *inlen, out, &dstsize);
+	if (err < 0)
+		return err;
+
+	cur = *inlen;
+	/* all data are fitted in when doing pass 0th */
+	if (err || dstsize > outlen) {
+		err = xz_decompressall(&infstrm, out, dstsize, tmp, &cur);
+		if (err)
+			return err;
+	}
+	left = 0;
+	right = ~0;
+	while (1) {
+		unsigned int beyondsize;
+
+		err = xz_fitblkcompress(&xc, in, cur, out, &dstsize);
+		if (err < 0)
+			return err;
+		if (!err && dstsize <= outlen) {
+			if (bisect && dstsize < outlen && left < cur) {
+				grade = (outlen - dstsize) * cur / dstsize;
+				left = cur;
+				cur += grade << (cur + 2 * grade < right);
+
+				if (left != cur) {
+					dstsize = outlen;
+					continue;
+				}
+			}
+			*inlen = cur;
+			break;
+		}
+		beyondsize = err;
+
+		err = xz_decompress(&infstrm, out, dstsize, tmp, &cur);
+		if (err)
+			return err;
+		if (dstsize > outlen) {
+			dstsize = outlen;
+		} else {
+			right = cur;
+			cur -= cur * beyondsize / (dstsize + beyondsize);
+			if (cur < left)
+				cur = left;
+		}
+	}
+#ifdef XZDEBUG
+	err = xz_decompress(&infstrm, out, dstsize, tmp, &cur);
+	if (err)
+		return err;
+	if (memcmp(tmp, in, cur) || cur > *inlen)
+		return -EBADMSG;
+#endif
+	memset(out + dstsize, 0, outlen - dstsize);
+	*inlen = cur;
+	return dstsize;
+}
+
+static int compressor_xz_exit(struct erofs_compress *c)
+{
+	return 0;
+}
+
+static int compressor_xz_init(struct erofs_compress *c)
+{
+	c->alg = &erofs_compressor_xz;
+	c->paddingdstsz = EXCESS;
+	return 0;
+}
+
+struct erofs_compressor erofs_compressor_xz = {
+	.name = "xz",
+	.default_level = LZMA_PRESET_DEFAULT,
+	.best_level = 9,
+	.init = compressor_xz_init,
+	.exit = compressor_xz_exit,
+	.compress_destsize = xz_compress_destsize,
+};
+
-- 
2.17.1

