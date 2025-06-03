Return-Path: <linux-erofs+bounces-383-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C3514ACBEFE
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Jun 2025 05:57:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bBH3B1HC4z2yNB;
	Tue,  3 Jun 2025 13:57:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748923030;
	cv=none; b=hz7jhEmjegP6WWpOimzr+WhtfDZS/CyYzdNv+2ugi/UmYucvc2dZ7C7ZWxiW7EetqLAnfDnQ4cTca68QI5ee2DDpXaP6xjAx4EGcGzemeqpkHHZpPKzlYCf+Xqw4osHeorboNM+YKbeM5dv1GQnZ0jPkrbOM3xt4UnDWsZUIu/T1sTpxRC77DdjWuWn0Ee0lskNOdRgj2IauVA0SQJXNH32pjV40bevNpkDG6Y03Hp15qt1ybwuclRYLFR1fUEbJ4s+/QymUDHuIW6hdxaZ4yqPK2qYtZmzr+x7miM0h7HHZAGhBqtnraIMveMLdSQ+A59keYyiy4bzxLk/6m74K9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748923030; c=relaxed/relaxed;
	bh=sJsZtc+gs2iTTvi9O7fuoPNTeKrmSaYPoILWs1ULcgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9DJ5tL38+5hf6JCm7w085SBLgwaNxN4WqhO36puFTgbijkJO3hauZCfLtmZGhEQT+tS7MfXivVbqQlBVc09w74N2lar2DKuG9a1bKPS0CM6GPRGCPKNEvOLIfc7Hm9Fu2a2xcGZ8ix5/iW/e2klEdCF8batRJCP2cgTu+MAlSwqrATkWVRv+B/6hx+7mSwjvLdCWrX10kEKUWyVnMLXYcb3MIG9lHlPpId/MlU8EdhjsGw/t1RdNq0N0HeLy0LvaGpIfSt1AE0Tiy6Ag79oepEfIhFCLpI7rd5mK8fVcRpgWMHsLuF01iCtBo0DnIARLerg/60pwJ4JZPzTJJ0BHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aeCjfRtf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aeCjfRtf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bBH390dBVz2xDD
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Jun 2025 13:57:08 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748923025; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=sJsZtc+gs2iTTvi9O7fuoPNTeKrmSaYPoILWs1ULcgM=;
	b=aeCjfRtff+jlFUdUo/KkHuNMv6iETuhfi2FGlwLt5ZgwwfRCkMvpDhQfU7oGMhLxC5IVxDJHkXFkqciG+ITYyX6JSTvuq2G0PJ/LlvTLj27NsqGWPY7Uaa+c6hnpA2G+ehcPhSfZHkCZLTEy/7Y1a6a8Ziep2Y5iZ8XY/zFqPyM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WchYNIx_1748923023 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Jun 2025 11:57:03 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/5] erofs-utils: lib: introduce per-FS compression context
Date: Tue,  3 Jun 2025 11:56:55 +0800
Message-ID: <20250603035657.2092012-3-hsiangkao@linux.alibaba.com>
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

Add a per-FS context for the compression process to maintain
multi-bucket fragment queues.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/compress.h |  2 +-
 include/erofs/internal.h |  2 ++
 lib/compress.c           | 49 +++++++++++++++++++++++++++-------------
 mkfs/main.c              |  2 +-
 4 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index c9831a7..4731a8b 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -25,7 +25,7 @@ int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx);
 
 int z_erofs_compress_init(struct erofs_sb_info *sbi,
 			  struct erofs_buffer_head *bh);
