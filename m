Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8FB8A65A8
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 10:05:26 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V2PBCw8M;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJc6D0S69z3d36
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 18:05:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V2PBCw8M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJc5S1R6kz3dLl
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Apr 2024 18:04:44 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3E85F61113;
	Tue, 16 Apr 2024 08:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2227C32783;
	Tue, 16 Apr 2024 08:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713254682;
	bh=HoXnhWUuGpeuQdIlvOO0ZPJwY/VYwYPy5rA8BjIHHUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V2PBCw8Mt8t4ijxF8xe5+IzUWvT94zr57m+E8l50dn5espZ7GQ1FZnWiU+9GZ7dom
	 D08x4bwfB7UZuRApnkVEmtKJ7Akk2L15Dq2Np8hm47qZFlZQ5DkbQbGaUl8Zudw7kh
	 CLDZW5fgspPLJ0Y0LLR4kuXWbH9pdmLeN3t3t32+nl6FtGcbIxRrjtcRrqnYfKnBCX
	 hAnQCSnoHm5MIwhH/1v5qLM8tx1cQA2dazZA5oPkp4rhkho4ovt7iYPgmSBr0wxCkL
	 jxAnYKHVV8mELmEicPRHitdKQzL7xN1f64FcOOpbTDQtJqnifxxXeHAxp7EjXyWU1g
	 2FrZ53gXo8qgw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 6/8] erofs-utils: mkfs: prepare inter-file multi-threaded compression
Date: Tue, 16 Apr 2024 16:04:17 +0800
Message-Id: <20240416080419.32491-6-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240416080419.32491-1-xiang@kernel.org>
References: <20240416080419.32491-1-xiang@kernel.org>
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

This patch separate compression process into two parts.

Specifically, erofs_begin_compressed_file() will trigger compression.
erofs_write_compressed_file() will wait for compression finish and
write compressed (meta)data.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Co-authored-by: Tong Xin <xin_tong@sjtu.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/compress.h |   5 +-
 lib/compress.c           | 115 ++++++++++++++++++++++++++-------------
 lib/inode.c              |  17 +++++-
 3 files changed, 95 insertions(+), 42 deletions(-)

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
index 3fd3874..45ff128 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1359,8 +1359,10 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
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
@@ -1384,27 +1386,31 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
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
@@ -1435,45 +1441,79 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
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
-	}
 #ifdef EROFS_MT_ENABLED
-	if (z_erofs_mt_enabled) {
-		ret = z_erofs_mt_compress(&ctx);
+	} else if (ictx != &g_ictx) {
+		ret = z_erofs_mt_compress(ictx);
 		if (ret)
 			goto err_free_idata;
-		return erofs_mt_write_compressed_file(&ctx);
+#endif
+	}
+	return ictx;
 
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
 #endif
+
 	/* allocate main data buffer */
 	bh = erofs_balloc(DATA, 0, 0, 0);
 	if (IS_ERR(bh)) {
@@ -1482,11 +1522,11 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
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
@@ -1496,15 +1536,14 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 
 	ret = z_erofs_compress_segment(&sctx, -1, blkaddr);
 	if (ret)
-		goto err_bdrop;
-	list_splice_tail(&sctx.extents, &ctx.extents);
+		goto err_free_idata;
 
-	return erofs_commit_compressed_file(&ctx, bh, blkaddr,
+	list_splice_tail(&sctx.extents, &ictx->extents);
+	return erofs_commit_compressed_file(ictx, bh, blkaddr,
 					    sctx.blkaddr - blkaddr);
 
-err_bdrop:
-	erofs_bdrop(bh, true);	/* revoke buffer */
 err_free_idata:
+	erofs_bdrop(bh, true);	/* revoke buffer */
 	if (inode->idata) {
 		free(inode->idata);
 		inode->idata = NULL;
diff --git a/lib/inode.c b/lib/inode.c
index 8ef0604..66eacab 100644
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
@@ -1363,6 +1368,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 {
 	struct stat st;
 	struct erofs_inode *inode;
+	void *ictx;
 	int ret;
 
 	ret = lseek(fd, 0, SEEK_SET);
@@ -1393,7 +1399,12 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
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

