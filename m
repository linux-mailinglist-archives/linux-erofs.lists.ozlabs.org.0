Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E708AC272
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 02:36:28 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ui4EScc9;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VN5sP4gwcz3cVK
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 10:36:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ui4EScc9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VN5s86M9Kz3cXF
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Apr 2024 10:36:12 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 302B3602BE;
	Mon, 22 Apr 2024 00:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C08C32782;
	Mon, 22 Apr 2024 00:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713746170;
	bh=RFxmPdALl0kptWiqOZpD1QBNxelXMLgNmoLS+GA3Ovg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ui4EScc9+l6awp5FGbv9jbg2i9NZUbZBU9vVm0SNlrVHJr9eWd0WJ5Ff/JRLTo0Hx
	 EuwGcHi67XrfHDYnthbulUNzJ5p9kB8qKQcOLmg6dPCAcE5TGf1E4irPnesFaRFUr1
	 u6Toct4hSIlC23V9T/C5q4KquiYMnaGlCGzPPj4CsrsRUPB+HNtCB0Ldyre2jzMvcQ
	 FY02zy042mPDX9Mbwq6hvCDbxom4tVZhwps2z+gG8FDgQSK1zAFev6Ruq6dG/Nw/0I
	 f1QhZ3xhe4ABzYuxv1XD0v5J7OqS80Ha2JLU3WvJD2F4oP5+W94bUyiX70t3a5Mebo
	 ca2pUePOaX2IQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 6/8] erofs-utils: mkfs: prepare inter-file multi-threaded compression
Date: Mon, 22 Apr 2024 08:34:48 +0800
Message-Id: <20240422003450.19132-6-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240422003450.19132-1-xiang@kernel.org>
References: <20240422003450.19132-1-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yifan Zhao <zhaoyifan@sjtu.edu.cn>, Tong Xin <xin_tong@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>

This patch separates the compression process into two parts.

Specifically, erofs_begin_compressed_file() will trigger compression.
erofs_write_compressed_file() will wait for the compression finish and
write compressed (meta)data.

Note that it's possible that erofs_begin_compressed_file() and
erofs_write_compressed_file() run with different threads even the
global inode context is used, thus add another synchronization point.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Co-authored-by: Tong Xin <xin_tong@sjtu.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/compress.h |   5 +-
 lib/compress.c           | 138 ++++++++++++++++++++++++++++-----------
 lib/inode.c              |  17 ++++-
 3 files changed, 118 insertions(+), 42 deletions(-)

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 871db54..c9831a7 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -17,8 +17,11 @@ extern "C"
 #define EROFS_CONFIG_COMPR_MAX_SZ	(4000 * 1024)
 #define Z_EROFS_COMPR_QUEUE_SZ		(EROFS_CONFIG_COMPR_MAX_SZ * 2)
 
+struct z_erofs_compress_ictx;
+
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
-int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos);
+void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos);
+int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx);
 
 int z_erofs_compress_init(struct erofs_sb_info *sbi,
 			  struct erofs_buffer_head *bh);
diff --git a/lib/compress.c b/lib/compress.c
index 4ac4760..7fef698 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -109,6 +109,7 @@ struct erofs_compress_work {
 static struct {
 	struct erofs_workqueue wq;
 	struct erofs_compress_work *idle;
+	pthread_mutex_t mutex;
 } z_erofs_mt_ctrl;
 #endif
 
@@ -1312,11 +1313,13 @@ int z_erofs_mt_compress(struct z_erofs_compress_ictx *ictx)
 	pthread_cond_init(&ictx->cond, NULL);
 
 	for (i = 0; i < nsegs; i++) {
+		pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
 		cur = z_erofs_mt_ctrl.idle;
 		if (cur) {
 			z_erofs_mt_ctrl.idle = cur->next;
 			cur->next = NULL;
 		}
+		pthread_mutex_unlock(&z_erofs_mt_ctrl.mutex);
 		if (!cur) {
 			cur = calloc(1, sizeof(*cur));
 			if (!cur)
@@ -1364,8 +1367,10 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 	pthread_mutex_unlock(&ictx->mutex);
 
 	bh = erofs_balloc(DATA, 0, 0, 0);
-	if (IS_ERR(bh))
-		return PTR_ERR(bh);
+	if (IS_ERR(bh)) {
+		ret = PTR_ERR(bh);
+		goto out;
+	}
 
 	DBG_BUGON(!head);
 	blkaddr = erofs_mapbh(bh->block);
@@ -1389,27 +1394,31 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 			blkaddr = cur->ctx.blkaddr;
 		}
 
+		pthread_mutex_lock(&z_erofs_mt_ctrl.mutex);
 		cur->next = z_erofs_mt_ctrl.idle;
 		z_erofs_mt_ctrl.idle = cur;
-	} while(head);
+		pthread_mutex_unlock(&z_erofs_mt_ctrl.mutex);
+	} while (head);
 
 	if (ret)
