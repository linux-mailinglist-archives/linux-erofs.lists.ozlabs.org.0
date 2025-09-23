Return-Path: <linux-erofs+bounces-1076-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A402CB948E4
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 08:29:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW96m2dr0z3cYg;
	Tue, 23 Sep 2025 16:29:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758608944;
	cv=none; b=oCgT4g7Cj4ppnWaQNIeErABJJzvkTHt3xNx6eHYfl6ontfpuXUck7KVIJSm4V+w5W6FR2M/mQa7ydnGO9GAQOjskxR4z2N3YkbOqB56coQtTLdzlFsaWzw4G9zgfA3TrzHgdbbDcb4AyU9UpSs9ngX1WgzEyiT0rv3OkvKpGmTrAJE3Vy3ZRfdzvUR8E7EDgpQB/k3GQna8SPd0OZ/Faj+9mQYKHtw78tiNaGUmmC2NVzMKzi59rYSSIbQ1rBQOxyRI288BYDdPmOHfsFDezO7RPvZC/V6693Vcnme2AhB1JQWiPQca2bICdmIfxTfkcQWo5XZmF8qo8iiuQVLT/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758608944; c=relaxed/relaxed;
	bh=TtRy/2L//J4ZPAVE/5vuVJ3iRIrbVU1knD/nEVzZSOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Thsiwohu3WB7SPYFdDXLWt0L+dqgDHKocmce1QgR2b/bPKFQIdcdrJ1PWJ7Wj0otks9FM7QNFcx/9vgkgmGBJwEHlycau45aeUsTbz8dsgmdgBLQKWVMoP2T45su5ZL+fjQ4REOMjikzQrtoeGIFXXdlrVX5XPKDn4nOkpIxsLABWRuc6aV5EiMQPREMHxVIGHfiUx2lUkZFv8L0s/KayAZhyf70QhRAdm8qOHnLizjIi3iO5IHqMtDK3d0Jjfh+O0FizaRm3Hgwypui1B4q95s6KiBVQU/D/QUBBDWuRGyA210kooyfzm1+mnduxVLRaTAch+tbDWPa9plRGti/xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WEAxAJyY; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WEAxAJyY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cW96k2WDJz2yqq
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 16:29:01 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758608937; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TtRy/2L//J4ZPAVE/5vuVJ3iRIrbVU1knD/nEVzZSOI=;
	b=WEAxAJyYS/LPTYRVGiZ4Yn0J5R9FnmumQqQdcnmR0uJ22cLqpxuIbwgHfBqmip2NSEqW8eNUF3GVbmkNQuFj4s2uHGWCgs0o3UPd4IDrt0efWnpIxWbHy8sM3KPjDoako2UqQ11i+GVRdttFt87kakRI5fJYQu4erKwV1Y++vHI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wodx0Od_1758608935 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 14:28:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/4] erofs-utils: lib: unexport z_erofs_compress_{init,exit}
Date: Tue, 23 Sep 2025 14:28:46 +0800
Message-ID: <20250923062848.1712858-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250923062848.1712858-1-hsiangkao@linux.alibaba.com>
References: <20250923062848.1712858-1-hsiangkao@linux.alibaba.com>
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

Users should use new importer APIs instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  3 ++
 lib/compress.c           | 97 ++++++++++++++++++++++------------------
 lib/global.c             |  2 +
 lib/importer.c           |  6 +++
 lib/liberofs_compress.h  |  7 ++-
 lib/super.c              |  3 +-
 mkfs/main.c              |  9 ----
 7 files changed, 70 insertions(+), 57 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index cea6420..f022a0c 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -488,6 +488,9 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size);
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 			    struct erofs_map_blocks *map, int flags);
 
+const char *z_erofs_list_supported_algorithms(int i, unsigned int *mask);
+const struct erofs_algorithm *z_erofs_list_available_compressors(int *i);
+
 /* io.c */
 int erofs_dev_open(struct erofs_sb_info *sbi, const char *dev, int flags);
 void erofs_dev_close(struct erofs_sb_info *sbi);
