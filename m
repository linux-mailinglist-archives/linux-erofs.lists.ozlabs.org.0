Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 091025EAAE0
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Sep 2022 17:25:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MbmmS0cZyz3c1n
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 01:25:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MbmmC6Pp0z3bc3
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Sep 2022 01:25:31 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VQoJOMk_1664205927;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VQoJOMk_1664205927)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 23:25:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 5/8] erofs-utils: mkfs: support fragments
Date: Mon, 26 Sep 2022 23:25:08 +0800
Message-Id: <20220926152511.94832-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220926152511.94832-1-hsiangkao@linux.alibaba.com>
References: <20220926152511.94832-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>, Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

This approach can merge tail pclusters or the whole files into a special
inode in order to achieve greater compression ratios. Also, an option of
pcluster size is provided for different compression requirements.

Enable interlaced uncompressed data layout for compressed files at the
same time as well.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/compress.h  |  11 ++++-
 include/erofs/config.h    |   3 +-
 include/erofs/fragments.h |  28 +++++++++++
 include/erofs/inode.h     |   1 +
 include/erofs/internal.h  |   3 ++
 lib/Makefile.am           |   4 +-
 lib/compress.c            | 101 ++++++++++++++++++++++++++++----------
 lib/fragments.c           |  65 ++++++++++++++++++++++++
 lib/inode.c               |  58 ++++++++++++++++++++--
 mkfs/main.c               |  58 +++++++++++++++++++---
 10 files changed, 295 insertions(+), 37 deletions(-)
 create mode 100644 include/erofs/fragments.h
 create mode 100644 lib/fragments.c

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 24f6204..e9dfaf2 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -18,13 +18,22 @@ extern "C"
 #define EROFS_CONFIG_COMPR_MIN_SZ           (32   * 1024)
 
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
-int erofs_write_compressed_file(struct erofs_inode *inode);
+int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
 
 int z_erofs_compress_init(struct erofs_buffer_head *bh);
 int z_erofs_compress_exit(void);
 
 const char *z_erofs_list_available_compressors(unsigned int i);
 
+static inline bool erofs_is_packed_inode(struct erofs_inode *inode)
+{
+	if (inode->nid == EROFS_PACKED_NID_UNALLOCATED) {
+		DBG_BUGON(sbi.packed_nid != EROFS_PACKED_NID_UNALLOCATED);
+		return true;
+	}
+	return (sbi.packed_nid > 0 && inode->nid == sbi.packed_nid);
+}
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 539d813..764b0f7 100644
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
+	u32 c_pclusterblks_max, c_pclusterblks_def, c_pclusterblks_packed;
 	u32 c_max_decompressed_extent_bytes;
 	u32 c_dict_size;
 	u64 c_unix_timestamp;
diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
new file mode 100644
index 0000000..5444384
--- /dev/null
+++ b/include/erofs/fragments.h
@@ -0,0 +1,28 @@
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
+extern const char *frags_packedname;
+#define EROFS_PACKED_INODE	frags_packedname
+
+int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
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
index 79b8d89..bf20cd3 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -22,6 +22,7 @@ unsigned int erofs_iput(struct erofs_inode *inode);
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
 struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
 						    const char *path);
+struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name);
 
 #ifdef __cplusplus
 }
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index dd3776c..6fc58f9 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -70,6 +70,8 @@ struct erofs_device_info {
 	u32 mapped_blkaddr;
 };
 
