Return-Path: <linux-erofs+bounces-100-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBA6A6B738
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Mar 2025 10:26:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJxs70W1Qz30MR;
	Fri, 21 Mar 2025 20:26:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742549179;
	cv=none; b=LcCq84wP+w+tupy+ZWEgFxM529got4D2ZAsXSdG4hxeEeFvDtri9XPg0dQr6kdrnATrcA8ov0MN7B/9lRdTR/kF3SpfTiCtP77/viVWaRcyOjYn+NmG/2BuwbYXNYGIxzYG/RMxhoLt31vPbFxVdTalXCjm3L+U3VmPNddZNrNhKTZluv2tcr6hoMhoad35jKCntn5Bh5Hc3ikoSSQIDLo8HRHU6FgiBgnXhMUNEfxHYMQWRZgfkO7q16SUqd+lypkguB8EyXHvkpbcdvGd1RAWRbl2n20d694rscBdmZX2X4GBusXMyq56qb3aELrbEl/n7OFZho/yg5ZQLb9OLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742549179; c=relaxed/relaxed;
	bh=EqoARP/YVweU7Xe9JPCzeqGI2U7cEWtan0/oPSxF/no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnnXbQggXZbfVEHFrQq0AU9Hndjk9IOYEwkvcV8AQy3XJg0cAGStQBQZ3hfHSQpGsL+DkRVAq2cNljPFBD7QxteAZxf1GE9D1jlnfwT808ccYqaSuZBxUOjheTfaNX6ROaYY4F+cDfTTVo8437Oo+Xp2hGFoTxM+JihYitPioEdAgmHitdsnJxXF4sq0EBTgp5wu1knMkzgklKyVa1k+emw0ncKYKGYBu+zF0eL77NOpa/lhnmpxwJPsOar3M/l2t21kWtoW8d185xZpzteBUjDVFsIIb8ZAQFtlcznwSmWg4Ndtf1js3RNOIlwvf0KcIBZBRnKK6n16qTIc43018g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dyqJvjvn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dyqJvjvn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJxs457ZXz30HB
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Mar 2025 20:26:15 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742549172; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=EqoARP/YVweU7Xe9JPCzeqGI2U7cEWtan0/oPSxF/no=;
	b=dyqJvjvn2ckb/FcIwfYuipIHg5E5TYr0VMNe552aG3j2j/1RvgfRb+d2W2Wfmn/UVRhWHgJRuBd8XGsPwJiXwEpKUZzaQufFIXaQGTnY+zHYBIQCNSEBdeESImthoYwVHj3pd4bLDi6xw5Cfh+8ITQKaWzT12XgRQGYkhEc9BtE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WSHd3aC_1742549169 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Mar 2025 17:26:10 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs-utils: mkfs: implement multi-threaded fragments
Date: Fri, 21 Mar 2025 17:26:00 +0800
Message-ID: <20250321092600.3703493-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250321092600.3703493-1-hsiangkao@linux.alibaba.com>
References: <20250321092600.3703493-1-hsiangkao@linux.alibaba.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Currently, only `-Eall-fragments` is allowed for multi-threaded
compression.  However, in many cases, we don't want the entire file
merged into the packed inode, as it may impact runtime performance.

