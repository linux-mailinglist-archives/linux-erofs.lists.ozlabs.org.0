Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A4E645384
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Dec 2022 06:48:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NRmY427T1z3bbJ
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Dec 2022 16:48:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=iqUctNtN;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=iqUctNtN;
	dkim-atps=neutral
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NRmXt6zLMz3bSq
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Dec 2022 16:48:12 +1100 (AEDT)
Received: by mail-pf1-x42a.google.com with SMTP id 21so16609074pfw.4
        for <linux-erofs@lists.ozlabs.org>; Tue, 06 Dec 2022 21:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ih1aWgKYIhQgtcYdkspNdGj2h6y7RuAoCO8iGuPAnA0=;
        b=iqUctNtNyDeuxjkfoqGNhSHQP5NW5S9bgLAFfKJYBFsxXHRv/eKBGLiSuH2cAleHiY
         SFnFvo/cRNmMevclCX0zhkqtggwJh4mpoRfd1c35YjGV5U0ctK1aAxereqShxfQmmsln
         FiPS1dFE4b3kMgRV1G6MfyFsIJPEopY01MjLJiTCNSv1zrfBQJumYWBEDR2apKfJGfW8
         eTXxfXm2d/3UViqnjP6KE+ftX5bPaZyRPBWS1kjUVsGyb/hvlry4+tCifox/psAzmlRZ
         1YXl1GEPVIGnA5yHlLhWqyYFj2/pBVzEs9sbbMqbXNNsqkfNM8DQm/w1uukimuP+Mc2L
         uqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ih1aWgKYIhQgtcYdkspNdGj2h6y7RuAoCO8iGuPAnA0=;
        b=deRvs3UDOxOR6uZg7j2fL4K1bYd0RA+YVHLRCBR78IAJJDmm+RZFhzHJW5zpk/9Gv9
         d8ed6Em34CRci2kUKR51nN5rjfZVGmnLZh6QC7rHteUDHy+pnRrLRAm9BJPpfVI5vK4D
         1Tj/qVybCciAU+iy2Stwm4iuAUQicR2dcR1E8iqZjOzrKCIMYykJpyNALtCsarU+nkBU
         /2y7ND404DGmldYKKJRLSAOI2g69+nD0gHdh2U/g/gAVGKaVFUR63/1SBcugYuA2nEEs
         7vHFx9NRg+u7vslwmcuKwlvLUl4lvSYOctaGFES1V827y81/aYn/wMf4DME4CB77IQEl
         bElg==
X-Gm-Message-State: ANoB5pnj+Eog5WtkhPoib91OatVGydPS8R5JxIrdalCQbvpxujhei4Hs
	2mYd8v2QnknP5YN5G7leEdfh/04SvX4=
X-Google-Smtp-Source: AA0mqf4kEX3osNpgCWjnOyf0+FjQGrIu/Sru7/ugc0Pl9+uAdhIclSVd9ow8gHZu5jUC9A5j7R7+jw==
X-Received: by 2002:a63:5857:0:b0:46f:9763:a37b with SMTP id i23-20020a635857000000b0046f9763a37bmr67112871pgm.177.1670392087018;
        Tue, 06 Dec 2022 21:48:07 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090a3f8100b00213d28a6dedsm336230pjc.13.2022.12.06.21.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 21:48:06 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v6] erofs-utils: mkfs: support fragment deduplication
Date: Wed,  7 Dec 2022 13:47:43 +0800
Message-Id: <20221207054743.15069-1-zbestahu@gmail.com>
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
introduced.  Let's support it now.

Fragments are deduplicated before compression, so that duplicated
parts will not be written into the packed inode.

Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v6:
- add fragemitted in ctx and move frag ctx generating after
  vle_compress_one
- add a jumping label for fixing flow in vle_compress_one
- increase EROFS_CONFIG_COMPR_MAX_SZ
- new variable naming include tof_chksum, fix_dedupedfrag in ctx,
  len_to_hash -> EROFS_TOF_HASHLEN
- refine the interface of z_erofs_fragments_dedupe_update, rename it
  to z_erofs_fixup_deduped_fragment
- refine list_for_each_entry in dedupe
- code comments/commit message minor update

v5:
- fix the issue that decompression may fail when ztailpacking is enabled
  as well
- fix the issue that decompression may fail when dedupe is enabled as
  well in v4
- minor commit message update

v4:
- renaming include tofcrc/new_fragmentsize
- move fixup into ctx
- use may_fixing to check packing fragment or not
- move sb/inode flag + 64bits case from erofs_pack_fragments() to new
  helper erofs_fragments_commit()
