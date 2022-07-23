Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E20357EC6C
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jul 2022 09:17:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lqd1Z2Ntjz3blb
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jul 2022 17:17:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=GKfIxUMW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=GKfIxUMW;
	dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lqd1K6Yxbz302d
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jul 2022 17:17:41 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so5939231pjf.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jul 2022 00:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2/E7AwYAr/X2rmUXk8i7aV4SQGEwMReHwNIVMC86JPo=;
        b=GKfIxUMWgYcxIAFikoqcx/e2p2LBq2NZDHgWhYDiHK9VDyxxpnzIpmM9QI81BVn1tu
         YFYYe/JJp/AKafSrON7mStZX5X2EGPI1/HiSAxadd6AmmHJRve9+TuAsVz/ydRC4iDOe
         f+1goyr/dmMTGPyE4J9jKhwyJ5FRION9VvoZzuHuauTwbdHeda/c1nmEBoJhThfXjyTl
         ghAo5rqdsWKnIZ2bfJshPemItx3unY9x2NkDkk23R8Pq8Ic1MhsqS/1YOVGrs4uX8MI5
         AGAGYavummr47a4RJtxX4piM2KQgOLKlkRn985atqEDlhPG4cMDGgP5tmx2uVhOU2xe3
         iiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2/E7AwYAr/X2rmUXk8i7aV4SQGEwMReHwNIVMC86JPo=;
        b=eVXL5TpF2YcXlVQ03pu1pIj1MJBZBs7m1hJaJpHUv6qIWfu+flMhzDtEu+q5IgJe5g
         nyb8QOn+udwRBUlQfIWm/UdbwsY6cTT6khkLKTKfJTkUayFhoArDiHS260PGYu5SGM+G
         Zjc4ByOJpuyb9SfovMJ3gtn9NoP7x65m7+sLjr5l9TDm1Tdd9CINwNeC4YYzCFha7q1z
         9vZE0NaakJ6ytsu4QxnjTMgCvfQx4fnHTesg8ml1MLn21Zzclq7zWUjB/XwiUFl20x5U
         YGpgb50+E/bWsarcBCDLVbWy/UQXBNGGvYV1BHXkbHBHhzVtCmwO+77WooZUa18iuP/D
         yOzg==
X-Gm-Message-State: AJIora/s+x3IS3TOX2F/NGKbZA1UsoRgACxHuAT3ZYrI6d571W4xBHG5
	nVnnXNtrC+NhUzo1I5VTJyRvoX5QY9I=
X-Google-Smtp-Source: AGRyM1sitP6CH4H5wJVmmQUTJEmoZcoQ0OWfADCQY/EbeytvjhgRUe37HnJooO6qorNPTrFQZfJ25w==
X-Received: by 2002:a17:902:d508:b0:16d:4f47:9d65 with SMTP id b8-20020a170902d50800b0016d4f479d65mr1938085plg.149.1658560659234;
        Sat, 23 Jul 2022 00:17:39 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id y66-20020a633245000000b00411955c03e5sm4535290pgy.29.2022.07.23.00.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 00:17:38 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v2 3/3] erofs-utils: introduce compressed fragments support
Date: Sat, 23 Jul 2022 15:17:15 +0800
Message-Id: <a50641d3219b855b9d7675f12cad42b310e8fce4.1658556336.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1658556336.git.huyue2@coolpad.com>
References: <cover.1658556336.git.huyue2@coolpad.com>
In-Reply-To: <cover.1658556336.git.huyue2@coolpad.com>
References: <cover.1658556336.git.huyue2@coolpad.com>
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
Cc: huyue2@coolpad.com, zbestahu@163.com, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This approach can merge tail pclusters or the whole files into a special
inode in order to achieve greater compression ratio. And an option of
pcluster size is provided for different compression requirments.

