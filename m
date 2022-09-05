Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670355AC8E6
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Sep 2022 04:52:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MLY311Sx1z2yy6
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Sep 2022 12:52:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=XG8taRqk;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=XG8taRqk;
	dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MLY2s37pvz2xr1
	for <linux-erofs@lists.ozlabs.org>; Mon,  5 Sep 2022 12:52:21 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so3436977pjl.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 04 Sep 2022 19:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=zw0W6XowJj8TB87FcUr1gi3wwWeIpPM80/DNE/G5Axc=;
        b=XG8taRqkof+QWY9SLvfdgtHFg9FfzdjSGGfoa/6bL+YFaMeAVVm7FlIbiQOF79n/pv
         58Hg9qtuvlpoVxzY21fdrL+dOb2coPKiaj6U6Jjih+hJw78VF6lrP+sMz4Euum2M2pDv
         +nZQ7IdMoKCI2cJvPX4sqULixuYQJv7UGEU7EEwufkcY9+RSEdveC3vT6BamhyUyx6Zq
         SpNKcweEBL71CoLUSuvXtBdBDTyumG7L7nxlndiz3KPzNW54qKOPCg/KDYq4hTTqZuD8
         VD5GB+xLNilrEJf9fYf4b2s4CIApP0njnfXLJWrNjmwKQqja5oHk5FL1Y4jRu23K7wtY
         FmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=zw0W6XowJj8TB87FcUr1gi3wwWeIpPM80/DNE/G5Axc=;
        b=Tp3RzR/5GevQPQq3MA1g+1PNuu209u73ZBO/3WOCmW3Z4M0+TMCjhGwFyXXYYRUQJf
         I1aPa2vSfQi57o/0rHHfRtan+EhmJPwj3opqIpIxf5cjTAt8HZak8kW963T7wzcw15g+
         dFl7PKSy6WvgMsW3+9aA+20OjCu/yBz5H4/Kf20muCvC+wJ5JZk2PMPNS22o9lVaKwYf
         35tj6bByPY31mianTjY1soK3xhGuaD5vu2rAaAyJBR3HH/q0ww/WoDqsey+B6fuIqzm4
         zO/ndK+fSzGAvwR+IkKzfdjyEKoFssqRK4h6dAuZ4hyCoBg2PLhGvlZdOUrcTMP9fi4/
         PY9A==
X-Gm-Message-State: ACgBeo2jHEj5jNm1nR9sIDQ1CENzPripn1gIR6bg4H2seTRunpOCcCa4
	4zLYaSh9iS3sBfWQF0tjShu1t8qhdf8=
X-Google-Smtp-Source: AA6agR4n/PxUAAbQyP9T71S3YkiWM9F8eJCNtbb7c/vp5NyJMGDl1p3CSb1nnfhjobZYJbHZqSFuKQ==
X-Received: by 2002:a17:903:518:b0:176:b7e9:d9da with SMTP id jn24-20020a170903051800b00176b7e9d9damr705693plb.48.1662346338586;
        Sun, 04 Sep 2022 19:52:18 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id i194-20020a6287cb000000b0053788e9f865sm6378729pfe.21.2022.09.04.19.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 19:52:18 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v6 4/4] erofs-utils: mkfs: introduce compressed fragments support
