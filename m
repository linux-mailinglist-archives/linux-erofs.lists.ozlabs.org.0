Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2814A63EF30
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Dec 2022 12:17:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NND6z3zv6z3bY1
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Dec 2022 22:16:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=e6ORfOdx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=e6ORfOdx;
	dkim-atps=neutral
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NND6v6wWnz3bVs
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Dec 2022 22:16:55 +1100 (AEDT)
Received: by mail-pg1-x536.google.com with SMTP id s196so1395948pgs.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Dec 2022 03:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNJjbD2CshJvOlNjBZr86BZ5mWJi4zRqCWRVDv9yuAY=;
        b=e6ORfOdxmL3wdEbloh92DYb2UgS2YfXdJfZOT0cjFUOu16z7Kp7hBP+x9YEjSt8DDI
         xM6XYr1xBXhfzqTl9joolQzm9xRYEAEunNlTwrYcHDQcsXHnxLaf+8mAPBtd+9iPCEWl
         D5LXyZEnEfEIvGBtHSiXTeDzA7owqDV/d1Yje3N8Wgj5w4axhQ7d1NV2FJTg4aDta3kt
         F7sdTieF6qdwzCyDWoTxoHsmXku/lfTdu0CQVMXvWowrtVyBHxFCz8mwmxmlYZ4hHJKl
         vv7z/OB+UBVeyTAZXWTdGj0L4HePz4CaayuQEwCq00FAYPtYIcFHTyyFItWyGyhYqH0y
         dKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNJjbD2CshJvOlNjBZr86BZ5mWJi4zRqCWRVDv9yuAY=;
        b=3F/AF8MQV/MH9FKSDiRp0qAxhSz9g0sDGkOqsMrFdHgsesvzFKbA8LE0iCLsZX0v2o
         74Et5gSZdNXLylOX5e/T4WdRB3jHmFN/c7yCNaYcPph8LSjlVM5LkVHWFIhKConQcS69
         7O3gUMyg9X/lOFOy5ydz72Fv8iQjMXge0W7OHTYcMsb91McTx8puI3vr8QxyQWyeonpd
         0wljIF5RgIpDFJwxTRGYE0yHuLf9MNoWj+EAlj/bgAtQDMeX+IXMWd2GbE1GuvYWpvQk
         cIPo26PdX9r7tEOC8fPKGDVejvyZMQZ7hj4/JiacgjRWZKj8KMuXBOAVti0jZh3NOmQq
         90/g==
X-Gm-Message-State: ANoB5pmnWSFav+6EDuOxoMHkjEe864kicu/U8gpJlFzCsTj0XYUSCjbJ
	icri99WoOOJUxc3sseYeEiM8da1M5O4=
X-Google-Smtp-Source: AA0mqf6pMdh6IOK+46TF7WFw+91Dn9zm17burqDOuHvgME/NWXeN59I+znLX5n/jGvEJTZnVWv+ebA==
X-Received: by 2002:a63:117:0:b0:476:f43d:913e with SMTP id 23-20020a630117000000b00476f43d913emr40657275pgb.386.1669893411461;
        Thu, 01 Dec 2022 03:16:51 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id m16-20020a62a210000000b0056ba6952e40sm2933446pff.181.2022.12.01.03.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:16:50 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4] erofs-utils: mkfs: support fragment deduplication
Date: Thu,  1 Dec 2022 19:16:15 +0800
Message-Id: <20221201111615.9593-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
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

Previously, there's no fragment deduplication when this feature is
introduced. Let's support it now.

We intend to dedupe the fragments before compression, so that duplicate
parts will not be written into packed inode.

With this patch, for Linux 5.10.1 + 5.10.87 source code:

[before]
 32k pcluster + T0 + lz4hc,12 + fragment		450M
 64k pcluster + T0 + lz4hc,12 + fragment		434M
128k pcluster + T0 + lz4hc,12 + fragment		426M
 32k pcluster + T0 + lz4hc,12 + fragment + dedupe	368M
 64k pcluster + T0 + lz4hc,12 + fragment + dedupe	380M
128k pcluster + T0 + lz4hc,12 + fragment + dedupe	395M

[after]
 32k pcluster + T0 + lz4hc,12 + fragment		311M
 64k pcluster + T0 + lz4hc,12 + fragment		295M
128k pcluster + T0 + lz4hc,12 + fragment		287M
 32k pcluster + T0 + lz4hc,12 + fragment + dedupe	286M
 64k pcluster + T0 + lz4hc,12 + fragment + dedupe	281M
128k pcluster + T0 + lz4hc,12 + fragment + dedupe	278M

