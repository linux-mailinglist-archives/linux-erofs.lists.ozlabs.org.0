Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 567425B6C04
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 12:55:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MRgP53j8tz3blb
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 20:55:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Pe0M4WhT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Pe0M4WhT;
	dkim-atps=neutral
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MRgNv3fJjz3bpW
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 20:55:42 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id w2so1108924pfb.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 03:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=gmP9qZDRoe7S/mUFQ8SztinUYSZalmhXt0fGGGiuifM=;
        b=Pe0M4WhTSPopoGGLwyn/K8k72udc3oXCtOd6hEvS0640w8RLGznje8ZjMUGRm3sOsL
         WDbqTuSPT5QyNAisMWY9GHtg3TaZ/K6FUqmpbFXtgQ1RsM0hxfWa3l/Dg72/2q+nM5b8
         qXrhC8A6cwvbUVIusmviVdJHLg1BleqDvatK0S67syIa49L4+KlLwP7xtas+K+ibxl1m
         b924JLkLVXvBh3JZFuYIAeP7CRNoR88uSqyTSN5IL3ICVkcMjra/bl/NfUGMGDb+FC+N
         MFc+m2ClkAdU7adkIS2vFGZwW63Un9gqYOnRPCCJwrHBwIwwVkNb70+5HhG85mg/oL+/
         yTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=gmP9qZDRoe7S/mUFQ8SztinUYSZalmhXt0fGGGiuifM=;
        b=2DrTtyeDOhk1wNgOK6Qy4JrSVHZADD/LsENyudqCBvxhXI56bnRz9L66EcieMpUMU6
         Zx8EyYUg59l1IByZMg4Rr/JQU+auLPsLXyPlQ1IWgwVVvvbvnEXrwSHujXwGjrFT341K
         +ZzxKZEuL/jObXu/VFVXgL9HKBShmi5SaLocLvqmA7F3/aQS40yyyfMjb2D/nuyMP8R5
         ZKL3FcqkILGphvOhI4ir7c9AIfrO+q4HYwKPG1LHWlo2IgTBGb4cwi7zJNXsir/CiPQ/
         T1mwJm063dQqqv6BY6E14X4+EpxaV74J8na/jecMqQleVeTRBMRaZBrusjOg3+GZYg0V
         AUdg==
X-Gm-Message-State: ACgBeo0Jq8kzWSBCNZFUygCzkASq+6X0V713vYx4A0CYqX2J0YKWjLyj
	I/zksu1JgoINv4turHghnOOPyr7PGfs=
X-Google-Smtp-Source: AA6agR6NdvXOgXqgfPOLZAbNYx0fpyTlbmIF2ZsTdSLBMtMSlarwJF/K+g6QIvU1qYFeRiDZoNpNDA==
X-Received: by 2002:a05:6a00:24c2:b0:52e:7181:a8a0 with SMTP id d2-20020a056a0024c200b0052e7181a8a0mr32469924pfv.57.1663066540348;
        Tue, 13 Sep 2022 03:55:40 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id g17-20020aa796b1000000b0054097cb2da6sm7475290pfk.38.2022.09.13.03.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 03:55:40 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v8 4/4] erofs-utils: mkfs: introduce compressed fragments support
Date: Tue, 13 Sep 2022 18:54:49 +0800
Message-Id: <210e345672c9002d80a41ff63b67c6805998c844.1663065968.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663065968.git.huyue2@coolpad.com>
References: <cover.1663065968.git.huyue2@coolpad.com>
In-Reply-To: <cover.1663065968.git.huyue2@coolpad.com>
References: <cover.1663065968.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

This approach can merge tail pclusters or the whole files into a special
inode in order to achieve greater compression ratio. And an option of
pcluster size is provided for different compression requirments.