diff --git a/lib/compress.c b/lib/compress.c
index 8266c56..6820042 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -111,7 +111,6 @@ static struct {
 	struct erofs_workqueue wq;
 	struct erofs_compress_work *idle;
 	pthread_mutex_t mutex;
-	bool hasfwq;
 } z_erofs_mt_ctrl;
 
 struct z_erofs_compress_fslot {
@@ -1647,11 +1646,12 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 		cur->errcode = 1;	/* mark as "in progress" */
 
 		if (i >= nsegs - 1) {
+			struct z_erofs_mgr *zmgr = inode->sbi->zmgr;
+
 			cur->ctx.remaining = inode->i_size -
 					inode->fragment_size - (u64)i * segsz;
 
-			if (z_erofs_mt_ctrl.hasfwq && ictx->tofh != ~0U) {
-				struct z_erofs_mgr *zmgr = inode->sbi->zmgr;
+			if (zmgr->fslot[0].pending.next && ictx->tofh != ~0U) {
 				struct z_erofs_compress_fslot *fs =
 					&zmgr->fslot[ictx->tofh & 1023];
 
@@ -1732,34 +1732,63 @@ out:
 	return ret;
 }
 
-static int z_erofs_mt_init(void)
+static int z_erofs_mt_global_init(void)
 {
+	static erofs_atomic_bool_t __initonce;
 	unsigned int workers = cfg.c_mt_workers;
 	int ret;
 
+	if (erofs_atomic_test_and_set(&__initonce))
+		return 0;
+
+	z_erofs_mt_enabled = false;
 	if (workers < 1)
 		return 0;
 	if (workers >= 1 && cfg.c_dedupe) {
 		erofs_warn("multi-threaded dedupe is NOT implemented for now");
 		cfg.c_mt_workers = 0;
 	} else {
-		if (cfg.c_fragments && workers > 1)
-			z_erofs_mt_ctrl.hasfwq = true;
-
 		ret = erofs_alloc_workqueue(&z_erofs_mt_ctrl.wq, workers,
 					    workers << 2,
 					    z_erofs_mt_wq_tls_alloc,
 					    z_erofs_mt_wq_tls_free);
-		if (ret)
+		if (ret) {
+			erofs_atomic_set(&__initonce, 0);
 			return ret;
+		}
 		z_erofs_mt_enabled = true;
 	}
 	pthread_mutex_init(&g_ictx.mutex, NULL);
 	pthread_cond_init(&g_ictx.cond, NULL);
 	return 0;
 }
+
+int z_erofs_mt_global_exit(void)
+{
+	struct erofs_compress_work *n;
+	int ret;
+
+	if (z_erofs_mt_enabled) {
+		ret = erofs_destroy_workqueue(&z_erofs_mt_ctrl.wq);
+		if (ret)
+			return ret;
+		while (z_erofs_mt_ctrl.idle) {
+			n = z_erofs_mt_ctrl.idle->next;
+			free(z_erofs_mt_ctrl.idle);
+			z_erofs_mt_ctrl.idle = n;
+		}
+		z_erofs_mt_enabled = false;
+	}
+	return 0;
+}
 #else
-static int z_erofs_mt_init(void)
+static int z_erofs_mt_global_init(void)
+{
+	z_erofs_mt_enabled = false;
+	return 0;
+}
+
+int z_erofs_mt_global_exit(void)
 {
 	return 0;
 }
@@ -2035,17 +2064,19 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 	return ret;
 }
 
-int z_erofs_compress_init(struct erofs_sb_info *sbi)
+int z_erofs_compress_init(struct erofs_importer *im)
 {
-	struct erofs_buffer_head *sb_bh = sbi->bh_sb;
+	struct erofs_sb_info *sbi = im->sbi;
 	u32 max_dict_size[Z_EROFS_COMPRESSION_MAX] = {};
 	u32 available_compr_algs = 0;
+	bool newzmgr = false;
 	int i, ret, id;
 
 	if (!sbi->zmgr) {
 		sbi->zmgr = calloc(1, sizeof(*sbi->zmgr));
 		if (!sbi->zmgr)
 			return -ENOMEM;
+		newzmgr = true;
 	}
 
 	for (i = 0; cfg.c_compr_opts[i].alg; ++i) {
@@ -2067,19 +2098,10 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi)
 		if (c->dict_size > max_dict_size[id])
 			max_dict_size[id] = c->dict_size;
 	}
-
-	/*
-	 * if primary algorithm is empty (e.g. compression off),
-	 * clear 0PADDING feature for old kernel compatibility.
-	 */
-	if (!available_compr_algs ||
-	    (cfg.c_legacy_compress && available_compr_algs == 1))
-		erofs_sb_clear_lz4_0padding(sbi);
-
 	if (!available_compr_algs)
 		return 0;
 
-	if (!sb_bh) {
+	if (sbi->available_compr_algs) {
 		u32 dalg = available_compr_algs & (~sbi->available_compr_algs);
 
 		if (dalg) {
@@ -2087,8 +2109,8 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi)
 				  dalg);
 			return -EOPNOTSUPP;
 		}
-		if (available_compr_algs & (1 << Z_EROFS_COMPRESSION_LZ4) &&
-		    sbi->lz4.max_pclusterblks << sbi->blkszbits <
+		if ((available_compr_algs & BIT(Z_EROFS_COMPRESSION_LZ4)) &&
+		    (sbi->lz4.max_pclusterblks << sbi->blkszbits) <
 			cfg.c_mkfs_pclustersize_max) {
 			erofs_err("pclustersize %u is too large on incremental builds",
 				  cfg.c_mkfs_pclustersize_max);
@@ -2096,6 +2118,11 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi)
 		}
 	} else {
 		sbi->available_compr_algs = available_compr_algs;
+
+		if (!cfg.c_legacy_compress)
+			erofs_sb_set_lz4_0padding(sbi);
+		if (available_compr_algs & ~(1 << Z_EROFS_COMPRESSION_LZ4))
+			erofs_sb_set_compr_cfgs(sbi);
 	}
 
 	/*
@@ -2122,19 +2149,18 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi)
 		return -EINVAL;
 	}
 
-	if (sb_bh && erofs_sb_has_compr_cfgs(sbi)) {
-		ret = z_erofs_build_compr_cfgs(sbi, sb_bh, max_dict_size);
+	if (sbi->bh_sb && erofs_sb_has_compr_cfgs(sbi)) {
+		ret = z_erofs_build_compr_cfgs(sbi, sbi->bh_sb, max_dict_size);
 		if (ret)
 			return ret;
 	}
 
-	z_erofs_mt_enabled = false;
-	ret = z_erofs_mt_init();
+	ret = z_erofs_mt_global_init();
 	if (ret)
 		return ret;
 
 #ifdef EROFS_MT_ENABLED
-	if (z_erofs_mt_ctrl.hasfwq) {
+	if (cfg.c_fragments && cfg.c_mt_workers > 1 && newzmgr) {
 		for (i = 0; i < ARRAY_SIZE(sbi->zmgr->fslot); ++i) {
 			init_list_head(&sbi->zmgr->fslot[i].pending);
 			pthread_mutex_init(&sbi->zmgr->fslot[i].lock, NULL);
@@ -2157,21 +2183,6 @@ int z_erofs_compress_exit(struct erofs_sb_info *sbi)
 		if (ret)
 			return ret;
 	}
-
-	if (z_erofs_mt_enabled) {
-#ifdef EROFS_MT_ENABLED
-		ret = erofs_destroy_workqueue(&z_erofs_mt_ctrl.wq);
-		if (ret)
-			return ret;
-		while (z_erofs_mt_ctrl.idle) {
-			struct erofs_compress_work *tmp =
-				z_erofs_mt_ctrl.idle->next;
-			free(z_erofs_mt_ctrl.idle);
-			z_erofs_mt_ctrl.idle = tmp;
-		}
-#endif
-	}
-
 	free(sbi->zmgr);
 	return 0;
 }
diff --git a/lib/global.c b/lib/global.c
index b1a6d76..c3d8aec 100644
--- a/lib/global.c
+++ b/lib/global.c
@@ -11,6 +11,7 @@
 #endif
 #include "erofs/err.h"
 #include "erofs/config.h"
+#include "liberofs_compress.h"
 
 static EROFS_DEFINE_MUTEX(erofs_global_mutex);
 #ifdef HAVE_LIBCURL
@@ -43,6 +44,7 @@ out_unlock:
 void liberofs_global_exit(void)
 {
 	erofs_mutex_lock(&erofs_global_mutex);
+	z_erofs_mt_global_exit();
 #ifdef HAVE_LIBCURL
 	if (erofs_global_curl_initialized) {
 		curl_global_cleanup();
diff --git a/lib/importer.c b/lib/importer.c
index bb29bd0..7c3d147 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -10,6 +10,7 @@
 #include "erofs/print.h"
 #include "erofs/lock.h"
 #include "liberofs_cache.h"
+#include "liberofs_compress.h"
 #include "liberofs_metabox.h"
 
 static EROFS_DEFINE_MUTEX(erofs_importer_global_mutex);
@@ -45,6 +46,11 @@ int erofs_importer_init(struct erofs_importer *im)
 
 	erofs_importer_global_init();
 
+	subsys = "compression";
+	err = z_erofs_compress_init(im);
+	if (err)
+		goto out_err;
+
 	if (cfg.c_fragments || cfg.c_extra_ea_name_prefixes) {
 		subsys = "packedfile";
 		if (!cfg.c_mkfs_pclustersize_packed)
diff --git a/lib/liberofs_compress.h b/lib/liberofs_compress.h
index 907c6d4..7f49e5d 100644
--- a/lib/liberofs_compress.h
+++ b/lib/liberofs_compress.h
@@ -7,7 +7,7 @@
 #ifndef __EROFS_LIB_LIBEROFS_COMPRESS_H
 #define __EROFS_LIB_LIBEROFS_COMPRESS_H
 
-#include "erofs/internal.h"
+#include "erofs/importer.h"
 
 #define EROFS_CONFIG_COMPR_MAX_SZ	(4000 * 1024)
 #define Z_EROFS_COMPR_QUEUE_SZ		(EROFS_CONFIG_COMPR_MAX_SZ * 2)
@@ -18,10 +18,9 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
 void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos);
 int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx);
 
-int z_erofs_compress_init(struct erofs_sb_info *sbi);
+int z_erofs_compress_init(struct erofs_importer *im);
 int z_erofs_compress_exit(struct erofs_sb_info *sbi);
 
-const char *z_erofs_list_supported_algorithms(int i, unsigned int *mask);
-const struct erofs_algorithm *z_erofs_list_available_compressors(int *i);
+int z_erofs_mt_global_exit(void);
 
 #endif
diff --git a/lib/super.c b/lib/super.c
index 2d2783b..0540b15 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -7,6 +7,7 @@
 #include "erofs/print.h"
 #include "erofs/xattr.h"
 #include "liberofs_cache.h"
+#include "liberofs_compress.h"
 
 static bool check_layout_compatibility(struct erofs_sb_info *sbi,
 				       struct erofs_super_block *dsb)
@@ -175,7 +176,7 @@ void erofs_put_super(struct erofs_sb_info *sbi)
 		erofs_buffer_exit(sbi->bmgr);
 		sbi->bmgr = NULL;
 	}
-
+	z_erofs_compress_exit(sbi);
 	sbi->sb_valid = false;
 }
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 9703d8c..13c4761 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -28,7 +28,6 @@
 #include "erofs/fragments.h"
 #include "erofs/rebuild.h"
 #include "../lib/compressor.h"
-#include "../lib/liberofs_compress.h"
 #include "../lib/liberofs_gzran.h"
 #include "../lib/liberofs_metabox.h"
 #include "../lib/liberofs_oci.h"
@@ -1753,13 +1752,6 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	err = z_erofs_compress_init(&g_sbi);
-	if (err) {
-		erofs_err("failed to initialize compressor: %s",
-			  erofs_strerror(err));
-		goto exit;
-	}
-
 	importer_params.source = cfg.c_src_path;
 	importer_params.no_datainline = mkfs_no_datainline;
 	importer_params.dot_omitted = mkfs_dot_omitted;
@@ -1918,7 +1910,6 @@ int main(int argc, char **argv)
 exit:
 	if (root)
 		erofs_iput(root);
-	z_erofs_compress_exit(&g_sbi);
 	z_erofs_dedupe_exit();
 	blklst = erofs_blocklist_close();
 	if (blklst)
-- 
2.43.5