Tested on SquashFS (which uses level 12 by default for lz4hc):

 32k block + lz4hc		332M
 64k block + lz4hc		304M
128k block + lz4hc		283M
256k block + lz4hc		273M
256k block + lz4hc + noI	278M

Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v4:
- renaming include tofcrc/new_fragmentsize
- move fixup into ctx
- use may_fixing to check packing fragment or not
- move sb/inode flag + 64bits case from erofs_pack_fragments() to new
  helper erofs_fragments_commit()
- move recompress ahead of may_inline case when compressing succeeds
- update commit message/code comments
- note that decompress will fail when enable ztailpacking at the same
  time, need some time to debug

v3:
- modify acrroding to Xiang's comments in v2
- simplify the logic in vle_compress_one
- fix the crash for 1MB pcluster

v2: mainly improve the logic in compression

 include/erofs/fragments.h |   4 +-
 lib/compress.c            | 134 +++++++++++++++++++++-----
 lib/fragments.c           | 197 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 305 insertions(+), 30 deletions(-)

diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
index 5444384..e91fb31 100644
--- a/include/erofs/fragments.h
+++ b/include/erofs/fragments.h
@@ -15,8 +15,10 @@ extern "C"
 extern const char *frags_packedname;
 #define EROFS_PACKED_INODE	frags_packedname
 
+int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc_r);
 int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
-			   unsigned int len);
+			   unsigned int len, u32 tofcrc);
+void z_erofs_fragments_commit(struct erofs_inode *inode);
 struct erofs_inode *erofs_mkfs_build_fragments(void);
 int erofs_fragments_init(void);
 void erofs_fragments_exit(void);
diff --git a/lib/compress.c b/lib/compress.c
index 17b3213..afd6e8e 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -33,6 +33,11 @@ struct z_erofs_vle_compress_ctx {
 	unsigned int head, tail;
 	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
 	u16 clusterofs;
+
+	u32 tofcrc;
+	unsigned int pclustersize;
+	erofs_off_t remaining;
+	bool need_fix;
 };
 
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	\
@@ -162,10 +167,10 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
 	ctx->clusterofs = clusterofs + count;
 }
 
