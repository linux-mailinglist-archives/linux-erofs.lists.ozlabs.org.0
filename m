Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF4C5AE6D5
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Sep 2022 13:46:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MMNrn1z9Gz30Dp
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Sep 2022 21:46:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=ziyangzhang@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MMNrg30KJz3bk9
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Sep 2022 21:46:26 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VOrDaR4_1662464480;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VOrDaR4_1662464480)
          by smtp.aliyun-inc.com;
          Tue, 06 Sep 2022 19:41:21 +0800
From: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/4] erofs-utils: mkfs: introduce global compressed data deduplication
Date: Tue,  6 Sep 2022 19:40:57 +0800
Message-Id: <20220906114057.151445-4-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220906114057.151445-1-ZiyangZhang@linux.alibaba.com>
References: <20220906114057.151445-1-ZiyangZhang@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>

This patch introduces global compressed data deduplication to
reuse potential prefixes for each pcluster.

It also uses rolling hashing and shortens the previous compressed
extent in order to explore more possibilities for deduplication.

Co-developped-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
---
 include/erofs/config.h |   1 +
 include/erofs/dedupe.h |  39 +++++++++
 lib/Makefile.am        |   4 +-
 lib/compress.c         | 112 +++++++++++++++++++++-----
 lib/dedupe.c           | 174 +++++++++++++++++++++++++++++++++++++++++
 lib/rolling_hash.h     |  60 ++++++++++++++
 mkfs/main.c            |  19 +++++
 7 files changed, 387 insertions(+), 22 deletions(-)
 create mode 100644 include/erofs/dedupe.h
 create mode 100644 lib/dedupe.c
 create mode 100644 lib/rolling_hash.h

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 539d813..6f94183 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -44,6 +44,7 @@ struct erofs_configure {
 	char c_chunkbits;
 	bool c_noinline_data;
 	bool c_ztailpacking;
+	bool c_dedupe;
 	bool c_ignore_mtime;
 	bool c_showprogress;
 
diff --git a/include/erofs/dedupe.h b/include/erofs/dedupe.h
new file mode 100644
index 0000000..153bd4c
--- /dev/null
+++ b/include/erofs/dedupe.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2022 Alibaba Cloud
+ */
+#ifndef __EROFS_DEDUPE_H
+#define __EROFS_DEDUPE_H
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+#include "internal.h"
+
+struct z_erofs_inmem_extent {
+	erofs_blk_t blkaddr;
+	unsigned int compressedblks;
+	unsigned int length;
+	bool raw, partial;
+};
+
+struct z_erofs_dedupe_ctx {
+	u8		*start, *end;
+	u8		*cur;
+	struct z_erofs_inmem_extent	e;
+};
+
+int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx);
+int z_erofs_dedupe_insert(struct z_erofs_inmem_extent *e,
+			  void *original_data);
+void z_erofs_dedupe_commit(bool drop);
+int z_erofs_dedupe_init(unsigned int wsiz);
+void z_erofs_dedupe_exit(void);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index b92adee..8bf29d9 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -27,7 +27,9 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
-		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c rb_tree.c
+		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c rb_tree.c \
+		      dedupe.c
+
 liberofs_la_CFLAGS = -Wall -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/compress.c b/lib/compress.c
index 3c1d9db..bdb6e78 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -15,6 +15,7 @@
 #include "erofs/io.h"
 #include "erofs/cache.h"
 #include "erofs/compress.h"
+#include "erofs/dedupe.h"
 #include "compressor.h"
 #include "erofs/block_list.h"
 #include "erofs/compress_hints.h"
@@ -22,13 +23,6 @@
 static struct erofs_compress compresshandle;
 static unsigned int algorithmtype[2];
 
