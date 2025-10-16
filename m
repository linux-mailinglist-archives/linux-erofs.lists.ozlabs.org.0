Return-Path: <linux-erofs+bounces-1189-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E413BE14FE
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Oct 2025 04:48:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnC7f6jrtz3bW7;
	Thu, 16 Oct 2025 13:48:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760582910;
	cv=none; b=YV1z0iVN1MQXOSNEZnWOD+YDJgBlsBOwx04uY6Pv8ppy7s8Etx02ZsfXEnJVEMwjK4B9c7xevyftqF4JSK3g8Q6XL/4yYyuGgD67wZKGIRNhrUsT4ftVWtWmqKfWjazMk1Bbilzjv+tL2DEh62UHKm6WZFWfOLae/0lLn6caUiNSK66adJn6usrLVx7SlH/FiVIOSnmkQGba/0NMWI6B2zdpJSr+vgKUt2j/CDrfkUnDHt0QVj2omBhXwPNqGLXmqKeF/GKdZFKTuiwD+Gzx8N7BitAkR+3ngfd+M/24ZEyVyNJFISmVKIZsXMTf064zcqk2Uh47ziqEZDnl69DpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760582910; c=relaxed/relaxed;
	bh=6Md6YryfuaWiBqR/Z67ZWUdqjixp3ecyXQd4mx7UwzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMg5nzyqKOtqPnhO3edtCPIXtaWLzbLXWRwbgUfg/0qH41BSZyj4A0UDzD2UTE90YeXvpV+tKr5ttDCp2/r82KUnIm/S1LBa9bsibGJ39aHUO4+zNIoTZEqFHRImXfoYI9vmjv2Aun7dbzpt8pc3OZiJaFjnI5hBZF2CwheKD0HGsfj49YjQ/NQN28jQ1ScIbLNHsuELDhNgu4K99KcachG8BRCMYYPKsW75ICIyKBnQ18J0Wy25Hdi7I+s0lM3hvHJmWt+XyqIV5HV28+jItMonQbolcluw7Mw4QSrkudgiqnNoopHi1cn0STnCEe0AQJCINCXFd0QIiESZx865jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=V7qB/Wqu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=V7qB/Wqu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnC7c3t0Cz30Vl
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Oct 2025 13:48:28 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760582904; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6Md6YryfuaWiBqR/Z67ZWUdqjixp3ecyXQd4mx7UwzQ=;
	b=V7qB/WquASpZidKGPsesE4fjSISTblShj7KEDp83SIJh0hV+1Z94ZBzqbwXyQ62PwK7y5RjntmjXVjzaegWvn98MnWA9mwH3dqYWjTGZ/e/zDuX7KDLGaYZ2oSy57OOjkemAccItWEDCE1NjpfSjWjrY/McUW5si2qoVjeh+PzI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqIZVjt_1760582902 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Oct 2025 10:48:23 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 5/7] erofs-utils: lib: switch to vfile interfaces for compression
Date: Thu, 16 Oct 2025 10:48:13 +0800
Message-ID: <20251016024815.2750927-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251016024815.2750927-1-hsiangkao@linux.alibaba.com>
References: <20251016024815.2750927-1-hsiangkao@linux.alibaba.com>
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