-static int z_erofs_compress_dedupe(struct erofs_inode *inode,
-				   struct z_erofs_vle_compress_ctx *ctx,
+static int z_erofs_compress_dedupe(struct z_erofs_vle_compress_ctx *ctx,
 				   unsigned int *len)
 {
+	struct erofs_inode *inode = ctx->inode;
 	int ret = 0;
 
 	do {
@@ -301,10 +306,6 @@ static void tryrecompress_trailing(void *in, unsigned int *insize,
 	unsigned int count;
 	int ret = *compressedsize;
 
-	/* no need to recompress */
-	if (!(ret & (EROFS_BLKSIZ - 1)))
-		return;
-
 	count = *insize;
 	ret = erofs_compress_destsize(&compresshandle,
 				      in, &count, (void *)tmp,
@@ -319,30 +320,69 @@ static void tryrecompress_trailing(void *in, unsigned int *insize,
 	*compressedsize = ret;
 }
 
-static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx,
-			    bool final)
+static void z_erofs_fragments_dedupe_update(struct z_erofs_vle_compress_ctx *ctx,
+					    unsigned int *len)
+{
+	struct erofs_inode *inode = ctx->inode;
+	const unsigned int new_fragmentsize = ctx->remaining + *len;
+
+	DBG_BUGON(!inode->fragment_size);
+
+	/* try to fix it again if it gets larger (should be rare) */
+	if (inode->fragment_size < new_fragmentsize) {
+		ctx->pclustersize =
+			roundup(new_fragmentsize - inode->fragment_size,
+				EROFS_BLKSIZ);
+		return;
+	}
+
+	inode->fragmentoff += inode->fragment_size - new_fragmentsize;
+	inode->fragment_size = new_fragmentsize;
+
+	erofs_dbg("Reducing fragment size to %u at %lu",
+		  inode->fragment_size, inode->fragmentoff);
+
+	/* it's ending */
+	ctx->head += new_fragmentsize;
+	ctx->remaining = 0;
+	*len = 0;
+}
+
+static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx)
 {
 	static char dstbuf[EROFS_CONFIG_COMPR_MAX_SZ + EROFS_BLKSIZ];
 	struct erofs_inode *inode = ctx->inode;
 	char *const dst = dstbuf + EROFS_BLKSIZ;
 	struct erofs_compress *const h = &compresshandle;
 	unsigned int len = ctx->tail - ctx->head;
+	bool final = !ctx->remaining;
 	int ret;
 
 	while (len) {
-		unsigned int pclustersize =
-			z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
 		bool may_inline = (cfg.c_ztailpacking && final);
 		bool may_packing = (cfg.c_fragments && final &&
 				   !erofs_is_packed_inode(inode));
+		bool may_fixing = ctx->need_fix;
 
-		if (z_erofs_compress_dedupe(inode, ctx, &len) && !final)
+		if (z_erofs_compress_dedupe(ctx, &len) && !final)
 			break;
 
-		if (len <= pclustersize) {
+		if (len <= ctx->pclustersize) {
+			if (may_fixing && !len) {
+				may_packing = false;
+				goto frag_nopacking;
+			}
 			if (!final || !len)
 				break;
 			if (may_packing) {
+				if (inode->fragment_size && !may_fixing) {
+					ctx->remaining = inode->fragment_size;
+					ctx->pclustersize =
+						roundup(len, EROFS_BLKSIZ);
+					ctx->e.length = 0;
+					ctx->need_fix = true;
+					break;
+				}
 				ctx->e.length = len;
 				goto frag_packing;
 			}
@@ -353,7 +393,7 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx,
 		ctx->e.length = min(len,
 				cfg.c_max_decompressed_extent_bytes);
 		ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
-				&ctx->e.length, dst, pclustersize,
+				&ctx->e.length, dst, ctx->pclustersize,
 				!(final && len == ctx->e.length));
 		if (ret <= 0) {
 			if (ret != -EAGAIN) {
@@ -385,15 +425,17 @@ nocompression:
 			ctx->e.compressedblks = 1;
 			ctx->e.raw = true;
 		} else if (may_packing && len == ctx->e.length &&
-			   ret < pclustersize) {
+			   ret < ctx->pclustersize && (!inode->fragment_size ||
+			   may_fixing)) {
 frag_packing:
 			ret = z_erofs_pack_fragments(inode,
 						     ctx->queue + ctx->head,
-						     len);
+						     len, ctx->tofcrc);
 			if (ret < 0)
 				return ret;
 			ctx->e.compressedblks = 0; /* indicate a fragment */
 			ctx->e.raw = true;
+			may_fixing = false;
 		/* tailpcluster should be less than 1 block */
 		} else if (may_inline && len == ctx->e.length &&
 			   ret < EROFS_BLKSIZ) {
@@ -415,7 +457,27 @@ frag_packing:
 		} else {
 			unsigned int tailused, padding;
 
-			if (may_inline && len == ctx->e.length)
+			tailused = ret & (EROFS_BLKSIZ - 1);
+			/*
+			 * If there's a space left for the last round when
+			 * deduping fragments, try to read fragment and
+			 * recompress a litte more to check whether it can be
+			 * filled up. Fix the fragment if succeeds. Otherwise,
+			 * just drop it and go to packing.
+			 */
+			if (may_packing && len == ctx->e.length && tailused &&
+			    ctx->tail < sizeof(ctx->queue)) {
+				DBG_BUGON(!inode->fragment_size);
+
+				ctx->remaining = inode->fragment_size;
+				ctx->pclustersize =
+					BLK_ROUND_UP(ret) * EROFS_BLKSIZ;
+				ctx->e.length = 0;
+				ctx->need_fix = true;
+				break;
+			}
+
+			if (may_inline && len == ctx->e.length && tailused)
 				tryrecompress_trailing(ctx->queue + ctx->head,
 						&ctx->e.length, dst, &ret);
 
@@ -454,6 +516,21 @@ frag_packing:
 		ctx->head += ctx->e.length;
 		len -= ctx->e.length;
 
+		if (may_fixing)
+			z_erofs_fragments_dedupe_update(ctx, &len);
+
+		/* generate a ctx for duplicate fragment */
+		if (final && !len && inode->fragment_size && !may_packing) {
+frag_nopacking:
+			z_erofs_write_indexes(ctx);
+
+			ctx->e.length = inode->fragment_size;
+			ctx->e.compressedblks = 0;
+			ctx->e.raw = true;
+			ctx->e.partial = false;
+			ctx->e.blkaddr = ctx->blkaddr;
+		}
+
 		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
 			const unsigned int qh_aligned =
 				round_down(ctx->head, EROFS_BLKSIZ);
@@ -736,7 +813,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 {
 	struct erofs_buffer_head *bh;
 	static struct z_erofs_vle_compress_ctx ctx;
-	erofs_off_t remaining;
 	erofs_blk_t blkaddr, compressed_blocks;
 	unsigned int legacymetasize;
 	int ret;
@@ -775,6 +851,16 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	inode->idata_size = 0;
 	inode->fragment_size = 0;
 
+	/*
+	 * Dedupe fragments before compression to avoid writing duplicate parts
+	 * into packed inode.
+	 */
+	if (cfg.c_fragments && !erofs_is_packed_inode(inode)) {
+		ret = z_erofs_fragments_dedupe(inode, fd, &ctx.tofcrc);
+		if (ret < 0)
+			goto err_bdrop;
+	}
+
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.inode = inode;
 	ctx.blkaddr = blkaddr;
@@ -782,10 +868,12 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	ctx.head = ctx.tail = 0;
 	ctx.clusterofs = 0;
 	ctx.e.length = 0;
-	remaining = inode->i_size;
+	ctx.pclustersize = z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
+	ctx.remaining = inode->i_size - inode->fragment_size;
+	ctx.need_fix = false;
 
-	while (remaining) {
-		const u64 readcount = min_t(u64, remaining,
+	while (ctx.remaining) {
+		const u64 readcount = min_t(u64, ctx.remaining,
 					    sizeof(ctx.queue) - ctx.tail);
 
 		ret = read(fd, ctx.queue + ctx.tail, readcount);
@@ -793,10 +881,10 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 			ret = -errno;
 			goto err_bdrop;
 		}
-		remaining -= readcount;
+		ctx.remaining -= readcount;
 		ctx.tail += readcount;
 
-		ret = vle_compress_one(&ctx, !remaining);
+		ret = vle_compress_one(&ctx);
 		if (ret)
 			goto err_free_idata;
 	}
@@ -807,6 +895,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	DBG_BUGON(compressed_blocks < !!inode->idata_size);
 	compressed_blocks -= !!inode->idata_size;
 
+	z_erofs_fragments_commit(inode);
+
 	z_erofs_write_indexes(&ctx);
 	z_erofs_write_indexes_final(&ctx);
 	legacymetasize = ctx.metacur - compressmeta;
diff --git a/lib/fragments.c b/lib/fragments.c
index b8c37d5..e50937c 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -10,17 +10,181 @@
 #include "erofs/inode.h"
 #include "erofs/compress.h"
 #include "erofs/print.h"
+#include "erofs/internal.h"
 #include "erofs/fragments.h"
 
+struct erofs_fragment_dedupe_item {
+	struct list_head	list;
+	unsigned int		length, nr_dup;
+	erofs_off_t		pos;
+	u8			data[];
+};
+
+#define FRAGMENT_HASHTABLE_SIZE		65536
+#define FRAGMENT_HASH(crc)		(crc & (FRAGMENT_HASHTABLE_SIZE - 1))
+
+static struct list_head dupli_frags[FRAGMENT_HASHTABLE_SIZE];
+static unsigned int len_to_hash; /* the fragment length for crc32 hash */
+
 static FILE *packedfile;
 const char *frags_packedname = "packed_file";
 
-int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
-			   unsigned int len)
+static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
+					 u32 crc)
 {
-	inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
-	inode->fragmentoff = ftell(packedfile);
-	inode->fragment_size = len;
+	struct erofs_fragment_dedupe_item *cur, *di = NULL;
+	struct list_head *head;
+	u8 *data;
+	unsigned int length;
+	int ret;
+
+	head = &dupli_frags[FRAGMENT_HASH(crc)];
+	if (list_empty(head))
+		return 0;
+
+	/* XXX: no need to read so much for smaller? */
+	if (inode->i_size < EROFS_CONFIG_COMPR_MAX_SZ)
+		length = inode->i_size;
+	else
+		length = EROFS_CONFIG_COMPR_MAX_SZ;
+
+	data = malloc(length);
+	if (!data)
+		return -ENOMEM;
+
+	ret = lseek(fd, inode->i_size - length, SEEK_SET);
+	if (ret == -1) {
+		ret = -errno;
+		goto out;
+	}
+
+	ret = read(fd, data, length);
+	if (ret != length) {
+		ret = -errno;
+		goto out;
+	}
+
+	list_for_each_entry(cur, head, list) {
+		unsigned int e1, e2, i = 0;
+
+		DBG_BUGON(cur->length < len_to_hash + 1);
+		DBG_BUGON(length < len_to_hash + 1);
+
+		e1 = cur->length - len_to_hash - 1;
+		e2 = length - len_to_hash - 1;
+
+		if (memcmp(cur->data + e1 + 1, data + e2 + 1, len_to_hash))
+			continue;
+
+		while (i <= min(e1, e2) && cur->data[e1 - i] == data[e2 - i])
+			i++;
+
+		if (i && (!di || i + len_to_hash > di->nr_dup)) {
+			cur->nr_dup = i + len_to_hash;
+			di = cur;
+
+			/* full match */
+			if (i == min(e1, e2) + 1)
+				break;
+		}
+	}
+	if (!di)
+		goto out;
+
+	DBG_BUGON(di->length < di->nr_dup);
+
+	inode->fragment_size = di->nr_dup;
+	inode->fragmentoff = di->pos + di->length - di->nr_dup;
+
+	erofs_dbg("Dedupe %u fragment data at %lu", inode->fragment_size,
+		  inode->fragmentoff);
+out:
+	free(data);
+	return ret;
+}
+
+int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc_r)
+{
+	u8 data_to_hash[len_to_hash];
+	u32 crc;
+	int ret;
+
+	if (inode->i_size <= len_to_hash)
+		return 0;
+
+	ret = lseek(fd, inode->i_size - len_to_hash, SEEK_SET);
+	if (ret == -1)
+		return -errno;
+
+	ret = read(fd, data_to_hash, len_to_hash);
+	if (ret != len_to_hash)
+		return -errno;
+
+	crc = erofs_crc32c(~0, data_to_hash, len_to_hash);
+	*tofcrc_r = crc;
+
+	ret = z_erofs_fragments_dedupe_find(inode, fd, crc);
+	if (ret < 0)
+		return ret;
+
+	ret = lseek(fd, 0, SEEK_SET);
+	if (ret == -1)
+		return -errno;
+	return 0;
+}
+
+static int z_erofs_fragments_dedupe_insert(void *data, unsigned int len,
+					   erofs_off_t pos, u32 crc)
+{
+	struct erofs_fragment_dedupe_item *di;
+
+	if (len <= len_to_hash)
+		return 0;
+
+	di = malloc(sizeof(*di) + len);
+	if (!di)
+		return -ENOMEM;
+
+	memcpy(di->data, data, len);
+	di->length = len;
+	di->pos = pos;
+	di->nr_dup = 0;
+
+	list_add_tail(&di->list, &dupli_frags[FRAGMENT_HASH(crc)]);
+	return 0;
+}
+
+static inline void z_erofs_fragments_dedupe_init(unsigned int clen)
+{
+	unsigned int i;
+
+	for (i = 0; i < FRAGMENT_HASHTABLE_SIZE; ++i)
+		init_list_head(&dupli_frags[i]);
+
+	len_to_hash = clen;
+}
+
+static void z_erofs_fragments_dedupe_exit(void)
+{
+	struct erofs_fragment_dedupe_item *di, *n;
+	struct list_head *head;
+	unsigned int i;
+
+	for (i = 0; i < FRAGMENT_HASHTABLE_SIZE; ++i) {
+		head = &dupli_frags[i];
+
+		if (list_empty(head))
+			continue;
+
+		list_for_each_entry_safe(di, n, head, list)
+			free(di);
+	}
+}
+
+void z_erofs_fragments_commit(struct erofs_inode *inode)
+{
+	if (!inode->fragment_size)
+		return;
 	/*
 	 * If the packed inode is larger than 4GiB, the full fragmentoff
 	 * will be recorded by switching to the noncompact layout anyway.
@@ -28,13 +192,28 @@ int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 	if (inode->fragmentoff >> 32)
 		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
 
+	inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+	erofs_sb_set_fragments();
+}
+
+int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
+			   unsigned int len, u32 tofcrc)
+{
+	int ret;
+
+	inode->fragmentoff = ftell(packedfile);
+	inode->fragment_size = len;
+
 	if (fwrite(data, len, 1, packedfile) != 1)
 		return -EIO;
 
-	erofs_sb_set_fragments();
-
 	erofs_dbg("Recording %u fragment data at %lu", inode->fragment_size,
 		  inode->fragmentoff);
+
+	ret = z_erofs_fragments_dedupe_insert(data, len, inode->fragmentoff,
+					      tofcrc);
+	if (ret)
+		return ret;
 	return len;
 }
 
@@ -50,6 +229,8 @@ void erofs_fragments_exit(void)
 {
 	if (packedfile)
 		fclose(packedfile);
+
+	z_erofs_fragments_dedupe_exit();
 }
 
 int erofs_fragments_init(void)
@@ -61,5 +242,7 @@ int erofs_fragments_init(void)
 #endif
 	if (!packedfile)
 		return -ENOMEM;
+
+	z_erofs_fragments_dedupe_init(16);
 	return 0;
 }
-- 
2.17.1

