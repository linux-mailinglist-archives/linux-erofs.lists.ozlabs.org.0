Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4FC631B09
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Nov 2022 09:11:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NG0V043twz3cJK
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Nov 2022 19:11:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=WsIYttNW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=WsIYttNW;
	dkim-atps=neutral
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NG0Ts4Snsz2xxn
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Nov 2022 19:11:43 +1100 (AEDT)
Received: by mail-pf1-x42f.google.com with SMTP id q9so10662409pfg.5
        for <linux-erofs@lists.ozlabs.org>; Mon, 21 Nov 2022 00:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCemmapjtj51BvGfWyju3ry8fGRuUp/qnhAgBp76Mxg=;
        b=WsIYttNWQnavRE76jaTmLdWOWDBDB+yrCB2/gt3QWNVb25jvl+k4xk5UAHjw8qiv9g
         EiecMDONcsjNnnTybP7lWtpHfNhKogb6/MnR/aRMKW6H92ccsgvefEayC/fN5vf1dqMW
         4Pf9056v9Opnipa1kBbTTP/g3cGPDUVLxYl3Ug+3OD4K6pXhvBIeD4n65jpBgxNurOIb
         F/1go2oF6BfEpXS/7pcMVIJ704vl5TxlIVHsHnAiVOgszdzxOhTjKCIQ6TjGywihgWEk
         gfV/KadknY/USPrq3EnhlID79Iw7+FtrijAd9xNwezeXzS4IqHfQZRncYGmtRDbyQbAz
         RNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCemmapjtj51BvGfWyju3ry8fGRuUp/qnhAgBp76Mxg=;
        b=P8LfW9wwLKFlWkteO9hK+ZccGpZF6sDyarntOWWrg6wQ4KMAwQ1MEAI97TSv4/SkQ7
         5y3TvsWPSPA+bvIK3lo2A3w83e0q+dIMAngU8yBUNsBxjtoqr/nK1XqiFtQcpd9zsffM
         dixvPJ2ccVVloso2JbsG6sE1gtCSllPOjIH1t0TV0A5yXBk4YM0KlWukwjHJ6kesxILn
         3Xp2V9hz9KZ6uR+41x8uLDNtFRaKclATFgTfP7NRPPcdotATLPm3LUzxIWyAcJjidntf
         mESs3XoreQJLWI5GcRr0My/S4gHIb0Lsu6WXNAu3LpQxxJsa9YSWPT7TFISEuJBW9Xxd
         uNSA==
X-Gm-Message-State: ANoB5pnARQdNBkdE9egZqdxutxTqRsKHLHB4CIzkaqcn7VrxA0pZh4tv
	gKZFd2IGkqdYyoO/gHzBFbg1rr6QFIo=
X-Google-Smtp-Source: AA0mqf50jvl/Ww86xKC5ijmxPjEwnzwN9TZ0BBHA/ifOoF8/kYJWJm1xGsJEneARlxGM95JrTizZmA==
X-Received: by 2002:a05:6a00:2352:b0:572:91c6:9e4e with SMTP id j18-20020a056a00235200b0057291c69e4emr2590291pfj.53.1669018299188;
        Mon, 21 Nov 2022 00:11:39 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id e190-20020a621ec7000000b00561dcfa700asm8044806pfe.107.2022.11.21.00.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 00:11:38 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC][PATCH] erofs-utils: mkfs: support fragments deduplication
Date: Mon, 21 Nov 2022 16:10:15 +0800
Message-Id: <20221121081015.19947-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, zbestahu@163.com, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Previously, there's no fragments deduplication when this feature is
introduced. Let's support it now.

Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 include/erofs/fragments.h |   3 +-
 lib/compress.c            | 117 ++++++++++++++++++++----
 lib/fragments.c           | 188 +++++++++++++++++++++++++++++++++++++-
 lib/inode.c               |  12 ++-
 4 files changed, 299 insertions(+), 21 deletions(-)

diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
index 5444384..6c51fc9 100644
--- a/include/erofs/fragments.h
+++ b/include/erofs/fragments.h
@@ -15,8 +15,9 @@ extern "C"
 extern const char *frags_packedname;
 #define EROFS_PACKED_INODE	frags_packedname
 
+int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *crc);
 int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