-int z_erofs_compress_exit(void);
+int z_erofs_compress_exit(struct erofs_sb_info *sbi);
 
 const char *z_erofs_list_supported_algorithms(int i, unsigned int *mask);
 const struct erofs_algorithm *z_erofs_list_available_compressors(int *i);
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 73845f1..e89a1e4 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -82,6 +82,7 @@ struct erofs_xattr_prefix_item {
 
 struct erofs_mkfs_dfops;
 struct erofs_packed_inode;
+struct z_erofs_mgr;
 
 struct erofs_sb_info {
 	struct erofs_sb_lz4_info lz4;
@@ -141,6 +142,7 @@ struct erofs_sb_info {
 	struct erofs_mkfs_dfops *mkfs_dfops;
 #endif
 	struct erofs_bufmgr *bmgr;
+	struct z_erofs_mgr *zmgr;
 	struct erofs_packed_inode *packedinode;
 	bool useqpl;
 };
diff --git a/lib/compress.c b/lib/compress.c
index 706a756..cbc51ca 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -28,13 +28,6 @@
 
 #define Z_EROFS_DESTBUF_SZ	(Z_EROFS_PCLUSTER_MAX_SIZE + EROFS_MAX_BLOCK_SIZE * 2)
 
-/* compressing configuration specified by users */
-struct erofs_compress_cfg {
-	struct erofs_compress handle;
-	unsigned int algorithmtype;
-	bool enable;
-} erofs_ccfg[EROFS_MAX_COMPR_CFGS];
-
 struct z_erofs_extent_item {
 	struct list_head list;
 	struct z_erofs_inmem_extent e;
@@ -118,6 +111,17 @@ static struct {
 } z_erofs_mt_ctrl;
 #endif
 
+/* compressing configuration specified by users */
+struct erofs_compress_cfg {
+	struct erofs_compress handle;
+	unsigned int algorithmtype;
+	bool enable;
+};
+
+struct z_erofs_mgr {
+	struct erofs_compress_cfg ccfg[EROFS_MAX_COMPR_CFGS];
+};
+
 static bool z_erofs_mt_enabled;
 
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	Z_EROFS_FULL_INDEX_ALIGN(0)
@@ -1463,6 +1467,7 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 		if (i >= nsegs - 1) {
 			cur->ctx.remaining = inode->i_size -
 					inode->fragment_size - (u64)i * segsz;
+
 			if (z_erofs_mt_ctrl.hasfwq) {
 				erofs_queue_work(&z_erofs_mt_ctrl.fwq,
 						 &cur->work);
@@ -1591,7 +1596,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 		while (1) {
 			inode->z_algorithmtype[0] =
 				rand() % EROFS_MAX_COMPR_CFGS;
-			if (erofs_ccfg[inode->z_algorithmtype[0]].enable)
+			if (sbi->zmgr->ccfg[inode->z_algorithmtype[0]].enable)
 				break;
 		}
 	}
@@ -1616,7 +1621,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 		ictx->fd = dup(fd);
 	}
 
-	ictx->ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
+	ictx->ccfg = &sbi->zmgr->ccfg[inode->z_algorithmtype[0]];
 	inode->z_algorithmtype[0] = ictx->ccfg->algorithmtype;
 	inode->z_algorithmtype[1] = 0;
 
@@ -1844,8 +1849,15 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	u32 max_dict_size[Z_EROFS_COMPRESSION_MAX] = {};
 	u32 available_compr_algs = 0;
 
+	if (!sbi->zmgr) {
+		sbi->zmgr = calloc(1, sizeof(*sbi->zmgr));
+		if (!sbi->zmgr)
+			return -ENOMEM;
+	}
+
 	for (i = 0; cfg.c_compr_opts[i].alg; ++i) {
-		struct erofs_compress *c = &erofs_ccfg[i].handle;
+		struct erofs_compress_cfg *ccfg = &sbi->zmgr->ccfg[i];
+		struct erofs_compress *c = &ccfg->handle;
 
 		ret = erofs_compressor_init(sbi, c, cfg.c_compr_opts[i].alg,
 					    cfg.c_compr_opts[i].level,
@@ -1854,10 +1866,10 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 			return ret;
 
 		id = z_erofs_get_compress_algorithm_id(c);
-		erofs_ccfg[i].algorithmtype = id;
-		erofs_ccfg[i].enable = true;
-		available_compr_algs |= 1 << erofs_ccfg[i].algorithmtype;
-		if (erofs_ccfg[i].algorithmtype != Z_EROFS_COMPRESSION_LZ4)
+		ccfg->algorithmtype = id;
+		ccfg->enable = true;
+		available_compr_algs |= 1 << ccfg->algorithmtype;
+		if (ccfg->algorithmtype != Z_EROFS_COMPRESSION_LZ4)
 			erofs_sb_set_compr_cfgs(sbi);
 		if (c->dict_size > max_dict_size[id])
 			max_dict_size[id] = c->dict_size;
@@ -1921,12 +1933,17 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 	return z_erofs_mt_init();
 }
 
-int z_erofs_compress_exit(void)
+int z_erofs_compress_exit(struct erofs_sb_info *sbi)
 {
 	int i, ret;
 
+	if (!sbi->zmgr) {
+		DBG_BUGON(1);
+		return -EINVAL;
+	}
+
 	for (i = 0; cfg.c_compr_opts[i].alg; ++i) {
-		ret = erofs_compressor_exit(&erofs_ccfg[i].handle);
+		ret = erofs_compressor_exit(&sbi->zmgr->ccfg[i].handle);
 		if (ret)
 			return ret;
 	}
diff --git a/mkfs/main.c b/mkfs/main.c
index 2907789..b2eff9d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1491,7 +1491,7 @@ int main(int argc, char **argv)
 exit:
 	if (root)
 		erofs_iput(root);
-	z_erofs_compress_exit();
+	z_erofs_compress_exit(&g_sbi);
 	z_erofs_dedupe_exit();
 	z_erofs_dedupe_ext_exit();
 	blklst = erofs_blocklist_close();
-- 
2.43.5


