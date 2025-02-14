Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F06A3633C
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2025 17:36:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yvd3M4H7fz3bpG
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Feb 2025 03:36:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739550973;
	cv=none; b=fl5ouZpTi1MEgwwVbCy6oIhaO/TqDzqzLxZcHxa4nz9uu0dRaljR+PTFw4Hy5JpnMwETlezsV6zVuVnNqM+evS82QpjL+Fs013h6H3VXQsPUL/+92fAyIQZ+IpHYYD3e20GLk0CJsAT0WtlXhpuXONcIQM4KTygWBBRAZhspSI6eqJ5ROHKX+5MfW6evYaMelMwr5qg48/2FFH9JTCSYzrCPM+VvOEkPNb8PDu5b3IsukMoZ+mzDieJaODRZrgrTymhR8f3BTbYViaI15CCNTONMXPjpIsTYwjrj33pKNLT3kEb5zQi3hh0d0QP7gBOlxSUsaeCQ0J4e6sOQR1idZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739550973; c=relaxed/relaxed;
	bh=0eOsDYvK+OYbxa0M1Fn4XOCc/LJX+6PVK9Wd166I15k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYuluOmSeLK6BFQuGzRao6/ApgWAwRXVMDsPm11cQivA2byRfBuFd3TqBApBKEKe9EzxnCCh+xFfZbvRroQZfCrSgLsv/YOmMZB7GUyicyqU3DMeGkxzgYfOkEF0pvN8ZZRtbG02DTT2yPlNnNupP/r5gYLu2agRD1o9lZKc1DKtGIZl22JGn6YivY7ENRSNThcsuZrXfkDIo7Un3bawZJWPs2FDxxocm/clbaq71MGD4t1VPgbArqglkxR3IubElE6tZXl5RtIVoFalwr7V+Pq4ej4i+eI/T9/stL/VUXUD8pFP/xzjaxe9yW8S6wg6JuOpbY155//mh64zdK8gdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yOsXS8D4; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yOsXS8D4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yvd3H2V3vz3bm7
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Feb 2025 03:36:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739550965; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0eOsDYvK+OYbxa0M1Fn4XOCc/LJX+6PVK9Wd166I15k=;
	b=yOsXS8D4LG+NIn2GOxl9sOPxE/5vxvBt83MHRJzbPkUITIt7V+nn8RrWJjM/mfS/0sxg4gGno1830qd0USS9D5g4zUDYBW+nVL7eF895CrhzaMFA4O0uoV143XRwKuqILWu6P2B6NEqvcwI3TnSSDn3mqWCLUY61Gu0OmuxQ61Y=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPRK0ea_1739550957 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 15 Feb 2025 00:36:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: mkfs: add per-segment reaper for multi-threaded compression
Date: Sat, 15 Feb 2025 00:35:53 +0800
Message-ID: <20250214163553.4108575-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Replace the old per-inode reaper to avoid unnecessary memory overhead.
It also speeds up the multithreaded compression a bit.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 604a04c..e9a4459 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -52,23 +52,21 @@ struct z_erofs_compress_ictx {		/* inode context */
 	u8 *metacur;
 	struct list_head extents;
 	u16 clusterofs;
-
 	int seg_num;
 
 #if EROFS_MT_ENABLED
 	pthread_mutex_t mutex;
 	pthread_cond_t cond;
-	int nfini;
 
 	struct erofs_compress_work *mtworks;
 #endif
 };
 
 struct z_erofs_compress_sctx {		/* segment context */
+	struct list_head extents;
 	struct z_erofs_compress_ictx *ictx;
 
 	u8 *queue;
-	struct list_head extents;
 	struct z_erofs_extent_item *pivot;
 
 	struct erofs_compress *chandle;
@@ -98,6 +96,7 @@ struct erofs_compress_work {
 	/* Note: struct erofs_work must be the first member */
 	struct erofs_work work;
 	struct z_erofs_compress_sctx ctx;
+	pthread_cond_t cond;
 	struct erofs_compress_work *next;
 
 	unsigned int alg_id;
@@ -1307,12 +1306,10 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 				       EROFS_NULL_ADDR);
 
 out:
-	cwork->errcode = ret;
+	DBG_BUGON(ret > 0);
 	pthread_mutex_lock(&ictx->mutex);
-	if (++ictx->nfini >= ictx->seg_num) {
-		DBG_BUGON(ictx->nfini > ictx->seg_num);
-		pthread_cond_signal(&ictx->cond);
-	}
+	cwork->errcode = ret;
+	pthread_cond_signal(&cwork->cond);
 	pthread_mutex_unlock(&ictx->mutex);
 }
 
@@ -1346,6 +1343,7 @@ int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
 		}
 	}
 	free(sctx->membuf);
+	sctx->membuf = NULL;
 	return ret;
 }
 
@@ -1358,7 +1356,6 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 	int i;
 
 	ictx->seg_num = nsegs;
-	ictx->nfini = 0;
 	pthread_mutex_init(&ictx->mutex, NULL);
 	pthread_cond_init(&ictx->cond, NULL);
 
@@ -1374,6 +1371,7 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 			cur = calloc(1, sizeof(*cur));
 			if (!cur)
 				return -ENOMEM;
+			pthread_cond_init(&cur->cond, NULL);
 		}
 		*last = cur;
 		last = &cur->next;
@@ -1396,6 +1394,7 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 		cur->alg_name = ccfg->handle.alg->name;
 		cur->comp_level = ccfg->handle.compression_level;
 		cur->dict_size = ccfg->handle.dict_size;
+		cur->errcode = 1;	/* mark as "in progress" */
 
 		cur->work.fn = z_erofs_mt_workfn;
 		erofs_queue_work(&z_erofs_mt_ctrl.wq, &cur->work);
@@ -1412,11 +1411,6 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 	erofs_blk_t blkaddr, compressed_blocks = 0;
 	int ret;
 
-	pthread_mutex_lock(&ictx->mutex);
-	while (ictx->nfini < ictx->seg_num)
-		pthread_cond_wait(&ictx->cond, &ictx->mutex);
-	pthread_mutex_unlock(&ictx->mutex);
-
 	bh = erofs_balloc(sbi->bmgr, DATA, 0, 0);
 	if (IS_ERR(bh)) {
 		ret = PTR_ERR(bh);
@@ -1431,9 +1425,12 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 		cur = head;
 		head = cur->next;
 
-		if (cur->errcode) {
-			ret = cur->errcode;
-		} else {
+		pthread_mutex_lock(&ictx->mutex);
+		while ((ret = cur->errcode) > 0)
+			pthread_cond_wait(&cur->cond, &ictx->mutex);
+		pthread_mutex_unlock(&ictx->mutex);
+
+		if (!ret) {
 			int ret2;
 
 			cur->ctx.blkaddr = blkaddr;
-- 
2.43.5