Also enable interlaced uncompressed data layout for compressed files at
the same time.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 include/erofs/compress.h  |  8 +++-
 include/erofs/config.h    |  3 +-
 include/erofs/fragments.h | 28 +++++++++++++
 include/erofs/inode.h     |  1 +
 include/erofs/internal.h  |  3 ++
 lib/Makefile.am           |  4 +-
 lib/compress.c            | 86 +++++++++++++++++++++++++++++----------
 lib/fragments.c           | 59 +++++++++++++++++++++++++++
 lib/inode.c               | 47 +++++++++++++++++++--
 mkfs/main.c               | 61 ++++++++++++++++++++++++---
 10 files changed, 266 insertions(+), 34 deletions(-)
 create mode 100644 include/erofs/fragments.h
 create mode 100644 lib/fragments.c

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 24f6204..df542df 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -18,13 +18,19 @@ extern "C"
 #define EROFS_CONFIG_COMPR_MIN_SZ           (32   * 1024)
 
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
-int erofs_write_compressed_file(struct erofs_inode *inode);
+int erofs_write_compressed_file_from_fd(struct erofs_inode *inode, int fd);
 
 int z_erofs_compress_init(struct erofs_buffer_head *bh);
 int z_erofs_compress_exit(void);
 
 const char *z_erofs_list_available_compressors(unsigned int i);
 
+static inline bool is_packed_inode(struct erofs_inode *inode)
+{
+	return ((sbi.packed_nid > 0 && inode->nid == sbi.packed_nid) ||
+		inode->nid == EROFS_PACKED_NID_UNALLOCATED);
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
index 0000000..05a88da
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
+const char *frags_packedname;
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
index 742bfed..8abcfc6 100644
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
index 4bd4e6b..daba881 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -18,6 +18,7 @@
 #include "compressor.h"
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
+#include "erofs/fragments.h"
 
 static struct erofs_compress compresshandle;
 static unsigned int algorithmtype[2];
@@ -60,7 +61,7 @@ static void vle_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
 }
 
 static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
-			      unsigned int count, bool raw)
+			      unsigned int count, bool raw, u32 fragmentoff)
 {
 	unsigned int clusterofs = ctx->clusterofs;
 	unsigned int d0 = 0, d1 = (clusterofs + count) / EROFS_BLKSIZ;
@@ -82,7 +83,10 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
 
 		di.di_advise = advise;
-		di.di_u.blkaddr = cpu_to_le32(ctx->blkaddr);
+		if (cfg.c_legacy_compress && !ctx->compressedblks)
+			di.di_u.blkaddr = cpu_to_le32(fragmentoff);
+		else
+			di.di_u.blkaddr = cpu_to_le32(ctx->blkaddr);
 		memcpy(ctx->metacur, &di, sizeof(di));
 		ctx->metacur += sizeof(di);
 
@@ -121,7 +125,10 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 		} else {
 			type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
 				Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
-			di.di_u.blkaddr = cpu_to_le32(ctx->blkaddr);
+			if (cfg.c_legacy_compress && !ctx->compressedblks)
+				di.di_u.blkaddr = cpu_to_le32(fragmentoff);
+			else
+				di.di_u.blkaddr = cpu_to_le32(ctx->blkaddr);
 		}
 		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
 		di.di_advise = advise;