Split erofs_begin_compressed_file() into three interfaces:
 - erofs_prepare_compressed_file();
 - erofs_bind_compressed_file_with_fd();
 - erofs_begin_compressed_file().

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c          | 74 +++++++++++++++++++++++++----------------
 lib/inode.c             | 16 ++++++---
 lib/liberofs_compress.h |  7 ++--
 3 files changed, 63 insertions(+), 34 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 74d40b1..1417967 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -35,6 +35,7 @@ struct z_erofs_extent_item {
 };
 
 struct z_erofs_compress_ictx {		/* inode context */
+	struct erofs_vfile _vf, *vf;
 	struct erofs_importer *im;
 	struct erofs_inode *inode;
 	struct erofs_compress_cfg *ccfg;
@@ -1258,14 +1259,14 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 	bool frag = params->fragments && !erofs_is_packed_inode(inode) &&
 		!erofs_is_metabox_inode(inode) &&
 		ctx->seg_idx >= ictx->seg_num - 1;
-	struct erofs_vfile vf = { .fd = ictx->fd };
+	struct erofs_vfile *vf = ictx->vf;
 	int ret;
 
 	DBG_BUGON(offset != -1 && frag && inode->fragment_size);
 	if (offset != -1 && frag && !inode->fragment_size &&
 	    params->fragdedupe != EROFS_FRAGDEDUPE_OFF) {
-		ret = erofs_fragment_findmatch(inode,
-					       &vf, ictx->fpos, ictx->tofh);
+		ret = erofs_fragment_findmatch(inode, vf, ictx->fpos,
+					       ictx->tofh);
 		if (ret < 0)
 			return ret;
 		if (inode->fragment_size > ctx->remaining)
@@ -1281,8 +1282,8 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 		int ret;
 
 		ret = (offset == -1 ?
-			erofs_io_read(&vf, ctx->queue + ctx->tail, rx) :
-			erofs_io_pread(&vf, ctx->queue + ctx->tail, rx,
+			erofs_io_read(vf, ctx->queue + ctx->tail, rx) :
+			erofs_io_pread(vf, ctx->queue + ctx->tail, rx,
 				       ictx->fpos + offset));
 		if (ret != rx)
 			return -errno;
@@ -1780,6 +1781,8 @@ int z_erofs_mt_global_exit(void)
 	return 0;
 }
 #else
+
+
 static int z_erofs_mt_global_init(struct erofs_importer *im)
 {
 	z_erofs_mt_enabled = false;
@@ -1792,8 +1795,8 @@ int z_erofs_mt_global_exit(void)
 }
 #endif
 
-void *erofs_begin_compressed_file(struct erofs_importer *im,
-				  struct erofs_inode *inode, int fd, u64 fpos)
+void *erofs_prepare_compressed_file(struct erofs_importer *im,
+				    struct erofs_inode *inode)
 {
 	const struct erofs_importer_params *params = im->params;
 	struct erofs_sb_info *sbi = inode->sbi;
@@ -1801,7 +1804,6 @@ void *erofs_begin_compressed_file(struct erofs_importer *im,
 	bool frag = params->fragments && !erofs_is_packed_inode(inode) &&
 		!erofs_is_metabox_inode(inode);
 	bool all_fragments = params->all_fragments && frag;
-	int ret;
 
 	/* initialize per-file compression setting */
 	inode->z_advise = 0;
@@ -1835,7 +1837,6 @@ void *erofs_begin_compressed_file(struct erofs_importer *im,
 	}
 	ictx->im = im;
 	ictx->inode = inode;
-	ictx->fd = fd;
 	if (erofs_is_metabox_inode(inode))
 		ictx->ccfg = &sbi->zmgr->ccfg[cfg.c_mkfs_metabox_algid];
 	else
@@ -1848,10 +1849,33 @@ void *erofs_begin_compressed_file(struct erofs_importer *im,
 	if (params->fragments && !params->dedupe && !ictx->data_unaligned)
 		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 
-	if (frag) {
-		struct erofs_vfile vf = { .fd = fd };
+	init_list_head(&ictx->extents);
+	ictx->fix_dedupedfrag = false;
+	ictx->fragemitted = false;
+	ictx->dedupe = false;
+	return ictx;
+}
+
+void erofs_bind_compressed_file_with_fd(struct z_erofs_compress_ictx *ictx,
+					int fd, u64 fpos)
+{
+	ictx->_vf = (struct erofs_vfile){ .fd = fd };
+	ictx->vf = &ictx->_vf;
+	ictx->fpos = fpos;
+}
+
+int erofs_begin_compressed_file(struct z_erofs_compress_ictx *ictx)
+{
+	const struct erofs_importer_params *params = ictx->im->params;
+	struct erofs_inode *inode = ictx->inode;
+	bool frag = params->fragments && !erofs_is_packed_inode(inode) &&
+		!erofs_is_metabox_inode(inode);
+	bool all_fragments = params->all_fragments && frag;
+	int ret;
 
-		ictx->tofh = z_erofs_fragments_tofh(inode, &vf, fpos);
+	if (frag) {
+		ictx->tofh = z_erofs_fragments_tofh(inode,
+						    ictx->vf, ictx->fpos);
 		if (ictx == &g_ictx &&
 		    params->fragdedupe != EROFS_FRAGDEDUPE_OFF) {
 			/*
@@ -1859,9 +1883,9 @@ void *erofs_begin_compressed_file(struct erofs_importer *im,
 			 * parts into the packed inode.
 			 */
 			ret = erofs_fragment_findmatch(inode,
-						       &vf, fpos, ictx->tofh);
+					ictx->vf, ictx->fpos, ictx->tofh);
 			if (ret < 0)
-				goto err_free_ictx;
+				goto err_out;
 
 			if (params->fragdedupe == EROFS_FRAGDEDUPE_INODE &&
 			    inode->fragment_size < inode->i_size) {
@@ -1871,36 +1895,30 @@ void *erofs_begin_compressed_file(struct erofs_importer *im,
 			}
 		}
 	}
-	ictx->fpos = fpos;
-	init_list_head(&ictx->extents);
-	ictx->fix_dedupedfrag = false;
-	ictx->fragemitted = false;
-	ictx->dedupe = false;
 
 	if (all_fragments && !inode->fragment_size) {
-		ret = erofs_pack_file_from_fd(inode,
-			&((struct erofs_vfile){ .fd = fd }), fpos, ictx->tofh);
+		ret = erofs_pack_file_from_fd(inode, ictx->vf, ictx->fpos,
+					      ictx->tofh);
 		if (ret)
-			goto err_free_idata;
+			goto err_out;
 	}
+
 #ifdef EROFS_MT_ENABLED
 	if (ictx != &g_ictx) {
 		ret = z_erofs_mt_compress(ictx);
 		if (ret)
-			goto err_free_idata;
+			goto err_out;
 	}
 #endif
-	return ictx;
-
-err_free_idata:
+	return 0;
+err_out:
 	if (inode->idata) {
 		free(inode->idata);
 		inode->idata = NULL;
 	}
-err_free_ictx:
 	if (ictx != &g_ictx)
 		free(ictx);
-	return ERR_PTR(ret);
+	return ret;
 }
 
 int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx)
diff --git a/lib/inode.c b/lib/inode.c
index 14a65af..e7c3edf 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1790,6 +1790,7 @@ static int erofs_mkfs_begin_nondirectory(struct erofs_importer *im,
 {
 	struct erofs_mkfs_job_ndir_ctx ctx =
 		{ .inode = inode, .fd = -1 };
+	int ret;
 
 	if (S_ISREG(inode->i_mode) && inode->i_size) {
 		switch (inode->datasource) {
@@ -1808,10 +1809,14 @@ static int erofs_mkfs_begin_nondirectory(struct erofs_importer *im,
 		}
 		if (ctx.fd >= 0 && cfg.c_compr_opts[0].alg &&
 		    erofs_file_is_compressible(im, inode)) {
-			ctx.ictx = erofs_begin_compressed_file(im, inode,
-							ctx.fd, ctx.fpos);
+			ctx.ictx = erofs_prepare_compressed_file(im, inode);
 			if (IS_ERR(ctx.ictx))
 				return PTR_ERR(ctx.ictx);
+			erofs_bind_compressed_file_with_fd(ctx.ictx,
+							   ctx.fd, ctx.fpos);
+			ret = erofs_begin_compressed_file(ctx.ictx);
+			if (ret)
+				return ret;
 		}
 	}
 	return erofs_mkfs_go(im, EROFS_MKFS_JOB_NDIR, &ctx, sizeof(ctx));
@@ -2129,11 +2134,14 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_importer *im,
 
 	if (cfg.c_compr_opts[0].alg &&
 	    erofs_file_is_compressible(im, inode)) {
-		ictx = erofs_begin_compressed_file(im, inode, fd, 0);
+		ictx = erofs_prepare_compressed_file(im, inode);
 		if (IS_ERR(ictx))
 			return ERR_CAST(ictx);
 
-		DBG_BUGON(!ictx);
+		erofs_bind_compressed_file_with_fd(ictx, fd, 0);
+		ret = erofs_begin_compressed_file(ictx);
+		if (ret)
+			return ERR_PTR(ret);
 		ret = erofs_write_compressed_file(ictx);
 		if (!ret)
 			goto out;
diff --git a/lib/liberofs_compress.h b/lib/liberofs_compress.h
index e0f4d24..8b39735 100644
--- a/lib/liberofs_compress.h
+++ b/lib/liberofs_compress.h
@@ -15,8 +15,11 @@
 struct z_erofs_compress_ictx;
 
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
-void *erofs_begin_compressed_file(struct erofs_importer *im,
-				  struct erofs_inode *inode, int fd, u64 fpos);
+void *erofs_prepare_compressed_file(struct erofs_importer *im,
+				    struct erofs_inode *inode);
+void erofs_bind_compressed_file_with_fd(struct z_erofs_compress_ictx *ictx,
+					int fd, u64 fpos);
+int erofs_begin_compressed_file(struct z_erofs_compress_ictx *ictx);
 int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx);
 
 int z_erofs_compress_init(struct erofs_importer *im);
-- 
2.43.5


