Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A30C8B4486
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Apr 2024 08:26:24 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rJ/G7Epx;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VRKNq5gK8z3cCt
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Apr 2024 16:26:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rJ/G7Epx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VRKNd3sV4z3c3s
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Apr 2024 16:26:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714199163; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ue0Rjw3lDGGpNalFSLFPHE5lgnfYQObf7NDFHCHwB78=;
	b=rJ/G7EpxLHbnu0B/rOeYgizjKGhUDMN7u7J85MSx/q2bwIzTcSmZGGHvb0JwEyTxQIT9Gs8awD0A1/DemRv9AbzT9MK505TBRzXynf12H4dgPeJbBfAv+olieJEe26JGqUIs1ojWq2blbfkjGciCTtU0CyXT+3F64uan32bt2qM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W5KtMoD_1714199153;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5KtMoD_1714199153)
          by smtp.aliyun-inc.com;
          Sat, 27 Apr 2024 14:26:01 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: use all available processors by default
Date: Sat, 27 Apr 2024 14:25:52 +0800
Message-Id: <20240427062552.744810-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fulfill the needs of most users.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h |  3 +--
 lib/compress.c         | 16 ++++++++++++----
 lib/config.c           |  5 -----
 mkfs/main.c            | 10 ++++------
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index d2f91ff..16910ea 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -76,10 +76,9 @@ struct erofs_configure {
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
 #ifdef EROFS_MT_ENABLED
-	u64 c_segment_size;
+	u64 c_mkfs_segment_size;
 	u32 c_mt_workers;
 #endif
-
 	u32 c_pclusterblks_max, c_pclusterblks_def, c_pclusterblks_packed;
 	u32 c_max_decompressed_extent_bytes;
 	u64 c_unix_timestamp;
diff --git a/lib/compress.c b/lib/compress.c
index 7fef698..f918322 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1255,7 +1255,7 @@ void z_erofs_mt_workfn(struct erofs_work *work, void *tlsp)
 	}
 	sctx->memoff = 0;
 
-	ret = z_erofs_compress_segment(sctx, sctx->seg_idx * cfg.c_segment_size,
+	ret = z_erofs_compress_segment(sctx, sctx->seg_idx * cfg.c_mkfs_segment_size,
 				       EROFS_NULL_ADDR);
 
 out:
@@ -1304,7 +1304,7 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 	struct erofs_compress_work *cur, *head = NULL, **last = &head;
 	struct erofs_compress_cfg *ccfg = ictx->ccfg;
 	struct erofs_inode *inode = ictx->inode;
-	int nsegs = DIV_ROUND_UP(inode->i_size, cfg.c_segment_size);
+	int nsegs = DIV_ROUND_UP(inode->i_size, cfg.c_mkfs_segment_size);
 	int i;
 
 	ictx->seg_num = nsegs;
@@ -1338,9 +1338,9 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 		if (i == nsegs - 1)
 			cur->ctx.remaining = inode->i_size -
 					      inode->fragment_size -
-					      i * cfg.c_segment_size;
+					      i * cfg.c_mkfs_segment_size;
 		else
-			cur->ctx.remaining = cfg.c_segment_size;
+			cur->ctx.remaining = cfg.c_mkfs_segment_size;
 
 		cur->alg_id = ccfg->handle.alg->id;
 		cur->alg_name = ccfg->handle.alg->name;
@@ -1718,6 +1718,14 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 
 	z_erofs_mt_enabled = false;
 #ifdef EROFS_MT_ENABLED
+	if (cfg.c_mt_workers > 1 && (cfg.c_dedupe || cfg.c_fragments)) {
+		if (cfg.c_dedupe)
+			erofs_warn("multi-threaded dedupe is NOT implemented for now");
+		if (cfg.c_fragments)
+			erofs_warn("multi-threaded fragments is NOT implemented for now");
+		cfg.c_mt_workers = 0;
+	}
+
 	if (cfg.c_mt_workers > 1) {
 		ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq,
 					    cfg.c_mt_workers,
diff --git a/lib/config.c b/lib/config.c
index 2530274..98adaef 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -38,11 +38,6 @@ void erofs_init_configure(void)
 	cfg.c_pclusterblks_max = 1;
 	cfg.c_pclusterblks_def = 1;
 	cfg.c_max_decompressed_extent_bytes = -1;
-#ifdef EROFS_MT_ENABLED
-	cfg.c_segment_size = 16ULL * 1024 * 1024;
-	cfg.c_mt_workers = 1;
-#endif
-
 	erofs_stdout_tty = isatty(STDOUT_FILENO);
 }
 
diff --git a/mkfs/main.c b/mkfs/main.c
index d632f74..9ad213b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -838,12 +838,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		}
 		cfg.c_pclusterblks_packed = pclustersize_packed >> sbi.blkszbits;
 	}
-#ifdef EROFS_MT_ENABLED
-	if (cfg.c_mt_workers > 1 && (cfg.c_dedupe || cfg.c_fragments)) {
-		erofs_warn("Note that dedupe/fragments are NOT supported in multi-threaded mode for now, resetting --workers=1.");
-		cfg.c_mt_workers = 1;
-	}
-#endif
 	return 0;
 }
 
@@ -954,6 +948,10 @@ static void erofs_mkfs_default_options(void)
 	cfg.c_legacy_compress = false;
 	cfg.c_inline_data = true;
 	cfg.c_xattr_name_filter = true;
+#ifdef EROFS_MT_ENABLED
+	cfg.c_mt_workers = erofs_get_available_processors();
+	cfg.c_mkfs_segment_size = 16ULL * 1024 * 1024;
+#endif
 	sbi.blkszbits = ilog2(min_t(u32, getpagesize(), EROFS_MAX_BLOCK_SIZE));
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_ZERO_PADDING;
 	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
-- 
2.39.3