-struct z_erofs_inmem_extent {
-	erofs_blk_t blkaddr;
-	unsigned int compressedblks;
-	unsigned int length;
-	bool raw;
-};
-
 struct z_erofs_vle_compress_ctx {
 	u8 queue[EROFS_CONFIG_COMPR_MAX_SZ * 2];
 	struct z_erofs_inmem_extent e;	/* (lookahead) extent */
@@ -72,9 +66,12 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 	unsigned int count = ctx->e.length;
 	unsigned int d0 = 0, d1 = (clusterofs + count) / EROFS_BLKSIZ;
 	struct z_erofs_vle_decompressed_index di;
-	unsigned int type;
-	__le16 advise;
+	unsigned int type, advise;
 
+	if (!count)
+		return;
+
+	ctx->e.length = 0;	/* mark as written first */
 	di.di_clusterofs = cpu_to_le16(ctx->clusterofs);
 
 	/* whether the tail-end (un)compressed block or not */
@@ -84,11 +81,12 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 		 * is well-compressed for !ztailpacking cases.
 		 */
 		DBG_BUGON(!ctx->e.raw && !cfg.c_ztailpacking);
+		DBG_BUGON(ctx->e.partial);
 		type = ctx->e.raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
 			Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
-		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
+		advise = type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT;
+		di.di_advise = cpu_to_le16(advise);
 
-		di.di_advise = advise;
 		di.di_u.blkaddr = cpu_to_le32(ctx->e.blkaddr);
 		memcpy(ctx->metacur, &di, sizeof(di));
 		ctx->metacur += sizeof(di);
@@ -99,6 +97,7 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 	}
 
 	do {
+		advise = 0;
 		/* XXX: big pcluster feature should be per-inode */
 		if (d0 == 1 && erofs_sb_has_big_pcluster()) {
 			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
@@ -129,9 +128,14 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 			type = ctx->e.raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
 				Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
 			di.di_u.blkaddr = cpu_to_le32(ctx->e.blkaddr);
+
+			if (ctx->e.partial) {
+				DBG_BUGON(ctx->e.raw);
+				advise |= Z_EROFS_VLE_DI_PARTIAL_REF;
+			}
 		}
-		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
-		di.di_advise = advise;
+		advise |= type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT;
+		di.di_advise = cpu_to_le16(advise);
 
 		memcpy(ctx->metacur, &di, sizeof(di));
 		ctx->metacur += sizeof(di);
@@ -146,6 +150,64 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 	ctx->clusterofs = clusterofs + count;
 }
 