-			   unsigned int len);
+			   unsigned int len, u32 crc);
 struct erofs_inode *erofs_mkfs_build_fragments(void);
 int erofs_fragments_init(void);
 void erofs_fragments_exit(void);
diff --git a/lib/compress.c b/lib/compress.c
index 17b3213..1461d4c 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -33,6 +33,11 @@ struct z_erofs_vle_compress_ctx {
 	unsigned int head, tail;
 	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
 	u16 clusterofs;
+
+	u32 crc;
+	unsigned int pclustersize;
+	erofs_off_t remaining;
+	bool fixing;
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
@@ -319,24 +324,68 @@ static void tryrecompress_trailing(void *in, unsigned int *insize,
 	*compressedsize = ret;
 }
 
-static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx,
-			    bool final)
+static void z_erofs_fragments_dedupe_reduce(struct z_erofs_vle_compress_ctx *ctx,
+					    unsigned int *len)
+{
+	struct erofs_inode *inode = ctx->inode;
+	const unsigned int remaining = ctx->remaining + *len;
+
+	if (!ctx->fixing || !inode->fragment_size || !ctx->e.compressedblks)
+		return;
+
+	if (inode->fragment_size < remaining) {
+		DBG_BUGON(!ctx->e.raw);
+		return;
+	}
+
+	inode->fragmentoff += inode->fragment_size - remaining;
+	inode->fragment_size = remaining;
+
+	erofs_dbg("Reducing fragment size to %u at %lu",
+		  inode->fragment_size, inode->fragmentoff);
+
+	/* it's ending */
+	ctx->head += remaining;
+	ctx->remaining = 0;
+	*len = 0;
+}
+
+static void z_erofs_fragments_dedupe_end(struct z_erofs_vle_compress_ctx *ctx)
+{
+	struct erofs_inode *inode = ctx->inode;
+
+	if (inode->fragment_size && ctx->e.compressedblks) {
+		inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+		z_erofs_write_indexes(ctx);
+
+		ctx->e.length = inode->fragment_size;
+		ctx->e.compressedblks = 0;
+		ctx->e.raw = true;
+		ctx->e.partial = false;
+		ctx->e.blkaddr = ctx->blkaddr;
+	}
+	z_erofs_write_indexes(ctx);
+	z_erofs_write_indexes_final(ctx);
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
+		unsigned int pclustersize = !ctx->fixing ? ctx->pclustersize :
+					ctx->e.compressedblks * EROFS_BLKSIZ;
 		bool may_inline = (cfg.c_ztailpacking && final);
 		bool may_packing = (cfg.c_fragments && final &&
 				   !erofs_is_packed_inode(inode));
 
-		if (z_erofs_compress_dedupe(inode, ctx, &len) && !final)
+		if (z_erofs_compress_dedupe(ctx, &len) && !final)
 			break;
 
 		if (len <= pclustersize) {
@@ -344,6 +393,7 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx,
 				break;
 			if (may_packing) {
 				ctx->e.length = len;
+				ret = 0; /* uncompressed */
 				goto frag_packing;
 			}
 			if (!may_inline && len <= EROFS_BLKSIZ)
@@ -387,9 +437,21 @@ nocompression:
 		} else if (may_packing && len == ctx->e.length &&
 			   ret < pclustersize) {
 frag_packing:
+			/*
+			 * Try to recompress a litte more to fill up the block
+			 * if the fragment already exists.
+			 */
+			if (inode->fragment_size && !ctx->fixing) {
+				ctx->remaining = inode->fragment_size;
+				ctx->e.compressedblks = ret ?
+					BLK_ROUND_UP(ret) : BLK_ROUND_UP(len);
+				ctx->e.length = 0; /* no index */
+				ctx->fixing = true;
+				break;
+			}
 			ret = z_erofs_pack_fragments(inode,
 						     ctx->queue + ctx->head,
-						     len);
+						     len, ctx->crc);
 			if (ret < 0)
 				return ret;
 			ctx->e.compressedblks = 0; /* indicate a fragment */
@@ -415,6 +477,14 @@ frag_packing:
 		} else {
 			unsigned int tailused, padding;
 
+			/* drop it if dedupe fragment makes it larger */
+			if (ctx->fixing && len - ctx->e.length > inode->fragment_size) {
+				inode->fragment_size = 0;
+				ctx->e.length = 0;
+				ctx->fixing = false;
+				continue;
+			}
+
 			if (may_inline && len == ctx->e.length)
 				tryrecompress_trailing(ctx->queue + ctx->head,
 						&ctx->e.length, dst, &ret);
@@ -454,6 +524,8 @@ frag_packing:
 		ctx->head += ctx->e.length;
 		len -= ctx->e.length;
 
+		z_erofs_fragments_dedupe_reduce(ctx, &len);
+
 		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
 			const unsigned int qh_aligned =
 				round_down(ctx->head, EROFS_BLKSIZ);
@@ -736,7 +808,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 {
 	struct erofs_buffer_head *bh;
 	static struct z_erofs_vle_compress_ctx ctx;
-	erofs_off_t remaining;
 	erofs_blk_t blkaddr, compressed_blocks;
 	unsigned int legacymetasize;
 	int ret;
@@ -775,6 +846,18 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	inode->idata_size = 0;
 	inode->fragment_size = 0;
 
+	/*
+	 * Try to dedupe fragments before compressing to avoid writing
+	 * duplicated parts into packed inode.
+	 */
+	if (cfg.c_fragments && !erofs_is_packed_inode(inode)) {
+		ret = z_erofs_fragments_dedupe(inode, fd, &ctx.crc);
+		if (ret < 0) {
+			erofs_dbg("fragment dedupe failed");
+			goto err_bdrop;
+		}
+	}
+
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.inode = inode;
 	ctx.blkaddr = blkaddr;
@@ -782,10 +865,13 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	ctx.head = ctx.tail = 0;
 	ctx.clusterofs = 0;
 	ctx.e.length = 0;
-	remaining = inode->i_size;
+	ctx.e.compressedblks = 0;
+	ctx.pclustersize = z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
+	ctx.remaining = inode->i_size - inode->fragment_size;
+	ctx.fixing = false;
 
-	while (remaining) {
-		const u64 readcount = min_t(u64, remaining,
+	while (ctx.remaining) {
+		const u64 readcount = min_t(u64, ctx.remaining,
 					    sizeof(ctx.queue) - ctx.tail);
 
 		ret = read(fd, ctx.queue + ctx.tail, readcount);
@@ -793,10 +879,10 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
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
@@ -807,8 +893,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	DBG_BUGON(compressed_blocks < !!inode->idata_size);
 	compressed_blocks -= !!inode->idata_size;
 
-	z_erofs_write_indexes(&ctx);
-	z_erofs_write_indexes_final(&ctx);
+	z_erofs_fragments_dedupe_end(&ctx);
 	legacymetasize = ctx.metacur - compressmeta;
 	/* estimate if data compression saves space or not */
 	if (!inode->fragment_size &&
diff --git a/lib/fragments.c b/lib/fragments.c
index b8c37d5..550c888 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -10,14 +10,191 @@
 #include "erofs/inode.h"
 #include "erofs/compress.h"
 #include "erofs/print.h"
+#include "erofs/internal.h"
 #include "erofs/fragments.h"
 
+struct fragment_dedupe_item {
+	struct list_head	list;
+	unsigned int		length, nr_dup;
+	erofs_off_t		pos;
+	u8			data[];
+};
+
+#define FRAGMENT_HASHTABLE_SIZE		65536
+#define FRAGMENT_HASH(crc)		(crc & (FRAGMENT_HASHTABLE_SIZE - 1))
+
+static struct list_head di_hashtable[FRAGMENT_HASHTABLE_SIZE];
+static unsigned int keylen;	/* the data length to crc for deduplication */
+
 static FILE *packedfile;
 const char *frags_packedname = "packed_file";
 
+static struct fragment_dedupe_item *find_duplicate(struct list_head *head,
+						   u8 *data, unsigned int len)
+{
+	struct fragment_dedupe_item *di, *candidate = NULL;
+
+	list_for_each_entry(di, head, list) {
+		unsigned int e1, e2, i = 0;
+
+		DBG_BUGON(di->length < keylen + 1);
+		DBG_BUGON(len < keylen + 1);
+
+		e1 = di->length - keylen - 1;
+		e2 = len - keylen - 1;
+
+		if (memcmp(di->data + e1 + 1, data + e2 + 1, keylen))
+			continue;
+
+		while (i <= min(e1, e2) && di->data[e1 - i] == data[e2 - i])
+			i++;
+
+		if (i && (!candidate || i + keylen > candidate->nr_dup)) {
+			di->nr_dup = i + keylen;
+			candidate = di;
+
+			/* full match */
+			if (i == min(e1, e2) + 1)
+				break;
+		}
+	}
+	return candidate;
+}
+
+static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
+					 u32 crc)
+{
+	struct fragment_dedupe_item *di;
+	struct list_head *head;
+	u8 *data;
+	unsigned int length;
+	int ret;
+
+	head = &di_hashtable[FRAGMENT_HASH(crc)];
+	if (list_empty(head))
+		return 0;
+
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
+	di = find_duplicate(head, data, length);
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
+
+int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *crc_ret)
+{
+	u8 key[keylen];
+	u32 crc;
+	int ret;
+
+	if (inode->i_size <= keylen)
+		return 0;
+
+	ret = lseek(fd, inode->i_size - keylen, SEEK_SET);
+	if (ret == -1)
+		return -errno;
+
+	ret = read(fd, key, keylen);
+	if (ret != keylen)
+		return -errno;
+
+	crc = erofs_crc32c(~0, key, keylen);
+	*crc_ret = crc;
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
+	struct fragment_dedupe_item *di;
+
+	if (len <= keylen)
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
+	list_add_tail(&di->list, &di_hashtable[FRAGMENT_HASH(crc)]);
+	return 0;
+}
+
+static inline void z_erofs_fragments_dedupe_init(unsigned int clen)
+{
+	unsigned int i;
+
+	for (i = 0; i < FRAGMENT_HASHTABLE_SIZE; ++i)
+		init_list_head(&di_hashtable[i]);
+
+	keylen = clen;
+}
+
+static void z_erofs_fragments_dedupe_exit(void)
+{
+	struct fragment_dedupe_item *di, *n;
+	struct list_head *head;
+	unsigned int i;
+
+	for (i = 0; i < FRAGMENT_HASHTABLE_SIZE; ++i) {
+		head = &di_hashtable[i];
+
+		if (list_empty(head))
+			continue;
+
+		list_for_each_entry_safe(di, n, head, list)
+			free(di);
+	}
+}
+
 int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
-			   unsigned int len)
+			   unsigned int len, u32 crc)
 {
+	int ret;
+
 	inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 	inode->fragmentoff = ftell(packedfile);
 	inode->fragment_size = len;
@@ -35,6 +212,11 @@ int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 
 	erofs_dbg("Recording %u fragment data at %lu", inode->fragment_size,
 		  inode->fragmentoff);
+
+	ret = z_erofs_fragments_dedupe_insert(data, len, inode->fragmentoff,
+					      crc);
+	if (ret)
+		return ret;
 	return len;
 }
 
@@ -50,6 +232,8 @@ void erofs_fragments_exit(void)
 {
 	if (packedfile)
 		fclose(packedfile);
+
+	z_erofs_fragments_dedupe_exit();
 }
 
 int erofs_fragments_init(void)
@@ -61,5 +245,7 @@ int erofs_fragments_init(void)
 #endif
 	if (!packedfile)
 		return -ENOMEM;
+
+	z_erofs_fragments_dedupe_init(16);
 	return 0;
 }
diff --git a/lib/inode.c b/lib/inode.c
index 9de4dec..cb2e057 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -406,7 +406,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 	return 0;
 }
 
-int erofs_write_file(struct erofs_inode *inode)
+static int erofs_write_file(struct erofs_inode *inode)
 {
 	int ret, fd;
 
@@ -1196,7 +1196,10 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 	struct erofs_inode *inode;
 	int ret;
 
-	lseek(fd, 0, SEEK_SET);
+	ret = lseek(fd, 0, SEEK_SET);
+	if (ret == -1)
+		return ERR_PTR(-errno);
+
 	ret = fstat64(fd, &st);
 	if (ret)
 		return ERR_PTR(-errno);
@@ -1223,7 +1226,10 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 
 	ret = erofs_write_compressed_file(inode, fd);
 	if (ret == -ENOSPC) {
-		lseek(fd, 0, SEEK_SET);
+		ret = lseek(fd, 0, SEEK_SET);
+		if (ret == -1)
+			return ERR_PTR(-errno);
+
 		ret = write_uncompressed_file_from_fd(inode, fd);
 	}
 
-- 
2.17.1

