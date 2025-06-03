Return-Path: <linux-erofs+bounces-387-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBA9ACBF02
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Jun 2025 05:57:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bBH3D0jXCz2xDD;
	Tue,  3 Jun 2025 13:57:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748923032;
	cv=none; b=I0uBfv6hEKP426s46EeUReVHHzkEdLSrMymKo2rAXC9RywFbw/WAb2gNde5KywR0bkyxvBrr+lMrxNQggW2uU3kOQudtP82RP0mYRcleRbm772vcBXJmZwzjw+Qf+Sv72ny4d3ZFYqCwoSf7dnOi/0zpH0AmJD4qsraMYGVV9EIwQqZB0F47Nur2nyhFQE65Z90+hkjJ+tGZlaC7wa1fCicHGZHReaEO2AEQzG2VEY0XVGdFR1qEN4VEf1CrJPv3QRrH4wIZPVijIpomm7ZTzPGS6krOh700zfiACLjTsoDedVY1qVshq75xOMq0pcJRPC3Eid15e8y105fwnv41tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748923032; c=relaxed/relaxed;
	bh=pgxPPoORV4HLWAc11yzCslXtmvTu5w5N1xPOV2mIDt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjZ5GkEKkByJ4lbni3GII0vqxqIN19BTxgc0ST49OCMnzB0MEsFy5K8yHonTZeR6ES2kM3AcWE/R5prP2fla9iD4aEFBm7QbtMDf48/fF8uTT5WE3r2WLDVIMxWxU8Y9lU8DdUBMSNkwANP4DNTKBNraU0bw40BY6mxQuzKhVlM4Bip4XF1FtJzOBpyKKu592cX+qc4eAQLJMeSmEu3dKaT4KLiuQ8YVvvcXtkY5e1Mns8Zyfg8rPhmYXVhwvz/DQ9nhlD55s42ex7Tr8r3XoBf/84apArBUrRNAoWyESD6NmgV1jJO8snuy7rfeCO++2VgGAzPZxVdbnm3TaAXEOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FbHQF1Fi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FbHQF1Fi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bBH3B3tBZz2yPd
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Jun 2025 13:57:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748923025; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pgxPPoORV4HLWAc11yzCslXtmvTu5w5N1xPOV2mIDt8=;
	b=FbHQF1FiSRV+m5vAwprbEO9cua6fI2zadELZiBZKsC6TvUBMIQ9tij97+P4UieWBCnGYH8LQDsI8ZTTVgitzbUrFLtkvHYWFHYck6euOX9zO+4OPyyhBb6Q/j+sJrFTSoR5ZPR1tb9Tmze6t5PknTWp8FmaFFR7QmYC9y6/aEFI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WchYNJO_1748923024 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Jun 2025 11:57:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4/5] erofs-utils: mkfs: add multi-bucket fragment queues