Meanwhile, we change to write the uncompressed data from 'clusterofs'
when compressing files since it can benefit from in-place I/O. For now,
this change goes with the fragments.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 include/erofs/compress.h  |   3 +-
 include/erofs/config.h    |   3 +-
 include/erofs/fragments.h |  25 +++++++++
 include/erofs/inode.h     |   2 +
 include/erofs/internal.h  |   1 +
 include/erofs_fs.h        |   5 +-
 lib/Makefile.am           |   4 +-
 lib/compress.c            | 108 ++++++++++++++++++++++++++++----------
 lib/fragments.c           |  76 +++++++++++++++++++++++++++
 lib/inode.c               |  43 ++++++++++-----
 lib/super.c               |  24 ++++++++-
 mkfs/main.c               |  64 +++++++++++++++++++---
 12 files changed, 304 insertions(+), 54 deletions(-)
 create mode 100644 include/erofs/fragments.h
 create mode 100644 lib/fragments.c

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 24f6204..d17aadb 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -18,7 +18,8 @@ extern "C"
 #define EROFS_CONFIG_COMPR_MIN_SZ           (32   * 1024)
 
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
-int erofs_write_compressed_file(struct erofs_inode *inode);
+int erofs_write_compressed_file_from_fd(struct erofs_inode *inode, int fd,
+					bool is_src);
 
 int z_erofs_compress_init(struct erofs_buffer_head *bh);
 int z_erofs_compress_exit(void);
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 6c6d71f..b677c54 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -44,6 +44,7 @@ struct erofs_configure {
 	char c_chunkbits;
 	bool c_noinline_data;
 	bool c_ztailpacking;
+	bool c_fragments;
 	bool c_ignore_mtime;
 	bool c_showprogress;
 
@@ -62,7 +63,7 @@ struct erofs_configure {
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
 
-	u32 c_pclusterblks_max, c_pclusterblks_def;
+	u32 c_pclusterblks_max, c_pclusterblks_def, c_pclusterblks_frags;
 	u32 c_max_decompressed_extent_bytes;
 	u32 c_dict_size;
 	u64 c_unix_timestamp;
diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
new file mode 100644
index 0000000..89f0f18
--- /dev/null
+++ b/include/erofs/fragments.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C), 2022, Coolpad Group Limited.
+ */
+#ifndef __EROFS_FRAGMENTS_H
+#define __EROFS_FRAGMENTS_H
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+#include "erofs/internal.h"
+
+int z_erofs_fill_fragments(struct erofs_inode *inode, void *data,
+			   unsigned int len);
+struct erofs_inode *erofs_mkfs_build_fragments(void);
+int erofs_fragments_init(void);
+void erofs_fragments_exit(void);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 79b39b0..0a87c58 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -21,6 +21,8 @@ unsigned int erofs_iput(struct erofs_inode *inode);
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
 struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
 						    const char *path);