+static int z_erofs_compress_dedupe(struct erofs_inode *inode,
+				   struct z_erofs_vle_compress_ctx *ctx,
+				   unsigned int *len)
+{
+	int ret = 0;
+
+	do {
+		struct z_erofs_dedupe_ctx dctx = {
+			.start = ctx->queue + ctx->head -
+				(ctx->e.length < EROFS_BLKSIZ ? 0 :
+					ctx->e.length - EROFS_BLKSIZ),
+			.end = ctx->queue + ctx->head + *len,
+			.cur = ctx->queue + ctx->head,
+		};
+		int delta;
+
+		if (z_erofs_dedupe_match(&dctx))
+			break;
+
+		/* fall back to noncompact indexes for deduplication */
+		inode->z_advise &= ~Z_EROFS_ADVISE_COMPACTED_2B;
+		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+
+		delta = ctx->queue + ctx->head - dctx.cur;
+		if (delta) {
+			DBG_BUGON(delta < 0);
+			DBG_BUGON(!ctx->e.length);
+			ctx->e.partial = true;
+			ctx->e.length -= delta;
+		}
+
+		erofs_dbg("Dedupe %u %scompressed data (delta %d) to %u of %u blocks",
+			  dctx.e.length, dctx.e.raw ? "un" : "",
+			  delta, dctx.e.blkaddr, dctx.e.compressedblks);
+		z_erofs_write_indexes(ctx);
+		ctx->e = dctx.e;
+		ctx->head += dctx.e.length - delta;
+		DBG_BUGON(*len < dctx.e.length - delta);
+		*len -= dctx.e.length - delta;
+
+		if (ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
+			const unsigned int qh_aligned =
+				round_down(ctx->head, EROFS_BLKSIZ);
+			const unsigned int qh_after = ctx->head - qh_aligned;
+
+			memmove(ctx->queue, ctx->queue + qh_aligned,
+				*len + qh_after);
+			ctx->head = qh_after;
+			ctx->tail = qh_after + *len;
+			ret = -EAGAIN;
+			break;
+		}
+	} while (*len);
+
+	z_erofs_write_indexes(ctx);
+	return ret;
+}
+
 static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
 				     unsigned int *len, char *dst)
 {
@@ -244,8 +306,11 @@ static int vle_compress_one(struct erofs_inode *inode,
 			z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
 		bool may_inline = (cfg.c_ztailpacking && final);
 
+		if (z_erofs_compress_dedupe(inode, ctx, &len) && !final)
+			break;
+
 		if (len <= pclustersize) {
-			if (!final)
+			if (!final || !len)
 				break;
 			if (!may_inline && len <= EROFS_BLKSIZ)
 				goto nocompression;
@@ -263,13 +328,15 @@ static int vle_compress_one(struct erofs_inode *inode,
 					  erofs_strerror(ret));
 			}
 
-			if (may_inline && len < EROFS_BLKSIZ)
+			if (may_inline && len < EROFS_BLKSIZ) {
 				ret = z_erofs_fill_inline_data(inode,
 						ctx->queue + ctx->head,
 						len, true);
-			else
+			} else {
+				may_inline = false;
 nocompression:
 				ret = write_uncompressed_extent(ctx, &len, dst);
+			}
 
 			if (ret < 0)
 				return ret;
@@ -330,11 +397,13 @@ nocompression:
 			if (ret)
 				return ret;
 			ctx->e.raw = false;
+			may_inline = false;
 		}
-		/* write indexes for this pcluster */
+		ctx->e.partial = false;
 		ctx->e.blkaddr = ctx->blkaddr;
-		z_erofs_write_indexes(ctx);
-
+		if (!may_inline)
+			(void)z_erofs_dedupe_insert(&ctx->e,
+						    ctx->queue + ctx->head);
 		ctx->blkaddr += ctx->e.compressedblks;
 		ctx->head += ctx->e.length;
 		len -= ctx->e.length;
@@ -688,22 +757,23 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	DBG_BUGON(compressed_blocks < !!inode->idata_size);
 	compressed_blocks -= !!inode->idata_size;
 
+	z_erofs_write_indexes(&ctx);
 	z_erofs_write_indexes_final(&ctx);
 	legacymetasize = ctx.metacur - compressmeta;
 	/* estimate if data compression saves space or not */
 	if (compressed_blocks * EROFS_BLKSIZ + inode->idata_size +
 	    legacymetasize >= inode->i_size) {
+		z_erofs_dedupe_commit(true);
 		ret = -ENOSPC;
 		goto err_free_idata;
 	}
+	z_erofs_dedupe_commit(false);
 	z_erofs_write_mapheader(inode, compressmeta);
 
 	close(fd);
 	if (compressed_blocks) {
 		ret = erofs_bh_balloon(bh, blknr_to_addr(compressed_blocks));
 		DBG_BUGON(ret != EROFS_BLKSIZ);
-	} else {
-		DBG_BUGON(!inode->idata_size);
 	}
 
 	erofs_info("compressed %s (%llu bytes) into %u blocks",
diff --git a/lib/dedupe.c b/lib/dedupe.c
new file mode 100644
index 0000000..c53a64e
--- /dev/null
+++ b/lib/dedupe.c
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2022 Alibaba Cloud
+ */
+#include "erofs/dedupe.h"
+#include "erofs/print.h"
+#include "rb_tree.h"
+#include "rolling_hash.h"
+
+void erofs_sha256(const unsigned char *in, unsigned long in_size,
+		  unsigned char out[32]);
+
+static unsigned int window_size, rollinghash_rm;
+static struct rb_tree *dedupe_tree, *dedupe_subtree;
+
+struct z_erofs_dedupe_item {
+	long long	hash;
+	u8		prefix_sha256[32];
+
+	erofs_blk_t	compressed_blkaddr;
+	unsigned int	compressed_blks;
+
+	int		original_length;
+	bool		partial;
+	u8		extra_data[];
+};
+
+static int z_erofs_dedupe_rbtree_cmp(struct rb_tree *self,
+		struct rb_node *node_a, struct rb_node *node_b)
+{
+	struct z_erofs_dedupe_item *e_a = node_a->value;
+	struct z_erofs_dedupe_item *e_b = node_b->value;
+
+	return (e_a->hash > e_b->hash) - (e_a->hash < e_b->hash);
+}
+
+int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *ctx)
+{
+	struct z_erofs_dedupe_item e_find;
+	u8 *cur;
+	bool initial = true;
+
+	if (!dedupe_tree)
+		return -ENOENT;
+
+	if (ctx->cur > ctx->end - window_size)
+		cur = ctx->end - window_size;
+	else
+		cur = ctx->cur;
+
+	/* move backward byte-by-byte */
+	for (; cur >= ctx->start; --cur) {
+		struct z_erofs_dedupe_item *e;
+		unsigned int extra;
+		u8 sha256[32];
+
+		if (initial) {
+			/* initial try */
+			e_find.hash = erofs_rolling_hash_init(cur, window_size, true);
+			initial = false;
+		} else {
+			e_find.hash = erofs_rolling_hash_advance(e_find.hash,
+				rollinghash_rm, cur[window_size], cur[0]);
+		}
+
+		e = rb_tree_find(dedupe_tree, &e_find);
+		if (!e) {
+			e = rb_tree_find(dedupe_subtree, &e_find);
+			if (!e)
+				continue;
+		}
+
+		erofs_sha256(cur, window_size, sha256);
+		if (memcmp(sha256, e->prefix_sha256, sizeof(sha256)))
+			continue;
+
+		extra = 0;
+		while (cur + window_size + extra < ctx->end &&
+		       window_size + extra < e->original_length &&
+		       e->extra_data[extra] == cur[window_size + extra])
+			++extra;
+
+		if (window_size + extra <= ctx->cur - cur)
+			continue;
+		ctx->cur = cur;
+		ctx->e.length = window_size + extra;
+		ctx->e.partial = e->partial ||
+			(window_size + extra < e->original_length);
+		ctx->e.blkaddr = e->compressed_blkaddr;
+		ctx->e.compressedblks = e->compressed_blks;
+		return 0;
+	}
+	return -ENOENT;
+}
+
+int z_erofs_dedupe_insert(struct z_erofs_inmem_extent *e,
+			  void *original_data)
+{
+	struct z_erofs_dedupe_item *di;
+
+	if (e->length < window_size)
+		return 0;
+
+	di = malloc(sizeof(*di) + e->length - window_size);
+	if (!di)
+		return -ENOMEM;
+
+	di->original_length = e->length;
+	erofs_sha256(original_data, window_size, di->prefix_sha256);
+	di->hash = erofs_rolling_hash_init(original_data,
+			window_size, true);
+	memcpy(di->extra_data, original_data + window_size,
+	       e->length - window_size);
+	di->compressed_blkaddr = e->blkaddr;
+	di->compressed_blks = e->compressedblks;
+	di->partial = e->partial;
+
+	/* with the same rolling hash */
+	if (!rb_tree_insert(dedupe_subtree, di))
+		free(di);
+	return 0;
+}
+
+static void z_erofs_dedupe_node_free_cb(struct rb_tree *self,
+					struct rb_node *node)
+{
+	free(node->value);
+	rb_tree_node_dealloc_cb(self, node);
+}
+
+void z_erofs_dedupe_commit(bool drop)
+{
+	if (!dedupe_subtree)
+		return;
+	if (!drop) {
+		struct rb_iter iter;
+		struct z_erofs_dedupe_item *di;
+
+		di = rb_iter_first(&iter, dedupe_subtree);
+		while (di) {
+			if (!rb_tree_insert(dedupe_tree, di))
+				DBG_BUGON(1);
+			di = rb_iter_next(&iter);
+		}
+		/*rb_iter_dealloc(iter);*/
+		rb_tree_dealloc(dedupe_subtree, rb_tree_node_dealloc_cb);
+	} else {
+		rb_tree_dealloc(dedupe_subtree, z_erofs_dedupe_node_free_cb);
+	}
+	dedupe_subtree = rb_tree_create(z_erofs_dedupe_rbtree_cmp);
+}
+
+int z_erofs_dedupe_init(unsigned int wsiz)
+{
+	dedupe_tree = rb_tree_create(z_erofs_dedupe_rbtree_cmp);
+	if (!dedupe_tree)
+		return -ENOMEM;
+
+	dedupe_subtree = rb_tree_create(z_erofs_dedupe_rbtree_cmp);
+	if (!dedupe_subtree) {
+		rb_tree_dealloc(dedupe_subtree, NULL);
+		return -ENOMEM;
+	}
+	window_size = wsiz;
+	rollinghash_rm = erofs_rollinghash_calc_rm(window_size);
+	return 0;
+}
+
+void z_erofs_dedupe_exit(void)
+{
+	z_erofs_dedupe_commit(true);
+	rb_tree_dealloc(dedupe_subtree, NULL);
+	rb_tree_dealloc(dedupe_tree, z_erofs_dedupe_node_free_cb);
+}
diff --git a/lib/rolling_hash.h b/lib/rolling_hash.h
new file mode 100644
index 0000000..448db34
--- /dev/null
+++ b/lib/rolling_hash.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * Copyright (C) 2022 Alibaba Cloud
+ */
+#ifndef __ROLLING_HASH_H__
+#define __ROLLING_HASH_H__
+
+#include <erofs/defs.h>
+
+#define PRIME_NUMBER	4294967295LL
+#define RADIX		256
+
+static inline long long erofs_rolling_hash_init(u8 *input,
+						int len, bool backwards)
+{
+	long long hash = 0;
+
+	if (!backwards) {
+		int i;
+
+		for (i = 0; i < len; ++i)
+			hash = (RADIX * hash + input[i]) % PRIME_NUMBER;
+	} else {
+		while (len)
+			hash = (RADIX * hash + input[--len]) % PRIME_NUMBER;
+	}
+	return hash;
+}
+
+/* RM = R ^ (M-1) % Q */
+/*
+ * NOTE: value of "hash" could be negative so we cannot use unsiged types for "hash"
+ * "long long" is used here and PRIME_NUMBER can be ULONG_MAX
+ */
+static inline long long erofs_rolling_hash_advance(long long old_hash,
+						   unsigned long long RM,
+						   u8 to_remove, u8 to_add)
+{
+	long long hash = old_hash;
+	long long to_remove_val = (to_remove * RM) % PRIME_NUMBER;
+
+	hash = RADIX * (old_hash - to_remove_val) % PRIME_NUMBER;
+	hash = (hash + to_add) % PRIME_NUMBER;
+
+	/* We might get negative value of hash, converting it to positive */
+	if (hash < 0)
+		hash += PRIME_NUMBER;
+	return hash;
+}
+
+static inline long long erofs_rollinghash_calc_rm(int window_size)
+{
+	int i;
+	long long RM = 1;
+
+	for (i = 0; i < window_size - 1; ++i)
+		RM = (RM * RADIX) % PRIME_NUMBER;
+	return RM;
+}
+#endif
diff --git a/mkfs/main.c b/mkfs/main.c
index b969b35..deba5ec 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -18,6 +18,7 @@
 #include "erofs/inode.h"
 #include "erofs/io.h"
 #include "erofs/compress.h"
+#include "erofs/dedupe.h"
 #include "erofs/xattr.h"
 #include "erofs/exclude.h"
 #include "erofs/block_list.h"
@@ -202,6 +203,12 @@ static int parse_extended_opts(const char *opts)
 				return -EINVAL;
 			cfg.c_ztailpacking = true;
 		}
