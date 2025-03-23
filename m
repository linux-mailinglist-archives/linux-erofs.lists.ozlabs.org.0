Return-Path: <linux-erofs+bounces-118-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D7CA6CDDD
	for <lists+linux-erofs@lfdr.de>; Sun, 23 Mar 2025 05:35:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZL3JC2XTmz2ySR;
	Sun, 23 Mar 2025 15:35:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742704507;
	cv=none; b=PrL2MmWf6K/IIXeJxcEfRzoTyyOKdW5EqKCEKIgjcD2/8RFxQF1Nm4iv//9MqoAzweFXyM/E+TYreZa8Byuueo8PahX1Yyq+gefmCyPnUyPrK+12Hxk4sGnUtxltDlr8LULXKmstRiz41dBiJFBWEf7LZEUJz0T9BMtSv8yk530btDz6iAHxjg8RCsbeXbyJ9PhdmnxbCHLVz77EB9bYi/cQMGnZsQeocNqJDefX5GdA/5ztBHejG2ORCSvlLS0c6b/Tt0h2tB5eMni2h5SSYYeVr3uxoYyb+Mq2FYkYVn+ShOMJu5tEFdyANdhYqsCqsMTr4ohCwEVRTjh+98JHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742704507; c=relaxed/relaxed;
	bh=PdtAujwpQdZFvgT5i003qvJImrNA2HooR7JUWNNORZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDhKocczm6nZGdhc5WK1zKpTZ1nqGEZb/w0/UHEwlyiMqIQgQlWOtcE3uub/hcfQ19DcuITBfIBM9kLrdSUefACcwCu7pf9F7krSW6oSpNlNkeU3lEXoFn5RqKrglc+hMFHpdQaNTy3zoMo8N74poQTx9yZCZXrY4XVcX8Ijokj7kg0+WOQXYyEkp7O3Z+s6P0ifw1Sz/HyBsaG6W03INcqUa4A9TSC5axoItGGY6+FiTKcOh6C716k2a0/Gv7D3jvEUJej1GcvI0m6NIALAp6ZrvXMbPW+J27o0VzuCC4fIO3TMnMHz7t9uom+InRlfDRL+ju3UdbZR12jU864C/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JAJUGe7c; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JAJUGe7c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZL3J86SbSz2yRm
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Mar 2025 15:35:03 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742704498; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=PdtAujwpQdZFvgT5i003qvJImrNA2HooR7JUWNNORZA=;
	b=JAJUGe7c/YoYg5HXOxZ+nvghYqg3JA2bEv4Gqj7g4BKkO7rLIgJ81oTozyxlYnxWnZS/3Ncr4BZHdg0eVrnapoMX5VKm+SuuvqcCRNMoWoAy73I71mNkkcJDgZ1dOQZg2pief15VTObWYVe59jvrv+JJAOxQcx7pcOC9yCKa1rg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WSQCy-x_1742704492 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 23 Mar 2025 12:34:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 2/2] erofs-utils: mkfs: implement multi-threaded fragments
Date: Sun, 23 Mar 2025 12:34:51 +0800
Message-ID: <20250323043451.2907228-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250321162019.43511-1-hsiangkao@linux.alibaba.com>
References: <20250321162019.43511-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Currently, only `-Eall-fragments` is allowed for multi-threaded
compression.  However, in many cases, we don't want the entire file
merged into the packed inode, as it may impact runtime performance.

Let's implement multi-threaded compression for `-Efragments` now,
although it's still not very fast and need to optimize performance
even further for this option.