+#define EROFS_PACKED_NID_UNALLOCATED	-1
+
 struct erofs_sb_info {
 	struct erofs_device_info *devs;
 
@@ -212,6 +214,7 @@ struct erofs_inode {
 	uint64_t capabilities;
 #endif
 	erofs_off_t fragmentoff;
+	unsigned int fragment_size;
 };
 
 static inline bool is_inode_layout_compression(struct erofs_inode *inode)
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
index 8fa60e2..c0bd307 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -18,6 +18,7 @@
 #include "compressor.h"
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
+#include "erofs/fragments.h"
 
 static struct erofs_compress compresshandle;
 static unsigned int algorithmtype[2];
@@ -33,6 +34,7 @@ struct z_erofs_vle_compress_ctx {
 	u8 queue[EROFS_CONFIG_COMPR_MAX_SZ * 2];
 	struct z_erofs_inmem_extent e;	/* (lookahead) extent */
 
+	struct erofs_inode *inode;
 	u8 *metacur;
 	unsigned int head, tail;
 	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
@@ -68,6 +70,7 @@ static void z_erofs_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
 
 static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 {
+	struct erofs_inode *inode = ctx->inode;
 	unsigned int clusterofs = ctx->clusterofs;
 	unsigned int count = ctx->e.length;
 	unsigned int d0 = 0, d1 = (clusterofs + count) / EROFS_BLKSIZ;
@@ -89,7 +92,11 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
 
 		di.di_advise = advise;
-		di.di_u.blkaddr = cpu_to_le32(ctx->e.blkaddr);
+		if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY &&
+		    !ctx->e.compressedblks)
+			di.di_u.blkaddr = cpu_to_le32(inode->fragmentoff >> 32);
+		else
+			di.di_u.blkaddr = cpu_to_le32(ctx->e.blkaddr);
 		memcpy(ctx->metacur, &di, sizeof(di));
 		ctx->metacur += sizeof(di);
 
@@ -128,7 +135,12 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 		} else {
 			type = ctx->e.raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
 				Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
-			di.di_u.blkaddr = cpu_to_le32(ctx->e.blkaddr);
+
+			if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY &&
+			    !ctx->e.compressedblks)
+				di.di_u.blkaddr = cpu_to_le32(inode->fragmentoff >> 32);
+			else
+				di.di_u.blkaddr = cpu_to_le32(ctx->e.blkaddr);
 		}
 		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
 		di.di_advise = advise;
@@ -163,7 +175,10 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 	count = min(EROFS_BLKSIZ, *len);
 
 	/* write interlaced uncompressed data if needed */