Let’s implement multi-threaded compression for `-Efragments` now,
although it's still not very fast and need to optimize performance
even further for this option.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c  | 134 +++++++++++++++++++++++++++++++-----------------
 lib/fragments.c |  14 ++---
 lib/inode.c     |   2 +-
 3 files changed, 90 insertions(+), 60 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 0b48c06..116bfe5 100644
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
@@ -1056,7 +1057,20 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 			     u64 offset, erofs_blk_t blkaddr)
 {
 	struct z_erofs_compress_ictx *ictx = ctx->ictx;
+	bool last = ctx->seg_idx >= ictx->seg_num - 1;
+	struct erofs_inode *inode = ictx->inode;
 	int fd = ictx->fd;
+	int ret;
+
+	DBG_BUGON(offset != -1 && last && inode->fragment_size);
+	if (offset != -1 && last && !inode->fragment_size) {
+		ret = z_erofs_fragments_dedupe(inode, fd, &ictx->tof_chksum);
+		if (ret < 0)
+			return ret;
+		if (inode->fragment_size > ctx->remaining)
+			inode->fragment_size = ctx->remaining;
+		ctx->remaining -= inode->fragment_size;
+	}
 
 	ctx->blkaddr = blkaddr;
 	while (ctx->remaining) {
@@ -1088,8 +1102,7 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 	}
 
 	/* generate an extra extent for the deduplicated fragment */
-	if (ctx->seg_idx >= ictx->seg_num - 1 &&
-	    ictx->inode->fragment_size && !ictx->fragemitted) {
+	if (last && inode->fragment_size && !ictx->fragemitted) {
 		struct z_erofs_extent_item *ei;
 
 		ei = malloc(sizeof(*ei));
@@ -1097,7 +1110,7 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 			return -ENOMEM;
 
 		ei->e = (struct z_erofs_inmem_extent) {
-			.length = ictx->inode->fragment_size,
+			.length = inode->fragment_size,
 			.compressedblks = 0,
 			.raw = false,
 			.partial = false,
@@ -1207,6 +1220,8 @@ err_free_idata:
 	return ret;
 }
 
+static struct z_erofs_compress_ictx g_ictx;
+
 #ifdef EROFS_MT_ENABLED
 void *z_erofs_mt_wq_tls_alloc(struct erofs_workqueue *wq, void *ptr)
 {
@@ -1354,9 +1369,12 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
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
@@ -1385,13 +1403,6 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
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
@@ -1399,6 +1410,17 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 		cur->errcode = 1;	/* mark as "in progress" */
 
 		cur->work.fn = z_erofs_mt_workfn;
+		if (i >= nsegs - 1) {
+			cur->ctx.remaining = inode->i_size -
+					      inode->fragment_size - i * segsz;
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
@@ -1460,14 +1482,52 @@ out:
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
+	}
+
+	if (cfg.c_fragments && workers > 1) {
+		ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.fwq, 1, 128,
+					    z_erofs_mt_wq_tls_alloc,
+					    z_erofs_mt_wq_tls_free);
+		if (ret)
+			return ret;
+		z_erofs_mt_ctrl.hasfwq = true;
+		--workers;
+	}
+
+	ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq, workers,
+				    workers << 2, z_erofs_mt_wq_tls_alloc,
+				    z_erofs_mt_wq_tls_free);
+	if (ret)
+		return ret;
+	z_erofs_mt_enabled = true;
+	pthread_mutex_init(&g_ictx.mutex, NULL);
+	pthread_cond_init(&g_ictx.cond, NULL);
+	return 0;
+}
+#else
+int z_erofs_mt_init(void)
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
@@ -1502,8 +1562,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	inode->idata_size = 0;
 	inode->fragment_size = 0;
 
-	if (!z_erofs_mt_enabled ||
-	    (cfg.c_all_fragments && !erofs_is_packed_inode(inode))) {
+	if (!z_erofs_mt_enabled || all_fragments) {
 #ifdef EROFS_MT_ENABLED
 		pthread_mutex_lock(&g_ictx.mutex);
 		if (g_ictx.seg_num)
@@ -1528,7 +1587,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	 * Handle tails in advance to avoid writing duplicated
 	 * parts into the packed inode.
 	 */
-	if (cfg.c_fragments && !erofs_is_packed_inode(inode) &&
+	if ((cfg.c_fragments && ictx == &g_ictx) &&
 	    cfg.c_fragdedupe != FRAGDEDUPE_OFF) {
 		ret = z_erofs_fragments_dedupe(inode, fd, &ictx->tof_chksum);
 		if (ret < 0)
@@ -1547,8 +1606,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	ictx->fix_dedupedfrag = false;
 	ictx->fragemitted = false;
 
-	if (cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
-	    !inode->fragment_size) {
+	if (all_fragments && !inode->fragment_size) {
 		ret = z_erofs_pack_file_from_fd(inode, fd, ictx->tof_chksum);
 		if (ret)
 			goto err_free_idata;
@@ -1819,30 +1877,7 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
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
@@ -1858,6 +1893,9 @@ int z_erofs_compress_exit(void)
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