Note that the image sizes could be larger without `-Ededupe` compared
to `-Eall-fragments` since the head parts aren't deduplicated for now.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
change since v2:
 - fix up broken `-Ededupe` fallback.

 lib/compress.c  | 137 +++++++++++++++++++++++++++++++-----------------
 lib/fragments.c |  14 ++---
 lib/inode.c     |   2 +-
 3 files changed, 93 insertions(+), 60 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 0b48c06..32f58b5 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -110,9 +110,10 @@ struct erofs_compress_work {
 };
 
 static struct {
-	struct erofs_workqueue wq;
+	struct erofs_workqueue wq, fwq;
 	struct erofs_compress_work *idle;
 	pthread_mutex_t mutex;
+	bool hasfwq;
 } z_erofs_mt_ctrl;
 #endif
 
@@ -577,11 +578,11 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	if (len <= ctx->pclustersize) {
 		if (!final || !len)
 			return 1;
-		if (inode->fragment_size && !ictx->fix_dedupedfrag) {
-			ctx->pclustersize = roundup(len, blksz);
-			goto fix_dedupedfrag;
-		}
 		if (may_packing) {
+			if (inode->fragment_size && !ictx->fix_dedupedfrag) {
+				ctx->pclustersize = roundup(len, blksz);
+				goto fix_dedupedfrag;
+			}
 			e->length = len;
 			goto frag_packing;
 		}
@@ -1056,7 +1057,22 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 			     u64 offset, erofs_blk_t blkaddr)
 {
 	struct z_erofs_compress_ictx *ictx = ctx->ictx;
+	struct erofs_inode *inode = ictx->inode;
+	bool frag = cfg.c_fragments && !erofs_is_packed_inode(inode) &&
+		ctx->seg_idx >= ictx->seg_num - 1;
 	int fd = ictx->fd;
+	int ret;
+
+	DBG_BUGON(offset != -1 && frag && inode->fragment_size);
+	if (offset != -1 && frag && !inode->fragment_size &&
+	    cfg.c_fragdedupe != FRAGDEDUPE_OFF) {
+		ret = z_erofs_fragments_dedupe(inode, fd, &ictx->tof_chksum);
+		if (ret < 0)
+			return ret;
+		if (inode->fragment_size > ctx->remaining)
+			inode->fragment_size = ctx->remaining;
+		ctx->remaining -= inode->fragment_size;
+	}
 
 	ctx->blkaddr = blkaddr;
 	while (ctx->remaining) {
@@ -1088,8 +1104,7 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 	}
 
 	/* generate an extra extent for the deduplicated fragment */
-	if (ctx->seg_idx >= ictx->seg_num - 1 &&
-	    ictx->inode->fragment_size && !ictx->fragemitted) {
+	if (frag && inode->fragment_size && !ictx->fragemitted) {
 		struct z_erofs_extent_item *ei;
 
 		ei = malloc(sizeof(*ei));
@@ -1097,7 +1112,7 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 			return -ENOMEM;
 
 		ei->e = (struct z_erofs_inmem_extent) {
-			.length = ictx->inode->fragment_size,
+			.length = inode->fragment_size,
 			.compressedblks = 0,
 			.raw = false,
 			.partial = false,
@@ -1207,6 +1222,8 @@ err_free_idata:
 	return ret;
 }
 
+static struct z_erofs_compress_ictx g_ictx;
+
 #ifdef EROFS_MT_ENABLED
 void *z_erofs_mt_wq_tls_alloc(struct erofs_workqueue *wq, void *ptr)
 {
@@ -1354,9 +1371,12 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 	struct erofs_compress_work *cur, *head = NULL, **last = &head;
 	struct erofs_compress_cfg *ccfg = ictx->ccfg;
 	struct erofs_inode *inode = ictx->inode;
-	int nsegs = DIV_ROUND_UP(inode->i_size, cfg.c_mkfs_segment_size);
-	int i;
+	unsigned int segsz = cfg.c_mkfs_segment_size;
+	int nsegs, i;
 
+	nsegs = DIV_ROUND_UP(inode->i_size - inode->fragment_size, segsz);
+	if (!nsegs)
+		nsegs = 1;
 	ictx->seg_num = nsegs;
 	pthread_mutex_init(&ictx->mutex, NULL);
 	pthread_cond_init(&ictx->cond, NULL);
@@ -1385,13 +1405,6 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 		};
 		init_list_head(&cur->ctx.extents);
 
-		if (i == nsegs - 1)
-			cur->ctx.remaining = inode->i_size -
-					      inode->fragment_size -
-					      i * cfg.c_mkfs_segment_size;
-		else
-			cur->ctx.remaining = cfg.c_mkfs_segment_size;
-
 		cur->alg_id = ccfg->handle.alg->id;
 		cur->alg_name = ccfg->handle.alg->name;
 		cur->comp_level = ccfg->handle.compression_level;
@@ -1399,6 +1412,17 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 		cur->errcode = 1;	/* mark as "in progress" */
 
 		cur->work.fn = z_erofs_mt_workfn;
+		if (i >= nsegs - 1) {
+			cur->ctx.remaining = inode->i_size -
+					inode->fragment_size - (u64)i * segsz;
+			if (z_erofs_mt_ctrl.hasfwq) {
+				erofs_queue_work(&z_erofs_mt_ctrl.fwq,
+						 &cur->work);
+				continue;
+			}
+		} else {
+			cur->ctx.remaining = segsz;
+		}
 		erofs_queue_work(&z_erofs_mt_ctrl.wq, &cur->work);
 	}
 	ictx->mtworks = head;
@@ -1460,14 +1484,53 @@ out:
 	free(ictx);
 	return ret;
 }
-#endif
 
-static struct z_erofs_compress_ictx g_ictx;
+static int z_erofs_mt_init(void)
+{
+	unsigned int workers = cfg.c_mt_workers;
+	int ret;
+
+	if (workers < 1)
+		return 0;
+	if (workers >= 1 && cfg.c_dedupe) {
+		erofs_warn("multi-threaded dedupe is NOT implemented for now");
+		cfg.c_mt_workers = 0;
+	} else {
+		if (cfg.c_fragments && workers > 1) {
+			ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.fwq, 1, 32,
+						    z_erofs_mt_wq_tls_alloc,
+						    z_erofs_mt_wq_tls_free);
+			if (ret)
+				return ret;
+			z_erofs_mt_ctrl.hasfwq = true;
+			--workers;
+		}
+
+		ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq, workers,
+					    workers << 2,
+					    z_erofs_mt_wq_tls_alloc,
+					    z_erofs_mt_wq_tls_free);
+		if (ret)
+			return ret;
+		z_erofs_mt_enabled = true;
+	}
+	pthread_mutex_init(&g_ictx.mutex, NULL);
+	pthread_cond_init(&g_ictx.cond, NULL);
+	return 0;
+}
+#else
+static int z_erofs_mt_init(void)
+{
+	return 0;
+}
+#endif
 
 void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct z_erofs_compress_ictx *ictx;