-	interlaced_offset = 0; /* will set it to clusterofs */
+	if (ctx->inode->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
+		interlaced_offset = ctx->clusterofs;
+	else
+		interlaced_offset = 0;
 	rightpart = min(EROFS_BLKSIZ - interlaced_offset, count);
 
 	memset(dst, 0, EROFS_BLKSIZ);
@@ -181,6 +196,8 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 
 static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode)
 {
+	if (erofs_is_packed_inode(inode))
+		return cfg.c_pclusterblks_packed;
 #ifndef NDEBUG
 	if (cfg.c_random_pclusterblks)
 		return 1 + rand() % cfg.c_pclusterblks_max;
@@ -234,11 +251,11 @@ static void tryrecompress_trailing(void *in, unsigned int *insize,
 	*compressedsize = ret;
 }
 
-static int vle_compress_one(struct erofs_inode *inode,
-			    struct z_erofs_vle_compress_ctx *ctx,
+static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx,
 			    bool final)
 {
 	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
+	struct erofs_inode *inode = ctx->inode;
 	char *const dst = dstbuf + EROFS_BLKSIZ;
 	struct erofs_compress *const h = &compresshandle;
 	unsigned int len = ctx->tail - ctx->head;
@@ -248,10 +265,16 @@ static int vle_compress_one(struct erofs_inode *inode,
 		unsigned int pclustersize =
 			z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
 		bool may_inline = (cfg.c_ztailpacking && final);
+		bool may_packing = (cfg.c_fragments && final &&
+				   !erofs_is_packed_inode(inode));
 
 		if (len <= pclustersize) {
 			if (!final)
 				break;
+			if (may_packing) {
+				ctx->e.length = len;
+				goto frag_packing;
+			}
 			if (!may_inline && len <= EROFS_BLKSIZ)
 				goto nocompression;
 		}
@@ -267,7 +290,6 @@ static int vle_compress_one(struct erofs_inode *inode,
 					  inode->i_srcpath,
 					  erofs_strerror(ret));
 			}
-
 			if (may_inline && len < EROFS_BLKSIZ)
 				ret = z_erofs_fill_inline_data(inode,
 						ctx->queue + ctx->head,
@@ -287,6 +309,16 @@ nocompression:
 			 */
 			ctx->e.compressedblks = 1;
 			ctx->e.raw = true;
+		} else if (may_packing && len == ctx->e.length &&
+			   ret < pclustersize) {
+frag_packing:
+			ret = z_erofs_pack_fragments(inode,
+						     ctx->queue + ctx->head,
+						     len);
+			if (ret < 0)
+				return ret;
+			ctx->e.compressedblks = 0; /* indicate a fragment */
+			ctx->e.raw = true;
 		/* tailpcluster should be less than 1 block */
 		} else if (may_inline && len == ctx->e.length &&
 			   ret < EROFS_BLKSIZ) {
@@ -559,13 +591,17 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
 {
 	struct z_erofs_map_header h = {
 		.h_advise = cpu_to_le16(inode->z_advise),
-		.h_idata_size = cpu_to_le16(inode->idata_size),
 		.h_algorithmtype = inode->z_algorithmtype[1] << 4 |
 				   inode->z_algorithmtype[0],
 		/* lclustersize */
 		.h_clusterbits = inode->z_logical_clusterbits - 12,
 	};
 
+	if (inode->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
+		h.h_fragmentoff = cpu_to_le32(inode->fragmentoff);
+	else
+		h.h_idata_size = cpu_to_le16(inode->idata_size);
+
 	memset(compressmeta, 0, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
 	/* write out map header */
 	memcpy(compressmeta, &h, sizeof(struct z_erofs_map_header));
@@ -618,30 +654,24 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 	inode->eof_tailraw = NULL;
 }
 
-int erofs_write_compressed_file(struct erofs_inode *inode)
+int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
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
@@ -658,11 +688,17 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 		if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION)
 			inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
 	}
+	if (cfg.c_fragments)
+		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 	inode->z_algorithmtype[0] = algorithmtype[0];
 	inode->z_algorithmtype[1] = algorithmtype[1];
 	inode->z_logical_clusterbits = LOG_BLOCK_SIZE;
 
+	inode->idata_size = 0;
+	inode->fragment_size = 0;
+
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
+	ctx.inode = inode;
 	ctx.blkaddr = blkaddr;
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	ctx.head = ctx.tail = 0;
@@ -682,7 +718,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 		remaining -= readcount;
 		ctx.tail += readcount;
 
-		ret = vle_compress_one(inode, &ctx, !remaining);
+		ret = vle_compress_one(&ctx, !remaining);
 		if (ret)
 			goto err_free_idata;
 	}
@@ -696,29 +732,41 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	z_erofs_write_indexes_final(&ctx);
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
+	/* if the entire file is a fragment, a simplified form is used. */
+	if (inode->i_size == inode->fragment_size) {
+		DBG_BUGON(inode->fragmentoff >> 63);
+		*(__le64 *)compressmeta =
+			cpu_to_le64(inode->fragmentoff | 1ULL << 63);
+		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+		legacymetasize = Z_EROFS_LEGACY_MAP_HEADER_SIZE;
+	}
+
 	if (compressed_blocks) {
 		ret = erofs_bh_balloon(bh, blknr_to_addr(compressed_blocks));
 		DBG_BUGON(ret != EROFS_BLKSIZ);
 	} else {
-		DBG_BUGON(!inode->idata_size);
+		if (!cfg.c_fragments)
+			DBG_BUGON(!inode->idata_size);
 	}
 
 	erofs_info("compressed %s (%llu bytes) into %u blocks",
 		   inode->i_srcpath, (unsigned long long)inode->i_size,
 		   compressed_blocks);
 
-	if (inode->idata_size)
+	if (inode->idata_size) {
+		bh->op = &erofs_skip_write_bhops;
 		inode->bh_data = bh;
-	else
+	} else {
 		erofs_bdrop(bh, false);
+	}
 
 	inode->u.i_blocks = compressed_blocks;
 
@@ -731,7 +779,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 		DBG_BUGON(ret);
 	}
 	inode->compressmeta = compressmeta;
-	erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
+	if (!erofs_is_packed_inode(inode))
+		erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
 	return 0;
 
 err_free_idata:
@@ -741,8 +790,6 @@ err_free_idata:
 	}
 err_bdrop:
 	erofs_bdrop(bh, true);	/* revoke buffer */
-err_close:
-	close(fd);
 err_free_meta:
 	free(compressmeta);
 	return ret;
@@ -856,6 +903,10 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
 		}
 		erofs_sb_set_big_pcluster();
 	}