+
+		if (MATCH_EXTENTED_OPT("dedupe", token, keylen)) {
+			if (vallen)
+				return -EINVAL;
+			cfg.c_dedupe = true;
+		}
 	}
 	return 0;
 }
@@ -670,6 +677,8 @@ int main(int argc, char **argv)
 		erofs_warn("EXPERIMENTAL chunked file feature in use. Use at your own risk!");
 	if (cfg.c_ztailpacking)
 		erofs_warn("EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
+	if (cfg.c_dedupe)
+		erofs_warn("EXPERIMENTAL data deduplication feature in use. Use at your own risk!");
 	erofs_set_fs_root(cfg.c_src_path);
 #ifndef NDEBUG
 	if (cfg.c_random_pclusterblks)
@@ -696,6 +705,15 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
+	if (cfg.c_dedupe) {
+		err = z_erofs_dedupe_init(EROFS_BLKSIZ);
+		if (err) {
+			erofs_err("failed to initialize deduplication: %s",
+				  erofs_strerror(err));
+			goto exit;
+		}
+	}
+
 	err = z_erofs_compress_init(sb_bh);
 	if (err) {
 		erofs_err("failed to initialize compressor: %s",
@@ -753,6 +771,7 @@ int main(int argc, char **argv)
 		err = erofs_mkfs_superblock_csum_set();
 exit:
 	z_erofs_compress_exit();
+	z_erofs_dedupe_exit();
 #ifdef WITH_ANDROID
 	erofs_droid_blocklist_fclose();
 #endif
-- 
2.27.0