+	bool all_fragments = cfg.c_all_fragments &&
+					!erofs_is_packed_inode(inode);
 	int ret;
 
 	/* initialize per-file compression setting */
@@ -1502,8 +1565,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	inode->idata_size = 0;
 	inode->fragment_size = 0;
 
-	if (!z_erofs_mt_enabled ||
-	    (cfg.c_all_fragments && !erofs_is_packed_inode(inode))) {
+	if (!z_erofs_mt_enabled || all_fragments) {
 #ifdef EROFS_MT_ENABLED
 		pthread_mutex_lock(&g_ictx.mutex);
 		if (g_ictx.seg_num)
@@ -1529,7 +1591,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	 * parts into the packed inode.
 	 */
 	if (cfg.c_fragments && !erofs_is_packed_inode(inode) &&
-	    cfg.c_fragdedupe != FRAGDEDUPE_OFF) {
+	    ictx == &g_ictx && cfg.c_fragdedupe != FRAGDEDUPE_OFF) {
 		ret = z_erofs_fragments_dedupe(inode, fd, &ictx->tof_chksum);
 		if (ret < 0)
 			goto err_free_ictx;
@@ -1547,8 +1609,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	ictx->fix_dedupedfrag = false;
 	ictx->fragemitted = false;
 
-	if (cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
-	    !inode->fragment_size) {
+	if (all_fragments && !inode->fragment_size) {
 		ret = z_erofs_pack_file_from_fd(inode, fd, ictx->tof_chksum);
 		if (ret)
 			goto err_free_idata;
@@ -1819,30 +1880,7 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	}
 
 	z_erofs_mt_enabled = false;
-#ifdef EROFS_MT_ENABLED
-	if (cfg.c_mt_workers >= 1 && (cfg.c_dedupe ||
-				      (cfg.c_fragments && !cfg.c_all_fragments))) {
-		if (cfg.c_dedupe)
-			erofs_warn("multi-threaded dedupe is NOT implemented for now");
-		if (cfg.c_fragments)
-			erofs_warn("multi-threaded fragments is NOT implemented for now");
-		cfg.c_mt_workers = 0;
-	}
-
-	if (cfg.c_mt_workers >= 1) {
-		ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq,
-					    cfg.c_mt_workers,
-					    cfg.c_mt_workers << 2,
-					    z_erofs_mt_wq_tls_alloc,
-					    z_erofs_mt_wq_tls_free);
-		if (ret)
-			return ret;
-		z_erofs_mt_enabled = true;
-	}
-	pthread_mutex_init(&g_ictx.mutex, NULL);
-	pthread_cond_init(&g_ictx.cond, NULL);
-#endif
-	return 0;
+	return z_erofs_mt_init();
 }
 
 int z_erofs_compress_exit(void)
@@ -1858,6 +1896,9 @@ int z_erofs_compress_exit(void)
 	if (z_erofs_mt_enabled) {
 #ifdef EROFS_MT_ENABLED
 		ret = erofs_destroy_workqueue(&z_erofs_mt_ctrl.wq);
+		if (ret)
+			return ret;
+		ret = erofs_destroy_workqueue(&z_erofs_mt_ctrl.fwq);
 		if (ret)
 			return ret;
 		while (z_erofs_mt_ctrl.idle) {
diff --git a/lib/fragments.c b/lib/fragments.c
index fecebb5..41b9912 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -146,21 +146,13 @@ int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc)
 	if (inode->i_size <= EROFS_TOF_HASHLEN)
 		return 0;
 
-	if (erofs_lseek64(fd, inode->i_size - EROFS_TOF_HASHLEN, SEEK_SET) < 0)
-		return -errno;
-
-	ret = read(fd, data_to_hash, EROFS_TOF_HASHLEN);
+	ret = pread(fd, data_to_hash, EROFS_TOF_HASHLEN,
+		    inode->i_size - EROFS_TOF_HASHLEN);
 	if (ret != EROFS_TOF_HASHLEN)
 		return -errno;
 
 	*tofcrc = erofs_crc32c(~0, data_to_hash, EROFS_TOF_HASHLEN);
-	ret = z_erofs_fragments_dedupe_find(inode, fd, *tofcrc);
-	if (ret < 0)
-		return ret;
-	ret = lseek(fd, 0, SEEK_SET);
-	if (ret < 0)
-		return -errno;
-	return 0;
+	return z_erofs_fragments_dedupe_find(inode, fd, *tofcrc);
 }
 
 static int z_erofs_fragments_dedupe_insert(struct list_head *hash, void *data,
diff --git a/lib/inode.c b/lib/inode.c
index 8c9a8ec..c4edd43 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1312,7 +1312,7 @@ struct erofs_mkfs_dfops {
 	bool idle;	/* initialize as false before the dfops worker runs */
 };
 
-#define EROFS_MT_QUEUE_SIZE 128
+#define EROFS_MT_QUEUE_SIZE 256
 
 static void erofs_mkfs_flushjobs(struct erofs_sb_info *sbi)
 {
-- 
2.43.5


