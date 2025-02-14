Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E79A3633D
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2025 17:36:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yvd3f6sG2z3bpL
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Feb 2025 03:36:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739550989;
	cv=none; b=cKQX21RtD6YkNGaVn6ycDUgHbOY/Sb36CaLAB2CvfkSex9XBX+ZY0PAaKc+xFItVXXrhSIMRwB5xAq4BuhXh1XxqV9xaYeLz7rAZfmiAasHodIRHV1R2i0FaH2Z1IIWkNBk5QKxCWR8MTi80sagh8uG5z4o66meiN2nh3ev2ybheI6F+L3sPTaNKom5/X7uDN3PUjQ4z//ov8uOKsdGPVfr+i0CcDKm6a1bOSLOYdEPX5zJP/a+zIXMJ6TUhfhcSo93fn9/599DsMiyPmSTS0qyHIWYJrhCdKz5N8F4VYXJp+qM9t0aieAqEdfYw7WoJ8CLnqi6zBI/9zUBcTkT/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739550989; c=relaxed/relaxed;
	bh=0eOsDYvK+OYbxa0M1Fn4XOCc/LJX+6PVK9Wd166I15k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5/xqt1+1xaAYBlf7znKLJYlIoY1HWWyf0Euvpv7FP4vWrZ7K1ndHT73N6ac2iTcoP0p8Ow6AR+i6t/Ic4/7tVMv6IrxDeE0bn1OepRMnHvxyOAsWKNQV1mwNDa/km5nB9EfzJOrXJ1IfKksVtAphTkY99SOp4ryqSbrB6PTy3e6Y7eGxEWbeLiSBbnXDOMoNbKUbucCJ0UOyoviv03h5gX0tUDhJpDx1QyTJeL9wL5N/HRiWl7BjXcacHXAky0g/iY8i+2bxgBetKb7Ags9xlaJ8EePq2fkRWVCq85fkOMynYyloPK3HRZ3YBqf0/+i1YQnQOSmQQAHcMNzGWzh6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=npuGE6n/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=npuGE6n/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yvd3c2spyz304f
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Feb 2025 03:36:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739550984; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0eOsDYvK+OYbxa0M1Fn4XOCc/LJX+6PVK9Wd166I15k=;
	b=npuGE6n/QONd52Kd8+t+bf0SEatkEfFblLDMZdZoelyrJxwcl/nzEbgiETW+l0p5uM1SR1tTwOL1MFxjN7jeYVcHr5ROsMZVBjgEpAHc8YKjL1z1d+GdB3xTfNeUR+HgyNHUhPrPZygbbhFQLwD2NhInRHQlrL3Mh3Krpv1s+Wo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPRMuay_1739550982 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 15 Feb 2025 00:36:23 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: mkfs: add per-segment reaper for multi-threaded compression
Date: Sat, 15 Feb 2025 00:36:20 +0800
Message-ID: <20250214163621.4109215-1-hsiangkao@linux.alibaba.com>
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