- move recompress ahead of may_inline case when compressing succeeds
- update commit message/code comments
- change to generate a ctx for duplicate fragment in compression
- note that decompress will fail when enable ztailpacking at the same
  time, need some time to debug

v3:
- modify acrroding to Xiang's comments in v2
- simplify the logic in vle_compress_one
- fix the crash for 1MB pcluster

v2: mainly improve the logic in compression

 include/erofs/compress.h  |   3 +-
 include/erofs/fragments.h |   4 +-
 lib/compress.c            | 133 +++++++++++++++++++++-----
 lib/fragments.c           | 193 ++++++++++++++++++++++++++++++++++++--
 4 files changed, 299 insertions(+), 34 deletions(-)

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index e9dfaf2..08af9e3 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -14,8 +14,7 @@ extern "C"
 
 #include "internal.h"
 
-#define EROFS_CONFIG_COMPR_MAX_SZ           (3000 * 1024)
-#define EROFS_CONFIG_COMPR_MIN_SZ           (32   * 1024)
+#define EROFS_CONFIG_COMPR_MAX_SZ           (4000 * 1024)
 
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
 int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
index 5444384..4caaf6b 100644
--- a/include/erofs/fragments.h
+++ b/include/erofs/fragments.h
@@ -15,8 +15,10 @@ extern "C"
 extern const char *frags_packedname;
 #define EROFS_PACKED_INODE	frags_packedname
 
+int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc);
 int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
-			   unsigned int len);
+			   unsigned int len, u32 tofcrc);
+void z_erofs_fragments_commit(struct erofs_inode *inode);
 struct erofs_inode *erofs_mkfs_build_fragments(void);
 int erofs_fragments_init(void);
 void erofs_fragments_exit(void);