+int erofs_prepare_inode_buffer(struct erofs_inode *inode);
+struct erofs_inode *erofs_generate_inode(struct stat64 *st, const char *path);
 
 #ifdef __cplusplus
 }
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index ce235de..0f2a217 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -193,6 +193,7 @@ struct erofs_inode {
 	unsigned int eof_tailrawsize;
 
 	erofs_off_t fragmentoff;
+	unsigned int fragment_size;
 
 	union {
 		void *compressmeta;
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index d957ebb..1eaad68 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -75,7 +75,9 @@ struct erofs_super_block {
 	} __packed u1;
 	__le16 extra_devices;	/* # of devices besides the primary device */
 	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
-	__u8 reserved2[38];
+	__u8 reserved[6];
+	__le64 fragments_nid;
+	__u8 reserved2[24];
 };
 
 /*
@@ -265,6 +267,7 @@ struct erofs_inode_chunk_index {
 
 /* maximum supported size of a physical compression cluster */
 #define Z_EROFS_PCLUSTER_MAX_SIZE	(1024 * 1024)
+#define Z_EROFS_PCLUSTER_MAX_BLKS	(Z_EROFS_PCLUSTER_MAX_SIZE / EROFS_BLKSIZ)
 
 /* available compression algorithm types (for h_algorithmtype) */
 enum {
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 3fad357..95f1d55 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -22,12 +22,14 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/trace.h \
       $(top_srcdir)/include/erofs/xattr.h \
       $(top_srcdir)/include/erofs/compress_hints.h \
+      $(top_srcdir)/include/erofs/fragments.h \
       $(top_srcdir)/lib/liberofs_private.h
 
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
-		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c
+		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
+		      fragments.c
 liberofs_la_CFLAGS = -Wall -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/compress.c b/lib/compress.c
index ee3b856..713c105 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -18,6 +18,7 @@
 #include "compressor.h"
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
+#include "erofs/fragments.h"
 
 static struct erofs_compress compresshandle;
 static unsigned int algorithmtype[2];
@@ -74,9 +75,9 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 	if (!d1) {
 		/*
 		 * A lcluster cannot have three parts with the middle one which
-		 * is well-compressed for !ztailpacking cases.
+		 * is well-compressed for !ztailpacking and !fragments cases.
 		 */
-		DBG_BUGON(!raw && !cfg.c_ztailpacking);
+		DBG_BUGON(!raw && !cfg.c_ztailpacking && !cfg.c_fragments);
 		type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
 			Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
 		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
@@ -143,7 +144,7 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 				     unsigned int *len, char *dst)
 {
 	int ret;
-	unsigned int count;
+	unsigned int count, offset, rcopied, rzeroed;
 
 	/* reset clusterofs to 0 if permitted */
 	if (!erofs_sb_has_lz4_0padding() && ctx->clusterofs &&
@@ -153,11 +154,21 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 		ctx->clusterofs = 0;
 	}
 
-	/* write uncompressed data */
+	/*
+	 * write uncompressed data from clusterofs which can benefit from
+	 * in-place I/O, loop shift right when to exceed EROFS_BLKSIZ.
+	 */
 	count = min(EROFS_BLKSIZ, *len);
 
-	memcpy(dst, ctx->queue + ctx->head, count);
-	memset(dst + count, 0, EROFS_BLKSIZ - count);
+	offset = cfg.c_fragments ? ctx->clusterofs : 0;
+	rcopied = min(EROFS_BLKSIZ - offset, count);
+	rzeroed = EROFS_BLKSIZ - offset - rcopied;
+
+	memcpy(dst + offset, ctx->queue + ctx->head, rcopied);
+	memcpy(dst, ctx->queue + ctx->head + rcopied, count - rcopied);
+
+	memset(dst + offset + rcopied, 0, rzeroed);
+	memset(dst + count - rcopied, 0, EROFS_BLKSIZ - count - rzeroed);
 
 	erofs_dbg("Writing %u uncompressed data to block %u",
 		  count, ctx->blkaddr);
@@ -167,8 +178,11 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 	return count;
 }
 
-static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode)
+static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode,
+						 bool is_src)
 {
+	if (cfg.c_fragments && !is_src)
+		return cfg.c_pclusterblks_frags;
 #ifndef NDEBUG
 	if (cfg.c_random_pclusterblks)
 		return 1 + rand() % cfg.c_pclusterblks_max;
@@ -224,7 +238,7 @@ static void tryrecompress_trailing(void *in, unsigned int *insize,
 
 static int vle_compress_one(struct erofs_inode *inode,
 			    struct z_erofs_vle_compress_ctx *ctx,
-			    bool final)
+			    bool final, bool is_src)
 {
 	struct erofs_compress *const h = &compresshandle;
 	unsigned int len = ctx->tail - ctx->head;
@@ -234,14 +248,19 @@ static int vle_compress_one(struct erofs_inode *inode,
 	char *const dst = dstbuf + EROFS_BLKSIZ;
 
 	while (len) {
-		unsigned int pclustersize =
-			z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
+		unsigned int pclustersize = EROFS_BLKSIZ *
+				z_erofs_get_max_pclusterblks(inode, is_src);
 		bool may_inline = (cfg.c_ztailpacking && final);
+		bool may_merge = (cfg.c_fragments && final && is_src);
 		bool raw;
 
 		if (len <= pclustersize) {
 			if (!final)
 				break;
+			if (may_merge) {
+				count = len;
+				goto fragments;
+			}
 			if (!may_inline && len <= EROFS_BLKSIZ)
 				goto nocompression;
 		}
@@ -294,6 +313,19 @@ nocompression:
 				return ret;
 			ctx->compressedblks = 1;
 			raw = false;
+		} else if (may_merge && len == count && ret < pclustersize) {
+fragments:
+			ret = z_erofs_fill_fragments(inode,
+						     ctx->queue + ctx->head,
+						     len);
+			if (ret < 0)
+				return ret;
+			if (inode->i_size == inode->fragment_size) {
+				ctx->head += len;
+				return 0;
+			}
+			ctx->compressedblks = 0;
+			raw = false;
 		} else {
 			unsigned int tailused, padding;
 
@@ -546,13 +578,20 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
 {
 	struct z_erofs_map_header h = {
 		.h_advise = cpu_to_le16(inode->z_advise),
-		.h_idata_size = cpu_to_le16(inode->idata_size),
 		.h_algorithmtype = inode->z_algorithmtype[1] << 4 |
 				   inode->z_algorithmtype[0],
 		/* lclustersize */
 		.h_clusterbits = inode->z_logical_clusterbits - 12,
 	};
 
+	if (cfg.c_fragments)
+		h.h_fragmentoff = cpu_to_le32(inode->fragmentoff);
+	else
+		h.h_idata_size = cpu_to_le16(inode->idata_size);
+
+	if (inode->fragment_size && inode->i_size == inode->fragment_size)
+		h.h_clusterbits |=  1 << Z_EROFS_FRAGMENT_INODE_BIT;
+
 	memset(compressmeta, 0, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
 	/* write out map header */
 	memcpy(compressmeta, &h, sizeof(struct z_erofs_map_header));
@@ -604,30 +643,25 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 	inode->eof_tailraw = NULL;
 }
 
-int erofs_write_compressed_file(struct erofs_inode *inode)
+int erofs_write_compressed_file_from_fd(struct erofs_inode *inode, int fd,
+					bool is_src)
 {
 	struct erofs_buffer_head *bh;
 	static struct z_erofs_vle_compress_ctx ctx;
 	erofs_off_t remaining;
 	erofs_blk_t blkaddr, compressed_blocks;
 	unsigned int legacymetasize;
-	int ret, fd;
+	int ret;
 	u8 *compressmeta = malloc(vle_compressmeta_capacity(inode->i_size));
 
 	if (!compressmeta)
 		return -ENOMEM;
 
-	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
-	if (fd < 0) {
-		ret = -errno;
-		goto err_free_meta;
-	}
-
 	/* allocate main data buffer */
 	bh = erofs_balloc(DATA, 0, 0, 0);
 	if (IS_ERR(bh)) {
 		ret = PTR_ERR(bh);
-		goto err_close;
+		goto err_free_meta;
 	}
 
 	/* initialize per-file compression setting */
@@ -648,6 +682,9 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	inode->z_algorithmtype[1] = algorithmtype[1];
 	inode->z_logical_clusterbits = LOG_BLOCK_SIZE;
 
+	inode->idata_size = 0;
+	inode->fragment_size = 0;
+
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.blkaddr = blkaddr;
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
@@ -667,7 +704,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 		remaining -= readcount;
 		ctx.tail += readcount;
 
-		ret = vle_compress_one(inode, &ctx, !remaining);
+		ret = vle_compress_one(inode, &ctx, !remaining, is_src);
 		if (ret)
 			goto err_free_idata;
 	}
@@ -681,19 +718,20 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	vle_write_indexes_final(&ctx);
 	legacymetasize = ctx.metacur - compressmeta;
 	/* estimate if data compression saves space or not */
-	if (compressed_blocks * EROFS_BLKSIZ + inode->idata_size +
+	if (!inode->fragment_size &&
+	    compressed_blocks * EROFS_BLKSIZ + inode->idata_size +
 	    legacymetasize >= inode->i_size) {
 		ret = -ENOSPC;
 		goto err_free_idata;
 	}
 	z_erofs_write_mapheader(inode, compressmeta);
 
-	close(fd);
 	if (compressed_blocks) {
 		ret = erofs_bh_balloon(bh, blknr_to_addr(compressed_blocks));
 		DBG_BUGON(ret != EROFS_BLKSIZ);
 	} else {
-		DBG_BUGON(!inode->idata_size);
+		if (!cfg.c_fragments)
+			DBG_BUGON(!inode->idata_size);
 	}
 
 	erofs_info("compressed %s (%llu bytes) into %u blocks",
@@ -716,7 +754,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 		DBG_BUGON(ret);
 	}
 	inode->compressmeta = compressmeta;
-	erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
+	if (is_src)
+		erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
 	return 0;
 
 err_free_idata:
@@ -726,8 +765,6 @@ err_free_idata:
 	}
 err_bdrop:
 	erofs_bdrop(bh, true);	/* revoke buffer */
-err_close:
-	close(fd);
 err_free_meta:
 	free(compressmeta);
 	return ret;
@@ -833,14 +870,27 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 	 * to be loaded in order to get those compressed block counts.
 	 */
 	if (cfg.c_pclusterblks_max > 1) {
-		if (cfg.c_pclusterblks_max >
-		    Z_EROFS_PCLUSTER_MAX_SIZE / EROFS_BLKSIZ) {
+		if (cfg.c_pclusterblks_max > Z_EROFS_PCLUSTER_MAX_BLKS) {
 			erofs_err("unsupported clusterblks %u (too large)",
 				  cfg.c_pclusterblks_max);
 			return -EINVAL;
 		}
+		if (cfg.c_pclusterblks_frags > Z_EROFS_PCLUSTER_MAX_BLKS) {
+			erofs_err("unsupported clusterblks %u (too large for fragments)",
+				  cfg.c_pclusterblks_frags);
+			return -EINVAL;
+		}
+		if (cfg.c_pclusterblks_frags == 1) {
+			erofs_err("physical cluster size of fragments should > 4096 bytes");
+			return -EINVAL;
+		}
 		erofs_sb_set_big_pcluster();
 	}
+	if (!erofs_sb_has_big_pcluster() && cfg.c_pclusterblks_frags > 1) {
+		erofs_err("invalid clusterblks %u (for fragments)",
+			  cfg.c_pclusterblks_frags);
+		return -EINVAL;
+	}
 
 	if (ret != Z_EROFS_COMPRESSION_LZ4)
 		erofs_sb_set_compr_cfgs();
diff --git a/lib/fragments.c b/lib/fragments.c
new file mode 100644
index 0000000..67e79b8
--- /dev/null
+++ b/lib/fragments.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+/*
+ * Copyright (C), 2022, Coolpad Group Limited.
+ * Created by Yue Hu <huyue2@coolpad.com>
+ */
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include "erofs/err.h"
+#include "erofs/inode.h"
+#include "erofs/compress.h"
+#include "erofs/print.h"
+#include "erofs/fragments.h"
+
+static FILE *fragmentsfp;
+
+int z_erofs_fill_fragments(struct erofs_inode *inode, void *data,
+			   unsigned int len)
+{
+	inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+	inode->fragmentoff = ftell(fragmentsfp);
+	inode->fragment_size = len;
+
+	if (write(fileno(fragmentsfp), data, len) < 0)
+		return -EIO;
+
+	erofs_sb_set_fragments();
+
+	erofs_dbg("Recording %u fragment data at %lu", inode->fragment_size,
+		  inode->fragmentoff);
+	return len;
+}
+
+struct erofs_inode *erofs_mkfs_build_fragments(void)
+{
+	struct stat64 st;
+	struct erofs_inode *inode;
+	int ret, fd = fileno(fragmentsfp);
+
+	ret = fstat64(fd, &st);
+	if (ret)
+		return ERR_PTR(-errno);
+
+	inode = erofs_generate_inode(&st, NULL);
+	if (IS_ERR(inode))
+		return inode;
+
+	fseek(fragmentsfp, 0, SEEK_SET);
+	ret = erofs_write_compressed_file_from_fd(inode, fd, false);
+	if (ret) {
+		erofs_err("write fragments file error");
+		return ERR_PTR(ret);
+	}
+
+	erofs_prepare_inode_buffer(inode);
+	return inode;
+}
+
+void erofs_fragments_exit(void)
+{
+	if (fragmentsfp)
+		fclose(fragmentsfp);
+}
+
+int erofs_fragments_init(void)
+{
+#ifdef HAVE_TMPFILE64
+	fragmentsfp = tmpfile64();
+#else
+	fragmentsfp = tmpfile();
+#endif
+	if (!fragmentsfp)
+		return -ENOMEM;
+	return 0;
+}
diff --git a/lib/inode.c b/lib/inode.c
index f192510..a49c7a7 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -405,7 +405,11 @@ int erofs_write_file(struct erofs_inode *inode)
 	}
 
 	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
-		ret = erofs_write_compressed_file(inode);
+		fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
+		if (fd < 0)
+			return -errno;
+		ret = erofs_write_compressed_file_from_fd(inode, fd, true);
+		close(fd);
 
 		if (!ret || ret != -ENOSPC)
 			return ret;
@@ -583,7 +587,7 @@ static int erofs_prepare_tail_block(struct erofs_inode *inode)
 	return 0;
 }
 
-static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
+int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 {
 	unsigned int inodesize;
 	struct erofs_buffer_head *bh, *ibh;
@@ -782,6 +786,9 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 	const char *fspath;
 	char *decorated = NULL;
 
+	if (!path)
+		return 0;
+
 	inode->capabilities = 0;
 	if (!cfg.fs_config_file && !cfg.mount_point)
 		return 0;
@@ -868,7 +875,8 @@ static int erofs_fill_inode(struct erofs_inode *inode,
 		return -EINVAL;
 	}
 
-	strncpy(inode->i_srcpath, path, sizeof(inode->i_srcpath) - 1);
+	strncpy(inode->i_srcpath, path ? path : "tmp",
+		sizeof(inode->i_srcpath) - 1);
 	inode->i_srcpath[sizeof(inode->i_srcpath) - 1] = '\0';
 
 	inode->dev = st->st_dev;
@@ -907,6 +915,23 @@ static struct erofs_inode *erofs_new_inode(void)
 	return inode;
 }
 
+struct erofs_inode *erofs_generate_inode(struct stat64 *st, const char *path)
+{
+	struct erofs_inode *inode;
+	int ret;
+
+	inode = erofs_new_inode();
+	if (IS_ERR(inode))
+		return inode;
+
+	ret = erofs_fill_inode(inode, st, path);
+	if (ret) {
+		free(inode);
+		return ERR_PTR(ret);
+	}
+	return inode;
+}
+
 /* get the inode from the (source) path */
 static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
 {
@@ -934,17 +959,7 @@ static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
 	}
 
 	/* cannot find in the inode cache */
-	inode = erofs_new_inode();
-	if (IS_ERR(inode))
-		return inode;
-
-	ret = erofs_fill_inode(inode, &st, path);
-	if (ret) {
-		free(inode);
-		return ERR_PTR(ret);
-	}
-
-	return inode;
+	return erofs_generate_inode(&st, path);
 }
 
 static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
diff --git a/lib/super.c b/lib/super.c
index b267412..20db217 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -104,6 +104,21 @@ int erofs_read_superblock(void)
 	sbi.xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
 	sbi.islotbits = EROFS_ISLOTBITS;
 	sbi.root_nid = le16_to_cpu(dsb->root_nid);
+	sbi.fragments_inode = NULL;
+	if (erofs_sb_has_fragments()) {
+		struct erofs_inode *inode;
+
+		inode = calloc(1, sizeof(struct erofs_inode));
+		if (!inode)
+			return -ENOMEM;
+		inode->nid = le64_to_cpu(dsb->fragments_nid);
+		ret = erofs_read_inode_from_disk(inode);
+		if (ret) {
+			free(inode);
+			return ret;
+		}
+		sbi.fragments_inode = inode;
+	}
 	sbi.inos = le64_to_cpu(dsb->inos);
 	sbi.checksum = le32_to_cpu(dsb->checksum);
 
@@ -111,11 +126,18 @@ int erofs_read_superblock(void)
 	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
 
 	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
-	return erofs_init_devices(&sbi, dsb);
+
+	ret = erofs_init_devices(&sbi, dsb);
+	if (ret && sbi.fragments_inode)
+		free(sbi.fragments_inode);
+	return ret;
 }
 
 void erofs_put_super(void)
 {
 	if (sbi.devs)
 		free(sbi.devs);
+
+	if (sbi.fragments_inode)
+		free(sbi.fragments_inode);
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index deb8e1f..b629196 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -23,6 +23,7 @@
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
+#include "erofs/fragments.h"
 #include "../lib/liberofs_private.h"
 
 #ifdef HAVE_LIBUUID
@@ -129,9 +130,9 @@ static int parse_extended_opts(const char *opts)
 		const char *p = strchr(token, ',');
 
 		next = NULL;
-		if (p)
+		if (p) {
 			next = p + 1;
-		else {
+		} else {
 			p = token + strlen(token);
 			next = p;
 		}
@@ -198,7 +199,34 @@ static int parse_extended_opts(const char *opts)
 				return -EINVAL;
 			cfg.c_ztailpacking = true;
 		}
+
+		if (MATCH_EXTENTED_OPT("fragments", token, keylen)) {
+			char *endptr;
+			u64 i;
+
+			if (vallen || cfg.c_ztailpacking)
+				return -EINVAL;
+			cfg.c_fragments = true;
+
+			i = strtoull(next, &endptr, 0);
+			if (i == 0 || (*endptr != ',' && *endptr != '\0')) {
+				cfg.c_pclusterblks_frags = 1;
+				continue;
+			}
+			if (i % EROFS_BLKSIZ) {
+				erofs_err("invalid physical clustersize %llu",
+					  i);
+				return -EINVAL;
+			}
+			cfg.c_pclusterblks_frags = i / EROFS_BLKSIZ;
+
+			if (*endptr == ',')
+				next = strchr(next, ',')  + 1;
+			else
+				goto out;
+		}
 	}
+out:
 	return 0;
 }
 
@@ -438,7 +466,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 
 int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 				  erofs_nid_t root_nid,
-				  erofs_blk_t *blocks)
+				  erofs_blk_t *blocks,
+				  erofs_nid_t fragments_nid)
 {
 	struct erofs_super_block sb = {
 		.magic     = cpu_to_le32(EROFS_SUPER_MAGIC_V1),
@@ -462,6 +491,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	*blocks         = erofs_mapbh(NULL);
 	sb.blocks       = cpu_to_le32(*blocks);
 	sb.root_nid     = cpu_to_le16(root_nid);
+	sb.fragments_nid     = cpu_to_le64(fragments_nid);
 	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
 
 	if (erofs_sb_has_compr_cfgs())
@@ -579,8 +609,8 @@ int main(int argc, char **argv)
 {
 	int err = 0;
 	struct erofs_buffer_head *sb_bh;
-	struct erofs_inode *root_inode;
-	erofs_nid_t root_nid;
+	struct erofs_inode *root_inode, *fragments_inode;
+	erofs_nid_t root_nid, fragments_nid;
 	struct stat64 st;
 	erofs_blk_t nblocks;
 	struct timeval t;
@@ -650,6 +680,14 @@ int main(int argc, char **argv)
 		erofs_warn("EXPERIMENTAL chunked file feature in use. Use at your own risk!");
 	if (cfg.c_ztailpacking)
 		erofs_warn("EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
+	if (cfg.c_fragments) {
+		err = erofs_fragments_init();
+		if (err) {
+			erofs_err("failed to initialize fragments");
+			return 1;
+		}
+		erofs_warn("EXPERIMENTAL compressed fragments feature in use. Use at your own risk!");
+	}
 	erofs_set_fs_root(cfg.c_src_path);
 #ifndef NDEBUG
 	if (cfg.c_random_pclusterblks)
@@ -719,7 +757,19 @@ int main(int argc, char **argv)
 			goto exit;
 	}
 
-	err = erofs_mkfs_update_super_block(sb_bh, root_nid, &nblocks);
+	fragments_nid = 0;
+	if (cfg.c_fragments) {
+		fragments_inode = erofs_mkfs_build_fragments();
+		if (IS_ERR(fragments_inode)) {
+			err = PTR_ERR(fragments_inode);
+			goto exit;
+		}
+		fragments_nid = erofs_lookupnid(fragments_inode);
+		erofs_iput(fragments_inode);
+	}
+
+	err = erofs_mkfs_update_super_block(sb_bh, root_nid, &nblocks,
+					    fragments_nid);
 	if (err)
 		goto exit;
 
@@ -741,6 +791,8 @@ exit:
 	erofs_cleanup_exclude_rules();
 	if (cfg.c_chunkbits)
 		erofs_blob_exit();
+	if (cfg.c_fragments)
+		erofs_fragments_exit();
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.17.1