@@ -160,7 +167,12 @@ static int write_uncompressed_extent(struct erofs_inode *inode,
 	 * write uncompressed data from clusterofs which can benefit from
 	 * in-place I/O, loop shift right when to exceed EROFS_BLKSIZ.
 	 */
-	interlaced_offset = 0; /* will set it to clusterofs */
+	if (cfg.c_fragments && ctx->clusterofs) {
+		interlaced_offset = ctx->clusterofs;
+		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
+	} else {
+		interlaced_offset = 0;
+	}
 	rightpart = min(EROFS_BLKSIZ - interlaced_offset, count);
 
 	memset(dst, 0, EROFS_BLKSIZ);
@@ -178,6 +190,8 @@ static int write_uncompressed_extent(struct erofs_inode *inode,
 
 static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode)
 {
+	if (cfg.c_fragments && is_packed_inode(inode))
+		return cfg.c_pclusterblks_packed;
 #ifndef NDEBUG
 	if (cfg.c_random_pclusterblks)
 		return 1 + rand() % cfg.c_pclusterblks_max;
@@ -246,11 +260,17 @@ static int vle_compress_one(struct erofs_inode *inode,
 		unsigned int pclustersize =
 			z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
 		bool may_inline = (cfg.c_ztailpacking && final);
+		bool may_packing = (cfg.c_fragments && final &&
+				   !is_packed_inode(inode));
 		bool raw;
 
 		if (len <= pclustersize) {
 			if (!final)
 				break;
+			if (may_packing) {
+				count = len;
+				goto frag_packing;
+			}
 			if (!may_inline && len <= EROFS_BLKSIZ)
 				goto nocompression;
 		}
@@ -265,7 +285,6 @@ static int vle_compress_one(struct erofs_inode *inode,
 					  inode->i_srcpath,
 					  erofs_strerror(ret));
 			}
-
 			if (may_inline && len < EROFS_BLKSIZ)
 				ret = z_erofs_fill_inline_data(inode,
 						ctx->queue + ctx->head,
@@ -304,6 +323,19 @@ nocompression:
 				return ret;
 			ctx->compressedblks = 1;
 			raw = false;
+		} else if (may_packing && len == count && ret < pclustersize) {
+frag_packing:
+			ret = z_erofs_pack_fragments(inode,
+						     ctx->queue + ctx->head,
+						     len);
+			if (ret < 0)
+				return ret;
+			if (inode->i_size == inode->fragment_size) {
+				ctx->head += len;
+				return 0;
+			}
+			ctx->compressedblks = 0; /* indicate it's fragment */
+			raw = true;
 		} else {
 			unsigned int tailused, padding;
 
@@ -336,7 +368,7 @@ nocompression:
 
 		ctx->head += count;
 		/* write compression indexes for this pcluster */
-		vle_write_indexes(ctx, count, raw);
+		vle_write_indexes(ctx, count, raw, inode->fragmentoff >> 32);
 
 		ctx->blkaddr += ctx->compressedblks;
 		len -= count;
@@ -556,13 +588,22 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
 {
 	struct z_erofs_map_header h = {
 		.h_advise = cpu_to_le16(inode->z_advise),
-		.h_idata_size = cpu_to_le16(inode->idata_size),
 		.h_algorithmtype = inode->z_algorithmtype[1] << 4 |
 				   inode->z_algorithmtype[0],
 		/* lclustersize */
 		.h_clusterbits = inode->z_logical_clusterbits - 12,
 	};
 
+	if (!cfg.c_fragments) {
+		h.h_idata_size = cpu_to_le16(inode->idata_size);
+	} else if (inode->i_size && inode->i_size == inode->fragment_size) {
+		DBG_BUGON(inode->fragmentoff >> 63);
+		*(__le64 *)&h = cpu_to_le64(inode->fragmentoff);
+		h.h_clusterbits = 1 << Z_EROFS_FRAGMENT_INODE_BIT;
+	} else {
+		h.h_fragmentoff = cpu_to_le32(inode->fragmentoff);
+	}
+
 	memset(compressmeta, 0, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
 	/* write out map header */
 	memcpy(compressmeta, &h, sizeof(struct z_erofs_map_header));
@@ -615,30 +656,24 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 	inode->eof_tailraw = NULL;
 }
 
-int erofs_write_compressed_file(struct erofs_inode *inode)
+int erofs_write_compressed_file_from_fd(struct erofs_inode *inode, int fd)
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
@@ -659,6 +694,9 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	inode->z_algorithmtype[1] = algorithmtype[1];
 	inode->z_logical_clusterbits = LOG_BLOCK_SIZE;
 
+	inode->idata_size = 0;
+	inode->fragment_size = 0;
+
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.blkaddr = blkaddr;
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
@@ -692,19 +730,20 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	vle_write_indexes_final(&ctx);
 	legacymetasize = ctx.metacur - compressmeta;
 	/* estimate if data compression saves space or not */
-	if (compressed_blocks * EROFS_BLKSIZ + inode->idata_size +
+	if (!inode->fragment_size && !is_packed_inode(inode) &&
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
@@ -727,7 +766,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 		DBG_BUGON(ret);
 	}
 	inode->compressmeta = compressmeta;
-	erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
+	if (!is_packed_inode(inode))
+		erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
 	return 0;
 
 err_free_idata:
@@ -737,8 +777,6 @@ err_free_idata:
 	}
 err_bdrop:
 	erofs_bdrop(bh, true);	/* revoke buffer */
-err_close:
-	close(fd);
 err_free_meta:
 	free(compressmeta);
 	return ret;
@@ -852,6 +890,10 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
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
index 0000000..47c06a0
--- /dev/null
+++ b/lib/fragments.c
@@ -0,0 +1,59 @@
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
+
+	if (write(fileno(packedfile), data, len) < 0)
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
+	fseek(packedfile, 0, SEEK_SET);
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
index 4da28b3..43de1d0 100644
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
+		ret = erofs_write_compressed_file_from_fd(inode, fd);
+		close(fd);
 
 		if (!ret || ret != -ENOSPC)
 			return ret;
@@ -844,8 +849,7 @@ static int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 }
 #endif
 
-static int erofs_fill_inode(struct erofs_inode *inode,
-			    struct stat64 *st,
+static int erofs_fill_inode(struct erofs_inode *inode, struct stat64 *st,
 			    const char *path)
 {
 	int err = erofs_droid_inode_fsconfig(inode, st, path);
@@ -1180,3 +1184,40 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
 
 	return erofs_mkfs_build_tree(inode);
 }
+
+struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
+{
+	struct stat64 st;
+	struct erofs_inode *inode;
+	int ret;
+
+	ret = fstat64(fd, &st);
+	if (ret)
+		return ERR_PTR(-errno);
+
+	inode = erofs_new_inode();
+	if (IS_ERR(inode))
+		return inode;
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
+	/* only for compressed file now */
+	ret = erofs_write_compressed_file_from_fd(inode, fd);
+	if (ret) {
+		DBG_BUGON(ret == -ENOSPC);
+		return ERR_PTR(ret);
+	}
+
+	erofs_prepare_inode_buffer(inode);
+
+	return inode;
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index b969b35..adad0d7 100644
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
@@ -202,7 +203,31 @@ static int parse_extended_opts(const char *opts)
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
+			if ((*endptr != '\0' && *endptr != ',') ||
+			    i < EROFS_BLKSIZ || i % EROFS_BLKSIZ) {
+				erofs_err("invalid physical cluster size for the packed file %s",
+					  next);
+				return -EINVAL;
+			}
+			cfg.c_pclusterblks_packed = i / EROFS_BLKSIZ;
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
 
@@ -458,7 +483,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 
 int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 				  erofs_nid_t root_nid,
-				  erofs_blk_t *blocks)
+				  erofs_blk_t *blocks,
+				  erofs_nid_t packed_nid)
 {
 	struct erofs_super_block sb = {
 		.magic     = cpu_to_le32(EROFS_SUPER_MAGIC_V1),
@@ -482,6 +508,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	*blocks         = erofs_mapbh(NULL);
 	sb.blocks       = cpu_to_le32(*blocks);
 	sb.root_nid     = cpu_to_le16(root_nid);
+	sb.packed_nid    = cpu_to_le64(packed_nid);
 	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
 
 	if (erofs_sb_has_compr_cfgs())
@@ -599,8 +626,8 @@ int main(int argc, char **argv)
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
@@ -670,6 +697,14 @@ int main(int argc, char **argv)
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
@@ -739,7 +774,19 @@ int main(int argc, char **argv)
 			goto exit;
 	}
 
-	err = erofs_mkfs_update_super_block(sb_bh, root_nid, &nblocks);
+	packed_nid = 0;
+	if (cfg.c_fragments) {
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
 
@@ -761,6 +808,8 @@ exit:
 	erofs_cleanup_exclude_rules();
 	if (cfg.c_chunkbits)
 		erofs_blob_exit();
+	if (cfg.c_fragments)
+		erofs_fragments_exit();
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.17.1