-		return ret;
-
-	return erofs_commit_compressed_file(ictx, bh,
+		goto out;
+	ret = erofs_commit_compressed_file(ictx, bh,
 			blkaddr - compressed_blocks, compressed_blocks);
+
+out:
+	close(ictx->fd);
+	free(ictx);
+	return ret;
 }
 #endif
 
-int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
+static struct z_erofs_compress_ictx g_ictx;
+
+void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 {
-	static u8 g_queue[Z_EROFS_COMPR_QUEUE_SZ];
-	struct erofs_buffer_head *bh;
-	static struct z_erofs_compress_ictx ctx;
-	static struct z_erofs_compress_sctx sctx;
-	erofs_blk_t blkaddr;
-	int ret;
 	struct erofs_sb_info *sbi = inode->sbi;
+	struct z_erofs_compress_ictx *ictx;
+	int ret;
 
 	/* initialize per-file compression setting */
 	inode->z_advise = 0;
@@ -1440,43 +1449,87 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 		}
 	}
 #endif
-	ctx.ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
-	inode->z_algorithmtype[0] = ctx.ccfg->algorithmtype;
-	inode->z_algorithmtype[1] = 0;
-
 	inode->idata_size = 0;
 	inode->fragment_size = 0;
 
+	if (z_erofs_mt_enabled) {
+		ictx = malloc(sizeof(*ictx));
+		if (!ictx)
+			return ERR_PTR(-ENOMEM);
+		ictx->fd = dup(fd);
+	} else {
+#ifdef EROFS_MT_ENABLED
+		pthread_mutex_lock(&g_ictx.mutex);
+		if (g_ictx.seg_num)
+			pthread_cond_wait(&g_ictx.cond, &g_ictx.mutex);
+		g_ictx.seg_num = 1;
+		pthread_mutex_unlock(&g_ictx.mutex);
+#endif
+		ictx = &g_ictx;
+		ictx->fd = fd;
+	}
+
+	ictx->ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
+	inode->z_algorithmtype[0] = ictx->ccfg->algorithmtype;
+	inode->z_algorithmtype[1] = 0;
+
 	/*
 	 * Handle tails in advance to avoid writing duplicated
 	 * parts into the packed inode.
 	 */
 	if (cfg.c_fragments && !erofs_is_packed_inode(inode)) {
-		ret = z_erofs_fragments_dedupe(inode, fd, &ctx.tof_chksum);
+		ret = z_erofs_fragments_dedupe(inode, fd, &ictx->tof_chksum);
 		if (ret < 0)
-			return ret;
+			goto err_free_ictx;
 	}
 
-	ctx.inode = inode;
-	ctx.fd = fd;
-	ctx.fpos = fpos;
-	init_list_head(&ctx.extents);
-	ctx.fix_dedupedfrag = false;
-	ctx.fragemitted = false;
+	ictx->inode = inode;
+	ictx->fpos = fpos;
+	init_list_head(&ictx->extents);
+	ictx->fix_dedupedfrag = false;
+	ictx->fragemitted = false;
 
 	if (cfg.c_all_fragments && !erofs_is_packed_inode(inode) &&
 	    !inode->fragment_size) {
-		ret = z_erofs_pack_file_from_fd(inode, fd, ctx.tof_chksum);
+		ret = z_erofs_pack_file_from_fd(inode, fd, ictx->tof_chksum);
 		if (ret)
 			goto err_free_idata;
+	}
 #ifdef EROFS_MT_ENABLED