+	if (cfg.c_pclusterblks_packed > cfg.c_pclusterblks_max) {
+		erofs_err("invalid physical cluster size for the packed file");
+		return -EINVAL;
+	}
 
 	if (ret != Z_EROFS_COMPRESSION_LZ4)
 		erofs_sb_set_compr_cfgs();
diff --git a/lib/fragments.c b/lib/fragments.c
new file mode 100644
index 0000000..b8c37d5
--- /dev/null
+++ b/lib/fragments.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+/*
+ * Copyright (C), 2022, Coolpad Group Limited.
+ * Created by Yue Hu <huyue2@coolpad.com>
+ */
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <unistd.h>
+#include "erofs/err.h"
+#include "erofs/inode.h"
+#include "erofs/compress.h"
+#include "erofs/print.h"
+#include "erofs/fragments.h"
+
+static FILE *packedfile;
+const char *frags_packedname = "packed_file";
+
+int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
+			   unsigned int len)
+{
+	inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+	inode->fragmentoff = ftell(packedfile);
+	inode->fragment_size = len;
+	/*
+	 * If the packed inode is larger than 4GiB, the full fragmentoff
+	 * will be recorded by switching to the noncompact layout anyway.
+	 */
+	if (inode->fragmentoff >> 32)
+		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+
+	if (fwrite(data, len, 1, packedfile) != 1)
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
+	fflush(packedfile);
+
+	return erofs_mkfs_build_special_from_fd(fileno(packedfile),
+						frags_packedname);
+}
+
+void erofs_fragments_exit(void)
+{
+	if (packedfile)
+		fclose(packedfile);
+}
+
+int erofs_fragments_init(void)
+{
+#ifdef HAVE_TMPFILE64
+	packedfile = tmpfile64();
+#else
+	packedfile = tmpfile();
+#endif
+	if (!packedfile)
+		return -ENOMEM;
+	return 0;
+}
diff --git a/lib/inode.c b/lib/inode.c
index 4da28b3..130e275 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -25,6 +25,7 @@
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
+#include "erofs/fragments.h"
 #include "liberofs_private.h"
 
 #define S_SHIFT                 12
@@ -424,7 +425,11 @@ int erofs_write_file(struct erofs_inode *inode)
 	}
 
 	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
-		ret = erofs_write_compressed_file(inode);
+		fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
+		if (fd < 0)
+			return -errno;
+		ret = erofs_write_compressed_file(inode, fd);
+		close(fd);
 
 		if (!ret || ret != -ENOSPC)
 			return ret;
@@ -769,6 +774,8 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
 		return true;
 	if (inode->i_size > UINT_MAX)
 		return true;
+	if (erofs_is_packed_inode(inode))
+		return false;
 	if (inode->i_uid > USHRT_MAX)
 		return true;
 	if (inode->i_gid > USHRT_MAX)
@@ -844,8 +851,7 @@ static int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 }
 #endif
 