Date: Tue,  3 Jun 2025 11:56:56 +0800
Message-ID: <20250603035657.2092012-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250603035657.2092012-1-hsiangkao@linux.alibaba.com>
References: <20250603035657.2092012-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Group fragments into multiple buckets using their hashed tail-data
digest, enabling parallel compression of different buckets.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 88 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 17 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index cbc51ca..b6e0c12 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -59,7 +59,10 @@ struct z_erofs_compress_ictx {		/* inode context */
 };
 
 struct z_erofs_compress_sctx {		/* segment context */
-	struct list_head extents;
+	union {
+		struct list_head extents;
+		struct list_head sibling;
+	};
 	struct z_erofs_compress_ictx *ictx;
 
 	u8 *queue;
@@ -104,11 +107,18 @@ struct erofs_compress_work {
 };
 
 static struct {
-	struct erofs_workqueue wq, fwq;
+	struct erofs_workqueue wq;
 	struct erofs_compress_work *idle;
 	pthread_mutex_t mutex;
 	bool hasfwq;
 } z_erofs_mt_ctrl;
+
+struct z_erofs_compress_fslot {
+	struct list_head pending;
+	pthread_mutex_t lock;
+	bool inprogress;
+};
+
 #endif
 
 /* compressing configuration specified by users */
@@ -120,6 +130,9 @@ struct erofs_compress_cfg {
 
 struct z_erofs_mgr {
 	struct erofs_compress_cfg ccfg[EROFS_MAX_COMPR_CFGS];
+#ifdef EROFS_MT_ENABLED
+	struct z_erofs_compress_fslot fslot[1024];
+#endif
 };
 
 static bool z_erofs_mt_enabled;
@@ -1364,6 +1377,32 @@ out:
 	pthread_mutex_unlock(&ictx->mutex);
 }
 
+void z_erofs_mt_f_workfn(struct erofs_work *work, void *tlsp)
+{
+	struct erofs_compress_work *cwork = (struct erofs_compress_work *)work;
+	struct erofs_sb_info *sbi = cwork->ctx.ictx->inode->sbi;
+	u32 tofh = cwork->ctx.ictx->tofh;
+	struct z_erofs_compress_fslot *fs = &sbi->zmgr->fslot[tofh & 1023];
+
+	while (1) {
+		z_erofs_mt_workfn(work, tlsp);
+		pthread_mutex_lock(&fs->lock);
+
+		if (list_empty(&fs->pending)) {
+			fs->inprogress = false;
+			pthread_mutex_unlock(&fs->lock);
+			break;
+		}
+		cwork = list_first_entry(&fs->pending,
+					 struct erofs_compress_work,
+					 ctx.sibling);
+		list_del(&cwork->ctx.sibling);
+		pthread_mutex_unlock(&fs->lock);
+		init_list_head(&cwork->ctx.extents);
+		work = &cwork->work;
+	}
+}
+
 int z_erofs_merge_segment(struct z_erofs_compress_ictx *ictx,
 			  struct z_erofs_compress_sctx *sctx)
 {
@@ -1463,19 +1502,32 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 		cur->dict_size = ccfg->handle.dict_size;
 		cur->errcode = 1;	/* mark as "in progress" */
 
-		cur->work.fn = z_erofs_mt_workfn;
 		if (i >= nsegs - 1) {
 			cur->ctx.remaining = inode->i_size -
 					inode->fragment_size - (u64)i * segsz;
 
-			if (z_erofs_mt_ctrl.hasfwq) {
-				erofs_queue_work(&z_erofs_mt_ctrl.fwq,
+			if (z_erofs_mt_ctrl.hasfwq && ictx->tofh != ~0U) {
+				struct z_erofs_mgr *zmgr = inode->sbi->zmgr;
+				struct z_erofs_compress_fslot *fs =
+					&zmgr->fslot[ictx->tofh & 1023];
+
+				pthread_mutex_lock(&fs->lock);
+				if (fs->inprogress) {
+					list_add_tail(&cur->ctx.sibling,
+						      &fs->pending);
+				} else {
+					fs->inprogress = true;
+					cur->work.fn = z_erofs_mt_f_workfn;
+					erofs_queue_work(&z_erofs_mt_ctrl.wq,
 						 &cur->work);
+				}
+				pthread_mutex_unlock(&fs->lock);
 				continue;
 			}
 		} else {
 			cur->ctx.remaining = segsz;
 		}
+		cur->work.fn = z_erofs_mt_workfn;
 		erofs_queue_work(&z_erofs_mt_ctrl.wq, &cur->work);
 	}
 	ictx->mtworks = head;
@@ -1548,15 +1600,8 @@ static int z_erofs_mt_init(void)
 		erofs_warn("multi-threaded dedupe is NOT implemented for now");
 		cfg.c_mt_workers = 0;
 	} else {
-		if (cfg.c_fragments && workers > 1) {
-			ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.fwq, 1, 32,
-						    z_erofs_mt_wq_tls_alloc,
-						    z_erofs_mt_wq_tls_free);
-			if (ret)
-				return ret;
+		if (cfg.c_fragments && workers > 1)
 			z_erofs_mt_ctrl.hasfwq = true;
-			--workers;
-		}
 
 		ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq, workers,
 					    workers << 2,
@@ -1930,7 +1975,19 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	}
 
 	z_erofs_mt_enabled = false;
-	return z_erofs_mt_init();
+	ret = z_erofs_mt_init();
+	if (ret)
+		return ret;
+
+#ifdef EROFS_MT_ENABLED
+	if (z_erofs_mt_ctrl.hasfwq) {
+		for (i = 0; i < ARRAY_SIZE(sbi->zmgr->fslot); ++i) {
+			init_list_head(&sbi->zmgr->fslot[i].pending);
+			pthread_mutex_init(&sbi->zmgr->fslot[i].lock, NULL);
+		}
+	}
+#endif
+	return 0;
 }
 
 int z_erofs_compress_exit(struct erofs_sb_info *sbi)
@@ -1951,9 +2008,6 @@ int z_erofs_compress_exit(struct erofs_sb_info *sbi)
 	if (z_erofs_mt_enabled) {
 #ifdef EROFS_MT_ENABLED
 		ret = erofs_destroy_workqueue(&z_erofs_mt_ctrl.wq);
-		if (ret)
-			return ret;
-		ret = erofs_destroy_workqueue(&z_erofs_mt_ctrl.fwq);
 		if (ret)
 			return ret;
 		while (z_erofs_mt_ctrl.idle) {
-- 
2.43.5