-	} else if (z_erofs_mt_enabled) {
-		ret = z_erofs_mt_compress(&ctx);
+	if (ictx != &g_ictx) {
+		ret = z_erofs_mt_compress(ictx);
 		if (ret)
 			goto err_free_idata;
-		return erofs_mt_write_compressed_file(&ctx);
+	}
 #endif
+	return ictx;
+
+err_free_idata:
+	if (inode->idata) {
+		free(inode->idata);
+		inode->idata = NULL;
 	}
+err_free_ictx:
+	if (ictx != &g_ictx)
+		free(ictx);
+	return ERR_PTR(ret);
+}
+
+int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx)
+{
+	static u8 g_queue[Z_EROFS_COMPR_QUEUE_SZ];
+	struct erofs_buffer_head *bh;
+	static struct z_erofs_compress_sctx sctx;
+	struct erofs_compress_cfg *ccfg = ictx->ccfg;
+	struct erofs_inode *inode = ictx->inode;
+	erofs_blk_t blkaddr;
+	int ret;
+
+#ifdef EROFS_MT_ENABLED
+	if (ictx != &g_ictx)
+		return erofs_mt_write_compressed_file(ictx);
+#endif
+
 	/* allocate main data buffer */
 	bh = erofs_balloc(DATA, 0, 0, 0);
 	if (IS_ERR(bh)) {
@@ -1485,11 +1538,11 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	}
 	blkaddr = erofs_mapbh(bh->block); /* start_blkaddr */
 
-	ctx.seg_num = 1;
+	ictx->seg_num = 1;
 	sctx = (struct z_erofs_compress_sctx) {
-		.ictx = &ctx,
+		.ictx = ictx,
 		.queue = g_queue,
-		.chandle = &ctx.ccfg->handle,
+		.chandle = &ccfg->handle,
 		.remaining = inode->i_size - inode->fragment_size,
 		.seg_idx = 0,
 		.pivot = &dummy_pivot,
@@ -1499,19 +1552,26 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 
 	ret = z_erofs_compress_segment(&sctx, -1, blkaddr);
 	if (ret)
-		goto err_bdrop;
-	list_splice_tail(&sctx.extents, &ctx.extents);
+		goto err_free_idata;
 
-	return erofs_commit_compressed_file(&ctx, bh, blkaddr,
-					    sctx.blkaddr - blkaddr);
+	list_splice_tail(&sctx.extents, &ictx->extents);
+	ret = erofs_commit_compressed_file(ictx, bh, blkaddr,
+					   sctx.blkaddr - blkaddr);
+	goto out;
 
-err_bdrop:
-	erofs_bdrop(bh, true);	/* revoke buffer */
 err_free_idata:
+	erofs_bdrop(bh, true);	/* revoke buffer */
 	if (inode->idata) {
 		free(inode->idata);
 		inode->idata = NULL;
 	}
+out:
+#ifdef EROFS_MT_ENABLED
+	pthread_mutex_lock(&ictx->mutex);
+	ictx->seg_num = 0;
+	pthread_cond_signal(&ictx->cond);
+	pthread_mutex_unlock(&ictx->mutex);
+#endif
 	return ret;
 }
 
@@ -1666,6 +1726,8 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
 					    z_erofs_mt_wq_tls_free);
 		z_erofs_mt_enabled = !ret;
 	}
+	pthread_mutex_init(&g_ictx.mutex, NULL);
+	pthread_cond_init(&g_ictx.cond, NULL);
 #endif
 	return 0;
 }
diff --git a/lib/inode.c b/lib/inode.c
index 1ff05e1..0d044f4 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -499,10 +499,15 @@ int erofs_write_file(struct erofs_inode *inode, int fd, u64 fpos)
 	DBG_BUGON(!inode->i_size);
 
 	if (cfg.c_compr_opts[0].alg && erofs_file_is_compressible(inode)) {
+		void *ictx;
 		int ret;
 
-		ret = erofs_write_compressed_file(inode, fd, fpos);
-		if (!ret || ret != -ENOSPC)
+		ictx = erofs_begin_compressed_file(inode, fd, fpos);
+		if (IS_ERR(ictx))
+			return PTR_ERR(ictx);
+
+		ret = erofs_write_compressed_file(ictx);
+		if (ret != -ENOSPC)
 			return ret;
 
 		if (lseek(fd, fpos, SEEK_SET) < 0)
@@ -1362,6 +1367,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 {
 	struct stat st;
 	struct erofs_inode *inode;
+	void *ictx;
 	int ret;
 
 	ret = lseek(fd, 0, SEEK_SET);
@@ -1392,7 +1398,12 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 		inode->nid = inode->sbi->packed_nid;
 	}
 
-	ret = erofs_write_compressed_file(inode, fd, 0);
+	ictx = erofs_begin_compressed_file(inode, fd, 0);
+	if (IS_ERR(ictx))
+		return ERR_CAST(ictx);
+
+	DBG_BUGON(!ictx);
+	ret = erofs_write_compressed_file(ictx);
 	if (ret == -ENOSPC) {
 		ret = lseek(fd, 0, SEEK_SET);
 		if (ret < 0)
-- 
2.30.2