-static int erofs_fill_inode(struct erofs_inode *inode,
-			    struct stat64 *st,
+static int erofs_fill_inode(struct erofs_inode *inode, struct stat64 *st,
 			    const char *path)
 {
 	int err = erofs_droid_inode_fsconfig(inode, st, path);
@@ -1180,3 +1186,49 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
 
 	return erofs_mkfs_build_tree(inode);
 }
+
+struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
+{
+	struct stat64 st;
+	struct erofs_inode *inode;
+	int ret;
+
+	lseek(fd, 0, SEEK_SET);
+	ret = fstat64(fd, &st);
+	if (ret)
+		return ERR_PTR(-errno);
+
+	inode = erofs_new_inode();
+	if (IS_ERR(inode))
+		return inode;
+
+	if (name == EROFS_PACKED_INODE) {
+		st.st_uid = st.st_gid = 0;
+		st.st_nlink = 0;
+	}
+
+	ret = erofs_fill_inode(inode, &st, name);
+	if (ret) {
+		free(inode);
+		return ERR_PTR(ret);
+	}
+
+	if (name == EROFS_PACKED_INODE) {
+		sbi.packed_nid = EROFS_PACKED_NID_UNALLOCATED;
+		inode->nid = sbi.packed_nid;
+	}
+
+	ret = erofs_write_compressed_file(inode, fd);
+	if (ret == -ENOSPC) {
+		lseek(fd, 0, SEEK_SET);
+		ret = write_uncompressed_file_from_fd(inode, fd);
+	}
+
+	if (ret) {
+		DBG_BUGON(ret == -ENOSPC);
+		return ERR_PTR(ret);
+	}
+	erofs_prepare_inode_buffer(inode);
+	erofs_write_tail_end(inode);
+	return inode;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index 594ecf9..bbca7b9 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -23,6 +23,7 @@
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
 #include "erofs/blobchunk.h"
+#include "erofs/fragments.h"
 #include "../lib/liberofs_private.h"
 
 #ifdef HAVE_LIBUUID
@@ -133,9 +134,9 @@ static int parse_extended_opts(const char *opts)
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
@@ -202,6 +203,23 @@ static int parse_extended_opts(const char *opts)
 				return -EINVAL;
 			cfg.c_ztailpacking = true;
 		}
+
+		if (MATCH_EXTENTED_OPT("fragments", token, keylen)) {
+			char *endptr;
+			u64 i;
+
+			cfg.c_fragments = true;
+			if (vallen) {
+				i = strtoull(value, &endptr, 0);
+				if (endptr - value != vallen ||
+				    i < EROFS_BLKSIZ || i % EROFS_BLKSIZ) {
+					erofs_err("invalid pcluster size for the packed file %s",
+						  next);
+					return -EINVAL;
+				}
+				cfg.c_pclusterblks_packed = i / EROFS_BLKSIZ;
+			}
+		}
 	}
 	return 0;
 }
@@ -458,7 +476,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 
 int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 				  erofs_nid_t root_nid,
-				  erofs_blk_t *blocks)
+				  erofs_blk_t *blocks,
+				  erofs_nid_t packed_nid)
 {
 	struct erofs_super_block sb = {
 		.magic     = cpu_to_le32(EROFS_SUPER_MAGIC_V1),
@@ -482,6 +501,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	*blocks         = erofs_mapbh(NULL);
 	sb.blocks       = cpu_to_le32(*blocks);
 	sb.root_nid     = cpu_to_le16(root_nid);
+	sb.packed_nid    = cpu_to_le64(packed_nid);
 	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
 
 	if (erofs_sb_has_compr_cfgs())
@@ -599,8 +619,8 @@ int main(int argc, char **argv)
 {
 	int err = 0;
 	struct erofs_buffer_head *sb_bh;
-	struct erofs_inode *root_inode;
-	erofs_nid_t root_nid;
+	struct erofs_inode *root_inode, *packed_inode;
+	erofs_nid_t root_nid, packed_nid;
 	struct stat64 st;
 	erofs_blk_t nblocks;
 	struct timeval t;
@@ -668,6 +688,17 @@ int main(int argc, char **argv)
 	erofs_show_config();
 	if (cfg.c_ztailpacking)
 		erofs_warn("EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
+	if (cfg.c_fragments) {
+		if (!cfg.c_pclusterblks_packed)
+			cfg.c_pclusterblks_packed = cfg.c_pclusterblks_def;
+
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
@@ -737,7 +768,20 @@ int main(int argc, char **argv)
 			goto exit;
 	}
 
-	err = erofs_mkfs_update_super_block(sb_bh, root_nid, &nblocks);
+	packed_nid = 0;
+	if (cfg.c_fragments && erofs_sb_has_fragments()) {
+		erofs_update_progressinfo("Handling packed_file ...");
+		packed_inode = erofs_mkfs_build_fragments();
+		if (IS_ERR(packed_inode)) {
+			err = PTR_ERR(packed_inode);
+			goto exit;
+		}
+		packed_nid = erofs_lookupnid(packed_inode);
+		erofs_iput(packed_inode);
+	}
+
+	err = erofs_mkfs_update_super_block(sb_bh, root_nid, &nblocks,
+					    packed_nid);
 	if (err)
 		goto exit;
 
@@ -759,6 +803,8 @@ exit:
 	erofs_cleanup_exclude_rules();
 	if (cfg.c_chunkbits)
 		erofs_blob_exit();
+	if (cfg.c_fragments)
+		erofs_fragments_exit();
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.24.4