Date: Mon,  5 Sep 2022 10:51:47 +0800
Message-Id: <ce727546abf581a61e53f6ea9369f8cc024bc4e4.1662345408.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <5a6077e3e3745ae80f2a0fc13444898e86cc838d.1662345408.git.huyue2@coolpad.com>
References: <5a6077e3e3745ae80f2a0fc13444898e86cc838d.1662345408.git.huyue2@coolpad.com>
In-Reply-To: <cover.1662345408.git.huyue2@coolpad.com>
References: <cover.1662345408.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com
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
v6: update due to change of patch 3/4.

 include/erofs/compress.h  |  2 +-
 include/erofs/config.h    |  3 +-
 include/erofs/fragments.h | 25 ++++++++++++++
 include/erofs/inode.h     |  1 +
 include/erofs/internal.h  |  2 ++
 lib/Makefile.am           |  4 ++-
 lib/compress.c            | 70 +++++++++++++++++++++++++++++----------
 lib/fragments.c           | 58 ++++++++++++++++++++++++++++++++
 lib/inode.c               | 47 +++++++++++++++++++++++---
 mkfs/main.c               | 61 ++++++++++++++++++++++++++++++----
 10 files changed, 241 insertions(+), 32 deletions(-)
 create mode 100644 include/erofs/fragments.h
 create mode 100644 lib/fragments.c

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 24f6204..fecc316 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -18,7 +18,7 @@ extern "C"
 #define EROFS_CONFIG_COMPR_MIN_SZ           (32   * 1024)
 
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
-int erofs_write_compressed_file(struct erofs_inode *inode);
+int erofs_write_compressed_file_from_fd(struct erofs_inode *inode, int fd);
 
 int z_erofs_compress_init(struct erofs_buffer_head *bh);
 int z_erofs_compress_exit(void);
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
index 0000000..913aa99
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
index 58590ed..30ac23d 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -212,6 +212,8 @@ struct erofs_inode {
 	uint64_t capabilities;
 #endif
 	erofs_off_t fragmentoff;
+	unsigned int fragment_size;
+	bool is_packed_inode;
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
index 4bd4e6b..899cdb8 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -18,6 +18,7 @@
 #include "compressor.h"
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
+#include "erofs/fragments.h"
 
 static struct erofs_compress compresshandle;
 static unsigned int algorithmtype[2];
@@ -160,7 +161,12 @@ static int write_uncompressed_extent(struct erofs_inode *inode,
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
@@ -178,6 +184,8 @@ static int write_uncompressed_extent(struct erofs_inode *inode,
 
 static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode)
 {
+	if (cfg.c_fragments && inode->is_packed_inode)
+		return cfg.c_pclusterblks_packed;
 #ifndef NDEBUG
 	if (cfg.c_random_pclusterblks)
 		return 1 + rand() % cfg.c_pclusterblks_max;
@@ -246,11 +254,17 @@ static int vle_compress_one(struct erofs_inode *inode,
 		unsigned int pclustersize =
 			z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
 		bool may_inline = (cfg.c_ztailpacking && final);
+		bool may_packing = (cfg.c_fragments && final &&
+				   !inode->is_packed_inode);
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
@@ -265,7 +279,6 @@ static int vle_compress_one(struct erofs_inode *inode,
 					  inode->i_srcpath,
 					  erofs_strerror(ret));
 			}
-
 			if (may_inline && len < EROFS_BLKSIZ)
 				ret = z_erofs_fill_inline_data(inode,
 						ctx->queue + ctx->head,
@@ -304,6 +317,19 @@ nocompression:
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
+			ctx->compressedblks = 0;
+			raw = true;
 		} else {
 			unsigned int tailused, padding;
 
@@ -556,13 +582,20 @@ static void z_erofs_write_mapheader(struct erofs_inode *inode,
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
@@ -615,30 +648,24 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
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
@@ -659,6 +686,9 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	inode->z_algorithmtype[1] = algorithmtype[1];
 	inode->z_logical_clusterbits = LOG_BLOCK_SIZE;
 
+	inode->idata_size = 0;
+	inode->fragment_size = 0;
+
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.blkaddr = blkaddr;
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
@@ -692,19 +722,20 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	vle_write_indexes_final(&ctx);
 	legacymetasize = ctx.metacur - compressmeta;
 	/* estimate if data compression saves space or not */
-	if (compressed_blocks * EROFS_BLKSIZ + inode->idata_size +
+	if (!inode->fragment_size && !inode->is_packed_inode &&
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
@@ -727,7 +758,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 		DBG_BUGON(ret);
 	}
 	inode->compressmeta = compressmeta;
-	erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
+	if (!inode->is_packed_inode)
+		erofs_droid_blocklist_write(inode, blkaddr, compressed_blocks);
 	return 0;
 
 err_free_idata:
@@ -737,8 +769,6 @@ err_free_idata:
 	}
 err_bdrop:
 	erofs_bdrop(bh, true);	/* revoke buffer */
-err_close:
-	close(fd);
 err_free_meta:
 	free(compressmeta);
 	return ret;
@@ -852,6 +882,10 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
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
index 0000000..73c0d1b
--- /dev/null
+++ b/lib/fragments.c
@@ -0,0 +1,58 @@
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
+						"packed_file");
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
index 4da28b3..bf37919 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -423,8 +423,13 @@ int erofs_write_file(struct erofs_inode *inode)
 		return erofs_blob_write_chunked_file(inode);
 	}
 
+
 	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
-		ret = erofs_write_compressed_file(inode);
+		fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
+		if (fd < 0)
+			return -errno;
+		ret = erofs_write_compressed_file_from_fd(inode, fd);
+		close(fd);
 
 		if (!ret || ret != -ENOSPC)
 			return ret;
@@ -844,9 +849,8 @@ static int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 }
 #endif
 
-static int erofs_fill_inode(struct erofs_inode *inode,
-			    struct stat64 *st,
-			    const char *path)
+static int erofs_fill_inode(struct erofs_inode *inode, struct stat64 *st,
+			    const char *path, bool is_src)
 {
 	int err = erofs_droid_inode_fsconfig(inode, st, path);
 
@@ -898,6 +902,7 @@ static int erofs_fill_inode(struct erofs_inode *inode,
 
 	strncpy(inode->i_srcpath, path, sizeof(inode->i_srcpath) - 1);
 	inode->i_srcpath[sizeof(inode->i_srcpath) - 1] = '\0';
+	inode->is_packed_inode = !is_src;
 
 	inode->dev = st->st_dev;
 	inode->i_ino[1] = st->st_ino;
@@ -966,7 +971,7 @@ static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
 	if (IS_ERR(inode))
 		return inode;
 
-	ret = erofs_fill_inode(inode, &st, path);
+	ret = erofs_fill_inode(inode, &st, path, is_src);
 	if (ret) {
 		free(inode);
 		return ERR_PTR(ret);
@@ -1180,3 +1185,35 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
 
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
+	ret = erofs_fill_inode(inode, &st, name, false);
+	if (ret) {
+		free(inode);
+		return ERR_PTR(ret);
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