diff --git a/lib/compress.c b/lib/compress.c
index 17b3213..0c17565 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -31,8 +31,14 @@ struct z_erofs_vle_compress_ctx {
 	struct erofs_inode *inode;
 	u8 *metacur;
 	unsigned int head, tail;
+	erofs_off_t remaining;
+	unsigned int pclustersize;
 	erofs_blk_t blkaddr;		/* pointing to the next blkaddr */
 	u16 clusterofs;
+
+	u32 tof_chksum;
+	bool fix_dedupedfrag;
+	bool fragemitted;
 };
 
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	\
@@ -162,10 +168,10 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
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
@@ -301,10 +307,6 @@ static void tryrecompress_trailing(void *in, unsigned int *insize,
 	unsigned int count;
 	int ret = *compressedsize;
 
-	/* no need to recompress */
-	if (!(ret & (EROFS_BLKSIZ - 1)))
-		return;
-
 	count = *insize;
 	ret = erofs_compress_destsize(&compresshandle,
 				      in, &count, (void *)tmp,
@@ -319,30 +321,62 @@ static void tryrecompress_trailing(void *in, unsigned int *insize,
 	*compressedsize = ret;
 }
 
-static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx,
-			    bool final)
+static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
+					   unsigned int len)
+{
+	struct erofs_inode *inode = ctx->inode;
+	const unsigned int newsize = ctx->remaining + len;
+
+	DBG_BUGON(!inode->fragment_size);
+
+	/* try to fix again if it gets larger (should be rare) */
+	if (inode->fragment_size < newsize) {
+		ctx->pclustersize = roundup(newsize - inode->fragment_size,
+					    EROFS_BLKSIZ);
+		return false;
+	}
+
+	inode->fragmentoff += inode->fragment_size - newsize;
+	inode->fragment_size = newsize;
+
+	erofs_dbg("Reducing fragment size to %u at %lu",
+		  inode->fragment_size, inode->fragmentoff);
+
+	/* it's the end */
+	ctx->head += newsize;
+	ctx->remaining = 0;
+	return true;
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
-		bool may_inline = (cfg.c_ztailpacking && final);
 		bool may_packing = (cfg.c_fragments && final &&
 				   !erofs_is_packed_inode(inode));
+		bool may_inline = (cfg.c_ztailpacking && final &&
+				  !may_packing);
+		bool fix_dedupedfrag = ctx->fix_dedupedfrag;
 
-		if (z_erofs_compress_dedupe(inode, ctx, &len) && !final)
+		if (z_erofs_compress_dedupe(ctx, &len) && !final)
 			break;
 
-		if (len <= pclustersize) {
+		if (len <= ctx->pclustersize) {
 			if (!final || !len)
 				break;
 			if (may_packing) {
+				if (inode->fragment_size && !fix_dedupedfrag) {
+					ctx->pclustersize =
+						roundup(len, EROFS_BLKSIZ);
+					goto fix_dedupedfrag;
+				}
 				ctx->e.length = len;
 				goto frag_packing;
 			}
@@ -353,7 +387,7 @@ static int vle_compress_one(struct z_erofs_vle_compress_ctx *ctx,
 		ctx->e.length = min(len,
 				cfg.c_max_decompressed_extent_bytes);
 		ret = erofs_compress_destsize(h, ctx->queue + ctx->head,
-				&ctx->e.length, dst, pclustersize,
+				&ctx->e.length, dst, ctx->pclustersize,
 				!(final && len == ctx->e.length));
 		if (ret <= 0) {
 			if (ret != -EAGAIN) {
@@ -385,15 +419,18 @@ nocompression:
 			ctx->e.compressedblks = 1;
 			ctx->e.raw = true;
 		} else if (may_packing && len == ctx->e.length &&
-			   ret < pclustersize) {
+			   ret < ctx->pclustersize &&
+			   (!inode->fragment_size || fix_dedupedfrag)) {
 frag_packing:
 			ret = z_erofs_pack_fragments(inode,
 						     ctx->queue + ctx->head,
-						     len);
+						     len, ctx->tof_chksum);
 			if (ret < 0)
 				return ret;
 			ctx->e.compressedblks = 0; /* indicate a fragment */
 			ctx->e.raw = true;
+			ctx->fragemitted = true;
+			fix_dedupedfrag = false;
 		/* tailpcluster should be less than 1 block */
 		} else if (may_inline && len == ctx->e.length &&
 			   ret < EROFS_BLKSIZ) {
@@ -415,11 +452,25 @@ frag_packing:
 		} else {
 			unsigned int tailused, padding;
 
-			if (may_inline && len == ctx->e.length)
+			tailused = ret & (EROFS_BLKSIZ - 1);
+			/*
+			 * If there's space left for the last round when
+			 * deduping fragments, try to read the fragment and
+			 * recompress a little more to check whether it can be
+			 * filled up. Fix up the fragment if succeeds.
+			 * Otherwise, just drop it and go to packing.
+			 */
+			if (may_packing && len == ctx->e.length && tailused &&
+			    ctx->tail < sizeof(ctx->queue)) {
+				ctx->pclustersize =
+					BLK_ROUND_UP(ret) * EROFS_BLKSIZ;
+				goto fix_dedupedfrag;
+			}
+
+			if (may_inline && len == ctx->e.length && tailused)
 				tryrecompress_trailing(ctx->queue + ctx->head,
 						&ctx->e.length, dst, &ret);
 
-			tailused = ret & (EROFS_BLKSIZ - 1);
 			padding = 0;
 			ctx->e.compressedblks = BLK_ROUND_UP(ret);
 			DBG_BUGON(ctx->e.compressedblks * EROFS_BLKSIZ >=
@@ -454,6 +505,10 @@ frag_packing:
 		ctx->head += ctx->e.length;
 		len -= ctx->e.length;
 
+		if (fix_dedupedfrag &&
+		    z_erofs_fixup_deduped_fragment(ctx, len))
+			break;
+
 		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
 			const unsigned int qh_aligned =
 				round_down(ctx->head, EROFS_BLKSIZ);
@@ -467,6 +522,13 @@ frag_packing:
 		}
 	}
 	return 0;
+
+fix_dedupedfrag:
+	DBG_BUGON(!inode->fragment_size);
+	ctx->remaining += inode->fragment_size;
+	ctx->e.length = 0;
+	ctx->fix_dedupedfrag = true;
+	return 0;
 }
 
 struct z_erofs_compressindex_vec {
@@ -736,7 +798,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 {
 	struct erofs_buffer_head *bh;
 	static struct z_erofs_vle_compress_ctx ctx;
-	erofs_off_t remaining;
 	erofs_blk_t blkaddr, compressed_blocks;
 	unsigned int legacymetasize;
 	int ret;
@@ -775,17 +836,30 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	inode->idata_size = 0;
 	inode->fragment_size = 0;
 
+	/*
+	 * Handle tails in advance to avoid writing duplicated
+	 * parts into the packed inode.
+	 */
+	if (cfg.c_fragments && !erofs_is_packed_inode(inode)) {
+		ret = z_erofs_fragments_dedupe(inode, fd, &ctx.tof_chksum);
+		if (ret < 0)
+			goto err_bdrop;
+	}
+
 	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.inode = inode;
+	ctx.pclustersize = z_erofs_get_max_pclusterblks(inode) * EROFS_BLKSIZ;
 	ctx.blkaddr = blkaddr;
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	ctx.head = ctx.tail = 0;
 	ctx.clusterofs = 0;
 	ctx.e.length = 0;
-	remaining = inode->i_size;
+	ctx.remaining = inode->i_size - inode->fragment_size;
+	ctx.fix_dedupedfrag = false;
+	ctx.fragemitted = false;
 
-	while (remaining) {
-		const u64 readcount = min_t(u64, remaining,
+	while (ctx.remaining) {
+		const u64 readcount = min_t(u64, ctx.remaining,
 					    sizeof(ctx.queue) - ctx.tail);
 
 		ret = read(fd, ctx.queue + ctx.tail, readcount);
@@ -793,10 +867,10 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
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
@@ -807,6 +881,17 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	DBG_BUGON(compressed_blocks < !!inode->idata_size);
 	compressed_blocks -= !!inode->idata_size;
 
+	/* generate an extent for the deduplicated fragment */
+	if (inode->fragment_size && !ctx.fragemitted) {
+		z_erofs_write_indexes(&ctx);
+		ctx.e.length = inode->fragment_size;
+		ctx.e.compressedblks = 0;
+		ctx.e.raw = true;
+		ctx.e.partial = false;
+		ctx.e.blkaddr = ctx.blkaddr;
+	}
+	z_erofs_fragments_commit(inode);
+
 	z_erofs_write_indexes(&ctx);
 	z_erofs_write_indexes_final(&ctx);
 	legacymetasize = ctx.metacur - compressmeta;
diff --git a/lib/fragments.c b/lib/fragments.c
index b8c37d5..e855467 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -10,17 +10,177 @@
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
+#define EROFS_TOF_HASHLEN		16
+
+#define FRAGMENT_HASHTABLE_SIZE		65536
+#define FRAGMENT_HASH(crc)		(crc & (FRAGMENT_HASHTABLE_SIZE - 1))
+
+static struct list_head dupli_frags[FRAGMENT_HASHTABLE_SIZE];
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
+	unsigned int length, e2;
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
+	if (ret < 0) {
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
+	DBG_BUGON(length <= EROFS_TOF_HASHLEN);
+	e2 = length - EROFS_TOF_HASHLEN;
+
+	list_for_each_entry(cur, head, list) {
+		unsigned int e1, mn, i = 0;
+
+		DBG_BUGON(cur->length <= EROFS_TOF_HASHLEN);
+		e1 = cur->length - EROFS_TOF_HASHLEN;
+
+		if (memcmp(cur->data + e1, data + e2, EROFS_TOF_HASHLEN))
+			continue;
+
+		mn = min(e1, e2);
+		while (i < mn && cur->data[e1 - i - 1] == data[e2 - i - 1])
+			++i;
+
+		if (i && (!di || i + EROFS_TOF_HASHLEN > di->nr_dup)) {
+			cur->nr_dup = i + EROFS_TOF_HASHLEN;
+			di = cur;
+
+			/* full match */
+			if (i == mn)
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
+int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc)
+{
+	u8 data_to_hash[EROFS_TOF_HASHLEN];
+	int ret;
+
+	if (inode->i_size <= EROFS_TOF_HASHLEN)
+		return 0;
+
+	ret = lseek(fd, inode->i_size - EROFS_TOF_HASHLEN, SEEK_SET);
+	if (ret < 0)
+		return -errno;
+
+	ret = read(fd, data_to_hash, EROFS_TOF_HASHLEN);
+	if (ret != EROFS_TOF_HASHLEN)
+		return -errno;
+
+	*tofcrc = erofs_crc32c(~0, data_to_hash, EROFS_TOF_HASHLEN);
+	ret = z_erofs_fragments_dedupe_find(inode, fd, *tofcrc);
+	if (ret < 0)
+		return ret;
+	ret = lseek(fd, 0, SEEK_SET);
+	if (ret < 0)
+		return -errno;
+	return 0;
+}
+
+static int z_erofs_fragments_dedupe_insert(void *data, unsigned int len,
+					   erofs_off_t pos, u32 crc)
+{
+	struct erofs_fragment_dedupe_item *di;
+
+	if (len <= EROFS_TOF_HASHLEN)
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
+static void z_erofs_fragments_dedupe_init(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < FRAGMENT_HASHTABLE_SIZE; ++i)
+		init_list_head(&dupli_frags[i]);
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
@@ -28,13 +188,28 @@ int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
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
 
@@ -50,6 +225,8 @@ void erofs_fragments_exit(void)
 {
 	if (packedfile)
 		fclose(packedfile);
+
+	z_erofs_fragments_dedupe_exit();
 }
 
 int erofs_fragments_init(void)
@@ -61,5 +238,7 @@ int erofs_fragments_init(void)
 #endif
 	if (!packedfile)
 		return -ENOMEM;
+
+	z_erofs_fragments_dedupe_init();
 	return 0;
 }
-- 
2.17.1

